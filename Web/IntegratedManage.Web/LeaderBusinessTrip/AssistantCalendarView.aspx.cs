using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim;
using System.Data;
using System.Configuration;

namespace IntegratedManage.Web
{
    public partial class AssistantCalendarView : IMListPage
    {
        string startDate = string.Empty;
        string endDate = string.Empty;
        string type = string.Empty;   //日期类型

        protected void Page_Load(object sender, EventArgs e)
        {
            startDate = RequestData.Get<string>("startDate");
            endDate = RequestData.Get<string>("endDate");
            type = RequestData.Get<string>("type");
            if (string.IsNullOrEmpty(startDate) && string.IsNullOrEmpty(endDate))
            {
                type = "week";
                startDate = GetMondayDate(DateTime.Now).ToShortDateString();
                endDate = GetSundayDate(DateTime.Now).ToShortDateString();
            }
            switch (this.RequestActionString)
            {
                case "getTrip":
                    GetTrip();
                    break;
                case "getToolTip":
                    GetToolTip();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }

        private void GetTrip()
        {
            string ids = this.RequestData.Get<string>("IdSet");
            if (!string.IsNullOrEmpty(ids))
            {

                string[] idset = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(t => { return "'" + t + "'"; }).ToArray();
                string sql = @"select * from BJKY_IntegratedManage..LeaderBusinessTrip where Id in ({0}) ";
                sql = string.Format(sql, string.Join(",", idset));
                this.PageState.Add("Ents", DataHelper.QueryDictList(sql));

            }
        }

        /// <summary>
        /// 获取ToolTip信息
        /// </summary>
        private void GetToolTip()
        {
            string sql = string.Empty;
            if (RequestData.Get<string>("viewType") + "" == "month")
            {
                string Ids = this.RequestData.Get<string>("Ids");
                string year = RequestData.Get<string>("year");
                string month = RequestData.Get<string>("month");

                sql = @"select * from BJKY_IntegratedManage..LeaderBusinessTrip where '{0}' like '%'+id+'%' 
                        and (DATEPART(year,TripStartTime)={1} and DATEPART(year,TripStartTime)={1}) 
                        and (DATEPART(month,TripStartTime)={2} or DATEPART(month,TripStartTime)={2})";
                sql = string.Format(sql, Ids, year, month);
                PageState.Add("TipEnt", DataHelper.QueryDictList(sql));
            }
            else
            {
                string LeaderId = this.RequestData.Get<string>("LeaderId");
                string Date = this.RequestData.Get<string>("Date");
                sql = "select * from BJKY_IntegratedManage..LeaderBusinessTrip where LeaderId='{0}' and (TripStartTime <='{1}' and TripEndTime >='{1}') ";
                sql = string.Format(sql, LeaderId, Date);
                PageState.Add("TipEnt", DataHelper.QueryDictList(sql));
            }
        }

        /// <summary>
        /// 默认查询当前所在周
        /// </summary>
        private void DoSelect()
        {
            string sql = string.Empty;
            if (string.IsNullOrEmpty(type)) return;
            switch (type)
            {
                case "week": //周视图
                    sql = @"with T1
                            As(
                                select * from BJKY_IntegratedManage..LeaderBusinessTrip  
                                where (TripStartTime >= '{0}' and TripStartTime <= '{1}')  or (TripEndTime >= '{0}' and TripEndTime <= '{1}') or 
                                (TripStartTime < '{0}' and TripEndTime > '{1}')                             
                            ) ,
                            T3 As( 
                            select 
                                Id,LeaderId,LeaderName,Theme,Addr,TripStartTime,TripEndTime,                               
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '2' THEN   Theme  End as  'Mon',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '3' THEN   Theme  End as  'Tue',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '4' THEN   Theme  End  as  'Wed',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '5' THEN   Theme  End  as  'Thu',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '6' THEN   Theme  End  as  'Fri',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '7' THEN   Theme  End  as  'Sat',
                                CASE WHEN DATEPART(WEEKDAY, TripStartTime) = '1' THEN   Theme  End  as 'Sun'
                            from T1
                            )
                            select T3.*,T3.Id+'##'+ CONVERT(varchar(100),TripStartTime, 120)+'##'+ isnull(T3.Theme,'')+'##AA##'+CONVERT(varchar(100),TripEndTime, 120)+'##'+ Addr As Rows
                            from T3 ";

                    if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
                    {
                        sql = string.Format(sql, startDate, DateTime.Parse(endDate).AddDays(1));
                    }
                    break;
                case "month":
                    sql = @"with T1
                            As(
                                select *,Max(Id) OVER(PARTITION BY LeaderId,Month(TripStartTime)) as ComId
                                from BJKY_IntegratedManage..LeaderBusinessTrip  
                                where year(TripStartTime) ='{0}'
                            ),
                        T2 As( 
                        select 
                            Id,LeaderId,ComId,LeaderName,Theme,Addr,TripStartTime,TripEndTime,
                            CASE WHEN Month(TripStartTime) = 1 THEN Theme  End as  'January',
                            CASE WHEN Month(TripStartTime) = 2 THEN Theme  End as 'February',
                            CASE WHEN Month(TripStartTime) = 3 THEN Theme  end  as  'March',
                            CASE WHEN Month(TripStartTime) = 4 THEN Theme  end  as  'April',
                            CASE WHEN Month(TripStartTime) = 5 THen Theme  end  as  'May',
                            CASE WHEN Month(TripStartTime) = 6 THEN Theme  end  as  'June',
                            CASE WHEN Month(TripStartTime) = 7 THEN Theme  end  as  'July',
                            CASE WHEN Month(TripStartTime) = 8 THEN Theme  end  as  'August',
                            CASE WHEN Month(TripStartTime) = 9 THEN Theme  end  as  'September',
                            CASE WHEN Month(TripStartTime) = 10 THEN Theme  end  as  'October',
                            CASE WHEN Month(TripStartTime) = 11 THEN Theme  end  as  'November',
                            CASE WHEN Month(TripStartTime) = 12 THEN Theme  end  as  'December'
                         from T1
                        ) 
                       select T2.*,T2.Id+'##'+ CONVERT(varchar(100),TripStartTime, 120)+'##'+ isnull(T2.Theme,'')+'##aa##'+CONVERT(varchar(100),TripEndTime, 120)+'##'+ Addr As Rows from T2";
                    sql = string.Format(sql, DateTime.Parse(startDate).Year);
                    break;
            }

            //领导人
            string LeadersSql = @" select UserId,UserName As Leader,SortIndex from BJKY_IntegratedManage..InstituteLeader ";

            IList<EasyDictionary> LeaderEnts = GetPageData(LeadersSql, SearchCriterion, " order by SortIndex ");
            IList<EasyDictionary> ContentEnts = DataHelper.QueryDictList(sql);


            sql = @"select * from BJKY_IntegratedManage..LeaderBusinessTrip where (TripStartTime >= '{0}' and TripStartTime <= '{1}')  
                    or (TripEndTime >= '{0}' and TripEndTime <= '{1}') or (TripStartTime < '{0}' and TripEndTime > '{1}')";

            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                sql = string.Format(sql, startDate, DateTime.Parse(endDate).AddDays(1));
            }
            sql = string.Format(sql, startDate, endDate);
            this.PageState.Add("LeaderTripEnts", DataHelper.QueryDictList(sql));

            switch (type)
            {
                case "week":
                    string[] WeekArr = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" };
                    GetTypeViewData(WeekArr, LeaderEnts, ContentEnts);
                    break;
                case "day":
                    string[] dayArr = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty", "Twenty-one", "Twenty-two", "Twenty-three" };
                    GetTypeViewData(dayArr, LeaderEnts, ContentEnts);
                    break;
                case "month":
                    string[] monthArr = { "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January", "February" };
                    GetTypeViewData(monthArr, LeaderEnts, ContentEnts);
                    break;

            }
        }

