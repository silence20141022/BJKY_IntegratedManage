using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal;

namespace IntegratedManage.Web
{
    public class ExecData : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            if (context.Request["opera"] == "batchcollection")
            {
                string Id = context.Request["id"];
                if (!string.IsNullOrEmpty(Id))
                {
                    //收藏
                    try
                    {
                        //object[] pram = { new SqlParameter("MsgId", RequestData["Id"]), new SqlParameter("UserId", UserInfo.UserID) };
                        CollectionToUser[] Ctus = CollectionToUser.FindAll("from CollectionToUser where MsgId='" + Id + "' and UserId='" + UserInfo.UserID + "'");
                        if (Ctus.Length == 0)
                        {
                            CollectionToUser Ctu = new CollectionToUser();
                            Ctu.MsgId = Id + "";
                            Ctu.UserId = UserInfo.UserID;
                            Ctu.CreateId = UserInfo.UserID;
                            Ctu.CreateName = UserInfo.Name;

                            Ctu.DoSave();
                            context.Response.Write("已收藏");
                        }
                        else
                        {
                            CollectionToUser.DoBatchDelete(Ctus[0].Id);
                            context.Response.Write("已取消收藏");
                        }
                    }
                    catch (Exception ex)
                    {
                        context.Response.Write(ex.Message);
                    }
                }
            }
            else if (context.Request["opera"] == "readstate")
            {
                string Id = context.Request["id"];
                if (!string.IsNullOrEmpty(Id))
                {
                    try
                    {
                        ImgNews news = ImgNews.TryFind(Id);
                        if (news != null)
                        {
                            if ((news.Ext2 + "").Contains(UserInfo.UserID))
                            {
                                return;
                            }
                            news.Ext2 += UserInfo.UserID;
                            news.DoUpdate();
                            context.Response.Write("标记成功！");
                        }
                    }
                    catch (Exception ex)
                    {
                        context.Response.Write(ex.Message);
                    }
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
