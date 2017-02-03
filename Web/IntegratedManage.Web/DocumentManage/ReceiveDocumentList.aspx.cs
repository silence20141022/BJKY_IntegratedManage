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
using Aim;
using IntegratedManage.Model;
using Aim.WorkFlow;

namespace IntegratedManage.Web.DocumentManage
{
    public partial class ReceiveDocumentList : IMListPage
    {
        string sql = "";
        string id = "";
        ReceiveDocument ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ReceiveDocument.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    ent = ReceiveDocument.Find(id);
                    sql = "delete from FileItem where PatIndex('%'+Id+'%','{0}')>0";
                    sql = string.Format(sql, ent.Attachment);
                    DataHelper.ExecSql(sql);
                    ent.DoDelete();
                    break;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
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
            sql = @"select *,(ReceiveWord+ReceiveWordSize) as ReceiveToltalNo,len(MainFile)/37 as MainQuan,len(Attachment)/37 as AttachmentQuan
            from BJKY_IntegratedManage..ReceiveDocument where CreateId='{0}'"+where;
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
            string formUrl = "/DocumentManage/ReceiveDocumentEdit.aspx?op=v&&id=" + id;
            Guid guid = new Guid();
            if (ent.ApprovalNodeName == "院办主任")
            {
                guid = WorkFlow.StartWorkFlow(id, formUrl, "收文审批", "ReceiveDocumentI", UserInfo.UserID, UserInfo.Name);
                IList<IntegratedConfig> icEnts = IntegratedConfig.FindAll();
                array.Add(guid + "#" + icEnts[0].YuanBanZhuRenId + "$" + icEnts[0].YuanBanZhuRenName);
            }
            else
            {
                guid = WorkFlow.StartWorkFlow(id, formUrl, "收文审批", "ReceiveDocumentII", UserInfo.UserID, UserInfo.Name);
                array.Add(guid + "#" + ent.YuanZhangId + "$" + ent.YuanZhangName);
            }
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
                if (strarray.Length > 1)
                {
                    if (!string.IsNullOrEmpty(strarray[1]))
                    {
                        userarray = strarray[1].Split(new string[] { "$" }, StringSplitOptions.RemoveEmptyEntries);
                    }
                }
                IList<Task> tasks = Task.FindAllByProperty(Task.Prop_WorkflowInstanceID, instanceId);
                Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], ent.ApprovalNodeName, userarray);
            }
        }
        private string GetApproveUserInfo(string sql)//人员id 和name拼接而成
        {
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            string resultUserIds = string.Empty;
            string resultUserNames = string.Empty;
            foreach (EasyDictionary dic in dics)
            {
                resultUserIds += dic.Get<string>("UserID") + ",";
                resultUserNames += dic.Get<string>("UserName") + ",";
            }
            return resultUserIds + "$" + resultUserNames;
        }
    }
}

