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
    public partial class DocumentEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        ReleaseDocument ent = null;
        string nextName = "";
        string taskName = "";
        string LinkView = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            LinkView = RequestData.Get<string>("LinkView");
            nextName = RequestData.Get<string>("nextName");
            taskName = RequestData.Get<string>("taskName");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ReleaseDocument.Find(id);
            }
            switch (RequestActionString)
            {
                case "UpdateReleaseContent":
                    ent.ReleaseContent = RequestData.Get<string>("ReleaseContent");
                    ent.DoUpdate();
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
                ent = ReleaseDocument.Find(id);
                SetFormData(ent);
            }
        }
    }
}

