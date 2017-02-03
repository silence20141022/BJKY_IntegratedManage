<%@ Page Title="信息浏览" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Ext/formpage.master"
    CodeBehind="FrmMessageView1.aspx.cs" Inherits="Aim.IntegratedManage.Web.FrmMessageView1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        self.moveTo(200, 0);
        self.resizeTo(screen.availWidth - 400, screen.height - 40);

        //var EnumType = { 1: "启用", 0: "停用" };

        function onPgLoad() {
            setPgUI();
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

        function setPgUI() {
            $("#btnCancel").click(function() {
                window.close();
            });

            $("#lblreadstate").click(function() {
                jQuery.ajaxExec('readstate', { "Id": eval("AimState.frmdata.Id") }, function() {
                    $("#lblreadstate").css("display", "none");
                    AimDlg.show("已标记");
                });
            });

            $("#imgCollection").click(function() {
                jQuery.ajaxExec('batchcollection', { "Id": eval("AimState.frmdata.Id") }, onFinish);
            });

            $("#FileId").html(eval("AimState.frmdata.FileId") || "");
            $("label").each(function(i) {
                $("#" + this.id).html(eval("AimState.frmdata." + this.id) || "");
            });

            if (!eval("AimState.frmdata.ReadState") || eval("AimState.frmdata.ReadState").indexOf(AimState.UserInfo.UserID) == -1) {
                $("#lblreadstate").css("display", "inline");
            }

            if (AimState["collection"] == "off") {
                $("#imgCollection").attr("src", "/images/shared/Collection2.gif");
            }

            //处理在线预览
            var strfile = document.getElementById("Attachments").value;
            var filelist = strfile.split(",");

            var temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<a tag='" + filelist[i] + "' href = '/CommonPages/File/DownLoad.aspx?Id=" + filelist[i].substring(0, 36) + "' >" + filelist[i].substring(37) + "</a>　　　"; //onmouseover='DisMenu(this)' 
                document.getElementById("divfile").innerHTML = temp;
            }

            strfile = document.getElementById("Pictures").value;
            filelist = strfile.split(",");

            temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<a tag='" + filelist[i] + "' href = '/CommonPages/File/DownLoad.aspx?Id=" + filelist[i].substring(0, 36) + "' >" + filelist[i].substring(37) + "</a>　　　"; //onmouseover='DisMenu(this)' 
                document.getElementById("divimg").innerHTML = temp;
            }
        }

        function doVew(filepath, type) {
            AimFrm.submit("View", { "fileName": filepath, "type": type }, null, function(args) {
                var data = args.data;
                var filepath = data.filepath;
                var type = data.type;
                window.open("FrmView.aspx?type=" + type + "&filepath=" + filepath, "ssdfagn", "");
            });
        }

        function dodown(Id) {
            window.location = "../CommonPages/File/DownLoad.aspx?Id=" + Id;
        }

        function onFinish(rtnFromServer) {
            var data = rtnFromServer.data;
            if ($("#imgCollection").attr("src") == "/images/shared/Collection2.gif") {
                $("#imgCollection").attr("src", "/images/shared/Collection.gif");
            }
            else {
                $("#imgCollection").attr("src", "/images/shared/Collection2.gif");
            }
            AimDlg.show(data.result);
        }

        function doZoom(size) {
            document.getElementById('Content').style.fontSize = size + 'pt';
            document.getElementById('Content').style.lineHeight = size + 10 + 'pt';
        }
    </script>

    <style type="text/css">
        .style1
        {
            font-size: 10px;
            color: #999999;
        }
        body
        {
            background-color: White;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table cellspacing="0" cellpadding="0" width="100%" height="100%" border="0">
        <tbody>
            <tr style="height: 30px;">
                <td>
                    <div align="right">
                        <img style="cursor: pointer;" src="/images/shared/printer.png" border="0" onclick="javascript:window.print();"
                            alt="打印" />
                        <img id="imgCollection" style="cursor: pointer; margin-left: 10px; margin-right: 10px;
                            margin-top: 10px;" src="/images/shared/Collection.gif" alt="收藏" border="0" />
                        <img style="cursor: pointer; margin-right: 30px;" src="/images/shared/cross.gif"
                            border="0" alt="关闭" onclick="window.close();" />
                    </div>
                </td>
            </tr>
            <tr style="height: 100px;">
                <td>
                    <div align="center">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="32">
                                    <div align="center">
                                        <font size="5" face="黑体,Arial, Helvetica, sans-serif"><strong>
                                            <label id="Title">
                                            </label>
                                        </strong></font>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <table width="95%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="center" style="color: #990000; font-size: 12px;">
                                    发布人：<label id="AuthorName">
                                    </label>
                                    &nbsp;&nbsp;&nbsp; 发布部门：<label id="PostDeptName">
                                    </label>
                                    &nbsp;&nbsp;&nbsp; 发布时间：<label id="CreateName">
                                    </label>
                                    &nbsp;&nbsp;&nbsp; 阅读次数：<label id="ReadCount"></label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="font-size: 13px; color: #559933;">
                                    <div>
                                        <div id="lblreadstate" style="cursor: pointer; margin-right: 5px; color: Red; display: none;">
                                            标记为已阅</div>
                                        字体大小：<a style="cursor: pointer;" onclick="doZoom(14)">大</a> <a style="cursor: pointer;"
                                            onclick="doZoom(12)">中</a> <a style="cursor: pointer;" onclick="doZoom(9)">小</a></div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <hr width="100%" size="1" noshade>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr style="vertical-align: top; height: *;">
                <td>
                    <label style="width: 95%; margin-left: 2.5%; font-size: 9pt; line-height: 19pt;"
                        id="Content">
                    </label>
                </td>
            </tr>
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
            <tr style="height: 5px;">
                <td>
                    <hr width="95%" style="margin-bottom: 10px;" size="1" noshade />
                </td>
            </tr>
            <tr style="height: 70px;">
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
        </tbody>
    </table>
</asp:Content>
