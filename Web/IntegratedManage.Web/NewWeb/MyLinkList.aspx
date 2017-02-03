<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    Title="我的链接" CodeBehind="MyLinkList.aspx.cs" Inherits="IntegratedManage.Web.MyLinkList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=575,height=225,scrollbars=yes");
        var EditPageUrl = "WebLinkEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["WebLinkList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'WebLinkList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' }, { name: 'Url' }, { name: 'WebName' },
			{ name: 'IsAdmin' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
			]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 5,
                collapsed: false,
                items: [
                { fieldLabel: '网站名', id: 'WebName', schopts: { qryopts: "{ mode: 'Like', field: 'WebName' }"} },
                { fieldLabel: '地址', id: 'Url', schopts: { qryopts: "{ mode: 'Like', field: 'Url' }"} },
                { fieldLabel: '收录人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} },
                { fieldLabel: '从', id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateTime' }"} },
                { fieldLabel: '至', id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateTime' }"} }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var recType = store.recordType;
                        $.ajaxExec("create", {}, function(rtn) {
                            if (rtn.data.Entity) {
                                var rec = new recType(rtn.data.Entity);
                                store.insert(store.data.length, rec);
                            }
                        })
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
                        var allow = true;
                        var ids = "";
                        $.each(recs, function() {
                            ids += (ids ? "," : "") + this.get("Id");
                        })
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { ids: ids }, function() {
                                store.reload();
                            })
                        }
                    }
                }, '->']
            });
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimEditorGridPanel({
                store: store,
                region: 'center',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'WebName', dataIndex: 'WebName', header: '网站名称', width: 200, sortable: true, editor: { xtype: 'textfield', allowBlank: false} },
					{ id: 'Url', dataIndex: 'Url', header: '地址', width: 450, sortable: true, editor: { xtype: 'textfield', allowBlank: false} },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 80, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建日期', width: 130, sortable: true }
                    ],
                bbar: pgBar,
                tbar: titPanel,
                listeners: { afteredit: function(e) {
                    $.ajaxExec("update", { id: e.record.get("Id"), field: e.field, value: e.value }, function(rtn) {
                        e.record.commit();
                    })
                }
                }
            });
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
            grid.getColumnModel().isCellEditable = function(colIndex, rowIndex) {
                var record = store.getAt(rowIndex);
                if (record.get("IsAdmin") == '1') {
                    return false;
                }
                return Ext.grid.ColumnModel.prototype.isCellEditable.call(this, colIndex, rowIndex);
            }
        }
        function onExecuted() {
            store.reload();
        }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
