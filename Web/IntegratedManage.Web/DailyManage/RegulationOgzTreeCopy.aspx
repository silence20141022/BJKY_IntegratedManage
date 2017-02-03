<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="RegulationOgzTreeCopy.aspx.cs" Inherits="IntegratedManage.Web.RegulationOgzTreeCopy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="/App_Themes/Ext/ux/TreeGrid/TreeGrid.css" rel="stylesheet" type="text/css" />

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script src="/js/ext/ux/FieldLabeler.js" type="text/javascript"></script>

    <script src="/js/pgfunc-ext-adv.js" type="text/javascript"></script>

    <style type="text/css">
        .x-form-cb-label
        {
            top: 0px !important;
        }
    </style>

    <script type="text/javascript">
        var DataRecord, store;
        var viewport, grid;

        var type = $.getQueryString({ ID: 'type' });
        var ruleid = $.getQueryString({ ID: 'id' });
        var curRec;
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            var data = AimState["DtList"];

            DataRecord = Ext.data.Record.create([
        { name: 'GroupID', type: 'string' },
        { name: 'ParentID', type: 'string' },
        { name: 'IsLeaf', type: 'bool', mapping: 'IsLeafHK' },
        { name: 'Name' },
        { name: 'Code' },
        { name: 'Type' },
        { name: 'Status' },
        { name: 'Description' },
        { name: 'CreateDate' }
            ]);

            store = new Ext.ux.data.AimAdjacencyListStore({
                data: data,
                aimbeforeload: function (proxy, options) {
                    var rec = store.getById(options.anode);
                    options.reqaction = "querychildren";

                    if (rec) {
                        options.data.id = rec.id;
                    }
                },
                reader: new Ext.ux.data.AimJsonReader({ id: 'GroupID', dsname: 'DtList' }, DataRecord)
            });


            // 工具栏
            var tlBar = new Ext.ux.AimToolbar({
                items: [
                {
                    text: '展开',
                    handler: function () {
                        store.expandAll();
                    }
                }]
            });

            // 表格面板
            grid = new Ext.ux.grid.AimEditorTreeGridPanel({
                store: store,
                master_column_id: 'Name',
                region: 'center',
                split: true,
                width: 300,
                viewConfig: { scrollOffset: 2 },
                minSize: 250,
                maxSize: 500,
                autoExpandColumn: 'Name',
                columns: [
                        { id: 'Name', header: "组织结构", renderer: colRender, width: 110, sortable: true, dataIndex: 'Name' },
                        { header: "编号", width: 70, sortable: true, dataIndex: 'Code', hidden: true }]
                //sm: sm,
                //tbar: tlBar
            });

            function colRender(val, p, rec) {
                var rtn = val;
                var type = rec.get('Type');

                switch (type) {
                    case 3:
                        rtn = '<span valign="bottom"><img src="/images/shared/user_red.png">' + val + '</span>';
                        break;
                    case 2:
                        rtn = '<span valign="bottom"><img src="/images/shared/preview2.png">' + val + '</span>';
                        break;
                }

                return rtn;
            }




            grid.getSelectionModel().on('rowselect', function (sm, rowIdx, r) {
                var rec = grid.store.getAt(rowIdx);
                curRec = rec;
                //                    if (typeof (parent.SetCatalog) == 'function') {
                //                        parent.SetCatalog.call(this, rec);
                //                    }
                //document.getElementById("frameContent").src = "RegulationList.aspx?pid=" + rec.get("GroupID") + "&pname=" + rec.get("Name");

            });

            var optpanel = new Ext.Panel({
                title: type == "copy" ? '复制规章制度' : '移动规章制度',
                region: 'north',
                layout: 'column',
                height: 50,
                frame: true,
                items: [{
                    xtype: 'label',
                    text: type == "copy" ? '同时复制:' : '同时移动:'
                }, {
                    id: 'chk_adminauth',
                    xtype: 'checkbox',
                    boxLabel: '管理权限',
                    style: { marginTop: '0px', marginLeft: "10px" }
                }, {
                    id: 'chk_browseauth',
                    xtype: 'checkbox',
                    boxLabel: '浏览权限',
                    style: { marginTop: '0px', marginLeft: "10px" }

                }]

            });
            var buttonPanel = new Ext.form.FormPanel({
                region: 'south',
                frame: true,
                buttonAlign: 'center',
                buttons: [
            {
                text: '确定', hidden: pgOperation == "r", handler: function () {
                    //                        var recs = store.getRange();
                    //                        var dt = store.getModifiedDataStringArr(recs) || [];
                    if (!curRec) {
                        AimDlg.show("请选择一个部门!");
                        return;
                    }
                    var carry_admin = Ext.getCmp("chk_adminauth").getValue() ? "y" : 'n';
                    var carry_browse = Ext.getCmp("chk_browseauth").getValue() ? "y" : 'n';

                    $.ajaxExec("submitopt", { did: curRec.get("GroupID"), ruleid: ruleid, type: type, carryadmin: carry_admin, carrybrowse: carry_browse }, function (rtn) {
                        Ext.MessageBox.show({
                            title: '确认',
                            msg: type == "copy" ? '复制成功' : '移动成功',
                            buttons: Ext.MessageBox.OK,
                            buttonText: { ok: '确认' },
                            minWidth: 100,
                            fn: function (btn, text) {
                                if (btn == 'ok') {
                                    RefreshClose();
                                    //window.close();
                                }
                            }
                        });
                    });
                }
            },
             {
                 text: '关闭', handler: function () {
                     window.close();
                 }
             }]
            });
            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [optpanel, grid, buttonPanel]
            });

        }
        // 应用或模块数据适配
        function adjustData(jdata) {
            if ($.isArray(jdata)) {
                $.each(jdata, function () {
                    if (this.GroupID) {
                        this.ID = this.GroupID;
                        this.ParentID = $.isSetted(this.ParentID) ? this.ParentID : this.Type;
                    } else if (this.GroupTypeID) {
                        this.ID = this.GroupTypeID;
                        this.Type = "GType";
                        this.ParentID = null;
                        this.IsLeaf = $.isSetted(this.HasGroup) ? !this.HasGroup : false;
                    }
                });

                return jdata;
            } else {
                return [];
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
