<%@ Page Title="对话框" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="MessageSend.aspx.cs" Inherits="IntegratedManage.Web.MessageManage.MessageSend" %>

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

    <script type="text/javascript">
        var store, myData, tlBar, grid, checkboxGroup, store1, grid1;
        var userId = $.getQueryString({ ID: "UserId" });
        function onPgLoad() {
            IniGrid();
            checkboxGroup = new Ext.form.CheckboxGroup({
                id: 'myGroup',
                xtype: 'checkboxgroup',
                fieldLabel: 'Single Column',
                itemCls: 'x-check-group-alt',
                renderTo: 'checkBoxGroup',
                columns: 2,
                items: [{ boxLabel: '短信', name: 'ShortMessage', id: "sm" },
                        { boxLabel: '邮件', name: 'Mail', id: 'em' }
                       ]
            })
            checkboxGroup.setValue("sm", $("#ShortMessage").val() == "on");
            checkboxGroup.setValue("em", $("#Mail").val() == "on");
            IniFileGrid();
            IniButton();
        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnSave").click(function() {
                $("#btnSave").hide();
                var userIds = ""; var userNames = "";
                var recs = store.getRange();
                for (var k = 0; k < recs.length; k++) {
                    if (k != recs.length - 1) {
                        userIds += recs[k].get("UserId") + ",";
                        userNames += recs[k].get("UserName") + ",";
                    }
                    else {
                        userIds += recs[k].get("UserId");
                        userNames += recs[k].get("UserName");
                    }
                }
                $("#ReceiverIds").val(userIds);
                $("#ReceiverNames").val(userNames);
                var recs2 = store1.getRange();
                var fileIds = "";
                for (var k = 0; k < recs2.length; k++) {
                    if (k != recs2.length - 1) {
                        fileIds += recs2[k].get("Id") + ",";
                    }
                    else {
                        fileIds += recs2[k].get("Id");
                    }
                }
                $("#Attachment").val(fileIds);
                AimFrm.submit(pgAction, { Action: "Save" }, null, SubFinish);
            });
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        window.onresize = function() {
            grid.setWidth(0);
            grid.setWidth(Ext.get("div1").getWidth());
            grid1.setWidth(0);
            grid1.setWidth(Ext.get("div2").getWidth());
        }

        function SuccessSubmit() {
            $("#btnSubmit").hide();
            var userIds = ""; var userNames = "";
            var recs = store.getRange();
            for (var k = 0; k < recs.length; k++) {
                if (k != recs.length - 1) {
                    userIds += recs[k].get("UserId") + ",";
                    userNames += recs[k].get("UserName") + ",";
                }
                else {
                    userIds += recs[k].get("UserId");
                    userNames += recs[k].get("UserName");
                }
            }
            $("#ReceiverIds").val(userIds);
            $("#ReceiverNames").val(userNames);
            var recs2 = store1.getRange();
            var fileIds = "";
            for (var k = 0; k < recs2.length; k++) {
                if (k != recs2.length - 1) {
                    fileIds += recs2[k].get("Id") + ",";
                }
                else {
                    fileIds += recs2[k].get("Id");
                }
            }
            $("#Attachment").val(fileIds);
            if (!userIds) {
                AimDlg.show("请选择要接收消息的人员！");
                return;
            }
            AimFrm.submit(pgAction, { Action: "Send" }, null, SubFinish);
        }
        function SubFinish(args) {
            RefreshClose();
        }
        function IniGrid() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            }
            tlBar = new Ext.ux.AimToolbar({
                items: [
               {
                   text: '添加人员',
                   iconCls: 'aim-icon-add',
                   handler: function() {
                       userSelect();
                   }
               }, '-', {
                   text: '删除人员',
                   iconCls: 'aim-icon-cancel',
                   handler: function() {
                       var recs = grid.getSelectionModel().getSelections();
                       if (!recs || recs.length <= 0) {
                           AimDlg.show("请先选择要删除的记录！");
                           return;
                       }
                       $.each(recs, function() {
                           store.remove(this);
                       })
                   }
}]
            });
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'UserId',
                data: myData,
                fields: [
			    { name: 'UserId' }, { name: 'UserName' }, { name: 'DeptName'}]
            });
            grid = new Ext.ux.grid.AimGridPanel({
                title: '接收人',
                store: store,
                renderTo: 'div1',
                width: Ext.get("div1").getWidth(),
                height: 130,
                viewConfig: { forceFit: true },
                collapsible: true,
                //  autoExpandColumn: 'DeptName',
                columns: [
                   { id: 'UserId', dataIndex: 'UserId', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 100 },
                    { id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 180 }
					],
                tbar: pgOperation != 'v' ? tlBar : ""
            });
        }
        function userSelect() {
            var style = "dialogWidth:750px; dialogHeight:570px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array&GroupID=" + $("#GroupID").val();
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var userData = this.data;
                var userIds = [];
                for (var i = 0; i < userData.length; i++) {
                    if (store.find("UserId", userData[i].UserID) != -1) continue; //筛选已经存在的人
                    userIds.push(userData[i].UserID);
                }
                $.ajaxExec("AddUser", { UserIds: userIds }, function(rtn) {
                    var recType = store.recordType;
                    if (rtn.data.Users.length > 0) {
                        $.each(rtn.data.Users, function() {
                            var rec = new recType(this);
                            store.insert(store.data.length, rec);
                        })
                    }
                })
            })

        };
        function IniFileGrid() {
            var myData1 = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["FileList"] || []
            }
            var tlBar1 = new Ext.ux.AimToolbar({
                items: [
               {
                   text: '添加附件',
                   iconCls: 'aim-icon-add',
                   handler: function() {
                       var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                       var uploadurl = '../CommonPages/File/Upload.aspx';
                       var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件 
                       var fileIds = "";
                       if (rtn != undefined) {
                           var strarray = rtn.split(",");
                           $.each(strarray, function(rtn) {
                               if (this.length >= 36) {//过滤数组中的空
                                   fileIds += this.substring(0, 36) + ",";
                               }
                           }) 
                           jQuery.ajaxExec('ImportFile', { fileIds: fileIds }, function(rtn2) {
                               if (rtn2.data.Result) {
                                   $.each(rtn2.data.Result, function() {
                                       if (store1.find("Id", this.Id) == -1) { //去掉重复的附件
                                           var recType = store1.recordType;
                                           var p = new recType(this);
                                           store1.insert(store1.data.length, p);
                                       }
                                   })
                               }
                           });
                       }
                   }
               }, '-',
               {
                   text: '删除附件',
                   iconCls: 'aim-icon-delete',
                   handler: function() {
                       var recs = grid1.getSelectionModel().getSelections();
                       if (!recs || recs.length <= 0) {
                           AimDlg.show("请先选择要删除的记录！");
                           return;
                       }
                       $.each(recs, function() {
                           store1.remove(this);
                       })
                   }
}]
            });
            store1 = new Ext.ux.data.AimJsonStore({
                dsname: 'FileList',
                idProperty: 'Id',
                data: myData1,
                fields: [
			    { name: 'Id' }, { name: 'Name' }, { name: 'ExtName' }, { name: 'FileSize'}]
            });
            grid1 = new Ext.ux.grid.AimGridPanel({
                title: '附件',
                store: store1,
                renderTo: 'div2',
                width: Ext.get("div2").getWidth(),
                height: 130,
                collapsible: true,
                autoExpandColumn: 'Name',
                columns: [
                   { id: 'Id', dataIndex: 'Id', header: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'Name', dataIndex: 'Name', width: 200, header: '文件名称', renderer: RowRender },
                    { id: 'ExtName', dataIndex: 'ExtName', width: 80, header: '文件类型' },
                    { id: 'FileSize', dataIndex: 'FileSize', header: '文件大小', width: 80, renderer: RowRender }
					],
                tbar: pgOperation != 'v' ? tlBar1 : ""
            });
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',               left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function showwin(val) {
            opencenterwin("../../CommonPages/File/DownLoad.aspx?id=" + val, "newwin0", 120, 120);
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Name":
                    rtn = '<a href="../../CommonPages/File/DownLoad.aspx?id=' + record.get('Id') + '">' + value + '</a>';
                    break;
                case "Id":
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
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            消息发送</h1>
    </div>
    <fieldset>
        <div id="div1">
        </div>
    </fieldset>
    <fieldset>
        <div id="div2">
        </div>
    </fieldset>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="width: 100%; border: none">
            <tr style="display: none">
                <td>
                    <input id="Id" name="Id" />
                    <input id="ReceiverId" name="ReceiverId" />
                    <input id="ReceiverName" name="ReceiverName" />
                    <input id="ReceiverIds" name="ReceiverIds" />
                    <input id="ReceiverNames" name="ReceiverNames" />
                    <input id="Attachment" name="Attachment" />
                    <input id="ShortMessage" name="ShortMessage" />
                    <input id="Mail" name="Mail" />
                </td>
            </tr>
            <tr>
                <td style="width: 25%" class="aim-ui-td-caption">
                    消息类型
                </td>
                <td style="width: 25%">
                    <select id="MessageType" name="MessageType" style="width: 90%;" aimctrl='select'
                        enum="MessageType" class="validate[required]">
                    </select>
                </td>
                <td style="width: 25%" class="aim-ui-td-caption">
                    同时发送
                </td>
                <td style="width: 25%">
                    <div id="checkBoxGroup">
                    </div>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    发送内容
                </td>
                <td colspan="3">
                    <textarea id="MessageContent" name="MessageContent" style="width: 95%; height: 75px;"
                        rows="3" cols=""></textarea>
                </td>
            </tr>
        </table>
    </fieldset>
    <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">发送</a>&nbsp;&nbsp; <a id="btnSave"
                        class="aim-ui-button submit">暂存</a>&nbsp;&nbsp; <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
