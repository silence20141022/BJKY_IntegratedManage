using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.Serialization;
using NHibernate;
using NHibernate.Criterion;
using NHibernate.Transform;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Castle.ActiveRecord.Queries;
using Aim.Data;

namespace Aim.WorkFlow
{
    [ActiveRecord("V_Task")]
    public partial class V_Task : EntityBase<V_Task>
    {
        #region Property_Names

        public static string Prop_ID = "ID";
        public static string Prop_Title = "Title";
        public static string Prop_Description = "Description";
        public static string Prop_OwnerId = "OwnerId";
        public static string Prop_Owner = "Owner";
        public static string Prop_Action = "Action";
        public static string Prop_WorkflowInstanceID = "WorkflowInstanceID";
        public static string Prop_WorkFlowName = "WorkFlowName";
        public static string Prop_EFormName = "EFormName";
        public static string Prop_ApprovalNodeName = "ApprovalNodeName";
        public static string Prop_GroupID = "GroupID";
        public static string Prop_ApprovalNodeMatchConditionType = "ApprovalNodeMatchConditionType";
        public static string Prop_BookmarkName = "BookmarkName";
        public static string Prop_CreatedTime = "CreatedTime";
        public static string Prop_UpdatedTime = "UpdatedTime";
        public static string Prop_FinishTime = "FinishTime";
        public static string Prop_Status = "Status";
        public static string Prop_Context = "Context";
        public static string Prop_Result = "Result";
        public static string Prop_FlowStatus = "FlowStatus";
        public static string Prop_DeptId = "DeptId";
        public static string Prop_DeptName = "DeptName";
        #endregion

        #region Private_Variables

        private string _id;
        private string _title;
        private string _description;
        private string _ownerId;
        private string _owner;
        private string _action;
        private string _workflowInstanceID;
        private string _workFlowName;
        private string _eFormName;
        private string _approvalNodeName;
        private string _groupID;
        private int? _approvalNodeMatchConditionType;
        private string _bookmarkName;
        private DateTime? _createdTime;
        private DateTime? _updatedTime;
        private DateTime? _finishTime;
        private int _status;
        private string _context;
        private string _result;
        private string _flowStatus;
        private string _deptId;
        private string _deptName;
        #endregion

        #region Constructors

        public V_Task()
        {
        }

        public V_Task(
            string p_iD,
            string p_title,
            string p_description,
            string p_ownerId,
            string p_owner,
            string p_action,
            string p_workflowInstanceID,
            string p_workFlowName,
            string p_eFormName,
            string p_approvalNodeName,
            string p_groupID,
            int? p_approvalNodeMatchConditionType,
            string p_bookmarkName,
            DateTime? p_createdTime,
            DateTime? p_updatedTime,
            DateTime? p_finishTime,
            int p_status,
            string p_context,
            string p_result,
            string p_flowStatus,
            string p_deptId,
            string p_deptName)
        {
            _id = p_iD;
            _title = p_title;
            _description = p_description;
            _ownerId = p_ownerId;
            _owner = p_owner;
            _action = p_action;
            _workflowInstanceID = p_workflowInstanceID;
            _workFlowName = p_workFlowName;
            _eFormName = p_eFormName;
            _approvalNodeName = p_approvalNodeName;
            _groupID = p_groupID;
            _approvalNodeMatchConditionType = p_approvalNodeMatchConditionType;
            _bookmarkName = p_bookmarkName;
            _createdTime = p_createdTime;
            _updatedTime = p_updatedTime;
            _finishTime = p_finishTime;
            _status = p_status;
            _context = p_context;
            _result = p_result;
            _flowStatus = p_flowStatus;
            _deptId = p_deptId;
            _deptName = p_deptName;
        }

        #endregion

        #region Properties

