<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="FrmVideoNewsEdit.aspx.cs" Inherits="Aim.Portal.Web.Modules.FrmVideoNewsEdit"
    Title="信息内容" ValidateRequest="false" %>

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
        var EnumType = { 0: "未发布", 1: "已发布" };
        var EnumLevel = { 0: "普通", 1: "重要", 2: "很重要" };
        var store, tlBar, grid;

        var type = $.getQueryString({ ID: 'TypeId', DefaultValue: '' });

        function onPgInit() {
        }

        function onPgLoad() {

            setPgUI();

            if ($.getQueryString({ ID: "op" }) == 'c') {
                if (AimState["DeptInfo"]) {
                    $("#PostDeptName").val(AimState["DeptInfo"].groupName);
                    $("#PostDeptId").val(AimState["DeptInfo"].groupId);

                    $("#CreateName").val(AimState["UserInfo"].Name);
                }
            }

            if ($.getQueryString({ ID: "InFlow", DefaultValue: "" }) == "T") {
                InitUIForFlow();
            }

            $("#TypeId").val(type);
            document.getElementById("TypeId").disabled = true;
        }

        function setPgUI() {
            //绑定按钮验证
            FormValidationBind('btntj', SuccessTJ);
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });

            //初始化详细

            tlBar = new Ext.ux.AimToolbar({
                hidden: pgOperation == "r" || $.getQueryString({ "ID": "InFlow" }) == "T",
                items: [{
                    text: '添加明细',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                        var uploadurl = '/CommonPages/File/Upload.aspx?Filter=' + escape('视频格式') + '(*.wmv;)|*.wmv;';
                        var rtn = window.showModalDialog(uploadurl, window, UploadStyle); //一次可能上传多个文件 
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
                     text: '删除',
                     iconCls: 'aim-icon-delete',
                     handler: function() {
                         var recs = grid.getSelectionModel().getSelections();
                         if (!recs || recs.length <= 0) {
                             AimDlg.show("请先选择要删除的记录！");
                             return;
                         }

                         if (confirm("确定删除所选记录？")) {
                             ExtBatchOperate('batchdeleteDetail', recs, null, null, function(rtn) {
                                 for (var i = 0; i < recs.length; i++) {
                                     store.remove(recs[i]);
                                 }
                             });
                         }
                     }
}]

            });

            // 表格数据源
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
                title: '【信息明细】',
                store: store,
                clicksToEdit: 1,
                renderTo: 'divdetail',
                columnLines: true,
                height: 200,
                viewConfig: {
                    forceFit: true
                },
                width: Ext.get("divdetail").getWidth(),
                //autoHeight: true,
                autoExpandColumn: 'Content',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    { id: 'ImgPath', dataIndex: 'ImgPath', header: '视频', width: 80, renderer: function(val) {
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

            window.onresize = function() {
                grid.setWidth(0);
                grid.setWidth(Ext.get("divdetail").getWidth());
            };
        }


        //验证成功执行保存方法
        function SuccessSubmit() {
            var recs = store.getRange();
            if (recs.length == 0) {
                alert("请添加信息明细");
                return;
            }

            var dt = store.getModifiedDataStringArr(recs) || [];
            AimFrm.submit(pgAction, { "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, SubFinish);
        }

        function SuccessTJ() {
            var recs = store.getRange();
            if (recs.length == 0) {
                alert("请添加信息明细");
                return;
            }

            var dt = store.getModifiedDataStringArr(recs) || [];
            AimFrm.submit(pgAction, { param: "tj", "detail": dt, HomePagePopup: $("#HomePagePopup").attr("checked") ? "on" : "off" }, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            信息维护</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit" border="0">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        标题
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Title" name="Title" class="validate[required]" style="width: 90%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        概要
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="KeyWord" name="KeyWord" style="width: 90%" rows="3"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        展示图片
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="ShowImg" name="ShowImg" style="" aimctrl='file' mode='single' />
                    </td>
                    <td colspan="2" style="color: Red;">
                        门户上的展示图片，若没有上传视频图片,系统会自动从视频中截取图片。
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接收部门
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveDeptName" name="ReceiveDeptName" relateid="ReceiveDeptId"
                            popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx" popparam="ReceiveDeptName:Name;ReceiveDeptId:GroupID"
                            popstyle="width=700,height=500" style="width: 90%" />
                        <input id="ReceiveDeptId" type="hidden" name="ReceiveDeptId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        接收用户
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input aimctrl='popup' readonly id="ReceiveUserName" name="ReceiveUserName" relateid="ReceiveUserId"
                            popurl="/CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi" popparam="ReceiveUserId:UserID;ReceiveUserName:Name"
                            popstyle="width=750,height=450" style="width: 90%" />
                        <input type="hidden" id="ReceiveUserId" name="ReceiveUserId" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        所属栏目
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%;">
                        <select id="TypeId" name="TypeId" aimctrl='select' enumdata="NewsTypeEnum" style="width: 230px;"
                            required="true">
                        </select>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        重要程度
                    </td>
                    <td class="aim-ui-td-data">
                        <select id="Grade" name="Grade" aimctrl='select' enumdata="EnumLevel" style="width: 230px;"
                            required="true">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                    </td>
                    <td class="aim-ui-td-data" style="width: 35%;">
                        <label>
                            <input type="checkbox" id="HomePagePopup" name="HomePagePopup" />登录系统自动弹出</label>
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        失效日期
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="ExpireTime" name="ExpireTime" aimctrl='date' style="width: 70%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        发布部门
                    </td>
                    <td class="aim-ui-td-data">
                        <input type="hidden" id="PostDeptId" name="PostDeptId" />
                        <input id="PostDeptName" name="PostDeptName" style="width: 70%" aimctrl='popup' readonly
                            relateid="PostDeptId" popurl="/CommonPages/Select/GrpSelect/MGrpSelect.aspx"
                            popparam="PostDeptName:Name;PostDeptId:GroupID" popstyle="width=700,height=500" />
                    </td>
                    <td class="aim-ui-td-caption" style="width: 15%;">
                        创建人
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="CreateName" name="CreateName" readonly="readonly" style="width: 70%" />
                    </td>
                </tr>
        </table>
        <div id="divdetail">
        </div>
        <table class="aim-ui-table-edit" border="0">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btntj" class="aim-ui-button submit">发布信息</a> <a id="btnSubmit" class="aim-ui-button submit">
                        保存</a> <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
