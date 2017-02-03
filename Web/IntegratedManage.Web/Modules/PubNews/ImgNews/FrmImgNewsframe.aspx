<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmImgNewsframe.aspx.cs"
    Inherits="IntegratedManage.Web.FrmImgNewsframe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>图片新闻</title>
    <link href="roll/reset.css" rel="stylesheet" type="text/css" />
    <link href="roll/webmain.css" rel="stylesheet" type="text/css" />
    <link href="roll/ddsmoothmenu.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="roll/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="roll/jquery.KinSlideshow-1.2.1.js"></script>

    <script type="text/javascript" src="roll/webtry_roll.js"></script>

    <script type="text/javascript" src="roll/ddsmoothmenu.js"></script>

</head>

<script language="javascript" type="text/javascript">
    $(function() {
        $("#banner").KinSlideshow({
            moveStyle: "right",
            titleBar: { titleBar_height: 30, titleBar_bgColor: "#000", titleBar_alpha: 0.7 },
            titleFont: { TitleFont_size: 12, TitleFont_color: "#FFFFFF", TitleFont_weight: "normal" },
            btn: { btn_bgColor: "#2d2d2d", btn_bgHoverColor: "#1072aa", btn_fontColor: "#FFF", btn_fontHoverColor: "#FFF", btn_borderColor: "#4a4a4a", btn_borderHoverColor: "#1188c0", btn_borderWidth: 1 }
        });
    });

    function OpenNews(htmUrl) {
        var url = htmUrl; //要打开的窗口  
        var winName = "newWin"; //给打开的窗口命名  
        var awidth = 1000;   //窗口宽度,需要设置  
        var aheight = 700;   //窗口高度,需要设置   
        var atop = (screen.availHeight - aheight) / 2;    //窗口顶部位置,一般不需要改  
        var aleft = (screen.availWidth - awidth) / 2; //窗口放中央,一般不需要改  

        var param0 = "scrollbars=1,status=0,menubar=0,resizable=2,location=0"; //新窗口的参数  

        //新窗口的左部位置，顶部位置，宽度，高度   
        var params = "top=" + atop + ",left=" + aleft + ",width=" + awidth + ",height="
          + aheight + "," + param0;

        win = window.open(url, winName, params); //打开新窗口  
        win.focus(); //新窗口获得焦点  
    }
</script>

<body>
    <form id="form1" runat="server">
    <asp:Literal ID="litinfo" runat="server" />
    <div id="banner" runat="server">
        <asp:Literal ID="litimg" runat="server" />
        <a href='#'>
            <img runat="server" id="imglast" width="350" height="200" /></a>
    </div>
    </form>
</body>
</html>
