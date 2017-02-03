<%@ Page Title="分发信息" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="GiveOutInfo.aspx.cs" Inherits="IntegratedManage.Web.GiveOutInfo" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        var FormId = $.getQueryString({ ID: "FormId" });
        var FormName = unescape($.getQueryString({ ID: "FormName" }));
        var StatusEnum = { 0: "未签收", 4: "已签收" };
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
                idProperty: 'OwnerId',
                data: myData,
                fields: [
			    { name: 'OwnerId' }, { name: 'Owner' }, { name: 'EFormName' }, { name: 'CreatedTime' }, { name: 'DeptName' },
			    { name: 'FinishTime' }, { name: 'Status' }, { name: 'Ext1' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    options.data.FormId = FormId;
                }
                }
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
                { fieldLabel: '接收人', id: 'Owner', schopts: { qryopts: "{ mode: 'Like', field: 'Owner' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("Owner"));
                }
                }
                ]
            });
            titPanel = new Ext.ux.AimPanel({
                //  tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                title: "【" + FormName + "】分发信息",
                store: store,
                region: 'center',
                autoExpandColumn: 'DeptName',
                columns: [
                    { id: 'OwnerId', dataIndex: 'OwnerId', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'Owner', dataIndex: 'Owner', header: '接收人', width: 100 },
                    { id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 120 },
					{ id: 'CreatedTime', dataIndex: 'CreatedTime', header: '分发时间', width: 100 },
                    { id: 'Status', dataIndex: 'Status', header: '签收状态', width: 80, enumdata: StatusEnum },
                    { id: 'FinishTime', dataIndex: 'FinishTime', header: '签收时间', width: 100 }
                    ],
                tbar: titPanel,
                bbar: pgBar
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
                if (Index == "1") {
                    opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + val, "", 1200, 650);
                }
                else {
                    opencenterwin("/WorkFlow/TaskExecute.aspx?op=r&TaskId=" + val, "", 1200, 650);
                }
            });
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Title":
                    if (Index == "1") {
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                        record.get('RelateId') + "\")'>" + value + "</label>";
                    }
                    else {
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                        record.get('ID') + "\")'>" + value + "</label>";
                    }
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
                case "SubContractAmount":
                    if (value) {
                        rtn = AmountFormat(value);
                    }
                    break;
            }
            return rtn;
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
