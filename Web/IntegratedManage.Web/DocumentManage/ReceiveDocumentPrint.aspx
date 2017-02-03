<%@ Page Title="差旅报销单" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="True" CodeBehind="ReceiveDocumentPrint.aspx.cs" Inherits="IntegratedManage.Web.DocumentManage.ReceiveDocumentPrint" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script language="javascript" src="CheckActivX.js" type="text/javascript"></script>

    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>

    <script language="javascript" type="text/javascript">
        var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
        CheckLodop();
    </script>

    <script type="text/javascript">
        function onPgLoad() {
            var tab = document.getElementById("tbSign");
            LODOP.PRINT_INIT("");
            LODOP.SET_PRINT_PAGESIZE(1, 2700, 1800, "A4");
            if (AimState["Opinion"] && AimState["Opinion"].length > 1) {
                var myData = AimState["Opinion"];
                for (var i = 1; i < myData.length; i++) {//从1开始是为了去掉提交人 
                    var tr = tab.insertRow();
                    tr.height = 32;
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].ApprovalNodeName ? myData[i].ApprovalNodeName + "意见" : '';
                    td.rowSpan = 2;
                    // td.className = "aim-ui-td-caption";
                    td.style.width = "25%";
                    td.style.textAlign = "center"; td.style.fontWeight = "bolder";
                    var td = tr.insertCell();
                    var Description = myData[i].Description ? myData[i].Description : '';
                    td.innerHTML = '<textarea rows="2" disabled style="width:96%;">' + Description + '</textarea>';
                    td.colSpan = 6;
                    var tr = tab.insertRow(); //第二行
                    var td = tr.insertCell(); td.innerHTML = '审批结果:'; td.style.width = "100px";
                    var td = tr.insertCell(); td.innerHTML = myData[i].Result; td.style.textDecoration = "underline";
                    var td = tr.insertCell(); td.innerHTML = '签名:';
                    var td = tr.insertCell(); td.innerHTML = '<img style="width:70px; height:25px;" src="/CommonPages/File/DownLoadSign.aspx?UserId=' + myData[i].OwnerId + '"/>';
                    var td = tr.insertCell(); td.innerHTML = '审批时间:';
                    var td = tr.insertCell(); td.innerHTML = myData[i].FinishTime ? myData[i].FinishTime : ''; td.style.textDecoration = "underline";
                }
            }
            var tr = tab.insertRow(); tr.height = 45;
            var td = tr.insertCell(); td.innerHTML = "处理情况"; td.style.textAlign = "center"; td.style.fontWeight = "bolder";
            var td = tr.insertCell(); td.colSpan = 6; td.innerHTML = "";
            var tr = tab.insertRow(); tr.height = 45;
            var td = tr.insertCell(); td.innerHTML = "备注"; td.style.textAlign = "center"; td.style.fontWeight = "bolder";
            var td = tr.insertCell(); td.colSpan = 6; td.innerHTML = "";
            LODOP.ADD_PRINT_HTM(5, 5, '100%', '100%', document.documentElement.innerHTML);
            LODOP.ADD_PRINT_TEXT(521, 900, 165, 22, "第#页/共&页");
            LODOP.SET_PRINT_STYLEA(0, "ItemType", 2);
            LODOP.SET_PRINT_STYLEA(0, "Horient", 1);
            LODOP.SET_PRINT_STYLEA(0, "Vorient", 1);
            //  LODOP.ADD_PRINT_HTM(5, 5, '100%', '100%', document.documentElement.innerHTML);
            //LODOP.SET_PRINT_STYLEA(0, "Horient", 2);
            //LODOP.SET_PRINT_STYLEA(0, "Horient", 3);
            // LODOP.ADD_PRINT_TEXT(532, 45, 100, 25, "：");
            //                LODOP.SET_PRINT_STYLEA(1, "FontSize", 10);
            //                LODOP.SET_PRINT_STYLEA(1, "Bold", 1);
            //                LODOP.ADD_PRINT_IMAGE(1, 65, 220, 100, '<img src="logo1.jpg" />');
            //                LODOP.ADD_PRINT_IMAGE(30, 575, 220, 120, '<img src="logo2.jpg" />');
            LODOP.PREVIEW();
            window.close();
            //LODOP.PRINT_DESIGN();
            //LODOP.PRINT_SETUP();
        }           
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <center style="background-color: White">
        <div id="divcontent" style="width: 25.5cm; text-align: left; font-size: 10px">
            <table width="100%" style="font-size: 15px; text-align: center; border-bottom: none;
                border-right: none; border-collapse: collapse;" border="1px" id="tb1">
                <tr>
                    <td colspan="4" align="center" style="font-weight: bolder; font-size: 18px; color: Red">
                        <img src="KYlogo.png" alt="" style="height: 40px; width: 50px" />北京矿冶研究总院收文处理单
                    </td>
                </tr>
                <tr style="height: 32px;">
                    <td style="width: 25%; font-weight: bolder">
                        收文字号
                    </td>
                    <td style="width: 25%;">
                        <label id="lbComeWord" runat="server">
                        </label>
                    </td>
                    <td style="width: 25%; font-weight: bolder">
                        日期
                    </td>
                    <td style="width: 25%;">
                        <label id="lbReceiveDate" runat="server">
                        </label>
                    </td>
                </tr>
                <tr style="height: 32px">
                    <td style="font-weight: bolder">
                        来文机关
                    </td>
                    <td>
                        <label id="lbBringUnit" runat="server">
                        </label>
                    </td>
                    <td style="font-weight: bolder">
                        来文字号
                    </td>
                    <td>
                        <label id="lbReceiveWord" runat="server">
                        </label>
                    </td>
                </tr>
                <tr style="height: 45px;">
                    <td style="font-weight: bolder;">
                        事由
                    </td>
                    <td>
                        <label id="lbReceiveReason" runat="server">
                        </label>
                    </td>
                    <td style="font-weight: bolder">
                        附件
                    </td>
                    <td>
                        <label id="lbAttachment" runat="server">
                        </label>
                    </td>
                </tr>
                <tr style="height: 45px;">
                    <td style="font-weight: bolder; border-bottom: none;">
                        拟办
                    </td>
                    <td colspan="3" style="border-bottom: none;">
                        <label id="lbNiBanOpinion" runat="server">
                        </label>
                    </td>
                </tr>
            </table>
            <table id="tbSign" width="100%" style="font-size: 15px; border-collapse: collapse;
                border-bottom: none; border-right: none;" border="1px solid">
            </table>
            <br />
        </div>
    </center>
</asp:Content>
