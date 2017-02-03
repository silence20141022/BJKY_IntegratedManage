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
using Aim;

namespace IntegratedManage.Web
{
    public partial class LeaderBusinessTrip2 : IMListPage
    {
        private IList<IntegratedManage.Model.LeaderBusinessTrip> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            IntegratedManage.Model.LeaderBusinessTrip ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<IntegratedManage.Model.LeaderBusinessTrip>();
                    ent.DoDelete();
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }
        }
        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            string LeaderId = RequestData.Get<string>("LeaderId");
            string ids = RequestData.Get<string>("id");
            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "TripStartTime":
                            where += " and TripStartTime>='" + item.Value + "' ";
                            break;
                        case "TripEndTime":
                            where += " and TripStartTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }

            string sql = @"select *,charindex(LeaderName,'{0}') As SortIndex from BJKY_IntegratedManage..LeaderBusinessTrip where  1=1 ";
            //按顺序获取领导
            string LeaderSql = @"select STUFF((select ','+ CAST(UserName AS varchar)  from  BJKY_IntegratedManage..InstituteLeader FOR XML PATH('')),1,1,'' ) As LeaderName ";
            object obj = DataHelper.QueryValue(LeaderSql);
            sql = string.Format(sql, obj);

            //if (!string.IsNullOrEmpty(RequestData.Get<string>("viewType") + "")) //处理月份
            //{
            //    sql = "select * from BJKY_IntegratedManage..LeaderBusinessTrip where '{0}' like '%'+Id+'%' ";
            //    sql = string.Format(sql, ids);
            //}

            if (!string.IsNullOrEmpty(where)) sql = sql + where;
            if (!string.IsNullOrEmpty(LeaderId))
            {
                sql += " and LeaderId='" + LeaderId + "'";
            }
            //sql += " order by SortIndex ";
            SearchCriterion.SetOrder("SortIndex");
            //ents = IntegratedManage.Model.LeaderBusinessTrip.FindAll();
            this.PageState.Add("LeaderBusinessTripList", GetPageData(sql, SearchCriterion));
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

        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {

                IntegratedManage.Model.LeaderBusinessTrip.DoBatchDelete(idList.ToArray());
            }
        }
    }
}
