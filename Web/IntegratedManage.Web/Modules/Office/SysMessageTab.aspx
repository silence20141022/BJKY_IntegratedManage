<%@ Page Title="消息管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SysMessageTab.aspx.cs" Inherits="Aim.Portal.Web.Office.SysMessageTab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var according = null;
        var view = null;
        Ext.onReady(function() {
            /*var tabArr = new Array();
            var tab = null;
            for (var i = 0; i < AimState["Types"].length; i++) {
            var node = AimState["Types"][i];
            tab = {
            title: node["TypeName"],
            href: node["Id"],
            listeners: { activate: handleActivate },
            html: "<div style='display:none;'></div>"
            }
            tabArr.push(tab);

            }*/
            var tabs = [{
                title: "未读消息",
                href: "Receive",
                listeners: { activate: handleActivate },
                margins: '0 0 0 0',
                border: false,
                layout: 'border',
                html: "<div style='display:none;'></div>"
            }, {
                title: "已读消息",
                href: "ReceiveReaded",
                listeners: { activate: handleActivate },
                margins: '0 0 0 0',
                border: false,
                layout: 'border',
                html: "<div style='display:none;'></div>"
            }, {
                title: "草稿箱[未发送]",
                href: "ToSend",
                listeners: { activate: handleActivate },
                margins: '0 0 0 0',
                border: false,
                layout: 'border',
                html: "<div style='display:none;'></div>"
            }, {
                title: "已发送消息",
                href: "Send",
                listeners: { activate: handleActivate },
                margins: '0 0 0 0',
                border: false,
                layout: 'border',
                html: "<div style='display:none;'></div>"
            }];
                var tabs2 = new Ext.ux.AimTabPanel({
                    enableTabScroll: true,
                    border: true,
                    defaults: { autoScroll: true },
                    region: 'north',
                    margins: '-1 0 0 0',
                    width: document.body.offsetWidth - 5,
                    height: 10,
                    items: tabs
                });

                function handleActivate(tab) {
                    if (document.getElementById("frameContent")) {
                        document.getElementById("frameContent").src = "SysMessageList.aspx?TypeId=" + tab.href;
                    }
                }

                var viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [tabs2, {
                        region: 'center',
                        margins: '-2 0 0 0',
                        cls: 'empty',
                        bodyStyle: 'background:#f1f1f1',
                        html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0" src="SysMessageList.aspx?TypeId=Receive"></iframe>'
}]
                    });
                    view = viewport;
                });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
