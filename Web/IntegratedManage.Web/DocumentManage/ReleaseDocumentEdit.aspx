<%@ Page Title="发文管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ReleaseDocumentEdit.aspx.cs" Inherits="IntegratedManage.Web.ReleaseDocumentEdit" %>

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
        var myData1, store1, tpl1, dataview, store2, tpl2, panel1, panel2;
        var InFlow = $.getQueryString({ ID: "InFlow" });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = "";
        var hidetbar = true;
        var id = $.getQueryString({ ID: "id" });
        function onPgLoad() {
            setPgUI();
            IniButton();
            IniPanel1();
            IniPanel2();
        }
        function setPgUI() {
            if (window.parent.AimState["Task"]) {
                taskName = window.parent.AimState["Task"].ApprovalNodeName;
            }
            // 打字员   清稿套红 •	在登记文号处确认盖电子章，但在套红、清稿处不显示，提交到后面核稿处显示。
            fileId = $("#ApproveContent").val();
            if (pgOperation == "v" && InFlow != "T") {
                hidetbar = true;
            }
            if (InFlow == "T" && taskName == "拟稿人" && LinkView != "T") {
                hidetbar = false;
            }
            if (pgOperation != "v") {
                hidetbar = false;
            }
        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSave").click(function() {
                $("#btnSave").hide();
                $("#ApproveContent").val("");
                $.each(store1.getRange(), function() {
                    $("#ApproveContent").val($("#ApproveContent").val() + this.get("Id"));
                });
                $("#Attachment").val("");
                $.each(store2.getRange(), function() {
                    $("#Attachment").val($("#Attachment").val() + this.get("Id"));
                });
                AimFrm.submit(pgAction, {}, null, SubFinish);
            });
            $("#btnCancel").click(function() {
                window.close();
            });
            if (InFlow == "T" || LinkView == "T") {
                $("#divButton").hide();
                IniOpinion();
            }
        }
        function SuccessSubmit() {
            if (!$("#ApproveLeaderIds").val()) {
                AimDlg.show("必须选择审批的部门领导才能提交！");
                return;
            }
            $("#ApproveContent").val("");
            $.each(store1.getRange(), function() {
                $("#ApproveContent").val($("#ApproveContent").val() + this.get("Id"));
            });
            $("#Attachment").val("");
            $.each(store2.getRange(), function() {
                $("#Attachment").val($("#Attachment").val() + this.get("Id"));
            });
            if (!$("#ApproveContent").val()) {
                AimDlg.show("必须上传正文才能提交！");
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
                '<div class="thumb-separater" ><label style="cursor:pointer;font-size:12px;color:blue" lang="{Id}" onclick="DocEdit(this)">{Name}</label></div>',
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
                selectedClass: 'x-view-selected',
                itemSelector: 'div.thumb-separater'
            });
            var tlBar1 = new Ext.Toolbar({
                items: ['<span style=font-size:12px><b>正文区</b></span>', {
                    text: '上传正文',
                    hidden: hidetbar,
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        if (store1.getRange().length > 0) {
                            AimDlg.show("正文只允许存在一个，如要替换请先删除原有正文！");
                            return;
                        }
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
                        var uploadurl = '../CommonPages/File/Upload.aspx?IsSingle=true&Filter=' + escape("文件格式") + "(*.doc;*.docx)|*.doc;*.docx";
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
            { text: '删除正文', iconCls: 'aim-icon-delete', hidden: hidetbar,
                handler: function() {
                    var recs = dataview.getSelectedRecords();
                    if (recs.length > 0) {
                        store1.remove(recs[0]);
                    }
                }
            }, { text: '编辑正文', iconCls: 'aim-icon-edit', hidden: hidetbar,
                handler: function() {
                    var recs = dataview.getSelectedRecords();
                    if (recs.length > 0) {
                        opencenterwin("DocumentEdit.aspx?fileId=" + recs[0].get("Id") + "&fileName=" + escape(recs[0].get("Name")) + "&taskName=" + escape(taskName) + "&id=" + id + "&InFlow=" + InFlow + "&LinkView=" + LinkView + "&op=" + pgOperation, "", 1100, 650);
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
        function IniPanel2() {
            myData2 = { total: AimSearchCrit["RecordCount"],
                records: AimState["DataList2"] || []
            }
            store2 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList2',
                idProperty: 'Id',
                data: myData2,
                fields: [{ name: 'Id' }, { name: 'Name'}]
            });
            tpl2 = new Ext.XTemplate(
                '<tpl for=".">',
                '<div class="thumb-separater"><label style="cursor:pointer;font-size:12px;color:blue" lang="{Id}" onclick="DocEdit(this)">{Name}</label></div>',
                '</tpl>'
                );
            dataview2 = new Ext.DataView({
                store: store2,
                tpl: tpl2,
                autoScroll: true,
                autoHeight: true,
                singleSelect: false,
                multiSelect: true,
                simpleSelect: true,
                // overClass: 'x-view-over',
                selectedClass: 'x-view-selected',
                itemSelector: 'div.thumb-separater'
            });
            tlBar2 = new Ext.Toolbar({
                items: ['<span style=font-size:12px><b>附件区</b></span>', {
                    text: '上传附件', hidden: hidetbar,
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
                        var uploadurl = '../CommonPages/File/Upload.aspx?Filter=' + escape("文件格式") + "(*.doc;*.docx)|*.doc;*.docx"; ;
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件
                        if (rtn != undefined) {
                            var strarray = rtn.split(",");
                            if (strarray.length > 0) {
                                var recType = store2.recordType;
                                for (var i = 0; i < strarray.length; i++) {
                                    if (store2.find("Name", strarray[i].substring(37, strarray[0].length)) == -1) {//没有同名的文件      
                                        if (strarray[i]) {
                                            var p = new recType({ Id: strarray[i].substring(0, 36), Name: strarray[i].substring(37, strarray[0].length) });
                                            store2.insert(store2.data.length, p);
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
            { text: '删除附件', iconCls: 'aim-icon-delete', hidden: hidetbar,
                handler: function() {
                    var recs = dataview2.getSelectedRecords();
                    if (!recs || recs.length <= 0) {
                        AimDlg.show("请先选择要删除的记录！");
                        return;
                    }
                    $.each(recs, function() {
                        store2.remove(this);
                    })
                }
            }, { text: '编辑附件', iconCls: 'aim-icon-edit', hidden: hidetbar,
                handler: function() {
                    var recs = dataview2.getSelectedRecords();
                    if (recs.length > 0) {
                        opencenterwin("DocumentEdit.aspx?fileId=" + recs[0].get("Id") + "&fileName=" + escape(recs[0].get("Name")) + "&taskName=" + escape(taskName) + "&id=" + id + "&InFlow=" + InFlow + "&LinkView=" + LinkView + "&op=" + pgOperation, "", 1100, 650);
                    }
                } }]
            });
            panel2 = new Ext.Panel({
                layout: 'fit',
                height: 80,
                renderTo: 'div2',
                tbar: tlBar2,
                border: false,
                autoScroll: true,
                items: [dataview2]
            });
        }
        function DocEdit(val) {//院办主任核稿打回到打字员，前紧才能后松
            if (pgOperation == "v") {
                if (InFlow == "T" && taskName == "拟稿人" && LinkView != "T") {
                    return
                }
                if ($("#ReleaseContent").val()) {//一但打字员清稿后，后续的查看都是查看发文内容，而不是审批内容
                    opencenterwin("DocumentEdit.aspx?fileId=" + $("#ReleaseContent").val() + "&fileName=" + escape(val.innerHTML) + "&taskName=" + escape(taskName) + "&id=" + id + "&InFlow=" + InFlow + "&LinkView=" + LinkView + "&op=" + pgOperation, "", 1100, 650);
                }
                else {
                    opencenterwin("DocumentEdit.aspx?fileId=" + val.lang + "&fileName=" + escape(val.innerHTML) + "&taskName=" + escape(taskName) + "&id=" + id + "&InFlow=" + InFlow + "&LinkView=" + LinkView + "&op=" + pgOperation, "", 1100, 650);
                }
            }
        }
        function AutoExecuteFlow(workflowinfo) {
            var strarray = workflowinfo.split(",");
            jQuery.ajaxExec('AutoExecuteFlow', { WorkFlowInfo: strarray, id: id }, function(rtn) {
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
            if (AimState["Opinion"] && AimState["Opinion"].length > 0) {
                $("#examfield").show();
                for (var i = 0; i < myData.length; i++) {//从1开始 是为了不显示自动提交的任务
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
                if (taskName == "部门领导" || taskName == "归口部门会签" || taskName == "相关部门会签" || taskName == "院办主任" || taskName == "院办主任核稿" || taskName == "主管院长" || taskName == "院长审批") {
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
                }
            }
        }
        window.onresize = function() {
            panel1.setWidth(0); panel1.setWidth(Ext.get("div1").getWidth());
            panel2.setWidth(0); panel2.setWidth(Ext.get("div2").getWidth());
        }
       
    </script>

    <script language="javascript" type="text/javascript">
        //保存流程和提交流程时触发
        function onSave(task) {
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val() ? $("#TaskNameOpinion").val() : "";
            }
            if (taskName == "拟稿人") {//拟稿人可能针对打回的文件修改后，重新上传
                $("#ApproveContent").val("");
                $.each(store1.getRange(), function() {
                    $("#ApproveContent").val($("#ApproveContent").val() + this.get("Id"));
                });
                $("#Attachment").val("");
                $.each(store2.getRange(), function() {
                    $("#Attachment").val($("#Attachment").val() + this.get("Id"));
                });
                $.ajaxExec("update", { JsonString: AimFrm.getJsonString(), id: $("#Id").val() }, function() { });
            }
        }
        //提交流程时触发
        function onSubmit(task) {
            if ($("#TaskNameOpinion").css("display") == "inline" && !$("#TaskNameOpinion").val()) {
                AimDlg.show("提交时必须填写审批意见！");
                return false;
            }
            if (taskName == "院办文书" && !$("#DocumentZiHao").val()) {//登记文号
                AimDlg.show("院办文书环节必须输入文号才能提交！");
                return false;
            }
            else {
                $.ajaxExec("UpdateZiHao", { id: id, DocumentZiHao: $("#DocumentZiHao").val() }, function() { })
            }
        }
        function onGiveUsers(nextName) {
            var users = { UserIds: "", UserNames: "" };
            switch (taskName) {
                case "部门领导":
                    if (nextName == "提交院办主任") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "归口部门会签":
                case "相关部门会签":
                    if (nextName == "院办主任") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "主管院长":
                case "院长审批":
                    if (nextName == "提交院办文书" || nextName == "提交院长审批") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "院办文书":
                    if (nextName == "打字员") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "打字员":
                    if (nextName == "院办主任核稿") {
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    }
                    break;
                case "拟稿人":
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
            发文信息</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" />
                    <input id="ApproveContent" name="ApproveContent" />
                    <input id="ReleaseContent" name="ReleaseContent" />
                    <input id="Attachment" name="Attachment" />
                    <input id="CreateTime" name="CreateTime" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    发文标题
                </td>
                <td colspan="3">
                    <input id="Title" name="Title" class="validate[required]" style="width: 97%" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption" style="width: 25%">
                    拟稿部门
                </td>
                <td style="width: 25%">
                    <input id="CreateDeptName" name="CreateDeptName" /><input type="hidden" id="CreateDeptId"
                        name="CreateDeptId" />
                </td>
                <td class="aim-ui-td-caption" style="width: 25%">
                    提交审批部门领导
                </td>
                <td style="width: 25%">
                    <input id="ApproveLeaderNames" name="ApproveLeaderNames" aimctrl='user' relateid="ApproveLeaderIds" />
                    <input type="hidden" id="ApproveLeaderIds" name="ApproveLeaderIds" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    发送机关
                </td>
                <td>
                    <input id="PrimaryReceiver" name="PrimaryReceiver" />
                </td>
                <td class="aim-ui-td-caption">
                    抄送机关
                </td>
                <td>
                    <input id="SecondaryReceiver" name="SecondaryReceiver" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    登记文号
                </td>
                <td>
                    <input id="DocumentZiHao" name="DocumentZiHao" />
                </td>
                <td class="aim-ui-td-caption">
                    拟稿人
                </td>
                <td>
                    <input id="CreateName" name="CreateName" /><input type="hidden" id="CreateId" name="CreateId" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    说明
                </td>
                <td colspan="3">
                    文档列表中正文只能有一个，附件可以有多个或无；单击名称可以在OFFICE界面编辑或批注；
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>文件区</legend>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td style="width: 50%; border-right: solid 1px gray;">
                    <div id="div1">
                    </div>
                </td>
                <td style="width: 50%">
                    <div id="div2">
                    </div>
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
                    <a id="btnSubmit" class="aim-ui-button submit">提交</a>&nbsp;&nbsp; <a id="btnSave"
                        class="aim-ui-button submit">暂存</a>&nbsp;&nbsp; <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
