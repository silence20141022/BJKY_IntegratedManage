using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Web.UI;
using Aim.Data;
using Castle.ActiveRecord;
using Aim.Portal.Model;
using System.Data;
using Newtonsoft.Json.Linq;

namespace IntegratedManage.Web.MessageManage
{
    public partial class UserTab : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DoSelect();
        }
        private void DoSelect()
        {
            string[] tabs = { "联系人", "部门" };
            PageState.Add("Tabs", tabs);
        }
    }
}
