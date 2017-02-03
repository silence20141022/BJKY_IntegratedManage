using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace IntegratedManage.Web
{
    public partial class Rule_Regulation_BrowseAuthList : IMListPage
    {
        #region 变量

        private IList<Rule_Regulation_BrowseAuth> ents = null;
        string id = "";


        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            Rule_Regulation_BrowseAuth ent = null;
            id = RequestData.Get<string>("id");

            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Rule_Regulation_BrowseAuth>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (RequestActionString == "submituser")
                    {
                        DoBatchInsert();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        #endregion

        #region 私有方法
        private void DoBatchInsert()
        {
            string id = RequestData.Get<string>("id", "");
            IList<string> entStrList = RequestData.GetList<string>("data");
            IList<Rule_Regulation_AdminAuth> ents = entStrList.Select(tent => Aim.JsonHelper.GetObject<Rule_Regulation_AdminAuth>(tent) as Rule_Regulation_AdminAuth).ToList();
            if (id != "" && ents.Count > 0)
            {
                DataTable dt = GetTableSchema();

                foreach (Rule_Regulation_AdminAuth item in ents)
                {
                    DataRow dr = dt.NewRow();
                    dr[0] = Guid.NewGuid();
                    dr[1] = id;
                    dr[2] = item.UserId;
                    dr[3] = item.UserName;
                    dt.Rows.Add(dr);
                }
                string connStr = ConfigurationManager.AppSettings["ConStr"].ToString();
                SqlConnection sqlConn = new SqlConnection(connStr);
                SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConn);
                bulkCopy.DestinationTableName = "Rule_Regulation_BrowseAuth";
                bulkCopy.BatchSize = dt.Rows.Count;
                
                try
                {
                    sqlConn.Open();
                    if (dt != null && dt.Rows.Count != 0)
                        bulkCopy.WriteToServer(dt);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    sqlConn.Close();
                    if (bulkCopy != null)
                        bulkCopy.Close();
                }

            }


        }

        private static DataTable GetTableSchema()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.AddRange(new DataColumn[] { new DataColumn("Id", typeof(string)), new DataColumn("Rule_Regulation", typeof(string)), new DataColumn("UserId", typeof(string)), new DataColumn("UserName", typeof(string)) });
            return dataTable;
        }

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            ents = Rule_Regulation_BrowseAuth.FindAll(SearchCriterion, Expression.Eq("Rule_Regulation", id));
            this.PageState.Add("Rule_Regulation_BrowseAuthList", ents);
        }

        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                Rule_Regulation_BrowseAuth.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion
    }
}

