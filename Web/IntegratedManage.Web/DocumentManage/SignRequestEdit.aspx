<%@ Page Title="签报管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="SignRequestEdit.aspx.cs" Inherits="IntegratedManage.Web.SignRequestEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
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
        select
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
    <style type="text/css">
        .x-view-selected
        {
            -moz-background-clip: border;
            -moz-background-inline-policy: continuous;
            -moz-background-origin: padding;
            background-color: #FFC0CB;
        }
        .thumb
        {
            background-color: #dddddd;
            padding: 4px;
            text-align: center;
            height: 40px;
        }
        .thumb-activated
        {
            background-color: yellow;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-activateded
        {
            background-color: blue;
            padding: 4px;
            text-align: center;
            border: 2px;
            border-style: dashed;
            border-color: Red;
            height: 40px;
        }
        .thumb-separater
        {
            float: left;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: center;
            border: 1px solid gray;
        }
        .thumb-wrap-out
        {
            float: left;
            width: 80px;
            margin-right: 0;
            padding: 0px; /*width: 160;background-color:#8DB2E3;*/
        }
        .thumb-wrap
        {
            font-size: 12px;
            font-weight: bold;
            padding: 2px;
        }
        .remark
        {
            font-size: 12px;
            padding: 2px;
        }
        .tblusing
        {
            background-color: #FF8247;
        }
        .tblunusing
        {
            background-color: Gray;
        }
    </style>

    <script type="text/javascript">
        var myData1, store1, tpl1, dataview, panel1;
        var InFlow = $.getQueryString({ ID: "InFlow" });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = "";
        var id = $.getQueryString({ ID: "id" });
        function onPgLoad() {
            setPgUI();
            IniButton();
            IniPanel1();
        }
        function setPgUI() {
            if (window.parent.AimState["Task"]) {
                taskName = window.parent.AimState["Task"].ApprovalNodeName;
            }
            if (taskName == "院办文书") {//登记文号  加盖电子章
                $("#trSeal").show();
            }
            if (taskName == "打字员") {// 打字员   清稿套红 •	在登记文号处确认盖电子章，但在套红、清稿处不显示，提交到后面核稿处显示。
                $("#tr_red").show();
            }
            if (InFlow == "T") {
                $("#tr_base").hide();
            }
            fileId = $("#ApproveContent").val();
        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSave").click(function() {
                $("#btnSave").hide();
                $("#Attachment").val("");
                $.each(store1.getRange(), function() {
                    $("#Attachment").val($("#Attachment").val() + this.get("Id"));
                });
                AimFrm.submit(pgAction, {}, null, SubFinish);
            });
            $("#btnCancel").click(function() {
                window.close();
            });
            if (InFlow == "T" || LinkView == "T") {
                $("#divButton").hide(); IniOpinion();
            }
        }
        function SuccessSubmit() {
            if (!$("#ApproveLeaderIds").val()) {
                AimDlg.show("必须选择审批的部门负责人才能提交！");
                return;
            }
            $("#btnSubmit").hide();
            $("#Attachment").val("");
            $.each(store1.getRange(), function() {
                $("#Attachment").val($("#Attachment").val() + this.get("Id"));
            });
            AimFrm.submit(pgAction, {}, null, function(rtn) {
                Ext.getBody().mask("请稍候!");
                jQuery.ajaxExec('submit', { state: "Flowing", id: rtn.data.Id }, function(rtn) {
                    window.setTimeout("AutoExecuteFlow('" + rtn.data.WorkFlowInfo + "')", 1000);
                });
            });
        }
        function IniPanel1() {
            myData1 = { total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            }
            store1 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData1,
                fields: [{ name: 'Id' }, { name: 'Name'}]
            });
            tpl1 = new Ext.XTemplate(
                '<tpl for=".">',
                '<div class="thumb-separater" ><label style="cursor:pointer;font-size:12px;color:blue" lang="{Id}" onclick="DocDownLoad(this)">{Name}</label></div>',
                '</tpl>'
                );
            dataview = new Ext.DataView({
                store: store1,
                tpl: tpl1,
                autoScroll: true,
                autoHeight: true,
                singleSelect: false,
                multiSelect: true,
                simpleSelect: true,
                // overClass: 'x-view-over',style="background-color:#D5D5D5;"
                selectedClass: 'x-view-selected',
                itemSelector: 'div.thumb-separater'
            });
            var tlBar1 = new Ext.Toolbar({
                items: [{
                    text: '上传附件',
                    hidden: pgOperation == "v",
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
                        var uploadurl = '../CommonPages/File/Upload.aspx';
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件
                        if (rtn != undefined) {
                            var strarray = rtn.split(",");
                            if (strarray.length > 0) {
                                var recType = store1.recordType;
                                for (var i = 0; i < strarray.length; i++) {
                                    if (strarray[i]) {
                                        var p = new recType({ Id: strarray[i].substring(0, 36), Name: strarray[i].substring(37, strarray[0].length) });
                                        store1.insert(store1.data.length, p);
                                    }
                                }
                            }
                        }
                    }
                },
            { text: '删除附件', iconCls: 'aim-icon-delete', hidden: pgOperation == "v",
                handler: function() {
                    var recs = dataview.getSelectedRecords();
                    if (recs.length > 0) {
                        store1.remove(recs[0]);
                    }
                } }]
            });
            panel1 = new Ext.Panel({
                layout: 'fit',
                renderTo: 'div1',
                height: 80,
                tbar: tlBar1,
                border: false,
                autoScroll: true,
                items: [dataview]
            });
        }
        function DocDownLoad(val) {
            if (pgOperation == "v") {
                opencenterwin("../../CommonPages/File/DownLoad.aspx?id=" + val.lang, "newwin0", 120, 120);
            }
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
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function IniOpinion() {
            var tab = document.getElementById("tbOpinion");
            var myData = AimState["Opinion"] || [];
            if (AimState["Opinion"] && AimState["Opinion"].length > 1) {
                $("#examfield").show();
                for (var i = 1; i < myData.length; i++) {//从1开始 是为了不显示自动提交的任务
                    var tr = tab.insertRow(); tr.height = 32;
                    //tr.align = "center";
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].ApprovalNodeName ? myData[i].ApprovalNodeName + "意见" : '';
                    td.rowSpan = 2;
                    td.className = "aim-ui-td-caption";
                    td.style.width = "20%";
                    td.style.textAlign = "right";
                    var td = tr.insertCell();
                    var Description = myData[i].Description ? myData[i].Description : '';
                    td.innerHTML = '<textarea rows="2" disabled style="width: 96%;">' + Description + '</textarea>';
                    td.colSpan = 6;
                    var tr = tab.insertRow();
                    var td = tr.insertCell();
                    td.innerHTML = '审批结果:';
                    td.style.width = "100px";
                    var td = tr.insertCell();
                    //不同意,打回,拒绝,退回  如果包含上述文字。结果就是不同意。否则就是同意 
                    if (myData[i].Result && (myData[i].Result.indexOf("不同意") >= 0 || myData[i].Result.indexOf("打回") >= 0 || myData[i].Result.indexOf("拒绝") >= 0) || myData[i].Result.indexOf("退回")>=0) {
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
                //if (taskName == "签报请示" || taskName == "部门负责人" || taskName == "院办负责人" || taskName == "归口部门会签" || taskName == "主管院领导" || taskName == "院长批示" || taskName == "院务部负责人") {
                $("#examfield").show();
                var tr = tab.insertRow(); tr.height = 32; var td = tr.insertCell();
                td.innerHTML = taskName + "意见";
                td.className = "aim-ui-td-caption";
                td.style.width = "20%"; td.style.textAlign = "right"; var td = tr.insertCell();
                td.innerHTML = '<textarea id="TaskNameOpinion" name="TaskNameOpinion" style="width: 96%;background-color:rgb(254, 255, 187)"  rows="2"></textarea>';
                td.colSpan = 6;
                if (AimState["UnSubmitOpinion"]) {
                    $("#TaskNameOpinion").val(AimState["UnSubmitOpinion"]);
                }
                // }
            }
        }
        window.onresize = function() {
            panel1.setWidth(0); panel1.setWidth(Ext.get("div1").getWidth());
        }
       
    </script>

    <script language="javascript" type="text/javascript">
        //保存流程和提交流程时触发
        function onSave(task) {
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val() ? $("#TaskNameOpinion").val() : "";
            }
            if (taskName == "院办负责人" && $("#YuanLeaderIds").val()) {
                $.ajaxExec("ConfirmYuanLeader", { id: id, YuanLeaderIds: $("#YuanLeaderIds").val(), YuanLeaderNames: $("#YuanLeaderNames").val() },
                               function() { });
            }
            if (taskName == "签报请示") {
                $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val() }, function() { });
                //  AimFrm.submit(, null, function() { });
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
                case "部门负责人":
                    if (nextName == "提交院办负责人") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "院办负责人":
                    if (nextName == "提交院领导") {
                        users.UserIds = $("#YuanLeaderIds").val();
                        users.UserNames = $("#YuanLeaderNames").val();
                    }
                    break;
                case "归口部门会签":
                    if (nextName == "院办负责人") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "签报请示":
                    if (nextName == "部门负责人") {
                        users.UserIds = $("#ApproveLeaderIds").val();
                        users.UserNames = $("#ApproveLeaderNames").val();
                    }
                    break;
                case "主管院领导":
                    if (nextName == "提交院办负责人" || nextName == "提交院长") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "院长批示":
                    if (nextName == "同意") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
            }
            return users;
        }
        //流程结束时触发window.parent.document.getElementById("id_SubmitState").value
        function onFinish(task) {
            jQuery.ajaxExec('submitfinish', { state: "End", id: id, ApprovalState: "同意"
            }, function() {
                RefreshClose();
            });
        } 
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            签报信息</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" /><input id="CreateId" name="CreateId" /><input id="CreateName"
                        name="CreateName" /><input id="WorkFlowState" name="WorkFlowState" /><input id="CreateTime"
                            name="CreateTime" />
                    <input id="Attachment" name="Attachment" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    签报事由
                </td>
                <td colspan="3">
                    <textarea id="SignReason" name="SignReason" class="validate[required]" cols="" rows="5"
                        style="width: 97%"></textarea>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption" style="width: 25%">
                    紧急程度
                </td>
                <td style="width: 25%">
                    <select id="ImportanceDegree" name="ImportanceDegree" style="width: 90%;" aimctrl='select'
                        enum="ImportanceDegree">
                    </select>
                </td>
                <td class="aim-ui-td-caption" style="width: 25%">
                    密级
                </td>
                <td style="width: 25%">
                    <select id="SecrecyDegree" name="SecrecyDegree" style="width: 90%;" aimctrl='select'
                        enum="SecrecyDegree">
                    </select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    主办单位
                </td>
                <td>
                    <input id="CreateDeptName" name="CreateDeptName" style="width: 90%" />
                    <input id="CreateDeptId" name="CreateDeptId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption">
                    联系人
                </td>
                <td>
                    <input id="ContactUserName" name="ContactUserName" aimctrl="user" relateid="ContactUserId" />
                    <input id="ContactUserId" name="ContactUserId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    联系电话
                </td>
                <td>
                    <input id="Telephone" name="Telephone" />
                </td>
                <td class="aim-ui-td-caption">
                    提交审批部门负责人
                </td>
                <td>
                    <input id="ApproveLeaderNames" name="ApproveLeaderNames" aimctrl="user" relateid="ApproveLeaderIds" />
                    <input id="ApproveLeaderIds" name="ApproveLeaderIds" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    提交审批院领导
                </td>
                <td>
                    <input id="YuanLeaderNames" name="YuanLeaderNames" relateid="YuanLeaderIds" aimctrl="user"
                        seltype="multi" />
                    <input id="YuanLeaderIds" name="YuanLeaderIds" type="hidden" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    说明
                </td>
                <td colspan="3">
                    1 提交审批的时候部门负责人为必选项；2 提交审批院领导可以在流程开始前指定，也可以在审批过程中指定
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>文件区</legend>
        <div id="div1">
        </div>
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
                    <a id="btnSubmit" class="aim-ui-button submit">提交</a>&nbsp;&nbsp; <a id="btnSave"
                        class="aim-ui-button submit">暂存</a>&nbsp;&nbsp; <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
