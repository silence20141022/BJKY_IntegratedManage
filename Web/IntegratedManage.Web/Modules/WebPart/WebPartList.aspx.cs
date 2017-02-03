using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using NHibernate.Criterion;

namespace Aim.Portal.Web
{
    public partial class WebPartList : BaseListPage
    {
        #region 属性

        #endregion

        #region 变量

        private Aim.Portal.Model.WebPart[] ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            SearchCriterion.SetOrder("BlockType");
            if (!string.IsNullOrEmpty(this.RequestData.Get<string>("BlockType")))
            {
                ents = WebPartRule.FindAll(SearchCriterion, Expression.Eq("BlockType", this.RequestData.Get<string>("BlockType")));
            }
            else
                ents = WebPartRule.FindAll(SearchCriterion, Expression.Eq("BlockType", "portal"));

            this.PageState.Add("WebPartList", ents);
            this.PageState.Add("BlockType", SysEnumeration.GetEnumDict("BlockType"));

            Aim.Portal.Model.WebPart ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Insert:
                    ent = this.GetPostedData<Aim.Portal.Model.WebPart>();
                    ent.Create();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<Aim.Portal.Model.WebPart>();
                    ent.Update();
                    this.SetMessage("保存成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Aim.Portal.Model.WebPart>();
                    ent.Delete();
                    this.SetMessage("删除成功！");
                    break;
                case RequestActionEnum.Custom:
                    IList<object> idList = RequestData.GetList<object>("IdList");

                    if (idList != null && idList.Count > 0)
                    {
                        if (RequestActionString == "batchdelete")
                        {
                            WebPartRule.BatchRemoveByPrimaryKeys(idList);
                        }
                    }
                    break;
            }
        }

        #endregion

        #region 私有方法

        #endregion
    }
}

