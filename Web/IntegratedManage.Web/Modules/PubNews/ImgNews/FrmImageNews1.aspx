<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmImageNews1.aspx.cs" Inherits="IntegratedManage.Web.FrmImageNews1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新闻预览</title>

    <script src="style/jquery-1.4.min.js" type="text/javascript"></script>

    <link href="style/css.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        self.moveTo(200, 0);
        self.resizeTo(screen.availWidth - 373, screen.height - 40);

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
                    if ($("#imgCollection").attr("src") == "/images/shared/Collection2.gif") {
                        $("#imgCollection").attr("src", "/images/shared/Collection.gif");
                    }
                    else {
                        $("#imgCollection").attr("src", "/images/shared/Collection2.gif");
                    }
                    alert(rtn);
                });
            });

            $("#lblreadstate").click(function() {
                jQuery.ajaxExecSync('readstate', {}, function(rtn) {
                    alert(rtn);
                    $("#lblreadstate").hide();
                });
            });

            if ($("#hidcollection").val() == "off") {
                $("#imgCollection").attr("src", "/images/shared/Collection2.gif");
            }
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="hidcollection" runat="server" />
    <div id="wrapper">
        <div id="picSlideWrap" class="clearfix">
            <table cellspacing="0" cellpadding="0" width="100%" height="100%" style="margin-top: 10px;"
                border="0">
                <tr style="height: 20px;">
                    <td>
                        <div align="right">
                            <div id="lblreadstate" runat="server" style="cursor: pointer; margin-right: 5px;
                                color: Red; display: inline;">
                                标记为已阅</div>
                            <img style="cursor: pointer;" src="/images/shared/printer.png" border="0" onclick="javascript:window.print();"
                                alt="打印" />
                            <img id="imgCollection" style="cursor: pointer; margin-left: 10px; margin-right: 10px;"
                                src="/images/shared/Collection.gif" alt="收藏" border="0" />
                            <img style="cursor: pointer; margin-right: 30px;" src="/images/shared/cross.gif"
                                border="0" alt="关闭" onclick="window.close();" />
                        </div>
                    </td>
                </tr>
            </table>
            <h3 class="titleh3">
                <label runat="server" id="lbltitle">
                </label>
            </h3>
            <h4 class="titleh4">
                发布部门：<label id="lblPostDeptName" runat="server">
                </label>&nbsp;&nbsp;发布人：<label id="lblAuthorName" runat="server"></label>&nbsp;&nbsp;发布时间：<label
                    runat="server" id="lblPostTime"></label>&nbsp;&nbsp;阅读次数：<label runat="server" id="lblReadCount"></label></h4>
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
