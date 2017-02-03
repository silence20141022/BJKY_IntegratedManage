<%@ Page Title="问卷详细" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="DetailViewList.aspx.cs" Inherits="IntegratedManage.Web.SurveyManage.DetailViewList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script type="text/javascript">
        var store, grid;
        var SurveyId = $.getQueryString({ ID: 'Id' }) || '';
        function onPgLoad() {
            setPgUI();
            initFirst();
        }

        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };

            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                listeners: { aimbeforeload: function (proxy, opitions) {
                    opitions.data.Id = SurveyId;
                }
                },
                fields: [
			{ name: 'UserId' },
			{ name: 'SurveyId' },
			{ name: 'UserName' },
		    { name: 'DeptId' },
			{ name: 'DeptName' },
            { name: "IsNoName" }
			]
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 1,
                collapsed: false,
                items: [
                { fieldLabel: '姓名', id: 'UserName', schopts: { qryopts: "{ mode: 'Like', field: 'UserName' }"} }
      ]
            });


            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                border: false,
                height: 520,
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
					{ id: 'UserName', dataIndex: 'UserName', header: '姓名', width: 100, sortable: true, renderer: RowRender },
					{ id: 'DeptName', dataIndex: 'DeptName', header: '部门', width: 140 }
                    ],
                tbar: schBar,
                bbar: pgBar
            });

            grid.on("rowClick", function (grid, number, e) {
                var rec = grid.getStore().getAt(number);
                loadDetail(SurveyId, rec.get("UserId"));
            });
            panel = new Ext.ux.AimPanel({
                title: '提交人员',
                region: 'west',
                split: true,
                width: 240,
                autoScroll: true,
                collapsible: true,
                margins: '3,0,3,3',
                cmargins: '3,3,3,',
                items: [grid]
            });
            content = new Ext.ux.AimPanel({
                title: '问卷内容',
                autoScroll: true,
                region: 'center',
                html: '<iframe width="100%" height="100%" id="usrViewFrame" name="frameContent" frameborder="0"  ></iframe>'
            });

            viewport = new Ext.ux.AimViewport({
                items: [panel, content]
            });
        }
        /*加载第一条数据*/
        function initFirst() {
            loadDetail(SurveyId, grid.getStore().getAt(0).get("UserId"));
        }
        function loadDetail(survey, userId) {
            var url = "CommitedSurvey.aspx?SurveyId=" + survey + "&UserId=" + userId;
            usrViewFrame.location.href = url;
            $("#btnDiv").hide();
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "UserName":
                    if (record.get("IsNoName") == "no") {
                        rtn = value;
                    } else {
                        rtn = "匿名";
                    }
                    break;
            }
            return rtn;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
