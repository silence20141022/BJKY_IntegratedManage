using System;
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
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using IntegratedManage.Web;

namespace Aim.AM.Web.Aim.Task
{
    public partial class TaskWBS : IMListPage
    {
        private A_TaskWBS[] ents = null;
        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表
        public string year = String.Empty; // 对象编码
        string db = ConfigurationManager.AppSettings["DB"];
        public string isLeader = "F";
        public string isLeaderCompany = "F";
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");
            year = RequestData.Get<string>("Year", DateTime.Now.Year.ToString());
            A_TaskWBS ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<A_TaskWBS>();
                    ent.ParentID = String.IsNullOrEmpty(ent.ParentID) ? null : ent.ParentID;
                    ent.Update();
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");
                        if (idList != null && idList.Count > 0)
                        {
                            A_TaskWBS.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (RequestActionString == "paste")
                    {
                        DoPaste();
                    }
                    else if (RequestActionString == "submittask")
                    {
                        ent = A_TaskWBS.Find(this.RequestData.Get<string>("Id"));
                        ent.State = "1";
                        ent.SubmitDate = DateTime.Now;
                        ent.SubmitUserId = this.UserInfo.UserID;
                        ent.SubmitUserName = this.UserInfo.Name;
                        ent.Save();
                    }
                    else if (RequestActionString == "backtask")
                    {
                        ent = A_TaskWBS.Find(this.RequestData.Get<string>("Id"));
                        ent.State = "0";
                        ent.Save();
                    }
                    else
                    {
                        DoSelect();
                        //this.PageState.Add("BudgetType", SysEnumeration.GetEnumDict("BudgetType"));
                        this.PageState.Add("Years", SysEnumeration.GetEnumDict("Year"));
                        this.PageState.Add("AimType", SysEnumeration.GetEnumDict("AimType"));
                    }
                    if (this.RequestData.Get<string>("ChartSearch") == "T")
                    {
                        string sql = "select Name TaskType,0 CountFinish,0 CountNormal from dbo.SysEnumeration where ParentId='5cf5990a-a68d-40b7-8ae5-558b1732cc92'";
                        DataTable dt = DataHelper.QueryDataTable(sql);
                        string deptName = this.RequestData.Get<string>("DeptName");
                        string Year = this.RequestData.Get<string>("Year");
                        DataTable newDt = new DataTable();
                        foreach (DataColumn col in dt.Columns)
                            newDt.Columns.Add(col.ColumnName, col.DataType);
                        foreach (DataRow row in dt.Rows)
                        {
                            DataRow newrow = newDt.NewRow();
                            newrow.ItemArray = row.ItemArray;
                            newDt.Rows.Add(newrow);
                            string rootId = DataHelper.QueryValue<string>("select isnull(Id,'') from " + db + "..A_TaskWBS where (DeptName='" + deptName + "' or DutyName='" + deptName + "') and Year='" + year + "' and TaskType='" + row["TaskType"].ToString() + "'");
                            newrow["CountFinish"] = DataHelper.QueryValue("select isnull(count(*),0) from " + db + "..A_TaskWBS where (DeptName='" + deptName + "' or DutyName='" + deptName + "') and Year='" + year + "' and Path like '%" + rootId + "%' and State='2'");
                            newrow["CountNormal"] = DataHelper.QueryValue("select isnull(count(*),0) from " + db + "..A_TaskWBS where (DeptName='" + deptName + "' or DutyName='" + deptName + "') and Year='" + year + "' and Path like '%" + rootId + "%' and State<>'2'");
                        }
                        this.PageState.Add("ChartData", DataHelper.DataTableToDictList(newDt));
                    }

                    break;
            }
        }
        private void DoSelect()
        {
            SearchCriterion sc = new HqlSearchCriterion(); // 构建查询表达式
            sc.SetOrder("SortIndex");
            sc.SetOrder("Code");
            ICriterion crit = null;
            if (RequestActionString == "querychildren")
            {
                if (ids != null && ids.Count > 0 || pids != null && pids.Count > 0)
                {
                    if (ids != null && ids.Count > 0)
                    {
                        IEnumerable<string> distids = ids.Distinct().Where(tent => !String.IsNullOrEmpty(tent));
                        crit = Expression.In(A_TaskWBS.Prop_Id, distids.ToArray());
                    }
                    if (pids != null && pids.Count > 0)
                    {
                        IEnumerable<string> dispids = pids.Distinct().Where(tent => !String.IsNullOrEmpty(tent));

                        if (crit != null)
                        {
                            crit = SearchHelper.UnionCriterions(crit, Expression.In(A_TaskWBS.Prop_ParentID, dispids.ToArray()));
                        }
                        else
                        {
                            crit = Expression.In(A_TaskWBS.Prop_ParentID, dispids.ToArray());
                            string pid = dispids.ToArray()[0];
                            if (pid == "1437f360-6937-409b-9548-964661e6c27c")
                            {
                                string test = pid;
                            }
                            //不是自己责任人的只能看到属于自己的(暂时屏蔽掉,有权限看到自己的子节点)
                            /*if (A_TaskWBS.Find(pid).DutyId.IndexOf(this.UserInfo.UserID) < 0)
                            {
                                //判断是否父节点有权限,有全部输出
                                //A_TaskWBS tp = A_TaskWBS.Find(pid);
                                string sqlall = " select Id,Path from " + db + "..A_TaskWBS where DutyId like '%" + this.UserInfo.UserID + "%'";
                                DataTable dtall = DataHelper.QueryDataTable(sqlall);
                                string checksql = "select Id from " + db + "..A_TaskWBS where ParentId='" + pid + "' and ";
                                string rules = "";
                                foreach (DataRow row in dtall.Rows)
                                {
                                    if (row["Path"] != null && row["Path"].ToString() != "")
                                        rules += "  Path like '%" + row["Path"] + "%' or";
                                }
                                if (rules != "") rules = rules.Substring(0, rules.Length - 2);
                                if (DataHelper.QueryDataTable(checksql + "(" + rules + ")").Rows.Count == 0)
                                {
                                    //判断有权限的子节点梯队
                                    string sqlIds = " select Id,Path from " + db + "..A_TaskWBS where DutyId like '%" + this.UserInfo.UserID + "%' and Path like '%" + pid + "%'";
                                    DataTable dt = DataHelper.QueryDataTable(sqlIds);
                                    string cids = "";
                                    string cpids = "";
                                    foreach (DataRow row in dt.Rows)
                                    {
                                        cids += row["Path"].ToString() + '.';
                                        cpids += " or Path like '%" + row["Path"].ToString() + "%'";
                                    }
                                    cids = cids.TrimEnd('.').Replace(".", "','");
                                    crit = Expression.Sql(" ParentID = '" + pid + "' and  ( Id in ('" + cids + "') " + cpids + " )");//SearchHelper.IntersectCriterions(crit);

                                }
                            }*/
                        }
                    }
                }
            }
            else
            {
                crit = Expression.Eq(A_TaskWBS.Prop_Year, year); 
                if (this.Request.QueryString["Type"] != null && this.Request.QueryString["Type"].ToString() != "")
                {
                    crit = SearchHelper.UnionCriterions(Expression.IsNull(A_TaskWBS.Prop_ParentID), Expression.Eq(A_TaskWBS.Prop_ParentID, String.Empty));
                }
                else
                {
                    string sqlC = " Id in (select distinct SUBSTRING(isnull(Path,Id),0,37) from BJKY_IntegratedManage..A_TaskWBS where ((DutyId like '%{0}%' or UserIds like '%{0}%') and State='1') or CreateId='{0}')";
                    sqlC = string.Format(sqlC, UserInfo.UserID);
                    crit = SearchHelper.IntersectCriterions(crit, Expression.Sql(sqlC));                   
                } 
            }
            if (crit != null)
            {
                ents = A_TaskWBS.FindAll(sc, SearchHelper.IntersectCriterions(crit, Expression.Eq(A_TaskWBS.Prop_Year, year)));
            }
            else
            {
                ents = A_TaskWBS.FindAll(sc);
            }
            if (ents != null && ents.Length != 0)
            {
                this.PageState.Add("DtList", ents);
            }
        }
        private int ReWriteChar(string code)
        {
            int s = 0;
            switch (code)
            {
                case "A":
                    s = 1;
                    break;
                case "B":
                    s = 20;
                    break;
                case "C":
                    s = 300;
                    break;
                case "D":
                    s = 400;
                    break;
            }
            return s;
        }
        //权限判定专用
        private ICriterion CheckProperty(ICriterion ic)
        {
            string sql = "";
            EasyDictionary dic = new EasyDictionary();
            DataTable dt = new DataTable();
            string DeptName = this.RequestData.Get<string>("DeptName");
            //能看到全部的角色
            /*if (this.UserContext.Roles.Where(ent => ent.Name == "全部目标查看").Count() > 0)
            {
                sql = @"select v.Name,isnull(s.sort,v.Type) Type from (select replace(Name,'院经营处','经营处') Name,2 Type from SysGroup as ent WHERE PathLevel=2 and (Type = 2) and Name not in ('院领导','内部退休','副总工程师','临时工')
union
select UserName Name,Type from dbo.View_SysUserGroup  where ChildDeptName='主管院长'
union select UserName Name,'4' Type from dbo.View_SysUserGroup where ChildDeptName='副总工程师') v left join {0}..A_SortSetting s on v.Name=s.PName
order by isnull(s.sort,case when v.Type='2' then 200 when v.Type='3' then 100 when v.Type='4' then 400 end) asc
";
                dt = DataHelper.QueryDataTable(string.Format(sql, db));
                this.PageState.Add("CurrentDept", dt.Rows[0][0]);
                ICriterion ich = null;
                if (string.IsNullOrEmpty(DeptName))
                {
                    ich = Expression.Sql(" (DutyName ='" + dt.Rows[0][0].ToString() + "' or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + this.UserInfo.Name + "' or DeptName like '%" + this.UserInfo.Name + "%')) and Flag is null");
                }
                else
                {
                    //主管院长能看自己的和从主管所获取过来的
                    ich = Expression.Sql(" (DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%'  or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%')) and Flag is null");
                }
                ic = SearchHelper.IntersectCriterions(ic, ich);
                isLeader = "T";
            }
            //只是主管院长
            else if (this.UserContext.Groups.Where(ent => ent.Name == "主管院长").Count() > 0)
            {
                sql = @"select distinct ParentDeptName from View_SysUserGroup where ChildDeptName='主管院长' and UserId ='{0}'  
                union select '{1}'";
                sql = string.Format(sql, this.UserInfo.UserID, this.UserInfo.Name);
                dt = DataHelper.QueryDataTable(sql);
                this.PageState.Add("CurrentDept", this.UserInfo.Name);
                ICriterion ich = null;
                if (string.IsNullOrEmpty(DeptName))
                {
                    ich = Expression.Sql(" (DutyName ='" + this.UserInfo.Name + "' or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + this.UserInfo.Name + "' or DeptName like '%" + this.UserInfo.Name + "%') or Ext2 in (select Id from " + db + "..A_AimLeaders where CreateId='" + this.UserInfo.UserID + "')) and Flag is null");
                    if (this.RequestData.Get<string>("IsShowAll") != null && this.RequestData.Get<string>("IsShowAll").ToLower() == "true")
                    {
                        ich = Expression.Sql(" (DutyName ='" + this.UserInfo.Name + "' or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + this.UserInfo.Name + "' or DeptName like '%" + this.UserInfo.Name + "%') or Ext2 in (select Id from " + db + "..A_AimLeaders where CreateId='" + this.UserInfo.UserID + "'))");
                    }
                }
                else
                {
                    //主管院长能看自己的和从主管所获取过来的
                    ich = Expression.Sql(" (DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%' or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%') or Ext2 in (select Id from " + db + "..A_AimLeaders where CreateName='" + DeptName + "')) and Flag is null");
                    if (this.RequestData.Get<string>("IsShowAll") != null && this.RequestData.Get<string>("IsShowAll").ToLower() == "true")
                    {
                        ich = Expression.Sql(" (DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%' or Ext2 in (select Flag from " + db + "..A_TaskWBS where DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%') or Ext2 in (select Id from " + db + "..A_AimLeaders where CreateName='" + DeptName + "'))");
                    }
                }
                ic = SearchHelper.IntersectCriterions(ic, ich);
                isLeader = "T";
                isLeaderCompany = "T";
            }
            //只是部门长
            else if (this.UserContext.Groups.Where(ent => ent.Name == "所（处、部）长").Count() > 0)
            {
                sql = @"select distinct case when ChildDeptName='所（处、部）长' then ParentDeptName else ChildDeptName end from dbo.View_SysUserGroup where UserId like '%" + this.UserInfo.UserID + "%' and ChildDeptName not in ('副总工程师','院办主任','副院长')";
                dt = DataHelper.QueryDataTable(sql);
                this.PageState.Add("CurrentDept", dt.Rows[0][0]);
                ICriterion ich = null;
                if (string.IsNullOrEmpty(DeptName))
                    ich = Expression.Sql("( DutyName ='" + dt.Rows[0][0].ToString() + "' or DeptName like '%" + dt.Rows[0][0].ToString() + "%') and Flag is null and DutyName not in ( select UserName from " + db + "..A_DeptLeaderRelation where GroupName='" + dt.Rows[0][0].ToString() + "')");
                else
                    ich = Expression.Sql("( DutyName ='" + DeptName + "' or DeptName like '%" + DeptName + "%') and Flag is null and DutyName not in ( select UserName from " + db + "..A_DeptLeaderRelation where GroupName='" + DeptName + "')");
                ic = SearchHelper.IntersectCriterions(ic, ich);
                isLeader = "T";
            }
            //普通责任人,能看到自己的责任任务
            else
            {*/
            //sql = @"select distinct case when ChildDeptName='所（处、部）长' then ParentDeptName else ChildDeptName end from dbo.View_SysUserGroup where UserId like '%" + this.UserInfo.UserID + "%' and Type=2";
            //dt = DataHelper.QueryDataTable(sql);
            //this.PageState.Add("CurrentDept", dt.Rows[0][0]);
            //责任领导不是部门长,是自己的也能看到(非责任人)
            string sqlC = " Id in (select distinct SUBSTRING(isnull(Path,Id),0,37) from  " + db + "..A_TaskWBS where DutyId like '%" + this.UserInfo.UserID + "%' or UserIds like '%" + this.UserInfo.UserID + "%'";
            sqlC += " union select Id from " + db + "..A_TaskWBS where Ext2 in (select Id from A_Aims where DutyLeaderId ='" + this.UserInfo.UserID + "') ";
            sqlC += ")";
            ic = SearchHelper.IntersectCriterions(ic, Expression.Sql(sqlC));
            //ICriterion ich = Expression.Sql(" ( DutyName ='" + dt.Rows[0][0].ToString() + "' or DeptName like '%" + dt.Rows[0][0].ToString() + "%')");
            //ic = SearchHelper.IntersectCriterions(ic, ich);
            //}
            foreach (DataRow row in dt.Rows)
            {
                dic.Add(row[0].ToString(), row[0]);
            }
            this.PageState.Add("Depts", dic);
            return ic;
        }

