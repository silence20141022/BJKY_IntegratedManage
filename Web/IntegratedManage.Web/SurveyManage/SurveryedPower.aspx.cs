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

namespace IntegratedManage.Web
{
    public partial class SurveryedPower : IMListPage
    {
        #region 变量

        private IList<SurveryedUser> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = this.RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                IList<SurveryedUser> suEnts = SurveryedUser.FindAllByProperties(SurveryedUser.Prop_SurveryId, Id);
                IList<SurveyScanUser> scEnts = SurveyScanUser.FindAllByProperties(SurveyScanUser.Prop_SurveyId, Id);
                this.PageState.Add("DataList1", suEnts);
            }

        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            ents = SurveryedUser.FindAll(SearchCriterion);
            this.PageState.Add("SurveryedUserList", ents);
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
                SurveryedUser.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion
    }
}

