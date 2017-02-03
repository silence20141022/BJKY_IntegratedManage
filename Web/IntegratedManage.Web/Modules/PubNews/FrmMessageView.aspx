<%@ Page Title="信息浏览" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Ext/formpage.master"
    CodeBehind="FrmMessageView.aspx.cs" Inherits="Aim.Portal.Web.FrmMessageView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="share/css/Jcpage.css" rel="stylesheet">
    <link href="share/css/JsCtrl.css" rel="stylesheet">
    <link href="share/css/style.css" rel="stylesheet">
    <style type="text/css">
        .STYLE1
        {
            color: #800000;
            font-weight: bold;
        }
        .STYLE3
        {
            color: red;
            font-weight: bold;
        }
        .STYLE2
        {
            color: #0000FF;
        }
        body
        {
            background-color: #F7FFFF;
            background-image: url(share/images/bg01.jpg);
            background-repeat: repeat-x;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function onFinish(rtnFromServer) {
            var data = rtnFromServer.data;
            if ($("#imgCollection").attr("src") == "share/images/shoucang2.jpg") {
                $("#imgCollection").attr("src", "share/images/shoucang.jpg");
            }
            else {
                $("#imgCollection").attr("src", "share/images/shoucang2.jpg");
            }
            AimDlg.show(data.result);
        }

        function onPgLoad() {

            $("#lblreadstate").click(function() {
                jQuery.ajaxExec('readstate', { "Id": eval("AimState.frmdata.Id") }, function() {
                    $("#lblreadstate").css("display", "none");
                    //AimDlg.show("已标记");
                });
            });

            $("#imgCollection").click(function() {
                jQuery.ajaxExec('batchcollection', { "Id": eval("AimState.frmdata.Id") }, onFinish);
            });

            if (AimState["frmdata"].FileType == "mht") {
                $("#Content").hide();
                document.getElementById("mhtframe").src = "/Document/" + AimState["frmdata"].MhtFile.substring(0, AimState["frmdata"].MhtFile.length - 1);
            }
            else {
                $("#mhtframe").hide();
            }

            $("#FileId").html(eval("AimState.frmdata.FileId") || "");
            $("label").each(function(i) {
                $("#" + this.id).html(eval("AimState.frmdata." + this.id) || "");
            });

            if (eval("AimState.frmdata.HomePagePopup") == "on" && (!eval("AimState.frmdata.ReadState") || eval("AimState.frmdata.ReadState").indexOf(AimState.UserInfo.UserID) == -1)) {
                $("#lblreadstate").css("display", "inline");
            }

            //处理在线预览
            var strfile = document.getElementById("Attachments").value;
            var filelist = strfile.split(",");

            var temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<img src='/images/shared/green_view.png' style='border:0px' align=absmiddle width='16px' height='16px' onclick='openView(\"" + filelist[i] + "\");'/>&nbsp;&nbsp;";
                temp += "<a tag='" + filelist[i] + "' href = '/CommonPages/File/DownLoad.aspx?Id=" + filelist[i].substring(0, 36) + "' >" + filelist[i].substring(37) + "</a>　　　"; //onmouseover='DisMenu(this)' 
                document.getElementById("divfile").innerHTML = temp;
            }

            strfile = document.getElementById("Pictures").value;
            filelist = strfile.split(",");

            temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<img src='/images/shared/green_view.png' style='border:0px' align=absmiddle width='16px' height='16px' onclick='openView(\"" + filelist[i] + "\");'/>&nbsp;&nbsp;";
                temp += "<a tag='" + filelist[i] + "' href = '/CommonPages/File/DownLoad.aspx?Id=" + filelist[i].substring(0, 36) + "' >" + filelist[i].substring(37) + "</a>　　　"; //onmouseover='DisMenu(this)' 
                document.getElementById("divimg").innerHTML = temp;
            }

            if (AimState["collection"] == "on") {
                $("#imgCollection").attr("src", "share/images/shoucang2.jpg");
            }
        }

        function DisMenu(obj) {
            var divmenu = $("#divmenu");
            divmenu.css("display", "inline");

            divmenu.css("left", $(obj).offset().left);
            divmenu.css("top", $(obj).offset().top + 12);

            var fileTyle = "";
            if (obj.tag.indexOf(".doc") > 0) {
                fileTyle = "doc";
            }
            else if (obj.tag.indexOf(".xls") > 0) {
                fileTyle = "xls";
            }

            //预览
            if (obj.tag.indexOf(".doc") < 0 && obj.tag.indexOf(".xls") < 0) {
                $("#lblview").css("display", "none");
            }
            else {
                $("#lblview").css("display", "block");
            }
            $("#lblview").click(function() { doVew(obj.tag, fileTyle) });
            $("#lbldown").click(function() { dodown(obj.tag.substring(0, 36)) });
        }

        function HasRead() {
            var dpId = new DataParam("Id", GetQueryString("Id"));
            var rtn = Execute.Post("HasRead", dpId);

            if (rtn.HasError)
                rtn.ShowDebug();
            else
                window.close();
        }

        function SetColor(color) {
            document.getElementById("Content").style.backgroundColor = color;
        }

        function SetSize(size) {
            document.getElementById('Content').style.fontSize = size;
        }
        function openView(fileid) {
            OpenWin("/onlineView.htm?id=" + fileid, "_blank", CenterWin("width=800,height=700,scrollbars=yes"));
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table width="900" border="0" align="center" cellpadding="0" cellspacing="0" style="height: 100%">
        <tr>
            <td width="10" valign="top" background="share/images/bg_leftside.jpg">
            </td>
            <td width="900" valign="top" bgcolor="#ffffff">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <a name="top" id="top"></a>
                            <img src="share/images/news_01a.jpg" width="900" height="82" alt="" />
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="7" background="share/images/news_02.gif">
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td background="share/images/news_04.gif" height="33">
                            <div style="position: relative" align="right" height="33">
                                <table cellspacing="0" cellpadding="0" width="756" border="0">
                                    <tr>
                                        <td valign="middle" background="share/images/tools_bg.gif" height="33">
                                            <table style="table-layout: fixed" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td width="12">
                                                    </td>
                                                    <td>
                                                        <img height="13" alt="" src="share/images/tools_03.gif" width="93">
                                                        <img onclick="SetColor('FEE5E5')" height="13" alt="" src="share/images/tools_04.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('E9C4FC')" height="13" alt="" src="share/images/tools_06.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('D6C4FC')" height="13" alt="" src="share/images/tools_08.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('C4CCFC')" height="13" alt="" src="share/images/tools_10.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('D0FCC4')" height="13" alt="" src="share/images/tools_12.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('C4FCE5')" height="13" alt="" src="share/images/tools_14.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('FCFBC4')" height="13" alt="" src="share/images/tools_16.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('FFFFFF')" height="13" alt="" src="share/images/tools_18.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img height="13" alt="" src="share/images/tools_19.gif" width="14">
                                                    </td>
                                                    <td>
                                                        <img height="13" alt="" src="share/images/tools_21.gif" width="68">
                                                        <img onclick="SetSize('22px')" height="13" alt="" src="share/images/tools_23.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img onclick="SetSize('16px')" height="13" alt="" src="share/images/tools_25.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img onclick="SetSize('12px')" height="13" alt="" src="share/images/tools_27.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img height="13" alt="" src="share/images/tools_28.gif" width="8">
                                                    </td>
                                                    <td align="center" width="200">
                                                        <img id="lblreadstate" height="13" alt="" src="share/images/tools_30b.gif" border="0"
                                                            style="cursor: hand; display: none;" title="点击此按钮后，下次登录，此信息将不会弹出。">
                                                        <img id="imgCollection" style="cursor: pointer;" src="share/images/shoucang.jpg"
                                                            alt="收藏" border="0" />
                                                        <img height="13" alt="" src="share/images/tools_30.gif" width="37" border="0" onclick="javascript:print()"
                                                            style="cursor: hand">
                                                        <!--<div style="font-size: 12px; color: #878787;">
                                                                【取消收藏】</div>-->
                                                        <img height="13" alt="" src="share/images/tools_34.gif" width="37" border="0" onclick="window.close()"
                                                            style="cursor: hand">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="54">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td height="15">
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr id="title1">
                                                <td>
                                                    <div align="center">
                                                        <font size="5" face="黑体,Arial, Helvetica, sans-serif"><strong>
                                                            <label id="Title">
                                                            </label>
                                                        </strong></font>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td height="30">
                                        <div align="center" class="font_12_black STYLE2">
                                            发布部门：<label id="PostDeptName">
                                            </label>
                                            &nbsp;&nbsp; 发布人：<label id="AuthorName"></label>&nbsp;&nbsp;发布时间：<label id="PostTime">
                                            </label>
                                            &nbsp;&nbsp;阅读次数：<label id="ReadCount"></label>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <hr width="90%" size="1" noshade>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                            <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" align="left">
                                        <label style="line-height: 19pt;" id="Content">
                                        </label>
                                        <iframe id="mhtframe" width="100%" height="600" name="frameContent" frameborder="0">
                                        </iframe>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <hr width="90%" size="1" noshade>
                                    </td>
                                </tr>
                            </table>
                            <table width="90%" border="0" align="center" cellspacing="0" cellpadding="10">
                                <tr style="display: none;">
                                    <td>
                                        <table width="95%" border="0" style="margin-left: 2.5%; font-size: 12px; margin-top: 20px;"
                                            cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="aim-ui-td-caption" style="width: 3%; vertical-align: top; text-align: left;">
                                                    附件：
                                                </td>
                                                <td style="width: 35%;" class="aim-ui-td-data">
                                                    <span>
                                                        <input id="Attachments" name="Attachments" style="width: 80%; height: 100px;" aimctrl='file' /></span>
                                                </td>
                                                <td class="aim-ui-td-caption" style="width: 3%; vertical-align: top; text-align: left;">
                                                    图片：
                                                </td>
                                                <td style="width: 35%;" class="aim-ui-td-data">
                                                    <span>
                                                        <input id="Pictures" name="Pictures" style="width: 80%; height: 100px;" aimctrl='file' /></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 3%; vertical-align: top; text-align: left;">
                                        <!--class="aim-ui-td-caption" -->
                                        <div style="margin-left: 2.5%; display: inline; margin-right: 30px; font-size: 13px;
                                            vertical-align: top;">
                                            附件：</div>
                                        <div id="divfile" style="font-size: 13px; color: Blue; cursor: pointer; display: inline;
                                            height: 30px;">
                                        </div>
                                        <br />
                                        <div style="margin-left: 2.5%; display: inline; margin-right: 30px; font-size: 13px;
                                            vertical-align: top;">
                                            图片：</div>
                                        <div id="divimg" style="font-size: 13px; color: Blue; cursor: pointer; display: inline;
                                            height: 30px;">
                                        </div>
                                        <div id="divmenu" style="font-size: 12px; width: 50px; display: none; position: absolute;"
                                            onmouseleave="this.style.display='none';">
                                            <a href="#" id="lbldown">下载</a> <a href="#" id="lblview">预览</a>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="5" background="share/images/news_15.gif">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="4%" height="48" background="share/images/news_17.gif">
                            &nbsp;
                        </td>
                        <td width="88%" background="share/images/news_17.gif">
                            <br>
                        </td>
                        <td width="8%" align="left" valign="top" background="share/images/news_17.gif">
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10" background="share/images/bg_rightside.jpg">
            </td>
        </tr>
    </table>
</asp:Content>
