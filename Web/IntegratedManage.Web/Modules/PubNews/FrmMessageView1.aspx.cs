using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

using Aim.Common;
using Aim.Portal.Web.UI;
using System.Data.SqlClient;
using System.IO;
using Aim.Portal.Model;
using Aim.Portal.Web;

namespace Aim.IntegratedManage.Web
{
    public partial class FrmMessageView1 : BaseListPage
    {
        #region 变量

        protected string JsonData = "";

        #endregion

        #region 构造函数

        public FrmMessageView1()
        {
            IsCheckLogon = false;
        }

        #endregion;

        #region ASP.NET 事件


        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Request["Id"] != null)
            {
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
                msg.Save();
            }
            //在线预览
            if (RequestActionString == "View")
            {
                string fileName = RequestData["fileName"] + "";
                string type = RequestData["type"] + "";

                string path = "/Document/" + fileName;

                this.PageState.Add("filepath", path);
                this.PageState.Add("type", type);
            }
        }

        #endregion
    }
}
