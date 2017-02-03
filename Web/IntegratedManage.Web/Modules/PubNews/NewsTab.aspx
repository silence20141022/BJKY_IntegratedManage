<%@ Page Title="项目门户信息" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="NewsTab.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.NewsTab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <script type="text/javascript">

        Ext.onReady(function() {
            var tabArr = new Array();

            function handleActivate(tab) {
                if (document.getElementById("frameContent")) {
                    var url = "NewsList.aspx?checkstate=" + tab.href + "&checktype=" + $.getQueryString({ 'ID': 'checktype' });
                    document.getElementById("frameContent").src = url;
                }
            }

            tabArr.push({
                title: "待审批",
                href: 0,
                listeners: { activate: handleActivate },
                html: "<div style='display:none;'></div>"
            }, {
                title: "已审批",
                href: 1,
                listeners: { activate: handleActivate },
                html: "<div style='display:none;'></div>"
            });

            var tabs = new Ext.TabPanel({
                region: 'north',
                margins: '0 0 0 0',
                activeTab: 0,
                width: document.body.offsetWidth - 5,
                height: 29,
                items: tabArr
            });

            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [{
                    region: 'center',
                    margins: '0 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" ></iframe>'
                }, tabs]
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
