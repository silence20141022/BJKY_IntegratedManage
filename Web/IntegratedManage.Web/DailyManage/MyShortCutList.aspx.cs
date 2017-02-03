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
    public partial class MyShortCutList : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id    
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            switch (RequestActionString)
            {
                //case "update":
                //    ent = GetMergedData<ReceiveDocument>();
                //    ent.DoUpdate();
                //    PageState.Add("Id", ent.Id);
                //    break;
                //case "ConfirmYuanZhang":
                //    ent.YuanZhangId = RequestData.Get<string>("YuanZhangId");
                //    ent.YuanZhangName = RequestData.Get<string>("YuanZhangName");
                //    ent.DoUpdate();
                //    break; 
                //case "create":
                //    ent = GetPostedData<ReceiveDocument>();
                //    ent.DoCreate();
                //    PageState.Add("Id", ent.Id);
                //    break; 
                //case "submitfinish":
                //    //院办文书结束后设置文档为归档状态
                //    ent = ReceiveDocument.Find(id);
                //    ent.State = "已归档";
                //    ent.ApproveResult = RequestData.Get<string>("ApprovalState");
                //    ent.WorkFlowState = RequestData.Get<string>("state");
                //    ent.DoUpdate();
                //    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            sql = @"select * from BJKY_IntegratedManage..MyShortCut where CreateId='{0}' order by SortIndex asc";
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("DataList", DataHelper.QueryDictList(sql));
            //if (op != "c" && op != "cs")
            //{
            //    ent = ReceiveDocument.Find(id);
            //    SetFormData(ent);
            //    sql = @"select * from FileItem where PatIndex('%'+Id+'%','{0}')>0 order by CreateTime desc";
            //    sql = string.Format(sql, ent.MainFile);
            //    PageState.Add("DataList", DataHelper.QueryDictList(sql));
            //    sql = @"select * from FileItem where PatIndex('%'+Id+'%','{0}')>0 order by CreateTime desc";
            //    sql = string.Format(sql, ent.Attachment);
            //    PageState.Add("DataList2", DataHelper.QueryDictList(sql));
            //    sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' order by FinishTime asc";
            //    sql = string.Format(sql, id);
            //    IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
            //    PageState.Add("Opinion", taskDics);
            //}
            //            else
            //            {
            //                sql = @"select Id,GroupName from BJKY_Examine..PersonConfig 
            //                      where (ClerkIds like '%{0}%' or SecondLeaderIds like '%{0}%' or FirstLeaderIds like '%{0}%') and (GroupType='职能服务部门' or GroupType='经营目标单位')";
            //                sql = string.Format(sql, UserInfo.UserID);
            //                IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
            //                if (deptDics.Count > 0)
            //                {
            //                    var obj = new
            //                    {
            //                        CreateDeptId = deptDics[0].Get<string>("Id"),
            //                        CreateDeptName = deptDics[0].Get<string>("GroupName"),
            //                        CreateId = UserInfo.UserID,
            //                        CreateName = UserInfo.Name
            //                    };
            //                    SetFormData(obj);
            //                }
            //            }

        }
    }
}

