<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommitedSurvey.aspx.cs"
    Inherits="IntegratedManage.Web.SurveyManage.CommitedSurvey" %>

<script type="text/javascript">
    window.onload = function() {
        //document.createAttribute("color");
        //        try {
        //              $("#__PAGESTATE").remove();
        //        }catch{}
        try {
            $("#btnDiv").hide();
        } catch (e) { }

        var dom = document.getElementsByTagName("input");
        for (var i = 0; i < dom.length; i++) {
            dom[i].setAttribute("disabled", "disabled");
            dom[i].setAttribute("readonly", "readonly");
        }
        var textarea = document.getElementsByTagName("textarea");
        for (var i = 0; i < textarea.length; i++) {
            textarea[i].setAttribute("disabled", "disabled");
        }
    }
</script>

