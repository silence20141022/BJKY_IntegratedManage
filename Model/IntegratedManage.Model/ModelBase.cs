using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Castle.ActiveRecord;
using Aim.Data;
using Aim.Common;
using Aim.Portal; 

namespace IntegratedManage.Model
{
    [Serializable]
    public abstract class ModelBase<T> : EntityBase<T> where T : ModelBase<T>
    {
        /// <summary>
        /// 当前用户信息
        /// </summary>
        public UserInfo UserInfo
        {
            get
            {
                return PortalService.CurrentUserInfo;
            }
        }
    }
}
