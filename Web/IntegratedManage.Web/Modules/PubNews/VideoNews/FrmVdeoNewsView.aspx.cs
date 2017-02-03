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
    public partial class FrmVdeoNewsView : BaseListPage
    {
        public string Url = "";
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (this.Request["Id"] != null)
            {
                VideoNews msg = VideoNews.Find(this.Request["Id"]);
                if (msg != null)
                {
                    if (msg.State == "2")
                    {
                        msg.Ext1 = msg.Ext1 == null ? "1" : (Convert.ToInt32(msg.Ext1) + 1) + "";
                        msg.Save();
                    }

                    if (msg.PostTime != null && msg.PostTime.HasValue)
                    {
                        msg.CreateName = ((DateTime)msg.PostTime).ToString("yyyy-MM-dd HH:mm");
                    }
                    CollectionToUser[] cts = CollectionToUser.FindAllByProperties("MsgId", msg.Id, "UserId", UserInfo.UserID);
                    PageState.Add("collection", cts.Length > 0 ? "on" : "off");
                    this.SetFormData(msg);

                    VideoNewDetail[] imgdetails = VideoNewDetail.FindAllByProperty("PId", msg.Id);
                    if (imgdetails.Length > 0)
                    {
                        Url = imgdetails[0].ImgPath.TrimEnd(',');
                        for (int i = 0; i < imgdetails.Length; i++)
                        {
                            litcontent.Text += "<p id='p" + i + "' style='margin-top: 20px;' tag='" + imgdetails[i].ImgPath + "'>" + imgdetails[i].Content + "</p>";
                            litimgs.Text += "<li><img src='" + imgdetails[i].Ext1 + "' /><tt></tt></li>";
                        }
                    }
                }
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
                VideoNews msg = VideoNews.Find(this.RequestData["Id"]);

                //添加阅读状态
                msg.Ext2 = (msg.Ext2 + "").Contains(UserInfo.UserID) ? msg.Ext2 : msg.Ext2 + UserInfo.UserID + ",";
                msg.DoUpdate();
            }
        }
    }
}
