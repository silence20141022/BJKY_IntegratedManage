// Business class SysMessageReceive generated from SysMessageReceive
// Creator: Ray
// Created Date: [2013-03-26]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace Aim.Portal.Model
{
	[ActiveRecord("SysMessageReceive")]
    public partial class SysMessageReceive : EntityBase<SysMessageReceive>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_MsgId = "MsgId";
		public static string Prop_ReceiverId = "ReceiverId";
		public static string Prop_ReceiverName = "ReceiverName";
		public static string Prop_IsFirstView = "IsFirstView";
		public static string Prop_FirstViewTime = "FirstViewTime";
		public static string Prop_IsReply = "IsReply";
		public static string Prop_ReplyTime = "ReplyTime";
		public static string Prop_ReplyType = "ReplyType";
		public static string Prop_ReplyResult = "ReplyResult";
		public static string Prop_ReplyMsgId = "ReplyMsgId";
		public static string Prop_IsDelete = "IsDelete";
		public static string Prop_DeleteTime = "DeleteTime";
		public static string Prop_IsHot = "IsHot";

		#endregion

		#region Private_Variables

		private string _id;
		private string _msgId;
		private string _receiverId;
		private string _receiverName;
		private string _isFirstView;
		private DateTime? _firstViewTime;
		private string _isReply;
		private DateTime? _replyTime;
		private string _replyType;
		private string _replyResult;
		private string _replyMsgId;
		private string _isDelete;
		private DateTime? _deleteTime;
		private string _isHot;


		#endregion

		#region Constructors

		public SysMessageReceive()
		{
		}

		public SysMessageReceive(
			string p_id,
			string p_msgId,
			string p_receiverId,
			string p_receiverName,
			string p_isFirstView,
			DateTime? p_firstViewTime,
			string p_isReply,
			DateTime? p_replyTime,
			string p_replyType,
			string p_replyResult,
			string p_replyMsgId,
			string p_isDelete,
			DateTime? p_deleteTime,
			string p_isHot)
		{
			_id = p_id;
			_msgId = p_msgId;
			_receiverId = p_receiverId;
			_receiverName = p_receiverName;
			_isFirstView = p_isFirstView;
			_firstViewTime = p_firstViewTime;
			_isReply = p_isReply;
			_replyTime = p_replyTime;
			_replyType = p_replyType;
			_replyResult = p_replyResult;
			_replyMsgId = p_replyMsgId;
			_isDelete = p_isDelete;
			_deleteTime = p_deleteTime;
			_isHot = p_isHot;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("MsgId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string MsgId
		{
			get { return _msgId; }
			set
			{
				if ((_msgId == null) || (value == null) || (!value.Equals(_msgId)))
				{
                    object oldValue = _msgId;
					_msgId = value;
					RaisePropertyChanged(SysMessageReceive.Prop_MsgId, oldValue, value);
				}
			}

		}

		[Property("ReceiverId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ReceiverId
		{
			get { return _receiverId; }
			set
			{
				if ((_receiverId == null) || (value == null) || (!value.Equals(_receiverId)))
				{
                    object oldValue = _receiverId;
					_receiverId = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReceiverId, oldValue, value);
				}
			}

		}

		[Property("ReceiverName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string ReceiverName
		{
			get { return _receiverName; }
			set
			{
				if ((_receiverName == null) || (value == null) || (!value.Equals(_receiverName)))
				{
                    object oldValue = _receiverName;
					_receiverName = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReceiverName, oldValue, value);
				}
			}

		}

		[Property("IsFirstView", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string IsFirstView
		{
			get { return _isFirstView; }
			set
			{
				if ((_isFirstView == null) || (value == null) || (!value.Equals(_isFirstView)))
				{
                    object oldValue = _isFirstView;
					_isFirstView = value;
					RaisePropertyChanged(SysMessageReceive.Prop_IsFirstView, oldValue, value);
				}
			}

		}

		[Property("FirstViewTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? FirstViewTime
		{
			get { return _firstViewTime; }
			set
			{
				if (value != _firstViewTime)
				{
                    object oldValue = _firstViewTime;
					_firstViewTime = value;
					RaisePropertyChanged(SysMessageReceive.Prop_FirstViewTime, oldValue, value);
				}
			}

		}

		[Property("IsReply", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IsReply
		{
			get { return _isReply; }
			set
			{
				if ((_isReply == null) || (value == null) || (!value.Equals(_isReply)))
				{
                    object oldValue = _isReply;
					_isReply = value;
					RaisePropertyChanged(SysMessageReceive.Prop_IsReply, oldValue, value);
				}
			}

		}

		[Property("ReplyTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ReplyTime
		{
			get { return _replyTime; }
			set
			{
				if (value != _replyTime)
				{
                    object oldValue = _replyTime;
					_replyTime = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReplyTime, oldValue, value);
				}
			}

		}

		[Property("ReplyType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string ReplyType
		{
			get { return _replyType; }
			set
			{
				if ((_replyType == null) || (value == null) || (!value.Equals(_replyType)))
				{
                    object oldValue = _replyType;
					_replyType = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReplyType, oldValue, value);
				}
			}

		}

		[Property("ReplyResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ReplyResult
		{
			get { return _replyResult; }
			set
			{
				if ((_replyResult == null) || (value == null) || (!value.Equals(_replyResult)))
				{
                    object oldValue = _replyResult;
					_replyResult = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReplyResult, oldValue, value);
				}
			}

		}

		[Property("ReplyMsgId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ReplyMsgId
		{
			get { return _replyMsgId; }
			set
			{
				if ((_replyMsgId == null) || (value == null) || (!value.Equals(_replyMsgId)))
				{
                    object oldValue = _replyMsgId;
					_replyMsgId = value;
					RaisePropertyChanged(SysMessageReceive.Prop_ReplyMsgId, oldValue, value);
				}
			}

		}

		[Property("IsDelete", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IsDelete
		{
			get { return _isDelete; }
			set
			{
				if ((_isDelete == null) || (value == null) || (!value.Equals(_isDelete)))
				{
                    object oldValue = _isDelete;
					_isDelete = value;
					RaisePropertyChanged(SysMessageReceive.Prop_IsDelete, oldValue, value);
				}
			}

		}

		[Property("DeleteTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? DeleteTime
		{
			get { return _deleteTime; }
			set
			{
				if (value != _deleteTime)
				{
                    object oldValue = _deleteTime;
					_deleteTime = value;
					RaisePropertyChanged(SysMessageReceive.Prop_DeleteTime, oldValue, value);
				}
			}

		}

		[Property("IsHot", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IsHot
		{
			get { return _isHot; }
			set
			{
				if ((_isHot == null) || (value == null) || (!value.Equals(_isHot)))
				{
                    object oldValue = _isHot;
					_isHot = value;
					RaisePropertyChanged(SysMessageReceive.Prop_IsHot, oldValue, value);
				}
			}

		}

		#endregion
	} // SysMessageReceive
}

