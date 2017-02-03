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

namespace IntegratedManage.Web
{
    public partial class ReleaseDocumentEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        ReleaseDocument ent = null;
        string nextName = "";
        string taskName = "";
        string sql = "";
        string LinkView = "";
        string JsonString = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            LinkView = RequestData.Get<string>("LinkView");
            nextName = RequestData.Get<string>("nextName");
            taskName = RequestData.Get<string>("taskName");
            JsonString = RequestData.Get<string>("JsonString");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ReleaseDocument.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    if (!string.IsNullOrEmpty(JsonString))
                    {
                        ReleaseDocument rdTemp = JsonHelper.GetObject<ReleaseDocument>(JsonString);
                        ent = DataHelper.MergeData<ReleaseDocument>(ent, rdTemp);
                    }
                    else
                    {
                        ent = GetMergedData<ReleaseDocument>();
                    }
                    ent.DoUpdate();
                    PageState.Add("Id", ent.Id);
                    break;
                case "UpdateZiHao":
                    ent.DocumentZiHao = RequestData.Get<string>("DocumentZiHao");
                    ent.DoUpdate();
                    break;
                case "GetNextUsers":
                    PageState.Add("NextUsers", GetNextUser(nextName));
                    break;
                case "create":
                    ent = GetPostedData<ReleaseDocument>();
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
                    ent = ReleaseDocument.Find(id);
                    ent.ApproveResult = RequestData.Get<string>("ApprovalState");
                    ent.WorkFlowState = RequestData.Get<string>("state");
                    ent.State = "已归档";
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
            string formUrl = "/DocumentManage/ReleaseDocumentEdit.aspx?op=v&&id=" + id;
            Guid guid = WorkFlow.StartWorkFlow(id, formUrl, "发文审批", "ReleaseDocument", UserInfo.UserID, UserInfo.Name);
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
                Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], "部门领导", userarray);
            }
        }
        private string[] GetNextUser(string nextName)
        {
            IList<IntegratedConfig> icEnts = IntegratedConfig.FindAll();
            string[] userInfo = new string[] { };
            switch (nextName)
            {
                case "院办主任核稿":
                case "提交院办主任":
                case "院办主任":
                    userInfo = new string[] { icEnts[0].YuanBanZhuRenId, icEnts[0].YuanBanZhuRenName };
                    break;
                case "提交院办文书":
                    userInfo = new string[] { icEnts[0].YuanBanWenShuId, icEnts[0].YuanBanWenShuName };
                    break;
                case "提交院长审批":
                    userInfo = new string[] { icEnts[0].YuanZhangId, icEnts[0].YuanZhangName };
                    break;
                case "打字员":
                    userInfo = new string[] { icEnts[0].TypistId, icEnts[0].TypistName };
                    break;
                case "提交":
                    userInfo = new string[] { ent.ApproveLeaderIds, ent.ApproveLeaderNames };
                    break;
            }
            return userInfo;
        }
        private void DoSelect()
        {
            if (op != "c" && op != "cs")
            {
                ent = ReleaseDocument.Find(id);
                SetFormData(ent);
                sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' and ApprovalNodeName in('部门领导','相关部门会签','院办主任','归口部门会签','主管院长','院办主任核稿','院长审批') 
                order by FinishTime asc";
                sql = string.Format(sql, id);
                IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                PageState.Add("Opinion", taskDics);
                sql = @"select  * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0 ";
                sql = string.Format(sql, ent.ApproveContent);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
                sql = @"select  * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0 ";
                sql = string.Format(sql, ent.Attachment);
                PageState.Add("DataList2", DataHelper.QueryDictList(sql));
            }
            else
            {
                sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                from View_SysUserGroup where UserId='{0}'";
                sql = string.Format(sql, UserInfo.UserID);
                IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
                if (deptDics.Count > 0)
                {
                    var obj = new
                    {
                        CreateDeptId = deptDics[0].Get<string>("DeptId"),
                        CreateDeptName = deptDics[0].Get<string>("DeptName"),
                        CreateId = UserInfo.UserID,
                        CreateName = UserInfo.Name
                    };
                    SetFormData(obj);
                }
            }
            string taskId = RequestData.Get<string>("TaskId");//取审批暂存时所填写的意见
            if (!string.IsNullOrEmpty(taskId))
            {
                Task tEnt = Task.Find(taskId);
                if (tEnt.Status != 4 && !string.IsNullOrEmpty(tEnt.Description))
                {
                    PageState.Add("UnSubmitOpinion", tEnt.Description);
                }
            }
        }
    }
}

