using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;

namespace IntegratedManage.Web
{
    public class NoticeView : BaseListPage
    {
        string id = "";
        News msg = null;
        private void Page_Load(object sender, System.EventArgs e)
        {
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                msg = News.Find(id);
            }
            switch (RequestActionString)
            {
                case "batchcollection":
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
                    break;
                case "readstate":
                    //标记为已阅状态
                    if (!string.IsNullOrEmpty(msg.ReadState))
                    {
                        msg.ReadState += "," + UserInfo.UserID;
                    }
                    else
                    {
                        msg.ReadState = UserInfo.UserID;
                    }
                    msg.DoUpdate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
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
            SetFormData(msg);
            PageState.Add("ReadStatus", (msg.ReadState + "").IndexOf(UserInfo.UserID));

        }
    }
}
