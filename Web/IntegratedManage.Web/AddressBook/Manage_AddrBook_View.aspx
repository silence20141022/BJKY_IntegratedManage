<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="Manage_AddrBook_View.aspx.cs" Inherits="IntegratedManage.Web.AddressBook.Manage_AddrBook_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var DeptId = "";
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            function SetCatalog(rec) {
                if (rec) {
                    DeptId = id;
                    var viewurl = "Manage_AddrBookList.aspx?DeptId=" + rec.get("GroupID") + "&DptName=" + escape(rec.get("Name"));
                    usrViewFrame.location.href = viewurl;
                }
            }
            window.SetCatalog = SetCatalog;

            combo = new Ext.ux.form.AimComboBox({
                id: 'subRoleCombo',
                anchor: '95%',
                enumdata: { '列表视图': '列表视图', "卡片视图": "卡片视图" },
                labelStyle: 'font-weight:bold',
                lazyRender: false,
                allowBlank: false,
                autoLoad: true,
                forceSelection: true,
                blankText: "请选择",
                triggerAction: 'all',
                mode: 'local',
                listeners: {
                    blur: function(obj) {
                        if (obj.value == "列表视图") {
                            window.location.href = "Manage_AddrBookList.aspx?DeptId=" + DeptId;
                        }
                    }
                }
            });
            panel = new Ext.ux.AimPanel({
                title: '参与考核部门',
                region: 'noth',
                border: false,
                autoScroll: true,
                items: [combo]
            });
            // 页面视图
            viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [
                        {
                            region: 'west',
                            id: 'west-panel', // see Ext.getCmp() below
                            title: '公司部门',
                            split: true,
                            width: 250,
                            minSize: 175,
                            maxSize: 400,
                            bodyStyle: 'background:#f1f1f1',
                            collapsible: true,
                            margins: '0 0 0 5',
                            html: '<iframe width="100%" height="100%" id="usrCatalogFrame" name="frameContent" frameborder="0" src="Manage_AddrBookTree.aspx "></iframe>'
                        },
                      {
                          region: 'center',
                          id: 'center-panel',
                          margins: '0 0 0 5',
                          split: false,
                          margins: '0 0 0 0',
                          cls: 'empty',
                          bodyStyle: 'background:#f1f1f1',
                          html: '<iframe width="100%" height="100%" id="usrViewFrame" name="frameContent" frameborder="0" src="Manage_AddrBookList.aspx"></iframe>'
                      }
            ]
            });
        }
    
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
