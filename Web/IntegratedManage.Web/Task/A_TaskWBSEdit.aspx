<%@ Page Title="任务编辑" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="A_TaskWBSEdit.aspx.cs" Inherits="Aim.AM.Web.A_TaskWBSEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <base target="_self" />
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
        .aim-ui-td-caption
        {
            text-align: right;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
    </style>

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <script type="text/javascript">

        var id, title;
        var EnumLevel = { 0: "普通", 1: "重要", 2: "很重要" };
        var taskType = $.getQueryString({ "ID": "TaskType", "DefaultValue": '' });
        var year = $.getQueryString({ "ID": "Type", "DefaultValue": '' });
        var mdls, tabPanel, subContentPanel, sngrid;
        var sndata, snstore;
        var tabPanel;
        var InFlow = $.getQueryString({ ID: "InFlow" });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskId = $.getQueryString({ ID: 'TaskId' });
        var taskName = "";
        function onPgLoad() {
            id = $.getQueryString({ ID: 'id' });
            setPgUI();
            if (InFlow == "T" || LinkView == "T") {
                $("#divButton").hide();
                IniOpinion();
            }
            if ($("#Year").val() == "") {
                $("#Year").val(year);
            }
            window.onbeforeunload = function() {
                if (window.dialogArguments && window.dialogArguments.Ext && window.dialogArguments.Ext.getCmp("btnRefresh"))
                    window.dialogArguments.Ext.getCmp("btnRefresh").el.dom.click();
            }
            if ($.getQueryString({ "ID": "InFlow", "DefaultValue": "" }) == "T") {
                tabPanel.setActiveTab(3);
            }
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#SubmitDate").val(jQuery.dateOnly(new Date()));
                $("#PlanStartDate").val(jQuery.dateOnly(new Date()));
                document.getElementById("tdFrame").style.display = "none";
                document.getElementById("TabArea").style.display = "none";
                AimFrm.dataBind();
            }
            else if ($.getQueryString({ "ID": "IsChild", "DefaultValue": "false" }) == "true") {
                document.getElementById("tdFrame").style.display = "none";
                document.getElementById("TabArea").style.display = "none";
            }
            else {
                InitSubContent();
            }
            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);
            FormValidationBind('btnSaveSubmit', SuccessSaveSubmit);
            $("#btnCancel").click(function() {
                window.close();
            });
        }

        function InitSubContent() {
            var mdls = [{ Name: "相关子任务", Url: "A_TaskWBSList.aspx?IsInTab=true&ParentId=" + $("#Id").val() + "&TaskType=" + AimState["frmdata"]["TaskType"], Status: 0 },
            { Name: "工作日志", Url: "WorkTimeFactListEdit.aspx?IsInTab=true&TaskId=" + $("#Id").val(), Status: 0 },
            { Name: "评定日志", Url: "A_ChargeProgresList.aspx?IsInTab=true&TaskId=" + $("#Id").val(), Status: 1 },
            { Name: "目标附件库", Url: "A_TaskAttachmentList.aspx?IsInTab=true&TaskId=" + $("#Id").val(), Status: 1}];
            var tabArr = [];
            $.each(mdls, function() {
                var tab = {
                    title: this["Name"],
                    href: this["Url"],
                    Status: this["Status"],
                    listeners: { activate: handleActivate },
                    margins: '0 0 0 0',
                    border: false,
                    layout: 'border',
                    html: "<div style='display:none;'></div>"
                }
                tabArr.push(tab);
            });

            // 用于tab过多时滚动
            var scrollerMenu = new Ext.ux.TabScrollerMenu({
                menuPrefixText: '项目',
                maxText: 15,
                pageSize: 5
            });

            tabPanel = new Ext.ux.AimTabPanel({
                enableTabScroll: true,
                border: true,
                defaults: { autoScroll: true },
                plugins: [scrollerMenu],
                renderTo: 'TabArea',
                activeTab: 0,
                width: document.body.offsetWidth - 25,
                height: 10,
                items: tabArr,
                listeners: { 'click': function() { handleActivate(); } }
            });

            function handleActivate(tab) {
                tab = tab || tabPanel.getActiveTab();
                var url = tab.href;

                if (document.getElementById("frameContent") && document.getElementById("frameContent").reloadPage)
                    frameContent.reloadPage.call(this, { cid: tab.Status });
                else {
                    window.setTimeout("LoadFirstTab('" + url + "');", 100);
                }
                return;
            }

        }
        function LoadFirstTab(url) {
            if (document.getElementById("frameContent")) {
                frameContent.location.href = url;
            }
            else
                window.setTimeout("LoadFirstTab('" + url + "');", 100);
        }


        function SuccessSaveSubmit() {
            if ($("#DutyId").val() == "") {
                alert("请填写责任人!");
                return;
            }
            AimFrm.submit(pgAction, { TaskType: taskType, issubmit: true }, null, SubFinish);
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, { TaskType: taskType }, null, SubFinish);
        }

        function SubFinish(args) {
            Aim.PopUp.ReturnValue({ id: id, op: pgOperation });
        }
        function IniOpinion() {
            if (window.parent.AimState["Task"]) {
                taskName = window.parent.AimState["Task"].ApprovalNodeName;
            }
            var tab = document.getElementById("tbOpinion");
            var myData = AimState["Opinion"] || [];
            if (AimState["Opinion"] && AimState["Opinion"].length > 1) {
                $("#examfield").show();
                for (var i = 1; i < myData.length; i++) {//从1开始是为了去掉提交人&& LinkView == "T"
                    var tr = tab.insertRow();
                    tr.height = 32;
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].ApprovalNodeName ? myData[i].ApprovalNodeName + "意见" : '';
                    td.rowSpan = 2;
                    td.className = "aim-ui-td-caption";
                    td.style.width = "25%";
                    td.style.textAlign = "right";
                    var td = tr.insertCell();
                    var Description = myData[i].Description ? myData[i].Description : '';
                    td.innerHTML = '<textarea rows="2" disabled style="width:96%;">' + Description + '</textarea>';
                    td.colSpan = 6;
                    var tr = tab.insertRow(); //第二行
                    var td = tr.insertCell(); td.innerHTML = '审批结果:'; td.style.width = "100px";
                    //不同意,打回,拒绝,退回  如果包含上述文字。结果就是不同意。否则就是同意
                    var td = tr.insertCell();
                    if (myData[i].Result && (myData[i].Result.indexOf("不同意") >= 0 || myData[i].Result.indexOf("打回") >= 0 || myData[i].Result.indexOf("拒绝") >= 0) || myData[i].Result.indexOf("退回") >= 0) {
                        td.innerHTML = "不同意";
                    }
                    else {
                        td.innerHTML = "同意";
                    }
                    td.style.textDecoration = "underline";
                    var td = tr.insertCell(); td.innerHTML = '签名:';
                    var td = tr.insertCell(); td.innerHTML = '<img style="width:70px; height:25px;" src="/CommonPages/File/DownLoadSign.aspx?UserId=' + myData[i].OwnerId + '"/>';
                    var td = tr.insertCell(); td.innerHTML = '审批时间:';
                    var td = tr.insertCell(); td.innerHTML = myData[i].FinishTime ? myData[i].FinishTime : ''; td.style.textDecoration = "underline";
                }
            }
            if (taskName && LinkView != "T") {
                $("#examfield").show();
                var tr = tab.insertRow();
                tr.height = 32;
                var td = tr.insertCell(); td.innerHTML = taskName + "意见";
                td.className = "aim-ui-td-caption";
                td.style.width = "25%";
                td.style.textAlign = "right";
                var td = tr.insertCell(); td.innerHTML = '<textarea id="TaskNameOpinion" name="TaskNameOpinion" style="width:96%;background-color:rgb(254, 255, 187)" rows="2"></textarea>'; td.colSpan = 6;
                if (AimState["UnSubmitOpinion"]) {
                    $("#TaskNameOpinion").val(AimState["UnSubmitOpinion"]);
                }
            }
        }
    </script>

    <script language="javascript" type="text/javascript">
        /**********************************************WorkFlow Function Start**************************/
        var permission = {};
        //这里依次统一添加各环节的控件权限
        permission.确认发布内容 = { ReadOnly: "Title,KeyWord,Content", Hidden: "" };
        permission.审批人审批 = { ReadOnly: "Title,KeyWord", Hidden: "" };

        //var StartUserId = "";
        //var StartUserName = "";
        function InitUIForFlow() {
            //StartUserId = $("#RequestUserId").val();
            //StartUserName = $("#RequestUserName").val();
            if (window.parent.AimState["Task"])
                var taskName = window.parent.AimState["Task"].ApprovalNodeName;

            $("#btnSubmit").hide();
            $("#btnCancel").hide();

            ///控制下一步路由
            if (taskName == "确认发布内容") {
                //SetRoute("公司领导",true);//第一个参数为下一步路由,第二个参数为是否禁止重新选择路由
            }
            if (taskName == "申请人") {
                sngrid.getColumnModel().setHidden(6, true);
                sngrid.getColumnModel().setHidden(7, true);
            }
            else if (taskName && (taskName.indexOf("行政") >= 0 || taskName.indexOf("资讯") >= 0)) {
                sngrid.getColumnModel().setHidden(6, false);
                sngrid.getColumnModel().setHidden(7, false);
                if (taskName != "行政采购" && taskName != "资讯采购") {
                    sngrid.getColumnModel().setEditable(6, false);
                    sngrid.getColumnModel().setEditable(7, false);
                }
            }
            if (eval("permission." + taskName)) {
                //只读
                var read = eval("permission." + taskName).ReadOnly;
                for (var i = 0; i < read.split(',').length; i++) {
                    var id = read.split(',')[i];
                    if (document.getElementById(id))
                        document.getElementById(id).readOnly = true;
                }
                //隐藏
                var vis = eval("permission." + taskName).Hidden;
                for (var i = 0; i < vis.split(',').length; i++) {
                    var id = vis.split(',')[i];
                    if (document.getElementById(id))
                        document.getElementById(id).style.display = "none";
                }
            }
        }
        //保存流程和提交流程时触发
        function onSave(task) {
            var taskName = window.parent.AimState["Task"].ApprovalNodeName;
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val();
            }
        }
        //提交流程时触发
        function onSubmit(task) {
            if ($("#TaskNameOpinion").css("display") == "inline" && !$("#TaskNameOpinion").val()) {
                AimDlg.show("提交时必须填写审批意见！");
                return false;
            }
        }
        //获取下一环节用户
        function onGiveUsers(nextName) {
            var users = { UserIds: "", UserNames: "" };
            switch (nextName) {
                case "任务审批人":
                    $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                        if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                            users.UserIds = rtn.data.NextUsers[0];
                            users.UserNames = rtn.data.NextUsers[1];
                        }
                    });
                    break; 
            }
            return users;
        }
        //流程结束时触发
        function onFinish(task) { 
            jQuery.ajaxExec('submitfinish', { "state": "End", "id": id }, function() {
                RefreshClose();
            }); 
        } 
        function SetRoute(name, flag) {
            window.parent.SetRoute("公司领导", flag);
        }
        /*****************************************************WorkFlow Function End****************************/
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            任务维护</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td colspan="6">
                        <input id="Id" name="Id" />
                        <input id="Year" name="Year" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        任务编码:
                    </td>
                    <td class="aim-ui-td-data" style="width: 23%">
                        <input id="Code" name="Code" class="validate[required]" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        任务名称:
                    </td>
                    <td class="aim-ui-td-data" style="width: 23%">
                        <input id="TaskName" name="TaskName" class="validate[required]" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        任务责任人:
                    </td>
                    <td class="aim-ui-td-data" style="width: 23%">
                        <input aimctrl='user' required="true" id="DutyName" name="DutyName" relateid="DutyId"
                            style="width: 180px;" />
                        <input type="hidden" id="DutyId" name="DutyId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        计划开始时间:
                    </td>
                    <td class="aim-ui-td-data" id="BalanceTD">
                        <input aimctrl='date' required="true" class="validate[required]" id="PlanStartDate"
                            name="PlanStartDate" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        计划完成时间:
                    </td>
                    <td class="aim-ui-td-data">
                        <input aimctrl='date' required="true" class="validate[required]" id="PlanEndDate"
                            name="PlanEndDate" />
                    </td>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        计划工时:
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="PlanWorkHours" name="PlanWorkHours" class="validate[required]" value="0" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        权重:
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="Balance" name="Balance" class="validate[required]" value="0" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        主办部门:
                    </td>
                    <td class="aim-ui-td-data">
                        <input aimctrl='popup' id="DeptName" name="DeptName" popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx?seltype=single"
                            popparam="DeptId:GroupID;DeptName:Name" popstyle="width=700,height=500" style="width: 75%" />
                        <input type="hidden" id="DeptId" name="DeptId" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        分管领导:
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="LeaderName" name="LeaderName" aimctrl="user" required="true" relateid="LeaderId" />
                        <input type="hidden" id="LeaderId" name="LeaderId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                    </td>
                    <td class="aim-ui-td-data">
                        <!--input aimctrl='popup' id="SecondDeptNames" name="SecondDeptNames" popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx"
                            popparam="SecondDeptIds:GroupID;SecondDeptNames:Name" popstyle="width=700,height=500"
                            style="width: 75%" />
                        <input type="hidden" id="SecondDeptIds" name="SecondDeptIds" /-->
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        参与人员:
                    </td>
                    <td class="aim-ui-td-data">
                        <input aimctrl='popup' readonly id="UserNames" name="UserNames" relateid="UserIds"
                            popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="UserIds:UserID;UserNames:Name"
                            popstyle="width=750,height=450" style="width: 75%" />
                        <input type="hidden" id="UserIds" name="UserIds" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        主要内容:
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="Remark" name="Remark" style="width: 100%; height: 40px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        考核标准:
                    </td>
                    <td class="aim-ui-td-data">
                        <textarea id="Ext1" name="Ext1" style="width: 100%; height: 40px"></textarea>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        里程碑说明:
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="ImportantRemark" name="ImportantRemark" style="width: 100%; height: 40px"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 10%">
                        相关指导附件:
                    </td>
                    <td class="aim-ui-td-data" colspan="5">
                        <input type="hidden" id="Attachment" name="Attachment" aimctrl='file' value="" style="width: 80%;
                            height: 40px" />
                    </td>
                </tr>
                <tr>
                    <td style="margin: 0px!important; padding: 0px!important;" id="TabArea" colspan="6">
                    </td>
                </tr>
                <tr>
                    <td style="margin: 0px!important; padding: 0px!important;" id="tdFrame" colspan="6">
                        <iframe width="100%" height="240px" id="frameContent" name="frameContent" frameborder="0">
                        </iframe>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="6">
                        <a id="btnSaveSubmit" class="aim-ui-button submit">下发任务</a> <a id="btnSubmit" class="aim-ui-button submit">
                            暂存</a> <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
        <fieldset id="examfield" style="display: none">
            <legend>审批意见区</legend>
            <table width="100%" id="tbOpinion" style="font-size: 12px; border: none;" class="aim-ui-table-edit">
            </table>
        </fieldset>
    </div>
</asp:Content>
