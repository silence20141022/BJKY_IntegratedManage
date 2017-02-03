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
using System.IO;

namespace IntegratedManage.Web
{
    public partial class ReleaseTemplateEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        ReleaseTemplate ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<ReleaseTemplate>();
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = GetPostedData<ReleaseTemplate>();
                    ent.DoCreate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (op != "c" && op != "cs")
            {
                ent = ReleaseTemplate.Find(id);
                SetFormData(ent);
            }
            PageState.Add("FileName", ent == null || string.IsNullOrEmpty(ent.TemplateContent) ? "Empty.doc" : ent.TemplateContent);
        }
    }
}

