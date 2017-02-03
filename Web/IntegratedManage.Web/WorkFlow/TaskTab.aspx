<%@ Page Title="办理任务列表" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="TaskTab.aspx.cs" Inherits="Aim.Portal.Web.WorkFlow.TaskTab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            margin: 2px;
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
            border-right: 1px dotted;
            padding-left: 10px;
            padding-right: 10px; /*background-color:Gray;*/
        }
    </style>

    <script type="text/javascript">
        var mdls;
        function onPgLoad() {
            mdls = [{ Name: "待办任务", Url: "TaskList.aspx?Status=0" }, { Name: "已办任务", Url: "TaskList.aspx?Status=1"}];
            setPgUI();
        }
        function setPgUI() {
            var tabArr = new Array();
            var FrameHtml = "";
            // 构建tab标签
            $.each(mdls, function() {
                var tab = {
                    title: this["Name"],
                    href: this["Url"],
                    listeners: { activate: handleActivate },
                    margins: '0 0 0 0',
                    border: false,
                    layout: 'border',
                    html: "<div style='display:none;'></div>"
                }
                tabArr.push(tab);
            });

            // 用于tab过多时滚动
            var scrollerMenu = new Ext.ux.TabScrollerMenu({
                menuPrefixText: '项目',
                maxText: 15,
                pageSize: 5
            });

            var tabPanel = new Ext.ux.AimTabPanel({
                enableTabScroll: true,
                border: true,
                defaults: { autoScroll: true },
                plugins: [scrollerMenu],
                region: 'north',
                margins: '-1 0 0 0',
                activeTab: 0,
                width: document.body.offsetWidth - 5,
                height: 10,
                items: tabArr
            });
            var viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [tabPanel, {
                    region: 'center',
                    margins: '-2 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'
}]
                });
                if (document.getElementById("frameContent")) {
                    frameContent.location.href = "TaskList.aspx?Status=0";
                }
            }
            function handleActivate(tab) {
                tab = tab || tabPanel.getActiveTab();
                if (document.getElementById("frameContent")) {
                    frameContent.location.href = tab.href;
                }
            }           
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
