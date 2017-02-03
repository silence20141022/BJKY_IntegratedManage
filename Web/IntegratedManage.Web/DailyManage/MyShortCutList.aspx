<%@ Page Title="我的快捷" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="MyShortCutList.aspx.cs" Inherits="IntegratedManage.Web.MyShortCutList" %>

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
            width: 120px;
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
        function onPgLoad() {
            setPgUI();
            //            radioGroup = new Ext.form.RadioGroup({
            //                name: 'ApprovalNodeName',
            //                renderTo: 'taskName',
            //                columns: 2,
            //                items: [{ boxLabel: '院办主任', inputValue: '院办主任', name: 'ApprovalNodeName', id: 'zhuren', checked: true },
            //                        { boxLabel: '主管院长', inputValue: '主管院长', name: 'ApprovalNodeName', id: 'yuanzhang' }
            //                       ]
            //                //                listeners: { change: function(rg, radio) {
            //                //                    if (radio.boxLabel == "主管院长") {
            //                //                        $("#td_yuanzhangId").show();
            //                //                        $("#td_yuanzhangName").show();
            //                //                    }
            //                //                    else {
            //                //                        $("#td_yuanzhangId").hide();
            //                //                        $("#td_yuanzhangName").hide();
            //                //                    }
            //                //                }
            //                //                }
            //            })
            //            if (pgOperation != "c") {
            //                if ($("#ApprovalNodeName").val() == "院办主任") {
            //                    radioGroup.setValue("zhuren", true);
            //                }
            //                else {
            //                    radioGroup.setValue("yuanzhang", true);
            //                }
            //            }
            //  IniButton();
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
                AimDlg.show("收文必须上传正文文件！");
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
                fields: [{ name: 'Id' }, { name: 'AuthId' }, { name: 'AuthName' }, { name: 'ModuleUrl' }, { name: 'IconFileName' }, { name: 'IconFileId'}]
            });
            tpl1 = new Ext.XTemplate(
                '<tpl for=".">',
                '<div class="thumb-separater"><table width="99%"><tr><td align="right"><img style="height:32px;width:32px" src="/Document/{IconFileId}_{IconFileName}" /></td>',
                '<td><label style="cursor:pointer;font-size:12px;color:blue" lang="{ModuleUrl}" onclick="OpenModule(this)">{AuthName}</label></td></tr></table></div>',
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
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        opencenterwin("MyShortCutEdit.aspx?op=c", "", 700, 300);
                    }
                }, {
                    text: '编辑',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = dataview.getSelectedRecords();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        opencenterwin("MyShortCutEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 700, 300);
                    }
                },
            { text: '删除',
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
                height: 120,
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
                items: [{
                    text: '上传附件',
                    iconCls: 'aim-icon-add', hidden: pgOperation == "v",
                    handler: function() {
                        opencenterwin("MyShortCutEidt.aspx?op=c", "", 300, 200);
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
                height: 100,
                renderTo: 'div2',
                //  tbar: tlBar2,
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
        function OpenModule(val) {
            opencenterwin(val.lang, "newwin0", 1100, 650);
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn;
            switch (this.id) {
                case "Name":
                    rtn = '<a href="../../CommonPages/File/DownLoad.aspx?id=' + record.get('Id') + '">' + value + '</a>';
                    break;
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
    <fieldset>
        <legend>我的快捷</legend>
        <div id="div1">
        </div>
    </fieldset>
    <fieldset>
        <legend>常用下载</legend>
        <div id="div2">
        </div>
    </fieldset>
</asp:Content>
