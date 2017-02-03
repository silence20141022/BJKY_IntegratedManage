// Business class NotePad generated from NotePad
// Creator: Ray
// Created Date: [2013-03-17]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("NotePad")]
	public partial class NotePad : IMModelBase<NotePad>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_StartTime = "StartTime";
		public static string Prop_EndTime = "EndTime";
		public static string Prop_Theme = "Theme";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private DateTime? _startTime;
		private DateTime? _endTime;
		private string _theme;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public NotePad()
		{
		}

		public NotePad(
			string p_id,
			string p_userId,
			string p_userName,
			DateTime? p_startTime,
			DateTime? p_endTime,
			string p_theme,
			DateTime? p_createTime)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_startTime = p_startTime;
			_endTime = p_endTime;
			_theme = p_theme;
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
					RaisePropertyChanged(NotePad.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(NotePad.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("StartTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? StartTime
		{
			get { return _startTime; }
			set
			{
				if (value != _startTime)
				{
                    object oldValue = _startTime;
					_startTime = value;
					RaisePropertyChanged(NotePad.Prop_StartTime, oldValue, value);
				}
			}

		}

		[Property("EndTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? EndTime
		{
			get { return _endTime; }
			set
			{
				if (value != _endTime)
				{
                    object oldValue = _endTime;
					_endTime = value;
					RaisePropertyChanged(NotePad.Prop_EndTime, oldValue, value);
				}
			}

		}

		[Property("Theme", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Theme
		{
			get { return _theme; }
			set
			{
				if ((_theme == null) || (value == null) || (!value.Equals(_theme)))
				{
                    object oldValue = _theme;
					_theme = value;
					RaisePropertyChanged(NotePad.Prop_Theme, oldValue, value);
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
					RaisePropertyChanged(NotePad.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // NotePad
}