        [PrimaryKey("ID", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string ID
        {
            get { return _id; }

        }

        [Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 50)]
        public string Title
        {
            get { return _title; }
            set
            {
                if ((_title == null) || (value == null) || (!value.Equals(_title)))
                {
                    object oldValue = _title;
                    _title = value;
                    RaisePropertyChanged(V_Task.Prop_Title, oldValue, value);
                }
            }

        }

        [Property("Description", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string Description
        {
            get { return _description; }
            set
            {
                if ((_description == null) || (value == null) || (!value.Equals(_description)))
                {
                    object oldValue = _description;
                    _description = value;
                    RaisePropertyChanged(V_Task.Prop_Description, oldValue, value);
                }
            }

        }

        [Property("OwnerId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string OwnerId
        {
            get { return _ownerId; }
            set
            {
                if ((_ownerId == null) || (value == null) || (!value.Equals(_ownerId)))
                {
                    object oldValue = _ownerId;
                    _ownerId = value;
                    RaisePropertyChanged(V_Task.Prop_OwnerId, oldValue, value);
                }
            }

        }

        [Property("Owner", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 50)]
        public string Owner
        {
            get { return _owner; }
            set
            {
                if ((_owner == null) || (value == null) || (!value.Equals(_owner)))
                {
                    object oldValue = _owner;
                    _owner = value;
                    RaisePropertyChanged(V_Task.Prop_Owner, oldValue, value);
                }
            }

        }

        [Property("Action", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 50)]
        public string Action
        {
            get { return _action; }
            set
            {
                if ((_action == null) || (value == null) || (!value.Equals(_action)))
                {
                    object oldValue = _action;
                    _action = value;
                    RaisePropertyChanged(V_Task.Prop_Action, oldValue, value);
                }
            }

        }

        [Property("WorkflowInstanceID", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 36)]
        public string WorkflowInstanceID
        {
            get { return _workflowInstanceID; }
            set
            {
                if ((_workflowInstanceID == null) || (value == null) || (!value.Equals(_workflowInstanceID)))
                {
                    object oldValue = _workflowInstanceID;
                    _workflowInstanceID = value;
                    RaisePropertyChanged(V_Task.Prop_WorkflowInstanceID, oldValue, value);
                }
            }

        }

        [Property("WorkFlowName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string WorkFlowName
        {
            get { return _workFlowName; }
            set
            {
                if ((_workFlowName == null) || (value == null) || (!value.Equals(_workFlowName)))
                {
                    object oldValue = _workFlowName;
                    _workFlowName = value;
                    RaisePropertyChanged(V_Task.Prop_WorkFlowName, oldValue, value);
                }
            }

        }

        [Property("EFormName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string EFormName
        {
            get { return _eFormName; }
            set
            {
                if ((_eFormName == null) || (value == null) || (!value.Equals(_eFormName)))
                {
                    object oldValue = _eFormName;
                    _eFormName = value;
                    RaisePropertyChanged(V_Task.Prop_EFormName, oldValue, value);
                }
            }

        }

        [Property("ApprovalNodeName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 100)]
        public string ApprovalNodeName
        {
            get { return _approvalNodeName; }
            set
            {
                if ((_approvalNodeName == null) || (value == null) || (!value.Equals(_approvalNodeName)))
                {
                    object oldValue = _approvalNodeName;
                    _approvalNodeName = value;
                    RaisePropertyChanged(V_Task.Prop_ApprovalNodeName, oldValue, value);
                }
            }

        }

        [Property("GroupID", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 36)]
        public string GroupID
        {
            get { return _groupID; }
            set
            {
                if ((_groupID == null) || (value == null) || (!value.Equals(_groupID)))
                {
                    object oldValue = _groupID;
                    _groupID = value;
                    RaisePropertyChanged(V_Task.Prop_GroupID, oldValue, value);
                }
            }

        }

        [Property("ApprovalNodeMatchConditionType", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? ApprovalNodeMatchConditionType
        {
            get { return _approvalNodeMatchConditionType; }
            set
            {
                if (value != _approvalNodeMatchConditionType)
                {
                    object oldValue = _approvalNodeMatchConditionType;
                    _approvalNodeMatchConditionType = value;
                    RaisePropertyChanged(V_Task.Prop_ApprovalNodeMatchConditionType, oldValue, value);
                }
            }

        }

        [Property("BookmarkName", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 50)]
        public string BookmarkName
        {
            get { return _bookmarkName; }
            set
            {
                if ((_bookmarkName == null) || (value == null) || (!value.Equals(_bookmarkName)))
                {
                    object oldValue = _bookmarkName;
                    _bookmarkName = value;
                    RaisePropertyChanged(V_Task.Prop_BookmarkName, oldValue, value);
                }
            }

        }

        [Property("CreatedTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? CreatedTime
        {
            get { return _createdTime; }
            set
            {
                if (value != _createdTime)
                {
                    object oldValue = _createdTime;
                    _createdTime = value;
                    RaisePropertyChanged(V_Task.Prop_CreatedTime, oldValue, value);
                }
            }

        }

        [Property("UpdatedTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? UpdatedTime
        {
            get { return _updatedTime; }
            set
            {
                if (value != _updatedTime)
                {
                    object oldValue = _updatedTime;
                    _updatedTime = value;
                    RaisePropertyChanged(V_Task.Prop_UpdatedTime, oldValue, value);
                }
            }

        }

        [Property("FinishTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? FinishTime
        {
            get { return _finishTime; }
            set
            {
                if (value != _finishTime)
                {
                    object oldValue = _finishTime;
                    _finishTime = value;
                    RaisePropertyChanged(V_Task.Prop_FinishTime, oldValue, value);
                }
            }

        }

        [Property("Status", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
        public int Status
        {
            get { return _status; }
            set
            {
                if (value != _status)
                {
                    object oldValue = _status;
                    _status = value;
                    RaisePropertyChanged(V_Task.Prop_Status, oldValue, value);
                }
            }

        }

        [Property("Context", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
        public string Context
        {
            get { return _context; }
            set
            {
                if ((_context == null) || (value == null) || (!value.Equals(_context)))
                {
                    object oldValue = _context;
                    _context = value;
                    RaisePropertyChanged(V_Task.Prop_Context, oldValue, value);
                }
            }

        }

        [Property("Result", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
        public string Result
        {
            get { return _result; }
            set
            {
                if ((_result == null) || (value == null) || (!value.Equals(_result)))
                {
                    object oldValue = _result;
                    _result = value;
                    RaisePropertyChanged(V_Task.Prop_Result, oldValue, value);
                }
            }

        }

        [Property("FlowStatus", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string FlowStatus
        {
            get { return _flowStatus; }
            set
            {
                if ((_flowStatus == null) || (value == null) || (!value.Equals(_flowStatus)))
                {
                    object oldValue = _flowStatus;
                    _flowStatus = value;
                    RaisePropertyChanged(V_Task.Prop_FlowStatus, oldValue, value);
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
                    RaisePropertyChanged(V_Task.Prop_DeptId, oldValue, value);
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
                    RaisePropertyChanged(V_Task.Prop_DeptName, oldValue, value);
                }
            }

        }
        #endregion
    } // V_Task
}

