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
using Aim;
using IntegratedManage.Model;
using Aim.WorkFlow;
using System.Data;
using System.Configuration;

namespace IntegratedManage.Web.DailyManage
{
    public partial class WebLink : IMListPage
    {
        private IList<IntegratedManage.Model.WebLink> ents = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            IntegratedManage.Model.WebLink ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<IntegratedManage.Model.WebLink>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        private void DoSelect()
        {
            // 判断是否院务部的人员
            string sql = @"select UserID from SysRole,SysUserRole
                         where SysRole.RoleID=SysUserRole.RoleID and SysRole.Name like '%系统管理员%' and UserID='{0}'";
            sql = string.Format(sql, UserInfo.UserID);
            object obj = DataHelper.QueryValue(sql);
            if (obj != null)
            {
                ents = IntegratedManage.Model.WebLink.FindAll(SearchCriterion);
                this.PageState.Add("WebLinkList", ents);
            }
            else
            {
                ents = Model.WebLink.FindAll(SearchCriterion, Expression.Sql("CreateId = '" + UserInfo.UserID + "' or IsAdmin like '%1%' "));
                this.PageState.Add("WebLinkList", ents);
            }
        }

        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                IntegratedManage.Model.WebLink.DoBatchDelete(idList.ToArray());
            }
        }
    }
}
