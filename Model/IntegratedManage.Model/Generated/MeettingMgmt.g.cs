// Business class MeettingMgmt generated from MeettingMgmt
// Creator: Ray
// Created Date: [2013-03-08]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("MeettingMgmt")]
	public partial class MeettingMgmt : IMModelBase<MeettingMgmt>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Code = "Code";
		public static string Prop_Name = "Name";
		public static string Prop_CompereId = "CompereId";
		public static string Prop_CompereName = "CompereName";
		public static string Prop_BeginTime = "BeginTime";
		public static string Prop_EndTime = "EndTime";
		public static string Prop_MeettingAdress = "MeettingAdress";
		public static string Prop_IsSendMessage = "IsSendMessage";
		public static string Prop_IsSendSMS = "IsSendSMS";
		public static string Prop_IsSendEmail = "IsSendEmail";
		public static string Prop_Remark = "Remark";
		public static string Prop_Summary = "Summary";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateDate = "CreateDate";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";
		public static string Prop_Ext4 = "Ext4";

		#endregion

		#region Private_Variables

		private string _id;
		private string _code;
		private string _name;
		private string _compereId;
		private string _compereName;
		private DateTime? _beginTime;
		private DateTime? _endTime;
		private string _meettingAdress;
		private string _isSendMessage;
		private string _isSendSMS;
		private string _isSendEmail;
		private string _remark;
		private string _summary;
		private string _createId;
		private string _createName;
		private DateTime? _createDate;
		private string _ext1;
		private string _ext2;
		private string _ext3;
		private string _ext4;


		#endregion

		#region Constructors

		public MeettingMgmt()
		{
		}

		public MeettingMgmt(
			string p_id,
			string p_code,
			string p_name,
			string p_compereId,
			string p_compereName,
			DateTime? p_beginTime,
			DateTime? p_endTime,
			string p_meettingAdress,
			string p_isSendMessage,
			string p_isSendSMS,
			string p_isSendEmail,
			string p_remark,
			string p_summary,
			string p_createId,
			string p_createName,
			DateTime? p_createDate,
			string p_ext1,
			string p_ext2,
			string p_ext3,
			string p_ext4)
		{
			_id = p_id;
			_code = p_code;
			_name = p_name;
			_compereId = p_compereId;
			_compereName = p_compereName;
			_beginTime = p_beginTime;
			_endTime = p_endTime;
			_meettingAdress = p_meettingAdress;
			_isSendMessage = p_isSendMessage;
			_isSendSMS = p_isSendSMS;
			_isSendEmail = p_isSendEmail;
			_remark = p_remark;
			_summary = p_summary;
			_createId = p_createId;
			_createName = p_createName;
			_createDate = p_createDate;
			_ext1 = p_ext1;
			_ext2 = p_ext2;
			_ext3 = p_ext3;
			_ext4 = p_ext4;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Code
		{
			get { return _code; }
			set
			{
				if ((_code == null) || (value == null) || (!value.Equals(_code)))
				{
                    object oldValue = _code;
					_code = value;
					RaisePropertyChanged(MeettingMgmt.Prop_Code, oldValue, value);
				}
			}

		}

		[Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Name
		{
			get { return _name; }
			set
			{
				if ((_name == null) || (value == null) || (!value.Equals(_name)))
				{
                    object oldValue = _name;
					_name = value;
					RaisePropertyChanged(MeettingMgmt.Prop_Name, oldValue, value);
				}
			}

		}

		[Property("CompereId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string CompereId
		{
			get { return _compereId; }
			set
			{
				if ((_compereId == null) || (value == null) || (!value.Equals(_compereId)))
				{
                    object oldValue = _compereId;
					_compereId = value;
					RaisePropertyChanged(MeettingMgmt.Prop_CompereId, oldValue, value);
				}
			}

		}

		[Property("CompereName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string CompereName
		{
			get { return _compereName; }
			set
			{
				if ((_compereName == null) || (value == null) || (!value.Equals(_compereName)))
				{
                    object oldValue = _compereName;
					_compereName = value;
					RaisePropertyChanged(MeettingMgmt.Prop_CompereName, oldValue, value);
				}
			}

		}

		[Property("BeginTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? BeginTime
		{
			get { return _beginTime; }
			set
			{
				if (value != _beginTime)
				{
                    object oldValue = _beginTime;
					_beginTime = value;
					RaisePropertyChanged(MeettingMgmt.Prop_BeginTime, oldValue, value);
				}
			}

		}

		[Property("EndTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? EndTime
		{
			get { return _endTime; }
			set
			{
				if (value != _endTime)
				{
                    object oldValue = _endTime;
					_endTime = value;
					RaisePropertyChanged(MeettingMgmt.Prop_EndTime, oldValue, value);
				}
			}

		}

		[Property("MeettingAdress", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MeettingAdress
		{
			get { return _meettingAdress; }
			set
			{
				if ((_meettingAdress == null) || (value == null) || (!value.Equals(_meettingAdress)))
				{
                    object oldValue = _meettingAdress;
					_meettingAdress = value;
					RaisePropertyChanged(MeettingMgmt.Prop_MeettingAdress, oldValue, value);
				}
			}

		}

		[Property("IsSendMessage", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string IsSendMessage
		{
			get { return _isSendMessage; }
			set
			{
				if ((_isSendMessage == null) || (value == null) || (!value.Equals(_isSendMessage)))
				{
                    object oldValue = _isSendMessage;
					_isSendMessage = value;
					RaisePropertyChanged(MeettingMgmt.Prop_IsSendMessage, oldValue, value);
				}
			}

		}

		[Property("IsSendSMS", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string IsSendSMS
		{
			get { return _isSendSMS; }
			set
			{
				if ((_isSendSMS == null) || (value == null) || (!value.Equals(_isSendSMS)))
				{
                    object oldValue = _isSendSMS;
					_isSendSMS = value;
					RaisePropertyChanged(MeettingMgmt.Prop_IsSendSMS, oldValue, value);
				}
			}

		}

		[Property("IsSendEmail", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string IsSendEmail
		{
			get { return _isSendEmail; }
			set
			{
				if ((_isSendEmail == null) || (value == null) || (!value.Equals(_isSendEmail)))
				{
                    object oldValue = _isSendEmail;
					_isSendEmail = value;
					RaisePropertyChanged(MeettingMgmt.Prop_IsSendEmail, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(MeettingMgmt.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("Summary", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string Summary
		{
			get { return _summary; }
			set
			{
				if ((_summary == null) || (value == null) || (!value.Equals(_summary)))
				{
                    object oldValue = _summary;
					_summary = value;
					RaisePropertyChanged(MeettingMgmt.Prop_Summary, oldValue, value);
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
					RaisePropertyChanged(MeettingMgmt.Prop_CreateId, oldValue, value);
				}
			}

		}

		[Property("CreateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string CreateName
		{
			get { return _createName; }
			set
			{
				if ((_createName == null) || (value == null) || (!value.Equals(_createName)))
				{
                    object oldValue = _createName;
					_createName = value;
					RaisePropertyChanged(MeettingMgmt.Prop_CreateName, oldValue, value);
				}
			}

		}

		[Property("CreateDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? CreateDate
		{
			get { return _createDate; }
			set
			{
				if (value != _createDate)
				{
                    object oldValue = _createDate;
					_createDate = value;
					RaisePropertyChanged(MeettingMgmt.Prop_CreateDate, oldValue, value);
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
					RaisePropertyChanged(MeettingMgmt.Prop_Ext1, oldValue, value);
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
					RaisePropertyChanged(MeettingMgmt.Prop_Ext2, oldValue, value);
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
					RaisePropertyChanged(MeettingMgmt.Prop_Ext3, oldValue, value);
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
					RaisePropertyChanged(MeettingMgmt.Prop_Ext4, oldValue, value);
				}
			}

		}

		#endregion
	} // MeettingMgmt
}

