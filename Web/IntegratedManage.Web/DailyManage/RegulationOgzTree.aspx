<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="RegulationOgzTree.aspx.cs" Inherits="IntegratedManage.Web.RegulationOgzTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/ext/ux/FieldLabeler.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <style type="text/css">
        .x-grid3-cell-inner
        {
            padding-left: 0px !important;
        }
    </style>

    <script type="text/javascript">
        var DataRecord, store;
        var viewport, grid;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            var data = AimState["DtList"];

            DataRecord = Ext.data.Record.create([
        { name: 'GroupID', type: 'string' },
        { name: 'ParentID', type: 'string' },
        { name: 'IsLeaf', type: 'bool', mapping: 'IsLeafHK' },
        { name: 'Name' },
        { name: 'Code' },
        { name: 'Type' },
        { name: 'Status' },
        { name: 'Description' },
        { name: 'CreateDate' }
            ]);

            store = new Ext.ux.data.AimAdjacencyListStore({
                data: data,
                aimbeforeload: function (proxy, options) {
                    var rec = store.getById(options.anode);
                    options.reqaction = "querychildren";

                    if (rec) {
                        options.data.id = rec.id;
                    }
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'GroupID', dsname: 'DtList' }, DataRecord)
            });


            // 工具栏
            var tlBar = new Ext.ux.AimToolbar({
                items: [
                {
                    text: '展开',
                    handler: function () {
                        store.expandAll();
                    }
                }]
            });

            // 表格面板
            grid = new Ext.ux.grid.AimEditorTreeGridPanel({
                store: store,
                master_column_id: 'Name',
                region: 'west',
                split: true,
                width: 230,
                viewConfig: { scrollOffset: 2 },
                minSize: 150,
                maxSize: 500,
                autoExpandColumn: 'Name',
                columns: [
                        { id: 'Name', header: "组织结构", renderer: colRender, width: 110, sortable: true, dataIndex: 'Name' },
                        { header: "编号", width: 70, sortable: true, dataIndex: 'Code', hidden: true }]
                //sm: sm,
                //tbar: tlBar
            });
            store.expandAll();
            function colRender(val, p, rec) {
                var rtn = val;
                var type = rec.get('Type');



                return rtn;
            }




            grid.getSelectionModel().on('rowselect', function (sm, rowIdx, r) {
                var rec = grid.store.getAt(rowIdx);
                //                    if (typeof (parent.SetCatalog) == 'function') {
                //                        parent.SetCatalog.call(this, rec);
                //                    }
                document.getElementById("frameContent").src = "RegulationList.aspx?pid=" + rec.get("GroupID") + "&pname=" + rec.get("Name");

            });
            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [grid, {
                    border: false,
                    region: 'center',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" src="RegulationList.aspx?pid=&pname=" frameborder="0"></iframe>'
                }]
            });

        }
        // 应用或模块数据适配
        function adjustData(jdata) {
            if ($.isArray(jdata)) {
                $.each(jdata, function () {
                    if (this.GroupID) {
                        this.ID = this.GroupID;
                        this.ParentID = $.isSetted(this.ParentID) ? this.ParentID : this.Type;
                    } else if (this.GroupTypeID) {
                        this.ID = this.GroupTypeID;
                        this.Type = "GType";
                        this.ParentID = null;
                        this.IsLeaf = $.isSetted(this.HasGroup) ? !this.HasGroup : false;
                    }
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
