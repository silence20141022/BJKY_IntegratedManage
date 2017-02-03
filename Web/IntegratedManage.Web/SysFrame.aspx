<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="True"
    CodeBehind="SysFrame.aspx.cs" Inherits="IntegratedManage.Web.SysFrame" Title="北京矿冶研究总院"
    EnableEventValidation="false" %>

<%@ Import Namespace="Aim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFBFF,endColorStr=#C7D7FF);
            color: #003399;
            font-family: Verdana,Arial,Helvetica,sans-serif;
        }
        #main
        {
        }
        .table_banner
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E0F0F6,endColorStr=#A4C7E3);
        }
        .tab_item
        {
            font-size: 15;
            border: 0px;
            border-right: 2px solid;
            border-color: #FFF;
            padding-left: 10px;
            padding-right: 10px;
        }
        .x-tab-strip-text
        {
            font-weight: bold !important;
            font-size: 16px !important;
            color: #f0f0f0 !important;
            padding: 0px !important;
            margin: 8px 10px 0px 10px;
        }
        .x-tab-strip x-tab-strip-top
        {
            background-image: url(images/head/head-toolbar-image.png) repeat-x;
            width: 100%;
            height: 32px;
        }
        .x-tab-strip-active
        {
            height: 28px;
            line-height: 28px;
            background-image: url(images/head/head-toolbar-checkedimage.png) !important;
        }
        .x-tab-panel-header
        {
            border: 0px;
            background-image: url() !important;
            background: Transparent;
        }
        .x-tab-panel-header .x-tab-strip
        {
            border: 0px;
            background: none;
            height: 32px;
        }
        .toolbar
        {
            border: 0px;
            background-color: rgb(85,153,224);
        }
        .NEWBT td
        {
            background-position: 1000px 1000px;
        }
        .NEWBT .x-btn-text
        {
            color: white;
        }
        .x-btn-mc em.x-btn-arrow
        {
            background-image: url(/Modules/WebPart/images/Themes1/arrow.gif);
        }
        .header
        {
            background-color: #0075c2;
            height: 93px;
        }
        .mlogo
        {
            height: 93px;
            width: 100%;
            background-color: transparent;
            position: relative;
        }
        .mlogo-head-login
        {
            width: 197px;
            height: 73px;
            z-index: 5;
            position: absolute;
            top: 10px;
            left: 30px;
        }
        .mlogo-head-bg
        {
            background-image: url(images/head/head-background-image.png) !important;
            width: 905px;
            height: 93px;
            text-align: center;
            margin: 0 auto 0 auto;
            z-index: 500;
        }
        .mlogo-head-cname
        {
            font-family: '华文琥珀';
            width: 400px;
            height: 50px;
            background-color: transparent;
            font-size: 48px;
            margin: 24px auto 0 auto;
            color: white;
            text-align: center;
        }
        .mlogo-head-appname
        {
            height: 93px;
            width: 100%;
            background-color: transparent;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 200;
            margin-bottom: 0px !important;
        }
        #ext-gen11
        {
            margin-top: 0px;
        }
        .icon
        {
            width: 330px;
            height: 17px;
            float: right;
            position: absolute;
            top: 8px;
            right: 0px;
            color: White;
        }
        .head-icon
        {
            padding-left: 5px;
            padding-right: 5px;
            display: inline;
        }
        .head-icon-image
        {
            vertical-align: middle;
            display: inline;
        }
        .head-icon-size
        {
            font-family: '微软雅黑';
            font-size: 14px;
            font-weight: 900;
            display: inline;
        }
        .head-icon-rigth
        {
            background-image: url(images/head/head-background-right.png);
            position: absolute;
            top: 0px;
            right: 0px;
            height: 93px;
            width: 180px;
            z-index: 10;
        }
        .head-toolbar-image
        {
            background-image: url(images/head/head-toolbar-image.png);
            width: 100%;
            height: 32px;
        }
        .head-toolbar-size
        {
            height: 32px;
            width: 890px;
            margin: 0 auto 0 auto;
            margin-top: 8px;
        }
        .x-tab-strip
        {
            background-image: url(images/head/head-toolbar-image.png) !important;
            margin-top: 0px !important;
        }
        .x-tab-strip li
        {
            height: 32px !important;
            line-height: 32px !important;
        }
        .tab_item
        {
            padding: 0px !important;
            line-height: 32px !important;
        }
        .x-panel-body
        {
            border-top: none;
        }
        .x-tab-strip-text .x-tab-strip-text
        {
            height: 36px;
            overflow: hidden;
        }
        .x-tab-strip-text ul li
        {
            float: left;
            font-size: 14px;
            font-weight: bold;
            margin: 5px 5px 0 5px;
        }
        .x-tab-strip-text ul li a
        {
            float: left;
            display: block;
            height: 26px;
            line-height: 26px;
            color: #fff;
            padding-left: 20px;
        }
        .x-tab-strip-text ul li a span
        {
            float: left;
            display: block;
            padding-right: 20px;
        }
        x-tab-panel-header x-unselectable
        {
            padding-bottom: 0px;
        }
    </style>
    <script type="text/javascript">
        //self.moveTo(0,0)
        self.resizeTo(screen.availWidth, screen.availHeight)
        var mdls;
        var needCheckKey = false;

        function onPgLoad() {
            mdls = AimState["Modules"] || [];
            setPgUI();
            //弹出未读通知公告
//            var data = AimState["PromptDics"];
//            for (var i = 0; i < data.length; i++) {
//                if (data[i].NewsType == "pt") {
//                    opencenterwin("Modules/PubNews/FrmMessageView.aspx?Id=" + data[i].Id, "ptnews" + i, 1100, 600);
//                }  // background-image: url(/images/nportal/tdbg.jpg);
//            } 
           // window.setTimeout("RefreshSession()", 100000);
            window.onbeforeunload = function () { if (event.clientY < 0) window.location.href = "/Unlogin.aspx"; }           
        }
        function RefreshSession() {
            $.ajax({
                type: "GET",
                url: "SysFrame.aspx",
                data: "tag=Refresh",
                success: function (msg) {
                    document.getElementById("UserOnline").innerText = msg;
                }
            });
            window.setTimeout("RefreshSession()", 100000);
        }

        function setPgUI() {
            var tabArr = new Array();
            var i = 0;
            var FrameHtml = "";
            // 构建tab标签
            $.each(mdls, function () {
                //FrameHtml = "<iframe width=100% height=100% id=frameContent" + i.toString() + " name=frameContent frameborder='0' src=''></iframe>";
                var tab = {
                    title: this["Name"],
                    href: this["Url"],
                    code: this["Code"],
                    Description: this["Description"],
                    AID: this["ApplicationID"],
                    /*listeners: { activate: handleActivate },*/
                    margins: '0 0 0 0',
                    border: false,
                    layout: 'border',
                    html: "<div style='display:none;'></div>"
                    /*items: [{ region: 'center', border: false,
                    html: "<div style='display:none;'></div>"
                    }]*/
                }
                tabArr.push(tab);
            });

            // 用于tab过多时滚动
            var scrollerMenu = new Ext.ux.TabScrollerMenu({
                menuPrefixText: '系统',
                maxText: 15,
                pageSize: 5
            });

            var tabPanel = new Ext.ux.AimTabPanel({
                enableTabScroll: true,
                border: true,
                defaults: { autoScroll: true },
                plugins: [scrollerMenu],
                region: 'north',
                margins: '93 0 0 0',
                activeTab: 0,
                width: document.body.offsetWidth - 5,
                height: 10,
                items: tabArr,
                listeners: { 'click': function () { handleActivate(); } },
                itemTpl: new Ext.XTemplate(
                ' <li id="{id}" style="overflow:hidden">',
                    '<span class="tab_item">',
                        '<span class="x-tab-strip-text" align="center"> {text}</span>',
                    '</span>',
                '</li> '
                 )
            });
            var html = "<div style='font-size: 12px; margin: 0;padding:0px;background-color:rgb(85,153,224)'><table width=99%><tr><td style='font-size:12px;color:white;'>&nbsp;您好&nbsp;<%=UserInfo.Name %>&nbsp;&nbsp;欢迎您使用系统&nbsp;!&nbsp;&nbsp;";
            html += "<span  style='font-size:12px;' onclick=\"window.open('/Modules/Office/calendar.htm','_blank')\" style='text-decoration: underline; cursor: hand;'>  今天是 <%=String.Format("{0}月{1}日", DateTime.Now.Month, DateTime.Now.Day) %></span>&nbsp;&nbsp;</td>";
            html += "<td align=center style=font-size:12px;color:white;width:80%>在线人数&nbsp;&nbsp;<span id=UserOnline style='font-size:12px;color:white' onclick=\"window.open('/OnlineUserList.aspx','_blank')\" style='text-decoration: underline; cursor: hand;'>" + AimState["UserOnLine"] + "</span></td>";
            html += "<td align=right style='font-size:12px;color:white;'></td></tr></table></div>";
            var bottomBar = new Ext.Toolbar({
                cls: "toolbar",
                region: 'south',
                bodyStyle: 'border:0px',
                width: document.body.offsetWidth - 5,
                html: html
            });
            var viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [tabPanel, {
                    region: 'center',
                    margins: '0 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'border-top-color:#323232;border-top-width: 1px;background:#323232',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" src="/NewHome.aspx"></iframe>'
                }, bottomBar]
            });
            var depts = AimState["Depts"];  
            function handleActivate(tab) {
                tab = tab || tabPanel.getActiveTab();
                if (!tab) {
                    return;
                } 
                var url = tab.href; 
                if (tab.code.toUpperCase() != "HOME"&&tab.href.toString().toLowerCase().indexOf("http://")<0) {
                    url = $.combineQueryUrl("/SubPortalTree.aspx", "id=" + tab.AID);
                }
                else
                {
                    url = tab.href;
                    url = $.combineQueryUrl(url, "SSOID=<%=this.UserSID %>");
                    if(tab.Description=="open")
                    { 
                        OpenFull(url);
                        return false;
                    }
                }
                if (document.getElementById("frameContent"))
                    frameContent.location.href = url;
                else {
                    window.setTimeout("LoadFirstTab('" + url + "');", 100);
                }
                return;
            }
