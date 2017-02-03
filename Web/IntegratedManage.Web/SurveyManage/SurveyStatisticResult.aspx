<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="SurveyStatisticResult.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveyStatisticResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        td, body, select, input
        {
            font-size: 12px;
            color: #646464;
            line-height: 18px;
        }
        body
        {
            background-color: White;
        }
        .guid
        {
            filter: dropshadow(color=#FFFFFF,direction=0,offx=1,offy=1);
            width: 100%;
            font-size: 14px;
            font-weight: bold;
            color: #FF6600;
        }
        .header
        {
            background-color: #e0e0e0;
        }
        .discuss
        {
            float: left;
            width: 30px;
            border: solid 1 gray;
            margin: 12px 3px 0px 0px;
        }
        fieldset
        {
            border: solid 2px #ff7800;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        .style1
        {
            width: 374px;
        }
        .headTbl
        {
            border-collapse: collapse;
            font-size: 1em;
            border: 1px solid #98bf21;
            padding: 3px 7px 2px 7px;
        }
    </style>
    <script src="/FusionChart32/FusionCharts.js" type="text/javascript"></script>
    <script type="text/javascript">
        var id = $.getQueryString({ ID: 'Id' });
        var resetedDataArr, records, baseInfo, fillQuestion;
        var counter = 0;            //题目序号
        function onPgLoad() {
            setPageUI();
        }
        function setPageUI() {
            records = AimState["DataList"] || [];
            baseInfo = AimState["SurveyQuestion"];
            fillQuestion = AimState["FillQuestion"] || [];  //必填项

            if (records.length > 0) {
                resetedDataArr = resetData(records);
                setChart();
            }
            if (baseInfo) {
                setBaseInfo(baseInfo);
            }
            if (fillQuestion.length > 0) {
                setFillQuestion(fillQuestion);
            }

        }
        //设置填写项
        function setFillQuestion(obj) {
            var divContaint = "";
            for (var i = 0; i < obj.length; i++) {
                divContaint += "<div style=\"font-size: 15px; font-weight: bold; margin: 10px\"><a href='#'  onclick='showWin(\"" + obj[i]["Id"] + "\")'><span>" + (counter + i + 1) + '.' + obj[i]["Content"] + "【填写项】</span></a></div>";
            }
            $("#result_content").append(divContaint);
        }

        //设置基本信息
        function setBaseInfo(obj) {

            $("#title").text(AimState["SurveyQuestion"]["Title"]);   //title
            $("#DeptName").text(AimState["SurveyQuestion"]["DeptName"]); //发布部门

            $("#IsName").text((obj.IsNoName == "yes" ? "可匿名" : "不匿名"));
            $("#State").text(obj.State != "2" ? "已启动" : "已结束");
            $("#startDate").text(obj.StartTime);
            $("#endDate").text(obj.EndTime);
        }
        //设置Chart
        function setChart() {
            for (var i = 0; i < resetedDataArr.length; i++) {
                var div = "chartdiv_", title, tempItems;
                var chart = " <chart maxLabelWidthPercent='40' yAxisMaxValue='100' numDivLines='0' labelDisplay='WRAP' numberSuffix='%' outCnvbaseFontSize='12' borderAlpha='100' bgColor='#FFFFFF' caption='{caption}' formatNumberScale='0' showBorder='0' canvasBorderThickness='1' canvasLeftMargin='250' canvasBorderColor='#CCCCCC'>{items}</chart>";
                var setItem = "<set label='{item}'  value='{val}' {other} />";

                counter = i + 1;   //题目序号
                title = counter + "." + resetedDataArr[i]["Content"] + "【" + resetedDataArr[i]["QuestionType"] + "】";

                for (var k = 0; k < resetedDataArr[i]["Item"].length; k++) {
                    var tempArr = resetedDataArr[i]["Item"][k].toString().split("|");
                    if (tempArr.length > 0) {
                        var temp = setItem.replaceAll('{item}', tempArr[0]);
                        temp = temp.replaceAll('{val}', tempArr[1]);

                        //点击函数

                        if (tempArr[2] == "是") {
                            var link = "j-showWin-" + tempArr[3];
                            temp = temp.replaceAll('{other}', "link='" + link + "'");
                        } else {
                            var link = "j-showWin1-" + tempArr[3];
                            temp = temp.replaceAll('{other}', "link='" + link + "'");
                            tempItems += temp;
                            // temp = temp.replaceAll('{other}', "");
                        }
                    }
                }

                $("#result_content").append("<div style='margin-left:0px;' id=" + (div + i) + "></div>");

                chart = chart.replaceAll('{caption}', title);
                chart = chart.replaceAll('{items}', tempItems);

                var chartdiv = new FusionCharts('/FusionChart32/Bar2D.swf', title, '700', '180', '0', '1');
                chartdiv.setXMLData(chart);
                chartdiv.render(div + i);

                chart = tempItems = "";  //清空状态
            }
        }
        function resetData(obj) {
            var questionsArr = [], items = []
            var currentQCId = '';
            var questionObj = {};

            for (var i = 0; i < obj.length; i++) {
                items.push(obj[i]["Integ"]);  //$ 符号作为区分
                if (i > 0 && currentQCId != obj[i]["QuestionContentId"]) {
                    questionObj["Qty"] = obj[i - 1]["Qty"];
                    questionObj["IsMustAnswer"] = obj[i - 1]["IsMustAnswer"];
                    questionObj["Content"] = obj[i - 1]["Content"];
                    questionObj["QuestionType"] = obj[i - 1]["QuestionType"];
                    questionObj["QuestionContentId"] = obj[i - 1]["QuestionContentId"];
                    var temp = items.pop();
                    questionObj["Item"] = items;
                    questionsArr.push(questionObj);
                    questionObj = {};
                    items = [];
                    items.push(temp);

                }
                if (i == (obj.length - 1)) {
                    questionObj["Qty"] = obj[i]["Qty"];
                    questionObj["IsMustAnswer"] = obj[i]["IsMustAnswer"];
                    questionObj["Content"] = obj[i]["Content"];
                    questionObj["QuestionType"] = obj[i]["QuestionType"];
                    questionObj["QuestionContentId"] = obj[i]["QuestionContentId"];
                    questionObj["Item"] = items;
                    questionsArr.push(questionObj);
                    questionObj = {};
                    items = [];
                }
                currentQCId = obj[i]["QuestionContentId"];
            }
            return questionsArr;
        }

        //val 选择项ID
        function showWin1(val) {
            $.ajaxExec("GetSlcUser", { ItemId: val, SurveyId: id }, function (rtn) {
                if (rtn && rtn.data.Ents && rtn.data.Ents.length > 0) {
                    var html = "";
                    var arr = rtn.data.Ents;
                    for (var i = 0; i < arr.length; i++) {
                        html += "<b>" + (arr[i]["UserName"] || "") + "</b><br/>";
                    }
                    //html="<div style>"+html+"</div>"
                    win = new Ext.Window({
                        id: 'winremark',
                        title: "选择该项人员",
                        width: 320,
                        height: 240,
                        autoScroll: true,
                        renderTo: Ext.getBody(),
                        html: html,
                        buttons: [{
                            text: '取消',
                            handler: function () {
                                win.close();
                                return;
                            }
                        }]
                    }).show();
                }

            })
        }
        function showWin(val1) {

            var isNoName = baseInfo.IsNoName || '';
            var url = "GetPersonalAdvices.aspx?ItemId=" + val1 + "&ran=" + Math.random() + "&isNoName=" + isNoName;
            opencenterwin(url, "", 735, 360);
        }
        /*  创建fusionchart  end by Phg 20120616*/
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=auto,resizable=yes');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table width="750" height="31" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <b class="guid"><font color="#000000"><span id="title"></span></font></b>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="750" style="margin-top: 20px; margin-bottom: 12px; height: 12px;">
                            <fieldset>
                                <legend>问卷基本信息</legend>
                                <table class="aim-ui-table-edit" width="100%">
                                    <tr>
                                        <td class="aim-ui-td-caption" style="width: 25%">
                                            是否匿名
                                        </td>
                                        <td class="aim-ui-td-data" style="width: 25%">
                                            <span id="IsName">允许</span>
                                        </td>
                                        <td class="aim-ui-td-caption" style="width: 25%">
                                            状态
                                        </td>
                                        <td class="aim-ui-td-data" style="width: 25%">
                                            <span id="State">未完成</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="aim-ui-td-caption" style="width: 25%">
                                            开始时间
                                        </td>
                                        <td class="aim-ui-td-data" style="width: 25%">
                                            <span id="startDate">2012-12-12</span>
                                        </td>
                                        <td class="aim-ui-td-caption" style="width: 25%">
                                            结束时间
                                        </td>
                                        <td class="aim-ui-td-data" style="width: 25%">
                                            <span id="endDate">2012-11-12</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="aim-ui-td-caption" style="width: 25%">
                                            发起部门
                                        </td>
                                        <td class="aim-ui-td-data" style="width: 90%" colspan="4">
                                            <span id="DeptName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="aim-ui-td-data" style="width: 25%" colspan="4">
                                            说明:当鼠标指针变为手状指针时,可点击查看该问题项的评论.
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="750" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="E0E0E0">
                                        </table>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td width="100%">
                                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                            <tr valign="top">
                                                <td width="100%" id="SurveyList">
                                                    <%---------------------------------------%>
                                                    <fieldset>
                                                        <legend>统计信息</legend>
                                                        <div class="result_content" id="result_content" style="height: 600px; text-align: center">
                                                        </div>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td height="12">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
