using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;


namespace IntegratedManage.Web
{
    public partial class NotepadEdit : IMListPage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            NotePad ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<NotePad>();
                    ent.DoUpdate();
                    this.PageState.Add("Id", ent.Id);
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<NotePad>();
                    ent.UserId = UserInfo.UserID;
                    ent.UserName = UserInfo.Name;
                    ent.DoCreate();
                    this.PageState.Add("Id", ent.Id);
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<NotePad>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
                default:
                    if (RequestActionString == "delete")
                    {
                        if (!string.IsNullOrEmpty(id))
                        {
                            ent = NotePad.Find(id);
                            ent.DoDelete();
                        }
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = NotePad.Find(id);
                }

                this.SetFormData(ent);
            }
        }
    }
}
