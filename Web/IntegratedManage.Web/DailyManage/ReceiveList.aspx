<%@ Page Title="接待管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="ReceiveList.aspx.cs" Inherits="IntegratedManage.Web.ReceiveManageList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=735,height=600,scrollbars=0");
        var EditPageUrl = "ReceiveManageEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["ReceiveManageList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'ReceiveManageList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'CustomerName' },
			{ name: 'ComInTime' },
			{ name: 'LeaveoutTime' },
			{ name: 'ReceptionistId' },
			{ name: 'Receptionist' },
			{ name: 'ReceiveThing' },
			{ name: 'FeedBackResult' },
			{ name: 'Counter' },
			{ name: 'Remark' },
			{ name: 'CreateId' },
			{ name: 'LastModifyTime' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
                ]
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 5,
                items: [
                { fieldLabel: '来访客户', id: 'CustomerName', schopts: { qryopts: "{ mode: 'Like', field: 'CustomerName' }"} },
                { fieldLabel: '接待人', id: 'Receptionist', schopts: { qryopts: "{ mode: 'Like', field: 'Receptionist' }"} },
                { fieldLabel: '来访日期', id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThanEqual', datatype:'Date', field: 'StartTime' }"} },
                { fieldLabel: '截至日期', id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThanEqual', datatype:'Date', field: 'EndTime' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("CustomerName"));   //Number 为任意
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
                        ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
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
                    autoExpandColumn: 'ReceiveThing',
                    columns: [
                { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                { id: 'CustomerName', dataIndex: 'CustomerName', header: '来访客户', width: 150, sortable: true, renderer: RowRender },
                { id: 'ReceiveThing', dataIndex: 'ReceiveThing', header: '接待内容', width: 300 },
                { id: 'FeedBackResult', dataIndex: 'FeedBackResult', header: '接待结果反馈', width: 200 },
                { id: 'ComInTime', dataIndex: 'ComInTime', header: '来访时间', width: 100, sortable: true },
                { id: 'LeaveoutTime', dataIndex: 'LeaveoutTime', header: '结束时间', width: 100, sortable: true },
                { id: 'Receptionist', dataIndex: 'Receptionist', header: '接待人', width: 100, sortable: true },
                { id: 'CreateTime', dataIndex: 'CreateTime', header: '录入日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true }
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
                    case "CustomerName":
                        if (value) {
                            var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='openWin(\"" + record.get("Id") + "\",\"" + record.get("Id") + "\")'>" + value + "</span>";

                            rtn = str;
                        }
                        break;
                }
                return rtn;
            }


            function openWin(val) {
                var task = new Ext.util.DelayedTask();
                task.delay(50, function() {
                    opencenterwin(EditPageUrl + "?op=r&id=" + val, "", 735, 600);
                });
            }

            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=0');
            }


            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }

    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
