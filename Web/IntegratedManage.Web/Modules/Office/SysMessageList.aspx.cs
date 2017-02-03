using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;


namespace Aim.Portal.Web
{
    public partial class SysMessageList : BaseListPage
    {
        #region 属性

        #endregion

        #region 变量

        private SysMessage[] ents = null;

        protected string TypeId = string.Empty;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            TypeId = RequestData.Get<string>("TypeId");

            if (!String.IsNullOrEmpty(TypeId))
            {
                ICriterion crit = null;
                SearchCriterion.SetOrder("SendTime", false);
                switch (TypeId)
                {
                    case "ToSend":
                        SearchCriterion.AddSearch("SenderId", this.UserInfo.UserID, SearchModeEnum.Like);
                        crit = Expression.Or(Expression.Eq("IsSenderDelete", false), Expression.IsNull("IsSenderDelete"));
                        crit = SearchHelper.IntersectCriterions(crit, Expression.IsNull(SysMessage.Prop_State));
                        ents = SysMessageRule.FindAll(SearchCriterion, crit);
                        this.PageState.Add("SysMessageList", ents);
                        break;
                    case "Send":
                        SearchCriterion.AddSearch("SenderId", this.UserInfo.UserID, SearchModeEnum.Like);
                        crit = Expression.Or(Expression.Eq("IsSenderDelete", false), Expression.IsNull("IsSenderDelete"));
                        crit = SearchHelper.IntersectCriterions(crit, Expression.IsNotNull(SysMessage.Prop_State));
                        ents = SysMessageRule.FindAll(SearchCriterion, crit);
                        this.PageState.Add("SysMessageList", ents);
                        break;
                    case "Receive":
                        crit = Expression.Or(Expression.Eq("IsReceiverDelete", false), Expression.IsNull("IsReceiverDelete"));
                        crit = SearchHelper.IntersectCriterions(crit, Expression.IsNull(View_SysMessage.Prop_IsFirstView), Expression.Eq(View_SysMessage.Prop_ReceiveId, this.UserInfo.UserID)
                            , Expression.IsNull(View_SysMessage.Prop_IsDelete));
                        View_SysMessage[] mgs = View_SysMessage.FindAll(SearchCriterion, crit);
                        this.PageState.Add("SysMessageList", mgs);
                        break;
                    case "ReceiveReaded":
                        crit = Expression.Or(Expression.Eq("IsReceiverDelete", false), Expression.IsNull("IsReceiverDelete"));
                        crit = SearchHelper.IntersectCriterions(crit, Expression.IsNotNull(View_SysMessage.Prop_IsFirstView), Expression.Eq(View_SysMessage.Prop_ReceiveId, this.UserInfo.UserID)
                            , Expression.IsNull(View_SysMessage.Prop_IsDelete));
                        View_SysMessage[] mgss = View_SysMessage.FindAll(SearchCriterion, crit);
                        this.PageState.Add("SysMessageList", mgss);
                        break;
                }
            }

            SysMessage ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<SysMessage>();
                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<SysMessage>();
                    ent.DoUpdate();
                    this.SetMessage("保存成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<SysMessage>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                case RequestActionEnum.Custom:
                    IList<object> ids = RequestData.GetList<object>("Ids");

                    if (ids != null && ids.Count > 0)
                    {
                        if (RequestActionString == "batchdelete")
                        {
                            if (TypeId == "Send" || TypeId == "ToSend")
                            {
                                SysMessage[] tents = SysMessage.FindAll(Expression.In("Id", ids.ToList()));

                                foreach (SysMessage tent in tents)
                                {
                                    tent.IsSenderDelete = true;

                                    tent.DoDelete();
                                }
                            }
                            else
                            {
                                SysMessage[] tents = SysMessage.FindAll(Expression.In("Id", ids.ToList()));

                                foreach (SysMessage tent in tents)
                                {
                                    SysMessageReceive receive = SysMessageReceive.FindAllByProperties("MsgId", tent.Id, "ReceiverId", this.UserInfo.UserID)[0];
                                    receive.IsDelete = "1";
                                    receive.DeleteTime = DateTime.Now;
                                    receive.Save();
                                }
                            }
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

