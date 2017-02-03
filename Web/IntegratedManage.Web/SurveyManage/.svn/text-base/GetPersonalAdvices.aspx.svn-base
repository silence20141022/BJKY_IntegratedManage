<%@ Page Title="查看统计结果" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="GetPersonalAdvices.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.GetPersonalAdvices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        var isNoName = $.getQueryString({ ID: 'isNoName' }) || '';
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [{ name: 'UserId' }, { name: 'UserName' }, { name: 'QuestionItemContent' }, { name: 'CreateId'}]
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            var cln = [new Ext.ux.grid.AimRowNumberer(), new Ext.ux.grid.AimCheckboxSelectionModel(),
                      { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                      { id: 'UserId', dataIndex: 'UserId', header: 'UserId', hidden: true}];
            //匿名
            isNoName != "yes" && cln.push({ id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 140, sortable: true });

            cln.push({ id: 'QuestionItemContent', dataIndex: 'QuestionItemContent', header: '评论内容', width: 120, renderer: RowRender });


            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'QuestionItemContent',
                columns: cln
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }

        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            if (value) {
                value = value.replaceAll("##", "") || "";
                cellmeta.attr = 'ext:qtitle =""' + ' ext:qtip ="' + value + '"';
                rtn = value;
            }
            return rtn;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
