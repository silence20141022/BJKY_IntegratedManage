<%@ Page Title="日志" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="A_ChargeProgresEdit.aspx.cs" Inherits="Aim.AM.Web.A_ChargeProgresEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
        .aim-ui-td-caption
        {
            text-align: right;
        }
    </style>

    <script type="text/javascript">

        function onPgLoad() {
            new Ext.Slider({
                renderTo: 'BalanceTD',
                id: 'sldBlanace',
                width: 400,
                minValue: 0,
                maxValue: 100,
                hideLabel: false,
                plugins: new Ext.slider.Tip(),
                listeners: { change: function(obj, newValue, oldValue) { $("#Progress").val(newValue); } }
            });
            setPgUI();
        }
        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
                $("#TaskId").val($.getQueryString({ "ID": "TaskId" }));
                $("#TaskCode").val(AimState.TaskModel.Code);
                $("#TaskName").val(AimState.TaskModel.TaskName);
                Ext.getCmp("sldBlanace").setValue(AimState.TaskModel.TaskProgress);
            }
            else {
                Ext.getCmp("sldBlanace").setValue($("#Progress").val());
            }

            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            //if (Ext.getCmp("sldBlanace").getValue() == 100) {
            //if (!confirm("确定要设置任务为已完成吗?")) return;
            //}
            jQuery.ajaxExec('charge', { "TaskId": $.getQueryString({ "ID": "TaskId" }) }, function(rtn) {
                if (rtn.data.Finish == "false" && $("#Progress").val() == "100") {
                    alert("子任务没有完成,不允许评定为100%!");
                    return;
                }
                AimFrm.submit(pgAction, {}, null, SubFinish);
            });
        }

        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            任务评定</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td colspan="4">
                        <input id="Id" name="Id" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 100px">
                        评定内容
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="Title" name="Title" class="validate[required]" style="width: 95%; height: 210px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        相关附件
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input type="hidden" id="Attachment" name="Attachment" aimctrl='file' value="" style="width: 90%;
                            height: 40px" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        关联目标任务
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="TaskName" name="TaskName" disabled="disabled" class="validate[required]"
                            popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx" popparam="TaskId:GroupID;TaskName:Name"
                            popstyle="width=700,height=500" style="width: 95%" />
                        <input type="hidden" id="TaskId" name="TaskId" />
                        <input type="hidden" id="TaskCode" name="TaskCode" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <table class="aim-ui-table-edit">
                            <tr>
                                <td class="aim-ui-td-caption">
                                    进度
                                </td>
                                <td class="aim-ui-td-data" id="BalanceTD" colspan="2">
                                </td>
                                <td>
                                    已完成:<input id="Progress" name="Progress" style="width: 20px; border: 0px!important;
                                        background: transparent;" readonly value="0" />%
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr width="100%">
                    <td class="aim-ui-td-caption">
                        评定人
                    </td>
                    <td class="aim-ui-td-data">
                        <input disabled id="CreateName" name="CreateName" />
                    </td>
                    <td class="aim-ui-td-caption">
                        评定日期
                    </td>
                    <td class="aim-ui-td-data">
                        <input aimctrl="date" id="CreateTime" name="CreateTime" dateonly="true" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button submit">提交</a> <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
