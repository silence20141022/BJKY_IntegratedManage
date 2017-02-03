<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="Manage_AddrBookList.aspx.cs" Inherits="IntegratedManage.Web.AddressBook.Manage_AddrBookList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGridLevels.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <style type="text/css">
        .hintStyle
        {
            width: 280px;
            float: left;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: left;
            border: 1px solid gray;
        }
    </style>

    <script type="text/javascript">

        var DeptId = $.getQueryString({ ID: "DeptId" });
        var DeptName = unescape($.getQueryString({ ID: 'DeptName' }));

        var EditWinStyle = CenterWin("width=770,height=530,scrollbars=no");
        var EditPageUrl = "EnterpriseAddrBookEdit.aspx";
        var viewport, treeStore, treeGrid, DataRecord;
        var authState = '';   //验证是否具有修改的权限
        var grid, store;

        function onPgLoad() {
            authState = AimState["authState"] || '';
            setPgUI();
        }

        function setPgUI() {


            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["EnterpriseAddrBookList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'EnterpriseAddrBookList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'UserId' },
			{ name: 'UserName' },
			{ name: 'DeptId' },
			{ name: 'DeptName' },
			{ name: 'Postion' },
			{ name: 'PhotoId' },
			{ name: 'Sex' },
			{ name: 'Fax' },
			{ name: 'OfficeEmail' },
			{ name: 'OfficeTel' },
			{ name: 'OfficeAddr' },
			{ name: 'IsShowPersonalTel' },
			{ name: 'PersonalTel' },
			{ name: 'PersonalAddr' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			],
                listeners: {
                    aimbeforeload: function(proxy, options) {
                        options.data = options.data || {};
                        options.data.DeptId = DeptId;
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
                collapsed: false,
                columns: 4,
                items: [
                { fieldLabel: '姓名', id: 'UserName', schopts: { qryopts: "{ mode: 'Like', field: 'UserName' }"} },
                { fieldLabel: '部门', id: 'DeptName', schopts: { qryopts: "{ mode: 'Like', field: 'DeptName' }"} },
                { fieldLabel: '职务', id: 'Postion', schopts: { qryopts: "{ mode: 'Like', field: 'Postion' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("UserName"));   //Number 为任意
                }
                }
                ]
            });
            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '同步人员到通讯录',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        Ext.getBody().mask("数据同步中,请稍候");    //mask  .
                        $.ajaxExec("Sync", {}, function(rtn) {
                            Ext.getBody().unmask("数据同步完成");
                            store.reload();
                        });
                        //ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                },
                '-',
                {
                    text: '编辑',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }

                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
}]
                });

                // 工具标题栏
                titPanel = new Ext.ux.AimPanel({
                    tbar: authState ? tlBar : '',
                    items: [schBar]
                });

                // 表格面板
                grid = new Ext.ux.grid.AimGridPanel({
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'PersonalTel',
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 100, sortable: true, renderer: RowRender },
					{ id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 200, sortable: true, renderer: RowRender },
					{ id: 'Postion', dataIndex: 'Postion', header: '职位', width: 130, sortable: true, renderer: RowRender },
					{ id: 'OfficeEmail', dataIndex: 'OfficeEmail', header: '邮件', width: 140, renderer: RowRender },
					{ id: 'OfficeTel', dataIndex: 'OfficeTel', header: '办公电话', width: 140, renderer: RowRender },
					{ id: 'PersonalTel', dataIndex: 'PersonalTel', header: '移动电话', width: 140, renderer: RowRender }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });
                // 页面视图
                viewport = new Ext.Viewport({
                    layout: 'border',
                    items: [grid]
                });
            }
            var tpl_Div = '<div class=&quot;hintStyle&quot;><table style=&quot;width: 100%; text-align: left; table-layout: fixed; font-variant: small-caps;font-size: 12px&quot;>';
            var tpl_Tr0 = '<tr style=&quot;font-size:12px;&quot;><td rowspan=&quot;5&quot;  style=&quot;width:35%&quot;><img src={PhotoId} id=&quot;img&quot; style=&quot;width:90px;height:100px&quot;/></td>';
            var tpl_Tr1 = '<td style=&quot;width:25%;font-weight: bold;&quot; >&nbsp;&nbsp;姓名</td><td style=&quot;width:45%&quot;>{UserName}</td></tr>';
            var tpl_Tr2 = '<tr><td style=&quot;font-weight: bold;&quot;>&nbsp;&nbsp;职务</td><td>{Postion}</td></tr>';
            var tpl_Tr3 = '<tr><td style=&quot;font-weight: bold;&quot;>&nbsp;&nbsp;邮箱</td><td>{OfficeEmail}</td></tr>';
            var tpl_Tr4 = '<tr><td style=&quot;font-weight: bold;&quot;>&nbsp;&nbsp;电话</td><td>{OfficeTel}</td></tr>';
            var tpl_Tr5 = '<tr><td style=&quot;font-weight: bold;&quot;>&nbsp;&nbsp;移动电话</td><td>{PersonalTel}</td></tr>';
            var tpl = tpl_Div + tpl_Tr0 + tpl_Tr1 + tpl_Tr2 + tpl_Tr3 + tpl_Tr4 + tpl_Tr5 + '</table></div>';
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = '';
                if (value) {
                    rtn = value;
                    //if (value == "陈兴斌")
                    var tempStr = tpl.replaceAll('{PhotoId}', record.get("PhotoId") ? '/Document/' + record.get("PhotoId") : 'nobody.png');
                    tempStr = tempStr.replaceAll('{UserName}', record.get("UserName") || '');
                    tempStr = tempStr.replaceAll('{Postion}', record.get("Postion") || '');
                    tempStr = tempStr.replaceAll('{OfficeEmail}', charSplit(record.get("OfficeEmail") || ''));
                    tempStr = tempStr.replaceAll('{OfficeTel}', record.get("OfficeTel") || '');
                    tempStr = tempStr.replaceAll('{PersonalTel}', record.get("PersonalTel") || '');

                    cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + tempStr + '"';
                    rtn = '<span style=font-weight: bold>' + value + '</span>';
                }
                return rtn;
            }

            function windowOpen(val) {
                var task = new Ext.util.DelayedTask();
                task.delay(50, function() {
                    opencenterwin(EditPageUrl + "?op=r&id=" + val, "", 900, 620);
                });
            }

            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
            }

            function charSplit(val) {
                if (val.length > 18)
                    return val.toString().substring(0, 13) + "...";
                else
                    return val;
            }

            function onExecuted() {
                store.reload();
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
