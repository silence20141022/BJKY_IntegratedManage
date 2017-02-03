<%@ Page Title="出差管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="AbsenceApplyEdit.aspx.cs" Inherits="IntegratedManage.Web.AbsenceApplyEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/PCASClass.js" type="text/javascript" charset="gb2312"></script>

    <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
            background-color: #F2F2F2;
        }
        fieldset
        {
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        .righttxt
        {
            text-align: right;
        }
        input
        {
            width: 90%;
        }
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }
        .x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
    </style>

    <script type="text/javascript">
        var InFlow = $.getQueryString({ ID: "InFlow" });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = "";
        var id = $.getQueryString({ ID: "id" });
        function onPgLoad() {
            setPgUI();
            initState();
            if (window.parent.AimState["Task"]) {
                taskName = window.parent.AimState["Task"].ApprovalNodeName;
            }
            if (InFlow == "T" || LinkView == "T") {
                $("#divButton").hide();
                IniOpinion();
            }
        }
        function setPgUI() {
            new PCAS("province", "city", "area");  //地区选择 
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSave").click(function() {
                $("#btnSave").hide();
                AimFrm.submit(pgAction, {}, null, SubFinish);
            });
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        function initState() {
            $("#province,#city,#area").change(function() { //处理地点选中
                $("#Address").val($("#province").val() + $("#city").val() + $("#area").val());
            });
        }
        function SuccessSubmit() {
            if (!$("#ApplyUserName").val() || !$("#ExamineUserName").val()) {
                AimDlg.show("申请人和审批领导为必填");
                return;
            }
            if (!$("#StartTime").val() || !$("#EndTime").val()) {
                AimDlg.show("开始时间,结束时间为必填项!");
                return;
            }
            $("#btnSubmit").hide();
            AimFrm.submit(pgAction, {}, null, function(rtn) {
                Ext.getBody().mask("请稍候!");
                jQuery.ajaxExec('submit', { state: "Flowing", id: rtn.data.Id }, function(rtn) {
                    window.setTimeout("AutoExecuteFlow('" + rtn.data.WorkFlowInfo + "')", 1000);
                });
            });
        }
        function AutoExecuteFlow(workflowinfo) {
            var strarray = workflowinfo.split(",");
            jQuery.ajaxExec('AutoExecuteFlow', { WorkFlowInfo: strarray }, function(rtn) {
                Ext.getBody().unmask();
                alert("提交成功！");
                RefreshClose();
            });
        }
        function SubFinish(args) {
            RefreshClose();
        }
        function IniOpinion() {
            var tab = document.getElementById("tbOpinion");
            var myData = AimState["Opinion"] || [];
            if (AimState["Opinion"] && AimState["Opinion"].length > 0) {
                $("#examfield").show();
                for (var i = 1; i < myData.length; i++) {//从1开始 是为了不显示自动提交的任务
                    var tr = tab.insertRow(); tr.height = 32;
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].ApprovalNodeName ? myData[i].ApprovalNodeName + "意见" : '';
                    td.rowSpan = 2;
                    td.className = "aim-ui-td-caption";
                    td.style.width = "25%";
                    td.style.textAlign = "right";
                    var td = tr.insertCell();
                    var Description = myData[i].Description ? myData[i].Description : '';
                    td.innerHTML = '<textarea rows="2" disabled style="width: 97%;">' + Description + '</textarea>';
                    td.colSpan = 6;
                    var tr = tab.insertRow();
                    var td = tr.insertCell();
                    td.innerHTML = '审批结果:';
                    td.style.width = "100px";
                    var td = tr.insertCell();
                    //不同意,打回,拒绝,退回  如果包含上述文字。结果就是不同意。否则就是同意 
                    if (myData[i].Result && (myData[i].Result.indexOf("不同意") >= 0 || myData[i].Result.indexOf("打回") >= 0 || myData[i].Result.indexOf("拒绝") >= 0) || myData[i].Result.indexOf("退回") >= 0) {
                        td.innerHTML = "不同意";
                    }
                    else {
                        td.innerHTML = "同意";
                    }
                    td.style.textDecoration = "underline";
                    var td = tr.insertCell(); td.innerHTML = '签名:';
                    var td = tr.insertCell();
                    td.innerHTML = '<img style="width: 70px; height: 25px;" src="/CommonPages/File/DownLoadSign.aspx?UserId=' + myData[i].OwnerId + '" />';
                    var td = tr.insertCell(); td.innerHTML = '审批时间:';
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].FinishTime ? myData[i].FinishTime : '';
                    td.style.textDecoration = "underline";
                }
            }
            if (LinkView != "T") {
                $("#examfield").show();
                var tr = tab.insertRow(); tr.height = 32; var td = tr.insertCell();
                td.innerHTML = taskName + "意见";
                td.className = "aim-ui-td-caption";
                td.style.width = "25%"; td.style.textAlign = "right"; var td = tr.insertCell();
                td.innerHTML = '<textarea id="TaskNameOpinion" name="TaskNameOpinion" style="width: 97%;background-color:rgb(254, 255, 187)"  rows="2"></textarea>';
                td.colSpan = 6;
                if (AimState["UnSubmitOpinion"]) {
                    $("#TaskNameOpinion").val(AimState["UnSubmitOpinion"]);
                }
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        //保存流程和提交流程时触发
        function onSave(task) {
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val() ? $("#TaskNameOpinion").val() : "";
            }
            if (taskName == "出差申请") {
                $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val() }, function() { });
            }
        }
        //提交流程时触发
        function onSubmit(task) {
            if ($("#TaskNameOpinion").css("display") == "inline" && !$("#TaskNameOpinion").val()) {
                AimDlg.show("提交时必须填写审批意见！");
                return false;
            }
        }
        function onGiveUsers(nextName) {
            var users = { UserIds: "", UserNames: "" };
            switch (taskName) {
                case "出差申请":
                    if (nextName == "提交") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
            }
            return users;
        }
        //流程结束时触发
        function onFinish(task) {
            jQuery.ajaxExec('submitfinish', { state: "End", id: $("#Id").val(), ApproveResult: window.parent.document.getElementById("id_SubmitState").value
            }, function() {
                RefreshClose();
            });
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            出差管理</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td>
                    <input id="Id" name="Id" />
                    <input id="CreateId" name="CreateId" />
                    <input id="CreateName" name="CreateName" />
                    <input id="CreateTime" name="CreateTime" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption" style="width: 25%">
                    申请人
                </td>
                <td class="aim-ui-td-data" style="width: 25%">
                    <input id="ApplyUserName" name="ApplyUserName" aimctrl='user' relateid="ApplyUserId" />
                    <input id="ApplyUserId" name="ApplyUserId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption" style="width: 25%">
                    申请人部门
                </td>
                <td class="aim-ui-td-data" style="width: 25%">
                    <input id="DeptName" name="DeptName" />
                    <input id="DeptId" name="DeptId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    审批领导
                </td>
                <td class="aim-ui-td-data">
                    <input id="ExamineUserName" name="ExamineUserName" aimctrl='user' relateid="ExamineUserId" />
                    <input id="ExamineUserId" name="ExamineUserId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    开始时间
                </td>
                <td class="aim-ui-td-data">
                    <input id="StartTime" name="StartTime" class="Wdate" class="validate[required]" onclick="WdatePicker({dateFmt:'yyyy/MM/dd'})"
                        class="validate[required]" />
                </td>
                <td class="aim-ui-td-caption">
                    结束时间
                </td>
                <td class="aim-ui-td-data">
                    <input id="EndTime" name="EndTime" class="Wdate" class="validate[required]" readonly="readonly"
                        onclick="var date=$('#StartTime').val()?$('#StartTime').val():new Date(); WdatePicker({minDate:date,dateFmt:'yyyy/MM/dd'})"
                        class="validate[required]" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    出差地点
                </td>
                <td>
                    <input id="Address" name="Address" class="validate[required]" />
                </td>
                <td class="aim-ui-td-data" colspan="2">
                    <select name="province" id="province" style="width: 32%">
                    </select><select name="city" id="city" style="width: 32%"></select><select name="area"
                        id="area" style="width: 32%"></select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    出差事由
                </td>
                <td class="aim-ui-td-data" colspan="3">
                    <textarea rows="4" id="Reason" name="Reason" class="validate[required]" style="width: 97%"></textarea>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset id="examfield" style="display: none">
        <legend>审批意见区</legend>
        <table width="100%" id="tbOpinion" style="font-size: 12px; border: none;" class="aim-ui-table-edit">
        </table>
    </fieldset>
    <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">提交</a>&nbsp; &nbsp;<a id="btnSave"
                        class="aim-ui-button submit">保存</a>&nbsp;&nbsp;<a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
