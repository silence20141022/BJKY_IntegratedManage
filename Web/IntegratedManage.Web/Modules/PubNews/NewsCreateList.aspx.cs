using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Generic;

using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using Aim.WorkFlow;

namespace Aim.Portal.Web.Modules.PubNews
{
    public partial class NewsCreateList : BaseListPage
    {
        string op = String.Empty;
        string typeId = String.Empty;
        News ent = null;
        VideoNews ne = null;
        ImgNews imgnew = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            typeId = RequestData.Get<string>("TypeId", String.Empty);          
            switch (RequestActionString)
            {
                case "batchdelete":
                    IList<object> idList = RequestData.GetList<object>("IdList");
                    if (idList != null && idList.Count > 0)
                    {
                        NewsRule.BatchRemoveByPrimaryKeys(idList);
                        foreach (object obj in idList)
                        {
                            ImgNewDetail.DeleteAll(" PId='" + obj + "' ");
                            VideoNewDetail.DeleteAll(" PId='" + obj + "' ");

                            string delsql = "delete WorkflowInstance where RelateId='" + obj + "' delete Task where EFormName like '%" + obj + "%'";
                            DataHelper.ExecSql(delsql);
                        }
                        ImgNews.DoBatchDelete(idList.ToArray());
                        VideoNews.DoBatchDelete(idList.ToArray());
                    }
                    break;
                case "submitnews":
                    object news = null;
                    string NewsType = RequestData.Get<string>("NewsType");
                    if (NewsType == "视频")
                    {
                        ne = VideoNews.Find(this.RequestData["Id"].ToString());
                        ne.State = this.RequestData["state"].ToString();
                        ne.Save();
                        news = ne;
                    }
                    else if (NewsType == "图片")
                    {
                        imgnew = ImgNews.Find(this.RequestData["Id"].ToString());
                        imgnew.State = this.RequestData["state"].ToString();
                        imgnew.Save();
                        news = imgnew;
                    }
                    else
                    {
                        ent = News.Find(this.RequestData["Id"].ToString());
                        ent.State = this.RequestData["state"].ToString();
                        ent.Save();
                        news = ent;
                    }

                    if (this.RequestData["state"].ToString() == "1")
                        PageState.Add("message", "提交成功");
                    else
                    {
                        string nid = "";
                        if (news is News)
                        {
                            ent = news as News;
                            ent.WFState = "";
                            ent.WFResult = "";
                            ent.Update();
                            nid = ent.Id;
                        }
                        else if (news is ImgNews)
                        {
                            ImgNews imgent = news as ImgNews;
                            imgent.WFState = "";
                            imgent.WFResult = "";
                            imgent.Update();
                            nid = imgent.Id;
                        }
                        else if (news is VideoNews)
                        {
                            VideoNews videoent = news as VideoNews;
                            videoent.WFState = "";
                            videoent.WFResult = "";
                            videoent.Update();
                            nid = videoent.Id;
                        }

                        string delsql = "delete WorkflowInstance where RelateId='" + nid + "' delete Task where EFormName like '%" + nid + "%'";
                        DataHelper.ExecSql(delsql);
                        PageState.Add("message", "收回成功");
                    }
                    break;
                case "submit":
                    StartFlow(RequestData.Get<string>("id"));
                    break;
                case "autoexecute":
                    Task[] tasks = Task.FindAllByProperties(Task.Prop_WorkflowInstanceID, this.RequestData.Get<string>("FlowId"));
                    if (tasks.Length == 0)
                    {
                        System.Threading.Thread.Sleep(1000);
                        tasks = Task.FindAllByProperties(Task.Prop_WorkflowInstanceID, this.RequestData.Get<string>("FlowId"));
                    }
                    if (tasks.Length > 0)
                    {
                        this.PageState.Add("TaskId", tasks[0].ID);
                        string AuditUserId = RequestData.Get<string>("AuditUserId");
                        string AuditUserName = RequestData.Get<string>("AuditUserName");

                        if (!string.IsNullOrEmpty(AuditUserId))
                        {
                            Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], new string[] { AuditUserId, AuditUserName });
                        }
                        else
                        {
                            PageState.Add("error", "自动提交申请人失败，请手动提交");
                        }
                    }
                    else
                    {
                        PageState.Add("error", "自动提交申请人失败，请手动提交");
                    }
                    break;
                case "CancelFlow":
                    string id = RequestData.Get<string>("id");
                    string NId = "";
                    ent = News.TryFind(id);
                    if (ent != null)
                    {
                        NId = ent.Id;
                    }
                    else
                    {
                        imgnew = ImgNews.TryFind(id);
                        if (imgnew != null)
                        {
                            NId = imgnew.Id;
                        }
                    }
                    if (DataHelper.QueryDataTable("Select Id from Task where EFormName like '%" + NId + "%' and OwnerId='" + this.UserInfo.UserID + "' and Status=0 ").Rows.Count == 0)
                    {
                        PageState.Add("error", "单据未打回给您或未启动流程,不能作废!");
                    }
                    else
                    {
                        if (ent != null)
                        {
                            ent.WFState = "";
                            ent.WFResult = "已撤销";
                            ent.Update();
                        }
                        else if (imgnew != null)
                        {
                            imgnew.WFState = "";
                            imgnew.WFResult = "已撤销";
                            imgnew.Update();
                        }
                        string delsql = "delete WorkflowInstance where RelateId='" + NId + "' delete Task where EFormName like '%" + NId + "%'";
                        DataHelper.ExecSql(delsql);
                    }
                    break;
                default:
                    PageState.Add("WorkFlowState", SysEnumeration.GetEnumDict("WorkFlowState"));
                    if (op == "r")
                    {
                        string path = DataHelper.QueryValue("select g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId where UserId='" + UserInfo.UserID + "'") + "";
                        string sql = @"select n.Id, n.TypeId, n.BelongDeptId, n.Title, n.KeyWord, n.Content, n.ContentType, n.AuthorName, n.PostUserId, n.PostUserName, n.PostDeptId, n.PostDeptName, n.ReceiveDeptId, n.ReceiveDeptName, n.ReceiveUserId, n.ReceiveUserName, n.PostTime, n.ExpireTime, n.SaveTime, n.Pictures, n.Attachments, n.MHT, n.State, n.ImportantGrade, n.ReadCount, n.HomePagePopup, n.LinkPortalImage, n.Class, n.PopupIds, n.Grade, n.AuthorId, n.CreateTime, n.CreateId, n.CreateName, n.Type, n.ReleaseState, n.PId, n.SubmitState, n.NewType, n.ReadState, n.RemindDays, n.RdoType, n.FileType, n.MhtFile from News n 
                                    inner join NewsType nt on nt.Id=n.TypeId
                                    where TypeId='{2}' 
                                    and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                                    and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',n.AuthorId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                                    exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,'{1}')>0)
                                    or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,'{1}')>0)) {3}";
                        //合并老系统的新闻和公告
                        if (typeId == "fa67b910-a692-4df7-83a2-50711ba4bfa5" || typeId == "eb9db227-6adc-4dd1-8783-467aadc2d11b")
                        {
                            if (typeId == "fa67b910-a692-4df7-83a2-50711ba4bfa5")
                            {
                                sql += @" union all select [Id],'fa67b910-a692-4df7-83a2-50711ba4bfa5' [CatalogId],[BelongDeptId],[Title],[KeyWord],[Content],[ContentType]
                                 ,[AuthorName],[PostUserId],[PostUserName],[PostDeptId],[PostDeptName]
                                 ,[ReceiveDeptId],[ReceiveDeptName],[ReceiveUserId],[ReceiveUserName]
                                 ,[PostTime],[ExpireTime],[SaveTime],[Pictures],[Attachments],[MHT]
                                 ,2,[ImportantGrade],[ReadCount],[HomePagePopup],[LinkPortalImage],
                                 '' s,[PopupIds],[Grade],'' authorid,null createtime,null createid,null t,class,null a,null b,null c,null d,null e,null f,null g,null h,null i from BJKY_BeOfficeAuto..PublicInformation WHERE CatalogId = 'OPIC0020' and state=1 {3}";
                            }
                            else
                            {
                                sql += @" union all select [Id],'eb9db227-6adc-4dd1-8783-467aadc2d11b' [CatalogId],[BelongDeptId],[Title],[KeyWord],[Content],[ContentType]
                              ,[AuthorName],[PostUserId],[PostUserName],[PostDeptId],[PostDeptName]
                              ,[ReceiveDeptId],[ReceiveDeptName],[ReceiveUserId],[ReceiveUserName]
                              ,[PostTime],[ExpireTime],[SaveTime],[Pictures],[Attachments],[MHT]
                              ,2,[ImportantGrade],[ReadCount],[HomePagePopup],[LinkPortalImage],
                              '' s,[PopupIds],[Grade],'' authorid,null createtime,null createid,null t,class,null a,null b,null c,null d,null e,null f,null g,null h,null i from BJKY_BeOfficeAuto..PublicInformation WHERE CatalogId = 'OPIC0021' and state=1 {3}";
                            }
                        }
                        string where = "";
                        foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                        {
                            if (item.Value + "" != "")
                            {
                                where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            }
                        }
                        sql = string.Format(sql, UserInfo.UserID, path, typeId, where);
                        PageState.Add("SysUserList", GetPageData(sql, SearchCriterion));
                    }
                    else
                    {
                        string where = " and isnull(ExpireTime,'2099-01-01')>=getdate() ";
                        if (RequestData.Get<string>("Expire") == "true")
                        {
                            where = " and isnull(ExpireTime,'2099-01-01')<getdate() ";
                        }
                        foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
                        {
                            if (item.Value + "" != "")
                            {
                                where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            }
                        }
                        if (!string.IsNullOrEmpty(typeId))
                        {
                            SearchCriterion.SetSearch("TypeId", typeId);
                            News[] ents = NewsRule.FindAll(SearchCriterion, Expression.Sql(" AuthorId = '" + UserInfo.UserID + "' " + where)).OrderByDescending(o => o.SaveTime).ToArray();
                            this.PageState.Add("SysUserList", ents);

                        }//图片新闻、视频新闻 不需要过滤(不同的页面)
                        else
                        {
                            string sql = @"select * from (select Id, TypeId, Title, AuthorId, AuthorName, PostDeptId,ReadCount, PostDeptName, PostTime, ExpireTime, SaveTime, [State],'普通' as NewsType, AuditUserId, AuditUserName, WFState, WFResult,
                            (select top 1 ApprovalNodeName from task where [Status]='0' and EFormName like '%'+News.Id+'%') as WFCurrentNode from News
                             union all 
                            select Id, TypeId, Title, CreateId,CreateName, PostDeptId,Ext1, PostDeptName, PostTime, ExpireTime, CreateTime, [State],'图片', AuditUserId, AuditUserName, WFState, WFResult,
                            (select top 1 ApprovalNodeName from task where [Status]='0' and EFormName like '%'+ImgNews.Id+'%') as WFCurrentNode from ImgNews
                            union all 
                            select Id, TypeId, Title, CreateId,CreateName, PostDeptId,Ext1, PostDeptName, PostTime, ExpireTime, CreateTime, [State],'视频', AuditUserId, AuditUserName, WFState, WFResult,
                           (select top 1 ApprovalNodeName from task where [Status]='0' and EFormName like '%'+VideoNews.Id+'%') as WFCurrentNode from VideoNews) t ";
                            this.PageState.Add("SysUserList", GetPageData(sql + " where AuthorId = '" + UserInfo.UserID + "' " + where, SearchCriterion));
                        }
                    }
                    break;
            }
            if (!IsAsyncRequest)
            {
                NewsType[] types = NewsType.FindAll();
                Dictionary<string, string> dt = new Dictionary<string, string>();
                foreach (NewsType type in types)
                {
                    dt.Add(type.Id, type.TypeName);
                }
                PageState.Add("EnumType", dt);
            }
        }
        public void StartFlow(string formId)
        {
            string code = "";
            News ent = News.TryFind(formId);
            ImgNews imgnew = null;
            string[] entarry = new string[4];
            string formUrl = "";
            if (ent != null)
            {
                if (ent.TypeId == "fa67b910-a692-4df7-83a2-50711ba4bfa5")
                {
                    code = "ImgNewsAudit";
                }
                else
                {
                    code = "NewsAudit";
                }
                formUrl = "/Modules/PubNews/NewsCreateEdit.aspx?op=u&id=" + formId;
                entarry[0] = ent.Title;
                entarry[1] = ent.CreateName;
                entarry[2] = ent.CreateId;
                entarry[3] = ent.CreateName;
            }
            else
            {
                imgnew = ImgNews.TryFind(formId);
                code = "ImgNewsAudit";
                if (imgnew != null)
                {
                    entarry[0] = imgnew.Title;
                    entarry[1] = imgnew.CreateName;
                    entarry[2] = imgnew.CreateId;
                    entarry[3] = imgnew.CreateName;
                    formUrl = "/Modules/PubNews/ImgNews/FrmImgNewsCreateEdit.aspx?op=u&id=" + formId;
                }
            }
            Guid guid = Aim.WorkFlow.WorkFlow.StartWorkFlow(formId, formUrl, "信息发布【" + entarry[0] + "】申请人【" + entarry[1] + "】", code, entarry[2], entarry[3]);
            //返回流程的Id
            PageState.Add("FlowId", guid.ToString());
            if (ent != null)
            {
                ent.WFState = "Flowing";
                ent.WFResult = "";
                ent.Save();
            }
            else if (imgnew != null)
            {
                imgnew.WFState = "Flowing";
                imgnew.WFResult = "";
                imgnew.Save();
            }
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            string ordercol = "SaveTime";
            if (RequestData.Get<string>("op") == "r")
            {
                ordercol = "PostTime";
            }

            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : ordercol;
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " desc" : " asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
    }
}

