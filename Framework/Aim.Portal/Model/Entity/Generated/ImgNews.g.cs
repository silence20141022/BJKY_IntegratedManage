﻿// Business class ImgNews generated from ImgNews
// Creator: Ray
// Created Date: [2013-05-24]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace Aim.Portal.Model
{
	[ActiveRecord("ImgNews")]
    public partial class ImgNews : EntityBase<ImgNews>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ShowImg = "ShowImg";
		public static string Prop_Title = "Title";
		public static string Prop_ReceiveDeptId = "ReceiveDeptId";
		public static string Prop_ReceiveDeptName = "ReceiveDeptName";
		public static string Prop_PostUserId = "PostUserId";
		public static string Prop_PostUserName = "PostUserName";
		public static string Prop_PostTime = "PostTime";
		public static string Prop_ExpireTime = "ExpireTime";
		public static string Prop_Remark = "Remark";
		public static string Prop_TypeId = "TypeId";
		public static string Prop_Content = "Content";
		public static string Prop_State = "State";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";
		public static string Prop_Ext4 = "Ext4";
		public static string Prop_Ext5 = "Ext5";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_ReceiveUserName = "ReceiveUserName";
		public static string Prop_ReceiveUserId = "ReceiveUserId";
		public static string Prop_Grade = "Grade";
		public static string Prop_HomePagePopup = "HomePagePopup";
		public static string Prop_PostDeptId = "PostDeptId";
		public static string Prop_PostDeptName = "PostDeptName";
		public static string Prop_AuditUserId = "AuditUserId";
		public static string Prop_AuditUserName = "AuditUserName";
		public static string Prop_WFState = "WFState";
		public static string Prop_WFResult = "WFResult";
		public static string Prop_WFCurrentNode = "WFCurrentNode"; 

		#endregion

		#region Private_Variables

		private string _id;
		private string _showImg;
		private string _title;
		private string _receiveDeptId;
		private string _receiveDeptName;
		private string _postUserId;
		private string _postUserName;
		private DateTime? _postTime;
		private DateTime? _expireTime;
		private string _remark;
		private string _typeId;
		private string _content;
		private string _state;
		private string _ext1;
		private string _ext2;
		private string _ext3;
		private string _ext4;
		private string _ext5;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _receiveUserName;
		private string _receiveUserId;
		private string _grade;
		private string _homePagePopup;
		private string _postDeptId;
		private string _postDeptName;
		private string _auditUserId;
		private string _auditUserName;
		private string _wFState;
		private string _wFResult;
		private string _wFCurrentNode; 

		#endregion

		#region Constructors

		public ImgNews()
		{
		}

		public ImgNews(
			string p_id,
			string p_showImg,
			string p_title,
			string p_receiveDeptId,
			string p_receiveDeptName,
			string p_postUserId,
			string p_postUserName,
			DateTime? p_postTime,
			DateTime? p_expireTime,
			string p_remark,
			string p_typeId,
			string p_content,
			string p_state,
			string p_ext1,
			string p_ext2,
			string p_ext3,
			string p_ext4,
			string p_ext5,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_receiveUserName,
			string p_receiveUserId,
			string p_grade,
			string p_homePagePopup,
			string p_postDeptId,
			string p_postDeptName,
			string p_auditUserId,
			string p_auditUserName,
			string p_wFState,
			string p_wFResult,
			string p_wFCurrentNode)
		{
			_id = p_id;
			_showImg = p_showImg;
			_title = p_title;
			_receiveDeptId = p_receiveDeptId;
			_receiveDeptName = p_receiveDeptName;
			_postUserId = p_postUserId;
			_postUserName = p_postUserName;
			_postTime = p_postTime;
			_expireTime = p_expireTime;
			_remark = p_remark;
			_typeId = p_typeId;
			_content = p_content;
			_state = p_state;
			_ext1 = p_ext1;
			_ext2 = p_ext2;
			_ext3 = p_ext3;
			_ext4 = p_ext4;
			_ext5 = p_ext5;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_receiveUserName = p_receiveUserName;
			_receiveUserId = p_receiveUserId;
			_grade = p_grade;
			_homePagePopup = p_homePagePopup;
			_postDeptId = p_postDeptId;
			_postDeptName = p_postDeptName;
			_auditUserId = p_auditUserId;
			_auditUserName = p_auditUserName;
			_wFState = p_wFState;
			_wFResult = p_wFResult;
			_wFCurrentNode = p_wFCurrentNode; 
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("ShowImg", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ShowImg
		{
			get { return _showImg; }
			set
			{
				if ((_showImg == null) || (value == null) || (!value.Equals(_showImg)))
				{
                    object oldValue = _showImg;
					_showImg = value;
					RaisePropertyChanged(ImgNews.Prop_ShowImg, oldValue, value);
				}
			}

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
					RaisePropertyChanged(ImgNews.Prop_Title, oldValue, value);
				}
			}

		}

		[Property("ReceiveDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 360)]
		public string ReceiveDeptId
		{
			get { return _receiveDeptId; }
			set
			{
				if ((_receiveDeptId == null) || (value == null) || (!value.Equals(_receiveDeptId)))
				{
                    object oldValue = _receiveDeptId;
					_receiveDeptId = value;
					RaisePropertyChanged(ImgNews.Prop_ReceiveDeptId, oldValue, value);
				}
			}

		}

		[Property("ReceiveDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string ReceiveDeptName
		{
			get { return _receiveDeptName; }
			set
			{
				if ((_receiveDeptName == null) || (value == null) || (!value.Equals(_receiveDeptName)))
				{
                    object oldValue = _receiveDeptName;
					_receiveDeptName = value;
					RaisePropertyChanged(ImgNews.Prop_ReceiveDeptName, oldValue, value);
				}
			}

		}

		[Property("PostUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 360)]
		public string PostUserId
		{
			get { return _postUserId; }
			set
			{
				if ((_postUserId == null) || (value == null) || (!value.Equals(_postUserId)))
				{
                    object oldValue = _postUserId;
					_postUserId = value;
					RaisePropertyChanged(ImgNews.Prop_PostUserId, oldValue, value);
				}
			}

		}

		[Property("PostUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string PostUserName
		{
			get { return _postUserName; }
			set
			{
				if ((_postUserName == null) || (value == null) || (!value.Equals(_postUserName)))
				{
                    object oldValue = _postUserName;
					_postUserName = value;
					RaisePropertyChanged(ImgNews.Prop_PostUserName, oldValue, value);
				}
			}

		}

		[Property("PostTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? PostTime
		{
			get { return _postTime; }
			set
			{
				if (value != _postTime)
				{
                    object oldValue = _postTime;
					_postTime = value;
					RaisePropertyChanged(ImgNews.Prop_PostTime, oldValue, value);
				}
			}

		}

		[Property("ExpireTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ExpireTime
		{
			get { return _expireTime; }
			set
			{
				if (value != _expireTime)
				{
                    object oldValue = _expireTime;
					_expireTime = value;
					RaisePropertyChanged(ImgNews.Prop_ExpireTime, oldValue, value);
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
					RaisePropertyChanged(ImgNews.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("TypeId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string TypeId
		{
			get { return _typeId; }
			set
			{
				if ((_typeId == null) || (value == null) || (!value.Equals(_typeId)))
				{
                    object oldValue = _typeId;
					_typeId = value;
					RaisePropertyChanged(ImgNews.Prop_TypeId, oldValue, value);
				}
			}

		}

		[Property("Content", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Content
		{
			get { return _content; }
			set
			{
				if ((_content == null) || (value == null) || (!value.Equals(_content)))
				{
                    object oldValue = _content;
					_content = value;
					RaisePropertyChanged(ImgNews.Prop_Content, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(ImgNews.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Ext1", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext1
		{
			get { return _ext1; }
			set
			{
				if ((_ext1 == null) || (value == null) || (!value.Equals(_ext1)))
				{
                    object oldValue = _ext1;
					_ext1 = value;
					RaisePropertyChanged(ImgNews.Prop_Ext1, oldValue, value);
				}
			}

		}

		[Property("Ext2", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Ext2
		{
			get { return _ext2; }
			set
			{
				if ((_ext2 == null) || (value == null) || (!value.Equals(_ext2)))
				{
                    object oldValue = _ext2;
					_ext2 = value;
					RaisePropertyChanged(ImgNews.Prop_Ext2, oldValue, value);
				}
			}

		}

		[Property("Ext3", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext3
		{
			get { return _ext3; }
			set
			{
				if ((_ext3 == null) || (value == null) || (!value.Equals(_ext3)))
				{
                    object oldValue = _ext3;
					_ext3 = value;
					RaisePropertyChanged(ImgNews.Prop_Ext3, oldValue, value);
				}
			}

		}

		[Property("Ext4", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext4
		{
			get { return _ext4; }
			set
			{
				if ((_ext4 == null) || (value == null) || (!value.Equals(_ext4)))
				{
                    object oldValue = _ext4;
					_ext4 = value;
					RaisePropertyChanged(ImgNews.Prop_Ext4, oldValue, value);
				}
			}

		}

		[Property("Ext5", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext5
		{
			get { return _ext5; }
			set
			{
				if ((_ext5 == null) || (value == null) || (!value.Equals(_ext5)))
				{
                    object oldValue = _ext5;
					_ext5 = value;
					RaisePropertyChanged(ImgNews.Prop_Ext5, oldValue, value);
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
					RaisePropertyChanged(ImgNews.Prop_CreateId, oldValue, value);
				}
			}

		}

		[Property("CreateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
		public string CreateName
		{
			get { return _createName; }
			set
			{
				if ((_createName == null) || (value == null) || (!value.Equals(_createName)))
				{
                    object oldValue = _createName;
					_createName = value;
					RaisePropertyChanged(ImgNews.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ImgNews.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("ReceiveUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
		public string ReceiveUserName
		{
			get { return _receiveUserName; }
			set
			{
				if ((_receiveUserName == null) || (value == null) || (!value.Equals(_receiveUserName)))
				{
                    object oldValue = _receiveUserName;
					_receiveUserName = value;
					RaisePropertyChanged(ImgNews.Prop_ReceiveUserName, oldValue, value);
				}
			}

		}

		[Property("ReceiveUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string ReceiveUserId
		{
			get { return _receiveUserId; }
			set
			{
				if ((_receiveUserId == null) || (value == null) || (!value.Equals(_receiveUserId)))
				{
                    object oldValue = _receiveUserId;
					_receiveUserId = value;
					RaisePropertyChanged(ImgNews.Prop_ReceiveUserId, oldValue, value);
				}
			}

		}

		[Property("Grade", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
		public string Grade
		{
			get { return _grade; }
			set
			{
				if ((_grade == null) || (value == null) || (!value.Equals(_grade)))
				{
                    object oldValue = _grade;
					_grade = value;
					RaisePropertyChanged(ImgNews.Prop_Grade, oldValue, value);
				}
			}

		}

		[Property("HomePagePopup", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string HomePagePopup
		{
			get { return _homePagePopup; }
			set
			{
				if ((_homePagePopup == null) || (value == null) || (!value.Equals(_homePagePopup)))
				{
                    object oldValue = _homePagePopup;
					_homePagePopup = value;
					RaisePropertyChanged(ImgNews.Prop_HomePagePopup, oldValue, value);
				}
			}

		}

		[Property("PostDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PostDeptId
		{
			get { return _postDeptId; }
			set
			{
				if ((_postDeptId == null) || (value == null) || (!value.Equals(_postDeptId)))
				{
                    object oldValue = _postDeptId;
					_postDeptId = value;
					RaisePropertyChanged(ImgNews.Prop_PostDeptId, oldValue, value);
				}
			}

		}

		[Property("PostDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PostDeptName
		{
			get { return _postDeptName; }
			set
			{
				if ((_postDeptName == null) || (value == null) || (!value.Equals(_postDeptName)))
				{
                    object oldValue = _postDeptName;
					_postDeptName = value;
					RaisePropertyChanged(ImgNews.Prop_PostDeptName, oldValue, value);
				}
			}

		}

		[Property("AuditUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string AuditUserId
		{
			get { return _auditUserId; }
			set
			{
				if ((_auditUserId == null) || (value == null) || (!value.Equals(_auditUserId)))
				{
                    object oldValue = _auditUserId;
					_auditUserId = value;
					RaisePropertyChanged(ImgNews.Prop_AuditUserId, oldValue, value);
				}
			}

		}

		[Property("AuditUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string AuditUserName
		{
			get { return _auditUserName; }
			set
			{
				if ((_auditUserName == null) || (value == null) || (!value.Equals(_auditUserName)))
				{
                    object oldValue = _auditUserName;
					_auditUserName = value;
					RaisePropertyChanged(ImgNews.Prop_AuditUserName, oldValue, value);
				}
			}

		}

		[Property("WFState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string WFState
		{
			get { return _wFState; }
			set
			{
				if ((_wFState == null) || (value == null) || (!value.Equals(_wFState)))
				{
                    object oldValue = _wFState;
					_wFState = value;
					RaisePropertyChanged(ImgNews.Prop_WFState, oldValue, value);
				}
			}

		}

		[Property("WFResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string WFResult
		{
			get { return _wFResult; }
			set
			{
				if ((_wFResult == null) || (value == null) || (!value.Equals(_wFResult)))
				{
                    object oldValue = _wFResult;
					_wFResult = value;
					RaisePropertyChanged(ImgNews.Prop_WFResult, oldValue, value);
				}
			}

		}

		[Property("WFCurrentNode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string WFCurrentNode
		{
			get { return _wFCurrentNode; }
			set
			{
				if ((_wFCurrentNode == null) || (value == null) || (!value.Equals(_wFCurrentNode)))
				{
                    object oldValue = _wFCurrentNode;
					_wFCurrentNode = value;
					RaisePropertyChanged(ImgNews.Prop_WFCurrentNode, oldValue, value);
				}
			}

		} 
		#endregion
	} // ImgNews
}

