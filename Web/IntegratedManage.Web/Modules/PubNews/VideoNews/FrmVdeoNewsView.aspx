<%@ Page Title="信息浏览" Language="C#" AutoEventWireup="True" MasterPageFile="~/Masters/Ext/formpage.master"
    CodeBehind="FrmVdeoNewsView.aspx.cs" Inherits="Aim.Portal.Web.FrmVdeoNewsView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../share/css/Jcpage.css" rel="stylesheet">
    <link href="../share/css/JsCtrl.css" rel="stylesheet">
    <link href="../share/css/style.css" rel="stylesheet">
    <link href="style/css.css" rel="stylesheet" type="text/css" />
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
            background-image: url(../share/images/bg01.jpg);
            background-repeat: repeat-x;
        }
    </style>

    <script language="javascript">
        //self.moveTo(200, 0);
        //self.resizeTo(screen.availWidth - 400, screen.height - 40);

        function onFinish(rtnFromServer) {
            var data = rtnFromServer.data;
            if ($("#imgCollection").attr("src") == "../share/images/shoucang2.jpg") {
                $("#imgCollection").attr("src", "../share/images/shoucang.jpg");
            }
            else {
                $("#imgCollection").attr("src", "../share/images/shoucang2.jpg");
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

            $("#FileId").html(eval("AimState.frmdata.FileId") || "");
            $("label").each(function(i) {
                $("#" + this.id).html(eval("AimState.frmdata." + this.id) || "");
            });

            if (eval("AimState.frmdata.HomePagePopup") == "on" && (!eval("AimState.frmdata.Ext2") || eval("AimState.frmdata.Ext2").indexOf(AimState.UserInfo.UserID) == -1)) {
                $("#lblreadstate").css("display", "inline");
            }

            if (AimState["collection"] == "on") {
                $("#imgCollection").attr("src", "../share/images/shoucang2.jpg");
            }
        }

        function SetColor(color) {
            document.getElementById("Content").style.backgroundColor = color;
        }

        function SetSize(size) {
            document.getElementById('Content').style.fontSize = size;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <body>
        <table width="900" border="0" align="center" cellpadding="0" cellspacing="0" style="height: 100%">
            <tr>
                <td width="10" valign="top" background="../share/images/bg_leftside.jpg">
                </td>
                <td width="900" valign="top" bgcolor="#ffffff">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <a name="top" id="top"></a>
                                <img src="../share/images/news_01a.jpg" width="900" height="82" alt="">
                            </td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="7" background="../share/images/news_02.gif">
                            </td>
                        </tr>
                    </table>
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td background="../share/images/news_04.gif" height="33">
                                <div style="position: relative" align="right" height="33">
                                    <table cellspacing="0" cellpadding="0" width="756" border="0">
                                        <tr>
                                            <td valign="middle" background="../share/images/tools_bg.gif" height="33">
                                                <table style="table-layout: fixed" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td width="12">
                                                        </td>
                                                        <td>
                                                            <!--<font style="color:Gray;">【<font style="color:Red;">不再弹出</font>】</font>-->
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td align="center" width="200">
                                                            <img id="lblreadstate" height="13" alt="" src="../share/images/tools_30b.gif" border="0"
                                                                style="cursor: hand; display: none;" title="点击此按钮后，下次登录，此信息将不会弹出。">
                                                            <img id="imgCollection" style="cursor: pointer;" src="../share/images/shoucang.jpg"
                                                                alt="收藏" border="0" />
                                                            <img height="13" alt="" src="../share/images/tools_30.gif" width="37" border="0"
                                                                onclick="javascript:print()" style="cursor: hand">
                                                            <!--<div style="font-size: 12px; color: #878787;">
                                                                【取消收藏】</div>-->
                                                            <img height="13" alt="" src="../share/images/tools_34.gif" width="37" border="0"
                                                                onclick="window.close()" style="cursor: hand">
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
                    <div id="wrapper" style="width: 900px; text-align: left;">
                        <div id="picSlideWrap" class="clearfix">
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
                                                        &nbsp;&nbsp; 发布人：<label id="CreateName"></label>&nbsp;&nbsp;发布时间：<label id="PostTime">
                                                        </label>
                                                        &nbsp;&nbsp;阅读次数：<label id="Ext1"></label></div>
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
                                            <tr style="height: 600px;">
                                                <td id="tdplayer" valign="top" align="left">
                                                    <div id="divPlayer" style="display: block">
                                                        <object id="player" data="data:application/x-silverlight-2," type="application/x-silverlight-2"
                                                            width="100%" height="100%">
                                                            <param name="source" value="/Document/Vedio.xap" />
                                                            <param name="onError" value="onSilverlightError" />
                                                            <param name="background" value="white" />
                                                            <param name="minRuntimeVersion" value="4.0.50826.0" />
                                                            <param name="autoUpgrade" value="false" />
                                                            <param name="initParams" value='url=<%=Url %>' />
                                                            <a href="/ClientBin/Silverlight.exe" style="text-decoration: none">
                                                                <img src="/ClientBin/SLMedallion_CHS.png" alt="获取 Microsoft Silverlight" style="border-style: none" />
                                                            </a>
                                                        </object>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <hr width="90%" size="1" noshade>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <center>
                                <div class="imgnav" id="imgnav">
                                    <div id="content" style="text-align: left;">
                                        <asp:Literal ID="litcontent" runat="server" />
                                    </div>
                                    <div id="cbtn">
                                        <i class="picSildeLeft">
                                            <img src="images/ico/picSlideLeft.gif" /></i> <i class="picSildeRight">
                                                <img src="images/ico/picSlideRight.gif" /></i>
                                        <div id="cSlideUl">
                                            <ul id="uilength">
                                                <asp:Literal ID="litimgs" runat="server" />
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </center>
                        </div>
                    </div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="5" background="../share/images/news_15.gif">
                            </td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="4%" height="48" background="../share/images/news_17.gif">
                                &nbsp;
                            </td>
                            <td width="88%" background="../share/images/news_17.gif">
                                <br>
                            </td>
                            <td width="8%" align="left" valign="top" background="../share/images/news_17.gif">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10" background="../share/images/bg_rightside.jpg">
                </td>
            </tr>
        </table>

        <script type="text/javascript">
            $(document).ready(function() {
                var index = 0;
                var length = $("#uilength li").length;
                var i = 1;

                $("#content p").hide();
                $("#p" + index).show();

                //关键函数：通过控制i ，来显示图片
                function showImg(i, qiehuan) {
                    //$("#img img").eq(i).stop(true, true).fadeIn(800).siblings("img").hide();
                    if (qiehuan == "OK") {
                        var ss = document.getElementById("player");
                        $("#tdplayer").html('<object id="player" data="data:application/x-silverlight-2," type="application/x-silverlight-2"' +
                                            'width="100%" height="100%">' +
                                            '<param name="source" value="/Document/Vedio.xap" />' +
                                            '<param name="onError" value="onSilverlightError" />' +
                                            '<param name="background" value="white" />' +
                                            '<param name="minRuntimeVersion" value="4.0.50826.0" />' +
                                            '<param name="autoUpgrade" value="false" />' +
                                            '<param name="initParams" value=\'url=' + $("#p" + i).attr("tag") + '\' />' +
                                            '<a href="/ClientBin/Silverlight.exe" style="text-decoration: none">' +
                                            '    <img src="/ClientBin/SLMedallion_CHS.png" alt="获取 Microsoft Silverlight" style="border-style: none" />' +
                                            '</a>' +
                                        '</object>');
                    }

                    $("#cbtn li").eq(i).addClass("hov").siblings().removeClass("hov");
                }

                function slideNext() {
                    if (index >= 0 && index < length - 1) {
                        ++index;
                        showImg(index);

                        $("#content p").hide();
                        $("#p" + index).show();
                    } else {
                        showImg(0);
                        index = 0;
                        aniPx = ((length < 5 ? 5 : length) - 5) * 142 + 'px'; //所有图片数 - 可见图片数 * 每张的距离 = 最后一张滚动到第一张的距离
                        $("#cSlideUl ul").animate({ "left": "+=" + aniPx }, 200);
                        i = 1;

                        $("#content p").hide();
                        $("#p" + index).show();
                    }
                    if (i < 0 || i > length - 5) { return false; }
                    $("#cSlideUl ul").animate({ "left": "-=142px" }, 200)
                    i++;
                }

                function slideFront() {
                    if (index >= 1) {
                        --index;
                        showImg(index);

                        $("#content p").hide();
                        $("#p" + index).show();
                    }
                    if (i < 2 || i > length + 5) { return false; }
                    $("#cSlideUl ul").animate({ "left": "+=142px" }, 200)
                    i--;
                }
                $("#img img").eq(0).show();
                $("#cbtn li").eq(0).addClass("hov");
                $("#cbtn tt").each(function(e) {
                    var str = (e + 1) + "/" + length;
                    $(this).html(str)
                })

                $(".picSildeRight,#next").click(function() {
                    slideNext();
                })
                $(".picSildeLeft,#front").click(function() {
                    slideFront();
                })
                $("#cbtn li").click(function() {
                    index = $("#cbtn li").index(this);
                    showImg(index, "OK");

                    $("#content p").hide();
                    $("#p" + index).show();
                });
                $("#next,#front").hover(function() {
                    $(this).children("a").fadeIn();
                }, function() {
                    $(this).children("a").fadeOut();
                })
            });
        </script>

    </body>
</asp:Content>
