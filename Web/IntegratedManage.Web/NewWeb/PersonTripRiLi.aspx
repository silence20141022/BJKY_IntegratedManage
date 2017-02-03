<%@ Page Title="领导外出" Language="C#" MasterPageFile="~/Masters/Ext/IE8Site.Master"
    AutoEventWireup="true" CodeBehind="PersonTripRiLi.aspx.cs" Inherits="IntegratedManage.Web.PersonTripRiLi" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Ext/ux/css/ColumnHeaderGroup.css" rel="stylesheet" type="text/css" />
    <script src="../js/ext/ux/ColumnHeaderGroup.js" type="text/javascript"></script>
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
        var weekDay = ["Sun", "Mon", "Tues", "Wed", "Thur", "Fri", "Sat"];
        function onPgLoad() {
            $("#btnBack").click(function () {
                window.location.href = "PersonTripRiLi.aspx?op=u&currentWeek=" + (parseFloat(AimState["currentWeek"]) - 1) + "&year=" + AimState["year"];
            });
            $("#btnNext").click(function () {
                window.location.href = "PersonTripRiLi.aspx?op=u&currentWeek=" + (parseFloat(AimState["currentWeek"]) + 1) + "&year=" + AimState["year"];
            })
            //            $("#search").click(function () {
            //                var json = { UserName: $("#UserName_s").val() };
            //                store.reload(json);
            //            })
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            var fieldarray = [];
            var colArray = [new Ext.ux.grid.AimRowNumberer(), new Ext.ux.grid.AimCheckboxSelectionModel()];
            var rowArray = [{ header: '<label id="lbweek"></label>', colspan: 4, align: 'center'}];
            if (AimState["ColumnData"]) {
                var coldata = AimState["ColumnData"];
                for (var i = 0; i < coldata.length; i++) {
                    fieldarray.push({ name: coldata[i].ColumnName });
                    if (i % 2 == 0 && i > 0) {
                        var header = coldata[i].ColumnName.slice(0, coldata[i].ColumnName.length - 2);
                        var myDate = new Date(Date.parse(header.replace(new RegExp("-", "gm"), "/")));
                        //js new一个date对象务必用/格式。否则getDay会报错
                        week = weekDay[myDate.getDay()];
                        header = "<font style='color:blue'><b>" + header + " " + week + "</b></font>"
                        rowArray.push({ header: header, colspan: 2, align: 'center' });
                    }
                    switch (coldata[i].ColumnName) {
                        case "UserNames":
                            colArray.push({ id: coldata[i].ColumnName, dataIndex: coldata[i].ColumnName, header: '领导姓名', width: 70 });
                            break;
                        case "UserIds":
                            colArray.push({ id: coldata[i].ColumnName, dataIndex: coldata[i].ColumnName, header: coldata[i].ColumnName, hidden: true });
                            break;
                        default:
                            header = coldata[i].ColumnName.slice(coldata[i].ColumnName.length - 2, coldata[i].ColumnName.length);
                            colArray.push({ id: coldata[i].ColumnName, dataIndex: coldata[i].ColumnName, header: header, align: 'center', width: 70, renderer: RowRender });
                            break;
                    }
                }
            }
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: fieldarray,
                listeners: { aimbeforeload: function (proxy, options) {
                    options.data.year = AimState["year"];
                    options.data.currentWeek = AimState["currentWeek"];
                }
                }
            });
            var columnModel = new Ext.grid.ColumnModel({
                columns: colArray,
                rows: [rowArray]
            });
            var pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                margins: '94 0 0 0',
                columnLines: true,
                // autoExpandColumn: 'UserName',
                bbar: pgBar,
                cm: columnModel,
                plugins: [new Ext.ux.grid.ColumnHeaderGroup()],
                listeners: { celldblclick: function (grid, rowIndex, columnIndex, e) {
                    var rec = store.getAt(rowIndex);
                    var columnId = grid.getColumnModel().getColumnId(columnIndex);
                    var trip = (rec.get(columnId) ? rec.get(columnId) : "");
                    var tripid = "";
                    if (trip) {
                        tripid = trip.slice(0, 36);
                    }
                    opencenterwin("LeaderTripEdit.aspx?TripId=" + tripid + "&ColumnId=" + columnId, "PersonTripEdit", 900, 500);
                    //window.location.href = "PersonTripEdit.aspx?UserIds=" + rec.get("UserIds") + + "&TripId=" + tripid;
                }
                }
            });
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [grid]
            })
            $("#lbweek").text(AimState["year"] + "年第" + AimState["currentWeek"] + "周");
        }
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn;
            switch (this.id) {
                case "ShouKuanAmount":
                case "ChouJinAmount":
                    rtn = CaiWuFormat(value);
                    break;
                case "Id":
                    rtn = "<i onclick='delrec(\"" + value + "\")' class='fa fa-times'>&nbsp;&nbsp;&nbsp;&nbsp;</i><i class='fa fa-pencil-square-o'></i>";
                    break;
                default:
                    if (value) {
                        var array1 = value.split("@");
                        cellmeta.attr = 'ext:qtitle="" ext:qtip="' + array1[2] + '"';
                        rtn = '<span  style="color:#FF8247">' + array1[1] + '</span>';
                    }
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
                <li><a href="PersonTripTable.aspx" style="color: black; font-weight: bolder"><span
                    class="fa fa-search"></span>外出查询</a></li>
                <li class="active"><a href="PersonTripRiLi.aspx" style="color: black; font-weight: bolder">
                    <span class="fa fa-calendar"></span>日历视图</a></li>
            </ul>
        </div>
        <table class="table">
            <tr>
                <td>
                    <div class="btn-group">
                        <a class="btn btn-primary btn-sm" id="btnBack"><span class="fa fa-backward"></span><strong>
                            上一周</strong></a> <a class="btn btn-primary btn-sm" id="btnNext"><strong>下一周</strong><span
                                class="fa fa-forward" style="padding-left: 5px; padding-right: 0"> </span>
                        </a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
