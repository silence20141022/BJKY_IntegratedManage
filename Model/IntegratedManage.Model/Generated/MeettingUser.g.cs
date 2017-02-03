// Business class MeettingUser generated from MeettingUser
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
	[ActiveRecord("MeettingUser")]
	public partial class MeettingUser : IMModelBase<MeettingUser>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_MeettingMgmtId = "MeettingMgmtId";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_Post = "Post";
		public static string Prop_ReMark = "ReMark";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";
		public static string Prop_Ext4 = "Ext4";

		#endregion

		#region Private_Variables

		private string _id;
		private string _meettingMgmtId;
		private string _userId;
		private string _userName;
		private string _deptId;
		private string _deptName;
		private string _post;
		private string _reMark;
		private string _ext1;
		private string _ext2;
		private string _ext3;
		private string _ext4;


		#endregion

		#region Constructors

		public MeettingUser()
		{
		}

		public MeettingUser(
			string p_id,
			string p_meettingMgmtId,
			string p_userId,
			string p_userName,
			string p_deptId,
			string p_deptName,
			string p_post,
			string p_reMark,
			string p_ext1,
			string p_ext2,
			string p_ext3,
			string p_ext4)
		{
			_id = p_id;
			_meettingMgmtId = p_meettingMgmtId;
			_userId = p_userId;
			_userName = p_userName;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_post = p_post;
			_reMark = p_reMark;
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

		[Property("MeettingMgmtId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string MeettingMgmtId
		{
			get { return _meettingMgmtId; }
			set
			{
				if ((_meettingMgmtId == null) || (value == null) || (!value.Equals(_meettingMgmtId)))
				{
                    object oldValue = _meettingMgmtId;
					_meettingMgmtId = value;
					RaisePropertyChanged(MeettingUser.Prop_MeettingMgmtId, oldValue, value);
				}
			}

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
					RaisePropertyChanged(MeettingUser.Prop_UserId, oldValue, value);
				}
			}

		}

		[Property("UserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string UserName
		{
			get { return _userName; }
			set
			{
				if ((_userName == null) || (value == null) || (!value.Equals(_userName)))
				{
                    object oldValue = _userName;
					_userName = value;
					RaisePropertyChanged(MeettingUser.Prop_UserName, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_DeptId, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("Post", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Post
		{
			get { return _post; }
			set
			{
				if ((_post == null) || (value == null) || (!value.Equals(_post)))
				{
                    object oldValue = _post;
					_post = value;
					RaisePropertyChanged(MeettingUser.Prop_Post, oldValue, value);
				}
			}

		}

		[Property("ReMark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ReMark
		{
			get { return _reMark; }
			set
			{
				if ((_reMark == null) || (value == null) || (!value.Equals(_reMark)))
				{
                    object oldValue = _reMark;
					_reMark = value;
					RaisePropertyChanged(MeettingUser.Prop_ReMark, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_Ext1, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_Ext2, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_Ext3, oldValue, value);
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
					RaisePropertyChanged(MeettingUser.Prop_Ext4, oldValue, value);
				}
			}

		}

		#endregion
	} // MeettingUser
}

