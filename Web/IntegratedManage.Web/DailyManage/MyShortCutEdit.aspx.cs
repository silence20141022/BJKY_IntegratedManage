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
    public partial class MyShortCutEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        MyShortCut ent = null;
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            string AuthIds = RequestData.Get<string>("AuthIds");
            if (!string.IsNullOrEmpty(id))
            {
                ent = MyShortCut.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<MyShortCut>();
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = GetPostedData<MyShortCut>();
                    sql = @"delete from BJKY_IntegratedManage..MyShortCut where CreateId='{0}' and PatIndex('%'+AuthId+'%','{1}')>0";
                    sql = string.Format(sql, UserInfo.UserID, ent.AuthId);
                    DataHelper.ExecSql(sql);//删除快捷中已经存在权限模块ID
                    if (ent.AuthId.Length > 36)
                    {
                        string[] authIdArray = ent.AuthId.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        string[] authNameArray = ent.AuthName.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < authIdArray.Length; i++)
                        {
                            MyShortCut mscEnt = new MyShortCut();
                            mscEnt.AuthId = authIdArray[i];
                            mscEnt.AuthName = authNameArray[i];
                            SysAuth saEnt = SysAuth.Find(ent.AuthId);
                            SysModule smEnt = SysModule.Find(saEnt.ModuleID);
                            mscEnt.ModuleUrl = smEnt.Url;
                            mscEnt.IconFileId = ent.IconFileId;
                            mscEnt.IconFileName = ent.IconFileName;
                            mscEnt.DoCreate();
                        }
                    }
                    else
                    {
                        SysAuth saEnt = SysAuth.Find(ent.AuthId);
                        SysModule smEnt = SysModule.Find(saEnt.ModuleID);
                        ent.ModuleUrl = smEnt.Url;
                        ent.DoCreate();
                    }
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
                SetFormData(ent);
                //                sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and Status='4' and ApprovalNodeName in('部门领导','相关部门会签','院办主任','归口部门会签','主管院长','院办主任核稿') 
                //                order by FinishTime asc";
                //                sql = string.Format(sql, id);
                //                IList<EasyDictionary> taskDics = DataHelper.QueryDictList(sql);
                //                PageState.Add("Opinion", taskDics);
                //                sql = @"select  * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0 ";
                //                sql = string.Format(sql, ent.ApproveContent);
                //                PageState.Add("DataList", DataHelper.QueryDictList(sql));
                //                sql = @"select  * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0 ";
                //                sql = string.Format(sql, ent.Attachment);
                //                PageState.Add("DataList2", DataHelper.QueryDictList(sql));
            }
        }
    }
}

