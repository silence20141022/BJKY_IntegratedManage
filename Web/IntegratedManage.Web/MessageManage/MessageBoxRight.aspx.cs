using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using Aim;
using IntegratedManage.Model;
using Aim.WorkFlow;

namespace IntegratedManage.Web
{
    public partial class MessageBoxRight : IMListPage
    {
        string sql = "";
        string according = "";
        string createId = "";
        string messageType = "";
        string id = "";
        string msgContent = "";
        string receiverId = "";
        IntegratedMessage ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            according = RequestData.Get<string>("According");
            createId = RequestData.Get<string>("CreateId");
            messageType = Server.UrlDecode(RequestData.Get<string>("MessageType"));
            id = RequestData.Get<string>("id");
            msgContent = Server.UrlDecode(RequestData.Get<string>("MessageContent"));
            receiverId = RequestData.Get<string>("ReceiverId");
            if (!string.IsNullOrEmpty(id))
            {
                ent = IntegratedMessage.Find(id);
            }
            switch (RequestActionString)
            {
                case "SignRead":
                    ent.State = "1";
                    ent.DoUpdate();
                    break;
                case "Delete":
                    ent.State = "2";
                    ent.DoUpdate();
                    break;
                case "SendMessage":
                    ent = new IntegratedMessage();
                    ent.ReceiverId = receiverId;
                    ent.ReceiverName = SysUser.Find(receiverId).Name;
                    ent.MessageType = "一般消息";
                    ent.MessageContent = msgContent;
                    ent.SubmitState = "1";
                    ent.DoCreate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (according == "Sender")
            {
                sql = @"select * from BJKY_IntegratedManage..IntegratedMessage 
                where ReceiverId='{0}' and State is null and CreateId='{1}' and SubmitState='1' order by CreateTime desc";
                sql = string.Format(sql, UserInfo.UserID, createId);
            }
            else
            {
                sql = @"select * from BJKY_IntegratedManage..IntegratedMessage 
                where ReceiverId='{0}' and State is null and MessageType='{1}' and SubmitState='1' order by CreateTime desc";
                sql = string.Format(sql, UserInfo.UserID, messageType);
            }
            PageState.Add("DataList", DataHelper.QueryDictList(sql));
        }
    }
}

