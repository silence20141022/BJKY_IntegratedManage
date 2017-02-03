<%@ Page Title="基础配置" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="IntegratedConfigEdit.aspx.cs" Inherits="IntegratedManage.Web.IntegratedConfigEdit" %>

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
    </style>

    <script type="text/javascript">
        var ValidEnum = { 否: '否', 是: '是' };
        var store;
        function onPgLoad() {
            setPgUI();
            InitialGrid();
        }
        function setPgUI() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSubmit").show();
        }
        //验证成功执行保存方法
        function SuccessSubmit() {
            if ($("#Id").val()) {
                AimFrm.submit("update", { UserBalanceValid: $("#UserBalanceValid").val() }, null, function() { document.location.reload(); });
            }
            else {
                AimFrm.submit("create", { UserBalanceValid: $("#UserBalanceValid").val() }, null, function() { document.location.reload(); });
            }
        }
        function InitialGrid() {
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            var tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        UserSelect();
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
                        var instituteLeaderIds = [];
                        $.each(recs, function() {
                            instituteLeaderIds.push(this.get("Id"));
                        })
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { InstituteLeaderIds: instituteLeaderIds }, function(rtn) {
                                store.remove(recs);
                            });
                        }
                    }
}]
                });
                store = new Ext.ux.data.AimJsonStore({
                    dsname: 'DataList',
                    idProperty: 'Id',
                    data: myData,
                    fields: [
			        { name: 'Id' }, { name: 'UserId' }, { name: 'UserName' }, { name: 'DeptId' }, { name: 'DeptName' },
			        { name: 'Email' }, { name: 'Phone' }, { name: 'SortIndex'}],
                    listeners: { aimbeforeload: function(proxy, options) {
                        options.data = options.data || {};
                    }
                    }
                });
                var grid = new Ext.ux.grid.AimEditorGridPanel({
                    title: '领导外出人员维护',
                    store: store,
                    autoHeight: true,
                    renderTo: 'div1',
                    autoExpandColumn: 'DeptName',
                    tbar: tlBar,
                    columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    { id: 'UserId', dataIndex: 'UserId', header: '标识', hidden: true },
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 100 },
                    { id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 120 },
                    { id: 'Phone', dataIndex: 'Phone', header: '<label style="color:red">电话</label>', width: 120, editor: { xtype: 'textfield', allowBlank: false} },
                    { id: 'Email', dataIndex: 'Email', header: '<label style="color:red">EMail</label>', width: 180, editor: { xtype: 'textfield', allowBlank: false} },
				    { id: 'SortIndex', dataIndex: 'SortIndex', header: '<label style="color:red">序号</label>', width: 80,
				        editor: { xtype: 'numberfield', allowBlank: false, decimalPercission: 0, minValue: 0 }
}],
                    listeners: { afteredit: function(e) {
                        if (e.value) {
                            switch (e.field) {
                                case "SortIndex":
                                    $.ajaxExec("UpdateSortIndex", { InstituteLeaderId: e.record.get("Id"), SortIndex: e.value }, function() { store.reload(); })
                                    break;
                                default:
                                    $.ajaxExec("UpdateUser", { UserId: e.record.get("UserId"), Email: e.record.get("Email"), Phone: e.record.get("Phone") },
                                function() { e.record.commit(); })
                                    break;
                            }
                        }
                    }
                    }

                });
                window.onresize = function() {
                    grid.setWidth(0); grid.setWidth(Ext.get("div1").getWidth());
                }
            }
            function UserSelect() {
                var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
                var url = "/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
                OpenModelWin(url, {}, style, function() {
                    if (this.data == null || this.data.length == 0 || !this.data.length) return;
                    var userIds = [];
                    for (var i = 0; i < this.data.length; i++) {
                        if (store.find("UserId", this.data[i].UserID) != -1) continue; //筛选已经存在的人
                        userIds.push(this.data[i].UserID);
                    }
                    var recType = store.recordType;
                    $.ajaxExec("AddLeader", { UserIds: userIds }, function(rtn) {
                        if (rtn.data.ilEnts) {
                            $.each(rtn.data.ilEnts, function() {
                                var rec = new recType(this);
                                store.insert(store.data.length, rec);
                            })
                        }
                    })
                })
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            综合管理参数配置</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    院办主任
                </td>
                <td>
                    <input id="YuanBanZhuRenName" name="YuanBanZhuRenName" class="validate[required]"
                        style="width: 300px" aimctrl='user' relateid="YuanBanZhuRenId" seltype="multi" />
                    <input id="YuanBanZhuRenId" name="YuanBanZhuRenId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    院办文书
                </td>
                <td>
                    <input id="YuanBanWenShuName" name="YuanBanWenShuName" aimctrl="user" relateid="YuanBanWenShuId"
                        style="width: 300px" />
                    <input id="YuanBanWenShuId" name="YuanBanWenShuId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    发文主管院长
                </td>
                <td>
                    <input id="YuanZhangName" name="YuanZhangName" aimctrl="user" relateid="YuanZhangId"
                        style="width: 300px" />
                    <input id="YuanZhangId" name="YuanZhangId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    视频维护人
                </td>
                <td>
                    <input id="VedioMaintenanceName" name="VedioMaintenanceName" aimctrl="user" seltype="multi"
                        relateid="VedioMaintenanceId" style="width: 300px" />
                    <input id="VedioMaintenanceId" name="VedioMaintenanceId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    打字员
                </td>
                <td>
                    <input id="TypistName" name="TypistName" aimctrl="user" relateid="TypistId" style="width: 300px" />
                    <input id="TypistId" name="TypistId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    院办盖章人
                </td>
                <td>
                    <input id="SealName" name="SealName" aimctrl="user" relateid="SealId" style="width: 300px" />
                    <input id="SealId" name="SealId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    通讯录维护人
                </td>
                <td>
                    <input id="AddressListMaintenanceName" name="AddressListMaintenanceName" aimctrl="user"
                        style="width: 300px" seltype="multi" relateid="AddressListMaintenanceId" />
                    <input id="AddressListMaintenanceId" name="AddressListMaintenanceId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    院长
                </td>
                <td>
                    <input id="FirstYuanZhangName" name="FirstYuanZhangName" aimctrl="user" style="width: 300px"
                        relateid="FirstYuanZhangId" />
                    <input id="FirstYuanZhangId" name="FirstYuanZhangId" type="hidden" />
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <div id="div1">
        </div>
    </fieldset>
    <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-button-panel">
                    <a id="btnSubmit" class="aim-ui-button submit">保存</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
