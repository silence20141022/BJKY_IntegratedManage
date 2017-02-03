using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using Aim;
using IntegratedManage.Model;
using Aim.WorkFlow;
using System.Data;
using System.Configuration;
using Video = IntegratedManage.Model.Vedio;
namespace IntegratedManage.Web.DailyManage
{
    public partial class VideoSourceList : IMListPage
    {
        private IList<Vedio> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Vedio ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Vedio>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    switch (RequestActionString)
                    {
                        case "GetFileName":
                            GetFileName();
                            break;
                        default:
                            DoSelect();
                            break;
                    }
                    break;
            }

        }

        private void GetFileName()
        {
            string Id = this.RequestData.Get<string>("Id");
            if (!string.IsNullOrEmpty(Id))
            {
                string sql = "select Name from BJKY_Portal..FileItem where Id='" + Id + "'";
                string Name = DataHelper.QueryValue(sql).ToString();
                this.PageState.Add("Name", Name);
            }
        }
        private void DoSelect()
        {
            string type = this.RequestData.Get("VedioType") + "";
            if (!string.IsNullOrEmpty(type))
            {
                SearchCriterion.AddSearch(Vedio.Prop_VedioType, type);
            }
            ents = Vedio.FindAll(SearchCriterion);
            this.PageState.Add("DataList", ents);
        }

    }
}
