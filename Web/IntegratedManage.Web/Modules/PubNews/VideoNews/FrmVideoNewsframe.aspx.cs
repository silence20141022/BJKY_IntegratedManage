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

namespace Aim.Examining.Web
{
    public partial class FrmVideoNewsframe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EnableViewState = false;
                //string sql = @"select top 5 A.Id,Title,ShowImg as ImgPath,B.ImgPath As ImgPath1 from VideoNews As A left join VideoNewDetail As B on A.Id=B.PId where A.State='2' order by PostTime desc";

                string sql = @"declare @path varchar(300)
                                select @path=g.Path from SysGroup g inner join sysusergroup ug on ug.GroupId=g.GroupId 
                                where UserId='{0}'
                                select top 5 n.Id,Title,n.ShowImg as ImgPath
                                from VideoNews As n 
                                inner join NewsType nt on nt.Id=n.TypeId
                                where n.State='2' and isnull(ExpireTime,'2099-01-01')>=getdate()
                                and (charindex('{0}',n.ReceiveUserId)>0 or charindex('{0}',nt.AllowQueryId)>0 or 
                                exists (select Id from Competence c where c.Ext1=n.Id and charindex(PId,@path)>0)
                                or exists (select Id from Competence c where c.Ext1=nt.Id and charindex(PId,@path)>0))
                                order by PostTime desc";
                sql = string.Format(sql, Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID);

                DataTable dt = DataHelper.QueryDataTable(sql);

                DataRow row = null;
                for (int i = 0; i < dt.Rows.Count - 1; i++)
                {
                    row = dt.Rows[i];
                    string imgPath = string.Empty;

                    //没有上传时图片则找视频的截取图片
                    if (row["ImgPath"] + "" == "")
                    {
                        row["ImgPath"] = DataHelper.QueryValue("select top 1 Ext1 from dbo.VideoNewDetail where PId='" + row["Id"] + "' order by CreateTime") + "";
                        imgPath = (row["ImgPath"] + "").TrimEnd(',');
                    }
                    else
                    {
                        imgPath = "/Document/" + (row["ImgPath"] + "").TrimEnd(',');
                    }

                    litimg.Text += @"<a href='#'><img src='" + imgPath + "' alt='" + row["Title"] + "' "
                            + "onclick=\"OpenNews('/Modules/PubNews/VideoNews/FrmVdeoNewsView.aspx?Id=" + row["Id"] + "&op=r');\" width='350' height='200' />";
                }

                if (dt.Rows.Count > 0)//如果有多个视频新闻，默认进来展示最后一个视频的图片
                {
                    row = dt.Rows[dt.Rows.Count - 1];
                    string imgPath = string.Empty;

                    //没有上传时图片则找视频的截取图片
                    if (row["ImgPath"] + "" == "")
                    {
                        row["ImgPath"] = DataHelper.QueryValue("select top 1 Ext1 from dbo.VideoNewDetail where PId='" + row["Id"] + "' order by CreateTime") + "";
                        imgPath = (row["ImgPath"] + "").TrimEnd(',');
                    }
                    else
                    {
                        imgPath = "/Document/" + (row["ImgPath"] + "").TrimEnd(',');
                    }

                    imglast.Src = imgPath;
                    imglast.Alt = row["Title"] + "";
                    imglast.Attributes.Add("onclick", "OpenNews('/Modules/PubNews/VideoNews/FrmVdeoNewsView.aspx?Id=" + row["Id"] + "&op=r');");
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
