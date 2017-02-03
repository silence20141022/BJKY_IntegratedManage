// Business class View_SysMessage generated from View_SysMessage
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
	[ActiveRecord("View_SysMessage")]
    public partial class View_SysMessage : EntityBase<View_SysMessage>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SenderId = "SenderId";
		public static string Prop_SenderName = "SenderName";
		public static string Prop_ReceiverId = "ReceiverId";
		public static string Prop_ReceiverName = "ReceiverName";
		public static string Prop_FullId = "FullId";
		public static string Prop_Title = "Title";
		public static string Prop_MessageContent = "MessageContent";
		public static string Prop_ReplayMessageId = "ReplayMessageId";
		public static string Prop_SendTime = "SendTime";
		public static string Prop_ReadTime = "ReadTime";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_State = "State";
		public static string Prop_IsRead = "IsRead";
		public static string Prop_IsSenderDelete = "IsSenderDelete";
		public static string Prop_IsReceiverDelete = "IsReceiverDelete";
		public static string Prop_RId = "RId";
		public static string Prop_ReceiveId = "ReceiveId";
		public static string Prop_ReceiveName = "ReceiveName";
		public static string Prop_IsFirstView = "IsFirstView";
		public static string Prop_FirstViewTime = "FirstViewTime";
		public static string Prop_IsReply = "IsReply";
		public static string Prop_ReplyTime = "ReplyTime";
		public static string Prop_ReplyMsgId = "ReplyMsgId";
		public static string Prop_IsDelete = "IsDelete";
		public static string Prop_DeleteTime = "DeleteTime";
		public static string Prop_ReplyResult = "ReplyResult";
		public static string Prop_ReplyType = "ReplyType";
		public static string Prop_IsHot = "IsHot";

		#endregion

		#region Private_Variables

		private string _id;
		private string _senderId;
		private string _senderName;
		private string _receiverId;
		private string _receiverName;
		private string _fullId;
		private string _title;
		private string _messageContent;
		private string _replayMessageId;
		private DateTime? _sendTime;
		private DateTime? _readTime;
		private string _attachment;
		private string _state;
		private bool? _isRead;
		private bool? _isSenderDelete;
		private bool? _isReceiverDelete;
		private string _rId;
		private string _receiveId;
		private string _receiveName;
		private string _isFirstView;
		private DateTime? _firstViewTime;
		private string _isReply;
		private DateTime? _replyTime;
		private string _replyMsgId;
		private string _isDelete;
		private DateTime? _deleteTime;
		private string _replyResult;
		private string _replyType;
		private string _isHot;


		#endregion

		#region Constructors

		public View_SysMessage()
		{
		}

		public View_SysMessage(
			string p_id,
			string p_senderId,
			string p_senderName,
			string p_receiverId,
			string p_receiverName,
			string p_fullId,
			string p_title,
			string p_messageContent,
			string p_replayMessageId,
			DateTime? p_sendTime,
			DateTime? p_readTime,
			string p_attachment,
			string p_state,
			bool? p_isRead,
			bool? p_isSenderDelete,
			bool? p_isReceiverDelete,
			string p_rId,
			string p_receiveId,
			string p_receiveName,
			string p_isFirstView,
			DateTime? p_firstViewTime,
			string p_isReply,
			DateTime? p_replyTime,
			string p_replyMsgId,
			string p_isDelete,
			DateTime? p_deleteTime,
			string p_replyResult,
			string p_replyType,
			string p_isHot)
		{
			_id = p_id;
			_senderId = p_senderId;
			_senderName = p_senderName;
			_receiverId = p_receiverId;
			_receiverName = p_receiverName;
			_fullId = p_fullId;
			_title = p_title;
			_messageContent = p_messageContent;
			_replayMessageId = p_replayMessageId;
			_sendTime = p_sendTime;
			_readTime = p_readTime;
			_attachment = p_attachment;
			_state = p_state;
			_isRead = p_isRead;
			_isSenderDelete = p_isSenderDelete;
			_isReceiverDelete = p_isReceiverDelete;
			_rId = p_rId;
			_receiveId = p_receiveId;
			_receiveName = p_receiveName;
			_isFirstView = p_isFirstView;
			_firstViewTime = p_firstViewTime;
			_isReply = p_isReply;
			_replyTime = p_replyTime;
			_replyMsgId = p_replyMsgId;
			_isDelete = p_isDelete;
			_deleteTime = p_deleteTime;
			_replyResult = p_replyResult;
			_replyType = p_replyType;
			_isHot = p_isHot;
		}

		#endregion

		#region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
		{
			get { return _id; }
			set
			{
				if ((_id == null) || (value == null) || (!value.Equals(_id)))
				{
                    object oldValue = _id;
					_id = value;
				}
			}

		}

		[Property("SenderId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SenderId
		{
			get { return _senderId; }
			set
			{
				if ((_senderId == null) || (value == null) || (!value.Equals(_senderId)))
				{
                    object oldValue = _senderId;
					_senderId = value;
				}
			}

		}

		[Property("SenderName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string SenderName
		{
			get { return _senderName; }
			set
			{
				if ((_senderName == null) || (value == null) || (!value.Equals(_senderName)))
				{
                    object oldValue = _senderName;
					_senderName = value;
				}
			}

		}

		[Property("ReceiverId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 8000)]
		public string ReceiverId
		{
			get { return _receiverId; }
			set
			{
				if ((_receiverId == null) || (value == null) || (!value.Equals(_receiverId)))
				{
                    object oldValue = _receiverId;
					_receiverId = value;
				}
			}

		}

		[Property("ReceiverName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 4000)]
		public string ReceiverName
		{
			get { return _receiverName; }
			set
			{
				if ((_receiverName == null) || (value == null) || (!value.Equals(_receiverName)))
				{
                    object oldValue = _receiverName;
					_receiverName = value;
				}
			}

		}

		[Property("FullId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1850)]
		public string FullId
		{
			get { return _fullId; }
			set
			{
				if ((_fullId == null) || (value == null) || (!value.Equals(_fullId)))
				{
                    object oldValue = _fullId;
					_fullId = value;
				}
			}

		}

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 80)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
				}
			}

		}

		[Property("MessageContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 4000)]
		public string MessageContent
		{
			get { return _messageContent; }
			set
			{
				if ((_messageContent == null) || (value == null) || (!value.Equals(_messageContent)))
				{
                    object oldValue = _messageContent;
					_messageContent = value;
				}
			}

		}

		[Property("ReplayMessageId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ReplayMessageId
		{
			get { return _replayMessageId; }
			set
			{
				if ((_replayMessageId == null) || (value == null) || (!value.Equals(_replayMessageId)))
				{
                    object oldValue = _replayMessageId;
					_replayMessageId = value;
				}
			}

		}

		[Property("SendTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? SendTime
		{
			get { return _sendTime; }
			set
			{
				if (value != _sendTime)
				{
                    object oldValue = _sendTime;
					_sendTime = value;
				}
			}

		}

		[Property("ReadTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ReadTime
		{
			get { return _readTime; }
			set
			{
				if (value != _readTime)
				{
                    object oldValue = _readTime;
					_readTime = value;
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
				}
			}

		}

		[Property("IsRead", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public bool? IsRead
		{
			get { return _isRead; }
			set
			{
				if (value != _isRead)
				{
                    object oldValue = _isRead;
					_isRead = value;
				}
			}

		}

		[Property("IsSenderDelete", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public bool? IsSenderDelete
		{
			get { return _isSenderDelete; }
			set
			{
				if (value != _isSenderDelete)
				{
                    object oldValue = _isSenderDelete;
					_isSenderDelete = value;
				}
			}

		}

		[Property("IsReceiverDelete", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public bool? IsReceiverDelete
		{
			get { return _isReceiverDelete; }
			set
			{
				if (value != _isReceiverDelete)
				{
                    object oldValue = _isReceiverDelete;
					_isReceiverDelete = value;
				}
			}

		}

		[Property("RId", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 36)]
		public string RId
		{
			get { return _rId; }
			set
			{
				if ((_rId == null) || (value == null) || (!value.Equals(_rId)))
				{
                    object oldValue = _rId;
					_rId = value;
				}
			}

		}

		[Property("ReceiveId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ReceiveId
		{
			get { return _receiveId; }
			set
			{
				if ((_receiveId == null) || (value == null) || (!value.Equals(_receiveId)))
				{
                    object oldValue = _receiveId;
					_receiveId = value;
				}
			}

		}

		[Property("ReceiveName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string ReceiveName
		{
			get { return _receiveName; }
			set
			{
				if ((_receiveName == null) || (value == null) || (!value.Equals(_receiveName)))
				{
                    object oldValue = _receiveName;
					_receiveName = value;
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
				}
			}

		}

		#endregion
	} // View_SysMessage
}

