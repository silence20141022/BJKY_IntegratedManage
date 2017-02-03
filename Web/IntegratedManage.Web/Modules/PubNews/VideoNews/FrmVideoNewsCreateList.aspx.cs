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

namespace Aim.Portal.Web
{
    public partial class FrmVideoNewsCreateList : BaseListPage
    {
        private VideoNews[] ents = null;

        string op = String.Empty;
        string typeId = String.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            string link = RequestData.Get<string>("link");
            typeId = RequestData.Get<string>("TypeId", String.Empty);

            VideoNews ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<VideoNews>();
                    ent.Delete();
                    this.SetMessage("删除成功！");
                    break;
                case RequestActionEnum.Custom:
                    if (this.RequestActionString.ToLower() == "submitnews")
                    {
                        VideoNews ne = VideoNews.Find(this.RequestData["Id"].ToString());
                        ne.State = this.RequestData["state"].ToString();
                        ne.Save();
                        if (this.RequestData["state"].ToString() == "1")
                            PageState.Add("message", "提交成功");
                        else
                            PageState.Add("message", "收回成功");
                        return;
                    }
                    else if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    break;
                default:
                    //查看更多
                    if (link == "home")
                    {
                        string path = DataHelper.QueryValue("select g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId where UserId='" + UserInfo.UserID + "'") + "";
                        string sql = @"select n.* from VideoNews n 
                                    inner join NewsType nt on nt.Id=n.TypeId
                                    where TypeId='{2}' 
                                    and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                                    and (charindex('{0}',n.CreateId)>0 or charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                                    exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,'{1}')>0)
                                    or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,'{1}')>0))";
                        sql = string.Format(sql, UserInfo.UserID, path, typeId);
                        PageState.Add("DataList", GetPageData(sql, SearchCriterion));
                    }
                    else
                    {
                        string where = " and isnull(ExpireTime,'2099-01-01')>=getdate() ";
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
                        SearchCriterion.SetSearch("TypeId", typeId);
                        ents = VideoNews.FindAll(SearchCriterion, Expression.Sql(" CreateId = '" + UserInfo.UserID + "' " + where)).OrderByDescending(o => o.CreateTime).ToArray();

                        this.PageState.Add("DataList", ents);
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

        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                foreach (object obj in idList)
                {
                    ImgNewDetail.DeleteAll(" PId='" + obj + "' ");
                }
                VideoNews.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

