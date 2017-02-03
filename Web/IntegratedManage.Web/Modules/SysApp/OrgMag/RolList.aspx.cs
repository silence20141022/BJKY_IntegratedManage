using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using Castle.ActiveRecord;


namespace Aim.Portal.Web.Modules.SysApp.OrgMag
{
    public partial class RolList : BaseListPage
    {
        #region 属性

        #endregion

        #region 变量

        private SysRole[] ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsAsyncRequest)
            {
                SearchCriterion.SetOrder("CreateDate");
                SearchCriterion.SetOrder("SortIndex");
                ents = SysRoleRule.FindAll(SearchCriterion);

                this.PageState.Add("RoleList", ents);
            }

            SysRole ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<SysRole>();
                    ent.SaveAndFlush();
                    this.SetMessage("保存成功！");
                    break;
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<SysRole>();
                    ent.CreateAndFlush();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<SysRole>();
                    ent.DeleteAndFlush();
                    this.SetMessage("删除成功！");
                    break;
                case RequestActionEnum.Custom:
                    if (RequestActionString == "refreshsys")
                    {
                        PortalService.RefreshSysModules();
                        SetMessage("操作成功！");
                    }
                    else if (RequestActionString == "getusers")
                    {
                        string uids = "";
                        string names = "";
                        using (new SessionScope())
                        {
                            ent = SysRole.Find(this.RequestData.Get<string>("id"));
                            if (ent.User.Count > 0)
                            {
                                SysUser[] usrs = ent.User.ToArray();
                                foreach (SysUser usr in usrs)
                                {
                                    uids += usr.UserID + ",";
                                    names += usr.Name + ",";
                                }
                            }
                        }
                        uids = uids.TrimEnd(',');
                        names = names.TrimEnd(',');
                        this.PageState.Add("UserId", uids);
                        this.PageState.Add("UserName", names);
                    }
                    else if (RequestActionString == "setusers")
                    {
                        string roleId = this.RequestData.Get<string>("id");
                        string userIds = this.RequestData.Get<string>("userids");
                        DataHelper.ExecSql("delete from SysUserRole where RoleId='" + roleId + "'");
                        string insertTpl = "insert into SysUserRole values ('{0}','" + roleId + "')";
                        string sql = "";
                        string[] users = userIds.Split(',');
                        foreach (string user in users)
                        {
                            if (user != "")
                                sql += string.Format(insertTpl, user);
                        }
                        if (sql.Trim() != "")
                            DataHelper.ExecSql(sql);
                    }
                    break;
            }

            SysRoleType[] roleTypes = SysRoleTypeRule.FindAll();
            this.PageState.Add("RoleTypeList", roleTypes);
        }

        #endregion

        #region 私有方法

        #endregion
    }
}
