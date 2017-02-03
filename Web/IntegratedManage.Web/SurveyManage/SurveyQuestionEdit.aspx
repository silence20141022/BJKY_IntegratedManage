<%@ Page Title="投票信息维护" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="SurveyQuestionEdit.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.SurveyQuestionEdit" %>

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
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
    </style>

    <script src="../js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script type="text/javascript">

        var Id = $.getQueryString({ ID: 'id' });

        var editCounter = 0;  //添加计数器
        var isSave = false;   //是否保存标志

        var store, store1, store2;
        var grid, gridDept, gridPerson;

        function onPgLoad() {
            setPgUI();
            renderGrid();
        }

        function setPgUI() {

            initState(); //初始化
            //------------------------------------------------
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function() { window.close() });
            // document.oncontextmenu = function() { return false; }
            window.onbeforeunload = function() {
                if (editCounter && !isSave) {
                    $.ajaxExecSync("close", { id: $("#Id").val() || '' }, function(rtn) { window.close() });
                }
            }

            //---------------------------状态切换---------------
            $("#all").click(function() {
                if ($(this).attr("checked")) {
                    gridSwitch("all");
                    $("#dept").attr("checked", false);
                    $("#person").attr("checked", false)
                }
            });

            $("#dept").click(function() {
                if ($(this).attr("checked")) {
                    $("#all").attr("checked", false);
                    gridSwitch("dept");

                } else {
                    $("#barDiv_dept").hide();
                    $("#deptDiv").hide();
                }
            });

            $("#person").click(function() {
                if ($(this).attr("checked")) {
                    gridSwitch("person");
                    $("#all").attr("checked", false);
                } else {
                    $("#barDiv_p").hide();
                    $("#personDiv").hide();
                }
            });
            //---------------------------------

        }


        function initState() {  /*初始化设置*/
            !$("#Id").val() && gridSwitch("all") == "all" && $("#all").attr("checked", true);
            if (!AimState["frmdata"]) return;
            //设定是否匿名
            AimState["frmdata"].IsNoName == "yes" ? $("#yes").attr("checked", true) : $("#no").attr("checked", true);
            //问卷结果查看对象
            AimState["frmdata"].ReadPower == "1" ? $("#ReadPower_1").attr("checked", true) : $("#ReadPower_0").attr("checked", true);
            //调查对象类型
            if (AimState["frmdata"].PowerType) {
                var type = AimState["frmdata"].PowerType || '';
                var arr = type.split(",") || [];

                for (var v = 0; v < arr.length; v++) {
                    gridSwitch(arr[v]);
                    arr[v] == "all" && $("#all").attr("checked", true);
                    arr[v] == "dept" && $("#dept").attr("checked", true);
                    arr[v] == "person" && $("#person").attr("checked", true);
                }
            }
        }

        function gridSwitch(signVal) {
            var rtn = "";
            switch (signVal) {
                case "all":
                    $("#powerset").hide();
                    rtn = "all";
                    break;
                case "dept":
                    $("#powerset").show();
                    $("#barDiv_dept").show();
                    $("#deptDiv").show();
                    rtn = "dept";
                    break;
                case "person":

                    $("#powerset").show();
                    $("#personDiv").show();
                    $("#barDiv_p").show();

                    rtn = "person";
                    break;
            }
            return rtn;
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            var recs = store.getRange();
            var dt = store.getModifiedDataStringArr(recs);
            isSave = true;

            var deptId = "";               //全院
            if ($("#dept").attr("checked")) { //部门
                var recs1 = store1.getRange();
                for (var i = 0; i < recs1.length; i++) {
                    i > 0 && (deptId += ",");
                    deptId += recs1[i].get("Id");
                }

            }

            var personId = "";
            if ($("#person").attr("checked")) {//个人
                var recs1 = store2.getRange();
                for (var i = 0; i < recs1.length; i++) {
                    i > 0 && (personId += ",");
                    personId += recs1[i].get("Id");
                }
            }

            var PowerType = '';
            $(":checkbox").each(function() {
                if ($(this).attr("checked")) {
                    PowerType += $(this).val() + ",";
                }
            })
            if (deptId || personId) {
                PowerType = PowerType.replace("all", '');
            }

            if ($("#Id").val()) {
                AimFrm.submit("update", { data: dt, Dept: deptId, PersonId: personId, PowerType: PowerType }, null, SubFinish);
            } else {
                AimFrm.submit("create", { data: dt, Dept: deptId, PersonId: personId, PowerType: PowerType }, null, SubFinish);
            }
        }

        /*渲染grid -*/
        function renderGrid() {

            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                isclient: true,
                data: { records: AimState["DataList"] || [] },
                fields: [{ name: 'Id' },
                   	    { name: 'SurveyQuestionId' },
                   	    { name: 'Content' },
                   	    { name: 'QuestionType' },
                   	    { name: 'IsMustAnswer' },
                   	    { name: 'IsComment' },
                   	    { name: 'CreateTime' },
                   	    { name: 'SortIndex' }
                   	   ],
                listeners: {
                    aimbeforeload: function(proxy, options) {
                        options.data = options.data || {};
                        options.data.id = Id;
                    }
                }
            });
            //工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [
				{
				    text: '添加',
				    iconCls: 'aim-icon-add',
				    handler: function() {
				        //debugger
				        var valide = true;
				        if ($("[class*=validate]").length > 0) {
				            $.each($("[class*=validate]"), function() {
				                if (!$(this).val()) {
				                    AimDlg.show("请填写问卷标题!");
				                    valide = false;
				                }
				            })
				        }
				        if (!valide) return;
				        var recType = store.recordType;
				        var sortIndex = 0;
				        $.each(store.getRange(), function() {
				            sortIndex = parseInt(this.get("SortIndex")) > sortIndex ? parseInt(this.get("SortIndex")) : sortIndex;
				        });
				        var rec = new recType({ Edit: '增加答案选择项', SortIndex: sortIndex + 1 });
				        store.insert(store.data.length, rec);
				        rec.set("IsMustAnswer", "是");
				        rec.set("QuestionType", "单选项");
				        rec.set("IsComment", "否");

				        $.ajaxExec("question", { id: $("#Id").val() || '' }, function(rtn) {
				            if (!rtn.data.SurveyQuestionId) {
				                rec.set("SurveyQuestionId", $("#Id").val());
				                rec.set("CreateTime", rtn.data.date);
				            } else {
				                rec.set("SurveyQuestionId", rtn.data.SurveyQuestionId);
				                rec.set("CreateTime", rtn.data.date);
				                $("#Id").val(rtn.data.SurveyQuestionId);
				            }
				            editCounter = editCounter + 1;
				            rec.set("Id", rtn.data.Id);
				        });

				    }
				}, '-',
				{
				    text: '删除',
				    iconCls: 'aim-icon-delete',
				    handler: function() {
				        var recs = grid.getSelectionModel().getSelections();
				        var dt = store.getModifiedDataStringArr(recs);
				        if (!recs || recs.length <= 0) {
				            AimDlg.show("请先选择要删除的记录！");
				            return;
				        }
				        if (confirm("确定删除所选记录？")) {
				            store.remove(recs);
				            ExtBatchOperate('girdBatchDel', recs, null, null);
				        }
				    }
				}, { xtype: 'tbtext', text: '(编辑后系统会自动保存)' }, '->'
		    ]
            });
            cb_QuestionType = new Ext.ux.form.AimComboBox({
                id: 'cb_QuestionType',
                enumdata: { "单选项": "单选项", "多选项": "多选项", "填写项": "填写项" },
                lazyRender: false,
                allowBlank: false,
                autoLoad: true,
                forceSelection: true,
                triggerAction: 'all',
                mode: 'local',
                listeners: {
                    blur: function(obj) {
                        if (grid.activeEditor) {
                            var rec = store.getAt(grid.activeEditor.row);
                            if (rec) {
                                grid.stopEditing();
                                rec.set("QuestionType", obj.value);
                            }
                        }
                    }
                }
            });

            cb_IsMustAnswer = new Ext.ux.form.AimComboBox({
                id: 'cb_IsMustAnswer',
                enumdata: { "是": "是", "否": "否" },
                lazyRender: false,
                allowBlank: false,
                autoLoad: true,
                forceSelection: true,
                triggerAction: 'all',
                mode: 'local',
                listeners: {
                    blur: function(obj) {
                        if (grid.activeEditor) {
                            var rec = store.getAt(grid.activeEditor.row);
                            if (rec) {
                                grid.stopEditing();
                                rec.set("IsMustAnswer", obj.value);
                            }
                        }
                    }
                }
            });
            cb_IsComment = new Ext.ux.form.AimComboBox({ /*是否评论*/
                id: 'cb_IsComment',
                enumdata: { "否": "否", "是": "是" },
                lazyRender: false,
                allowBlank: false,
                autoLoad: true,
                forceSelection: true,
                triggerAction: 'all',
                mode: 'local',
                listeners: {
                    blur: function(obj) {
                        if (grid.activeEditor) {
                            var rec = store.getAt(grid.activeEditor.row);
                            if (rec) {
                                grid.stopEditing();
                                rec.set("IsComment", obj.value);
                            }
                        }
                    }
                }
            });
            grid = new Ext.ux.grid.AimEditorGridPanel({
                store: store,
                height: 240,
                collapsible: true,
                renderTo: 'SubContent',
                // region: 'center',
                //autoHeight: true,
                autoExpandColumn: 'Content',
                columns: [
                    { id: 'Id', dataIndex: 'Id', hidden: true },
                    { id: 'SurveyQuestionId', dataIndex: 'SurveyQuestionId', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Content', dataIndex: 'Content', header: '题目内容', editor: { xtype: 'textarea' }, width: 150 },
					{ id: 'QuestionType', dataIndex: 'QuestionType', header: '问题类型', editor: cb_QuestionType, width: 90 },
					{ id: 'IsMustAnswer', dataIndex: 'IsMustAnswer', header: '是否必答', editor: cb_IsMustAnswer, width: 90 },
					{ id: 'IsComment', dataIndex: 'IsComment', header: '是否评论', editor: cb_IsComment, width: 90 },
				    { id: 'SortIndex', dataIndex: 'SortIndex', header: '序号', editor: { xtype: 'numberfield', minValue: 0, maxValue: 100, allowBlank: false }, width: 80 },
					{ id: 'Edit', dataIndex: 'Edit', header: '操作', width: 100, renderer: RowRender }
					],
                tbar: pgOperation != "v" ? tlBar : "",
                tbar: tlBar,
                listeners: {
                    afteredit: function(e) {
                        e.record.commit();
                    }
                }
            });

            //----------------------------gridPower     dept----------------

            tlBar_dept = new Ext.Toolbar({
                renderTo: 'barDiv_dept',
                items: [{ text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        deptSelect("gridDept");
                    }
                }, '-',
               { text: '删除',
                   iconCls: 'aim-icon-delete',
                   handler: function() {
                       var recs = gridDept.getSelectionModel().getSelections();
                       if (!recs || recs.length <= 0) {
                           AimDlg.show("请先选择要删除的记录！");
                           return;
                       }
                       if (confirm("确定删除所选记录？")) {
                           for (var i = 0; i < recs.length; i++) {
                               gridDept.getStore().remove(recs[i]);
                           }
                       }

                   }
               }
]
            });

            myData1 = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataListDept"] || []
            };
            store1 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataListDept',
                idProperty: 'Id',
                data: myData1,
                fields: [
			      { name: 'Id' }, { name: 'Name' }
            ]
            });

            gridDept = new Ext.ux.grid.AimGridPanel({
                id: "gridDept",
                title: '部门配置',
                store: store1,
                height: 120,
                //autoHeight: true,
                //collapsible: true,
                renderTo: 'deptDiv',
                //autoExpandColumn: 'Name',
                columns: [
                     new Ext.ux.grid.AimRowNumberer(),
                     new Ext.grid.MultiSelectionModel(),
                     { id: 'Id', header: "Id", width: 100, dataIndex: 'Id', hidden: true },
                     { id: 'Name', header: "部门名称", width: 650, dataIndex: 'Name' }
                  ]
            });

            //------------------------------personn------------------
            tlBar_p = new Ext.Toolbar({
                renderTo: 'barDiv_p',
                items: [{ text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        userSelect("gridPerson");
                    }
                }, '-',
               { text: '删除',
                   iconCls: 'aim-icon-delete',
                   handler: function() {
                       var recs = gridPerson.getSelectionModel().getSelections();
                       if (!recs || recs.length <= 0) {
                           AimDlg.show("请先选择要删除的记录！");
                           return;
                       }
                       if (confirm("确定删除所选记录？")) {
                           for (var i = 0; i < recs.length; i++) {
                               gridPerson.getStore().remove(recs[i]);
                           }
                       }
                   }
               }
]
            });

            myData2 = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataListPerson"] || []
            };
            store2 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataListPerson',
                idProperty: 'Id',
                data: myData2,
                fields: [
			      { name: 'Id' }, { name: 'Name' }
            ]
            });
            gridPerson = new Ext.ux.grid.AimGridPanel({
                id: "gridPerson",
                title: '人员配置',
                store: store2,
                height: 150,
                //autoHeight: true,
                //collapsible: true,
                renderTo: 'personDiv',
                //autoExpandColumn: 'Name',
                columns: [
                     new Ext.ux.grid.AimRowNumberer(),
                     new Ext.grid.MultiSelectionModel(),
                     { id: 'Id', header: "Id", width: 100, dataIndex: 'Id', hidden: true },
                     { id: 'Name', header: "姓名", width: 650, dataIndex: 'Name' }
                  ]
            });
            //-------------------------end------------------

        }



        function userSelect(val) {//用户选择控件
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/UsrSelect/MUsrSelect.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var gird = Ext.getCmp(val);
                var EntRecord = gird.getStore().recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (Ext.getCmp(val).store.find("Id", this.data[i].Id) != -1) continue; //筛选已经存在的人
                    var rec = new EntRecord({ Id: this.data[i]["UserID"], Name: this.data[i]["Name"] });
                    gird.getStore().insert(gird.getStore().data.length, rec);
                }
            })
        }

        function deptSelect(val) {//部门选择控件
            var style = "dialogWidth:800px; dialogHeight:400px; scroll:yes; center:yes; status:no; resizable:yes;";
            var url = "../CommonPages/Select/GrpSelect/MGrpSelect.aspx?seltype=multi&rtntype=array";
            OpenModelWin(url, {}, style, function() {
                if (this.data == null || this.data.length == 0 || !this.data.length) return;
                var gird = Ext.getCmp(val);
                var EntRecord = gird.getStore().recordType;
                for (var i = 0; i < this.data.length; i++) {
                    if (Ext.getCmp(val).store.find("Id", this.data[i]["GroupID"]) != -1) continue; //筛选已经存在的部门
                    var rec = new EntRecord({ Id: this.data[i]["GroupID"], Name: this.data[i]["Name"] });
                    gird.getStore().insert(gird.getStore().data.length, rec);
                }
            })
        }

        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "Edit":
                    if (record.get("QuestionType") == "填写项") {
                        cellmeta.style = 'background-color: gray';
                        rtn = "维护答案选择项"
                    }
                    else {
                        var str = "<span style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='windowOpenEdit(\"" + record.get("SurveyQuestionId") + "\",\"" + record.get("Id") + "\",\"" + record.get("Content") + "\")'>" + "维护答案选择项" + "</span>";
                        rtn = str;
                    }

            }
            return rtn;
        }

        function windowOpenEdit() { /* 答案选择项*/

            var SurveyQuestionId = arguments[0] || ''; //SurveyQuestionId
            var QuestionContentId = arguments[1] || ''; //QuestionContentId
            var QuestionContent = escape(arguments[2]) || ''; //QuestionContent
            var task = new Ext.util.DelayedTask();
            task.delay(100, function() {
                var win = opencenterwin("QuestionItemEdit.aspx?op=v&SurveyQuestionId=" + SurveyQuestionId + "&QuestionContentId=" + QuestionContentId + "&QuestionContent=" + QuestionContent, "", 700, 350);
            });
        }

        var contTip = function(vals, p, rec) { //tooptip
            if (vals == null || vals == "")
                return;
            p.attr = 'ext:qtitle=""' + 'ext:qtip="' + vals + '"';
            return vals;
        };


        function windowOpen() {
            var Id = arguments[0] || '';  //ID
            var Title = escape(arguments[1] || ''); //Title
            var task = new Ext.util.DelayedTask();
            task.delay(100, function() {
                opencenterwin("SurveyView.aspx?op=v&Id=" + Id + "&Title=" + Title + "&rand=" + Math.random(), "", 1000, 600);
            });
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',                      innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=                yes,resizable=yes');
        }


        function onExecuted() {
            store.reload();
        }
        window.onresize = function() {
            grid.setWidth(0);
            grid.setWidth(Ext.get("SubContent").getWidth());
        }
        function SubFinish(args) {
            RefreshClose();
        }
        
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            问卷配置</h1>
    </div>
    <div id="editDiv" align="center">
        <fieldset>
            <legend>配置信息</legend>
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr style="display: none">
                        <td>
                            <input id="Id" name="Id" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">
                            问卷标题
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <input id="Title" name="Title" style="width: 96.7%;" class="validate[required]" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">
                            问卷描述
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <textarea id="Contents" name="Contents" style="width: 96.7%;" rows="5"></textarea>
                        </td>
                    </tr>
                    <tr width="100%">
                        <td class="aim-ui-td-caption">
                            开始时间
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="StartTime" name="StartTime" class="Wdate" onfocus="var date=$('#EndTime').val()?$('#EndTime').val():'';                                             
                         WdatePicker({maxDate:date,dateFmt:'yyyy/MM/dd'})" />
                        </td>
                        <td class="aim-ui-td-caption">
                            结束时间
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="EndTime" name="EndTime" class="Wdate" onfocus="var date=$('#StartTime').val()?$('#StartTime').val():new Date();  
                        WdatePicker({minDate:date,dateFmt:'yyyy/MM/dd'})" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">
                            是否匿名
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="radio" name="IsNoName" checked="checked" id="no" value="no" />否
                            <input type="radio" name="IsNoName" id="yes" value="yes" />是
                        </td>
                        <td class="aim-ui-td-caption">
                            调查对象
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="checkbox" id="all" name="PowerType" value="all" />全院
                            <input type="checkbox" id="dept" name="PowerType" value="dept" />
                            部门
                            <input type="checkbox" id="person" name="PowerType" value="person" />人员
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption">
                            结果查看对象
                        </td>
                        <td class="aim-ui-td-data" colspan="3">
                            <input type="radio" name="ReadPower" checked="checked" id="ReadPower_0" value="0" />问卷发起者
                            &nbsp;&nbsp;
                            <input type="radio" name="ReadPower" id="ReadPower_1" value="1" />问卷参与者
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
    </div>
    <div id="powerset" style="display: none">
        <fieldset>
            <legend>配置调查对象</legend>
            <div id="barDiv_dept" style="display: none">
            </div>
            <div id="deptDiv" style="width: 100%; display: none">
            </div>
            <div id="barDiv_p" style="display: none">
            </div>
            <div id="personDiv" style="width: 100%; display: none">
            </div>
        </fieldset>
    </div>
    <fieldset>
        <legend>问题维护</legend>
        <div id="SubContent" style="width: 100%;">
        </div>
    </fieldset>
    <table class="aim-ui-table-edit">
        <tr>
            <td class="aim-ui-button-panel" colspan="8">
                <a id="btnSubmit" class="aim-ui-button submit">保存</a> <a id="btnCancel" class="aim-ui-button cancel">
                    取消</a>
            </td>
        </tr>
    </table>
</asp:Content>
