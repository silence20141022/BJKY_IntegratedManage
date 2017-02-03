// Business class LeaderTrip generated from LeaderTrip
// Creator: Ray
// Created Date: [2014-09-03]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("LeaderTrip")]
	public partial class LeaderTrip : IMModelBase<LeaderTrip>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_TripStartTime = "TripStartTime";
		public static string Prop_StartAMPM = "StartAMPM";
		public static string Prop_TripEndTime = "TripEndTime";
		public static string Prop_EndAMPM = "EndAMPM";
		public static string Prop_Addr = "Addr";
		public static string Prop_Reason = "Reason";
		public static string Prop_TripType = "TripType";
		public static string Prop_State = "State";
		public static string Prop_UserIds = "UserIds";
		public static string Prop_UserNames = "UserNames";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private DateTime? _tripStartTime;
		private string _startAMPM;
		private DateTime? _tripEndTime;
		private string _endAMPM;
		private string _addr;
		private string _reason;
		private string _tripType;
		private string _state;
		private string _userIds;
		private string _userNames;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public LeaderTrip()
		{
		}

		public LeaderTrip(
			string p_id,
			DateTime? p_tripStartTime,
			string p_startAMPM,
			DateTime? p_tripEndTime,
			string p_endAMPM,
			string p_addr,
			string p_reason,
			string p_tripType,
			string p_state,
			string p_userIds,
			string p_userNames,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_tripStartTime = p_tripStartTime;
			_startAMPM = p_startAMPM;
			_tripEndTime = p_tripEndTime;
			_endAMPM = p_endAMPM;
			_addr = p_addr;
			_reason = p_reason;
			_tripType = p_tripType;
			_state = p_state;
			_userIds = p_userIds;
			_userNames = p_userNames;
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
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("TripStartTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? TripStartTime
		{
			get { return _tripStartTime; }
			set
			{
				if (value != _tripStartTime)
				{
                    object oldValue = _tripStartTime;
					_tripStartTime = value;
					RaisePropertyChanged(LeaderTrip.Prop_TripStartTime, oldValue, value);
				}
			}

		}

		[Property("StartAMPM", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string StartAMPM
		{
			get { return _startAMPM; }
			set
			{
				if ((_startAMPM == null) || (value == null) || (!value.Equals(_startAMPM)))
				{
                    object oldValue = _startAMPM;
					_startAMPM = value;
					RaisePropertyChanged(LeaderTrip.Prop_StartAMPM, oldValue, value);
				}
			}

		}

		[Property("TripEndTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? TripEndTime
		{
			get { return _tripEndTime; }
			set
			{
				if (value != _tripEndTime)
				{
                    object oldValue = _tripEndTime;
					_tripEndTime = value;
					RaisePropertyChanged(LeaderTrip.Prop_TripEndTime, oldValue, value);
				}
			}

		}

		[Property("EndAMPM", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string EndAMPM
		{
			get { return _endAMPM; }
			set
			{
				if ((_endAMPM == null) || (value == null) || (!value.Equals(_endAMPM)))
				{
                    object oldValue = _endAMPM;
					_endAMPM = value;
					RaisePropertyChanged(LeaderTrip.Prop_EndAMPM, oldValue, value);
				}
			}

		}

		[Property("Addr", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Addr
		{
			get { return _addr; }
			set
			{
				if ((_addr == null) || (value == null) || (!value.Equals(_addr)))
				{
                    object oldValue = _addr;
					_addr = value;
					RaisePropertyChanged(LeaderTrip.Prop_Addr, oldValue, value);
				}
			}

		}

		[Property("Reason", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Reason
		{
			get { return _reason; }
			set
			{
				if ((_reason == null) || (value == null) || (!value.Equals(_reason)))
				{
                    object oldValue = _reason;
					_reason = value;
					RaisePropertyChanged(LeaderTrip.Prop_Reason, oldValue, value);
				}
			}

		}

		[Property("TripType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string TripType
		{
			get { return _tripType; }
			set
			{
				if ((_tripType == null) || (value == null) || (!value.Equals(_tripType)))
				{
                    object oldValue = _tripType;
					_tripType = value;
					RaisePropertyChanged(LeaderTrip.Prop_TripType, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(LeaderTrip.Prop_State, oldValue, value);
				}
			}

		}

		[Property("UserIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string UserIds
		{
			get { return _userIds; }
			set
			{
				if ((_userIds == null) || (value == null) || (!value.Equals(_userIds)))
				{
                    object oldValue = _userIds;
					_userIds = value;
					RaisePropertyChanged(LeaderTrip.Prop_UserIds, oldValue, value);
				}
			}

		}

		[Property("UserNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string UserNames
		{
			get { return _userNames; }
			set
			{
				if ((_userNames == null) || (value == null) || (!value.Equals(_userNames)))
				{
                    object oldValue = _userNames;
					_userNames = value;
					RaisePropertyChanged(LeaderTrip.Prop_UserNames, oldValue, value);
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
					RaisePropertyChanged(LeaderTrip.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(LeaderTrip.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(LeaderTrip.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // LeaderTrip
}

