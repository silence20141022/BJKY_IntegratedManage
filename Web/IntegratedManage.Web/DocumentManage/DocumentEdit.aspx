<%@ Page Title="发文管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="DocumentEdit.aspx.cs" Inherits="IntegratedManage.Web.DocumentEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
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
        .righttxt
        {
            text-align: right;
        }
        input
        {
            width: 90%;
        }
        select
        {
            width: 90%;
        }
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }
        .x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
    </style>

    <script type="text/javascript">
        var InFlow = $.getQueryString({ ID: "InFlow" });
        var LinkView = $.getQueryString({ ID: "LinkView" });
        var taskName = unescape($.getQueryString({ ID: "taskName" }));
        var fileId = $.getQueryString({ ID: "fileId" });
        var fileName = unescape($.getQueryString({ ID: "fileName" }));
        var id = $.getQueryString({ ID: 'id' });
        var tbarvisible;
        function onPgLoad() {
            if (LinkView == "T" || (InFlow != "T" && pgOperation == "v") || taskName == "部门文书" || taskName == "部门文书[分发]") {
                //document.all.WebOffice1.ReadOnly = 1; 跟踪模式、查看、和部分节点设置只读taskName == "归口部门会签" || taskName == "相关部门会签" ||
                tbarvisible = false;
            }
            else {
                tbarvisible = true;
            }
            setPgUI();
        }
        function setPgUI() {
            var tlBar = new Ext.Toolbar({
                renderTo: 'div1',
                items: [{
                    text: '保存', hidden: tbarvisible == false,
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        var result = SaveToWeb(fileId);
                        if (taskName == "打字员") {
                            $.ajaxExec("UpdateReleaseContent", { id: id, ReleaseContent: result.substring(0, 36) }, function() {
                                $("#ReleaseContent", window.opener.document).val(result.substring(0, 36));
                            });
                        }
                        if (result) {
                            alert("保存成功！");
                        }
                    }
                }, '-', {
                    text: '关闭',
                    iconCls: 'aim-icon-exit',
                    handler: function() {
                        window.close();
                    }
}]
                });
                LoadDoc(fileId + "_" + fileName);
            }
            function LoadDoc(val) {
                var host = window.location.host;
                var result = document.all.WebOffice1.LoadOriginalFile("Http://" + host + "/Document/" + val, "doc");
                if (InFlow == "T" && LinkView != "T") {
                    document.all.WebOffice1.SetTrackRevisions(1); //设置文档编辑模式是否为修订模式
                }
                else {
                    document.all.WebOffice1.SetTrackRevisions(0);
                }
                if (taskName == "院办主任核稿" || taskName == "部门文书" || taskName == "相关部门签收" || (InFlow != "T" && pgOperation == "v")) {
                    document.all.WebOffice1.ShowRevisions(0);  // 1:显示修订  0:隐藏修订 
                }
                //隐藏自定义工具
                document.all.WebOffice1.HideMenuItem(0x01);
                document.all.WebOffice1.HideMenuItem(0x02);
                document.all.WebOffice1.HideMenuItem(0x04);
                //隐藏菜单
                document.all.WebOffice1.HideMenuArea("", "", "", "");
                //屏蔽文件菜单项
                document.all.WebOffice1.SetToolBarButton2("Menu Bar", 1, 1);
                if (LinkView != "T" && InFlow == "T") {
                    if (taskName == "部门领导" || taskName == "院办主任" || taskName == "主管院长" || taskName == "归口部门会签" || taskName == "相关部门会签") {//流程跟踪的时候taskName也有值
                        document.all.WebOffice1.SetCustomToolBtn(2, "插入批注");
                    }
                }
                if (InFlow == "T") {
                    document.all.WebOffice1.SetCustomToolBtn(4, "显示修订");
                    document.all.WebOffice1.SetCustomToolBtn(3, "隐藏修订");
                } 
                document.all.WebOffice1.SetCurrUserName(AimState["UserInfo"].Name);//用户名
                 var webObj = document.getElementById("WebOffice1"); 
                //webObj.HideMenuArea("", "", "", ""); //隐藏2007 功能区
                if (result) {//文档打开成功
                   webObj.GetDocumentObject().Application.UserInitials = AimState["UserInfo"].Name;//缩写
                    // webObj.GetDocumentObject().Application.Caption = "融为Word编辑器";
                }
            }
            function WebOffice1_NotifyToolBarClick(lCmd) {//2. 截获处理事件 
                if (32776 == lCmd) {
                    SaveDoc();
                }
                if (32778 == lCmd) {
                    document.all.WebOffice1.GetDocumentObject().Comments.Add(document.all.WebOffice1.GetDocumentObject().ActiveWindow.Selection.Range, "");
                    //document.all.WebOffice1.lEventRet = 0;		 
                }
                else if (lCmd == 32779) {
                    document.all.WebOffice1.ShowRevisions(0);
                }
                else if (lCmd == 32780) {
                    document.all.WebOffice1.ShowRevisions(1);
                }
            }
            function SaveToWeb(fileId) {
                if (document.all.WebOffice1.IsOpened() != 0 && document.all.WebOffice1.ReadOnly != 1) {
                    if (document.all.WebOffice1.IsSaved() == 0) {
                        document.all.WebOffice1.HttpInit();
                        document.all.WebOffice1.HttpAddPostString("RecordID", "rongwei");
                        if (taskName != "打字员") {  // 加此审批节点判断是不是打字员提交，如果是，将内容保存为发布字段
                            document.all.WebOffice1.HttpAddPostString("FileId", fileId);
                        }
                        document.all.WebOffice1.HttpAddPostString("FileMainName", escape(fileName));
                        document.all.WebOffice1.HttpAddPostCurrFile("FileData", "11.doc");
                        var host = window.location.host;
                        return document.all.WebOffice1.HttpPost("Http://" + host + "/DocumentManage/SaveDoc.aspx");
                    }
                }
            }
            function window_onunload() {
                document.all.WebOffice1.SetCurrUserName("");
                document.all.WebOffice1.SetTrackRevisions(0);
                document.all.WebOffice1.Close();
            }
    </script>

    <script language="javascript" for="WebOffice1" event="NotifyToolBarClick(lCmd)" type="text/javascript">
                WebOffice1_NotifyToolBarClick(lCmd);
    </script>

    <%----%>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <fieldset id="fieldset" style="display: none">
        <legend>基本信息</legend>
        <table class="aim-ui-table-edit" style="border: none">
            <tr style="display: none">
                <td colspan="4">
                    <input id="Id" name="Id" /><input id="ApproveContent" name="ApproveContent" />
                    <input id="ReleaseContent" name="ReleaseContent" /><input id="Attachment" name="Attachment" />
                </td>
            </tr>
        </table>
    </fieldset>
    <div style="text-align: center; padding: 0 15 0 15">
        <div id="div1">
        </div>
        <object id="WebOffice1" height="100%" width='100%' style='left: 0px; top: 0px' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5'
            codebase="WebOffice.cab#V6,0,0,0">
            <param name='_ExtentX' value='6350' />
            <param name='_ExtentY' value='6350' />
        </object>
    </div>
</asp:Content>
