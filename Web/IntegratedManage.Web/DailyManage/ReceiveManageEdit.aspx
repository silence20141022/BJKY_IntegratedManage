<%@ Page Title="接待管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ReceiveManageEdit.aspx.cs" Inherits="IntegratedManage.Web.ReceiveManageEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
        td
        {
            font-size: 12;
        }
        .aim-ui-td-caption
        {
            text-align: right;
        }
    </style>

    <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script type="text/javascript">

        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
            }

            //            var pgCaption = { "c": "添加接待", "u": "修改接待", "r": "查看接待" };
            //            $("#header h1:only-child").text(pgCaption[pgOperation] || "查看接待");

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
            接待维护</h1>
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
                        来访客户
                    </td>
                    <td class="aim-ui-td-data" colspan='3'>
                        <input id="CustomerName" name="CustomerName" class="validate[required]" style="width: 95%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接待人
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Receptionist" name="Receptionist" relateid="ReceptionistId" class="validate[required]"
                            style="width: 547" />
                        <input type="hidden" id="ReceptionistId" name="ReceptionistId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        来访时间
                    </td>
                    <td class="aim-ui-td-data" style="width: 25%">
                        <input id="ComInTime" name="ComInTime" readonly="readonly" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy/MM/dd'})" />
                    </td>
                    <td class="aim-ui-td-caption">
                        结束时间
                    </td>
                    <td class="aim-ui-td-data" style="width: 25%">
                        <input id="LeaveoutTime" name="LeaveoutTime" class="Wdate" readonly="readonly" onclick="var date=$('#ComInTime').val()?$('#ComInTime').val():new Date(); WdatePicker({minDate:date,dateFmt:'yyyy/MM/dd'})"
                            style="width: 178" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接待内容
                    </td>
                    <td class="aim-ui-td-data" colspan="4">
                        <textarea rows="7" style="width: 95%" class="validate[required]" id="ReceiveThing"
                            name="ReceiveThing"> </textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接待反馈结果
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea name="FeedBackResult" id="FeedBackResult" rows="3" style="width: 95%"></textarea>
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
