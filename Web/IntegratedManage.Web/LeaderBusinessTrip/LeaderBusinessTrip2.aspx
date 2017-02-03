<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="LeaderBusinessTrip2.aspx.cs" Inherits="IntegratedManage.Web.LeaderBusinessTrip2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">

        var EditWinStyle = CenterWin("width=820,height=400,scrollbars=1");
        var EditPageUrl = "TripEdit.aspx";
        var type = $.getQueryString({ ID: 'type' }) || '';
        var LeaderId = $.getQueryString({ ID: 'LeaderId' }) || '';
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["LeaderBusinessTripList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'LeaderBusinessTripList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Theme' },
			{ name: 'LeaderId' },
			{ name: 'LeaderName' },
			{ name: 'BelongUserId' },
			{ name: 'BelongUserName' },
			{ name: 'TripStartTime' },
			{ name: 'TripEndTime' },
			{ name: 'Addr' },
			{ name: 'Reason' },
			{ name: 'Remark' },
			{ name: 'ImportantLevel' },
			{ name: 'State' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			],
                aimbeforeload: function(proxy, options) {
                    options.data.LeaderId = LeaderId;

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
                columns: 5,
                collapsed: false,
                items: [
                { fieldLabel: '领导', id: 'LeaderName', schopts: { qryopts: "{ mode: 'Like', field: 'LeaderName' }"} },
                { fieldLabel: '外出主题', id: 'Theme', schopts: { qryopts: "{ mode: 'Like', field: 'Theme' }"} },
                { fieldLabel: '起始时间', id: 'TripStartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'TripEndTime', schopts: { qryopts: "{ mode: 'Greater', datatype:'Date', field: 'TripStartTime' }"} },
                { fieldLabel: '截至时间', id: 'TripEndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'TripStartTime', schopts: { qryopts: "{ mode: 'Less', datatype:'Date', field: 'TripEndTime' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("LeaderName"));   //Number 为任意
                }
                }
                ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl + "?type=assistant", "c", EditWinStyle);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl + "?type=" + type, "u", EditWinStyle);
                    }
                }, '-', {
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
                }
                ]
            });

            // 工具标题栏
            titPanel = new Ext.ux.AimPanel({
                tbar: pgOperation == "v" ? "" : tlBar,
                items: [schBar]
            });

            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'Theme',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'LeaderName', dataIndex: 'LeaderName', header: '领导', width: 100, sortable: true },
					{ id: 'Theme', dataIndex: 'Theme', header: '外出主题', width: 200, sortable: true, renderer: RowRender },
					{ id: 'Addr', dataIndex: 'Addr', header: '外出地点', width: 180, renderer: RowRender },
					{ id: 'TripStartTime', dataIndex: 'TripStartTime', header: '开始时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'TripEndTime', dataIndex: 'TripStartTime', header: '开始时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender }
                    ],
                bbar: pgBar,
                tbar: titPanel
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
            });
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Theme":
                    var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='windowOpen(\"" + record.get("Id") + "\")'>" + value + "</span>";
                    cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + value + '"';
                    rtn = str;
                    break;
                case "Addr":
                case "Reason":
                case "BelongUserName":
                    if (value) {
                        cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + value + '"';
                        if (value.toString().length > 50) {
                            rtn = value.toString().substring(0, 50) + "...";
                        } else {
                            rtn = value;
                        }
                    }
                    break;
            }
            return rtn;
        }
        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }

        //打开窗口
        function windowOpen(id) {
            var task = new Ext.util.DelayedTask();
            task.delay(100, function() {
                opencenterwin("TripEdit.aspx?op=r&id=" + id, "", 800, 380);
            });
        }
    
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
</asp:Content>
