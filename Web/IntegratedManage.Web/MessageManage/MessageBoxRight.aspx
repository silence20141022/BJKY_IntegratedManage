<%@ Page Title="消息盒子" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="MessageBoxRight.aspx.cs" Inherits="IntegratedManage.Web.MessageBoxRight" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
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
            background-color: #33dd33;
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
        var store, myData, dataview, tpl, panel, formPanel, userId;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
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
			    { name: 'Attachment' }, { name: 'ShortMessage' }, { name: 'Mail' }, { name: 'State' }, { name: 'ReceiverIds' },
			    { name: 'ReceiverNames' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    //options.data.cid = cid;
                }
                }
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '已阅',
                    iconCls: 'aim-icon-submit',
                    handler: function() {
                        var recs = dataview.getSelectedRecords();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要标记已阅的记录！");
                            return;
                        }
                        $.ajaxExec("SignRead", { id: recs[0].get("Id") }, function(rtn) {
                        });
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = dataview.getSelectedRecords();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        $.ajaxExec("Delete", { id: recs[0].get("Id") }, function(rtn) {
                            store.remove(recs[0]);
                        });
                    }
                },
                  '->']
            });
            tpl = new Ext.XTemplate(
                '<tpl for=".">',
                '<div class="thumb-separater"><table width="100%">',
                   '<tr style="font-size:14px;color:blue"><td>{MessageType}</td><td>{CreateTime}</td><td>{CreateName}</td><td><label style="cursor:pointer; text-decoration:underline" lang="{CreateId}" onclick="WriteBack(this.lang)">回复</label></td><td>详细</td></tr>',
                   '<tr style="font-size:15px;"><td colspan="5">{MessageContent}</td></tr>',
                '</table></div>',
                '</tpl>'
             );
            dataview = new Ext.DataView({
                id: 'my-data-view',
                store: store,
                tpl: tpl,
                region: 'center',
                autoScroll: true,
                autoHeight: true,
                singleSelect: false,
                multiSelect: true,
                simpleSelect: true,
                // overClass: 'x-view-over',
                selectedClass: 'x-view-selected',
                itemSelector: 'div.thumb-separater'
            });
            panel = new Ext.ux.AimPanel({
                // title: '参与考核部门',
                layout: 'border',
                region: 'center',
                //   renderTo: 'div0',
                margins: '0 0 45 0',
                tbar: tlBar,
                border: false,
                autoScroll: true,
                items: [dataview]
            });
            formPanel = new Ext.FormPanel({
                region: "south",
                height: 120,
                collapsed: true,
                collapsible: true,
                buttonAlign: 'right',
                bodyStyle: 'padding:5px',
                frame: true,
                items: [{ xtype: 'textarea', id: 'msgContent', hideLabel: true, width: '100%'}],
                buttons: [{ text: '发送', handler: function() {
                    if (!Ext.getCmp("msgContent").getValue()) {
                        AimDlg.show("发送内容不能为空！");
                        return;
                    }
                    $.ajaxExec("SendMessage", { ReceiverId: userId, MessageContent: escape(Ext.getCmp("msgContent").getValue()) }, function() {
                        Ext.getCmp("msgContent").setValue("");
                        formPanel.toggleCollapse();
                    })
                } }]
                });
                viewport = new Ext.ux.AimViewport({
                    items: [panel, formPanel]
                });
            }
            function WriteBack(val) {
                userId = val;
                if (formPanel.collapsed) {
                    formPanel.toggleCollapse();
                }
            }
            function onExecuted() {
                store.reload();
            }
            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
            }
            function handleActivate(tab) {
                if (document.getElementById("frameContent")) {
                    if (tabpanel.activeTab.tooltip == "0") {
                        frameContent.location.href = "UserList.aspx?Index=" + tabpanel.activeTab.tooltip;
                    }
                    else {
                        frameContent.location.href = "DeptList.aspx?Index=" + tabpanel.activeTab.tooltip;
                    }
                }
            }
            function showwin(val) {
                var task = new Ext.util.DelayedTask();
                task.delay(50, function() {
                    opencenterwin("ReleaseDocumentEdit.aspx?op=v&id=" + val, "", 1200, 650);
                });
            }
            function showflowwin(val) {
                var task = new Ext.util.DelayedTask();
                task.delay(50, function() {
                    opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + val, "", 1200, 650);
                });
            }
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = "";
                switch (this.id) {
                    case "FileName":
                        if (record.get("WorkFlowState")) {
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
                        }
                        else {
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>" + value + "</label>";
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
                    case "WorkFlowState":
                        if (value) {
                            rtn = eval('AimState["WorkFlowState"].' + value);
                        }
                        else {
                            rtn = "申请";
                        }
                        break;
                }
                return rtn;
            }
        
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
