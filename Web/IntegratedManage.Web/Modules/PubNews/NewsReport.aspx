<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsReport.aspx.cs" Inherits="Aim.Portal.Web.NewsReport" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Aim" %>
<%@ Import Namespace="Aim.Portal.Entity" %>
<%@ Import Namespace="Aim.Data" %>
<%@ Import Namespace="Aim.Web" %>
<%@ Import Namespace="Aim.Common" %>
<%@ Import Namespace="Aim.Web.UI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/App_Themes/Default/css/jquery-ui-1.8/redmond.css" />

    <link href="/Modules/WebPart/door1.css" type="text/css" rel="stylesheet" />
    <link href="/Modules/WebPart/style.css" type="text/css" rel="stylesheet" />
    
    <script src="/js/lib/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="/js/lib/jquery-ui-1.8.custom.min.js" type="text/javascript"></script>

    <script src="/js/common.js" type="text/javascript"></script>
    <script src="/js/pgform.js" type="text/javascript"></script>
    
    <script runat="server">

        protected string WeekHtml = String.Empty;
        protected string MonthHtml = String.Empty;
        protected string QuarterHtml = String.Empty;
        
        private void Page_Init(object sender, EventArgs e)
        {
            WeekHtml = GetHtml("Week");
            MonthHtml = GetHtml("Month");
            QuarterHtml = GetHtml("Quarter");
        }

        /// <summary>
        /// 获取内容类型
        /// </summary>
        /// <param name="ctype"></param>
        /// <returns></returns>
        private string GetHtml(string ctype)
        {
            StringBuilder html = new StringBuilder("<br />");

            string sqlformat = "SELECT top 6 Id, Code, Name, CreateTime, Type FROM PRJ_WeekReportSummary WHERE State = 'Published' AND Type = '{0}' ORDER BY CreateTime DESC";
            
            string strformat = @"<div class='linkdiv'><IMG SRC='/Modules/webPart/Icons/sms.gif' WIDTH='15' HEIGHT='10' BORDER='0' ALT=''>"
                + @"<a  onclick=""OpenNews('/EPC/Whole/PRJ_WeekReportSummaryEdit.aspx?id={0}&op=r');"" href='javascript:void(0);'>{1}</a></div>";

            DataTable dt = DataHelper.QueryDataTable(String.Format(sqlformat, ctype));

            if (dt != null)
            {
                string tlinkstr = String.Empty;
                
                foreach (DataRow drow in dt.Rows)
                {
                    tlinkstr = String.Format(strformat, StringHelper.IsNullValue(drow["Id"], string.Empty), StringHelper.IsNullValue(drow["Name"], string.Empty));

                    html.Append(tlinkstr);
                }
            }

            return html.ToString();
        }
        
    </script>

    <style type="text/css">
        body
        {
            margin: 0px;
            font-size: 12px;
            color: #003399;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            text-align: center;
        }
        #center
        {
            margin-right: auto;
            margin-left: auto;
        }
        .text-input
        {
            border: solid 1px #8FAACF;
        }
        .lbl-message
        {
            color: Red;
        }
        
        .ui-widget-header { border: 0; background: #ffffff; color: #ffffff; font-weight: bold; }
        .ui-widget-content { border: 0; background: #ffffff; color: #222222; }
        .ui-tabs { position: relative; padding: 0; zoom: 0; }
        .ui-tabs .ui-tabs-nav { margin: 0; padding: 0 0 0; }
        .ui-tabs .ui-tabs-nav li { list-style: none; float: left; position: relative; top: 0; margin: 0 0 0 0; border-bottom: 0 !important; padding: 0; white-space: nowrap; }
        .ui-tabs .ui-tabs-nav li a { float: left; padding: 0.1em 0.8em; text-decoration: none; }
        .ui-tabs .ui-tabs-nav li.ui-tabs-selected { margin-bottom: 0; padding-bottom: 0 }
        .ui-tabs .ui-tabs-panel { display: block; border: 0; padding: 0 0; background: none; }
    </style>

    <script language="javascript" type="text/javascript">
        var islogining = false;

        function onPgLoad() {
            $("#tabs").tabs();

        }
        
        function OpenNews(NewsUrl) {
            OpenWin(NewsUrl, "_Blank", CenterWin("width=810,height=550,resizable=yes,scrollbars=yes"));
        }
    </script>

</head>
<body onload="onPgLoad()" style="background-color: #ffffff;">
    <form method="post" runat="server">
        <div id="tabs">
	        <ul>
		        <li><a href="#tabs-1">周</a></li>
		        <li><a href="#tabs-2">月</a></li>
		        <li><a href="#tabs-3">季</a></li>
	        </ul>
	        <div id="tabs-1" align=left style="padding:5px; font-size:12px;">
	            <%=WeekHtml %>
	        </div>
	        <div id="tabs-2" align=left style="padding:5px; font-size:12px;">
	            <%=MonthHtml %>
	        </div>
	        <div id="tabs-3" align=left style="padding:5px; font-size:12px;">
	            <%=QuarterHtml %>
	        </div>
        </div>
        <hr style="border-style:dotted"></hr>
        <div align="right" style="padding:2px; font-size:12px;"><a  href='#' onclick="OpenNews('/EPC/Whole/WeekReportMaint.aspx?op=r&type=week&mode=portal','_blank');">更多</a></div>
    </form>
</body>
</html>
