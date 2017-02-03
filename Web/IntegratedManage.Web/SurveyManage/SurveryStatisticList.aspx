<%@ Page Title="问卷统计" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SurveryStatisticList.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveryStatisticList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=625,scrollbars=0");
        var EditPageUrl = "SurveyQuestionEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["SurveyQuestionList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'SurveyQuestionList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Title' },
			{ name: 'Contents' },
			{ name: 'StartTime' },
			{ name: 'EndTime' },
			{ name: 'IsNoName' },
			{ name: 'PowerType' },
			{ name: 'ScanPower' },
			{ name: 'StatisticsPower' },
			{ name: 'State' },
			{ name: 'CommitNum' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			]
            });

            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 5,
                collapsed: false,
                items: [
                { fieldLabel: '问卷标题', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },

       { fieldLabel: '开始时间', id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'StartTime' }"} },
                { fieldLabel: '截至时间', id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndTime' }"} },
                { fieldLabel: '状态', id: 'State', xtype: 'aimcombo', required: true, enumdata: { '0': '已创建', '1': '启用中', '2': '已完成' }, schopts: { qryopts: "{ mode: 'Equal', field: 'State' }" }, listeners: { "collapse": function (e) { Ext.ux.AimDoSearch(Ext.getCmp("State")) } } },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function () {
                    Ext.ux.AimDoSearch(Ext.getCmp("Title"));   //Number 为任意
                }
                }
      ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function () {
                        ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function () {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }

                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, '-', {
                    text: '导出Excel',
                    iconCls: 'aim-icon-xls',
                    handler: function () {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
                }]
            });

            // 工具标题栏
            titPanel = new Ext.ux.AimPanel({

                items: [schBar]
            });
            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });



            var colArray = [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Title', dataIndex: 'Title', header: '问卷标题', width: 350, sortable: true, renderer: RowRender },
					{ id: 'StartTime', dataIndex: 'StartTime', header: '开始时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'EndTime', dataIndex: 'EndTime', header: '结束时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: "IsNoName", dataIndex: "IsNoName", header: "是否匿名", width: 80, sortable: true, renderer: RowRender },
					{ id: 'State', dataIndex: 'State', header: '状态', width: 100, sortable: true, renderer: RowRender },
					{ id: 'CommitNum', dataIndex: 'CommitNum', header: '已提交人数', width: 80, sortable: true },
					{ id: 'Edit', dataIndex: 'Edit', header: '操作', width: 130, renderer: RowRender }
                    ];

            var rowArr = [
                        { colspan: 10, align: 'center' },
                        { header: ' fdsfasdfadf ', colspan: 3, align: 'center' }
                ];

            var colModel = new Ext.grid.ColumnModel({
                columns: colArray
            });

            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'Title',
                cm: colModel,
                bbar: pgBar,
                tbar: titPanel
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }

        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }

        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Title":
                    if (value) {
                        cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + "标题:" + value + "</br>内容:" + record.get("Contents").substr(0, 30) + "..." + '"';
                        rtn = value;
                    }
                    break;
                case "State":
                    rtn = value == "0" ? "已创建" : value == "1" ? "已启动" : (value == "2" ? "已结束" : '');
                    break;
                case "Edit":
                    //查看详细
                    var detail = "";
                    //                        if (record.get("IsNoName") == "yes") {
                    //                            detail = " <span style='color:gray;'>" + "查看详细" + "</span>";
                    //                        } else {
                    if (AimState["detailAudit"] == "true") {
                        detail = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='openDetailWin(\"" + record.get("Id") + "\")'>" + "查看详细" + "</span>";
                    } else {
                        detail = " <span style='color:gray;'>" + "查看详细" + "</span>";
                    }
                    // }

                    //统计结果
                    var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='windowOpen(\"" + record.get("Id") + "\",\"" + record.get("Title") + "\")'>" + "统计结果" + "</span>";
                    rtn = str + " " + detail;
                    break;
                case "IsNoName":
                    rtn = value == "no" ? "否" : "是"
                    break;
            }
            return rtn;
        }


        function openDetailWin() {
            var Id = arguments[0] || '';  //ID
            var Title = escape(arguments[1] || ''); //Title
            var task = new Ext.util.DelayedTask();
            task.delay(100, function () {
                opencenterwin("DetailViewList.aspx?op=v&Id=" + Id, "", 1000, 600);
            });
        }
        function windowOpen() {
            var Id = arguments[0] || '';  //ID
            var Title = escape(arguments[1] || ''); //Title
            var task = new Ext.util.DelayedTask();
            task.delay(100, function () {
                opencenterwin("SurveyStatisticResult.aspx?op=v&Id=" + Id + "&Title=" + Title, "", 1000, 600);
            });
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',                      innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=                yes,resizable=yes');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
