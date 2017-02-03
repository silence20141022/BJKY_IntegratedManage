<%@ Page Title="红头文件" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="HongTouEdit.aspx.cs" Inherits="IntegratedManage.Web.DocumentManage.HongTouEdit" %>

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
        }
        function setPgUI() {
            var tlBar = new Ext.Toolbar({
                renderTo: 'div1',
                items: [{
                    text: '保存红头文件', hidden: pgOperation == "v",
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        if (!$("#Title").val()) {
                            AimDlg.show("红头文件的标题为必填项!");
                            return;
                        }
                        SaveToWeb();
                        AimFrm.submit(pgAction, {}, null, SubFinish);
                    }
                }, { text: '插入文号书签', hidden: pgOperation == "v",
                    iconCls: 'aim-icon-flag-red', handler: function() {
                        document.all.WebOffice1.SetFieldValue("WenHao", "", "::ADDMARK::");
                        AimDlg.show("文号书签插入成功!");
                    }
                }, {
                    text: '关闭红头文件',
                    iconCls: 'aim-icon-exit',
                    handler: function() {
                        window.close();
                    }
}]
                });
                var result = LoadDoc(AimState["FileName"]);
            }
            function LoadDoc(fileName) {
                var host = window.location.host;
                if (pgOperation == "v") {
                    document.all.WebOffice1.ReadOnly = 1; //跟踪模式、查看、和部分节点设置只读
                }
                return document.all.WebOffice1.LoadOriginalFile("Http://" + host + "/Document/" + fileName, "doc");
            }
            function SaveToWeb() {
                var webObj = document.getElementById("WebOffice1");
                if (webObj.IsOpened() != 0 && webObj.ReadOnly != 1) {
                    if (webObj.IsSaved() == 0) {
                        webObj.HttpInit(); //初始化Http引擎
                        //document.all.WebOffice1.HttpAddPostString("FileMainName", escape($("#Title").val()));不建议用标题做文件名。因为插入文件的时候不支持中文
                        webObj.HttpAddPostString("RecordID", "rongwei");
                        webObj.HttpAddPostString("FileId", $("#HongTouContent").val().substring(0, 36)); //增加Post变量
                        webObj.HttpAddPostCurrFile("FileData", "11.doc"); //上传打开的文件 
                        var host = window.location.host;
                        var fileName = webObj.HttpPost("Http://" + host + "/DocumentManage/SaveDoc.aspx"); //执行上传动作
                        $("#HongTouContent").val(fileName);
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

            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn;
                switch (this.id) {
                    case "Name":
                        rtn = '<a href="../../CommonPages/File/DownLoad.aspx?id=' + record.get('Id') + '">' + value + '</a>';
                        break;
                }
                return rtn;
            }
            function window_onunload() {
                document.getElementById("WebOffice1").Close();
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            红头文件</h1>
    </div>
    <table class="aim-ui-table-edit" style="border: none">
        <tr style="display: none">
            <td colspan="4">
                <input id="Id" name="Id" />
                <input id="HongTouContent" name="HongTouContent" />
            </td>
        </tr>
        <tr>
            <td style="width: 25%; text-align: right">
                红头标题
            </td>
            <td style="width: 75%" colspan="3">
                <input id="Title" name="Title" />
            </td>
        </tr>
        <tr>
            <td style="text-align: right">
                说明
            </td>
            <td colspan="3">
                插入文号书签是给发文中登记的文号在Word中的定位，书签定位后注意调整所在行的字体和颜色
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
</asp:Content>
