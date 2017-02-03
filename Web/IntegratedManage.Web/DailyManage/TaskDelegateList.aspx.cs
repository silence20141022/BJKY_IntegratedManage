using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using System.Configuration;
using IntegratedManage.Model;
using Aim;
using Aim.WorkFlow;

namespace IntegratedManage.Web
{
    public partial class TaskDelegateList : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id    
        string sql = "";
        TaskDelegate ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = TaskDelegate.Find(id);
            }
            switch (RequestActionString)
            {
                //case "update":
                //    ent = GetMergedData<ReceiveDocument>();
                //    ent.DoUpdate();
                //    PageState.Add("Id", ent.Id);
                //    break;
                case "StartDelegate":
                    sql = @"update BJKY_IntegratedManage..TaskDelegate set State='0' where Id<>'{0}' and CreateId='{1}'";
                    sql = string.Format(sql, id, UserInfo.UserID);//启动本委托的时候需要将其他委托关闭
                    DataHelper.ExecSql(sql);
                    ent.State = "1";
                    ent.StartTime = System.DateTime.Now;
                    ent.DoUpdate();
                    break;
                case "StopDelegate":
                    ent.State = "0";
                    ent.StartTime = null;
                    ent.DoUpdate();
                    break;
                case "delete":
                    ent.DoDelete();
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
                        //case "BeginDate":
                        //    where += " and CreateTime>='" + item.Value + "' ";
                        //    break;
                        //case "EndDate":
                        //    where += " and CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                        //    break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            sql = @"select * from BJKY_IntegratedManage..TaskDelegate where CreateId='{0}'" + where;
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

