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
    public partial class SurveyView_No : IMListPage
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
                            where += " and T1.CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndTime":
                            where += " and T1.CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
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
            //***T1和where 查询条件有关联
            string sql = @"select distinct T1.Id,T1.Title,T1.Contents,T1.IsNoName,T1.StartTime,T1.EndTime,T1.State,T1.CreateTime,T1.DeptId,T1.DeptName,
                            case when getdate()> T1.EndTime then 'yes' else 'no'  end As IsPasted
                            from  BJKY_IntegratedManage..SurveyQuestion  As T1  
                             where  T1.State=1 and getdate() between StartTime and EndTime
                              and ( 
                                ---All
                                     charindex('all',PowerType) > 0
                                ---person
                                    or patindex('%{0}%',StatisticsPower)>0  or CreateId='{0}'
                                --Dept 
                                or exists(
                                    select F1 As ID  from fun_splitstr(T1.ScanPower,',' )  
                                    INTERSECT 
                                    select GroupID from BJKY_Portal..SysGroup where path like  '%'+
                                         ( select top 1
	                                            case [Type] when 3 then ParentID when 2 then B.GroupID end As GroupID
			                                            from BJKY_Portal..SysUserGroup As A,BJKY_Portal..SysGroup As B 
                                               where A.GroupID=B.GroupID and UserID='{0}' 
                                         ) +'%'
                                ))
                            and not exists(	                             select * from BJKY_IntegratedManage..SurveyCommitHistory where SurveyedUserId='{0}'	                             and T1.Id=SurveyId                            )";

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
