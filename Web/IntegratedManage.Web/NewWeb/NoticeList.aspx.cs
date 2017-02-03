using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Generic;

using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using Aim;
namespace IntegratedManage.Web
{
    public partial class NoticeList : BaseListPage
    {
        string Index = String.Empty;
        News nEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Index = RequestData.Get<string>("Index", String.Empty);
            switch (RequestActionString)
            {
                case "sign":
                    string ids = RequestData.Get<string>("ids");
                    string[] idarray = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string id in idarray)
                    {
                        nEnt = News.Find(id);
                        //标记为已阅状态
                        if (!string.IsNullOrEmpty(nEnt.ReadState))
                        {
                            nEnt.ReadState += "," + UserInfo.UserID;
                        }
                        else
                        {
                            nEnt.ReadState = UserInfo.UserID;
                        }
                        nEnt.DoUpdate();
                    }
                    string sql = @"select count(Id) from News where (TypeId='a0365551-9017-49f2-b416-14c6bbd8be9b' or TypeId='eb9db227-6adc-4dd1-8783-467aadc2d11b') and 
                    PATINDEX ( '%" + UserInfo.UserID + "%' , ReadState )<=0 and State='2'";
                    PageState.Add("result", DataHelper.QueryValue<int>(sql));
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
                        default:
                            where += " and A." + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            string sql = "";
            if (Index == "0")//未阅
            {
                //                sql = @"declare @path varchar(500)
                //                select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                //                where UserId='{0}' 
                //                select top 5 n.Id,n.Title,n.PostDeptName,Convert(varchar(10),PostTime,20) as NewTime  from News n 
                //                inner join NewsType nt on nt.Id=n.TypeId 
                //                where TypeId in('eb9db227-6adc-4dd1-8783-467aadc2d11b','a0365551-9017-49f2-b416-14c6bbd8be9b')
                //                and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                //                and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                //                exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                //                or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0)) order by PostTime desc ";
                sql = @"select A.*,B.TypeName from News A left join NewsType B on  A.TypeId=B.Id
                where (A.TypeId='a0365551-9017-49f2-b416-14c6bbd8be9b' or A.TypeId='eb9db227-6adc-4dd1-8783-467aadc2d11b') 
                and A.State='2' and PATINDEX ( '%{0}%' , A.ReadState )<=0  and (charindex('{0}',A.ReceiveUserId)>0 or charindex('{0}',B.AllowQueryId)>0 or 
                exists (select Id from Competence c where c.Ext1=A.Id and charindex(PId,(select top 1 g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                where UserId='{0}'))>0)
                or exists (select Id from Competence c where c.Ext1=B.Id and charindex(PId,(select top 1 g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                where UserId='{0}'))>0))" + where;
            }
            else//已阅
            {
                sql = @"select A.*,B.TypeName from News A left join NewsType B on  A.TypeId=B.Id
                where (A.TypeId='a0365551-9017-49f2-b416-14c6bbd8be9b' or A.TypeId='eb9db227-6adc-4dd1-8783-467aadc2d11b') 
                and A.State='2' and PATINDEX ( '%{0}%' , A.ReadState )>0 and (charindex('{0}',A.ReceiveUserId)>0 or charindex('{0}',B.AllowQueryId)>0 or 
                exists (select Id from Competence c where c.Ext1=A.Id and charindex(PId,(select top 1 g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                where UserId='{0}'))>0)
                or exists (select Id from Competence c where c.Ext1=B.Id and charindex(PId,(select top 1 g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                where UserId='{0}'))>0))" + where;
            }
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "PostTime";
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

