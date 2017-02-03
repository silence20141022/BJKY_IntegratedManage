<%@ Page Title="消息查看" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master"
    AutoEventWireup="true" CodeBehind="SysMessageView.aspx.cs" Inherits="Aim.Portal.Web.Office.SysMessageView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <style>
        .x-superboxselect UL
        {
            height: auto;
            overflow: hidden;
            cursor: text;
        }
    </style>

    <script type="text/javascript">

        var op, recdisable, titledisable;

        function onPgLoad() {
            op = $.getQueryString({ 'ID': 'op' });
            recdisable = $.getQueryString({ 'ID': 'recdisable', 'DefaultValue': false });
            titledisable = $.getQueryString({ 'ID': 'titledisable', 'DefaultValue': false });

            setPgUI();
            document.getElementById("Label_body").innerHTML = AimState["frmdata"].MessageContent;
        }

        function setPgUI() {
            if (op == 'c' || op == 'cs') {
                if (AimState['ReceiverInfo']) {
                    $('#ReceiverId').val(AimState['ReceiverInfo'].UserID);
                    $('#ReceiverName').val(AimState['ReceiverInfo'].Name);
                }

                $('#Title').val(AimState['Title'] || '');
            }

            if (recdisable && (recdisable == '1' || recdisable == 'true')) {
                AimCtrl['ReceiverName'].setDisabled(true);
            }

            if (titledisable && (titledisable == '1' || titledisable == 'true')) {
                $('#Title').attr('disabled', true);
            }


            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
            $("#btnSave").click(function() {
                openEditWin("SysMessageEdit.aspx?op=c&recid=" + AimState["frmdata"].Id);
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, { isdelete: "T" }, null, SubFinish);
        }

        function SubFinish(args) {
            window.returnValue = args;
            window.close();
            window.opener.location.reload();
        }

        // 打开模态窗口
        function openEditWin(url, op, style) {
            op = op || "r";
            style = style || CenterWin("width=650,height=450,scrollbars=yes");


            var params = [];
            url = jQuery.combineQueryUrl(url, params)
            rtn = OpenWin(url, "_blank", style);
            if (rtn && rtn.result) {
                if (rtn.result === 'success') {
                }
            }
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="editDiv" align="center" style="background-image: url(back.jpg);">
        <table id="AutoNumber1" style="border-collapse: collapse;" bordercolor="#111111"
            cellspacing="0" cellpadding="0" width="450" border="1">
            <tr>
                <td valign="top" height="250">
                    <div align="center">
                        <center>
                            <table id="AutoNumber2" style="border-collapse: collapse" bordercolor="#111111" height="244"
                                cellspacing="0" cellpadding="0" width="427" border="0">
                                <tr>
                                    <td valign="top" background="/portal/image/new_back21.jpg" height="112">
                                        <table width="450" border="0" cellpadding="0" cellspacing='0'>
                                            <tr>
                                                <td valign="bottom" height="41">
                                                    <div align="center">
                                                        <table width="96%" border="0">
                                                            <tr>
                                                                <td width="14%">
                                                                    <div align="center">
                                                                        <img src="message.png" width="60" height="60"></div>
                                                                </td>
                                                                <td width="86%" align="center" valign="bottom">
                                                                    <font color="#333333">
                                                                        <input id="Title" name="Title" style="width: 90%; background-color: Transparent;
                                                                            border: none; font-size: 14px; font-weight: bold;" />
                                                                    </font>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <hr align="center" width="96%" noshade size="1">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <table width="96%" border="0">
                                                            <tr>
                                                                <td>
                                                                    <font size="2">发 送 者:&nbsp; &nbsp; <span id="Sender" style="width: 80%;">
                                                                        <input id="SenderName" name="SenderName" style="width: 90%" style="width: 90%; background-color: Transparent;
                                                                            border: none; font-size: 12px;" /></span></font>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <font size="2">发送时间:&nbsp; &nbsp; <span id="Label_time" style="width: 80%;">
                                                                        <input id="SendTime" name="SendTime" style="width: 90%; background-color: Transparent;
                                                                            border: none; font-size: 12px;" style="width: 90%" />
                                                                    </span></font>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <hr align="center" width="96%" noshade size="1">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="303" valign="top">
                                                    <div align="center">
                                                        <table style="table-layout: fixed;" width="396px" border="0">
                                                            <tr>
                                                                <td width="420px" id="Label_body" font-size="12" style="word-wrap: break-word;">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <hr align="center" width="96%" noshade size="1">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <table width="96%" border="0">
                                                            <tr>
                                                                <td width="12%">
                                                                    <div align="left">
                                                                        <font size="2">附件：</font></div>
                                                                </td>
                                                                <td width="77%" id="FileId" class="aim-ui-td-data">
                                                                    <input id="Attachment" name="Attachment" aimctrl='file' value="" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="aim-ui-button-panel">
                                                    <p align="center">
                                                        <a id="btnSave" class="aim-ui-button replay">回复</a> <a id="btnSubmit" class="aim-ui-button del">
                                                            删除</a> <a id="btnCancel" class="aim-ui-button cancel">关闭</a>
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <table width="96%" border="0">
                                                            <tr>
                                                                <td width="12%">
                                                                    <div align="left">
                                                                        <font size="4"><b>回复情况</b></font></div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <%=ReplyHTML%>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td background="/portal/image/new_back31.jpg" height="21">
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
