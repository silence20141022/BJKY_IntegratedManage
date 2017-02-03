// Business class VideoNewDetail generated from VideoNewDetail
// Creator: Ray
// Created Date: [2013-03-19]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace Aim.Portal.Model
{
	[ActiveRecord("VideoNewDetail")]
    public partial class VideoNewDetail : EntityBase<VideoNewDetail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_PId = "PId";
		public static string Prop_ImgPath = "ImgPath";
		public static string Prop_Content = "Content";
		public static string Prop_Remark = "Remark";
		public static string Prop_State = "State";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";
		public static string Prop_Ext4 = "Ext4";
		public static string Prop_Ext5 = "Ext5";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _pId;
		private string _imgPath;
		private string _content;
		private string _remark;
		private string _state;
		private string _ext1;
		private string _ext2;
		private string _ext3;
		private string _ext4;
		private string _ext5;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public VideoNewDetail()
		{
		}

		public VideoNewDetail(
			string p_id,
			string p_pId,
			string p_imgPath,
			string p_content,
			string p_remark,
			string p_state,
			string p_ext1,
			string p_ext2,
			string p_ext3,
			string p_ext4,
			string p_ext5,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_pId = p_pId;
			_imgPath = p_imgPath;
			_content = p_content;
			_remark = p_remark;
			_state = p_state;
			_ext1 = p_ext1;
			_ext2 = p_ext2;
			_ext3 = p_ext3;
			_ext4 = p_ext4;
			_ext5 = p_ext5;
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
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("PId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PId
		{
			get { return _pId; }
			set
			{
				if ((_pId == null) || (value == null) || (!value.Equals(_pId)))
				{
                    object oldValue = _pId;
					_pId = value;
					RaisePropertyChanged(VideoNewDetail.Prop_PId, oldValue, value);
				}
			}

		}

		[Property("ImgPath", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ImgPath
		{
			get { return _imgPath; }
			set
			{
				if ((_imgPath == null) || (value == null) || (!value.Equals(_imgPath)))
				{
                    object oldValue = _imgPath;
					_imgPath = value;
					RaisePropertyChanged(VideoNewDetail.Prop_ImgPath, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Content, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_State, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Ext1, oldValue, value);
				}
			}

		}

		[Property("Ext2", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Ext2
		{
			get { return _ext2; }
			set
			{
				if ((_ext2 == null) || (value == null) || (!value.Equals(_ext2)))
				{
                    object oldValue = _ext2;
					_ext2 = value;
					RaisePropertyChanged(VideoNewDetail.Prop_Ext2, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Ext3, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Ext4, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_Ext5, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(VideoNewDetail.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // VideoNewDetail
}

