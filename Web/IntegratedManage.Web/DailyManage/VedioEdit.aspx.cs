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
using System.Configuration;
using IntegratedManage.Model;
using Aim;
using Aim.WorkFlow;
using System.Data;

namespace IntegratedManage.Web.DailyManage
{
    public partial class VedioEdit : IMBasePage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id   
        Vedio ent = null;
        string sql = "";

        private string ImgDirectory = ConfigurationManager.AppSettings["ImgDirectory"];
        protected void Page_Load(object sender, EventArgs e)
        {
            //根据参数设置缩略图片大小
            if (!string.IsNullOrEmpty(this.RequestData.Get<string>("ImgDirectory")))
            {
                string imgSize = this.RequestData.Get("ImgDirectory").ToString();
                if (imgSize.Split('*').Length > 1)
                {
                    ImgDirectory = imgSize;
                }
            }

            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            if (!string.IsNullOrEmpty(id))
            {
                ent = Vedio.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    ent = GetMergedData<Vedio>();
                    ent.DoUpdate();
                    break;
                case "ImportFile":
                    string fileIds = RequestData.Get<string>("fileIds");
                    string fileType = Server.UrlDecode(RequestData.Get<string>("FileType"));
                    if (!string.IsNullOrEmpty(fileIds))
                    {
                        sql = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0";
                        sql = string.Format(sql, fileIds);
                        PageState.Add("Result", DataHelper.QueryDictList(sql));
                    }
                    break;
                case "create":
                    ent = GetPostedData<Vedio>();
                    ent.PlayTimes = 0;
                    ent.DoCreate();
                    VideoToThumbImg(ent);
                    break;
                default:
                    DoSelect();
                    break;
            }
        }



        private void VideoToThumbImg(IntegratedManage.Model.Vedio av)
        /*生成缩略图*/
        {

            string sql = @"select A.Id, Name from  BJKY_Portal..FileItem As A , BJKY_IntegratedManage..Vedio As B 
                           where B.VedioFile=A.Id  and B.Id='{0}'";
            sql = string.Format(sql, av.Id);
            DataTable dt = DataHelper.QueryDataTable(sql);

            if (dt.Rows.Count > 0)
            {
                try
                {
                    
                    string FileName = av.VedioFile;
                    string AvPath = "/Document/" + FileName + "_" + dt.Rows[0]["Name"].ToString();
                    AvPath = MapPath(AvPath);
                    Ffmpeg.FfmpegConverter ff = new  Ffmpeg.FfmpegConverter();
                    string Result = ff.ConvertImage(AvPath, ImgDirectory, FileName);
                }
                catch
                {

                }
            }

        }

        private void DoSelect()
        {
            if (op != "c" && op != "cs")
            {
                ent = Vedio.Find(id);
                SetFormData(ent);
                sql = @"select * from FileItem where Id='{0}'";
                sql = string.Format(sql, ent.VedioFile);
                PageState.Add("DataList", DataHelper.QueryDictList(sql));
                sql = @"select * from FileItem where PatIndex('%'+Id+'%','{0}')>0";
                sql = string.Format(sql, ent.ImageFile);
                PageState.Add("ImageList", DataHelper.QueryDictList(sql));
            }
            PageState.Add("VedioType", SysEnumeration.GetEnumDict("VedioType"));
        }
    }
}

