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
    public partial class QuestionItemEdit : IMListPage
    {
        string QuestionContentId = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {

            QuestionContentId = RequestData.Get<string>("QuestionContentId");

            switch (RequestActionString)
            {
                case "save":
                    DoSave();
                    break;
                default:
                    DoSelect();
                    break;

            }

        }
        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(QuestionContentId))
            {
                IList<QuestionItem> items = QuestionItem.FindAllByProperty(QuestionItem.Prop_QuestionContentId, QuestionContentId);
                this.PageState.Add("DataList", items);
            }
        }

        private void DoSave()
        {
            if (!string.IsNullOrEmpty(QuestionContentId))
            {
                IList<QuestionItem> qiEnts = QuestionItem.FindAllByProperty(QuestionItem.Prop_QuestionContentId, QuestionContentId);
                foreach (QuestionItem items in qiEnts)
                {
                    items.DoDelete();
                }
                IList<string> DataList = RequestData.GetList<string>("data");
                if (DataList.Count > 0)
                {
                    qiEnts = DataList.Select(tent => JsonHelper.GetObject<QuestionItem>(tent) as QuestionItem).ToArray();
                    foreach (QuestionItem itms in qiEnts)
                    {
                        itms.DoCreate();
                    }
                }
            }
        }
    }
}

