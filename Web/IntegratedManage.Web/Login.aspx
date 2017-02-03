<%@ Page Title="用户登录" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="Aim.Portal.Web.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>用户登录</title>
    <meta http-equiv="Content-Type" />

    <script src="/js/lib/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script src="/js/common.js" type="text/javascript"></script>

    <script src="/js/pgform.js" type="text/javascript"></script>

    <script src="/js/lib/jquery.form.js" type="text/javascript"></script>

    <script src="/js/lib/jquery.plug-ins.js" type="text/javascript"></script>

    <link href="Login_Theme/mini-pkg-min.css" rel="stylesheet" type="text/css" />
    <link href="Login_Theme/login_pro.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #loading
        {
            width: 16px;
            height: 16px;
            margin-left: 80px;
        }
    </style>
    <style type="text/css">
        .text-input
        {
            border: solid 1px #8FAACF;
        }
        .lbl-message
        {
            color: Red;
        }
    </style>

    <script language="javascript" type="text/javascript">
        var islogining = false;
        function onPgLoad() {
            $(document).bind("keydown", function(e) {  // 回车              
                if (e.keyCode == 13 && !islogining) {
                    DoLogin();
                }
            });
            getCookie();    // 获取Cookie
            if (!$("#uname").val()) {
                $("#uname").focus();
            } else if (!$("#pwd").val()) {
                $("#pwd").focus();
            } else {
                $("#imgDoLogin").focus();
            }
        }

        function DoLogin() { 
            if (islogining) {
                return;
            }
            setLoginStatus(true);
            if (!$("#uname").val()) {
                $("#message").text("提示：请输入用户名。");
                $("#uname").focus();
                setLoginStatus(false);
                return;
            }
            else {
                $("#message").text("");
            }
            setCookie();    // 设置Cookie
            $("form").ajaxSubmit({
                data: { 'reqaction': 'login', 'asyncreq': true }, success: function(resp) { 
                    setLoginStatus(false);
                    if (resp) {

                        if (resp.indexOf("success") == 0) {
                            var redurl = resp.substr("success".length + 1);
                            if (window.parent && window.parent != window)
                                window.location.href = redurl;
                            else {
                                newWin = window.open(redurl, "OnControl_" + Math.round(Math.random() * 1000), "height=" + (window.screen.availHeight - 60) + ", width=" + (window.screen.availWidth - 14) + ", top=0, left=0, menubar=0, location=0, resizable=1, status=1");
                                window.setTimeout("DestroySelf('" + redurl + "')", 500);
                            }
                        }
                        else {
                            if (resp == "请先设置密码再登陆！") {
                                alert(resp);
                                OpenWin("/Modules/SysApp/OrgMag/UsrChgPwd.aspx", "_blank", CenterWin("width=350,height=180,scrollbars=yes"));
                            }
                            else {
                                $("#message").html("提示：" + resp);
                            }
                        }
                    }
                }
            });
        }

        function OpenPwdChgPage() {
            rtn = OpenWin("/Modules/SysApp/OrgMag/UsrChgPwd.aspx", "_blank", CenterWin("width=350,height=180,scrollbars=yes"));
        }

        function setLoginStatus(flag) {
            if (flag) {
                islogining = true;
                $("input").attr("disabled", true);
                $("#imgDoLogin").attr("disabled", true);
                $("#span-loading").css("display", ""); // 显示进度条
            }
            else {
                islogining = false;
                $("input").attr("disabled", false);
                $("#imgDoLogin").attr("disabled", false);
                $("#span-loading").css("display", "none"); // 隐藏进度条
            }
        }

        function setCookie() {
            var isSaveAccount = $("#saveAcount").attr("checked");
            var isSavePassword = $("#savePassword").attr("checked");

            if (isSaveAccount) {
                SetCookie("uname", $("#uname").val());
                SetCookie("saveAcount", isSaveAccount);
            } else {
                SetCookie("uname", null, { expires: 300 });
                SetCookie("saveAcount", null, { expires: 300 });
            }

            if (isSavePassword) {
                SetCookie("pwd", $("#pwd").val());
                SetCookie("savePassword", isSavePassword);
            } else {
                SetCookie("pwd", null, { expires: 300 });
                SetCookie("savePassword", null, { expires: 300 });
            }
        }

        function getCookie() {
            var isSaveAccount = GetCookie("saveAcount");
            var isSavePassword = GetCookie("savePassword");
            if (isSaveAccount && isSaveAccount != "null") {
                $("#saveAcount").attr("checked", true);
                $("#uname").val(GetCookie("uname"));
            }

            if (isSavePassword && isSavePassword != "null") {
                $("#savePassword").attr("checked", true);
                $("#pwd").val(GetCookie("pwd"));
            }
        }
        function SetCookie(sName, sValue) {
            date = new Date();
            document.cookie = sName + "=" + escape(sValue) + "; expires=Fri, 31 Dec 2099 23:59:59 GMT;";
        }

        function GetCookie(sName) {
            // cookies are separated by semicolons

            var aCookie = document.cookie.split("; ");
            for (var i = 0; i < aCookie.length; i++) {
                // a name/value pair (a crumb) is separated by an equal sign 13818920945
                var aCrumb = aCookie[i].split("=");
                if (sName == aCrumb[0]) {
                    if (aCrumb[1])
                        return unescape(aCrumb[1]);
                    else
                        return "";
                }
            }

            // a cookie with the requested name does not exist
            return "";
        }
        function DestroySelf(redurl) {
            if (newWin) {
                window.opener = null;
                window.open("", "_self");   //fix ie7 
                window.close();
            }
            else {
                alert("窗口被阻止弹出,请点击浏览器上方的提示选择总是允许本系统弹出窗口,或者将本系统加入到本地站点里");
            }
        }
    </script>

