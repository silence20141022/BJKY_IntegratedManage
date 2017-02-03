<%@ Page Title="发文模板" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ReleaseTemplateEdit.aspx.cs" Inherits="IntegratedManage.Web.ReleaseTemplateEdit" %>

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

    <script type="text/javascript">
        function onPgLoad() {
            setPgUI();
            IniButton();
        }
        function setPgUI() {
            var tlBar = new Ext.Toolbar({
                renderTo: 'div1',
                items: [{
                    text: '保存发文模板', hidden: pgOperation == "v",
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        if (!$("#Title").val()) {
                            AimDlg.show("模板文件的标题为必填项!");
                            return;
                        }
                        SaveToWeb();
                        AimFrm.submit(pgAction, {}, null, SubFinish);
                    }
                }, {
                    text: '关闭发文模板',
                    iconCls: 'aim-icon-exit',
                    handler: function() {
                        window.close();
                    }
}]
                });
                LoadDoc(AimState["FileName"]);
            }
            function IniButton() {
                FormValidationBind('btnSubmit', SuccessSubmit);
                $("#btnSave").click(function() {
                    $("#btnSave").hide();
                    SaveToWeb();
                    AimFrm.submit(pgAction, {}, null, SubFinish);
                });
                $("#btnCancel").click(function() {
                    window.close();
                });
            }
            function SuccessSubmit() {
                $("#btnSubmit").hide();
                SaveToWeb();
                AimFrm.submit(pgAction, {}, null, SubFinish);
            }
            function LoadDoc(fileName) {
                var host = window.location.host;
                if (pgOperation == "v") {
                    document.all.WebOffice1.ReadOnly = 1; //跟踪模式、查看、和部分节点设置只读
                }
                document.all.WebOffice1.LoadOriginalFile("Http://" + host + "/Document/" + fileName, "doc");
            }
            function SaveToWeb() {
                var webObj = document.all.WebOffice1;
                if (webObj.IsOpened() != 0 && webObj.ReadOnly != 1) {
                    if (webObj.IsSaved() == 0) {
                        webObj.HttpInit(); //初始化Http引擎
                        document.all.WebOffice1.HttpAddPostString("FileMainName", escape($("#Title").val()));
                        webObj.HttpAddPostString("RecordID", "rongwei");
                        webObj.HttpAddPostString("FileId", $("#HongTouContent").val()); //增加Post变量
                        webObj.HttpAddPostCurrFile("FileData", "11.doc"); //上传打开的文件 
                        var host = window.location.host;
                        var fileName = webObj.HttpPost("Http://" + host + "/DocumentManage/SaveDoc.aspx"); //执行上传动作  
                        $("#TemplateContent").val(fileName);
                    }
                }
            }
            function SubFinish(args) {
                RefreshClose();
            }
            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
            }
            function showwin(val) {
                opencenterwin("../../CommonPages/File/DownLoad.aspx?id=" + val, "newwin0", 120, 120);
            }
            function window_onunload() {
                webObj.Close();
            }
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn;
                switch (this.id) {
                    case "Name":
                        rtn = '<a href="../../CommonPages/File/DownLoad.aspx?id=' + record.get('Id') + '">' + value + '</a>';
                        break;
                }
                return rtn;
            }
         
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            发文模板</h1>
    </div>
    <table class="aim-ui-table-edit" style="border: none">
        <tr style="display: none">
            <td colspan="4">
                <input id="Id" name="Id" />
                <input id="TemplateContent" name="TemplateContent" />
            </td>
        </tr>
        <tr>
            <td class="aim-ui-td-caption" style="width: 25%">
                模板名称
            </td>
            <td style="width: 75%" colspan="3">
                <input id="Title" name="Title" />
            </td>
        </tr>
    </table>
    <div style="text-align: center">
        <div id="div1">
        </div>
        <object id="WebOffice1" height="100%" width='100%' style='left: 0px; top: 0px' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5'
            codebase="WebOffice.cab#V6,0,0,0">
            <param name='_ExtentX' value='6350' />
            <param name='_ExtentY' value='6350' />
        </object>
    </div>
    <%--  <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">提交</a>&nbsp;&nbsp; <a id="btnSave"
                        class="aim-ui-button submit">暂存</a>&nbsp;&nbsp; <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>--%>
</asp:Content>
