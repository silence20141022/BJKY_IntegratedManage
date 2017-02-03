// Business class Rule_Regulation_BrowseDept generated from Rule_Regulation_BrowseDept
// Creator: Ray
// Created Date: [2013-04-13]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Rule_Regulation_BrowseDept")]
	public partial class Rule_Regulation_BrowseDept : IMModelBase<Rule_Regulation_BrowseDept>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Rule_Regulation = "Rule_Regulation";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _rule_Regulation;
		private string _deptId;
		private string _deptName;


		#endregion

		#region Constructors

		public Rule_Regulation_BrowseDept()
		{
		}

		public Rule_Regulation_BrowseDept(
			string p_id,
			string p_rule_Regulation,
			string p_deptId,
			string p_deptName)
		{
			_id = p_id;
			_rule_Regulation = p_rule_Regulation;
			_deptId = p_deptId;
			_deptName = p_deptName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Rule_Regulation", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string Rule_Regulation
		{
			get { return _rule_Regulation; }
			set
			{
				if ((_rule_Regulation == null) || (value == null) || (!value.Equals(_rule_Regulation)))
				{
                    object oldValue = _rule_Regulation;
					_rule_Regulation = value;
					RaisePropertyChanged(Rule_Regulation_BrowseDept.Prop_Rule_Regulation, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation_BrowseDept.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(Rule_Regulation_BrowseDept.Prop_DeptName, oldValue, value);
				}
			}

		}

		#endregion
	} // Rule_Regulation_BrowseDept
}

