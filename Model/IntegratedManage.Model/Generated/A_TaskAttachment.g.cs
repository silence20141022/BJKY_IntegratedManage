// Business class A_TaskAttachment generated from A_TaskAttachment
// Creator: Ray
// Created Date: [2013-03-09]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("A_TaskAttachment")]
	public partial class A_TaskAttachment : IMModelBase<A_TaskAttachment>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Title = "Title";
		public static string Prop_TaskId = "TaskId";
		public static string Prop_TaskCode = "TaskCode";
		public static string Prop_TaskName = "TaskName";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_State = "State";
		public static string Prop_Flag = "Flag";
		public static string Prop_DutyId = "DutyId";
		public static string Prop_DutyName = "DutyName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _title;
		private string _taskId;
		private string _taskCode;
		private string _taskName;
		private string _attachment;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _state;
		private string _flag;
		private string _dutyId;
		private string _dutyName;


		#endregion

		#region Constructors

		public A_TaskAttachment()
		{
		}

		public A_TaskAttachment(
			string p_id,
			string p_title,
			string p_taskId,
			string p_taskCode,
			string p_taskName,
			string p_attachment,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_state,
			string p_flag,
			string p_dutyId,
			string p_dutyName)
		{
			_id = p_id;
			_title = p_title;
			_taskId = p_taskId;
			_taskCode = p_taskCode;
			_taskName = p_taskName;
			_attachment = p_attachment;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_state = p_state;
			_flag = p_flag;
			_dutyId = p_dutyId;
			_dutyName = p_dutyName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_Title, oldValue, value);
				}
			}

		}

		[Property("TaskId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string TaskId
		{
			get { return _taskId; }
			set
			{
				if ((_taskId == null) || (value == null) || (!value.Equals(_taskId)))
				{
                    object oldValue = _taskId;
					_taskId = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_TaskId, oldValue, value);
				}
			}

		}

		[Property("TaskCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string TaskCode
		{
			get { return _taskCode; }
			set
			{
				if ((_taskCode == null) || (value == null) || (!value.Equals(_taskCode)))
				{
                    object oldValue = _taskCode;
					_taskCode = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_TaskCode, oldValue, value);
				}
			}

		}

		[Property("TaskName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string TaskName
		{
			get { return _taskName; }
			set
			{
				if ((_taskName == null) || (value == null) || (!value.Equals(_taskName)))
				{
                    object oldValue = _taskName;
					_taskName = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_TaskName, oldValue, value);
				}
			}

		}

		[Property("Attachment", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Attachment
		{
			get { return _attachment; }
			set
			{
				if ((_attachment == null) || (value == null) || (!value.Equals(_attachment)))
				{
                    object oldValue = _attachment;
					_attachment = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_Attachment, oldValue, value);
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
					RaisePropertyChanged(A_TaskAttachment.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(A_TaskAttachment.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(A_TaskAttachment.Prop_CreateTime, oldValue, value);
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
					RaisePropertyChanged(A_TaskAttachment.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Flag", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Flag
		{
			get { return _flag; }
			set
			{
				if ((_flag == null) || (value == null) || (!value.Equals(_flag)))
				{
                    object oldValue = _flag;
					_flag = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_Flag, oldValue, value);
				}
			}

		}

		[Property("DutyId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DutyId
		{
			get { return _dutyId; }
			set
			{
				if ((_dutyId == null) || (value == null) || (!value.Equals(_dutyId)))
				{
                    object oldValue = _dutyId;
					_dutyId = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_DutyId, oldValue, value);
				}
			}

		}

		[Property("DutyName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string DutyName
		{
			get { return _dutyName; }
			set
			{
				if ((_dutyName == null) || (value == null) || (!value.Equals(_dutyName)))
				{
                    object oldValue = _dutyName;
					_dutyName = value;
					RaisePropertyChanged(A_TaskAttachment.Prop_DutyName, oldValue, value);
				}
			}

		}

		#endregion
	} // A_TaskAttachment
}

