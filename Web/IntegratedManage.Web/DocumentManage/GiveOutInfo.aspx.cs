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

namespace IntegratedManage.Web
{
    public partial class GiveOutInfo : IMListPage
    {
        string sql = "";
        string FormId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            FormId = RequestData.Get<string>("FormId");
            switch (RequestActionString)
            {
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            sql = @"select OwnerId,Owner,EFormName,CONVERT(VARCHAR(10),CreatedTime,120) as CreatedTime,Status,
            Convert(varchar(10),FinishTime,120) as FinishTime, 
            (select top 1 case [Type] when 3 then ParentDeptName when 2 then DeptName  end as DeptName
            from View_SysUserGroup where UserId=Task.OwnerId) as DeptName
            from BJKY_Portal..Task where PatIndex('%{0}%',EFormName)>0 and Ext1='Branch' ";
            sql = string.Format(sql, FormId);
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "DeptName,Owner";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " asc" : " desc";
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

