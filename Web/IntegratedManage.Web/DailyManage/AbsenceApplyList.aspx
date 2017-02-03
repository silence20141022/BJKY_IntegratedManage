<%@ Page Title="出差申请" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="AbsenceApplyList.aspx.cs" Inherits="IntegratedManage.Web.AbsenceApplyList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' }, { name: 'ApplyUserId' }, { name: 'ApplyUserName' }, { name: 'DeptId' },
			{ name: 'DeptName' }, { name: 'Reason' }, { name: 'StartTime' }, { name: 'EndTime' },
			{ name: 'Address' }, { name: 'WorkFlowState' }, { name: 'ApproveResult' },
			{ name: 'ExamineUserId' }, { name: 'ExamineUserName' },
			{ name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
			]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
                { fieldLabel: '出差事由', id: 'Reason', schopts: { qryopts: "{ mode: 'Like', field: 'Reason' }"} },
                { fieldLabel: '出差地点', id: 'Address', schopts: { qryopts: "{ mode: 'Like', field: 'Address' }"} },
                { fieldLabel: '开始时间从', labelWidth: 90, id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'StartTime' }"} },
                { fieldLabel: '到', labelWidth: 90, id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndTime' }"} }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        opencenterwin("AbsenceApplyEdit.aspx?op=c", "", 800, 400);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        if (recs[0].get("WorkFlowState") == "Flowing" || recs[0].get("WorkFlowState") == "End") {
                            AimDlg.show("审批中或者结束的申请单不允许修改");
                            return;
                        }
                        opencenterwin("AbsenceApplyEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 800, 400);
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
                        if (recs[0].get("WorkFlowState") == "Flowing" || recs[0].get("WorkFlowState") == "End") {
                            AimDlg.show("审批中或者结束的申请单不允许删除");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { id: recs[0].get("Id") }, function() { store.reload(); })
                        }
                    }
                }, '-', { text: '提交审批', id: 'btnSubmit', iconCls: 'aim-icon-checking', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要审批的记录！");
                        return;
                    }
                    if (!recs[0].get("ExamineUserId") || !recs[0].get("Reason") || !recs[0].get("StartTime") || !recs[0].get("EndTime")) {
                        AimDlg.show("提交出差申请时审批人、出差事由、开始结束时间都不能为空！");
                        return;
                    }
                    if (recs[0].get("WorkFlowState")) {
                        AimDlg.show("流程中或审批结束的记录,不能再进行提交!");
                        return;
                    }
                    Ext.getBody().mask("提交中,请稍后...");
                    jQuery.ajaxExec('submit', { state: "Flowing", id: recs[0].get("Id") }, function(rtn) {
                        window.setTimeout("AutoExecuteFlow('" + rtn.data.WorkFlowInfo + "')", 1000);
                    });
                }
                }, '-', { text: '流程跟踪', iconCls: 'aim-icon-addrbook', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要跟踪的记录！");
                        return;
                    }
                    if (!recs[0].get("WorkFlowState")) {
                        AimDlg.show("有审批的记录才能跟踪！");
                        return;
                    }
                    opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + recs[0].get("Id"), "", 1000, 500);
                }
                }, '-', {
                    text: '导出Excel',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
}]
                });
                titPanel = new Ext.ux.AimPanel({
                    tbar: tlBar,
                    items: [schBar]
                });
                grid = new Ext.ux.grid.AimGridPanel({
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'Reason',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Reason', dataIndex: 'Reason', header: '出差事由', width: 230, renderer: RowRender },
					{ id: 'Address', dataIndex: 'Address', header: '出差地点', width: 130 },
					{ id: 'StartTime', dataIndex: 'StartTime', header: '开始时间', width: 80, sortable: true },
					{ id: 'EndTime', dataIndex: 'EndTime', header: '结束时间', width: 80, sortable: true },
					{ id: 'WorkFlowState', dataIndex: 'WorkFlowState', header: '审批状态', width: 80, sortable: true, enumdata: AimState["WorkFlowState"] },
					{ id: 'ApproveResult', dataIndex: 'ApproveResult', header: '审批结果', width: 80, sortable: true },
					{ id: 'ExamineUserName', dataIndex: 'ExamineUserName', header: '审批人', width: 80, sortable: true },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '申请人', width: 80, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '申请时间', width: 80, renderer: ExtGridDateOnlyRender, sortable: true }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });
                viewport = new Ext.ux.AimViewport({
                    items: [grid]
                });
            }

            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = "";
                switch (this.id) {
                    case "Reason":
                        var str = value.length > 30 ? value.toString().substring(0, 30) + "..." : value;
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='openWin(\"" + record.get("Id") + "\")'>" + str + "</label>";
                        break;
                }
                return rtn;
            }
            function openWin(val) {
                var task = new Ext.util.DelayedTask();
                task.delay(50, function() {
                    opencenterwin("AbsenceApplyEdit.aspx?op=v&id=" + val, "", 800, 400);
                });
            }
            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
            }
            function onExecuted() {
                store.reload();
            }
            function AutoExecuteFlow(workflowinfo) {
                var strarray = workflowinfo.split(",");
                jQuery.ajaxExec('AutoExecuteFlow', { WorkFlowInfo: strarray }, function(rtn) {
                    AimDlg.show("提交成功！");
                    onExecuted();
                    Ext.getBody().unmask();
                    store.reload();
                });
            } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
