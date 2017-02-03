<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="RegulationOgzTreeBrowse.aspx.cs" Inherits="IntegratedManage.Web.RegulationOgzTreeBrowse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGridLevels.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/ext/ux/FieldLabeler.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <style type="text/css">
        .icon
        {
            display: none !important;
        }
    </style>

    <script type="text/javascript">
        var DataRecord, store;
        var viewport, grid;
        var treeLoader, rootNode, sel;
        function onPgLoad() {
            setPgUI();
            tree.expandAll();
        }

        function setPgUI() {
            treeLoader = new Ext.tree.TreeLoader({
                baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI }
            });


            // 表格面板
            tree = new Ext.tree.TreePanel({
                title: "公司部门",
                id: 'tree',
                region: 'west',
                expanded: true,
                border: true,
                animate: false,
                //tbar: tlBar,
                width: 230,
                split: true,
                height: 250,
                autoScroll: true,
                containerScroll: true,
                lines: true, //节点之间连接的横竖线
                rootVisible: false, //是否显示根节点
                loader: treeLoader

                //checkModel: 'cascade',

            });


            tree.on('beforeload', function (node) {
                Ext.getBody().mask("数据加载中,请稍候…");
                tree.loader.dataUrl = 'RegulationOgzTreeBrowse.aspx?asyncreq=true&reqaction=querychildren&id=' + node.attributes.id;
            });
            tree.on('load', function (node) {
                Ext.getBody().unmask();
            });


            rootNode = new Ext.tree.AsyncTreeNode({
                draggable: false,
                id: 'root',
                iconCls: 'icon',
                expanded: true,
                children: adjustData(AimState["DtList"])
            });

            tree.setRootNode(rootNode);

            tree.on('click', function (node, e) {
                sel = node;

                document.getElementById("frameContent").src = "RegulationList.aspx?pid=" + sel.id + "&seltype=browse";
            });

            //            var data = AimState["DtList"];

            //            DataRecord = Ext.data.Record.create([
            //        { name: 'GroupID', type: 'string' },
            //        { name: 'ParentID', type: 'string' },
            //        { name: 'IsLeaf', type: 'bool', mapping: 'IsLeafHK' },
            //        { name: 'Name' },
            //        { name: 'Code' },
            //        { name: 'Type' },
            //        { name: 'Status' },
            //        { name: 'Description' },
            //        { name: 'CreateDate' }
            //        ]);

            //            store = new Ext.ux.data.AimAdjacencyListStore({
            //                data: data,
            //                aimbeforeload: function(proxy, options) {
            //                    var rec = store.getById(options.anode);
            //                    options.reqaction = "querychildren";

            //                    if (rec) {
            //                        options.data.id = rec.id;
            //                    }
            //                },
            //                reader: new Ext.ux.data.AimJsonReader({ id: 'GroupID', dsname: 'DtList' }, DataRecord)
            //            });


            //            // 工具栏
            //            var tlBar = new Ext.ux.AimToolbar({
            //                items: [
            //                { text: '展开',
            //                    handler: function() {
            //                        store.expandAll();
            //                    }
            //}]
            //                });

            //                // 表格面板
            //                grid = new Ext.ux.grid.AimEditorTreeGridPanel({
            //                    store: store,
            //                    master_column_id: 'Name',
            //                    region: 'west',
            //                    split: true,
            //                    width: 300,
            //                    viewConfig: { scrollOffset: 2 },
            //                    minSize: 250,
            //                    maxSize: 500,
            //                    autoExpandColumn: 'Name',
            //                    columns: [
            //				            { id: 'Name', header: "组织结构", renderer: colRender, width: 110, sortable: true, dataIndex: 'Name' },
            //				            { header: "编号", width: 70, sortable: true, dataIndex: 'Code', hidden: true}]
            //                    //sm: sm,
            //                    //tbar: tlBar
            //                });

            //                function colRender(val, p, rec) {
            //                    var rtn = val;
            //                    var type = rec.get('Type');

            //                    switch (type) {
            //                        case 3:
            //                            rtn = '<span valign="bottom"><img src="/images/shared/user_red.png">' + val + '</span>';
            //                            break;
            //                        case 2:
            //                            rtn = '<span valign="bottom"><img src="/images/shared/preview2.png">' + val + '</span>';
            //                            break;
            //                    }

            //                    return rtn;
            //                }




            //                grid.getSelectionModel().on('rowselect', function(sm, rowIdx, r) {
            //                    var rec = grid.store.getAt(rowIdx);
            //                    //                    if (typeof (parent.SetCatalog) == 'function') {
            //                    //                        parent.SetCatalog.call(this, rec);
            //                    //                    }
            //                    document.getElementById("frameContent").src = "RegulationList.aspx?pid=" + rec.get("GroupID") + "&pname=" + rec.get("Name");

            //                });
            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [tree, {
                    border: false,
                    region: 'center',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" src="RegulationList.aspx?pid=&seltype=browse" frameborder="0"></iframe>'
                }]
            });

        }


        // 应用或模块数据适配
        function adjustData(jdata) {
            if ($.isArray(jdata)) {
                $.each(jdata, function () {
                    this.id = this.GroupID;
                    this.text = this.Name;
                    this.leaf = false;
                    this.iconCls = "icon";
                    //this.uiProvider = 'col';
                });

                return jdata;
            } else {
                return [];
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
