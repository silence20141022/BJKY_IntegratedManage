using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;

using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using System.Data;
using Aim.Common;
using Aim;
using IntegratedManage.Model;

namespace IntegratedManage.Web
{
    public partial class RegulationOgzTreeBrowse : IMListPage
    {

        private SysGroup[] ents = null;
        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表 
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");
            if (IsAsyncRequest)
            {
                switch (this.RequestAction)
                {
                    case RequestActionEnum.Custom:
                        if (RequestActionString == "querychildren")
                        {
                            id = (RequestData.ContainsKey("id") ? RequestData["id"].ToString() : String.Empty);

                            string sql = @"select distinct b.GroupId,b.Name,b.Path,b.PathLevel,b.ParentID 
from (
select GroupID,Name,Path from BJKY_Portal..SysGroup c 
where exists 
(
select DeptId from(
    SELECT * FROM BJKY_IntegratedManage..Rule_Regulation where AuthType='all'
    union
    select a.* from BJKY_IntegratedManage..Rule_Regulation a 
    left join BJKY_Portal..View_SysUserGroup b on a.DeptId like '%'+b.DeptId+'%'
    where b.UserId='{0}' and b.Type<>'3' and a.AuthType='dept'
    union
    select a.* from BJKY_IntegratedManage..Rule_Regulation a
    left join BJKY_IntegratedManage..Rule_Regulation_BrowseAuth b on b.Rule_Regulation=a.Id
    where b.UserId='{0}' and a.AuthType='specify'
    union 
    select a.* from BJKY_IntegratedManage..Rule_Regulation a
    left join BJKY_IntegratedManage..Rule_Regulation_BrowseDept b on b.Rule_Regulation=a.Id
    left join BJKY_Portal..View_SysUserGroup c on b.DeptId=c.DeptId
    where c.UserId='{0}' and c.Type<>'3' and a.AuthType='specify')a 
    where charindex(c.GroupID,a.DeptId)>0
)
)a
left join BJKY_Portal..SysGroup b on a.Path like '%'+b.Path+'%'";
                            sql = string.Format(sql, UserInfo.UserID);
                            DataTable dt = new DataTable();
                            dt = DataHelper.QueryDataTable(sql, DataHelper.GetCurrentDbConnection(typeof(Rule_Regulation_BrowseAuth)));
                            string jsonString = JsonHelper.GetJsonString(this.ToExtTreeCollection(dt, null));

                            Response.Write(jsonString);

                            Response.End();

                        }
                        break;
                    default:
                        SysGroup[] grpList = SysGroup.FindAll("From SysGroup as ent where ParentId is null and Type = 2 Order By SortIndex, CreateDate Desc");

                        this.PageState.Add("DtList", grpList);
                        break;
                }
            }
            else
            {
                ents = SysGroup.FindAll(Expression.Eq("PathLevel", 1));
                //ents = ents.OrderByDescending(ment => ment.Type).ToArray();
                this.PageState.Add("DtList", ents);
            }


        }


        /// <summary>
        /// 生成ExtTree
        /// </summary>
        /// <param name="ents"></param>
        /// <param name="parentID"></param>
        /// <returns></returns>
        private WebHelper.ExtTreeNodeCollection ToExtTreeCollection(DataTable dataTable, WebHelper.ExtTreeNode pnode)
        {
            string parentID = (pnode == null) ? null : (pnode["id"] == null ? null : pnode["id"].ToString());
            //IEnumerable<D_WorkPackageDictionary> rtnents = null;
            DataRow[] rtnRows = null;

            WebHelper.ExtTreeNodeCollection nodes = new WebHelper.ExtTreeNodeCollection();

            if (dataTable.Rows.Count > 0)
            {
                if (String.IsNullOrEmpty(parentID))
                {
                    //rtnents = ents.Where(ent => (ent.ParentId == null || ent.ParentId == String.Empty));
                    rtnRows = dataTable.Select("PathLevel=2");
                }
                else
                {
                    //rtnents = ents.Where(ent => ent.ParentId == parentID);
                    rtnRows = dataTable.Select("ParentID='" + parentID + "'");
                }

                if (rtnRows.Count() > 0)
                {
                    if (pnode != null)
                    {
                        pnode["leaf"] = false;
                    }

                    foreach (DataRow tent in rtnRows)
                    {
                        WebHelper.ExtTreeNode node = new WebHelper.ExtTreeNode();
                        node["id"] = tent["GroupID"].ToString();
                        //this.text = '<span style="width:150px;">' + this.WBSCode + '</span>' + '<span style="margin-left:30px;">' + this.CurLevelName + '</span>'
                        //node["text"] = "<span style=\"width:150px;\">" + tent["WBSCode"].ToString() + "</span>" + "<span style=\"margin-left:30px;\">" + tent["CurLevelName"].ToString() + "</span>";
                        node["ParentId"] = tent["ParentID"].ToString();
                        //node["Path"] = tent.Path;
                        node["text"] = tent["Name"].ToString();
                        node["Path"] = tent["Path"].ToString();
                        node["PathLevel"] = tent["PathLevel"].ToString();
                        //node["uiProvider"] = "col";
                        //node["PathLevel"] = tent["CurLevel"];
                        //node["SortIndex"] = tent["RowIndex"];
                        //node["ManHours"] = tent["ManHours"];
                        node["children"] = ToExtTreeCollection(dataTable, node);
                        node["iconCls"] = "icon";
                        //node["cls"] = "node-row-bg-level" + tent["CurLevel"];

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
