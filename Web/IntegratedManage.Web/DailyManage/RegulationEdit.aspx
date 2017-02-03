<%@ Page Title="规章制度" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="RegulationEdit.aspx.cs" Inherits="IntegratedManage.Web.RegulationEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
            width: 15%;
        }

        .aim-ui-td-data
        {
            width: 35%;
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

        input
        {
            border: 1px solid #B5B8C8;
            font-size: 14px;
            /*background: #FFF url('/img/form/text-bg.gif') repeat-x;*/
        }

        textarea
        {
            width: 90%;
        }

        select
        {
            width: 90%;
        }

        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }

        .x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
    </style>

    <script type="text/javascript">
        var pgCaption = { "c": "添加规章制度", "u": "修改规章制度", "r": "查看规章制度信息" };

        var pid = $.getQueryString({ ID: 'pid' });
        var pname = $.getQueryString({ ID: 'pname' });
        var ptype = $.getQueryString({ ID: 'ptype' });
        var type = $.getQueryString({ ID: 'type' });
        var id = $.getQueryString({ ID: 'id' });
        var deptData, deptStore, deptGrid, tlBar1;
        var userData, userStore, userGrid, tlBar2;
        function onPgLoad() {
            renderGrid();
            setPgUI();
            $("input[name='AuthType']").click(function () {
                if ($(this).val() == "specify" && $(this).attr("checked")) {
                    $("#grids").show();
                    if (AimState["DeptList"] && AimState["DeptList"].length > 0) {
                        deptStore.loadData({ records: AimState["DeptList"] || [] });
                    }
                    if (AimState["UserList"] && AimState["UserList"].length > 0) {
                        userStore.loadData({ records: AimState["UserList"] || [] });

                    }
                    deptGrid.show();
                    userGrid.show();
                } else {
                    $("#grids").hide();
                    deptStore.removeAll();
                    userStore.removeAll();
                }
            });


        }
        function setPgUI() {
            if (type == "r") $("#header h1:only-child").hide();  //tooltip
            $("#header h1:only-child").text(pgCaption[pgOperation] || "规章制度信息");
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
                $("#all").attr("checked", true);
                if (pid) {
                    $("#DeptId").val(pid);
                    $("#DeptName").val(pname);
                }
            }
            else {
                if (AimState["frmdata"] && AimState["frmdata"].AuthType) {
                    $("#" + AimState["frmdata"].AuthType).attr("checked", true);
                }
                if ($("#specify").attr("checked")) {
                    $("#grids").show();
                    deptGrid.show();
                    userGrid.show();
                }
            }
            if (pgOperation == 'r') {
                $("#Files").closest("td").next().hide();
            }

            if (ptype == "tip") {
                //$("#header").hide();
                $("#btnSubmit").closest("tr").hide();
                $("#tip_2,#tip_1").show();
                $("#authset").hide();
            }

            FormValidationBind('btnSave', SuccessSave);
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function () {
                window.close();
            });


        }

        //验证成功执行保存方法
        function SuccessSave() {
            var authType = $(":checked").val() || null;
            if (authType == "specify") {
                var deptRecs = deptStore.getRange();
                var deptDt = deptStore.getModifiedDataStringArr(deptRecs);
                var userRecs = userStore.getRange();
                var userDt = userStore.getModifiedDataStringArr(userRecs);
                AimFrm.submit(pgAction, { IsRelease: '未发布', AuthType: authType, DeptData: deptDt, UserData: userDt }, null, SubFinish);
            } else {
                AimFrm.submit(pgAction, { IsRelease: '未发布', AuthType: authType }, null, SubFinish);
            }
        }

        //验证成功执行发布方法
        function SuccessSubmit() {
            var authType = $(":checked").val() || null;
            if (authType == "specify") {
                var deptRecs = deptStore.getRange();
                var deptDt = deptStore.getModifiedDataStringArr(deptRecs);
                var userRecs = userStore.getRange();
                var userDt = userStore.getModifiedDataStringArr(userRecs);
                AimFrm.submit(pgAction, { IsRelease: '已发布', AuthType: authType, DeptData: deptDt, UserData: userDt }, null, SubFinish);
            } else {
                AimFrm.submit(pgAction, { IsRelease: '已发布', AuthType: authType }, null, SubFinish);
            }
        }

        function SubFinish(args) {
            RefreshClose();
        }

        function renderGrid() {
            deptData = {
                records: AimState["DeptList"] || []
            };
            deptStore = new Ext.ux.data.AimJsonStore({
                dsname: 'DeptList',
                idProperty: 'Id',
                data: deptData,
                fields: [
                    { name: 'Id' },
                    { name: "DeptId" },
                    { name: 'DeptName' }
                ]
            });
            tlBar1 = new Ext.ux.AimToolbar({
                items: [
                    '<span style="font-size:13px;color:red;">指定部门</span>', '-',
                    {
                        text: '选择部门',
                        iconCls: 'aim-icon-add',
                        handler: function () {
                            DeptSelect();
                        }
                    },
                    {
                        text: '移除部门',
                        iconCls: 'aim-icon-delete',
                        handler: function () {
                            var recs = deptGrid.getSelectionModel().getSelections();
                            deptStore.remove(recs);
                        }
                    }
                ]
            });

            // 表格面板
            deptGrid = new Ext.ux.grid.AimGridPanel({
                store: deptStore,
                renderTo: 'deptgrid',
                //autoExpandColumn: 'Name',
                columnLines: true,
                hidden: true,
                height: 200,
                viewConfig: { forceFit: true },
                columns: [
                   { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                   { id: 'DeptId', dataIndex: 'DeptId', header: '部门编号', hidden: true, width: 40, sortable: true },
                   { id: 'DeptName', dataIndex: 'DeptName', header: '部门名称', width: 150, sortable: true }

                ],
                tbar: tlBar1
            });

            userData = {
                records: AimState["UserList"] || []
            };
            userStore = new Ext.ux.data.AimJsonStore({
                dsname: 'UserList',
                idProperty: 'Id',
                data: userData,
                fields: [
                    { name: 'Id' },
                    { name: "UserId" },
                    { name: 'UserName' }
                ]
            });
            tlBar2 = new Ext.ux.AimToolbar({
                items: [
                    '<span style="font-size:13px;color:red;">指定人员</span>', '-',
                    {
                        text: '选择人员',
                        iconCls: 'aim-icon-add',
                        handler: function () {
                            UserSelect();
                        }
                    },
                    {
                        text: '移除人员',
                        iconCls: 'aim-icon-delete',
                        handler: function () {
                            var recs = userGrid.getSelectionModel().getSelections();
                            userStore.remove(recs);
                        }
                    }
                ]
            });

            // 表格面板
            userGrid = new Ext.ux.grid.AimGridPanel({
                store: userStore,
                renderTo: 'usergrid',
                //autoExpandColumn: 'Name',
                columnLines: true,
                hidden: true,
                height: 200,
                viewConfig: { forceFit: true },
                columns: [
                   { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                   { id: 'UserId', dataIndex: 'UserId', header: '人员Id', hidden: true, width: 40, sortable: true },
                   { id: 'UserName', dataIndex: 'UserName', header: '人员名称', width: 150, sortable: true }

                ],
                tbar: tlBar2
            });
        }

        function UserSelect() {
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function () {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                //var gird = Ext.getCmp(val);
                var EntRecord = userStore.recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (userStore.find("UserId", this.data[i].Id) != -1) continue; //筛选已经存在的人
                    var rec = new EntRecord({ UserId: this.data[i].UserID, UserName: this.data[i].Name });
                    userStore.insert(userStore.data.length, rec);
                }
            })

        }
        function DeptSelect() {
            var style = "dialogWidth:400px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/GrpSelect/MGrpSelect.aspx?seltype=multi&cid=2";
            OpenModelWin(url, {}, style, function () {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                //var gird = Ext.getCmp(val);
                var EntRecord = deptStore.recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (deptStore.find("DeptId", this.data[i].Id) != -1) continue; //筛选已经存在的部门
                    var rec = new EntRecord({ DeptId: this.data[i].GroupID, DeptName: this.data[i].Name });
                    deptStore.insert(deptStore.data.length, rec);
                }
            })

        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>标题</h1>
    </div>
    <div id="editDiv" align="center">
        <fieldset>
            <legend>基本信息
            </legend>
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr style="display: none">
                        <td>
                            <input id="Id" name="Id" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">主题
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <input id="Name" name="Name" class="validate[required]" style="width: 96%;" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">编号
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="Code" name="Code" style="width: 90%;" />
                        </td>
                        <td class="aim-ui-td-caption">关键字
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="KeyWord" name="KeyWord" style="width: 90%;"></input>
                        </td>
                    </tr>
                    <tr>

                        <td class="aim-ui-td-caption">摘要
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <textarea id="Summary" name="Summary" rows="3" style="width: 96%;"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">所属部门
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <input type="hidden" id="DeptId" name="DeptId" />
                            <input aimctrl='popup' readonly id="DeptName" name="DeptName" class="validate[required]"
                                popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx?seltype=multi&cid=2" popparam="DeptId:GroupID;DeptName:Name"
                                popstyle="width=600,height=450" style="width: 90%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">附件
                        </td>
                        <td colspan="3">
                            <input type="hidden" style="width: 98%" id="Files" name="Files" aimctrl='file' 
                                value="" />
                        </td>
                    </tr>
                    <tr id='tip_1' width="100%" style="display: none;">
                        <td class="aim-ui-td-caption">创建人
                        </td>
                        <td class="aim-ui-td-data">
                            <input disabled id="CreateName" name="CreateName" />
                        </td>
                        <td class="aim-ui-td-caption">创建时间
                        </td>
                        <td class="aim-ui-td-data">
                            <input disabled id="CreateTime" name="CreateTime" />
                        </td>
                    </tr>
                    <tr id='tip_2' width="100%" style="display: none;">
                        <td class="aim-ui-td-caption">更新人
                        </td>
                        <td class="aim-ui-td-data">
                            <input disabled id="LastModifyName" name="LastModifyName" />
                        </td>
                        <td class="aim-ui-td-caption">更新时间
                        </td>
                        <td class="aim-ui-td-data">
                            <input disabled id="LastModifyTime" name="LastModifyTime" />
                        </td>
                    </tr>

                </tbody>
            </table>
        </fieldset>
        <fieldset id="authset">
            <legend>浏览权限设置
            </legend>
            <table style="table-layout: fixed;">
                <tr>
                    <td class="aim-ui-td-data" colspan="4" style="text-align: center; font-size: 14px;">
                        <label>
                            <input type="radio" id="all" name="AuthType" value="all" />全院</label>
                        <label>
                            <input type="radio" id="dept" name="AuthType" value="dept" />本部门</label>
                        <label>
                            <input type="radio" id="specify" name="AuthType" value="specify" />指定部门和人员</label>
                    </td>
                </tr>
                <tr id="grids">
                    <td colspan="2">
                        <div id="deptgrid"></div>
                    </td>
                    <td colspan="2">
                        <div id="usergrid"></div>
                    </td>
                </tr>
            </table>

        </fieldset>
        <table>
            <tr>
                <td class="aim-ui-button-panel" colspan="4" style="border-top: none;">
                    <a id="btnSave" class="aim-ui-button submit">暂存</a> <a id="btnSubmit" class="aim-ui-button submit">发布</a> <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                </td>
            </tr>
        </table>

    </div>
</asp:Content>
