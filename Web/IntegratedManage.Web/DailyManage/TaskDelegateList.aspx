<%@ Page Title="任务委托" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="TaskDelegateList.aspx.cs" Inherits="IntegratedManage.Web.TaskDelegateList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
            background-color: #F2F2F2;
        }
        fieldset
        {
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        .righttxt
        {
            text-align: right;
        }
        input
        {
            width: 90%;
        }
        select
        {
            width: 90%;
        }
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }
        .x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
    </style>
    <style type="text/css">
        .x-view-selected
        {
            -moz-background-clip: border;
            -moz-background-inline-policy: continuous;
            -moz-background-origin: padding;
            background-color: #FFC0CB;
        }
        .thumb
        {
            background-color: #dddddd;
            padding: 4px;
            text-align: center;
            height: 40px;
        }
        .thumb-activated
        {
            background-color: yellow;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-activateded
        {
            background-color: blue;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-separater
        {
            float: left;
            width: 120px;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: center;
            border: 1px solid gray;
        }
        .thumb-wrap-out
        {
            float: left;
            width: 80px;
            margin-right: 0;
            padding: 0px; /*width: 160;background-color:#8DB2E3;*/
        }
        .thumb-wrap
        {
            font-size: 12px;
            font-weight: bold;
            padding: 2px;
        }
        .remark
        {
            font-size: 12px;
            padding: 2px;
        }
        .tblusing
        {
            background-color: #FF8247;
        }
        .tblunusing
        {
            background-color: Gray;
        }
    </style>

    <script type="text/javascript">
        var myData, store, pgBar, schBar, tlBar, titPanel, grid;
        var EnumData = { 1: '启动', 0: '关闭' };
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = { total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            }
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [{ name: 'Id' }, { name: 'DelegateUserId' }, { name: 'DelegateUserName' }, { name: 'CreateId' }, { name: 'CreateName' },
                 { name: 'CreateTime' }, { name: 'StartTime' }, { name: 'Remark' }, { name: 'State'}]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
                    { fieldLabel: '委托人', id: 'DelegateUserName', schopts: { qryopts: "{ mode: 'Like', field: 'DelegateUserName' }"} },
                // { fieldLabel: '开始时间', id: 'StartTime', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                //{ fieldLabel: '结束时间', id: 'EndTime', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} },
                    {fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                        Ext.ux.AimDoSearch(Ext.getCmp("DelegateUserName"));
                    }
                }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        var allowcreate = true;
                        if (recs || recs.length > 0) {
                            $.each(recs, function() {
                                if (this.get("State") == "1")
                                    allowcreate = false;
                                return false;
                            })
                        }
                        if (!allowcreate) {
                            AimDlg.show("请先关闭启动的委托！");
                            return;
                        }
                        opencenterwin("TaskDelegateEdit.aspx?op=c", "", 600, 300);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        opencenterwin("TaskDelegateEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 600, 300);
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的委托！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { id: recs[0].get("Id") }, function(rtn) {
                                AimDlg.show("删除成功！"); store.reload();
                            });
                        }
                    }
                }, '-', {
                    text: '导出<label style=" font-family:@宋体">Excel</label>',
                    iconCls: 'aim-icon-xls',
                    handler: function() {
                        ExtGridExportExcel(grid, { store: null, title: '标题' });
                    }
                }, '-', {
                    text: '关闭委托', iconCls: 'aim-icon-stop',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要关闭的委托！");
                            return;
                        }
                        $.ajaxExec("StopDelegate", { id: recs[0].get("Id") }, function() {
                            store.reload();
                        })
                    }
                }, '-', { text: '启动委托', iconCls: 'aim-icon-run', handler: function() {
                    var recs = grid.getSelectionModel().getSelections();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要启动的委托！");
                        return;
                    }
                    $.ajaxExec("StartDelegate", { id: recs[0].get("Id") }, function() {
                        store.reload();
                    })
                }
                }, '->']
            });
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'Remark',
                // plugins: [new Ext.ux.grid.GridSummary()],
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'CreateName', dataIndex: 'CreateName', header: '原执行人', width: 100 },
					{ id: 'DelegateUserName', dataIndex: 'DelegateUserName', header: '委托人', width: 100 },
					{ id: 'StartTime', dataIndex: 'StartTime', header: '开始时间', width: 130 },
					{ id: 'Remark', dataIndex: 'Remark', header: '委托原因', width: 120, renderer: RowRender },
					{ id: 'State', dataIndex: 'State', header: '委托状态', width: 100, enumdata: EnumData }
                    ],
                tbar: titPanel,
                bbar: pgBar

            });
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }
        function SubFinish(args) {
            RefreshClose();
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function OpenModule(val) {
            opencenterwin(val.lang, "newwin0", 1100, 650);
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Name":
                    rtn = '<a href="../../CommonPages/File/DownLoad.aspx?id=' + record.get('Id') + '">' + value + '</a>';
                    break;
                case "Id":
                    rtn = "";
                    if (record.get("WorkFlowState") == "Flowing" || record.get("WorkFlowState") == "End") {
                        rtn += "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                      value + "\")'>跟踪</label>  ";
                    }
                    break;
                case "Remark":
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
