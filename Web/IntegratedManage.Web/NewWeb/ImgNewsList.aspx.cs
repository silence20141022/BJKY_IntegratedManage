using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Generic;

using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using Aim;
namespace IntegratedManage.Web
{
    public partial class ImgNewsList : BaseListPage
    {
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (RequestActionString)
            {
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
                        default:
                            where += " and A." + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            sql = @"select * from (select A.Id,A.Title,A.PostUserId,A.PostUserName,A.PostDeptId,A.PostDeptName,A.PostTime,
                B.TypeName from ImgNews A left join NewsType B on  A.TypeId=B.Id
                where  A.State='2' 
                union 
                select A.Id,A.Title,A.PostUserId,A.PostUserName,A.PostDeptId,A.PostDeptName,A.PostTime,B.TypeName
                from News A left join NewsType B on  A.TypeId=B.Id where   A.State='2' and TypeId='fa67b910-a692-4df7-83a2-50711ba4bfa5') t" + where;
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "PostTime";
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

