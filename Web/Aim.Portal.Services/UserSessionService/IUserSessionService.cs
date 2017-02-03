﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Aim.Common.Authentication;
using Aim.Portal.Model;
using Aim.Common.Service;

namespace Aim.Portal.Services
{
    /// <summary>
    /// 用户Session服务接口
    /// </summary>
    [ServiceContract]
    public interface IUserSessionService : IWCFService
    {
        /// <summary>
        /// 判断用户Session状态(判断用户是否已注销)
        /// </summary>
        /// <param name="sessionID">此用户的UserSession标识</param>
        /// <returns>true-有效  false-无效</returns>
        [OperationContract]
        bool CheckUserSession(string sessionID);

        /// <summary>
        /// 用户注销或者页面超时时释放用户Session
        /// </summary>
        /// <param name="sessionID"></param>
        /// <returns>true-释放成功,false--释放失败</returns>
        [OperationContract]
        bool ReleaseSession(string sessionID);

        /// <summary>
        /// 用户认证
        /// </summary>
        /// <param name="loginName"></param>
        /// <param name="password"></param>
        /// <param name="authType"></param>
        /// <returns></returns>
        [OperationContract]
        string AuthenticateUser(string message);

        /// <summary>
        /// 设置预释放
        /// </summary>
        /// <param name="sessionID"></param>
        [OperationContract]
        bool SetPrepRelease(string sessionID, LoginTypeEnum logMode);

        /// <summary>
        /// 刷新指定用户的状态信息,改变此用户最近的活动时间为当前时间
        /// </summary>
        /// <param name="sessionID"></param>
        [OperationContract]
        bool RefreshSession(string sessionID);

        /// <summary>
        /// 获取用户数据
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        byte[] GetUserData(string msg);

        /// <summary>
        /// 获取系统数据
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        byte[] GetSystemData(string msg);

        /// <summary>
        /// 获取用户数据
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        string GetUserDataJson(string msg);
        /// <summary>
        /// 获取系统数据
        /// </summary>
        /// <returns></returns>
        [OperationContract]
        string GetSystemDataJson(string msg);
    }
}
