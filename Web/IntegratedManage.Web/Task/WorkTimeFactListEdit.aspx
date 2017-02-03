<%@ Page Title="工作日志" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="WorkTimeFactListEdit.aspx.cs" Inherits="Aim.AM.Web.WorkTimeFactListEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=600,scrollbars=yes");
        var EditPageUrl = "WorkTimeFactEdit.aspx";
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
                records: AimState["WorkTimeFactList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'WorkTimeFactList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'CurrentDate' },
			{ name: 'PrjId' },
			{ name: 'PrjCode' },
			{ name: 'PrjName' },
			{ name: 'MajorId' },
			{ name: 'MajorName' },
			{ name: 'MajorDeptId' },
			{ name: 'MajorDeptName' },
			{ name: 'UserId' },
			{ name: 'UserName' },
			{ name: 'UserDeptId' },
			{ name: 'UserDeptName' },
			{ name: 'NormalHour' },
			{ name: 'ExtralHour' },
			{ name: 'Total' },
			{ name: 'IsOutgo' },
			{ name: 'IsManage' },
			{ name: 'WorkType' },
			{ name: 'TaskId' },
			{ name: 'TaskCode' },
			{ name: 'TaskName' },
			{ name: 'TaskProgress' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateDate', type: 'date' },
			{ name: 'Remark' }
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
                { fieldLabel: '目标名称', id: 'TaskName', schopts: { qryopts: "{ mode: 'Like', field: 'TaskName' }"} },
                 { fieldLabel: '日志时间', id: 'CreateTimeStart', xtype: 'datefield', vtype: 'daterange', endDateField: 'CreateTimeEnd', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateDate' }"} },
                { fieldLabel: '至', id: 'CreateTimeEnd', xtype: 'datefield', vtype: 'daterange', startDateField: 'CreateTimeStart', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateDate' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加', id: 'btnAdd',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var EntRecord = grid.getStore().recordType;
                        var p = new EntRecord({ "Month": 1, "TaskId": TaskId, "TaskName": AimState["TaskModel"].TaskName, "TaskCode": AimState["TaskModel"].Code,"CreateDate":new Date() });
                        //grid.stopEditing();
                        //var insRowIdx = store.data.length;
                        //store.insert(insRowIdx, p);
                        //grid.startEditing(insRowIdx, 3);
                        ExtOpenGridEditWin(grid, EditPageUrl + "?TaskId=" + TaskId, "c", EditWinStyle);
                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除', id: 'btnDelete',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            for (var i = 0; i < recs.length; i++) {
                                if (recs[i] && (recs[i].get("Id") == null || recs[i].get("Id") == "")) {
                                    store.remove(recs[i]);
                                    store.commitChanges();
                                }
                            }
                            if (grid.getSelectionModel().getSelections().length > 0)
                                ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, {
                    text: '保存',hidden:true,
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        // 保存修改的数据
                        var recs = store.getModifiedRecords();
                        if (recs && recs.length > 0) {
                            var dt = store.getModifiedDataStringArr(recs) || [];

                            jQuery.ajaxExec('batchsave', { "data": dt }, function() {
                                store.commitChanges();

                                AimDlg.show("保存成功！");
                            });
                        }
                    }
                },
                '->',
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
                grid = new Ext.ux.grid.AimEditorGridPanel({
                    store: store,
                    clicksToEdit: 3,
                    region: 'center',
                    autoExpandColumn: 'Remark',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Total', dataIndex: 'Total', header: '工时(小时)', width: 70, editor: { xtype: 'numberfield' }, sortable: true },
					{ id: 'Remark', dataIndex: 'Remark', header: '工作内容', editor: { xtype: 'textarea' }, width: 120, sortable: true },
					{ id: 'PrjName', dataIndex: 'PrjName', header: '标准化成果', editor: { xtype: 'textarea' }, width: 120, sortable: true, renderer: ExtGridFileRender },
					{ id: 'TaskCode', dataIndex: 'TaskCode', header: '任务编号', width: 100, sortable: true },
					{ id: 'TaskName', dataIndex: 'TaskName', header: '目标任务名称', width: 80, sortable: true },
					{ id: 'CreateDate', dataIndex: 'CreateDate', header: '创建日期', width: 100, editor: { xtype: 'datefield' }, renderer: ExtGridDateOnlyRender, sortable: true }
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
