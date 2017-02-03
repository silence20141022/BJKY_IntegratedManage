using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Common;
using Aim.Portal;
using Aim.Portal.Web;
using Aim.Portal.Model;
using Aim.Portal.Web.UI;
using Aim.Data;
using System.Configuration;
using IntegratedManage.Web;
using System.Data;
using System.Data.SqlClient;
using Aim;

namespace IntegratedManage.Web
{
    public partial class Default : IMBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (RequestActionString)
            {
                case "unreadmessage":
                    GetUserTasks();
                    try
                    {
                        GoodwaySSO.Sso.Singletion.RefreshUserState(Session["PassCode"].ToString());
                    }
                    catch { }
                    break;
                default: if (Request.QueryString["tag"] != null && Request.QueryString["tag"] == "Refresh")
                    {
                        Response.Write("");
                        Response.End();
                    }
                    if (Session["PassCode"] == null)
                    {
                        SqlDataAdapter sda = new SqlDataAdapter("select Id,WorkNo,UserName,SystemName from OgUser where SystemName='" + this.UserInfo.LoginName + "' ", System.Configuration.ConfigurationManager.ConnectionStrings["BJKY_BeAdmin"].ConnectionString);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            string template = "<Form Name='" + row["Id"] + "'><Id>" + row["Id"] + "</Id><WorkNo>" + row["WorkNo"] + "</WorkNo><UserName>" + row["UserName"] + "</UserName><SystemName>" + row["SystemName"] + "</SystemName><Password></Password><Field></Field></Form>";
                            string passCode = "";
                            try
                            {
                                passCode = GoodwaySSO.Sso.LoginGW(template, row["Id"].ToString(), row["UserName"].ToString());
                            }
                            catch { }
                            this.PageState.Add("PassCode", passCode);
                            Session["PassCode"] = passCode;
                        }
                        else
                            Session["PassCode"] = "";
                    }
                    IEnumerable<SysModule> topAuthExamMdls = new List<SysModule>();
                    if (UserContext.AccessibleApplications.Count > 0)
                    {
                        SysApplication examApp = UserContext.AccessibleApplications.FirstOrDefault(tent => tent.Code == EXAMINING_APP_CODE);

                        if (examApp != null && UserContext.AccessibleModules.Count > 0)
                        {
                            topAuthExamMdls = UserContext.AccessibleModules.Where(tent => tent.ApplicationID == examApp.ApplicationID && String.IsNullOrEmpty(tent.ParentID));
                            topAuthExamMdls = topAuthExamMdls.OrderBy(tent => tent.SortIndex);
                        }
                    }
                    DataTable dtps = DataHelper.QueryDataTable("select distinct DeptId,DeptName from WebPart where isnull(DeptId,'')<>''");
                    List<EasyDictionary> ess = new List<EasyDictionary>();
                    foreach (DataRow row in dtps.Rows)
                    {
                        try
                        {
                            string[] deptIds = row["DeptId"].ToString().Split(',');
                            string[] deptNames = row["DeptName"].ToString().Split(',');
                            for (var i = 0; i < deptIds.Length; i++)
                            {
                                EasyDictionary es = new EasyDictionary();
                                es.Add("DeptId", deptIds[i]);
                                es.Add("DeptName", deptNames[i]);
                                if (!ess.Exists(ens => ens.Get("DeptId").ToString() == deptIds[i]))
                                    ess.Add(es);
                            }
                        }
                        catch { continue; }
                    }
                    this.PageState.Add("Depts", ess);
                    this.PageState.Add("Modules", topAuthExamMdls);
                    GetUserTasks();
                    break;
            }
            //string IsPrompt = "False";
            //IList<EasyDictionary> dicAssConfig = DataHelper.QueryDictList("select * from " + db + "..P_AssConfig where CloseState='1'");
            //if (dicAssConfig.Count > 0)
            //{
            //    string assConfigId = dicAssConfig[0].Get<String>("Id");
            //    IList<EasyDictionary> dicList = DataHelper.QueryDictList("select * from " + db + "..P_StageSubmitUser where UserId='" + WebPortalService.CurrentUserInfo.UserID + "'  and P_AssConfigId='" + assConfigId + "'");
            //    if (dicList.Count == 0)
            //    {
            //        IsPrompt = "True";
            //    }
            //}
            //this.PageState.Add("Prompt", IsPrompt);
        }
        private void GetUserTasks()
        {
            string sql = @"select Count(Id) from View_SysMessage where ReceiveId ='{0}' and IsFirstView is null";
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("NewMessage", DataHelper.QueryValue<int>(sql));
            sql = @"select Count(Id) from (
select Id from Task where status=0 and OwnerId='{0}' 
union
select Id  from BJKY_BeAdmin..WfWorkList where (State='New') and IsSign='{0}'  )a ";
            sql = string.Format(sql, this.UserInfo.UserID);
            PageState.Add("NewTask", DataHelper.QueryValue<int>(sql));
        }
        protected void lnkRelogin_Click(object sender, EventArgs e)
        {
            try
            {
                GoodwaySSO.Sso.Singletion.LogoutUserStateEx(Session["PassCode"].ToString(), "PC.IE");
            }
            catch { }
            WebPortalService.LogoutAndRedirect();
        }
        protected void lnkGoodway_Click(object sender, EventArgs e)
        {
            // string passcode = GwIntegrateService.GetGwPasscode();
            string passcode = String.Empty;
            string gwPortalUrl = ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"];
            gwPortalUrl = String.Format(gwPortalUrl + "?PassCode={0}", passcode);
            Response.Redirect(gwPortalUrl);
        }
        protected void lnkExit_Click(object sender, EventArgs e)
        {
            WebPortalService.Exit();
        }
    }
}
