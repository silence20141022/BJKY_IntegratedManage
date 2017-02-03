
<%@ Page Title="附件库" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master" AutoEventWireup="true" CodeBehind="A_TaskAttachmentEdit.aspx.cs" Inherits="Aim.AM.Web.A_TaskAttachmentEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
                $("#TaskId").val($.getQueryString({ "ID": "TaskId" }));
                $("#TaskCode").val(AimState.TaskModel.TaskCode);
                $("#TaskName").val(AimState.TaskModel.TaskName);
            }

            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, { TaskId: $.getQueryString({ "ID": "TaskId" }) }, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            附件信息</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        标题
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Title" name="Title" class="validate[required]" style="width: 95%" />
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
                    <td class="aim-ui-td-caption">
                        相关附件
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input type="hidden" id="Attachment" name="Attachment" aimctrl='file' value="" style="width: 90%;
                            height: 40px" />
                    </td>
                </tr>
                <tr width="100%">
                    <td class="aim-ui-td-caption">
                        上传人
                    </td>
                    <td class="aim-ui-td-data">
                        <input disabled id="CreateName" name="CreateName" />
                    </td>
                    <td class="aim-ui-td-caption">
                        上传日期
                    </td>
                    <td class="aim-ui-td-data">
                        <input disabled id="CreateTime" name="CreateTime" dateonly="true" />
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
