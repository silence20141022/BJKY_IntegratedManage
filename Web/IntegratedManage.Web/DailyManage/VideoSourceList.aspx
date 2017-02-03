<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="VideoSourceList.aspx.cs" Inherits="IntegratedManage.Web.DailyManage.VideoSourceList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
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
        .thumb-separater
        {
            width: 30%;
            float: left;
            padding: 5px;
            margin: '5 5 5 5';
            vertical-align: middle;
            text-align: center;
            border: 1px solid gray;
        }
        .radioItem
        {
            width: 150px;
            height: 180px;
            border: 1px solid #6c9249;
            text-align: center;
            display: inline-block;
            display: inline;
            margin-left: 40px;
            margin-top: 20px;
        }
        .radioItem img
        {
            height: 80%;
            width: 100%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 1px;
        }
    </style>

    <script type="text/javascript">
        var type = "";     //视频类型
        var store, dataview;
        var typeEunm = { "文化娱乐": "文化娱乐", "教育学习": "教育学习", "政策法规": "政策法规" };
        function onPgLoad() {
            setPgUI()
        }

        function reSetBtnStyle() {
            /*修改按钮样式*/
            $("td[class='x-toolbar-left']").css({ height: 20 });
            $("td[class='x-btn-tl'],td[class='x-btn-tc'],td[class='x-btn-tr']").remove();
            $("td[class='x-btn-br'],td[class='x-btn-bc'],td[class='x-btn-bl']").remove();
            $("td[class='x-btn-mr'],td[class='x-btn-ml']").remove();
        }
        function setPgUI() {

            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            // 图片文件名: VedioFile + _thumb.jpg
            //            for (var i = 0; i < myData.records.length; i++) {
            //                myData.records[i]["VedioFile"] = myData.records[i]["VedioFile"] ? ("/Document/" + myData.records[i]["VedioFile"] + '_thumb.jpg') : '';
            //            }

            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'Theme' },
			{ name: 'VedioType' },
			{ name: 'VedioFile' },
			{ name: 'ViewCounter' },
			{ name: 'Remark' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
		    { name: 'CreateTime' }
			],
                listeners: {
                    aimbeforeload: function(proxy, options) {
                        options.data.VedioType = type;
                    }
                }
            });

            schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: true,
                items: [
                    { fieldLabel: '视频名称', id: 'Theme', schopts: { qryopts: "{ mode: 'Like', field: 'Theme' }"} },
                    { fieldLabel: '视频类型', id: 'VedioType', xtype: 'aimcombo', required: true, enumdata: typeEunm, schopts: { qryopts: "{ mode: 'Like', field: 'VedioType' }" }, listeners: { "collapse": function(e) { Ext.ux.AimDoSearch(Ext.getCmp("VedioType")); } } },
                    { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function() {
                        Ext.ux.AimDoSearch(Ext.getCmp("Theme"));   //Number 为任意
                    }
                    }
                ]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    id: 'btn_all',
                    text: '全部',
                    iconCls: 'aim-icon-swf',
                    enableToggle: true,
                    pressed: true,
                    handler: function() {
                        Ext.getCmp("btn_jx").toggle(false);
                        Ext.getCmp("btn_wy").toggle(false);
                        Ext.getCmp("btn_zf").toggle(false);
                        type = "";
                        store.reload();
                    }
                }, {
                    id: 'btn_wy',
                    text: '文化娱乐',
                    iconCls: 'aim-icon-swf',
                    enableToggle: true,
                    handler: function() {
                        Ext.getCmp("btn_all").toggle(false);
                        Ext.getCmp("btn_jx").toggle(false);
                        Ext.getCmp("btn_zf").toggle(false);
                        type = "文化娱乐";
                        store.reload();
                    }
                }, {
                    id: 'btn_jx',
                    text: '教育学习',
                    iconCls: 'aim-icon-swf',
                    enableToggle: true,
                    handler: function() {
                        Ext.getCmp("btn_all").toggle(false);
                        Ext.getCmp("btn_wy").toggle(false);
                        Ext.getCmp("btn_zf").toggle(false);
                        type = "教育学习";
                        store.reload();
                    }
                },
                {
                    id: 'btn_zf',
                    text: '政策法规',
                    enableToggle: true,
                    iconCls: 'aim-icon-swf',
                    handler: function() {
                        Ext.getCmp("btn_all").toggle(false);
                        Ext.getCmp("btn_jx").toggle(false);
                        Ext.getCmp("btn_wy").toggle(false);
                        type = "政策法规";
                        store.reload();
                    }
                }, '->',
                {
                    text: '复杂查询',
                    iconCls: 'aim-icon-search',
                    handler: function() {
                        schBar.toggleCollapse(false);
                        setTimeout("viewport.doLayout()", 50);
                    }
}]
                });

                titPanel = new Ext.ux.AimPanel({
                    tbar: tlBar,
                    items: [schBar]
                });


                tpl = new Ext.XTemplate(
                '<tpl for=".">',
                '<div onclick="openWin(\'{VedioFile}\')" class="radioItem"><img src="/Document/{VedioFile}_thumb.jpg" alt="" /><span style="font-size:13;margin-top:8px; display:block;">{Theme}</span></div>',
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
                    //overClass: 'x-view-over',
                    selectedClass: 'x-view-selected',
                    itemSelector: 'div.thumb-separater'

                });

                //            dataview.on('click', function(obj, index, node, e) {
                //                AimDlg.show("hello");
                //            });

                panel = new Ext.ux.AimPanel({
                    title: '视频列表',
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

            function openWin(val) {
                $.ajaxExecSync("GetFileName", { Id: val }, function(rtn) {
                    var FileUrl = val + "_" + rtn.data.Name;
                    var task = new Ext.util.DelayedTask();
                    task.delay(50, function() {
                        opencenterwin("FilePlay.aspx" + "?op=r&FileUrl=" + FileUrl, "", 1000, 650);
                    });
                });

            }


            function opencenterwin(url, name, iWidth, iHeight) {
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
            }
            
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
