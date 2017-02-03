using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Common;
using Aim.Portal.Model;

using Aim.Portal.Web.UI;
using NHibernate.Criterion;

namespace Aim.Portal.Web.Office
{
    public partial class SysMessageView : BasePage
    {
        #region 变量

        string recid = String.Empty;
        string title = String.Empty;
        string op = String.Empty;
        public string ReplyHTML = "";

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
                        GenerateReceivers(msg);
                    }
                    msg.CreateAndFlush();
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
                try
                {
                    SysMessageReceive receive = SysMessageReceive.FindAllByProperties("MsgId", msg.Id, "ReceiverId", this.UserInfo.UserID)[0];
                    receive.IsFirstView = "1";
                    receive.FirstViewTime = DateTime.Now;
                    receive.Save();
                    if (this.RequestData.Get("isdelete") != null && this.RequestData.Get<string>("isdelete") == "T")
                    {
                        receive.IsDelete = "1";
                        receive.Save();
                    }
                    string template = @"<tr>
                                                <td align='center'>
                                                    <table width='96%' border='1' style='border-collapse: collapse; background-color:Gray;' cellspacing='0' cellpadding='0'>
                                                        <tr>
                                                            <td>
                                                                <font size='2'>回复人:&nbsp; {0}</font>
                                                            </td>
                                                            <td>
                                                                <font size='2'>回复时间:&nbsp; {1}</font>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        </tr>
                                                        <tr>
                                                            <td colspan='2' style='word-wrap: break-word;'>
                                                                <font size='2'>回复内容:&nbsp; {2}</font>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>";
                    SysMessage[] msgs = SysMessage.FindAll(Expression.Sql("Id in (select ReplyMsgId from SysMessageReceive where MsgId='" + msg.Id + "')"));
                    foreach (SysMessage mg in msgs)
                    {
                        ReplyHTML += string.Format(template, mg.SenderName, mg.SendTime, mg.MessageContent);
                    }
                }
                catch { }
            }
            else if (op == "c")
            {
                if (!String.IsNullOrEmpty(recid))
                {
                    SysUser tusr = SysUser.Find(recid);

                    PageState.Add("ReceiverInfo", tusr);
                    PageState.Add("Title", title);
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
