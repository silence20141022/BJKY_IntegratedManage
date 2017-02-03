using System;
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
using System.Collections;

namespace IntegratedManage.Web
{
    public partial class OnlineUserList : IMListPage
    {

        private IList<AbsenceApply> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            AbsenceApply ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<AbsenceApply>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (RequestActionString == "Submit")
                    {
                        ChanageState();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        /// <summary>
        /// 修改状态
        /// </summary>
        private void ChanageState()
        {
            string Id = this.RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                AbsenceApply ent = AbsenceApply.Find(Id);
                if (ent == null) return;
                // ent.State = "1";
                ent.DoUpdate();
            }
        }

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            string sql = @"select * from SysUser where UserID in (
select UserID from (
select count(UserID)%2 cnt,UserID from SysEvent where DateTime>=dateadd(day,-2,GetDate()) and Type is null
 group by UserID) a 
where cnt>0)";
            if (SearchCriterion.GetSearchValue<string>("Name") != "")
                sql += " and Name like '%" + SearchCriterion.GetSearchValue<string>("Name") + "%'";
            //PageState.Add("AbsenceApplyList", GetPageData(sql, SearchCriterion));
            //ents = AbsenceApply.FindAll(SearchCriterion);
            //this.PageState.Add("AbsenceApplyList", ents);
            Aim.Portal.ServicesProvider.WebPortalServiceProvider ws = (Aim.Portal.ServicesProvider.WebPortalServiceProvider)WebPortalService.GetDefaultProvider();
            SysUser[] users = Aim.Common.ServiceHelper.DeserializeFromBytes<SysUser[]>(ws.USService.GetSystemData("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getonlineusers</parameter></parameters></container>"));
            PageState.Add("AbsenceApplyList", users);
        }


        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateDate";
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
                AbsenceApply.DoBatchDelete(idList.ToArray());
            }
        }

    }
}

