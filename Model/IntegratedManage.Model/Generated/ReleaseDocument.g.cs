// Business class ReleaseDocument generated from ReleaseDocument
// Creator: Ray
// Created Date: [2013-05-08]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("ReleaseDocument")]
	public partial class ReleaseDocument : IMModelBase<ReleaseDocument>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Title = "Title";
		public static string Prop_Theme = "Theme";
		public static string Prop_DocumentZiHao = "DocumentZiHao";
		public static string Prop_ApproveLeaderIds = "ApproveLeaderIds";
		public static string Prop_ApproveLeaderNames = "ApproveLeaderNames";
		public static string Prop_PrimaryReceiver = "PrimaryReceiver";
		public static string Prop_SecondaryReceiver = "SecondaryReceiver";
		public static string Prop_ReleaseContent = "ReleaseContent";
		public static string Prop_ApproveContent = "ApproveContent";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_WorkFlowState = "WorkFlowState";
		public static string Prop_ApproveResult = "ApproveResult";
		public static string Prop_State = "State";
		public static string Prop_CreateDeptId = "CreateDeptId";
		public static string Prop_CreateDeptName = "CreateDeptName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _title;
		private string _theme;
		private string _documentZiHao;
		private string _approveLeaderIds;
		private string _approveLeaderNames;
		private string _primaryReceiver;
		private string _secondaryReceiver;
		private string _releaseContent;
		private string _approveContent;
		private string _attachment;
		private string _workFlowState;
		private string _approveResult;
		private string _state;
		private string _createDeptId;
		private string _createDeptName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public ReleaseDocument()
		{
		}

		public ReleaseDocument(
			string p_id,
			string p_title,
			string p_theme,
			string p_documentZiHao,
			string p_approveLeaderIds,
			string p_approveLeaderNames,
			string p_primaryReceiver,
			string p_secondaryReceiver,
			string p_releaseContent,
			string p_approveContent,
			string p_attachment,
			string p_workFlowState,
			string p_approveResult,
			string p_state,
			string p_createDeptId,
			string p_createDeptName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_title = p_title;
			_theme = p_theme;
			_documentZiHao = p_documentZiHao;
			_approveLeaderIds = p_approveLeaderIds;
			_approveLeaderNames = p_approveLeaderNames;
			_primaryReceiver = p_primaryReceiver;
			_secondaryReceiver = p_secondaryReceiver;
			_releaseContent = p_releaseContent;
			_approveContent = p_approveContent;
			_attachment = p_attachment;
			_workFlowState = p_workFlowState;
			_approveResult = p_approveResult;
			_state = p_state;
			_createDeptId = p_createDeptId;
			_createDeptName = p_createDeptName;
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

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
					RaisePropertyChanged(ReleaseDocument.Prop_Title, oldValue, value);
				}
			}

		}

		[Property("Theme", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Theme
		{
			get { return _theme; }
			set
			{
				if ((_theme == null) || (value == null) || (!value.Equals(_theme)))
				{
                    object oldValue = _theme;
					_theme = value;
					RaisePropertyChanged(ReleaseDocument.Prop_Theme, oldValue, value);
				}
			}

		}

		[Property("DocumentZiHao", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DocumentZiHao
		{
			get { return _documentZiHao; }
			set
			{
				if ((_documentZiHao == null) || (value == null) || (!value.Equals(_documentZiHao)))
				{
                    object oldValue = _documentZiHao;
					_documentZiHao = value;
					RaisePropertyChanged(ReleaseDocument.Prop_DocumentZiHao, oldValue, value);
				}
			}

		}

		[Property("ApproveLeaderIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ApproveLeaderIds
		{
			get { return _approveLeaderIds; }
			set
			{
				if ((_approveLeaderIds == null) || (value == null) || (!value.Equals(_approveLeaderIds)))
				{
                    object oldValue = _approveLeaderIds;
					_approveLeaderIds = value;
					RaisePropertyChanged(ReleaseDocument.Prop_ApproveLeaderIds, oldValue, value);
				}
			}

		}

		[Property("ApproveLeaderNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ApproveLeaderNames
		{
			get { return _approveLeaderNames; }
			set
			{
				if ((_approveLeaderNames == null) || (value == null) || (!value.Equals(_approveLeaderNames)))
				{
                    object oldValue = _approveLeaderNames;
					_approveLeaderNames = value;
					RaisePropertyChanged(ReleaseDocument.Prop_ApproveLeaderNames, oldValue, value);
				}
			}

		}

		[Property("PrimaryReceiver", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string PrimaryReceiver
		{
			get { return _primaryReceiver; }
			set
			{
				if ((_primaryReceiver == null) || (value == null) || (!value.Equals(_primaryReceiver)))
				{
                    object oldValue = _primaryReceiver;
					_primaryReceiver = value;
					RaisePropertyChanged(ReleaseDocument.Prop_PrimaryReceiver, oldValue, value);
				}
			}

		}

		[Property("SecondaryReceiver", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string SecondaryReceiver
		{
			get { return _secondaryReceiver; }
			set
			{
				if ((_secondaryReceiver == null) || (value == null) || (!value.Equals(_secondaryReceiver)))
				{
                    object oldValue = _secondaryReceiver;
					_secondaryReceiver = value;
					RaisePropertyChanged(ReleaseDocument.Prop_SecondaryReceiver, oldValue, value);
				}
			}

		}

		[Property("ReleaseContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ReleaseContent
		{
			get { return _releaseContent; }
			set
			{
				if ((_releaseContent == null) || (value == null) || (!value.Equals(_releaseContent)))
				{
                    object oldValue = _releaseContent;
					_releaseContent = value;
					RaisePropertyChanged(ReleaseDocument.Prop_ReleaseContent, oldValue, value);
				}
			}

		}

		[Property("ApproveContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ApproveContent
		{
			get { return _approveContent; }
			set
			{
				if ((_approveContent == null) || (value == null) || (!value.Equals(_approveContent)))
				{
                    object oldValue = _approveContent;
					_approveContent = value;
					RaisePropertyChanged(ReleaseDocument.Prop_ApproveContent, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_Attachment, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_WorkFlowState, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_ApproveResult, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_State, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_CreateDeptId, oldValue, value);
				}
			}

		}

		[Property("CreateDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CreateDeptName
		{
			get { return _createDeptName; }
			set
			{
				if ((_createDeptName == null) || (value == null) || (!value.Equals(_createDeptName)))
				{
                    object oldValue = _createDeptName;
					_createDeptName = value;
					RaisePropertyChanged(ReleaseDocument.Prop_CreateDeptName, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ReleaseDocument.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // ReleaseDocument
}

