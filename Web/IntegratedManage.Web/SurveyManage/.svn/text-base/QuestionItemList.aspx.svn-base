<%@ Page Title="问卷答案查看" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="QuestionItemList.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.QuestionItemList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .rowspan-grid .x-grid3-body .x-grid3-row
        {
            border: none;
            cursor: default;
            width: 100%;
        }
        .rowspan-grid .x-grid3-header .x-grid3-cell
        {
            /*border-left: 2px solid transparent;*/ /*ie6的transparent下显示黑色?*/
            border-left: 2px solid #fff;
        }
        .rowspan-grid .x-grid3-body .x-grid3-row
        {
            overflow: hidden;
            border-right: 1px solid #ccc; 
        }
        .rowspan-grid .x-grid3-body .x-grid3-cell
        {
            border: 1px solid #ccc;
            border-top: none;
            border-right: none;
        }
        .rowspan-grid .x-grid3-body .x-grid3-cell-first
        {
            /*border-left: 1px solid transparent;*/
            border-left: 1px solid #fff;
        }
        .rowspan-grid .x-grid3-body .rowspan-unborder
        {
            /*border-bottom:1px solid transparent;*/
            border-bottom: 1px solid #fff;
        }
        .rowspan-grid .x-grid3-body .rowspan
        {
            border-bottom: 1px solid #ccc;
        }
    </style>

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=650,height=600,scrollbars=yes");
        var EditPageUrl = "QuestionItemEdit.aspx";
        var Title = unescape($.getQueryString({ ID: 'Title' }));
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["QuestionItemList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'QuestionItemList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'SurveyQuestionId' },
			{ name: 'QuestionContentId' },
			{ name: 'Content' },
			{ name: 'AnswerItems' },
			{ name: 'QuestionType' },
			{ name: 'IsMustAnswer' },
			{ name: 'IsComment' }
			]
            });


            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                title: "【" + Title + "】内容项",
                store: store,
                region: 'center',
                autoExpandColumn: 'AnswerItems',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'Content', dataIndex: 'Content', header: '问题项', width: 150, renderer: RowRender },
					{ id: 'QuestionType', dataIndex: 'QuestionType', header: '问题类型', width: 100 },
					{ id: 'IsMustAnswer', dataIndex: 'IsMustAnswer', header: '是否必答项', width: 100 },
					{ id: 'IsComment', dataIndex: 'IsComment', header: '是否评论', width: 100 },
					{ id: 'AnswerItems', dataIndex: 'AnswerItems', header: '答案项', width: 200 }
                    ]
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
            });
        }

        function RowRender(value, meta, record, rowIndex, colIndex, store) {
            switch (this.id) {
                case "Content":
                    if (!value) {
                        return '';
                    }
                    var first = !rowIndex || value !== store.getAt(rowIndex - 1).get("Content");
                    var last = rowIndex >= store.getCount() - 1 || value !== store.getAt(rowIndex + 1).get("Content");
                    meta.css += 'row-span' + (first ? ' row-span-first' : '') + (last ? ' row-span-last' : '');
                    if (first && last)
                    // meta.css = 'row-span' + ' row-span-first-last';
                        if (first) {
                        var i = rowIndex + 1;
                        while (i < store.getCount() && value === store.getAt(i).get("Content")) {
                            i++;
                        }
                        var rowHeight = 23, padding = 8, height = (rowHeight * (i - rowIndex) - padding) + 'px';
                        meta.attr = 'style="height:' + height + ';line-height:' + height + ';"';
                        meta.attr = '';
                    }
                    return first ? '<b>' + value + '</b>' : '';
            }

        }

        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
        </h1>
    </div>
</asp:Content>
