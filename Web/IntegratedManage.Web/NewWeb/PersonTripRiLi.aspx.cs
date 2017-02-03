using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim;
using System.Data;
using Newtonsoft.Json.Linq;
using IntegratedManage.Model;

namespace IntegratedManage.Web
{
    public partial class PersonTripRiLi : IMListPage
    {
        string sql = "";
        int year = DateTime.Now.Year;
        int currentWeek = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(RequestData.Get<string>("currentWeek")))
            {
                currentWeek = GetWeekOfYear();
            }
            else
            {
                currentWeek = RequestData.Get<int>("currentWeek");
                year = RequestData.Get<int>("year");
            }
            switch (RequestActionString.ToLower())
            {
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string where = "";
            if (IsAsyncRequest)
            {
                foreach (string str in RequestData.Keys)
                {
                    if (!string.IsNullOrEmpty(RequestData[str] + ""))
                    {
                        switch (str)//在排序和分页的时候会传递其他的Key过来 防止报错所以没有用default
                        {
                            //case "BeginDate":
                            //    where += "and TripStartTime >='" + RequestData[str].ToString() + " 00:00:00'";
                            //    break;
                            //case "EndDate":
                            //    where += "and TripEndTime<='" + RequestData[str].ToString() + " 23:59:59'";
                            //    break;
                            case "UserName":
                                where += " and " + str + " like '%" + RequestData[str].ToString().Replace(" ", "") + "%'";
                                break;
                        }
                    }
                }
            }
            PageState.Add("currentWeek", currentWeek);
            PageState.Add("year", year);
            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("UserIds");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserNames");
            dt.Columns.Add(dc);
            DateTime startdate = GetDaysOfWeeks(year, currentWeek);
            for (int i = 0; i < 7; i++)
            {
                dc = new DataColumn(startdate.AddDays(i).ToShortDateString().Replace("/", "-") + "AM");
                dt.Columns.Add(dc);
                dc = new DataColumn(startdate.AddDays(i).ToShortDateString().Replace("/", "-") + "PM");
                dt.Columns.Add(dc);
            }
            //表格列构建完毕;接下根据领导个数插入行数据
            sql = "select * from BJKY_IntegratedManage..InstituteLeader where UserId='" + UserInfo.UserID + "'" + where;
            IList<EasyDictionary> dics = null;
            foreach (EasyDictionary udic in GetPageData(sql, SearchCriterion))
            {
                DataRow dr = dt.NewRow();
                dr["UserIds"] = udic.Get<string>("UserId");
                dr["UserNames"] = udic.Get<string>("UserName");
                for (int i = 0; i < 7; i++)
                {
                    sql = "select * from BJKY_IntegratedManage..LeaderTrip where UserIds like '%{0}%' and TripStartTime <='{1}' and TripEndTime >='{1}'";
                    sql = string.Format(sql, udic.Get<string>("UserId"), startdate.AddDays(i).ToShortDateString() + " 00:00:00");
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        dr[startdate.AddDays(i).ToShortDateString().Replace("/", "-") + "AM"] = dics[0].Get<string>("Id") + "@" + dics[0].Get<string>("TripType") + "@" + dics[0].Get<string>("Reason");
                    }
                    sql = "select * from BJKY_IntegratedManage..LeaderTrip where UserIds like '%{0}%' and TripStartTime <='{1}' and TripEndTime >='{1}'";
                    sql = string.Format(sql, udic.Get<string>("UserId"), startdate.AddDays(i).ToShortDateString() + " 12:00:00");
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        dr[startdate.AddDays(i).ToShortDateString().Replace("/", "-") + "PM"] = dics[0].Get<string>("Id") + "@" + dics[0].Get<string>("TripType") + "@" + dics[0].Get<string>("Reason");
                    }
                }
                dt.Rows.Add(dr);
            }
            PageState.Add("DataList", dt);
            PageState.Add("ColumnData", dt.Columns);
        }
        // 获取指定日期所在周的第一天，星期天为第一天  
        public DateTime GetDateTimeWeekFirstDaySun(DateTime dateTime)
        {
            DateTime firstWeekDay = DateTime.Now;
            try
            {
                //得到是星期几，然后从当前日期减去相应天数   
                int weeknow = Convert.ToInt32(dateTime.DayOfWeek);
                int daydiff = (-1) * weeknow;
                firstWeekDay = dateTime.AddDays(daydiff);
            }
            catch { }
            return firstWeekDay;
        }
        // 获取指定日期所在周的最后一天，星期六为最后一天  
        public DateTime GetDateTimeWeekLastDaySat(DateTime dateTime)
        {
            DateTime lastWeekDay = DateTime.Now;
            try
            {
                int weeknow = Convert.ToInt32(dateTime.DayOfWeek);
                int daydiff = (7 - weeknow) - 1;
                lastWeekDay = dateTime.AddDays(daydiff);
            }
            catch { }
            return lastWeekDay;
        }
        //c#获取当前日期是今年第几周 
        private int GetWeekOfYear()
        {
            //一.找到第一周的最后一天（先获取1月1日是星期几，从而得知第一周周末是几）
            int firstWeekend = 7 - Convert.ToInt32(DateTime.Parse(DateTime.Today.Year + "-1-1").DayOfWeek);
            //二.获取今天是一年当中的第几天
            int currentDay = DateTime.Today.DayOfYear;
            //三.（今天 减去 第一周周末）/7 等于 距第一周有多少周 再加上第一周的1 就是今天是今年的第几周了
            // 刚好考虑了惟一的特殊情况就是，今天刚好在第一周内，那么距第一周就是0 再加上第一周的1 最后还是1
            return Convert.ToInt32(Math.Ceiling((currentDay - firstWeekend) / 7.0)) + 1;
        }
        /// <summary>
        /// 获取指定周数的开始日期和结束日期，开始日期为周日
        /// </summary>
        /// <param name="year">年份</param>
        /// <param name="index">周数</param>
        /// <param name="first">当此方法返回时，则包含参数 year 和 index 指定的周的开始日期的 System.DateTime 值；如果失败，则为 System.DateTime.MinValue。</param>
        /// <param name="last">当此方法返回时，则包含参数 year 和 index 指定的周的结束日期的 System.DateTime 值；如果失败，则为 System.DateTime.MinValue。</param>
        /// <returns></returns>
        public DateTime GetDaysOfWeeks(int year, int index)
        {
            DateTime first = DateTime.MinValue;
            //if (year < 1700 || year > 9999)
            //{
            //    //"年份超限"
            //    return false;
            //}
            //if (index < 1 || index > 53)
            //{
            //    //"周数错误"
            //    return false;
            //}
            DateTime startDay = new DateTime(year, 1, 1);  //该年第一天
            DateTime endDay = new DateTime(year + 1, 1, 1).AddMilliseconds(-1);
            int dayOfWeek = 0;
            if (Convert.ToInt32(startDay.DayOfWeek.ToString("d")) > 0)
                dayOfWeek = Convert.ToInt32(startDay.DayOfWeek.ToString("d"));  //该年第一天为星期几
            if (dayOfWeek == 7) { dayOfWeek = 0; }
            if (index == 1)
            {
                first = startDay;
                //if (dayOfWeek == 6)
                //{
                //    last = first;
                //}
                //else
                //{
                //    last = startDay.AddDays((6 - dayOfWeek));
                //}
            }
            else
            {
                first = startDay.AddDays((7 - dayOfWeek) + (index - 2) * 7); //index周的起始日期
                //last = first.AddDays(6);
                //if (last > endDay)
                //{
                //    last = endDay;
                //}
            }
            //if (first > endDay)  //startDayOfWeeks不在该年范围内
            //{
            //    //"输入周数大于本年最大周数";
            //    return false;
            //}
            return first;
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "SortIndex";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " asc" : " desc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
    }
}

