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
using Aim.WorkFlow;

namespace IntegratedManage.Web
{
    public partial class DailyDownLoad : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        MyShortCut ent = null;
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            string AuthIds = RequestData.Get<string>("AuthIds");

            switch (RequestActionString)
            {
                default:
                    break;
            }
        }
    }
}

