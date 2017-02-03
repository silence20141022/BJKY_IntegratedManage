using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Common;
using Aim.Portal;
using Aim.Portal.Web;
using Aim.Portal.Model;
using Aim.Portal.Web.UI;
using System.Collections;
using NHibernate.Criterion;
using Aim;
namespace IntegratedManage.Web
{
    public partial class SubPortalTree : BasePage
    {
        string op = String.Empty;
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 查询类型

        protected void Page_Load(object sender, EventArgs e)
        {
            id = (RequestData.ContainsKey("id") ? RequestData["id"].ToString() : String.Empty);
            type = (RequestData.ContainsKey("type") ? RequestData["type"].ToString() : String.Empty).ToLower();

            if (this.IsAsyncRequest)
            {
                switch (this.RequestAction)
                {
                    case RequestActionEnum.Custom:
                        if (RequestActionString == "querychildren" || RequestActionString == "querydescendant")
                        {
                            SysModule[] ents = null;

                            if (RequestActionString == "querychildren")
                            {
                                string atype = String.Empty;

                                ents = SysModule.FindAll("FROM SysModule as ent WHERE ent.ParentID = ?", id);
                            }
                            else if (RequestActionString == "querydescendant")
                            {
                                string atype = String.Empty;

                                ents = UserContext.AccessibleModules.Where(tent => tent.Path != null && tent.Path.IndexOf(id) > 0).ToArray();
                            }

                            string jsonString = JsonHelper.GetJsonString(this.ToExtTreeCollection(ents.OrderBy(v => v.SortIndex).ThenBy(v => v.CreateDate), null));

                            Response.Write(jsonString);

                            Response.End();
                        }
                        break;
                }
            }
            else
            {
                SysAuthType[] authTypeList = SysAuthTypeRule.FindAll();
                if (this.Request.QueryString["Role"] != null && this.Request.QueryString["Role"] == "User")
                {
                    authTypeList = SysAuthType.FindAllByProperties(SysAuthType.Prop_AuthTypeID, 1);
                }
                IEnumerable<SysModule> ents = UserContext.AccessibleModules.Where(tent => tent.ApplicationID == id && tent.ParentID == null)
                        .OrderBy(tent => tent.SortIndex);

                this.PageState.Add("DtList", ents.ToList());
                //this.PageState.Add("DtList", authTypeList);
            }

            // 获取权限列表
            /*if (RequestAction != RequestActionEnum.Custom)
            {
                this.PageState.Add("EntityID", id);

                IEnumerable<string> authIDs = null;
                using (new Castle.ActiveRecord.SessionScope())
                {
                    if (type == "user" && !String.IsNullOrEmpty(id))
                    {
                        SysUser user = SysUser.Find(id);
                        if (this.RequestData.Get<string>("Deny") != null && this.RequestData.Get<string>("Deny").Trim() == "Y")
                        {
                            authIDs = (user.AuthNo).Select((ent) => { return ent.AuthID; });
                        }
                        else
                            authIDs = (user.Auth).Select((ent) => { return ent.AuthID; });
                    }
                    else if (type == "group" && !String.IsNullOrEmpty(id))
                    {
                        SysGroup group = SysGroup.Find(id);
                        authIDs = (group.Auth).Select((ent) => { return ent.AuthID; });
                    }
                    else if (type == "role" && !String.IsNullOrEmpty(id))
                    {
                        SysRole role = SysRole.Find(id);
                        authIDs = (role.Auth).Select((ent) => { return ent.AuthID; });
                    }

                    this.PageState.Add("AtList", new List<string>(authIDs));
                }
            }*/
        }

        /// <summary>
        /// 生成ExtTree
        /// </summary>
        /// <param name="ents"></param>
        /// <param name="parentID"></param>
        /// <returns></returns>
        private WebHelper.ExtTreeNodeCollection ToExtTreeCollection(IEnumerable<SysModule> ents, WebHelper.ExtTreeNode pnode)
        {
            string parentID = (pnode == null) ? RequestData["id"].ToString() : (pnode["id"] == null ? null : pnode["id"].ToString());

            IEnumerable<SysModule> rtnents = null;

            WebHelper.ExtTreeNodeCollection nodes = new WebHelper.ExtTreeNodeCollection();

            if (ents != null)
            {
                if (String.IsNullOrEmpty(parentID))
                {
                    rtnents = ents.Where(ent => (ent.ParentID == null || ent.ParentID == String.Empty));
                }
                else
                {
                    rtnents = ents.Where(ent => ent.ParentID == parentID);
                }

                if (rtnents.Count() > 0)
                {
                    if (pnode != null)
                    {
                        pnode["leaf"] = false;
                        pnode["iconCls"] = "iconnone";
                    }

                    foreach (SysModule tent in rtnents)
                    {
                        WebHelper.ExtTreeNode node = new WebHelper.ExtTreeNode();
                        node["id"] = tent.ModuleID;
                        node["text"] = tent.Name;
                        node["ParentID"] = tent.ParentID;
                        node["ModuleID"] = tent.ModuleID;
                        node["Type"] = tent.Type;
                        node["Name"] = tent.Name;
                        node["Code"] = tent.Code;
                        node["Path"] = tent.Path;
                        node["PathLevel"] = tent.PathLevel;
                        node["Url"] = tent.Url;
                        node["SortIndex"] = tent.SortIndex;
                        node["LastModifiedDate"] = tent.LastModifiedDate;
                        node["CreateDate"] = tent.CreateDate;
                        node["Description"] = tent.Description;

                        node["children"] = ToExtTreeCollection(ents, node);

                        nodes.Add(node);
                    }
                }
                else
                {
                    if (pnode != null)
                    {
                        pnode["leaf"] = true;

                        if (pnode["children"] == null)
                        {
                            pnode.Remove("children");
                        }
                    }
                }
            }

            return nodes;
        }
    }
}
