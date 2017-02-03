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

namespace IntegratedManage.Web.MessageManage
{
    public partial class MessageList : IMListPage
    {
        string sql = "";
        string Index = "";
        IntegratedMessage ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Index = RequestData.Get<string>("Index");
            IList<string> ids = RequestData.GetList<string>("ids");
            switch (RequestActionString)
            {
                case "HaveRead":
                    if (ids.Count > 0)
                    {
                        foreach (string str in ids)
                        {
                            ent = IntegratedMessage.Find(str);
                            ent.State = "1";
                            ent.DoUpdate();
                        }
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
            switch (Index)
            {
                case "0"://未接收
                    sql = @"select * from BJKY_IntegratedManage..IntegratedMessage where ReceiverId='{0}' and State is null
                    and SubmitState='1'" + where;
                    break;
                case "1"://已接收
                    sql = @"select * from BJKY_IntegratedManage..IntegratedMessage where ReceiverId='{0}' and State='1'
                    and SubmitState='1'" + where;
                    break;
                case "2"://未发送
                    sql = @"select * from BJKY_IntegratedManage..IntegratedMessage where CreateId='{0}' and SubmitState is null" + where;
                    break;
                case "3"://已发送
                    sql = @"select * from BJKY_IntegratedManage..IntegratedMessage where CreateId='{0}' and SubmitState='1'" + where;
                    break;
                case "4"://已删除
                    sql = @"select * from BJKY_IntegratedManage..IntegratedMessage where ReceiverId='{0}'and State='2' and SubmitState='1'" + where;
                    break;
            }
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
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

