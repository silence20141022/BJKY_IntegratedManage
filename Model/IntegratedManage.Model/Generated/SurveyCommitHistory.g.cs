// Business class SurveyCommitHistory generated from SurveyCommitHistory
// Creator: Ray
// Created Date: [2013-03-01]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("SurveyCommitHistory")]
	public partial class SurveyCommitHistory : IMModelBase<SurveyCommitHistory>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SurveyId = "SurveyId";
		public static string Prop_SurveyedUserId = "SurveyedUserId";
		public static string Prop_SurveryUserName = "SurveryUserName";
		public static string Prop_CommitSurvey = "CommitSurvey";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _surveyId;
		private string _surveyedUserId;
		private string _surveryUserName;
		private string _commitSurvey;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SurveyCommitHistory()
		{
		}

		public SurveyCommitHistory(
			string p_id,
			string p_surveyId,
			string p_surveyedUserId,
			string p_surveryUserName,
			string p_commitSurvey,
			DateTime? p_createTime)
		{
			_id = p_id;
			_surveyId = p_surveyId;
			_surveyedUserId = p_surveyedUserId;
			_surveryUserName = p_surveryUserName;
			_commitSurvey = p_commitSurvey;
			_createTime = p_createTime;
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
					RaisePropertyChanged(SurveyCommitHistory.Prop_SurveyId, oldValue, value);
				}
			}

		}

		[Property("SurveyedUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SurveyedUserId
		{
			get { return _surveyedUserId; }
			set
			{
				if ((_surveyedUserId == null) || (value == null) || (!value.Equals(_surveyedUserId)))
				{
                    object oldValue = _surveyedUserId;
					_surveyedUserId = value;
					RaisePropertyChanged(SurveyCommitHistory.Prop_SurveyedUserId, oldValue, value);
				}
			}

		}

		[Property("SurveryUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SurveryUserName
		{
			get { return _surveryUserName; }
			set
			{
				if ((_surveryUserName == null) || (value == null) || (!value.Equals(_surveryUserName)))
				{
                    object oldValue = _surveryUserName;
					_surveryUserName = value;
					RaisePropertyChanged(SurveyCommitHistory.Prop_SurveryUserName, oldValue, value);
				}
			}

		}

		[Property("CommitSurvey", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string CommitSurvey
		{
			get { return _commitSurvey; }
			set
			{
				if ((_commitSurvey == null) || (value == null) || (!value.Equals(_commitSurvey)))
				{
                    object oldValue = _commitSurvey;
					_commitSurvey = value;
					RaisePropertyChanged(SurveyCommitHistory.Prop_CommitSurvey, oldValue, value);
				}
			}

		}

		[Property("CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? CreateTime
		{
			get { return _createTime; }
			set
			{
				if (value != _createTime)
				{
                    object oldValue = _createTime;
					_createTime = value;
					RaisePropertyChanged(SurveyCommitHistory.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SurveyCommitHistory
}

