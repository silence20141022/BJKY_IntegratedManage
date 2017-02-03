// Business class SurveyQuestion generated from SurveyQuestion
// Creator: Ray
// Created Date: [2013-04-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("SurveyQuestion")]
	public partial class SurveyQuestion : IMModelBase<SurveyQuestion>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Title = "Title";
		public static string Prop_Contents = "Contents";
		public static string Prop_TicketType = "TicketType";
		public static string Prop_StartTime = "StartTime";
		public static string Prop_EndTime = "EndTime";
		public static string Prop_IsNoName = "IsNoName";
		public static string Prop_PowerType = "PowerType";
		public static string Prop_ScanPower = "ScanPower";
		public static string Prop_StatisticsPower = "StatisticsPower";
		public static string Prop_ReadPower = "ReadPower";
		public static string Prop_State = "State";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _title;
		private string _contents;
		private string _ticketType;
		private DateTime? _startTime;
		private DateTime? _endTime;
		private string _isNoName;
		private string _powerType;
		private string _scanPower;
		private string _statisticsPower;
		private string _readPower;
		private string _state;
		private string _ext1;
		private string _deptId;
		private string _deptName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SurveyQuestion()
		{
		}

		public SurveyQuestion(
			string p_id,
			string p_title,
			string p_contents,
			string p_ticketType,
			DateTime? p_startTime,
			DateTime? p_endTime,
			string p_isNoName,
			string p_powerType,
			string p_scanPower,
			string p_statisticsPower,
			string p_readPower,
			string p_state,
			string p_ext1,
			string p_deptId,
			string p_deptName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_title = p_title;
			_contents = p_contents;
			_ticketType = p_ticketType;
			_startTime = p_startTime;
			_endTime = p_endTime;
			_isNoName = p_isNoName;
			_powerType = p_powerType;
			_scanPower = p_scanPower;
			_statisticsPower = p_statisticsPower;
			_readPower = p_readPower;
			_state = p_state;
			_ext1 = p_ext1;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_createId = p_createId;
			_createName = p_createName;
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

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
					RaisePropertyChanged(SurveyQuestion.Prop_Title, oldValue, value);
				}
			}

		}

		[Property("Contents", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string Contents
		{
			get { return _contents; }
			set
			{
				if ((_contents == null) || (value == null) || (!value.Equals(_contents)))
				{
                    object oldValue = _contents;
					_contents = value;
					RaisePropertyChanged(SurveyQuestion.Prop_Contents, oldValue, value);
				}
			}

		}

		[Property("TicketType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string TicketType
		{
			get { return _ticketType; }
			set
			{
				if ((_ticketType == null) || (value == null) || (!value.Equals(_ticketType)))
				{
                    object oldValue = _ticketType;
					_ticketType = value;
					RaisePropertyChanged(SurveyQuestion.Prop_TicketType, oldValue, value);
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
					RaisePropertyChanged(SurveyQuestion.Prop_StartTime, oldValue, value);
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
					RaisePropertyChanged(SurveyQuestion.Prop_EndTime, oldValue, value);
				}
			}

		}

		[Property("IsNoName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IsNoName
		{
			get { return _isNoName; }
			set
			{
				if ((_isNoName == null) || (value == null) || (!value.Equals(_isNoName)))
				{
                    object oldValue = _isNoName;
					_isNoName = value;
					RaisePropertyChanged(SurveyQuestion.Prop_IsNoName, oldValue, value);
				}
			}

		}

		[Property("PowerType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PowerType
		{
			get { return _powerType; }
			set
			{
				if ((_powerType == null) || (value == null) || (!value.Equals(_powerType)))
				{
                    object oldValue = _powerType;
					_powerType = value;
					RaisePropertyChanged(SurveyQuestion.Prop_PowerType, oldValue, value);
				}
			}

		}

		[Property("ScanPower", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string ScanPower
		{
			get { return _scanPower; }
			set
			{
				if ((_scanPower == null) || (value == null) || (!value.Equals(_scanPower)))
				{
                    object oldValue = _scanPower;
					_scanPower = value;
					RaisePropertyChanged(SurveyQuestion.Prop_ScanPower, oldValue, value);
				}
			}

		}

		[Property("StatisticsPower", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string StatisticsPower
		{
			get { return _statisticsPower; }
			set
			{
				if ((_statisticsPower == null) || (value == null) || (!value.Equals(_statisticsPower)))
				{
                    object oldValue = _statisticsPower;
					_statisticsPower = value;
					RaisePropertyChanged(SurveyQuestion.Prop_StatisticsPower, oldValue, value);
				}
			}

		}

		[Property("ReadPower", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string ReadPower
		{
			get { return _readPower; }
			set
			{
				if ((_readPower == null) || (value == null) || (!value.Equals(_readPower)))
				{
                    object oldValue = _readPower;
					_readPower = value;
					RaisePropertyChanged(SurveyQuestion.Prop_ReadPower, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(SurveyQuestion.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Ext1", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext1
		{
			get { return _ext1; }
			set
			{
				if ((_ext1 == null) || (value == null) || (!value.Equals(_ext1)))
				{
                    object oldValue = _ext1;
					_ext1 = value;
					RaisePropertyChanged(SurveyQuestion.Prop_Ext1, oldValue, value);
				}
			}

		}

		[Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DeptId
		{
			get { return _deptId; }
			set
			{
				if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
				{
                    object oldValue = _deptId;
					_deptId = value;
					RaisePropertyChanged(SurveyQuestion.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(SurveyQuestion.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("CreateId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string CreateId
		{
			get { return _createId; }
			set
			{
				if ((_createId == null) || (value == null) || (!value.Equals(_createId)))
				{
                    object oldValue = _createId;
					_createId = value;
					RaisePropertyChanged(SurveyQuestion.Prop_CreateId, oldValue, value);
				}
			}

		}

		[Property("CreateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CreateName
		{
			get { return _createName; }
			set
			{
				if ((_createName == null) || (value == null) || (!value.Equals(_createName)))
				{
                    object oldValue = _createName;
					_createName = value;
					RaisePropertyChanged(SurveyQuestion.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SurveyQuestion.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SurveyQuestion
}

