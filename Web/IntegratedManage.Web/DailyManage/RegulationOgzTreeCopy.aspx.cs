using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;

using Aim.Data;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using NHibernate.Criterion;
using IntegratedManage.Model;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace IntegratedManage.Web
{
    public partial class RegulationOgzTreeCopy : IMListPage
    {

        private SysGroup[] ents = null;
        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表 
        string did = string.Empty;
        string ruleId = string.Empty;
        string type = string.Empty;
        string carryadmin = string.Empty;
        string carrybrowse = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");
            did = RequestData.Get<string>("did");
            ruleId = RequestData.Get<string>("ruleid");
            type = RequestData.Get<string>("type");
            carryadmin = RequestData.Get<string>("carryadmin");
            carrybrowse = RequestData.Get<string>("carryadmin");

            SysGroup ent = null;

            //if (IsAsyncRequest)
            //{

            //}
            //else
            //{
            //    ents = SysGroup.FindAll(Expression.Eq("PathLevel", 1));
            //    //ents = ents.OrderByDescending(ment => ment.Type).ToArray();
            //    this.PageState.Add("DtList", ents);
            //}

            switch (this.RequestAction)
            {
                case RequestActionEnum.Custom:
                    if (RequestActionString == "querychildren")
                    {
                        if (String.IsNullOrEmpty(id))
                        {
                            ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ParentId is null and Type = 2 Order By SortIndex asc");
                        }
                        else
                        {
                            ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ParentId = '" + id + "' and Type = 2 Order By SortIndex asc");
                        }

                        this.PageState.Add("DtList", ents);
                    }
                    else if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");
                        if (idList != null && idList.Count > 0)
                        {
                            SysGroup.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (RequestActionString == "submitopt")
                    {
                        Rule_Regulation rrEnt = Rule_Regulation.Find(ruleId);
                        SysGroup sg = SysGroup.Find(did);

                        if (type == "copy")
                        {
                            Rule_Regulation newRr = new Rule_Regulation();
                            newRr.Code = rrEnt.Code;
                            newRr.Name = rrEnt.Name;
                            newRr.KeyWord = rrEnt.KeyWord;
                            newRr.Summary = rrEnt.Summary;
                            newRr.Files = rrEnt.Files;
                            newRr.ReleaseState = "未发布";
                            newRr.DeptId = sg.GroupID;
                            newRr.DeptName = sg.Name;
                            newRr.CreateId = UserInfo.UserID;
                            newRr.CreateName = UserInfo.Name;
                            newRr.CreateTime = System.DateTime.Now;
                            newRr.LastModifyId = UserInfo.UserID;
                            newRr.LastModifyName = UserInfo.Name;
                            newRr.LastModifyTime = DateTime.Now;
                            newRr.DoCreate();

                            if (carryadmin == "y")
                            {
                                Rule_Regulation_AdminAuth[] rraas = Rule_Regulation_AdminAuth.FindAllByProperty("Rule_Regulation", ruleId);
                                if (rraas.Length > 0)
                                {
                                    DataTable dt = GetTableSchema();
                                    foreach (Rule_Regulation_AdminAuth item in rraas)
                                    {
                                        DataRow dr = dt.NewRow();
                                        dr[0] = Guid.NewGuid();
                                        dr[1] = newRr.Id;
                                        dr[2] = item.UserId;
                                        dr[3] = item.UserName;
                                        dt.Rows.Add(dr);
                                    }
                                    string connStr = ConfigurationManager.AppSettings["ConStr"].ToString();
                                    BulkCopy(connStr, "Rule_Regulation_AdminAuth", dt);
                                }

                            }
                            if (carrybrowse == "y")
                            {

                                Rule_Regulation_BrowseAuth[] rraas = Rule_Regulation_BrowseAuth.FindAllByProperty("Rule_Regulation", ruleId);
                                if (rraas.Length > 0)
                                {
                                    DataTable dt = GetTableSchema();
                                    foreach (Rule_Regulation_BrowseAuth item in rraas)
                                    {
                                        DataRow dr = dt.NewRow();
                                        dr[0] = Guid.NewGuid();
                                        dr[1] = newRr.Id;
                                        dr[2] = item.UserId;
                                        dr[3] = item.UserName;
                                        dt.Rows.Add(dr);
                                    }
                                    string connStr = ConfigurationManager.AppSettings["ConStr"].ToString();
                                    BulkCopy(connStr, "Rule_Regulation_BrowseAuth", dt);
                                }
                            }

                        }
                        else if (type == "cut")
                        {
                            rrEnt.DeptId = sg.GroupID;
                            rrEnt.DeptName = sg.Name;
                            rrEnt.CreateId = UserInfo.UserID;
                            rrEnt.CreateName = UserInfo.Name;
                            rrEnt.CreateTime = System.DateTime.Now;
                            rrEnt.LastModifyId = UserInfo.UserID;
                            rrEnt.LastModifyName = UserInfo.Name;
                            rrEnt.LastModifyTime = DateTime.Now;
                            rrEnt.DoUpdate();

                            if (carryadmin == "n")
                            {
                                Rule_Regulation_AdminAuth.DeleteAll(" Rule_Regulation='" + ruleId + "'");
                            }
                            if (carrybrowse == "n")
                            {
                                Rule_Regulation_BrowseAuth.DeleteAll(" Rule_Regulation='" + ruleId + "'");
                            }
                        }

                    }
                    else if (RequestActionString == "c")
                    {
                        DoCreateSubByRole();
                    }
                    break;
                default:
                    SysGroup[] grpList = SysGroup.FindAll("From SysGroup as ent where ParentId is null and Type = 2Order By SortIndex, CreateDate Desc");

                    this.PageState.Add("DtList", grpList);
                    break;
            }
        }


        private void BulkCopy(string constr, string tablename, DataTable dt)
        {
            SqlConnection sqlConn = new SqlConnection(constr);
            SqlBulkCopy bulkCopy = new SqlBulkCopy(sqlConn);
            bulkCopy.DestinationTableName = tablename;// "Rule_Regulation_AdminAuth";
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

        private static DataTable GetTableSchema()
        {
            DataTable dataTable = new DataTable();
            dataTable.Columns.AddRange(new DataColumn[] { new DataColumn("Id", typeof(string)), new DataColumn("Rule_Regulation", typeof(string)), new DataColumn("UserId", typeof(string)), new DataColumn("UserName", typeof(string)) });
            return dataTable;
        }


        [ActiveRecordTransaction]
        private void DoCreateSubByRole()
        {
            IList<string> idList = RequestData.GetList<string>("IdList");
            SysGroup tent = SysGroup.Find(id);

            if (idList != null && idList.Count > 0)
            {
                SysRole[] duties = SysRole.FindAllByPrimaryKeys(idList.ToArray());

                foreach (SysRole tduty in duties)
                {
                    if (!SysGroup.Exists("Name=? and Type=21 and ParentID = ?", tduty.Name, tent.ID))
                    {
                        SysGroup tgrp = new SysGroup()
                        {
                            Name = tduty.Name,
                            Code = tduty.Code,
                            Type = 3,   //角色
                            Status = 1,
                            SortIndex = 9999,
                            CreateDate = DateTime.Now
                        };

                        tgrp.CreateAsChild(tent);
                    }
                }
            }
        }
    }
}
