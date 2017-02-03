using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using Aim.Portal.Web;
using System.Web.Services;
using Aim.Portal;

namespace IntegratedManage.Web
{
    public partial class FrmImageNews1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Id = Request.QueryString["id"];
                ImgNews news = ImgNews.TryFind(Id);
                if (news == null)
                    return;

                if (news.State == "2")
                {
                    news.Ext1 = news.Ext1 == null ? "1" : (Convert.ToInt32(news.Ext1) + 1) + "";
                    news.DoUpdate();
                }

                if (news != null)
                {
                    this.lbltitle.InnerText = news.Title;
                    this.lblPostDeptName.InnerText = news.PostDeptName;
                    this.lblAuthorName.InnerText = news.CreateName;
                    this.lblPostTime.InnerText = news.PostTime != null ? news.PostTime.ToString() : "";
                    this.lblReadCount.InnerText = news.Ext1;

                    if ((news.Ext2 + "").Contains(UserInfo.UserID))
                    {
                        lblreadstate.Attributes.Add("style", "display:none");
                    }

                    ImgNewDetail[] imgdetails = ImgNewDetail.FindAllByProperty("PId", news.Id);
                    int index = 0;
                    foreach (ImgNewDetail ent in imgdetails)
                    {
                        litimg.Text += "<img src='/Document/" + ent.ImgPath + "' width='780' height='570'/>";
                        litcontent.Text += "<p id='p" + index + "' style='margin-top:20px;'>" + ent.Content + "</p>";
                        litimgs.Text += "<li><img src='/Document/" + ent.ImgPath + "'/><tt></tt></li>";
                        index++;
                    }

                    CollectionToUser[] cts = CollectionToUser.FindAllByProperties("MsgId", news.Id, "UserId", UserInfo.UserID);
                    hidcollection.Value = cts.Length > 0 ? "on" : "off";
                }
            }
        }

        /// <summary>
        /// 当前用户信息
        /// </summary>
        public Aim.Common.UserInfo UserInfo
        {
            get
            {
                return PortalService.CurrentUserInfo;
            }
        }
    }
}
