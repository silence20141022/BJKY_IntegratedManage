using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using System.Configuration;
using IntegratedManage.Model;
using Aim;
using Aim.WorkFlow;
using Newtonsoft.Json.Linq;

namespace IntegratedManage.Web
{
    public partial class SignRequestEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        SignRequest ent = null;
        string nextName = "";
        string taskName = "";
        string sql = "";
        string LinkView = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            LinkView = RequestData.Get<string>("LinkView");
            nextName = RequestData.Get<string>("nextName");
            taskName = RequestData.Get<string>("taskName");
            if (!string.IsNullOrEmpty(id))
            {
                ent = SignRequest.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    string JsonString = RequestData.Get<string>("JsonString");//打回首环节再次提交的时候需要重新保存表单
                    if (!string.IsNullOrEmpty(JsonString))
                    {
                        SignRequest tempEnt = JsonHelper.GetObject<SignRequest>(JsonString);
                        DataHelper.MergeData<SignRequest>(ent, tempEnt);
                        ent.DoUpdate();
                    }
                    else
                    {
                        ent = GetMergedData<SignRequest>();
                        ent.DoUpdate();
                        PageState.Add("Id", ent.Id);
                    }
                    break;
                case "GetNextUsers":
                    PageState.Add("NextUsers", GetNextUser(nextName));
                    break;
                case "ConfirmYuanLeader":
                    ent.YuanLeaderIds = RequestData.Get<string>("YuanLeaderIds");
                    ent.YuanLeaderNames = RequestData.Get<string>("YuanLeaderNames");
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = GetPostedData<SignRequest>();
                    ent.DoCreate();
                    PageState.Add("Id", ent.Id);
                    break;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
                    break;
                case "submitfinish":
                    ent = SignRequest.Find(id);
                    ent.ApproveResult = RequestData.Get<string>("ApprovalState");
                    ent.WorkFlowState = RequestData.Get<string>("state");
                    ent.DoUpdate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void StartFlow()
        {
            ArrayList array = new ArrayList();
            string state = RequestData.Get<string>("state");
            string formUrl = "/DocumentManage/SignRequestEdit.aspx?op=v&&id=" + id;
            Guid guid = WorkFlow.StartWorkFlow(id, formUrl, "签报审批", "SignRequest", UserInfo.UserID, UserInfo.Name);
            array.Add(guid + "#" + ent.ApproveLeaderIds + "$" + ent.ApproveLeaderNames);
            PageState.Add("WorkFlowInfo", array);
            ent.WorkFlowState = state;
            ent.DoUpdate();
        }
        private void AutoExecuteFlow()
        {
            IList<string> workFlowInfo = RequestData.GetList<string>("WorkFlowInfo");
            string instanceId = string.Empty;
            foreach (string str in workFlowInfo)
            {
                string[] strarray = str.Split(new string[] { "#" }, StringSplitOptions.RemoveEmptyEntries);
                instanceId = strarray[0];
                string[] userarray = null;
                if (!string.IsNullOrEmpty(strarray[1]))
                {
                    userarray = strarray[1].Split(new string[] { "$" }, StringSplitOptions.RemoveEmptyEntries);
                }
                IList<Task> tasks = Task.FindAllByProperty(Task.Prop_WorkflowInstanceID, instanceId);
                Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], "部门负责人", userarray);
            }
        }
        private string[] GetNextUser(string nextName)
        {
            IList<IntegratedConfig> icEnts = IntegratedConfig.FindAll();
            string[] userInfo = new string[] { };
            switch (nextName)
            {
                case "提交院办负责人":
                case "院办负责人":
                case "同意":
                    userInfo = new string[] { icEnts[0].YuanBanZhuRenId, icEnts[0].YuanBanZhuRenName };
                    break;
                case "提交院长":
                    userInfo = new string[] { icEnts[0].FirstYuanZhangId, icEnts[0].FirstYuanZhangName };
                    break;
            }
            return userInfo;
        }
        private void DoSelect()
        {
            if (op != "c" && op != "cs")
            {
                sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' and Ext1 is null order by FinishTime asc";
                sql = string.Format(sql, id);
                IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                PageState.Add("Opinion", taskDics);
                sql = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0 ";
                sql = string.Format(sql, ent.Attachment);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
            }
            else
            {
                sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                from View_SysUserGroup where UserId='{0}'";
                sql = string.Format(sql, UserInfo.UserID);
                IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
                ent = new SignRequest();
                if (deptDics.Count > 0)
                {
                    ent.CreateDeptId = deptDics[0].Get<string>("DeptId");
                    ent.CreateDeptName = deptDics[0].Get<string>("DeptName");
                }
                ent.ContactUserId = UserInfo.UserID;
                ent.ContactUserName = UserInfo.Name;
                ent.CreateId = UserInfo.UserID;
                ent.CreateName = UserInfo.Name;
            }
            SetFormData(ent);
            string taskId = RequestData.Get<string>("TaskId");
            if (!string.IsNullOrEmpty(taskId))
            {
                Task tEnt = Task.Find(taskId);
                if (tEnt.Status != 4 && !string.IsNullOrEmpty(tEnt.Description))
                {
                    PageState.Add("UnSubmitOpinion", tEnt.Description);
                }
            }
            PageState.Add("SecrecyDegree", SysEnumeration.GetEnumDict("SecrecyDegree"));
            PageState.Add("ImportanceDegree", SysEnumeration.GetEnumDict("ImportanceDegree"));
        }
    }
}

