// Business class ReceiveDocument generated from ReceiveDocument
// Creator: Ray
// Created Date: [2013-03-26]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("ReceiveDocument")]
	public partial class ReceiveDocument : IMModelBase<ReceiveDocument>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_FileName = "FileName";
		public static string Prop_BringUnitId = "BringUnitId";
		public static string Prop_BringUnitName = "BringUnitName";
		public static string Prop_Pages = "Pages";
		public static string Prop_ReceiveType = "ReceiveType";
		public static string Prop_ComeWord = "ComeWord";
		public static string Prop_ComeWordSize = "ComeWordSize";
		public static string Prop_ReceiveWord = "ReceiveWord";
		public static string Prop_ReceiveWordSize = "ReceiveWordSize";
		public static string Prop_SecrecyDegree = "SecrecyDegree";
		public static string Prop_ImportanceDegree = "ImportanceDegree";
		public static string Prop_ReceiveDate = "ReceiveDate";
		public static string Prop_ApprovalNodeName = "ApprovalNodeName";
		public static string Prop_YuanZhangId = "YuanZhangId";
		public static string Prop_YuanZhangName = "YuanZhangName";
		public static string Prop_ReceiveReason = "ReceiveReason";
		public static string Prop_MainFile = "MainFile";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_NiBanOpinion = "NiBanOpinion";
		public static string Prop_ApproveResult = "ApproveResult";
		public static string Prop_WorkFlowState = "WorkFlowState";
		public static string Prop_State = "State";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _fileName;
		private string _bringUnitId;
		private string _bringUnitName;
		private int? _pages;
		private string _receiveType;
		private string _comeWord;
		private string _comeWordSize;
		private string _receiveWord;
		private string _receiveWordSize;
		private string _secrecyDegree;
		private string _importanceDegree;
		private DateTime? _receiveDate;
		private string _approvalNodeName;
		private string _yuanZhangId;
		private string _yuanZhangName;
		private string _receiveReason;
		private string _mainFile;
		private string _attachment;
		private string _niBanOpinion;
		private string _approveResult;
		private string _workFlowState;
		private string _state;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public ReceiveDocument()
		{
		}

		public ReceiveDocument(
			string p_id,
			string p_fileName,
			string p_bringUnitId,
			string p_bringUnitName,
			int? p_pages,
			string p_receiveType,
			string p_comeWord,
			string p_comeWordSize,
			string p_receiveWord,
			string p_receiveWordSize,
			string p_secrecyDegree,
			string p_importanceDegree,
			DateTime? p_receiveDate,
			string p_approvalNodeName,
			string p_yuanZhangId,
			string p_yuanZhangName,
			string p_receiveReason,
			string p_mainFile,
			string p_attachment,
			string p_niBanOpinion,
			string p_approveResult,
			string p_workFlowState,
			string p_state,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_fileName = p_fileName;
			_bringUnitId = p_bringUnitId;
			_bringUnitName = p_bringUnitName;
			_pages = p_pages;
			_receiveType = p_receiveType;
			_comeWord = p_comeWord;
			_comeWordSize = p_comeWordSize;
			_receiveWord = p_receiveWord;
			_receiveWordSize = p_receiveWordSize;
			_secrecyDegree = p_secrecyDegree;
			_importanceDegree = p_importanceDegree;
			_receiveDate = p_receiveDate;
			_approvalNodeName = p_approvalNodeName;
			_yuanZhangId = p_yuanZhangId;
			_yuanZhangName = p_yuanZhangName;
			_receiveReason = p_receiveReason;
			_mainFile = p_mainFile;
			_attachment = p_attachment;
			_niBanOpinion = p_niBanOpinion;
			_approveResult = p_approveResult;
			_workFlowState = p_workFlowState;
			_state = p_state;
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

		[Property("FileName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string FileName
		{
			get { return _fileName; }
			set
			{
				if ((_fileName == null) || (value == null) || (!value.Equals(_fileName)))
				{
                    object oldValue = _fileName;
					_fileName = value;
					RaisePropertyChanged(ReceiveDocument.Prop_FileName, oldValue, value);
				}
			}

		}

		[Property("BringUnitId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string BringUnitId
		{
			get { return _bringUnitId; }
			set
			{
				if ((_bringUnitId == null) || (value == null) || (!value.Equals(_bringUnitId)))
				{
                    object oldValue = _bringUnitId;
					_bringUnitId = value;
					RaisePropertyChanged(ReceiveDocument.Prop_BringUnitId, oldValue, value);
				}
			}

		}

		[Property("BringUnitName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string BringUnitName
		{
			get { return _bringUnitName; }
			set
			{
				if ((_bringUnitName == null) || (value == null) || (!value.Equals(_bringUnitName)))
				{
                    object oldValue = _bringUnitName;
					_bringUnitName = value;
					RaisePropertyChanged(ReceiveDocument.Prop_BringUnitName, oldValue, value);
				}
			}

		}

		[Property("Pages", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? Pages
		{
			get { return _pages; }
			set
			{
				if (value != _pages)
				{
                    object oldValue = _pages;
					_pages = value;
					RaisePropertyChanged(ReceiveDocument.Prop_Pages, oldValue, value);
				}
			}

		}

		[Property("ReceiveType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ReceiveType
		{
			get { return _receiveType; }
			set
			{
				if ((_receiveType == null) || (value == null) || (!value.Equals(_receiveType)))
				{
                    object oldValue = _receiveType;
					_receiveType = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ReceiveType, oldValue, value);
				}
			}

		}

		[Property("ComeWord", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ComeWord
		{
			get { return _comeWord; }
			set
			{
				if ((_comeWord == null) || (value == null) || (!value.Equals(_comeWord)))
				{
                    object oldValue = _comeWord;
					_comeWord = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ComeWord, oldValue, value);
				}
			}

		}

		[Property("ComeWordSize", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ComeWordSize
		{
			get { return _comeWordSize; }
			set
			{
				if ((_comeWordSize == null) || (value == null) || (!value.Equals(_comeWordSize)))
				{
                    object oldValue = _comeWordSize;
					_comeWordSize = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ComeWordSize, oldValue, value);
				}
			}

		}

		[Property("ReceiveWord", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ReceiveWord
		{
			get { return _receiveWord; }
			set
			{
				if ((_receiveWord == null) || (value == null) || (!value.Equals(_receiveWord)))
				{
                    object oldValue = _receiveWord;
					_receiveWord = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ReceiveWord, oldValue, value);
				}
			}

		}

		[Property("ReceiveWordSize", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ReceiveWordSize
		{
			get { return _receiveWordSize; }
			set
			{
				if ((_receiveWordSize == null) || (value == null) || (!value.Equals(_receiveWordSize)))
				{
                    object oldValue = _receiveWordSize;
					_receiveWordSize = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ReceiveWordSize, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_SecrecyDegree, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_ImportanceDegree, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_ReceiveDate, oldValue, value);
				}
			}

		}

		[Property("ApprovalNodeName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ApprovalNodeName
		{
			get { return _approvalNodeName; }
			set
			{
				if ((_approvalNodeName == null) || (value == null) || (!value.Equals(_approvalNodeName)))
				{
                    object oldValue = _approvalNodeName;
					_approvalNodeName = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ApprovalNodeName, oldValue, value);
				}
			}

		}

		[Property("YuanZhangId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string YuanZhangId
		{
			get { return _yuanZhangId; }
			set
			{
				if ((_yuanZhangId == null) || (value == null) || (!value.Equals(_yuanZhangId)))
				{
                    object oldValue = _yuanZhangId;
					_yuanZhangId = value;
					RaisePropertyChanged(ReceiveDocument.Prop_YuanZhangId, oldValue, value);
				}
			}

		}

		[Property("YuanZhangName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string YuanZhangName
		{
			get { return _yuanZhangName; }
			set
			{
				if ((_yuanZhangName == null) || (value == null) || (!value.Equals(_yuanZhangName)))
				{
                    object oldValue = _yuanZhangName;
					_yuanZhangName = value;
					RaisePropertyChanged(ReceiveDocument.Prop_YuanZhangName, oldValue, value);
				}
			}

		}

		[Property("ReceiveReason", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ReceiveReason
		{
			get { return _receiveReason; }
			set
			{
				if ((_receiveReason == null) || (value == null) || (!value.Equals(_receiveReason)))
				{
                    object oldValue = _receiveReason;
					_receiveReason = value;
					RaisePropertyChanged(ReceiveDocument.Prop_ReceiveReason, oldValue, value);
				}
			}

		}

		[Property("MainFile", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string MainFile
		{
			get { return _mainFile; }
			set
			{
				if ((_mainFile == null) || (value == null) || (!value.Equals(_mainFile)))
				{
                    object oldValue = _mainFile;
					_mainFile = value;
					RaisePropertyChanged(ReceiveDocument.Prop_MainFile, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_Attachment, oldValue, value);
				}
			}

		}

		[Property("NiBanOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string NiBanOpinion
		{
			get { return _niBanOpinion; }
			set
			{
				if ((_niBanOpinion == null) || (value == null) || (!value.Equals(_niBanOpinion)))
				{
                    object oldValue = _niBanOpinion;
					_niBanOpinion = value;
					RaisePropertyChanged(ReceiveDocument.Prop_NiBanOpinion, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_ApproveResult, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_WorkFlowState, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_State, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ReceiveDocument.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // ReceiveDocument
}

