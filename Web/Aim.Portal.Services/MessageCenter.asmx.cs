using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Aim.Data;
using System.Data;

namespace Aim.Portal.Services
{
    /// <summary>
    /// MessageCenter 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    [System.Web.Script.Services.ScriptService]
    public class MessageCenter : System.Web.Services.WebService
    {
        [WebMethod]
        public string SendMail(string mailSenderAddress, string mailto, string title, string body)
        {
            try
            {
                string sql = @"INSERT INTO [ServiceDataStore].[dbo].[MailToSend]
           ([Id]
           ,[SenderAddress]
           ,[SendToAddress]
           ,[Title]
           ,[Body]
           ,[SendAccount]
           ,[SendPassword]
           ,[SendServer])
     VALUES
           ('{0}'
           ,'{1}'
           ,'{2}'
           ,'{3}'
           ,'{4}'
           ,'{5}'
           ,'{6}'
           ,'{7}')";
                sql = string.Format(sql, System.Guid.NewGuid().ToString(), mailSenderAddress, mailto, title, body, "", "", "");
                return DataHelper.ExecSql(sql).ToString();
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        [WebMethod]
        public string SendPhoneMessage(string SenderLoginName, string ReceivePhone, string ReceiveContent)
        {
            try
            {
                string insertTemplate = @"INSERT INTO [ServiceDataStore].[dbo].[MessageToSend]
           ([UserId]
           ,[UserName]
           ,[Phone]
           ,[CreateTime]
           ,[MessageContent]
           ,[IP]
           ,[OperateType]
           ,[PersonSign])
     VALUES
           ('{0}'
           ,'{1}'
           ,'{2}'
           ,getdate()
           ,'{3}'
           ,''
           ,'自由模式'
           ,'')";
                string userId = "";
                string userName = "";
                DataTable dt = DataHelper.QueryDataTable("select Id,UserName from BJKY_BeAdmin..OgUser where SystemName='" + SenderLoginName + "'");
                if (dt.Rows.Count > 0)
                {
                    userId = dt.Rows[0]["Id"].ToString();
                    userName = dt.Rows[0]["UserName"].ToString();
                }
                if (userId != "")
                    return DataHelper.ExecSql(string.Format(insertTemplate, userId, userName, ReceivePhone, ReceiveContent)).ToString();
                else
                    return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
