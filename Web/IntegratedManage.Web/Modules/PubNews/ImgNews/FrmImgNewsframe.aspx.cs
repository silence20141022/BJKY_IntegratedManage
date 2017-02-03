using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Aim.Data;

namespace IntegratedManage.Web
{
    public partial class FrmImgNewsframe : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EnableViewState = false; 
                string sql = @"declare @path varchar(300)
                            select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                            where UserId='{0}'
                            select top 5 n.Id,n.Title,n.ShowImg as ImgPath from ImgNews as n 
                            inner join NewsType nt on nt.Id=n.TypeId where State='2' 
                            and isnull(ExpireTime,'2099-01-01')>=getdate()
                            and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                            exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                            or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))
                            order by PostTime desc";
                sql = string.Format(sql, Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID);
                DataTable dt = DataHelper.QueryDataTable(sql);
                foreach (DataRow trow in dt.Rows)
                {
                    if (trow["ImgPath"] + "" == "")
                    {
                        trow["ImgPath"] = DataHelper.QueryValue("select top 1 ImgPath from dbo.ImgNewDetail where PId='" + trow["Id"] + "' order by CreateTime") + "";
                    }
                    else
                    {
                        trow["ImgPath"] = (trow["ImgPath"] + "").TrimEnd(',');
                    }
                }
                DataRow row = null;
                for (int i = 0; i < dt.Rows.Count - 1; i++)
                {
                    row = dt.Rows[i];
                    litimg.Text += @"<a href='#'><img src='/Document/" + row["ImgPath"] + "' alt='" + row["Title"] + "' "
                            + "onclick=\"OpenNews('/Modules/PubNews/ImgNews/FrmImageNews.aspx?Id=" + row["Id"] + "&op=r');\" width='350' height='200' />";
                }
                if (dt.Rows.Count > 0)
                {
                    row = dt.Rows[dt.Rows.Count - 1];
                    imglast.Src = @"/Document/" + row["ImgPath"];
                    imglast.Alt = row["Title"] + "";
                    imglast.Attributes.Add("onclick", "OpenNews('/Modules/PubNews/ImgNews/FrmImageNews.aspx?Id=" + row["Id"] + "&op=r');");
                }
                else
                {
                    litinfo.Text = "没有数据";
                    banner.Attributes.Add("style", "display:none");
                }
            }
        }
    }
}
