<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="NewHome.aspx.cs" Inherits="IntegratedManage.Web.NewHome" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/NewWeb/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/NewWeb/css/webmain.css" rel="stylesheet" type="text/css" />
    <link href="/NewWeb/css/ddsmoothmenu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/NewWeb/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/NewWeb/js/jquery.KinSlideshow-1.2.1.js"></script>
    <script type="text/javascript" src="/NewWeb/js/webtry_roll.js"></script>
    <script type="text/javascript" src="/NewWeb/js/ddsmoothmenu.js"></script>
    <style type="text/css">
        .myclass a
        {
            color: Red !important;
        }
        .new-img
        {
            width: 8px;
            padding-left: 4px;
        }
        .new-font-family
        {
            font-size: 12px;
            padding-left: 3px;
            padding-right: 5px;
            cursor: pointer;
            white-space: nowrap;
            word-break: keep-all;
            overflow: hidden;
        }
        .new-date
        {
            width: 80px;
            font-size: 12px;
            padding-left: 5px;
            padding-right: 2px;
        }
    </style>
    <script type="text/javascript">
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置; 
            window.open(url, name, 'height=' + iHeight + ',innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        $(function () {
            $("#banner").KinSlideshow({
                moveStyle: "right",
                titleBar: { titleBar_height: 30, titleBar_bgColor: "#000", titleBar_alpha: 0.7 },
                titleFont: { TitleFont_size: 12, TitleFont_color: "#FFFFFF", TitleFont_weight: "normal" },
                btn: { btn_bgColor: "#2d2d2d", btn_bgHoverColor: "#1072aa", btn_fontColor: "#FFF", btn_fontHoverColor: "#FFF", btn_borderColor: "#4a4a4a", btn_borderHoverColor: "#1188c0", btn_borderWidth: 1 }
            });
        });
        function upload() {
            var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
            var uploadurl = '/CommonPages/File/Upload.aspx?IsSingle=true&Filter=' + escape("文件格式") + "(*.jpg;*.png)|*.jpg;*.png";
            var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件
            if (rtn != undefined) {
                var strarray = rtn.split(",");
                if (strarray.length > 0) {
                    for (var i = 0; i < strarray.length; i++) {
                        if (strarray[i]) {
                            $("#userimage").attr("src", "/Document/" + strarray[i]);
                            $.post("?", { "action": "upload", fileId: strarray[i].substring(0, 36) }, function (rtn) {
                            })
                        }
                    }
                }
            }
        }
        window.name = "zhbg_main_page";
        function shownotice(val) {
            opencenterwin("/NewWeb/NoticeView.aspx?id=" + val, "", 1000, 600);
        }
        function showimgnews(val) {
            opencenterwin("/Modules/PubNews/ImgNews/FrmImageNews.aspx?id=" + val, "", 1000, 600);
        }
        function showmylink(url) {
            opencenterwin(url, '', 1000, 600);
        }
        function ViewTask(val) {
            opencenterwin("/workflow/TaskExecuteView.aspx?FormId=" + val, "", 1000, 500);
        }
        function OpenMoreTask() {
            opencenterwin("/WorkFlow/TaskTab.aspx", '', 1000, 600);
        }
        function clicktab(index) {
            $("#span1").attr("src", index == "1" ? "/images/center/yellowD.png" : "/images/center/dbdesk.png");
            $("#span2").attr("src", index == "2" ? "/images/center/yellowY.png" : "/images/center/ydesk.png");
            $("#tasklist1").css("display", index == "1" ? "block" : "none");
            $("#tasklist2").css("display", index == "2" ? "block" : "none");
        }
        function showwin(val) {
            if (val == '1') {
                opencenterwin("/WorkFlow/TaskTab.aspx", "", 1000, 600);
            }
            if (val == '2') {
                opencenterwin("/NewWeb/NoticeTab.aspx", "", 1000, 600);
            }
            if (val == '3') {
                opencenterwin("/NewWeb/ImgNewsList.aspx", "", 1000, 600);
            }
            if (val == '4') {
                opencenterwin("/NewWeb/MyLinkList.aspx", '', 1000, 600);
            }
            if (val == '5') {
                opencenterwin("/Modules/Office/SysMessageTab.aspx", '', 1000, 600);
            }
        }
        function ShowFAQ() {
            opencenterwin("http://192.168.1.208", '', 1000, 600);
        }
        function personalcenter(val, val2) {
            switch (val) {
                case "1":
                    if (val2 == "on") {
                        $("#divTask").css("background-image", $("#divTaskQuan").css("display") == "block" ? "url(/images/center/task3.png)" : "url(/images/center/task4.png)");
                    }
                    else {
                        $("#divTask").css("background-image", $("#divTaskQuan").css("display") == "block" ? "url(/images/center/task2.png)" : "url(/images/center/task.png)");
                    }
                    break;
                case "2":
                    if (val2 == "on") {
                        $("#divNotice").css("background-image", $("#NoticeQuan").css("display") == "block" ? "url(/images/center/notice3.png)" : "url(/images/center/notice4.png)");
                    }
                    else {
                        $("#divNotice").css("background-image", $("#NoticeQuan").css("display") == "block" ? "url(/images/center/notice2.png)" : "url(/images/center/notice.png)");
                    }
                    break;
                case "3":
                    if (val2 == "on") {
                        $("#divMessage").css("background-image", $("#MessageQuan").css("display") == "block" ? "url(/images/center/message3.png)" : "url(/images/center/message4.png)");
                    }
                    else {
                        $("#divMessage").css("background-image", $("#MessageQuan").css("display") == "block" ? "url(/images/center/message2.png)" : "url(/images/center/message.png)");
                    }
                    break;
            }
        }
        function MailTo() {
            var address = "bgRimm@163.com";
        }
        function changeback(val, val2) {
            switch (val) {
                case "1":
                    $("#mykaoqin").attr("src", val2 == "on" ? "/images/center/kq_glide.png" : "/images/center/kq.png");
                    break;
                case "2":
                    $("#mygongshi").attr("src", val2 == "on" ? "/images/center/qjck_glide.png" : "/images/center/qjck.png");
                    break;
                case "3":
                    $("#mygongzi").attr("src", val2 == "on" ? "/images/center/gz_glide.png" : "/images/center/gz.png");
                    break;
                case "4":
                    $("#myrizhi").attr("src", val2 == "on" ? "/images/center/yzrc_glide.png" : "/images/center/yzrc.png");
                    break;
                case "5":
                    $("#mytongxunlu").attr("src", val2 == "on" ? "/images/center/txl_glide.png" : "/images/center/txl.png");
                    break; ///
                default:
                    $("#mysq").attr("src", val2 == "on" ? "/images/center/sq_glide.png" : "/images/center/sq.png");
                    break;
            }
        }
     
    </script>
