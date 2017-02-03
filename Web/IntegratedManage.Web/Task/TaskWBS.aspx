<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="TaskWBS.aspx.cs" Inherits="Aim.AM.Web.Aim.Task.TaskWBS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <script src="TaskWBS.js" type="text/javascript"></script>

    <script type="text/javascript">
        var EditWinStyle = "dialogWidth:1000px; dialogHeight:660px; scroll:yes; center:yes; status:no; resizable:yes;";
        var EditPageUrl = "A_TaskWBSEdit.aspx";
        var CYear = $.getQueryString({ "ID": "Type", "DefaultValue": new Date().getFullYear() });
        var enumType = { '0': '未下达', '1': '进行中', '1.5': '待审批', '2': '已完成' };
        var enumImportant = { 0: "普通", 1: "重要", 2: "很重要" };
        var data, DataRecord, viewport, store, schBar, tlBar, grid;
        var topid, topnode; //  右键行
        var CKBEvt = true;
        var IsShowAll = false;
        function onPgLoad() {
            if (window.parent.collapseAccordion) {
                window.parent.collapseAccordion(true);
            }
            clipBoard = { records: [] }; // 剪切板;
            topnode = AimState["TopNode"];
            setPgUI();
        }
        function ReplaceChar(code) {
            var s = 0;
            switch (code) {
                case "A":
                    s = 1;
                    break;
                case "B":
                    s = 2;
                    break;
                case "C":
                    s = 3;
                    break;
                case "D":
                    s = 4;
                    break;
            }
            return s;
        }
        function setPgUI() {
            data = adjustData(AimState["DtList"]) || [];
            DataRecord = Ext.data.Record.create([
			{ name: 'Id' }, { name: 'ParentID' }, { name: 'Path' }, { name: 'PathLevel' },
			{ name: 'IsLeaf' }, { name: 'SortIndex' }, { name: 'EditStatus' }, { name: 'Tag' },
			{ name: 'LastModifiedDate' }, { name: 'State' }, { name: 'Flag' }, { name: 'DeptId' }, { name: 'DeptName' },
			{ name: 'Code' }, { name: 'TaskName' }, { name: 'RefTaskCode' }, { name: 'RefTaskName' }, { name: 'TaskType' },
			{ name: 'Balance' }, { name: 'PlanWorkHours' },
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
			{ name: 'PlanStartDate', type: 'date' },
			{ name: 'PlanEndDate', type: 'date' },
			{ name: 'FactStartDate', type: 'date' },
			{ name: 'FactEndDate', type: 'date' },
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
			]);
            store = new Ext.ux.data.AimAdjacencyListStore({
                data: data,
                aimbeforeload: function(proxy, options) {
                    options.data.Year = CYear;
                    var rec = store.getById(options.anode);
                    if (options.data.IsSearch) {
                        options.reqaction = null;
                        options.anode = null;
                        options.data.anode = null;
                        options.data.IsSearch = false;
                        //options.data.DeptName = Ext.getCmp("Department").getValue();
                        for (var item in AimState["AimType"]) {
                            eval("options.data." + item + " = " + Ext.getCmp("ckb" + item).getValue());
                        }
                    }
                    else {
                        options.reqaction = "querychildren";
                    }

                    if (rec) {
                        options.data.pids = [rec.id];
                    }
                    options.data.IsShowAll = IsShowAll;
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'Id', dsname: 'DtList' }, DataRecord)
            });
            schBar = new Ext.ux.AimSchPanel({
                collapsed: true,
                items: []
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{ text: '新增任务',
                    iconCls: 'aim-icon-add', handler: function() { showEditWin('c', null); }
                }, '-',
                 { text: '分解任务',
                     iconCls: 'aim-icon-split', handler: function() {
                         var recs = grid.getSelectionModel().getSelections();
                         if (!recs || recs.length <= 0) {
                             AimDlg.show("请先选择要分解的任务！");
                             return;
                         }
                         if (recs[0].get("DutyId") != AimState["UserInfo"].UserID || recs[0].get("State") == "2") {
                             AimDlg.show("不是负责人或者已完成的任务不能分解！");
                             return;
                         }
                         showEditWin('cs', recs[0], "子任务");
                     }
                 }, '-',
                { text: '进度填报', iconCls: 'aim-icon-progress-bar', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (recs && recs.length <= 0) {
                        AimDlg.show("请先选择要填报进度的任务！");
                        return;
                    }
                    if (recs[0].get("DutyId") != AimState["UserInfo"].UserID || recs[0].get("State") == "2") {
                        AimDlg.show("自己作为负责人或者进行中的任务才能填报进度！");
                        return;
                    }
                    opencenterwin("A_ChargeProgresList.aspx?TaskId=" + recs[0].get("Id"), '', 1000, 500);
                }
                }, '-',
                //                { text: '展开下一级任务',
                //                    iconCls: 'aim-icon-details', handler: function() { store.expandAll(); }
                //                },
                //                 {text: '刷新选中任务', id: 'btnRefresh',
                //                 iconCls: 'aim-icon-refresh', handler: function() {
                //                     if (grid.getSelections().length == 0) return;
                //                     var rec = grid.getSelections()[0];
                //                     store.reload({ params: { data: { ids: [rec.id]}} });
                //                 }
                //             },
                //              {text: '刷新全部', id: 'btnRefresh1',
                //              iconCls: 'aim-icon-refresh', handler: function() {
                //                  window.location.reload();
                //              }
                //          },
                {text: '图形分析',
                iconCls: 'aim-icon-chart', handler: function() {
                    ViewChart();
                }
            }, '-', { html: '<span style=font-size:12px>年份:</span>', xtype: 'tbtext' },
                { id: 'Type', width: 80, xtype: 'aimcombo', required: true, enumdata: AimState["Years"],
                    listeners: {
                        'afterrender': function(obj) {
                            obj.setValue('<%=year %>')
                        },
                        'select': function(obj) {
                            CYear = obj.getValue();
                            grid.clearNodes();
                            store.removeAll(true);
                            store.reload({ "IsSearch": true });
                        }
                    }
}]
        });
        for (var item in AimState["AimType"]) {
            var tempbar = new Ext.form.Checkbox({
                id: 'ckb' + item,
                checked: true,
                hidden: true,
                boxLabel: "<span style=font-size:12px>" + item + "</span>",
                handler: function() {
                    if (!CKBEvt) return false;
                    grid.clearNodes();
                    store.removeAll(true);
                    store.reload({ "IsSearch": true });
                }
            });
            tlBar.addItem(tempbar);
            eval("ckb" + item + "=true");
        }
        if ("<%=isLeaderCompany %>" == "T") {
            var tempbar = new Ext.form.Checkbox({
                id: 'ckbAll',
                boxLabel: "<span style=font-size:12px>全部</span>",
                handler: function() {
                    IsShowAll = this.getValue();
                    store.reload({ "IsSearch": true });
                }
            });
            tlBar.addItem(tempbar);
        }
        var titPanel = new Ext.ux.AimPanel({
            tbar: tlBar,
            items: [schBar]
        });

        // 表格面板
        grid = new Ext.ux.grid.AimEditorTreeGridPanelEx({
            store: store,
            master_column_id: 'Code',
            columnLines: true,
            region: 'center',
            columns: [
				{ id: 'Flag', dataIndex: 'Flag', header: "标牌", width: 35, renderer: linkRender, sortable: true, hidden: true },
				{ id: 'Code', dataIndex: 'Code', header: "编号", width: 150, sortable: true },
				{ id: 'TaskName', dataIndex: 'TaskName', header: "工作/任务名称", width: 190, sortable: true, renderer: RowRender },
				{ id: 'DutyName', dataIndex: 'DutyName', header: "负责人", width: 60, sortable: true },
				{ id: 'TaskProgress', dataIndex: 'TaskProgress', header: "任务进度", width: 80, sortable: true, renderer: RowRender },
				{ id: 'PlanWorkHours', dataIndex: 'PlanWorkHours', header: "计划工时", width: 60, sortable: true },
				{ id: 'PlanEndDate', dataIndex: 'PlanEndDate', header: "计划完成时间", renderer: ExtGridDateOnlyRender, width: 80, sortable: true },
				{ id: 'FactEndDate', dataIndex: 'FactEndDate', header: "实际完成时间", renderer: ExtGridDateOnlyRender, width: 80, sortable: true },
				{ id: 'LeaderName', dataIndex: 'LeaderName', header: "分管领导", width: 60, sortable: true },
				{ id: 'DeptName', dataIndex: 'DeptName', header: "主办部门", width: 80, sortable: true, renderer: linkRender },
				{ id: 'SecondDeptNames', dataIndex: 'SecondDeptNames', header: "协办部门", width: 80, sortable: true },
				{ id: 'State', dataIndex: 'State', header: "状态", renderer: linkRender, width: 50, sortable: true },
				{ id: 'Remark', dataIndex: 'Remark', header: "主要内容", renderer: linkRender, width: 200, sortable: true, renderer: linkRender },
				{ id: 'ImportantRemark', dataIndex: 'ImportantRemark', header: "里程碑进度说明", renderer: linkRender, width: 200, sortable: true, renderer: linkRender },
				{ id: 'TaskType', dataIndex: 'TaskType', header: "工作类型", width: 80, sortable: true, hidden: true },
				{ id: 'CreateName', dataIndex: 'CreateName', header: "创建人", width: 70, sortable: true }
      ],
            autoExpandColumn: 'Remark',
            tbar: titPanel
        });
        grid.on('paste', function(grid, type, rec, cb) {
            var pdstype = cb.type;
            var recs = this.clipBoard.records;
            var idList = this.getIdStringList(recs);
            var pids = [];  // 需要刷新的节点

            $.ajaxExec('paste', { "IdList": idList, type: type, pdstype: pdstype, tid: rec.id }, function() {
                var selrecs = grid.getSelections();
                $.merge(recs, selrecs);

                if (pdstype == 'cut') {
                    // 删除所有复制节点
                    $.each(recs, function() {
                        if (store.getById(this.id)) {
                            // 若存在则删除节点
                            store.remove(this);
                        }
                    });

                    if (type == 'sub') {
                        pids = $.map(recs, function(n, i) {
                            return n.data["ParentID"];
                        });

                        $.merge(pids, [rec.id]);
                    } else {
                        pids = $.map(recs, function(n, i) {
                            return n.data["ParentID"];
                        });

                        $.merge(pids, [rec.data["ParentID"] || null, rec.id]);
                    }
                } else {
                    store.remove(rec);
                    pids = [rec.data["ParentID"]];
                }

                if (pids && pids.length > 0) {
                    grid.reload({ pids: pids });
                    //store.singleSort('SortIndex', 'ASC');
                }
            });
        });
        // grid.on('celldblclick', DBClickGrid);
        grid.on('rowcontextmenu', ShowMenu)
        viewport = new Ext.ux.AimViewport({
            layout: 'border',
            items: [grid
                    ]
        });

        // 展开所有加载的节点
        store.expandAll();
    }
    function DBClickGrid(gd, rowIndex, colIndex, evt) {
        var rec = store.getAt(rowIndex);
        var type = rec.get("TaskType") == "任务" ? "子任务" : "";
        if (rec.get("State") == "1" || rec.get("TaskProgress") == "100")
            showEditWin('r', store.getAt(rowIndex), type);
        else {
            showEditWin('u', store.getAt(rowIndex), type);
        }
    }
    function ShowMenu(grid, rowIdx, e, e2) {
        if (arguments.length == 4) e = e2;
        e.preventDefault(); // 抑制IE右键菜单
        var grid = this;
        var store = this.store;
        var xy = e.getXY();
        grid.contextRow = store.getAt(rowIdx);
        if (store.getAt(rowIdx).get("DutyId") && store.getAt(rowIdx).get("DutyId").indexOf("<%=this.UserInfo.UserID %>") < 0 && store.getAt(rowIdx).get("CreateId") != "<%=this.UserInfo.UserID %>" && "<%=isLeader %>" == "F") {
            alert("您不是负责人,没有权限!"); return;
        }
        var sels = grid.getSelections();
        if (!sels || sels.length < 0 || $.inArray(this.contextRow, sels) < 0) {
            grid.selectRow(rowIdx);
        }
        if (!grid.rowContextMenu) {
            grid.rowContextMenu = new Ext.menu.Menu({ id: 'contextMenu', items: [
            {
                id: 'menuItemAddSid', hidden: true,
                text: '新增平级',
                handler: function() {
                    showEditWin('c', grid.contextRow);
                }
            },
             {
                id: 'menuItemAddSub1',
                iconCls: 'aim-icon-member',
                text: '新增子任务',
                handler: function() {
                    if (grid.contextRow.get("State") == "2") {
                        alert("任务已完成,此操作被禁止!");
                        return;
                    }
                    //主管领导从部门带过来的任务不让分解
                    if ("<%=isLeaderCompany %>" == "T") {
                        if (grid.contextRow.data.Flag != null) {
                            alert("您从部门引入的目标不需要分解,由相关部门负责分解执行,如需查看请选择相关部门!");
                            return;
                        }
                    }
                    showEditWin('cs', grid.contextRow, "子任务");
                }
            }, {
                id: 'menuItemAddSub2',
                iconCls: 'aim-icon-flag',
                text: '新增里程碑',
                handler: function() {
                    showEditWin('cs', grid.contextRow, "里程碑");
                }
            },
            {
                id: 'menuItemAddSub',
                iconCls: 'aim-icon-add',
                text: '新增子任务',
                handler: function() {
                    if (grid.contextRow.get("State") == "2") {
                        alert("任务已完成,此操作被禁止!");
                        return;
                    }
                    //主管领导从部门带过来的任务不让分解
                    if ("<%=isLeaderCompany %>" == "T") {
                        if (grid.contextRow.data.Flag != null) {
                            alert("您从部门引入的目标不需要分解,由相关部门负责分解执行,如需查看请选择相关部门!");
                            return;
                        }
                    }
                    showEditWin('cs', grid.contextRow);
                }
            },
             '-', {
                 id: 'menuItemUpdate',
                 iconCls: 'aim-icon-edit',
                 text: '修改',
                 handler: function() {
                     showEditWin('u', grid.contextRow);
                 }
             }, {
                 id: 'menuItemDelete',
                 text: '删除',
                 iconCls: 'aim-icon-delete2',
                 handler: function() {
                     batchOperate('batchdelete');
                 }
             },
             '-', {
                 id: 'menuItemSub',
                 iconCls: 'aim-icon-execute',
                 text: '下达',
                 handler: function() {
                     var rec = grid.contextRow;
                     if (!rec.get("DutyId") || !rec.get("TaskName") || !rec.get("Code")) {
                         AimDlg.show("任务下达前任务编码、任务名称、任务责任人的为必输项！");
                         return;
                     }
                     $.ajaxExec("submittask", { "Id": rec.id }, function() {
                         AimDlg.show("下达成功！");
                         store.reload({ params: { data: { ids: [rec.id]}} });
                         store.commitChanges();
                     });
                 }
             }, {
                 id: 'menuItemBack',
                 iconCls: 'aim-icon-execute',
                 text: '收回',
                 handler: function() {
                     if (grid.contextRow.get("State") == "2") {
                         AimDlg.show("已完成的任务不能收回!");
                         return;
                     }
                     var rec = grid.contextRow;
                     $.ajaxExec("backtask", { "Id": rec.id }, function() {
                         AimDlg.show("收回成功！");
                         store.reload({ params: { data: { ids: [rec.id]}} });
                         store.commitChanges();
                     });
                 }
             }, {
                 id: 'menuItemCut', hidden: true,
                 iconCls: 'aim-icon-cut',
                 text: '剪切',
                 handler: function() {
                     grid.cut();
                 }
             }, {
                 id: 'menuItemPaste', hidden: true,
                 iconCls: 'aim-icon-plaster',
                 text: '粘贴',
                 menu: [{ id: 'menuItemPasteAsSib', text: '粘贴为同级节点', handler: function() {
                     grid.paste('sib');
                 }
                 }, { id: 'menuItemPasteAsSub', text: '粘贴为子节点', handler: function() {
                     grid.paste('sub');
                 }
                 }, {
                     id: 'menuItemCancelPanel', text: '取消', handler: function() {
                         grid.clearClipBoard();
                     }
                 }
]
             }
]
            });
        }

        if (grid.contextRow) {
            var roots = store.getRootNodes();
            var isroot = (roots.indexOf(grid.contextRow) >= 0);
            var isleaf = store.isLeafNode(grid.contextRow);
            if (!isleaf || isroot) {
                Ext.getCmp('menuItemDelete').setDisabled(true);
            }
            else {
                Ext.getCmp('menuItemDelete').setDisabled(false);
            }
            if (isroot) {
                Ext.getCmp('menuItemDelete').setDisabled(true);
                Ext.getCmp('menuItemUpdate').setDisabled(true);
                Ext.getCmp('menuItemAddSid').setDisabled(true);
                Ext.getCmp('menuItemPasteAsSib').setDisabled(true);
                // Ext.getCmp('menuItemBack').setDisabled(true);
                Ext.getCmp('menuItemAddSub').hide();
            }
            else {
                Ext.getCmp('menuItemUpdate').setDisabled(false);
                Ext.getCmp('menuItemAddSid').setDisabled(false);
                Ext.getCmp('menuItemPasteAsSib').setDisabled(false);
                Ext.getCmp('menuItemAddSub').show();
            }
            if (grid.clipBoard.records && grid.clipBoard.records.length > 0) {
                Ext.getCmp('menuItemPaste').setDisabled(false);
            }
            else {
                Ext.getCmp('menuItemPaste').setDisabled(true);
            }
            if (grid.contextRow.data.State == "0" || !grid.contextRow.data.State) {
                Ext.getCmp('menuItemSub').setDisabled(false);
                Ext.getCmp('menuItemUpdate').setDisabled(false);
                Ext.getCmp('menuItemDelete').setDisabled(false);
            }
            else {
                Ext.getCmp('menuItemSub').setDisabled(true);
                Ext.getCmp('menuItemUpdate').setDisabled(true);
                Ext.getCmp('menuItemDelete').setDisabled(true);
            }
            if (grid.contextRow.data.PathLevel == "0") {
                // Ext.getCmp('menuItemBack').setDisabled(true);
            }
            //                    else if (grid.contextRow.data.State == "1") {
            //                        Ext.getCmp('menuItemBack').setDisabled(false);
            //                    }
            //                    else {
            //                        Ext.getCmp('menuItemBack').setDisabled(true);
            //                    }
            if (grid.contextRow.data.TaskType.indexOf("任务") >= 0 && grid.contextRow.data.TaskType != "子任务") {
                Ext.getCmp('menuItemAddSub2').hide();
                Ext.getCmp('menuItemAddSub1').show();

            }
            else {
                Ext.getCmp('menuItemAddSub2').hide();
                Ext.getCmp('menuItemAddSub1').hide();
            }
            //                    if (isroot || (store.getAt(rowIdx).get("CreateId") != "<%=this.UserInfo.UserID %>" && "<%=isLeader %>" == "F")) {
            //                        Ext.getCmp('menuItemBack').setDisabled(true);
            //                    }
            //                    else {
            //                        Ext.getCmp('menuItemBack').setDisabled(false);
            //                    }
            //                    if (store.getAt(rowIdx).get("DutyId") == null || store.getAt(rowIdx).get("DutyId") == "") {
            //                        Ext.getCmp('menuItemUpdate').setDisabled(false);
            //                    }
            //                    else {
            //                        Ext.getCmp('menuItemUpdate').setDisabled(true);
            //                    }

        }
        this.rowContextMenu.showAt(xy);
    }
    function adjustData(jdata) {
        if ($.isArray(jdata)) {
            $.each(jdata, function() {
                if (topid && topid == this.ParentID) {
                }
            });
            return jdata;
        }
        else {
            return [];
        }
    }

    function batchOperate(action, recs, params, url) {
        recs = recs || grid.getSelections();

        if (!recs || recs.length <= 0) {
            AimDlg.show("请先选择要操作的记录！");
            return;
        }

        if (action == 'batchdelete') {
            for (var i = 0; i < recs.length; i++) {
                if (!store.isLeafNode(recs[i])) {
                    AimDlg.show("存在子任务，请先删除子任务！");
                    return;
                }
            }

            if (!confirm("确定执行删除操作？")) {
                return;
            }
        }

        ExtBatchOperate(action, recs, params, url, function(args) {
            if (args.status == "success") {
                // 从store中删除已删除的记录
                var pids = $.map(recs, function(n, i) {
                    var tpid = n.data["ParentID"];
                    store.remove(n);
                    return tpid;
                });
                store.singleSort('SortIndex', 'ASC');
            }
        });
    }
    function opencenterwin(url, name, iWidth, iHeight) {
        var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
        var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
        window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
    }
    function showwin(val) {
        opencenterwin("A_TaskWBSEdit.aspx?op=v&id=" + val, "", 1100, 600);
    }
    function RowRender(val, cellmeta, record, rowIndex, columnIndex, store) {
        var rtn = "";
        switch (this.id) {
            case "TaskName":
                cellmeta.attr = 'ext:qtitle="" ext:qtip="' + val + '"';
                rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + val + "</label>";
                break;
            case "ReceiveReason":
                if (value) {
                    cellmeta.attr = 'ext:qtitle="" ext:qtip="' + val + '"';
                    rtn = val;
                }
                break;
            case "TaskProgress":
                val = val == null ? "0" : val;
                rtn = "<div style='width:98%;border-style:solid; border-width:1px; border-color:#8DB2E3;'>" +
                        "<span style='width:" + val + "%;background-color:#8DB2E3;'></span><span style='position:absolute;left:6px;'>" + val + "%</span></div>";
                break;
        }
        return rtn;
    }
    function showEditWin(op, rec, tasktype) {
        if (!rec) rec = {};
        sty = "dialogWidth:1100px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;";
        if (op == "c") {
            sty = "dialogWidth:1100px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;";
        }
        OpenModelWin(EditPageUrl, { op: op, id: rec.id, 'Type': CYear }, op != "cs" ? sty : "dialogWidth:1100px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;", function(rtn) {
            var expnode = null; // 重新加载后需要展开的节点
            switch (op) {
                case 'c':
                    if (!rec.json) {
                        window.location.reload();
                        return;
                    }
                    if (rec && rec.json.ParentID) {
                        var pnode = store.getById(rec.json.ParentID);
                        expnode = pnode;
                        store.remove(pnode);
                        if (pnode.parentNode) {
                            store.reload({ params: { data: { ids: [pnode.id], pids: [pnode.id]}} });
                        }
                        else {
                            store.reload({ params: { data: { ids: [pnode.id]}} });
                        }
                    }
                    break;
                case 'cs':
                    //这里要改一下。创建子任务的时候，如果取消了。不需要刷新这个页面
                case 'u':
                    store.reload({ params: { data: { ids: [rec.id]}} });
                    if (op == 'cs') {
                        expnode = rec;
                    }
                    break;
            }
            if (expnode && expnode.id) {
                // 展开节点
                $.ensureExec(function() {
                    var npnode = store.getById(expnode.id);
                    if (npnode) {
                        store.expandNode(npnode);
                        return true;
                    }

                    return false;
                });
            }
            store.singleSort('SortIndex', 'ASC');
        });
    } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            任务下发分解</h1>
    </div>
</asp:Content>
