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
using Aim;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;

namespace IntegratedManage.Web
{
    public partial class EnterpriseAddrBookEdit : IMListPage
    {


        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            EnterpriseAddrBook ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<EnterpriseAddrBook>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<EnterpriseAddrBook>();

                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<EnterpriseAddrBook>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = EnterpriseAddrBook.Find(id);
                }
                
                this.SetFormData(ent);
            }
        }


    }
}

