<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SubPortalTree.aspx.cs" Inherits="IntegratedManage.Web.SubPortalTree" %>

<%@ OutputCache Duration="1" VaryByParam="None" %>
<%@ Import Namespace="Aim" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .x-tree-node-expanded .iconCls
        {
            display: none !important;
        }
        .x-tree-node-collapsed .iconCls
        {
            display: none !important;
        }
        .iconnone
        {
            display: none !important;
        }
        .x-tree-node .x-tree-selected
        {
            background-color: #FBDF92;
        }
        .x-tree-node-icon
        {
            background-image: url("/Modules/WebPart/close.gif") !important;
        }
        .x-tree-node
        {
            padding-top: 5px;
        }
        /*.x-tree-no-lines .x-tree-elbow-plus
        {
            background-image: url(/Modules/WebPart/close.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-minus
        {
            background-image: url(/Modules/WebPart/open.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-end-plus
        {
            background-image: url(/Modules/WebPart/close.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-end-minus
        {
            background-image: url(/Modules/WebPart/open.gif);
            margin: 8 0 0 3;
        }*/.x-tree-node-leaf
        {
            margin-left: -12px;
        }
    </style>
    <%--<style type="text/css">
        .x-tree-node-expanded .iconCls
        {
            display: none !important;
        }
        .x-tree-node-collapsed .iconCls
        {
            display: none !important;
        }
        .iconnone
        {
            display: none !important;
        }
        .x-tree-node .x-tree-selected
        {
            background-color: #FBDF92;
        }
        .x-tree-no-lines .x-tree-elbow-plus
        {
            background-image: url(/Modules/WebPart/close.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-minus
        {
            background-image: url(/Modules/WebPart/open.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-end-plus
        {
            background-image: url(/Modules/WebPart/close.gif);
            margin: 8 0 0 3;
        }
        .x-tree-no-lines .x-tree-elbow-end-minus
        {
            background-image: url(/Modules/WebPart/open.gif);
            margin: 8 0 0 3;
        }
        .x-tree-node-leaf .x-tree-node-icon
        {
            background-image: url(/Modules/WebPart/con_p_icon.gif);
        }
        .x-tree-node-leaf
        {
            margin-left: -12px;
        }
    </style>--%>

    <script src="/js/ext/ux/TreeGrid.js" type="text/javascript"></script>

    <script type="text/javascript">
        var Role = $.getQueryString({ "ID": "Role" });
        var StatusEnum = { 1: "启用", 0: "停用" };
        var deny = $.getQueryString({ "ID": "Deny" });
        var rootid = $.getQueryString({ "ID": "id" });

        var viewport;
        var treeLoader, rootNode;
        var authData, authList;
        var optype;

        function onPgLoad() {
            optype = $.getQueryString({ ID: "type" });

            setPgUI();
        }

        function setPgUI() {
            authData = adjustData(AimState["DtList"]);
            authList = AimState["AtList"] || [];

            /*treeLoader = new Ext.tree.TreeLoader({
            baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI }
            });*/

            // 工具栏
            var tlBar = new Ext.Toolbar({
                items: [{
                    text: '保存',
                    iconCls: 'aim-icon-save',
                    handler: function() {
                        saveChanges();
                    }
                }, '-'/*, {
                text: '展开',
                iconCls: 'aim-icon-refresh',
                menu: [{ text: '展开下一层', handler: function() { authStore.expandAll(); } }] }*/]
            });

            // 工具标题栏
            var titPanel = new Ext.Panel({
                /*tbar: tlBar,*/
                items: [{ hidden: true}]
            });

            var tree = new Ext.tree.TreePanel({
                id: 'tree',
                region: 'west',
                iconCls: 'iconCls',
                expanded: true,
                border: true,
                tbar: titPanel,
                width: 180,
                resizable: true,
                collapsible: true,
                collapsed: authData.length == 0 ? true : false,
                height: 250,
                autoScroll: true, split: true,
                animate: false,
                hlColor: 'yellow',
                containerScroll: true,
                lines: false, //节点之间连接的横竖线
                rootVisible: false, //是否显示根节点
                loader: treeLoader
            });

            tree.on('beforeload', function(node) {
                tree.loader.dataUrl = 'SubPortalTree.aspx?asyncreq=true&reqaction=querydescendant&id=' + node.attributes.ID;
            });

            tree.on('load', function(node) {
                $.each(node.childNodes, function(i) {
                    //this.iconCls = "";
                });
            });
            tree.on('click', function(node) {
                if (!node.isLeaf()) {//不是叶子节点
                    node.singleClickExpand = true; //提供单击属性
                    if (node.isExpanded()) {    //节点是展开的情况
                        //node.collapse(true); //闭合该节点
                    } else {
                        node.expand(node); //展开该节点
                    }
                }
                var url = "about:blank";
                if (node.attributes.Url && node.attributes.Url != "") {
                    url = node.attributes.Url;
                }
                if (url.toLowerCase().indexOf("http:")>=0)
                    url+=url.indexOf("?") >= 0?"&PassCode=<%=Session["PassCode"] %>":"?PassCode=<%=Session["PassCode"] %>";
                if(url!="about:blank")
                    url = $.combineQueryUrl(url, "SSOID=<%=this.UserSID %>");
                subFrameContent.location.href = url;
            });

            rootNode = new Ext.tree.AsyncTreeNode({
                draggable: false,
                id: "0",
                expanded: true,
                children: authData
            });

            tree.setRootNode(rootNode);

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [
                authData.length == 0 ? { region: 'west', html: ''} : tree, {
                    region: 'center',
                    border: false,
                    margins: '0 0 0 0',
                    cls: 'empty',
                    bodyStyle: 'background:#f1f1f1',
                    html: '<iframe width="100%" height="100%" id="subFrameContent" name="subFrameContent" frameborder="0" src=""></iframe>'
}]
                });
                rootNode.expand();
            }

            // 应用或模块数据适配
            function adjustData(jdata) {
                if ($.isArray(jdata)) {
                    $.each(jdata, function() {
                        this.ID = this.ModuleID;
                        this.ParentID = this.ParentID ? "0" : this.ParentID;
                        this.text = this.Name;
                        this.Url = this.Url;
                        this.leaf = this.IsLeaf;
                        if (!this.leaf) {
                            this.iconCls = 'iconnone';
                        }
                    });

                    return jdata;
                } else {
                    return [];
                }
            }

            // 获取树下所有节点
            function getAllNodes(rnode, cnodes) {
                cnodes = cnodes || [];
                var nodes = rnode.childNodes || [];
                $.merge(cnodes, nodes);

                for (var i = 0; i < nodes.length; i++) {
                    var node = nodes[i];

                    if (node.childNodes.length > 0) {
                        getAllNodes(node, cnodes);
                    }
                }

                return cnodes;
            }

            function saveChanges() {
                var allNodes = getAllNodes(rootNode);
                var authAdded = []; // 所有新赋的权限
                var authRemoved = [];  // 所有移除的权限

                $.each(allNodes, function() {
                    var node = this;
                    var cAuthID = node.attributes.AuthID;

                    if (cAuthID && cAuthID != "") {
                        if (node.attributes.checked) {
                            if ($.inArray(cAuthID, authList) < 0) {
                                authAdded.push(cAuthID);
                            }
                        } else {
                            if ($.inArray(cAuthID, authList) >= 0) {
                                authRemoved.push(cAuthID);
                            }
                        }
                    }
                });

                GetAjaxData(null, "savechanges", { type: optype, added: authAdded, removed: authRemoved, id: AimState["EntityID"], Deny: deny }, function() { AimDlg.show("保存成功！") });
            }

    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
