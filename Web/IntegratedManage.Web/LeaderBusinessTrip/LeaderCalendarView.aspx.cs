using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim;
namespace IntegratedManage.Web
{
    public partial class LeaderCalendarView : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (RequestActionString)
            {
                case "getLast":
                    GetNewData();
                    break;
                case "UpdateEvent":
                    UpdateEvent();
                    break;
                default:
                    GetEvents();
                    break;
            }
        }


        private void UpdateEvent()
        {
            string start = RequestData.Get<string>("start");
            string end = RequestData.Get<string>("end");

            string id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                Model.NotePad ent = Model.NotePad.Find(id);
                ent.StartTime = DateTime.Parse(start);
                ent.EndTime = DateTime.Parse(end);
                ent.DoUpdate();
                this.PageState.Add("state", "ture");
            }
        }
        private void GetEvents()
        {
            string sql = @"select  top 120 * from  BJKY_IntegratedManage..NotePad where UserId='{0}' order by CreateTime desc ";
            sql = string.Format(sql, UserInfo.UserID);
            this.PageState.Add("DataList", DataHelper.QueryDictList(sql));
        }
        private void GetNewData()
        {
            string Id = this.RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                Model.NotePad ent = Model.NotePad.Find(Id);
                this.PageState.Add("DataList", ent);
            }

        }
    }
}
