
<%@ Page Title="附件列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true" CodeBehind="A_TaskAttachmentList.aspx.cs" Inherits="Aim.AM.Web.A_TaskAttachmentList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=300,scrollbars=yes");
        var EditPageUrl = "A_TaskAttachmentEdit.aspx";
        var TaskId = $.getQueryString({ "ID": "TaskId" });
        var IsInTab = $.getQueryString({ "ID": "IsInTab" });

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
            if (IsInTab == "true") {
                tlBar.hide();
            }
        }

        function setPgUI() {
            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["A_TaskAttachmentList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'A_TaskAttachmentList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Code' },
			{ name: 'Title' },
			{ name: 'TaskId' },
			{ name: 'TaskCode' },
			{ name: 'TaskName' },
			{ name: 'Remark' },
			{ name: 'Attachment' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'State' },
			{ name: 'Flag' },
			{ name: 'DutyId' },
			{ name: 'DutyName' },
			{ name: 'StartDate' }
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
                { fieldLabel: '标题', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
                 { fieldLabel: '日期从', id: 'CreateTimeStart', xtype: 'datefield', vtype: 'daterange', endDateField: 'CreateTimeEnd', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateTime' }"} },
                { fieldLabel: '至', id: 'CreateTimeEnd', xtype: 'datefield', vtype: 'daterange', startDateField: 'CreateTimeStart', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateTime' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加附件',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl + "?TaskId=" + TaskId, "c", EditWinStyle);
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
					{ id: 'Title', dataIndex: 'Title', header: '标题', linkparams: { url: EditPageUrl, style: EditWinStyle }, width: 100, sortable: true },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '上传人', width: 100, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '上传日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true }
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
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
