<%@ Page Title="部门列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="DeptList.aspx.cs" Inherits="IntegratedManage.Web.MessageManage.DeptList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var myData, pgBar, schBar, tlBar, titPanel, grid, viewport;
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
                idProperty: 'DeptId',
                data: myData,
                fields: [
			    { name: 'DeptId' }, { name: 'GroupName' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    //options.data.cid = cid;
                }
                }
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                listeners: { rowdblclick: function(grid, rowIndex, e) {
                    showwin(store.getAt(rowIndex).get("DeptId"));
                }
                },
                columns: [
                { id: 'DeptId', dataIndex: 'DeptId', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                { id: 'GroupName', dataIndex: 'GroupName', header: '部门', width: 100 }
		        ],
                autoExpandColumn: 'GroupName'
            });
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',               left=  ' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function showwin(val) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("MessageSend.aspx?op=c&&DeptId=" + val, "MessageSend", 600, 500);
            });
        }  
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
