// Business class Seal generated from Seal
// Creator: Ray
// Created Date: [2013-03-13]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Seal")]
	public partial class Seal : IMModelBase<Seal>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_SealName = "SealName";
		public static string Prop_SealType = "SealType";
		public static string Prop_SealFileId = "SealFileId";
		public static string Prop_SealFileName = "SealFileName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _sealName;
		private string _sealType;
		private string _sealFileId;
		private string _sealFileName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public Seal()
		{
		}

		public Seal(
			string p_id,
			string p_sealName,
			string p_sealType,
			string p_sealFileId,
			string p_sealFileName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_sealName = p_sealName;
			_sealType = p_sealType;
			_sealFileId = p_sealFileId;
			_sealFileName = p_sealFileName;
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

		[Property("SealName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SealName
		{
			get { return _sealName; }
			set
			{
				if ((_sealName == null) || (value == null) || (!value.Equals(_sealName)))
				{
                    object oldValue = _sealName;
					_sealName = value;
					RaisePropertyChanged(Seal.Prop_SealName, oldValue, value);
				}
			}

		}

		[Property("SealType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SealType
		{
			get { return _sealType; }
			set
			{
				if ((_sealType == null) || (value == null) || (!value.Equals(_sealType)))
				{
                    object oldValue = _sealType;
					_sealType = value;
					RaisePropertyChanged(Seal.Prop_SealType, oldValue, value);
				}
			}

		}

		[Property("SealFileId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SealFileId
		{
			get { return _sealFileId; }
			set
			{
				if ((_sealFileId == null) || (value == null) || (!value.Equals(_sealFileId)))
				{
                    object oldValue = _sealFileId;
					_sealFileId = value;
					RaisePropertyChanged(Seal.Prop_SealFileId, oldValue, value);
				}
			}

		}

		[Property("SealFileName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string SealFileName
		{
			get { return _sealFileName; }
			set
			{
				if ((_sealFileName == null) || (value == null) || (!value.Equals(_sealFileName)))
				{
                    object oldValue = _sealFileName;
					_sealFileName = value;
					RaisePropertyChanged(Seal.Prop_SealFileName, oldValue, value);
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
					RaisePropertyChanged(Seal.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Seal.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Seal.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // Seal
}