</head>
<body>
    <script type="text/javascript">
        function OpenNews(NewsUrl) {
            if (arguments.length > 4 && arguments[1] != "") {
                ExecuteTask(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])
            }
            else {
                opencenterwin(NewsUrl, "win0", 1100, 700);
            }
        }
        function ExecuteTask(taskType, wid, flowId, sys, execUrl) {
            var _link = '<%=Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("/portal/Portal.aspx","") %>';
            switch (taskType) {
                case "AuditFlow":
                    if (sys == "Project")
                        _link += '/Project/WorkSpace/PrjNormalTaskBus.aspx?FlowId=' + flowId + "&ItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    else
                        _link += '/workflow/businessframe/TaskBus.aspx?WorkItemId=' + wid + '&PassCode=<%=Session["PassCode"] %>';
                    // OpenWin(_link, "_Blank", CenterWin("width=870,height=650,resizable=yes,scrollbars=yes"));
                    opencenterwin(_link, "win1", 870, 650);
                    break;
                case "AuditTask":
                    _link += '/project/workspace/PrjMyAudit.aspx?FlowId=' + flowId + "&amp;TaskKey=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    //  OpenWin(, "_Blank", CenterWin("width=820,height=600,status=yes"));
                    opencenterwin(_link, "win2", 820, 600);
                    break;
                case "FileFlow":
                    _link += '/workflow/fileflowframe/FileBus.aspx?WorkItemId=' + wid + '&PassCode=<%=Session["PassCode"] %>';
                    //  OpenWin(_link, "_blank", CenterWin("width=820,height=650,scrollbars=yes,resizable=yes"));
                    opencenterwin(_link, "win3", 820, 650);
                    break;
                case "newflow":
                    _link += "/workflow/fileflow/FileBus.aspx?WorkItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    // OpenWin(_link, "_blank", CenterWin("width=820,height=650,scrollbars=yes,resizable=yes"));
                    opencenterwin(_link, "win4", 820, 650);
                    break;
                case "CustomFormFlow":
                    _link += "/workflow/customformflowframe/CustomFormBus.aspx?WorkItemId=" + wid + '&PassCode=<%=Session["PassCode"] %>';
                    opencenterwin(_link, "win4", 820, 650);
                    break;
                case "Questionare":
                    opencenterwin("/SurveyManage/InternetSurveyView.aspx?Id=" + wid, 'Questionare', 1000, 600);
                    break;
                case "MiddleDB":
                    opencenterwin(execUrl + '&SSOID=<%=this.UserSID %>', '_blank', 1000, 700);
                    break;
                default:
                    //LinkTo
                    //("/workflow/businessframe/TaskBus.aspx?WorkItemId=" + wid, "_blank", CenterWin("width=820,height=600,scrollbars=yes"));
                    ExecuteFreeFlow(execUrl, wid, flowId, sys);
                    break;
            }
        }
        function ExecuteFreeFlow(url, wid, flowId, relateType) {
            _link = '<%=Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("/portal/Portal.aspx","") %>' + url + "&WorkItemId=" + wid + "&FlowId=" + flowId + '&PassCode=<%=Session["PassCode"] %>';
            //  OpenWin(_link, "_Blank", CenterWin("width=1000,height=650,scrollbars=yes"));
            opencenterwin(_link, "win65", 1000, 650);
        }
        function MyWorkPlatform(val) {
            switch (val) {
                case "1": //我的考勤
                    opencenterwin('http://192.168.1.45:8010/hr/CheckIng/PersonInfo/PersonFrame.aspx?PassCode=<%=Session["PassCode"] %>', "", 1100, 600);
                    break;
                case "2": //请假查看
                    opencenterwin('http://192.168.1.45:8010/Hr/CheckIng/leave/LeaveListPerson.aspx?PassCode=<%=Session["PassCode"] %>', "", 1100, 600);
                    break;
                case "3": //我的工资
                    opencenterwin('http://192.168.1.45:7002/NewWeb/NoticeView.aspx?id=52577f76-5c4f-4c13-9021-350655819ab9&op=v', "", 1024, 800)

                    // opencenterwin('http://192.168.1.45:8010/hr/Laborage/MyLaborageList.aspx?PassCode=<%=Session["PassCode"] %>', "", 1100, 600);
                    break;
                case "4": //一周日程
                    opencenterwin('http://192.168.1.45:8010/officeauto/ScheduleManage/SmWeekPlanHead.aspx?PassCode=<%=Session["PassCode"] %>', "", 1100, 600);
                    break;
                case "5":
                    opencenterwin('http://192.168.1.45:8010/officeauto/PhoneManage/PhoneLookList.aspx?PassCode=<%=Session["PassCode"] %>', "", 1024, 800);
                    break;
                case "6":
                    opencenterwin('http://192.168.1.45:8010/Hr/CheckIng/leave/LeavePage.aspx?FuncType=Start&PassCode=<%=Session["PassCode"] %>', "", 1100, 600);
                    break;
            }
        }
    </script>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadCalendar1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadCalendar1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <table cellpadding="0" cellspacing="0" width="100%" border="0">
        <tr>
            <td style="width: 25%; padding-right: 5px; padding-left: 5px">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="Images/center/pcenter-login.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            个人中心
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0" style="border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1;">
                    <tr>
                        <td rowspan="4" style="width: 20%; padding-left: 10px">
                            <img src="/images/center/pcenter-person.png" alt="" onclick="upload()" id="userimage"
                                style="width: 79px; height: 94px" runat="server" />
                        </td>
                        <td style="text-align: center">
                            <img style="width: 24px;" src="/images/center/pcenter-smile.png" alt="" />
                        </td>
                        <td style="font-size: 12px; width: 34%">
                            欢迎登录!
                        </td>
                    </tr>
                    <tr style="font-size: 12px;">
                        <td style="text-align: center">
                        </td>
                        <td>
                            <asp:Label ID="lbCurrentUser" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="font-size: 12px;">
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbLastLoginTime" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr style="height: 15px">
                        <td colspan="2">
                        </td>
                    </tr>
                    <tr style="height: 37px">
                        <td colspan="3">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <div id="divTask" style="width: 87px; height: 37px; margin-left: 5px; margin-right: 5px;
                                            text-align: right; vertical-align: top; float: left; cursor: pointer" runat="server"
                                            onclick="showwin(1)" onmouseover="personalcenter('1','on')" onmouseout="personalcenter('1','off')">
                                            <div id="divTaskQuan" style="font-size: 10px; color: White; float: right; width: 17px;
                                                text-align: center; margin-top: 0px; margin-right: 0px" runat="server">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div id="divNotice" style="width: 87px; height: 37px; margin-left: 5px; margin-right: 5px;
                                            text-align: right; vertical-align: top; float: left; cursor: pointer" runat="server"
                                            onclick="showwin(2)" onmouseover="personalcenter('2','on')" onmouseout="personalcenter('2','off')">
                                            <div id="NoticeQuan" style="font-size: 10px; color: White; float: right; width: 17px;
                                                text-align: center; margin-top: 0px; margin-right: 0px" runat="server">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div id="divMessage" style="width: 87px; height: 37px; margin-left: 5px; margin-right: 5px;
                                            text-align: right; vertical-align: top; float: left; cursor: pointer" runat="server"
                                            onclick="showwin(5)" onmouseover="personalcenter('3','on')" onmouseout="personalcenter('3','off')">
                                            <div id="MessageQuan" style="font-size: 10px; color: White; float: right; width: 17px;
                                                text-align: center; margin-top: 0px; margin-right: 0px;" runat="server">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 9px">
                        <td colspan="3">
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 50%; padding-right: 5px">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 83px">
                            <img alt="" src="/images/center/yellowD.png" id="span1" onclick="clicktab('1')" />
                        </td>
                        <td style="width: 83px">
                            <img alt="" src="/images/center/ydesk.png" id="span2" onclick="clicktab('2')" />
                        </td>
                        <td>
                        </td>
                        <td style="width: 60px; vertical-align: middle;">
                            <span style="font-size: 12px; cursor: pointer" onclick="showwin(1)">更多>></span>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(/images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <div id="tasklist1" style="display: block; height: 140px; border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1">
                    <asp:Literal runat="server" ID="litdetail1" /></div>
                <div id="tasklist2" style="display: none; height: 140px; border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1">
                    <asp:Literal runat="server" ID="litdetail2" /></div>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 25%; padding-right: 5px">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-weather.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            天气
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table cellpadding='0' cellspacing='0' width='100%' style='border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1; table-layout: fixed; height: 140px; text-align: center'>
                    <asp:Literal runat="server" ID="Literal4" />
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; padding-right: 5px; padding-left: 5px">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-desk.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            我的工作台
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0" style='border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1; height: 177px'>
                    <tr style="padding-top: 5px; padding-bottom: 5px; text-align: center; height: 50px">
                        <td style="width: 50%">
                            <img alt="" src="/images/center/kq.png" id="mykaoqin" style="cursor: pointer" onmouseover="changeback('1','on')"
                                onmouseout="changeback('1','off')" onclick="MyWorkPlatform('1')" />
                        </td>
                        <td style="width: 50%">
                            <img alt="" src="/images/center/qjck.png" id="mygongshi" style="cursor: pointer"
                                onmouseover="changeback('2','on')" onmouseout="changeback('2','off')" onclick="MyWorkPlatform('2')" />
                        </td>
                    </tr>
                    <tr style="margin-top: 5px; margin-bottom: 5px; text-align: center; height: 50px">
                        <td>
                            <img alt="" src="/images/center/gz.png" id="mygongzi" style="cursor: pointer" onmouseover="changeback('3','on')"
                                onmouseout="changeback('3','off')" onclick="MyWorkPlatform('3')" />
                        </td>
                        <td>
                            <img alt="" src="/images/center/yzrc.png" id="myrizhi" style="cursor: pointer" onmouseover="changeback('4','on')"
                                onmouseout="changeback('4','off')" onclick="MyWorkPlatform('4')" />
                        </td>
                    </tr>
                    <tr style="margin-top: 5px; margin-bottom: 5px; text-align: center; height: 50px">
                        <td>
                            <img alt="" src="/images/center/txl.png" id="mytongxunlu" style="cursor: pointer"
                                onmouseover="changeback('5','on')" onmouseout="changeback('5','off')" onclick="MyWorkPlatform('5')" />
                        </td>
                        <td>
                            <img alt="" src="/images/center/sq.png" id="mysq" style="cursor: pointer" onmouseover="changeback('6','on')"
                                onmouseout="changeback('6','off')" onclick="MyWorkPlatform('6')" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top; padding-right: 5px;">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-new.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            院内新闻
                        </td>
                        <td style="width: 60px; vertical-align: middle">
                            <span style="font-size: 12px; cursor: pointer" onclick="showwin(3)">更多>></span>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(/images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1; height: 177px">
                    <tr>
                        <td style="width: 335px">
                            <div id="banner" runat="server">
                                <asp:Literal ID="litimg" runat="server" />
                            </div>
                        </td>
                        <td style="vertical-align: top">
                            <asp:Literal ID="Literal2" runat="server" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top; padding-right: 5px;">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-calender.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            日历
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0" style="border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1; height: 177px">
                    <tr>
                        <td style="width: 100%">
                            <telerik:RadCalendar ID="RadCalendar1" runat="server" TitleFormat="MMMM yyyy" Width="100%"
                                Skin="Vista" FirstDayOfWeek="Sunday" EnableMultiSelect="false" EnableTheming="true"
                                AutoPostBack="true" OnPreRender="FormatSpecialDay">
                                <SpecialDays>
                                </SpecialDays>
                            </telerik:RadCalendar>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; padding-right: 5px; padding-left: 5px">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-indexbox.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            意见箱
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(/images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0" style='border-left: solid 2px #e1e1e1;
                    border-right: solid 2px #e1e1e1; height: 140px'>
                    <tr>
                        <td style="width: 70%; text-align: center">
                            <a href="MailTO:ywb@bgrimm.com">
                                <img alt="" src="/images/center/ideabox-picture.png" style="width: 130px; height: 120px;
                                    cursor: pointer" /></a>
                        </td>
                        <td style="text-align: right; vertical-align: bottom">
                            <img alt="" src="/images/center/FAQ.jpg" style="width: 80%; height: 25%; cursor: pointer"
                                onclick="ShowFAQ()" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top; padding-right: 5px;">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/center-notice.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold;">
                            通知公告
                        </td>
                        <td style="width: 60px; vertical-align: middle">
                            <span style="font-size: 12px; cursor: pointer" onclick="showwin(2)">更多>></span>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(/images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <asp:Literal runat="server" ID="Literal1"></asp:Literal>
                <table cellpadding="0" cellspacing="0" width="100%" border="0" style="margin-top: -2px">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png)">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top; padding-right: 5px;">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 22px; padding-right: 5px">
                            <img alt="" src="/images/center/link-picture.png" />
                        </td>
                        <td style="font-size: 15px; color: #636363; font-weight: bold">
                            我的链接
                        </td>
                        <td style="width: 60px; vertical-align: middle">
                            <span style="font-size: 12px; cursor: pointer" onclick="showwin(4)">更多>></span>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td style="width: 5px; height: 13px; background-image: url(/images/center/pcenter-up-left.png)">
                        </td>
                        <td style="background-image: url(/images/center/pcenter-up-cenetr.png)">
                        </td>
                        <td style="width: 5px; background-image: url(/images/center/pcenter-up-right.png)">
                        </td>
                    </tr>
                </table>
                <asp:Literal ID="Literal3" runat="server"></asp:Literal>
                <table cellpadding="0" cellspacing="0" width="100%" border="0" style="margin-top: -2px">
                    <tr style="height: 12px">
                        <td style="background: url(/images/center/pcenter-down-left.png); width: 3px">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-center.png);">
                        </td>
                        <td style="background: url(/images/center/pcenter-down-right.png); width: 3px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:Literal ID="Literal5" runat="server"></asp:Literal>
    </form>
</body>
</html>