        /// <summary>
        /// 粘贴
        /// </summary>
        [ActiveRecordTransaction]
        private void DoPaste()
        {
            IList<string> idList = RequestData.GetList<string>("IdList");
            string type = RequestData.Get<string>("type", String.Empty);
            string tid = RequestData.Get<string>("tid", String.Empty);  // 目标节点id
            string pdstype = RequestData.Get<string>("pdstype", String.Empty);  // 粘贴数据来源类型

            if (!String.IsNullOrEmpty(tid))
            {
                A_TaskWBS target = A_TaskWBS.Find(tid);

                PasteDataSourceEnum pdsenum = PasteDataSourceEnum.Unknown;
                PasteAsEnum paenum = PasteAsEnum.Other;

                if (pdstype == "cut")
                {
                    pdsenum = PasteDataSourceEnum.Cut;
                }
                else if (pdstype == "copy")
                {
                    pdsenum = PasteDataSourceEnum.Copy;
                }

                if (type == "sib")
                {
                    paenum = PasteAsEnum.Sibling;
                }
                else if (type == "sub")
                {
                    paenum = PasteAsEnum.Child;
                }

                if (pdsenum != PasteDataSourceEnum.Unknown && paenum != PasteAsEnum.Other)
                {
                    // 粘贴操作
                    A_TaskWBS.DoPaste(pdsenum, paenum, tid, idList.ToArray());
                }
            }
        }
    }
}

