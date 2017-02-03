<%@ Page Title="公出日程" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="LeaderBusinessTripEdit.aspx.cs" Inherits="IntegratedManage.Web.LeaderBusinessTripEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/PCASClass.js" type="text/javascript" charset="gb2312"></script>

    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
        }
        td
        {
            font-size: 12;
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

    <script src="/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script type="text/javascript">
        var start = $.getQueryString({ ID: 'Start' });
        var end = $.getQueryString({ ID: 'End' });
        var type = $.getQueryString({ ID: 'type' });

        var LeaderId = unescape($.getQueryString({ ID: 'LeaderId' }));
        var LeaderName = unescape($.getQueryString({ ID: 'LeaderName' }));

        function onPgLoad() {
            setPgUI();
            btnInit();
            dateValida();  //验证日期是否冲突
        }

        function setPgUI() {

            //地区选择
            new PCAS("province", "city", "area");
            $("#province,#city,#area").change(function() {
                $("#Addr").val($("#province").val() + $("#city").val() + $("#area").val());
            });

            start = $("#Id").val() ? ($("#TripStartTime").val().split(' ') || []) : start;
            end = $("#Id").val() ? ($("#TripEndTime").val().split(' ') || []) : end;

            if (LeaderId && LeaderName) {
                $("#LeaderName").val(LeaderName);
                $("#LeaderId").val(LeaderId);
                !$("#Id").val() && $("#LeaderNameusersel").val(LeaderName || '');   //User控件bug
            }

            FormValidationBind('btnSubmit', SuccessSubmit)  //保存

            $("#delete").click(function() {       //删除
                if (confirm("确定要删除吗?")) {
                    AimFrm.submit("delete", { Id: $("#Id").val() }, null, function() {
                        window.returnValue = "refurbish";
                        RefreshClose();
                    });
                }
            });
            $("#btnCancel").click(function() { window.close() }); //取消

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
            $("#TripEndTime").focusout(function() {
                if ($("#TripEndTime").val() && $("#TripStartTime").val()) {
                    $.ajaxExec("checkDate", { StartDate: $("#TripStartTime").val(), EndDate: $("TripEndTime").val(), LeaderId: LeaderId || ""
                    }, function(rtn) {
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
    <div id="header">
        <h1>
            外出日程</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                        <input id="State" name="State" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        领导姓名
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="LeaderName" name="LeaderName" aimctrl='user' <%=seltype%> relateid="LeaderId"
                            style="width: 328px;" />
                        <input name="LeaderId" id="LeaderId" type="hidden" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        外出时间
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="TripStartTime" name="TripStartTime" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy/MM/dd'})"
                            readonly="readonly" />
                        至
                        <input id="TripEndTime" name="TripEndTime" class="Wdate" onclick="var date=$('#TripStartTime').val()?$('#TripStartTime').val():new Date();  
				WdatePicker({minDate:date,dateFmt:'yyyy/MM/dd'})" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption" style="width: 15%">
                        外出地点
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="Addr" name="Addr" style="width: 35%;" class="validate[required]" />
                        <select name="province" id="province">
                        </select><select name="city" id="city"></select><select name="area" id="area"></select>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        外出主题
                    </td>
                    <td class="aim-ui-td-data" colspan="4">
                        <input id="Theme" name="Theme" style="width: 100%;" class="validate[required]" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        外出事由
                    </td>
                    <td class="aim-ui-td-data" colspan="4">
                        <textarea name="Reason" id="Reason" rows="10" style="width: 100%;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button">保存</a>&nbsp; &nbsp;<a id="delete" style="display: none"
                            class="aim-ui-button cancel">删除</a> &nbsp;<a id="btnCancel" class="aim-ui-button cancel">
                                取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
