<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="WorkLog.aspx.cs" Inherits="Aim.AM.Web.Aim.Execute.WorkLog" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=600,scrollbars=yes");
        var EditPageUrl = "/Aim/WorkTimeFactEdit.aspx";
        var TaskId = $.getQueryString({ "ID": "TaskId" });
        var passcode = $.getQueryString({ "ID": "PassCode", "DefaultValue": "" });
        var allowEdit = 3;

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        var curDate;

        function onPgLoad() {
            /*if (!$.getQueryString({ ID: "EditDate" })) {
            curDate = $.getQueryString({ ID: "EditDate", DefaultValue: "<%=DateTime.Now.ToShortDateString() %>" }).replace(/\//gi, '-');
            window.location.href = window.location.href + "?EditDate=" + curDate;
            }
            else*/
            curDate = $.getQueryString({ ID: "EditDate" });
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["WorkTimeFactList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'WorkTimeFactList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'CurrentDate' },
			{ name: 'PrjId' },
			{ name: 'PrjCode' },
			{ name: 'PrjName' },
			{ name: 'MajorId' },
			{ name: 'MajorName' },
			{ name: 'MajorDeptId' },
			{ name: 'MajorDeptName' },
			{ name: 'UserId' },
			{ name: 'UserName' },
			{ name: 'UserDeptId' },
			{ name: 'UserDeptName' },
			{ name: 'NormalHour' },
			{ name: 'ExtralHour' },
			{ name: 'Total' },
			{ name: 'IsOutgo' },
			{ name: 'IsManage' },
			{ name: 'WorkType' },
			{ name: 'TaskId' },
			{ name: 'TaskCode' },
			{ name: 'TaskName' },
			{ name: 'TaskProgress' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateDate', type: 'date' },
			{ name: 'Remark' }
			], listeners: { "aimbeforeload": function(proxy, options) {
			    options.data = options.data || {};
			    options.data.op = pgOperation || null;
			    options.data.TaskId = TaskId;
			    options.data.EditDate = curDate;
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
                padding: '0 0 0 0',
                collapsed: true,
                columns: 4,
                items: [
                { fieldLabel: '任务名称', id: 'TaskName', schopts: { qryopts: "{ mode: 'Like', field: 'TaskName' }"} },
                { fieldLabel: '工作内容', id: 'Remark', schopts: { qryopts: "{ mode: 'Like', field: 'Remark' }"} },
                 { fieldLabel: '日志时间', id: 'CreateTimeStart', xtype: 'datefield', vtype: 'daterange', endDateField: 'CreateTimeEnd', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'CreateDate' }"} },
                { fieldLabel: '至', id: 'CreateTimeEnd', xtype: 'datefield', vtype: 'daterange', startDateField: 'CreateTimeStart', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'CreateDate' }"}}]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加', id: 'btnAdd',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var EntRecord = grid.getStore().recordType;
                        var p = new EntRecord({ "Month": 1, "CurrentDate": curDate.replace(/-/g, "/"), "CreateDate": new Date(), "Total": 0 });
                        grid.stopEditing();
                        var insRowIdx = store.data.length;
                        store.insert(insRowIdx, p);
                        grid.startEditing(insRowIdx, 3);
                        //ExtOpenGridEditWin(grid, EditPageUrl + "?EditDate=" + curDate, "c", EditWinStyle);
                    }
                }, {
                    text: '删除', id: 'btnDelete',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            for (var i = 0; i < recs.length; i++) {
                                if (recs[i] && (recs[i].get("Id") == null || recs[i].get("Id") == "")) {
                                    store.remove(recs[i]);
                                    store.commitChanges();
                                }
                            }
                            if (grid.getSelectionModel().getSelections().length > 0)
                                ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }, {
                    text: '保存',
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        // 保存修改的数据
                        var recs = store.getModifiedRecords();
                        if (recs && recs.length > 0) {
                            var dt = store.getModifiedDataStringArr(recs) || [];

                            jQuery.ajaxExec('batchsave', { "data": dt }, function() {
                                store.reload();
                                AimDlg.show("保存成功！");
                            });
                        }
                    }
                }, '-', {
                    text: '前一天',
                    iconCls: 'aim-icon-arrow-left1',
                    handler: function() {
                        var m = store.modified.slice(0);
                        if (m.length > 0) {
                            if (confirm("存在未保存的数据，请先保存数据,确定继续将丢失数据？")) {
                                ChangeDate(true);
                                store.reload();
                            }
                        }
                        else {
                            ChangeDate(true);
                            store.reload();
                        }
                        store.commitChanges();
                    }
                }, {
                    text: '后一天',
                    iconCls: 'aim-icon-arrow-right1',
                    handler: function() {
                        var m = store.modified.slice(0);
                        if (m.length > 0) {
                            if (confirm("存在未保存的数据，请先保存数据,确定继续将丢失数据？")) {
                                ChangeDate(false);
                                store.reload();
                                //store.reload({ params: { "id": id, "EditDate": curDate} });
                            }
                        }
                        else {
                            ChangeDate(false);
                            store.reload();
                        }
                        store.commitChanges();
                    }
                }, {
                    text: '转到日历',
                    iconCls: 'aim-icon-calendar',
                    handler: function() {
                        var m = store.modified.slice(0);
                        if (m.length > 0) {
                            if (confirm("存在未保存的数据，确定继续？")) {
                                window.location.href = "/WorkTime/MonthView.aspx";
                            }
                        }
                        else
                            window.location.href = "/WorkTime/MonthView.aspx";
                    }
                }, '-', {
                    text: '导出Excel',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '工作日志' });
                    }
                },
                '->',
                {
                    text: '查询[输入条件后按回车查询]', hidden: true,
                    iconCls: 'aim-icon-search',
                    handler: function() {
                        schBar.toggleCollapse(false);

                        setTimeout("viewport.doLayout()", 50);
                    }
}]
                });

                // 工具标题栏
                titPanel = new Ext.ux.AimPanel({
                    tbar: tlBar,
                    items: [schBar]
                });
                var title = "日志填报" + curDate == null ? '' : '日志填报  [填报日期<span id=spanDate>:' + curDate + '</span>]';
                // 表格面板
                grid = new Ext.ux.grid.AimEditorGridPanel({
                    store: store,
                    clicksToEdit: 1,
                    title: title,
                    region: 'center',
                    autoExpandColumn: 'Remark',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'TaskCode', dataIndex: 'TaskCode', header: '任务编号', width: 100, sortable: true, editor:
					{ xtype: 'aimpopup', popUrl: "/Aim/Task/TaskSel.aspx",
					    popStyle: "dialogWidth:700px;dialogHeight:500px", popAfter: SelAfter,editable:true
					}
					},
					{ id: 'TaskName', dataIndex: 'TaskName', header: '目标任务名称', width: 250, editor: { xtype: 'textfield' }, sortable: true, renderer: linkRender },
					{ id: 'Total', dataIndex: 'Total', header: '工时(小时)', width: 70, editor: { xtype: 'numberfield' }, sortable: true, align: 'right' },
					{ id: 'Remark', dataIndex: 'Remark', header: '工作内容', editor: { xtype: 'textarea' }, width: 120, sortable: true, renderer: linkRender },
					{ id: 'PrjName', dataIndex: 'PrjName', header: '标准化成果', width: 120, sortable: true, renderer: ExtGridFileRender
					},
					{ id: 'Up', dataIndex: 'Up', header: '<img src="/images/shared/zip.png"/>', editor:
					{ xtype: 'aimpopup', popUrl: "/CommonPages/File/Upload.aspx?IsSingle=false",
					    popStyle: "dialogWidth:460px;dialogHeight:400px", popAfter: FileAfter
					}, width: 25, sortable: false, renderer: linkRender
					},
					{ id: 'CurrentDate', dataIndex: 'CurrentDate', header: '填报日期', width: 70, editor: { xtype: 'datefield' }, renderer: ExtGridDateOnlyRender, sortable: true },
					{ id: 'CreateDate', dataIndex: 'CreateDate', header: '创建日期', width: 70, editor: { xtype: 'datefield' }, renderer: ExtGridDateOnlyRender, sortable: true }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
                });
            }

            function linkRender(val, p, rec, rowIndex, columnIndex, store) {
                switch (this.id) {
                    case "Up":
                        return '<img src="/images/shared/zip.png" style="cursor:hand;"/>';
                        break;
                    case "Remark":
                    case "TaskName":
                        val = val == null ? "" : val;
                        p.attr = 'ext:qtitle =""' + ' ext:qtip ="' + val + '"';
                        return val;
                        break;
                }
            }

            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }
            function FileAfter(rtn) {
                if (rtn && grid.activeEditor.row != null) {
                    var rec = store.getAt(grid.activeEditor.row);
                    if (rec) {
                        rec.set("PrjName", rtn);
                    }
                }
                grid.stopEditing(false);
            }
            function SelAfter(rtn) {
                if (rtn && rtn.data && grid.activeEditor.row != null) {
                    var rec = store.getAt(grid.activeEditor.row);
                    if (rec) {
                        rec.set("TaskId", rtn.data.Id);
                        rec.set("TaskCode", rtn.data.Code);
                        rec.set("TaskName", rtn.data.TaskName);
                        grid.stopEditing(false);
                    }
                }
            }

            function ChangeDate(pre) {
                var datt = new Date();
                var stt = datt.format('Y-m-d');
                if (pre) {
                    var arys = curDate.split('-');
                    var d2 = new Date(arys[0], arys[1] - 1, arys[2] - 1);
                    curDate = d2.getFullYear() + "-" + (d2.getMonth() + 1) + "-" + d2.getDate();
                }
                else {
                    var arys = curDate.split('-');
                    var d2 = new Date(parseInt(arys[0]), parseInt(arys[1] - 1), parseInt(arys[2]));
                    d2.setDate(d2.getDate() + 1);
                    curDate = d2.getFullYear() + "-" + (d2.getMonth() + 1) + "-" + d2.getDate();
                }
                spanDate.innerText = curDate;
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            标题</h1>
    </div>
</asp:Content>
