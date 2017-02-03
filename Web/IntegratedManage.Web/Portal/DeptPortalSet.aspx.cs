using System;
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
using Castle.ActiveRecord.Queries;

namespace IntegratedManage.Web.Portal
{
    public partial class DeptPortalSet : BaseListPage
    {
        private SysGroup[] ents = null;
        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表 

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");

            SysGroup ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Custom:
                    if (RequestActionString == "querychildren")
                    {
                        if (String.IsNullOrEmpty(id))
                        {
                            ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ParentId is null and (Type = 2 or Type = 3) Order By SortIndex asc");
                            this.PageState.Add("DtList", ents);
                        }
                        else
                        {
                            string sql = @"
select g.*,w.Id WId from SysGroup g left join 
WebPartTemplate w on g.GroupID=w.BaseTemplateId WHERE ParentId = '" + id + "' and (g.Type = 2 or g.Type = 3) Order By SortIndex asc";
                            DataHelper.QueryDictList(sql);
                            //ents = SysGroup.FindAll("FROM SysGroup as ent WHERE g.ParentId = '" + id + "' and (Type = 2 or Type = 3) Order By SortIndex asc");
                            this.PageState.Add("DtList", DataHelper.QueryDictList(sql));
                        }
                    }
                    else if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");
                        if (idList != null && idList.Count > 0)
                        {
                            SysGroup.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (RequestActionString == "c")
                    {
                        DoCreateSubByRole();
                    }
                    else if (RequestActionString == "open")
                    {
                        if (id != "")
                        {
                            SimpleQuery query = new SimpleQuery(typeof(WebPartTemplate), "FROM WebPartTemplate WHERE BaseTemplateId='" + id + "' AND UserId IS NULL AND BlockType='DeptPortal'");
                            if (((WebPartTemplate[])WebPartTemplate.ExecuteQuery(query)).Length == 0)
                            {
                                query = new SimpleQuery(typeof(WebPartTemplate), "FROM WebPartTemplate WHERE Type IS NULL AND UserId IS NULL AND BlockType='Portal'");
                                WebPartTemplate wpT = ((WebPartTemplate[])WebPartTemplate.ExecuteQuery(query))[0];
                                WebPartTemplate wp = new WebPartTemplate();
                                wp.BaseTemplateId = wpT.Id;
                                wp.Type = "";
                                wp.BlockType = "DeptPortal";
                                wp.BaseTemplateId = id;
                                wp.IsDefault = "T";
                                wp.TemplateColWidth = wpT.TemplateColWidth;
                                wp.TemplateString = "";
                                wp.TemplateXml = "<List></List>";
                                wp.GlobalColor = wpT.GlobalColor;
                                wp.GlobalColorValue = wpT.GlobalColorValue;
                                wp.Save();
                            }
                        }
                    }
                    else if (RequestActionString == "close")
                    {
                        if (id!="")
                        {
                            WebPartTemplate wp = WebPartTemplate.FindAllByProperties(WebPartTemplate.Prop_BaseTemplateId, id)[0];
                            wp.Delete();
                        }
                    }
                    break;
                default:
                    //SysGroup[] grpList = SysGroup.FindAll("From SysGroup as ent where ParentId is null and (Type = 2 or Type = 21) Order By SortIndex Desc");
                    string sqls = @"
select g.*,w.Id WId from SysGroup g left join 
WebPartTemplate w on g.GroupID=w.BaseTemplateId where g.ParentId is null and (g.Type = 2 or g.Type = 21) Order By SortIndex Desc";
                    this.PageState.Add("DtList", DataHelper.QueryDictList(sqls));
                    break;
            }
        }

        #endregion

        #region 私有方法

        [ActiveRecordTransaction]
        private void DoCreateSubByRole()
        {
            IList<string> idList = RequestData.GetList<string>("IdList");
            SysGroup tent = SysGroup.Find(id);

            if (idList != null && idList.Count > 0)
            {
                SysRole[] duties = SysRole.FindAllByPrimaryKeys(idList.ToArray());

                foreach (SysRole tduty in duties)
                {
                    if (!SysGroup.Exists("Name=? and Type=21 and ParentID = ?", tduty.Name, tent.ID))
                    {
                        SysGroup tgrp = new SysGroup()
                        {
                            Name = tduty.Name,
                            Code = tduty.Code,
                            Type = 3,   //角色
                            Status = 1,
                            SortIndex = 9999,
                            CreateDate = DateTime.Now
                        };

                        tgrp.CreateAsChild(tent);
                    }
                }
            }

        }

        #endregion
    }
}
