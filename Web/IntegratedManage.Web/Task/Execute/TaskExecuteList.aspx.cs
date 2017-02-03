using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;
using IntegratedManage.Web;
using FlowModel = Aim.WorkFlow;
using System.Data;
using Aim.WorkFlow;
using System.Collections;

namespace IntegratedManage.Web
{
    public partial class TaskExecuteList : BaseListPage
    {
        private IList<V_TaskWBS> ents = null;
        IList<object> idList = null;
        string id = string.Empty;
        A_TaskWBS twEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            V_TaskWBS ent = null;
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                twEnt = A_TaskWBS.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    ent = this.GetTargetData<V_TaskWBS>();
                    ent.Delete();
                    break;
                case "batchdelete":
                    idList = RequestData.GetList<object>("IdList");
                    break;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
                    break;
                case "SignFinish":
                    twEnt.State = "2";
                    twEnt.Update();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (SearchCriterion.Orders.Count == 0)
            {
                SearchCriterion.Orders.Add(new OrderCriterionItem("RootCode", true));
                SearchCriterion.Orders.Add(new OrderCriterionItem("Code", true));
            }
            string dateFlag = this.RequestData["Date"] == null ? "365" : this.RequestData["Date"].ToString();
            switch (dateFlag)
            {
                case "3":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(3), SearchModeEnum.LessThanEqual);
                    break;
                case "7":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(7), SearchModeEnum.LessThanEqual);
                    break;
                case "14":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(14), SearchModeEnum.LessThanEqual);
                    break;
                case "30":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(1), SearchModeEnum.LessThanEqual);
                    break;
                case "31":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(1), SearchModeEnum.LessThanEqual);
                    break;
                case "180":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(3), SearchModeEnum.LessThanEqual);
                    break;
                case "365":
                    SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddYears(1), SearchModeEnum.LessThanEqual);
                    break;
            }
            if (this.RequestData.Get<string>("Status") == "2")
            {
                ents = V_TaskWBS.FindAll(SearchCriterion, Expression.Sql(" (DutyId like '%" + this.UserInfo.UserID + "%' or UserIds like '%" + this.UserInfo.UserID + "%')"), Expression.Eq("State", "2"));
            }
            else if (this.RequestData.Get<string>("Status") == "1.5")
            {
                ents = V_TaskWBS.FindAll(SearchCriterion, Expression.Sql(" (DutyId like '%" + this.UserInfo.UserID + "%' or UserIds like '%" + this.UserInfo.UserID + "%')"), Expression.Eq("State", "1.5"));
            }
            else
            {
                ents = V_TaskWBS.FindAll(SearchCriterion, Expression.Sql(" (DutyId like '%" + this.UserInfo.UserID + "%' or UserIds like '%" + this.UserInfo.UserID + "%')"), Expression.Not(Expression.In("State", new string[] { "0", "1.5", "2" })));
            }
            PageState.Add("SysWorkFlowTaskList", ents);
        }
        public void StartFlow()
        {
            ArrayList array = new ArrayList();
            string formUrl = "/Task/A_TaskWBSEdit.aspx?op=r&InFlow=T&id=" + id;
            Guid guid = WorkFlow.StartWorkFlow(id, formUrl, "任务审批", "AimFinishAudit", UserInfo.UserID, UserInfo.Name);
            A_TaskWBS ptEnt = A_TaskWBS.TryFind(twEnt.ParentID); //获取到上级任务责任人
            if (ptEnt != null)
            {
                array.Add(guid + "#" + ptEnt.DutyId + "$" + ptEnt.DutyName);
                PageState.Add("WorkFlowInfo", array);
                twEnt.State = "1.5";
                twEnt.Update();
            }
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
                WorkFlow.AutoExecute(tasks[0], "任务审批人", userarray);
            }
        }
    }
}