<%@ Page Title="权限设置" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="SurveryedPower.aspx.cs" Inherits="IntegratedManage.Web.SurveryedPower" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
        .aim-ui-td-caption
        {
            text-align: right;
        }
        fieldset
        {
            border: solid 1px #8FAACF;
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        input
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

        var store1, gridLeft;
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            InitialGrid1();
            initButton();
        }

        function InitialGrid1() {
            myData1 = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList1"] || []
            };
            store1 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList1',
                idProperty: 'Id',
                data: myData1,
                fields: [{ name: 'SurveyedUserId' }, { name: 'SurveyedUserName'}]
            });
            tlBar1 = new Ext.ux.AimToolbar({
                items: [{ text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        userSelect("grid1");
                    }
                }, '-',
               { text: '删除',
                   iconCls: 'aim-icon-delete',
                   handler: function() {
                       var recs = gridLeft.getSelectionModel().getSelections();
                       if (!recs || recs.length <= 0) {
                           AimDlg.show("请先选择要删除的记录！");
                           return;
                       }
                       if (confirm("确定删除所选记录？")) {
                           for (var i = 0; i < recs.length; i++) {
                               store1.remove(recs[i]);

                           }
                       }
                   }
               }
]
            });

            gridLeft = new Ext.ux.grid.AimGridPanel({
                id: "grid1",
                store: store1,
                title: '调查对象',
                renderTo: "div1",
                height: 275,
                autoExpandColumn: 'SurveyedUserName',
                columns: [
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.grid.MultiSelectionModel(),
                { id: 'SurveyedUserName', header: "姓名", width: 100, dataIndex: 'SurveyedUserName'}],
                tbar: pgOperation != "v" ? tlBar1 : ""
            });
        }

        function userSelect(val) {
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var gird = Ext.getCmp(val);
                var EntRecord = gird.getStore().recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (Ext.getCmp(val).store.find("SurveyedUserId", this.data[i].Id) != -1) continue; //筛选已经存在的人
                    var rec = new EntRecord({ SurveyedUserId: this.data[i].UserID, SurveyedUserName: this.data[i].Name });
                    gird.getStore().insert(gird.getStore().data.length, rec);
                }
            })
        }



        function userSelect(val) {
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var gird = Ext.getCmp(val);
                var EntRecord = gird.getStore().recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (Ext.getCmp(val).store.find("SurveyedUserId", this.data[i].Id) != -1) continue; //筛选已经存在的人
                    var rec = new EntRecord({ SurveyedUserId: this.data[i].UserID, SurveyedUserName: this.data[i].Name });
                    gird.getStore().insert(gird.getStore().data.length, rec);
                }
            })
        }

        function deptSelect(val) {
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/GrpSelView.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var gird = Ext.getCmp(val);
                var EntRecord = gird.getStore().recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (Ext.getCmp(val).store.find("Id", this.data[i].Id) != -1) continue; //筛选已经存在的人
                    var rec = new EntRecord({ Id: this.data[i].UserID, Name: this.data[i].Name });
                    gird.getStore().insert(gird.getStore().data.length, rec);
                }
            })
        }

        function initButton() {
            /*初始化按钮*/
            $("#btnSubmit").click(function() {
                SuccessSubmit();
            });
        }
        
        function SuccessSubmit() {
            var recs1 = store1.getRange();
            recs1 = store1.getModifiedDataStringArr(recs1);
            var temp = "";
            for (var i = 0; i < recs1.length; i++) {
                if (i > 0) {
                    temp += "|";
                }
                temp += recs1[i];
            }
            window.returnValue = temp;
            RefreshClose();
        }
        
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="editDiv" align="center">
        <fieldset>
            <legend id='legend'>调查权限配置</legend>
            <table width="100%">
                <tr>
                    <td style="width: 100%">
                        <div id="div1">
                        </div>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="width: 100%">
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr>
                        <td class="aim-ui-button-panel" colspan="4">
                            <a id="btnSubmit" class="aim-ui-button">保存</a> <a id="A1" class="aim-ui-button">取消</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
