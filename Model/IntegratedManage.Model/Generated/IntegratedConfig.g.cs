// Business class IntegratedConfig generated from IntegratedConfig
// Creator: Ray
// Created Date: [2013-04-11]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("IntegratedConfig")]
	public partial class IntegratedConfig : IMModelBase<IntegratedConfig>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_YuanBanZhuRenId = "YuanBanZhuRenId";
		public static string Prop_YuanBanZhuRenName = "YuanBanZhuRenName";
		public static string Prop_YuanBanWenShuId = "YuanBanWenShuId";
		public static string Prop_YuanBanWenShuName = "YuanBanWenShuName";
		public static string Prop_YuanZhangId = "YuanZhangId";
		public static string Prop_YuanZhangName = "YuanZhangName";
		public static string Prop_FirstYuanZhangId = "FirstYuanZhangId";
		public static string Prop_FirstYuanZhangName = "FirstYuanZhangName";
		public static string Prop_TypistId = "TypistId";
		public static string Prop_TypistName = "TypistName";
		public static string Prop_SealId = "SealId";
		public static string Prop_SealName = "SealName";
		public static string Prop_VedioMaintenanceId = "VedioMaintenanceId";
		public static string Prop_VedioMaintenanceName = "VedioMaintenanceName";
		public static string Prop_AddressListMaintenanceId = "AddressListMaintenanceId";
		public static string Prop_AddressListMaintenanceName = "AddressListMaintenanceName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _yuanBanZhuRenId;
		private string _yuanBanZhuRenName;
		private string _yuanBanWenShuId;
		private string _yuanBanWenShuName;
		private string _yuanZhangId;
		private string _yuanZhangName;
		private string _firstYuanZhangId;
		private string _firstYuanZhangName;
		private string _typistId;
		private string _typistName;
		private string _sealId;
		private string _sealName;
		private string _vedioMaintenanceId;
		private string _vedioMaintenanceName;
		private string _addressListMaintenanceId;
		private string _addressListMaintenanceName;


		#endregion

		#region Constructors

		public IntegratedConfig()
		{
		}

		public IntegratedConfig(
			string p_id,
			string p_yuanBanZhuRenId,
			string p_yuanBanZhuRenName,
			string p_yuanBanWenShuId,
			string p_yuanBanWenShuName,
			string p_yuanZhangId,
			string p_yuanZhangName,
			string p_firstYuanZhangId,
			string p_firstYuanZhangName,
			string p_typistId,
			string p_typistName,
			string p_sealId,
			string p_sealName,
			string p_vedioMaintenanceId,
			string p_vedioMaintenanceName,
			string p_addressListMaintenanceId,
			string p_addressListMaintenanceName)
		{
			_id = p_id;
			_yuanBanZhuRenId = p_yuanBanZhuRenId;
			_yuanBanZhuRenName = p_yuanBanZhuRenName;
			_yuanBanWenShuId = p_yuanBanWenShuId;
			_yuanBanWenShuName = p_yuanBanWenShuName;
			_yuanZhangId = p_yuanZhangId;
			_yuanZhangName = p_yuanZhangName;
			_firstYuanZhangId = p_firstYuanZhangId;
			_firstYuanZhangName = p_firstYuanZhangName;
			_typistId = p_typistId;
			_typistName = p_typistName;
			_sealId = p_sealId;
			_sealName = p_sealName;
			_vedioMaintenanceId = p_vedioMaintenanceId;
			_vedioMaintenanceName = p_vedioMaintenanceName;
			_addressListMaintenanceId = p_addressListMaintenanceId;
			_addressListMaintenanceName = p_addressListMaintenanceName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("YuanBanZhuRenId", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string YuanBanZhuRenId
		{
			get { return _yuanBanZhuRenId; }
			set
			{
				if ((_yuanBanZhuRenId == null) || (value == null) || (!value.Equals(_yuanBanZhuRenId)))
				{
                    object oldValue = _yuanBanZhuRenId;
					_yuanBanZhuRenId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_YuanBanZhuRenId, oldValue, value);
				}
			}

		}

		[Property("YuanBanZhuRenName", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string YuanBanZhuRenName
		{
			get { return _yuanBanZhuRenName; }
			set
			{
				if ((_yuanBanZhuRenName == null) || (value == null) || (!value.Equals(_yuanBanZhuRenName)))
				{
                    object oldValue = _yuanBanZhuRenName;
					_yuanBanZhuRenName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_YuanBanZhuRenName, oldValue, value);
				}
			}

		}

		[Property("YuanBanWenShuId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string YuanBanWenShuId
		{
			get { return _yuanBanWenShuId; }
			set
			{
				if ((_yuanBanWenShuId == null) || (value == null) || (!value.Equals(_yuanBanWenShuId)))
				{
                    object oldValue = _yuanBanWenShuId;
					_yuanBanWenShuId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_YuanBanWenShuId, oldValue, value);
				}
			}

		}

		[Property("YuanBanWenShuName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string YuanBanWenShuName
		{
			get { return _yuanBanWenShuName; }
			set
			{
				if ((_yuanBanWenShuName == null) || (value == null) || (!value.Equals(_yuanBanWenShuName)))
				{
                    object oldValue = _yuanBanWenShuName;
					_yuanBanWenShuName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_YuanBanWenShuName, oldValue, value);
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
					RaisePropertyChanged(IntegratedConfig.Prop_YuanZhangId, oldValue, value);
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
					RaisePropertyChanged(IntegratedConfig.Prop_YuanZhangName, oldValue, value);
				}
			}

		}

		[Property("FirstYuanZhangId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string FirstYuanZhangId
		{
			get { return _firstYuanZhangId; }
			set
			{
				if ((_firstYuanZhangId == null) || (value == null) || (!value.Equals(_firstYuanZhangId)))
				{
                    object oldValue = _firstYuanZhangId;
					_firstYuanZhangId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_FirstYuanZhangId, oldValue, value);
				}
			}

		}

		[Property("FirstYuanZhangName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string FirstYuanZhangName
		{
			get { return _firstYuanZhangName; }
			set
			{
				if ((_firstYuanZhangName == null) || (value == null) || (!value.Equals(_firstYuanZhangName)))
				{
                    object oldValue = _firstYuanZhangName;
					_firstYuanZhangName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_FirstYuanZhangName, oldValue, value);
				}
			}

		}

		[Property("TypistId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string TypistId
		{
			get { return _typistId; }
			set
			{
				if ((_typistId == null) || (value == null) || (!value.Equals(_typistId)))
				{
                    object oldValue = _typistId;
					_typistId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_TypistId, oldValue, value);
				}
			}

		}

		[Property("TypistName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string TypistName
		{
			get { return _typistName; }
			set
			{
				if ((_typistName == null) || (value == null) || (!value.Equals(_typistName)))
				{
                    object oldValue = _typistName;
					_typistName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_TypistName, oldValue, value);
				}
			}

		}

		[Property("SealId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SealId
		{
			get { return _sealId; }
			set
			{
				if ((_sealId == null) || (value == null) || (!value.Equals(_sealId)))
				{
                    object oldValue = _sealId;
					_sealId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_SealId, oldValue, value);
				}
			}

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
					RaisePropertyChanged(IntegratedConfig.Prop_SealName, oldValue, value);
				}
			}

		}

		[Property("VedioMaintenanceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string VedioMaintenanceId
		{
			get { return _vedioMaintenanceId; }
			set
			{
				if ((_vedioMaintenanceId == null) || (value == null) || (!value.Equals(_vedioMaintenanceId)))
				{
                    object oldValue = _vedioMaintenanceId;
					_vedioMaintenanceId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_VedioMaintenanceId, oldValue, value);
				}
			}

		}

		[Property("VedioMaintenanceName", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string VedioMaintenanceName
		{
			get { return _vedioMaintenanceName; }
			set
			{
				if ((_vedioMaintenanceName == null) || (value == null) || (!value.Equals(_vedioMaintenanceName)))
				{
                    object oldValue = _vedioMaintenanceName;
					_vedioMaintenanceName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_VedioMaintenanceName, oldValue, value);
				}
			}

		}

		[Property("AddressListMaintenanceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string AddressListMaintenanceId
		{
			get { return _addressListMaintenanceId; }
			set
			{
				if ((_addressListMaintenanceId == null) || (value == null) || (!value.Equals(_addressListMaintenanceId)))
				{
                    object oldValue = _addressListMaintenanceId;
					_addressListMaintenanceId = value;
					RaisePropertyChanged(IntegratedConfig.Prop_AddressListMaintenanceId, oldValue, value);
				}
			}

		}

		[Property("AddressListMaintenanceName", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string AddressListMaintenanceName
		{
			get { return _addressListMaintenanceName; }
			set
			{
				if ((_addressListMaintenanceName == null) || (value == null) || (!value.Equals(_addressListMaintenanceName)))
				{
                    object oldValue = _addressListMaintenanceName;
					_addressListMaintenanceName = value;
					RaisePropertyChanged(IntegratedConfig.Prop_AddressListMaintenanceName, oldValue, value);
				}
			}

		}

		#endregion
	} // IntegratedConfig
}

