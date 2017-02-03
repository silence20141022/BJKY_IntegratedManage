using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Aim.Data;
using Aim.Common;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;
using Aim;
using NHibernate.Criterion;
using Newtonsoft.Json.Linq;
using Aim.Portal;


namespace IntegratedManage.Web
{
    public partial class MyAuthTree : BasePage
    {
        string op = String.Empty;
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 查询类型

        protected void Page_Load(object sender, EventArgs e)
        {
            id = (RequestData.ContainsKey("id") ? RequestData["id"].ToString() : UserInfo.UserID);
            type = (RequestData.ContainsKey("type") ? RequestData["type"].ToString() : String.Empty).ToLower();
            if (this.IsAsyncRequest)
            {
                switch (this.RequestAction)
                {
                    case RequestActionEnum.Custom:
                        if (RequestActionString == "querydescendant")
                        {
                            SysAuth[] ents = null;
                            string atype = String.Empty;
                            //ents = SysAuth.FindAll("FROM SysAuth as ent WHERE ent.Type = ?", id);
                            SysUser user = SysUser.Find(this.UserInfo.UserID);
                            ents = this.UserContext.Auths.OrderBy(ens => ens.SortIndex).ToArray();
                            //SysAuth.FindAll(Expression.Sql("AuthID in (select AuthID from SysUserPermission where UserID ='" + this.UserInfo.UserID + "')"));
                            //user.Auth.ToArray();
                            string jsonString = JsonHelper.GetJsonString(this.ToExtTreeCollection(ents.OrderBy(v => v.SortIndex).ThenBy(v => v.CreateDate), null));
                            Response.Write(jsonString);
                            Response.End();
                        }
                        else if (RequestActionString == "savechanges")
                        {
                            ICollection authAdded = RequestData["added"] as ICollection;
                            ICollection authRemoved = RequestData["removed"] as ICollection;

                            if (type == "user" && !String.IsNullOrEmpty(id))
                            {
                                SysAuth[] tAuths = SysAuthRule.GetAuthByIDs(authAdded).ToArray();
                                foreach (SysAuth auth in tAuths)
                                {
                                    MyShortCut cut = new MyShortCut();
                                    cut.CreateId = this.UserInfo.UserID;
                                    cut.CreateName = this.UserInfo.Name;
                                    cut.CreateTime = DateTime.Now;
                                    cut.ModuleUrl = SysModule.Find(auth.ModuleID).Url;
                                    cut.AuthId = auth.AuthID;
                                    cut.AuthName = auth.Name;
                                    cut.IconFileName = "/images/shared/read.gif";
                                    cut.Save();
                                }
                                if (authRemoved.Count > 0)
                                {
                                    ICollection myAuthIDs = null;
                                    if (authRemoved is JArray)
                                    {
                                        JArray arrAuths = authRemoved as JArray;
                                        myAuthIDs = new List<string>(arrAuths.Values<string>());
                                    }
                                    else
                                    {
                                        myAuthIDs = authRemoved;
                                    }
                                    foreach (string s in myAuthIDs)
                                    {
                                        DataHelper.ExecSql("delete from MyShortCut where AuthId like '%" + s + "%' and CreateId='" + this.UserInfo.UserID + "'", DataHelper.GetCurrentDbConnection(typeof(MyShortCut)));
                                    }
                                }
                                //SysAuthRule.GrantAuthToUser(authAdded, id);
                                //SysAuthRule.RevokeAuthFromUser(authRemoved, id);
                            }
                            /*else if (type == "group" && !String.IsNullOrEmpty(id))
                            {
                                SysAuthRule.GrantAuthToGroup(authAdded, id);
                                SysAuthRule.RevokeAuthFromGroup(authRemoved, id);
                            }
                            else if (type == "role" && !String.IsNullOrEmpty(id))
                            {
                                SysAuthRule.GrantAuthToRole(authAdded, id);
                                SysAuthRule.RevokeAuthFromRole(authRemoved, id);
                            }*/
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
                this.PageState.Add("DtList", authTypeList);
            }

            // 获取权限列表
            if (RequestAction != RequestActionEnum.Custom)
            {
                this.PageState.Add("EntityID", id);
                IEnumerable<string> authIDs = null;
                IList<MyShortCut> mscEnts = MyShortCut.FindAllByProperty(MyShortCut.Prop_CreateId, UserInfo.UserID);

                authIDs = mscEnts.Select(s => s.AuthId);
                this.PageState.Add("AtList", new List<string>(authIDs));
                //using (new Castle.ActiveRecord.SessionScope())
                //{
                //    if (type == "user" && !String.IsNullOrEmpty(id))
                //    {
                //        SysUser user = SysUser.Find(id);
                //        if (this.RequestData.Get<string>("Deny") != null && this.RequestData.Get<string>("Deny").Trim() == "Y")
                //        {
                //            authIDs = (user.AuthNo).Select((ent) => { return ent.AuthID; });
                //        }
                //        else
                //            authIDs = (user.Auth).Select((ent) => { return ent.AuthID; });
                //    }
                //    else if (type == "group" && !String.IsNullOrEmpty(id))
                //    {
                //        SysGroup group = SysGroup.Find(id);
                //        authIDs = (group.Auth).Select((ent) => { return ent.AuthID; });
                //    }
                //    else if (type == "role" && !String.IsNullOrEmpty(id))
                //    {
                //        SysRole role = SysRole.Find(id);
                //        authIDs = (role.Auth).Select((ent) => { return ent.AuthID; });
                //    }
                //    this.PageState.Add("AtList", new List<string>(authIDs));
                //}
            }
        }

        /// <summary>
        /// 生成ExtTree
        /// </summary>
        /// <param name="ents"></param>
        /// <param name="parentID"></param>
        /// <returns></returns>
        private WebHelper.ExtTreeNodeCollection ToExtTreeCollection(IEnumerable<SysAuth> ents, WebHelper.ExtTreeNode pnode)
        {
            string parentID = (pnode == null) ? null : (pnode["id"] == null ? null : pnode["id"].ToString());
            IEnumerable<SysAuth> rtnents = null;

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
                    }

                    foreach (SysAuth tent in rtnents)
                    {
                        if (tent.ModuleID != null && DataHelper.QueryDataTable("Select ModuleID from SysModule where ModuleID='" + tent.ModuleID + "' and Status='0'").Rows.Count > 0)
                            continue;
                        WebHelper.ExtTreeNode node = new WebHelper.ExtTreeNode();
                        node["id"] = tent.AuthID;
                        node["text"] = tent.Name;
                        node["AuthID"] = tent.AuthID;
                        node["ParentID"] = tent.ParentID;
                        node["ModuleID"] = tent.ModuleID;
                        node["Type"] = tent.Type;
                        node["Name"] = tent.Name;
                        node["Code"] = tent.Code;
                        node["Data"] = tent.Data;
                        node["Path"] = tent.Path;
                        node["PathLevel"] = tent.PathLevel;
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
