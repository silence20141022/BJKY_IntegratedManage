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
using IntegratedManage.Model;

namespace Aim.Portal.Web.Modules
{
    public partial class FrmVideoNewsEdit : BasePage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string typeid = String.Empty;

        #endregion

        #region ASP.NET 事件
        private string ImgDirectory = ConfigurationManager.AppSettings["ImgDirectory"];
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            typeid = RequestData.Get<string>("TypeId");

            VideoNews ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<VideoNews>();
                    ent.HomePagePopup = RequestData.Get<string>("HomePagePopup");
                    ent.State = "1";
                    if (RequestData["param"] + "" == "tj")
                    {
                        ent.PostUserId = UserInfo.UserID;
                        ent.PostUserName = UserInfo.Name;
                        ent.PostTime = DateTime.Now;
                        ent.State = "2";
                    }
                    ent.SaveAndFlush();

                    SaveDetail(ent.Id, ent.ShowImg);
                    InsertCompetence(ent.Id, ent.ReceiveDeptId, ent.ReceiveDeptName);
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<VideoNews>();
                    ent.HomePagePopup = RequestData.Get<string>("HomePagePopup");
                    ent.CreateId = UserInfo.UserID;
                    ent.CreateName = UserInfo.Name;
                    ent.CreateTime = DateTime.Now;
                    ent.State = "1";
                    if (RequestData["param"] + "" == "tj")
                    {
                        ent.PostUserId = UserInfo.UserID;
                        ent.PostUserName = UserInfo.Name;
                        ent.PostTime = DateTime.Now;
                        ent.State = "2";
                    }
                    ent.CreateAndFlush();

                    SaveDetail(ent.Id, ent.ShowImg);
                    InsertCompetence(ent.Id, ent.ReceiveDeptId, ent.ReceiveDeptName);
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<VideoNews>();
                    ent.DeleteAndFlush();
                    this.SetMessage("删除成功！");
                    break;
            }

            if (RequestActionString == "ImportFile")
            {
                string fileIds = RequestData.Get<string>("fileIds");
                if (!string.IsNullOrEmpty(fileIds))
                {
                    string sql = @"select * from BJKY_Portal..FileItem where PatIndex('%'+Id+'%','{0}')>0";
                    sql = string.Format(sql, fileIds);
                    PageState.Add("Result", DataHelper.QueryDictList(sql));
                }
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = VideoNews.Find(id);
                    typeid = ent.TypeId;
                    //详细列表数据
                    PageState.Add("DetailList", VideoNewDetail.FindAllByProperty(VideoNewDetail.Prop_PId, ent.Id));
                }

                this.SetFormData(ent);
            }
            else
            {
                string sql = "select DeptId,ChildDeptName,ParentId,ParentDeptName,len(Path) LenPath from  dbo.View_SysUserGroup where UserId='" + UserInfo.UserID + "' and Type=2";
                DataTable dtt = DataHelper.QueryDataTable(sql);
                if (dtt.Rows.Count > 0)
                {
                    var DeptInfo = new { groupId = dtt.Rows[0]["DeptId"] + "", groupName = dtt.Rows[0]["ChildDeptName"] + "", deptId = dtt.Rows[0]["ParentId"] + "", deptName = dtt.Rows[0]["ParentDeptName"] + "" };
                    PageState.Add("DeptInfo", DeptInfo);
                }
            }

            if (!String.IsNullOrEmpty(typeid))
            {
                NewsType newsType = NewsType.TryFind(typeid);
                PageState.Add("NewsType", newsType);
            }
            EasyDictionary es = new EasyDictionary();
            DataTable dt = DataHelper.QueryDataTable("select Id,TypeName from NewsType where IsEfficient='1'");
            foreach (DataRow row in dt.Rows)
                es.Add(row["Id"].ToString(), row["TypeName"].ToString());
            PageState.Add("NewsTypeEnum", es);
        }

        /// <summary>
        /// 保存明细
        /// </summary>
        private void SaveDetail(string PId, string showimg)
        {
            IList<string> entStrList = RequestData.GetList<string>("detail");
            string dIds = "";
            if (entStrList != null && entStrList.Count > 0)
            {
                IList<VideoNewDetail> ocdEnts = entStrList.Select(tent => JsonHelper.GetObject<VideoNewDetail>(tent) as VideoNewDetail).ToList();
                foreach (VideoNewDetail ocdEnt in ocdEnts)
                {
                    //生成缩略图
                    ocdEnt.Ext1 = VideoToThumbImg(ocdEnt, "325*200");

                    if (string.IsNullOrEmpty(ocdEnt.Id))
                    {
                        ocdEnt.PId = PId;
                        ocdEnt.DoCreate();
                    }
                    else
                    {
                        ocdEnt.DoUpdate();
                    }

                    dIds += ocdEnt.Id + ",";
                }
                if (dIds.Length > 0)
                {
                    dIds = dIds.TrimEnd(',');
                }

                DataHelper.ExecSql("delete VideoNewDetail where PId='" + PId + "' and Id not in ('" + dIds.Replace(",", "','") + "')");
            }
        }

        /*生成缩略图*/
        private string VideoToThumbImg(VideoNewDetail detail, string imgSize)
        {
            try
            {
                string AvPath = "/Document/" + detail.ImgPath;
                AvPath = MapPath(AvPath);

                Ffmpeg.FfmpegConverter ff = new Ffmpeg.FfmpegConverter();
                string Result = ff.ConvertImage(AvPath, ImgDirectory, detail.ImgPath.Split('.')[0], imgSize);
                return Result;
            }
            catch
            {
                throw new Exception("生成缩略失败!");
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
                        Type = "VideoNews",
                        Ext1 = PId
                    }.DoCreate();
                }
            }
        }

        #endregion
    }
}
