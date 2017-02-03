<%@ Page Title="信息维护" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="EnterpriseAddrBookEdit.aspx.cs" Inherits="IntegratedManage.Web.EnterpriseAddrBookEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        body
        {
            background-color: #F2F2F2;
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
        td
        {
            font-size: 12;
        }
        .aim-ui-td-caption
        {
            text-align: right;
        }
        .fieldset1
        {
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
    </style>

    <script type="text/javascript">
        var type = $.getQueryString({ ID: 'type' });
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            var pgCaption = { "c": "添加通讯录", "u": "编辑通讯录", "r": "查看通讯录" };

            //$("#header h1:only-child").text(pgCaption[pgOperation] || "会议通知信息");
            if (AimState["frmdata"]) {
                //$("#IsShowPersonalTel").attr("checked", AimState["frmdata"]["IsShowPersonalTel"] == "1")
                $("input:radio").each(function() {
                    ($(this).val() == AimState["frmdata"]["Sex"]) && $(this).attr("checked", true);
                });
            }
            if (type == "add") {
                $("#DeptName").remove();
                $("#DeptNameHide").show();
            } else {
                $("#DeptNameHide").remove();
            }


            if ($("#PhotoId").val()) {
                $("#img").attr("src", "/Document/" + $("#PhotoId").val());
            } else {
                $("#img").attr("src", "../images/avatar.png");
            }
            $(".uploadImg").click(function() {
                var UploadStyle = "dialogHeight:405px; dialogWidth:465px; help:0; resizable:0; status:0;scroll=0";
                var uploadurl = '../CommonPages/File/Upload.aspx?IsSingle=true&Filter=' + escape('图片格式') + '(*.jpg;*.jpeg)|*.jpeg;*.jpg';
                var rtn = window.showModalDialog(uploadurl, window, UploadStyle);
                if (rtn) {
                    var src = "/Document/" + rtn.substring(0, rtn.length - 1);
                    $("#img").attr("src", src);
                    $("#PhotoId").val(rtn.substring(0, rtn.length - 1));
                }
            });

            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }
        

    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            通讯录维护</h1>
    </div>
    <div id="editDiv" align="center">
        <fieldset>
            <legend>基本信息</legend>
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr style="display: none">
                        <td>
                            <input id="Id" name="Id" />
                        </td>
                    </tr>
                    <tr>
                        <td width="150" style="text-align: center">
                            <img style="height: 125; width: 120" src="../images/avatar.png" id="img" alt="" />
                            <br />
                            <input type="button" value="上传图像" class="uploadImg" />
                            <input type="hidden" name="PhotoId" id="PhotoId" />
                        </td>
                        <td style="text-align: left; vertical-align: top;">
                            <table style="width: 100%">
                                <tr>
                                    <td class="aim-ui-td-caption" style="width: 15%">
                                        姓名
                                    </td>
                                    <td class="aim-ui-td-data" colspan="4" style="width: 101%">
                                        <input id="UserName" name="UserName" style="width: 100.7%; height: 22;" readonly="readonly" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="aim-ui-td-caption" style="width: 15%; font-size: 12">
                                        所属部门
                                    </td>
                                    <td class="aim-ui-td-data" colspan="7" style="width: 99%">
                                        <input id="DeptName" name="DeptName" style="width: 100%; height: 22;" readonly="readonly" />
                                        <input id="DeptNameHide" name="DeptName" style="width: 300; height: 22; display: none"
                                            class="validate[required]" popurl="/Select/GrpSelect/GrpSelView.aspx?seltype=single"
                                            popparam="DeptId:GroupID;DeptName:Name" popstyle="width=450,height=450" readonly="readonly" />
                                        <input id="DeptId" name="DeptId" type="hidden" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="aim-ui-td-caption" style="width: 25%; font-size: 12">
                                        职务
                                    </td>
                                    <td class="aim-ui-td-data" style="width: 100%;" colspan="7">
                                        <input id="Postion" name="Postion" style="width: 100%; height: 22;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 20%; font-size: 12" class="aim-ui-td-caption">
                                        性别
                                    </td>
                                    <td class="aim-ui-td-data">
                                        <input type="radio" value="man" name="Sex" />男
                                        <input type="radio" value="woman" name="Sex" />女
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <fieldset class="fieldset1">
            <legend>办公信息</legend>
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 43%">
                            电子邮件
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="OfficeEmail" class="validate[custom[email]]" name="OfficeEmail" style="width: 95.7%;
                                height: 22" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            办公电话
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="text" name="OfficeTel" id="OfficeTel" class="validate[custom[telephone]]"
                                style="width: 95.7%; height: 22;" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            移动电话
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="text" name="PersonalTel" id="PersonalTel" class="validate[custom[telephone]]"
                                style="width: 95.7%; height: 22;" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            办公地址
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="text" name="OfficeAddr" id="OfficeAddr" style="width: 95.7%; height: 22;" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            传真
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="text" name="Fax" id="Fax" style="width: 95.7%; height: 22" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            家庭电话
                        </td>
                        <td class="aim-ui-td-data">
                            <input type="text" id="FamilyTel" name="FamilyTel" style="width: 95.7%; height: 22" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption" style="width: 24%">
                            家庭住址
                        </td>
                        <td class="aim-ui-td-data">
                            <textarea id="PersonalAddr" name="PersonalAddr" rows="3" style="width: 95.7%;"></textarea>
                            <%-- <input type="text" id="PersonalAddr" name="PersonalAddr" style="width: 500; height: 22" />--%>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <div style="width: 100%">
            <table class="aim-ui-table-edit">
                <tbody>
                    <tr>
                        <td class="aim-ui-button-panel" colspan="4">
                            <a id="btnSubmit" class="aim-ui-button submit">提交</a> <a id="btnCancel" class="aim-ui-button cancel">
                                取消</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
