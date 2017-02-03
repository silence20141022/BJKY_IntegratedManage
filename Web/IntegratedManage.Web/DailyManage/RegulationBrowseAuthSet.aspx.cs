using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using IntegratedManage.Model;
using Aim;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace IntegratedManage.Web
{
    public partial class RegulationBrowseAuthSet : IMListPage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            Rule_Regulation ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = Rule_Regulation.Find(id);
                    ent.AuthType = RequestData.Get<string>("AuthType");
                    if (ent.AuthType == "specify")
                    {
                        SetAuth();
                    }
                    ent.LastModifyId = UserInfo.UserID;
                    ent.LastModifyName = UserInfo.Name;
                    ent.LastModifyTime = System.DateTime.Now;

                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                    return;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = Rule_Regulation.Find(id);
                }

                this.SetFormData(ent);
                if (!string.IsNullOrEmpty(id))
                {
                    this.PageState.Add("DeptList", Rule_Regulation_BrowseDept.FindAllByProperties("Rule_Regulation", id));
                    this.PageState.Add("UserList", Rule_Regulation_BrowseAuth.FindAllByProperties("Rule_Regulation", id));

                }
            }
        }

        private static DataTable GetTableSchema(string tabType)
        {
            DataTable dataTable = new DataTable();
            if (tabType == "user")
            {
                dataTable.Columns.AddRange(
                                new DataColumn[] { 
                    new DataColumn("Id", typeof(string)), 
                    new DataColumn("Rule_Regulation", typeof(string)), 
                    new DataColumn("UserId", typeof(string)), 
                    new DataColumn("UserName", typeof(string)) 
                });
            }
            else
            {
                dataTable.Columns.AddRange(
                                new DataColumn[] { 
                    new DataColumn("Id", typeof(string)), 
                    new DataColumn("Rule_Regulation", typeof(string)), 
                    new DataColumn("DeptId", typeof(string)), 
                    new DataColumn("DeptName", typeof(string)) 
                });
            }
            return dataTable;

        }

        private void SetAuth()
        {
            string connStr = ConfigurationManager.AppSettings["ConStr"].ToString();
            SqlConnection sqlConn = new SqlConnection(connStr);
            IList<string> entStrList_Dept = RequestData.GetList<string>("DeptData");
            if (entStrList_Dept.Count > 0)
            {
                DataTable deptDt = GetTableSchema("dept");
                IList<Rule_Regulation_BrowseDept> ents_Dept = entStrList_Dept.Select(tent => Aim.JsonHelper.GetObject<Rule_Regulation_BrowseDept>(tent) as Rule_Regulation_BrowseDept).ToList();
                foreach (Rule_Regulation_BrowseDept item in ents_Dept)
                {
                    DataRow dr = deptDt.NewRow();
                    dr[0] = Guid.NewGuid();
                    dr[1] = id;
                    dr[2] = item.DeptId;
                    dr[3] = item.DeptName;
                    deptDt.Rows.Add(dr);
                }
                Rule_Regulation_BrowseDept.DeleteAll("Rule_Regulation='" + id + "'");
                DataHelper.CopyDataToDatabase(deptDt, sqlConn, "BJKY_IntegratedManage..Rule_Regulation_BrowseDept");
            }

            IList<string> entStrList_User = RequestData.GetList<string>("UserData");
            if (entStrList_User.Count > 0)
            {
                DataTable deptDt = GetTableSchema("user");
                IList<Rule_Regulation_BrowseAuth> ents_Dept = entStrList_User.Select(tent => Aim.JsonHelper.GetObject<Rule_Regulation_BrowseAuth>(tent) as Rule_Regulation_BrowseAuth).ToList();
                foreach (Rule_Regulation_BrowseAuth item in ents_Dept)
                {
                    DataRow dr = deptDt.NewRow();
                    dr[0] = Guid.NewGuid();
                    dr[1] = id;
                    dr[2] = item.UserId;
                    dr[3] = item.UserName;
                    deptDt.Rows.Add(dr);
                }
                Rule_Regulation_BrowseAuth.DeleteAll("Rule_Regulation='" + id + "'");
                DataHelper.CopyDataToDatabase(deptDt, sqlConn, "BJKY_IntegratedManage..Rule_Regulation_BrowseAuth");
            }
        }
        #endregion
    }
}

