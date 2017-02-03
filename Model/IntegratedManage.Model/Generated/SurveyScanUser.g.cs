// Business class SurveyScanUser generated from SurveyScanUser
// Creator: Ray
// Created Date: [2013-02-28]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("SurveyScanUser")]
	public partial class SurveyScanUser : IMModelBase<SurveyScanUser>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SurveyId = "SurveyId";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _surveyId;
		private string _userId;
		private string _userName;


		#endregion

		#region Constructors

		public SurveyScanUser()
		{
		}

		public SurveyScanUser(
			string p_id,
			string p_surveyId,
			string p_userId,
			string p_userName)
		{
			_id = p_id;
			_surveyId = p_surveyId;
			_userId = p_userId;
			_userName = p_userName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("SurveyId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SurveyId
		{
			get { return _surveyId; }
			set
			{
				if ((_surveyId == null) || (value == null) || (!value.Equals(_surveyId)))
				{
                    object oldValue = _surveyId;
					_surveyId = value;
					RaisePropertyChanged(SurveyScanUser.Prop_SurveyId, oldValue, value);
				}
			}

		}

		[Property("UserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string UserId
		{
			get { return _userId; }
			set
			{
				if ((_userId == null) || (value == null) || (!value.Equals(_userId)))
				{
                    object oldValue = _userId;
					_userId = value;
					RaisePropertyChanged(SurveyScanUser.Prop_UserId, oldValue, value);
				}
			}

		}

		[Property("UserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserName
		{
			get { return _userName; }
			set
			{
				if ((_userName == null) || (value == null) || (!value.Equals(_userName)))
				{
                    object oldValue = _userName;
					_userName = value;
					RaisePropertyChanged(SurveyScanUser.Prop_UserName, oldValue, value);
				}
			}

		}

		#endregion
	} // SurveyScanUser
}

