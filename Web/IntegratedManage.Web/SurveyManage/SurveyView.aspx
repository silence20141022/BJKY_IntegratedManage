<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="SurveyView.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveyView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        td, body, select, input
        {
            font-size: 12px;
            color: #000000;
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
        .formCtl
        {
            width: 100%;
            padding-left: 12px;
        }
        .question_textarea
        {
            width: 450;
            margin-top: 5px;
            margin-left: 10px;
        }
        .IsExplanation
        {
            border: none;
            width: 360;
            margin-left: 5px;
            border-bottom: 1px #000000 solid;
        }
    </style>

    <script type="text/javascript">
        var id = $.getQueryString({ ID: 'Id' });
        //        var title = unescape($.getQueryString({ ID: 'Title' }));
        var records, survey;
        function onPgLoad() {
            renderView();
            setPageUI();

        }
        function setPageUI() {
            pgOperation == 'v' ? $("#btnDiv").hide() : '';
            $(".discuss").click(function() { /*是否评论*/
                $(this).parent().append("<textarea rows=3 style='float: left; width: 415;'" + " name=" + $(this).attr("name") + "/>")
                $(this).unbind("click");
            });
        }

        function renderView() {
            records = AimState["ItemList"] || [];
            survey = AimState["Survey"][0] || {};
            // $("#title").text(title);                                       
            !!survey["Contents"] && $("#content").text('').text(survey["Contents"]);  //设置说明
            var recordsObj = eval("(" + records + ")") || [];
            if (recordsObj.length > 0) {
                buildHtml(recordsObj);   //渲染问卷列表
            }
        }


        function buildHtml(objArr) {
            /*渲染问卷列表*/
            var table = "<table width=\"100%\" border=\"0\" cellspacing=\"1\" cellpadding=\"3\" style=\"margin-top: 5px;\">{sub}<tr></tr></table>";
            var header = "<tr class=\"header\"><td><b>&nbsp;{Num}.{Question}</b></td></tr>";
            var question_radio = "<tr><td class='formCtl'><input type=\"radio\" name=\"{name}\" value=\"{value}\">{item}</td></tr>";
            var question_checkbox = "<tr><td class='formCtl'><input type=\"checkbox\" name=\"{name}\" value=\"{value}\">{item}</td></tr>";
            var question_textarea = "<tr><td class='formCtl'><textarea rows=\"3\" name=\"{name}\" class='question_textarea' ></textarea></td></tr>";
            var question_discuss = "<tr><td class='formCtl'><div class=\"discuss\" name=\"{name}\"><span><a>评论</a></span></div></td></tr>";
            var queston_IsExplanation = "<tr><td class='formCtl'><input type=\"{type}\" name=\"{name}\" value=\"{value}\">{item}<input type=\"text\" name=\"{name}\" class='IsExplanation' ></td></tr>";

            var subStringBud = "";                         //table 级
            for (var i = 0; i < objArr.length; i++) {
                var type = objArr[i]["QuestionType"] || "";
                var isMustAnswer = objArr[i]["IsMustAnswer"] || '';          //是否必答
                var hd = objArr[i]["Content"] || '';
                var stringBuilder = "";

                switch (type) {
                    case "单选项":
                        var name = objArr[i]["Id"] || '';
                        var type = "radio";
                        var isComment = objArr[i]["IsComment"] || '';         //是否评论
                        var questionItems = objArr[i]["QuestionItems"] || '';
                        var questionItemsObj = eval("(" + questionItems + ")"); //答案项

                        for (var k = 0; k < questionItemsObj.length; k++) {
                            if (questionItemsObj[k]["IsExplanation"] == "是") {
                                var temp = queston_IsExplanation.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{type}", type);
                                temp = temp.replaceAll("{value}", '');
                                stringBuilder += temp;
                            } else if (questionItemsObj[k]["IsExplanation"] == "否") {
                                var temp = question_radio.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{value}", '');
                                stringBuilder += temp;
                            }
                        }
                        if (isComment == "是") {   //呈现评论dom
                            stringBuilder += question_discuss.replaceAll('{name}', name);
                        }
                        break;
                    case "多选项":
                        hd += "(多选项)";
                        var name = objArr[i]["Id"] || '';
                        var type = "checkbox";
                        var isComment = objArr[i]["IsComment"] || '';             //是否评论
                        var questionItems = objArr[i]["QuestionItems"] || '';
                        var questionItemsObj = eval("(" + questionItems + ")");     //答案项
                        for (var k = 0; k < questionItemsObj.length; k++) {
                            if (questionItemsObj[k]["IsExplanation"] == "是") {
                                var temp = queston_IsExplanation.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{type}", type);
                                temp = temp.replaceAll("{value}", '');
                                stringBuilder += temp;
                            } else if (questionItemsObj[k]["IsExplanation"] == "否") {
                                var temp = question_checkbox.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{value}", '');
                                stringBuilder += temp;
                            }
                        }
                        if (isComment == "是") {//呈现评论dom
                            stringBuilder += question_discuss.replaceAll('{name}', name);
                        }
                        break;
                    case "填写项":
                        var name = objArr[i]["Id"] || '';
                        var temp = question_textarea.replaceAll("{name}", name)
                        temp = temp.replaceAll('{value}', '');
                        stringBuilder += temp;
                        break;
                }

                var hder = header.replaceAll("{Num}", parseInt(i + 1));

                if (isMustAnswer == "是" && hd) {  //必填
                    hd += "<font color='red'><span id=\"mustInput\" ><b>&nbsp;*</b></span></font>";
                }

                hder = hder.replaceAll("{Question}", hd);  //问题
                var sub = hder + stringBuilder;
                var tbl = table.replaceAll("{sub}", sub);  // 
                subStringBud += tbl;
            }
            subStringBud += "<table><td height=\"5\"></td></table>";
            $("#SurveyList").children().remove();
            $("#SurveyList").append(subStringBud);  //添加问卷项
        }

 
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table width="750" height="31" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <b class="guid"><font color="#000000">
                    <asp:Label ID="lbTitle" runat="server"></asp:Label></font> </b>
            </td>
        </tr>
    </table>
    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr style="background-color: rgb(255, 120, 0)">
                        <td width="750" style="margin-top: 12px; margin-bottom: 12px; height: 20px;">
                        </td>
                    </tr>
                    <tr>
                        <td width="750" style="margin-top: 12px; margin-bottom: 12px; height: 12px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="750" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="E0E0E0">
                                            <tr bgcolor="#FFFFFF">
                                                <td>
                                                    <div align="left">
                                                        &nbsp;&nbsp;&nbsp;&nbsp;<span id="content"></span>
                                                    </div>
                                                </td>
                                            </tr>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF">
                                    <td width="100%">
                                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                            <tr valign="top">
                                                <td width="100%" id="SurveyList">
                                                    <%--   <% = content %>--%>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <td height="12">
                                            </td>
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
    <table width="100%" border="0" cellspacing="1" cellpadding="3" style="margin-top: 10px;">
        <tr>
            <td>
                <div id="btnDiv" style="margin: 0 auto; text-align: center; width: 100%; background-color: #e0e0e0;
                    border: solid 1 gray; margin-top: 1px;">
                    <input value="投票" type="button" />&nbsp;
                    <input value="取消" type="button" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
