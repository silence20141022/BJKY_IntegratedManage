using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
namespace IntegratedManage.Web
{
    public partial class Home_bak : BasePage
    {
        public string Html = "";
        public string LayoutXML = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = this.UserInfo.UserID;
            if (this.Request["DeptId"] == null && this.Request["IsDeptManage"] == "T")
            {
                string deptId = "select DeptId from V_FactDept where UserId='" + this.UserInfo.UserID + "'";
                deptId = DataHelper.QueryValue<string>(deptId);
                if (deptId == null)
                {
                    Response.Write("没有获取到用户的所在部门信息!");
                    Response.End(); 
                }
                else
                {
                    if (DataHelper.QueryValue("select Id from dbo.WebPartTemplate where BlockType='DeptPortal' and BaseTemplateId='" + deptId + "'") == null)
                    {
                        Response.Write("部门门户尚未开启,请联系管理员开启部门门户!");
                        Response.End();
                        //throw new Exception("");
                    }
                    Response.Redirect("/Home.aspx?&Redirect=T&IsManage=T&BlockType=DeptPortal&DeptId=" + deptId);
                }
            }
            Html = WebPartRule.GetBlocks(userId, this.UserInfo.LoginName, ref LayoutXML, this.Request["BlockType"], this.Request["TemplateId"], this.Request["IsManage"]);
        }
    }
}
