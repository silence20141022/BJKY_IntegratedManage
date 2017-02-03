// Business class WorkTimeFact generated from WorkTimeFact
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
	[ActiveRecord("WorkTimeFact")]
	public partial class WorkTimeFact : IMModelBase<WorkTimeFact>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CurrentDate = "CurrentDate";
		public static string Prop_PrjId = "PrjId";
		public static string Prop_PrjCode = "PrjCode";
		public static string Prop_PrjName = "PrjName";
		public static string Prop_MajorId = "MajorId";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_MajorDeptId = "MajorDeptId";
		public static string Prop_MajorDeptName = "MajorDeptName";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_UserDeptId = "UserDeptId";
		public static string Prop_UserDeptName = "UserDeptName";
		public static string Prop_NormalHour = "NormalHour";
		public static string Prop_ExtralHour = "ExtralHour";
		public static string Prop_Total = "Total";
		public static string Prop_IsOutgo = "IsOutgo";
		public static string Prop_IsManage = "IsManage";
		public static string Prop_WorkType = "WorkType";
		public static string Prop_TaskId = "TaskId";
		public static string Prop_TaskCode = "TaskCode";
		public static string Prop_TaskName = "TaskName";
		public static string Prop_TaskProgress = "TaskProgress";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateDate = "CreateDate";
		public static string Prop_Remark = "Remark";

		#endregion

		#region Private_Variables

		private string _id;
		private DateTime? _currentDate;
		private string _prjId;
		private string _prjCode;
		private string _prjName;
		private string _majorId;
		private string _majorName;
		private string _majorDeptId;
		private string _majorDeptName;
		private string _userId;
		private string _userName;
		private string _userDeptId;
		private string _userDeptName;
		private System.Decimal? _normalHour;
		private System.Decimal? _extralHour;
		private System.Decimal? _total;
		private string _isOutgo;
		private string _isManage;
		private string _workType;
		private string _taskId;
		private string _taskCode;
		private string _taskName;
		private int? _taskProgress;
		private string _createId;
		private string _createName;
		private DateTime? _createDate;
		private string _remark;


		#endregion

		#region Constructors

		public WorkTimeFact()
		{
		}

		public WorkTimeFact(
			string p_id,
			DateTime? p_currentDate,
			string p_prjId,
			string p_prjCode,
			string p_prjName,
			string p_majorId,
			string p_majorName,
			string p_majorDeptId,
			string p_majorDeptName,
			string p_userId,
			string p_userName,
			string p_userDeptId,
			string p_userDeptName,
			System.Decimal? p_normalHour,
			System.Decimal? p_extralHour,
			System.Decimal? p_total,
			string p_isOutgo,
			string p_isManage,
			string p_workType,
			string p_taskId,
			string p_taskCode,
			string p_taskName,
			int? p_taskProgress,
			string p_createId,
			string p_createName,
			DateTime? p_createDate,
			string p_remark)
		{
			_id = p_id;
			_currentDate = p_currentDate;
			_prjId = p_prjId;
			_prjCode = p_prjCode;
			_prjName = p_prjName;
			_majorId = p_majorId;
			_majorName = p_majorName;
			_majorDeptId = p_majorDeptId;
			_majorDeptName = p_majorDeptName;
			_userId = p_userId;
			_userName = p_userName;
			_userDeptId = p_userDeptId;
			_userDeptName = p_userDeptName;
			_normalHour = p_normalHour;
			_extralHour = p_extralHour;
			_total = p_total;
			_isOutgo = p_isOutgo;
			_isManage = p_isManage;
			_workType = p_workType;
			_taskId = p_taskId;
			_taskCode = p_taskCode;
			_taskName = p_taskName;
			_taskProgress = p_taskProgress;
			_createId = p_createId;
			_createName = p_createName;
			_createDate = p_createDate;
			_remark = p_remark;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("CurrentDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? CurrentDate
		{
			get { return _currentDate; }
			set
			{
				if (value != _currentDate)
				{
                    object oldValue = _currentDate;
					_currentDate = value;
					RaisePropertyChanged(WorkTimeFact.Prop_CurrentDate, oldValue, value);
				}
			}

		}

		[Property("PrjId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PrjId
		{
			get { return _prjId; }
			set
			{
				if ((_prjId == null) || (value == null) || (!value.Equals(_prjId)))
				{
                    object oldValue = _prjId;
					_prjId = value;
					RaisePropertyChanged(WorkTimeFact.Prop_PrjId, oldValue, value);
				}
			}

		}

		[Property("PrjCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PrjCode
		{
			get { return _prjCode; }
			set
			{
				if ((_prjCode == null) || (value == null) || (!value.Equals(_prjCode)))
				{
                    object oldValue = _prjCode;
					_prjCode = value;
					RaisePropertyChanged(WorkTimeFact.Prop_PrjCode, oldValue, value);
				}
			}

		}

		[Property("PrjName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string PrjName
		{
			get { return _prjName; }
			set
			{
				if ((_prjName == null) || (value == null) || (!value.Equals(_prjName)))
				{
                    object oldValue = _prjName;
					_prjName = value;
					RaisePropertyChanged(WorkTimeFact.Prop_PrjName, oldValue, value);
				}
			}

		}

		[Property("MajorId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string MajorId
		{
			get { return _majorId; }
			set
			{
				if ((_majorId == null) || (value == null) || (!value.Equals(_majorId)))
				{
                    object oldValue = _majorId;
					_majorId = value;
					RaisePropertyChanged(WorkTimeFact.Prop_MajorId, oldValue, value);
				}
			}

		}

		[Property("MajorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorName
		{
			get { return _majorName; }
			set
			{
				if ((_majorName == null) || (value == null) || (!value.Equals(_majorName)))
				{
                    object oldValue = _majorName;
					_majorName = value;
					RaisePropertyChanged(WorkTimeFact.Prop_MajorName, oldValue, value);
				}
			}

		}

		[Property("MajorDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string MajorDeptId
		{
			get { return _majorDeptId; }
			set
			{
				if ((_majorDeptId == null) || (value == null) || (!value.Equals(_majorDeptId)))
				{
                    object oldValue = _majorDeptId;
					_majorDeptId = value;
					RaisePropertyChanged(WorkTimeFact.Prop_MajorDeptId, oldValue, value);
				}
			}

		}

		[Property("MajorDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorDeptName
		{
			get { return _majorDeptName; }
			set
			{
				if ((_majorDeptName == null) || (value == null) || (!value.Equals(_majorDeptName)))
				{
                    object oldValue = _majorDeptName;
					_majorDeptName = value;
					RaisePropertyChanged(WorkTimeFact.Prop_MajorDeptName, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("UserDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
		public string UserDeptId
		{
			get { return _userDeptId; }
			set
			{
				if ((_userDeptId == null) || (value == null) || (!value.Equals(_userDeptId)))
				{
                    object oldValue = _userDeptId;
					_userDeptId = value;
					RaisePropertyChanged(WorkTimeFact.Prop_UserDeptId, oldValue, value);
				}
			}

		}

		[Property("UserDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserDeptName
		{
			get { return _userDeptName; }
			set
			{
				if ((_userDeptName == null) || (value == null) || (!value.Equals(_userDeptName)))
				{
                    object oldValue = _userDeptName;
					_userDeptName = value;
					RaisePropertyChanged(WorkTimeFact.Prop_UserDeptName, oldValue, value);
				}
			}

		}

		[Property("NormalHour", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? NormalHour
		{
			get { return _normalHour; }
			set
			{
				if (value != _normalHour)
				{
                    object oldValue = _normalHour;
					_normalHour = value;
					RaisePropertyChanged(WorkTimeFact.Prop_NormalHour, oldValue, value);
				}
			}

		}

		[Property("ExtralHour", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ExtralHour
		{
			get { return _extralHour; }
			set
			{
				if (value != _extralHour)
				{
                    object oldValue = _extralHour;
					_extralHour = value;
					RaisePropertyChanged(WorkTimeFact.Prop_ExtralHour, oldValue, value);
				}
			}

		}

		[Property("Total", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? Total
		{
			get { return _total; }
			set
			{
				if (value != _total)
				{
                    object oldValue = _total;
					_total = value;
					RaisePropertyChanged(WorkTimeFact.Prop_Total, oldValue, value);
				}
			}

		}

		[Property("IsOutgo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string IsOutgo
		{
			get { return _isOutgo; }
			set
			{
				if ((_isOutgo == null) || (value == null) || (!value.Equals(_isOutgo)))
				{
                    object oldValue = _isOutgo;
					_isOutgo = value;
					RaisePropertyChanged(WorkTimeFact.Prop_IsOutgo, oldValue, value);
				}
			}

		}

		[Property("IsManage", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string IsManage
		{
			get { return _isManage; }
			set
			{
				if ((_isManage == null) || (value == null) || (!value.Equals(_isManage)))
				{
                    object oldValue = _isManage;
					_isManage = value;
					RaisePropertyChanged(WorkTimeFact.Prop_IsManage, oldValue, value);
				}
			}

		}

		[Property("WorkType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string WorkType
		{
			get { return _workType; }
			set
			{
				if ((_workType == null) || (value == null) || (!value.Equals(_workType)))
				{
                    object oldValue = _workType;
					_workType = value;
					RaisePropertyChanged(WorkTimeFact.Prop_WorkType, oldValue, value);
				}
			}

		}

		[Property("TaskId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
		public string TaskId
		{
			get { return _taskId; }
			set
			{
				if ((_taskId == null) || (value == null) || (!value.Equals(_taskId)))
				{
                    object oldValue = _taskId;
					_taskId = value;
					RaisePropertyChanged(WorkTimeFact.Prop_TaskId, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_TaskCode, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_TaskName, oldValue, value);
				}
			}

		}

		[Property("TaskProgress", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? TaskProgress
		{
			get { return _taskProgress; }
			set
			{
				if (value != _taskProgress)
				{
                    object oldValue = _taskProgress;
					_taskProgress = value;
					RaisePropertyChanged(WorkTimeFact.Prop_TaskProgress, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_CreateName, oldValue, value);
				}
			}

		}

		[Property("CreateDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? CreateDate
		{
			get { return _createDate; }
			set
			{
				if (value != _createDate)
				{
                    object oldValue = _createDate;
					_createDate = value;
					RaisePropertyChanged(WorkTimeFact.Prop_CreateDate, oldValue, value);
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
					RaisePropertyChanged(WorkTimeFact.Prop_Remark, oldValue, value);
				}
			}

		}

		#endregion
	} // WorkTimeFact
}

