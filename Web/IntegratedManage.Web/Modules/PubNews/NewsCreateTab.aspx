<%@ Page Title="项目门户信息" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="NewsCreateTab.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.NewsCreateTab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var according = null;
        var view = null, op;

        Ext.onReady(function() {
            op = $.getQueryString({ 'ID': 'op' });

            var tabArr = new Array();
            var tab = null;

            for (var i = 0; i < AimState["Types"].length; i++) {
                var node = AimState["Types"][i];

                if (node.IsEfficient == '0') {
                    continue;
                }

                tab = {
                    title: node["TypeName"],
                    href: node["Id"],
                    listeners: { activate: handleActivate },
                    html: "<div style='display:none;'></div>"
                }
                tabArr.push(tab);

            }
            var tabs2 = new Ext.TabPanel({
                region: 'north',
                margins: '0 0 0 0',
                activeTab: 0,
                width: document.body.offsetWidth - 5,
                height: 29,
                items: tabArr
            });

            function handleActivate(tab) {
                if (document.getElementById("frameContent")) {
                    /*if (frameContent.reloadPage)
                    frameContent.reloadPage.call(this, { cid: tab.href });
                    else {*/
                    var url = "NewsCreateList.aspx?TypeId=" + tab.href;
                    if (op) {
                        url = $.combineQueryUrl(url, { op: op });
                    }
                    if (tab.title == "图片新闻") {
                        document.getElementById("frameContent").src = "ImgNews/FrmImgNewsCreateList.aspx?TypeId=" + tab.href;
                    }
                    else if (tab.title == "视频新闻") {
                        document.getElementById("frameContent").src = "VideoNews/FrmVideoNewsCreateList.aspx?TypeId=" + tab.href;
                    }
                    else {
                        document.getElementById("frameContent").src = url;
                    }
                    //}
                }
            }

            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [{
                    region: 'center',
                    margins: '0 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" src="NewsList.aspx"></iframe>'
                }, tabs2]
            });
            view = viewport;
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
