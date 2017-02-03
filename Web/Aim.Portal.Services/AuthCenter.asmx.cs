using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Aim.Common.Service;

namespace Aim.Portal.Services
{
    /// <summary>
    /// AuthCenter 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    // [System.Web.Script.Services.ScriptService]
    public class AuthCenter : System.Web.Services.WebService
    {

        [WebMethod]
        public bool CheckUserOnlineBySessionId(string sessionId)
        {
            return UserSessionService.Server.CheckUserSession(sessionId);
        }
        [WebMethod]
        public string GetLoginNameBySessionId(string sessionId)
        {
            return UserSessionService.Server.GetSession(sessionId).User.LoginName;
        }
        [WebMethod]
        public string GetSessionIdByLoginName(string loginName)
        {
            UserSession session = UserSessionService.Server.GetSessionByLoginName(loginName);
            if (session != null)
                return UserSessionService.Server.GetSessionByLoginName(loginName).SessionID;
            else
                return "";
        }
        [WebMethod]
        public string GetUserDataJson(string sessionId)
        {
            return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
        [WebMethod]
        public string GetAllDeptsDataJson()
        {
            UserSessionService services = new UserSessionService();
            return services.GetSystemDataJson("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getallgroups</parameter></parameters></container>").ToString();
            //return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
        [WebMethod]
        public string GetAllUsersDataJson()
        {
            UserSessionService services = new UserSessionService();
            return services.GetSystemDataJson("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getallusers</parameter></parameters></container>").ToString();
            //return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
        [WebMethod]
        public string GetAllRolesDataJson()
        {
            UserSessionService services = new UserSessionService();
            return services.GetSystemDataJson("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getallroles</parameter></parameters></container>").ToString();
            //return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
        [WebMethod]
        public string GetAllUserDeptRelationDataJson()
        {
            UserSessionService services = new UserSessionService();
            return services.GetSystemDataJson("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getallusergroup</parameter></parameters></container>").ToString();
            //return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
        [WebMethod]
        public string GetAllUserRoleDataJson()
        {
            UserSessionService services = new UserSessionService();
            return services.GetSystemDataJson("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getalluserrole</parameter></parameters></container>").ToString();
            //return JsonHelper.GetJsonString(UserSessionService.Server.GetSession(sessionId).User);
        }
    }
}
