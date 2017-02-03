<%@ Page Title="我的收藏" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="FrmMyFavoriteNews.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.FrmMyFavoriteNews" %>

<asp:Content ID="HeadHolder" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes,resizable=yes");
        var EditPageUrl = "FrmMessageView.aspx";
        var EditPageUrl2 = "ImgNews/FrmImageNews.aspx";
        var EditPageUrl3 = "VideoNews/FrmVdeoNewsView.aspx";
        var StatusEnum = { 0: "未发布", 1: "未发布", 2: "已发布" };

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
			    { name: 'Title' },
			    { name: 'TypeId' },
			    { name: 'PostUserId' },
			    { name: 'PostUserName' },
			    { name: 'PostTime' },
			    { name: 'NewType' },
			    { name: 'SaveType' },
                { name: 'ExpireTime' },
			    { name: 'SaveTime' },
			    { name: 'State' }
			    ], listeners: { "aimbeforeload": function(proxy, options) {
			        options.data = options.data || {};
			        options.data.op = pgOperation || null;
			        options.data.TypeId = typeId;
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
                columns: 5,
                items: [
				{ fieldLabel: '标题', anchor: '90%', id: 'Title', name: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
				{ fieldLabel: '发布人', anchor: '90%', name: 'PostUserName', schopts: { qryopts: "{ mode: 'Like', field: 'PostUserName' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("Title"));
                } }]
                });

                // 工具栏
                var tlBar = new Ext.ux.AimToolbar({
                    items: [{
                        text: '取消收藏',
                        iconCls: 'aim-icon-undo',
                        aimexecutable: true,
                        handler: function() {
                            if (!confirm("确定" + this.text + "?"))
                                return;

                            var smask = new Ext.LoadMask(document.body, { msg: "处理中..." });
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要操作的记录！");
                            }
                            else {
                                smask.show();
                                $.ajaxExec('canelFavorite', { Id: recs[0].data.Id }, function(rtn) {
                                    AimDlg.show("已取消收藏");
                                    onExecuted();
                                    smask.hide();
                                });
                            }
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
					    { id: 'Title', header: '标题', width: 100, renderer: function(val, p, c) {
					        if (c.data.NewType == "ImgNews") {
					            return '<label style="color:Blue; text-decoration:underline; cursor:pointer;" onclick="window.open(\'' + EditPageUrl2 + "?id=" + c.data.Id + '\',\'\',\'' + EditWinStyle + '\')">' + val + '</label>';
					        }
					        else if (c.data.NewType == "VideoNews") {
					            return '<label style="color:Blue; text-decoration:underline; cursor:pointer;" onclick="window.open(\'' + EditPageUrl3 + "?id=" + c.data.Id + '\',\'\',\'' + EditWinStyle + '\')">' + val + '</label>';
					        }
					        else {
					            return '<label style="color:Blue; text-decoration:underline; cursor:pointer;" onclick="window.open(\'' + EditPageUrl + "?id=" + c.data.Id + '\',\'\',\'' + EditWinStyle + '\')">' + val + '</label>';
					        }
					    }, sortable: true, dataIndex: 'Title'
					    },
					    { id: 'PostUserName', header: '发布人', width: 100, sortable: true, dataIndex: 'PostUserName' },
					    { id: 'SaveTime', header: '创建日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'SaveTime' },
					    { id: 'PostTime', header: '发布日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'PostTime' },
					    { id: 'ExpireTime', header: '失效日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'ExpireTime' },
					    { id: 'State', header: '状态', width: 100, enumdata: StatusEnum, sortable: true, dataIndex: 'State' }
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

                // 提交数据成功后
                function onExecuted() {
                    store.reload();
                }
    </script>

</asp:Content>
<asp:Content ID="BodyHolder" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            资讯列表</h1>
    </div>
</asp:Content>
