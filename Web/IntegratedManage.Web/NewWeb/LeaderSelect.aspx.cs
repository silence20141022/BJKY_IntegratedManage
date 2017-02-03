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
using Aim;
using System.Data;
using Newtonsoft.Json.Linq;
using IntegratedManage.Model;

namespace IntegratedManage.Web
{
    public partial class LeaderSelect : IMListPage
    {
        string sql = "";
        InstituteLeader ilEnt1 = null;
        InstituteLeader ilEnt2 = null;
        IList<EasyDictionary> dics = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = RequestData.Get<string>("id");
            switch (RequestActionString)
            {
                case "delete":
                    string leaderids = RequestData.Get<string>("leaderids");
                    sql = "delete from BJKY_IntegratedManage..InstituteLeader where '" + leaderids + "' like '%'+Id+'%'";
                    DataHelper.ExecSql(sql);
                    break;
                case "downlevel":
                    ilEnt1 = InstituteLeader.Find(id);//待降级的
                    sql = @"select top 1 Id from BJKY_IntegratedManage..InstituteLeader where SortIndex=
                         (select min(SortIndex) from (select * from  BJKY_IntegratedManage..InstituteLeader  where SortIndex > {0}) t )";
                    sql = string.Format(sql, ilEnt1.SortIndex);
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)//如果有比他靠后的领导
                    {
                        ilEnt2 = InstituteLeader.Find(dics[0].Get<string>("Id"));
                        int? temp = ilEnt2.SortIndex;
                        ilEnt2.SortIndex = ilEnt1.SortIndex;
                        ilEnt2.DoUpdate();
                        ilEnt1.SortIndex = temp;
                        ilEnt1.DoUpdate();
                    }
                    break;
                case "uplevel":
                    ilEnt1 = InstituteLeader.Find(id);//待升级的
                    sql = @"select top 1 Id from BJKY_IntegratedManage..InstituteLeader where SortIndex=
                         (select max(SortIndex) from (select * from  BJKY_IntegratedManage..InstituteLeader  where SortIndex <{0}) t )";
                    sql = string.Format(sql, ilEnt1.SortIndex);
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)//如果有比他靠后的领导
                    {
                        ilEnt2 = InstituteLeader.Find(dics[0].Get<string>("Id"));
                        int? temp = ilEnt2.SortIndex;
                        ilEnt2.SortIndex = ilEnt1.SortIndex;
                        ilEnt2.DoUpdate();
                        ilEnt1.SortIndex = temp;
                        ilEnt1.DoUpdate();
                    }
                    break;
                case "AddLeader":
                    string userIds = RequestData.Get<string>("userIds");
                    string[] idarray = userIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    IList<InstituteLeader> ilEnts = new List<InstituteLeader>();
                    sql = "select max(SortIndex) from BJKY_IntegratedManage..InstituteLeader";
                    int maxval = DataHelper.QueryValue<int>(sql);
                    foreach (string userid in idarray)
                    {
                        InstituteLeader ilEnt = new InstituteLeader();
                        ilEnt.UserId = userid;
                        ilEnt.UserName = SysUser.Find(userid).Name;
                        maxval++;
                        ilEnt.SortIndex = maxval;
                        sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                        case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                        from View_SysUserGroup where UserId='{0}'";
                        sql = string.Format(sql, userid);
                        IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
                        if (deptDics.Count > 0)
                        {
                            ilEnt.DeptId = deptDics[0].Get<string>("DeptId");
                            ilEnt.DeptName = deptDics[0].Get<string>("DeptName");
                        }
                        ilEnt.DoCreate();
                        ilEnts.Add(ilEnt);
                    }
                    PageState.Add("ilEnts", ilEnts);
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string where = "";
            if (IsAsyncRequest)
            {
                foreach (string str in RequestData.Keys)
                {
                    if (!string.IsNullOrEmpty(RequestData[str] + ""))
                    {
                        switch (str)//在排序和分页的时候会传递其他的Key过来 防止报错所以没有用default
                        {
                            case "UserName":
                                where += " and " + str + " like '%" + RequestData[str].ToString().Replace(" ", "") + "%'";
                                break;
                        }
                    }
                }
            }
            sql = "select * from BJKY_IntegratedManage..InstituteLeader where 1=1 " + where;
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "SortIndex";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " asc" : " desc";
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

