using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using System.Configuration;
using IntegratedManage.Model;
using Aim;

namespace IntegratedManage.Web.MessageManage
{
    public partial class MessageSend : IMBasePage
    {
        string userId = String.Empty;   // 对象id  
        string deptId = string.Empty;
        string op = String.Empty; // 用户编辑操作
        IntegratedMessage ent = null;
        string sql = "";
        string id = "";
        string Action = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            userId = RequestData.Get<string>("UserId");
            id = RequestData.Get<string>("id");
            Action = RequestData.Get<string>("Action");
            deptId = RequestData.Get<string>("DeptId");
            switch (RequestActionString)
            {
                case "ImportFile":
                    string fileIds = RequestData.Get<string>("fileIds");
                    if (!string.IsNullOrEmpty(fileIds))
                    {
                        sql = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0";
                        sql = string.Format(sql, fileIds);
                        PageState.Add("Result", DataHelper.QueryDictList(sql));
                    }
                    break;
                case "AddUser":
                    IList<string> userIds = RequestData.GetList<string>("UserIds");
                    string struserIds = "";
                    for (int i = 0; i < userIds.Count; i++)
                    {
                        struserIds += userIds[i] + ",";
                    }
                    sql = @"select UserId,Name as UserName,(select top 1 GroupName  from BJKY_Examine..PersonConfig where 
                    (PatIndex('%'+UserId+'%',FirstLeaderIds)>0 or PatIndex('%'+UserId+'%',SecondLeaderIds)>0 or PatIndex('%'+UserId+'%',ClerkIds)>0) 
                    and GroupType in ('经营目标单位','职能服务部门')) as DeptName from BJKY_Portal..SysUser where PatIndex('%'+UserId+'%','{0}')>0";
                    sql = string.Format(sql, struserIds);
                    PageState.Add("Users", DataHelper.QueryDictList(sql));
                    break;
                case "update":
                    ent = GetMergedData<IntegratedMessage>();
                    if (Action == "Send")
                    {
                        string[] userIdArray = ent.ReceiverIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        string[] userNameArray = ent.ReceiverNames.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < userIdArray.Length; i++)
                        {
                            IntegratedMessage imEnt = new IntegratedMessage();
                            imEnt.ReceiverId = userIdArray[i];
                            imEnt.ReceiverName = userNameArray[i];
                            imEnt.MessageType = ent.MessageType;
                            imEnt.MessageContent = ent.MessageContent;
                            imEnt.Attachment = ent.Attachment;
                            imEnt.ShortMessage = ent.ShortMessage;
                            imEnt.Mail = ent.Mail;
                            imEnt.SubmitState = "1";
                            imEnt.DoCreate();
                        }
                        ent.DoDelete();
                    }
                    else
                    {
                        ent.DoUpdate();
                    }
                    break;
                case "create":
                    ent = GetPostedData<IntegratedMessage>();
                    ent.DoCreate();
                    if (Action == "Send")
                    {
                        string[] userIdArray = ent.ReceiverIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        string[] userNameArray = ent.ReceiverNames.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < userIdArray.Length; i++)
                        {
                            IntegratedMessage imEnt = new IntegratedMessage();
                            imEnt.ReceiverId = userIdArray[i];
                            imEnt.ReceiverName = userNameArray[i];
                            imEnt.MessageType = ent.MessageType;
                            imEnt.MessageContent = ent.MessageContent;
                            imEnt.Attachment = ent.Attachment;
                            imEnt.ShortMessage = ent.ShortMessage;
                            imEnt.Mail = ent.Mail;
                            imEnt.SubmitState = "1";
                            imEnt.DoCreate();
                        }
                        ent.DoDelete();
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(userId))
            {
                sql = @"select UserId,Name as UserName,
                (select top 1 GroupName from BJKY_Examine..PersonConfig where 
                (PatIndex('%'+UserId+'%',FirstLeaderIds)>0 or PatIndex('%'+UserId+'%',SecondLeaderIds)>0 or PatIndex('%'+UserId+'%',ClerkIds)>0) 
                and GroupType in ('经营目标单位','职能服务部门')) as DeptName from BJKY_Portal..SysUser where UserId='{0}'";
                sql = string.Format(sql, userId);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
            }
            if (!string.IsNullOrEmpty(deptId))
            {
                sql = @"select UserId,Name as UserName,(select top 1 GroupName from BJKY_Examine..PersonConfig where Id='{0}') as DeptName
                from BJKY_Portal..SysUser where PatIndex('%'+UserId+'%', 
                (select top 1 FirstLeaderIds+','+SecondLeaderIds+','+convert(varchar(8000),ClerkIds) from BJKY_Examine..PersonConfig where Id='{0}'))>0";
                sql = string.Format(sql, deptId);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
            }
            if (!string.IsNullOrEmpty(id))// top 1,'{0}' as UserId,
            {
                ent = IntegratedMessage.Find(id);
                SetFormData(ent);
                if (ent.SubmitState == "1")//已发送
                {
                    sql = @"select top 1 GroupName as DeptName,'{0}' as UserId,
                    (select top 1 Name from SysUser where UserId='{0}') as UserName from BJKY_Examine..PersonConfig where 
                    (PatIndex('%{0}%',FirstLeaderIds)>0 or PatIndex('%{0}%',SecondLeaderIds)>0 or PatIndex('%{0}%',ClerkIds)>0) and 
                    GroupType in ('经营目标单位','职能服务部门')";
                    sql = string.Format(sql, ent.ReceiverId);
                    PageState.Add("DataList", DataHelper.QueryDictList(sql));
                }
                else
                {
                    if (!string.IsNullOrEmpty(ent.ReceiverIds))//未发送的消息有可能没有指定接收人 
                    {
                        sql = @"select UserID as UserId ,Name as UserName, 
                        (select top 1 GroupName from BJKY_Examine..PersonConfig
                        where (PatIndex('%'+UserId+'%',FirstLeaderIds)>0 or PatIndex('%'+UserId+'%',SecondLeaderIds)>0 
                        or PatIndex('%'+UserId+'%',ClerkIds)>0) and GroupType in ('经营目标单位','职能服务部门')) as DeptName
                        from SysUser where PatIndex('%'+UserId+'%','{0}')>0";
                        sql = string.Format(sql, ent.ReceiverIds);
                        PageState.Add("DataList", DataHelper.QueryDictList(sql));
                    }
                }
                string sql1 = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0";
                sql1 = string.Format(sql1, ent.Attachment);
                PageState.Add("FileList", DataHelper.QueryDictList(sql1));
            }
            PageState.Add("MessageType", SysEnumeration.GetEnumDict("MessageType"));
        }
    }
}

