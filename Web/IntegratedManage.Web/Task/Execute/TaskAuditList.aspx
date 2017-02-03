<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true" CodeBehind="TaskAuditList.aspx.cs" Inherits="Aim.AM.Web.Aim.Execute.TaskAuditList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <script src="TaskExecute.js" type="text/javascript"></script>

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=950,height=700,scrollbars=yes");
        var EditPageUrl = "/Aim//Task/A_TaskWBSEdit.aspx";
        var status = $.getQueryString({ ID: "Status", DefaultValue: "0" });
        var EnumType = { '0': '未下达', '1': '进行中', '1.5': '待审批', '2': '已完成' };
        var comboxData = [[365, '一年内'], [180, '六个月内'], [3, '三天内'], [7, '一周内'], [14, '二周内'], [30, '一个月内'], [31, '一个月以上']];
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        var mdls;

        function onPgLoad() {
            mdls = [{ Name: "待审批的任务", Url: "TaskList.aspx?Status=0", Status: "1.5" }, { Name: "已审批的任务", Url: "TaskList.aspx?Status=2", Status: "2"}];
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["SysWorkFlowTaskList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'SysWorkFlowTaskList',
                idProperty: 'Id',
                data: myData,
                remoteSort: false,
                fields: [
			{ name: 'Id' },
			{ name: 'ParentID' },
			{ name: 'Path' },
			{ name: 'PathLevel' },
			{ name: 'IsLeaf' },
			{ name: 'SortIndex' },
			{ name: 'EditStatus' },
			{ name: 'Tag' },
			{ name: 'LastModifiedDate' },
			{ name: 'State' },
			{ name: 'Flag' },
			{ name: 'DeptId' },
			{ name: 'DeptName' },
			{ name: 'Code' },
			{ name: 'TaskName' },
			{ name: 'RefTaskCode' },
			{ name: 'RefTaskName' },
			{ name: 'TaskType' },
			{ name: 'Balance' },
			{ name: 'PlanWorkHours' },
			{ name: 'ConfirmWorkHours' },
			{ name: 'ConfirmReason' },
			{ name: 'SubmitUserId' },
			{ name: 'SubmitUserName' },
			{ name: 'SubmitDate', type: 'date' },
			{ name: 'DutyId' },
			{ name: 'DutyName' },
			{ name: 'UserIds' },
			{ name: 'UserNames' },
			{ name: 'ReceiveDate' },
			{ name: 'ImportantRemark' },
			{ name: 'Remark' },
			{ name: 'Attachment' },
			{ name: 'FactWorkHours' },
			{ name: 'FactStartDate' },
			{ name: 'FactEndDate', type: 'date' },
			{ name: 'PlanStartDate' },
			{ name: 'PlanEndDate', type: 'date' },
			{ name: 'TaskProgress' },
			{ name: 'Suggestion' },
			{ name: 'RejectReason' },
			{ name: 'ExecuteRemark' },
			{ name: 'AttachmentChild' },
			{ name: 'ExamStandard' },
			{ name: 'Ext1' },
			{ name: 'Ext2' },
			{ name: 'ExtTime1' },
			{ name: 'ExtTime2' }
			],
                listeners: { "aimbeforeload": function(proxy, options) {
                    options.data = options.data || {};
                    options.data.Status = status;
                    options.data.Date = $("#id_SubmitStateH").val();
                }
                },
                sortInfo: {
                    field: 'PlanEndDate',
                    direction: 'asc'
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
                { fieldLabel: '任务名称', id: 'TaskName', schopts: { qryopts: "{ mode: 'Like', field: 'TaskName' }"} },
                { fieldLabel: '任务编号', id: 'Code', schopts: { qryopts: "{ mode: 'Like', field: 'Code' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [new Ext.Toolbar.TextItem('<span style=font-size:12px>计划完成日期：</span>'), {
                    xtype: 'combo',
                    name: 'submitState',
                    id: 'id_SubmitState',
                    hiddenName: 'id_SubmitStateH',
                    triggerAction: 'all',
                    forceSelection: true,
                    lazyInit: false,
                    editable: false,
                    allowBlank: false,
                    width: 90,
                    store: new Ext.data.SimpleStore({
                        fields: ["retrunValue", "displayText"],
                        data: comboxData
                    }),
                    mode: 'local',
                    value: '365',
                    valueField: "retrunValue",
                    displayField: "displayText",
                    listeners: {
                        select: function() {
                            store.reload();
                            try {
                            } catch (ex) {

                            }
                        }
                    }, anchor: '99%'
                }, '-', {
                    text: '确认审批通过', id: 'btnSubmit',
                    iconCls: 'aim-icon-execute',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请选择要审批通过的任务！");
                            return;
                        }
                        if (confirm("确定审批通过所选择的任务吗？")) {
                            ExtBatchOperate('batchsubmit', recs, null, null, function() {
                                AimDlg.show("提交成功！");
                                store.reload();
                            });
                        }
                    }
                }, {
                    text: '打回重新执行', id: 'btnBack',
                    iconCls: 'aim-icon-execute',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请选择要打回的任务！");
                            return;
                        }
                        if (confirm("确定打回所选择的任务吗？")) {
                            ExtBatchOperate('batchback', recs, null, null, function() {
                            AimDlg.show("打回成功！");
                                store.reload();
                            });
                        }
                    }
                }, '->',
                '-',
                {
                    text: '复杂查询',
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
                    autoExpandColumn: 'Remark',
                    columns: [
                    { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'execute', header: '评定', renderer: linkRender, width: 40, sortable: true, fixed: true, menuDisabled: true },
				    { id: 'Attach', dataIndex: 'Attach', header: "任务附件", width: 60, sortable: true, renderer: linkRender },
				    { id: 'WorkLog', dataIndex: 'WorkLog', header: "工作日志", width: 60, sortable: true, renderer: linkRender },
				    { id: 'PubDoc', dataIndex: 'PubDoc', header: "相关公文", width: 60, sortable: true, renderer: linkRender },
					{ id: 'TaskName', dataIndex: 'TaskName', header: '任务名称', linkparams: { url: EditPageUrl, style: EditWinStyle }, width: 250, sortable: true },
					{ id: 'TaskProgress', dataIndex: 'TaskProgress', header: '进度', width: 80, sortable: true, renderer: linkRender },
					{ id: 'SubmitDate', dataIndex: 'SubmitDate', header: '下达日期', width: 70, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'PlanEndDate', dataIndex: 'PlanEndDate', header: '计划完成日期', width: 80, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'FactEndDate', dataIndex: 'FactEndDate', header: '实际完成日期', width: 80, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'DutyName', dataIndex: 'DutyName', header: '负责人', width: 70, sortable: true, renderer: linkRender },
					{ id: 'UserNames', dataIndex: 'UserNames', header: '参与人', width: 100, sortable: true, renderer: linkRender },
					{ id: 'State', dataIndex: 'State', header: '状态', width: 45, sortable: true, enumdata: EnumType },
					{ id: 'Remark', dataIndex: 'Remark', header: '备注', width: 100, sortable: true }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });

                // 页面视图
                /*viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
                });*/
                var tabArr = new Array();
                var i = 0;
                var FrameHtml = "";
                // 构建tab标签
                $.each(mdls, function() {
                    var tab = {
                        title: this["Name"],
                        href: this["Url"],
                        Status: this["Status"],
                        listeners: { activate: handleActivate },
                        margins: '0 0 0 0',
                        border: false,
                        layout: 'border',
                        html: "<div style='display:none;'></div>"
                    }
                    tabArr.push(tab);
                });

                // 用于tab过多时滚动
                var scrollerMenu = new Ext.ux.TabScrollerMenu({
                    menuPrefixText: '项目',
                    maxText: 15,
                    pageSize: 5
                });

                var tabPanel = new Ext.ux.AimTabPanel({
                    enableTabScroll: true,
                    border: true,
                    defaults: { autoScroll: true },
                    plugins: [scrollerMenu],
                    region: 'north',
                    margins: '-1 0 0 0',
                    activeTab: 0,
                    width: document.body.offsetWidth - 5,
                    height: 10,
                    items: tabArr,
                    listeners: { 'click': function() { handleActivate(); } }
                });

                viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [tabPanel, grid]
                });

                function handleActivate(tab) {
                    tab = tab || tabPanel.getActiveTab();
                    var url = tab.href;
                    status = tab.Status;
                    if (status == "1.5") {
                        Ext.getCmp("btnSubmit").show();
                        Ext.getCmp("btnBack").show();
                        grid.getColumnModel().setHidden(3, false);
                    }
                    else {
                        Ext.getCmp("btnSubmit").hide();
                        Ext.getCmp("btnBack").hide();
                        grid.getColumnModel().setHidden(3, true);
                    }
                    store.reload();
                }
            }
            var WinStyle = CenterWin("width=800,height=600,scrollbars=yes");
            function ExecuteTask(taskId) {
                if (status == "1") {
                    alert("环节已审批!"); return;
                }
                OpenWin("/WorkFlow/TaskExecute.aspx?TaskId=" + taskId, "_blank", WinStyle);
            }
            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }

            function reloadPage(args) {
                // 重新加载页面
                status = args ? args.cid : status;
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
