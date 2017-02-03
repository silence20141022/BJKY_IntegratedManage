using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;

namespace Aim.Portal.Web
{
    /// <summary>
    /// InformView 的摘要说明。
    /// </summary>
    public class FrmMessageView : BaseListPage
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
            if (this.Request["Id"] != null)
            {
                if (this.Request["Id"].Length == 8)
                {
                    var _link = Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("/portal/Portal.aspx", "");
                    _link += "/officeauto/PubInfo/InformView.aspx?FuncType=View&Id=" + this.Request["Id"] + "&PassCode=" + Session["PassCode"];
                    Response.Redirect(_link);
                }
                News msg = News.Find(this.Request["Id"]);
                if (msg.State == "2")
                {
                    msg.ReadCount = msg.ReadCount == null ? 1 : msg.ReadCount.Value + 1;
                    msg.Save();
                }

                if (msg.PostTime != null && msg.PostTime.HasValue)
                {
                    msg.CreateName = ((DateTime)msg.PostTime).ToString("yyyy-MM-dd HH:mm");
                }
                CollectionToUser[] cts = CollectionToUser.FindAllByProperties("MsgId", msg.Id, "UserId", UserInfo.UserID);
                PageState.Add("collection", cts.Length > 0 ? "on" : "off");
                this.SetFormData(msg);
            }

            if (RequestActionString == "batchcollection")
            {
                //收藏
                try
                {
                    //object[] pram = { new SqlParameter("MsgId", RequestData["Id"]), new SqlParameter("UserId", UserInfo.UserID) };
                    CollectionToUser[] Ctus = CollectionToUser.FindAll("from CollectionToUser where MsgId='" + RequestData["Id"] + "' and UserId='" + UserInfo.UserID + "'");
                    if (Ctus.Length == 0)
                    {
                        CollectionToUser Ctu = new CollectionToUser();
                        Ctu.MsgId = RequestData["Id"] + "";
                        Ctu.UserId = UserInfo.UserID;
                        Ctu.CreateId = UserInfo.UserID + "";
                        Ctu.CreateName = UserInfo.Name + "";

                        Ctu.DoSave();
                        this.PageState.Add("result", "已收藏");
                    }
                    else
                    {
                        CollectionToUser.DoBatchDelete(Ctus[0].Id);
                        this.PageState.Add("result", "已取消收藏");
                    }
                }
                catch (Exception ex)
                {
                    this.PageState.Add("result", ex.Message);
                }
            }
            else if (RequestActionString == "readstate")
            {
                News msg = News.Find(this.RequestData["Id"]);

                //添加阅读状态
                msg.ReadState = (msg.ReadState + "").Contains(UserInfo.UserID) ? msg.ReadState : msg.ReadState + UserInfo.UserID + ",";
                msg.DoUpdate();
            }
        }
    }
}