        //不同视图的呈现
        public void GetTypeViewData(string[] typeArr, IList<EasyDictionary> LeaderEnts, IList<EasyDictionary> ConteEnts)
        {
            //*******************公共部分********************
            DataTable renderDt = new DataTable();
            string[] CommonFields = { "Id", "LeaderId", "ComId", "LeaderName", "Theme", "Addr", "TripStartTime", "TripEndTime" };
            foreach (string str in CommonFields)
            {
                DataColumn tempDc = new DataColumn(str);
                renderDt.Columns.Add(tempDc);
            }
            DataColumn dc = new DataColumn("Leader");
            renderDt.Columns.Add(dc);
            //************************************************ 

            foreach (var v in typeArr)
            {
                DataColumn dayDc = new DataColumn(v);
                renderDt.Columns.Add(dayDc);
            }
            foreach (EasyDictionary leader in LeaderEnts)
            {
                DataRow dr = renderDt.NewRow();
                IList<EasyDictionary> tempEnts = ConteEnts.Where(ten => leader["UserId"].ToString() == ten["LeaderId"].ToString()).ToArray();
                if (tempEnts.Count > 0)
                {
                    foreach (var com in CommonFields)
                    {
                        dr[com] = tempEnts[0][com];
                    }
                }
                foreach (EasyDictionary items in tempEnts)
                {
                    foreach (string str in typeArr)
                    {
                        if (!string.IsNullOrEmpty(items[str].ToString()))
                        {
                            dr[str] = items["Rows"].ToString();
                        }
                    }
                }
                dr["LeaderId"] = leader["UserId"].ToString();
                dr["Leader"] = leader["Leader"].ToString();
                renderDt.Rows.Add(dr);
            }
            this.PageState.Add("DataList", DataHelper.DataTableToDictList(renderDt));
        }


        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search, string orderby)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            //string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
            //string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " desc" : " asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by UserId) as RowNumber
		    FROM ({0}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {1} and {2} and 1=1 ";
            pageSql = string.Format(pageSql, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            if (!string.IsNullOrEmpty(orderby))
            {
                pageSql = pageSql.Replace("and 1=1", orderby);
            }
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }


        public static DateTime GetMondayDate(DateTime someDate)
        {
            int i = someDate.DayOfWeek - DayOfWeek.Monday;
            if (i == -1) i = 6;
            TimeSpan ts = new TimeSpan(i, 0, 0, 0);
            return someDate.Subtract(ts);
        }

        public static DateTime GetSundayDate(DateTime someDate)
        {
            int i = someDate.DayOfWeek - DayOfWeek.Sunday;
            if (i != 0) i = 7 - i;
            TimeSpan ts = new TimeSpan(i, 0, 0, 0);
            return someDate.Add(ts);
        }

        private int DayDiff(DateTime dt1, DateTime dt2)
        /*返回相差的天数*/
        {
            string dateDiff = string.Empty;
            TimeSpan ts1 = new TimeSpan(dt1.Ticks);
            TimeSpan ts2 = new TimeSpan(dt2.Ticks);
            return ts1.Subtract(ts2).Days;
        }
    }
}
