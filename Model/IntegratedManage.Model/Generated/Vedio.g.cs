// Business class Vedio generated from Vedio
// Creator: Ray
// Created Date: [2013-03-16]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Vedio")]
	public partial class Vedio : IMModelBase<Vedio>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Theme = "Theme";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_VedioType = "VedioType";
		public static string Prop_VedioFile = "VedioFile";
		public static string Prop_ImageFile = "ImageFile";
		public static string Prop_Remark = "Remark";
		public static string Prop_PlayTimes = "PlayTimes";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _theme;
		private string _deptId;
		private string _deptName;
		private string _vedioType;
		private string _vedioFile;
		private string _imageFile;
		private string _remark;
		private int? _playTimes;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public Vedio()
		{
		}

		public Vedio(
			string p_id,
			string p_theme,
			string p_deptId,
			string p_deptName,
			string p_vedioType,
			string p_vedioFile,
			string p_imageFile,
			string p_remark,
			int? p_playTimes,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_theme = p_theme;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_vedioType = p_vedioType;
			_vedioFile = p_vedioFile;
			_imageFile = p_imageFile;
			_remark = p_remark;
			_playTimes = p_playTimes;
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
					RaisePropertyChanged(Vedio.Prop_Theme, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_DeptId, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("VedioType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string VedioType
		{
			get { return _vedioType; }
			set
			{
				if ((_vedioType == null) || (value == null) || (!value.Equals(_vedioType)))
				{
                    object oldValue = _vedioType;
					_vedioType = value;
					RaisePropertyChanged(Vedio.Prop_VedioType, oldValue, value);
				}
			}

		}

		[Property("VedioFile", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string VedioFile
		{
			get { return _vedioFile; }
			set
			{
				if ((_vedioFile == null) || (value == null) || (!value.Equals(_vedioFile)))
				{
                    object oldValue = _vedioFile;
					_vedioFile = value;
					RaisePropertyChanged(Vedio.Prop_VedioFile, oldValue, value);
				}
			}

		}

		[Property("ImageFile", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ImageFile
		{
			get { return _imageFile; }
			set
			{
				if ((_imageFile == null) || (value == null) || (!value.Equals(_imageFile)))
				{
                    object oldValue = _imageFile;
					_imageFile = value;
					RaisePropertyChanged(Vedio.Prop_ImageFile, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("PlayTimes", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? PlayTimes
		{
			get { return _playTimes; }
			set
			{
				if (value != _playTimes)
				{
                    object oldValue = _playTimes;
					_playTimes = value;
					RaisePropertyChanged(Vedio.Prop_PlayTimes, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Vedio.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // Vedio
}

