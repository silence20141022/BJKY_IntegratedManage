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
using NHibernate.Criterion;
using IntegratedManage.Web;

namespace Aim.AM.Web
{
    public partial class A_ChargeProgresEdit : IMBasePage
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

            A_ChargeProgres ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<A_ChargeProgres>();
                    ent.DoUpdate();
                    A_TaskWBS tb = A_TaskWBS.Find(ent.TaskId);
                    tb.TaskProgress = float.Parse(ent.Progress);
                    /*if (int.Parse(tb.TaskProgress.ToString()).Equals(100))
                    {
                        tb.State = "2";
                        tb.FactEndDate = ent.CreateTime;
                    }
                    else
                        tb.State = "1";*/
                    tb.Save();
                    CalculateRates(tb);
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<A_ChargeProgres>();
                    ent.CreateId = this.UserInfo.UserID;
                    ent.CreateName = this.UserInfo.Name;
                    ent.CreateTime = DateTime.Now;
                    ent.DoCreate();
                    A_TaskWBS tb1 = A_TaskWBS.Find(ent.TaskId);
                    tb1.TaskProgress = float.Parse(ent.Progress);
                    /*if (int.Parse(tb1.TaskProgress.ToString()).Equals(100))
                    {
                        tb1.State = "2";
                        tb1.FactEndDate = ent.CreateTime;
                    }
                    else
                        tb1.State = "1";*/
                    tb1.Save();
                    CalculateRates(tb1);
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<A_ChargeProgres>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
                default:
                    if (RequestActionString == "charge")
                    {
                        A_TaskWBS[] charges = A_TaskWBS.FindAll(Expression.Eq(A_TaskWBS.Prop_ParentID, this.RequestData.Get<string>("TaskId")), Expression.Not(Expression.Eq(A_TaskWBS.Prop_State, "2")));
                        if (charges.Length > 0)
                        {
                            this.PageState.Add("Finish", "false");
                        }
                        else
                            this.PageState.Add("Finish", "true");
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = A_ChargeProgres.Find(id);
                }

                this.SetFormData(ent);
            }
            else
            {
                this.PageState.Add("TaskModel", A_TaskWBS.Find(this.RequestData.Get<string>("TaskId")));
            }
        }

        private void CalculateRates(A_TaskWBS task)
        {
            string path = task.Path;
            string[] paths = path.Split('.').Reverse().ToArray();
            foreach (string ph in paths)
            {
                string sql = @"update a_taskwbs set taskProgress=(select round(sum(taskProgress*balance)/100,0) from 
a_taskwbs where ParentId='{0}' ) where Id='{0}'";
                DataHelper.ExecSql(string.Format(sql, ph), DataHelper.GetCurrentDbConnection(typeof(A_TaskAttachment)));
            }
        }

        #endregion
    }
}

