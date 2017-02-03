<%@ Page Title="地址收藏" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="WebLinkEdit.aspx.cs" Inherits="IntegratedManage.Web.WebLinkEdit" %>

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
            //   var reg = /((http)|(https)\:\/\/)|([\w.]+)(\/[\w- \.\/\?%&=]*)?/gi;
            //      if (!reg.exec($("#WebName").val())) {
            //      AimDlg.show("不是正确的URL!");
            //      return;
            //  }
            var nameArr = document.getElementById("WebName").value.split('\r');
            var urlArr = document.getElementById("Url").value.split('\r');
            if (nameArr.length != urlArr.length) {
                AimDlg.show("网址名和网址不一一对应!");
                return;
            }
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
            地址收藏</h1>
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
                        网址名
                    </td>
                    <td class="aim-ui-td-data">
                        <textarea id="WebName" name="WebName" rows="3" style="width: 97%" class="validate[required]"> </textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        网&nbsp;&nbsp;&nbsp;&nbsp;址
                    </td>
                    <td class="aim-ui-td-data">
                        <textarea id="Url" name="Url" rows="3" class="validate[required]" style="width: 97%"> </textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        说&nbsp;&nbsp;&nbsp;&nbsp;明
                    </td>
                    <td class="aim-ui-td-data">
                        添加多个网址时可使用换行分割，且网站名和网址一一对应
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
