// Business class Rule_Regulation_BrowseAuth generated from Rule_Regulation_BrowseAuth
// Creator: Ray
// Created Date: [2013-03-17]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Rule_Regulation_BrowseAuth")]
	public partial class Rule_Regulation_BrowseAuth : IMModelBase<Rule_Regulation_BrowseAuth>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Rule_Regulation = "Rule_Regulation";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _rule_Regulation;
		private string _userId;
		private string _userName;


		#endregion

		#region Constructors

		public Rule_Regulation_BrowseAuth()
		{
		}

		public Rule_Regulation_BrowseAuth(
			string p_id,
			string p_rule_Regulation,
			string p_userId,
			string p_userName)
		{
			_id = p_id;
			_rule_Regulation = p_rule_Regulation;
			_userId = p_userId;
			_userName = p_userName;
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
					RaisePropertyChanged(Rule_Regulation_BrowseAuth.Prop_Rule_Regulation, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation_BrowseAuth.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation_BrowseAuth.Prop_UserName, oldValue, value);
				}
			}

		}

		#endregion
	} // Rule_Regulation_BrowseAuth
}

