using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Aim.Data;
using Newtonsoft.Json;

namespace Aim.Portal.Services
{
    /// <summary>
    /// DocumentService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    // [System.Web.Script.Services.ScriptService]
    public class DocumentService : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetDocumentFileSchema(string documentCode)
        {
            string schema = "";
            string sql = "select NameKey,Name,DataType,length,IsRequird from EntityProperty where EntityId =(select Id from dbo.DocType where Code='" + documentCode + "') and Flag<>'System'";
            schema = JsonHelper.GetJsonString(DataHelper.QueryDictList(sql));
            return schema;
        }
        [WebMethod]
        public string GatherDocumentFile(string documentCode, string TreeName, string FileJsonData)
        {
            string result = "0";
            string treeid = "";
            try
            {
                treeid = DataHelper.QueryValue<string>("select Id from " + documentCode + "..DocumentTree___" + documentCode + " where Name='" + TreeName + "'");
            }
            catch { }
            Dictionary<string, object> dic = (Dictionary<string, object>)JsonConvert.DeserializeObject(FileJsonData, typeof(Dictionary<string, object>));
            string sqlInsert = "insert into " + documentCode + "..Documents___" + documentCode + "('DocTreeId',{0}) values ('" + treeid + "',{1})";
            string soure = "";
            string des = "";
            foreach (var obj in dic)
            {
                soure += obj.Key + ",";
                des += "'" + obj.Value == null ? "" : obj.ToString() + "',";
            }
            soure = soure.TrimEnd(',');
            des = des.TrimEnd(',');
            sqlInsert = string.Format(sqlInsert, soure, des);
            DataHelper.ExecSql(sqlInsert);
            return result;
        }
    }
}
