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
    /// DataCenter 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    // [System.Web.Script.Services.ScriptService]
    public class DataCenter : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetTableSchema(string desTableName)
        {
            string schema = "";
            string sql = @"SELECT 
                           [ColumnName] = c.name, 
                           [Description] = ex.value 
                           FROM 
                           sys.columns c 
                           LEFT OUTER JOIN 
                           middleDB.sys.extended_properties ex 
                           ON 
                           ex.major_id = c.object_id 
                           AND ex.minor_id = c.column_id 
                           AND ex.name = 'MS_Description' 
                           WHERE 
                           OBJECTPROPERTY(c.object_id, 'IsMsShipped')=0 
                           AND OBJECT_NAME(c.object_id) ='{0}'";
            sql = string.Format(sql);
            schema = JsonHelper.GetJsonString(DataHelper.QueryDictList(sql));
            return schema;
        }

        [WebMethod]
        public string GetTableData(string desTableName, string whereStr)
        {
            string sql = " select * from middleDB.." + desTableName + whereStr;
            return JsonHelper.GetJsonString(DataHelper.QueryDictList(sql));
        }
        [WebMethod]
        public string InsertTableData(string desTableName, string dataJson)
        {

            string result = "0";
            string sqlInsert = "insert into middleDB.." + desTableName + "({0}) values ({1})";
            string soure = "";
            string des = "";
            Dictionary<string, object> dic = (Dictionary<string, object>)JsonConvert.DeserializeObject(dataJson, typeof(Dictionary<string, object>));
            foreach (var obj in dic)
            {
                soure += obj.Key + ",";
                des += "'" + obj.Value == null ? "" : obj.ToString() + "',";
            } 
            soure = soure.TrimEnd(',');
            des = des.TrimEnd(',');
            sqlInsert = string.Format(sqlInsert, soure, des);
            sqlInsert = string.Format(sqlInsert, soure, des);
            return result;
        }
    }
}
