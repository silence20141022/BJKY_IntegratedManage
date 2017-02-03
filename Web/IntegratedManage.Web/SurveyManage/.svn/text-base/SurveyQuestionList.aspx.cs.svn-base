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
using IntegratedManage.Model;
using System.Text;

namespace IntegratedManage.Web.SurveyManage
{
    public partial class SurveyQuestionList : IMListPage
    {

        private IList<SurveyQuestion> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            SurveyQuestion ent = null;
            switch (this.RequestActionString)
            {
                case "batchdelete":
                    DoBatchDelete();
                    break;
                case "Start":
                    StartSurvery();
                    break;
                case "stop":
                    StopSurvery();
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
            string SQuestion = "CreateId = '" + UserInfo.UserID + "'";

            //验证是否为系统管理员  Y=>全部
            string sql = @"select UserID from SysRole,SysUserRole
                        where SysRole.RoleID=SysUserRole.RoleID and SysRole.Name like '%系统管理员%' and UserID='{0}'";
            sql = string.Format(sql, UserInfo.UserID);
            if (DataHelper.QueryValue(sql) != null)
            {
                SQuestion += " or 1=1";
                //this.PageState.Add("Audit", "admin"); 
            }

            ents = SurveyQuestion.FindAll(SearchCriterion, Expression.Sql(SQuestion));
            this.PageState.Add("SurveyQuestionList", ents);
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
        private void StopSurvery()
        {
            /*将状态设置为停止状态*/
            string Id = this.RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                SurveyQuestion Ent = SurveyQuestion.Find(Id);
                Ent.State = "2";
                Ent.DoUpdate();
            }

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

