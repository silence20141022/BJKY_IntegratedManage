﻿using System;
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
    public partial class NotePadList : IMListPage
    {
        #region 变量

        private IList<NotePad> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
			NotePad ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<NotePad>();
                    ent.DoDelete();
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
			ents = NotePad.FindAll(SearchCriterion);
			this.PageState.Add("NotePadList", ents);
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
				NotePad.DoBatchDelete(idList.ToArray());
			}
		}

        #endregion
    }
}

