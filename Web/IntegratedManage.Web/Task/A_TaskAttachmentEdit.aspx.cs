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
using NHibernate.Criterion;
using IntegratedManage.Web;

namespace Aim.AM.Web
{
    public partial class A_TaskAttachmentEdit : BasePage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            A_TaskAttachment ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<A_TaskAttachment>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<A_TaskAttachment>();
                    ent.CreateId = this.UserInfo.UserID;
                    ent.CreateName = this.UserInfo.Name;
                    ent.CreateTime = DateTime.Now;
                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<A_TaskAttachment>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = A_TaskAttachment.Find(id);
                }
                
                this.SetFormData(ent);
            }
            else
            {
                this.PageState.Add("TaskModel", A_TaskWBS.Find(this.RequestData.Get<string>("TaskId")));
            }
        }

        #endregion
    }
}

