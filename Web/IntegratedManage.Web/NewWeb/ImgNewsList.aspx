<%@ Page Title="院内新闻" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="ImgNewsList.aspx.cs" Inherits="IntegratedManage.Web.ImgNewsList" %>

<asp:Content ID="HeadHolder" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes");
        var EditPageUrl = "FrmMessageView.aspx";
        var Expire = "false";
        var store, grid, viewport;
        function onPgLoad() {
            Index = $.getQueryString({ ID: "Index" });
            setPgUI();
        }
        function setPgUI() {
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
                { name: 'Id' },
			    { name: 'Title' }, { name: 'PostDeptName' }, { name: 'ReadCount' }, { name: 'TypeId' },
			    { name: 'PostUserId' }, { name: 'PostUserName' }, { name: 'PostTime' }, { name: 'TypeName' },
			    { name: 'AuthorName' },
			    { name: 'SaveType' },
                { name: 'ExpireTime' },
			    { name: 'SaveTime' },
			    { name: 'State' }
			    ], listeners: { "aimbeforeload": function(proxy, options) {
			        options.data = options.data || {};
			        options.data.Index = Index;
			    }
			    }
            });
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            var schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
                { fieldLabel: '标题', anchor: '90%', id: 'Title', name: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
				{ fieldLabel: '发布人', anchor: '90%', name: 'PostUserName', schopts: { qryopts: "{ mode: 'Like', field: 'PostUserName' }"} },
				{ fieldLabel: '发布部门', anchor: '90%', name: 'PostDeptName', schopts: { qryopts: "{ mode: 'Like', field: 'PostDeptName' }"} }
                 ]
            });
            var titPanel = new Ext.ux.AimPanel({
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                border: false,
                columns: [
                        { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                        new Ext.ux.grid.AimRowNumberer(),
                        new Ext.ux.grid.AimCheckboxSelectionModel(),
					    { id: 'Title', header: '标题', width: 100, sortable: true, dataIndex: 'Title', renderer: RowRender },
					    { id: 'TypeName', header: '类型', width: 80, sortable: true, dataIndex: 'TypeName' },
					    { id: 'PostUserName', header: '发布人', width: 80, sortable: true, dataIndex: 'PostUserName' },
					    { id: 'PostDeptName', header: '发布部门', width: 120, sortable: true, dataIndex: 'PostDeptName' },
					    { id: 'PostTime', header: '发布日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'PostTime' }
                    ],
                bbar: pgBar,
                tbar: titPanel,
                autoExpandColumn: 'Title'
            });
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
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
        function ViewNews(val, typename) {
            if (typename == "图片新闻") {
                opencenterwin("/Modules/PubNews/ImgNews/FrmImageNews.aspx?id=" + val, "", 1000, 600);
            }
            else {
                opencenterwin("/NewWeb/NoticeView.aspx?id=" + val, "", 1000, 600);
            }
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Title":
                    cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                    rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='ViewNews(\"" +
                                                     record.get('Id') + "\",\"" + record.get('TypeName') + "\")'>" + value + "</label>";
                    break;
            }
            return rtn;
        }       
    </script>

</asp:Content>
<asp:Content ID="BodyHolder" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
