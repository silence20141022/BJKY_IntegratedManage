// Business class Rule_Regulation generated from Rule_Regulation
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
	[ActiveRecord("Rule_Regulation")]
	public partial class Rule_Regulation : IMModelBase<Rule_Regulation>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Code = "Code";
		public static string Prop_Name = "Name";
		public static string Prop_KeyWord = "KeyWord";
		public static string Prop_Summary = "Summary";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_AuthType = "AuthType";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_LastModifyId = "LastModifyId";
		public static string Prop_LastModifyName = "LastModifyName";
		public static string Prop_LastModifyTime = "LastModifyTime";
		public static string Prop_Files = "Files";
		public static string Prop_ReleaseState = "ReleaseState";
		public static string Prop_ReleaseId = "ReleaseId";
		public static string Prop_ReleaseName = "ReleaseName";
		public static string Prop_ReleaseTime = "ReleaseTime";
		public static string Prop_State = "State";
		public static string Prop_Flag = "Flag";
		public static string Prop_WorkFlowState = "WorkFlowState";
		public static string Prop_WorkFlowResult = "WorkFlowResult";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";
		public static string Prop_Ext4 = "Ext4";

		#endregion

		#region Private_Variables

		private string _id;
		private string _code;
		private string _name;
		private string _keyWord;
		private string _summary;
		private string _deptId;
		private string _deptName;
		private string _authType;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _lastModifyId;
		private string _lastModifyName;
		private DateTime? _lastModifyTime;
		private string _files;
		private string _releaseState;
		private string _releaseId;
		private string _releaseName;
		private DateTime? _releaseTime;
		private string _state;
		private string _flag;
		private string _workFlowState;
		private string _workFlowResult;
		private string _ext1;
		private string _ext2;
		private string _ext3;
		private string _ext4;


		#endregion

		#region Constructors

		public Rule_Regulation()
		{
		}

		public Rule_Regulation(
			string p_id,
			string p_code,
			string p_name,
			string p_keyWord,
			string p_summary,
			string p_deptId,
			string p_deptName,
			string p_authType,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_lastModifyId,
			string p_lastModifyName,
			DateTime? p_lastModifyTime,
			string p_files,
			string p_releaseState,
			string p_releaseId,
			string p_releaseName,
			DateTime? p_releaseTime,
			string p_state,
			string p_flag,
			string p_workFlowState,
			string p_workFlowResult,
			string p_ext1,
			string p_ext2,
			string p_ext3,
			string p_ext4)
		{
			_id = p_id;
			_code = p_code;
			_name = p_name;
			_keyWord = p_keyWord;
			_summary = p_summary;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_authType = p_authType;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_lastModifyId = p_lastModifyId;
			_lastModifyName = p_lastModifyName;
			_lastModifyTime = p_lastModifyTime;
			_files = p_files;
			_releaseState = p_releaseState;
			_releaseId = p_releaseId;
			_releaseName = p_releaseName;
			_releaseTime = p_releaseTime;
			_state = p_state;
			_flag = p_flag;
			_workFlowState = p_workFlowState;
			_workFlowResult = p_workFlowResult;
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

		[Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Code
		{
			get { return _code; }
			set
			{
				if ((_code == null) || (value == null) || (!value.Equals(_code)))
				{
                    object oldValue = _code;
					_code = value;
					RaisePropertyChanged(Rule_Regulation.Prop_Code, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_Name, oldValue, value);
				}
			}

		}

		[Property("KeyWord", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string KeyWord
		{
			get { return _keyWord; }
			set
			{
				if ((_keyWord == null) || (value == null) || (!value.Equals(_keyWord)))
				{
                    object oldValue = _keyWord;
					_keyWord = value;
					RaisePropertyChanged(Rule_Regulation.Prop_KeyWord, oldValue, value);
				}
			}

		}

		[Property("Summary", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Summary
		{
			get { return _summary; }
			set
			{
				if ((_summary == null) || (value == null) || (!value.Equals(_summary)))
				{
                    object oldValue = _summary;
					_summary = value;
					RaisePropertyChanged(Rule_Regulation.Prop_Summary, oldValue, value);
				}
			}

		}

		[Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 7400)]
		public string DeptId
		{
			get { return _deptId; }
			set
			{
				if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
				{
                    object oldValue = _deptId;
					_deptId = value;
					RaisePropertyChanged(Rule_Regulation.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 4000)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(Rule_Regulation.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("AuthType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string AuthType
		{
			get { return _authType; }
			set
			{
				if ((_authType == null) || (value == null) || (!value.Equals(_authType)))
				{
                    object oldValue = _authType;
					_authType = value;
					RaisePropertyChanged(Rule_Regulation.Prop_AuthType, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("LastModifyId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string LastModifyId
		{
			get { return _lastModifyId; }
			set
			{
				if ((_lastModifyId == null) || (value == null) || (!value.Equals(_lastModifyId)))
				{
                    object oldValue = _lastModifyId;
					_lastModifyId = value;
					RaisePropertyChanged(Rule_Regulation.Prop_LastModifyId, oldValue, value);
				}
			}

		}

		[Property("LastModifyName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string LastModifyName
		{
			get { return _lastModifyName; }
			set
			{
				if ((_lastModifyName == null) || (value == null) || (!value.Equals(_lastModifyName)))
				{
                    object oldValue = _lastModifyName;
					_lastModifyName = value;
					RaisePropertyChanged(Rule_Regulation.Prop_LastModifyName, oldValue, value);
				}
			}

		}

		[Property("LastModifyTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? LastModifyTime
		{
			get { return _lastModifyTime; }
			set
			{
				if (value != _lastModifyTime)
				{
                    object oldValue = _lastModifyTime;
					_lastModifyTime = value;
					RaisePropertyChanged(Rule_Regulation.Prop_LastModifyTime, oldValue, value);
				}
			}

		}

		[Property("Files", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string Files
		{
			get { return _files; }
			set
			{
				if ((_files == null) || (value == null) || (!value.Equals(_files)))
				{
                    object oldValue = _files;
					_files = value;
					RaisePropertyChanged(Rule_Regulation.Prop_Files, oldValue, value);
				}
			}

		}

		[Property("ReleaseState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ReleaseState
		{
			get { return _releaseState; }
			set
			{
				if ((_releaseState == null) || (value == null) || (!value.Equals(_releaseState)))
				{
                    object oldValue = _releaseState;
					_releaseState = value;
					RaisePropertyChanged(Rule_Regulation.Prop_ReleaseState, oldValue, value);
				}
			}

		}

		[Property("ReleaseId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ReleaseId
		{
			get { return _releaseId; }
			set
			{
				if ((_releaseId == null) || (value == null) || (!value.Equals(_releaseId)))
				{
                    object oldValue = _releaseId;
					_releaseId = value;
					RaisePropertyChanged(Rule_Regulation.Prop_ReleaseId, oldValue, value);
				}
			}

		}

		[Property("ReleaseName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string ReleaseName
		{
			get { return _releaseName; }
			set
			{
				if ((_releaseName == null) || (value == null) || (!value.Equals(_releaseName)))
				{
                    object oldValue = _releaseName;
					_releaseName = value;
					RaisePropertyChanged(Rule_Regulation.Prop_ReleaseName, oldValue, value);
				}
			}

		}

		[Property("ReleaseTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ReleaseTime
		{
			get { return _releaseTime; }
			set
			{
				if (value != _releaseTime)
				{
                    object oldValue = _releaseTime;
					_releaseTime = value;
					RaisePropertyChanged(Rule_Regulation.Prop_ReleaseTime, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(Rule_Regulation.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Flag", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string Flag
		{
			get { return _flag; }
			set
			{
				if ((_flag == null) || (value == null) || (!value.Equals(_flag)))
				{
                    object oldValue = _flag;
					_flag = value;
					RaisePropertyChanged(Rule_Regulation.Prop_Flag, oldValue, value);
				}
			}

		}

		[Property("WorkFlowState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
		public string WorkFlowState
		{
			get { return _workFlowState; }
			set
			{
				if ((_workFlowState == null) || (value == null) || (!value.Equals(_workFlowState)))
				{
                    object oldValue = _workFlowState;
					_workFlowState = value;
					RaisePropertyChanged(Rule_Regulation.Prop_WorkFlowState, oldValue, value);
				}
			}

		}

		[Property("WorkFlowResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string WorkFlowResult
		{
			get { return _workFlowResult; }
			set
			{
				if ((_workFlowResult == null) || (value == null) || (!value.Equals(_workFlowResult)))
				{
                    object oldValue = _workFlowResult;
					_workFlowResult = value;
					RaisePropertyChanged(Rule_Regulation.Prop_WorkFlowResult, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_Ext1, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_Ext2, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_Ext3, oldValue, value);
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
					RaisePropertyChanged(Rule_Regulation.Prop_Ext4, oldValue, value);
				}
			}

		}

		#endregion
	} // Rule_Regulation
}

