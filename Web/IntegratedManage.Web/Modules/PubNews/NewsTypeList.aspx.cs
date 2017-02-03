﻿using System;
using System.Collections;
using System.Collections.Generic;
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

using Castle.ActiveRecord.Queries;

using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using IntegratedManage.Web;

namespace IntegratedManage.Web.Modules.PubNews
{
    public partial class NewsTypeList : IMListPage
    {
        private NewsType[] news = null;
        string deptId = "";
        NewsType type = null;
        private string id = "";
        public NewsTypeList()
        {
            this.IsCheckLogon = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                type = NewsType.Find(id);
            }
            SearchCriterion.AllowPaging = true;
            deptId = RequestData.Get<string>("DeptId");
            if (!string.IsNullOrEmpty(deptId))
            {
                news = NewsTypeRule.FindAll(SearchCriterion, Expression.Sql(" (BelongDeptId like '%" + this.RequestData.Get<string>("DeptId") + "%') or isnull(BelongDeptId,'')='' or BelongDeptId='7368C6F5-608F-4BA4-B810-1BA2448CDF57'"));
            }
            else
            {
                news = NewsTypeRule.FindAll(SearchCriterion);
            }
            PageState.Add("SysUserList", news);
            NewsType usr = null;
            switch (RequestActionString)
            {
                case "update":
                    usr = GetMergedData<NewsType>();
                    usr.SaveAndFlush();
                    break;
                case "insert":
                    usr = GetPostedData<NewsType>();
                    usr.CreateAndFlush();
                    break;
                case "delete":
                    usr = GetTargetData<NewsType>();
                    usr.DeleteAndFlush();
                    break;
                case "batchdelete":
                    IList<object> idList = RequestData.GetList<object>("IdList");
                    NewsTypeRule.BatchRemoveByPrimaryKeys(idList);
                    break;
                case "JudgeExist":
                    IList<Aim.Portal.Model.WebPart> wpEnts = Aim.Portal.Model.WebPart.FindAllByProperties("DeptId", deptId, "BlockKey", Aim.Utilities.Tool.GetPYString(type.TypeName));
                    if (wpEnts.Count > 0)
                    {
                        PageState.Add("Exist", "T");
                    }
                    break;
                case "asyn":
                    Asyn();
                    break;
                default:
                    break;
            }
        }
        private void Asyn()
        {
            Aim.Portal.Model.WebPart part = null;
            //if (Aim.Portal.Model.WebPart.FindAll(Expression.Eq("BlockKey", Aim.Utilities.Tool.GetPYString(type.TypeName))).Length > 0)
            //{
            //    part = Aim.Portal.Model.WebPart.FindFirst(Expression.Eq("BlockKey", Aim.Utilities.Tool.GetPYString(type.TypeName)));
            //}FindAll("FROM WebPart as ent where RepeatDataDataSql is not null and Id!='8eb3ebd5-74f0-4909-89b2-2b0c715eae23'").FirstOrDefault();
            //else
            //{
            part = new Aim.Portal.Model.WebPart();
            //直接用院内新闻作为模板这个是院内新闻的WebPartId f8fc2786-3707-4dd5-b7bf-3c26a47e4e7a
            Aim.Portal.Model.WebPart partOld = Aim.Portal.Model.WebPart.Find("f8fc2786-3707-4dd5-b7bf-3c26a47e4e7a");
            part = DataHelper.MergeData<Aim.Portal.Model.WebPart>(part, partOld);
            //} 
            string sql = @"declare @path varchar(300)
                        select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                        where UserId='[UserId]'
                        select top 6 n.Id,n.Title,Convert(varchar(10),n.PostTime,20) as NewTime, PostTime from News n 
                        inner join NewsType nt on nt.Id=n.TypeId 
                        where TypeId='{0}' 
                        and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                        and (charindex('[UserId]',n.ReceiveUserId)>0 or charindex('[UserId]',nt.AllowQueryId)>0 or 
                        exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                        or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))
                        order by PostTime desc";
            part.RepeatDataDataSql = string.Format(sql, type.Id);
            part.AllowUserIds = type.AllowQueryId;
            part.HeadHtml = @"<DIV id='drag_title_[Id]' style='BACKGROUND-Color: #D0DDF1;WIDTH: 100%; HEIGHT: 20px'>
            part.HeadHtml = string.Format(part.HeadHtml, '"', type.Id);
            part.AllowUserNames = type.AllowQueryName;
            part.DeptId = type.BelongDeptId;
            part.DeptName = type.BelongDeptName;
            part.BlockKey = Aim.Utilities.Tool.GetPYString(type.TypeName);
            part.BlockName = type.TypeName;
            part.BlockTitle = type.TypeName;
            part.RepeatItemCount = 5;
            if (type.BelongDeptId != null && type.BelongDeptId != "")
            {
                part.BlockType = "DeptPortal";
            }
            part.Save();
        }
    }
}