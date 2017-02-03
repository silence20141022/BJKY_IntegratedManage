<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="FrmVideoNewsCreateEdit.aspx.cs" Inherits="Aim.Portal.Web.Modules.FrmVideoNewsCreateEdit"
    Title="��Ƶ����" ValidateRequest="false" %>

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

    <script type="text/javascript">
        var EnumType = { 0: "δ����", 1: "�ѷ���" };
        var EnumLevel = { 0: "��ͨ", 1: "��Ҫ", 2: "����Ҫ" };
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
                if (window.parent.AimState["Task"]) {
                    taskName = window.parent.AimState["Task"].ApprovalNodeName;
                }
                IniOpinion();
                $("#divbutton").hide();
            }
            if (AimState["TypeId"]) {
                $("#TypeId").val(AimState["TypeId"]);
            }
        }
        function setPgUI() {
            FormValidationBind('btntj', SuccessTJ);
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function() {
                window.close();
            });
            tlBar = new Ext.ux.AimToolbar({
                hidden: pgOperation == "r" || $.getQueryString({ "ID": "InFlow" }) == "T",
                items: [{
                    text: '�����Ƶ�ļ�',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                        var uploadurl = '/CommonPages/File/Upload.aspx';
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //һ�ο����ϴ�����ļ� 
                        var fileIds = "";
                        if (rtn != undefined) {
                            var strarray = rtn.split(",");
                            var recType = store.recordType;
                            $.each(strarray, function(rtn) {
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
                     text: 'ɾ��',
                     iconCls: 'aim-icon-delete',
                     handler: function() {
                         var recs = grid.getSelectionModel().getSelections();
                         if (!recs || recs.length <= 0) {
                             AimDlg.show("����ѡ��Ҫɾ���ļ�¼��");
                             return;
                         }
                         if (confirm("ȷ��ɾ����ѡ��¼��")) {
                             ExtBatchOperate('batchdeleteDetail', recs, null, null, function(rtn) {
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
                title: '����Ƶ�ļ���',
                store: store,
                clicksToEdit: 1,
                renderTo: 'divdetail',
                columnLines: true,
                height: 200,
                viewConfig: {
                    forceFit: true
                },
                width: Ext.get("divdetail").getWidth(),
                autoExpandColumn: 'Content',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '��ʶ', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'ImgPath', dataIndex: 'ImgPath', header: '��Ƶ�ļ�', width: 140, renderer: function(val) {
                        if (val.length > 36) {
                            return val.substring(37);
                        }
                        return val;
                    }
                    },
                    { id: 'Content', dataIndex: 'Content', header: '����', editor: { xtype: 'textarea' }, width: 300 }
                    ], tbar: tlBar
            });

            window.onresize = function() {
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
                alert("�������Ϣ��ϸ");
                return;
            }
            var dt = store.getModifiedDataStringArr(recs) || [];
            AimFrm.submit(pgAction, { "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, function() {
                if (window.opener) {
                    window.opener.store.reload();
                }
                window.close();
            });
        }
        function SuccessTJ() {
            var checkText = $("#AuditUserId").find("option:selected").text();
            $("#AuditUserName").val(checkText);
            var checkText2 = $("#SecondApproveId").find("option:selected").text();
            $("#SecondApproveName").val(checkText2);
            var recs = store.getRange();
            if (recs.length == 0) {
                alert("�������Ϣ��ϸ");
                return;
            }
            var dt = store.getModifiedDataStringArr(recs) || [];
            if (confirm("ȷ��Ҫ�ύ������?")) {
                $("#btntj").hide();
                var AuditUserId = $("#AuditUserId").val();
                var AuditUserName = $("#AuditUserName").val();
                AimFrm.submit(pgAction, { param: "tj", "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, function(rtn) {
                    Ext.getBody().mask("�ύ��,���Ժ�...");
                    jQuery.ajaxExec('submit', { id: rtn.data.rtnId }, function(rtn) {
                        window.setTimeout("AutoExecuteFlow('" + rtn.data.FlowId + "','" + AuditUserId + "','" + AuditUserName + "')", 1000);
                    });
                });
            }
        }

        function AutoExecuteFlow(flowid, AuditUserId, AuditUserName) {
            jQuery.ajaxExec('autoexecute', { "FlowId": flowid, AuditUserId: AuditUserId, AuditUserName: AuditUserName }, function(rtn) {
                if (rtn.data.error) {
                    alert(rtn.data.error);
                }
                else {
                    alert("�ύ�ɹ���");
                    if (window.opener) {
                        window.opener.store.reload();
                    }
                    window.close();
                    Ext.getBody().unmask();
                }
            });
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
            if (taskName == "������") {
                var recs = store.getRange();
                var dt = store.getModifiedDataStringArr(recs) || [];
                $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val(), detail: dt }, function() { });
            }
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
                users.UserIds = $("#SecondApproveId").val();
                users.UserNames = $("#SecondApproveName").val();
            }
            return users;
        }
        //���̽���ʱ����
        function onFinish(task) {
            jQuery.ajaxExec('submitfinish', { state: "End", id: $("#Id").val(), ApproveResult: window.parent.document.getElementById("id_SubmitState").value }, function() {
                RefreshClose();
            });
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            ��Ƶ����</h1>
    </div>
    <div id="editDiv">
        <fieldset>
            <legend>������Ϣ</legend>
            <table class="aim-ui-table-edit" style="border: none">
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                        <input id="TypeId" name="TypeId" />
                        <input id="AuditUserName" name="AuditUserName" />
                        <input id="SecondApproveName" name="SecondApproveName" />
                        <input id="PostDeptId" name="PostDeptId" />
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
                <%-- <tr>
                    <td class="aim-ui-td-caption">
                        չʾͼƬ
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="ShowImg" name="ShowImg" style="" aimctrl='file' mode='single' />
                    </td>
                    <td colspan="2" style="color: Red;">
                        �Ż��ϵ�չʾͼƬ����û���ϴ���ƵͼƬ,ϵͳ���Զ�����Ƶ�н�ȡͼƬ��
                    </td>
                </tr>--%>
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
                        �����û�
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveUserName" name="ReceiveUserName" relateid="ReceiveUserId"
                            popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="ReceiveUserId:UserID;ReceiveUserName:Name"
                            popstyle="width=750,height=450" style="width: 96%" />
                        <input type="hidden" id="ReceiveUserId" name="ReceiveUserId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        ���������
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%">
                        <select id="AuditUserId" name="AuditUserId" aimctrl="select" enum="AimState['AuditEnum']"
                            required="true" style="width: 100%">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        ��ҳ�Զ�����
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%">
                        <label>
                            <input type="checkbox" id="HomePagePopup" name="HomePagePopup" />��</label>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        ������������
                    </td>
                    <td>
                        <select id="SecondApproveId" name="SecondApproveId" aimctrl="select" enum="AimState['SecondApproveEnum']"
                            style="width: 100%" required="true">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption">
                        ˵��
                    </td>
                    <td class="aim-ui-td-data">
                        Ĭ�Ͻ�����ΪȫԺ����Ա��
                    </td>
                </tr>
                <%--   <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%;">
                        <label>
                           ��¼ϵͳ�Զ�����</label>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        ʧЧ����
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="ExpireTime" name="ExpireTime" aimctrl='date' style="width: 70%" />
                    </td>
                </tr>--%>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        ��������
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="PostDeptName" name="PostDeptName" readonly="readonly" style="width: 100%" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        ������
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="CreateName" name="CreateName" readonly="readonly" style="width: 100%" />
                    </td>
                </tr>
            </table>
            <div id="divdetail">
            </div>
        </fieldset>
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
