<%@ Page Title="信息列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="FrmImgNewsList.aspx.cs" Inherits="Aim.Portal.Web.FrmImgNewsList" %>

<asp:Content ID="HeadHolder" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes");
        var EditPageUrl = "FrmImageNews.aspx";
        var StatusEnum = { 0: "未发布", 1: "未发布", 2: "已发布" };

        var Expire = "false";
        var viewport, grid;
        var store;
        var typeId, op;

        function onPgLoad() {
            typeId = $.getQueryString({ "ID": "TypeId" });

            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
                { name: 'Id' },
                { name: 'ShowImg' },
                { name: 'Title' },
                { name: 'ReceiveDeptId' }, { name: 'PostDeptName' }, { name: 'Ext1' },
                { name: 'ReceiveDeptName' },
                { name: 'PostUserId' },
                { name: 'PostUserName' },
                { name: 'PostTime' },
                { name: 'ExpireTime' },
                { name: 'Remark' },
                { name: 'TypeId' },
                { name: 'Content' },
                { name: 'State' },
                { name: 'Ext2' },
                { name: 'Ext3' },
                { name: 'Ext4' },
                { name: 'Ext5' },
                { name: 'CreateId' },
                { name: 'CreateName' },
                { name: 'CreateTime'}], listeners: { "aimbeforeload": function(proxy, options) {
                    options.data = options.data || {};
                    options.data.op = pgOperation || null;
                    options.data.TypeId = typeId;
                    options.data.Expire = Expire;
                }
                }
            });

            // 分页栏
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            var schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
				{ fieldLabel: '标题', anchor: '90%', id: 'Title', name: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
				{ fieldLabel: '发布人', anchor: '90%', name: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} },
                { fieldLabel: '发布部门', anchor: '90%', name: 'PostDeptName', schopts: { qryopts: "{ mode: 'Like', field: 'PostDeptName' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("Title"));
                } }]
                });

                // 工具栏
                var tlBar = new Ext.ux.AimToolbar({
                    items: [{
                        text: '添加',
                        iconCls: 'aim-icon-add',
                        handler: function() {
                            openEditWin("FrmImgNewsEdit.aspx?TypeId=" + typeId, "c");
                        }
                    }, {
                        text: '修改',
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要修改的记录！");
                                return;
                            }
                            if (recs[0].data.State == "2") {
                                AimDlg.show("已发布的消息不能修改！");
                                return;
                            }
                            openEditWin("FrmImgNewsEdit.aspx", "u");
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

                            if (recs[0].data.State == "2") {
                                AimDlg.show("已发布的消息不能删除！");
                                return;
                            }

                            if (confirm("确定删除所选记录？")) {
                                batchOperate('batchdelete', recs);
                            }
                        }
                    }, '-', {
                        text: '发布信息',
                        aimexecutable: true,
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            SubmitNews(this);
                        }
                    }, {
                        text: '撤销发布',
                        iconCls: 'aim-icon-undo',
                        aimexecutable: true,
                        handler: function() {
                            ReSubmitNews(this);
                        }
                    }, {
                        text: '不同意发布',
                        aimexecutable: true,
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            BackNews(this);
                        }
                    }, '-', {
                        text: '已过期',
                        iconCls: 'aim-icon-search',
                        aimexecutable: true,
                        handler: function() {
                            if (Expire == "false") {
                                Expire = "true";
                                this.addClass("x-btn-click");
                            }
                            else {
                                Expire = "false";
                                this.removeClass("x-btn-click");
                            }
                            store.reload();
                        }
}]
                    });

                    // 工具标题栏
                    var titPanel = new Ext.ux.AimPanel({
                        tbar: tlBar,
                        items: [schBar]
                    });

                    // 表格面板
                    grid = new Ext.ux.grid.AimGridPanel({
                        store: store,
                        region: 'center',
                        border: false,
                        columns: [
                        { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                        new Ext.ux.grid.AimRowNumberer(),
                        new Ext.ux.grid.AimCheckboxSelectionModel(),
					    { id: 'TypeId', header: '类别', width: 100, sortable: false, enumdata: AimState["EnumType"], dataIndex: 'TypeId' },
					    { id: 'Title', header: '标题', width: 100, linkparams: { url: EditPageUrl, style: EditWinStyle }, sortable: true, dataIndex: 'Title' },
					    { id: 'CreateName', header: '发布人', width: 80, sortable: true, dataIndex: 'CreateName' },
					    { id: 'PostDeptName', header: '发布部门', width: 120, sortable: true, dataIndex: 'PostDeptName' },
					    { id: 'CreateTime', header: '创建日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'CreateTime' },
					    { id: 'PostTime', header: '发布日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'PostTime' },
					    { id: 'ExpireTime', header: '失效日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'ExpireTime' },
					    { id: 'Ext1', header: '阅读次数', width: 80, sortable: true, dataIndex: 'Ext1' },
					    { id: 'State', header: '状态', width: 80, enumdata: StatusEnum, sortable: true, dataIndex: 'State' }
                    ],
                        bbar: pgBar,
                        tbar: titPanel,
                        autoExpandColumn: 'Title'
                    });

                    // 页面视图
                    viewport = new Ext.ux.AimViewport({
                        layout: 'border',
                        items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
                    });
                }

                // 打开模态窗口
                function openEditWin(url, op, style) {
                    ExtOpenGridEditWin(grid, url, op, style || EditWinStyle);
                }

                function batchOperate(action, recs, params, url) {
                    ExtBatchOperate(action, recs, params, url, onExecuted)
                }

                // 提交数据成功后
                function onExecuted() {
                    store.reload();
                }
                function reloadPage(args) {
                    // 重新加载页面
                    typeId = args ? args.cid : typeId;
                    store.reload();
                }

                function ReSubmitNews(obj) {
                    SubmitState(1, obj);
                }

                function BackNews(obj) {
                    SubmitState(0, obj);
                }
                function SubmitNews(obj) {
                    SubmitState(2, obj);
                }
                function SubmitState(val, obj) {
                    if (!confirm("确定" + obj.text + "?"))
                        return;

                    var smask = new Ext.LoadMask(document.body, { msg: "处理中..." });
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要" + obj.text + "的记录！");
                    }
                    else {
                        if (val == recs[0].data.State) {
                            alert("该信息不需要" + obj.text);
                            return;
                        }
                        smask.show();
                        $.ajaxExec('submitnews', { Id: recs[0].data.Id, state: val }, function(args) {
                            AimDlg.show(args.data.message);
                            onExecuted();
                            smask.hide();
                        });
                    }
                }
    </script>

</asp:Content>
<asp:Content ID="BodyHolder" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            资讯列表</h1>
    </div>
</asp:Content>
