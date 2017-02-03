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
    public partial class InteSurveyViewList : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetSurveyList();
        }

        private void GetSurveyList()
        {
            string where = string.Empty;
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "StartTime":
                            where += " and SQ.CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndTime":
                            where += " and SQ.CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        case "CommitState":
                            if (item.Value.ToString() == "yes") where += " and CommitSurvey is not null ";
                            if (item.Value.ToString() == "no") where += " and CommitSurvey is null ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            //一个人在多个部门取一个部门,取其中的一个部门 (fields:CommitState ,IsPasted)
            //***SQ和where 查询条件有关联507947e9-b3ac-4e06-9e33-8ca95ef45e13
            string sql = @"select distinct SQ.Id,SQ.Title,SQ.Contents,SQ.IsNoName,SQ.StartTime,SQ.EndTime,SQ.State,SQ.CreateTime,SQ.DeptId,SQ.DeptName ,SQ.ReadPower,SQ.CreateId,
	                    case when T2.Id is not null  then 'yes' else  'no'  end  As CommitState                          
                        from  BJKY_IntegratedManage..SurveyQuestion  As SQ
                        left join  BJKY_IntegratedManage..SurveyCommitHistory  As T2
                        on SQ.Id=T2.SurveyId  where T2.Id is not null and T2.SurveyedUserId='{0}'
                        and 1=1 ";

            if (!string.IsNullOrEmpty(where))
            {
                sql = sql.Replace("and 1=1", where);
            }
            sql = string.Format(sql, UserInfo.UserID);
            this.PageState.Add("DataList", GetPageData(sql, SearchCriterion));
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
