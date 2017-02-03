<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="Home3.aspx.cs" Inherits="Aim.Examining.Web.Home3" Title="��ҳ" %>

<%@ Import Namespace="Aim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/css/Portal.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/Portal.js" type="text/javascript"></script>

    <script src="/js/ext/ux/PortalColumn.js" type="text/javascript"></script>

    <script src="/js/ext/ux/Portlet.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            margin: 2px;
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFBFF,endColorStr=#C7D7FF);
            color: #003399;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }
        #header
        {
            background-color: #BAD1EF;
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#BAD1EF,endColorStr=#8DB2E3);
        }
        .tab_item
        {
            font-size: 15;
            border: 0px;
            border-right: 1px dotted;
            padding-left: 10px;
            padding-right: 10px; /*background-color:Gray;*/
        }
        .info_panel
        {
            padding: 10px;
            font-size: 12px;
        }
        .info_panel hr
        {
            color: gray;
            height: 1px;
        }
        .panelSearch
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr=#ffffff, endColorStr=#000000, gradientType=0);
        }
    </style>

    <script type="text/javascript">

        var InfoPopupStyle;
        var InfoTmpl;

        function onPgLoad() {
            InfoPopupStyle = CenterWin("width=850,height=600,scrollbars=yes");
            InfoTmpl = buildInfoTemplate();

            setPgUI();
        }

        function setPgUI() {
            var infoPanels = [];

            /*var panelSearch = new Ext.ux.AimPanel({
            border: true,
            title: "��������",
            paddings: '5 0 0 0 ',
            html: "<table width=100%><tr width=100%><td align=center><select style=width:120px id=selSearch></select></td></tr><tr width=100%><td align=center><input id=txtSearch style=width:120px;/></td></tr><tr width=100%><td align=center><input type=button id=btnSearch value=ִ�� class='aim-ui-button' style='cursor:hand;'/></td></tr></table>"
            });
            infoPanels.push(panelSearch);
            panelSearch = new Ext.ux.AimPanel({
            border: true,
            title: "�����½�",
            paddings: '5 0 0 0 ',
            html: "<table width=100%><tr width=100%><td align=center><select style=width:120px id=selAddNew><option value=>�½�...</option></select></td></tr><tr width=100%><td align=center><input id=btnAddNew type=button value=ִ�� class='aim-ui-button' style='cursor:hand;'/></td></tr></table>"
            });
            infoPanels.push(panelSearch);
            */
            var tsk = $.getJsonObj(AimState["Tasks"]) || [];
            tsk[0].iconUrl = "/images/Iphone/15.ico";
            var recs = (tsk);
            recs.push({ title: '��Ϣ����', count: AimState["MsgCount"] || "0", url: '/Modules/Office/SysMessageTab.aspx', iconUrl: '/images/Iphone/1.ico' });
            recs.push({ title: '����֪ͨ', count: AimState["NewsCount"] || "0", url: 'Modules/PubNews/NewsList.aspx?op=r', iconUrl: '/images/Iphone/2.ico' });
            pal = buildInfoView({ title: '�칫��Ϣ����', url: '/workflow/TaskTab.aspx?TypeId={id}', mappings: { 'id': 'Id' }, records: recs });
            infoPanels.push(pal);
            //pal = buildInfoView({ title: '��Ϣ����', url: '', records: [{ title: '��Ϣ����', count: AimState["MsgCount"] + "��" || "0", url: '/Modules/Office/SysMessageTab.aspx'}] });
            //infoPanels.push(pal);


            //��ҵ���
            /*var recordsArr = [];
            recordsArr.push({ title: '�ҵĲ߻�', count: null, url: '/EPC/WBS/PrjWbs.aspx', style: CenterWin("width=800,height=600,scrollbars=yes") });
            pal = buildInfoView({ title: '��ҵ', url: '', records: recordsArr });
            infoPanels.push(pal);*/

            //var pal = buildInfoView({ title: '��˾��Ѷ', url: '/Modules/PubNews/NewsList.aspx?TypeId={id}', mappings: { 'id': 'Id' }, records: ($.getJsonObj(AimState["News"]) || []) });
            //infoPanels.push(pal);
            var pal = buildInfoView({ ICO: true, title: '�ҵĿ��<span style=width:95px></span><span onclick="showshort()" style=cursor:hand;color:blue;>����</span>', url: '{url}', mappings: { 'url': 'ModuleUrl', 'fileid': 'fileid' }, records: ($.getJsonObj(AimState["ShortCut"]).length > 0 ? $.getJsonObj(AimState["ShortCut"]) : [{}]) });
            infoPanels.push(pal);
            //��Ŀ���
            //recordsArr = [];
            //recordsArr.push({ title: '��̱�', count: null, url: '/EPC/Schedule/PRJ_MilestoneList.aspx' });
            //recordsArr.push({ title: '�ļ�', count: null, url: '/EPC/Document/DocManager.aspx', style: CenterWin("width=800,height=600,scrollbars=yes") });
            //recordsArr.push({ title: '��Ŀ���ñ���', count: null, url: '/EPC/Common/Report/PRJ_Report.aspx?rpt=cost', style: CenterWin("width=800,height=600,scrollbars=yes") });
            //recordsArr.push({ title: '����', count: AimState["MsgCount"] || 0, url: '/Modules/Office/SysMessageList.aspx?TypeId=Receive' });
            //recordsArr.push({ title: '����', count: AimState["MsgCount"] || 0, url: '/Modules/Office/SysMessageList.aspx?TypeId=Receive' });
            //recordsArr.push({ title: '����', count: AimState["MsgCount"] || 0, url: '/Modules/Office/SysMessageList.aspx?TypeId=Receive' });
            //pal = buildInfoView({ title: '��Ŀ', url: '', records: recordsArr });
            //infoPanels.push(pal);
            //��վ����
            var linkHTML = "<div class=info_panel>";
            linkHTML += '<b style="color:black;">�ҵ�����<span style=width:95px></span><span onclick="weblinks()" style=cursor:hand;color:blue;>����</span></b>';
            linkHTML += '<hr />';
            linkHTML += '<span style="width:80%;"><select style="width:100%" onchange=if(this.value)window.open(this.value,"_blank")>';
            linkHTML += '<option>��ѡ��...</option>';
            for (var i = 0; i < AimState["WebLinks"].length; i++) {
                linkHTML += '<option value=' + AimState["WebLinks"][i].Url + '>' + AimState["WebLinks"][i].WebName + '</option>';
            }
            linkHTML += '</select></span>';
            linkHTML += '<div>';
            var lView = new Ext.ux.AimDataView({
                itemSelector: 'p',
                html: linkHTML,
                border: false,
                margins: '5 5 5 5'
            });
            infoPanels.push(lView);
            var url = "/home.aspx?BlockType=Portal";
            if ($.getQueryString({ ID: "DeptId", DefaultValue: "" }) != "") {
                url = "/Home.aspx?BlockType=DeptPortal&DeptId=" + $.getQueryString({ ID: "DeptId", DefaultValue: "" });
            }
            portalPanel = new Ext.ux.AimPanel({
                layout: 'border',
                region: 'center',
                /*tbar: { xtype: 'aimtoolbar', items: [{ iconCls: 'aim-icon-user-edit' }, { html: '<b>�ҵĸ�����ҳ</b>', xtype: 'tbtext' }, '->', { iconCls: 'aim-icon-help', tooltip: '����'}] },*/
                items: [
                { id: 'infoView',
                    border: true,
                    resizable: true,
                    collapsible: true, autoScroll: true, iconCls: 'aim-icon-info', region: 'east', width: 220, margins: '2 0 0 0',
                    items: infoPanels
                }, { region: 'center', autoScroll: true, margins: '2 0 0 0', html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" src="' + url + '"></iframe>' }
                ]
            });

            // ҳ����ͼ
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [portalPanel]
            });
            //BindFucSelect();
        }
        //��������
        var tempInternalAdd = 0;
        var tempInternalSearch = 0;
        function BindFucSelect() {
            var addNews = AimState["ModulesCreate"];
            for (var i = 0, len = addNews.length; i < len; i++) {
                var option = new Option(addNews[i].Name, addNews[i].Url);
                if ($.browser.msie) {
                    document.getElementById("selAddNew").options.add(option);
                }
                else {
                    document.getElementById("selAddNew").options.add(option);
                }
            }
            $("#btnAddNew").click(function() {
                tempInternalAdd = 0;
                if ($("#selAddNew").val() != "") {
                    document.getElementById("frameContent").src = $("#selAddNew").val();
                    var delayedTask = new Ext.util.DelayedTask();
                    delayedTask.delay(400, AddNewFire, this, [this, $("#txtSearch").val(), $("#selAddNew").val()]);
                }
            });
            var addNews = AimState["ModulesSearch"];
            for (var i = 0, len = addNews.length; i < len; i++) {
                var option = new Option(addNews[i].Name, addNews[i].Url);
                if ($.browser.msie) {
                    document.getElementById("selSearch").options.add(option);
                }
                else {
                    document.getElementById("selSearch").options.add(option);
                }
            }
            $("#btnSearch").click(function() {
                tempInternalSearch = 0;
                document.getElementById("frameContent").src = "/SearchBus.aspx";
                var delayedTask = new Ext.util.DelayedTask();
                delayedTask.delay(400, SearchResult, this, [this, $("#txtSearch").val(), $("#selSearch").val()]);
            });
        }
        function AddNewFire() {
            tempInternalAdd++;
            if (tempInternalAdd == 5) return;
            if (document.getElementById("frameContent").contentWindow && document.getElementById("frameContent").contentWindow.location.href.indexOf(arguments[2]) >= 0 && document.getElementById("frameContent").contentWindow.document.body.readyState == "complete") {
                var inputsall = document.getElementById("frameContent").contentWindow.$("button");
                if (inputsall)
                    $.each(inputsall, function() {
                        if (this.innerText == "���") {
                            this.click();
                        }
                    });
            }
            else {
                var delayedTask = new Ext.util.DelayedTask();
                delayedTask.delay(400, AddNewFire, arguments[0], [arguments[0], arguments[1], arguments[2]]);
            }
        }
        function SearchResult() {
            tempInternalSearch++;
            if (tempInternalSearch == 5) return;
            if (document.getElementById("frameContent").contentWindow && document.getElementById("frameContent").contentWindow.location.href.indexOf(arguments[2]) >= 0 && document.getElementById("frameContent").contentWindow.document.body.readyState == "complete") {
                if (document.getElementById("frameContent").contentWindow.Ext.getCmp("defaultFullSearch")) {
                    document.getElementById("frameContent").contentWindow.Ext.getCmp("defaultFullSearch").el.dom.value = $("#txtSearch").val();
                    document.getElementById("frameContent").contentWindow.Ext.getCmp("defaultFullSearch").onTrigger2Click(); return;
                }
                /*
                var inputsall = document.getElementById("frameContent").contentWindow.$("input");
                if(inputsall)
                $.each(inputsall, function() {
                if (this.qryopts == "{ type: 'fulltext' }") {
                this.value = $("#txtSearch").val();
                document.getElementById("frameContent").contentWindow.Ext.getCmp("defaultFullSearch").onTrigger2Click();
                }
                });*/
            }
            else {
                var delayedTask = new Ext.util.DelayedTask();
                delayedTask.delay(400, SearchResult, arguments[0], [arguments[0], arguments[1], arguments[2]]);
            }
        }

        function buildInfoView(opts) {
            var fields = ['title', 'count', 'id', 'url', 'style', 'fileid','iconUrl'];
            var mappings = opts["mappings"] || {};

            var opts = opts || {};
            var store = opts.store;
            var data = opts.data || [];

            if (!store) {
                if (!opts.data && opts.records) {
                    data = { records: opts.records };
                } else {
                    data = opts.data;
                }

                $.each(data.records, function() {
                    for (var key in mappings) {
                        if (mappings[key] && !this[key]) {
                            this[key] = this[mappings[key]];
                        }
                    }
                });

                store = new Ext.ux.data.AimJsonStore({ fields: fields, data: data });
            }

            var tpl = opts.tmpl || buildInfoTemplate(opts);
            if (opts.ICO) tpl = buildInfoTemplateICO(opts);

            var view = new Ext.ux.AimDataView({
                store: store,
                itemSelector: 'p',
                tpl: tpl,
                border: false,
                margins: '5 5 5 5'
            });

            return view;
        }

        function buildInfoTemplate(opts) {
            var opts = opts || {};
            var title = opts.title || '';
            // var colcount = opts.colcount || 2;
            url = $.combineQueryUrl(opts.url, "op=r");
            var tpl = new Ext.XTemplate(
                    '<div class="info_panel">',
                    '<b style="color:black;">' + title + '</b>',
                    '<hr />',
                    '<tpl for=".">',
                    '<span style="width:50%;cursor:hand;align:center" onclick=\'OpenWin("',
                    '<tpl if="url">',
                    '{url}',
                    '</tpl>',
                    '<tpl if="!url">',
                    url,
                    '</tpl>',
                    '", "_blank", "',
                    '<tpl if="style">',
                    '{style}',
                    '</tpl>',
                    '<tpl if="!style">',
                    InfoPopupStyle,
                    '</tpl>',
                     '")\'>',
                    '<tpl if="iconUrl">',
                    '<img src="{iconUrl}" width=64px height=64px border=0>',
                    '</tpl>',
                    '<br/>',
                    '<a href="#" >&nbsp;',
                    '{title}',
            //'<tpl if="count">',
                    '<font color=red>({count})</font>&nbsp;',
            //'</tpl>',
                    '</a></span>',
                    '</tpl>',
                    '<div>'
                );

            return tpl;
        }
        function buildInfoTemplateICO(opts) {
            var opts = opts || {};
            var title = opts.title || '';
            // var colcount = opts.colcount || 2;
		    //url=$.combineQueryUrl(opts.url, "op=r&PassCode=<%=Session["PassCode"] %>");
            var tpl = new Ext.XTemplate(
                    '<div class="info_panel">',
                    '<b style="color:black;">' + title + '</b>',
                    '<hr />',
                    '<tpl for=".">',
                    '<span style="width:50%;">',
                    '<tpl if="fileid">',
                    '<img src="{fileid}">',
                    '</tpl>',
                    '<a href="#" onclick=\'OpenWin("',
                    '<tpl if="url">',
                    url,
                    '</tpl>',
                    '<tpl if="!url">',
                    url,
                    '</tpl>',
                    '", "_blank", "',
                    '<tpl if="style">',
                    '{style}',
                    '</tpl>',
                    '<tpl if="!style">',
                    InfoPopupStyle,
                    '</tpl>',
                     '")\'>&nbsp;',
                     '<tpl if="count">',
                    '({count})&nbsp;',
                    '</tpl>',
                    '{title}</a></span>',
                    '</tpl>',
                    '<div>'
                );

            return tpl;
        }
        function showshort() {
            OpenWin("/DailyManage/MyAuthTree.aspx?Role=User&type=user", "_blank", CenterWin("width=300,height=650,scrollbars=yes"));
        }
        function weblinks() {
            OpenWin("/DailyManage/WebLink.aspx", "_blank", CenterWin("width=900,height=450,scrollbars=yes"));
        }
        
        function OpenWin(url, target, style) {
            url=$.combineQueryUrl(url, "op=r&PassCode=<%=Session["PassCode"] %>");
            var desurl = url;
            
            var win = null;
            if (desurl == null || desurl == "") {
                return false;
            }
            if (desurl.indexOf("{") != -1) {
                var param = returnUrl.substring(desurl.indexOf("{") + 1, desurl.indexOf("}"));
                var value = AppServer[param];
                desurl = desurl.replace("{" + param + "}", value);
            }
            try { var target = eval(target); } catch (e) { }
            if (!target || target == "null" || target == "_SELF") {
                window.location.href = desurl;
                //=================

                var sp = new StringParam(style.toLowerCase(), ",", "=");
                var width = parseInt(sp.Get("width").replace("px", ""));
                var height = parseInt(sp.Get("height").replace("px", ""));
                var x = (screen.availWidth - width) / 2;
                var y = (screen.availHeight - height) / 2;
                window.resizeTo(width, height);
                window.moveTo(x, y);
                //=================

            } else if (typeof (target) == "object") {
                target.location.href = desurl;
                win = target;
            } else if (typeof (target) == "string") {

                if (!style) style = "compact";
                else {
                    if (style.indexOf('resizable') < 0) {
                        style += ",resizable=yes";
                    }
                }
                if (target == "")
                    target = "_SELF";
                if (target.toUpperCase() == "_BLANK") {
                    win = window.open(desurl, "", style);
                    //=======
                    //            var sp = new StringParam(style.toLowerCase(), ",", "=");
                    //            var width = parseInt(sp.Get("width").replace("px", ""));
                    //            var height = parseInt(sp.Get("height").replace("px", ""));
                    //            if (win.document.body.scrollHeight >= height) return;
                    //            win.resizeTo(width, win.document.body.scrollHeight);
                    //========= 
                }
                else {
                    win = window.open(desurl, target, style);
                }
                if (!win) alert("�������ڱ���ֹ��");
                //}		
                //win = window.open(desurl,target,style);
            }
            if (win) return win;
       }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            �ҵĸ�����ҳ</h1>
    </div>
</asp:Content>
