<%@ Page Title="任务查看" Language="C#" AutoEventWireup="True" MasterPageFile="~/Masters/Ext/formpage.master"
    CodeBehind="FrmTaskView.aspx.cs" Inherits="IntegratedManage.Web.FrmTaskView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            margin: 0px;
            padding: 0px;
            background-color: White;
        }
        .center-second-up-new
        {
            width: 100%;
            height: 30px;
        }
        .new-img
        {
            width: 3px;
            height: 5px;
            margin-left: 10px;
            margin-top: 5px;
            float: left;
            vertical-align: middle;
        }
        .new-font-family
        {
            font-family: 微软雅黑;
            margin-top: 7px;
            font-size: 12px;
            color: #1c1c1c;
            width: 70%;
            float: left;
            margin-left: 7px;
        }
        .new-date
        {
            font-family: 微软雅黑;
            margin-top: 7px;
            font-size: 12px;
            color: #acacac;
            width: 19%;
            float: right;
        }
    </style>

    <script language="javascript" type="text/javascript">

        function onPgLoad() {
            $("#divContent2").hide();
        }

        function OpenNews(NewsUrl) {
            OpenWin(NewsUrl, "_Blank", CenterWin("width=900,height=550,resizable=yes,scrollbars=yes"));
        }

        function OpenTask() {
            OpenWin("/WorkFlow/TaskTab.aspx", "_Blank", CenterWin("width=1000,height=650,resizable=yes,scrollbars=yes"));
        }

        function clicktab(divtitle1, divtitle2, divname, hiddivname) {
            $("#" + divtitle1).css("color", "black");
            $("#" + divtitle2).css("color", "white");
            $("#" + divname).show();
            $("#" + hiddivname).hide();
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table width="100%">
        <tr>
            <td>
                <div style="width: 82px; height: 24px; cursor: pointer; display: inline;">
                    <div style="background-image: url(/images/center/left.png); width: 6px; height: 24px;
                        float: left">
                    </div>
                    <div style="background-image: url(/images/center/center.png); height: 24px; width: 80%;
                        float: left">
                        <div id="divtitle1" style="font-family: '方正大黑简体'; font-size: 12px; line-height: 24px;
                            color: black; text-align: center;" onclick="clicktab('divtitle1','divtitle2','divContent1','divContent2');">
                            待办任务</div>
                    </div>
                    <div style="background-image: url(/images/center/right.png); width: 6px; height: 24px;
                        float: left">
                    </div>
                </div>
                <div style="width: 82px; height: 24px; cursor: pointer; display: inline;">
                    <div style="background-image: url(/images/center/left.png); width: 6px; height: 24px;
                        float: left">
                    </div>
                    <div style="background-image: url(/images/center/center.png); height: 24px; width: 80%;
                        float: left">
                        <div id="divtitle2" style="font-family: '方正大黑简体'; font-size: 12px; line-height: 24px;
                            color: white; text-align: center;" onclick="clicktab('divtitle2','divtitle1','divContent2','divContent1');">
                            已办任务
                        </div>
                    </div>
                    <div style="background-image: url(/images/center/right.png); width: 6px; height: 24px;
                        float: left">
                    </div>
                </div>
            </td>
            <td>
            </td>
            <td align="right">
                <img src="/images/center/more-size.png" style="cursor: pointer;" alt="查看更多" onclick="OpenTask()" />
            </td>
        </tr>
    </table>
    <div id="divContent1" style="background-image: url(/images/center/h-center.png);
        width: 100%; height: 177px; font-size: 12px;">
        <asp:Literal runat="server" ID="litdetail1" />
    </div>
    <div id="divContent2" style="background-image: url(/images/center/h-center.png);
        width: 100%; height: 177px; font-size: 12px;">
        <asp:Literal runat="server" ID="litdetail2" />
    </div>
    <div>
        <div style="background-image: url(/images/center/pcenter-down-left.png); width: 3px;
            background-repeat: repeat-x; height: 6px; display: inline;">
        </div>
        <div style="background-image: url(/images/center/pcenter-down-center.png); background-repeat: repeat-x;
            height: 6px; width: 99.3%; display: inline;">
        </div>
        <div style="background-image: url( /images/center/pcenter-down-right.png); width: 3px;
            background-repeat: repeat-x; height: 6px; display: inline;">
        </div>
    </div>
</asp:Content>
