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
using Aim;
using System.Data;

namespace IntegratedManage.Web.SurveyManage
{
    public partial class SurveyStatisticResult : IMListPage
    {

        string Id = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            Id = RequestData.Get<string>("Id");

            if (!string.IsNullOrEmpty(Id))
            {
                this.PageState.Add("SurveyQuestion", SurveyQuestion.Find(Id));
                SurveyStatistic(Id);
            }
            if (RequestActionString == "GetSlcUser")
            {
                GetSlcUser();
            }

        }

        private void GetSlcUser()
        {
            string qItemId = RequestData.Get("ItemId") + "";
            string SurveyId = RequestData.Get("SurveyId") + "";
            var Ents = SurveyResult.FindAll(
             Expression.Sql("  SurveyId='" + SurveyId + "' and QuestionItemId like '%" + qItemId + "%' "));
            this.PageState.Add("Ents", Ents);
        }
        public void SurveyStatistic(string SurveyId)
        {

            string sql = @"With  T1
                            As(

                                select * from(
                                    select *  from BJKY_IntegratedManage..SurveyResult  where SurveyId='{0}' 			
                                ) As A
                                cross apply(
                                    select F1 as ItemSet from func_splitstr(A.QuestionItemId,',')
                                ) As Et

                            ),
                            --该题选择人数
                            qCount AS (
                                 select Questioncontentid, count(1) As Qty  from T1
                                 where  questionitemid is not null and questionitemid<>''       
                                 group by  Questioncontentid 
                            ),
                            RestultTbl As(
                             select  distinct SurveyId,A.QuestionContentId,ItemSet,QuestionItemContent,Qty,
                                  cast(Cast(1.0*count(1) over (PARTITION BY ItemSet)/qC.Qty As float )*100 As decimal(5,2)) As Per
                             from  T1 As A
                                left join  qCount AS qC
                                    on A.QuestionContentId=qC.QuestionContentId
                             )
                            select  distinct 
	                            B.SurveyQuestionId as SurveyId,B.Id As QuestionContentId,C.Id as ItemSet,
                                isnull(A.Qty,0) as Qty,isnull( A.Per,0.00) as Per,
	                            B.Content,C.Answer,B.SortIndex ,C.SortIndex IIndex,
                                B.QuestionType,B.IsMustAnswer,B.IsComment,C.IsExplanation ,
	                             case 
		                            when A.Qty is null 
			                             then  Answer+'|'+ '0.00'+'|'+ IsExplanation+'|'+ C.Id
		                            else 
			                            Answer+'|'+ cast(isnull(Per,0) as nvarchar(50))+'|'+ IsExplanation+'|'+ ItemSet
	                             end As Integ
                            from   
                                BJKY_IntegratedManage..QuestionContent As B 
                                left join BJKY_IntegratedManage..QuestionItems As C 
			                            on C.QuestionContentId= B.Id
	                            left join RestultTbl As A
			                            on	A.ItemSet=C.Id
                            where B.SurveyQuestionId='{0}'
		                            and	 Answer is not null  order by B.SortIndex,C.SortIndex";
            sql = string.Format(sql, SurveyId);
            this.PageState.Add("DataList", DataHelper.QueryDictList(sql));

            sql = @"select *  from BJKY_IntegratedManage..QuestionContent 
                    where SurveyQuestionId='{0}' and QuestionType like '%填写项%' ";
            sql = string.Format(sql, Id);
            this.PageState.Add("FillQuestion", DataHelper.QueryDictList(sql));
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

            string sql = @"select * from BJKY_IntegratedManage..SurveyQuestion  where Id='{0}' ";
            this.PageState.Add("Survey", DataHelper.QueryDictList(string.Format(sql, Id)));
        }
    }
}
