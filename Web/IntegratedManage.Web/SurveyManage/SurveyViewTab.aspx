<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SurveyViewTab.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveyViewTab" %>

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

            tabs = ["新调查问卷", "历史记录"] || [];
            tabArray = [];
            for (var a = 0; a < tabs.length; a++) {
                var tab = {
                    title: tabs[a],
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
                heigth: 50,
                items: [tabArray]
            });


            var viewport = new Ext.ux.AimViewport({
                items: [tabpanel, {
                    region: 'center',
                    margins: '-2 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'}]
                });
                if (document.getElementById("frameContent")) {
                    frameContent.location.href = "SurveyView_No.aspx?Index=0";
                }
            }

            function handleActivate(tab) {
                if (document.getElementById("frameContent")) {
                    if (tab.title == "新调查问卷") {
                        frameContent.location.href = "SurveyView_No.aspx?Index=0";
                    } else if (tab.title == "历史记录") {
                        frameContent.location.href = "InteSurveyViewList.aspx?Index=0" + "&op=" + pgOperation;
                    }
                }
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
