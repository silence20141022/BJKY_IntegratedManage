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
using System.Configuration;
using IntegratedManage.Model;
using Aim;
using Aim.WorkFlow;

namespace IntegratedManage.Web
{
    public partial class ReceiveDocumentEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        ReceiveDocument ent = null;
        string sql = "";
        string nextName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ReceiveDocument.Find(id);
            }
            nextName = RequestData.Get<string>("nextName");
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<ReceiveDocument>();
                    ent.DoUpdate();
                    PageState.Add("Id", ent.Id);
                    break;
                case "ConfirmYuanZhang":
                    ent.YuanZhangId = RequestData.Get<string>("YuanZhangId");
                    ent.YuanZhangName = RequestData.Get<string>("YuanZhangName");
                    ent.DoUpdate();
                    break;
                case "GetNextUsers":
                    PageState.Add("NextUsers", GetNextUser(nextName));
                    break;
                case "create":
                    ent = GetPostedData<ReceiveDocument>();
                    ent.DoCreate();
                    PageState.Add("Id", ent.Id);
                    break;
                case "submit":
                    StartFlow();
                    break;
                case "AutoExecuteFlow":
                    AutoExecuteFlow();
                    break;
                case "submitfinish":
                    //院办文书结束后设置文档为归档状态
                    ent = ReceiveDocument.Find(id);
                    ent.State = "已归档";
                    ent.ApproveResult = RequestData.Get<string>("ApprovalState");
                    ent.WorkFlowState = RequestData.Get<string>("state");
                    ent.DoUpdate();
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (op != "c" && op != "cs")
            {
                ent = ReceiveDocument.Find(id);
                sql = @"select * from FileItem where PatIndex('%'+Id+'%','{0}')>0 order by CreateTime desc";
                sql = string.Format(sql, ent.MainFile);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
                sql = @"select * from FileItem where PatIndex('%'+Id+'%','{0}')>0 order by CreateTime desc";
                sql = string.Format(sql, ent.Attachment);
                PageState.Add("DataList2", DataHelper.QueryDictList(sql));
                sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' and Ext1 is null order by FinishTime asc";
                sql = string.Format(sql, id);
                IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                PageState.Add("Opinion", taskDics);
            }
            else
            {
                ent = new ReceiveDocument();
                ent.ReceiveDate = System.DateTime.Now.Date;
            }
            SetFormData(ent);
            string taskId = RequestData.Get<string>("TaskId");
            if (!string.IsNullOrEmpty(taskId))
            {
                Task tEnt = Task.Find(taskId);
                if (tEnt.Status != 4 && !string.IsNullOrEmpty(tEnt.Description))
                {
                    PageState.Add("UnSubmitOpinion", tEnt.Description);
                }
            }
            PageState.Add("ReceiveType", SysEnumeration.GetEnumDict("ReceiveType"));
            PageState.Add("SecrecyDegree", SysEnumeration.GetEnumDict("SecrecyDegree"));
            sql = "select * from BJKY_IntegratedManage..BringUnit";
            PageState.Add("ImportanceDegree", SysEnumeration.GetEnumDict("ImportanceDegree"));
        }
        private void StartFlow()
        {
            ArrayList array = new ArrayList();
            string state = RequestData.Get<string>("state");
            string formUrl = "/DocumentManage/ReceiveDocumentEdit.aspx?op=v&&id=" + id;
            Guid guid = new Guid();
            if (ent.ApprovalNodeName == "院办主任")
            {
                guid = WorkFlow.StartWorkFlow(id, formUrl, "收文审批", "ReceiveDocumentI", UserInfo.UserID, UserInfo.Name);
                IList<IntegratedConfig> icEnts = IntegratedConfig.FindAll();
                array.Add(guid + "#" + icEnts[0].YuanBanZhuRenId + "$" + icEnts[0].YuanBanZhuRenName);
            }
            else
            {
                guid = WorkFlow.StartWorkFlow(id, formUrl, "收文审批", "ReceiveDocumentII", UserInfo.UserID, UserInfo.Name);
                array.Add(guid + "#" + ent.YuanZhangId + "$" + ent.YuanZhangName);
            }
            PageState.Add("WorkFlowInfo", array);
            ent.WorkFlowState = state;
            ent.DoUpdate();
        }
        private void AutoExecuteFlow()
        {
            IList<string> workFlowInfo = RequestData.GetList<string>("WorkFlowInfo");
            string instanceId = string.Empty;
            foreach (string str in workFlowInfo)
            {
                string[] strarray = str.Split(new string[] { "#" }, StringSplitOptions.RemoveEmptyEntries);
                instanceId = strarray[0];
                string[] userarray = null;
                if (strarray.Length > 1)
                {
                    if (!string.IsNullOrEmpty(strarray[1]))
                    {
                        userarray = strarray[1].Split(new string[] { "$" }, StringSplitOptions.RemoveEmptyEntries);
                    }
                }
                IList<Task> tasks = Task.FindAllByProperty(Task.Prop_WorkflowInstanceID, instanceId);
                Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], ent.ApprovalNodeName, userarray);
            }
        }
        private string[] GetNextUser(string nextName)
        {
            IList<IntegratedConfig> icEnts = IntegratedConfig.FindAll();
            string[] userInfo = new string[] { };
            switch (nextName)
            {
                case "提交主管院长":
                    userInfo = new string[] { ent.YuanZhangId, ent.YuanZhangName };
                    break;
                case "打回院办主任":
                    userInfo = new string[] { icEnts[0].YuanBanZhuRenId, icEnts[0].YuanBanZhuRenName };
                    break;
                case "提交院办文书":
                    userInfo = new string[] { ent.CreateId, ent.CreateName };
                    break;
            }
            return userInfo;
        }
    }
}

