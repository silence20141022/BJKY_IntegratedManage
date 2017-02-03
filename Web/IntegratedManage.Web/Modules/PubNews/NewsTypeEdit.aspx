<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="NewsTypeEdit.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.NewsTypeEdit"
    Title="��Ŀ����ά��" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
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
        var StatusEnum = { '1': '��Ч', '0': '��Ч' };

        var EnumBlock = { protal: "�Ż�" };

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            //�󶨰�ť��֤
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
        }

        //��֤�ɹ�ִ�б��淽��
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
            ά����¼</h1>
    </div>
    <table class="aim-ui-table-edit">
        <tbody>
            <tr style="display: none">
                <td>
                    <input type="hidden" id="Id" name="Id" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    ��Ŀ����
                </td>
                <td class="aim-ui-td-data">
                    <input id="TypeName" name="TypeName" class="validate[required]" style="width: 100%" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    �Ƿ���Ч
                </td>
                <td class="aim-ui-td-data">
                    <select id="IsEfficient" name="IsEfficient" aimctrl='select' enum="StatusEnum" class="validate[required]"
                        style="width: 160px;">
                    </select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    ���ղ���
                </td>
                <td class="aim-ui-td-data">
                    <input aimctrl='popup' readonly id="BelongDeptName" name="BelongDeptName" relateid="BelongDeptId"
                        popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx" popparam="BelongDeptName:Name;BelongDeptId:GroupID"
                        popstyle="width=700,height=500" style="width: 90%" />
                    <input id="BelongDeptId" type="hidden" name="BelongDeptId" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    �����û�
                </td>
                <td class="aim-ui-td-data">
                    <input aimctrl='popup' readonly id="AllowQueryName" name="AllowQueryName" relateid="ReceiverId"
                        popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="AllowQueryId:UserID;AllowQueryName:Name"
                        popstyle="width=700,height=500" style="width: 90%" />
                    <input type="hidden" id="AllowQueryId" name="AllowQueryId" />
                </td>
            </tr>
            <tr style='display: none;'>
                <td class="aim-ui-td-caption">
                    ��������û�
                </td>
                <td class="aim-ui-td-data">
                    <input aimctrl='popup' readonly id="AllowManageName" name="AllowManageName" relateid="ReceiverId"
                        popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="AllowManageId:UserID;AllowManageName:Name"
                        popstyle="width=700,height=500" style="width: 90%" />
                    <input type="hidden" id="AllowManageId" name="AllowManageId" />
                </td>
            </tr>
            <tr style="display: none;">
                <td class="aim-ui-td-caption">
                    ��������
                </td>
                <td class="aim-ui-td-data">
                    <input aimctrl="date" id="CreateTime" name="CreateTime" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    ����ļ�
                </td>
                <td class="aim-ui-td-data">
                    <input type="hidden" id="Attachment" name="Attachment" aimctrl='file' value="" />
                </span>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    ����
                </td>
                <td class="aim-ui-td-data">
                    <textarea id="Remark" name="Remark" rows="7" style="width: 95%"></textarea>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">����</a> <a id="btnCancel" class="aim-ui-button cancel">
                        ȡ��</a>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
</asp:Content>
