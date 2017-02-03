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
    public partial class TripEdit : IMListPage
    {

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            LeaderBusinessTrip ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<Model.LeaderBusinessTrip>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<Model.LeaderBusinessTrip>();

                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Model.LeaderBusinessTrip>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;

                default:
                    if (RequestActionString == "checkDate")
                    {
                        CheckDate();
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = Model.LeaderBusinessTrip.Find(id);
                }
                this.SetFormData(ent);
            }
        }


        //验证日期
        private void CheckDate()
        {
            string LeaderId = RequestData.Get<string>("LeaderId");
            string StartDate = RequestData.Get<string>("StartDate");
            string EndDate = RequestData.Get<string>("StartDate");

            string sql = @"select count(1) from BJKY_IntegratedManage..LeaderBusinessTrip where  LeaderId='{0}' and TripStartTime <= '{1}' and TripEndTime >='{2}' ";
            sql = string.Format(sql, LeaderId, StartDate, EndDate);
            object obj = DataHelper.QueryValue(sql);
            if (obj != null)
            {
                PageState.Add("state", "1");
            }
            else
            {
                PageState.Add("state", "0");
            }
        }
    }
}
