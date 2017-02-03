<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyLink.aspx.cs" Inherits="IntegratedManage.Web.MyLink" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title></title>
    <style type="text/css">
        .link
        {
            height: 182px;
            width: 28%;
        }
        .link-lsize
        {
            font-family: '方正大黑简体';
            font-size: 17px;
            color: #636363;
            font-weight: 500;
            margin-left: 10px;
            float: left;
            line-height: 28px;
        }
        .link-big-div
        {
            width: 100%;
        }
        .link-size
        {
            font-family: '微软雅黑';
            font-size: 17px;
            margin: 0 auto;
            margin-left: 20px;
            width: 100%;
        }
        .link-more-div
        {
            height: 33px;
            margin: 0 auto;
            margin-left: 20px;
        }
        .link-more
        {
            color: #ffb10c;
            font-family: '方正大黑简体';
            font-size: 18px;
            width: 80px;
            float: left;
            line-height: 38px;
        }
        .link-arrow
        {
            width: 33px;
            height: 29px;
            margin-left: 5px;
            float: left;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="link">
        <div class="link-size">
            财务报销系统<br />
            国务院国有资产监督管理委员会<br />
            科技部<br />
            财务部<br />
        </div>
        <div class="link-more-div">
            <div class="link-more">
                添加更多
            </div>
            <div class="link-arrow">
                <img src="images/center/nrrow.png" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
