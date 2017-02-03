using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Web.UI;
using Aim.Data;
using Castle.ActiveRecord;
using Aim.Portal.Model;
using System.Data;
using Newtonsoft.Json.Linq;
using Vedio = IntegratedManage.Model.Vedio;
namespace IntegratedManage.Web.Daily
{
    public partial class FilePlay : IMListPage
    {
        public string filename = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            filename = RequestData.Get<string>("FileUrl");
            AddVedioCheckTimes();
        }
        public string GetUrl()
        {
            return "url=" + filename;
        }

        private void AddVedioCheckTimes()
        {

            if (!string.IsNullOrEmpty(filename))
            {
                Vedio av = Vedio.FindFirstByProperties(Vedio.Prop_VedioFile, filename.Substring(0, 36));
                if (av == null) return;
                int counter = av.PlayTimes.GetValueOrDefault();
                av.PlayTimes = counter + 1;
                av.DoUpdate();
            }
        }
    }
}
