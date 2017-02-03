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
using IntegratedManage.Web;

namespace Aim.AM.Web
{
    public partial class WorkTimeFactListEdit : BaseListPage
    {
        private IList<WorkTimeFact> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            WorkTimeFact ent = null;
            switch (RequestActionString)
            {
                case "delete":
                    ent = this.GetTargetData<WorkTimeFact>();
                    ent.DoDelete();
                    break;
                case "batchdelete":
                    DoBatchDelete();
                    break;
                case "batchsave":
                    DoBatchSave();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(this.RequestData.Get<string>("TaskId")))
            {
                this.PageState.Add("TaskModel", A_TaskWBS.Find(this.RequestData.Get<string>("TaskId")));
                ents = WorkTimeFact.FindAll(SearchCriterion, Expression.Eq(WorkTimeFact.Prop_TaskId, this.RequestData.Get<string>("TaskId")));
            }
            else
                ents = WorkTimeFact.FindAll(SearchCriterion);
            this.PageState.Add("WorkTimeFactList", ents);
        }
        [ActiveRecordTransaction]
        private void DoBatchSave()
        {
            IList<string> entStrList = RequestData.GetList<string>("data");

            if (entStrList != null && entStrList.Count > 0)
            {
                IList<WorkTimeFact> ents = entStrList.Select(tent => JsonHelper.GetObject<WorkTimeFact>(tent) as WorkTimeFact).ToList();
                foreach (WorkTimeFact ent in ents)
                {
                    if (ent != null)
                    {
                        WorkTimeFact tent = ent;

                        if (String.IsNullOrEmpty(tent.Id))
                        {
                            tent.CreateId = UserInfo.UserID;
                            tent.CreateName = UserInfo.Name;
                        }
                        else
                        {
                            tent = DataHelper.MergeData(WorkTimeFact.Find(tent.Id), tent);
                        }

                        tent.DoSave();
                    }
                }
            }
        }
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");
            if (idList != null && idList.Count > 0)
            {
                WorkTimeFact.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

