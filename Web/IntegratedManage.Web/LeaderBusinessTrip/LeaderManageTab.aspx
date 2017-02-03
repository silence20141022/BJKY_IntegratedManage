<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="LeaderManageTab.aspx.cs" Inherits="IntegratedManage.Web.LeaderManageTab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script type="text/javascript">
        var tableData, columnData, store, tabs, tlBar, tabpanel;
        var titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            // 初始化tooltip
            Ext.apply(Ext.QuickTips.getQuickTip(), { dismissDelay: 0 });
            tabs = ["日历视图", "列表视图"];
            tabArray = [];
            for (var a = 0; a < tabs.length; a++) {
                var tab = {
                    title: tabs[a],
                    tooltip: a,
                    listeners: { activate: handleActivate },
                    autoScroll: true,
                    border: false,
                    layout: 'border',
                    html: "<div style='display:none;'></div>"
                };
                tabArray.push(tab);
            }
            tabpanel = new Ext.TabPanel({
                enableTabScroll: true,
                border: true,
                region: 'north',
                activeTab: 0,
                items: [tabArray]
            });
            var viewport = new Ext.ux.AimViewport({
                items: [tabpanel, {
                    region: 'center',
                    margins: '-2 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'
                }]
            });
            if (document.getElementById("frameContent")) {
                frameContent.location.href = "LeaderCalendarView.aspx?Index=0";
            }
        }

        function handleActivate(tab) {
            if (document.getElementById("frameContent")) {
                switch (tab.title) {
                    case "日历视图":
                        frameContent.location.href = "LeaderCalendarView.aspx?Index=0";
                        break;
                    case "列表视图":
                        frameContent.location.href = "NotePadList.aspx?Index=0";
                        break;

                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
