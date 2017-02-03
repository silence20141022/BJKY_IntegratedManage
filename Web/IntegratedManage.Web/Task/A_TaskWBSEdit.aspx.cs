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
using System.Data;
using IntegratedManage.Web;
using Aim.WorkFlow;

namespace Aim.AM.Web
{
    public partial class A_TaskWBSEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型  
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            A_TaskWBS ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<A_TaskWBS>();
                    if (this.RequestData.Get<string>("issubmit", "") != "")
                    {
                        ent.State = "1";
                        ent.SubmitDate = DateTime.Now;
                        ent.SubmitUserId = this.UserInfo.UserID;
                        ent.SubmitUserName = this.UserInfo.Name;
                    }
                    ent.Update();
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<A_TaskWBS>();
                    ent.CreateId = this.UserInfo.UserID;
                    ent.CreateName = this.UserInfo.Name;
                    ent.CreateTime = DateTime.Now;
                    if (this.RequestData.Get<string>("issubmit", "") != "")
                    {
                        ent.State = "1";
                    }
                    if (ent.TaskType == null) ent.TaskType = "任务";
                    if (String.IsNullOrEmpty(id))
                    {
                        ent.CreateAsRoot();
                    }
                    else
                    {
                        ent.State = "0";
                        if (this.RequestData.Get<string>("issubmit", "") != "")
                        {
                            ent.State = "1";
                        }
                        ent.CreateAsSibling(id);
                    }
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<A_TaskWBS>();
                    ent.Delete();
                    return;
                default:
                    if (RequestActionString == "createsub")
                    {
                        ent = this.GetPostedData<A_TaskWBS>();
                        ent.State = "0";
                        if (this.RequestData.Get<string>("issubmit", "") != "")
                        {
                            ent.State = "1";
                            ent.SubmitDate = DateTime.Now;
                            ent.SubmitUserId = this.UserInfo.UserID;
                            ent.SubmitUserName = this.UserInfo.Name;
                        }
                        ent.TaskType = this.RequestData.Get<string>("TaskType");
                        ent.CreateId = this.UserInfo.UserID;
                        ent.CreateName = this.UserInfo.Name;
                        ent.CreateTime = DateTime.Now;
                        ent.Year = DateTime.Now.Year.ToString();
                        ent.CreateAsChild(id);
                        this.SetMessage("新建成功！");
                    }
                    else if (RequestActionString == "submitfinish")
                    {
                        if (this.RequestData.Get<string>("id") != null)
                        {
                            ent = A_TaskWBS.Find(id);
                            ent.State = "2";
                            ent.FactEndDate = DateTime.Now;
                            ent.Save();
                        }
                    }
                    else if (RequestActionString == "GetNextUsers")
                    {
                        ent = A_TaskWBS.Find(id);
                        A_TaskWBS ptEnt = A_TaskWBS.TryFind(ent.ParentID);
                        PageState.Add("NextUsers", new string[] { ptEnt.DutyId, ptEnt.DutyName });
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = A_TaskWBS.Find(id);
                    if (ent.Parent != null)
                    {
                        this.PageState.Add("ParentNode", ent.Parent);
                    }
                    string sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' and Ext1 is null order by FinishTime asc";
                    sql = string.Format(sql, ent.Id);
                    IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                    PageState.Add("Opinion", taskDics);
                    try
                    {
                        string sqlUsers = "select UserID,UserName from dbo.View_SysUserGroup where ParentId='" + ent.DeptId + "' and ChildDeptName='所（处、部）长'";
                        DataTable dt = DataHelper.QueryDataTable(sqlUsers);
                        if (dt.Rows.Count > 0)
                        {
                            this.PageState.Add("DeptLeaderUserId", dt.Rows[0]["UserID"].ToString());
                            this.PageState.Add("DeptLeaderUserName", dt.Rows[0]["UserName"].ToString());
                        }
                    }
                    catch { }
                }

                this.SetFormData(ent);
            }
            else if (op == "cs")
            {
                if (this.RequestData.Get<string>("id") != null)
                {
                    ent = A_TaskWBS.Find(id);
                    A_TaskWBS nt = new A_TaskWBS();
                    //加上默认的序号等数据
                    nt.Code = ent.Code + "-" + (A_TaskWBS.FindAllByProperties(A_TaskWBS.Prop_ParentID, id).Length + 1).ToString();
                    nt.LeaderName = ent.LeaderName;
                    nt.LeaderId = ent.LeaderId;
                    nt.DeptId = ent.DeptId;
                    nt.DeptName = ent.DeptName;
                    nt.PlanEndDate = ent.PlanEndDate;
                    nt.SecondDeptIds = ent.SecondDeptIds;
                    nt.SecondDeptNames = ent.SecondDeptNames;
                    this.SetFormData(nt);
                }
            }
            string taskId = RequestData.Get<string>("TaskId");
            if (!string.IsNullOrEmpty(taskId))
            {
                Task tEnt = Task.Find(taskId);
                if (tEnt.Status != 4 && !string.IsNullOrEmpty(tEnt.Description))
                {
                    PageState.Add("UnSubmitOpinion", tEnt.Description);
                }
            }
        }
    }
}

