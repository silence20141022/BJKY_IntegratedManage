<%@ Page Title="工作日志" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="WorkTimeFactEdit.aspx.cs" Inherits="Aim.AM.Web.WorkTimeFactEdit" %>

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

        var curDate = $.getQueryString({ ID: "EditDate" });
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
                $("#CurrentDate").val(curDate);
                if (AimState.TaskModel) {
                    $("#TaskId").val($.getQueryString({ "ID": "TaskId" }));
                    $("#TaskCode").val(AimState.TaskModel.Code);
                    $("#TaskName").val(AimState.TaskModel.TaskName);
                }
            }

            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            工作日志</h1>
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
                        关联任务名称
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' id="TaskName" name="TaskName" popurl="/Aim/Task/TaskSel.aspx"
                            popparam="TaskId:Id;TaskName:TaskName;TaskCode,Code" popstyle="width=800,height=600"
                            style="width: 95%" />
                        <input type="hidden" id="TaskId" name="TaskId" />
                        <input type="hidden" id="TaskCode" name="TaskCode" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        工时(小时)
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="Total" name="Total" class="validate[required,custom[onlyNumber]]" style="width: 100px" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 20%">
                        填报日期:
                    </td>
                    <td class="aim-ui-td-data" id="BalanceTD">
                        <input aimctrl='date' required="true" class="validate[required]" id="CurrentDate"
                            name="CurrentDate" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        工作内容
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="Remark" name="Remark" style="width: 95%; height: 250px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        工作成果
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input type="hidden" id="PrjName" name="PrjName" aimctrl='file' value="" style="width: 95%;
                            height: 100px" />
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
