// Business class A_TaskWBS generated from A_TaskWBS
// Creator: Rongwei
// Created Date: [2012-04-05]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace IntegratedManage.Model
{
	[ActiveRecord("A_TaskWBS")]
    public partial class A_TaskWBS : EditSensityTreeNodeEntityBase<A_TaskWBS>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ParentID = "ParentID";
		public static string Prop_Path = "Path";
		public static string Prop_PathLevel = "PathLevel";
		public static string Prop_IsLeaf = "IsLeaf";
		public static string Prop_SortIndex = "SortIndex";
		public static string Prop_EditStatus = "EditStatus";
		public static string Prop_Tag = "Tag";
		public static string Prop_LastModifiedDate = "LastModifiedDate";
		public static string Prop_State = "State";
		public static string Prop_Flag = "Flag";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_Code = "Code";
		public static string Prop_TaskName = "TaskName";
		public static string Prop_RefTaskCode = "RefTaskCode";
		public static string Prop_RefTaskName = "RefTaskName";
		public static string Prop_TaskType = "TaskType";
		public static string Prop_PlanWorkHours = "PlanWorkHours";
        public static string Prop_ConfirmWorkHours = "ConfirmWorkHours";
        public static string Prop_Balance = "Balance";
		public static string Prop_ConfirmReason = "ConfirmReason";
		public static string Prop_SubmitUserId = "SubmitUserId";
		public static string Prop_SubmitUserName = "SubmitUserName";
		public static string Prop_SubmitDate = "SubmitDate";
		public static string Prop_DutyId = "DutyId";
        public static string Prop_DutyName = "DutyName";
        public static string Prop_UserIds = "UserIds";
        public static string Prop_UserNames = "UserNames";
        public static string Prop_LeaderId = "LeaderId";
        public static string Prop_LeaderName = "LeaderName";
        public static string Prop_SecondDeptIds = "SecondDeptIds";
        public static string Prop_SecondDeptNames = "SecondDeptNames";
        public static string Prop_DeptCharge = "DeptCharge";
        public static string Prop_AimDeptCharge = "AimDeptCharge";
		public static string Prop_ReceiveDate = "ReceiveDate";
		public static string Prop_ImportantRemark = "ImportantRemark";
		public static string Prop_Remark = "Remark";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_FactWorkHours = "FactWorkHours";
		public static string Prop_FactStartDate = "FactStartDate";
        public static string Prop_FactEndDate = "FactEndDate";
        public static string Prop_PlanStartDate = "PlanStartDate";
        public static string Prop_PlanEndDate = "PlanEndDate";
		public static string Prop_TaskProgress = "TaskProgress";
		public static string Prop_Suggestion = "Suggestion";
		public static string Prop_RejectReason = "RejectReason";
		public static string Prop_ExecuteRemark = "ExecuteRemark";
		public static string Prop_AttachmentChild = "AttachmentChild";
		public static string Prop_ExamStandard = "ExamStandard";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_ExtTime1 = "ExtTime1";
        public static string Prop_ExtTime2 = "ExtTime2";
        public static string Prop_Ext3 = "Ext3";
        public static string Prop_Ext4 = "Ext4";
        public static string Prop_Year = "Year";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _parentID;
		private string _path;
		private int? _pathLevel;
		private bool? _isLeaf;
		private int? _sortIndex;
		private string _editStatus;
		private string _tag;
		private DateTime? _lastModifiedDate;
		private string _state;
		private string _flag;
		private string _deptId;
		private string _deptName;
		private string _code;
		private string _taskName;
		private string _refTaskCode;
		private string _refTaskName;
		private string _taskType;
		private float? _planWorkHours;
        private float? _confirmWorkHours;
        private float? _balance;
		private string _confirmReason;
		private string _submitUserId;
		private string _submitUserName;
		private DateTime? _submitDate;
		private string _dutyId;
        private string _dutyName;
        private string _userIds;
        private string _userNames;
        private string _leaderId;
        private string _leaderName;
        private string _secondDeptIds;
        private string _secondDeptNames;
        private string _deptCharge;
        private string _aimDeptCharge;
		private DateTime? _receiveDate;
		private string _importantRemark;
		private string _remark;
		private string _attachment;
		private float? _factWorkHours;
		private DateTime? _planStartDate;
        private DateTime? _planEndDate;
        private DateTime? _factStartDate;
        private DateTime? _factEndDate;
		private float? _taskProgress;
		private string _suggestion;
		private string _rejectReason;
		private string _executeRemark;
		private string _attachmentChild;
		private string _examStandard;
		private string _ext1;
		private string _ext2;
		private DateTime? _extTime1;
        private DateTime? _extTime2;
        private string _ext3;
        private string _ext4;
        private string _year;
        private string _createId;
        private string _createName;
        private DateTime? _createTime;


		#endregion

		#region Constructors

		public A_TaskWBS()
		{
		}

		public A_TaskWBS(
			string p_id,
			string p_parentID,
			string p_path,
			int? p_pathLevel,
			bool? p_isLeaf,
			int? p_sortIndex,
			string p_editStatus,
			string p_tag,
			DateTime? p_lastModifiedDate,
			string p_state,
			string p_flag,
			string p_deptId,
			string p_deptName,
			string p_code,
			string p_taskName,
			string p_refTaskCode,
			string p_refTaskName,
			string p_taskType,
			float? p_planWorkHours,
			float? p_confirmWorkHours,
			string p_confirmReason,
			string p_submitUserId,
			string p_submitUserName,
			DateTime? p_submitDate,
			string p_dutyId,
			string p_dutyName,
			DateTime? p_receiveDate,
			string p_importantRemark,
			string p_remark,
			string p_attachment,
			float? p_factWorkHours,
			DateTime? p_factStartDate,
			DateTime? p_factEndDate,
			float? p_taskProgress,
			string p_suggestion,
			string p_rejectReason,
			string p_executeRemark,
			string p_attachmentChild,
			string p_examStandard,
			string p_ext1,
			string p_ext2,
			DateTime? p_extTime1,
			DateTime? p_extTime2)
		{
			_id = p_id;
			_parentID = p_parentID;
			_path = p_path;
			_pathLevel = p_pathLevel;
			_isLeaf = p_isLeaf;
			_sortIndex = p_sortIndex;
			_editStatus = p_editStatus;
			_tag = p_tag;
			_lastModifiedDate = p_lastModifiedDate;
			_state = p_state;
			_flag = p_flag;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_code = p_code;
			_taskName = p_taskName;
			_refTaskCode = p_refTaskCode;
			_refTaskName = p_refTaskName;
			_taskType = p_taskType;
			_planWorkHours = p_planWorkHours;
			_confirmWorkHours = p_confirmWorkHours;
			_confirmReason = p_confirmReason;
			_submitUserId = p_submitUserId;
			_submitUserName = p_submitUserName;
			_submitDate = p_submitDate;
			_dutyId = p_dutyId;
			_dutyName = p_dutyName;
			_receiveDate = p_receiveDate;
			_importantRemark = p_importantRemark;
			_remark = p_remark;
			_attachment = p_attachment;
			_factWorkHours = p_factWorkHours;
			_factStartDate = p_factStartDate;
			_factEndDate = p_factEndDate;
			_taskProgress = p_taskProgress;
			_suggestion = p_suggestion;
			_rejectReason = p_rejectReason;
			_executeRemark = p_executeRemark;
			_attachmentChild = p_attachmentChild;
			_examStandard = p_examStandard;
			_ext1 = p_ext1;
			_ext2 = p_ext2;
			_extTime1 = p_extTime1;
			_extTime2 = p_extTime2;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("ParentID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public override string ParentID
		{
			get { return _parentID; }
			set
			{
				if ((_parentID == null) || (value == null) || (!value.Equals(_parentID)))
				{
                    object oldValue = _parentID;
					_parentID = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ParentID, oldValue, value);
				}
			}

		}

		[Property("Path", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
        public override string Path
		{
			get { return _path; }
			set
			{
				if ((_path == null) || (value == null) || (!value.Equals(_path)))
				{
                    object oldValue = _path;
					_path = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Path, oldValue, value);
				}
			}

		}

		[Property("PathLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public override int? PathLevel
		{
			get { return _pathLevel; }
			set
			{
				if (value != _pathLevel)
				{
                    object oldValue = _pathLevel;
					_pathLevel = value;
					RaisePropertyChanged(A_TaskWBS.Prop_PathLevel, oldValue, value);
				}
			}

		}

		[Property("IsLeaf", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public override bool? IsLeaf
		{
			get { return _isLeaf; }
			set
			{
				if (value != _isLeaf)
				{
                    object oldValue = _isLeaf;
					_isLeaf = value;
					RaisePropertyChanged(A_TaskWBS.Prop_IsLeaf, oldValue, value);
				}
			}

		}

		[Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public override int? SortIndex
		{
			get { return _sortIndex; }
			set
			{
				if (value != _sortIndex)
				{
                    object oldValue = _sortIndex;
					_sortIndex = value;
					RaisePropertyChanged(A_TaskWBS.Prop_SortIndex, oldValue, value);
				}
			}

		}

		[Property("EditStatus", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public override string EditStatus
		{
			get { return _editStatus; }
			set
			{
				if ((_editStatus == null) || (value == null) || (!value.Equals(_editStatus)))
				{
                    object oldValue = _editStatus;
					_editStatus = value;
					RaisePropertyChanged(A_TaskWBS.Prop_EditStatus, oldValue, value);
				}
			}

		}

		[Property("Tag", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Tag
		{
			get { return _tag; }
			set
			{
				if ((_tag == null) || (value == null) || (!value.Equals(_tag)))
				{
                    object oldValue = _tag;
					_tag = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Tag, oldValue, value);
				}
			}

		}

		[Property("LastModifiedDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? LastModifiedDate
		{
			get { return _lastModifiedDate; }
			set
			{
				if (value != _lastModifiedDate)
				{
                    object oldValue = _lastModifiedDate;
					_lastModifiedDate = value;
					RaisePropertyChanged(A_TaskWBS.Prop_LastModifiedDate, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(A_TaskWBS.Prop_State, oldValue, value);
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
					RaisePropertyChanged(A_TaskWBS.Prop_Flag, oldValue, value);
				}
			}

		}

		[Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
		public string DeptId
		{
			get { return _deptId; }
			set
			{
				if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
				{
                    object oldValue = _deptId;
					_deptId = value;
					RaisePropertyChanged(A_TaskWBS.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(A_TaskWBS.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Code
		{
			get { return _code; }
			set
			{
				if ((_code == null) || (value == null) || (!value.Equals(_code)))
				{
                    object oldValue = _code;
					_code = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Code, oldValue, value);
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
					RaisePropertyChanged(A_TaskWBS.Prop_TaskName, oldValue, value);
				}
			}

		}

		[Property("RefTaskCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RefTaskCode
		{
			get { return _refTaskCode; }
			set
			{
				if ((_refTaskCode == null) || (value == null) || (!value.Equals(_refTaskCode)))
				{
                    object oldValue = _refTaskCode;
					_refTaskCode = value;
					RaisePropertyChanged(A_TaskWBS.Prop_RefTaskCode, oldValue, value);
				}
			}

		}

		[Property("RefTaskName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RefTaskName
		{
			get { return _refTaskName; }
			set
			{
				if ((_refTaskName == null) || (value == null) || (!value.Equals(_refTaskName)))
				{
                    object oldValue = _refTaskName;
					_refTaskName = value;
					RaisePropertyChanged(A_TaskWBS.Prop_RefTaskName, oldValue, value);
				}
			}

		}

		[Property("TaskType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string TaskType
		{
			get { return _taskType; }
			set
			{
				if ((_taskType == null) || (value == null) || (!value.Equals(_taskType)))
				{
                    object oldValue = _taskType;
					_taskType = value;
					RaisePropertyChanged(A_TaskWBS.Prop_TaskType, oldValue, value);
				}
			}

		}

		[Property("PlanWorkHours", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public float? PlanWorkHours
		{
			get { return _planWorkHours; }
			set
			{
				if (value != _planWorkHours)
				{
                    object oldValue = _planWorkHours;
					_planWorkHours = value;
					RaisePropertyChanged(A_TaskWBS.Prop_PlanWorkHours, oldValue, value);
				}
			}

		}

		[Property("ConfirmWorkHours", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public float? ConfirmWorkHours
		{
			get { return _confirmWorkHours; }
			set
			{
				if (value != _confirmWorkHours)
				{
                    object oldValue = _confirmWorkHours;
					_confirmWorkHours = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ConfirmWorkHours, oldValue, value);
				}
			}

        }
        [Property("Balance", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public float? Balance
        {
            get { return _balance; }
            set
            {
                if (value != _balance)
                {
                    object oldValue = _balance;
                    _balance = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_Balance, oldValue, value);
                }
            }

        }

		[Property("ConfirmReason", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ConfirmReason
		{
			get { return _confirmReason; }
			set
			{
				if ((_confirmReason == null) || (value == null) || (!value.Equals(_confirmReason)))
				{
                    object oldValue = _confirmReason;
					_confirmReason = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ConfirmReason, oldValue, value);
				}
			}

		}

		[Property("SubmitUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SubmitUserId
		{
			get { return _submitUserId; }
			set
			{
				if ((_submitUserId == null) || (value == null) || (!value.Equals(_submitUserId)))
				{
                    object oldValue = _submitUserId;
					_submitUserId = value;
					RaisePropertyChanged(A_TaskWBS.Prop_SubmitUserId, oldValue, value);
				}
			}

		}

		[Property("SubmitUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 5)]
		public string SubmitUserName
		{
			get { return _submitUserName; }
			set
			{
				if ((_submitUserName == null) || (value == null) || (!value.Equals(_submitUserName)))
				{
                    object oldValue = _submitUserName;
					_submitUserName = value;
					RaisePropertyChanged(A_TaskWBS.Prop_SubmitUserName, oldValue, value);
				}
			}

		}

		[Property("SubmitDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? SubmitDate
		{
			get { return _submitDate; }
			set
			{
				if (value != _submitDate)
				{
                    object oldValue = _submitDate;
					_submitDate = value;
					RaisePropertyChanged(A_TaskWBS.Prop_SubmitDate, oldValue, value);
				}
			}

		}

		[Property("DutyId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
		public string DutyId
		{
			get { return _dutyId; }
			set
			{
				if ((_dutyId == null) || (value == null) || (!value.Equals(_dutyId)))
				{
                    object oldValue = _dutyId;
					_dutyId = value;
					RaisePropertyChanged(A_TaskWBS.Prop_DutyId, oldValue, value);
				}
			}

		}

		[Property("DutyName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DutyName
		{
			get { return _dutyName; }
			set
			{
				if ((_dutyName == null) || (value == null) || (!value.Equals(_dutyName)))
				{
                    object oldValue = _dutyName;
					_dutyName = value;
					RaisePropertyChanged(A_TaskWBS.Prop_DutyName, oldValue, value);
				}
			}

		}


        [Property("UserIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 3700)]
        public string UserIds
        {
            get { return _userIds; }
            set
            {
                if ((_userIds == null) || (value == null) || (!value.Equals(_userIds)))
                {
                    object oldValue = _userIds;
                    _userIds = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_UserIds, oldValue, value);
                }
            }

        }

        [Property("UserNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
        public string UserNames
        {
            get { return _userNames; }
            set
            {
                if ((_userNames == null) || (value == null) || (!value.Equals(_userNames)))
                {
                    object oldValue = _userNames;
                    _userNames = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_UserNames, oldValue, value);
                }
            }

        }

        [Property("LeaderId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 370)]
        public string LeaderId
        {
            get { return _leaderId; }
            set
            {
                if ((_leaderId == null) || (value == null) || (!value.Equals(_leaderId)))
                {
                    object oldValue = _leaderId;
                    _leaderId = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_LeaderId, oldValue, value);
                }
            }

        }

        [Property("LeaderName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string LeaderName
        {
            get { return _leaderName; }
            set
            {
                if ((_leaderName == null) || (value == null) || (!value.Equals(_leaderName)))
                {
                    object oldValue = _leaderName;
                    _leaderName = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_LeaderName, oldValue, value);
                }
            }

        }

        [Property("SecondDeptIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1110)]
        public string SecondDeptIds
        {
            get { return _secondDeptIds; }
            set
            {
                if ((_secondDeptIds == null) || (value == null) || (!value.Equals(_secondDeptIds)))
                {
                    object oldValue = _secondDeptIds;
                    _secondDeptIds = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_SecondDeptIds, oldValue, value);
                }
            }

        }

        [Property("SecondDeptNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
        public string SecondDeptNames
        {
            get { return _secondDeptNames; }
            set
            {
                if ((_secondDeptNames == null) || (value == null) || (!value.Equals(_secondDeptNames)))
                {
                    object oldValue = _secondDeptNames;
                    _secondDeptNames = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_SecondDeptNames, oldValue, value);
                }
            }

        }

        [Property("DeptCharge", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string DeptCharge
        {
            get { return _deptCharge; }
            set
            {
                if ((_deptCharge == null) || (value == null) || (!value.Equals(_deptCharge)))
                {
                    object oldValue = _deptCharge;
                    _deptCharge = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_DeptCharge, oldValue, value);
                }
            }

        }

        [Property("AimDeptCharge", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string AimDeptCharge
        {
            get { return _aimDeptCharge; }
            set
            {
                if ((_aimDeptCharge == null) || (value == null) || (!value.Equals(_aimDeptCharge)))
                {
                    object oldValue = _aimDeptCharge;
                    _aimDeptCharge = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_AimDeptCharge, oldValue, value);
                }
            }

        }

		[Property("ReceiveDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ReceiveDate
		{
			get { return _receiveDate; }
			set
			{
				if (value != _receiveDate)
				{
                    object oldValue = _receiveDate;
					_receiveDate = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ReceiveDate, oldValue, value);
				}
			}

		}

		[Property("ImportantRemark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ImportantRemark
		{
			get { return _importantRemark; }
			set
			{
				if ((_importantRemark == null) || (value == null) || (!value.Equals(_importantRemark)))
				{
                    object oldValue = _importantRemark;
					_importantRemark = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ImportantRemark, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("Attachment", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string Attachment
		{
			get { return _attachment; }
			set
			{
				if ((_attachment == null) || (value == null) || (!value.Equals(_attachment)))
				{
                    object oldValue = _attachment;
					_attachment = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Attachment, oldValue, value);
				}
			}

		}

		[Property("FactWorkHours", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public float? FactWorkHours
		{
			get { return _factWorkHours; }
			set
			{
				if (value != _factWorkHours)
				{
                    object oldValue = _factWorkHours;
					_factWorkHours = value;
					RaisePropertyChanged(A_TaskWBS.Prop_FactWorkHours, oldValue, value);
				}
			}

		}

		[Property("FactStartDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? FactStartDate
		{
			get { return _factStartDate; }
			set
			{
				if (value != _factStartDate)
				{
                    object oldValue = _factStartDate;
					_factStartDate = value;
					RaisePropertyChanged(A_TaskWBS.Prop_FactStartDate, oldValue, value);
				}
			}

		}

		[Property("FactEndDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? FactEndDate
		{
			get { return _factEndDate; }
			set
			{
				if (value != _factEndDate)
				{
                    object oldValue = _factEndDate;
					_factEndDate = value;
					RaisePropertyChanged(A_TaskWBS.Prop_FactEndDate, oldValue, value);
				}
			}

        }

        [Property("PlanStartDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? PlanStartDate
        {
            get { return _planStartDate; }
            set
            {
                if (value != _planStartDate)
                {
                    object oldValue = _planStartDate;
                    _planStartDate = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_PlanStartDate, oldValue, value);
                }
            }

        }

        [Property("PlanEndDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? PlanEndDate
        {
            get { return _planEndDate; }
            set
            {
                if (value != _planEndDate)
                {
                    object oldValue = _planEndDate;
                    _planEndDate = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_PlanEndDate, oldValue, value);
                }
            }

        }


		[Property("TaskProgress", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public float? TaskProgress
		{
			get { return _taskProgress; }
			set
			{
				if (value != _taskProgress)
				{
                    object oldValue = _taskProgress;
					_taskProgress = value;
					RaisePropertyChanged(A_TaskWBS.Prop_TaskProgress, oldValue, value);
				}
			}

		}

		[Property("Suggestion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
		public string Suggestion
		{
			get { return _suggestion; }
			set
			{
				if ((_suggestion == null) || (value == null) || (!value.Equals(_suggestion)))
				{
                    object oldValue = _suggestion;
					_suggestion = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Suggestion, oldValue, value);
				}
			}

		}

		[Property("RejectReason", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string RejectReason
		{
			get { return _rejectReason; }
			set
			{
				if ((_rejectReason == null) || (value == null) || (!value.Equals(_rejectReason)))
				{
                    object oldValue = _rejectReason;
					_rejectReason = value;
					RaisePropertyChanged(A_TaskWBS.Prop_RejectReason, oldValue, value);
				}
			}

		}

		[Property("ExecuteRemark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
		public string ExecuteRemark
		{
			get { return _executeRemark; }
			set
			{
				if ((_executeRemark == null) || (value == null) || (!value.Equals(_executeRemark)))
				{
                    object oldValue = _executeRemark;
					_executeRemark = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ExecuteRemark, oldValue, value);
				}
			}

		}

		[Property("AttachmentChild", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
		public string AttachmentChild
		{
			get { return _attachmentChild; }
			set
			{
				if ((_attachmentChild == null) || (value == null) || (!value.Equals(_attachmentChild)))
				{
                    object oldValue = _attachmentChild;
					_attachmentChild = value;
					RaisePropertyChanged(A_TaskWBS.Prop_AttachmentChild, oldValue, value);
				}
			}

		}

		[Property("ExamStandard", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string ExamStandard
		{
			get { return _examStandard; }
			set
			{
				if ((_examStandard == null) || (value == null) || (!value.Equals(_examStandard)))
				{
                    object oldValue = _examStandard;
					_examStandard = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ExamStandard, oldValue, value);
				}
			}

		}

		[Property("Ext1", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string Ext1
		{
			get { return _ext1; }
			set
			{
				if ((_ext1 == null) || (value == null) || (!value.Equals(_ext1)))
				{
                    object oldValue = _ext1;
					_ext1 = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Ext1, oldValue, value);
				}
			}

		}

		[Property("Ext2", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Ext2
		{
			get { return _ext2; }
			set
			{
				if ((_ext2 == null) || (value == null) || (!value.Equals(_ext2)))
				{
                    object oldValue = _ext2;
					_ext2 = value;
					RaisePropertyChanged(A_TaskWBS.Prop_Ext2, oldValue, value);
				}
			}

		}

		[Property("ExtTime1", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ExtTime1
		{
			get { return _extTime1; }
			set
			{
				if (value != _extTime1)
				{
                    object oldValue = _extTime1;
					_extTime1 = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ExtTime1, oldValue, value);
				}
			}

		}

		[Property("ExtTime2", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ExtTime2
		{
			get { return _extTime2; }
			set
			{
				if (value != _extTime2)
				{
                    object oldValue = _extTime2;
					_extTime2 = value;
					RaisePropertyChanged(A_TaskWBS.Prop_ExtTime2, oldValue, value);
				}
			}

        }
        [Property("Ext3", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Ext3
        {
            get { return _ext3; }
            set
            {
                if ((_ext3 == null) || (value == null) || (!value.Equals(_ext3)))
                {
                    object oldValue = _ext3;
                    _ext3 = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_Ext3, oldValue, value);
                }
            }

        }

        [Property("Ext4", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Ext4
        {
            get { return _ext4; }
            set
            {
                if ((_ext4 == null) || (value == null) || (!value.Equals(_ext4)))
                {
                    object oldValue = _ext4;
                    _ext4 = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_Ext4, oldValue, value);
                }
            }

        }

        [Property("Year", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Year
        {
            get { return _year; }
            set
            {
                if ((_year == null) || (value == null) || (!value.Equals(_year)))
                {
                    object oldValue = _year;
                    _year = value;
                    RaisePropertyChanged(A_TaskWBS.Prop_Year, oldValue, value);
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
                    RaisePropertyChanged(A_TaskWBS.Prop_CreateId, oldValue, value);
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
                    RaisePropertyChanged(A_TaskWBS.Prop_CreateName, oldValue, value);
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
                    RaisePropertyChanged(A_TaskWBS.Prop_CreateTime, oldValue, value);
                }
            }

        }

		#endregion
	} // A_TaskWBS
}

