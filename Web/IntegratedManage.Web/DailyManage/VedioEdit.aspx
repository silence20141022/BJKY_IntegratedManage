<%@ Page Title="视频管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="VedioEdit.aspx.cs" Inherits="IntegratedManage.Web.DailyManage.VedioEdit" %>

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
        var id = $.getQueryString({ ID: "id" });
        var store1, grid1;
        function onPgLoad() {
            setPgUI();
            IniButton();
        }
        function setPgUI() {
            IniGrid1();
        }
        function IniButton() {
            FormValidationBind('btnSubmit', SuccessSubmit);
            //            $("#btnSave").click(function() {
            //                $("#btnSave").hide();
            //                if (store1.getRange().length > 0) {
            //                    $("#VedioFile").val(store1.getAt(0).get("Id"));
            //                }
            //                AimFrm.submit(pgAction, {}, null, SubFinish);
            //            });
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        function SuccessSubmit() {
            $("#btnSubmit").hide();
            if (store1.getRange().length > 0) {
                $("#VedioFile").val(store1.getAt(0).get("Id"));
            }
            else {
                AimDlg.show("上传视频文件不能为空！");
                return;
            }
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }
        function SubFinish(args) {
            RefreshClose();
        }
        function IniGrid1() {
            var myData1 = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            }
            var tlBar1 = new Ext.ux.AimToolbar({
                items: [
               {
                   text: '上传视频',
                   iconCls: 'aim-icon-add',
                   handler: function() {
                       var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                       var uploadurl = '../CommonPages/File/Upload.aspx?IsSingle=true&&Filter=' + escape('视频格式') + '(*.wmv)|*.wmv';
                       var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件  
                       if (rtn != undefined) {
                           jQuery.ajaxExec('ImportFile', { fileIds: rtn.substring(0, 36) }, function(rtn2) {
                               if (rtn2.data.Result) {
                                   store1.removeAll();
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
                   text: '删除视频',
                   iconCls: 'aim-icon-delete',
                   handler: function() {
                       var recs = grid1.getSelectionModel().getSelections();
                       if (recs || recs.length > 0) {
                           $.each(recs, function() {
                               store1.remove(this);
                           })
                       }
                   }
}]
            });
            store1 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData1,
                fields: [
			    { name: 'Id' }, { name: 'Name' }, { name: 'ExtName' }, { name: 'FileSize' },
			    { name: 'FileType' }, { name: 'CreateTime'}]
            });
            grid1 = new Ext.ux.grid.AimGridPanel({
                title: '视频文件',
                store: store1,
                renderTo: 'div1',
                width: Ext.get("div1").getWidth(),
                height: 145,
                collapsible: true,
                autoExpandColumn: 'Name',
                columns: [
                   { id: 'Id', dataIndex: 'Id', header: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.grid.MultiSelectionModel(),
                    { id: 'Name', dataIndex: 'Name', width: 200, header: '文件名称', renderer: RowRender },
                    { id: 'ExtName', dataIndex: 'ExtName', width: 80, header: '文件扩展名' },
                    { id: 'FileSize', dataIndex: 'FileSize', header: '文件大小', renderer: RowRender, width: 80 },
                    { id: 'CreateTime', dataIndex: 'CreateTime', width: 80, header: '上传时间', renderer: ExtGridDateOnlyRender }
					],
                tbar: pgOperation != 'v' ? tlBar1 : ""
            });
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function showwin(val) {
            opencenterwin("../../CommonPages/File/DownLoad.aspx?id=" + val, "newwin0", 120, 120);
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
                case "PayAmount":
                    if (value) {
                        //  cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                        rtn = AmountFormat(value);
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
            grid1.setWidth(0);
            grid1.setWidth(Ext.get("div1").getWidth());
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            视频信息</h1>
    </div>
    <fieldset>
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" />
                    <input id="VedioFile" name="VedioFile" /><input id="ImageFile" name="ImageFile" />
                </td>
            </tr>
            <tr>
                <td style="width: 20%" class="aim-ui-td-caption">
                    视频主题
                </td>
                <td style="width: 36%">
                    <input id="Theme" name="Theme" class="validate[required]" style="width: 100%" />
                </td>
                <td style="width: 18%" class="aim-ui-td-caption">
                    视频类别
                </td>
                <td style="width: 25%">
                    <select id="VedioType" name="VedioType" style="width: 90%;" aimctrl='select' enum="VedioType">
                    </select>
                </td>
            </tr>
            <tr>
                <td class="aim-ui-td-caption">
                    视频描述
                </td>
                <td colspan="3">
                    <textarea id="Remark" name="Remark" style="width: 97%;" cols="" rows="3"></textarea>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <div id="div1">
        </div>
    </fieldset>
    <div style="width: 100%" id="divButton">
        <table class="aim-ui-table-edit">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">确定</a>&nbsp;&nbsp;<a id="btnCancel"
                        class="aim-ui-button cancel"> 取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
