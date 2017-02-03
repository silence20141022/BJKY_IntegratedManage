<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyPlatform.aspx.cs" Inherits="IntegratedManage.Web.MyPlatform" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .ideas
        {
            width: 28%;
        }
        .ideas-head
        {
            height: 182px;
            width: 97%;
        }
        .ideas-hd
        {
            width: 100%;
        }
        .ideas-img
        {
            width: 25px;
            height: 20px;
            float: left;
        }
        .ideas-size
        {
            font-family: '方正大黑简体';
            font-size: 17px;
            color: #636363;
            font-weight: 500;
            margin-left: 6px;
            float: left;
            line-height: 28px;
        }
        .ideas-picture
        {
            width: 150px;
            height: 120px;
            margin: 0 auto;
        }
        .ideas-dhelp
        {
            height: 33px;
            float: right;
            margin-top: 20px;
        }
        .ideas-help-size
        {
            color: #ffb10c;
            font-family: '方正大黑简体';
            font-size: 18px;
            float: left;
            line-height: 33px;
        }
        .ideas-nrrow
        {
            width: 33px;
            height: 29px;
            float: left;
            margin-left: 8px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="ideas">
        <div class="ideas-head">
            <div class="ideas-hd">
                <div class="ideas-img">
                    <img alt="" src="images/center/ideabox-login.png" />
                </div>
                <div class="ideas-size">
                    意见箱
                </div>
            </div>
            <div class="ideas-picture">
                <img alt="" src="images/center/ideabox-picture.png" />
            </div>
            <div class="ideas-dhelp">
                <div class="ideas-help-size">
                    常见问题及帮助
                </div>
                <div class="ideas-nrrow">
                    <img src="images/center/nrrow.png" />
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
