<%@ Page Title="我的快捷" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="MyShortCutEdit.aspx.cs" Inherits="IntegratedManage.Web.MyShortCutEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
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
        .righttxt
        {
            text-align: right;
        }
        input
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
    <style type="text/css">
        .x-view-selected
        {
            -moz-background-clip: border;
            -moz-background-inline-policy: continuous;
            -moz-background-origin: padding;
            background-color: #FFC0CB;
        }
        .thumb
        {
            background-color: #dddddd;
            padding: 4px;
            text-align: center;
            height: 40px;
        }
        .thumb-activated
        {
            background-color: yellow;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-activateded
        {
            background-color: blue;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-separater
        {
            float: left;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: center;
            border: 1px solid gray;
        }
        .thumb-wrap-out
        {
            float: left;
            width: 80px;
            margin-right: 0;
            padding: 0px; /*width: 160;background-color:#8DB2E3;*/
        }
        .thumb-wrap
        {
            font-size: 12px;
            font-weight: bold;
            padding: 2px;
        }
        .remark
        {
            font-size: 12px;
            padding: 2px;
        }
        .tblusing
        {
            background-color: #FF8247;
        }
        .tblunusing
        {
            background-color: Gray;
        }
    </style>

    <script type="text/javascript">
        var myData1, store1, tpl1, dataview, store2, tpl2, panel1, panel2;
        var id = $.getQueryString({ ID: "id" });
        function onPgLoad() {
            setPgUI();
            IniButton();
        }
        function setPgUI() {

        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        function SuccessSubmit() {
            $("#btnSubmit").hide();
            AimFrm.submit(pgAction, { AuthIds: $("#AuthId").val() }, null, SubFinish);
        }
        function DocEdit(val) {
            opencenterwin("DocumentEdit.aspx?fileId=" + val.lang + "&fileName=" + escape(val.innerHTML) + "&taskName=" + escape(taskName) + "&id=" + id + "&InFlow=" + InFlow + "&LinkView=" + LinkView + "&op=" + pgOperation, "", 1100, 650);
        }
        function SubFinish(args) {
            RefreshClose();
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function UpLoadIcon() {
            var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
            var uploadurl = '../CommonPages/File/Upload.aspx?IsSingle=true';
            var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件
            if (rtn != undefined) {
                $("#IconFileName").val(rtn.substring(37, rtn.length - 1));
                $("#IconFileId").val(rtn.substring(0, 36));
            }
        }
        function AfterSelect(rtn) {
            if (rtn.data) {
                $("#AuthId").val(rtn.data.AuthIds); $("#AuthName").val(rtn.data.AuthNames);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            快捷信息</h1>
    </div>
    <fieldset>
        <legend></legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" /><input id="SortIndex" name="SortIndex" />
                    <input id="ModuleUrl" name="ModuleUrl" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption" style="width: 15%">
                    模块名称
                </td>
                <td style="width: 35%">
                    <input id="AuthName" name="AuthName" class="validate[required]" aimctrl='popup' popurl="MyAuthTree.aspx?Role=User&type=user"
                        popstyle="width=350,height=550" style="width: 78%" afterpopup="AfterSelect" />
                    <input id="AuthId" name="AuthId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption" style="width: 15%">
                    模块图标
                </td>
                <td style="width: 35%">
                    <input id="IconFileName" name="IconFileName" style="width: 70%" />
                    <input id="IconFileId" name="IconFileId" type="hidden" />
                    <label style="cursor: pointer; color: Blue" onclick="UpLoadIcon()">
                        上传</label>
                </td>
            </tr>
        </table>
    </fieldset>
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
