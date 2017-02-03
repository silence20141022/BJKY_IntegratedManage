<%@ Page Title="��Ϣ" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master"
    AutoEventWireup="true" CodeBehind="SysMessageEdit.aspx.cs" Inherits="Aim.Portal.Web.Office.SysMessageEdit" %>

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
        }

        function setPgUI() {
            if (op == 'c' || op == 'cs') {
                if (AimState['ReceiverInfo']) {
                    Ext.getCmp("ReceiverNameusersel").setValueEx($.getJsonObj(AimState['ReceiverInfo']));
                    //$('#ReceiverId').val(AimState['ReceiverInfo'].UserID);
                    //$('#ReceiverName').val(AimState['ReceiverInfo'].Name);
                }

                $('#Title').val(AimState['Title'] || '');
            }

            if (recdisable && (recdisable == '1' || recdisable == 'true')) {
                AimCtrl['ReceiverName'].setDisabled(true);
            }

            if (titledisable && (titledisable == '1' || titledisable == 'true')) {
                $('#Title').attr('disabled', true);
            }


            //�󶨰�ť��֤
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
            $("#btnSave").click(function() {
                AimFrm.submit(pgAction, {}, null, SubFinish);
            });
        }

        //��֤�ɹ�ִ�б��淽��
        function SuccessSubmit() {
            if ($("#ReceiverName").val() == "") {
                alert("������д�����˲�������"); return;
            }
            AimFrm.submit(pgAction, { issend: "T" }, null, SubFinish);
        }

        function SubFinish(args) {
            window.returnValue = args;
            window.close();
            window.opener.location.reload();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            ϵͳ��Ϣ</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit" border="0">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ����
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="Title" name="Title" class="validate[required] text-input" style="width: 90%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ������
                    </td>
                    <td class="aim-ui-td-data">
                        <input aimctrl='user' seltype='multi' required="true" id="ReceiverName" name="ReceiverName"
                            relateid="ReceiverId" style="width: 480px" />
                        <input type="hidden" id="ReceiverId" name="ReceiverId" style="width: 100%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ����
                    </td>
                    <td class="aim-ui-td-data">
                        <textarea id="MessageContent" name="MessageContent" style="width: 90%; height: 200px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ��ظ���
                    </td>
                    <td class="aim-ui-td-data" valign="top">
                        <input id="Attachment" name="Attachment" aimctrl='file' value="" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="2">
                        <a id="btnSave" class="aim-ui-button save">�ݴ�</a> <a id="btnSubmit" class="aim-ui-button submit">
                            ����</a> <a id="btnCancel" class="aim-ui-button cancel">ȡ��</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
