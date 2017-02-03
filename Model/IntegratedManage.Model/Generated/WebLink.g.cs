// Business class WebLink generated from WebLink
// Creator: Ray
// Created Date: [2014-05-04]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("WebLink")]
	public partial class WebLink : IMModelBase<WebLink>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Url = "Url";
		public static string Prop_WebName = "WebName";
		public static string Prop_IsAdmin = "IsAdmin";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_ExceptUserId = "ExceptUserId";

		#endregion

		#region Private_Variables

		private string _id;
		private string _url;
		private string _webName;
		private string _isAdmin;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _exceptUserId;


		#endregion

		#region Constructors

		public WebLink()
		{
		}

		public WebLink(
			string p_id,
			string p_url,
			string p_webName,
			string p_isAdmin,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_exceptUserId)
		{
			_id = p_id;
			_url = p_url;
			_webName = p_webName;
			_isAdmin = p_isAdmin;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_exceptUserId = p_exceptUserId;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Url", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Url
		{
			get { return _url; }
			set
			{
				if ((_url == null) || (value == null) || (!value.Equals(_url)))
				{
                    object oldValue = _url;
					_url = value;
					RaisePropertyChanged(WebLink.Prop_Url, oldValue, value);
				}
			}

		}

		[Property("WebName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string WebName
		{
			get { return _webName; }
			set
			{
				if ((_webName == null) || (value == null) || (!value.Equals(_webName)))
				{
                    object oldValue = _webName;
					_webName = value;
					RaisePropertyChanged(WebLink.Prop_WebName, oldValue, value);
				}
			}

		}

		[Property("IsAdmin", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string IsAdmin
		{
			get { return _isAdmin; }
			set
			{
				if ((_isAdmin == null) || (value == null) || (!value.Equals(_isAdmin)))
				{
                    object oldValue = _isAdmin;
					_isAdmin = value;
					RaisePropertyChanged(WebLink.Prop_IsAdmin, oldValue, value);
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
					RaisePropertyChanged(WebLink.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(WebLink.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(WebLink.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("ExceptUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 4000)]
		public string ExceptUserId
		{
			get { return _exceptUserId; }
			set
			{
				if ((_exceptUserId == null) || (value == null) || (!value.Equals(_exceptUserId)))
				{
                    object oldValue = _exceptUserId;
					_exceptUserId = value;
					RaisePropertyChanged(WebLink.Prop_ExceptUserId, oldValue, value);
				}
			}

		}

		#endregion
	} // WebLink
}

