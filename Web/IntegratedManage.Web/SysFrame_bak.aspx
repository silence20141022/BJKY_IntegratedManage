<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SysFrame_bak.aspx.cs" Inherits="IntegratedManage.Web.SysFrame_bak" Title="北京矿冶研究总院"
    EnableEventValidation="false" %>

<%@ Import Namespace="Aim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <script src="/js/IA300ClientJavascript.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFBFF,endColorStr=#C7D7FF);
            color: #003399;
            font-family: Verdana, Arial, Helvetica, sans-serif;
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
            border-right: 1px solid;
            border-color: Gray;
            padding-left: 10px;
            padding-right: 10px;
        }
        .x-tab-strip-text
        {
            color: Black !important;
        }
        .x-tab-strip-active
        {
            height: 28;
            line-height: 28;
            border-bottom-style: solid;
            border-bottom-color: Red;
            border-bottom-width: 2;
            background-image: url(images/NPortal/nav_bg1.png) repeat-x;
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
            background-image: url(/images/nportal/tdbg.jpg);
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
    </style>

    <script type="text/javascript">
		//self.moveTo(0,0)
		self.resizeTo(screen.availWidth,screen.availHeight)
        var mdls;
        var needCheckKey = false;

        function onPgLoad() {
        
            mdls = AimState["Modules"] || [];

            setPgUI();
            var data=AimState["PromptDics"];
            
           for(var i =0;i<data.length;i++)
           {
               if(data[i].NewsType=="pt")
               {
                   opencenterwin("Modules/PubNews/FrmMessageView.aspx?Id="+data[i].Id,"ptnews"+i,1100,600);
               }
               else if(data[i].NewsType=="image")
               {
                   opencenterwin("Modules/PubNews/ImgNews/FrmImageNews.aspx?id="+data[i].Id,"imgnews"+i,1100,600);
               }
               else if(data[i].NewsType=="video")
               {
                   opencenterwin("Modules/PubNews/VideoNews/FrmVdeoNewsView.aspx?Id="+data[i].Id,"videonews"+i,1100,600);
               }
           }
               
            window.setTimeout("RefreshSession()", 100000);
            window.onbeforeunload=function(){if  (event.clientY<0)  window.location.href="/Unlogin.aspx";}
            //易用性处理
            
            //for the key
            /* var browser = DetectBrowser();
            if (browser == "Unknown") {
                return;
            }
            createElementIA300();
            window.setTimeout("CheckKeys();", 50);*/
        }
        
        function RefreshSession() {
            $.ajax({
                type: "GET",
                url: "SysFrame.aspx",
                data: "tag=Refresh",
                success: function(msg) {
                    document.getElementById("UserOnline").innerText=msg;
                }
            });
            window.setTimeout("RefreshSession()", 100000);
        }

        function setPgUI() {
            var tabArr = new Array();
            var i = 0;
            var FrameHtml = "";
            // 构建tab标签
            $.each(mdls, function() {
                //FrameHtml = "<iframe width=100% height=100% id=frameContent" + i.toString() + " name=frameContent frameborder='0' src=''></iframe>";
                var tab = {
                    title: this["Name"],
                    href: this["Url"],
                    code: this["Code"],
                    AID: this["ApplicationID"],
                    listeners: { activate: handleActivate },
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
                margins: '50 5 0 5',
                activeTab: 0,
                width: document.body.offsetWidth - 5,
                height: 10,
                items: tabArr,
                listeners: { 'click': function() { handleActivate(); } },
               itemTpl: new Ext.XTemplate(
               '<li id="{id}" style="overflow:hidden">',
                   '<span class="tab_item" style="margin-top:5px;">',
                       '<span class="x-tab-strip-text" align="center">{text}</span>',
                   '</span>',
               '</li>'
                )
            });
            
            var html = "<div style='font-size: 12px; margin: 0;padding:0px;'><table width=99%><tr><td style='font-size:12px;color:white;'>&nbsp;您好&nbsp;<%=UserInfo.Name %>&nbsp;&nbsp;欢迎您使用系统&nbsp;!&nbsp;&nbsp;";
            html+="<span  style='font-size:12px;' onclick=\"window.open('/Modules/Office/calendar.htm','_blank')\" style='text-decoration: underline; cursor: hand;'>  今天是 <%=String.Format("{0}月{1}日", DateTime.Now.Month, DateTime.Now.Day) %></span>&nbsp;&nbsp;</td>";
            html +="<td align=center style=font-size:12px;color:white;width:80%>在线人数&nbsp;&nbsp;<span id=UserOnline style='font-size:12px;color:white' onclick=\"window.open('/OnlineUserList.aspx','_blank')\" style='text-decoration: underline; cursor: hand;'>"+AimState["UserOnLine"]+"</span></td>";
            html+="<td align=right style='font-size:12px;color:white;'></td></tr></table></div>";
            var bottomBar = new Ext.Toolbar({
                cls: "toolbar",
                region: 'south',
                bodyStyle: 'border:0px',
                width: document.body.offsetWidth - 5,
                html:html
            });
            
            var viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [tabPanel, {
                    region: 'center',
                    margins: '0 5 0 5',
                    cls: 'empty',
                    bodyStyle: 'border-top-color:#323232;border-top-width: 1px;background:#323232',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'
                }, bottomBar]
            });
            
            var depts = AimState["Depts"];
            var dtpbtns = [];
            $.each(depts, function() {  // 构建tab标签 background:#21acef
                var tab = {
                    text: this["DeptName"],
                    id: this["DeptId"],
                    //icon: "/Images/shared/home2.png",
                    handler: function() {
                    frameContent.location.href = "Home3.aspx?DeptId="+this.id;
                    return;
                    if(frameContent.document.getElementById("subFrameContent"))
                        frameContent.document.getElementById("subFrameContent").src = "/Home.aspx?IsManage=T&BlockType=DeptPortal&DeptId=" + this.id;
                    else
                        frameContent.document.getElementById("frameContent").src = "/Home.aspx?IsManage=T&BlockType=DeptPortal&DeptId=" + this.id;
                    }
                }
                dtpbtns.push(tab);
            });
            
            var btn = new Ext.Button({
                id:'deptBtn',
                renderTo: 'btnDeptArea',
                cls:'NEWBT',
                text: '部门门户',
                iconCls: "aim-icon-home",
                menu: dtpbtns
            }); 
                       
            Ext.getCmp("deptBtn").menu.on("itemclick",function(item,e){
                   Ext.getCmp("deptBtn").setText(item.text||'部门门户');
            });
            
            var btn = new Ext.Button({
                id:'linkBtn',
                renderTo: 'btnLinkArea',
                text: '常用下载',
                cls:'NEWBT',
                iconCls: "aim-icon-download",
                handler:function(){ 
                    opencenterwin("/DailyManage/DailyDownLoad.aspx","",1000,600);
                }
            });
            
            var btn = new Ext.Button({
                renderTo: 'btnArea',
                text: '退出',
                cls:'NEWBT',
                iconCls: 'aim-icon-cog',
                menu: [
                    { text: '退出', icon: "/Images/shared/exit.png", handler: function() { document.getElementById("ctl00_BodyHolder_lnkExit").click(); } },
                    { text: '注销', icon: "/Images/shared/trans.gif", handler: function() { document.getElementById("ctl00_BodyHolder_lnkRelogin").click(); } },
                    { text: '修改密码', icon: "/Images/shared/key.png", handler: function() { OpenPwdChgPage(); } },
                    { text: '刷新', icon: "/Images/shared/refresh.gif", handler: function() { document.location.reload();   } },
                    { text: '收藏', icon: "/Images/shared/feed_add.png", handler: function() { addfavor(window.location.href, "综合管理系统"); } }]
            });
            
            function handleActivate(tab) {
                tab = tab || tabPanel.getActiveTab();

                if (!tab) {
                    return;
                }

                var url = tab.href;
                // 首页
                if (tab.code.toUpperCase() != "HOME") {
                    url = $.combineQueryUrl("/SubPortalTree.aspx", "id=" + tab.AID);
                }
                else
                {
                    url = tab.href;
                }
                if (document.getElementById("frameContent"))
                    frameContent.location.href = url;
                else {
                    window.setTimeout("LoadFirstTab('" + url + "');", 100);
                }
                return;
            }
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
        function RedirectEntry()
        {
            var host = window.location.host.split(":")[0];
            window.location.href = "http://"+host+":3230/SysEntry.aspx";
        }
        function SetSysImage() { 
            var sys = $.getQueryString({"ID":"App"});
            var imgurl = "1.gif";
            switch(sys)
            {
                case "EXAMINING":
                imgurl = sys+".gif";
                break;
                case "APPReport":
                imgurl = sys+".gif";
                break;
                case "D_Design":
                imgurl = sys+".gif";
                break;
                case "APPLeaderView":
                imgurl = sys+".gif";
                break;
                default:
                break;
            }
            document.getElementById("imgLogo").src = "images/NPortal/"+imgurl;
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
        
    //<![CDATA[
    //IE 10 兼容性处理
    function __doPostBack(eventTarget, eventArgument) {
        var theForm = document.forms['form1'];
        if (!theForm) {
            theForm = document.form1||document.forms[0];
            if(!document.getElementById("__EVENTTARGET"))
            {
                var h1=document.createElement("input");
                h1.type="hidden";
                h1.id = "__EVENTTARGET"; 
                h1.name = "__EVENTTARGET"; 
                var h2=document.createElement("input");
                h2.type="hidden";
                h2.id = "__EVENTARGUMENT";
                h2.name = "__EVENTARGUMENT";
                theForm.appendChild(h1);
                theForm.appendChild(h2);
            //<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
            //<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
            }
        }
        if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
            theForm.__EVENTTARGET.value = eventTarget;
            theForm.__EVENTARGUMENT.value = eventArgument;
            theForm.submit();
        }
    }
    //]]>
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="main" align="center">
        <div align="center" />
        <table id="__01" width="100%" cellpadding="0" cellspacing="0" style="table-layout: fixed;
            background-color: White;">
            <tr>
                <td width="5" valign="top">
                </td>
                <td>
                    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed;">
                        <tr height="50">
                            <td align="left" width="320">
                                <img src="images/NPortal/1.png" id="imgLogo" />
                            </td>
                            <td valign="top" align="right" style="background: url(images/NPortal/3.png) repeat-x;
                                font-size: 12px;">
                                <table>
                                    <tr>
                                        <td valign="middle" align="right" id="btnLinkArea">
                                        </td>
                                        <td style="color: White">
                                            |
                                        </td>
                                        <td valign="middle" align="right" id="btnDeptArea">
                                        </td>
                                        <td style="color: White">
                                            |
                                        </td>
                                        <td valign="middle" align="left" style="repeat-x" id="btnArea" style="width: 60px">
                                            <asp:LinkButton Visible="false" ID="lnkGoodway" Font-Size="12px" runat="server" ForeColor="White"
                                                OnClick="lnkGoodway_Click">综合管理平台</asp:LinkButton>
                                            <asp:LinkButton ID="lnkRelogin" runat="server" OnClick="lnkRelogin_Click" ForeColor="White"
                                                Style="display: none;" Font-Size="12px">注销</asp:LinkButton>
                                            <asp:LinkButton ID="lnkExit" runat="server" OnClick="lnkExit_Click" ForeColor="White"
                                                Style="display: none;" Font-Size="12px">退出</asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="11" style="background: url(images/NPortal/5.png) norepeat; background-color: none;">
                            </td>
                        </tr>
                        <tr height="32">
                            <td colspan="3">
                                <table width="100%" style="table-layout: fixed; border-collapse: collapse;">
                                    <tr>
                                        <td align="left" width="250">
                                            <img src="images/NPortal/2.png" />
                                        </td>
                                        <td align="right" style="background: url(images/NPortal/4.png) repeat-x">
                                        </td>
                                        <td width="11" style="background: url(images/NPortal/6.png) norepeat">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="5" valign="top">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
