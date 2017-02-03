using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Aim.Portal.Model;
using Aim.Data;
namespace Aim.Portal.Web
{
    public partial class Login : System.Web.UI.Page
    {
        private bool asyncreq = false;

        protected string PrjName = String.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            asyncreq = ObjectHelper.ConvertValue<bool>(Request["asyncreq"], false);
            if (Request["reqaction"] == "login")
            {
                DoLogin();
            }
            else if (Request["reqaction"] == "getuser")
            {
                string usbguid = this.Request.QueryString["usbguid"];
                if (SysUser.FindAllByProperties(SysUser.Prop_Server_IAGUID, usbguid).Length > 0)
                {
                    SysUser user = SysUser.FindAllByProperties(SysUser.Prop_Server_IAGUID, usbguid)[0];
                    Response.Write(user.LoginName);
                    Response.End();
                }
                else
                {
                    Response.Write("");
                    Response.End();
                }
            }
            else if (Request["reqaction"] == "checkneedkey")
            {
                string loginName = this.Request.QueryString["loginname"];
                string keyId = this.Request.QueryString["usbkey"];
                if (SysUser.FindAllByProperties(SysUser.Prop_LoginName, loginName).Length > 0)
                {
                    if (SysUser.FindAllByProperties(SysUser.Prop_LoginName, loginName)[0].Server_IAGUID != null && SysUser.FindAllByProperties(SysUser.Prop_LoginName, loginName)[0].Server_IAGUID.Trim() != "")
                    {
                        Response.Write(SysUser.FindAllByProperties(SysUser.Prop_LoginName, loginName)[0].Server_IAGUID);
                    }
                    else
                        Response.Write("false");
                }
                else
                {
                    Response.Write("false");
                }
                Response.End();
            }
            else
            {
                string gwPassCode = Request["gwpasscode"];
                string workNo = Request["workno"];
                if (!String.IsNullOrEmpty(gwPassCode) && !String.IsNullOrEmpty(workNo))
                {
                    DoLoginByGwPassCodeAndWorkNo(gwPassCode, workNo);
                }
            }
        }
        private void DoLoginByGwPassCodeAndWorkNo(string passcode, string workno)
        {
            bool stateflag = true;
            if (stateflag)
            {
                SysUser usr = SysUser.FindFirstByProperties("WorkNo", workno);
                LoginUser(usr.LoginName, usr.Password, true);
            }
        }
        private void DoLogin()
        {
            string uname = Request["uname"];
            string pwd = Request["pwd"];
            if (!String.IsNullOrEmpty(uname))
            {
                LoginUser(uname, pwd, false);
            }
            else
            {
                Response.Write("请输入用户名！");
                Response.End();
            }
        }

        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="uname"></param>
        /// <param name="pwd"></param>
        private void LoginUser(string uname, string pwd, bool pwdEncrypted)
        {
            try
            {
                if (DataHelper.QueryValue<int>("select count(UserId) from SysUser where Status=1 and  LoginName='" + uname + "'") > 0)
                {
                    if (DataHelper.QueryValue("select password from SysUser where LoginName='" + uname + "'") + "" == "")
                    {
                        Response.Write("请先设置密码再登陆！");
                    }
                    else
                    {
                        string sid = PortalService.AuthUser(uname, pwd, pwdEncrypted);
                        if (!String.IsNullOrEmpty(sid))
                        {
                            string url = FormsAuthentication.GetRedirectUrl(uname, true);
                            if (asyncreq)
                            {
                                Response.Write(String.Format("success,{0}", url));
                            }
                            else
                            {
                                Response.Redirect(url);
                            }
                        }
                        else
                        {
                            Response.Write("登陆失败，用户名或密码不正确！");
                        }
                    }
                }
                else
                {
                    Response.Write("用户名不存在！");
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
                Response.End();
            }
            Response.End();
        }
    }
}
