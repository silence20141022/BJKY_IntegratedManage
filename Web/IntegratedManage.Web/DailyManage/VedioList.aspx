<%@ Page Title="视频管理" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="VedioList.aspx.cs" Inherits="IntegratedManage.Web.DailyManage.VedioList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
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
        .x-view-selected
        {
            -moz-background-clip: border;
            -moz-background-inline-policy: continuous;
            -moz-background-origin: padding;
            background-color: #FFC0CB;
        }
        .radioItem
        {
            width: 150px;
            height: 180px;
            border: 1px solid #6c9249;
            text-align: center;
            display: inline-block;
            display: inline;
            margin-left: 30px;
            margin-top: 20px;
        }
        .radioItem img
        {
            height: 80%;
            width: 100%;
            margin-left: auto;
            margin-right: auto;
        }
        .desc
        {
            font-size: 13;
            text-align: left;
            vertical-align: middle;
        }
        .desc .play
        {
            height: 20;
            width: 20;
            display: inline-block;
            display: inline;
            margin-left: 5px;
        }
        .desc .font
        {
            display: inline-block;
            display: inline;
            vertical-align: top;
            padding-bottom: 2px;
        }
        .caption
        {
            width: 25%;
            font-size: 12px;
            font-weight: bold;
            padding-left: 2px;
        }
        .vedio-data
        {
            padding-left: 5px;
            width: 32%;
        }
    </style>

    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, dataview, tip, viewport;
        var authState;

        var EditWinStyle = "width=650,height=600,scrollbars==0";
        function onPgLoad() {
            authState = AimState["authState"] || '';
            setPgUI();
            $(".radioItem").each(function() {
                var tpl = '';
                $.ajaxExecSync("getTip", { id: $(this).attr("id").substring(5) || '' }, function(rtn) {
                    var obj = rtn.data.VedioEnt[0] || {};
                    var tbl = '<table style="height: 140; width: 280px; border: 1 solid #808080; font-size: 12px;">';
                    var tr1 = '<tr><td class="caption">视频名称</td><td class="vedio-data"  colspan="3">{Theme}</td> </tr>';
                    var tr2 = '<tr><td class="caption">视频类型</td><td class="vedio-data">{VedioType}</td> <td class="caption"> 点播次数 </td> <td class="vedio-data"> {PlayTimes}次 </td</tr>';
                    var tr3 = ' <tr> <td class="caption"> &nbsp;上&nbsp;传&nbsp;人&nbsp; </td> <td class="vedio-data"> {CreateName} </td> <td class="caption"> 上传时间 </td> <td class="vedio-data">{CreateTime} </td></tr>';
                    var tr4 = '<tr><td colspan="4" valign="middle;" style="height: 70px;"><div style="margin: 0 0 0 0;"> <div style="border: 1 solid #000000; height: 66px; margin: 5 5 5 5; vertical-align: middle; text-indent: 12px; padding-top: 5px">{Remark}</div></div></td></tr>';
                    var tbl_end = "<table>";
                    tpl = tbl + tr1 + tr2 + tr3 + tr4 + tbl_end;
                    tpl = tpl.replaceAll('{Theme}', obj.Theme || '');
                    tpl = tpl.replaceAll('{VedioType}', obj.VedioType || '');
                    tpl = tpl.replaceAll('{PlayTimes}', obj.PlayTimes || '0');
                    tpl = tpl.replaceAll('{CreateName}', obj.CreateName || '');
                    tpl = tpl.replaceAll('{CreateTime}', obj.CreateTime.split(' ')[0] || '');
                    tpl = tpl.replaceAll('{Remark}', obj.Remark.toString().length > 80 ? (obj.Remark.toString().substring(0, 80) + "...") : obj.Remark);

                })

                tip = new Ext.ToolTip({
                    target: $(this).attr("id"),
                    html: tpl,
                    title: '视频信息',
                    autoHide: true,
                    draggable: true
                });
            });
        }
        function setPgUI() {

            AimState["VedioType"]["全部"] = "全部视频";
            //AimState["VedioType"].unshift({ "全部": "全部视频" });

            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			    { name: 'Id' }, { name: 'Theme' }, { name: 'DeptId' }, { name: 'DeptName' }, { name: 'VedioType' }, { name: 'VedioFile' },

			    { name: 'ImageFile' }, { name: 'CreateId' }, { name: 'CreateName' }, { name: 'CreateTime' }, { name: 'Name' }, { name: 'PlayTimes' }
			],
                listeners: { aimbeforeload: function(proxy, options) {
                    options.data = options.data || {};
                    //options.data.cid = cid;
                }
                }
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 5,
                items: [
                 { fieldLabel: '视频类型', id: 'VedioType', xtype: 'aimcombo', required: true, enumdata: AimState["VedioType"], schopts: { qryopts: "{ mode: 'Like', field: 'VedioType' }" }, listeners: { "collapse": function(e) { Ext.ux.AimDoSearch(Ext.getCmp("VedioType")); } } },
                    { fieldLabel: '视频名称', id: 'Theme', schopts: { qryopts: "{ mode: 'Like', field: 'Theme' }"} },

                    { fieldLabel: '开始时间', id: 'StartTime', xtype: 'datefield', format: 'Y-m-d', vtype: 'daterange', endDateField: 'EndTime', schopts: { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }"} },
                    { fieldLabel: '结束时间', id: 'EndTime', xtype: 'datefield', format: 'Y-m-d', vtype: 'daterange', startDateField: 'StartTime', schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }"} },
                    { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                        Ext.ux.AimDoSearch(Ext.getCmp("VedioType"));   //Number 为任意
                    }
                    }
                ]
            });
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        opencenterwin("VedioEdit.aspx?op=c", "", 700, 360);
                    }
                }, '-', {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = dataview.getSelectedRecords();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        }
                        opencenterwin("VedioEdit.aspx?op=u&id=" + recs[0].get("Id"), "", 700, 360);
                    }
                }, '-', {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = dataview.getSelectedRecords();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
                        if (confirm("确定删除所选记录？")) {
                            $.ajaxExec("delete", { id: recs[0].get("Id") }, function() {
                                store.remove(recs[0]);
                            });
                        }
                    }
                }
                ]
            });

            titPanel = new Ext.ux.AimPanel({
                tbar: authState ? tlBar : '',
                items: [schBar]
            });


            tpl = new Ext.XTemplate(
                '<tpl for=".">',
                '<div id="item-{Id}" class="radioItem"><img src="/Document/{VedioFile}_thumb.jpg" alt="" /><span style="font-size:13;margin-top:8px; display:block;"><b>{Theme}</b></span>',
               '<div class="desc"><div class="font"><span>&nbsp;&nbsp;点播次数:</span><span>[{PlayTimes}]</span>&nbsp;&nbsp;',
               '<span><a href="#" onclick="openEidtWin(\'{Id}\')">详细</a></span></div><img onclick="openPalyerWin(\'{VedioFile}\',\'{Name}\')" src="/images/shared/Player.png" alt="" class="play" ></div></div>',
               '</tpl>'
           );
            dataview = new Ext.DataView({
                id: 'my-data-view',
                store: store,
                tpl: tpl,
                region: 'center',
                autoScroll: true,
                autoHeight: true,
                singleSelect: true,
                multiSelect: false,
                simpleSelect: true,
                overClass: 'x-view-over',
                selectedClass: 'x-view-selected',
                itemSelector: 'div.radioItem'

            });

            panel = new Ext.ux.AimPanel({
                region: 'center',
                tbar: titPanel,
                bbar: pgBar,
                border: false,
                autoScroll: true,
                items: [dataview]
            });

            viewport = new Ext.ux.AimViewport({
                items: [panel]
            });
        }


        function openPalyerWin(val, name) {
            var FileUrl = val + "_" + name;
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin("FilePlay.aspx" + "?op=r&FileUrl=" + FileUrl, "", 1000, 650);
            });

        }

        function openEidtWin(Id) {
            /*点击查看*/
            var url = "VedioEdit.aspx?op=r";
            var task = new Ext.util.DelayedTask();
            task.delay(50, function() {
                opencenterwin(url + "&id=" + Id, "", 700, 360);
            });
        }

        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
            window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=0,resizable=yes');
        }

        function onExecuted() {
            store.reload();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
