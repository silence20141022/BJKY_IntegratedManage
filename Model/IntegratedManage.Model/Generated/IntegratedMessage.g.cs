// Business class IntegratedMessage generated from IntegratedMessage
// Creator: Ray
// Created Date: [2013-03-06]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("IntegratedMessage")]
	public partial class IntegratedMessage : IMModelBase<IntegratedMessage>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ReceiverId = "ReceiverId";
		public static string Prop_ReceiverName = "ReceiverName";
		public static string Prop_MessageType = "MessageType";
		public static string Prop_MessageContent = "MessageContent";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_ShortMessage = "ShortMessage";
		public static string Prop_Mail = "Mail";
		public static string Prop_State = "State";
		public static string Prop_SubmitState = "SubmitState";
		public static string Prop_ReceiverIds = "ReceiverIds";
		public static string Prop_ReceiverNames = "ReceiverNames";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _receiverId;
		private string _receiverName;
		private string _messageType;
		private string _messageContent;
		private string _attachment;
		private string _shortMessage;
		private string _mail;
		private string _state;
		private string _submitState;
		private string _receiverIds;
		private string _receiverNames;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public IntegratedMessage()
		{
		}

		public IntegratedMessage(
			string p_id,
			string p_receiverId,
			string p_receiverName,
			string p_messageType,
			string p_messageContent,
			string p_attachment,
			string p_shortMessage,
			string p_mail,
			string p_state,
			string p_submitState,
			string p_receiverIds,
			string p_receiverNames,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_receiverId = p_receiverId;
			_receiverName = p_receiverName;
			_messageType = p_messageType;
			_messageContent = p_messageContent;
			_attachment = p_attachment;
			_shortMessage = p_shortMessage;
			_mail = p_mail;
			_state = p_state;
			_submitState = p_submitState;
			_receiverIds = p_receiverIds;
			_receiverNames = p_receiverNames;
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
					RaisePropertyChanged(IntegratedMessage.Prop_ReceiverId, oldValue, value);
				}
			}

		}

		[Property("ReceiverName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ReceiverName
		{
			get { return _receiverName; }
			set
			{
				if ((_receiverName == null) || (value == null) || (!value.Equals(_receiverName)))
				{
                    object oldValue = _receiverName;
					_receiverName = value;
					RaisePropertyChanged(IntegratedMessage.Prop_ReceiverName, oldValue, value);
				}
			}

		}

		[Property("MessageType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MessageType
		{
			get { return _messageType; }
			set
			{
				if ((_messageType == null) || (value == null) || (!value.Equals(_messageType)))
				{
                    object oldValue = _messageType;
					_messageType = value;
					RaisePropertyChanged(IntegratedMessage.Prop_MessageType, oldValue, value);
				}
			}

		}

		[Property("MessageContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string MessageContent
		{
			get { return _messageContent; }
			set
			{
				if ((_messageContent == null) || (value == null) || (!value.Equals(_messageContent)))
				{
                    object oldValue = _messageContent;
					_messageContent = value;
					RaisePropertyChanged(IntegratedMessage.Prop_MessageContent, oldValue, value);
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
					RaisePropertyChanged(IntegratedMessage.Prop_Attachment, oldValue, value);
				}
			}

		}

		[Property("ShortMessage", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShortMessage
		{
			get { return _shortMessage; }
			set
			{
				if ((_shortMessage == null) || (value == null) || (!value.Equals(_shortMessage)))
				{
                    object oldValue = _shortMessage;
					_shortMessage = value;
					RaisePropertyChanged(IntegratedMessage.Prop_ShortMessage, oldValue, value);
				}
			}

		}

		[Property("Mail", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Mail
		{
			get { return _mail; }
			set
			{
				if ((_mail == null) || (value == null) || (!value.Equals(_mail)))
				{
                    object oldValue = _mail;
					_mail = value;
					RaisePropertyChanged(IntegratedMessage.Prop_Mail, oldValue, value);
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
					RaisePropertyChanged(IntegratedMessage.Prop_State, oldValue, value);
				}
			}

		}

		[Property("SubmitState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SubmitState
		{
			get { return _submitState; }
			set
			{
				if ((_submitState == null) || (value == null) || (!value.Equals(_submitState)))
				{
                    object oldValue = _submitState;
					_submitState = value;
					RaisePropertyChanged(IntegratedMessage.Prop_SubmitState, oldValue, value);
				}
			}

		}

		[Property("ReceiverIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ReceiverIds
		{
			get { return _receiverIds; }
			set
			{
				if ((_receiverIds == null) || (value == null) || (!value.Equals(_receiverIds)))
				{
                    object oldValue = _receiverIds;
					_receiverIds = value;
					RaisePropertyChanged(IntegratedMessage.Prop_ReceiverIds, oldValue, value);
				}
			}

		}

		[Property("ReceiverNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ReceiverNames
		{
			get { return _receiverNames; }
			set
			{
				if ((_receiverNames == null) || (value == null) || (!value.Equals(_receiverNames)))
				{
                    object oldValue = _receiverNames;
					_receiverNames = value;
					RaisePropertyChanged(IntegratedMessage.Prop_ReceiverNames, oldValue, value);
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
					RaisePropertyChanged(IntegratedMessage.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(IntegratedMessage.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(IntegratedMessage.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // IntegratedMessage
}

