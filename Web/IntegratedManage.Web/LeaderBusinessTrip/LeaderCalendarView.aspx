<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="LeaderCalendarView.aspx.cs" Inherits="IntegratedManage.Web.LeaderCalendarView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/js/fullcalendar/theme.css" rel="stylesheet" type="text/css" />
    <link href="/js/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />

    <script src="/js/fullcalendar/jquery-ui-1.8.23.custom.min.js" type="text/javascript"></script>

    <script src="/js/fullcalendar/fullcalendar.js" type="text/javascript"></script>

    <script type="text/javascript">
        var beforeId = '';  //记录上次提示的ID
        function onPgLoad() {
            setPgUI();
            $("th[class='fc-agenda-axis ui-widget-header']").each(function() {
                $(this).text($(this).text().replace('am', ''));
                $(this).text($(this).text().replace('pm', ''));
            });
            $("table[class='fc-header']").removeClass();   //移除title下方的空白

            $("#calendar table").eq(0).css({                 //head背景颜色
                "background-color": "#f2f4f6"
            });

            // markEventColor();
            // $(".fc-button-prev,fc-button-today,fc-button-next,fc-button-agendaWeek,fc-button-month").click(function() {
            //  markEventColor();
            // })

        }


        function markEventColor() {
            /*标注事件颜色*/
            $("div[sign]").each(function() {
                if ($(this).attr("sign") == "0") {
                    $(this).parent().css({ "border": "solid 2 #FF8000" });
                } else if ($(this).attr("sign") == "1") {
                }
            });
        }

        var calEvents = [];
        function setPgUI() {

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            calEvents = AimState["DataList"] || [];
            var calendar = $('#calendar').fullCalendar({
                theme: true,
                height: 560,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'agendaWeek,month'
                },
                titleFormat: {
                    month: 'MMMM yyyy',                             // September 2009
                    week: " yyyy 年 MMMM d[ yyyy] 日{ '至'[ MMM] d 日 }", // Sep 7 - 13 2009
                    day: 'dddd, MMM d, yyyy'                  // Tuesday, Sep 8, 2009
                },
                //columnFormat: {
                //week: 'ddd d MMM', // Mon 9/7
                //day: 'dddd d MMM'  // Monday 9/7
                //},
                axisFormat: 'H(:mm)tt',
                timeFormat: { // for event elements
                    '': 'H(:mm)t' // default
                },
                //allDaySlot: false,   //天的虚线
                //aspectRatio: 5,
                defaultView: 'agendaWeek',  //默认视图
                currentTimezone: 'Asia/Beijing',
                firstDay: 1, //星期一开始
                monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                today: ["今天"],
                buttonText: {
                    today: '今天',
                    week: '周',
                    month: '月'
                },
                firstHour: 7, //将默认时间定位到7点
                editable: true,
                selectable: true,
                selectHelper: true,
                select: function(start, end, allDay) {
                    var countStart = Date.parse(start);
                    var counterNow = Date.parse(new Date());
                    var dtStr = start;

                    var dtStr = $.getFullDate(start);
                    var endDate = $.getFullDate(end);
                    var url = "NotepadEdit.aspx" + "?op=c&type=calar&Start=" + dtStr + "&End=" + endDate;
                    win = window.showModalDialog(url, "_blank", 'dialogWidth=650px;dialogHeight=330px;center:1;scroll:0;help:0'); //模态窗口
                    if (win) {
                        var schdata = { allDay: allDay };
                        $.ajaxExecSync('getLast', { Id: win }, function(rtn) {

                            var obj = rtn.data.DataList || {};
                            var evtstart = $.toDate(obj.StartTime);
                            var evtend = $.toDate(obj.EndTime);

                            evtstart == evtend && (schdata.allDay = true);
                            schdata.title = "日程" + "[" + (obj.Theme || '').toString().substring(0, 30) + '...' + "]";
                            schdata.id = obj.Id;
                            schdata.start = evtstart
                            schdata.end = evtend;
                            schdata.url = "NotepadEdit.aspx?id=" + obj.Id;

                            //editable: false,  //禁止编辑事件,可拖动
                            //calendar.fullCalendar('renderEvent', schdata, true);
                            calendar.fullCalendar('renderEvent', schdata);
                            calendar.fullCalendar('unselect');
                            calendar.fullCalendar('eventClick');
                            //calendar.fullCalendar('updateEvent', event);

                        });
                    }

                },
                eventClick: function(ev) {
                    if (ev.url) {
                        var left = window.screen.width / 2 - (850 / 2);  //窗口居中
                        window.open(ev.url, '_blank', 'width=650,height=330,scrollbars=0,' + "left=" + left);
                        return false;
                    }
                },
                eventResize: function(calEvent, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) {

                    var start = calEvent.start;
                    var end = calEvent.end;
                    //   calEvent.start = start;
                    //   calEvent.end = $.dateAdd(end, 'n', minuteDelta);
                    start = $.getFullDate(start);
                    end = $.getFullDate(end);

                    $.ajaxExec("UpdateEvent", { id: calEvent.id, start: start, end: end }, function(rtn) {
                        $("#calendar").fullCalendar("updateEvent", calEvent);
                    })
                },
                eventDrop: function(calEvent, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {

                    var start = calEvent.start;
                    var end = calEvent.end;
                    if (allDay) {
                        start = $.getDatePart(start) + " 00:00:00";
                        end = $.getDatePart(end) + " 00:00:00";
                    }
                    else {
                        start = $.getFullDate(start);
                        end = $.getFullDate(end);
                    }
                    $.ajaxExec("UpdateEvent", { id: calEvent.id, start: start, end: end }, function(rtn) {
                        $("#calendar").fullCalendar("updateEvent", calEvent);
                    })
                },
                eventRender: function(event, element) {
                    var fstart = $.fullCalendar.formatDate(event.start, "HH:mm");
                    var fend = $.fullCalendar.formatDate(event.end, "HH:mm");
                },
                eventMouseover: function(event, jsEvent, view) {

                },
                mouseRightClick: function(event, jsEvent, view) {  /*鼠标右键的支持*/

                    // $(document).bind('contextmenu', function(e) { return false; }); //释放右键菜单
                },
                dayClick: function(dayDate, allDay, jsEvent, view) {

                },
                updateEvent: function() {

                },
                events: function(start, end, callback) {
                    var events = [];
                    for (var i = 0; i < calEvents.length; i++) {
                        var evtstart = $.toDate(calEvents[i].StartTime || '');
                        var evtend = $.toDate(calEvents[i].EndTime || '');
                        var obj = {
                            title: "日程" + "[" + (calEvents[i].Theme || '').toString().substring(0, 30) + '...' + "]",
                            start: evtstart,
                            end: evtend,
                            editable: true,  //禁止编辑事件,可拖动
                            confcolor: '#ff3f3f',
                            sign: calEvents[i]["State"],
                            id: calEvents[i].Id,
                            data: calEvents[i],
                            url: "NotepadEdit.aspx?id=" + (calEvents[i].Id || '')
                        };
                        if (evtstart.toString() == evtend.toString() && evtstart.toString().indexOf('0:00:00') > 0) {
                            obj.allDay = true;  // 指示事件是否至整天的
                        } else {
                            obj.allDay = false;
                        }
                        events.push(obj);
                    }
                    callback(events);
                }
            })
        }

    </script>

    <style type="text/css">
        body
        {
            margin-top: 40px;
            text-align: left;
            font-size: 14px;
            font-family: "Lucida Grande" ,Helvetica,Arial,Verdana,sans-serif;
        }
        #calendar
        {
            width: 1000px;
            margin: 0 auto;
            float: left;
        }
        .explan
        {
            margin-top: 30px;
            text-align: left;
            font-size: 14px;
            float: right;
            width: 17%;
            height: 517;
            background-color: #eaf3fa;
        }
        .tipheader
        {
            margin-top: 12px;
            margin-left: 50;
            font-size: 15px;
        }
        .fc-agenda-allday .fc-day-content
        {
            min-height: 60px; /* 调整allday 高度 */
            _height: 50px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div>
        <div id='calendar' style="width: 100%">
        </div>
    </div>
</asp:Content>
