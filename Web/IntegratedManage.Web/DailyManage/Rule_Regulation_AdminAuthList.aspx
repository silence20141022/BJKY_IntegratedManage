<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="Rule_Regulation_AdminAuthList.aspx.cs" Inherits="IntegratedManage.Web.Rule_Regulation_AdminAuthList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=600,scrollbars=yes");
        var EditPageUrl = "Rule_Regulation_AdminAuthEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        var id = $.getQueryString({ ID: 'id' });
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["Rule_Regulation_AdminAuthList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'Rule_Regulation_AdminAuthList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Rule_Regulation' },
			{ name: 'UserId' },
			{ name: 'UserName' }
			],
                listeners: { "aimbeforeload": function(proxy, options) {
                    options.data = options.data || {};
                    options.data.id = id;
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
                columns: 3,
                collapsed: false,
                items: [
                { fieldLabel: '姓名', id: 'UserName', schopts: { qryopts: "{ mode: 'Like', field: 'UserName' }"} },
                                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '1 30 0 0', text: '查 询', handler: function() { Ext.ux.AimDoSearch(Ext.getCmp("UserName")); } }
                ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        //ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                        UserSelect();

                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }

                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
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
                    title: '设置管理权限',
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'UserName',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 100, sortable: true }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });


                var buttonPanel = new Ext.form.FormPanel({
                    region: 'south',
                    frame: true,
                    buttonAlign: 'center',
                    buttons: [
                    { text: '提交', hidden: pgOperation == "r", handler: function() {
                        var recs = store.getRange();
                        var dt = store.getModifiedDataStringArr(recs) || [];
                        $.ajaxExec("submituser", { id: id, data: dt }, function(rtn) {
                            Ext.MessageBox.show({
                                title: '确认',
                                msg: '提交成功！',
                                buttons: Ext.MessageBox.OK,
                                buttonText: { ok: '确认' },
                                minWidth: 100,
                                fn: function(btn, text) {
                                    if (btn == 'ok') {
                                        //RefreshClose();
                                        window.close();
                                    }
                                }
                            });
                        });
                    }
                    },
                     { text: '关闭', handler: function() {
                         window.close();
                     } }]
                });

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid, buttonPanel]
                });
            }

            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }

            function UserSelect() {
                var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
                var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
                OpenModelWin(url, {}, style, function() {
                    if (this.data == null || this.data.length == 0 || !this.data.length) return;
                    //var gird = Ext.getCmp(val);
                    var EntRecord = store.recordType;
                    for (var i = 0; i < this.data.length; i++) {
                        if (store.find("UserId", this.data[i].Id) != -1) continue; //筛选已经存在的人
                        var rec = new EntRecord({ UserId: this.data[i].UserID, UserName: this.data[i].Name });
                        store.insert(store.data.length, rec);
                    }
                })

            }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
