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
    public partial class RegulationList : IMListPage
    {
        #region 变量

        private IList<Rule_Regulation> ents = null;
        string pid = "";
        string seltype = "";
        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            Rule_Regulation ent = null;
            seltype = RequestData.Get<string>("seltype");

            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Rule_Regulation>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (RequestActionString == "bathrelease")
                    {
                        DoBatchRelease();
                    }
                    else if (RequestActionString == "bathunrelease")
                    {
                        DoBatchUnRelease();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        private void DoBatchRelease()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                foreach (string id in idList)
                {
                    //Rule_Regulation.TryFind(
                    Rule_Regulation rr = Rule_Regulation.TryFind(id);
                    if (rr != null)
                    {
                        if (rr.ReleaseState != "已发布")
                        {
                            rr.ReleaseState = "已发布";
                            rr.ReleaseId = UserInfo.UserID;
                            rr.ReleaseName = UserInfo.Name;
                            rr.ReleaseTime = System.DateTime.Now;
                            rr.DoUpdate();
                        }
                    }

                }
            }
        }

        private void DoBatchUnRelease()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                foreach (string id in idList)
                {
                    Rule_Regulation rr = Rule_Regulation.TryFind(id);
                    if (rr != null)
                    {
                        if (rr.ReleaseState == "已发布")
                        {
                            rr.ReleaseState = "未发布";
                            rr.ReleaseId = UserInfo.UserID;
                            rr.ReleaseName = UserInfo.Name;
                            rr.ReleaseTime = System.DateTime.Now;
                            rr.DoUpdate();
                        }
                    }
                }
            }
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {

            pid = RequestData.Get<string>("pid");
            if (!string.IsNullOrEmpty(pid))
            {
                string where = "";
                foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                {
                    if (!String.IsNullOrEmpty(item.Value.ToString()))
                    {
                        where += " and a." + item.PropertyName + " like '%" + item.Value + "%' ";
                    }
                }

                SysGroup sg = SysGroup.Find(pid);
                string path = sg.Path;//所点击的部门的path

                //ents = Rule_Regulation.FindAll(SearchCriterion, Expression.Sql(" charindex(DeptId,'" + path + "')>0"));
                //this.PageState.Add("Rule_RegulationList", ents);

                string sql = "";
                if (seltype == "browse")
                {
                    sql = @"select distinct a.* from 
(
SELECT * FROM BJKY_IntegratedManage..Rule_Regulation where AuthType='all'
union
select a.* from BJKY_IntegratedManage..Rule_Regulation a 
left join BJKY_Portal..View_SysUserGroup b on a.DeptId like '%'+b.DeptId+'%'
where b.UserId='{2}' and b.Type<>'3' and a.AuthType='dept'
union
select a.* from BJKY_IntegratedManage..Rule_Regulation a
left join BJKY_IntegratedManage..Rule_Regulation_BrowseAuth b on b.Rule_Regulation=a.Id
where b.UserId='{2}' and a.AuthType='specify'
union 
select a.* from BJKY_IntegratedManage..Rule_Regulation a
left join BJKY_IntegratedManage..Rule_Regulation_BrowseDept b on b.Rule_Regulation=a.Id
left join BJKY_Portal..View_SysUserGroup c on b.DeptId=c.DeptId
where c.UserId='{2}' and c.Type<>'3' and a.AuthType='specify')a 
left join
BJKY_Portal..SysGroup b on a.DeptId like '%'+b.GroupID+'%' 
where b.Path like '%{0}%' {1}
";
                    //sql = @"SELECT a.* FROM BJKY_IntegratedManage..Rule_Regulation a left join BJKY_IntegratedManage..Rule_Regulation_BrowseAuth c on c.Rule_Regulation=a.Id LEFT JOIN BJKY_Portal..SysGroup b ON a.DeptId=b.GroupID WHERE b.Path like '%{0}%' and c.UserId='{2}' {1}";

                    sql = string.Format(sql, path, where, UserInfo.UserID);
                }
                else
                {
                    sql = @"SELECT a.* FROM BJKY_IntegratedManage..Rule_Regulation a LEFT JOIN BJKY_Portal..SysGroup b ON a.DeptId=b.GroupID WHERE b.Path like '%{0}%' {1}";
                    sql = string.Format(sql, path, where);
                }

                this.PageState.Add("Rule_RegulationList", GetPageData(sql, SearchCriterion));


            }
            else
            {
                if (seltype == "browse")
                {
                    string where = "";
                    foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                    {
                        if (!String.IsNullOrEmpty(item.Value.ToString()))
                        {
                            where += " and a." + item.PropertyName + " like '%" + item.Value + "%' ";
                        }
                    }
                    string sql = "";
                    sql = @"select distinct a.* from (SELECT * FROM BJKY_IntegratedManage..Rule_Regulation where AuthType='all'
union
select a.* from BJKY_IntegratedManage..Rule_Regulation a 
left join BJKY_Portal..View_SysUserGroup b on a.DeptId like '%'+b.DeptId+'%'
where b.UserId='{1}' and b.Type<>'3' and a.AuthType='dept'
union
select a.* from BJKY_IntegratedManage..Rule_Regulation a
left join BJKY_IntegratedManage..Rule_Regulation_BrowseAuth b on b.Rule_Regulation=a.Id
where b.UserId='{1}' and a.AuthType='specify'
union 
select a.* from BJKY_IntegratedManage..Rule_Regulation a
left join BJKY_IntegratedManage..Rule_Regulation_BrowseDept b on b.Rule_Regulation=a.Id
left join BJKY_Portal..View_SysUserGroup c on b.DeptId=c.DeptId
where c.UserId='{1}' and c.Type<>'3' and a.AuthType='specify')a 
where 1=1 {0}";
                    //sql = @"SELECT a.* FROM BJKY_IntegratedManage..Rule_Regulation a left join BJKY_IntegratedManage..Rule_Regulation_BrowseAuth c on c.Rule_Regulation=a.Id LEFT JOIN BJKY_Portal..SysGroup b ON a.DeptId=b.GroupID WHERE c.UserId='{1}' {0}";
                    sql = string.Format(sql, where, UserInfo.UserID);
                    this.PageState.Add("Rule_RegulationList", GetPageData(sql, SearchCriterion));

                }
                else
                {
                    ents = Rule_Regulation.FindAll(SearchCriterion);
                    this.PageState.Add("Rule_RegulationList", ents);
                }

            }


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
                Rule_Regulation.DoBatchDelete(idList.ToArray());
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
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
    }
}

