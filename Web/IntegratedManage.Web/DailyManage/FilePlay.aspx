<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="FilePlay.aspx.cs" Inherits="IntegratedManage.Web.Daily.FilePlay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            }
            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;
            if (errorType == "ImageError" || errorType == "MediaError") {
                return;
            }
            var errMsg = "Silverlight 应用程序中未处理的错误 " + appSource + "\n";
            errMsg += "代码: " + iErrorCode + "    \n";
            errMsg += "类别: " + errorType + "       \n";
            errMsg += "消息: " + args.ErrorMessage + "     \n";
            if (errorType == "ParserError") {
                errMsg += "文件: " + args.xamlFile + "     \n";
                errMsg += "行: " + args.lineNumber + "     \n";
                errMsg += "位置: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {
                if (args.lineNumber != 0) {
                    errMsg += "行: " + args.lineNumber + "     \n";
                    errMsg += "位置: " + args.charPosition + "     \n";
                }
                errMsg += "方法名称: " + args.methodName + "     \n";
            }
            引发新错误(errMsg); 
        }  
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="divPlayer" style="display: block">
        <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"
            width="100%" height="100%">
            <param name="source" value="/Document/Vedio.xap" />
            <param name="onError" value="onSilverlightError" />
            <param name="background" value="white" />
            <param name="minRuntimeVersion" value="4.0.50826.0" />
            <param name="autoUpgrade" value="false" />
            <param name="initParams" value='<%=GetUrl() %>' />
            <a href="/ClientBin/Silverlight.exe" style="text-decoration: none">
                <img src="/ClientBin/SLMedallion_CHS.png" alt="获取 Microsoft Silverlight" style="border-style: none" />
            </a>
        </object>
        &nbsp;</div>
</asp:Content>
