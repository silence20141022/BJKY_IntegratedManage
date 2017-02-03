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
using Aim;

namespace IntegratedManage.Web.SurveyManage
{
    public partial class QuestionItemList : IMListPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            QuestionItem ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<QuestionItem>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    DoSelect();
                    break;
            }

        }
        private void DoSelect()
        {
            string Id = RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                string sql = @"select A.AnswerItems, newid() as Id,B.SurveyQuestionId,B.Content,B.QuestionType,B.IsMustAnswer,B.IsComment 
                                from BJKY_IntegratedManage..QuestionItems As A 
                                right join 
                                BJKY_IntegratedManage..QuestionContent as B
                                on A.QuestionContentId=B.Id 
                                where B.SurveyQuestionId='{0}'
                                order by SurveyQuestionId,QuestionContent,A.SortIndex";
                sql = string.Format(sql, Id);
                IList<EasyDictionary> Ents = DataHelper.QueryDictList(sql);
                this.PageState.Add("QuestionItemList", Ents);
            }

        }
    }
}

