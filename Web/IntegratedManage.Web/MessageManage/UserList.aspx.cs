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

namespace IntegratedManage.Web.MessageManage
{
    public partial class UserList : IMListPage
    {
        string sql = "";
        string id = "";
        ReleaseTemplate ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ReleaseTemplate.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    ent = ReleaseTemplate.Find(id);
                    ent.DoDelete();
                    break;
                default:
                    DoSelect();//V_FactDept
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
                            where = @" and (PatIndex('%{0}%',FirstLeaderNames)>0 or PatIndex('%{0}%',SecondLeaderNames)>0 or
                            PatIndex('%{0}%',ClerkNames)>0)";
                            where = string.Format(where, item.Value);
                            break;
                    }
                }
            }
            ArrayList arrList = new ArrayList();
            sql = @"select * from BJKY_Examine..PersonConfig where (GroupType='职能服务部门' or GroupType='经营目标单位') " + where + "order by GroupType asc";
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            foreach (EasyDictionary dic in dics)
            {
                string[] fieldIdArray = new string[] { "FirstLeaderIds", "SecondLeaderIds", "ClerkIds" };
                string[] fieldNameArray = new string[] { "FirstLeaderNames", "SecondLeaderNames", "ClerkNames" };
                for (int j = 0; j < fieldIdArray.Length; j++)
                {
                    string userIds = dic.Get<string>(fieldIdArray[j]);
                    string userNames = dic.Get<string>(fieldNameArray[j]);
                    if (!string.IsNullOrEmpty(userIds))
                    {
                        string[] idArray = userIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        string[] nameArray = userNames.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < idArray.Length; i++)
                        {
                            Object[] oArray = new Object[] { };
                            ArrayList subArray = new ArrayList();
                            subArray.Add(idArray[i]); subArray.Add(nameArray[i]);
                            subArray.Add(dic.Get<string>("Id"));
                            subArray.Add(dic.Get<string>("GroupName"));
                            arrList.Add(subArray);
                        }
                    }
                }
            }
            PageState.Add("DataList", arrList);
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

