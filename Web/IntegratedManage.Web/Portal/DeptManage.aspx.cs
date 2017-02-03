using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
namespace IntegratedManage.Web.Portal
{
    public partial class DeptManage : BasePage
    {
        public string Html = "";
        public string LayoutXML = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = this.UserInfo.UserID;
            Html = WebPartRule.GetBlocks(userId, this.UserInfo.LoginName, ref LayoutXML, this.Request["BlockType"], this.Request["TemplateId"], this.Request["IsManage"]);
        }
    }
}
