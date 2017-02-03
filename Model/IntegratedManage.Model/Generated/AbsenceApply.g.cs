// Business class AbsenceApply generated from AbsenceApply
// Creator: Ray
// Created Date: [2013-05-06]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("AbsenceApply")]
	public partial class AbsenceApply : IMModelBase<AbsenceApply>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ApplyUserId = "ApplyUserId";
		public static string Prop_ApplyUserName = "ApplyUserName";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_Reason = "Reason";
		public static string Prop_StartTime = "StartTime";
		public static string Prop_EndTime = "EndTime";
		public static string Prop_Address = "Address";
		public static string Prop_WorkFlowState = "WorkFlowState";
		public static string Prop_ApproveResult = "ApproveResult";
		public static string Prop_ExamineUserId = "ExamineUserId";
		public static string Prop_ExamineUserName = "ExamineUserName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _applyUserId;
		private string _applyUserName;
		private string _deptId;
		private string _deptName;
		private string _reason;
		private DateTime? _startTime;
		private DateTime? _endTime;
		private string _address;
		private string _workFlowState;
		private string _approveResult;
		private string _examineUserId;
		private string _examineUserName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public AbsenceApply()
		{
		}

		public AbsenceApply(
			string p_id,
			string p_applyUserId,
			string p_applyUserName,
			string p_deptId,
			string p_deptName,
			string p_reason,
			DateTime? p_startTime,
			DateTime? p_endTime,
			string p_address,
			string p_workFlowState,
			string p_approveResult,
			string p_examineUserId,
			string p_examineUserName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_applyUserId = p_applyUserId;
			_applyUserName = p_applyUserName;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_reason = p_reason;
			_startTime = p_startTime;
			_endTime = p_endTime;
			_address = p_address;
			_workFlowState = p_workFlowState;
			_approveResult = p_approveResult;
			_examineUserId = p_examineUserId;
			_examineUserName = p_examineUserName;
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

		[Property("ApplyUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ApplyUserId
		{
			get { return _applyUserId; }
			set
			{
				if ((_applyUserId == null) || (value == null) || (!value.Equals(_applyUserId)))
				{
                    object oldValue = _applyUserId;
					_applyUserId = value;
					RaisePropertyChanged(AbsenceApply.Prop_ApplyUserId, oldValue, value);
				}
			}

		}

		[Property("ApplyUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ApplyUserName
		{
			get { return _applyUserName; }
			set
			{
				if ((_applyUserName == null) || (value == null) || (!value.Equals(_applyUserName)))
				{
                    object oldValue = _applyUserName;
					_applyUserName = value;
					RaisePropertyChanged(AbsenceApply.Prop_ApplyUserName, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_DeptId, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("Reason", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string Reason
		{
			get { return _reason; }
			set
			{
				if ((_reason == null) || (value == null) || (!value.Equals(_reason)))
				{
                    object oldValue = _reason;
					_reason = value;
					RaisePropertyChanged(AbsenceApply.Prop_Reason, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_StartTime, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_EndTime, oldValue, value);
				}
			}

		}

		[Property("Address", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Address
		{
			get { return _address; }
			set
			{
				if ((_address == null) || (value == null) || (!value.Equals(_address)))
				{
                    object oldValue = _address;
					_address = value;
					RaisePropertyChanged(AbsenceApply.Prop_Address, oldValue, value);
				}
			}

		}

		[Property("WorkFlowState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string WorkFlowState
		{
			get { return _workFlowState; }
			set
			{
				if ((_workFlowState == null) || (value == null) || (!value.Equals(_workFlowState)))
				{
                    object oldValue = _workFlowState;
					_workFlowState = value;
					RaisePropertyChanged(AbsenceApply.Prop_WorkFlowState, oldValue, value);
				}
			}

		}

		[Property("ApproveResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ApproveResult
		{
			get { return _approveResult; }
			set
			{
				if ((_approveResult == null) || (value == null) || (!value.Equals(_approveResult)))
				{
                    object oldValue = _approveResult;
					_approveResult = value;
					RaisePropertyChanged(AbsenceApply.Prop_ApproveResult, oldValue, value);
				}
			}

		}

		[Property("ExamineUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ExamineUserId
		{
			get { return _examineUserId; }
			set
			{
				if ((_examineUserId == null) || (value == null) || (!value.Equals(_examineUserId)))
				{
                    object oldValue = _examineUserId;
					_examineUserId = value;
					RaisePropertyChanged(AbsenceApply.Prop_ExamineUserId, oldValue, value);
				}
			}

		}

		[Property("ExamineUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ExamineUserName
		{
			get { return _examineUserName; }
			set
			{
				if ((_examineUserName == null) || (value == null) || (!value.Equals(_examineUserName)))
				{
                    object oldValue = _examineUserName;
					_examineUserName = value;
					RaisePropertyChanged(AbsenceApply.Prop_ExamineUserName, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(AbsenceApply.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // AbsenceApply
}

