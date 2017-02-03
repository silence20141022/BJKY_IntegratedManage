<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="A_TaskWBSList.aspx.cs" Inherits="Aim.AM.Web.A_TaskWBSList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = "dialogWidth:900px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;";
        var EditPageUrl = "A_TaskWBSEdit.aspx";
        var ParentId = $.getQueryString({ "ID": "ParentId", "DefaultValue": "0" });
        var enumType = { '0': '未下达', '1': '进行中', '1.5': '待审批', '2': '已完成' };

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
            SetAddFunction();
        }
        function SetAddFunction() {
            var taskType = $.getQueryString({ "ID": "TaskType", "DefaultValue": "" });
            if (taskType.indexOf("目标") >= 0 && taskType != "子目标") {
                Ext.getCmp("btnAddStep").hide();
                Ext.getCmp("btnAddChild").show();
            }
            else if (taskType == "里程碑") {
            }
            else {
            }
            if (AimState["TaskParent"] && AimState["TaskParent"].DutyId && AimState["TaskParent"].DutyId.indexOf("<%=this.UserInfo.UserID %>") < 0) {
                Ext.getCmp("btnAddStep").hide();
                Ext.getCmp("btnAdd").hide();
                Ext.getCmp("btnAddChild").hide();
                Ext.getCmp("btnModify").hide();
                Ext.getCmp("btnDelete").hide();
            }
            Ext.getCmp("btnAddStep").hide();
            Ext.getCmp("btnAdd").hide();
            Ext.getCmp("btnAddChild").hide();
            Ext.getCmp("btnModify").hide();
            Ext.getCmp("btnDelete").hide();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["A_TaskWBSList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'A_TaskWBSList',
                idProperty: 'Id',
                data: myData,
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
			{ name: 'SubmitDate' },
			{ name: 'DutyId' },
			{ name: 'DutyName' },
			{ name: 'UserIds' },
			{ name: 'UserNames' },
			{ name: 'LeaderId' },
			{ name: 'LeaderName' },
			{ name: 'SecondDeptIds' },
			{ name: 'SecondDeptNames' },
			{ name: 'DeptCharge' },
			{ name: 'AimDeptCharge' },
			{ name: 'ReceiveDate' },
			{ name: 'ImportantRemark' },
			{ name: 'Remark' },
			{ name: 'Attachment' },
			{ name: 'FactWorkHours' },
			{ name: 'PlanStartDate' },
			{ name: 'PlanEndDate' },
			{ name: 'FactStartDate' },
			{ name: 'FactEndDate' },
			{ name: 'TaskProgress' },
			{ name: 'Suggestion' },
			{ name: 'RejectReason' },
			{ name: 'ExecuteRemark' },
			{ name: 'AttachmentChild' },
			{ name: 'ExamStandard' },
			{ name: 'Ext1' },
			{ name: 'Ext2' },
			{ name: 'ExtTime1' },
			{ name: 'ExtTime2' },
			{ name: 'Ext3' },
			{ name: 'Ext4' },
			{ name: 'Year' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			], listeners: { "aimbeforeload": function(proxy, options) {
			    options.data = options.data || {};
			    options.data.op = pgOperation || null;
			    options.data.ParentId = ParentId;
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
                { fieldLabel: '名称', id: 'Name', schopts: { qryopts: "{ mode: 'Like', field: 'Name' }"} },
                { fieldLabel: '编码', id: 'Code', schopts: { qryopts: "{ mode: 'Like', field: 'Code' }"} },
                { fieldLabel: '创建人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加子任务', id: 'btnAdd',
                    iconCls: 'aim-icon-member',
                    handler: function() {
                        if (AimState["TaskParent"].State == "2") {
                            alert("任务已完成,此操作被禁止!");
                            return;
                        }
                        OpenModelWin(EditPageUrl, { op: "cs", id: ParentId }, EditWinStyle, function() { store.reload(); });
                    }
                }, {
                    text: '添加里程碑', id: 'btnAddStep', hidden: true,
                    iconCls: 'aim-icon-flag',
                    handler: function() {
                        OpenModelWin(EditPageUrl, { op: "cs", id: ParentId, TaskType: '里程碑' }, EditWinStyle, function() { store.reload(); });
                    }
                }, {
                    text: '添加子目标', id: 'btnAddChild', hidden: true,
                    iconCls: 'aim-icon-details-open',
                    handler: function() {
                        if (AimState["TaskParent"].State == "2") {
                            alert("任务已完成,此操作被禁止!");
                            return;
                        }
                        OpenModelWin(EditPageUrl, { op: "cs", id: ParentId, TaskType: '子目标' }, EditWinStyle, function() { store.reload(); });
                    }
                }, {
                    text: '修改', id: 'btnModify',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        for (var i = 0; i < recs.length; i++) {
                            if (recs[i].get("State") == "1") {
                                alert("进行中的任务不能被修改,请回收任务后再修改!");
                                return;
                            }
                        }
                        OpenModelWin(EditPageUrl, { op: "u", id: recs[0].id, IsChild: "true" }, EditWinStyle, function() { store.reload(); });
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
                        for (var i = 0; i < recs.length; i++) {
                            if (recs[i].get("State") == "1") {
                                alert("进行中的任务不能被删除,请回收任务后再删除!");
                                return;
                            }
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
                    autoExpandColumn: 'TaskName',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
				    { id: 'Flag', dataIndex: 'Flag', header: "标牌", width: 35, renderer: linkRender, sortable: true },
					{ id: 'Code', dataIndex: 'Code', header: '编号', width: 80, sortable: true },
					{ id: 'TaskName', dataIndex: 'TaskName', header: '任务名称', linkparams: { url: EditPageUrl, style: CenterWin("width=900,height=600,scrollbars=yes") }, width: 100, sortable: true },
					{ id: 'Balance', dataIndex: 'Balance', width: 60, sortable: true, header: '权重' },
					{ id: 'PlanEndDate', dataIndex: 'PlanEndDate', header: '计划完成时间', width: 80, renderer: ExtGridDateOnlyRender, sortable: true },
					{ id: 'FactEndDate', dataIndex: 'FactEndDate', header: '实际完成时间', width: 80, renderer: ExtGridDateOnlyRender, sortable: true },
					{ id: 'DutyName', dataIndex: 'DutyName', header: '责任人', width: 80, sortable: true },
					{ id: 'State', dataIndex: 'State', header: '状态', width: 45, sortable: true, enumdata: enumType },
					{ id: 'TaskProgress', dataIndex: 'TaskProgress', header: '完成进度', width: 80, sortable: true, renderer: linkRender }
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

            function linkRender(val, p, rec, rowIndex, columnIndex, store) {
                var rtn = "";
                var url = "";
                switch (this.id) {
                    case "Flag":
                        var title = "未开始";
                        url = "green.png";
                        if (rec.get("State") == "0") {
                            url = "gray.png";
                        }
                        else if (rec.get("State") == "1" || rec.get("State") == "2") {
                            url = "green.png";
                            title = "正常";
                            if (rec.get("State") == "1")
                                url = "gray.png";
                            if (rec.get("PlanEndDate") != null && rec.get("PlanEndDate") != "" && (rec.get("FactEndDate") == null || rec.get("FactEndDate") == "") && rec.get("PlanEndDate") < new Date()) {
                                url = "red.png";
                                title = "已延期";
                            }
                            else if (rec.get("PlanEndDate") != null && rec.get("PlanEndDate") != "" && rec.get("FactEndDate") != null && rec.get("FactEndDate") != "" && rec.get("PlanEndDate") < rec.get("FactEndDate")) {
                                url = "red.png";
                                title = "已延期";
                            }
                        }
                        val = "<img style='width:18px; height:18px; padding:0px; margin:0px; border:0px;' src='/images/shared/" + url + "' title='" + title + "'/>";
                        return val;
                        break;
                    case "Remark":
                    case "ImportantRemark":
                        p.attr = 'ext:qtitle =""' + ' ext:qtip ="' + val + '"';
                        return val;
                        break;
                    case "TaskProgress":
                        val = val == null ? "0" : val;
                        rtn = "<div style='cursor:hand;width:98%;border:2px;background-color:#D0D0D0;' onclick=\"showWin('A_ChargeProgresList.aspx','" + progressStyle + "')\"><span style='width:" + val + "%;background-color:#8DB2E3;'></span><span style='position:absolute;left:6px;'>" + val + "%</span></div>";
                        break;
                }

                return rtn;
            }
            var progressStyle = "dialogWidth:900px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;"
            function showWin(url, style, op, rec) {
                op = op || "c";
                rec = rec || grid.getSelectionModel().getSelections()[0];
                OpenModelWin(url, { op: op, TaskId: rec.id }, style, function() {
                });
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
