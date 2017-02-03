// Business class A_ChargeProgres generated from A_ChargeProgress
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
	[ActiveRecord("A_ChargeProgress")]
	public partial class A_ChargeProgres : IMModelBase<A_ChargeProgres>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Title = "Title";
		public static string Prop_TaskId = "TaskId";
		public static string Prop_TaskCode = "TaskCode";
		public static string Prop_TaskName = "TaskName";
		public static string Prop_Progress = "Progress";
		public static string Prop_ConfirmDate = "ConfirmDate";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_State = "State";
		public static string Prop_Flag = "Flag";

		#endregion

		#region Private_Variables

		private string _id;
		private string _title;
		private string _taskId;
		private string _taskCode;
		private string _taskName;
		private string _progress;
		private DateTime? _confirmDate;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _attachment;
		private string _state;
		private string _flag;


		#endregion

		#region Constructors

		public A_ChargeProgres()
		{
		}

		public A_ChargeProgres(
			string p_id,
			string p_title,
			string p_taskId,
			string p_taskCode,
			string p_taskName,
			string p_progress,
			DateTime? p_confirmDate,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_attachment,
			string p_state,
			string p_flag)
		{
			_id = p_id;
			_title = p_title;
			_taskId = p_taskId;
			_taskCode = p_taskCode;
			_taskName = p_taskName;
			_progress = p_progress;
			_confirmDate = p_confirmDate;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_attachment = p_attachment;
			_state = p_state;
			_flag = p_flag;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 400)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_Title, oldValue, value);
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
					RaisePropertyChanged(A_ChargeProgres.Prop_TaskId, oldValue, value);
				}
			}

		}

		[Property("TaskCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string TaskCode
		{
			get { return _taskCode; }
			set
			{
				if ((_taskCode == null) || (value == null) || (!value.Equals(_taskCode)))
				{
                    object oldValue = _taskCode;
					_taskCode = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_TaskCode, oldValue, value);
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
					RaisePropertyChanged(A_ChargeProgres.Prop_TaskName, oldValue, value);
				}
			}

		}

		[Property("Progress", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Progress
		{
			get { return _progress; }
			set
			{
				if ((_progress == null) || (value == null) || (!value.Equals(_progress)))
				{
                    object oldValue = _progress;
					_progress = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_Progress, oldValue, value);
				}
			}

		}

		[Property("ConfirmDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ConfirmDate
		{
			get { return _confirmDate; }
			set
			{
				if (value != _confirmDate)
				{
                    object oldValue = _confirmDate;
					_confirmDate = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_ConfirmDate, oldValue, value);
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
					RaisePropertyChanged(A_ChargeProgres.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(A_ChargeProgres.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(A_ChargeProgres.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("Attachment", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Attachment
		{
			get { return _attachment; }
			set
			{
				if ((_attachment == null) || (value == null) || (!value.Equals(_attachment)))
				{
                    object oldValue = _attachment;
					_attachment = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_Attachment, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Flag", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Flag
		{
			get { return _flag; }
			set
			{
				if ((_flag == null) || (value == null) || (!value.Equals(_flag)))
				{
                    object oldValue = _flag;
					_flag = value;
					RaisePropertyChanged(A_ChargeProgres.Prop_Flag, oldValue, value);
				}
			}

		}

		#endregion
	} // A_ChargeProgres
}

