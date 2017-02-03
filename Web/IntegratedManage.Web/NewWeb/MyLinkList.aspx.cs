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
using System.Data;
using System.Configuration;

namespace IntegratedManage.Web
{
    public partial class MyLinkList : IMListPage
    {
        IList<WebLink> ents = null;
        string id = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            WebLink ent = null;
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = WebLink.Find(id);
            }
            switch (RequestActionString)
            {
                case "create":
                    ent = new WebLink();
                    ent.DoCreate();
                    PageState.Add("Entity", ent);
                    break;
                case "update":
                    string field = RequestData.Get<string>("field");
                    string value = RequestData.Get<string>("value");
                    if (field == "Url")
                    {
                        ent.Url = value;
                    }
                    else
                    {
                        ent.WebName = value;
                    }
                    ent.DoUpdate();
                    break;
                case "delete":
                    string ids = RequestData.Get<string>("ids");
                    string[] idarray = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string tid in idarray)
                    {
                        ent = WebLink.Find(tid);
                        if (ent.IsAdmin == "1")
                        {
                            ent.ExceptUserId += (string.IsNullOrEmpty(ent.ExceptUserId) ? "" : ",") + UserInfo.UserID;
                            ent.DoUpdate();
                        }
                        else
                        {
                            ent.DoDelete();
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
            string sql = @"select *  from BJKY_IntegratedManage..WebLink where (IsAdmin='1' and 
            PatIndex('%" + UserInfo.UserID + "%',isnull(ExceptUserId,''))<=0) or CreateId='" + UserInfo.UserID + "'";
            PageState.Add("WebLinkList", DataHelper.QueryDictList(sql));
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
