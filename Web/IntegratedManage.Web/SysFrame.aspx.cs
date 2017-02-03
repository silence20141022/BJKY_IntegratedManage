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
using System.Collections;
using NHibernate.Criterion;
using Aim;
using System.Data.SqlClient;
using System.Data;
using Aim.Data;
using System.Configuration;
using Aim.Portal.Services;

namespace IntegratedManage.Web
{
    public partial class SysFrame : IMBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (RequestActionString)
            {
                case "logout":
                    WebPortalService.Logout();
                    break;
                default:
                    if (Request.QueryString["tag"] != null && Request.QueryString["tag"] == "Refresh")
                    {
                        try
                        {
                            GoodwaySSO.Sso.Singletion.RefreshUserState(Session["PassCode"].ToString());
                        }
                        catch { }
                        //在线人数
                        int urcts = 0;
                        Aim.Portal.ServicesProvider.WebPortalServiceProvider ws = (Aim.Portal.ServicesProvider.WebPortalServiceProvider)WebPortalService.GetDefaultProvider();
                        urcts = Aim.Common.ServiceHelper.DeserializeFromBytes<SysUser[]>(ws.USService.GetSystemData("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getonlineusers</parameter></parameters></container>")).Length;
                        Response.Write(urcts);
                        Response.End();
                    }
                    //string connStr = ConfigurationManager.AppSettings["BJKY_Examine"].ToString();
                    //SqlConnection conn = new SqlConnection(connStr);
                    //string sql = "select Id from BJKY_Examine..PersonConfig where ClerkIds like '%" + UserInfo.UserID + "%' and GroupType <>'系统部门'";//判定登陆人是不是员工
                    //SqlCommand com = new SqlCommand(sql, conn);
                    //conn.Open();
                    //DataSet ds = new DataSet();
                    //SqlDataAdapter da = new SqlDataAdapter(com);
                    //da.Fill(ds);
                    //conn.Close();
                    //if (ds.Tables[0].Rows.Count > 0)
                    //{
                    //    PageState.Add("IsClerk", "T");
                    //}
                    //else
                    //{
                    //    PageState.Add("IsClerk", "F");
                    //}
                    IEnumerable<SysModule> topAuthExamMdls = new List<SysModule>();
                    string appcode = EXAMINING_APP_CODE;
                    if (this.Request.QueryString["App"] != null && this.Request.QueryString["App"].Trim() != "")
                    {
                        appcode = this.Request.QueryString["App"];
                    }
                    if (UserContext.AccessibleApplications.Count > 0)
                    {
                        SysApplication examApp = UserContext.AccessibleApplications.FirstOrDefault(tent => tent.Code == appcode);
                        if (examApp != null && UserContext.AccessibleModules.Count > 0)
                        {
                            topAuthExamMdls = UserContext.AccessibleModules.Where(tent => tent.ApplicationID == examApp.ApplicationID && String.IsNullOrEmpty(tent.ParentID));
                            topAuthExamMdls = topAuthExamMdls.OrderBy(tent => tent.SortIndex);
                        }
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
                            //  20140409 潘注释   不然导致首页加载非常慢
                            try
                            {
                                passCode = GoodwaySSO.Sso.LoginGW(template, row["Id"].ToString(), row["UserName"].ToString());
                            }
                            catch { }
                            PageState.Add("PassCode", passCode);
                            Session["PassCode"] = passCode;
                        }
                        else
                        {
                            Session["PassCode"] = "";
                        }
                    }
                    IList<SysApplication> saEnts = UserContext.AccessibleApplications.OrderBy(tens => tens.SortIndex).Where(ent => ent.Status == 1).ToArray();
                    this.PageState.Add("Modules", saEnts);
                    DataTable dtps = DataHelper.QueryDataTable("select  GroupID DeptId,Name DeptName from SysGroup where GroupID in (select BaseTemplateId from WebPartTemplate where BlockType='DeptPortal')");
                    this.PageState.Add("Depts", DataHelper.DataTableToDictList(dtps));
                    //在线人数
                    int urs = 0;
                    Aim.Portal.ServicesProvider.WebPortalServiceProvider uss = (Aim.Portal.ServicesProvider.WebPortalServiceProvider)WebPortalService.GetDefaultProvider();
                    urs = Aim.Common.ServiceHelper.DeserializeFromBytes<SysUser[]>(uss.USService.GetSystemData("<container><parameters><parameter Name='SessionID'></parameter><parameter Name='Operation'>getonlineusers</parameter></parameters></container>")).Length;
                    this.PageState.Add("UserOnLine", urs);
                    //PopWin(); 
                    break;
            }
        }
        protected void PopWin()
        {
            string sql = @"declare @path varchar(300)
                        select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                        where UserId='{0}'
                        select * from (
                        select Id,Title,TypeId,[State],ExpireTime,HomePagePopup,ReceiveUserId,'pt' as NewsType from News where charindex('{0}',convert(varchar(max),isnull(ReadState,'')))=0 and datediff(dd,PostTime,getdate())<14
                        union all
                        select Id,Title,TypeId,[State],ExpireTime,HomePagePopup,ReceiveUserId,'image' as NewsType from ImgNews where charindex('{0}',convert(varchar(max),isnull(Ext2,'')))=0 and datediff(dd,PostTime,getdate())<14
                        union all
                        select Id,Title,TypeId,[State],ExpireTime,HomePagePopup,ReceiveUserId,'video' as NewsType from VideoNews where charindex('{0}',convert(varchar(max),isnull(Ext2,'')))=0 and datediff(dd,PostTime,getdate())<14
                        ) n 
                        inner join NewsType nt on nt.Id=n.TypeId 
                        and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                        and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                        exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                        or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))
                        and HomePagePopup='on'";

            IList<EasyDictionary> PromptDics = DataHelper.QueryDictList(string.Format(sql, UserInfo.UserID));
            PageState.Add("PromptDics", PromptDics);
        }
        protected void lnkGoodway_Click(object sender, EventArgs e)
        {
            string passcode = String.Empty;
            string gwPortalUrl = ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"];
            gwPortalUrl = String.Format(gwPortalUrl + "?PassCode={0}", passcode);
            Response.Redirect(gwPortalUrl);
        }
        protected void lnkExit_Click(object sender, EventArgs e)
        {
            try
            {
                GoodwaySSO.Sso.Singletion.LogoutUserState(Session["PassCode"].ToString());
            }
            catch { }
            WebPortalService.Exit();
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            WebPortalService.LogoutAndRedirect("Login.aspx");
        }
        //protected void lnkRelogin_Click1(object sender, ImageClickEventArgs e)
        //{
        //    try
        //    {
        //        GoodwaySSO.Sso.Singletion.LogoutUserState(Session["PassCode"].ToString());
        //    }
        //    catch { }
        //    
        //}
    }
}
