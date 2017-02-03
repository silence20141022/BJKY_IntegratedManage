<%@ Page Title="消息管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="MessageList.aspx.cs" Inherits="IntegratedManage.Web.MessageManage.MessageList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        var Index = $.getQueryString({ ID: "Index" });
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
                idProperty: 'Id',
                data: myData,
                fields: [
			    { name: 'Id' }, { name: 'ReceiverId' }, { name: 'ReceiverName' }, { name: 'MessageType' }, { name: 'MessageContent' },
			    { name: 'Attachment' }, { name: 'ShortMessage' }, { name: 'Mail' }, { name: 'State' }, { name: 'SubmitState' },
			    { name: 'ReceiverIds' }, { name: 'ReceiverNames' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    options.data.Index = Index;
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
                columns: 6,
                items: [
                    { fieldLabel: '接收人', id: 'ReceiverName', schopts: { qryopts: "{ mode: 'Like', field: 'ReceiverName' }"} },
                    { fieldLabel: '发送人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} },
                    { fieldLabel: '消息类型', id: 'MessageType', schopts: { qryopts: "{ mode: 'Like', field: 'MessageType' }"} },
                    { fieldLabel: '发送内容', id: 'MessageContent', schopts: { qryopts: "{ mode: 'Like', field: 'MessageContent' }"} },
                    { fieldLabel: '开始时间', id: 'StartTime', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                    { fieldLabel: '结束时间', id: 'EndTime', xtype: 'datefield', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} }
                ]
            });
            tlBar = new Ext.Toolbar(
            {
                items: [{
                    text: '已阅',
                    iconCls: 'aim-icon-submit',
                    hidden: Index == 1 || Index == 2 || Index == 3 || Index == 4,
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要标记已阅的记录！");
                            return;
                        }
                        var ids = [];
                        $.each(recs, function() {
                            ids.push(this.get("Id"));
                        })
                        $.ajaxExec("HaveRead", { ids: ids }, function() {
                            store.reload();
                        })
                    }
                },
                { xtype: 'tbseparator',
                    hidden: Index == 1 || Index == 2 || Index == 3 || Index == 4
                },
                {
                    text: '删除',
                    hidden: Index == 2 || Index == 3 || Index == 4,
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("流程中或者审批结束的记录不能进行修改!");
                            return;
                        }
                        opencenterwin("ReleaseDocumentEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 1200, 650);
                    }
                },
                {
                    text: '修改',
                    hidden: Index != 2,
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        if (recs[0].get("WorkFlowState")) {
                            AimDlg.show("流程中或者审批结束的记录不能进行修改!");
                            return;
                        }
                        opencenterwin("MessageSend.aspx?op=u&id=" + recs[0].get("Id"), "", 600, 500);
                    }
                }, '->', '<font color="blue"><b>双击行可以查看详细</b></font>']
            });
            // 工具标题栏
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'MessageContent',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'ReceiverName', dataIndex: 'ReceiverName', header: '接收人', width: 90 },
					{ id: 'MessageType', dataIndex: 'MessageType', header: '消息类型', width: 90 },
					{ id: 'MessageContent', dataIndex: 'MessageContent', header: '内容', width: 200, renderer: RowRender },
					{ id: 'Attachment', dataIndex: 'Attachment', header: '附件', width: 50, renderer: RowRender },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '发送人', width: 80 },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '发送时间', width: 130 }
                    ],
                tbar: titPanel,
                listeners: { rowdblclick: function(grid, rowIndex, e) {
                    opencenterwin("MessageSend.aspx?op=v&&id=" + store.getAt(rowIndex).get("Id"), "", 600, 500);
                }
                }
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
                opencenterwin("MessageSend.aspx?op=u&id=" + val, "", 1200, 650);
            });
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Attachment":
                    if (value) {
                        rtn = "<img src='../images/shared/attach.png' />";
                    }
                    break;
                case "MessageContent":
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
