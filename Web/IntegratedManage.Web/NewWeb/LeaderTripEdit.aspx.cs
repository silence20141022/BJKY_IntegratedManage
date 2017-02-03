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
using Aim;

namespace IntegratedManage.Web
{
    public partial class LeaderTripEdit : IMListPage
    {
        string UserIds = string.Empty;
        LeaderTrip ent = null;
        string sql = "";
        string ColumnId = "";
        string TripId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            UserIds = RequestData.Get<string>("UserIds");
            ColumnId = RequestData.Get<string>("ColumnId");
            TripId = RequestData.Get<string>("TripId");
            string JsonStr = RequestData.Get<string>("JsonStr");
            int seconds = 0;
            switch (this.RequestActionString)
            {
                case "update":
                    ent = JsonHelper.GetObject<LeaderTrip>(JsonStr);
                    seconds = 0;
                    if (ent.StartAMPM == "PM")
                    {
                        seconds = 11 * 60 * 60 + 59 * 60 + 59;
                    }
                    ent.TripStartTime = ent.TripStartTime.Value.AddSeconds(seconds);
                    seconds = 0;
                    if (ent.EndAMPM == "AM")
                    {
                        seconds = 11 * 60 * 60 + 59 * 60 + 59;
                    }
                    if (ent.EndAMPM == "PM")
                    {
                        seconds = 23 * 60 * 60 + 59 * 60 + 59;
                    }
                    ent.TripEndTime = ent.TripEndTime.Value.AddSeconds(seconds);
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = JsonHelper.GetObject<LeaderTrip>(JsonStr);
                    if (ent.StartAMPM == "PM")
                    {
                        seconds = 11 * 60 * 60 + 59 * 60 + 59;
                    }
                    ent.TripStartTime = ent.TripStartTime.Value.AddSeconds(seconds);
                    seconds = 0;
                    if (ent.EndAMPM == "AM")
                    {
                        seconds = 11 * 60 * 60 + 59 * 60 + 59;
                    }
                    if (ent.EndAMPM == "PM")
                    {
                        seconds = 23 * 60 * 60 + 59 * 60 + 59;
                    }
                    ent.TripEndTime = ent.TripEndTime.Value.AddSeconds(seconds);
                    ent.DoCreate();
                    break;
                case "delete":
                    ent = LeaderTrip.Find(TripId);
                    ent.DoDelete();
                    break;
                case "endTrip":
                    ent = this.GetMergedData<LeaderTrip>();
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
            if (!string.IsNullOrEmpty(TripId))
            {
                ent = LeaderTrip.Find(TripId);
            }
            else
            {
                ent = new LeaderTrip();
                if (!string.IsNullOrEmpty(UserIds))
                {
                    ent.UserIds = UserIds;
                    SysUser suEnt = SysUser.Find(UserIds);
                    ent.UserNames = suEnt.Name;
                }
                if (!string.IsNullOrEmpty(ColumnId))
                {
                    string dt = ColumnId.Substring(0, ColumnId.Length - 2);
                    ent.TripStartTime = Convert.ToDateTime(dt);
                    ent.StartAMPM = ColumnId.Substring(ColumnId.Length - 2, 2);
                    ent.TripEndTime = Convert.ToDateTime(dt);
                    ent.CreateName = UserInfo.Name;
                    ent.EndAMPM = "PM";
                }
                else
                {
                    ent.CreateName = UserInfo.Name;
                    ent.TripStartTime = Convert.ToDateTime(DateTime.Now.ToShortDateString().Replace("/", "-"));
                    ent.StartAMPM = "AM";
                    ent.TripEndTime = Convert.ToDateTime(DateTime.Now.ToShortDateString().Replace("/", "-"));
                    ent.EndAMPM = "PM";
                }
                //如果当前用户在领导信息清单中，直接将领导名称设置为当前登录人，否则 为空
                IList<InstituteLeader> ilEnts = InstituteLeader.FindAllByProperty(InstituteLeader.Prop_UserId, UserInfo.UserID);
                if (ilEnts.Count > 0)
                {
                    ent.UserIds = UserInfo.UserID;
                    ent.UserNames = UserInfo.Name;
                }
            }
            SetFormData(ent);
            PageState.Add("FormData", ent);
            sql = "select * from BJKY_IntegratedManage..InstituteLeader order by SortIndex asc";
            PageState.Add("LeaderData", DataHelper.QueryDictList(sql));
        }
    }
}

