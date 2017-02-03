// Business class SignRequest generated from SignRequest
// Creator: Ray
// Created Date: [2013-03-21]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("SignRequest")]
	public partial class SignRequest : IMModelBase<SignRequest>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SignReason = "SignReason";
		public static string Prop_ImportanceDegree = "ImportanceDegree";
		public static string Prop_ApproveLeaderIds = "ApproveLeaderIds";
		public static string Prop_ApproveLeaderNames = "ApproveLeaderNames";
		public static string Prop_YuanLeaderIds = "YuanLeaderIds";
		public static string Prop_YuanLeaderNames = "YuanLeaderNames";
		public static string Prop_SecrecyDegree = "SecrecyDegree";
		public static string Prop_ContactUserId = "ContactUserId";
		public static string Prop_ContactUserName = "ContactUserName";
		public static string Prop_Telephone = "Telephone";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_WorkFlowState = "WorkFlowState";
		public static string Prop_ApproveResult = "ApproveResult";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateDeptId = "CreateDeptId";
		public static string Prop_CreateDeptName = "CreateDeptName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _signReason;
		private string _importanceDegree;
		private string _approveLeaderIds;
		private string _approveLeaderNames;
		private string _yuanLeaderIds;
		private string _yuanLeaderNames;
		private string _secrecyDegree;
		private string _contactUserId;
		private string _contactUserName;
		private string _telephone;
		private string _attachment;
		private string _workFlowState;
		private string _approveResult;
		private string _createId;
		private string _createName;
		private string _createDeptId;
		private string _createDeptName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SignRequest()
		{
		}

		public SignRequest(
			string p_id,
			string p_signReason,
			string p_importanceDegree,
			string p_approveLeaderIds,
			string p_approveLeaderNames,
			string p_yuanLeaderIds,
			string p_yuanLeaderNames,
			string p_secrecyDegree,
			string p_contactUserId,
			string p_contactUserName,
			string p_telephone,
			string p_attachment,
			string p_workFlowState,
			string p_approveResult,
			string p_createId,
			string p_createName,
			string p_createDeptId,
			string p_createDeptName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_signReason = p_signReason;
			_importanceDegree = p_importanceDegree;
			_approveLeaderIds = p_approveLeaderIds;
			_approveLeaderNames = p_approveLeaderNames;
			_yuanLeaderIds = p_yuanLeaderIds;
			_yuanLeaderNames = p_yuanLeaderNames;
			_secrecyDegree = p_secrecyDegree;
			_contactUserId = p_contactUserId;
			_contactUserName = p_contactUserName;
			_telephone = p_telephone;
			_attachment = p_attachment;
			_workFlowState = p_workFlowState;
			_approveResult = p_approveResult;
			_createId = p_createId;
			_createName = p_createName;
			_createDeptId = p_createDeptId;
			_createDeptName = p_createDeptName;
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

		[Property("SignReason", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string SignReason
		{
			get { return _signReason; }
			set
			{
				if ((_signReason == null) || (value == null) || (!value.Equals(_signReason)))
				{
                    object oldValue = _signReason;
					_signReason = value;
					RaisePropertyChanged(SignRequest.Prop_SignReason, oldValue, value);
				}
			}

		}

		[Property("ImportanceDegree", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ImportanceDegree
		{
			get { return _importanceDegree; }
			set
			{
				if ((_importanceDegree == null) || (value == null) || (!value.Equals(_importanceDegree)))
				{
                    object oldValue = _importanceDegree;
					_importanceDegree = value;
					RaisePropertyChanged(SignRequest.Prop_ImportanceDegree, oldValue, value);
				}
			}

		}

		[Property("ApproveLeaderIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ApproveLeaderIds
		{
			get { return _approveLeaderIds; }
			set
			{
				if ((_approveLeaderIds == null) || (value == null) || (!value.Equals(_approveLeaderIds)))
				{
                    object oldValue = _approveLeaderIds;
					_approveLeaderIds = value;
					RaisePropertyChanged(SignRequest.Prop_ApproveLeaderIds, oldValue, value);
				}
			}

		}

		[Property("ApproveLeaderNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ApproveLeaderNames
		{
			get { return _approveLeaderNames; }
			set
			{
				if ((_approveLeaderNames == null) || (value == null) || (!value.Equals(_approveLeaderNames)))
				{
                    object oldValue = _approveLeaderNames;
					_approveLeaderNames = value;
					RaisePropertyChanged(SignRequest.Prop_ApproveLeaderNames, oldValue, value);
				}
			}

		}

		[Property("YuanLeaderIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string YuanLeaderIds
		{
			get { return _yuanLeaderIds; }
			set
			{
				if ((_yuanLeaderIds == null) || (value == null) || (!value.Equals(_yuanLeaderIds)))
				{
                    object oldValue = _yuanLeaderIds;
					_yuanLeaderIds = value;
					RaisePropertyChanged(SignRequest.Prop_YuanLeaderIds, oldValue, value);
				}
			}

		}

		[Property("YuanLeaderNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string YuanLeaderNames
		{
			get { return _yuanLeaderNames; }
			set
			{
				if ((_yuanLeaderNames == null) || (value == null) || (!value.Equals(_yuanLeaderNames)))
				{
                    object oldValue = _yuanLeaderNames;
					_yuanLeaderNames = value;
					RaisePropertyChanged(SignRequest.Prop_YuanLeaderNames, oldValue, value);
				}
			}

		}

		[Property("SecrecyDegree", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SecrecyDegree
		{
			get { return _secrecyDegree; }
			set
			{
				if ((_secrecyDegree == null) || (value == null) || (!value.Equals(_secrecyDegree)))
				{
                    object oldValue = _secrecyDegree;
					_secrecyDegree = value;
					RaisePropertyChanged(SignRequest.Prop_SecrecyDegree, oldValue, value);
				}
			}

		}

		[Property("ContactUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string ContactUserId
		{
			get { return _contactUserId; }
			set
			{
				if ((_contactUserId == null) || (value == null) || (!value.Equals(_contactUserId)))
				{
                    object oldValue = _contactUserId;
					_contactUserId = value;
					RaisePropertyChanged(SignRequest.Prop_ContactUserId, oldValue, value);
				}
			}

		}

		[Property("ContactUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ContactUserName
		{
			get { return _contactUserName; }
			set
			{
				if ((_contactUserName == null) || (value == null) || (!value.Equals(_contactUserName)))
				{
                    object oldValue = _contactUserName;
					_contactUserName = value;
					RaisePropertyChanged(SignRequest.Prop_ContactUserName, oldValue, value);
				}
			}

		}

		[Property("Telephone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Telephone
		{
			get { return _telephone; }
			set
			{
				if ((_telephone == null) || (value == null) || (!value.Equals(_telephone)))
				{
                    object oldValue = _telephone;
					_telephone = value;
					RaisePropertyChanged(SignRequest.Prop_Telephone, oldValue, value);
				}
			}

		}

		[Property("Attachment", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Attachment
		{
			get { return _attachment; }
			set
			{
				if ((_attachment == null) || (value == null) || (!value.Equals(_attachment)))
				{
                    object oldValue = _attachment;
					_attachment = value;
					RaisePropertyChanged(SignRequest.Prop_Attachment, oldValue, value);
				}
			}

		}

		[Property("WorkFlowState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string WorkFlowState
		{
			get { return _workFlowState; }
			set
			{
				if ((_workFlowState == null) || (value == null) || (!value.Equals(_workFlowState)))
				{
                    object oldValue = _workFlowState;
					_workFlowState = value;
					RaisePropertyChanged(SignRequest.Prop_WorkFlowState, oldValue, value);
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
					RaisePropertyChanged(SignRequest.Prop_ApproveResult, oldValue, value);
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
					RaisePropertyChanged(SignRequest.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SignRequest.Prop_CreateName, oldValue, value);
				}
			}

		}

		[Property("CreateDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string CreateDeptId
		{
			get { return _createDeptId; }
			set
			{
				if ((_createDeptId == null) || (value == null) || (!value.Equals(_createDeptId)))
				{
                    object oldValue = _createDeptId;
					_createDeptId = value;
					RaisePropertyChanged(SignRequest.Prop_CreateDeptId, oldValue, value);
				}
			}

		}

		[Property("CreateDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string CreateDeptName
		{
			get { return _createDeptName; }
			set
			{
				if ((_createDeptName == null) || (value == null) || (!value.Equals(_createDeptName)))
				{
                    object oldValue = _createDeptName;
					_createDeptName = value;
					RaisePropertyChanged(SignRequest.Prop_CreateDeptName, oldValue, value);
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
					RaisePropertyChanged(SignRequest.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SignRequest
}

