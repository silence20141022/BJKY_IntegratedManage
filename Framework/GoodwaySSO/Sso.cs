using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GoodwaySSO
{
    public class Sso
    {

        private static GWSSO.UserStateServiceSoapClient _Singleton;

        public static GWSSO.UserStateServiceSoapClient Singletion
        {
            get
            {
                if (_Singleton == null)
                {
                    _Singleton = new GWSSO.UserStateServiceSoapClient();
                }
                return _Singleton;
            }
        }
        public static string LoginGW(string formMessage,string userId, string UserName)
        {
            return Singletion.CreateUserStateEx(formMessage, "127.0.0.1", "", userId, UserName, "PC.IE");
        }
        public static bool CheckSSOLogin(string passCode)
        {
            if (Singletion.CheckUserState(passCode))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
