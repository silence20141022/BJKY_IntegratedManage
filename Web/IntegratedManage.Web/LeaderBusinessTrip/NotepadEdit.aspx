<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="NotepadEdit.aspx.cs" Inherits="IntegratedManage.Web.NotepadEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
    <script type="text/javascript">
        var start = $.getQueryString({ ID: 'Start' });
        var end = $.getQueryString({ ID: 'End' });
        var type = $.getQueryString({ ID: 'type' });
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {

            start && $("#StartTime").val(start);
            end && $("#EndTime").val(end);
            $("#Id").val() && $("#delete").show();

            if (pgOperation == "c" || pgOperation == "u") {
                $("#delete").hide();
                if (type != "calar") {
                    $("#StartTime").addClass("Wdate");
                    $("#EndTime").addClass("Wdate");

                    $("#StartTime").click(function () {
                        var date = $('#EndTime').val() ? $('#EndTime').val() : '';
                        WdatePicker({ maxDate: date, minDate: '%y-%M-%d', dateFmt: 'yyyy/MM/dd HH:mm:ss' });
                    });
                    $("#EndTime").click(function () {
                        var date = $('#StartTime').val() ? $('#StartTime').val() : new Date();
                        WdatePicker({ minDate: date, dateFmt: 'yyyy/MM/dd HH:mm:ss' });
                    });
                }
            }

            // class="Wdate" onfocus="var date=$('#EndTime').val()?$('#EndTime').val():'';                          
            //WdatePicker({maxDate:date,minDate:'%y-%M-%d'})"

            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function () {
                window.close();
            });

            $("#delete").click(function () {  //删除
                if (confirm("确定要删除吗?")) {
                    AimFrm.submit("delete", { id: $("#Id").val() }, null, function () {
                        window.returnValue = "refurbish";
                        RefreshClose();
                    });
                }
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }

        function SubFinish(args) {

            window.returnValue = args.data.Id;
            RefreshClose();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            个人日历</h1>
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
                    <td class="aim-ui-td-caption" style="width: 15%">
                        开始时间
                    </td>
                    <td class="aim-ui-td-data">
                        <input name="StartTime" id="StartTime" readonly="readonly" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        结束时间
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="EndTime" name="EndTime" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        内容
                    </td>
                    <td class="aim-ui-td-data" colspan="4">
                        <textarea name="Theme" id="Theme" rows="12" style="width: 100%;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button">保存</a>&nbsp; &nbsp;<a id="delete" style="display: none"
                            class="aim-ui-button cancel">删除</a> &nbsp;<a id="btnCancel" class="aim-ui-button cancel">
                                取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
