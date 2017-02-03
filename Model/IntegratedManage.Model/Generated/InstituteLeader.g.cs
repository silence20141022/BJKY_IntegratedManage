// Business class InstituteLeader generated from InstituteLeader
// Creator: Ray
// Created Date: [2013-04-30]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("InstituteLeader")]
	public partial class InstituteLeader : IMModelBase<InstituteLeader>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_SortIndex = "SortIndex";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private string _deptId;
		private string _deptName;
		private int? _sortIndex;


		#endregion

		#region Constructors

		public InstituteLeader()
		{
		}

		public InstituteLeader(
			string p_id,
			string p_userId,
			string p_userName,
			string p_deptId,
			string p_deptName,
			int? p_sortIndex)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_sortIndex = p_sortIndex;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

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
					RaisePropertyChanged(InstituteLeader.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(InstituteLeader.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string DeptId
		{
			get { return _deptId; }
			set
			{
				if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
				{
                    object oldValue = _deptId;
					_deptId = value;
					RaisePropertyChanged(InstituteLeader.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(InstituteLeader.Prop_DeptName, oldValue, value);
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
					RaisePropertyChanged(InstituteLeader.Prop_SortIndex, oldValue, value);
				}
			}

		}

		#endregion
	} // InstituteLeader
}

