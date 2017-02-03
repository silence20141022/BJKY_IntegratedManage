<%@ Page Title="来文单位" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="BringUnitList.aspx.cs" Inherits="IntegratedManage.Web.BringUnitList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

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
			    { name: 'Id' }, { name: 'BringUnitName' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
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
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var recType = store.recordType;
                        var rec = new recType({});
                        store.insert(store.data.length, rec);
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
                        if (confirm("确定删除所选记录？")) {
                            var ids = [];
                            $.each(recs, function() {
                                ids.push(this.get("Id"));
                            })
                            $.ajaxExec("delete", { ids: ids }, function(rtn) {
                                AimDlg.show("删除成功！");
                                store.remove(recs);
                            });
                        }
                    }
                }, '-', {
                    text: '导出<label style=" font-family:@宋体">Excel</label>',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
                }, '->']
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
                { fieldLabel: '来文单位', id: 'BringUnitName', schopts: { qryopts: "{ mode: 'Like', field: 'BringUnitName' }"} },
                { fieldLabel: '创建日期', id: 'StartTime', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                { fieldLabel: '到', id: 'EndTime', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("BringUnitName"));
                }
                }
                ]
            });
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimEditorGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'BringUnitName',
                plugins: [new Ext.ux.grid.GridSummary()],
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'BringUnitName', dataIndex: 'BringUnitName', header: '来文单位', width: 260, editor: { xtype: 'textfield' }, sortable: true },
               		{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 100 },
                	{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建时间', width: 100, renderer: ExtGridDateOnlyRender }
                    ],
                tbar: titPanel,
                bbar: pgBar,
                listeners: { afteredit: function(e) {
                    if (e.value) {
                        $.ajaxExec("Save", { id: e.record.get("Id"), BringUnitName: e.record.get("BringUnitName") }, function(rtn) {
                            e.record.set("Id", rtn.data.Entity.Id);
                            e.record.set("CreateName", rtn.data.Entity.CreateName);
                            e.record.set("CreateTime", rtn.data.Entity.CreateTime);
                            e.record.commit();
                        })
                    }
                }
                }
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
        function showwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("HongTouEdit.aspx?op=v&id=" + val, "", 1200, 650);
            });
        }

        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Title":
                    rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
                    break;
                case "Id":
                    rtn = "";
                    if (record.get("WorkFlowState") == "Flowing" || record.get("WorkFlowState") == "End") {
                        rtn += "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                      value + "\")'>跟踪</label>  ";
                    }
                    break;
                case "SubContractContent":
                    if (value) {
                        cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                        rtn = value;
                    }
                    break;
            }
            return rtn;
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
