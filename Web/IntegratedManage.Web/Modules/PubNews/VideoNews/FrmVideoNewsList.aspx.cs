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
    public partial class FrmVideoNewsList : BaseListPage
    {
        private VideoNews[] ents = null;
        string op = String.Empty;
        string typeId = String.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
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
                    //启动流程
                    if (this.RequestActionString.ToLower() == "startflow")
                    {
                        VideoNews ne = VideoNews.Find(this.RequestData["Id"].ToString());
                        //启动流程
                        string key = "NewsPub";
                        //表单路径,后面加上参数传入
                        string formUrl = "/Modules/PubNews/NewsEdit.aspx?op=u&&Id=" + ne.Id;
                        Aim.WorkFlow.WorkFlow.StartWorkFlow(ne.Id, formUrl, ne.Title, key, this.UserInfo.UserID, this.UserInfo.Name);
                        PageState.Add("message", "启动成功");
                        return;
                    }
                    else if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (this.RequestActionString.ToLower() == "submitnews")
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
                        return;
                    }
                    break;
                default:
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
                    ents = VideoNews.FindAll(SearchCriterion, Expression.Sql(" (State='1' or State='2') " + where)).OrderByDescending(o => o.CreateTime).ToArray();

                    this.PageState.Add("DataList", ents);
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

