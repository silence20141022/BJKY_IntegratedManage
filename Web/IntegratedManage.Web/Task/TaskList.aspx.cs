using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;

namespace Aim.AM.Web.Aim.Task
{
    public partial class TaskList : BaseListPage
    {
        #region 属性

        #endregion

        #region 变量

        private IList<A_TaskWBS> ents = null;

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
                    else
                    {
                        SearchCriterion.SetSearch("DutyId", this.UserInfo.UserID);
                        SearchCriterion.SetOrder("SubmitDate", false);
                        string dateFlag = this.RequestData["Date"] == null ? "180" : this.RequestData["Date"].ToString();
                        switch (dateFlag)
                        {
                            case "3":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddDays(-3), SearchModeEnum.GreaterThanEqual);
                                break;
                            case "7":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddDays(-7), SearchModeEnum.GreaterThanEqual);
                                break;
                            case "14":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddDays(-14), SearchModeEnum.GreaterThanEqual);
                                break;
                            case "30":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddMonths(-1), SearchModeEnum.GreaterThanEqual);
                                break;
                            case "31":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddMonths(-1), SearchModeEnum.LessThanEqual);
                                break;
                            case "180":
                                SearchCriterion.SetSearch("SubmitDate", DateTime.Now.AddMonths(3), SearchModeEnum.LessThanEqual);
                                break;
                        }
                        if (this.RequestData.Get<string>("Status") == "0")
                        {
                            ents = A_TaskWBS.FindAll(SearchCriterion,Expression.IsNull("Tag"));
                        }
                        else
                        {
                            ents = A_TaskWBS.FindAll(SearchCriterion, Expression.IsNotNull("Tag"));
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