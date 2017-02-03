<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmImageNews.aspx.cs" Inherits="IntegratedManage.Web.FrmImageNews" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新闻预览</title>

    <script src="style/jquery-1.4.min.js" type="text/javascript"></script>

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

    <script type="text/javascript">

        //self.moveTo(200, 0);
        //self.resizeTo(screen.availWidth - 373, screen.height - 40);

        function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }

        $.ajaxExecSync = function(action, params, onExecuted, onError, url, maskmsg) {
            // 提交的数据
            $.ajax({
                async: false,
                type: "POST",
                url: 'ExecData.ashx',
                data: {
                    opera: action,
                    id: getUrlParam("id")
                },
                dataType: 'json',
                success: function(rtn) {
                    onExecuted(rtn.responseText);
                }, error: function(rtn) {
                    onExecuted(rtn.responseText);
                }
            });
        }

        $(document).ready(function() {
            $("#imgCollection").click(function() {
                jQuery.ajaxExecSync('batchcollection', {}, function(rtn) {
                    if ($("#imgCollection").attr("src") == "../share/images/shoucang2.jpg") {
                        $("#imgCollection").attr("src", "../share/images/shoucang.jpg");
                    }
                    else {
                        $("#imgCollection").attr("src", "../share/images/shoucang2.jpg");
                    }
                    alert(rtn);
                });
            });

            $("#lblreadstate").click(function() {
                jQuery.ajaxExecSync('readstate', {}, function(rtn) {
                    //alert(rtn);
                    $("#lblreadstate").hide();
                });
            });

            if ($("#hidcollection").val() == "on") {
                $("#imgCollection").attr("src", "../share/images/shoucang2.jpg");
            }
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="hidcollection" runat="server" />
    <table width="787" border="0" align="center" cellpadding="0" cellspacing="0" style="height: 100%">
        <tr>
            <td width="10" valign="top" background="../share/images/bg_leftside.jpg">
            </td>
            <td width="767" valign="top" bgcolor="#ffffff">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <a name="top" id="top"></a>
                            <img src="../share/images/news_01a.jpg" width="800" height="82" alt="">
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
                                                    </td>
                                                    <td align="center" width="200">
                                                        <img id="lblreadstate" runat="server" height="13" alt="" src="../share/images/tools_30b.gif"
                                                            border="0" style="cursor: pointer;" title="点击此按钮后，下次登录，此信息将不会弹出。">
                                                        <img id="imgCollection" style="cursor: pointer;" src="../share/images/shoucang.jpg"
                                                            alt="收藏" border="0" />
                                                        <img height="13" alt="" src="../share/images/tools_30.gif" width="37" border="0"
                                                            onclick="javascript:print()" style="cursor: pointer">
                                                        <img height="13" alt="" src="../share/images/tools_34.gif" width="37" border="0"
                                                            onclick="window.close()" style="cursor: pointer">
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
                            <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td valign="top" align="left">
                                        <div id="wrapper" style="width: 800px;">
                                            <div id="picSlideWrap" class="clearfix">
                                                <table cellspacing="0" cellpadding="0" width="100%" height="100%" style="margin-top: 10px;"
                                                    border="0">
                                                    <tr style="height: 15px;">
                                                    </tr>
                                                </table>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr id="title1">
                                                        <td>
                                                            <div align="center">
                                                                <font size="5" face="黑体,Arial, Helvetica, sans-serif"><strong>
                                                                    <label runat="server" id="lbltitle">
                                                                    </label>
                                                                </strong></font>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="30">
                                                            <div align="center" class="font_12_black STYLE2">
                                                                发布部门：<label id="lblPostDeptName" runat="server">
                                                                </label>
                                                                &nbsp;&nbsp; 发布人：<label id="lblAuthorName" runat="server"></label>&nbsp;&nbsp;发布时间：<label
                                                                    runat="server" id="lblPostTime"></label>
                                                                &nbsp;&nbsp;阅读次数：<label runat="server" id="lblReadCount"></label></div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <hr width="98%" size="0.1" noshade>
                                                <div class="imgnav" id="imgnav">
                                                    <div id="img">
                                                        <!--<img src="images/100260_1306276811398.jpg" width="780" height="570"/>-->
                                                        <asp:Literal ID="litimg" runat="server" />
                                                        <div id="front" title="上一张">
                                                            <a href="javaScript:void(0)" class="pngFix"></a>
                                                        </div>
                                                        <div id="next" title="下一张">
                                                            <a href="javaScript:void(0)" class="pngFix"></a>
                                                        </div>
                                                    </div>
                                                    <div id="content">
                                                        <!--<p id="p0" style="margin-top:20px;">0000000000000，30万群众生产生活用水出现困难。从5月4日开始，湖南华容县和湖北石首市一起“引江济河”，在位于石首市调关镇的华容河与长江交汇处筑堤铺管，通过管道将长江水引进久旱少水的华容河.新华社记者 李尕 摄 </p>-->
                                                        <asp:Literal ID="litcontent" runat="server" />
                                                    </div>
                                                    <div id="cbtn">
                                                        <i class="picSildeLeft">
                                                            <img src="images/ico/picSlideLeft.gif" /></i> <i class="picSildeRight">
                                                                <img src="images/ico/picSlideRight.gif" /></i>
                                                        <div id="cSlideUl">
                                                            <ul>
                                                                <!--<li><img src="images/100260_1306276811398.jpg"/><tt></tt></li>-->
                                                                <asp:Literal ID="litimgs" runat="server" />
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--end滚动看图-->
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
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
            var length = $("#img img").length;
            var i = 1;

            $("#content p").hide();
            $("#p" + index).show();

            //关键函数：通过控制i ，来显示图片
            function showImg(i) {
                $("#img img")
            .eq(i).stop(true, true).fadeIn(800)
            .siblings("img").hide();
                $("#cbtn li")
            .eq(i).addClass("hov")
            .siblings().removeClass("hov");
            }

            function slideNext() {
                if (index >= 0 && index < length - 1) {
                    ++index;
                    showImg(index);

                    $("#content p").hide();
                    $("#p" + index).show();
                } else {
                    if (confirm("已经是最后一张,点击确定重新浏览！")) {
                        showImg(0);
                        index = 0;
                        aniPx = ((length < 5 ? 5 : length) - 5) * 142 + 'px'; //所有图片数 - 可见图片数 * 每张的距离 = 最后一张滚动到第一张的距离
                        $("#cSlideUl ul").animate({ "left": "+=" + aniPx }, 200);
                        i = 1;

                        $("#content p").hide();
                        $("#p" + index).show();
                    }
                    return false;
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
                showImg(index);

                $("#content p").hide();
                $("#p" + index).show();
            });
            $("#next,#front").hover(function() {
                $(this).children("a").fadeIn();
            }, function() {
                $(this).children("a").fadeOut();
            })
        })	
    </script>

    </form>
</body>
</html>
