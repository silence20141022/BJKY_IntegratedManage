<%@ Page Title="规章制度" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="RegulationList.aspx.cs" Inherits="IntegratedManage.Web.RegulationList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .x-tip .x-tip-tc
        {
            background-position-x: 100px !important;
            background-repeat: repeat;
        }

        .aim-icon-fabu
        {
            background-image: url(/images/shared/rss_go.png) !important;
            background-repeat: no-repeat;
        }

        .aim-icon-undo
        {
            background-image: url(/images/shared/undo.png) !important;
            background-repeat: no-repeat;
        }

        .aim-icon-user_red
        {
            background-image: url(/images/shared/user_red.png) !important;
            background-repeat: no-repeat;
        }

        .aim-icon-user
        {
            background-image: url(/images/shared/user.gif) !important;
            background-repeat: no-repeat;
        }
    </style>

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=800,height=650,scrollbars=yes");
        var EditPageUrl = "RegulationEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        var currRec;
        var pid = $.getQueryString({ ID: 'pid' });
        var pname = $.getQueryString({ ID: 'pname' });
        var seltype = $.getQueryString({ ID: 'seltype' });

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据 
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["Rule_RegulationList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'Rule_RegulationList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Code' },
			{ name: 'Name' },
			{ name: 'KeyWord' },
			{ name: 'Summary' },
			{ name: 'DeptId' },
			{ name: 'DeptName' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'LastModifyId' },
			{ name: 'LastModifyName' },
			{ name: 'LastModifyTime' },
			{ name: 'ReleaseState' },
			{ name: 'ReleaseId' },
			{ name: 'ReleaseName' },
			{ name: 'ReleaseTime' },
			{ name: 'State' },
			{ name: 'Flag' },
			{ name: 'WorkFlowState' },
			{ name: 'WorkFlowResult' },
			{ name: 'Ext1' },
			{ name: 'Ext2' },
			{ name: 'Ext3' },
			{ name: 'Ext4' }
                ], listeners: {
                    "aimbeforeload": function (proxy, options) {
                        options.data = options.data || {};

                        options.data.pid = pid;
                        options.data.seltype = seltype;

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
                collapsed: false,
                columns: 5,
                items: [
                { fieldLabel: '主题', id: 'Name', schopts: { qryopts: "{ mode: 'Like', field: 'Name' }" } },
                { fieldLabel: '编号', id: 'Code', schopts: { qryopts: "{ mode: 'Like', field: 'Code' }" } },
                { fieldLabel: '关键字', id: 'KeyWord', schopts: { qryopts: "{ mode: 'Like', field: 'KeyWord' }" } },
                { fieldLabel: '摘要', id: 'Summary', schopts: { qryopts: "{ mode: 'Like', field: 'Summary' }" } },
                {
                    fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '1 10 0 0', text: '查 询', handler: function () {
                        Ext.ux.AimDoSearch(Ext.getCmp("Name"));
                    }
                }
                //Ext.ux.AimDoSearch(Ext.getCmp("DutyName"));
                ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function () {
                        var editpage = EditPageUrl;


                        editpage = editpage + "?pid=" + pid + "&pname=" + pname;


                        ExtOpenGridEditWin(grid, editpage, "c", EditWinStyle);
                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        if (recs[0].get("ReleaseState") == "已发布") {
                            AimDlg.show("所选记录已发布,请撤消后修改！");
                            return;
                        }
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        if (recs[0].get("ReleaseState") == "已发布") {
                            AimDlg.show("所选记录已发布,请撤消后删除！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, '-', {
                    text: '发布',
                    iconCls: 'aim-icon-fabu',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要发布的记录！");
                            return;
                        }
                        if (recs[0].get("ReleaseState") == "已发布") {
                            AimDlg.show("所选记录已发布,请重新选择！");
                            return;
                        }
                        var idList = [];
                        if (recs != null) {
                            jQuery.each(recs, function () {
                                idList.push(this.id);
                            })
                        }
                        //var dt = store.getModifiedDataStringArr(recs);
                        $.ajaxExec('bathrelease', { IdList: idList }, function (rtn) {
                            store.reload();
                            AimDlg.show("发布成功！");
                        });
                    }
                }, {
                    text: '撤销发布',
                    iconCls: 'aim-icon-undo',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要撤销发布的记录！");
                            return;
                        }
                        if (recs[0].get("ReleaseState") == "未发布") {
                            AimDlg.show("所选记录尚未发布,请重新选择！");
                            return;
                        }
                        var idList = [];
                        if (recs != null) {
                            jQuery.each(recs, function () {
                                idList.push(this.id);
                            })
                        }
                        $.ajaxExec('bathunrelease', { IdList: idList }, function (rtn) {
                            store.reload();
                            AimDlg.show("撤销成功！");

                        });
                    }
                }, '-', {
                    text: '复制到',
                    iconCls: 'aim-icon-copy',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要复制的记录！");
                            return;
                        }
                        opencenterwin("RegulationOgzTreeCopy.aspx?type=copy&id=" + recs[0].get("Id"), 'newwin', 600, 600);
                    }
                }, {
                    text: '移动到', iconCls: 'aim-icon-cut',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要移动的记录！");
                            return;
                        }
                        opencenterwin("RegulationOgzTreeCopy.aspx?type=cut&id=" + recs[0].get("Id"), 'newwin', 600, 600);
                    }
                }, '-',
                //{
                //    text: '设置管理权限',
                //    iconCls: 'aim-icon-user_red',
                //    handler: function() {
                //        //OpenWin('')
                //        var recs = grid.getSelectionModel().getSelections();
                //        if (!recs || recs.length <= 0) {
                //            AimDlg.show("请先选择要设置管理权限的记录！");
                //            return;
                //        }
                //        opencenterwin("Rule_Regulation_AdminAuthList.aspx?id=" + recs[0].get("Id"), 'newwin', 600, 600);
                //    }
                //},
                {
                    text: '设置浏览权限',
                    iconCls: 'aim-icon-user',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要设置浏览权限的记录！");
                            return;
                        }
                        opencenterwin("RegulationBrowseAuthSet.aspx?op=u&id=" + recs[0].get("Id"), 'newwin', 600, 400);
                    }
                }]
            });

            // 工具标题栏
            titPanel = new Ext.ux.AimPanel({
                tbar: seltype == "browse" ? "" : tlBar,
                items: [schBar]
            });
            var columns = [{ id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                { id: 'Name', dataIndex: 'Name', header: '主题', width: 120, sortable: true, renderer: RowRender },
                { id: 'Code', dataIndex: 'Code', header: '编号', width: 120, sortable: true },
                { id: 'DeptName', dataIndex: 'DeptName', header: '所属部门', width: 100, sortable: true }
            ];
            if (seltype == "browse") {
                columns.push(
                { id: 'ReleaseName', dataIndex: 'ReleaseName', header: '发布人', width: 40, sortable: true },
                { id: 'ReleaseTime', dataIndex: 'ReleaseTime', header: '发布时间', width: 80, sortable: true }
                );
            }
            else {
                columns.push(
                { id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 40, sortable: true },
                { id: 'CreateTime', dataIndex: 'CreateTime', header: '创建时间', width: 80, sortable: true },
                { id: 'ReleaseState', dataIndex: 'ReleaseState', header: '发布状态', width: 60, sortable: true }
                );
            }
            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                //autoExpandColumn: 'Name',
                viewConfig: { forceFit: true },
                columns: columns,
                bbar: pgBar,
                tbar: titPanel
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });

            Ext.onReady(function () {
                var store = grid.getStore();

                var view = grid.getView();

                grid.tip = new Ext.ToolTip({
                    target: view.mainBody,

                    delegate: '.x-grid3-col-Name',

                    trackMouse: false,
                    autoHide: false,
                    maxWidth: 600,
                    mouseOffset: [-10, -10],
                    //trackMouse: true,
                    autoHeight: true,
                    dismissDelay: 0,

                    renderTo: document.body,

                    listeners: {

                        beforeshow: function (tip) {
                            var x = tip.targetXY[0];
                            var y = tip.targetXY[1];
                            var bodyHeight = document.body.offsetHeight;


                            var rowIndex = view.findRowIndex(tip.triggerElement);
                            var record = store.getAt(rowIndex);

                            tip.body.dom.innerHTML = '<iframe width="100%" height="340px" id="frameContentEdit" name="frameContentEdit" frameborder="0" src="RegulationEdit.aspx?op=r&type=r&id=' + record.get("Id") + '&ptype=tip"></iframe>';
                            //                            if (bodyHeight - y < 340) {
                            //                                if (tip.y && bodyHeight - tip.y < 340) {

                            //                                    tip.showAt([x + 3, bodyHeight - 340 - 40]);
                            //                                } else {
                            //                                    return false;
                            //                                }

                            //                            }
                        }
                    }
                });
            });

        }

        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }

        function SetCatalog(rec) {

            currRec = rec;

            store.reload();
        }
        window.SetCatalog = SetCatalog;

        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;ExamineResultView
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function doViewInfo(id) {
            //alert("scs");
            opencenterwin("RegulationEdit.aspx?id=" + id + "&op=r", 'newwin', 800, 600);
        }
        function RowRender(v, c, r) {
            if (v) {
                return '<label style="color:blue; cursor:pointer; text-decoration:underline;" onclick="doViewInfo(\'' + r.get("Id") + '\')">' + v + '</label>';
            }
        }

    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>标题</h1>
    </div>
</asp:Content>
