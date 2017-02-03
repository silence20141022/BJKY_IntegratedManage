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
using Aim;
using System.Text;
using System.Data;

namespace IntegratedManage.Web.SurveyManage
{
    public partial class SurveyQuestionEdit : IMListPage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型
        string SurveyQuestionId = string.Empty;
        string DeptId = string.Empty;//部门Id
        string DeptName = string.Empty; //部门名称

        //以便于前台使用被调查人信息
        public string SurveyedUserName = string.Empty;
        public string SurveyedUserId = string.Empty;

        SurveyQuestion ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            GetDeptInfo();

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = SurveyQuestion.Find(id);
                    this.SetFormData(ent);
                }
            }

            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<SurveyQuestion>();
                    //ent.Contents = toHtml(ent.Contents);
                    ent.DoUpdate();
                    SaveDetail(ent);
                    break;
                case "create":
                    ent = this.GetPostedData<SurveyQuestion>();
                    ent.State = "0";  //已创建状态
                    ent.DeptId = DeptId;
                    ent.DeptName = DeptName;
                    ent.DoCreate();
                    this.PageState.Add("Id", ent.Id);
                    SaveDetail(ent);
                    break;
                case "question":
                    Create();
                    break;
                case "girdBatchDel":
                    DoBatchDel();
                    break;
                case "close":
                    DoClose();
                    break;
                default:
                    DoSelect();
                    break;
            }

        }

        //获取部门信息
        private void GetDeptInfo()
        {
            string sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                         case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                         from View_SysUserGroup where UserId='{0}'";
            sql = string.Format(sql, UserInfo.UserID);
            DataTable dt = DataHelper.QueryDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                DeptId = dt.Rows[0]["DeptId"] + "";
                DeptName = dt.Rows[0]["DeptName"] + "";
            }
        }

        private void DoClose()
        {
            if (!string.IsNullOrEmpty(id))
            {
                string sql = @"delete from BJKY_IntegratedManage..SurveyQuestion where Id='{0}' and Title is null ;";
                sql += @"delete from BJKY_IntegratedManage..QuestionContent where SurveyQuestionId='{0}' and [Content] is null ;";
                sql += @"delete from BJKY_IntegratedManage..QuestionItems where SurveyQuestionId='{0}' and  QuestionContentId not in 
                        (select id from BJKY_IntegratedManage..QuestionContent where SurveyQuestionId='{0}' ) ";
                sql = string.Format(sql, id);
                DataHelper.ExecSql(sql);
            }

        }

        private void Create()
        {

            string QcId = string.Empty;//QuestionContent_ID
            string SqId = string.Empty;//SurveyQuestionId
            if (string.IsNullOrEmpty(id))  //创建状态
            {
                SurveyQuestion sq = new SurveyQuestion();
                sq.State = "0"; // 已生成
                sq.DoCreate();
                SqId = sq.Id;

                QuestionContent qc = new QuestionContent();
                qc.SurveyQuestionId = SqId;
                qc.DoCreate();
                QcId = qc.Id;

                this.PageState.Add("date", qc.CreateTime);
                this.PageState.Add("SurveyQuestionId", SqId);
                this.PageState.Add("Id", QcId); //QuestionContent ID
            }
            else  //修改状态
            {
                QuestionContent qc = new QuestionContent();
                qc.SurveyQuestionId = id;
                qc.DoCreate();
                QcId = qc.Id;
                this.PageState.Add("date", qc.CreateTime);
                this.PageState.Add("Id", QcId); //QuestionContent  ID  
            }
        }


        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(id))
            {
                string sql = @"select * from BJKY_IntegratedManage..QuestionContent 
                            where SurveyQuestionId='{0}'  order by SortIndex";
                sql = string.Format(sql, id);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
                if (ent == null) return;

                string[] typeArr = string.IsNullOrEmpty(ent.PowerType) ? new string[] { "" } : ent.PowerType.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                for (int i = 0; i < typeArr.Length; i++)
                {
                    if (typeArr[i] == "person")
                    {
                        string PersonSql = @"with T as (
	                             select F1 as ID from  fun_splitstr((select top 1 StatisticsPower from BJKY_IntegratedManage..SurveyQuestion where Id='{0}') ,','))  
                               select A.UserID as Id, A.Name from BJKY_Portal..SysUser As A,T where A.UserID=T.ID";
                        PersonSql = string.Format(PersonSql, id);
                        PageState.Add("DataListPerson", DataHelper.QueryDictList(PersonSql));//DataListDept
                    }
                    if (typeArr[i] == "dept")
                    {
                        string DeptSql = @"with T as (
	                                select F1 as ID from  fun_splitstr((select top 1 ScanPower from BJKY_IntegratedManage..SurveyQuestion where Id='{0}') ,',') )  
                               select A.GroupID as Id, A.Name from BJKY_Portal..SysGroup As A,T where A.GroupID=T.ID";

                        DeptSql = string.Format(DeptSql, id);
                        this.PageState.Add("DataListDept", DataHelper.QueryDictList(DeptSql));
                    }
                }
            }
        }

        private void DoBatchDel()/*批量删除*/
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                QuestionContent.DoBatchDelete(idList.ToArray());
            }
        }

        private void SaveDetail(SurveyQuestion isEnt)
        {
            string temp = string.Empty;
            IList<string> entStrList = RequestData.GetList<string>("data");
            if (entStrList != null && entStrList.Count > 0)
            {
                IList<QuestionContent> Ents = entStrList.Select(tent => JsonHelper.GetObject<QuestionContent>(tent) as QuestionContent).ToList();
                foreach (QuestionContent subItem in Ents)
                {
                    subItem.DoUpdate();
                }
            }

            string deptId = RequestData["Dept"] + "";
            string PersonId = RequestData["PersonId"] + "";
            string PowerType = RequestData["PowerType"] + "";
            if (!string.IsNullOrEmpty(PowerType) || deptId != "" || PersonId != "")
            {
                isEnt.ScanPower = deptId;
                isEnt.StatisticsPower = PersonId;
                isEnt.PowerType = PowerType;
                isEnt.DoUpdate();
            }
        }


    }
}

