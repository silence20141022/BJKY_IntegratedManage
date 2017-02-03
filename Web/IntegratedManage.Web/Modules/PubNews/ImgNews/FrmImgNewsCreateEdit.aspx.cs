using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Generic;

using Aim.Common;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Portal.Model;
using Aim.WorkFlow;
using System.Data.SqlClient;

namespace Aim.Portal.Web.Modules
{
    public partial class FrmImgNewsCreateEdit : BasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string typeid = String.Empty;
        ImgNews ent = null;
        string JsonString = "";
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            typeid = RequestData.Get<string>("TypeId");
            JsonString = RequestData.Get<string>("JsonString");
            if (!string.IsNullOrEmpty(id))
            {
                ent = ImgNews.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    if (!string.IsNullOrEmpty(JsonString))
                    {
                        ImgNews tempEnt = JsonHelper.GetObject<ImgNews>(JsonString);
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(JsonString);
                        DataHelper.MergeData<ImgNews>(ent, tempEnt, dic.Keys);
                        ent.SaveAndFlush();
                    }
                    else
                    {
                        ent = GetMergedData<ImgNews>();
                        ent.HomePagePopup = RequestData.Get<string>("HomePagePopup");
                        ent.SaveAndFlush();
                        if (RequestData["param"] + "" == "tj")
                        {
                            PageState.Add("rtnId", ent.Id);
                        }
                    }
                    SaveDetail(ent.Id);
                    InsertCompetence(ent.Id, ent.ReceiveDeptId, ent.ReceiveDeptName);
                    break;
                case "create":
                    ent = this.GetPostedData<ImgNews>();
                    ent.HomePagePopup = RequestData.Get<string>("HomePagePopup");
                    ent.CreateId = UserInfo.UserID;
                    ent.CreateName = UserInfo.Name;
                    ent.CreateTime = DateTime.Now;
                    ent.State = "0";
                    ent.CreateAndFlush();
                    if (RequestData["param"] + "" == "tj")
                    {
                        //ent.State = "1";
                        //提交流程
                        PageState.Add("rtnId", ent.Id);
                    }
                    SaveDetail(ent.Id);
                    InsertCompetence(ent.Id, ent.ReceiveDeptId, ent.ReceiveDeptName);
                    break;
                case "ImportFile":
                    string fileIds = RequestData.Get<string>("fileIds");
                    if (!string.IsNullOrEmpty(fileIds))
                    {
                        sql = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0";
                        sql = string.Format(sql, fileIds);
                        PageState.Add("Result", DataHelper.QueryDictList(sql));
                    }
                    break;
                case "autoexecute":
                    Task[] tasks = Task.FindAllByProperties(Task.Prop_WorkflowInstanceID, this.RequestData.Get<string>("FlowId"));
                    if (tasks.Length == 0)
                    {
                        System.Threading.Thread.Sleep(1000);
                        tasks = Task.FindAllByProperties(Task.Prop_WorkflowInstanceID, this.RequestData.Get<string>("FlowId"));
                    }
                    if (tasks.Length > 0)
                    {
                        this.PageState.Add("TaskId", tasks[0].ID);
                        string AuditUserId = RequestData.Get<string>("AuditUserId");
                        string AuditUserName = RequestData.Get<string>("AuditUserName");
                        if (!string.IsNullOrEmpty(AuditUserId))
                        {
                            Aim.WorkFlow.WorkFlow.AutoExecute(tasks[0], new string[] { AuditUserId, AuditUserName });
                        }
                        else
                        {
                            PageState.Add("error", "自动提交申请人失败，请手动提交");
                        }
                    }
                    else
                    {
                        PageState.Add("error", "自动提交申请人失败，请手动提交");
                    }
                    break;
                case "submitfinish":
                    string ApproveResult = RequestData.Get<string>("ApproveResult");
                    ent = ImgNews.Find(id);
                    ent.WFState = "End";
                    ent.WFResult = ApproveResult;
                    ent.PostUserId = UserInfo.UserID;
                    ent.PostUserName = UserInfo.Name;
                    if (ApproveResult == "同意")
                    {
                        ent.State = "2";
                    }
                    ent.PostTime = DateTime.Now;
                    ent.Update();
                    break;
                case "submit":
                    StartFlow(id);
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            //1 先取当前人所在的部门 一个人可能有多个部门
            sql = @"select GroupId from SysGroup where Type='2' and GroupId in 
                 (select GroupId from SysUserGroup where UserId='{0}')";
            sql = string.Format(sql, ent == null ? UserInfo.UserID : ent.CreateId);
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            string groupids = "";
            foreach (EasyDictionary dic in dics)
            {
                groupids += (string.IsNullOrEmpty(groupids) ? "" : ",") + dic.Get<string>("GroupId");
            }
            //2 取该部门下的角色 且名称是'部门正职', '部门副职', '部门领导'
            sql = @"select GroupId from SysGroup where PatIndex('%'+ParentId+'%','" + groupids + "')>0 and Name in ('部门正职', '部门副职', '部门领导')";
            IList<EasyDictionary> dic2s = DataHelper.QueryDictList(sql);
            groupids = "";
            foreach (EasyDictionary dic2 in dic2s)
            {
                groupids += (string.IsNullOrEmpty(groupids) ? "" : ",") + dic2.Get<string>("GroupId");
            }
            //3 取该角色下所有的人
            sql = @"select UserId,Name from SysUser where UserId In (select UserId from SysUserGroup where PatIndex('%'+GroupId+'%','{0}')>0)";
            sql = string.Format(sql, groupids);
            PageState.Add("AuditEnum", DataHelper.QueryDict(sql, "UserId", "Name"));
            //2 如果是带有图片的发布的院内新闻,需经宣传部审批 取该部门下的角色 且名称是'部门正职', '部门副职', '部门领导'
            sql = @"select GroupId from SysGroup where PatIndex('%'+ParentId+'%','037b894a-198f-47fe-8d05-d8f136362dfa')>0 and Name in ('部门正职', '部门副职', '部门领导')";
            IList<EasyDictionary> dic3s = DataHelper.QueryDictList(sql);
            groupids = "";
            foreach (EasyDictionary dic3 in dic3s)
            {
                groupids += (string.IsNullOrEmpty(groupids) ? "" : ",") + dic3.Get<string>("GroupId");
            }
            //3 取该角色下所有的人
            sql = @"select UserId,Name from SysUser where UserId In (select UserId from SysUserGroup where PatIndex('%'+GroupId+'%','{0}')>0)";
            sql = string.Format(sql, groupids);
            PageState.Add("SecondApproveEnum", DataHelper.QueryDict(sql, "UserId", "Name"));
            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = ImgNews.Find(id);
                    typeid = ent.TypeId;
                    //详细列表数据
                    PageState.Add("DetailList", ImgNewDetail.FindAllByProperty("PId", ent.Id));

                    if (RequestData.Get<string>("InFlow") == "T")
                    {
                        sql = @"select * from Task where PatIndex('%" + ent.Id + "%',EFormName)>0  and Status='4' order by FinishTime asc";
                        IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                        PageState.Add("Opinion", taskDics);
                        string taskId = RequestData.Get<string>("TaskId");//取审批暂存时所填写的意见
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
                SetFormData(ent);
            }
            else
            {
                sql = "select DeptId,ChildDeptName,ParentId,ParentDeptName,len(Path) LenPath from  dbo.View_SysUserGroup where UserId='" + UserInfo.UserID + "' and Type=2";
                DataTable dtt = DataHelper.QueryDataTable(sql);
                if (dtt.Rows.Count > 0)
                {
                    var DeptInfo = new { groupId = dtt.Rows[0]["DeptId"] + "", groupName = dtt.Rows[0]["ChildDeptName"] + "", deptId = dtt.Rows[0]["ParentId"] + "", deptName = dtt.Rows[0]["ParentDeptName"] + "" };
                    PageState.Add("DeptInfo", DeptInfo);
                }
                IList<NewsType> ntEnts = NewsType.FindAllByProperty(NewsType.Prop_TypeName, "图片新闻");
                PageState.Add("TypeId", ntEnts[0].Id);
            } 
        }
        private void SaveDetail(string PId)
        {
            IList<string> entStrList = RequestData.GetList<string>("detail");
            IList<ImgNewDetail> ocdEnts = ImgNewDetail.FindAllByProperty(ImgNewDetail.Prop_PId, ent.Id);
            foreach (ImgNewDetail ocdEnt in ocdEnts)
            {
                ocdEnt.DoDelete();
            }
            if (entStrList != null && entStrList.Count > 0)
            {
                ocdEnts = entStrList.Select(tent => JsonHelper.GetObject<ImgNewDetail>(tent) as ImgNewDetail).ToList();
                for (int i = 0; i < ocdEnts.Count; i++)
                {
                    ocdEnts[i].PId = PId;
                    ocdEnts[i].CreateId = UserInfo.UserID;
                    ocdEnts[i].CreateName = UserInfo.Name;
                    ocdEnts[i].CreateTime = DateTime.Now;
                    ocdEnts[i].DoCreate();
                    if (i == 0)
                    {
                        ent.ShowImg = ocdEnts[i].ImgPath;
                        ent.DoUpdate();
                    }
                }
            }
        }
        private void InsertCompetence(string PId, string strId, string strName)
        {
            string[] ids = strId.Split(',');
            string[] names = strName.Split(',');
            Competence.DeleteAll(" Ext1='" + PId + "' ");
            if (ids.Length > 0)
            {
                for (int i = 0; i < ids.Length; i++)
                {
                    new Competence
                    {
                        PId = ids[i],
                        PName = names[i],
                        Type = "ImgNews",
                        Ext1 = PId
                    }.DoCreate();
                }
            }
        }
        public void StartFlow(string formId)
        {
            ImgNews ent = ImgNews.Find(formId);
            string code = "ImgNewsAudit";
            string formUrl = "/Modules/PubNews/ImgNews/FrmImgNewsCreateEdit.aspx?op=u&id=" + formId;
            Guid guid = Aim.WorkFlow.WorkFlow.StartWorkFlow(formId, formUrl, "信息发布【" + ent.Title + "】申请人【" + ent.CreateName + "】", code, ent.CreateId, ent.CreateName);
            //返回流程的Id
            PageState.Add("FlowId", guid.ToString());
            ent.WFState = "Flowing";
            ent.WFResult = "";
            ent.Save();
        }
    }
}
