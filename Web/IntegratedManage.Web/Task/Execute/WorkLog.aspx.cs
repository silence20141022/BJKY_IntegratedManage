using System;
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
using System.Configuration;

namespace Aim.AM.Web.Aim.Execute
{
    public partial class WorkLog : BaseListPage
    {
        #region 变量

        private IList<WorkTimeFact> ents = null;
        string db = ConfigurationManager.AppSettings["AimAMDB"];

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            WorkTimeFact ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<WorkTimeFact>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (RequestActionString == "batchsave")
                    {
                        DoBatchSave();
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
            if (RequestData.Get<object>("EditDate") != null)
            {
                ents = WorkTimeFact.FindAll(SearchCriterion, Expression.Eq(WorkTimeFact.Prop_CreateId, this.UserInfo.UserID), Expression.Eq(WorkTimeFact.Prop_CurrentDate, RequestData.Get<DateTime>("EditDate")));
                if (ents.Count > 0)
                    this.PageState.Add("WorkTimeFactList", ents);
                else
                {
                    string sql = @"select 0 Total,Id TaskId,Code TaskCode,TaskName,GetDate() CreateDate,'{2}' CurrentDate from {1}..A_TaskWBS 
where DutyId like '%{0}%' order by Code asc";
                    this.PageState.Add("WorkTimeFactList", DataHelper.QueryDictList(string.Format(sql, this.UserInfo.UserID, db, RequestData.Get<object>("EditDate").ToString().Replace("-", "/"))));
                }
            }
            else
            {
                Response.Redirect("/Aim/Execute/WorkLog.aspx?EditDate="+DateTime.Now.ToShortDateString().Replace('/','-'));
                ents = WorkTimeFact.FindAll(SearchCriterion, Expression.Eq(WorkTimeFact.Prop_CreateId, this.UserInfo.UserID));
                this.PageState.Add("WorkTimeFactList", ents);
            }
        }

        /// <summary>
        /// 批量保存
        /// </summary>
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

        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                WorkTimeFact.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion
    }
}

