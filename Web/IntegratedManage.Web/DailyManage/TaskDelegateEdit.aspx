<%@ Page Title="任务委托" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="TaskDelegateEdit.aspx.cs" Inherits="IntegratedManage.Web.TaskDelegateEdit" %>

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
            background: #FFF url('/img/form/text-bg.gif') repeat-x;
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
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        function SuccessSubmit() {
            AimFrm.submit(pgAction, null, null, SubFinish);
        }
        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            任务委托</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tr style="display: none">
                <td>
                    <input id="Id" name="Id" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    原执行人
                </td>
                <td class="aim-ui-td-data">
                    <input id="CreateName" name="CreateName" aimctrl="user" relateid="CreateId" />
                    <input id="CreateId" name="CreateId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    委托人
                </td>
                <td class="aim-ui-td-data">
                    <input id="DelegateUserName" name="DelegateUserName" aimctrl="user" relateid="DelegateUserId"
                        class="validate[required]" />
                    <input id="DelegateUserId" name="DelegateUserId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    开始时间
                </td>
                <td class="aim-ui-td-data">
                    <input id="StartTime" name="StartTime" aimctrl="date" />
                </td>
                <td class="aim-ui-td-caption">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    委托原因
                </td>
                <td colspan="3">
                    <textarea style="width: 97%" id="Remark" name="Remark"></textarea>
                </td>
            </tr>
        </table>
    </div>
    <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">保存</a>&nbsp;&nbsp; <a id="btnCancel"
                        class="aim-ui-button cancel">取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
