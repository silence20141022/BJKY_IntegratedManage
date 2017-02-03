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
using System.Data;

namespace IntegratedManage.Web.SurveyManage
{
    public partial class InternetSurveyView : IMListPage
    {
        public string header = string.Empty;
        string Id = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            Id = RequestData.Get<string>("Id");
            switch (RequestActionString)
            {
                case "Commit":
                    CommitSurvey();
                    break;
            }
            Authenrion();
            if (!string.IsNullOrEmpty(Id))
            {
                RendSurveryView(Id);
            }
        }

        private void Authenrion()
        //验证是否有权限
        {
            //已提交状态
            string sql_commmit = @"select Id from BJKY_IntegratedManage..SurveyCommitHistory where SurveyId='{0}' and SurveyedUserId='{1}'";
            sql_commmit = string.Format(sql_commmit, Id, UserInfo.UserID);
            object obj = DataHelper.QueryValue(sql_commmit);
            if (obj != null)
            {
                string url = "CommitedSurvey.aspx?op=v&SurveyId=" + Id;
                Response.Redirect(url, true);
                return;
            }
            //string Auth = "false";
            //            //全院或者创建人
            //            string sql_all = "select Id,CreateId,PowerType from BJKY_IntegratedManage..SurveyQuestion where Id='{0}' ";
            //            sql_all = string.Format(sql_all, Id);
            //            DataTable dt = DataHelper.QueryDataTable(sql_all);
            //            if (dt.Rows.Count > 0)
            //            {
            //                if (dt.Rows[0]["CreateId"].ToString() == UserInfo.UserID || dt.Rows[0]["PowerType"].ToString().Contains("all"))
            //                {
            //                    Auth = "ture";
            //                }
            //            }
            //            string sql_dept = @"select F1 As ID  from fun_splitstr(
            //	                            (select top 1 ScanPower from BJKY_IntegratedManage..SurveyQuestion where Id='{0}'  ),',' )  INTERSECT 
            //            	              select GroupID from BJKY_Portal..SysGroup where path like  '%'+
            //			                    ( select top 1 case [Type] when 3 then ParentID when 2 then B.GroupID end As GroupID
            //				                    from BJKY_Portal..SysUserGroup As A,BJKY_Portal..SysGroup As B 
            //				                    where A.GroupID=B.GroupID and UserID='{1}' )+'%'";
            //            string sql_person = @"select F1 As Id  from fun_splitstr(
            //	                            (select top 1 StatisticsPower from BJKY_IntegratedManage..SurveyQuestion where Id='{0}'  ),',' ) 
            //                                where F1='{1}'";
            //            sql_dept = string.Format(sql_dept, Id, UserInfo.UserID);
            //            DataTable dt_dept = DataHelper.QueryDataTable(sql_dept);
            //            sql_person = string.Format(sql_person, Id, UserInfo.UserID);
            //            DataTable dt_person = DataHelper.QueryDataTable(sql_person);
            //            if (dt_dept.Rows.Count <= 0 && dt_person.Rows.Count <= 0)
            //            {
            //                Auth = "false";
            //            }
            //            this.PageState.Add("Auth", Auth);
        }

        private void CommitSurvey()
        /*存储提交的调查问卷数据*/
        {
            string CommitHistory = this.RequestData.Get<string>("CommitHistory");
            IList<string> list = this.RequestData.GetList<string>("commitArr");

            if (list.Count > 0 && !string.IsNullOrEmpty(CommitHistory))
            {
                IList<SurveyResult> ents = list.Select(ten => JsonHelper.GetObject<SurveyResult>(ten) as SurveyResult).ToArray();
                SurveyCommitHistory shEnt = JsonHelper.GetObject<SurveyCommitHistory>(CommitHistory);
                foreach (var v in ents)
                {
                    v.DoCreate();
                }
                shEnt.DoCreate();
            }
        }

        private void RendSurveryView(string Id)
        {
            IList<QuestionContent> qcEnts = QuestionContent.FindAllByProperties(0, QuestionContent.Prop_SortIndex, QuestionContent.Prop_SurveyQuestionId, Id);
            if (qcEnts.Count > 0)
            {
                StringBuilder Stb = new StringBuilder();
                for (int i = 0; i < qcEnts.Count; i++)
                {
                    StringBuilder SubStb = new StringBuilder();
                    IList<QuestionItem> qiEnts = QuestionItem.FindAllByProperties(0, QuestionItem.Prop_SortIndex, QuestionItem.Prop_QuestionContentId, qcEnts[i].Id);
                    for (int k = 0; k < qiEnts.Count; k++)
                    {
                        if (k > 0) SubStb.Append(",");
                        SubStb.Append(JsonHelper.GetJsonString(qiEnts[k]));
                    }
                    qcEnts[i].QuestionItems = "[" + SubStb.ToString() + "]";
                    if (i > 0) Stb.Append(",");
                    Stb.Append(JsonHelper.GetJsonString(qcEnts[i]));
                }
                this.PageState.Add("ItemList", "[" + Stb.ToString() + "]");
            }

            //string sql = @"select * from BJKY_IntegratedManage..SurveyQuestion  where Id='{0}' ";

            SurveyQuestion ent = null;
            if (!string.IsNullOrEmpty(Id))
            {
                ent = SurveyQuestion.Find(Id);
                this.PageState.Add("Survey", ent);
            }

        }
    }
}