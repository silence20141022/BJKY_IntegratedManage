<%@ Page Title="栏目维护" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="NewsTypeList.aspx.cs" Inherits="IntegratedManage.Web.Modules.PubNews.NewsTypeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var StatusEnum = { '1': '有效', '0': '无效' };
        var deptId = $.getQueryString({ ID: "DeptId", DefaultValue: '' });
        var viewport;
        var myData, store;
        var grid;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["SysUserList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'SysUserList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'TypeName' },
			{ name: 'IsEfficient' },
			{ name: 'AllowManageId' }
			], listeners: { "aimbeforeload": function(proxy, options) {
			    options.data = options.data || {};
			    options.data.op = pgOperation || null;
			    options.data.DeptId = deptId;
			}
			}
            });
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store,
                displayInfo: true,
                displayMsg: '当前条目 {0} - {1}, 总条目 {2}',
                emptyMsg: "无条目显示",
                items: ['-']
            });

            // 搜索栏
            var schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 5,
                items: [
				{ fieldLabel: '栏目名称', anchor: '90%', id: 'TypeName', name: 'TypeName', schopts: { qryopts: "{ mode: 'Like', field: 'TypeName' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("TypeName"));
                } }]
                });
                var tlBar = new Ext.ux.AimToolbar({
                    items: [{
                        text: '添加',
                        iconCls: 'aim-icon-add',
                        handler: function() {
                            openEditWin("NewsTypeEdit.aspx?DeptId=" + $.getQueryString({ ID: 'DeptId', DefaultValue: '' }), "c");
                        }
                    }, {
                        text: '修改',
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if ($.getQueryString({ ID: 'DeptId', DefaultValue: '' }) != "") {
                                for (var i = 0; i < recs.length; i++) {
                                    if (recs[i].get("AllowManageId") != "<%=this.UserInfo.UserID %>") {
                                        alert("不是您创建的部门版块,没有权限操作!");
                                        return;
                                    }
                                }
                            }
                            openEditWin("NewsTypeEdit.aspx?DeptId=" + $.getQueryString({ ID: 'DeptId', DefaultValue: '' }), "u");
                        }
                    }, {
                        text: '删除',
                        iconCls: 'aim-icon-delete',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要删除的记录！");
                                return;
                            }
                            if ($.getQueryString({ ID: 'DeptId', DefaultValue: '' }) != "") {
                                for (var i = 0; i < recs.length; i++) {
                                    if (recs[i].get("AllowManageId") != "<%=this.UserInfo.UserID %>") {
                                        alert("不是您创建的部门版块,没有权限操作!");
                                        return;
                                    }
                                }
                            }
                            if (confirm("确定删除所选记录？")) {
                                batchOperate('batchdelete', recs);
                            }
                        }
                    }, {
                        text: '发布到门户块',
                        iconCls: 'aim-icon-execute',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要发布到门户的栏目！");
                                return;
                            }
                            $.ajaxExec("JudgeExist", { id: recs[0].get("Id"), DeptId: deptId }, function(rtn) {
                                if (rtn.data.Exist == "T") {
                                    AimDlg.show("你选择的栏目在本部门门户中已经存在！");
                                    return;
                                }
                                else {
                                    $.ajaxExec('asyn', { id: recs[0].data.Id }, function(args) {
                                        AimDlg.show("同步到门户成功!");
                                    });
                                }
                            });
                        }
                    }, '->', {
                        text: '复杂查询',
                        iconCls: 'aim-icon-search',
                        handler: function() {
                            schBar.toggleCollapse(false);
                            setTimeout("viewport.doLayout()", 50);
                        }
}]
                    });

                    // 工具标题栏
                    var titPanel = new Ext.ux.AimPanel({
                        tbar: tlBar,
                        items: [schBar]
                    });

                    // 表格面板
                    grid = new Ext.ux.grid.AimGridPanel({
                        store: store,
                        region: 'center',
                        monitorResize: true,
                        columns: [
                    { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'TypeName', header: '栏目名称', width: 100, sortable: true, renderer: linkRender, dataIndex: 'TypeName' },
					{ id: 'IsEfficient', header: '是否有效', width: 100, sortable: true, enumdata: StatusEnum, dataIndex: 'IsEfficient' }
                    ],
                        bbar: pgBar,
                        tbar: titPanel,
                        autoExpandColumn: 'TypeName'
                    });

                    // 页面视图
                    viewport = new Ext.ux.AimViewport({
                        layout: 'border',
                        items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
                    });
                }

                // 链接渲染
                function linkRender(val, p, rec) {
                    var rtn = val;
                    switch (this.dataIndex) {
                        case "TypeName":
                            rtn = "<a class='aim-ui-link' onclick='openEditWin(\"NewsTypeEdit.aspx?id=" + rec.id + "\")'>" + val + "</a>";
                            break;
                    }

                    return rtn;
                }

                // 打开模态窗口
                function openEditWin(url, op, style) {
                    op = op || "r";
                    style = style || CenterWin("width=650,height=550,scrollbars=yes");

                    var sels = grid.getSelectionModel().getSelections();
                    var sel;
                    if (sels.length > 0) sel = sels[0];

                    var params = [];
                    params[params.length] = "op=" + op;
                    if (op !== "c") {
                        if (sel) {
                            if (url.indexOf("id=") < 0) {
                                params[params.length] = "id=" + sel.json.Id;
                            }
                        } else {
                            AimDlg.show('请选择需要操作的行。', '提示', 'alert');
                            return;
                        }
                    }

                    url = jQuery.combineQueryUrl(url, params)
                    rtn = OpenWin(url, "_blank", style);
                    if (rtn && rtn.result) {
                        if (rtn.result === 'success') {
                            store.reload();
                        }
                    }
                }

                function batchOperate(action, recs, params, url) {
                    if (!url) url = null;

                    idList = [];

                    if (recs != null) {
                        $.each(recs, function() {
                            idList.push(this.json["Id"]);
                        })
                    }

                    params = params || {};
                    params["IdList"] = idList;

                    $.ajaxExec(action, params, onExecuted);
                }

                // 提交数据成功后
                function onExecuted() {
                    store.reload();
                }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            栏目维护</h1>
    </div>
</asp:Content>
