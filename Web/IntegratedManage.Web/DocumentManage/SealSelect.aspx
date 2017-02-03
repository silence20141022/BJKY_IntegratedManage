<%@ Page Title="印章选择" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="True" CodeBehind="SealSelect.aspx.cs" Inherits="IntegratedManage.Web.SealSelect" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/pgfunc-ext-sel.js" type="text/javascript"></script>

    <script type="text/javascript">

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, AimSelGrid, viewport;
        function onSelPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
                { name: 'Id' }, { name: 'SealName' }, { name: 'SealType' }, { name: 'SealFileId' }, { name: 'SealFileName' },
			    { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime'}]
            });
            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 4,
                collapsed: false,
                items: [{ fieldLabel: '标题', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} }
                ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: ['->',
                {
                    text: '查  询',
                    iconCls: 'aim-icon-search',
                    handler: function() {
                        if (!schBar.collapsed) {
                            Ext.ux.AimDoSearch(Ext.getCmp("Title"));
                        }
                        else {
                            schBar.toggleCollapse(false);
                            setTimeout("viewport.doLayout()", 50);
                        }
                    }
}]
                });

                // 工具标题栏
                titPanel = new Ext.ux.AimPanel({
                    //    tbar: tlBar,
                    items: [schBar]
                });
                var buttonPanel = new Ext.form.FormPanel({
                    region: 'south',
                    frame: true,
                    buttonAlign: 'center',
                    buttons: [{ text: '确定', handler: function() { AimGridSelect(); } }, { text: '取消', handler: function() {
                        window.close();
                    } }]
                    });
                    // 表格面板
                    Ext.override(Ext.grid.CheckboxSelectionModel, {
                        handleMouseDown: function(g, rowIndex, e) {
                            if (e.button !== 0 || this.isLocked()) {
                                return;
                            }
                            var view = this.grid.getView();
                            if (e.shiftKey && !this.singleSelect && this.last !== false) {
                                var last = this.last;
                                this.selectRange(last, rowIndex, e.ctrlKey);
                                this.last = last; // reset the last     
                                view.focusRow(rowIndex);
                            } else {
                                var isSelected = this.isSelected(rowIndex);
                                if (isSelected) {
                                    this.deselectRow(rowIndex);
                                } else if (!isSelected || this.getCount() > 1) {
                                    this.selectRow(rowIndex, true);
                                    view.focusRow(rowIndex);
                                }
                            }
                        }
                    });
                    AimSelGrid = new Ext.ux.grid.AimGridPanel({
                        title: '印章文件',
                        store: store,
                        region: 'center',
                        autoExpandColumn: 'SealName',
                        sm: seltype == "single" ? new Ext.grid.RowSelectionModel({ singleSelect: true }) : "",
                        columns: [
                        { id: 'Id', dataIndex: 'Id', header: 'Id', hidden: true },
                        new Ext.ux.grid.AimRowNumberer(),
                        new Ext.ux.grid.AimCheckboxSelectionModel(),
                        { id: 'SealName', dataIndex: 'SealName', header: '印章名称', width: 120 },
                        { id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 100 },
                        { id: 'CreateTime', dataIndex: 'CreateTime', header: '创建时间', width: 130}]
                    });
                    // 页面视图
                    viewport = new Ext.ux.AimViewport({
                        items: [AimSelGrid, buttonPanel]
                    });
                } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
