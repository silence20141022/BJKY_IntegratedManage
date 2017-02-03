using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal.Web.UI;
using Aim.Utilities;
using System.Data.SqlClient;
using System.Configuration;
using Aim.Portal.Model;
using Aim;
using IntegratedManage.Model;
namespace IntegratedManage.Web.DocumentManage
{
    public partial class ReleaseTemplateSelect : IMBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PageState.Add("DataList", ReleaseTemplate.FindAll(SearchCriterion));
        }
    }
}


