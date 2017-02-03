<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="AssistantCalendarView.aspx.cs" Inherits="IntegratedManage.Web.AssistantCalendarView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .x-grid3-row td, .x-grid3-summary-row td
        {
            height: 32px;
            border-right: dashed 1px #8894a3;
            border-bottom: solid 1px #8894a3;
        }
        .extClnsOneColor
        {
            /*调整第一列的颜色*/ /* background: #EDEDED;*/
            background: rgb(187,187,187);
            text-align: center;
            vertical-align: middle;
        }
        .nav
        {
            background-color: rgb(245,160,102);
            height: 20px;
        }
        .dateBar
        {
            padding-top: 3px;
        }
        .datebar .x-grid3-cell-inner
        {
            background-color: rgb(245,160,102);
        }
        .x-grid3-row TD
        {
            padding-left: 0 !important;
            padding-right: 0 !important;
        }
        .context
        {
            font-family: Arial;
            font-size: 12px;
            margin-top: 5px;
        }
        .checked
        {
            background-color: #edf2d2;
            border-bottom: solid 1 #4f5455;
            border-left: solid 1 #4f5455;
            border-right: solid 1 #4f5455;
        }
        .hintStyle
        {
            width: 220px;
            float: left;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: left;
        }
    </style>

    <script type="text/javascript">
        var store, myData, grid;
        var monthStore, dayStore, weekStore;
        var count = 0, type = "week";            //默认周视图,count:日期翻页计数
        var stDate = $.getDateFrom('week');      //开始时间
        var edDate = $.dateAdd(stDate, 'd', 6);  //结束时间
        var isUrlOrOpenWin = false;              // grid rowclick 

        function onPgLoad() {
            setPgUI();
            //reSetBtnStyle();
            dateAreaBar(); //日期跨度条

        }

        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            //myData.records = margeObj(myData.records);
            // "Id", "LeaderId", "ComId", "LeaderName", "Theme", "TripStartTime", "TripEndTime" Leader
            var weekFields = [
			    { name: 'Id' }, { name: 'Addr' }, { name: 'LeaderId' }, { name: 'Theme' }, { name: 'Leader' }, { name: 'TripStartTime' }, { name: 'TripEndTime' },
			    { name: 'Mon' }, { name: 'Tue' }, { name: 'Wed' }, { name: 'Thu' }, { name: 'Fri' }, { name: 'Sat' },
			    { name: 'Sun' }, { name: 'WeekDay' }, { name: 'IdSet' }
			    ];
            var monthFields = [
			    { name: 'Id' }, { name: 'Addr' }, { name: 'LeaderId' }, { name: 'Theme' }, { name: 'Leader' }, { name: 'TripStartTime' }, { name: 'TripEndTime' }, { name: 'Rows' },
			    { name: 'March' }, { name: 'April' }, { name: 'May' }, { name: 'June' }, { name: 'July' }, { name: 'August' },
			    { name: 'September' }, { name: 'October' }, { name: 'November' }, { name: 'December' }, { name: 'January' }, { name: 'February' }
			    ];
            //默认store (week)
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: weekFields,
                listeners: {
                    aimbeforeload: function(proxy, options) {
                        options.data.startDate = stDate;
                        options.data.endDate = edDate;
                        options.data.type = type;
                    }
                }
            });

            //-----------------------------------//
            var monthCln = [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'Addr', dataIndex: 'Addr', header: '地点', hidden: true },
					{ id: 'Leader', dataIndex: 'Leader', header: '领导(Leader)', width: 100, sortable: true, menuDisabled: true, renderer: RowRender },
					{ id: 'January', dataIndex: 'January', header: '一月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'February', dataIndex: 'February', header: '二月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'March', dataIndex: 'March', header: '三月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'April', dataIndex: 'April', header: '四月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'May', dataIndex: 'May', header: '五月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'June', dataIndex: 'June', header: '六月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'July', dataIndex: 'July', header: '七月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'August', dataIndex: 'August', header: '八月', resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'September', dataIndex: 'September', header: '九月', menuDisabled: true, renderer: RowRender },
					{ id: 'October', dataIndex: 'October', header: '十月', menuDisabled: true, renderer: RowRender },
					{ id: 'November', dataIndex: 'November', header: '十一月', menuDisabled: true, renderer: RowRender },
					{ id: 'December', dataIndex: 'December', header: '十二月', menuDisabled: true, renderer: RowRender }

                    ];

            var weekCln = [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'Addr', dataIndex: 'Addr', header: '地点', hidden: true },
					{ id: 'Leader', dataIndex: 'Leader', header: '领导(Leader)', width: 100, sortable: true, menuDisabled: true, renderer: RowRender },
					{ id: 'Mon', dataIndex: 'Mon', header: '周一', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Tue', dataIndex: 'Tue', header: '周二', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Wed', dataIndex: 'Wed', header: '周三', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Thu', dataIndex: 'Thu', header: '周四', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Fri', dataIndex: 'Fri', header: '周五', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Sat', dataIndex: 'Sat', header: '周六', width: 145, resizable: false, menuDisabled: true, renderer: RowRender },
					{ id: 'Sun', dataIndex: 'Sun', header: '周日', width: 145, resizable: false, menuDisabled: true, renderer: RowRender }
                    ];
            colModel = new Ext.grid.ColumnModel({
                columns: weekCln,
                defaults: {
                //css: 'background-color :#e4f0f8;'
            }
        });

        //-----------------------------------按钮功能区------------------------------------------//
        pgBar = new Ext.ux.AimPagingToolbar({
            pageSize: AimSearchCrit["PageSize"],
            store: store
        });

        tlBar = new Ext.ux.AimToolbar({
            items: [{
                id: 'btnWeek',
                text: '周视图',
                iconCls: 'aim-icon-zhou',
                enableToggle: true,
                handler: function() {
                    type = "week"; count = 0;

                    Ext.getCmp("btnMonth").toggle(false);
                    Ext.getCmp("before").setText("上一周");
                    Ext.getCmp("next").setText("下一周");

                    colModel.setConfig(weekCln);
                    setWeek(count);
                    var weekConfig = {
                        dsname: 'DataList',
                        idProperty: 'Id',
                        data: myData,
                        fields: weekFields,
                        listeners: {
                            aimbeforeload: function(proxy, options) {
                                options.data.startDate = stDate;
                                options.data.endDate = edDate;
                                options.data.type = type;
                            }
                        }
                    };

                    weekStore = new Ext.ux.data.AimJsonStore(weekConfig);
                    grid.reconfigure(weekStore, colModel);
                    dateAreaBar();
                    // weekStore.reload();
                }
            }, {
                id: 'btnMonth',
                text: '月视图',
                enableToggle: true,
                iconCls: 'aim-icon-yue',
                handler: function() {
                    type = "month"; count = 0;
                    Ext.getCmp("btnWeek").toggle(false);

                    Ext.getCmp("before").setText("上一年");
                    Ext.getCmp("next").setText("下一年");

                    colModel.setConfig(monthCln);
                    setMonth(count);
                    stDate = $.getDatePart();

                    var monthConfig = {
                        dsname: 'DataList',
                        idProperty: 'Id',
                        data: myData,
                        fields: monthFields,

                        listeners: {
                            aimbeforeload: function(proxy, options) {
                                options.data.startDate = stDate;
                                options.data.endDate = edDate;
                                options.data.type = 'month';
                            }
                        }
                    };

                    monthStore = new Ext.ux.data.AimJsonStore(monthConfig);
                    grid.reconfigure(monthStore, colModel);
                    //grid.autoExpandColumn = "Leader";
                    monthStore.reload();

                    $('[class$="x-grid3-row-table"]').each(function() {
                        $(this).css({ heigth: "100px" });
                    });
                }
            }, '-', {
                id: 'before',
                iconCls: 'aim-icon-leftrrow',
                text: '上一周',
                handler: function() { /*左*/
                    count--; //用来计数
                    setDatePaging(count);
                    dateAreaBar();
                }
            }, ' ', {
                id: "next",
                iconCls: 'aim-icon-rightrrow',
                text: '下一周',
                handler: function() {  /*右*/
                    count++;
                    setDatePaging(count);
                    dateAreaBar();
                }
            }, '-',
                {
                    id: 'display',
                    xtype: 'tbtext',
                    text: stDate.getFullYear() + '年' + (stDate.getMonth() + 1) + '月' + stDate.getDate() + '日' + "-" + (edDate.getMonth() > stDate.getMonth() ? ((edDate.getMonth() + 1) + "月") : '') + edDate.getDate() + '日'
                }, '-',
               {
                   text: '刷新',
                   iconCls: 'aim-icon-undo',
                   handler: function() {
                       switch (type) {
                           case "week":
                               if (weekStore) {
                                   weekStore.reload();
                               } else {
                                   store.reload();
                               }
                               dateAreaBar();
                               break;
                           case "month":
                               monthStore.reload();
                               break;
                       }
                   }
               }
]
        });

        //---------------------------grid-----------------------------------------//

        grid = new Ext.ux.grid.AimGridPanel({
            store: store,
            region: 'center',
            viewConfig: { forceFit: true, scrollOffset: 0 },
            cm: colModel,
            bbar: pgBar,
            tbar: tlBar
        });

        grid.on('celldblclick', function(grid, rowIndex, columnIndex, e) {
            click = true;
            if (isUrlOrOpenWin) {
                isUrlOrOpenWin = false;
                return;
            }
            if (type == 'week') {
                if (columnIndex <= 3) return;
                var year = new Date().getFullYear();
                var dateStr = year + "/" + grid.getColumnModel().getColumnHeader(columnIndex).match(/\d+/g).join("/");
                var LeaderId = grid.getStore().getAt(rowIndex).get("LeaderId");
                var LeaderName = escape(grid.getStore().getAt(rowIndex).get("Leader"));

                var url = "LeaderBusinessTripEdit.aspx?op=c&type=assistant" + "&Start=" + dateStr + "&LeaderId=" + LeaderId + "&LeaderName=" + LeaderName;
                if (columnIndex > 2) openModelWin(url, "", 820, 400);  //
            }

            // opencenterwin("LeaderBusinessTripEdit.aspx?op=c", "", 900, 620);
        });


        grid.on('render', function(grid) {
            var view = grid.getView();    // Capture the GridView.
            grid.tip = new Ext.ToolTip({
                id: 'gridTip',
                // draggable: true,          //允许拖动
                target: view.mainBody,    // The overall target element. 
                delegate: '.x-grid3-cell', // Each grid row causes its own seperate show and hide. 
                trackMouse: true,         // Moving within the row should not hide the tip.   
                renderTo: document.body,  // Render immediately so that tip.body can be referenced prior to the first show. 
                listeners: {              // Change content dynamically depending on which element triggered the show.
                    beforeshow: function updateTipBody(tip) {

                        var rowIndex = view.findRowIndex(tip.triggerElement);
                        var colIndex = view.findCellIndex(tip.triggerElement);
                        var clnId = grid.getColumnModel().getColumnId(colIndex);

                        var store = grid.getStore();
                        var val = store.getAt(rowIndex).get(clnId);
                        //Ext.getCmp("gridTip").enable();  //显示该组件
                        if (type == "week") {

                            //区间段
                            if (tip.triggerElement.className.indexOf("dateBar") > -1) {
                                var LeaderId = store.getAt(rowIndex).get("LeaderId");
                                var year = new Date().getFullYear();
                                var header = year + "-" + grid.getColumnModel().getColumnHeader(colIndex).match(/\d+/g).join("-");
                                $.ajaxExec("getToolTip", { LeaderId: LeaderId, Date: header }, function(rtn) {
                                    var obj = rtn.data.TipEnt[0] || {}
                                    var theme = obj.Theme || '';
                                    var stDate = obj.TripStartTime || '';
                                    var edDate = obj.TripEndTime || '';
                                    var addr = obj.Addr || '';
                                    tip.body.dom.innerHTML = tooTip(theme, stDate, edDate, addr);
                                })

                            } else if (grid.getStore().getAt(rowIndex).get(clnId)) {
                                //同一天
                                if (grid.getStore().getAt(rowIndex).get(clnId).indexOf("##") > -1) {
                                    var arr = grid.getStore().getAt(rowIndex).get(clnId).split("##");

                                    var Id = arr[0], startTime = arr[1] || '', Theme = arr[2] || '', IdSet = arr[3] || '', endTime = arr[4] || '', addr = arr[5] || '';
                                    tip.body.dom.innerHTML = tooTip(Theme, startTime, endTime, addr);
                                } else {
                                    var theme = store.getAt(rowIndex).get("Theme") || '';
                                    var stDate = store.getAt(rowIndex).get("TripStartTime") || ''
                                    var edDate = store.getAt(rowIndex).get("TripEndTime") || '';
                                    var addr = store.getAt(rowIndex).get("Addr") || '';
                                    tip.body.dom.innerHTML = tooTip(theme, stDate, edDate, addr);
                                }
                            } else {  //无数据情况
                                tip.body.dom.innerHTML = "";
                                return false;
                            }
                        }
                        else if (type == "month") {
                            tip.body.dom.innerHTML = "";
                            return false;
                        }

                    }
                }
            });
        });


        //设置week
        var startDate = $.getDateFrom('week');
        grid.colModel.columns[4].header = '(' + (startDate.getMonth() + 1) + "/" + startDate.getDate() + ')' + '周一';
        grid.colModel.columns[5].header = '(' + ($.dateAdd(startDate, 'd', 1).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 1).getDate() + ")" + '周二';
        grid.colModel.columns[6].header = '(' + ($.dateAdd(startDate, 'd', 2).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 2).getDate() + ')' + '周三';
        grid.colModel.columns[7].header = '(' + ($.dateAdd(startDate, 'd', 3).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 3).getDate() + ')' + '周四';
        grid.colModel.columns[8].header = '(' + ($.dateAdd(startDate, 'd', 4).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 4).getDate() + ')' + '周五';
        grid.colModel.columns[9].header = '(' + ($.dateAdd(startDate, 'd', 5).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 5).getDate() + ')' + '周六';
        grid.colModel.columns[10].header = '(' + ($.dateAdd(startDate, 'd', 6).getMonth() + 1) + "/" + $.dateAdd(startDate, 'd', 6).getDate() + ')' + '周日';

        // 页面视图
        viewport = new Ext.ux.AimViewport({
            items: [grid]
        });

    }

    /*日期翻页*/
    function setDatePaging(count) {
        switch (type) {
            case "week":
                var startDate = setWeek(count);
                var endDate = $.dateAdd(startDate, 'd', 6);

                stDate = startDate.getFullYear() + "-" + (startDate.getMonth() + 1) + "-" + startDate.getDate();
                edDate = endDate.getFullYear() + "-" + (endDate.getMonth() + 1) + "-" + endDate.getDate();
                if (endDate.getMonth() > startDate.getMonth()) {
                    Ext.getCmp("display").setText(startDate.getFullYear() + '年' + (startDate.getMonth() + 1) + '月' + startDate.getDate() + '日' + "-" + (endDate.getMonth() + 1) + '月' + endDate.getDate() + '日');
                } else {
                    Ext.getCmp("display").setText(startDate.getFullYear() + '年' + (startDate.getMonth() + 1) + '月' + startDate.getDate() + '日' + "-" + endDate.getDate() + '日');
                }
                if (weekStore) {
                    weekStore.reload();
                } else {
                    store.reload();
                }
                break;
            case "month":
                startDate = setMonth(count);
                stDate = startDate.getFullYear() + "-" + (startDate.getMonth() + 1) + "-" + startDate.getDate();
                Ext.getCmp("display").setText(startDate.getFullYear() + '年' + "1月-12月");
                monthStore.reload();
                break;
        }
    }

    //-----------------------------------调整表头日期-----------------------------
    function setMonth(count) {
        /*调整Month*/
        var monthDate = $.getDateFrom('year');
        var startDate = $.dateAdd(monthDate, 'y', count);
        Ext.getCmp('display').setText(startDate.getFullYear() + '年' + '1月-12月');
        return startDate;
    }
    function setWeek(count) {
        /*调整week,返回开始日期*/
        var weekDate = $.getDateFrom('week');
        var startDate = $.dateAdd(weekDate, 'w', count);

        Ext.getCmp('display').setText(startDate.getFullYear() + '年' + (startDate.getMonth() + 1) + '月' + startDate.getDate() + '日' + "-" + ($.dateAdd(startDate, 'd', 6).getMonth() > startDate.getMonth() ? (($.dateAdd(startDate, 'd', 6).getMonth() + 1) + "月") : '') + $.dateAdd(startDate, 'd', 6).getDate() + '日');

        var tempDate = $.dateAdd(startDate, 'd', 0); //一
        grid.getColumnModel().setColumnHeader(4, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周一');
        tempDate = $.dateAdd(startDate, 'd', 1); //二
        grid.getColumnModel().setColumnHeader(5, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周二');
        tempDate = $.dateAdd(startDate, 'd', 2); //三
        grid.getColumnModel().setColumnHeader(6, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周三');
        tempDate = $.dateAdd(startDate, 'd', 3); //四
        grid.getColumnModel().setColumnHeader(7, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周四');
        tempDate = $.dateAdd(startDate, 'd', 4); //五
        grid.getColumnModel().setColumnHeader(8, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周五');
        tempDate = $.dateAdd(startDate, 'd', 5); //六
        grid.getColumnModel().setColumnHeader(9, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周六');
        tempDate = $.dateAdd(startDate, 'd', 6); //日
        grid.getColumnModel().setColumnHeader(10, "(" + (tempDate.getMonth() + 1) + '/' + tempDate.getDate() + ")" + '周日');

        return startDate;
    }

    /*-------------------------RowRender------------------------------*/

    function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
        if (type == 'week') {

            return weekShow.call(this, value, cellmeta, record, rowIndex, columnIndex, store);
        }
        else if (type == 'month') {
            return monthShow.call(this, value, cellmeta, record, rowIndex, columnIndex, store);
        }
    }
    function monthShow(value, cellmeta, record, rowIndex, columnIndex, store) {
        var rtn = "";
        // cellmeta.attr = 'style="padding-left:0 !important;padding-right:0 !important; "';
        if (columnIndex > 3) {  //月份开始列
            if (value) {
                var arr = value.toString().split("##");
                var Id = arr[0] + (arr[3] || '')
                var txtTpl = "<div class=\"nav\" style='width:100%;' onclick='windowOpen(\"" + Id + "\",\"" + record.get("LeaderId") + "\")'> </div>";
                rtn = txtTpl;
            }
        } else {
            switch (this.id) {
                case "Leader":
                    cellmeta.css = "extClnsOneColor";
                    rtn = "<b>" + value + "</b>";
                    break;
            }
        }
        return rtn;
    }

    function weekShow(value, cellmeta, record, rowIndex, columnIndex, store) {
        /*week renderer*/
        var rtn = "";
        switch (this.id) {
            case "Mon":
            case "Tue":
            case "Wed":
            case "Thu":
            case "Fri":
            case "Sat":
            case "Sun":
                cellmeta.attr = 'style="padding-left:0 !important;padding-right:0 !important;"';
                if (value) {
                    var arr = value.toString().split("##");
                    var Id = arr[0], startTime = arr[1] || '', Theme = arr[2] || '', IdSet = arr[3] || '', endTime = arr[4] || '', addr = arr[5] || '';
                    var tip = tooTip(Theme, startTime.toString().replaceAll("-", "/"), endTime.toString().replaceAll("-", "/"), addr)
                    if (startTime == endTime) {
                        var txtTpl = "<div class=\"nav\"><span class=\"context\"  onclick='windowOpen(\"" + Id + "\")'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </span></div>";
                        rtn = txtTpl;
                    }
                }
                break;
            case "Leader":
                cellmeta.css = "extClnsOneColor";
                rtn = "<b>" + value + "</b>";
                break;
        }
        return rtn;
    }


    //----------------------------tooltip----------------------------------------/

    function tooTip(theme, startTime, endTime, addr, rowIndex) {

        var tpl_Div = '<div class="hintStyle"><table style="width: 100%; text-align: left; table-layout: fixed; font-variant: small-caps;font-size: 12px">';
        var tpl_Tr0 = '<tr style="font-size:12px;">';
        var tpl_Tr1 = '<td style="width:20%;font-weight: bold;" >&nbsp;&nbsp;主题</td><td style="width:55%">{Theme}</td></tr>';
        var tpl_Tr2 = '<tr><td style="font-weight: bold;">&nbsp;&nbsp;时间</td><td>{Time}</td></tr>';
        var tpl_Tr3 = '<tr><td style="font-weight: bold;">&nbsp;&nbsp;地点</td><td>{Addr}</td></tr>';
        var tpl = tpl_Div + tpl_Tr0 + tpl_Tr1 + tpl_Tr2 + tpl_Tr3 + '</table></div>';
        theme = theme || '';
        startTime = startTime || '';
        endTime = endTime || '';
        addr = addr || '';
        var time = theme ? (startTime + "").split(" ")[0] + " - " + (endTime + "").split(" ")[0] : '';
        var tempStr = tpl.replaceAll('{Theme}', theme.toString().length > 30 ? (theme.toString().substring(0, 30) + "...") : theme);
        tempStr = tempStr.replaceAll('{Time}', time);
        tempStr = tempStr.replaceAll('{Addr}', addr);
        return tempStr;
    }
    //----------------------------设置日期跨度条-----------------------------------/
    function dateAreaBar() {

        if (type == "month") return;  //月视图则跳过
        var ents;
        ents = AimState["LeaderTripEnts"];
        if (ents.length <= 0) return;


        var headerVal = $("#display").text().match(/\d+/g);

        var year = new Date().getFullYear();
        var mon = year + "/" + grid.getColumnModel().getColumnHeader(4).match(/\d+/g).join("/");
        var tue = year + "/" + grid.getColumnModel().getColumnHeader(5).match(/\d+/g).join("/");
        var wed = year + "/" + grid.getColumnModel().getColumnHeader(6).match(/\d+/g).join("/");
        var thu = year + "/" + grid.getColumnModel().getColumnHeader(7).match(/\d+/g).join("/");
        var fri = year + "/" + grid.getColumnModel().getColumnHeader(8).match(/\d+/g).join("/");
        var sat = year + "/" + grid.getColumnModel().getColumnHeader(9).match(/\d+/g).join("/");
        var sun = year + "/" + grid.getColumnModel().getColumnHeader(10).match(/\d+/g).join("/");

        var rows = {}, clns = {}; //row leaderId 分割
        var hintCln = [];         //命中的单元格
        var theme, sDate, eDate, addr; //record数据

        clns[Date.parse(mon)] = "x-grid3-td-Mon";
        clns[Date.parse(tue)] = "x-grid3-td-Tue";
        clns[Date.parse(wed)] = "x-grid3-td-Wed";
        clns[Date.parse(thu)] = "x-grid3-td-Thu";
        clns[Date.parse(fri)] = "x-grid3-td-Fri";
        clns[Date.parse(sat)] = "x-grid3-td-Sat";
        clns[Date.parse(sun)] = "x-grid3-td-Sun";
        for (var i = 0; i < myData.records.length; i++) {
            rows[myData.records[i]["LeaderId"]] = i;
        }
        for (var i = 0; i < myData.records.length; i++) {
            var obj = {};
            for (var v = 0; v < ents.length; v++) {
                if (myData.records[i]["LeaderId"] == ents[v]["LeaderId"]) {
                    obj.arr = [];
                    obj.isMore = false;
                    obj.LeaderId = myData.records[i]["LeaderId"];
                    var diff = $.dateDiff($.toDate(ents[v]["TripStartTime"]), $.toDate(ents[v]["TripEndTime"]), 'd');  //获取相差的天数
                    obj.arr.push(ents[v]["TripStartTime"].split(" ")[0]);
                    if (diff > 0) {
                        addr = ents[v]["Addr"];
                        theme = ents[v]["Theme"];
                        sDate = ents[v]["TripStartTime"];
                        eDate = ents[v]["TripStartTime"];
                        for (var k = 0; k < 7 && k < diff; k++) {
                            var st = $.dateAdd($.toDate(ents[v]["TripStartTime"]), 'd', k + 1)
                            obj.arr.push($.getDatePart(st))
                        }
                        obj.isMore = true;
                    }
                }
            }
            hintCln.push(obj);
        }


        //这里执行填充
        var interval = setInterval(function() {
            if ($('body').length > 0) {
                window.clearInterval(interval);
                for (var i = 0; i < hintCln.length && (!!hintCln[i]); i++) {
                    if (hintCln[i]["isMore"] == true) {
                        var row = rows[hintCln[i]["LeaderId"]];  //行
                        var cell = [];                           //定位的单元格

                        for (var k = 0; k < hintCln[i]["arr"].length; k++) {
                            var obj = hintCln[i]["arr"];
                            if (clns[Date.parse(obj[k])]) cell.push(clns[Date.parse(obj[k])]);
                        }
                        for (var j = 0; j < cell.length; j++) {
                            //if (j == 0) {
                            //$(".x-grid3-row").eq(row).find('table td[class*=' + cell[j] + "]").find("div").remove().end().append("<div class='dateBar'>QQQQQ</div>");
                            $(".x-grid3-row").eq(row).find('table td[class*=' + cell[j] + "]").addClass("dateBar");
                            //} else {
                            // $(".x-grid3-row").eq(row).find('table td[class*=' + cell[j] + "]").addClass("dateBar").attr({ id: 'AAAAA' + i }).find("div").remove();
                            //}

                        }
                    }
                }
            }
        }, 320);

        //$('[class*="x-grid3-td-numberer"]').css({ "border-right": "solid 1px #8894a3" });
        //$('[class*="x-grid3-col-Leader]').css({ "font-size": "18px" });
        //$(".x-grid3-row ")
    }




    function OpenModelWin(url, params, style, onProcessFinish) {
        var ModelStyle = "dialogWidth:820px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
        params.rtntype = params.rtntype || "array";
        style = style || ModelStyle;
        url = $.combineQueryUrl(url, params);
        rtn = window.showModalDialog(url, window, style);

        if (rtn) {
            if (typeof (onProcessFinish) == "function") {
                onProcessFinish.call(rtn, params);
            }
        }
    }


    function openModelWin(url, name, iWidth, iHeight) {
        var style = "dialogWidth:800px; dialogHeight:380px; scroll:yes; center:yes; status:no; resizable:yes;";
        var state = window.showModalDialog(url, name, style);
        if (state) {
            window.location.reload();
        }
    }
    /*打开窗口*/
    function windowOpen(id, LeaderId) {
        isUrlOrOpenWin = true;
        var task = new Ext.util.DelayedTask();
        task.delay(100, function() {
            if (type == "month")
                opencenterwin("LeaderBusinessTrip.aspx?op=v&viewType=month&LeaderId=" + LeaderId + "&id=" + id, "", 800, 380);
            else
                opencenterwin("LeaderBusinessTripEdit.aspx?op=v&Id=" + id, "", 800, 380);
        });
    }
 
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
