<%@ Page Title="领导行程" Language="C#" MasterPageFile="~/Masters/Ext/IE8formpage.Master"
    AutoEventWireup="true" CodeBehind="LeaderTripEdit.aspx.cs" Inherits="IntegratedManage.Web.LeaderTripEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        i
        {
            margin-right: 5px;
        }
        td
        {
            vertical-align: middle !important;
        }
    </style>
    <script type="text/javascript">
        var df1, df2, cbg;
        function onPgLoad() {
            setPgUI();
            formdata = AimState["FormData"];
            var startDate = new Date(Date.parse(formdata.TripStartTime.replace(new RegExp("-", "gm"), "/")));
            df1.setValue(startDate.format('Y-m-d'));
            $("input:radio[value='" + formdata.StartAMPM + "'][name='rg']").attr('checked', 'true');
            var endDate = new Date(Date.parse(formdata.TripEndTime.replace(new RegExp("-", "gm"), "/")));
            df2.setValue(endDate.format('Y-m-d'));
            $("input:radio[value='" + formdata.EndAMPM + "'][name='rg2']").attr('checked', 'true');
        }
        function setPgUI() {
            df1 = new Ext.form.DateField({
                name: 'TripStartTime',
                width: 185,
                format: "Y-m-d",
                renderTo: 'div2'
            })
            df2 = new Ext.form.DateField({
                name: 'TripEndTime',
                format: "Y-m-d",
                width: 185,
                renderTo: 'div3'
            })
            $("#btnShowDialog").click(function () {
                var json = window.showModalDialog("LeaderList.aspx?op=u", 'mw', "dialogWidth=900px;dialogHeight=600px");
                if (json) {
                    $("#UserIds").val(json.UserIds);
                    $("#UserNames").val(json.UserNames);
                }
            })
            $("#btnSubmit").click(function () {
                var startdate = new Date(df1.getValue());
                var enddate = new Date(df2.getValue());
                if (enddate == startdate);
                {
                    var s1 = $("input:radio[name='rg']:checked").val();
                    var s2 = $("input:radio[name='rg2']:checked").val();
                    if (s1 == "PM" && s2 == "AM") {
                        alert("开始日期不能大于结束日期！")
                        return;
                    }
                }
                if (enddate < startdate) {
                    alert("开始日期不能大于结束日期！")
                    return;
                }
                if (!$("#TripType").val()) {
                    alert("外出类型不能为空！");
                    return;
                }
                if (startdate && enddate && $("#UserIds").val()) {
                    $("#StartAMPM").val($("input:radio[name='rg']:checked").val());
                    $("#EndAMPM").val($("input:radio[name='rg2']:checked").val());
                    $.ajaxExec($("#Id").val() ? "update" : "create", { JsonStr: AimFrm.getJsonString() }, function () {
                        if (window.opener && window.opener.store) {
                            window.opener.store.reload();
                            window.close();
                        }
                    })
                }
                else {
                    alert("外出人员、开始时间、结束时间不能为空！");
                }
            });
            $("#btnDelete").click(function () {
                if ($("#Id").val()) {
                    $.ajaxExec("delete", { TripId: $("#Id").val() }, function () {
                        if (window.opener && window.opener.store) {
                            window.opener.store.reload();
                            window.close();
                        }
                    })
                }
                else {
                    window.close();
                }
            });
            $("#btnCancel").click(function () {
                window.close();
            });
        }
        function btnInit() {
            if (!$("#Id").val()) {
                if (start) {
                    $("#TripStartTime").val(start);
                    $("#TripEndTime").val(start);
                } else {
                    $("#TripStartTime").val($.getDatePart());
                    $("#TripEndTime").val($.getDatePart());
                }
            } else {
                $("#TripStartTime").val($("#TripStartTime").val());
                $("#TripEndTime").val($("#TripEndTime").val());
            }
            $("#Id").val() && $("#delete").show();   //删除按钮
        }
        //日期验证
        function dateValida() {
            $("#TripEndTime").focusout(function () {
                if ($("#TripEndTime").val() && $("#TripStartTime").val()) {
                    $.ajaxExec("checkDate", { StartDate: $("#TripStartTime").val(), EndDate: $("TripEndTime").val(), LeaderId: LeaderId || ""
                    }, function (rtn) {
                        if (rtn.data.state == "1") {//已有该日期
                            AimDlg.show("已有该时段的日期,请重新选择!");
                            return;
                        }
                    });
                }
            });
        }
        function SuccessSubmit() {

            if ($("#Id").val()) {
                AimFrm.submit("update", {}, null, SubFinish);
            } else {
                AimFrm.submit("create", {}, null, SubFinish);
            }
        }
        function SubFinish(args) {
            window.returnValue = args.data.Id;
            RefreshClose();
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <strong><i class="fa fa-users"></i>领导外出</strong>
        </div>
        <div class="panel-body">
            <table class="table table-bordered">
                <tr style="display: none">
                    <td colspan="4">
                        <input id="Id" name="Id" />
                        <input id="State" name="State" />
                        <input id="StartAMPM" name="StartAMPM" />
                        <input id="EndAMPM" name="EndAMPM" />
                        <input id="UserIds" name="UserIds" />
                        <input id="CreateId" name="CreateId" />
                        <input id="CreateTime" name="CreateTime" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 15%;">
                        <label>
                            领导姓名</label>
                    </td>
                    <td colspan="3">
                        <div class="input-group">
                            <input id="UserNames" name="UserNames" class="form-control" placeholder="请选择领导" type="text" />
                            <div class="input-group-addon" id="btnShowDialog" style="cursor: pointer">
                                <i class="fa fa-list-ul"></i>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 15%;">
                        <label>
                            外出类型</label>
                    </td>
                    <td style="width: 35%;">
                        <select class="form-control" id="TripType" name="TripType">
                            <option value="">-请选择-</option>
                            <option value="出差">出差</option>
                            <option value="学习">学习</option>
                            <option value="考察">考察</option>
                        </select>
                    </td>
                    <td style="width: 15%;">
                        <label>
                            登记人</label>
                    </td>
                    <td style="width: 35%;">
                        <input id="CreateName" name="CreateName" class="form-control" type="text" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            外出时间从</label>
                    </td>
                    <td>
                        <div class="input-group">
                            <div class="form-control" id="div2">
                            </div>
                            <div class="input-group-addon">
                                <input type="radio" name='rg' value='AM' />AM
                                <input type="radio" name='rg' value='PM' />PM
                            </div>
                        </div>
                    </td>
                    <td>
                        <label>
                            至</label>
                    </td>
                    <td>
                        <div class="input-group">
                            <div class="form-control" id="div3">
                            </div>
                            <div class="input-group-addon">
                                <input type="radio" name='rg2' value='AM' />AM
                                <input type="radio" name='rg2' value='PM' />PM
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            外出事由</label>
                    </td>
                    <td colspan="3">
                        <textarea name="Reason" id="Reason" rows="3" style="width: 100%"></textarea>
                    </td>
                </tr>
            </table>
        </div>
        <div class=" panel-footer" style="text-align: center">
            <div class="btn-group">
                <a id="btnSubmit" class="btn btn-primary btn-sm"><i class="fa fa-floppy-o"></i><strong>
                    保 存</strong></a><a id="btnDelete" class="btn btn-primary btn-sm"><i class="fa fa-times-circle"></i>
                        <strong>删 除</strong></a><a id="btnCancel" class="btn btn-primary btn-sm"><i class="fa fa-ban"></i><strong>
                            取 消</strong></a>
            </div>
        </div>
    </div>
</asp:Content>
