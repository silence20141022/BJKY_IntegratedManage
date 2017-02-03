using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text; 
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using Aim.WorkFlow; 

namespace Aim.Portal.Web.WorkFlow
{
    public partial class TaskList : BaseListPage
    {
        string sql = "";
        string where = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (RequestActionString.ToLower())
            {
                case "startflow":
                    //启动流程
                    /*string key = "FirstFlow";
                    //表单路径,后面加上参数传入
                    string formUrl = "/EPC/PrjBasic/PrjBasicEdit.aspx?op=u";
                    Aim.WorkFlow.WorkFlow.StartWorkFlow("", formUrl, "流程的标题", key, this.UserInfo.UserID, this.UserInfo.Name);*/
                    string key = this.RequestData.Get<string>("flowkey");
                    Aim.WorkFlow.WorkflowTemplate ne = Aim.WorkFlow.WorkflowTemplate.FindAllByProperty("Code", key)[0];
                    //启动流程
                    //表单路径,后面加上参数传入
                    string formUrl = "/WorkFlow/flowdemo.htm";
                    Aim.WorkFlow.WorkFlow.StartWorkFlow(ne.ID, formUrl, ne.TemplateName, key, this.UserInfo.UserID, this.UserInfo.Name);
                    PageState.Add("message", "启动成功");
                    break;
                default:

                    foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                    {
                        if (!String.IsNullOrEmpty(item.Value.ToString()))
                        {
                            switch (item.PropertyName)
                            {
                                case "BeginDate":
                                    where += " and ReceiveDate>='" + item.Value + "' ";
                                    break;
                                case "EndDate":
                                    where += " and ReceiveDate<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                                    break;
                                default:
                                    where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                                    break;
                            }
                        }
                    }
                    if (int.Parse(RequestData["Status"].ToString()) == 0)
                    {
                        sql = @"select * from (
                            select Id,(WorkFlowName+'--'+ApprovalNodeName) Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,CreatedTime as CreateTime,
                            '综合办公' RelateName,'' System,'' Type,'' ExecUrl,'' RelateType,'' OwnerUserId from Task where status=0 and OwnerId='{0}'  
                            union
                            select Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,'综合办公' RelateName,System,Type,
                            ExecUrl,RelateType,OwnerUserId from BJKY_BeAdmin..WfWorkList where State='New'and isnull(OwnerUserId,'')<>'' and IsSign='{0}'
                            union 
                            select Id,Title,'' WorkFlowInstanceId,'' WorkFlowName,'' ApprovalNodeName,CreateTime,'问卷调查' Relatename,'' System,'Questionare' Type,'' ExecUrl,
                            '' RelateType,'' OwnerUserId from BJKY_IntegratedManage..SurveyQuestion c
                            where state='1' and (select count(1) from BJKY_IntegratedManage..SurveyCommitHistory t where t.SurveyId=c.Id and t.SurveyedUserId='{0}')=0
                            and (isnull(StatisticsPower,'')='' or PatIndex('%{0}%',StatisticsPower)>0)             
                            union 
                            select Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' Type,
                            ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskMiddle where (State='New' or State='0') and OwnerUserId='{0}'           
                            ) b where 1=1 " + where;
                    }
                    if (int.Parse(RequestData["Status"].ToString()) == 1)
                    {
                        sql = @"select * from (
                            select Id,(WorkFlowName+'--'+ApprovalNodeName) Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,CreatedTime as CreateTime,
                            '综合办公' RelateName,'' System,'' Type,'' ExecUrl,'' RelateType,'' OwnerUserId from Task where status<>0 and OwnerId='{0}'  
                            union
                            select Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,'综合办公' as RelateName,System,Type,
                            ExecUrl,RelateType,OwnerUserId from BJKY_BeAdmin..WfWorkList where isnull(State,'')<>'New'and isnull(OwnerUserId,'')<>'' and IsSign='{0}'
                            union 
                            select Id,Title,'' WorkFlowInstanceId,'' WorkFlowName,'' ApprovalNodeName,CreateTime,'问卷调查' RelateName,'' System,'Questionare' Type,'' ExecUrl,
                            '' RelateType,'' OwnerUserId from BJKY_IntegratedManage..SurveyQuestion c where
                            (select count(1) from BJKY_IntegratedManage..SurveyCommitHistory t where t.SurveyId=c.Id and t.SurveyedUserId='{0}')>0 and (isnull(StatisticsPower,'')='' or PatIndex('%{0}%',StatisticsPower)>0)             
                            union 
                            select Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' Type,
                            ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskMiddle where isnull(State,'')<>'New' and isnull(State,'')<>'0' 
                            and OwnerUserId='{0}' and System!='科研管理系统'
                            union 
                            select Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' Type,
                            ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskFinishMiddle where OwnerUserId='{0}' and System='科研管理系统'     
                            ) b where datediff(month,CreateTime,getdate())<=6 " + where;
                    }
                    sql = string.Format(sql, UserInfo.UserID);
                    PageState.Add("SysWorkFlowTaskList", GetPageData(sql, SearchCriterion));
                    break;
            }
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
    }
}

