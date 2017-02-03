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
using System.Text;
using Aim;
namespace IntegratedManage.Web.SurveyManage
{
    public partial class DetailViewList : IMListPage
    {

        string Id = string.Empty;

        public DetailViewList()
        {
            this.SearchCriterion.PageSize = 200;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Id = this.RequestData.Get<string>("Id");
            switch (RequestActionString)
            {
                default:
                    DoSelect();
                    break;
            }
        }

        private void DoSelect()
        {
            //            string sql = @"select 
            //                             SurveyedUserId as UserId,SurveryUserName as UserName,
            //                             C.GroupID as DeptId,C.Name As DeptName,D.IsNoName
            //                           from BJKY_IntegratedManage..SurveyCommitHistory As A
            //                            left join BJKY_Portal..SysUserGroup As B 
            //                                on A.SurveyedUserId=B.UserId 
            //                            left join BJKY_Portal..SysGroup As C
            //                                on C.GroupID=B.GroupID
            //                            left  join BJKY_IntegratedManage..SurveyQuestion AS D
            //	                            on D.Id=A.SurveyId				
            //                           where A.SurveyId='{0}' and 1=1 ";
            string sql = @"select 
	                            SurveyedUserId as UserId,SurveryUserName as UserName,D.IsNoName,A.CreateTime
                           from BJKY_IntegratedManage..SurveyCommitHistory As A
                            left  join BJKY_IntegratedManage..SurveyQuestion AS D
	                            on D.Id=A.SurveyId				
                           where A.SurveyId='{0}' and 1=1";

            if (SearchCriterion.GetSearchValue("UserName") != null)
            {
                sql = sql.Replace("and 1=1", " and A.SurveryUserName like '%" + SearchCriterion.GetSearchValue("UserName") + "%'");
            }
            if (!string.IsNullOrEmpty(Id))
            {
                sql = string.Format(sql, Id);
                this.PageState.Add("DataList", GetPageData(sql, SearchCriterion));
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