</head>
<body onload="onPgLoad()">
    <form method="post">
    <div id="header">
        <div id="head">
            <div class="logo">
                <a href="" target="_blank">
                    <img src="Login_Theme/img/sysname.jpg" alt="北京矿研" style="border: 0pt none;" border="0"></a>
            </div>
        </div>
    </div>
    <!--头部end-->
    <div class="clear">
    </div>
    <!-- 主体 begin -->
    <div id="wrap">
        <div class="banner">
        </div>
        <div id="login-info">
            <div class="login_top">
            </div>
            <div class="login_middle">
                <div id="J_LoginBox" class="login-box simple no-longlogin no-dynamic  no-reg module-static">
                    <div class="bd">
                        <div id="J_Static" class="static safe_login">
                            <div class="field">
                                <label for="TPL_username_1">
                                    账户名</label>
                                <span class="ph-label"></span>
                                <input id="uname" class="login-text J_UserName" value="admin" maxlength="32">
                            </div>
                            <div class="field">
                                <label id="password-label">
                                    密 码</label>
                                <span id="J_StandardPwd">
                                    <input id="pwd" class="login-text" maxlength="10000" type="password" />
                                </span>
                            </div>
                            <div class="field hidden" id="l_f_code">
                            </div>
                            <div class="safe">
                                <input type="checkbox" name="saveAcountName" id="saveAcount" value="true" />
                                <label for="checkbox">
                                    保存帐号</label>
                                <input type="checkbox" name="savePassword" id="savePassword" value="true" />
                                <label for="checkbox">
                                    保存密码</label>
                                <div id="span-loading" style="display: none; text-align: left;">
                                    <img style="margin-left: 40px;" src="Login_Theme/img/loading.gif" />
                                </div>
                            </div>
                            <div class="submit">
                                <button class="J_Submit" tabindex="5" type="button" onclick="DoLogin();">
                                    登录</button>
                                <a href="#" id="forget-pw-safe" class="forget-pw" tabindex="6" onclick="OpenPwdChgPage()">
                                    修改密码</a>
                            </div>
                            <ul class="entries">
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="form_text">
                    <div id="form_text2">
                        <div id="message" class="lbl-message">
                        </div>
                        <div id="login_table_notice">
                            忘记密码请联系管理员
                        </div>
                    </div>
                </div>
            </div>
            <div class="login_bottom">
            </div>
        </div>
        <div class="login_img1">
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="foot">
        <div id="footer" style="width: 98%">
            <div style="text-align: center; width: 100%">
                北京矿冶研究总院综合管理信息系统
            </div>
        </div>
    </div>
    </form>
</body>
</html>
