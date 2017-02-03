<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="NewsCreateEdit.aspx.cs" Inherits="Aim.Portal.Web.Modules.PubNews.NewsCreateEdit"
    Title="��Ϣ����" ValidateRequest="false" %>

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
    </style>
    <script language="JScript" src="fckeditor/fckeditor.js" type="text/javascript"></script>
    <script type="text/javascript">
        var EnumType = { 0: "δ����", 1: "�ѷ���" };
        var EnumLevel = { 0: "��ͨ", 1: "��Ҫ", 2: "����Ҫ" };
        var ReportTypeEnum = { 'Week': "�ܱ�", 'Month': "�±�", 'Quarter': "����" };
        var type = $.getQueryString({ ID: 'TypeId', DefaultValue: '' });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = "";
        function onPgLoad() {
            setPgUI();
            if ($.getQueryString({ ID: "op" }) == 'c') {
                $("#MhtFile").next().hide();
                $("#mhtContent").hide();
                if (AimState["DeptInfo"]) {
                    $("#PostDeptName").val(AimState["DeptInfo"].groupName);
                    $("#PostDeptId").val(AimState["DeptInfo"].groupId);
                    $("#CreateName").val(AimState["UserInfo"].Name);
                    $("#CreateId").val(AimState["UserInfo"].UserID);
                }
            }
            else if ($.getQueryString({ ID: "op" }) == 'u') {
                if (AimState["frmdata"].FileType == 'mht') {
                    $("#MhtFile").next().show();
                    $("#Content___Frame").hide();
                }
                else {
                    $("#MhtFile").next().hide();
                    $("#mhtContent").hide();
                }
                $("input[type=radio]").each(function () {
                    if (this.value == AimState["frmdata"][this.name]) {
                        this.checked = true;
                    }
                });
            }
            var typeName = $("#TypeId").find("option:selected").text();
            $("#trSecondApprove").css("display", typeName == "Ժ������" ? "block" : "none");
            if ($.getQueryString({ ID: "InFlow", DefaultValue: "" }) == "T" || LinkView == "T") {
                $("#divbutton").hide();
                if (window.parent.AimState["Task"]) {
                    taskName = window.parent.AimState["Task"].ApprovalNodeName;
                }
                IniOpinion();
            }
        }
        function setPgUI() {
            //�󶨰�ť��֤
            FormValidationBind('btntj', SuccessTJ);
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function () {
                window.close();
            });
        }
        function TypeChange() {
            var typeName = $("#TypeId").find("option:selected").text();
            $("#trSecondApprove").css("display", typeName == "Ժ������" ? "block" : "none");
        }
        //��֤�ɹ�ִ�б��淽��
        function SuccessSubmit() {
            var oEditor = FCKeditorAPI.GetInstance("Content");
            if (!oEditor.EditorDocument.body.innerText) {
                alert("�������ݲ���Ϊ��!");
                return;
            }
            var checkText = $("#AuditUserId").find("option:selected").text();
            $("#AuditUserName").val(checkText);
            var checkText2 = $("#SecondApproveId").find("option:selected").text();
            $("#SecondApproveName").val(checkText2);
            AimFrm.submit(pgAction, { HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, SubFinish);
        }
        function SuccessTJ() {
            var oEditor = FCKeditorAPI.GetInstance("Content");
            if (!oEditor.EditorDocument.body.innerText) {
                alert("�������ݲ���Ϊ��!");
                return;
            }
            var checkText = $("#AuditUserId").find("option:selected").text();
            $("#AuditUserName").val(checkText);
            var checkText2 = $("#SecondApproveId").find("option:selected").text();
            $("#SecondApproveName").val(checkText2);
            if (!$("#AuditUserId").val()) {
                AimDlg.show("��ѡ���������");
                return;
            }
            var typeName = $("#TypeId").find("option:selected").text();
            if (typeName == "Ժ������" && !$("#SecondApproveId").val()) {
                AimDlg.show("Ժ�����ű���ѡ������������ˣ�");
                return;
            }
            if (confirm("ȷ��Ҫ�����ύ��")) {
                $("#btntj").hide();
                var AuditUserId = $("#AuditUserId").val();
                var AuditUserName = $("#AuditUserName").val();
                AimFrm.submit(pgAction, { param: "tj", HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, function (rtn) {
                    Ext.getBody().mask("�ύ��,���Ժ�...");
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
                    alert("�ύ�ɹ���");
                    SubFinish();
                    Ext.getBody().unmask();
                }
            });
        }

        function SubFinish(args) {
            RefreshClose();
        }

        function radioClick(tag) {
            $("#Content___Frame").hide();
            $("#mhtContent").hide();

            if (tag == "Content___Frame") {
                contype = "html";
                $("#Content___Frame").show();
                $("#MhtFile").next().hide();
            }
            else {
                $("#mhtContent").show();
                contype = "mht";
                $("#MhtFile").next().show();
            }
        }
        // ��ȡ�༭������������ 
        function getEditorTextContents(EditorName) {
            var oEditor = FCKeditorAPI.GetInstance(EditorName);
            return (oEditor.EditorDocument.body.innerText);
        }
        function doloadmht(obj) {
            if (obj.value) {
                //alert(obj.value.substring(0, obj.value.length - 1));
                //$("#mhtframe").attr("src", "/Document/" + obj.value.substring(0, obj.value.length - 1));
                document.getElementById("mhtframe").src = "/Document/" + obj.value.substring(0, obj.value.length - 1);
            }
        }

        function IniOpinion() {
            var tab = document.getElementById("tbOpinion");
            var myData = AimState["Opinion"] || [];
            if (AimState["Opinion"] && AimState["Opinion"].length > 0) {
                $("#examfield").show();
                for (var i = 1; i < myData.length; i++) {//��1��ʼ ��Ϊ�˲���ʾ�Զ��ύ������
                    var tr = tab.insertRow(); tr.height = 32;
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].ApprovalNodeName ? myData[i].ApprovalNodeName + "���" : '';
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
                    td.innerHTML = '�������:';
                    td.style.width = "100px";
                    var td = tr.insertCell();
                    //��ͬ��,���,�ܾ�,�˻�  ��������������֡�������ǲ�ͬ�⡣�������ͬ�� 
                    if (myData[i].Result && (myData[i].Result.indexOf("��ͬ��") >= 0 || myData[i].Result.indexOf("���") >= 0 || myData[i].Result.indexOf("�ܾ�") >= 0) || myData[i].Result.indexOf("�˻�") >= 0) {
                        td.innerHTML = "��ͬ��";
                    }
                    else {
                        td.innerHTML = "ͬ��";
                    }
                    td.style.textDecoration = "underline";
                    var td = tr.insertCell(); td.innerHTML = 'ǩ��:';
                    var td = tr.insertCell();
                    td.innerHTML = '<img style="width: 70px; height: 25px;" src="/CommonPages/File/DownLoadSign.aspx?UserId=' + myData[i].OwnerId + '" />';
                    var td = tr.insertCell(); td.innerHTML = '����ʱ��:';
                    var td = tr.insertCell();
                    td.innerHTML = myData[i].FinishTime ? myData[i].FinishTime : '';
                    td.style.textDecoration = "underline";
                }
            }
            if (LinkView != "T") {
                $("#examfield").show();
                var tr = tab.insertRow(); tr.height = 32; var td = tr.insertCell();
                td.innerHTML = taskName + "���";
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
        function onSave(task) {
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val() ? $("#TaskNameOpinion").val() : "";
            }
            //��ʱ���쵼������ʱ��ֱ����΢���޸ģ�ֱ��ͨ����Ҳ���ԣ������ڴ˲����ڵ��ж�
            $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val() }, function () { });
        }
        //�ύ����ʱ����
        function onSubmit(task) {
            if ($("#TaskNameOpinion").css("display") == "inline" && !$("#TaskNameOpinion").val()) {
                AimDlg.show("�ύʱ������д���������");
                return false;
            }
        }
        function onGiveUsers(nextName) {
            var users = { UserIds: "", UserNames: "" };
            if (window.parent.AimState["Task"].ApprovalNodeName == "������") {
                users.UserIds = $("#AuditUserId").val();
                users.UserNames = $("#AuditUserName").val();
            }
            if (window.parent.AimState["Task"].ApprovalNodeName == "�쵼����") {
                if (nextName == "����޸�") {
                    users.UserIds = $("#CreateId").val();
                    users.UserNames = $("#CreateName").val();
                }
                else {
                    users.UserIds = $("#SecondApproveId").val();
                    users.UserNames = $("#SecondApproveName").val();
                }
            }
            return users;
        }

        //���̽���ʱ����
        function onFinish(task) {
            jQuery.ajaxExec('submitfinish', { state: "End", id: $("#Id").val(), ApproveResult: window.parent.document.getElementById("id_SubmitState").value }, function () {
                RefreshClose();
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            ��Ϣ����</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit" style="border: none">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                        <input id="CreateId" name="CreateId" />
                        <input id="AuditUserName" name="AuditUserName" />
                        <input id="SecondApproveName" name="SecondApproveName" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ����
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Title" name="Title" class="validate[required]" style="width: 100%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ���ղ���
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
                        ������
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveUserName" name="ReceiveUserName" relateid="ReceiveUserId"
                            popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="ReceiveUserId:UserID;ReceiveUserName:Name"
                            popstyle="width=750,height=450" style="width: 96%" />
                        <input type="hidden" id="ReceiveUserId" name="ReceiveUserId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        ���������
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%;">
                        <select id="AuditUserId" name="AuditUserId" aimctrl="select" enum="AimState['AuditEnum']"
                            style="width: 100%">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        ������Ŀ
                    </td>
                    <td style="width: 35%;">
                        <select id="TypeId" name="TypeId" aimctrl='select' enumdata="NewsTypeEnum" style="width: 100%;"
                            class="validate[required]" onchange="TypeChange()">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ��ҳ�Զ�����
                    </td>
                    <td class="aim-ui-td-data">
                        <label>
                            <input type="checkbox" id="HomePagePopup" name="HomePagePopup" />��</label>
                    </td>
                    <td class="aim-ui-td-caption">
                        ʧЧ����
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="ExpireTime" name="ExpireTime" aimctrl='date' style="width: 100%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ��������
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="PostDeptId" name="PostDeptId" />
                        <input id="PostDeptName" name="PostDeptName" readonly="readonly" style="width: 100%" />
                    </td>
                    <td class="aim-ui-td-caption">
                        ������
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="CreateName" name="CreateName" readonly="readonly" style="width: 100%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ����
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input type="hidden" id="Attachments" name="Attachments" aimctrl='file' value=""
                            style="width: 100%" />
                    </td>
                </tr>
                <tr id="trSecondApprove">
                    <td class="aim-ui-td-caption">
                        ��ҳչʾͼƬ
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="Pictures" name="Pictures" aimctrl='file' value="" mode='single' />
                    </td>
                    <td class="aim-ui-td-caption">
                        ������������
                    </td>
                    <td>
                        <select id="SecondApproveId" name="SecondApproveId" aimctrl="select" enum="AimState['SecondApproveEnum']"
                            style="width: 100%">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="text-align: right;">
                        ��������
                    </td>
                    <td style="border-width: 0px; vertical-align: middle;">
                        <input type="radio" id="rdohtml" name="FileType" tag="Content___Frame" checked="checked"
                            onclick="radioClick(this.tag)" style="border-width: 0px;" value="html" />html&nbsp;
                        <input type="radio" id="rdomht" name="FileType" tag="mhtContent" onclick="radioClick(this.tag)"
                            style="border-width: 0px;" value="mht" />mht�ļ�&nbsp;<input id="MhtFile" onpropertychange="doloadmht(this)"
                                name="MhtFile" style="width: 100px;" aimctrl='file' mode='single' />
                    </td>
                    <td class="aim-ui-td-caption">
                        ˵��
                    </td>
                    <td>
                        Ĭ�Ͻ�����ΪȫԺ����Ա��
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-data" colspan="4">
                        <textarea id="Content" aimctrl="editor" style="width: 100%; height: 600px" rows=""
                            cols=""></textarea>
                        <div id="mhtContent" style="height: 400px;">
                            <iframe id="mhtframe" width="100%" height="100%" id="frameContent" name="frameContent"
                                frameborder="0"></iframe>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <fieldset id="examfield" style="display: none">
            <legend>���������</legend>
            <table width="100%" id="tbOpinion" style="font-size: 12px; border: none;" class="aim-ui-table-edit">
            </table>
        </fieldset>
        <table class="aim-ui-table-edit" style="border: none" id="divbutton">
            <tr>
                <td class="aim-ui-button-panel" style="border: none;" colspan="4">
                    <a id="btntj" class="aim-ui-button submit">�ύ</a> <a id="btnSubmit" class="aim-ui-button submit">
                        ����</a> <a id="btnCancel" class="aim-ui-button cancel">ȡ��</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
