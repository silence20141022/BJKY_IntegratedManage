// Business class TaskDelegate generated from TaskDelegate
// Creator: Ray
// Created Date: [2013-04-10]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("TaskDelegate")]
	public partial class TaskDelegate : IMModelBase<TaskDelegate>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_DelegateUserId = "DelegateUserId";
		public static string Prop_DelegateUserName = "DelegateUserName";
		public static string Prop_StartTime = "StartTime";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Remark = "Remark";
		public static string Prop_State = "State";

		#endregion

		#region Private_Variables

		private string _id;
		private string _delegateUserId;
		private string _delegateUserName;
		private DateTime? _startTime;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _remark;
		private string _state;


		#endregion

		#region Constructors

		public TaskDelegate()
		{
		}

		public TaskDelegate(
			string p_id,
			string p_delegateUserId,
			string p_delegateUserName,
			DateTime? p_startTime,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_remark,
			string p_state)
		{
			_id = p_id;
			_delegateUserId = p_delegateUserId;
			_delegateUserName = p_delegateUserName;
			_startTime = p_startTime;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_remark = p_remark;
			_state = p_state;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("DelegateUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DelegateUserId
		{
			get { return _delegateUserId; }
			set
			{
				if ((_delegateUserId == null) || (value == null) || (!value.Equals(_delegateUserId)))
				{
                    object oldValue = _delegateUserId;
					_delegateUserId = value;
					RaisePropertyChanged(TaskDelegate.Prop_DelegateUserId, oldValue, value);
				}
			}

		}

		[Property("DelegateUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DelegateUserName
		{
			get { return _delegateUserName; }
			set
			{
				if ((_delegateUserName == null) || (value == null) || (!value.Equals(_delegateUserName)))
				{
                    object oldValue = _delegateUserName;
					_delegateUserName = value;
					RaisePropertyChanged(TaskDelegate.Prop_DelegateUserName, oldValue, value);
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
					RaisePropertyChanged(TaskDelegate.Prop_StartTime, oldValue, value);
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
					RaisePropertyChanged(TaskDelegate.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(TaskDelegate.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(TaskDelegate.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(TaskDelegate.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(TaskDelegate.Prop_State, oldValue, value);
				}
			}

		}

		#endregion
	} // TaskDelegate
}

