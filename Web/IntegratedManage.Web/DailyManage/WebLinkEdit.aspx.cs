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
    public partial class WebLinkEdit : IMListPage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            WebLink ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<WebLink>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    DoCrate();
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<WebLink>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = WebLink.Find(id);
                }
                this.SetFormData(ent);
            }
        }

        //创建多个url
        private void DoCrate()
        {
            // 判断是否系统管理员
            string sql = @"select UserID from SysRole,SysUserRole
                        where SysRole.RoleID=SysUserRole.RoleID and SysRole.Name like '%系统管理员%' and UserID='{0}'";
            sql = string.Format(sql, UserInfo.UserID);
            object obj = DataHelper.QueryValue(sql);
            WebLink ent = this.GetPostedData<WebLink>();
            if (!String.IsNullOrEmpty(ent.Url))
            {
                string[] ArrUrl = ent.Url.Split(new string[] { "\r" }, StringSplitOptions.RemoveEmptyEntries);
                string[] ArrName = ent.WebName.Split(new string[] { "\r" }, StringSplitOptions.RemoveEmptyEntries);
                int point = 0;   //指向下一个Name
                if (ArrUrl.Length > 0)
                {
                    for (int i = 0; i < ArrUrl.Length; i++)
                    {
                        WebLink WL_ent = new WebLink();
                        WL_ent.Url = ArrUrl[i];
                        WL_ent.WebName = ArrName[point];
                        if (obj != null) WL_ent.IsAdmin = "1";   //表示管理员
                        WL_ent.DoCreate();
                        if (i < ArrName.Length - 1) point++;
                    }
                }
                else
                {
                    ent.DoCreate();
                }
            }

        }
    }
}

