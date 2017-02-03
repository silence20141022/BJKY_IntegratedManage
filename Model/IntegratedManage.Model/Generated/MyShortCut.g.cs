// Business class MyShortCut generated from MyShortCut
// Creator: Ray
// Created Date: [2013-03-22]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("MyShortCut")]
	public partial class MyShortCut : IMModelBase<MyShortCut>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_AuthId = "AuthId";
		public static string Prop_AuthName = "AuthName";
		public static string Prop_ModuleUrl = "ModuleUrl";
		public static string Prop_IconFileName = "IconFileName";
		public static string Prop_IconFileId = "IconFileId";
		public static string Prop_SortIndex = "SortIndex";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _authId;
		private string _authName;
		private string _moduleUrl;
		private string _iconFileName;
		private string _iconFileId;
		private int? _sortIndex;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public MyShortCut()
		{
		}

		public MyShortCut(
			string p_id,
			string p_authId,
			string p_authName,
			string p_moduleUrl,
			string p_iconFileName,
			string p_iconFileId,
			int? p_sortIndex,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_authId = p_authId;
			_authName = p_authName;
			_moduleUrl = p_moduleUrl;
			_iconFileName = p_iconFileName;
			_iconFileId = p_iconFileId;
			_sortIndex = p_sortIndex;
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

		[Property("AuthId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string AuthId
		{
			get { return _authId; }
			set
			{
				if ((_authId == null) || (value == null) || (!value.Equals(_authId)))
				{
                    object oldValue = _authId;
					_authId = value;
					RaisePropertyChanged(MyShortCut.Prop_AuthId, oldValue, value);
				}
			}

		}

		[Property("AuthName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string AuthName
		{
			get { return _authName; }
			set
			{
				if ((_authName == null) || (value == null) || (!value.Equals(_authName)))
				{
                    object oldValue = _authName;
					_authName = value;
					RaisePropertyChanged(MyShortCut.Prop_AuthName, oldValue, value);
				}
			}

		}

		[Property("ModuleUrl", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ModuleUrl
		{
			get { return _moduleUrl; }
			set
			{
				if ((_moduleUrl == null) || (value == null) || (!value.Equals(_moduleUrl)))
				{
                    object oldValue = _moduleUrl;
					_moduleUrl = value;
					RaisePropertyChanged(MyShortCut.Prop_ModuleUrl, oldValue, value);
				}
			}

		}

		[Property("IconFileName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IconFileName
		{
			get { return _iconFileName; }
			set
			{
				if ((_iconFileName == null) || (value == null) || (!value.Equals(_iconFileName)))
				{
                    object oldValue = _iconFileName;
					_iconFileName = value;
					RaisePropertyChanged(MyShortCut.Prop_IconFileName, oldValue, value);
				}
			}

		}

		[Property("IconFileId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string IconFileId
		{
			get { return _iconFileId; }
			set
			{
				if ((_iconFileId == null) || (value == null) || (!value.Equals(_iconFileId)))
				{
                    object oldValue = _iconFileId;
					_iconFileId = value;
					RaisePropertyChanged(MyShortCut.Prop_IconFileId, oldValue, value);
				}
			}

		}

		[Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? SortIndex
		{
			get { return _sortIndex; }
			set
			{
				if (value != _sortIndex)
				{
                    object oldValue = _sortIndex;
					_sortIndex = value;
					RaisePropertyChanged(MyShortCut.Prop_SortIndex, oldValue, value);
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
					RaisePropertyChanged(MyShortCut.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(MyShortCut.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(MyShortCut.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // MyShortCut
}

