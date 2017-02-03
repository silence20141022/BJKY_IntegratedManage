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

namespace IntegratedManage.Web
{
    public partial class IntegratedConfigEdit : IMBasePage
    {
        string id = String.Empty;   // 对象id   
        IntegratedConfig ent = null;
        InstituteLeader ilEnt = null;
        SysUser suEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id");
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<IntegratedConfig>();
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = GetPostedData<IntegratedConfig>();
                    ent.DoCreate();
                    break;
                case "AddLeader":
                    IList<string> userIds = RequestData.GetList<string>("UserIds");
                    IList<InstituteLeader> ilEnts = new List<InstituteLeader>(); 
                    foreach (string userId in userIds)
                    {
                        ilEnt = new InstituteLeader();
                        ilEnt.UserId = userId;
                        ilEnt.UserName = SysUser.Find(userId).Name;
                        string sql = @"select top 1 case [Type] when 3 then ParentDeptName when 2 then ChildDeptName end as DeptName,
                        case [Type] when 3 then ParentId when 2 then DeptId end as DeptId
                        from View_SysUserGroup where UserId='{0}'";
                        sql = string.Format(sql, userId);
                        IList<EasyDictionary> deptDics = DataHelper.QueryDictList(sql);
                        if (deptDics.Count > 0)
                        {
                            ilEnt.DeptId = deptDics[0].Get<string>("DeptId");
                            ilEnt.DeptName = deptDics[0].Get<string>("DeptName");
                        }
                        ilEnt.DoCreate();
                        ilEnts.Add(ilEnt);
                    }
                    PageState.Add("ilEnts", ilEnts);
                    break;
                case "UpdateSortIndex":
                    ilEnt = InstituteLeader.Find(RequestData.Get<string>("InstituteLeaderId"));
                    ilEnt.SortIndex = RequestData.Get<int>("SortIndex");
                    ilEnt.DoUpdate();
                    break;
                case "UpdateUser":
                    suEnt = SysUser.Find(RequestData.Get<string>("UserId"));
                    suEnt.Email = RequestData.Get<string>("Email");
                    suEnt.Phone = RequestData.Get<string>("Phone");
                    suEnt.DoUpdate();
                    break;
                case "delete":
                    IList<string> instituteLeaderIds = RequestData.GetList<string>("InstituteLeaderIds");
                    foreach (string instituteLeaderId in instituteLeaderIds)
                    {
                        ilEnt = InstituteLeader.Find(instituteLeaderId);
                        ilEnt.DoDelete();
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            IList<IntegratedConfig> scEnts = IntegratedConfig.FindAll();
            if (scEnts.Count > 0)
            {
                SetFormData(scEnts[0]);
            }
            string sql = @"SELECT A.*,B.Email,B.Phone FROM BJKY_IntegratedManage..InstituteLeader as A
            left join BJKY_Portal..SysUser as B on A.UserId=B.UserId ORDER BY A.SortIndex";
            PageState.Add("DataList", DataHelper.QueryDictList(sql));
        }
    }
}

