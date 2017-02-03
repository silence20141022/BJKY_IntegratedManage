<%@ Page Title="领导信息" Language="C#" MasterPageFile="~/Masters/Ext/IE8Site.Master"
    AutoEventWireup="true" CodeBehind="LeaderSelect.aspx.cs" Inherits="IntegratedManage.Web.LeaderSelect" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        span
        {
            margin-right: 5px;
        }
        .x-toolbar
        {
            box-sizing: content-box !important;
        }
    </style>
    <script type="text/javascript">
        var store, grid;
        function onPgLoad() {
            $("#search").click(function () {
                var json = { UserName: $("#UserName_s").val() };
                store.reload(json);
            })
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#search").click();
                }
            });
            $("#btnConfirm").click(function () {
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    alert("请选择相应的记录！");
                    return;
                }
                var userIds = ""; var userNames = "";
                $.each(recs, function () {
                    userIds += (userIds ? "," : "") + this.get("UserId");
                    userNames += (userNames ? "," : "") + this.get("UserName");
                })
                window.returnValue = { UserIds: userIds, UserNames: userNames };
                window.close();
            });
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [{ name: 'Id' }, { name: 'UserId' }, { name: 'UserName' }, { name: 'DeptId' }, { name: 'DeptName' },
                { name: 'SortIndex'}]
                //                listeners: { aimbeforeload: function (proxy, options) {
                //                    options.data.year = AimState["year"];
                //                    options.data.currentWeek = AimState["currentWeek"];
                //                }
                //                }
            });
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                bbar: pgBar,
                margins: '90 0 0 0',
                autoExpandColumn: 'DeptName',
                columnLines: true,
                columns: [
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                { id: 'UserName', dataIndex: 'UserName', header: '领导姓名', width: 100 },
                { id: 'SortIndex', dataIndex: 'SortIndex', header: '序号', width: 60 },
                // { id: 'Id', dataIndex: 'Id', header: '升/降序', width: 80, renderer: RowRender },
                {id: 'DeptName', dataIndex: 'DeptName', header: '所属部门', width: 130 }
                 ]
            });
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [grid]
            })
        }
        function leveldown(val) {
            $.ajaxExec("downlevel", { id: val }, function () {
                store.reload();
            })
        }
        function levelup(val) {
            $.ajaxExec("uplevel", { id: val }, function () {
                store.reload();
            })
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn;
            switch (this.id) {
                case "TripStartTime":
                    rtn = Ext.util.Format.date(value, "Y-m-d") + " " + record.get("StartAMPM");
                    break;
                case "TripEndTime":
                    rtn = Ext.util.Format.date(value, "Y-m-d") + " " + record.get("EndAMPM");
                    break;
                case "Id":
                    rtn = "<span class='fa fa-arrow-up  text-info' style='cursor: pointer' onclick='levelup(\"" + value + "\")'></span>&nbsp;&nbsp;&nbsp;&nbsp;<span onclick='leveldown(\"" + value + "\")' class='fa fa-arrow-down text-info' style='cursor: pointer'></span>";
                    break;
            }
            return rtn;
        }
        
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <%--<ul class="nav nav-tabs" style="border-bottom-width: 0px">
                <li><a href="LeaderTripRiLi.aspx?op=u" style="color: black; font-weight: bolder"><span
                    class="fa fa-calendar"></span>日历视图</a></li>
                <li><a href="LeaderTripTable.aspx?op=u" style="color: black; font-weight: bolder"><span
                    class="fa fa-table"></span>表格视图</a></li>
                <li class="active"><a href="LeaderList.aspx?op=u" style="color: black; font-weight: bolder">
                    <span class="fa fa-users"></span>领导维护</a></li>
            </ul>--%>
            <strong><span class="fa fa-users"></span>领导选择</strong>
        </div>
        <table class="table">
            <tr>
                <td style="width: 35%">
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">领导姓名</span>
                        <input type="text" class=" form-control" id="UserName_s" />
                        <span class="input-group-addon" id="search" style="cursor: pointer"><span class="fa fa-search">
                            查 询</span></span>
                    </div>
                </td>
                <td>
                    <div class="btn-group">
                        <a class="btn btn-primary btn-sm" id="btnConfirm"><span class="fa fa-check-square"></span>
                            <strong>确 定</strong></a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
