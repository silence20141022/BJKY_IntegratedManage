<%@ Page Title="常用下载" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="DailyDownLoad.aspx.cs" Inherits="IntegratedManage.Web.DailyDownLoad" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
            background-color: white;
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
        var myData1, store1, tpl1, dataview, store2, tpl2, panel1, panel2;
        var id = $.getQueryString({ ID: "id" });
        function onPgLoad() {
            //            setPgUI();
            //            IniButton();
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
        function DownLoad(val) {
            switch (val) {
                case 1:
                    opencenterwin("/DocumentManage/WebOffice.cab", "", 350, 350);
                    break;
                case 2:
                    opencenterwin("/ClientBin/Silverlight.exe", "", 350, 350);
                    break;
                case 3:
                    opencenterwin("DownLoad/VideoConverter.zip", "", 350, 350);
                    break;
                case 4:
                    opencenterwin("DownLoad/使用手册_综合管理信息系统V2.0.docx", "", 350, 350);
                    break;
                case 5:
                    opencenterwin("DownLoad/使用手册_绩效考核系统V1.0.doc", "", 350, 350);
                    break;
                case 6:
                    opencenterwin("DownLoad/IE8-WindowsXP-x86-CHS.exe", "", 350, 350);
                    break;
                case 7:
                    opencenterwin("DownLoad/360se6_6.1.0.350.exe", "", 350, 350);
                    break;
                case 8:
                    opencenterwin("DownLoad/IE10兼容.rar", "", 350, 350);
                    break;
                case 100:
                    opencenterwin("DownLoad/附件直接查看补丁.zip", "", 350, 350);
                    break;
                case 9:
                    opencenterwin("IE11Help.pdf", "", 900, 900);
                    break;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            常用下载</h1>
    </div>
    <fieldset>
        <legend>系统组件</legend>
        <table style="border: none; vertical-align: middle; font-size: 12px" width="100%"
            cellpadding="0" cellspacing="0">
            <tr style="height: 45px">
                <td style="width: 4%; text-align: center">
                    <img src="DownLoad/Number_001.ico" alt="" width="20" height="20" />
                </td>
                <td style="width: 30%">
                    <img src="DownLoad/document-office.png" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(1)">
                        WebOffice.cab</label>
                </td>
                <td>
                    <label>
                        WebOffice文档控件能够在浏览器窗口中直接打开和编辑服务器上的Word,Excel等Office文档并保存到Web服务器，实现文档和电子表格的在线统一管理，支持强制痕迹保留。</label>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 2px; background-color: Black">
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center">
                    <img src="DownLoad/Number_002.ico" alt="" width="20" height="20" />
                </td>
                <td>
                    <img src="DownLoad/konqsidebar_mediaplayer-2.png" alt="" style="width: 20px; height: 20px" /><label
                        style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(2)">
                        Silverlight.exe</label>
                </td>
                <td>
                    Microsoft Silverlight中文名“微软银光”，是一种新的Web呈现技术，能在各种平台上运行。借助该技术，您将拥有内容丰富、视觉效果绚丽的交互式体验
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 2px; background-color: Black">
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center">
                    <img src="DownLoad/Number_003.ico" width="20" height="20" alt="" />
                </td>
                <td>
                    <img src="DownLoad/tools.png" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(3)">
                        VideoConverter.zip</label>
                </td>
                <td>
                    功能强大的影音文件转换工具,本系统建议转换为WMV格式上传
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 2px; background-color: Black">
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center">
                    <img src="DownLoad/Number_004.ico" alt="" width="20px" height="20px" />
                </td>
                <td>
                    <img src="DownLoad/tools.png" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(100)">
                        附件直接查看补丁.zip</label>
                </td>
                <td>
                    支持在浏览器中直接打开附件,目前支持office,图片格式和PDF格式的文件
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>操作手册</legend>
        <table style="border: none; vertical-align: middle; font-size: 12px" width="100%"
            cellpadding="0" cellspacing="0">
            <tr style="height: 45px">
                <td style="text-align: center; width: 4%">
                    <img src="DownLoad/Number_001.ico" alt="" width="20" height="20" />
                </td>
                <td style="width: 30%">
                    <img src="DownLoad/address_book_search_32.png" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(4)">
                        使用手册_综合管理信息系统V2.0.docx</label>
                </td>
                <td>
                    为综合管理信息系统各模块、功能点提供详细的操作说明
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 2px; background-color: Black">
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center;">
                    <img src="DownLoad/Number_002.ico" alt="" width="20" height="20" />
                </td>
                <td>
                    <img src="DownLoad/address_book_search_32.png" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(5)">
                        使用手册_绩效考核系统V1.0.doc</label>
                </td>
                <td>
                    为绩效考核系统各模块、功能点提供详细的操作说明
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>浏览器</legend>
        <table style="border: none; vertical-align: middle; font-size: 12px" width="100%"
            cellpadding="0" cellspacing="0">
            <tr style="height: 45px">
                <td style="text-align: center; width: 4%">
                    <img src="DownLoad/Number_001.ico" alt="" width="20" height="20" />
                </td>
                <td style="width: 30%">
                    <img src="DownLoad/IE8.ico" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(6)">
                        IE8 for XP</label>
                </td>
                <td>
                    运行环境：Windows7/Vista/XP
                </td>
            </tr>
            <tr>
                <td colspan="3" style="height: 2px; background-color: Black">
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center;">
                    <img src="DownLoad/Number_002.ico" alt="" width="20" height="20" />
                </td>
                <td>
                    <img src="DownLoad/360.jpg" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(7)">
                        360浏览器</label>
                </td>
                <td>
                    如果您装的是IE10浏览器进入综合管理信息系统发现样式有问题,请使用360浏览器或下载IE10与老系统兼容批处理文件
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center;">
                    <img src="DownLoad/Number_003.ico" alt="" width="20" height="20" />
                </td>
                <td>
                    <img src="DownLoad/IE8.ico" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(8)">
                        IE10与老系统兼容批处理文件</label>
                </td>
                <td>
                    下载后解压缩,文件全名为"IE10兼容.bat",关闭所有浏览器,执行此文件,鼠标双击即可,然后再用IE10进入综合管理信息系统
                </td>
            </tr>
            <tr style="height: 45px">
                <td style="text-align: center;">
                    <img src="DownLoad/Number_004.ico" alt="" width="20" height="20" />
                </td>
                <td>
                    <img src="DownLoad/IE8.ico" alt="" style="width: 20px; height: 20px" />
                    <label style="cursor: pointer; color: Blue; text-decoration: underline" onclick="DownLoad(9)">
                        IE11与综合办公系统兼容的问题</label>
                </td>
                <td>
                    解决用户升级到IE11后,打开页面的时候出现乱码的情况
                </td>
            </tr>
        </table>
    </fieldset>
</asp:Content>
