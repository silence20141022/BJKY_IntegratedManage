using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

using Aim.Common;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;

namespace Aim.Portal.Web.CommonPages
{
    public partial class DownLoad : BasePage
    {
        public DownLoad()
        {
            this.IsCheckLogon = false;
        }
        string fileId = String.Empty;

        private void Page_Load(object sender, System.EventArgs e)
        {
            this.EnableViewState = false;   // 禁用ViewState

            fileId = Request["id"];
            Stream iStream = null;

            try
            {
                if (!String.IsNullOrEmpty(fileId))
                {
                    FileItem file = FileItem.Find(fileId);

                    // 下载大附件的方法
                    iStream = new FileStream(file.FilePath, FileMode.Open, FileAccess.Read, FileShare.Read);
                    ResponseFile(iStream, file.Name);
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=JScript>");
                Response.Write("alert(\"" + ex.Message + ",下载Id=" + fileId + " 的文件时发生系统级错误\");");
                Response.Write("</script>");
            }
            finally
            {
                if (iStream != null)
                {
                    iStream.Close();
                }

                Response.End();
            }
        }

        public static HttpResponse ResponseFile(Stream stream, string fileName)
        {
            byte[] buffer = new Byte[10000];
            int length;
            long dataToRead = stream.Length;


            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AppendHeader("Expires", System.DateTime.Now.AddMinutes(30).ToString());
            HttpContext.Current.Response.AppendHeader("Pragma", "public");
            HttpContext.Current.Response.AppendHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
            HttpContext.Current.Response.AppendHeader("Cache-Control", "public");
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.GetEncoding("UTF-8")));

            while (dataToRead > 0)
            {
                if (HttpContext.Current.Response.IsClientConnected)
                {
                    length = stream.Read(buffer, 0, 10000);
                    HttpContext.Current.Response.OutputStream.Write(buffer, 0, length);
                    HttpContext.Current.Response.Flush();

                    buffer = new Byte[10000];
                    dataToRead = dataToRead - length;
                }
                else
                {
                    dataToRead = -1;
                }
            }

            return HttpContext.Current.Response;
        }

    }
}
