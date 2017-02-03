// Business class SurveyResult generated from SurveyResult
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
	[ActiveRecord("SurveyResult")]
	public partial class SurveyResult : IMModelBase<SurveyResult>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SurveyId = "SurveyId";
		public static string Prop_QuestionContentId = "QuestionContentId";
		public static string Prop_QuestionItemId = "QuestionItemId";
		public static string Prop_QuestionItemContent = "QuestionItemContent";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _surveyId;
		private string _questionContentId;
		private string _questionItemId;
		private string _questionItemContent;
		private string _userId;
		private string _userName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SurveyResult()
		{
		}

		public SurveyResult(
			string p_id,
			string p_surveyId,
			string p_questionContentId,
			string p_questionItemId,
			string p_questionItemContent,
			string p_userId,
			string p_userName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_surveyId = p_surveyId;
			_questionContentId = p_questionContentId;
			_questionItemId = p_questionItemId;
			_questionItemContent = p_questionItemContent;
			_userId = p_userId;
			_userName = p_userName;
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
					RaisePropertyChanged(SurveyResult.Prop_SurveyId, oldValue, value);
				}
			}

		}

		[Property("QuestionContentId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string QuestionContentId
		{
			get { return _questionContentId; }
			set
			{
				if ((_questionContentId == null) || (value == null) || (!value.Equals(_questionContentId)))
				{
                    object oldValue = _questionContentId;
					_questionContentId = value;
					RaisePropertyChanged(SurveyResult.Prop_QuestionContentId, oldValue, value);
				}
			}

		}

		[Property("QuestionItemId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string QuestionItemId
		{
			get { return _questionItemId; }
			set
			{
				if ((_questionItemId == null) || (value == null) || (!value.Equals(_questionItemId)))
				{
                    object oldValue = _questionItemId;
					_questionItemId = value;
					RaisePropertyChanged(SurveyResult.Prop_QuestionItemId, oldValue, value);
				}
			}

		}

		[Property("QuestionItemContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string QuestionItemContent
		{
			get { return _questionItemContent; }
			set
			{
				if ((_questionItemContent == null) || (value == null) || (!value.Equals(_questionItemContent)))
				{
                    object oldValue = _questionItemContent;
					_questionItemContent = value;
					RaisePropertyChanged(SurveyResult.Prop_QuestionItemContent, oldValue, value);
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
					RaisePropertyChanged(SurveyResult.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(SurveyResult.Prop_UserName, oldValue, value);
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
					RaisePropertyChanged(SurveyResult.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SurveyResult
}

