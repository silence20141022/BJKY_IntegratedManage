<%@ Page Title="消息盒子" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="MessageBox.aspx.cs" Inherits="IntegratedManage.Web.MessageManage.MessageBox" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, tlBar2, titPanel, grid, colModel, viewport;
        var according = "Sender";
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
			    { name: 'Id' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'MessageType' }, { name: 'Quantity' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    options.data.According = according;
                }, load: function() {
                    if (document.getElementById("frameContent") && store.data.length > 0) {
                        if (according == "Sender") {
                            frameContent.location.href = "MessageBoxRight.aspx?According=" + according + "&&CreateId=" + store.getAt(0).get("CreateId");
                        }
                        else {
                            frameContent.location.href = "MessageBoxRight.aspx?According=" + according + "&&MessageType=" + escape(store.getAt(0).get("MessageType"));
                        }
                    }
                }
                }
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            //            tlBar = new Ext.ux.AimToolbar({
            //                items: [{
            //                    text: '按姓名分组',
            //                    iconCls: 'aim-icon-add',
            //                    handler: function() {
            //                        according = "Sender";
            //                        store.reload();
            //                        colModel.setHidden(3, false);
            //                        colModel.setHidden(4, true);
            //                    }
            //                },
            //                '-', {
            //                    text: '按类型分组',
            //                    iconCls: 'aim-icon-edit',
            //                    handler: function() {
            //                        according = "MessageType";
            //                        store.reload();
            //                        colModel.setHidden(3, true);
            //                        colModel.setHidden(4, false);
            //                    }
            //                },
            //                  '->']
            //            });
            tlBar2 = new Ext.ux.AimToolbar({
                items: [{
                    text: '全部详情',
                    handler: function() {
                        opencenterwin("MessageTab.aspx", "", 1200, 650);
                    }
                }, '-', {
                    text: '全部删除',
                    // iconCls: 'aim-icon-edit',
                    handler: function() {
                        //                        according = "MessageType";
                        //                        store.reload();
                        //                        colModel.setHidden(3, true);
                        //                        colModel.setHidden(4, false);
                    }
                },
                  '->']
            });
            grid = new Ext.ux.grid.AimGridPanel({
                title: '消息盒子',
                store: store,
                region: 'west',
                width: 200,
                //  autoExpandColumn: aaccording == "Sender" ? 'CreateName' : 'MessageType',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'CreateName', dataIndex: 'CreateName', header: '发送人', width: 90 },
                    { id: 'MessageType', dataIndex: 'MessageType', header: '消息类型', width: 90, hidden: true },
					{ id: 'Quantity', dataIndex: 'Quantity', header: '数量', width: 50 }
                    ],
                // tbar: tlBar,
                bbar: tlBar2
            });
            colModel = grid.getColumnModel();
            viewport = new Ext.ux.AimViewport({
                items: [grid, {
                    region: 'center',
                    margins: '-2 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'}]

                });
                if (document.getElementById("frameContent") && store.data.length > 0) {
                    if (according == "Sender") {
                        frameContent.location.href = "MessageBoxRight.aspx?According=" + according + "&&CreateId=" + store.getAt(0).get("CreateId");
                    }
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
            function window_onunload() {
                if (window.opener.win2) {
                    window.opener.win2 = "";
                }
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
                }
                return rtn;
            }
        
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
