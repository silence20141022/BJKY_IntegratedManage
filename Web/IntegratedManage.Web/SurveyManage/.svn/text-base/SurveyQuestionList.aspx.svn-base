<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SurveyQuestionList.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveyQuestionList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=845,height=550,scrollbars=1");
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
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			]
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 6,
                collapsed: false,
                items: [
                { fieldLabel: '问卷标题', id: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
                { fieldLabel: '创建人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} },
       { fieldLabel: '起始时间', id: 'StartTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'StartTime' }"} },
                { fieldLabel: '截至时间', id: 'EndTime', format: 'Y-m-d', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndTime' }"} },
                { fieldLabel: '状态', id: 'State', xtype: 'aimcombo', required: true, enumdata: { '0': '已创建', '1': '已启动', '2': '已结束', '%%': '请选择...' }, schopts: { qryopts: "{ mode: 'Like', field: 'State' }" }, listeners: { "collapse": function(e) { Ext.ux.AimDoSearch(Ext.getCmp("State")) } } },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
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
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (recs.length > 0) {
                            if (recs[0].get("State") == "2") {
                                AimDlg.show("已结束的调查问卷无法修改!");
                                return;
                            }
                        }
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (recs[0].get("State") == "1") {
                            AimDlg.show("已启动的问卷不能删除,请结束后再删除!");
                            return;
                        }
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                },
                //                 '-', {
                //                    text: '查看统计权限',
                //                    iconCls: 'aim-icon-user',
                //                    handler: function() {
                //                        var recs = grid.getSelectionModel().getSelections();
                //                        if (!recs || recs.length <= 0) {
                //                            AimDlg.show("请先选择要设置权限的记录！");
                //                            return;
                //                        }
                //                        opencenterwin("ScanPowerEdit.aspx?id=" + recs[0].get("Id"), 'newwin', 600, 600);
                //                    }
                //                }, 

                '-', {
                    text: '启动',
                    iconCls: 'aim-icon-run',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要启动的问卷项！");
                            return;
                        }
                        var isrReturn = false;
                        $.each(recs, function() {
                            if (this.get("State") != "0") {
                                isrReturn = true;
                                AimDlg.show("已创建的调查问卷项才能启动！");
                                return;
                            }
                        });
                        if (isrReturn) return;
                        Ext.getBody().mask("调查问卷启动中");
                        ExtBatchOperate('Start', recs, null, null, function(rtn) {
                            AimDlg.show("启动成功!");
                            store.reload();
                        });
                    }
                }, '-', {
                    text: '结束',
                    iconCls: 'aim-icon-stop',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要结束的问卷调查！");
                            return;
                        }

                        if (recs[0].get("State") != '1') {
                            AimDlg.show("已启动的问卷调查才能结束！");
                            return;
                        }

                        if (confirm("确定要结束本次问卷吗？")) {
                            Ext.getBody().mask("问卷调查结束中。。。。");
                            $.ajaxExec("stop", { Id: recs[0].get("Id") }, function(rtn) {
                                store.reload();
                            });
                        }
                    }
                }, '-', {
                    text: '查看统计结果',
                    iconCls: 'aim-icon-preview2',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要查看的记录！");
                            return;
                        }
                        openStatisticWin(recs[0].get("Id"));
                    }
                }, '-', {
                    text: '查看投票详细',
                    iconCls: 'aim-icon-details',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        //   if (!recs || recs.length <= 0) {
                        //     AimDlg.show("请先选择要查看的记录！");
                        //     return;
                        //   }
                        openDetailsWin();
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
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'Title',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Title', dataIndex: 'Title', header: '问卷标题', width: 140, sortable: true, renderer: RowRender },
					{ id: 'StartTime', dataIndex: 'StartTime', header: '开始时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: 'EndTime', dataIndex: 'EndTime', header: '结束时间', width: 120, sortable: true, renderer: ExtGridDateOnlyRender },
					{ id: "IsNoName", dataIndex: "IsNoName", header: "是否匿名", width: 80, sortable: true, renderer: RowRender },
					{ id: 'State', dataIndex: 'State', header: '状态', width: 100, sortable: true, renderer: RowRender },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 100 },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建时间', width: 120, renderer: ExtGridDateOnlyRender },
					{ id: 'Edit', dataIndex: 'Edit', header: '操作', width: 80, renderer: RowRender }
                    ],
                    bbar: pgBar,
                    // tbar: AimState["Audit"] == 'admin' ? titPanel : ''
                    tbar: titPanel
                    //tbar: titPanel
                });

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
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
                            var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='openConfigWin(\"" + record.get("Id") + "\")'>" + value + "</span>"
                            cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + "标题:" + value + "</br>内容:" + record.get("Contents").substr(0, 30) + "..." + '"';
                            rtn = str;
                        }
                        break;
                    case "State":
                        rtn = value == "0" ? "已创建" : value == "1" ? "已启动" : (value == "2" ? "已结束" : '');
                        break;
                    case "Edit":
                        var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='windowOpen(\"" + record.get("Id") + "\",\"" + record.get("Title") + "\")'>" + "查看预览" + "</span>";
                        rtn = str;
                        break;
                    case "IsNoName":
                        if (value == "no") {
                            rtn = "否";
                        } else {
                            rtn = "是";
                        }
                        break;
                }
                return rtn;
            }


            //查看统计
            function openStatisticWin(surveyId) {
                var task = new Ext.util.DelayedTask();
                task.delay(100, function() {
                    opencenterwin("SurveyStatisticResult.aspx?op=r&Id=" + surveyId, "", 840, 540);
                });
            }

            //查看投票详细
            function openDetailsWin() {
                var task = new Ext.util.DelayedTask();
                task.delay(100, function() {
                    opencenterwin("SurveryStatisticList.aspx?op=r&id=" + id, "", 840, 540);
                });
            }

            function openConfigWin(id) {
                var task = new Ext.util.DelayedTask();
                task.delay(100, function() {
                    opencenterwin("SurveyQuestionEdit.aspx?op=r&id=" + id, "", 840, 540);
                });
            }
            function windowOpen(id, op) {
                var Id = arguments[0] || '';  //ID
                var Title = escape(arguments[1] || ''); //Title
                var task = new Ext.util.DelayedTask();
                task.delay(100, function() {
                    opencenterwin("SurveyView.aspx?op=v&Id=" + Id + "&Title=" + Title, "", 1000, 600);
                });
            }
            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',                      innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=                yes,resizable=yes');
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
