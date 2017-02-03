<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="A_ChargeProgresList.aspx.cs" Inherits="IntegratedManage.Web.A_ChargeProgresList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=500,scrollbars=yes");
        var EditPageUrl = "A_ChargeProgresEdit.aspx";
        var TaskId = $.getQueryString({ "ID": "TaskId" });
        var IsInTab = $.getQueryString({ "ID": "IsInTab" });

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
            if (AimState["TaskModel"])
                document.title = AimState["TaskModel"].TaskName + "  评定信息";
            if (IsInTab == "true") {
                tlBar.hide();
            }
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["A_ChargeProgresList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'A_ChargeProgresList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Title' },
			{ name: 'TaskId' },
			{ name: 'TaskCode' },
			{ name: 'TaskName' },
			{ name: 'Progress' },
			{ name: 'ConfirmDate' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'Attachment' }
			], listeners: { "aimbeforeload": function(proxy, options) {
			    options.data = options.data || {};
			    options.data.op = pgOperation || null;
			    options.data.TaskId = TaskId;
			}
			}
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                items: [
                { fieldLabel: '评定内容', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
                 { fieldLabel: '日期从', id: 'CreateTimeStart', xtype: 'datefield', vtype: 'daterange', endDateField: 'CreateTimeEnd', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateTime' }"} },
                { fieldLabel: '至', id: 'CreateTimeEnd', xtype: 'datefield', vtype: 'daterange', startDateField: 'CreateTimeStart', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateTime' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加评定',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        jQuery.ajaxExec('charge', { "TaskId": TaskId }, function(rtn) {
                            if (rtn.data.Finish == "false") {
                                //alert("子任务没有完成,不允许增加评定!");
                                //return;
                            }
                            ExtOpenGridEditWin(grid, EditPageUrl + "?TaskId=" + TaskId, "c", EditWinStyle);

                        });
                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }

                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, '-', {
                    text: '导出Excel',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
                }, { text: '图形分析',
                    iconCls: 'aim-icon-chart', handler: function() {
                        ViewChart();
                    }
                }, '->',
                {
                    text: '查询',
                    iconCls: 'aim-icon-search',
                    handler: function() {
                        schBar.toggleCollapse(false);

                        setTimeout("viewport.doLayout()", 50);
                    }
}]
                });

                // 工具标题栏
                titPanel = new Ext.ux.AimPanel({
                    tbar: tlBar,
                    items: [schBar]
                });

                // 表格面板
                grid = new Ext.ux.grid.AimGridPanel({
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'Title',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Title', dataIndex: 'Title', header: '评定内容', linkparams: { url: EditPageUrl, style: EditWinStyle }, width: 100, sortable: true },
					{ id: 'Attachment', dataIndex: 'Attachment', header: '相关附件', width: 100, sortable: true, renderer: ExtGridFileRender },
					{ id: 'Progress', dataIndex: 'Progress', header: '进度%', width: 80, sortable: true },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '评定人', width: 100, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '评定日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
                });
            }

            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }

            function ViewChart() {
                var records = [];
                store.each(function(r) {
                    records.push(r.copy());
                });
                var statStore = new Ext.data.Store({
                    recordType: store.recordType
                });
                statStore.add(records);
                var tabPanel = new Ext.ux.AimTabPanel({
                    region: 'center',
                    margins: '3 3 3 0',
                    activeTab: 0,
                    width: 680,
                    height: 470,
                    border: false,
                    deferredRender: false,
                    defaults: { autoScroll: true, layout: 'fit' },
                    items: [{
                        title: '进度图(柱状图)',
                        layout: 'fit',
                        items: {
                            xtype: 'columnchart',
                            store: statStore,
                            autoScroll: true,
                            xField: 'CreateTime',
                            series: [{ yField: 'Progress', displayName: '进度'}],
                            extraStyle: {
                                legend: {
                                    display: 'bottom'
                                },
                                xAxis: {
                                    labelRotation: 30
                                }
                            },
                            listeners: {
                                "afterrender": function() {
                                    Ext.getBody().unmask();
                                }
                            }
                        }
                    }, {
                        title: '进度图(线性图)',
                        layout: 'fit',
                        items: {
                            xtype: 'linechart',
                            store: statStore,
                            xField: 'CreateTime',
                            series: [{ yField: 'Progress', displayName: '进度'}],
                            extraStyle: {
                                legend: {
                                    display: 'bottom'
                                },
                                xAxis: {
                                    labelRotation: 30
                                }
                            }
                        }
}]
                    });
                    var w = new Ext.Window({
                        title: '图形分析',
                        width: 700,
                        height: 500,
                        items: tabPanel/*{
                        xtype: 'stackedbarchart',
                        type: 'stackcolumn',
                        store: statStore,
                        xField: 'CreateTime',
                        yAxis: new Ext.chart.NumericAxis({
                            stackingEnabled: true
                        }),
                        series: [{
                            yField: 'Progress',
                            displayName: '进度'
}]
                        }*/
                    }).show();
                }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
