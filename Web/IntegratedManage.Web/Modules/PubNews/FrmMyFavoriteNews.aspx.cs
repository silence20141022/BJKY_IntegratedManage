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
using System.Data.SqlClient;
using NHibernate.Criterion;



namespace Aim.Portal.Web.Modules.PubNews
{
    public partial class FrmMyFavoriteNews : BaseListPage
    {
        #region 变量

        private News[] ents = null;

        string op = String.Empty;

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");

            News ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<News>();
                    ent.Delete();
                    this.SetMessage("删除成功！");
                    break;
                case RequestActionEnum.Custom:
                    IList<object> idList = RequestData.GetList<object>("IdList");

                    if (idList != null && idList.Count > 0)
                    {
                        if (RequestActionString == "batchdelete")
                        {
                            NewsRule.BatchRemoveByPrimaryKeys(idList);
                        }
                    }

                    if (this.RequestActionString.ToLower() == "submitnews")
                    {
                        News ne = News.Find(this.RequestData["Id"].ToString());
                        ne.PostTime = DateTime.Now;
                        ne.State = this.RequestData["state"].ToString();
                        ne.Save();
                        if (this.RequestData["state"].ToString() == "1")
                            PageState.Add("message", "发布成功");
                        else
                            PageState.Add("message", "撤销成功");
                        return;
                    }
                    else if (RequestActionString == "canelFavorite")
                    {
                        //取消收藏
                        CollectionToUser[] Ctus = CollectionToUser.FindAll("from CollectionToUser where MsgId='" + RequestData["Id"] + "' and UserId='" + UserInfo.UserID + "'");
                        if (Ctus.Length > 0)
                        {
                            foreach (CollectionToUser ctu in Ctus)
                            {
                                ctu.DoDelete();
                            }
                        }
                    }
                    break;
                default:
                    //ents = NewsRule.FindAll(SearchCriterion, Expression.Sql(" Id in (select MsgId from CollectionToUser where UserId='" + UserInfo.UserID + "' )"));

                    string sql = @"select Id,Title,TypeId,PostUserName,PostTime,SaveTime,ExpireTime,[State], 'News' as NewType from News where Id in (select MsgId from CollectionToUser where UserId='" + UserInfo.UserID + "' ) " +
                                    "union all " +
                                    "select Id,Title,TypeId,PostUserName,PostTime,CreateTime,ExpireTime,[State], 'ImgNews' as NewType from ImgNews where Id in (select MsgId from CollectionToUser where UserId='" + UserInfo.UserID + "' ) " +
                                    "union all " +
                                    "select Id,Title,TypeId,PostUserName,PostTime,CreateTime,ExpireTime,[State], 'VideoNews' as NewType from VideoNews where Id in (select MsgId from CollectionToUser where UserId='" + UserInfo.UserID + "' )";

                    this.PageState.Add("DataList", GetPageData(sql, SearchCriterion));
                    break;
            }

            if (!IsAsyncRequest)
            {
                NewsType[] types = NewsType.FindAll();
                Dictionary<string, string> dt = new Dictionary<string, string>();

                foreach (NewsType type in types)
                {
                    dt.Add(type.Id, type.TypeName);
                }

                this.PageState.Add("EnumType", dt);
            }
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

        #endregion
    }
}

