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
using Aim;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using IntegratedManage.Model;
using Aim.Utilities;
namespace IntegratedManage.Web.AddressBook
{
    public partial class Manage_AddrBookList : IMListPage
    {
        private IList<EnterpriseAddrBook> ents = null;
        private string DeptId = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            DeptId = this.RequestData.Get<string>("DeptId");
            switch (this.RequestActionString)
            {
                case "batchdelete":
                    DoBatchDelete();
                    break;
                case "Sync":
                    SyncAddrBook();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void SyncAddrBook()
        /*同步通讯录*/
        {
            string sql = @"insert into  BJKY_IntegratedManage..EnterpriseAddrBook(Id,UserId,UserName,OfficeEmail,OfficeTel,PersonalTel,Fax,DeptId,DeptName) 
                            select  newid(), A.UserID,A.Name,A.Email,A.Phone, A.HomePhone,A.Fax,B.GroupID ,C.Name
                            from BJKY_Portal..SysUser As A
                            inner join  
                            BJKY_Portal..SysUserGroup As B 
                            on A.UserID=B.UserID
                            left join BJKY_Portal..SysGroup As C
                            on B.GroupID =C.GroupID
                            where not exists(
                            select 'X' from BJKY_IntegratedManage..EnterpriseAddrBook As T where A.UserID=T.UserId
                            ) ;";
            sql += @"delete  BJKY_IntegratedManage..EnterpriseAddrBook 
                where not exists(
                  select 'X' from BJKY_Portal..SysUser
                  where BJKY_IntegratedManage..EnterpriseAddrBook.UserId=BJKY_Portal..SysUser.UserID 
                )";
            PageState.Add("SyncBookState", DataHelper.ExecSql(sql));
        }
        private void DoSelect()
        {
            //维护验证
            string auth = @"select Id from BJKY_IntegratedManage..IntegratedConfig where patindex('%{0}%',AddressListMaintenanceId)>0";
            auth = string.Format(auth, UserInfo.UserID);
            if (DataHelper.QueryValue(auth) != null)
            {
                PageState.Add("authState", "true");
            }
            string sql = string.Empty;
            if (string.IsNullOrEmpty(DeptId))  //第一次加载
            {
                sql = @"select * from BJKY_IntegratedManage..EnterpriseAddrBook
                        where DeptId in (select GroupID from BJKY_Portal..SysUserGroup Where UserID='{0}') and 1=1 ";
                sql = string.Format(sql, UserInfo.UserID);
            }
            else
            {
                sql = @"select * from BJKY_IntegratedManage..EnterpriseAddrBook where DeptId in(
	                    select GroupID from BJKY_Portal..SysGroup where path like '%{0}%') and 1=1 ";
                sql = string.Format(sql, DeptId);
            }
            string SearchPara = string.Empty;
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!string.IsNullOrEmpty(item.Value + ""))
                {
                    if (item.PropertyName == "UserName")
                    {
                        SearchPara = " and " + GetPinyinWhereString("UserName", item.Value + "");
                    }
                    else
                    {
                        SearchPara += " and " + item.PropertyName + " like " + "'%" + item.Value + "%'";
                    }
                }
            }
            sql = sql.Replace("and 1=1", SearchPara);
            PageState.Add("EnterpriseAddrBookList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " desc" : " asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
        public string GetPinyinWhereString(string fieldName, string pinyinIndex)
        {
            string[,] hz = Tool.GetHanziScope(pinyinIndex);
            string whereString = "(";
            for (int i = 0; i < hz.GetLength(0); i++)
            {
                whereString += "(SUBSTRING(" + fieldName + ", " + (i + 1) + ", 1) >= '" + hz[i, 0] + "' AND SUBSTRING(" + fieldName + ", " + (i + 1) + ", 1) <= '" + hz[i, 1] + "') AND ";
            }
            if (whereString.Substring(whereString.Length - 4, 4) == "AND ")
                return whereString.Substring(0, whereString.Length - 4) + ")";
            else
                return "(1=1)";
        }
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                Model.EnterpriseAddrBook.DoBatchDelete(idList.ToArray());
            }
        }
    }
}
