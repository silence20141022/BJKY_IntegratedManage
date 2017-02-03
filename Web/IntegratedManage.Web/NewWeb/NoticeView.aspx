<%@ Page Title="通知公告" Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/Ext/formpage.master"
    CodeBehind="NoticeView.aspx.cs" Inherits="IntegratedManage.Web.NoticeView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/NewWeb/css/Jcpage.css" rel="stylesheet" />
    <link href="/NewWeb/css/JsCtrl.css" rel="stylesheet" />
    <link href="/NewWeb/css/style.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">

        //------------------------Aim File 开始------------------------//
        (function() {
            function AimFile(htmele) {
                var htmlele = typeof (htmele) == "object" ? $("#" + htmele.id) : $("#" + htmele);
                htmlele.css("float", "left");
                var eleSpan, fileLinkSpan, fileBtnSpan, fileInputField, btnFileAdd, btnFileDel, btnFileClr, btnFileOpn;
                var readOnly = htmlele.attr("readonly");
                var disabled = htmlele.attr("disabled");
                var mode = htmlele.attr("mode") || "multi";
                var IsLog = htmlele.attr("IsLog") || ""; // 上传是否写日志
                var FolderKey = htmlele.attr("FolderKey") || "Portal"; // 上传的目录
                var Filter = htmlele.attr("Filter") || ""; // 上传文件过滤字符
                var MaximumUpload = ""; // 最大单个上传文件大小(MB)
                var MaxNumberToUpload = ""; // 最大上传文件数
                var AllowThumbnail = false; // 是否允许显示缩略图
                var DoCheck = htmlele.attr("DoCheck") || null; // 上传前检查方法
                var UploadPage = htmlele.attr("UploadPage") || UPLOAD_PAGE_URL;
                var DownloadPage = htmlele.attr("DownloadPage") || DOWNLOAD_PAGE_URL;
                var BtnFileAddID = "btnFileAdd_" + htmele.id;
                var BtnFileClrID = "btnFileClr_" + htmele.id;
                var BtnFileDelID = "btnFileDel_" + htmele.id;
                var BtnFileOpnID = "btnFileOpn_" + htmele.id;
                var FileLinkSpanID = "spanFileLink_" + htmele.id;
                var FileInputFieldID = "spanFileInput_" + htmele.id;
                var FileBtnSpanID = "spanFileBtn_" + htmele.id;

                var SingleFileBlock = "<div class='aim-ctrl-file-link' linkfile='{filefullname}' style='float:left; width:100%; border:0px;'>"
            + "<a href='" + DownloadPage + "?Id={fileid}' style='margin:5px;' title='{filename}' "
            + " target='_blank'>{filename}</a></div>";

                var FileBlock = "<div class='aim-ctrl-file-link' linkfile='{filefullname}' style='float:left; width:120; height: 20; margin:2px; border:0px;'>"
            + "<input type='checkbox'style='border:0px' />"
            + "<img src='/images/shared/green_view.png' style='border:0px' width='15' height='15px' onclick='alert();'/>"
            + "<a href='" + DownloadPage + "?Id={fileid}' style='margin:5px;' title='{filename}' "
            + "  target='_blank'>{filename}</a></div>";

                var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0;"; // 上传文件页面弹出样式

                var SingleStructure = "<table style='border:0px; width:100%; font-size:12px;'><tr>"
            + "<td style='width:*; vertical-align:top; border-color:#8FAACF; padding:2px;' class='aim-ctrl-file'><span id='" + FileInputFieldID + "' style='width:100%' /></td>"
            + "<td style='width:100px; border:0px; padding:0px;' align='center'><span id='" + FileBtnSpanID + "' class='aim-ctrl-file-button-span'>"
            + "<a id='" + BtnFileAddID + "' class='aim-ctrl-file-button'>上传</a>"
            + "<a id='" + BtnFileClrID + "' class='aim-ctrl-file-button'>清空</a>"
                // + "<a id='" + BtnFileOpnID + "' class='aim-ctrl-file-button'>打开</a>"
            + "</span></td></tr></table>";

                var MultiStructure = "<table style='border:0px; width:100%; font-size:12px;'><tr>"
            + "<td style='width:*; vertical-align:top; border-color:#8FAACF' class='aim-ctrl-file'><span id='" + FileLinkSpanID + "' style='width:100%;'></span></td>"
            + "<td style='width:50px; border:0px;' align='center'><span id='" + FileBtnSpanID + "' class='aim-ctrl-file-button-span'>"
            + "<a id='" + BtnFileAddID + "' class='aim-ctrl-file-button'>上传</a><br><br>"
            + "<a id='" + BtnFileDelID + "' class='aim-ctrl-file-button'>删除</a><br><br>"
            + "<a id='" + BtnFileClrID + "' class='aim-ctrl-file-button'>清空</a>"
            + "</span></td></tr></table>";

                init();

                function init() {
                    // 如果父元素不是span，则创建一个span
                    if (htmlele.parent().attr("tagname").toLowerCase() == "span") {
                        eleSpan = htmlele.parent();
                    } else {
                        htmlele.wrap("<span></span>");
                        eleSpan = htmlele.parent();

                        eleSpan.attr("height", htmlele.attr("height"));
                        eleSpan.css("height", htmlele.css("height"));

                        eleSpan.attr("width", htmlele.attr("width"));
                        eleSpan.css("width", htmlele.css("width"));
                    }

                    if (!eleSpan.css("height") || eleSpan.css("height") == "auto") {
                        if (mode != "single") {
                            eleSpan.css("height", 60);
                        }
                    }

                    eleSpan.attr("className", "aim-ctrl");

                    var structure;

                    if (mode == "single") {
                        structure = $(SingleStructure);
                        htmlele.css("display", "none");
                    } else {
                        structure = $(MultiStructure);
                        htmlele.css("visibility", "hidden");
                        htmlele.css("width", "15");
                    }
                    eleSpan.append(structure);

                    fileLinkSpan = $("#" + FileLinkSpanID);
                    fileLinkSpan.css("height", parseInt(eleSpan.css("height").replace("px", "")) + 20);
                    fileLinkSpan.css("overflow-y", "auto");
                    fileInputField = $("#" + FileInputFieldID);
                    fileBtnSpan = $("#" + FileBtnSpanID);
                    btnFileAdd = $("#" + BtnFileAddID);
                    btnFileDel = $("#" + BtnFileDelID);
                    btnFileClr = $("#" + BtnFileClrID);
                    btnFileOpn = $("#" + BtnFileOpnID);

                    fileLinkSpan.append(htmlele);

                    if (htmlele.attr("Required")) {
                        structure.find(".aim-ctrl-file").css("background", FIELD_REQUIRED_BGCOLOR)

                        if (mode == "single") {
                            fileInputField.css("background", FIELD_REQUIRED_BGCOLOR);
                            htmlele.removeClass("validate[required]");
                            fileInputField.addClass("validate[required]");
                        }
                    }

                    btnFileAdd.click(function() {
                        var uploadurl = getUploadUrl();
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle);

                        if (rtn) {
                            if (mode == "single") {
                                htmlele.val(rtn);
                            } else {
                                htmlele.val(htmlele.val() + rtn);
                            }

                            refreshFileView();
                        }
                        if (rtn && htmlele.attr("UploadAfter")) {
                            try {
                                eval(htmlele.attr("UploadAfter") + "('" + rtn + "');");
                            } catch (e) { }
                        }
                    });

                    btnFileDel.click(function() {
                        $.each(fileLinkSpan.find("input[type='checkbox']"), function() {
                            if (this.checked) {
                                var ffname = $(this.parentNode).attr("linkfile");
                                removeFile(ffname);
                            }
                        });
                        if (htmlele.attr("DeleteAfter")) {
                            try {
                                eval(htmlele.attr("DeleteAfter") + "('');");
                            } catch (e) { }
                        }
                    });

                    btnFileClr.click(function() {
                        htmlele.val('');
                        clearFileView();
                        if (htmlele.attr("ClearAfter")) {
                            try {
                                eval(htmlele.attr("ClearAfter") + "('');");
                            } catch (e) { }
                        }
                    });

                    btnFileOpn.click(function() {
                        if (htmlele.val()) {
                            var tflid = htmlele.val().substring(0, htmlele.val().indexOf("_"));
                            OpenWin(DownloadPage + '?Id=' + tflid, '_blank', 'width=1,height=1');
                        }
                    });

                    htmlele.change(function() {
                        refreshFileView();
                    });

                    refreshFileView();

                    if (readOnly) {
                        setReadOnly(readOnly);
                    } else if (disabled) {
                        setDisabled(disabled);
                    }
                }

                // 刷新文件按视图
                function refreshFileView() {
                    clearFileView();

                    var fileval = htmlele.val();
                    if (!fileval) return;

                    if (mode == "single") {
                        fileval = fileval.trimEnd(',');
                        var tflname = fileval.substring(fileval.indexOf("_") + 1);
                        var tflid = fileval.substring(0, fileval.indexOf("_"));

                        var linkFile = $(SingleFileBlock.replace(/{filefullname}/g, fileval).replace(/{filename}/g, tflname).replace(/{fileid}/g, tflid));
                        fileInputField.html(linkFile);
                    } else {
                        var ctrl = this;
                        var fileVals = fileval.split(",");

                        $.each(fileVals, function() {
                            if (this != "") {
                                var tflname = this.substring(this.indexOf("_") + 1);
                                var tflid = this.substring(0, this.indexOf("_"));

                                var linkFile = $(FileBlock.replace(/{filefullname}/g, this).replace(/{filename}/g, tflname).replace(/{fileid}/g, tflid));
                                if (readOnly || disabled) {
                                    linkFile.find("input").css("display", "none");
                                }

                                if (mode == "single") {
                                    linkFile.css("display", "none");
                                }

                                linkFile.insertBefore(htmlele);
                            }
                        }
                );
                    }
                }

                // 移除文件
                function removeFile(filefullname) {
                    var fstr = filefullname + ","
                    var val = htmlele.val().replace(fstr, "");

                    fileLinkSpan.find("[linkfile=" + filefullname + "]").remove();
                    htmlele.val(val);
                }

                // 清空文件视图
                function clearFileView() {
                    if (mode == "single") {
                        fileInputField.html("");
                    } else {
                        fileLinkSpan.find(".aim-ctrl-file-link").remove();
                    }
                }

                function getValue() {
                    return this.htmlele.val();
                }

                function setValue(val) {
                    this.htmlele.val(val);
                }

                function setReadOnly(bool) {
                    this.readOnly = bool;
                    if (bool) {
                        eleSpan.find("input").attr("readonly", true);
                        fileBtnSpan.css("visibility", "hidden");
                    } else {
                        eleSpan.find("input").attr("readonly", false);
                        fileBtnSpan.css("visibility", "visible");
                    }
                }

                function setDisabled(bool) {
                    if (bool) {
                        eleSpan.find("input").attr("disabled", true);
                        fileBtnSpan.css("visibility", "hidden");
                    } else {
                        eleSpan.find("input").attr("disabled", false);
                        fileBtnSpan.css("visibility", "visible");
                    }
                }

                // 获取上传文件路径
                function getUploadUrl() {
                    var qrystr = "&IsLog=" + IsLog + "&Filter=" + escape(Filter)
                + "&MaximumUpload=" + MaximumUpload + "&MaxNumberToUpload=" + MaxNumberToUpload
                + "&AllowThumbnail=" + AllowThumbnail + "&FolderKey=" + FolderKey;

                    if (mode == "single") {
                        qrystr += "&IsSingle=true";
                    }

                    if (this.DoCheck) {
                        qrystr += "&DoCheck=" + DoCheck;
                    }

                    var uploadurl = UploadPage + "?" + qrystr;
                    return uploadurl;
                }


                // Public API
                $.extend(this, {
                    // Methods
                    "getValue": getValue,
                    "setValue": setValue,
                    "setReadOnly": setReadOnly,
                    "setDisabled": setDisabled
                });

            }

            // Aim.File
            $.extend(true, window, { Aim: { File: AimFile} });
        } ());

        //------------------------Aim File 结束------------------------//
    </script>

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
        var id = $.getQueryString({ ID: "id" });
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
                jQuery.ajaxExec('readstate', { id: id }, function() {
                    $("#lblreadstate").css("display", "none");
                    if (window.opener && window.opener.store) {
                        window.opener.store.reload();
                    }
                    if (window.opener && !window.opener.store) {
                        window.opener.location.reload();
                    }
                    if (window.opener && window.opener.parent.opener) {
                        window.opener.parent.opener.location.reload();
                    }
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

            //            if (eval("AimState.frmdata.HomePagePopup") == "on" && (!eval("AimState.frmdata.ReadState") || eval("AimState.frmdata.ReadState").indexOf(AimState.UserInfo.UserID) == -1)) {
            //                $("#lblreadstate").css("display", "inline");
            //            }
            if (parseInt(AimState["ReadStatus"]) < 0) {//只要未读 就让该图标显示
                $("#lblreadstate").css("display", "inline");
            }
            //处理在线预览
            var strfile = document.getElementById("Attachments").value;
            var filelist = strfile.split(",");

            var temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<img src='/images/shared/green_view.png' style='border:0px;' align=absmiddle width='16px' height='16px' onclick='openView(\"" + filelist[i] + "\");'/>&nbsp;&nbsp;";
                temp += "<a tag='" + filelist[i] + "' href = '/CommonPages/File/DownLoad.aspx?Id=" + filelist[i].substring(0, 36) + "' >" + filelist[i].substring(37) + "</a>　　　"; //onmouseover='DisMenu(this)' 
                document.getElementById("divfile").innerHTML = temp;
            }

            strfile = document.getElementById("Pictures").value;
            filelist = strfile.split(",");

            temp = "";
            for (var i = 0; i < filelist.length; i++) {

                if (!filelist[i])
                    break;

                temp += "<img src='/images/shared/green_view.png' style='border:0px;' align=absmiddle width='16px' height='16px' onclick='openView(\"" + filelist[i] + "\");'/>";
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
            <td width="10" valign="top" background="/NewWeb/images/bg_leftside.jpg">
            </td>
            <td width="900" valign="top" bgcolor="#ffffff">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <a name="top" id="top"></a>
                            <img src="/NewWeb/images/news_01a.jpg" width="900" height="82" alt="" />
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="7" background="/NewWeb/images/news_02.gif">
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td background="/NewWeb/images/news_04.gif" height="33">
                            <div style="position: relative" align="right" height="33">
                                <table cellspacing="0" cellpadding="0" width="756" border="0">
                                    <tr>
                                        <td valign="middle" background="/NewWeb/images/tools_bg.gif" height="33">
                                            <table style="table-layout: fixed" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td width="12">
                                                    </td>
                                                    <td>
                                                        <img height="13" alt="" src="/NewWeb/images/tools_03.gif" width="93">
                                                        <img onclick="SetColor('FEE5E5')" height="13" alt="" src="/NewWeb/images/tools_04.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('E9C4FC')" height="13" alt="" src="/NewWeb/images/tools_06.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('D6C4FC')" height="13" alt="" src="/NewWeb/images/tools_08.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('C4CCFC')" height="13" alt="" src="/NewWeb/images/tools_10.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('D0FCC4')" height="13" alt="" src="/NewWeb/images/tools_12.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('C4FCE5')" height="13" alt="" src="/NewWeb/images/tools_14.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('FCFBC4')" height="13" alt="" src="/NewWeb/images/tools_16.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img onclick="SetColor('FFFFFF')" height="13" alt="" src="/NewWeb/images/tools_18.gif"
                                                            width="13" border="0" style="cursor: hand">
                                                        <img height="13" alt="" src="/NewWeb/images/tools_19.gif" width="14">
                                                    </td>
                                                    <td>
                                                        <img height="13" alt="" src="/NewWeb/images/tools_21.gif" width="68">
                                                        <img onclick="SetSize('22px')" height="13" alt="" src="/NewWeb/images/tools_23.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img onclick="SetSize('16px')" height="13" alt="" src="/NewWeb/images/tools_25.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img onclick="SetSize('12px')" height="13" alt="" src="/NewWeb/images/tools_27.gif"
                                                            width="20" border="0" style="cursor: hand">
                                                        <img height="13" alt="" src="/NewWeb/images/tools_28.gif" width="8">
                                                    </td>
                                                    <td align="center" width="200">
                                                        <img id="lblreadstate" height="13" alt="" src="/NewWeb/images/signreaded.gif" border="0"
                                                            style="cursor: hand; display: none;">
                                                        <img id="imgCollection" style="cursor: pointer;" src="/NewWeb/images/shoucang.jpg"
                                                            alt="收藏" border="0" />
                                                        <img height="13" alt="" src="/NewWeb/images/tools_30.gif" width="37" border="0" onclick="javascript:print()"
                                                            style="cursor: hand">
                                                        <img height="13" alt="" src="/NewWeb/images/tools_34.gif" width="37" border="0" onclick="window.close()"
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
                        <td height="5" background="/NewWeb/images/news_15.gif">
                        </td>
                    </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="4%" height="48" background="/NewWeb/images/news_17.gif">
                            &nbsp;
                        </td>
                        <td width="88%" background="/NewWeb/images/news_17.gif">
                            <br>
                        </td>
                        <td width="8%" align="left" valign="top" background="/NewWeb/images/news_17.gif">
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10" background="/NewWeb/images/bg_rightside.jpg">
            </td>
        </tr>
    </table>
</asp:Content>
