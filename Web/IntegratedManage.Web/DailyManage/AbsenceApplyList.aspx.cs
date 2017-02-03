using System;
using System.Collections;
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
using Aim;
using Aim.WorkFlow;

namespace IntegratedManage.Web
{
    public partial class AbsenceApplyList : IMListPage
    {
        AbsenceApply ent = null;
        string sql = "";
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = AbsenceApply.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    ent.DoDelete();
                    break;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
                    break;
                case "CancelFlow":
                    ent.WorkFlowState = "End";
                    ent.ApproveResult = "已撤销";
                    ent.DoUpdate();
                    IList<WorkflowInstance> wfiEnts = WorkflowInstance.FindAllByProperties("Status", "Processing", "RelateId", ent.Id);
                    if (wfiEnts.Count > 0)
                    {
                        wfiEnts[0].Status = "Completed";
                        wfiEnts[0].EndTime = System.DateTime.Now;
                        wfiEnts[0].DoUpdate();
                        sql = "update Task set Status=4 ,Result='已撤销',Description='已撤销',FinishTime='" + System.DateTime.Now + "' where WorkFlowInstanceId='" + wfiEnts[0].ID + "' and Status=0";
                        DataHelper.ExecSql(sql);
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "StartTime":
                            where += " and CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndTime":
                            where += " and CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and A." + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            sql = @"select A.*,(select top 1 ApprovalNodeName from task where Status='0' and PatIndex('%'+A.Id+'%',EFormName)>0) as ApprovalNodeName
            from BJKY_IntegratedManage..AbsenceApply as A where (A.CreateId='{0}' or A.ApplyUserId='{0}')" + where;
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
            PageState.Add("WorkFlowState", SysEnumeration.GetEnumDict("WorkFlowState"));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " desc" : " asc";
            string pageSql = @"
        		    WITH OrderedOrders AS
        		    (SELECT *,
        		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
        		    FROM ({2}) temp ) 
        		    SELECT * 
        		    FROM OrderedOrders 
        		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
        private void StartFlow()
        {
            ArrayList array = new ArrayList();
            string state = RequestData.Get<string>("state");
            string formUrl = "/DailyManage/AbsenceApplyEdit.aspx?op=v&id=" + id;
            Guid guid = WorkFlow.StartWorkFlow(id, formUrl, "出差审批", "TravelApply", UserInfo.UserID, UserInfo.Name);
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

