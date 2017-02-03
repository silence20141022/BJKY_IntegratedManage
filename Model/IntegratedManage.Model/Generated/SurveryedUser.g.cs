// Business class SurveryedUser generated from SurveryedUser
// Creator: Ray
// Created Date: [2013-02-23]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("SurveryedUser")]
	public partial class SurveryedUser : IMModelBase<SurveryedUser>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SurveryId = "SurveryId";
		public static string Prop_SurveyedDeptId = "SurveyedDeptId";
		public static string Prop_SurveyedDeptName = "SurveyedDeptName";
		public static string Prop_SurveyedUserId = "SurveyedUserId";
		public static string Prop_SurveyedUserName = "SurveyedUserName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _surveryId;
		private string _surveyedDeptId;
		private string _surveyedDeptName;
		private string _surveyedUserId;
		private string _surveyedUserName;


		#endregion

		#region Constructors

		public SurveryedUser()
		{
		}

		public SurveryedUser(
			string p_id,
			string p_surveryId,
			string p_surveyedDeptId,
			string p_surveyedDeptName,
			string p_surveyedUserId,
			string p_surveyedUserName)
		{
			_id = p_id;
			_surveryId = p_surveryId;
			_surveyedDeptId = p_surveyedDeptId;
			_surveyedDeptName = p_surveyedDeptName;
			_surveyedUserId = p_surveyedUserId;
			_surveyedUserName = p_surveyedUserName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
		    set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("SurveryId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SurveryId
		{
			get { return _surveryId; }
			set
			{
				if ((_surveryId == null) || (value == null) || (!value.Equals(_surveryId)))
				{
                    object oldValue = _surveryId;
					_surveryId = value;
					RaisePropertyChanged(SurveryedUser.Prop_SurveryId, oldValue, value);
				}
			}

		}

		[Property("SurveyedDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SurveyedDeptId
		{
			get { return _surveyedDeptId; }
			set
			{
				if ((_surveyedDeptId == null) || (value == null) || (!value.Equals(_surveyedDeptId)))
				{
                    object oldValue = _surveyedDeptId;
					_surveyedDeptId = value;
					RaisePropertyChanged(SurveryedUser.Prop_SurveyedDeptId, oldValue, value);
				}
			}

		}

		[Property("SurveyedDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 256)]
		public string SurveyedDeptName
		{
			get { return _surveyedDeptName; }
			set
			{
				if ((_surveyedDeptName == null) || (value == null) || (!value.Equals(_surveyedDeptName)))
				{
                    object oldValue = _surveyedDeptName;
					_surveyedDeptName = value;
					RaisePropertyChanged(SurveryedUser.Prop_SurveyedDeptName, oldValue, value);
				}
			}

		}

		[Property("SurveyedUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string SurveyedUserId
		{
			get { return _surveyedUserId; }
			set
			{
				if ((_surveyedUserId == null) || (value == null) || (!value.Equals(_surveyedUserId)))
				{
                    object oldValue = _surveyedUserId;
					_surveyedUserId = value;
					RaisePropertyChanged(SurveryedUser.Prop_SurveyedUserId, oldValue, value);
				}
			}

		}

		[Property("SurveyedUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string SurveyedUserName
		{
			get { return _surveyedUserName; }
			set
			{
				if ((_surveyedUserName == null) || (value == null) || (!value.Equals(_surveyedUserName)))
				{
                    object oldValue = _surveyedUserName;
					_surveyedUserName = value;
					RaisePropertyChanged(SurveryedUser.Prop_SurveyedUserName, oldValue, value);
				}
			}

		}

		#endregion
	} // SurveryedUser
}

