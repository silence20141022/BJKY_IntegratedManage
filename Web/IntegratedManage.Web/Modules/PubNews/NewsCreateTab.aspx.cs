using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;

namespace Aim.Portal.Web.Modules.PubNews
{
    public partial class NewsCreateTab : BasePage
    {
        public NewsCreateTab()
        {
            this.IsCheckLogon = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> dt = new Dictionary<string, string>();
            dt.Add("0", "停用");
            dt.Add("1", "启用");
            this.PageState.Add("EnumType", dt);
            NewsType[] usr = NewsType.FindAll();
            this.PageState.Add("Types", usr);
        }
    }
}
