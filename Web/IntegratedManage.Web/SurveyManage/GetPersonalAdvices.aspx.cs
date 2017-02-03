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

namespace IntegratedManage.Web.SurveyManage
{
    public partial class GetPersonalAdvices : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = this.RequestData.Get<string>("ItemId");
            if (!string.IsNullOrEmpty(id))
            {
                GetComment(id);
            }
        }

        //获取问题的评论和建议
        public void GetComment(string Id)
        {
            string sql = @"select top 120  NewId() As Id, UserId,UserName,QuestionItemContent 
                            from  BJKY_IntegratedManage..SurveyResult     
                            where QuestionItemId= '{0}' or QuestionContentId='{0}' and QuestionItemContent is not null and len(QuestionItemContent)>0";
            sql = string.Format(sql, Id);
            this.PageState.Add("DataList", DataHelper.QueryDictList(sql));
        }

    }
}
