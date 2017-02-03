using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Aim.Portal.Model;
using Aim.Portal.FileSystem;

namespace IntegratedManage.Web.DocumentManage
{
    public partial class SaveDoc : System.Web.UI.Page
    {
        readonly int enterCount = 12;
        string[] requestValues = new string[3];
        FileItem item = null;
        string fileName = "";
        protected void Page_Load(object sender, System.EventArgs e)
        {
            string fileId = Request.Params["FileId"];
            fileName = Server.UrlDecode(Request.Params["FileMainName"]);
            if (string.IsNullOrEmpty(fileId))
            {
                FileFolder folder = FileFolder.FindAllByProperties(FileFolder.Prop_FolderKey, "Portal")[0];
                FileInfo file = new FileInfo(Path.Combine(folder.FolderPath, "Empty.doc"));
                //FileInfo file = new FileInfo(Path.Combine(folder.FolderPath, fileName + ".doc"));
                //string subKey = Request.Params["SubKeyId"];
                //string fileName = Guid.NewGuid().ToString(); 
                FileItem newfitem = FileService.CreateFileItem(file.FullName, "Portal");
                File.Copy(file.FullName, Path.Combine(folder.FolderPath, FileService.GetFullID(newfitem.Id, newfitem.Name)));
                FileInfo fileN = new FileInfo(Path.Combine(folder.FolderPath, FileService.GetFullID(newfitem.Id, newfitem.Name)));
                fileN.MoveTo(Path.Combine(folder.FolderPath, FileService.GetFullID(newfitem.Id, fileName)));//+ newfitem.ExtName
                newfitem.Name = fileName;//+ newfitem.ExtName
                newfitem.Save();
                item = newfitem;
            }
            else
            {
                item = FileItem.Find(fileId);
            }
            string newFile = item.FilePath;
            BinaryReader bReader = new BinaryReader(Request.InputStream);
            string strTemp = System.Text.Encoding.GetEncoding("gb2312").GetString(
            bReader.ReadBytes((int)bReader.BaseStream.Length), 0, (int)bReader.BaseStream.Length);
            string match = "Content-Type: application/msword\r\n\r\n";
            int pos = strTemp.IndexOf(match) + match.Length;
            bReader.BaseStream.Seek(pos, SeekOrigin.Begin);

            FileStream newDoc = new FileStream(newFile, FileMode.Create, FileAccess.Write);
            BinaryWriter bWriter = new BinaryWriter(newDoc);
            bWriter.BaseStream.Seek(0, SeekOrigin.End);


            while (bReader.BaseStream.Position < bReader.BaseStream.Length - 38)
                bWriter.Write(bReader.ReadByte());
            bReader.Close();
            bWriter.Flush();
            bWriter.Close();
            Response.Write(FileService.GetFullID(item.Id, item.Name));
            Response.End();
        }
    }
}
