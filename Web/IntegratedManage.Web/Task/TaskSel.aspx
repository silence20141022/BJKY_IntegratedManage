<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="TaskSel.aspx.cs" Inherits="Aim.AM.Web.Aim.Task.TaskSel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <script src="TaskWBS.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-sel.js" type="text/javascript"></script>

    <script type="text/javascript">
        var EditWinStyle = "dialogWidth:900px; dialogHeight:660px; scroll:yes; center:yes; status:no; resizable:yes;";
        var EditPageUrl = "A_TaskWBSEdit.aspx";
        var CYear = $.getQueryString({ "ID": "Type", "DefaultValue": new Date().getFullYear() });
        var enumType = { '0': '新建', '1': '进行中', '2': '已完成' };
        var enumImportant = { 0: "普通", 1: "重要", 2: "很重要" };

        var viewport, store, grid;
        var DataRecord;
        var topid, topnode; //  右键行

        function onPgLoad() {
            if (window.parent.collapseAccordion) {
                window.parent.collapseAccordion(true);
            }
            clipBoard = { records: [] }; // 剪切板;

            topnode = AimState["TopNode"];

            setPgUI();
        }

        function setPgUI() {
            var data = adjustData(AimState["DtList"]) || [];

            DataRecord = Ext.data.Record.create([
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
                        options.data.IsSearch = false;
                        options.data.DeptName = Ext.getCmp("Department").getValue();
                        /*for (var item in AimState["AimType"]) {
                            eval("options.data." + item + " = " + Ext.getCmp("ckb" + item).getValue());
                        }*/
                    }
                    else {
                        options.reqaction = "querychildren";
                    }

                    if (rec) {
                        options.data.pids = [rec.id];
                    }
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'Id', dsname: 'DtList' }, DataRecord)
            });

            // 搜索栏
            var schBar = new Ext.ux.AimSchPanel({
                collapsed: true,
                items: [{ fieldLabel: '科目类别', id: 'Type', xtype: 'aimcombo', required: true, enumdata: AimState["BudgetType"], listeners: { 'afterrender': function(obj) { obj.setValue(0) }, 'select': function(obj) { CYear = obj.getValue(); grid.clearNodes(); store.reload({ "IsSearch": true }); } }, schopts: { qryopts: "{ mode: 'Like', field: 'Type' }"}}]
            });
            /*schBar.on('specialkey', function(f, e) {
            if (e.getKey() == e.ENTER) {
            alert();
            }
            }, schBar);*/
            // 工具栏
            var tlBar = new Ext.ux.AimToolbar({
                items: ['<span style=font-size:12px>目标任务选择</span>', '-', { text: '展开下一级任务',
                    iconCls: 'aim-icon-details', handler: function() { store.expandAll(); }
                }, '-', { html: '<span style=font-size:12px>年份:</span>', xtype: 'tbtext' },
                { id: 'Type', width: 80, xtype: 'aimcombo', required: true, enumdata: AimState["Years"],
                    listeners: {
                        'afterrender': function(obj) {
                            obj.setValue('<%=DateTime.Now.Year %>')
                        },
                        'select': function(obj) {
                            CYear = obj.getValue();
                            store.removeAll(true);
                            store.reload({ "IsSearch": true });
                        }
                    }
                }, '-', { html: '<span style=font-size:12px>部门/副院长:</span>', xtype: 'tbtext' },
                { id: 'Department', width: 160, xtype: 'aimcombo', required: true, enumdata: AimState["Depts"],
                    listeners: {
                        'afterrender': function(obj) {
                            obj.setValue(AimState["CurrentDept"])
                        },
                        'select': function(obj) {
                            store.removeAll(true);
                            store.reload({ "IsSearch": true });
                        }
                    }
                }, '->', { text: '选择', iconCls: 'aim-icon-accept', handler: function() {
                    AimGridSelect();
                }
}]
                });
                /*for (var item in AimState["AimType"]) {
                var tempbar = new Ext.form.Checkbox({
                id: 'ckb' + item,
                checked: true,
                boxLabel: "<span style=font-size:12px>" + item + "</span>",
                handler: function() {
                grid.clearNodes();
                store.removeAll(true);
                store.reload({ "IsSearch": true });
                }
                });
                tlBar.addItem(tempbar);
                eval("ckb" + item + "=true");
                }*/
                // 工具标题栏
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
				{ id: 'Flag', dataIndex: 'Flag', header: "标牌", width: 35, renderer: linkRender, sortable: true },
				{ id: 'Code', dataIndex: 'Code', header: "编号", width: 150, sortable: true },
				{ id: 'TaskName', dataIndex: 'TaskName', header: "任务名称", width: 190, sortable: true },
				{ id: 'PlanEndDate', dataIndex: 'PlanEndDate', header: "计划完成时间", renderer: ExtGridDateOnlyRender, width: 80, sortable: true },
				{ id: 'LeaderName', dataIndex: 'LeaderName', header: "分管领导", width: 60, sortable: true },
				{ id: 'DeptName', dataIndex: 'DeptName', header: "主办部门", width: 80, sortable: true },
				{ id: 'SecondDeptNames', dataIndex: 'SecondDeptNames', header: "协办部门", width: 80, sortable: true }
      ],
                    autoExpandColumn: 'TaskName',
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
                            store.singleSort('SortIndex', 'ASC');
                        }
                    });
                });
                //grid.on('celldblclick', DBClickGrid);
                //grid.on('rowcontextmenu', ShowMenu)

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid
                    ]
                });

                AimSelGrid = grid;
                // 展开所有加载的节点
                store.expandAll();
            }
            function DBClickGrid(gd, rowIndex, colIndex, evt) {
                var rec = store.getAt(rowIndex);
                if (rec.get("State") == "1")
                    showEditWin('r', store.getAt(rowIndex));
                else
                    showEditWin('u', store.getAt(rowIndex));
            }
            function ShowMenu(grid, rowIdx, e, e2) {
                if (arguments.length == 4) e = e2;
                e.preventDefault(); // 抑制IE右键菜单

                var grid = this;
                var store = this.store;
                var xy = e.getXY();

                grid.contextRow = store.getAt(rowIdx);

                var sels = grid.getSelections();

                if (!sels || sels.length < 0 || $.inArray(this.contextRow, sels) < 0) {
                    grid.selectRow(rowIdx);
                }

                if (!grid.rowContextMenu) {
                    grid.rowContextMenu = new Ext.menu.Menu({ id: 'contextMenu', items: [{
                        id: 'menuItemAddSid', hidden: true,
                        text: '新增平级',
                        handler: function() {
                            showEditWin('c', grid.contextRow);
                        }
                    }, {
                        id: 'menuItemAddSub',
                        iconCls: 'aim-icon-add',
                        text: '新增子任务',
                        handler: function() {
                            showEditWin('cs', grid.contextRow);
                        }
                    }, '-', {
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
                    }, {
                        id: 'menuItemView',
                        iconCls: 'aim-icon-search',
                        text: '查看',
                        handler: function() {
                            showEditWin('r', grid.contextRow);
                        }
                    }, '-', {
                        id: 'menuItemSub',
                        iconCls: 'aim-icon-execute',
                        text: '下达',
                        handler: function() {
                            var rec = grid.contextRow;
                            $.ajaxExec("submittask", { "Id": rec.id }, function() {
                                AimDlg.show("下达成功！");
                                store.remove(rec);
                                store.reload({ params: { data: { ids: [rec.id]}} });
                            });
                        }
                    }, {
                        id: 'menuItemBack',
                        iconCls: 'aim-icon-execute',
                        text: '收回',
                        handler: function() {
                            var rec = grid.contextRow;
                            $.ajaxExec("backtask", { "Id": rec.id }, function() {
                                AimDlg.show("收回成功！");
                                store.remove(rec);
                                store.reload({ params: { data: { ids: [rec.id]}} });
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
                    } else {
                        Ext.getCmp('menuItemDelete').setDisabled(false);
                    }

                    if (isroot) {
                        Ext.getCmp('menuItemDelete').setDisabled(true);
                        Ext.getCmp('menuItemUpdate').setDisabled(true);
                        Ext.getCmp('menuItemAddSid').setDisabled(true);
                        Ext.getCmp('menuItemPasteAsSib').setDisabled(true);
                    } else {
                        Ext.getCmp('menuItemUpdate').setDisabled(false);
                        Ext.getCmp('menuItemAddSid').setDisabled(false);
                        Ext.getCmp('menuItemPasteAsSib').setDisabled(false);
                    }

                    if (grid.clipBoard.records && grid.clipBoard.records.length > 0) {
                        Ext.getCmp('menuItemPaste').setDisabled(false);
                    } else {
                        Ext.getCmp('menuItemPaste').setDisabled(true);
                    }
                    if (grid.contextRow.json.State == "0" || !grid.contextRow.json.State) {
                        Ext.getCmp('menuItemSub').setDisabled(false);
                        Ext.getCmp('menuItemUpdate').setDisabled(false);
                        Ext.getCmp('menuItemDelete').setDisabled(false);
                    }
                    else {
                        Ext.getCmp('menuItemSub').setDisabled(true);
                        Ext.getCmp('menuItemUpdate').setDisabled(true);
                        Ext.getCmp('menuItemDelete').setDisabled(true);
                    }
                    if (grid.contextRow.json.State == "1")
                        Ext.getCmp('menuItemBack').setDisabled(false);
                    else
                        Ext.getCmp('menuItemBack').setDisabled(true);

                    if (isroot) {
                        Ext.getCmp('menuItemDelete').setDisabled(true);
                    }

                }

                this.rowContextMenu.showAt(xy);
            }

            function adjustData(jdata) {
                if ($.isArray(jdata)) {
                    $.each(jdata, function() {
                        if (topid && topid == this.ParentID) {
                            //this.ParentID = null;
                        }
                    });

                    return jdata;
                } else {
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

                        // 刷新已删除的记录的父节点
                        store.reload({ params: { data: { ids: pids, pids: pids}} });

                        store.singleSort('SortIndex', 'ASC');
                    }
                });
            }

            function showEditWin(op, rec) {
                OpenModelWin(EditPageUrl, { op: op, id: rec.id, 'Type': CYear }, op != "cs" ? EditWinStyle : "dialogWidth:900px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;", function() {
                    var expnode = null; // 重新加载后需要展开的节点
                    switch (op) {
                        case 'c':
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
                        case 'u':
                            store.remove(rec);
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

            // 提交数据成功后
            function onExecuted() {
                // store.reload();
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            任务</h1>
    </div>
</asp:Content>
