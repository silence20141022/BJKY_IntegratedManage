using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Common;
using Aim.Portal.Model;

using Aim.Portal.Web.UI;

namespace Aim.Portal.Web.Office
{
    public partial class SysMessageEdit : BasePage
    {
        #region 变量

        string recid = String.Empty;
        string title = String.Empty;
        string op = String.Empty;

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            recid = RequestData.Get<string>("recid");
            title = RequestData.Get<string>("title", String.Empty);
            op = RequestData.Get<string>("op");

            SysMessage msg = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    msg = this.GetMergedData<SysMessage>();
                    if (this.RequestData.Get("issend") != null && this.RequestData.Get<string>("issend") == "T")
                    {
                        msg.State = "1";
                        GenerateReceivers(msg);
                    }
                    msg.SaveAndFlush();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Create:
                    msg = this.GetPostedData<SysMessage>();

                    msg.SenderId = this.UserInfo.UserID;
                    msg.SenderName = this.UserInfo.Name;
                    msg.SendTime = DateTime.Now;

                    if (this.RequestData.Get("issend") != null && this.RequestData.Get<string>("issend") == "T")
                    {
                        msg.State = "1";
                    }
                    msg.CreateAndFlush();
                    if (this.RequestData.Get("issend") != null && this.RequestData.Get<string>("issend") == "T")
                    {
                        GenerateReceivers(msg);
                    }
                    if (recid != null && recid != "")
                    {
                        SysMessageReceive receive = SysMessageReceive.FindAllByProperties("MsgId", recid, "ReceiverId", this.UserInfo.UserID)[0];
                        receive.IsReply = "1";
                        receive.ReplyMsgId = msg.Id;
                        receive.ReplyTime = DateTime.Now;
                        receive.ReplyResult = msg.MessageContent;
                        receive.Save();
                    }
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    msg = this.GetTargetData<SysMessage>();
                    msg.DeleteAndFlush();
                    this.SetMessage("删除成功！");
                    return;
            }

            if (this.Request["Id"] != null)
            {
                msg = SysMessage.Find(this.Request["Id"]);
            }
            else if (op == "c")
            {
                if (!String.IsNullOrEmpty(recid))
                {
                    SysMessage tusr = SysMessage.Find(recid);

                    PageState.Add("ReceiverInfo", "{UserID:'" + tusr.SenderId + "',Name:'" + tusr.SenderName + "'}");
                    PageState.Add("Title", tusr.Title + "[回复]");
                }
            }

            this.SetFormData(msg);
        }

        private void GenerateReceivers(SysMessage msg)
        {
            string[] userIds = msg.ReceiverId.Split(',');
            string[] userNames = msg.ReceiverName.Split(',');
            for (var i = 0; i < userIds.Length; i++)
            {
                if (userIds[i].Trim() == "") continue;
                SysMessageReceive receive = new SysMessageReceive();
                receive.ReceiverId = userIds[i];
                receive.ReceiverName = userNames[i];
                receive.MsgId = msg.Id;
                receive.CreateAndFlush();
            }
        }

        #endregion
    }
}
