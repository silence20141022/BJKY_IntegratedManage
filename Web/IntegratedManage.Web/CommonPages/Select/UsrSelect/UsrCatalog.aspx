<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="UsrCatalog_wgm.aspx.cs" Inherits="Aim.Portal.Web.CommonPages.UsrCatalog" %>

<%@ OutputCache Duration="1" VaryByParam="None" %>
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

            var data = AimState["DtList"];

            DataRecord = Ext.data.Record.create([
                    { name: 'GroupID', type: 'string' },
                    { name: 'ParentID', type: 'string' },
                    { name: 'IsLeaf', type: 'bool' },
                    { name: 'Name' },
                    { name: 'Code' },
                    { name: 'Type' },
                    { name: 'Status' },
                    { name: 'Description' },
                    { name: 'SortIndex' },
                    { name: 'CreateDate'}]);

            store = new Ext.ux.data.AimAdjacencyListStore({
                data: data,
                aimbeforeload: function(proxy, options) {
                    var rec = store.getById(options.anode);
                    options.reqaction = "querychildren";
                    if (rec) {
                        options.data.id = rec.id;
                    }
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'GroupID', dsname: 'DtList' }, DataRecord)
            });

            // 表格面板
            grid = new Ext.ux.grid.AimEditorTreeGridPanel({
                store: store,
                master_column_id: 'Name',
                region: 'center',
                split: true,
                width: 350,
                minSize: 250,
                maxSize: 500,
                autoExpandColumn: 'Name',
                columns: [
				{ id: 'Name', header: "组织结构", width: 110, sortable: true, dataIndex: 'Name'}]
            });

            grid.getSelectionModel().on('rowselect', function(sm, rowIdx, r) {
                if (parent.SetCatalog) {
                    parent.SetCatalog("group", { id: r.id, type: r.data.Type });
                }
            });

            // 展开所有加载的节点
            setTimeout(function() {
                var roots = store.getRootNodes();
                if (roots) {
                    $.each(roots, function() {
                        store.expandNode(this);
                    });
                }
            }, 500);
            //grid.expandAllNext(1);

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
            });

        }

    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            组列表</h1>
    </div>
</asp:Content>
