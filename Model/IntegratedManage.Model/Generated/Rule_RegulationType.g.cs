// Business class Rule_RegulationType generated from Rule_RegulationType
// Creator: Ray
// Created Date: [2013-04-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Rule_RegulationType")]
	public partial class Rule_RegulationType : IMModelBase<Rule_RegulationType>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Code = "Code";
		public static string Prop_Name = "Name";
		public static string Prop_ParentId = "ParentId";
		public static string Prop_Path = "Path";
		public static string Prop_PathLevel = "PathLevel";
		public static string Prop_IsLeaf = "IsLeaf";

		#endregion

		#region Private_Variables

		private string _id;
		private string _code;
		private string _name;
		private string _parentId;
		private string _path;
		private int? _pathLevel;
		private bool? _isLeaf;


		#endregion

		#region Constructors

		public Rule_RegulationType()
		{
		}

		public Rule_RegulationType(
			string p_id,
			string p_code,
			string p_name,
			string p_parentId,
			string p_path,
			int? p_pathLevel,
			bool? p_isLeaf)
		{
			_id = p_id;
			_code = p_code;
			_name = p_name;
			_parentId = p_parentId;
			_path = p_path;
			_pathLevel = p_pathLevel;
			_isLeaf = p_isLeaf;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string Code
		{
			get { return _code; }
			set
			{
				if ((_code == null) || (value == null) || (!value.Equals(_code)))
				{
                    object oldValue = _code;
					_code = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_Code, oldValue, value);
				}
			}

		}

		[Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Name
		{
			get { return _name; }
			set
			{
				if ((_name == null) || (value == null) || (!value.Equals(_name)))
				{
                    object oldValue = _name;
					_name = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_Name, oldValue, value);
				}
			}

		}

		[Property("ParentId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ParentId
		{
			get { return _parentId; }
			set
			{
				if ((_parentId == null) || (value == null) || (!value.Equals(_parentId)))
				{
                    object oldValue = _parentId;
					_parentId = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_ParentId, oldValue, value);
				}
			}

		}

		[Property("Path", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string Path
		{
			get { return _path; }
			set
			{
				if ((_path == null) || (value == null) || (!value.Equals(_path)))
				{
                    object oldValue = _path;
					_path = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_Path, oldValue, value);
				}
			}

		}

		[Property("PathLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? PathLevel
		{
			get { return _pathLevel; }
			set
			{
				if (value != _pathLevel)
				{
                    object oldValue = _pathLevel;
					_pathLevel = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_PathLevel, oldValue, value);
				}
			}

		}

		[Property("IsLeaf", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public bool? IsLeaf
		{
			get { return _isLeaf; }
			set
			{
				if (value != _isLeaf)
				{
                    object oldValue = _isLeaf;
					_isLeaf = value;
					RaisePropertyChanged(Rule_RegulationType.Prop_IsLeaf, oldValue, value);
				}
			}

		}

		#endregion
	} // Rule_RegulationType
}

