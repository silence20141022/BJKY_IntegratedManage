<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SubPortalApp.aspx.cs" Inherits="IntegratedManage.Web.SubPortalApp" %>

<%@ OutputCache Duration="1" VaryByParam="None" %>
<%@ Import Namespace="Aim" %>
<asp:Content ID="HeadHolder" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <style type="text/css">
        /* .x-panel-header-default, .x-panel-header1 {
    color:#333;
	font-weight:bold; 
    font-size: 14px;
    padding-left:35px;
    height: 30px;
    font-family: tahoma,arial,verdana,sans-serif;
    border-color:#d0d0d0;
    background-image: url(/images/tree_head_bg.png);tahoma,arial,verdana,sans-serif
}*/.x-accordion-hd
        {
            color:white;
            font-weight: bold;
            font-size: 14px;
            padding-left: 35px;
            height: 30px;
            font-family:tahoma;
            border-color: #d0d0d0;
            background-image: url(/images/tree_head_bg.png);
            background-repeat: repeat-y;
            background-position-y: 0px;
            padding-top: 10px;
        }
    </style>

    <script type="text/javascript">
        var ItemTemplage = "<li><a href='{Url}' target='subFrameContent'>{Title}</a></li>";    // 列表模版
        var accordion;
        var curMdl, subMdls;

        function onPgLoad() {
            //curMdl = AimState["Module"] || {};   // 当前模块
            //subMdls = AimState["SubModules"] || {}; // 子孙模块

            setPgUI();

            //subFrameContent.location.href = curMdl["Url"] || "about:blank";
            //if (!curMdl["Url"] && $('.accordion-nav li a')[0]) {
            //    $('.accordion-nav li a')[0].click();
            //}
        }

        function setPgUI() {
            var items = GetAccordionItems();

            tools = [{ id: 'gear',
                handler: function() {
                    Ext.Msg.alert('Message', 'The Settings tool was clicked.');
                }
}];

                accordion = new Ext.ux.AimPanel({
                    region: 'west',
                    // title: curMdl['Name'],
                    title: '<div class="aim-icon-help" style="cursor:hand;" onclick="doHelp();" title="帮助">&nbsp;</div>',
                    margins: '0 2 0 0',
                    collapsible: true,
                    collapsed: items.length == 0 ? true : false,
                    border: false,
                    width: 160,
                    layout: 'accordion',
                    // tools: tools,
                    items: items || []
                });

                viewport = new Ext.ux.AimViewport({
                    layout: 'border',
                    items: [
                accordion, {
                    region: 'center',
                    border: false,
                    margins: '0 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="subFrameContent" name="subFrameContent" frameborder="0" src="Home.aspx?BlockType=Portal"></iframe>'
}]
                });

                $('.accordion-nav li a').click(function(ev) {
                    $('.accordion-nav li a.selected').removeClass('selected');
                    $(this).addClass('selected');
                });
            }

            function doHelp() {

            }

            function collapseAccordion(flag) {
                if (flag) {
                    accordion.collapse(true);
                } else {
                    accordion.collapse(true);
                }
            }

            function GetAccordionItems() {
                var items = [];

                $.each(AimState["Modules"], function() {
                    var item = new Ext.Panel({
                        title: "<b>" + this.Name + "<b>",
                        html: '<iframe width="100%" height="100%" id="FrameTree' + this.Code + '" name="FrameTree' + this.Code + '" frameborder="0" src="SubPortalTree.aspx?id=' + this.ApplicationID + '"></iframe>', /*GetChildrenLis(this.ModuleID, subMdls),*/
                        cls: 'accordion-nav',
                        listeners: {
                            afterrender: function(panel) {
                                var header = panel.header;
                                //header.setHeight(30);
                                //header.applyStyles("background-image: url(/images/tree_head_bg.png)");
                            }
                        }

                    });
                    //item.setStyle({ background: 'url(/images/tree_head_bg.png)' });
                    items.push(item);
                });

                return items;
            }

            // 获取子节点列表
            function GetChildrenLis(mid, subMdls) {
                var html = "";

                $.each(subMdls, function() {
                    if (this.ParentID == mid) {
                        html += ItemTemplage.replace("{Url}", this.Url).replace("{Title}", this.Name);
                    }
                });

                return html;
            }

            function OpenContentUrl(tab) {

            }
    </script>

</asp:Content>
<asp:Content ID="BodyHolder" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
