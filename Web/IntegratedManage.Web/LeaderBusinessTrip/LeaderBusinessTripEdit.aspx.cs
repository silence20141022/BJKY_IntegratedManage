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
    public partial class LeaderBusinessTripEdit : IMListPage
    {
        public string Id = string.Empty;  //Id 
        public string seltype = string.Empty;  //是否单选

        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = this.RequestData.Get<string>("Id");
            IntegratedManage.Model.LeaderBusinessTrip ent = null;
            seltype = string.IsNullOrEmpty(RequestData.Get<string>("id")) ? "seltype='multi'" : "";

            switch (this.RequestActionString)
            {
                case "update":
                    ent = this.GetMergedData<IntegratedManage.Model.LeaderBusinessTrip>();
                    ent.DoUpdate();
                    this.PageState.Add("Id", ent.Id);
                    break;
                case "create":

                    ent = this.GetPostedData<IntegratedManage.Model.LeaderBusinessTrip>();
                    if (string.IsNullOrEmpty(ent.LeaderId))
                    {
                        ent.LeaderId = UserInfo.UserID;
                        ent.LeaderName = UserInfo.Name;
                    }
                    ent.State = "0";
                    DoCreteMutiPerson(ent);
                    this.PageState.Add("Id", ent.Id);
                    this.PageState.Add("StartDate", ent.TripStartTime);
                    this.PageState.Add("EndDate", ent.TripEndTime);
                    break;
                case "delete": //删除
                    if (!string.IsNullOrEmpty(Id))
                    {
                        ent = IntegratedManage.Model.LeaderBusinessTrip.Find(Id);
                        ent.DoDelete();
                    }
                    break;
                case "endTrip":
                    ent = this.GetMergedData<IntegratedManage.Model.LeaderBusinessTrip>();
                    ent.State = "1";
                    ent.DoUpdate();
                    break;
                case "checkDate":
                    CheckDate();
                    break;
                default:
                    DoSelect();
                    break;
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
        private void DoSelect()
        {
            IntegratedManage.Model.LeaderBusinessTrip ent = null;
            Id = this.RequestData.Get<string>("Id");
            Id = string.IsNullOrEmpty(Id) ? this.RequestData.Get<string>("id") : Id;
            if (!string.IsNullOrEmpty(Id))
            {
                ent = IntegratedManage.Model.LeaderBusinessTrip.Find(Id);
                this.SetFormData(ent);
            }
            else
            {
                string Leader = this.RequestData.Get<string>("LeaderId");
                string StartTime = this.RequestData.Get<string>("Start");
                string sql = "select * from BJKY_IntegratedManage..LeaderBusinessTrip where LeaderId='{0}' and (TripStartTime <='{1}' and TripEndTime >='{1}')  ";
                sql = string.Format(sql, Leader, StartTime);
                this.SetFormData(DataHelper.QueryDictList(sql).SingleOrDefault());
            }
        }

        public void DoCreteMutiPerson(IntegratedManage.Model.LeaderBusinessTrip ent)
        /*分拆多人*/
        {
            if (ent == null) return;
            if (ent.LeaderId.Length > 36)
            {
                string[] ArrID = ent.LeaderId.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                string[] ArrName = ent.LeaderName.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

                for (int i = 0; i < ArrID.Length; i++)
                {
                    IntegratedManage.Model.LeaderBusinessTrip tmpEnt = new IntegratedManage.Model.LeaderBusinessTrip();
                    tmpEnt = ent;
                    tmpEnt.LeaderId = ArrID[i];
                    tmpEnt.LeaderName = ArrName[i];
                    tmpEnt.DoCreate();
                }
            }
            else
            {
                ent.DoCreate();
            }

        }

    }
}

