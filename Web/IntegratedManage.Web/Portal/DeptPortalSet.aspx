<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="DeptPortalSet.aspx.cs" Inherits="IntegratedManage.Web.Portal.DeptPortalSet" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/ext/ux/FieldLabeler.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <script type="text/javascript">
        var EditWinStyle = "dialogWidth:550px; dialogHeight:250px; scroll:yes; center:yes; status:no; resizable:yes;";
        var EditPageUrl = "OrgStructureEdit.aspx";

        var DataRecord, store;
        var viewport, grid, contextMenu;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            var data = adjustData(AimState["DtList"]);

            DataRecord = Ext.data.Record.create([
        { name: 'WId', type: 'string' },
        { name: 'GroupID', type: 'string' },
        { name: 'ParentID', type: 'string' },
        { name: 'IsLeaf', type: 'bool' },
        { name: 'Name' },
        { name: 'Code' },
        { name: 'Type' },
        { name: 'Status' },
        { name: 'Description' },
        { name: 'SortIndex' },
        { name: 'CreateDate' }
        ]);

            store = new Ext.ux.data.AimAdjacencyListStore({
                data: data,
                aimbeforeload: function(proxy, options) {
                    var rec = store.getById(options.anode);
                    options.reqaction = "querychildren";

                    if (rec) {
                        options.data.id = rec.id;
                    }
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'GroupID', dsname: 'DtList',
                    aimread: function(rd, resp, dt) {
                        if (dt) {
                            dt = adjustData(dt);
                        }
                    }
                }, DataRecord)
            });

            // 搜索栏
            var schBar = new Ext.ux.AimSchPanel({
                items: []
            });

            // 工具栏
            var tlBar = new Ext.ux.AimToolbar({
                items: [{ text: '展开', handler: function() { store.expandAll(); }
                }, '-', { text: '开启', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0 || !recs[0].get("IsLeaf")) {
                        AimDlg.show("请先选择要开启的部门！");
                        return;
                    }
                    if (recs[0].get("WId") != "") {
                        AimDlg.show("部门门户已开启,无需重复开启!");
                        return;
                    }
                    else {
                        if (confirm("您确认要开启部门[" + recs[0].get("Name") + "]门户吗?")) {
                            $.ajaxExec("open", { id: recs[0].get("GroupID") }, function(rtn) {
                                AimDlg.show("开启成功,请配置门户栏目！");
                                recs[0].set("WId", rtn.data.DeptId);
                                frameContent.location.href = "/Home.aspx?IsManage=T&BlockType=DeptPortal&DeptId=" + recs[0].get("GroupID");
                            });
                        }
                    }
                }
                }, { text: '关闭', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0 || !recs[0].get("IsLeaf")) {
                        AimDlg.show("请先选择要关闭的部门！");
                        return;
                    }
                    if (recs[0].get("WId") == "") {
                        AimDlg.show("部门门户已关闭,无需重复关闭!");
                        return;
                    }
                    else {
                        if (confirm("您确认要关闭部门[" + recs[0].get("Name") + "]门户吗?")) {
                            $.ajaxExec("close", { id: recs[0].get("GroupID") }, function(rtn) {
                                AimDlg.show("关闭成功！");
                                recs[0].set("WId", "");
                                frameContent.location.href = "about:blank";
                            });
                        }
                    }
                } }]
                });


                // 工具标题栏
                var titPanel = new Ext.Panel({
                    tbar: tlBar,
                    items: [schBar]
                });

                var sm = new Ext.grid.RowSelectionModel({ singleSelect: false,
                    listeners: {
                        rowselect: function(g, ridx, e) {
                            var rec = store.getAt(ridx);
                            if (rec.get("IsLeaf") && rec.get("WId") != "") {
                                if (!frameContent.reloadPage) {
                                    frameContent.location.href = "/Home.aspx?IsManage=T&BlockType=DeptPortal&DeptId=" + rec.get("GroupID");
                                }

                                if (frameContent.reloadPage) {
                                    // 异步加载
                                    frameContent.reloadPage.call(this, { cid: rec.id });
                                }
                            }
                            else
                                frameContent.location.href = "about:blank";
                        }
                    }
                });

                // 表格面板
                grid = new Ext.ux.grid.AimEditorTreeGridPanel({
                    store: store,
                    master_column_id: 'Name',
                    region: 'west',
                    split: true,
                    width: 300,
                    minSize: 250,
                    maxSize: 500,
                    columns: [
				{ id: 'Name', header: "组织结构", renderer: colRender, width: 110, sortable: true, dataIndex: 'Name' },
				{ header: "门户开启状态", width: 85, sortable: true, dataIndex: 'WId', renderer: colRender }
      ],
                    sm: sm,
                    autoExpandColumn: 'Name',
                    tbar: titPanel
                });

                function colRender(val, p, rec) {
                    var rtn = val;
                    switch (this.dataIndex) {
                        case "WId":
                            if (!rec.get("IsLeaf"))
                                return "";
                            if (val == "")
                                return "<label onclick=\"SSSS();\" style='color:red;cursor:hand;'>未开启</label>";
                            else
                                return "<span style='color:blue;cursor:hand;' onclick=DeptOpt(\"" + rec.get("WId") + "\",\"" + rec.get("Name") + "\",0);>已开启</span>";
                            break;
                    }

                    return rtn;
                }
                /*grid.on("rowcontextmenu", function(grid, rowIdx, e) {
                e.preventDefault(); //这行是必须的
                showContextMenu(rowIdx, e.getXY());
                });*/

                //添加右键
                function showContextMenu(rowIdx, xy) {
                    if (pgOperation == 'r') {
                        return false;
                    }

                    var rec = store.getAt(rowIdx);

                    if (!contextMenu) {
                        contextMenu = new Ext.menu.Menu({ id: 'contextMenu' });

                        menuItemAddCls = new Ext.menu.Item({
                            id: 'menuItemAddSid',
                            text: '新增同级部门'
                        });

                        menuItemAdd = new Ext.menu.Item({
                            id: 'menuItemAddSub',
                            text: '新增下级部门'
                        });

                        menuItemAddSub = new Ext.menu.Item({
                            id: 'menuItemAddSubRole',
                            text: '新增组织角色'
                        });


                        menuItemUpdate = new Ext.menu.Item({
                            id: 'menuItemUpdate',
                            text: '修改'
                        });

                        menuItemDelete = new Ext.menu.Item({
                            id: 'menuItemDelete',
                            text: '删除'
                        });

                        // contextMenu.addItem(menuItemAddCls);
                        contextMenu.addItem(menuItemAdd);
                        contextMenu.addItem(menuItemAddSub);

                        contextMenu.addItem(menuItemUpdate);
                        contextMenu.addItem(menuItemDelete);
                    }

                    if (!rec.get('ParentID')) {
                        menuItemAddCls.setVisible(false);
                        menuItemDelete.setVisible(false);
                        menuItemUpdate.setVisible(false);
                    } else if (rec.get('Type') == '21') {
                        menuItemAddCls.setVisible(false)    // 创建节点
                        menuItemAdd.setVisible(false)    // 创建节点
                        menuItemAddSub.setVisible(false)    // 创建节点
                        menuItemDelete.setVisible(true);
                        menuItemUpdate.setVisible(true);
                    }
                    else {
                        menuItemAddCls.setVisible(true)    // 创建节点
                        menuItemAdd.setVisible(true)    // 创建节点
                        menuItemAddSub.setVisible(true)    // 创建节点
                        menuItemDelete.setVisible(true);
                        menuItemUpdate.setVisible(true);
                    }

                    // menuItemAddCls.setHandler(function() { showEditWin('c', rec); })    // 创建节点
                    menuItemAdd.setHandler(function() { showEditWin('cs', rec); })      // 创建子节点

                    menuItemAddSub.setHandler(function() { showEditSubWin('cs', rec); })      // 创建子节点角色

                    menuItemUpdate.setHandler(function() { showEditWin('u', rec); })    // 更新节点
                    menuItemDelete.setHandler(function() { batchOperate('batchdelete', [rec]); })    // 删除节点

                    contextMenu.showAt(xy);
                }

                function batchOperate(action, recs, params, url) {
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要操作的结点！");
                        return;
                    } else if (!confirm("确定要删除该结点吗？")) {
                        return;
                    }

                    ExtBatchOperate(action, recs, params, url, function(args) {
                        if (args.status == "success") {
                            // 从store中删除已删除的记录

                            var pids = $.map(recs, function(n, i) {
                                var tpid = n.data["ParentID"];
                                store.remove(n);
                                return tpid;
                            });
                        }
                    });
                }


                function showEditSubWin(op, rec) {
                    OpenModelWin("/CommonPages/Select/RolSelect/PRJ_RoleSelect.aspx?seltype=multi", { op: op, id: rec.id },
                        "dialogWidth:650px; dialogHeight:550px; scroll:yes; center:yes; status:no; resizable:yes;seltype:multi",
                        function() {
                            var expnode = null; // 重新加载后需要展开的节点
                            var params = {};
                            var uids = [];
                            uids.push(rec.id);

                            $.each(rtn.data, function() {
                                if (this.RoleID) {
                                    uids.push(this.RoleID);
                                }
                            });

                            params = { "id": rec.id, "IdList": uids };
                            jQuery.ajaxExec("c", params, function(args) {
                                switch (op) {
                                    case 'cs':
                                        store.reload({ id: rec.id });
                                        expnode = rec;
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
                            });


                            // store.singleSort('CreatedDate', 'ASC');
                        });
                }


                function showEditWin(op, rec) {
                    rec = rec || {};
                    OpenModelWin(EditPageUrl, { op: op, id: rec.id }, EditWinStyle, function() {
                        var expnode = null; // 重新加载后需要展开的节点

                        switch (op) {
                            case 'c':
                                if (rec && rec.json.ParentID) {

                                    var pnode = store.getById(rec.json.ParentID);
                                    // store.remove(pnode);
                                    expnode = pnode;

                                    store.reload({ op: "add", id: pnode.id });
                                }
                                break;
                            case 'cs':
                            case 'u':
                                // store.remove(rec);
                                store.reload({ id: rec.id });

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

                        //store.singleSort('CreatedDate', 'ASC');
                    });
                }

                // 提交数据成功后
                function onExecuted() {
                    // store.reload();
                }


                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid, {
                        region: 'center',
                        border: false,
                        bodyStyle: 'background:#f1f1f1',
                        html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" src=""></iframe>'}]
                    });

                    // 展开所有加载的节点
                    var roots = store.getRootNodes();
                    if (roots) {
                        $.each(roots, function() {
                            store.expandNode(this);
                        });
                    }

                    // grid.expandAllNext(1);
                }

                // 应用或模块数据适配
                function adjustData(jdata) {
                    if ($.isArray(jdata)) {
                        $.each(jdata, function() {
                            if (this.PathLevel == 3 && this.ParentID != "6115ee4c-c63d-4dae-b084-736209f434c3")
                                this.IsLeaf = true;
                            else if (this.PathLevel == 4)
                                this.IsLeaf = true;
                            return;
                            if (this.GroupID) {
                                this.ID = this.GroupID;
                                this.ParentID = $.isSetted(this.ParentID) ? this.ParentID : this.Type;
                            } else if (this.GroupTypeID) {
                                this.ID = this.GroupTypeID;
                                this.Type = "GType";
                                this.ParentID = null;
                                //this.IsLeaf = $.isSetted(this.HasGroup) ? !this.HasGroup : false;
                            }
                        });

                        return jdata;
                    } else {
                        return [];
                    }
                }
                
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            组织策划</h1>
    </div>
</asp:Content>
