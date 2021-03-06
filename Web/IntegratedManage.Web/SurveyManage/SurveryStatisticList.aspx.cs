﻿using System;
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
using System.Text;
using Aim;
namespace IntegratedManage.Web.SurveyManage
{
    public partial class SurveryStatisticList : IMListPage
    {
        private IList<SurveyQuestion> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (this.RequestActionString)
            {
                case "batchdelete":
                    DoBatchDelete();
                    break;
                case "Start":
                    StartSurvery();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "StartTime":
                            where += " and CreateTime>='" + item.Value + "' ";
                            break;
                        case "EndTime":
                            where += " and CreateTime<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            //SurveyScanPower 浏览权限表
            //exists(  select  * from BJKY_IntegratedManage..SurveyScanPower where SurveyId=A.Id and charindex('{0}',UserId)>0 )
            /* string sql = @" select * from BJKY_IntegratedManage..SurveyQuestion As A,
                             (select  SurveyId,count(Id) As CommitNum from BJKY_IntegratedManage..SurveyCommitHistory group by SurveyId )  As B 
                            where A.Id=B.SurveyId and (
                             exists(
                                 select * from SysRole,SysUserRole
                                     where SysRole.RoleID=SysUserRole.RoleID and SysRole.Name like '%系统管理员%' and UserID='{0}'
                             )
                            or A.CreateId='{0}') and 1=1  ";*/

            //验证权限,能否查看详细
            string AuditSql = @" select Id from BJKY_IntegratedManage..SurveyQuestion As A 
                                 where exists(
                                    select * from SysRole,SysUserRole
                                        where SysRole.RoleID=SysUserRole.RoleID and 
                                         (SysRole.Name like '%系统管理员%' or SysRole.Name like '%网上调查管理员%')
                                         and UserID='{0}'
                                    )
                                  or CreateId='{0}'  ";

            object Obj = DataHelper.QueryValue(string.Format(AuditSql, UserInfo.UserID));
            if (Obj != null)
            {
                this.PageState.Add("detailAudit", "true");
            }
            //A.Id=B.SurveyId 提交 bug
            string sql = @" select * from BJKY_IntegratedManage..SurveyQuestion As A,
                            (select SurveyId,count(Id) As CommitNum from BJKY_IntegratedManage..SurveyCommitHistory group by SurveyId )  As B 
                            where A.Id=B.SurveyId and (
                            exists(
                                select * from SysRole,SysUserRole
                                    where SysRole.RoleID=SysUserRole.RoleID and 
                                    (SysRole.Name like '%系统管理员%' or SysRole.Name like '%网上调查管理员%') and UserID='{0}'
                            ) or A.CreateId='{0}' ) and 1=1 
                            union 
                            select * from BJKY_IntegratedManage..SurveyQuestion As A,
                            (select SurveyId,count(Id) As CommitNum from BJKY_IntegratedManage..SurveyCommitHistory group by SurveyId  )  As B 
                            where A.Id=B.SurveyId and A.ReadPower='1' and exists(
	                            select * from BJKY_IntegratedManage..SurveyCommitHistory where SurveyedUserId='{0}'
                            )";

            sql = string.Format(sql, UserInfo.UserID);
            sql = sql.Replace("and 1=1", where);
            IList<EasyDictionary> Ents = GetPageData(sql, SearchCriterion);
            this.PageState.Add("SurveyQuestionList", Ents);

        }


        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
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

        private void StartSurvery()
        {
            IList<string> IdList = RequestData.GetList<string>("IdList");
            StringBuilder strbId = new StringBuilder();
            foreach (string item in IdList)
            {
                strbId.Append("'" + item + "',");

            }
            string sql = @"update BJKY_IntegratedManage..SurveyQuestion set State='1' where Id in ({0})";
            sql = string.Format(sql, strbId.ToString().Remove(strbId.ToString().Length - 1, 1));
            object obj = DataHelper.ExecSql(sql);
            this.PageState.Add("obj", obj);

        }
        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                foreach (var v in idList)
                {
                    IList<QuestionContent> qcEnt = QuestionContent.FindAllByProperty(QuestionContent.Prop_SurveyQuestionId, v.ToString());
                    IList<QuestionItem> qIEnt = QuestionItem.FindAllByProperty(QuestionItem.Prop_SurveyQuestionId, v.ToString());
                    foreach (QuestionContent items in qcEnt)
                    {
                        items.DoDelete();
                    }
                    foreach (QuestionItem items in qIEnt)
                    {
                        items.Delete();
                    }
                }
                SurveyQuestion.DoBatchDelete(idList.ToArray());
            }
        }
    }
}
