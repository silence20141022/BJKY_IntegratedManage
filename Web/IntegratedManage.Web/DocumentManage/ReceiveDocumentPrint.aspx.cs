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
using System.Data;
using System.Text;
using Aim.WorkFlow;
using System.Collections.Specialized;
using IntegratedManage.Model;

namespace IntegratedManage.Web.DocumentManage
{
    public partial class ReceiveDocumentPrint : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id 
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            ReceiveDocument ent = null;
            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = ReceiveDocument.Find(id);
                    lbComeWord.InnerHtml = ent.ComeWord + "字第" + ent.ComeWordSize + "号";
                    lbReceiveDate.InnerHtml = ent.ReceiveDate.Value.ToShortDateString();
                    lbBringUnit.InnerHtml = ent.BringUnitName;
                    lbReceiveWord.InnerHtml = ent.ReceiveWord + "字第" + ent.ReceiveWordSize + "号";
                    lbReceiveReason.InnerHtml = ent.ReceiveReason;
                    lbNiBanOpinion.InnerHtml = ent.NiBanOpinion;
                    string sql = @"select * from Task where PatIndex('%{0}%',EFormName)>0  and  Status='4'  order by FinishTime asc";
                    sql = string.Format(sql, ent.Id);
                    PageState.Add("Opinion", DataHelper.QueryDictList(sql));
                }
            }
        }
    }
}

