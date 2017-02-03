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

namespace IntegratedManage.Web
{
    public partial class A_ChargeProgresList : BaseListPage
    {
        private IList<A_ChargeProgres> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            A_ChargeProgres ent = null;
            switch (RequestActionString)
            {
                case "delete":
                    ent = this.GetTargetData<A_ChargeProgres>();
                    ent.DoDelete();
                    break;
                case "batchdelete":
                    DoBatchDelete();
                    break;
                case "charge":
                    A_TaskWBS[] charges = A_TaskWBS.FindAll(Expression.Eq(A_TaskWBS.Prop_ParentID, this.RequestData.Get<string>("TaskId")), Expression.Not(Expression.Eq(A_TaskWBS.Prop_State, "2")));
                    if (charges.Length > 0)
                    {
                        PageState.Add("Finish", "false");
                    }
                    else
                    {
                        PageState.Add("Finish", "true");
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (!SearchCriterion.Orders.Exists(ent => ent.PropertyName == A_ChargeProgres.Prop_CreateTime))
            {
                SearchCriterion.Orders.Add(new OrderCriterionItem(A_ChargeProgres.Prop_CreateTime, false));
            }
            if (!string.IsNullOrEmpty(this.RequestData.Get<string>("TaskId")))
            {
                this.PageState.Add("TaskModel", A_TaskWBS.Find(this.RequestData.Get<string>("TaskId")));
                ents = A_ChargeProgres.FindAll(SearchCriterion, Expression.Eq(A_ChargeProgres.Prop_TaskId, this.RequestData.Get<string>("TaskId")));
            }
            else
            {
                ents = A_ChargeProgres.FindAll(SearchCriterion);
            }
            PageState.Add("A_ChargeProgresList", ents);
        }
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");
            if (idList != null && idList.Count > 0)
            {
                A_ChargeProgres.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

