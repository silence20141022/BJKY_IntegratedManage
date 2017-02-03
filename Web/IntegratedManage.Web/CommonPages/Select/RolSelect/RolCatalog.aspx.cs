using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;
using Aim.Data;
using Aim.Common;
using IntegratedManage.Web;
using Aim.Portal.Model;

namespace Aim.Portal.Web.CommonPages
{
    public partial class RolCatalog : IMBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SysRoleType[] roleTypes = SysRoleTypeRule.FindAll();
            this.PageState.Add("DtList", roleTypes);
        }
    }
}
