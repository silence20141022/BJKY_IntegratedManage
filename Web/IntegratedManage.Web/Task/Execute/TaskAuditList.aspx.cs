using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;
using IntegratedManage.Web;

namespace Aim.AM.Web.Aim.Execute
{
    public partial class TaskAuditList : BaseListPage
    {
        #region 属性

        #endregion

        #region 变量

        private IList<A_TaskWBS> ents = null;
        string db = ConfigurationManager.AppSettings["AimAMDB"];

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            A_TaskWBS ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<A_TaskWBS>();
                    ent.Delete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");

                        if (idList != null && idList.Count > 0)
                        {
                            A_TaskWBS.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (RequestActionString == "batchsubmit")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");

                        if (idList != null && idList.Count > 0)
                        {
                            A_TaskWBS[] tents = A_TaskWBS.FindAll(Expression.In("Id", idList.ToArray()));
                            foreach (A_TaskWBS tent in tents)
                            {
                                tent.State = "2";
                                tent.Save();
                            }
                        }
                    }
                    else if (RequestActionString == "batchback")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");

                        if (idList != null && idList.Count > 0)
                        {
                            A_TaskWBS[] tents = A_TaskWBS.FindAll(Expression.In("Id", idList.ToArray()));
                            foreach (A_TaskWBS tent in tents)
                            {
                                tent.State = "1";
                                tent.Save();
                            }
                        }
                    }
                    else
                    {
                        if (SearchCriterion.Orders.Count == 0)
                            SearchCriterion.Orders.Add(new OrderCriterionItem("PlanEndDate", true));
                        string dateFlag = this.RequestData["Date"] == null ? "365" : this.RequestData["Date"].ToString();
                        switch (dateFlag)
                        {
                            case "3":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(3), SearchModeEnum.LessThanEqual);
                                break;
                            case "7":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(7), SearchModeEnum.LessThanEqual);
                                break;
                            case "14":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddDays(14), SearchModeEnum.LessThanEqual);
                                break;
                            case "30":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(1), SearchModeEnum.LessThanEqual);
                                break;
                            case "31":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(1), SearchModeEnum.LessThanEqual);
                                break;
                            case "180":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddMonths(3), SearchModeEnum.LessThanEqual);
                                break;
                            case "365":
                                SearchCriterion.SetSearch("PlanEndDate", DateTime.Now.AddYears(1), SearchModeEnum.LessThanEqual);
                                break;
                        }
                        if (this.RequestData.Get<string>("Status") == "2")
                        {
                            ents = A_TaskWBS.FindAll(SearchCriterion, Expression.Sql(" ParentId in (select Id from " + db + "..A_TaskWBS where DutyId like '%" + this.UserInfo.UserID + "%' )  and State='2'"));
                        }
                        else
                        {
                            ents = A_TaskWBS.FindAll(SearchCriterion, Expression.Sql(" ParentId in (select Id from " + db + "..A_TaskWBS where DutyId like '%" + this.UserInfo.UserID + "%' ) and State='1.5'"), Expression.IsNotNull("ParentID"));
                        }
                        this.PageState.Add("SysWorkFlowTaskList", ents);
                    }
                    break;
            }

        }

        #endregion

        #region 私有方法

        #endregion
    }
}