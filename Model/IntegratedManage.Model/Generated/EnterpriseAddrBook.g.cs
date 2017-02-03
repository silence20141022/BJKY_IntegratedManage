// Business class EnterpriseAddrBook generated from EnterpriseAddrBook
// Creator: Ray
// Created Date: [2013-03-05]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("EnterpriseAddrBook")]
	public partial class EnterpriseAddrBook : IMModelBase<EnterpriseAddrBook>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_Postion = "Postion";
		public static string Prop_PhotoId = "PhotoId";
		public static string Prop_Sex = "Sex";
		public static string Prop_OfficeEmail = "OfficeEmail";
		public static string Prop_OfficeTel = "OfficeTel";
		public static string Prop_OfficeAddr = "OfficeAddr";
		public static string Prop_PersonalTel = "PersonalTel";
		public static string Prop_IsShowPersonalTel = "IsShowPersonalTel";
		public static string Prop_PersonalAddr = "PersonalAddr";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private string _deptId;
		private string _deptName;
		private string _postion;
		private string _photoId;
		private string _sex;
		private string _officeEmail;
		private string _officeTel;
		private string _officeAddr;
		private string _personalTel;
		private string _isShowPersonalTel;
		private string _personalAddr;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public EnterpriseAddrBook()
		{
		}

		public EnterpriseAddrBook(
			string p_id,
			string p_userId,
			string p_userName,
			string p_deptId,
			string p_deptName,
			string p_postion,
			string p_photoId,
			string p_sex,
			string p_officeEmail,
			string p_officeTel,
			string p_officeAddr,
			string p_personalTel,
			string p_isShowPersonalTel,
			string p_personalAddr,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_postion = p_postion;
			_photoId = p_photoId;
			_sex = p_sex;
			_officeEmail = p_officeEmail;
			_officeTel = p_officeTel;
			_officeAddr = p_officeAddr;
			_personalTel = p_personalTel;
			_isShowPersonalTel = p_isShowPersonalTel;
			_personalAddr = p_personalAddr;
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

		[Property("UserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserId
		{
			get { return _userId; }
			set
			{
				if ((_userId == null) || (value == null) || (!value.Equals(_userId)))
				{
                    object oldValue = _userId;
					_userId = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_UserId, oldValue, value);
				}
			}

		}

		[Property("UserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserName
		{
			get { return _userName; }
			set
			{
				if ((_userName == null) || (value == null) || (!value.Equals(_userName)))
				{
                    object oldValue = _userName;
					_userName = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_UserName, oldValue, value);
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
					RaisePropertyChanged(EnterpriseAddrBook.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("Postion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 256)]
		public string Postion
		{
			get { return _postion; }
			set
			{
				if ((_postion == null) || (value == null) || (!value.Equals(_postion)))
				{
                    object oldValue = _postion;
					_postion = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_Postion, oldValue, value);
				}
			}

		}

		[Property("PhotoId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PhotoId
		{
			get { return _photoId; }
			set
			{
				if ((_photoId == null) || (value == null) || (!value.Equals(_photoId)))
				{
                    object oldValue = _photoId;
					_photoId = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_PhotoId, oldValue, value);
				}
			}

		}

		[Property("Sex", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Sex
		{
			get { return _sex; }
			set
			{
				if ((_sex == null) || (value == null) || (!value.Equals(_sex)))
				{
                    object oldValue = _sex;
					_sex = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_Sex, oldValue, value);
				}
			}

		}

		[Property("OfficeEmail", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string OfficeEmail
		{
			get { return _officeEmail; }
			set
			{
				if ((_officeEmail == null) || (value == null) || (!value.Equals(_officeEmail)))
				{
                    object oldValue = _officeEmail;
					_officeEmail = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_OfficeEmail, oldValue, value);
				}
			}

		}

		[Property("OfficeTel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string OfficeTel
		{
			get { return _officeTel; }
			set
			{
				if ((_officeTel == null) || (value == null) || (!value.Equals(_officeTel)))
				{
                    object oldValue = _officeTel;
					_officeTel = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_OfficeTel, oldValue, value);
				}
			}

		}

		[Property("OfficeAddr", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string OfficeAddr
		{
			get { return _officeAddr; }
			set
			{
				if ((_officeAddr == null) || (value == null) || (!value.Equals(_officeAddr)))
				{
                    object oldValue = _officeAddr;
					_officeAddr = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_OfficeAddr, oldValue, value);
				}
			}

		}

		[Property("PersonalTel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PersonalTel
		{
			get { return _personalTel; }
			set
			{
				if ((_personalTel == null) || (value == null) || (!value.Equals(_personalTel)))
				{
                    object oldValue = _personalTel;
					_personalTel = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_PersonalTel, oldValue, value);
				}
			}

		}

		[Property("IsShowPersonalTel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string IsShowPersonalTel
		{
			get { return _isShowPersonalTel; }
			set
			{
				if ((_isShowPersonalTel == null) || (value == null) || (!value.Equals(_isShowPersonalTel)))
				{
                    object oldValue = _isShowPersonalTel;
					_isShowPersonalTel = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_IsShowPersonalTel, oldValue, value);
				}
			}

		}

		[Property("PersonalAddr", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PersonalAddr
		{
			get { return _personalAddr; }
			set
			{
				if ((_personalAddr == null) || (value == null) || (!value.Equals(_personalAddr)))
				{
                    object oldValue = _personalAddr;
					_personalAddr = value;
					RaisePropertyChanged(EnterpriseAddrBook.Prop_PersonalAddr, oldValue, value);
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
					RaisePropertyChanged(EnterpriseAddrBook.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(EnterpriseAddrBook.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(EnterpriseAddrBook.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // EnterpriseAddrBook
}

