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



namespace Aim.Portal.Web.Modules.PubNews
{
    public partial class NewsList : BaseListPage
    {
        private News[] ents = null;
        string op = String.Empty;
        string typeId = String.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            typeId = RequestData.Get<string>("TypeId", String.Empty);
            News ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<News>();
                    ent.Delete();
                    break;
                case RequestActionEnum.Custom:
                    if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");

                        if (idList != null && idList.Count > 0)
                        {
                            NewsRule.BatchRemoveByPrimaryKeys(idList);

                            foreach (object obj in idList)
                            {
                                ImgNewDetail.DeleteAll(" PId='" + obj + "' ");
                                VideoNewDetail.DeleteAll(" PId='" + obj + "' ");
                            }
                            ImgNews.DoBatchDelete(idList.ToArray());
                            VideoNews.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (this.RequestActionString.ToLower() == "submitnews")
                    {
                        string NewsType = RequestData.Get<string>("NewsType");
                        if (NewsType == "视频")
                        {
                            VideoNews ne = VideoNews.Find(this.RequestData["Id"].ToString());
                            ne.PostTime = DateTime.Now;
                            ne.State = this.RequestData["state"].ToString();
                            string state = this.RequestData["state"] + "";
                            if (state == "2")
                            {
                                ne.PostUserId = UserInfo.UserID;
                                ne.PostUserName = UserInfo.Name;
                                ne.PostTime = DateTime.Now;
                                PageState.Add("message", "发布成功");
                            }
                            else if (state == "0")
                            {
                                PageState.Add("message", "退回成功");
                            }
                            else
                            {
                                ne.PostUserId = "";
                                ne.PostUserName = "";
                                ne.PostTime = null;
                                PageState.Add("message", "撤销成功");
                            }
                            ne.Save();
                        }
                        else if (NewsType == "图片")
                        {
                            ImgNews ne = ImgNews.Find(this.RequestData["Id"].ToString());
                            ne.PostTime = DateTime.Now;
                            ne.State = this.RequestData["state"].ToString();
                            string state = this.RequestData["state"] + "";
                            if (state == "2")
                            {
                                ne.PostUserId = UserInfo.UserID;
                                ne.PostUserName = UserInfo.Name;
                                ne.PostTime = DateTime.Now;
                                PageState.Add("message", "发布成功");
                            }
                            else if (state == "0")
                            {
                                PageState.Add("message", "退回成功");
                            }
                            else
                            {
                                ne.PostUserId = "";
                                ne.PostUserName = "";
                                ne.PostTime = null;
                                PageState.Add("message", "撤销成功");
                            }
                            ne.Save();
                        }
                        else
                        {
                            News ne = News.Find(this.RequestData["Id"].ToString());
                            ne.PostTime = DateTime.Now;
                            ne.State = this.RequestData["state"].ToString();
                            string state = this.RequestData["state"] + "";
                            if (state == "2")
                            {
                                ne.PostUserId = UserInfo.UserID;
                                ne.PostUserName = UserInfo.Name;
                                ne.PostTime = DateTime.Now;
                                PageState.Add("message", "发布成功");
                            }
                            else if (state == "0")
                            {
                                PageState.Add("message", "退回成功");
                            }
                            else
                            {
                                ne.PostUserId = "";
                                ne.PostUserName = "";
                                ne.PostTime = null;
                                PageState.Add("message", "撤销成功");
                            }
                            ne.Save();
                        }
                        return;
                    }
                    break;
                default:
                    string where = " and isnull(ExpireTime,'2099-01-01')>=getdate() ";

                    if (RequestData.Get<string>("checkstate") == "0")
                    {
                        where += " and State='1' ";
                    }
                    else
                    {
                        where += " and State='2' ";
                    }

                    if (RequestData.Get<string>("Expire") == "true")
                    {
                        where = " and isnull(ExpireTime,'2099-01-01')<getdate() ";
                    }
                    foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                    {
                        if (!String.IsNullOrEmpty(item.Value.ToString()))
                        {
                            switch (item.PropertyName)
                            {
                                default:
                                    where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                                    break;
                            }
                        }
                    }

                    if (RequestData.Get<string>("checktype") == "Dept")
                    {
                        string sql = @"select top 1 [Path] from View_SysUserGroup where UserId='" + UserInfo.UserID + "' order by Type desc";
                        where += " and '" + (DataHelper.QueryValue(sql) + "") + "' like '%'+PostDeptId+'%'";
                    }

                    if (!string.IsNullOrEmpty(typeId))
                    {
                        SearchCriterion.SetSearch("TypeId", typeId);
                        ents = NewsRule.FindAll(SearchCriterion, Expression.Sql(" (State='1' or State='2') " + where)).OrderByDescending(o => o.SaveTime).ToArray();

                        this.PageState.Add("SysUserList", ents);
                    }//图片新闻、视频新闻 不需要过滤(不同的页面)
                    else
                    {
                        string sql = @"select * from (select Id, TypeId, Title, AuthorName, PostDeptId,ReadCount, PostDeptName, PostTime, ExpireTime, SaveTime, [State],'普通' as NewsType from News
                                            union all 
                                            select Id, TypeId, Title, CreateName, PostDeptId,Ext1, PostDeptName, PostTime, ExpireTime, CreateTime, [State],'图片' from ImgNews
                                            union all 
                                            select Id, TypeId, Title, CreateName, PostDeptId,Ext1, PostDeptName, PostTime, ExpireTime, CreateTime, [State],'视频' from VideoNews) t ";

                        this.PageState.Add("SysUserList", GetPageData(sql + " where 1=1 " + where, SearchCriterion));
                    }
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
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "SaveTime";
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

