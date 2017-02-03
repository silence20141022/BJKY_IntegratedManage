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
    public partial class ReceiveManageList : IMListPage
    {
        #region 变量

        private IList<ReceiveManage> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            ReceiveManage ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<ReceiveManage>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
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

        #endregion

        #region 私有方法

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {

            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "StartTime":
                            where += " and ComInTime >='" + item.Value + "' ";
                            break;
                        case "EndTime":
                            where += " and ComInTime <='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + ProcessSqlStr(item.Value + "") + "%' ";
                            break;
                    }
                }
            }
            string sql = @"select * from BJKY_IntegratedManage..ReceiveManage where 1=1 ";
            if (!string.IsNullOrEmpty(where))
            {
                sql = sql + where;
            }

            // ents = ReceiveManage.FindAll(SearchCriterion);
            this.PageState.Add("ReceiveManageList", GetPageData(sql, SearchCriterion));

        }


        /**/
        /// < summary>  
        /// 分析用户请求是否正常  
        /// < /summary>  
        /// < param name="Str">传入用户提交数据< /param>  
        /// < returns>返回是否含有SQL注入式攻击代码< /returns>  
        private static string ProcessSqlStr(string Str)
        {
            string SqlStr = "'or|and|exec|insert|select|delete|update|count|*|chr|mid|master|truncate|char|declare";
            if (Str != "")
            {
                Str = Str.ToLower();
                string[] anySqlStr = SqlStr.Split('|');
                foreach (string ss in anySqlStr)
                {
                    if (Str.IndexOf(ss) >= 0)
                    {
                        Str = Str.Replace(ss, "");
                    }
                }
            }
            return Str + "";
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
                ReceiveManage.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion

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
            IList<Aim.EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
    }
}

