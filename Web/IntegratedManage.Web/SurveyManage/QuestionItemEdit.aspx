<%@ Page Title="答案选项维护" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="QuestionItemEdit.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.QuestionItemEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
    </style>

    <script type="text/javascript">
        var SurveyQuestionId = $.getQueryString({ ID: 'SurveyQuestionId' });  // SQID
        var QuestionContentId = $.getQueryString({ ID: 'QuestionContentId' }); //Id
        var QuestionContent = unescape($.getQueryString({ ID: 'QuestionContent' }));  //
        var grid, store;
        function onPgLoad() {
            renderGrid();
            submit();
        }

        function submit() {
            $("#btnSubmit").click(function() {
                var recs = store.getRange();
                var dt = store.getModifiedDataStringArr(recs);
                AimFrm.submit("save", { data: dt }, null, function() {
                    window.close();
                });
            });
            $("#btnCancel").click(function() {
                window.close();
            });
        }

        /*渲染grid -*/
        function renderGrid() {
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                isclient: true,
                data: { records: AimState["DataList"] || [] },
                fields: [{ name: 'Id' },
                   	    { name: 'SurveyQuestionId' },
                   	    { name: 'QuestionContentId' },
                   	    { name: 'QuestionContent' },
                   	    { name: "IsExplanation" },
                   	    { name: 'Answer' },
                   	    { name: 'SortIndex' },
                   	   ]
            });
            //工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [
				{
				    text: '添加',
				    iconCls: 'aim-icon-add',
				    handler: function() {
				        var recType = store.recordType;
				        var sortIndex = 0;
				        $.each(store.getRange(), function() {
				            sortIndex = parseInt(this.get("SortIndex")) > sortIndex ? parseInt(this.get("SortIndex")) : sortIndex;
				        });
				        var rec = new recType({ SurveyQuestionId: SurveyQuestionId, QuestionContentId: QuestionContentId, QuestionContent: QuestionContent, SortIndex: sortIndex + 1, IsExplanation: '否' });
				        store.insert(store.data.length, rec);
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
				        }
				    }
				}, '->'
		    ]
            });

            var isRemark = new Ext.ux.form.AimComboBox({ /*是否评论*/
                id: 'isRemark',
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
                title: '<div align=left>答案选项维护</div>',
                store: store,
                height: 300,
                // autoHeight: true,
                renderTo: 'SubContent',
                viewConfig: { forceFit: true },
                autoExpandColumn: 'AnswerItems',
                columns: [
                    { id: 'Id', dataIndex: 'Id', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'QuestionContent', dataIndex: 'QuestionContent', header: '题目内容', width: 150 },
{ id: 'IsExplanation', dataIndex: 'IsExplanation', header: '添加说明', editor: isRemark, width: 50 },
					{ id: 'Answer', dataIndex: 'Answer', header: '答案选项', editor: { xtype: 'textarea' }, width: 250 },
				    { id: 'SortIndex', dataIndex: 'SortIndex', header: '序号', editor: { xtype: 'numberfield', minValue: 0, maxValue: 100 }, width: 80 }
					],
                tbar: tlBar
            });
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="SubContent" name="SubContent" style="width: 100%;">
    </div>
    <table class="aim-ui-table-edit">
        <tr>
            <td class="aim-ui-button-panel" colspan="8">
                <a id="btnSubmit" class="aim-ui-button">提交</a>&nbsp;&nbsp;<a id="btnCancel" class="aim-ui-button">取消</a>
            </td>
        </tr>
    </table>
</asp:Content>
