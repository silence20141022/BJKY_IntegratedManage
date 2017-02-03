// Business class MyAddressBook generated from MyAddressBook
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
	[ActiveRecord("MyAddressBook")]
	public partial class MyAddressBook : IMModelBase<MyAddressBook>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_AddrBookId = "AddrBookId";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private string _addrBookId;


		#endregion

		#region Constructors

		public MyAddressBook()
		{
		}

		public MyAddressBook(
			string p_id,
			string p_userId,
			string p_userName,
			string p_addrBookId)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_addrBookId = p_addrBookId;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
		 set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("UserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string UserId
		{
			get { return _userId; }
			set
			{
				if ((_userId == null) || (value == null) || (!value.Equals(_userId)))
				{
                    object oldValue = _userId;
					_userId = value;
					RaisePropertyChanged(MyAddressBook.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(MyAddressBook.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("AddrBookId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string AddrBookId
		{
			get { return _addrBookId; }
			set
			{
				if ((_addrBookId == null) || (value == null) || (!value.Equals(_addrBookId)))
				{
                    object oldValue = _addrBookId;
					_addrBookId = value;
					RaisePropertyChanged(MyAddressBook.Prop_AddrBookId, oldValue, value);
				}
			}

		}

		#endregion
	} // MyAddressBook
}

