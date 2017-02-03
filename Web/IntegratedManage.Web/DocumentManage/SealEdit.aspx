<%@ Page Title="公章维护" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="SealEdit.aspx.cs" Inherits="IntegratedManage.Web.SealEdit" %>

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

    <script type="text/javascript">
        var SealType = { "公司印章": "公司印章", "个人印章": "个人印章" };
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            if ($("#SealFileId").val()) {
                $("#img").attr("src", "/Document/" + $("#SealFileId").val() + "_" + $("#SealFileName").val());
            }
            $(".uploadImg").click(function() {
                var UploadStyle = "dialogHeight:200px; dialogWidth:385px; help:0; resizable:0; status:0;scroll=0";
                var uploadurl = '../CommonPages/File/Upload.aspx';
                var rtn = window.showModalDialog(uploadurl, window, UploadStyle);
                if (rtn) {
                    var src = "/Document/" + rtn.substring(0, rtn.length - 1);
                    $("#img").attr("src", src);
                    $("#SealFileName").val(rtn.substring(37, rtn.length - 1));
                    $("#SealFileId").val(rtn.substring(0, 36));
                }
            });
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
            印章管理</h1>
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
                    <td width="150" style="text-align: center;" rowspan="5">
                        <img style="height: 150; width: 160; border: solid 1 #000000;" src="../images/Seal.jpg"
                            id="img" alt="" />
                        <br />
                        <input type="button" value="上传印章" class="uploadImg" />
                        <input type="hidden" name="SealFileId" id="SealFileId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" width="25%">
                        印章类型
                    </td>
                    <td colspan="2">
                        <select id="SealType" name="SealType" aimctrl='select' enum="SealType" style="width: 75%">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" width="25%">
                        印章名称
                    </td>
                    <td class="aim-ui-td-data" colspan="2">
                        <input id="SealName" name="SealName" class="validate[required]" style="width: 76%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" width="25%">
                        文件名
                    </td>
                    <td class="aim-ui-td-data" colspan="2">
                        <input name="SealFileName" id="SealFileName" style="width: 76%" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        <div style="height: 30">
                        </div>
                    </td>
                    <td class="aim-ui-td-data">
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button submit">保存</a> <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
