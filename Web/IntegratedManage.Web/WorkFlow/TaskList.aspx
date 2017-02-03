<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="TaskList.aspx.cs" Inherits="Aim.Portal.Web.WorkFlow.TaskList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1200,height=600,scrollbars=yes");
        var EditPageUrl = "TaskEdit.aspx";
        var status = $.getQueryString({ ID: "Status", DefaultValue: "" });
        var EnumType = { '4': '已审批', '0': '待审批' };
        var EnumType1 = { 'Idle': '签核中', 'Completed': '已结束' };
        var comboxData = [[3, '三天内'], [7, '一周内'], [14, '二周内'], [30, '一个月内'], [31, '一个月以上'], [100, '全部']];
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["SysWorkFlowTaskList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'SysWorkFlowTaskList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Title' },
			{ name: 'Description' },
			{ name: 'OwnerId' },
			{ name: 'OwnerName' },
			{ name: 'Action' },
			{ name: 'WorkFlowInstanceId' },
			{ name: 'WorkFlowName' },
			{ name: 'EFormName' },
			{ name: 'ApprovalNodeName' },
			{ name: 'GroupId' },
			{ name: 'ApprovalNodeMathConditionType' },
			{ name: 'BookmarkName' }, { name: 'CreateTime' }, { name: 'Status' },
			{ name: 'Context' },
			{ name: 'Result' },
			{ name: 'FlowStatus' },{ name: 'RelateName' },			
			{ name: 'System' },
			{ name: 'Type' },
			{ name: 'ExecUrl' },
			{ name: 'RelateType' },
			{ name: 'OwnerUserId' }
			],
                listeners: { "aimbeforeload": function(proxy, options) {
                    options.data = options.data || {};
                    options.data.Status = status;
                    options.data.Date = $("#id_SubmitStateH").val();
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
                items: [
                { fieldLabel: '标题', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
                { fieldLabel: '流程名', id: 'WorkFlowName', schopts: { qryopts: "{ mode: 'Like', field: 'WorkFlowName' }"} },
                { fieldLabel: '环节名', id: 'ApprovalNodeName', schopts: { qryopts: "{ mode: 'Like', field: 'ApprovalNodeName' }"}}]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [
                new Ext.Toolbar.TextItem('查看：'), {
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
                    value: '3',
                    valueField: "retrunValue",
                    displayField: "displayText",
                    listeners: {
                        select: function() {
                            reloadPage(null);
                            try {
                            } catch (ex) {

                            }
                        }
                    }, anchor: '99%'
                },
                '->'
                ]
            });
            titPanel = new Ext.ux.AimPanel({
                // tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'Title',
                columns: [
                    { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'execute', header: '执行', renderer: RenderImg, width: 60, sortable: true, fixed: true, menuDisabled: true },
					{ id: 'Title', dataIndex: 'Title', header: '任务名称', width: 150, sortable: true },
					//{ id: 'WorkFlowName', dataIndex: 'WorkFlowName', header: '流程名称', width: 200, sortable: true },
					{id: 'ApprovalNodeName', dataIndex: 'ApprovalNodeName', header: '环节名称', width: 150, sortable: true },
                    { id: 'RelateName', dataIndex: 'RelateName', header: '任务类型', width: 120, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '分发时间', width: 130, sortable: true },
					{ id: 'Status', dataIndex: 'Status', header: '状态', width: 50, sortable: true, enumdata: EnumType, hidden: true },
					{ id: 'FlowStatus', dataIndex: 'FlowStatus', header: '单据状态', width: 60, sortable: true, enumdata: EnumType1, hidden: true }
                    ],
                bbar: pgBar,
                tbar: titPanel
            });
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
            });
        }
        function RenderImg(value, cellmeta, record, rowIndex, columnIndex, store) {
            switch (this.id) {
                case "execute":
                    var ret = "<img src='/images/shared/arrow_turnback.gif' style='cursor:hand' onclick=\"OpenNews('" + "/WorkFlow/TaskExecute.aspx?TaskId=" + record.get("Id") + "&op=r" + "','" + record.get("Type") + "','" + record.get("Id") + "','" + record.get("WorkFlowInstanceId") + "','" + record.get("RelateType") + "','" + record.get("ExecUrl") + "')\"/>";
                    return ret;
                    break;
            }
        }
        var WinStyle = CenterWin("width=1200,height=650,scrollbars=yes");
        function OpenNews(NewsUrl) {
            if (arguments.length > 4 && arguments[1] != "") {
                ExecuteTask(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])
            }
            else {
                opencenterwin(NewsUrl, "win0", 1100, 700);
            }
        }
        function ExecuteTask(taskType, wid, flowId, sys, execUrl) {
            var _link = '<%=Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("/portal/Portal.aspx","") %>';
            switch (taskType) {
                case "AuditFlow":
                    if (sys == "Project")
                        _link += '/Project/WorkSpace/PrjNormalTaskBus.aspx?FlowId=' + flowId + "&ItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    else
                        _link += '/workflow/businessframe/TaskBus.aspx?WorkItemId=' + wid + '&PassCode=<%=Session["PassCode"] %>';
                    // OpenWin(_link, "_Blank", CenterWin("width=870,height=650,resizable=yes,scrollbars=yes"));
                    opencenterwin(_link, "win1", 870, 650);
                    break;
                case "AuditTask":
                    _link += '/project/workspace/PrjMyAudit.aspx?FlowId=' + flowId + "&amp;TaskKey=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    //  OpenWin(, "_Blank", CenterWin("width=820,height=600,status=yes"));
                    opencenterwin(_link, "win2", 820, 600);
                    break;
                case "FileFlow":
                    _link += '/workflow/fileflowframe/FileBus.aspx?WorkItemId=' + wid + '&PassCode=<%=Session["PassCode"] %>';
                    //  OpenWin(_link, "_blank", CenterWin("width=820,height=650,scrollbars=yes,resizable=yes"));
                    opencenterwin(_link, "win3", 820, 650);
                    break;
                case "newflow":
                    _link += "/workflow/fileflow/FileBus.aspx?WorkItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    opencenterwin(_link, "win4", 820, 650);
                    break;
                case "CustomFormFlow":
                    _link += "/workflow/customformflowframe/CustomFormBus.aspx?WorkItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    opencenterwin(_link, "win4", 820, 650);
                    break;
                case "Questionare":
                    opencenterwin("/SurveyManage/InternetSurveyView.aspx?Id=" + wid, 'Questionare', 1000, 600);
                    break;
                case "MiddleDB":
                    opencenterwin(execUrl + '&SSOID=<%=this.UserSID %>', '_blank', 1000, 600);
                    break;
                default:
                    //LinkTo
                    //("/workflow/businessframe/TaskBus.aspx?WorkItemId=" + wid, "_blank", CenterWin("width=820,height=600,scrollbars=yes"));
                    ExecuteFreeFlow(execUrl, wid, flowId, sys);
                    break;
            }
        }
        function ExecuteFreeFlow(url, wid, flowId, relateType) {
            _link = '<%=Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("/portal/Portal.aspx","") %>' + url + "&WorkItemId=" + wid + "&FlowId=" + flowId + '&PassCode=<%=Session["PassCode"] %>';
            //  OpenWin(_link, "_Blank", CenterWin("width=1000,height=650,scrollbars=yes"));
            opencenterwin(_link, "win65", 1000, 650);
        }
        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }

        function reloadPage(args) {
            // 重新加载页面
            status = args ? args.cid : status;
            if (status == 0) {
                grid.getColumnModel().setHidden(3, false);
                grid.getColumnModel().setColumnHeader(3, "执行");
            }
            else {
                grid.getColumnModel().setColumnHeader(3, "查看");
            }
            store.reload();
            if (window.parent) {
                if (window.parent.opener) {
                    window.parent.opener.location.reload();
                }
            }
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
