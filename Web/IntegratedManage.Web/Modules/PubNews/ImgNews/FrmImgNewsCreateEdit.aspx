<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    Title="图片新闻" CodeBehind="FrmImgNewsCreateEdit.aspx.cs" Inherits="Aim.Portal.Web.Modules.FrmImgNewsCreateEdit"
    ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
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
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }
        .x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
        input
        {
            width: 100%;
        }
    </style>
    <script type="text/javascript">
        var EnumType = { 0: "未发布", 1: "已发布" };
        var EnumLevel = { 0: "普通", 1: "重要", 2: "很重要" };
        var store, tlBar, grid;
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = "";
        function onPgLoad() {
            setPgUI();
            if ($.getQueryString({ ID: "op" }) == 'c') {
                if (AimState["DeptInfo"]) {
                    $("#PostDeptName").val(AimState["DeptInfo"].groupName);
                    $("#PostDeptId").val(AimState["DeptInfo"].groupId);
                    $("#CreateName").val(AimState["UserInfo"].Name);
                }
            }
            if ($.getQueryString({ ID: "InFlow", DefaultValue: "" }) == "T" || LinkView == "T") {
                $("#divbutton").hide();
                if (window.parent.AimState["Task"]) {
                    taskName = window.parent.AimState["Task"].ApprovalNodeName;
                }
                IniOpinion();
            }
            if (AimState["TypeId"]) {
                $("#TypeId").val(AimState["TypeId"]);
            }
        }
        function setPgUI() {
            FormValidationBind('btntj', SuccessTJ);
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function () {
                window.close();
            });
            tlBar = new Ext.ux.AimToolbar({
                hidden: pgOperation == "r" || $.getQueryString({ "ID": "InFlow" }) == "T",
                items: [{
                    text: '添加明细',
                    iconCls: 'aim-icon-add',
                    handler: function () {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                        var uploadurl = '/CommonPages/File/Upload.aspx';
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件 
                        var fileIds = "";
                        if (rtn != undefined) {
                            var strarray = rtn.split(",");
                            var recType = store.recordType;
                            $.each(strarray, function (rtn) {
                                if (this != "") {
                                    var tempRec = new recType({ "ImgPath": this.toString() });
                                    var insRowIdx = store.data.length;
                                    store.insert(insRowIdx, tempRec);
                                }
                            });
                        }
                    }
                }, '-',
                 {
                     text: '删除',
                     iconCls: 'aim-icon-delete',
                     handler: function () {
                         var recs = grid.getSelectionModel().getSelections();
                         if (!recs || recs.length <= 0) {
                             AimDlg.show("请先选择要删除的记录！");
                             return;
                         }
                         if (confirm("确定删除所选记录？")) {
                             ExtBatchOperate('batchdeleteDetail', recs, null, null, function (rtn) {
                                 for (var i = 0; i < recs.length; i++) {
                                     store.remove(recs[i]);
                                 }
                             });
                         }
                     }
                 }]
            });
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DetailList',
                idProperty: 'Id',
                data: { records: AimState["DetailList"] || [] },
                fields: [
			        { name: 'Id' },
                    { name: 'PId' },
                    { name: 'ImgPath' },
                    { name: 'Content' },
                    { name: 'Remark' },
                    { name: 'State' },
                    { name: 'Ext1' },
                    { name: 'Ext2' },
                    { name: 'Ext3' },
                    { name: 'Ext4' },
                    { name: 'Ext5' },
                    { name: 'CreateId' },
                    { name: 'CreateName' },
                    { name: 'CreateTime'}]
            });
            grid = new Ext.ux.grid.AimEditorGridPanel({
                title: '图片明细【首页默认展示第一张图片】',
                store: store,
                clicksToEdit: 1,
                renderTo: 'divdetail',
                columnLines: true,
                height: 200,
                viewConfig: {
                    forceFit: true
                },
                autoExpandColumn: 'Content',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'ImgPath', dataIndex: 'ImgPath', header: '图片', width: 80, renderer: function (val) {
                        if (val.length > 36) {
                            return val.substring(37);
                        }
                        return val;
                    }
                    },
                    { id: 'Content', dataIndex: 'Content', header: '描述', editor: { xtype: 'textarea' }, width: 300 },
					{ id: 'Remark', dataIndex: 'Remark', header: '备注', editor: { xtype: 'textarea' }, width: 100 }
                    ], tbar: tlBar
            });

            window.onresize = function () {
                grid.setWidth(0);
                grid.setWidth(Ext.get("divdetail").getWidth());
            };
        }
        function SuccessSubmit() {
            var checkText = $("#AuditUserId").find("option:selected").text();
            $("#AuditUserName").val(checkText);
            var checkText2 = $("#SecondApproveId").find("option:selected").text();
            $("#SecondApproveName").val(checkText2);
            var recs = store.getRange();
            if (recs.length == 0) {
                alert("请添加信息明细");
                return;
            }
            var dt = store.getModifiedDataStringArr(recs) || [];
            AimFrm.submit(pgAction, { "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, SubFinish);
        }
        function SuccessTJ() {
            var checkText = $("#AuditUserId").find("option:selected").text();
            $("#AuditUserName").val(checkText);
            var checkText2 = $("#SecondApproveId").find("option:selected").text();
            $("#SecondApproveName").val(checkText2);
            var recs = store.getRange();
            if (recs.length == 0) {
                alert("请添加信息明细");
                return;
            }
            var dt = store.getModifiedDataStringArr(recs) || [];
            if (confirm("确定提交审批吗？")) {
                $("#btntj").hide();
                var AuditUserId = $("#AuditUserId").val();
                var AuditUserName = $("#AuditUserName").val();
                AimFrm.submit(pgAction, { param: "tj", "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, function (rtn) {
                    Ext.getBody().mask("提交中,请稍后...");
                    jQuery.ajaxExec('submit', { id: rtn.data.rtnId }, function (rtn) {
                        window.setTimeout("AutoExecuteFlow('" + rtn.data.FlowId + "','" + AuditUserId + "','" + AuditUserName + "')", 1000);
                    });
                });
            }
        }
        function AutoExecuteFlow(flowid, AuditUserId, AuditUserName) {
            jQuery.ajaxExec('autoexecute', { "FlowId": flowid, AuditUserId: AuditUserId, AuditUserName: AuditUserName }, function (rtn) {
                if (rtn.data.error) {
                    alert(rtn.data.error);
                }
                else {
                    alert("提交成功！");
                    SubFinish();
                    Ext.getBody().unmask();
                }
            });
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
        function SubFinish(args) {
            RefreshClose();
        }
        
    </script>
    <script language="javascript" type="text/javascript">
        function onSave(task) {
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val() ? $("#TaskNameOpinion").val() : "";
            }
            var recs = store.getRange();
            var dt = store.getModifiedDataStringArr(recs) || [];
            $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val(), detail: dt }, function () { });
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
            if (window.parent.AimState["Task"].ApprovalNodeName == "申请人") {
                users.UserIds = $("#AuditUserId").val();
                users.UserNames = $("#AuditUserName").val();
            }
            if (window.parent.AimState["Task"].ApprovalNodeName == "领导审批") {
                if (nextName == "打回修改") {
                    users.UserIds = $("#CreateId").val();
                    users.UserNames = $("#CreateName").val();
                }
                else {
                    users.UserIds = $("#SecondApproveId").val();
                    users.UserNames = $("#SecondApproveName").val();
                }
            }
            if (window.parent.AimState["Task"].ApprovalNodeName == "宣传部审批") {
                if (nextName == "打回修改") {
                    users.UserIds = $("#CreateId").val();
                    users.UserNames = $("#CreateName").val();
                }
            }
            return users;
        }
        //流程结束时触发
        function onFinish(task) {
            if ($("#TaskNameOpinion").css("display") == "inline" && !$("#TaskNameOpinion").val()) {
                AimDlg.show("提交时必须填写审批意见！");
                return false;
            }
            jQuery.ajaxExec('submitfinish', { state: "End", id: $("#Id").val(), ApproveResult: window.parent.document.getElementById("id_SubmitState").value }, function () {
                RefreshClose();
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            图片新闻</h1>
    </div>
    <div id="editDiv">
        <fieldset>
            <legend>基本信息</legend>
            <table class="aim-ui-table-edit" style="border: none">
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                        <input id="CreateId" name="CreateId" />
                        <input id="TypeId" name="TypeId" />
                        <input id="AuditUserName" name="AuditUserName" />
                        <input id="SecondApproveName" name="SecondApproveName" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        标题
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Title" name="Title" class="validate[required]" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接收部门
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveDeptName" name="ReceiveDeptName" relateid="ReceiveDeptId"
                            popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx" popparam="ReceiveDeptName:Name;ReceiveDeptId:GroupID"
                            popstyle="width=700,height=500" style="width: 96%" />
                        <input id="ReceiveDeptId" type="hidden" name="ReceiveDeptId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接收人
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveUserName" name="ReceiveUserName" relateid="ReceiveUserId"
                            popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="ReceiveUserId:UserID;ReceiveUserName:Name"
                            popstyle="width=750,height=450" style="width: 96%" />
                        <input type="hidden" id="ReceiveUserId" name="ReceiveUserId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        部门审核人
                    </td>
                    <td class="aim-ui-td-data">
                        <select id="AuditUserId" name="AuditUserId" aimctrl="select" enum="AimState['AuditEnum']"
                            style="width: 100%" required="true">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        重要程度
                    </td>
                    <td class="aim-ui-td-data">
                        <select id="Grade" name="Grade" aimctrl='select' enumdata="EnumLevel" style="width: 100%"
                            required="true">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        登录系统自动弹出
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%;">
                        <input type="checkbox" id="HomePagePopup" name="HomePagePopup" style="width: 15px" />
                        <span>是</span>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        失效日期
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="ExpireTime" name="ExpireTime" aimctrl='date' />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        宣传部审批人
                    </td>
                    <td class="aim-ui-td-data">
                        <select id="SecondApproveId" name="SecondApproveId" aimctrl="select" enum="AimState['SecondApproveEnum']"
                            style="width: 100%" required="true">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption">
                        说明
                    </td>
                    <td class="aim-ui-td-data">
                        默认接收人为全院所有员工
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        发布部门
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="PostDeptId" name="PostDeptId" />
                        <input id="PostDeptName" name="PostDeptName" readonly="readonly" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        创建人
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="CreateName" name="CreateName" readonly="readonly" />
                    </td>
                </tr>
            </table>
            <div id="divdetail">
            </div>
        </fieldset>
        <fieldset id="examfield" style="display: none">
            <legend>审批意见区</legend>
            <table width="100%" id="tbOpinion" style="font-size: 12px; border: none;" class="aim-ui-table-edit">
            </table>
        </fieldset>
        <table class="aim-ui-table-edit" style="border: none" id="divbutton">
            <tr>
                <td class="aim-ui-button-panel" style="border: none;" colspan="4">
                    <a id="btntj" class="aim-ui-button submit">提交</a> <a id="btnSubmit" class="aim-ui-button submit">
                        保存</a> <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
