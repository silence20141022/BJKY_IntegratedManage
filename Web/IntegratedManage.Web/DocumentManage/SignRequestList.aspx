<%@ Page Title="发文管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SignRequestList.aspx.cs" Inherits="IntegratedManage.Web.SignRequestList" %>

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
			    { name: 'Id' }, { name: 'SignReason' }, { name: 'ImportanceDegree' }, { name: 'ApproveLeaderIds' },
			    { name: 'ApproveLeaderNames' }, { name: 'YuanLeaderIds' }, { name: 'YuanLeaderNames' }, { name: 'SecrecyDegree' },
			    { name: 'ContactUserId' }, { name: 'ContactUserName' }, { name: 'Telephone' }, { name: 'Attachment' },
			    { name: 'WorkFlowState' }, { name: 'ApproveResult' }, { name: 'CreateDeptId' },
			    { name: 'CreateDeptName' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    //options.data.cid = cid;
                }
                }
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 6,
                items: [
                    { fieldLabel: '签报事由', id: 'SignReason', schopts: { qryopts: "{ mode: 'Like', field: 'SignReason' }"} },
                    { fieldLabel: '主办单位', id: 'CreateDeptName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateDeptName' }"} },
                    { fieldLabel: '联系人', id: 'ContactUserName', schopts: { qryopts: "{ mode: 'Like', field: 'ContactUserName' }"} },
                    { fieldLabel: '开始时间', id: 'StartTime', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                    { fieldLabel: '结束时间', id: 'EndTime', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} },
                    { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                        Ext.ux.AimDoSearch(Ext.getCmp("SignReason"));
                    }
                    }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        opencenterwin("SignRequestEdit.aspx?op=c", "", 1000, 500);
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
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("流程中或者审批结束的记录不能进行修改!");
                            return;
                        }
                        opencenterwin("SignRequestEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 1000, 500);
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
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("流程中或者审批结束的记录不能进行删除!");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { id: recs[0].get("Id") }, function(rtn) {
                                AimDlg.show("删除成功！"); store.reload();
                            });
                        }
                    }
                }, '-', {
                    text: '导出<label style=" font-family:@宋体">Excel</label>',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
                }, '-', { text: '提交审批', id: 'btnSubmit', iconCls: 'aim-icon-checking',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要审批的记录！");
                            return;
                        }
                        if (!recs[0].get("ApproveLeaderIds") || !recs[0].get("SignReason")) {
                            AimDlg.show("提交审批时部门负责人、签报事由为必填项！");
                            return;
                        }
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("记录已处于流程中,不能再进行提交!");
                            return;
                        }
                        Ext.getBody().mask("提交中,请稍后...");
                        jQuery.ajaxExec('submit', { state: "Flowing", id: recs[0].get("Id") }, function(rtn) {
                            window.setTimeout("AutoExecuteFlow('" + rtn.data.WorkFlowInfo + "')", 1000);
                        });
                    }
                }, '-', { text: '流程跟踪', iconCls: 'aim-icon-addrbook',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要跟踪的记录！");
                            return;
                        }
                        if (!recs[0].get("WorkFlowState")) {
                            AimDlg.show("有审批的记录才能跟踪！");
                            return;
                        }
                        showflowwin(recs[0].get("Id"));
                    }
                }, '-', { text: '分发情况', iconCls: 'aim-icon-group',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要查看分发的记录！");
                            return;
                        }
                        opencenterwin("GiveOutInfo.aspx?FormId=" + recs[0].get("Id") + "&FormName=" + escape(recs[0].get("SignReason")), "", 800, 600);
                    }
                }, '->']
            });
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                // viewConfig: { forceFit: true },
                autoExpandColumn: 'SignReason',
                plugins: [new Ext.ux.grid.GridSummary()],
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'SignReason', dataIndex: 'SignReason', header: '签报事由', width: 260, renderer: RowRender },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '联系人', width: 80 },
					{ id: 'CreateDeptName', dataIndex: 'CreateDeptName', header: '主办单位', width: 100 },
					{ id: 'ImportanceDegree', dataIndex: 'ImportanceDegree', header: '紧急程度', width: 80 },
					{ id: 'SecrecyDegree', dataIndex: 'SecrecyDegree', header: '密级', width: 80 },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '申请时间', width: 80, renderer: ExtGridDateOnlyRender },
					{ id: 'WorkFlowState', dataIndex: 'WorkFlowState', header: '审批状态', width: 80, enumdata: AimState["WorkFlowState"] },
					{ id: 'ApproveResult', dataIndex: 'ApproveResult', header: '审批结果', width: 80 }
                    ],
                tbar: titPanel,
                bbar: pgBar
            });
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }
        function onExecuted() {
            store.reload();
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function showwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("SignRequestEdit.aspx?op=v&id=" + val, "", 1000, 500);
            });
        }
        function showflowwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + val, "", 1000, 500);
            });
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "SignReason":
                    if (record.get("Attachment")) {
                        rtn = "<img  src='../images/shared/attach.png' alt='' style='width:16px;height:16px'/><label style='color:Blue; cursor:pointer; text-decoration:underline;padding-left:5px' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
                    }
                    else {
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;padding-left:21px' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
                    }
                    break;
                case "Id":
                    rtn = "";
                    if (record.get("WorkFlowState") == "Flowing" || record.get("WorkFlowState") == "End") {
                        rtn += "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                      value + "\")'>跟踪</label>  ";
                    }
                    break;
                case "DocumentWord":
                    if (value) {
                        rtn = value + (record.get("DocumentYear") ? record.get("DocumentYear") : "") + (record.get("DocumentNo") ? record.get("DocumentNo") : "");
                    }
                    break;
            }
            return rtn;
        }
        function AutoExecuteFlow(workflowinfo) {
            var strarray = workflowinfo.split(",");
            jQuery.ajaxExec('AutoExecuteFlow', { WorkFlowInfo: strarray }, function(rtn) {
                AimDlg.show("提交成功！");
                onExecuted();
                Ext.getBody().unmask();
            });
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
