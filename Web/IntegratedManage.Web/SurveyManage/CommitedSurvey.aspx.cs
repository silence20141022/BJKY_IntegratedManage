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
    public partial class CommitedSurvey : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetCommitSurvey();
        }
        private void GetCommitSurvey()
        {
            string SurveyId = this.RequestData.Get<string>("SurveyId");
            if (!string.IsNullOrEmpty(SurveyId))
            {
                if (!string.IsNullOrEmpty(this.RequestData.Get<string>("UserId")))
                {
                    SurveyCommitHistory Ent = SurveyCommitHistory.FindFirstByProperties(SurveyCommitHistory.Prop_SurveyId, SurveyId, SurveyCommitHistory.Prop_SurveyedUserId, this.RequestData.Get<string>("UserId"));
                    if (Ent != null)
                        Response.Write(string.IsNullOrEmpty(Ent.CommitSurvey) ? "" : Ent.CommitSurvey);
                }
                else
                {
                    SurveyCommitHistory Ent = SurveyCommitHistory.FindFirstByProperties(SurveyCommitHistory.Prop_SurveyId, SurveyId, SurveyCommitHistory.Prop_SurveyedUserId, UserInfo.UserID);
                    if (Ent != null)
                        Response.Write(string.IsNullOrEmpty(Ent.CommitSurvey) ? "" : Ent.CommitSurvey);
                }

            }
        }
    }
}