//             var btn = new Ext.Button({
//                renderTo: 'div1',
//                text: '退出',
//                cls:'NEWBT',
//                iconCls: 'aim-icon-cog',
//                menu: [
//                    { text: '退出', icon: "/Images/shared/exit.png", handler: function() { document.getElementById("ctl00_BodyHolder_lnkExit").click(); } },
//                    { text: '注销', icon: "/Images/shared/trans.gif", handler: function() { document.getElementById("ctl00_BodyHolder_lnkRelogin").click(); } },
//                    { text: '修改密码', icon: "/Images/shared/key.png", handler: function() { OpenPwdChgPage(); } },
//                    { text: '刷新', icon: "/Images/shared/refresh.gif", handler: function() { document.location.reload();   } },
//                    { text: '收藏', icon: "/Images/shared/feed_add.png", handler: function() { addfavor(window.location.href, "综合管理系统"); } }]
//            });
        }
        function OpenFull(url)
        {
           
            var ww = window.screen.width;
            var hh = window.screen.height - 20;
            window.open(url, "_blank");//,"toolbar=no,location=no,directories=no,menubar=no,scrollbars=no,resizable=yes,status=no,top=0,left=0,width="+ww+",height="+hh);
        }

        function LoadFirstTab(url) {
            if (document.getElementById("frameContent"))
                frameContent.location.href = url;
            else
                window.setTimeout("LoadFirstTab('" + url + "');", 100);
        }

        function DoRelogin() {
            window.setTimeout("location.href = '../Login.aspx'", 200);
        }
        function Download() {
            opencenterwin("/DailyManage/DailyDownLoad.aspx",'download',1000,600);
            //window.showModalDialog("/DailyManage/DailyDownLoad.aspx", window, "resizable:yes;scroll:yes;status:no;center=yes;help=no'");
        }
        function returnHome() {
           opencenterwin("http://www.bgrimm.com",'',1100,650);
        }
        function DoClose() {
        $.ajaxExec("close",{},function(){
            
        })            
        }
        function RedirectEntry() {
            var host = window.location.host.split(":")[0];
            window.location.href = "http://" + host + ":3230/SysEntry.aspx";
        }
        function SetSysImage() {
            var sys = $.getQueryString({ "ID": "App" });
            var imgurl = "1.gif";
            switch (sys) {
                case "EXAMINING":
                    imgurl = sys + ".gif";
                    break;
                case "APPReport":
                    imgurl = sys + ".gif";
                    break;
                case "D_Design":
                    imgurl = sys + ".gif";
                    break;
                case "APPLeaderView":
                    imgurl = sys + ".gif";
                    break;
                default:
                    break;
            }
            document.getElementById("imgLogo").src = "images/NPortal/" + imgurl;
        }
        function addfavor(url, title) {
            if (confirm("您确定要收藏吗?")) {
                var ua = navigator.userAgent.toLowerCase();
                if (ua.indexOf("msie 8") > -1) {
                    external.AddToFavoritesBar(url, title, '北京矿研综合管理信息系统'); //IE8
                } else {
                    try {
                        window.external.addFavorite(url, title);
                    } catch (e) {
                        try {
                            window.sidebar.addPanel(title, url, ""); //firefox
                        } catch (e) {
                            alert("加入收藏失败，请使用Ctrl+D进行添加");
                        }
                    }
                }
            }
            return false;
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function OpenPwdChgPage() {
            rtn = OpenWin("/Modules/SysApp/OrgMag/UsrChgPwd.aspx", "_blank", CenterWin("width=350,height=180,scrollbars=yes"));
        } 
       function logout()
       {
        $.ajaxExec("logout",{},function(rtn){ window.location.href="login.aspx";
       })
         
       }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="main" align="center">
        <div class="header">
            <div id="mlogo" class="mlogo">
                <div class="mlogo-head-login">
                    <img alt="" src="images/head/head-login.png" />
                </div>
                <div class="mlogo-head-bg">
                </div>
                <div class="mlogo-head-appname" id="appname">
                    <div class="mlogo-head-cname">
                        综合管理信息系统
                    </div>
                    <div class="icon">
                        <div class="head-icon" onclick="returnHome()" onmouseover="this.style.cursor='hand'">
                            <img alt="" src="/images/head/LMain.png" />
                        </div>
                        <div class="head-icon" onclick="Download()" onmouseover="this.style.cursor='hand'">
                            <img alt="" src="/images/head/DownLoad.png" />
                        </div>
                        <div class="head-icon" onclick="DoClose()" onmouseover="this.style.cursor='hand'"
                            id="div1">
                            <img src="/images/head/Exit.png" onclick="logout()" alt="" />
                            <%--<asp:LinkButton ForeColor="White" Font-Size="12px" onclick="lnkRelogin_Click">注销</asp:LinkButton>
                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/images/head/Exit.png"
                                 OnClientClick="" /> --%>
                        </div>
                    </div>
                </div>
                <div class="head-icon-rigth">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
