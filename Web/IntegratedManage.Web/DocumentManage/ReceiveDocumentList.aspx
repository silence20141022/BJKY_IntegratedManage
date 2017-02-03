<%@ Page Title="收文管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="ReceiveDocumentList.aspx.cs" Inherits="IntegratedManage.Web.DocumentManage.ReceiveDocumentList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../App_Themes/Ext/ux/css/ColumnHeaderGroup.css" rel="stylesheet" type="text/css" />

    <script src="../js/ext/ux/ColumnHeaderGroup.js" type="text/javascript"></script>

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
			    { name: 'Id' }, { name: 'FileName' }, { name: 'BringUnitId' }, { name: 'BringUnitName' }, { name: 'Pages' }, { name: 'ReceiveType' },
			    { name: 'ComeWord' }, { name: 'ComeWordSize' }, { name: 'ReceiveWord' }, { name: 'ReceiveWordSize' }, { name: 'SecrecyDegree' },
			    { name: 'ImportanceDegree' }, { name: 'ReceiveDate' }, { name: 'ApprovalNodeName' }, { name: 'YuanZhangId' }, { name: 'YuanZhangName' },
			    { name: 'ReceiveReason' }, { name: 'MainFile' }, { name: 'Attachment' }, { name: 'NiBanOpinion' }, { name: 'ApproveResult' },
			    { name: 'WorkFlowState' }, { name: 'State' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }, { name: 'MainQuan' },
			    { name: 'AttachmentQuan' }
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
                columns: 5,
                items: [
                    { fieldLabel: '收文名称', id: 'FileName', schopts: { qryopts: "{ mode: 'Like', field: 'FileName' }"} },
                    { fieldLabel: '发文单位', id: 'BringUnitName', schopts: { qryopts: "{ mode: 'Like', field: 'BringUnitName' }"} },
                    { fieldLabel: '收文日期', id: 'StartTime', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                    { fieldLabel: '到', id: 'EndTime', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} },
                    { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                        Ext.ux.AimDoSearch(Ext.getCmp("FileName"));
                    }
                    }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        opencenterwin("ReceiveDocumentEdit.aspx?op=c", "", 1000, 650);
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
                            AimDlg.show("流程中或者已审批的记录,不能修改!");
                            return;
                        }
                        opencenterwin("ReceiveDocumentEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 1000, 650);
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
                            AimDlg.show("流程中或者已审批的记录,不能删除!");
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
                        if (!recs[0].get("FileName") || !recs[0].get("MainFile")) {
                            AimDlg.show("提交审批时收文名称、收文正文不能为空!");
                            return;
                        }
                        if (recs[0].get("ApprovalNodeName") == "主管院长" && !recs[0].get("YuanZhangId")) {
                            AimDlg.show("首个审批环节是主管院长时必须配置具体人员！");
                            return;
                        }
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("流程中或者已审批的记录,不能再进行提交!");
                            return;
                        }
                        Ext.getBody().mask("提交中,请稍后...");
                        jQuery.ajaxExec('submit', { state: "Flowing", id: recs[0].get("Id") }, function(rtn) {
                            window.setTimeout("AutoExecuteFlow('" + rtn.data.WorkFlowInfo + "','" + recs[0].get("Id") + "')", 1000);
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
                }, '-',
                { text: '打印公文处理单', iconCls: 'aim-icon-printer', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要打印的记录！");
                        return;
                    }
                    if (recs[0].get("WorkFlowState") != "End" || recs[0].get("ApproveResult") != "同意") {
                        AimDlg.show("审批同意的公文才能打印处理单！");
                        return;
                    }
                    PrintReceiveBill(recs[0].get("Id"));
                }
                }, '-', { text: '分发情况', iconCls: 'aim-icon-group',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要查看分发的记录！");
                            return;
                        }
                        opencenterwin("GiveOutInfo.aspx?FormId=" + recs[0].get("Id") + "&FormName=" + escape(recs[0].get("FileName")), "", 800, 600);
                    }
                }, '->']
            });
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            var colArray = [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'FileName', dataIndex: 'FileName', header: '收文名称', width: 100, renderer: RowRender },
                    { id: 'ReceiveDate', dataIndex: 'ReceiveDate', header: '收文日期', width: 80, renderer: ExtGridDateOnlyRender },
					{ id: 'ReceiveType', dataIndex: 'ReceiveType', header: '文别', width: 60 },
					{ id: 'ComeWord', dataIndex: 'ComeWord', header: '字', width: 60 },
					{ id: 'ComeWordSize', dataIndex: 'ComeWordSize', header: '号', width: 60 },
                    { id: 'ReceiveWord', dataIndex: 'ReceiveWord', header: '收文字号', width: 80, renderer: RowRender },
            		{ id: 'BringUnitName', dataIndex: 'BringUnitName', header: '发文单位', width: 120 },
       				{ id: 'ReceiveReason', dataIndex: 'ReceiveReason', header: '事由', width: 100, renderer: RowRender },
       				{ id: 'MainQuan', dataIndex: 'MainQuan', header: '正文', width: 60 },
       				{ id: 'AttachmentQuan', dataIndex: 'AttachmentQuan', header: '附件', width: 60 },
       				{ id: 'Pages', dataIndex: 'Pages', header: '共页', width: 60 },
					{ id: 'WorkFlowState', dataIndex: 'WorkFlowState', header: '审批状态', width: 70, renderer: RowRender },
					{ id: 'ApproveResult', dataIndex: 'ApproveResult', header: '审批结果', width: 70 },
					{ id: 'State', dataIndex: 'State', header: '收文状态', width: 70 }
                    ];
            var rowArr = [
                        { header: '<b></b>', colspan: 6, align: 'center' },
                        { header: '<b>来文</b>', colspan: 2, align: 'center' },
                        { header: '<b></b>', colspan: 3, align: 'center' },
                        { header: '<b>件数</b>', colspan: 3, align: 'center' },
                        { header: '<b></b>', colspan: 3, align: 'center' }
                ];
            var colModel = new Ext.grid.ColumnModel({
                columns: colArray,
                rows: [rowArr]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'FileName',
                plugins: [new Ext.ux.grid.ColumnHeaderGroup()],
                cm: colModel,
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
        function PrintReceiveBill(val) {
            opencenterwin("ReceiveDocumentPrint.aspx?id=" + val, "", 1000, 650);
        }
        function showwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("ReceiveDocumentEdit.aspx?op=v&id=" + val, "", 1100, 650);
            });
        }
        function showflowwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + val, "", 1100, 650);
            });
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "FileName":
                    //                    if (record.get("WorkFlowState")) {
                    //                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                    //                                                     record.get('Id') + "\")'>" + value + "</label>";
                    //                    }
                    //                    else {
                    cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                    rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
                    //}
                    break;
                case "Id":
                    rtn = "";
                    if (record.get("WorkFlowState") == "Flowing" || record.get("WorkFlowState") == "End") {
                        rtn += "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                      value + "\")'>跟踪</label>  ";
                    }
                    break;
                case "ReceiveReason":
                    if (value) {
                        cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                        rtn = value;
                    }
                    break;
                case "WorkFlowState":
                    if (value) {
                        rtn = eval('AimState["WorkFlowState"].' + value);
                    }
                    else {
                        rtn = "申请";
                    }
                    break;
                case "ReceiveWord":
                    if (value) {
                        rtn = value + record.get("ReceiveWordSize");
                    }
                    break;
            }
            return rtn;
        }
        function AutoExecuteFlow(workflowinfo, id) {
            var strarray = workflowinfo.split(",");
            jQuery.ajaxExec('AutoExecuteFlow', { WorkFlowInfo: strarray, id: id }, function(rtn) {
                AimDlg.show("提交成功！");
                onExecuted();
                Ext.getBody().unmask();
            });
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
