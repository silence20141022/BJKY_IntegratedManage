<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="WebLink.aspx.cs" Inherits="IntegratedManage.Web.DailyManage.WebLink" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=575,height=225,scrollbars=yes");
        var EditPageUrl = "WebLinkEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["WebLinkList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'WebLinkList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Url' },
			{ name: 'WebName' },
			{ name: 'IsAdmine' },
			{ name: 'CreateId' },
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
                columns: 6,
                collapsed: false,
                items: [
                { fieldLabel: '网站名', id: 'WebName', schopts: { qryopts: "{ mode: 'Like', field: 'WebName' }"} },
                { fieldLabel: '地址', id: 'Url', schopts: { qryopts: "{ mode: 'Like', field: 'Url' }"} },
                { fieldLabel: '收录人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} },
                { fieldLabel: '从', id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateTime' }"} },
                { fieldLabel: '至', id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateTime' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("WebName"));
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
                        recs = grid.getSelectionModel().getSelections();
                        if (recs) {
                            if (recs[0].get("CreateId") != AimState.UserInfo.UserID) {
                                AimDlg.show("不可修改他人的收藏!");
                                return;
                            }
                        }
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
                        var allow = true;
                        $.each(recs, function() {
                            if (this.get("CreateId") != AimState.UserInfo.UserID) {
                                allow = false; return;
                            }
                        })
                        if (!allow) {
                            AimDlg.show("不可删除他人的收藏!");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, '->']
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
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'WebName', dataIndex: 'WebName', header: '网站名称', width: 200, sortable: true },
					{ id: 'Url', dataIndex: 'Url', header: '地址', width: 450, sortable: true },
			      	{ id: 'CreateName', dataIndex: 'CreateName', header: '收录人', width: 120, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '收藏日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true }
                    ],
                bbar: pgBar,
                tbar: titPanel
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
            window.onresize = function() {
                schBar.collapse();
                schBar.expand();
            }
        }

        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
