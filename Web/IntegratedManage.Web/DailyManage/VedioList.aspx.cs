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

namespace IntegratedManage.Web.DailyManage
{
    public partial class VedioList : IMListPage
    {
        string sql = "";
        string id = "";
        Vedio ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = Vedio.Find(id);
            }
            switch (RequestActionString)
            {
                case "delete":
                    DoDelete();
                    break;
                case "getTip":
                    GetTooltip();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }



        public void GetTooltip()
        {
            if (!string.IsNullOrEmpty(id))
            {
                string sql = @"select Theme,VedioType,PlayTimes,Remark,CreateName,CreateTime
                                from BJKY_IntegratedManage..Vedio where Id='{0}'";
                sql = string.Format(sql, id);
                this.PageState.Add("VedioEnt", DataHelper.QueryDictList(sql));
            }
        }

        private void DoDelete()
        {
            try
            {
                FileItem.Find(ent.VedioFile).DoDelete();
                ent.DoDelete();
            }
            catch
            {
                ent.DoDelete();
            }
        }
        private void DoSelect()
        {

            //维护验证
            string auth = @"select Id from BJKY_IntegratedManage..IntegratedConfig  where  patindex('%{0}%',VedioMaintenanceId)>0";
            auth = string.Format(auth, UserInfo.UserID);
            if (DataHelper.QueryValue(auth) != null)
            {
                this.PageState.Add("authState", "true");
            }

            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "BeginDate":
                            where += " and A.CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndDate":
                            where += " and A.CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            if (item.PropertyName == "VedioType" && item.Value.ToString() == "全部")
                            {
                                break;
                            }
                            else
                            {
                                where += " and A." + item.PropertyName + " like '%" + item.Value + "%' ";
                            }
                            break;
                    }
                }
            }
            sql = @"select A.*,B.Name from BJKY_IntegratedManage..Vedio as A left join BJKY_Portal..FileItem as B on A.VedioFile=B.Id
            where 1=1" + where;
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
            PageState.Add("VedioType", SysEnumeration.GetEnumDict("VedioType"));
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


        private string GetApproveUserInfo(string sql)//人员id 和name拼接而成
        {
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            string resultUserIds = string.Empty;
            string resultUserNames = string.Empty;
            foreach (EasyDictionary dic in dics)
            {
                resultUserIds += dic.Get<string>("UserID") + ",";
                resultUserNames += dic.Get<string>("UserName") + ",";
            }
            return resultUserIds + "$" + resultUserNames;
        }
    }
}

