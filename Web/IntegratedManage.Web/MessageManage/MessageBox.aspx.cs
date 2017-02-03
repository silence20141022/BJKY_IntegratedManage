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

namespace IntegratedManage.Web.MessageManage
{
    public partial class MessageBox : IMListPage
    {
        string sql = "";
        string according = "Sender";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(RequestData.Get<string>("According")))
            {
                according = RequestData.Get<string>("According");
            }
            switch (RequestActionString)
            {
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            if (according == "Sender")
            {
                sql = @"select newid() as Id, CreateId,CreateName,Count(Id) as Quantity from BJKY_IntegratedManage..IntegratedMessage 
                 where ReceiverId='{0}' and State is null group by CreateId,CreateName";
            }
            else
            {
                sql = @"select newid() as Id, MessageType,Count(Id) as Quantity from BJKY_IntegratedManage..IntegratedMessage 
                where ReceiverId='{0}' and State is null group by MessageType ";
            }
            sql = string.Format(sql, UserInfo.UserID);
            PageState.Add("DataList", DataHelper.QueryDictList(sql));
        }
    }
}

