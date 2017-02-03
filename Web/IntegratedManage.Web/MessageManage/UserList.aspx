<%@ Page Title="人员列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="UserList.aspx.cs" Inherits="IntegratedManage.Web.MessageManage.UserList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            var reader = new Ext.data.ArrayReader({}, [
               { name: 'UserId' }, { name: 'UserName' }, { name: 'DeptId' }, { name: 'DeptName' }
            ]);
            var store = new Ext.data.GroupingStore({
                reader: reader,
                data: AimState["DataList"] || [],
                groupField: 'DeptName'
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 1,
                items: [
                    { fieldLabel: '姓名', id: 'UserName', schopts: { qryopts: "{ mode: 'Like', field: 'UserName' }"} }
                ]
            });
            titPanel = new Ext.ux.AimPanel({
                // tbar: tlBar,
                items: [schBar]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                listeners: { rowdblclick: function(grid, rowIndex, e) {
                    var rec = store.getAt(rowIndex)
                    showwin(rec.get("UserId"));
                }
                },
                tbar: titPanel,
                columns: [
                    { id: 'UserId', dataIndex: 'UserId', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer({ width: 30 }),
                    { id: 'UserName', dataIndex: 'UserName', header: '联系人', width: 100 },
                    { id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 100, hidden: true }
		        ],
                view: new Ext.grid.GroupingView({
                    forceFit: true,
                    startCollapsed: true,
                    groupTextTpl: '{[values["text"].replace("部门:","")]} '
                    //  ({[values.rs.length]}个)({[values.rs.length]}个)groupTextTpl: '{text} ({[values.rs.length]}个)&nbsp;&nbsp;&nbsp;&nbsp;项目数:(' + store.data.length + ')个&nbsp;&nbsp;&nbsp;&nbsp;{[values["text"].substr(5,4)]}率:({[Math.round(values.rs.length/' + store.data.length + '*10000)/100]}%)'
                })
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
        function showwin(val1, val2, val3, val4) {
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("MessageSend.aspx?op=c&&UserId=" + val1, "MessageSend", 600, 500);
            });
        }  
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
