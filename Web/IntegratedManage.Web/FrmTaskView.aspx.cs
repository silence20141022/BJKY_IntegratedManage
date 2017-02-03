using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using System.Data.SqlClient;
using Aim.Data;

namespace IntegratedManage.Web
{
    public partial class FrmTaskView : BaseListPage
    {
        public FrmTaskView()
        {
            base.IsCheckLogon = false;
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            PageState.Add("taskUrl", System.Configuration.ConfigurationManager.AppSettings["taskUrl"]);
            if (UserInfo != null)
            {
                string sql = @"select top 5 Id,Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,RelateName,System,Type,ExecUrl,RelateType,OwnerUserId,convert(varchar(10),CreatedTime,20) as NewDate from (
                                select * from (
                                select top 5 Id,Title,WorkFlowInstanceId,WorkFlowName,ApprovalNodeName,CreatedTime,'' RelateName,'' System,'' Type,'' ExecUrl,'' RelateType,'' OwnerUserId from Task where status=0 and OwnerId='{0}' order by CreatedTime desc
                                ) a
                                union all
                                select * from (
                                select top 5 Id,TaskName Title,FlowId WorkFlowInstanceId,FlowName WorkFlowName,TaskName ApprovalNodeName,CreateTime,RelateName,System,Type,
                                ExecUrl,RelateType,OwnerUserId from BJKY_BeAdmin..WfWorkList where (State='New') and IsSign='{0}' order by Id Desc) b
                                ) a order by Createdtime desc";

                sql = string.Format(sql, UserInfo.UserID);
                DataTable dttask = DataHelper.QueryDataTable(sql);
                if (dttask.Rows.Count == 0)
                {
                    litdetail1.Text = "没有数据!";
                    return;
                }
                foreach (DataRow row in dttask.Rows)
                {
                    litdetail1.Text += "<div class='center-second-up-new'><div class='new-img'><img src='/images/center/little.png' /></div><div class='new-font-family' style='cursor: pointer;' onclick='OpenNews(\"/WorkFlow/TaskExecute.aspx?TaskId=" + row["Id"] + "&op=r\")'>" +
                        row["ApprovalNodeName"] + "</div><div class='new-date'>" + row["NewDate"] + "</div></div>";
                }

                //divcontent2
                sql = @"select top 5 t.Id,Title,t.WorkFlowName,ApprovalNodeName,CONVERT(VARCHAR(10), CreatedTime, 20) as NewDate, CreatedTime from Task t 
                        where t.status<>0 and OwnerId='{0}' order by FinishTime desc,CreatedTime desc";

                sql = string.Format(sql, UserInfo.UserID);
                dttask = DataHelper.QueryDataTable(sql);
                if (dttask.Rows.Count == 0)
                {
                    litdetail2.Text = "没有数据!";
                    return;
                }
                foreach (DataRow row in dttask.Rows)
                {
                    litdetail2.Text += "<div class='center-second-up-new'><div class='new-img'><img src='/images/center/little.png' /></div><div class='new-font-family' style='cursor: pointer;' onclick='OpenNews(\"/WorkFlow/TaskExecute.aspx?TaskId=" + row["Id"] + "&op=r\")'>" +
                        row["ApprovalNodeName"] + "</div><div class='new-date'>" + row["NewDate"] + "</div></div>";
                }
            }
            else
            {
                litdetail1.Text = "没有数据!";
                litdetail2.Text = "没有数据!";
            }
        }

        public DataTable GetData(string sql, string constr)
        {
            DataTable dt = new DataTable();
            SqlDataAdapter dap = new SqlDataAdapter(sql, constr);
            dap.Fill(dt);
            dap.Dispose();
            return dt;
        }

        public string jie(string v, string l)
        {
            string val = v;
            int len = Convert.ToInt32(l);
            if (v.Length > len)
            {
                val = v.Substring(0, len) + "...";
            }
            return val;
        }
    }
}
