using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Common;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web.UI;
using IntegratedManage.Web;
using Aim.Data;
using IntegratedManage.Model;
using NHibernate.Criterion;

namespace Aim.Examining.Web
{
    public partial class Home3 : IMBasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //新闻
            string qryString = "SELECT nt.*, nt.TypeName AS title, ISNULL(n.[Count], 0) AS count FROM NewsType nt LEFT JOIN "
                + "(SELECT TypeId, COUNT(Id) AS [Count] FROM News WHERE ReceiveUserId LIKE '%" + UserInfo.UserID + "%'  or isnull(ReceiveUserId,'')='' GROUP BY TypeId) AS n "
                + " ON n.TypeId = nt.Id AND AllowQueryId LIKE '%" + UserInfo.UserID + "%'  or isnull(AllowQueryId,'')=''";
            //qryString = "select sum(count) count,'新闻通知' from (" + qryString + ") a";
            DataTable dtNews = Aim.Data.DataHelper.QueryDataTable(qryString);
            PageState.Add("News", JsonHelper.GetJsonStringFromDataTable(dtNews));
            int newsCount = Aim.Data.DataHelper.QueryValue<int>("declare @path varchar(300)" +
            "select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId " +
            "where UserId='" + this.UserInfo.UserID + "'" +
            "select count(n.Id) from News n " +
            "inner join NewsType nt on nt.Id=n.TypeId " +
            "where State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()" +
            "and (charindex('" + this.UserInfo.UserID + "',n.ReceiveUserId)>0 or charindex('" + this.UserInfo.UserID + "',nt.AllowQueryId)>0 or " +
            "exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)" +
            "or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))");
            PageState.Add("NewsCount", newsCount);

            //任务
            qryString = "";/* @"select Count(Id) count,'待办任务' title from (
select Id from Task where status=0 and OwnerId='{0}' 
union
select Id  from BJKY_BeAdmin..WfWorkList where (State='New') and IsSign='{0}'  ) a 
union
select count(*) count,'已办任务' title from Task t 
left join dbo.WorkflowInstance w on w.Id=t.WorkflowInstanceID 
where t.status<>0 and OwnerId='{0}' and w.status<>'Completed'
union
select count(*) count,'办结任务' title  from Task t 
left join dbo.WorkflowInstance w on w.Id=t.WorkflowInstanceID 
where t.status<>0 and OwnerId='{0}' and w.status='Completed'";*/
            qryString = @"select Count(Id) count,'新任务' title from (
select Id from Task where status=0 and OwnerId='{0}' 
union
select Id  from BJKY_BeAdmin..WfWorkList where (State='New') and IsSign='{0}'  ) a  ";
            dtNews = Aim.Data.DataHelper.QueryDataTable(string.Format(qryString, this.UserInfo.UserID));
            PageState.Add("Tasks", JsonHelper.GetJsonStringFromDataTable(dtNews));


            int msgCount = Aim.Data.DataHelper.QueryValue<int>("select Count(Id) from View_SysMessage where ReceiveId ='" + this.UserInfo.UserID + "' and IsFirstView is null");
            PageState.Add("MsgCount", msgCount);

            qryString = @" select authname title,ModuleUrl,IconFileName fileid from MyShortCut where createid='{0}'";
            dtNews = Aim.Data.DataHelper.QueryDataTable(string.Format(qryString, this.UserInfo.UserID), DataHelper.GetCurrentDbConnection(typeof(A_TaskWBS)));
            PageState.Add("ShortCut", JsonHelper.GetJsonStringFromDataTable(dtNews));
            //网站自助
            WebLink[] lnks = WebLink.FindAll(Expression.Sql(" CreateId='" + this.UserInfo.UserID + "' or IsAdmine='1'"));
            PageState.Add("WebLinks",lnks); 
        }

        public void GetUserCreateMoudles()
        {
            IEnumerable<SysModule> topAuthEPCMdls = new List<SysModule>();
            IEnumerable<SysModule> ents = new List<SysModule>();
            if (UserContext.AccessibleApplications.Count > 0)
            {
                SysApplication epcApp = UserContext.AccessibleApplications.First(tent => tent.Code == EXAMINING_APP_CODE);

                if (epcApp != null && UserContext.AccessibleModules.Count > 0)
                {
                    topAuthEPCMdls = UserContext.AccessibleModules.Where(tent => tent.IsQuickCreate == true);
                    topAuthEPCMdls = topAuthEPCMdls.OrderBy(tent => tent.SortIndex);
                    ents = UserContext.AccessibleModules.Where(tent => tent.IsQuickSearch == true)
                        .OrderBy(tent => tent.SortIndex);
                }
            }
            this.PageState.Add("ModulesCreate", topAuthEPCMdls);
            this.PageState.Add("ModulesSearch", ents);
        }
    }
}
