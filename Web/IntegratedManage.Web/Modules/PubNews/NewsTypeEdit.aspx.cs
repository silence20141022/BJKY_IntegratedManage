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

namespace Aim.Portal.Web.Modules.PubNews
{
    public partial class NewsTypeEdit : BasePage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion

        #region 构造函数

        public NewsTypeEdit()
        {
            // IsAsyncPage = true;
        }

        #endregion;

        #region ASP.NET 事件


        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            NewsType ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<NewsType>();
                    ent.SaveAndFlush();
                    InsertCompetence(ent.Id, ent.BelongDeptId, ent.BelongDeptName);
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<NewsType>();
                    ent.CreateAndFlush();
                    InsertCompetence(ent.Id, ent.BelongDeptId, ent.BelongDeptName);
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<NewsType>();
                    ent.DeleteAndFlush();
                    this.SetMessage("删除成功！");
                    return;
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = NewsType.Find(id);
                    this.SetFormData(ent);
                }
            }
            else if (this.Request["DeptId"] != null && this.Request["DeptId"] != "")
            {
                var cc = new { BelongDeptId = this.Request["DeptId"], BelongDeptName = DataHelper.QueryValue("select Name from SysGroup where GroupID='" + this.Request["DeptId"] + "'").ToString(), AllowManageId = this.UserInfo.UserID, AllowManageName = this.UserInfo.Name };
                this.SetFormData(cc);
            }
        }

        /// <summary>
        /// 添加权限中间表
        /// </summary>
        /// <param name="Ids"></param>
        /// <param name="Names"></param>
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
                        Type = "NewsType",
                        Ext1 = PId
                    }.DoCreate();
                }
            }
        }
        #endregion
    }
}
