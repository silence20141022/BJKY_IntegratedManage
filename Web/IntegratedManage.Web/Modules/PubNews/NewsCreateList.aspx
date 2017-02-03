<%@ Page Title="信息列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="NewsCreateList.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.NewsCreateList" %>

<asp:Content ID="HeadHolder" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes");
        var EditPageUrl = "FrmMessageView.aspx";
        var StatusEnum = { 0: "未发布", 1: "已提交", 2: "已发布" };

        var Expire = "false";
        var viewport, grid;
        var store;
        var typeId, op;

        function onPgLoad() {
            typeId = $.getQueryString({ "ID": "TypeId" });
            setPgUI();
        }

        function setPgUI() {
            // 表格数据
            var myData = {
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
			    { name: 'Title' },
			    { name: 'TypeId' },
			    { name: 'PostUserName' }, { name: 'PostDeptName' }, { name: 'ReadCount' },
			    { name: 'PostTime' },
			    { name: 'AuthorName' },
			    { name: 'SaveType' },
			    { name: 'SaveTime' },
			    { name: 'NewsType' },
			    { name: 'ExpireTime' },
			    { name: 'WFState' },
			    { name: 'WFResult' },
			    { name: 'WFCurrentNode' },
			    { name: 'AuditUserId' },
			    { name: 'AuditUserName' },
			    { name: 'State' }
			    ], listeners: { "aimbeforeload": function(proxy, options) {
			        options.data = options.data || {};
			        options.data.op = pgOperation || null;
			        options.data.TypeId = typeId;
			        options.data.Expire = Expire;
			    }
			    }
            });

            // 分页栏
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            var schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 5,
                items: [
                { id: 'SearchTypeId', fieldLabel: '类型', anchor: '90%', blankText: "全部", disabled: pgOperation == "r", style: { marginTop: '-1px' }, id: 'TypeId', name: 'TypeId', xtype: 'aimcombo', enumdata: AimState["EnumType"], schopts: { qryopts: "{ mode: 'Like', field: 'TypeId' }"} },
				{ fieldLabel: '标题', anchor: '90%', id: 'Title', name: 'Title', schopts: { qryopts: "{ mode: 'Like', field: 'Title' }"} },
				{ fieldLabel: '发布人', anchor: '90%', name: 'AuthorName', schopts: { qryopts: "{ mode: 'Like', field: 'AuthorName' }"} },
				{ fieldLabel: '发布部门', anchor: '90%', name: 'PostDeptName', schopts: { qryopts: "{ mode: 'Like', field: 'PostDeptName' }"} },
                { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                    Ext.ux.AimDoSearch(Ext.getCmp("Title"));
                } }]
                });

                // 工具栏
                var tlBar = new Ext.ux.AimToolbar({
                    items: [{
                        text: '添加',
                        iconCls: 'aim-icon-add',
                        handler: function() {
                            openEditWin("NewsCreateEdit.aspx?TypeId=" + typeId, "c");
                        }
                    }, {
                        text: '添加图片新闻',
                        iconCls: 'aim-icon-add',
                        handler: function() {
                            openEditWin("ImgNews/FrmImgNewsCreateEdit.aspx?TypeId=146156a0-34a4-4c8e-9e51-0d9c5b4588c9", "c");
                        }
                    }, {
                        text: '添加视频新闻',
                        iconCls: 'aim-icon-add',
                        handler: function() {
                            openEditWin("VideoNews/FrmVideoNewsCreateEdit.aspx?TypeId=edd6f523-065f-4169-a855-8df11faf8ab2", "c");
                        }
                    }, {
                        text: '修改',
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要修改的记录！");
                                return;
                            }

                            if (recs[0].get("WFState") == "Flowing") {
                                AimDlg.show("审批中的记录不能修改！");
                                return;
                            }

                            if (recs[0].get("WFState") == "End") {
                                AimDlg.show("审批完成的记录不能修改！");
                                return;
                            }

                            for (var i = 0; i < recs.length; i++) {
                                if (recs[i].data.State && recs[i].data.State != "0") {
                                    AimDlg.show("已发布的消息不能修改！");
                                    return;
                                }
                            }

                            if (recs[0].data.NewsType == "视频") {
                                var url = "VideoNews/FrmVideoNewsCreateEdit.aspx";
                            }
                            else if (recs[0].data.NewsType == "图片") {
                                var url = "ImgNews/FrmImgNewsCreateEdit.aspx";
                            }
                            else {
                                var url = "NewsCreateEdit.aspx"
                            }
                            openEditWin(url, "u");
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

                            if (recs[0].get("WFState") == "Flowing") {
                                AimDlg.show("审批中的记录不能删除！");
                                return;
                            }

                            for (var i = 0; i < recs.length; i++) {
                                if (recs[i].data.State && recs[i].data.State != "0") {
                                    AimDlg.show("已发布的消息不能删除！");
                                    return;
                                }
                            }

                            if (confirm("确定删除所选记录？")) {
                                batchOperate('batchdelete', recs);
                            }
                        }
                    }, '-', {
                        text: '提交审批',
                        aimexecutable: true,
                        iconCls: 'aim-icon-edit',
                        handler: function() {
                            var recs = grid.getSelectionModel().getSelections();
                            if (!recs || recs.length <= 0) {
                                AimDlg.show("请先选择要提交的记录！");
                                return;
                            }
                            if (recs[0].get("WFState")) {
                                AimDlg.show("该记录已经提交！");
                                return;
                            }
                            if (!recs[0].data.AuditUserId) {
                                AimDlg.show("请填写审核人后再提交");
                                return;
                            }
                            if (confirm("确定要提交审批吗？")) {
                                Ext.getBody().mask("提交中,请稍后...");
                                var AuditUserId = recs[0].data.AuditUserId;
                                var AuditUserName = recs[0].data.AuditUserName;
                                jQuery.ajaxExec('submit', { id: recs[0].data.Id }, function(rtn) {
                                    window.setTimeout("AutoExecuteFlow('" + rtn.data.FlowId + "','" + AuditUserId + "','" + AuditUserName + "')", 1000);
                                });
                            }
                        }
                    }, { text: '流程跟踪', iconCls: 'aim-icon-addrbook', handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要跟踪的记录！");
                            return;
                        }
                        if (!recs[0].get("WFState")) {
                            AimDlg.show("有审批的记录才能跟踪！");
                            return;
                        }
                        opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + recs[0].get("Id"), "", 1000, 500);
                    }
                    }, { text: '撤销流程', iconCls: 'aim-icon-cancel', handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要撤销的记录！");
                            return;
                        }
                        if (recs[0].get("WFState") != "Flowing") {
                            AimDlg.show("审批中且回到首环节的申请才能撤销！");
                            return;
                        }

                        if (!confirm("确定要撤销流程？")) return;

                        $.ajaxExec("CancelFlow", { id: recs[0].get("Id") }, function(rtn) {
                            if (rtn.data.error) {
                                AimDlg.show(rtn.data.error);
                            }
                            else {
                                store.reload();
                            }
                        });
                    }
                    }, '-', {
                        text: '收回修改',
                        iconCls: 'aim-icon-undo',
                        aimexecutable: true,
                        handler: function() {
                            ReSubmitNews(this);
                        }
                    },
                      {
                          text: '已过期',
                          iconCls: 'aim-icon-search',
                          aimexecutable: true,
                          handler: function() {
                              if (Expire == "false") {
                                  Expire = "true";
                                  this.addClass("x-btn-click");
                              }
                              else {
                                  Expire = "false";
                                  this.removeClass("x-btn-click");
                              }
                              store.reload();
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
                    border: false,
                    columns: [
                        { id: 'Id', header: '标识', dataIndex: 'Id', hidden: true },
                        new Ext.ux.grid.AimRowNumberer(),
                        new Ext.ux.grid.AimCheckboxSelectionModel(),
					    { id: 'TypeId', header: '类别', width: 100, sortable: false, enumdata: AimState["EnumType"], dataIndex: 'TypeId' },
					    { id: 'Title', header: '标题', width: 100, sortable: true, dataIndex: 'Title', renderer: function(v, p, c) {
					        if (c.data.NewsType == "视频") {
					            var url = "\"VideoNews/FrmVdeoNewsView.aspx?id=" + c.data.Id + "\"";
					            return "<a href='#' onclick='openEditWin(" + url + ");'>" + v + "</a>";
					        }
					        else if (c.data.NewsType == "图片") {
					            var url = "\"ImgNews/FrmImageNews.aspx?id=" + c.data.Id + "\"";
					            return "<a href='#' onclick='openEditWin(" + url + ");'>" + v + "</a>";
					        }
					        else {
					            var url = "\"FrmMessageView.aspx?id=" + c.data.Id + "\"";
					            return "<a href='#' onclick='openEditWin(" + url + ");'>" + v + "</a>";
					        }
					    }
					    }, //linkparams: { url: EditPageUrl, style: EditWinStyle },
					    {id: 'AuthorName', header: '发布人', width: 80, sortable: true, dataIndex: 'AuthorName' },
					    { id: 'PostDeptName', dataIndex: 'PostDeptName', header: '发布部门', width: 120, sortable: true },
					    { id: 'SaveTime', header: '创建日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'SaveTime', hidden: pgOperation == "r" },
					    { id: 'PostTime', header: '发布日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'PostTime' },
					    { id: 'ReadCount', dataIndex: 'ReadCount', header: '阅读次数', width: 60, sortable: true },
					    { id: 'ExpireTime', header: '失效日期', width: 80, renderer: ExtGridDateOnlyRender, sortable: true, dataIndex: 'ExpireTime' },
					    { id: 'State', header: '状态', width: 80, enumdata: StatusEnum, sortable: true, dataIndex: 'State' },
					    { id: 'WFState', header: '审批状态', width: 80, sortable: true, dataIndex: 'WFState', enumdata: AimState["WorkFlowState"] },
					    { id: 'WFCurrentNode', header: '当前环节', width: 80, sortable: true, dataIndex: 'WFCurrentNode', renderer: function(v, p, c) {
					        if (!v) {
					            if (c.data.WFState == "End") {
					                return "流程已结束";
					            }
					            else { return "未启动流程"; }
					        }
					        return v;
					    }
					    },
					    { id: 'WFResult', header: '审批结果', width: 80, sortable: true, dataIndex: 'WFResult' }
                    ],
                    bbar: pgBar,
                    tbar: titPanel,
                    autoExpandColumn: 'Title'
                });

                //页面视图
                viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [grid]
                });

                if (pgOperation == "r") {
                    //隐藏流程审批列
                    var config = grid.getColumnModel().config;
                    for (var i = 0; i < config.length; i++) {
                        if (config[i].header && ",审批状态,当前环节,审批结果,".indexOf("," + config[i].header + ",") > -1) {
                            grid.getColumnModel().setHidden(i, true);
                        }
                    }
                }
            }

            function AutoExecuteFlow(flowid, AuditUserId, AuditUserName) {
                jQuery.ajaxExec('autoexecute', { "FlowId": flowid, AuditUserId: AuditUserId, AuditUserName: AuditUserName }, function(rtn) {
                    if (rtn.data.error) {
                        alert(rtn.data.error);
                    }
                    else {
                        alert("提交成功！");
                        store.reload();
                        Ext.getBody().unmask();
                    }
                });
            }

            // 打开模态窗口
            function openEditWin(url, op, style) {
                ExtOpenGridEditWin(grid, url, op, style || EditWinStyle);
            }

            function batchOperate(action, recs, params, url) {
                ExtBatchOperate(action, recs, params, url, onExecuted)
            }

            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }
            function reloadPage(args) {
                // 重新加载页面
                typeId = args ? args.cid : typeId;
                store.reload();
            }

            function ReSubmitNews(obj) {
                SubmitState(0, obj);
            }
            function SubmitNews(obj) {
                SubmitState(1, obj);
            }
            function SubmitState(val, obj) {
                if (!confirm("确定" + obj.text + "?"))
                    return;

                var smask = new Ext.LoadMask(document.body, { msg: "处理中..." });
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    AimDlg.show("请先选择要" + obj.text + "的记录！");
                }
                else {
                    if (val == recs[0].data.State) {
                        alert("该信息不需要" + obj.text);
                        return;
                    }
                    smask.show();
                    $.ajaxExec('submitnews', { Id: recs[0].data.Id, state: val, NewsType: recs[0].data.NewsType }, function(args) {
                        AimDlg.show(args.data.message);
                        onExecuted();
                        smask.hide();
                    });
                }
            }
    </script>

</asp:Content>
<asp:Content ID="BodyHolder" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
