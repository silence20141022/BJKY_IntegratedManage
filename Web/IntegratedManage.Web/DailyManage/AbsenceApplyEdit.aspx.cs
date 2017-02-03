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
using IntegratedManage.Model;
using Aim.WorkFlow;
using Aim;

namespace IntegratedManage.Web
{
    public partial class AbsenceApplyEdit : IMListPage
    {


        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型
        AbsenceApply ent = null;
        string sql = "";
        string JsonString = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = AbsenceApply.Find(id);
            }
            JsonString = RequestData.Get<string>("JsonString");
            switch (RequestActionString)
            {
                case "update":
                    if (!string.IsNullOrEmpty(JsonString))
                    {
                        AbsenceApply tempEnt = JsonHelper.GetObject<AbsenceApply>(JsonString);
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(JsonString);
                        DataHelper.MergeData<AbsenceApply>(ent, tempEnt, dic.Keys);
                        ent.DoUpdate();
                    }
                    else
                    {
                        ent = this.GetMergedData<AbsenceApply>();
                        ent.DoUpdate();
                    }
                    PageState.Add("Id", ent.Id);
                    break;
                case "create":
                    ent = this.GetPostedData<AbsenceApply>();
                    ent.DoCreate();
                    PageState.Add("Id", ent.Id);
                    break;
                case "delete":
                    ent = this.GetTargetData<AbsenceApply>();
                    ent.DoDelete();
                    return;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
                    break;
                case "GetNextUsers":
                    PageState.Add("NextUsers", new string[] { ent.ExamineUserId, ent.ExamineUserName });
                    break;
                case "submitfinish":
                    ent.WorkFlowState = RequestData.Get<string>("state");
                    ent.ApproveResult = RequestData.Get<string>("ApproveResult");
                    ent.DoUpdate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (op == "c")
            {
                sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                from View_SysUserGroup where UserId='{0}'";
                sql = string.Format(sql, UserInfo.UserID);
                IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
                ent = new AbsenceApply();
                if (deptDics.Count > 0)
                {
                    ent.DeptId = deptDics[0].Get<string>("DeptId");
                    ent.DeptName = deptDics[0].Get<string>("DeptName");
                }
                ent.ApplyUserId = UserInfo.UserID;
                ent.ApplyUserName = UserInfo.Name;
            }
            sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' order by FinishTime asc";
            sql = string.Format(sql, id);
            IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
            PageState.Add("Opinion", taskDics);
            string taskId = RequestData.Get<string>("TaskId");//取审批暂存时所填写的意见
            if (!string.IsNullOrEmpty(taskId))
            {
                Task tEnt = Task.Find(taskId);
                if (tEnt.Status != 4 && !string.IsNullOrEmpty(tEnt.Description))
                {
                    PageState.Add("UnSubmitOpinion", tEnt.Description);
                }
            }
            SetFormData(ent);
        }
        private void StartFlow()
        {
            ArrayList array = new ArrayList();
            string state = RequestData.Get<string>("state");
            string formUrl = "/DailyManage/AbsenceApplyEdit.aspx?op=v&id=" + id;
            Guid guid = WorkFlow.StartWorkFlow(id, formUrl, "出差审批", "TravelApply", UserInfo.UserID, UserInfo.Name);
            //WorkFlowIntance Insert 返回一个WorkflowIntance   Id 同时给自己生成一条审批任务
           
            array.Add(guid + "#" + ent.ExamineUserId + "$" + ent.ExamineUserName);
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
                Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], "出差审批", userarray);
            }
        }
    }
}

