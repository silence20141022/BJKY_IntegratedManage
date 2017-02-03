<%@ Page Title="在线人员列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true" CodeBehind="OnlineUserList.aspx.cs" Inherits="IntegratedManage.Web.OnlineUserList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=790,height=320,scrollbars=yes");
        var EditPageUrl = "AbsenceApplyEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["AbsenceApplyList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'AbsenceApplyList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'LoginName' },
			{ name: 'Name' },
			{ name: 'WorkNo' }
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
                columns: 6,
                items: [
                { fieldLabel: '姓名', id: 'Name', schopts: { qryopts: "{ mode: 'Like', field: 'Name' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("Name"));   //Number 为任意
                } }]
                });

                // 工具栏
                tlBar = new Ext.ux.AimToolbar({
                    items: [ {
                        text: '导出Excel',
                        iconCls: 'aim-icon-xls',
                        handler: function() {
                            ExtGridExportExcel(grid, { store: null, title: '标题' });
                        }
                    }, '-']
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
                        autoExpandColumn: 'WorkNo',
                        columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Name', dataIndex: 'Name', header: '姓名', width: 80 },
					{ id: 'LoginName', dataIndex: 'LoginName', header: '登录名', width: 140 },
					{ id: 'WorkNo', dataIndex: 'WorkNo', header: '工号', width: 100, sortable: true }
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
                        case "State":
                            if (value == "1") rtn = "提交审批中";
                            break;
                        case "Reason":
                            var str = value.length > 30 ? value.toString().substring(0, 30) + "..." : value;
                            rtn = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='openWin(\"" + record.get("Id") + "\")'>" + str + "</span>";
                            break;
                    }
                    return rtn;
                }
                function openWin(val) {

                    var task = new Ext.util.DelayedTask();
                    task.delay(50, function() {
                        opencenterwin(EditPageUrl + "?op=r&id=" + val, "", 790, 390);
                    });
                }
                function opencenterwin(url, name, iWidth, iHeight) {
                    var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                    window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
                }
                // 提交数据成功后
                function onExecuted() {
                    store.reload();
                }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" >
        <h1>
            在线人员列表</h1>
    </div>
</asp:Content>
