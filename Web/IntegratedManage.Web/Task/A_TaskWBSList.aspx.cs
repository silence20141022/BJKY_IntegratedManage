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
    public partial class A_TaskWBSList : IMListPage
    {
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
                        DoBatchDelete();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(this.RequestData.Get<string>("ParentId")))
            {
                ents = A_TaskWBS.FindAll(SearchCriterion, Expression.Eq(A_TaskWBS.Prop_ParentID, this.RequestData.Get<string>("ParentId")));
                this.PageState.Add("TaskParent", A_TaskWBS.Find(this.RequestData.Get<string>("ParentId")));
            }
            else
                ents = A_TaskWBS.FindAll(SearchCriterion);
            this.PageState.Add("A_TaskWBSList", ents);
        }
        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                A_TaskWBS.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion
    }
}

