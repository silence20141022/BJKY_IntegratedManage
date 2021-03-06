﻿using System;
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

namespace IntegratedManage.Web
{
    public partial class SignRequestList : IMListPage
    {
        string sql = "";
        string id = "";
        SignRequest ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = SignRequest.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    if (!string.IsNullOrEmpty(ent.Attachment))
                    {
                        foreach (string str in ent.Attachment.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries))
                        {
                            FileItem fiEnt = FileItem.Find(str);
                            fiEnt.DoDelete();
                        }
                    }
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
                            where += " and CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndDate":
                            where += " and CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            sql = @"select * from BJKY_IntegratedManage..SignRequest where CreateId='{0}'" + where;
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

