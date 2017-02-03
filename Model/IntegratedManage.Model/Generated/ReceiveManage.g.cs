// Business class ReceiveManage generated from ReceiveManage
// Creator: Ray
// Created Date: [2013-03-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace IntegratedManage.Model
{
    [ActiveRecord("ReceiveManage")]
    public partial class ReceiveManage : IMModelBase<ReceiveManage>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_CustomerName = "CustomerName";
        public static string Prop_ComInTime = "ComInTime";
        public static string Prop_LeaveoutTime = "LeaveoutTime";
        public static string Prop_ReceptionistId = "ReceptionistId";
        public static string Prop_Receptionist = "Receptionist";
        public static string Prop_DeptId = "DeptId";
        public static string Prop_DeptName = "DeptName";
        public static string Prop_ReceiveThing = "ReceiveThing";
        public static string Prop_FeedBackResult = "FeedBackResult";
        public static string Prop_Counter = "Counter";
        public static string Prop_Remark = "Remark";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_LastModifyTime = "LastModifyTime";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_CreateTime = "CreateTime";

        #endregion

        #region Private_Variables

        private string _id;
        private string _customerName;
        private DateTime? _comInTime;
        private DateTime? _leaveoutTime;
        private string _receptionistId;
        private string _receptionist;
        private string _deptId;
        private string _deptName;
        private string _receiveThing;
        private string _feedBackResult;
        private int? _counter;
        private string _remark;
        private string _createId;
        private DateTime _lastModifyTime;
        private string _createName;
        private DateTime? _createTime;


        #endregion

        #region Constructors

        public ReceiveManage()
        {
        }

        public ReceiveManage(
            string p_id,
            string p_customerName,
            DateTime? p_comInTime,
            DateTime? p_leaveoutTime,
            string p_receptionistId,
            string p_receptionist,
            string p_deptId,
            string p_deptName,
            string p_receiveThing,
            string p_feedBackResult,
            int? p_counter,
            string p_remark,
            string p_createId,
            DateTime p_lastModifyTime,
            string p_createName,
            DateTime? p_createTime)
        {
            _id = p_id;
            _customerName = p_customerName;
            _comInTime = p_comInTime;
            _leaveoutTime = p_leaveoutTime;
            _receptionistId = p_receptionistId;
            _receptionist = p_receptionist;
            _deptId = p_deptId;
            _deptName = p_deptName;
            _receiveThing = p_receiveThing;
            _feedBackResult = p_feedBackResult;
            _counter = p_counter;
            _remark = p_remark;
            _createId = p_createId;
            _lastModifyTime = p_lastModifyTime;
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

        [Property("CustomerName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
        public string CustomerName
        {
            get { return _customerName; }
            set
            {
                if ((_customerName == null) || (value == null) || (!value.Equals(_customerName)))
                {
                    object oldValue = _customerName;
                    _customerName = value;
                    RaisePropertyChanged(ReceiveManage.Prop_CustomerName, oldValue, value);
                }
            }

        }

        [Property("ComInTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? ComInTime
        {
            get { return _comInTime; }
            set
            {
                if (value != _comInTime)
                {
                    object oldValue = _comInTime;
                    _comInTime = value;
                    RaisePropertyChanged(ReceiveManage.Prop_ComInTime, oldValue, value);
                }
            }

        }

        [Property("LeaveoutTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? LeaveoutTime
        {
            get { return _leaveoutTime; }
            set
            {
                if (value != _leaveoutTime)
                {
                    object oldValue = _leaveoutTime;
                    _leaveoutTime = value;
                    RaisePropertyChanged(ReceiveManage.Prop_LeaveoutTime, oldValue, value);
                }
            }

        }

        [Property("ReceptionistId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string ReceptionistId
        {
            get { return _receptionistId; }
            set
            {
                if ((_receptionistId == null) || (value == null) || (!value.Equals(_receptionistId)))
                {
                    object oldValue = _receptionistId;
                    _receptionistId = value;
                    RaisePropertyChanged(ReceiveManage.Prop_ReceptionistId, oldValue, value);
                }
            }

        }

        [Property("Receptionist", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
        public string Receptionist
        {
            get { return _receptionist; }
            set
            {
                if ((_receptionist == null) || (value == null) || (!value.Equals(_receptionist)))
                {
                    object oldValue = _receptionist;
                    _receptionist = value;
                    RaisePropertyChanged(ReceiveManage.Prop_Receptionist, oldValue, value);
                }
            }

        }

        [Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string DeptId
        {
            get { return _deptId; }
            set
            {
                if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
                {
                    object oldValue = _deptId;
                    _deptId = value;
                    RaisePropertyChanged(ReceiveManage.Prop_DeptId, oldValue, value);
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
                    RaisePropertyChanged(ReceiveManage.Prop_DeptName, oldValue, value);
                }
            }

        }

        [Property("ReceiveThing", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
        public string ReceiveThing
        {
            get { return _receiveThing; }
            set
            {
                if ((_receiveThing == null) || (value == null) || (!value.Equals(_receiveThing)))
                {
                    object oldValue = _receiveThing;
                    _receiveThing = value;
                    RaisePropertyChanged(ReceiveManage.Prop_ReceiveThing, oldValue, value);
                }
            }

        }

        [Property("FeedBackResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
        public string FeedBackResult
        {
            get { return _feedBackResult; }
            set
            {
                if ((_feedBackResult == null) || (value == null) || (!value.Equals(_feedBackResult)))
                {
                    object oldValue = _feedBackResult;
                    _feedBackResult = value;
                    RaisePropertyChanged(ReceiveManage.Prop_FeedBackResult, oldValue, value);
                }
            }

        }

        [Property("Counter", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? Counter
        {
            get { return _counter; }
            set
            {
                if (value != _counter)
                {
                    object oldValue = _counter;
                    _counter = value;
                    RaisePropertyChanged(ReceiveManage.Prop_Counter, oldValue, value);
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
                    RaisePropertyChanged(ReceiveManage.Prop_Remark, oldValue, value);
                }
            }

        }

        [Property("CreateId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string CreateId
        {
            get { return _createId; }
            set
            {
                if ((_createId == null) || (value == null) || (!value.Equals(_createId)))
                {
                    object oldValue = _createId;
                    _createId = value;
                    RaisePropertyChanged(ReceiveManage.Prop_CreateId, oldValue, value);
                }
            }

        }

        [Property("LastModifyTime", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
        public DateTime LastModifyTime
        {
            get { return _lastModifyTime; }
            set
            {
                if (value != _lastModifyTime)
                {
                    object oldValue = _lastModifyTime;
                    _lastModifyTime = value;
                    RaisePropertyChanged(ReceiveManage.Prop_LastModifyTime, oldValue, value);
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
                    RaisePropertyChanged(ReceiveManage.Prop_CreateName, oldValue, value);
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
                    RaisePropertyChanged(ReceiveManage.Prop_CreateTime, oldValue, value);
                }
            }

        }

        #endregion
    } // ReceiveManage
}

