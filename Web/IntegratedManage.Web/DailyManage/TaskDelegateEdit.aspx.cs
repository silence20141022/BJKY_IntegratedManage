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
using IntegratedManage.Model;

namespace IntegratedManage.Web
{
    public partial class TaskDelegateEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型  
        TaskDelegate ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<TaskDelegate>();
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = GetPostedData<TaskDelegate>();
                    ent.State = "1";
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
                if (!String.IsNullOrEmpty(id))
                {
                    ent = TaskDelegate.Find(id);
                }
            }
            else
            {
                ent = new TaskDelegate();
                ent.CreateName = UserInfo.Name;
                ent.CreateId = UserInfo.UserID;
                ent.StartTime = System.DateTime.Now;
            }
            SetFormData(ent);
        }
    }
}

