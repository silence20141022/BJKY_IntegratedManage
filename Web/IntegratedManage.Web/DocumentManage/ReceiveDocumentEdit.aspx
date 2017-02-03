<%@ Page Title="收文管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ReceiveDocumentEdit.aspx.cs" Inherits="IntegratedManage.Web.ReceiveDocumentEdit" %>

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
        var radioGroup, store1, grid1;
        var taskName = "";
        var FileType = "";
        var id = $.getQueryString({ ID: "id" });
        var taskId = $.getQueryString({ ID: 'TaskId' });
        function onPgLoad() {
            setPgUI();
            radioGroup = new Ext.form.RadioGroup({
                name: 'ApprovalNodeName',
                renderTo: 'taskName',
                columns: 2,
                items: [{ boxLabel: '院办主任', inputValue: '院办主任', name: 'ApprovalNodeName', id: 'zhuren', checked: true },
                        { boxLabel: '主管院长', inputValue: '主管院长', name: 'ApprovalNodeName', id: 'yuanzhang' }
                       ]
                //                listeners: { change: function(rg, radio) {
                //                    if (radio.boxLabel == "主管院长") {
                //                        $("#td_yuanzhangId").show();
                //                        $("#td_yuanzhangName").show();
                //                    }
                //                    else {
                //                        $("#td_yuanzhangId").hide();
                //                        $("#td_yuanzhangName").hide();
                //                    }
                //                }
                //                }
            })
            if (pgOperation != "c") {
                if ($("#ApprovalNodeName").val() == "院办主任") {
                    radioGroup.setValue("zhuren", true);
                }
                else {
                    radioGroup.setValue("yuanzhang", true);
                }
            }
            IniButton();
        }
        function setPgUI() {
            IniPanel1(); IniPanel2();
        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSave").click(function() {
                $("#btnSave").hide();
                var mainFile = ""; var attachment = "";
                var recs1 = store1.getRange(); var recs2 = store2.getRange();
                for (var k = 0; k < recs1.length; k++) {
                    mainFile += recs1[k].get("Id") + ",";
                }
                for (var k = 0; k < recs2.length; k++) {
                    attachment += recs2[k].get("Id") + ",";
                }
                $("#MainFile").val(mainFile);
                $("#Attachment").val(attachment);
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
            if (radioGroup.getValue().boxLabel == "主管院长" && !$("#YuanZhangId").val()) {
                AimDlg.show("首个审批环节是主管院长时必须配置具体人员！");
                return;
            }
            if (store1.getRange().length <= 0) {
                AimDlg.show("提交审批必须上传正文文件！");
                return;
            }
            $("#btnSubmit").hide();
            var mainFile = ""; var attachment = "";
            var recs1 = store1.getRange(); var recs2 = store2.getRange();
            for (var k = 0; k < recs1.length; k++) {
                mainFile += recs1[k].get("Id") + ",";
            }
            for (var k = 0; k < recs2.length; k++) {
                attachment += recs2[k].get("Id") + ",";
            }
            $("#MainFile").val(mainFile);
            $("#Attachment").val(attachment);
            AimFrm.submit(pgAction, {}, null, function(rtn) {
                Ext.getBody().mask("请稍候!");
                jQuery.ajaxExec('submit', { state: "Flowing", id: rtn.data.Id }, function(rtn2) {
                    window.setTimeout("AutoExecuteFlow('" + rtn2.data.WorkFlowInfo + "','" + rtn.data.Id + "')", 1000);

                });
            });
        }
        function AutoExecuteFlow(workflowinfo, id) {
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
                '<div class="thumb-separater"><label style="cursor:pointer;font-size:12px;color:blue" lang="{Id}" onclick="DocDownLoad(this)">{Name}</label></div>',
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
                // overClass: 'x-view-over',
                selectedClass: 'x-view-selected',
                itemSelector: 'div.thumb-separater'
            });
            var tlBar1 = new Ext.Toolbar({
                items: ['<b>正文区</b>：', {
                    text: '上传正文', hidden: pgOperation == "v",
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0;status:0;scroll=0";
                        var uploadurl = "../CommonPages/File/Upload.aspx";
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
            { text: '删除正文', hidden: pgOperation == "v",
                iconCls: 'aim-icon-delete', handler: function() {
                    var recs = dataview.getSelectedRecords();
                    if (recs.length > 0) {
                        store1.remove(recs);
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
                '<div class="thumb-separater"><label style="cursor:pointer;font-size:12px;color:blue" lang="{Id}" onclick="DocDownLoad(this)">{Name}</label></div>',
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
                items: ['<b>附件区</b>：', {
                    text: '上传附件',
                    iconCls: 'aim-icon-add', hidden: pgOperation == "v",
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
            { text: '删除附件', hidden: pgOperation == "v", iconCls: 'aim-icon-delete', handler: function() {
                var recs = dataview2.getSelectedRecords();
                if (!recs || recs.length <= 0) {
                    AimDlg.show("请先选择要删除的记录！");
                    return;
                }
                $.each(recs, function() {
                    store2.remove(this);
                })
            }
}]
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
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function DocDownLoad(val) {
            if (pgOperation == "v") {
                opencenterwin("/CommonPages/File/DownLoad.aspx?id=" + val.lang, "newwin0", 120, 120);
            }
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn;
            switch (this.id) {
                case "Id":
                    rtn = "";
                    if (record.get("WorkFlowState") == "Flowing" || record.get("WorkFlowState") == "End") {
                        rtn += "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showflowwin(\"" +
                                      value + "\")'>跟踪</label>  ";
                    }
                    break;
                case "FileSize":
                    if (value) {
                        rtn = Math.round(parseFloat(value) * 10 / 1024) / 10 + "KB";
                    }
                    break;
            }
            return rtn;
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
        window.onresize = function() {
            panel1.setWidth(0);
            panel1.setWidth(Ext.get("div1").getWidth());
            panel2.setWidth(0);
            panel2.setWidth(Ext.get("div2").getWidth());
        }
    </script>

    <script language="javascript" type="text/javascript">
        //保存流程和提交流程时触发
        function onSave(task) {
            var taskName = window.parent.AimState["Task"].ApprovalNodeName;
            if (window.parent.document.getElementById("textOpinion")) {
                window.parent.document.getElementById("textOpinion").value = $("#TaskNameOpinion").val();
            }
            if (taskName == "院办主任") {
                $.ajaxExec("ConfirmYuanZhang", { id: id, YuanZhangId: $("#YuanZhangId").val(), YuanZhangName: $("#YuanZhangName").val() },
                               function() { });
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
            var taskName = window.parent.AimState["Task"].ApprovalNodeName;
            var users = { UserIds: "", UserNames: "" };
            switch (taskName) {
                case "院办主任":
                    if (nextName == "提交院办秘书")
                        $.ajaxExecSync("GetNextUsers", { id: id, nextName: nextName }, function(rtn) {
                            if (rtn.data.NextUsers && rtn.data.NextUsers.length > 1) {
                                users.UserIds = rtn.data.NextUsers[0];
                                users.UserNames = rtn.data.NextUsers[1];
                            }
                        });
                    if (nextName == "提交主管院长") {
                        users.UserIds = $("#YuanZhangId").val();
                        users.UserNames = $("#YuanZhangName").val();
                    }
                    break;
                case "主管院长":
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
            收文信息</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" />
                    <input id="MainFile" name="MainFile" /><input id="Attachment" name="Attachment" />
                    <input id="ApprovalNodeName" name="ApprovalNodeName" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    收文名称
                </td>
                <td colspan="3">
                    <input id="FileName" name="FileName" style="width: 97%" class="validate[required]" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    来文机关
                </td>
                <td>
                    <input id="BringUnitName" name="BringUnitName" class="validate[required]" aimctrl='popup'
                        popurl="BringUnitSelect.aspx" popparam="BringUnitId:Id;BringUnitName:BringUnitName; "
                        popstyle="width=800,height=550" style="width: 78%" />
                    <input id="BringUnitId" name="BringUnitId" type="hidden" />
                </td>
                <td class="aim-ui-td-caption" style="width: 25%">
                    收文类别
                </td>
                <td style="width: 25%">
                    <select id="ReceiveType" name="ReceiveType" style="width: 90%;" aimctrl='select'
                        enum="ReceiveType">
                    </select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption" style="width: 25%">
                    密级
                </td>
                <td style="width: 25%">
                    <select id="SecrecyDegree" name="SecrecyDegree" style="width: 90%;" aimctrl='select'
                        enum="SecrecyDegree">
                    </select>
                </td>
                <td class="aim-ui-td-caption">
                    重要度
                </td>
                <td>
                    <select id="ImportanceDegree" name="ImportanceDegree" style="width: 90%;" aimctrl='select'
                        enum="ImportanceDegree">
                    </select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    来文字号
                </td>
                <td style="vertical-align: top;">
                    字
                    <input id="ComeWord" name="ComeWord" style="width: 35%" />号<input id="ComeWordSize"
                        name="ComeWordSize" style="width: 35%" />
                </td>
                <td class="aim-ui-td-caption">
                    收文字号
                </td>
                <td>
                    字
                    <input id="ReceiveWord" name="ReceiveWord" style="width: 35%" />号<input id="ReceiveWordSize"
                        name="ReceiveWordSize" style="width: 35%" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    收文日期
                </td>
                <td>
                    <input id="ReceiveDate" name="ReceiveDate" aimctrl="date" class="validate[required]" />
                </td>
                <td class="aim-ui-td-caption">
                    总页数(含附件)
                </td>
                <td>
                    <input id="Pages" name="Pages" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    首个审批环节
                </td>
                <td>
                    <div id="taskName">
                    </div>
                </td>
                <td class="aim-ui-td-caption">
                    主管院长
                </td>
                <td>
                    <input aimctrl="user" id="YuanZhangName" name="YuanZhangName" relateid="YuanZhangId" />
                    <input id="YuanZhangId" name="YuanZhangId" type="hidden" />
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    事由
                </td>
                <td colspan="3">
                    <textarea id="ReceiveReason" name="ReceiveReason" rows="" style="width: 97%; height: 35px;"
                        cols=""></textarea>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    拟办意见
                </td>
                <td colspan="3">
                    <textarea id="NiBanOpinion" name="NiBanOpinion" style="width: 97%; height: 35px;"
                        rows="3" cols=""></textarea>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    说明
                </td>
                <td colspan="3">
                    1 收文正文和附件请分开上传，各自可以有多个; 2 如果审批环节涉及主管院长，请配置主管院长人选;3 单击文件名可以下载。
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>文件区</legend>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td style="width: 50%">
                    <div id="div1" style="border-right: solid 1px gray">
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
