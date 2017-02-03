<%@ Page Title="网上调查" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="InternetSurveyView.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.InternetSurveyView" %>

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
        var id = $.getQueryString({ ID: 'Id' });  // <=>SurveyId
        var title = unescape($.getQueryString({ ID: 'Title' }));
        var records, survey;
        function onPgLoad() {
            renderView();
            setPageUI();
        }
        function setPageUI() {
            if (AimState["Auth"] == "false") {
                $("#btnDiv").hide();
                AimDlg.show("您无参与问卷调查权限,请与管理员联系!");
            }
            $(".discuss").click(function () {
                /*是否评论*/
                $(this).parent().append("<textarea rows=3  attr='discuss' style='float: left; width: 415;'" + " name=" + $(this).attr("name") + "/>")
                $(this).unbind("click");
            });
        }

        function renderView() {
            records = AimState["ItemList"] || [];
            survey = AimState["Survey"];
            $("#title").text(title || (survey["Title"] || ''));                     //设置title
            survey["Contents"] && $("#content").text('').text(survey["Contents"]);  //设置说明
            var recordsObj = eval("(" + records + ")") || [];
            if (recordsObj.length > 0) {
                var html = buildHtml(recordsObj);   //渲染问卷列表
                $("#SurveyList").children().remove();
                $("#SurveyList").append(html);  //添加问卷项
            }

            //---------------------------------------
            var rand;
            $("input").attr("readonly", true);
            $("input:radio,input:checkbox").click(function () {
                var randChar = ["x", 'c', 'd', 'v', 'z', 'k', 's', 't'];
                if ($(this).next().attr("type") == "text") {
                    rand = randChar[parseInt(Math.random() * 9)] + randChar[parseInt(Math.random() * 9)] + randChar[parseInt(Math.random() * 9)] + randChar[parseInt(Math.random() * 9)];
                    $(this).next().attr("readonly", false).addClass(rand);
                } else {
                    $("." + rand + "").val('').attr("readonly", true);
                }
            });
            //--------------------------------------
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
            var isMustFill = "<font color='red'><span class=\"mustInput\" name=\"{name}\" ><b>&nbsp;*</b></span></font>";

            var subStringBud = "";                                          //table 级
            for (var i = 0; i < objArr.length; i++) {
                var stringBuilder = "";
                var hd = objArr[i]["Content"] || '';
                var type = objArr[i]["QuestionType"] || "";
                var isMustAnswer = objArr[i]["IsMustAnswer"] || '';          //是否必答

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
                                temp = temp.replaceAll("{value}", questionItemsObj[k].Id);
                                stringBuilder += temp;
                            } else if (questionItemsObj[k]["IsExplanation"] == "否") {
                                var temp = question_radio.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{value}", questionItemsObj[k].Id);
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
                        var questionItemsObj = eval("(" + questionItems + ")");   //答案项
                        for (var k = 0; k < questionItemsObj.length; k++) {
                            if (questionItemsObj[k]["IsExplanation"] == "是") {
                                var temp = queston_IsExplanation.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{type}", type);
                                temp = temp.replaceAll("{value}", questionItemsObj[k].Id);
                                stringBuilder += temp;
                            } else if (questionItemsObj[k]["IsExplanation"] == "否") {
                                var temp = question_checkbox.replaceAll("{name}", name);
                                temp = temp.replaceAll("{item}", questionItemsObj[k]["Answer"]);
                                temp = temp.replaceAll("{value}", questionItemsObj[k].Id);
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

                if (isMustAnswer == "是" && hd) {//必填
                    hd += isMustFill.replaceAll("{name}", objArr[i]["Id"] || '');
                }

                hder = hder.replaceAll("{Question}", hd);  //问题
                var sub = hder + stringBuilder;
                var tbl = table.replaceAll("{sub}", sub);  // 
                subStringBud += tbl;
            }
            subStringBud += "<table><td height=\"5\"></td></table>";  //处理留白
            return subStringBud;
        }

        function commit() {/*提交*/
            //必填项验证
            var validate = true;
            $(".mustInput").each(function () {
                if ($("[name=" + $(this).attr("name") + "]").not("[attr='discuss']").is("textarea")) {
                    !$("[name=" + $(this).attr("name") + "]").text() && (validate = false);
                } else {
                    !$("[name=" + $(this).attr("name") + "]:checked").val() && (validate = false);
                }
            })

            if (!validate) {
                return AimDlg.show("您有未填的必选项!");
            }

            if (confirm("提交后将无法修改,确认提交吗?")) {
                var commitArr = [];
                var recordsObj = eval("(" + records + ")") || [];
                for (var i = 0; i < recordsObj.length; i++) {
                    var temObj = {};
                    temObj.UserId = AimState.UserInfo.UserID;
                    temObj.UserName = AimState.UserInfo.Name;
                    temObj.SurveyId = id;
                    temObj.QuestionContentId = recordsObj[i].Id;

                    var tempId = "";
                    var tempConntent = "";
                    $("[name^=" + recordsObj[i].Id + "]").each(function () {
                        switch ($(this)[0].tagName) {
                            case "INPUT":
                            case "input":
                                if ($(this).attr("checked")) {
                                    tempId.length > 0 && (tempId += ",");
                                    tempId += $(this).val();
                                }
                                if ($(this).attr("type") == "text") {
                                    tempConntent += $(this).val();  //补充
                                }
                                break;
                            case "TEXTAREA":  //评论
                            case "textarea":
                                tempConntent += "##" + $(this).val() + "##";
                                break;
                        }
                    });
                    temObj.QuestionItemId = tempId.toString().slice(0, str.length - 1);
                    temObj.QuestionItemContent = tempConntent;
                    commitArr.push($.getJsonString(temObj));
                    // QuestionContentId    QuestionItemContent  UserId  UserName CreateTime
                }

                var paramObj = {};
                var html = document.getElementsByTagName('html')[0].innerHTML;
                paramObj["commitArr"] = commitArr;
                paramObj["CommitHistory"] = $.getJsonString({ SurveyId: id, SurveyedUserId: AimState.UserInfo.UserID, SurveryUserName: AimState.UserInfo.Name, CommitSurvey: html });
                AimFrm.submit("Commit", paramObj, null, function () {
                    RefreshClose();
                });
            }
        }

        function cancel() { /*取消*/
            RefreshClose();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <table width="750" height="31" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <b class="guid"><font color="#000000"><span id="title"></span></font></b>
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
    <table width="100%" border="0" cellspacing="1" cellpadding="3" style="margin-top: 10px;">
        <tr>
            <td>
                <div id="btnDiv" style="margin: 0 auto; text-align: center; width: 100%; background-color: #e0e0e0;
                    border: solid 1 gray; margin-top: 1px;">
                    <input value="投票" type="button" onclick="commit()" />&nbsp;
                    <input value="取消" type="button" onclick="cancel()" />
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
