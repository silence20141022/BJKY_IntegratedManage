using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using System.Data;
using IntegratedManage.Model;
using Aim;
using Telerik.Web.UI.Calendar.View;
using Telerik.Web.UI;
using Aim.Portal.Model;
using System.IO;
using NHibernate.Criterion;
using System.Xml;
using System.Xml.Linq;
using System.Net;
using System.Text;
using Newtonsoft.Json.Linq;

namespace IntegratedManage.Web
{
    public partial class NewHome : IMBasePage
    {
        string sql = "";
        FileItem fiEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SysUser suEnt = SysUser.Find(UserInfo.UserID);
                string action = Request["action"] + "";
                switch (action)
                {
                    case "upload":
                        string fileId = Request["fileId"];
                        if (!string.IsNullOrEmpty(suEnt.Ext2))
                        {
                            fiEnt = FileItem.Find(suEnt.Ext2);
                            fiEnt.DoDelete();//如果存在旧的图像将旧的图像文件删除
                            FileInfo fi = new FileInfo(@"D:\RW\Files\AppFiles\Portal\Default\" + fiEnt.Id + "_" + fiEnt.Name);
                            if (fi.Exists)
                            {
                                fi.Delete();
                            }
                        }
                        suEnt.Ext2 = fileId;
                        suEnt.DoUpdate();
                        Response.Write(fileId);
                        Response.End();
                        break;
                    default:
                        if (!string.IsNullOrEmpty(suEnt.Ext2))
                        {
                            fiEnt = FileItem.Find(suEnt.Ext2);
                            this.userimage.Src = @"/Document/" + fiEnt.Id + "_" + fiEnt.Name;
                        }
                        break;
                }
                IniPersonalCenter();
                IniWeather();
                IniNotice();
                IniNews();
                IniMyLink();
                IniTaskWebPart();
                //PromptWin();
            }
        }
        private void IniPersonalCenter()
        {
            int taskQuantity = 0;
            sql = "select count(Id) from Task where status=0 and OwnerId='" + UserInfo.UserID + "'";
            taskQuantity = DataHelper.QueryValue<int>(sql);
            sql = "select count(Id)from BJKY_BeAdmin..WfWorkList where (State='New' and  isnull(OwnerUserId,'')<>'') and IsSign='" + UserInfo.UserID + "'";
            taskQuantity += DataHelper.QueryValue<int>(sql);
            sql = @"select Count(Id) from BJKY_IntegratedManage..SurveyQuestion c where (select count(1) from BJKY_IntegratedManage..SurveyCommitHistory t
                  where t.SurveyId=c.Id and t.SurveyedUserId='" + UserInfo.UserID + "')=0 and (isnull(StatisticsPower,'')='' or PatIndex('%" + UserInfo.UserID + "%',StatisticsPower)>0)";
            taskQuantity += DataHelper.QueryValue<int>(sql);
            sql = @"select count(Id) from BJKY_MiddleDB..TaskMiddle where (State='New' or State='0') and OwnerUserId='" + UserInfo.UserID + "'";
            taskQuantity += DataHelper.QueryValue<int>(sql);
            if (taskQuantity > 0)
            {
                divTask.Style.Remove("background-image");
                divTask.Style.Add("background-image", "url(/images/center/task2.png)");
                divTaskQuan.Visible = true;
                divTaskQuan.InnerHtml = taskQuantity.ToString();
            }
            else
            {
                divTask.Style.Remove("background-image");
                divTask.Style.Add("background-image", "url(/images/center/task.png)");
                divTaskQuan.Visible = false;
            }
            int noticeQuan = 0;//统计未读通知公告数量通知和公告两种类型的ID TypeId in ('eb9db227-6adc-4dd1-8783-467aadc2d11b','a0365551-9017-49f2-b416-14c6bbd8be9b')
            sql = @"select count(Id) from News where (TypeId='a0365551-9017-49f2-b416-14c6bbd8be9b' or TypeId='eb9db227-6adc-4dd1-8783-467aadc2d11b') and 
                PATINDEX ( '%" + UserInfo.UserID + "%' , ReadState )<=0 and State='2'";
            noticeQuan = DataHelper.QueryValue<int>(sql);
            if (noticeQuan > 0)
            {
                divNotice.Style.Remove("background-image");
                divNotice.Style.Add("background-image", "url(/images/center/notice2.png)");
                NoticeQuan.Visible = true;
                NoticeQuan.InnerHtml = noticeQuan.ToString();
            }
            else
            {
                divNotice.Style.Remove("background-image");
                divNotice.Style.Add("background-image", "url(/images/center/notice.png)");
                NoticeQuan.Visible = false;
            }
            int messageQuan = 0;
            ICriterion crit = Expression.Or(Expression.Eq("IsReceiverDelete", false), Expression.IsNull("IsReceiverDelete"));
            crit = SearchHelper.IntersectCriterions(crit, Expression.IsNull(View_SysMessage.Prop_IsFirstView), Expression.Eq(View_SysMessage.Prop_ReceiveId, UserInfo.UserID)
                , Expression.IsNull(View_SysMessage.Prop_IsDelete));
            View_SysMessage[] mgs = View_SysMessage.FindAll(SearchCriterion, crit);
            messageQuan = mgs.Length;
            if (messageQuan > 0)
            {
                divMessage.Style.Remove("background-image");
                divMessage.Style.Add("background-image", "url(/images/center/message2.png)");
                MessageQuan.Visible = true;
                MessageQuan.InnerHtml = messageQuan.ToString();
            }
            else
            {
                divMessage.Style.Remove("background-image");
                divMessage.Style.Add("background-image", "url(/images/center/message.png)");
                MessageQuan.Visible = false;
            }
        }
        public string GetInfo(string url)
        {
            string strBuff = "";
            Uri httpURL = new Uri(url);
            ///HttpWebRequest类继承于WebRequest，并没有自己的构造函数，需通过WebRequest的Creat方法 建立，并进行强制的类型转换   
            HttpWebRequest httpReq = (HttpWebRequest)WebRequest.Create(httpURL);
            ///通过HttpWebRequest的GetResponse()方法建立HttpWebResponse,强制类型转换   
            HttpWebResponse httpResp = (HttpWebResponse)httpReq.GetResponse();
            ///GetResponseStream()方法获取HTTP响应的数据流,并尝试取得URL中所指定的网页内容   
            ///若成功取得网页的内容，则以System.IO.Stream形式返回，若失败则产生ProtoclViolationException错 误。在此正确的做法应将以下的代码放到一个try块中处理。这里简单处理   
            Stream respStream = httpResp.GetResponseStream();
            ///返回的内容是Stream形式的，所以可以利用StreamReader类获取GetResponseStream的内容，并以   
            //StreamReader类的Read方法依次读取网页源程序代码每一行的内容，直至行尾（读取的编码格式：UTF8）   
            StreamReader respStreamReader = new StreamReader(respStream, Encoding.UTF8);
            strBuff = respStreamReader.ReadToEnd();
            return strBuff;
        }
        private void IniWeather()
        {
            string url = "http://api.map.baidu.com/telematics/v3/weather?location=%E5%8C%97%E4%BA%AC&output=json&ak=WQdRBeDGxNGC2Ajs9hmSl6F9EZX2iYFn";
            string jsonstr = GetInfo(url);
            JObject jo = JsonHelper.GetObject<JObject>(jsonstr);
            Literal4.Text = "";
            if (jo.Value<string>("error") == "0")//如果返回成功
            {
                JArray ja_results = jo.Value<JArray>("results");
                if (ja_results.Count > 0)
                {
                    JArray ja_weather = ja_results[0].Value<JArray>("weather_data");
                    if (ja_weather.Count > 0)
                    {
                        foreach (JObject json in ja_weather)
                        {
                            Literal4.Text += "<tr>";
                            Literal4.Text += "<td >" + json.Value<string>("date") + "</td>";
                            Literal4.Text += "<td style='width:16%'>" + json.Value<string>("weather") + "</td>";
                            Literal4.Text += "<td style='width:19%'>" + json.Value<string>("temperature") + "</td>";
                            Literal4.Text += "<td style='width:16%'><img src='" + json.Value<string>("dayPictureUrl") + "'  /></td>";
                            Literal4.Text += "</tr>";
                        }
                    }
                }
            }
        }
        private void IniNotice()
        {
            //通知和公告两种类型的信息WebPart2 
            sql = @"declare @path varchar(500)
                select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                where UserId='{0}' 
                select top 5 n.Id,n.Title,n.PostDeptName,Convert(varchar(10),PostTime,20) as NewTime  from News n 
                inner join NewsType nt on nt.Id=n.TypeId 
                where TypeId in('eb9db227-6adc-4dd1-8783-467aadc2d11b','a0365551-9017-49f2-b416-14c6bbd8be9b')
                and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0)) order by PostTime desc ";
            //增加了通知和公告信息浏览的权限过滤
            //sql = @"select top 5 * ,Convert(varchar(10),PostTime,20) as NewTime from News where 
            //TypeId in ('eb9db227-6adc-4dd1-8783-467aadc2d11b','a0365551-9017-49f2-b416-14c6bbd8be9b') and State='2' order by PostTime desc";
            sql = string.Format(sql, UserInfo.UserID);
            DataTable dt = DataHelper.QueryDataTable(sql);
            Literal1.Text = @"<table cellpadding='0' cellspacing='0' width='100%' style='border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1;table-layout:fixed;height:140px'>";
            foreach (DataRow row in dt.Rows)
            {
                Literal1.Text += "<tr style='vertical-align:middle;height:28.5px'><td class='new-img'><img src='/images/center/little.png' /></td><td class='new-font-family' onclick='shownotice(\"" + row["Id"] + "\")'>" +
                row["Title"] + "</td><td style='font-size: 12px;width:100px;padding-left:5px;white-space: nowrap;word-break: keep-all;overflow: hidden;'>" + row["PostDeptName"] + "</td><td class='new-date'>" + row["NewTime"] + "</td></tr>";
            }
            Literal1.Text += "</table>";
        }
        private void IniNews()
        {
            //图片区域显示图片新闻；文字区域显示公司新闻  2014-1-24修改 by panhuaguo
            sql = @"select top 6 *,Convert(varchar(10),PostTime,20) as NewTime from News where 
                 TypeId='fa67b910-a692-4df7-83a2-50711ba4bfa5' and State='2' order by PostTime desc";
            DataTable dt1 = DataHelper.QueryDataTable(sql);
            sql = @"select top 5 *,Convert(varchar(10),PostTime,120) NewTime from 
                  (select top 5 Id,Title,PostTime,'ImgNews' as Type,ShowImg from ImgNEWS  
                  where State='2' order by PostTime DESC
                  union 
                  select top 5 Id,Title,PostTime,'News' as Type,Pictures as ShowImg from News where TypeId='fa67b910-a692-4df7-83a2-50711ba4bfa5' and State='2' and 
                  isnull(Pictures,'')!='' order by PostTime desc) t order by PostTime desc";
            IList<EasyDictionary> dicImgs = DataHelper.QueryDictList(sql);
            Literal2.Text = @"<table cellpadding='0' cellspacing='0' width='100%' style='table-layout:fixed'>";
            foreach (DataRow trow in dt1.Rows)
            {
                Literal2.Text += "<tr style='vertical-align:middle;height:28.5px'><td class='new-img'><img src='/images/center/little.png' /></td><td class='new-font-family' style='cursor:pointer;white-space:nowrap;word-break:keep-all;overflow: hidden' onclick='shownotice(\"" + trow["Id"] + "\")'>" +
                    trow["Title"] + "</td><td class='new-date'>" + trow["NewTime"] + "</td></tr>";
            }
            Literal2.Text += "</table>";
            foreach (EasyDictionary dicImg in dicImgs)//初始化首页图片
            {
                if (dicImg.Get<string>("Type") == "ImgNews")
                {
                    // dicImg.Set("ShowImg", DataHelper.QueryValue("select top 1 ImgPath from dbo.ImgNewDetail where PId='" + dicImg.Get<string>("Id") + "' order by CreateTime"));
                    litimg.Text += @"<a href='#'><img src='/Document/" + dicImg.Get<string>("ShowImg").Replace(",", "") + "' alt='" + dicImg.Get<string>("Title") + "'"
                    + "onclick=\"showimgnews('" + dicImg.Get<string>("Id") + "')\" width='320' height='177' /></a>";
                }
                else
                {
                    litimg.Text += @"<a href='#'><img src='/Document/" + dicImg.Get<string>("ShowImg").Replace(",", "") + "' alt='" + dicImg.Get<string>("Title") + "'"
                        + "onclick=\"shownotice('" + dicImg.Get<string>("Id") + "')\" width='320' height='177' /></a>";
                }
            }
        }
        private void IniMyLink()
        {
            sql = @"select top 5 *  from BJKY_IntegratedManage..WebLink where (IsAdmin='1' and 
            PatIndex('%" + UserInfo.UserID + "%',isnull(ExceptUserId,''))<=0) or CreateId='" + UserInfo.UserID + "'  order by CreateTime asc";
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            Literal3.Text = @"<table cellpadding='0' cellspacing='0' width='100%' style='border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1;table-layout:fixed;height:140px'>";
            for (int i = 0; i < dics.Count; i++)
            {
                Literal3.Text += "<tr style='vertical-align:middle;height:28.5px'><td class='new-img'><img src='/images/center/little.png' /></td><td class='new-font-family'><span style='text-decoration:underline' onclick=\"showmylink('" + dics[i].Get<string>("Url") + "')\">" + dics[i].Get<string>("WebName") + "</span></td></tr>";
            }
            Literal3.Text += "</table>";
        }
        private void IniTaskWebPart()
        {
            //把调查问卷也放到待办任务里面来 
            sql = @"select top 5 Id,Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,RelateName,System,Type,ExecUrl,RelateType,OwnerUserId,
                    convert(varchar(10),CreatedTime,20) as NewDate from 
                    (                               
                    select top 5 Id,(WorkFlowName+'--'+ApprovalNodeName) Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,CreatedTime,'综合办公' RelateName,'' System,'' as Type,'' ExecUrl,'' RelateType,'' OwnerUserId
                    from Task where status=0 and OwnerId='{0}' order by CreatedTime desc 
                    union   
                    select top 5 Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,'综合办公' RelateName,System, Type,
                    ExecUrl,RelateType,OwnerUserId from BJKY_BeAdmin..WfWorkList where (State='New' and  isnull(OwnerUserId,'')<>'' ) and IsSign='{0}' order by Id Desc 
                    union  
                    select top 5 Id,Title,'' WorkFlowInstanceId,'' WorkFlowName,'' ApprovalNodeName,CreateTime,'问卷调查' Relatename,'' System,'Questionare' Type,'' ExecUrl,'' RelateType,'' OwnerUserId
                    from BJKY_IntegratedManage..SurveyQuestion c where (isnull(StatisticsPower,'')='' or PatIndex('%{0}%',StatisticsPower)>0) and (select count(1) from BJKY_IntegratedManage..SurveyCommitHistory t
                    where t.SurveyId=c.Id and t.SurveyedUserId='{0}')=0 order by CreateTime desc    
                    union 
                    select top 5 Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' as Type,
                    ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskMiddle where (State='New' or State='0') and OwnerUserId='{0}' order by CreateTime desc           
                    ) a order by Createdtime desc";
            sql = string.Format(sql, UserInfo.UserID);
            DataTable dttask = DataHelper.QueryDataTable(sql);
            if (dttask.Rows.Count == 0)
            {
                litdetail1.Text = "暂无待审批任务!";
            }
            else
            {
                litdetail1.Text = @"<table cellpadding='0' cellspacing='0' width='100%' style='table-layout:fixed'>";
                foreach (DataRow row in dttask.Rows)
                {
                    string tr = "<tr style='vertical-align:middle;height:28.5px'><td class='new-img'><img src='/images/center/little.png' /></td><td class='new-font-family' onclick='OpenNews(\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\")'>{6}</td><td style='width:60px'>{7}</td><td class='new-date'>{8}</td></tr>";
                    tr = string.Format(tr, "/WorkFlow/TaskExecute.aspx?TaskId=" + row["Id"] + "&op=r", row["Type"], row["Id"], row["WorkFlowInstanceId"], row["RelateType"], row["ExecUrl"], row["Title"], (row["RelateName"] + "").Replace("系统", ""), row["NewDate"]);
                    litdetail1.Text += tr;
                }
                litdetail1.Text += "</table>";
            }
            //已办
            sql = @"select top 5 Id,Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,RelateName,System,Type,ExecUrl,RelateType,OwnerUserId,
                    convert(varchar(10),CreatedTime,20) as NewDate from 
                    (                           
                    select top 5 Id,(WorkFlowName+'--'+ApprovalNodeName) Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,CreatedTime,'综合办公' RelateName,'' System,'' as Type,'' ExecUrl,'' RelateType,'' OwnerUserId
                    from Task where status<>0 and OwnerId='{0}' order by CreatedTime desc                       
                    union 
                    select top 5 Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,'综合办公' RelateName,System,Type,
                    ExecUrl,RelateType,OwnerUserId from BJKY_BeAdmin..WfWorkList where (isnull(State,'')<>'New' and  isnull(OwnerUserId,'')<>'' ) and IsSign='{0}' order by Id Desc 
                    union
                    select top 5 Id,Title,'' WorkFlowInstanceId,'' WorkFlowName,'' ApprovalNodeName,CreateTime,'问卷调查' Relatename,'' System,'Questionare' Type,'' ExecUrl,'' RelateType,'' OwnerUserId
                    from BJKY_IntegratedManage..SurveyQuestion c where (isnull(StatisticsPower,'')='' or PatIndex('%{0}%',StatisticsPower)>0) and (select count(1) from BJKY_IntegratedManage..SurveyCommitHistory t
                    where t.SurveyId=c.Id and t.SurveyedUserId='{0}')>0 order by CreateTime desc  
                    union 
                    select top 5 Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' Type,
                    ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskMiddle where isnull(State,'')<>'New' and isnull(State,'')<>'0' 
                    and OwnerUserId='{0}' and System!='科研管理系统' order by CreateTime desc                     
                    union 
                    select top 5 Id,(FlowName+'--'+TaskName) Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,System as RelateName,System,'MiddleDB' Type,
                    ExecUrl,RelateType,OwnerUserId from BJKY_MiddleDB..TaskFinishMiddle where isnull(State,'')<>'New' and isnull(State,'')<>'0' 
                    and OwnerUserId='{0}' and System='科研管理系统' order by CreateTime desc     
                    ) a  order by Createdtime desc";
            sql = string.Format(sql, UserInfo.UserID);
            dttask = DataHelper.QueryDataTable(sql);
            if (dttask.Rows.Count == 0)
            {
                litdetail2.Text = "暂无已办任务!";
            }
            else
            {
                litdetail2.Text = @"<table cellpadding='0' cellspacing='0' width='100%' style='table-layout:fixed'>";
                foreach (DataRow row in dttask.Rows)
                {
                    string tr = "<tr style='vertical-align:middle;height:28.5px'><td class='new-img'><img src='/images/center/little.png' /></td><td class='new-font-family' onclick='OpenNews(\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\",\"{5}\")'>{6}</td><td style='width:60px'>{7}</td><td class='new-date'>{8}</td></tr>";
                    tr = string.Format(tr, "/WorkFlow/TaskExecute.aspx?TaskId=" + row["Id"] + "&op=r", row["Type"], row["Id"], row["WorkFlowInstanceId"], row["RelateType"], row["ExecUrl"], row["Title"], (row["RelateName"] + "").Replace("系统", ""), row["NewDate"]);
                    litdetail2.Text += tr;
                }
                litdetail2.Text += "</table>";
            }
        }
        private void PromptWin()
        {
            //弹窗后下次登录时不需要弹出 特追加如下代码
            sql = @"declare @path varchar(300)
                        select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                        where UserId='{0}' 
                        select n.Id,n.Title,n.TypeId,[State],ExpireTime,HomePagePopup,ReceiveUserId from News n 
                        inner join NewsType nt on nt.Id=n.TypeId 
                        where charindex('{0}',convert(varchar(max),isnull(ReadState,'')))=0 and datediff(dd,PostTime,getdate())< 31                       
                        and State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                        and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                        exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                        or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))
                        and HomePagePopup='on' and n.TypeId in('eb9db227-6adc-4dd1-8783-467aadc2d11b','a0365551-9017-49f2-b416-14c6bbd8be9b')";
            sql = string.Format(sql, UserInfo.UserID);
            IList<EasyDictionary> PromptDics = DataHelper.QueryDictList(sql);
            string js = "<script type='text/javascript'>";
            News nEnt = null;
            for (int i = 0; i < PromptDics.Count; i++)
            {
                nEnt = News.Find(PromptDics[i].Get<string>("Id"));
                js += "opencenterwin('/NewWeb/NoticeView.aspx?id=" + PromptDics[i].Get<string>("Id") + "', 'prompt" + i + "',1100, 600);";
                if (String.IsNullOrEmpty(nEnt.ReadState))
                {
                    nEnt.ReadState = UserInfo.UserID;
                }
                else
                {
                    nEnt.ReadState = nEnt.ReadState + "," + UserInfo.UserID;
                }
                nEnt.DoUpdate();
            }
            js += "</script>";
            Literal5.Text = js;
        }
        protected void FormatSpecialDay(object sender, EventArgs e)
        {
            RadCalendar1.SelectedDate = DateTime.Now;
            RadCalendar1.SpecialDays.Clear();
            DateTime startDate = ((MonthView)RadCalendar1.CalendarView).MonthStartDate;
            DateTime endDate = ((MonthView)RadCalendar1.CalendarView).MonthEndDate;
            IList<Holiday> holEnts = Holiday.FindAllByProperty("Date", Holiday.Prop_Year, DateTime.Now.Year.ToString());
            foreach (Holiday holEnt in holEnts)
            {
                if (holEnt.Date.HasValue)
                {
                    Telerik.Web.UI.RadCalendarDay rcd = new Telerik.Web.UI.RadCalendarDay();
                    rcd.Date = holEnt.Date.Value;
                    rcd.ItemStyle.CssClass = "myclass";
                    RadCalendar1.SpecialDays.Add(rcd);
                }
            }
        }
    }
}
