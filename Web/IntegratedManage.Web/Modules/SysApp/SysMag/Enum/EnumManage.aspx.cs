﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;
using NHibernate.Criterion;

using Aim.Data;
using Aim.Common;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;


namespace Aim.Portal.Web.Modules.SysApp.SysMag
{
    public partial class EnumManage : BaseListPage
    {
        #region 属性

        private SysEnumeration[] ents = null;

        #endregion

        #region 变量

        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表
        string code = String.Empty; // 对象编码

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");
            code = RequestData.Get<string>("code", String.Empty);

            SysEnumeration ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<SysEnumeration>();
                    ent.ParentID = String.IsNullOrEmpty(ent.ParentID) ? null : ent.ParentID;
                    ent.Update();
                    this.SetMessage("更新成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");
                        if (idList != null && idList.Count > 0)
                        {
                            SysEnumeration.DoBatchDelete(idList.ToArray());
                        }
                    }
                    if (RequestActionString == "paste")
                    {
                        DoPaste();
                    }
                    else
                    {
                        DoSelect();
                    }

                    break;
            }
        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 选择数据
        /// </summary>
        private void DoSelect()
        {
            // 构建查询表达式
            SearchCriterion sc = new HqlSearchCriterion();

            sc.SetOrder("SortIndex");

            ICriterion crit = null;

            if (RequestActionString == "querychildren")
            {
                if (ids != null && ids.Count > 0 || pids != null && pids.Count > 0)
                {
                    if (ids != null && ids.Count > 0)
                    {
                        IEnumerable<string> distids = ids.Distinct().Where(tent => !String.IsNullOrEmpty(tent));
                        crit = Expression.In(SysEnumeration.Prop_EnumerationID, distids.ToArray());
                    }

                    if (pids != null && pids.Count > 0)
                    {
                        IEnumerable<string> dispids = pids.Distinct().Where(tent => !String.IsNullOrEmpty(tent));

                        if (crit != null)
                        {
                            crit = SearchHelper.UnionCriterions(crit, Expression.In(SysEnumeration.Prop_ParentID, dispids.ToArray()));
                        }
                        else
                        {
                            crit = Expression.In(SysEnumeration.Prop_ParentID, dispids.ToArray());
                        }
                    }
                }
            }
            else
            {
                if (!String.IsNullOrEmpty(code))
                {
                    SysEnumeration tent = SysEnumeration.FindFirstByProperties(SysEnumeration.Prop_Code, code);
                    crit = Expression.Eq(SysEnumeration.Prop_ParentID, tent.EnumerationID);
                }
                else
                {
                    crit = SearchHelper.UnionCriterions(Expression.IsNull(SysEnumeration.Prop_ParentID),
                        Expression.Eq(SysEnumeration.Prop_ParentID, String.Empty));
                }
            }

            if (crit != null)
            {
                ents = SysEnumerationRule.FindAll(sc, crit);
            }
            else
            {
                ents = SysEnumerationRule.FindAll(sc);
            }

            if (ents != null && ents.Length != 0)
            {
                this.PageState.Add("DtList", ents.OrderBy(v => v.SortIndex));
            }
        }

        /// <summary>
        /// 粘贴
        /// </summary>
        [ActiveRecordTransaction]
        private void DoPaste()
        {
            IList<string> idList = RequestData.GetList<string>("IdList");
            string type = RequestData.Get<string>("type", String.Empty);
            string tid = RequestData.Get<string>("tid", String.Empty);  // 目标节点id
            string pdstype = RequestData.Get<string>("pdstype", String.Empty);  // 粘贴数据来源类型

            if (!String.IsNullOrEmpty(tid))
            {
                SysEnumeration target = SysEnumeration.Find(tid);

                PasteDataSourceEnum pdsenum = PasteDataSourceEnum.Unknown;
                PasteAsEnum paenum = PasteAsEnum.Other;
                
                if (pdstype == "cut")
                {
                    pdsenum = PasteDataSourceEnum.Cut;
                }
                else if (pdstype == "copy")
                {
                    pdsenum = PasteDataSourceEnum.Copy;
                }

                if (type == "sib")
                {
                    paenum = PasteAsEnum.Sibling;
                }
                else if (type == "sub")
                {
                    paenum = PasteAsEnum.Child;
                }

                if (pdsenum != PasteDataSourceEnum.Unknown && paenum != PasteAsEnum.Other)
                {
                    // 粘贴操作
                    SysEnumeration.DoPaste(pdsenum, paenum, tid, idList.ToArray());
                }
            }
        }

        #endregion
    }
}
