using System;
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
using Aim.Examining.Web;
using IntegratedManage.Web;

namespace Aim.Portal.Web.EPC
{
    public partial class RoleSelect : IMBasePage
    {
               private SysRole[] ents = null;  

        public RoleSelect()
        {
            IsCheckLogon = false;
        }  
        protected void Page_Load(object sender, EventArgs e)
        {
            ents = SysRole.FindAll(SearchCriterion);

            this.PageState.Add("DtList", ents);

            //if (!IsAsyncRequest)
            //{
            //    this.PageState.Add("CatalogEnum", SysRole.GetCatalogDict());

            //    this.PageState.Add("DataEnum", SysEnumeration.GetEnumDicts("EPC.Supplier.OpProperty", "EPC.Supplier.Qualification", "EPC.Supplier.QualificationGrade"));
            //}
        } 
    }
}
