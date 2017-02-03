<%@ Page Title="领导外出" Language="C#" MasterPageFile="~/Masters/Ext/IE8Site.Master"
    AutoEventWireup="true" CodeBehind="PersonTripTable.aspx.cs" Inherits="IntegratedManage.Web.PersonTripTable" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        span
        {
            padding-right: 5px;
        }
        .x-toolbar
        {
            box-sizing: content-box !important;
        }
    </style>
    <script type="text/javascript">
        var store, grid;
        function onPgLoad() {
            df1 = new Ext.form.DateField({
                id: 'BeginDate',
                width: 110,
                renderTo: 'div2'
            })
            df2 = new Ext.form.DateField({
                id: 'EndDate',
                width: 110,
                renderTo: 'div3'
            })
            $("#search").click(function () {
                var json = { UserNames: $("#UserNames_s").val(), Reason: $("#Reason_s").val(), TripType: $("#TripType_s").val(), BeginDate: df1.getValue(), EndDate: df2.getValue() };
                store.reload(json);
            })
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#search").click();
                }
            });
            $("#btnAdd").click(function () {
                window.location.href = "PersonTripEdit.aspx";
            });
            $("#btnModify").click(function () {
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    AimDlg.show("请先选择要修改的记录！");
                    return;
                }
                opencenterwin("LeaderTripEdit.aspx?op=u&TripId=" + recs[0].get("Id"), '', 900, 500);
            });
            $("#btnDelete").click(function () {
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    AimDlg.show("请先选择要删除的记录！");
                    return;
                }
                var tripids = "";
                $.each(recs, function () {
                    tripids += (tripids ? "," : "") + this.get("Id");
                })
                $.ajaxExec("delete", { tripids: tripids }, function () {
                    var json = { UserNames: $("#UserNames_s").val(), Reason: $("#Reason_s").val(), BeginDate: df1.getValue(), EndDate: df2.getValue() };
                    store.reload(json);
                })
            });
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [{ name: 'Id' }, { name: 'UserIds' }, { name: 'UserNames' }, { name: 'TripStartTime' }, { name: 'TripEndTime' },
                { name: 'Reason' }, { name: 'TripType' }, { name: 'StartAMPM' }, { name: 'EndAMPM' }, { name: 'CreateTime'}]
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
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'Reason',
                margins: '95 0 0 0',
                columns: [
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                { id: 'UserNames', dataIndex: 'UserNames', header: '领导姓名', width: 200 },
                { id: 'TripType', dataIndex: 'TripType', header: '外出类型', width: 70 },
                { id: 'TripStartTime', dataIndex: 'TripStartTime', header: '开始时间', width: 130, renderer: RowRender },
                { id: 'TripEndTime', dataIndex: 'TripEndTime', header: '结束时间', width: 130, renderer: RowRender },
                { id: 'Reason', dataIndex: 'Reason', header: '外出事由', width: 170 }
                 ],
                bbar: pgBar
            });
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [grid]
            })
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn;
            switch (this.id) {
                case "TripStartTime":
                    var startDate = new Date(Date.parse(value.replace(new RegExp("-", "gm"), "/")));
                    rtn = Ext.util.Format.date(startDate, "Y-m-d") + " " + record.get("StartAMPM");
                    break;
                case "TripEndTime":
                    var endDate = new Date(Date.parse(value.replace(new RegExp("-", "gm"), "/")));
                    rtn = Ext.util.Format.date(endDate, "Y-m-d") + " " + record.get("EndAMPM");
                    break;
                case "Id":
                    rtn = "<i onclick='delrec(\"" + value + "\")' class='fa fa-times'>&nbsp;&nbsp;&nbsp;&nbsp;</i><i class='fa fa-pencil-square-o'></i>";
                    break;
            }
            return rtn;
        }        
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div class="panel panel-default">
        <div class=" panel-heading small" style="padding-bottom: 0px;">
            <ul class="nav nav-tabs" style="border-bottom-width: 0px">
                <li><a href="PersonTripEdit.aspx" style="color: black; font-weight: bolder"><span
                    class="fa fa-pencil-square-o"></span>外出登记</a></li>
                <li class="active"><a href="PersonTripTable.aspx" style="color: black; font-weight: bolder">
                    <span class="fa fa-search"></span>外出查询</a></li>
                <li><a href="PersonTripRiLi.aspx" style="color: black; font-weight: bolder"><span
                    class="fa fa-calendar"></span>日历视图</a></li>
            </ul>
        </div>
        <table class="table">
            <tr>
                <td style="width: 20%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">外出事由</span>
                        <input type="text" class=" form-control" id="Reason_s" />
                    </div>
                </td>
                <td style="width: 15%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">外出类型</span>
                        <select class="form-control" id="TripType_s">
                            <option value="">-请选择-</option>
                            <option value="出差">出差</option>
                            <option value="学习">学习</option>
                            <option value="考察">考察</option>
                        </select>
                    </div>
                </td>
                <td style="width: 18%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">外出日期从</span>
                        <div id="div2" class="form-control">
                        </div>
                    </div>
                </td>
                <td style="width: 18%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">至</span>
                        <div id="div3" class="form-control">
                        </div>
                        <span class="input-group-addon" id="search" style="cursor: pointer"><span class="fa fa-search">
                            查 询</span></span>
                    </div>
                </td>
                <td>
                    <div class="btn-group">
                        <a class="btn btn-primary btn-sm" id="btnAdd"><span class="fa fa-plus-square"></span>
                            <strong>添 加</strong></a><a class="btn btn-primary btn-sm" id="btnDelete"><span class="fa fa-times-circle">
                            </span><strong>删 除</strong></a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
