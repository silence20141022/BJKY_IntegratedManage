// Business class BringUnit generated from BringUnit
// Creator: Ray
// Created Date: [2013-03-26]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("BringUnit")]
	public partial class BringUnit : IMModelBase<BringUnit>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_BringUnitName = "BringUnitName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _bringUnitName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public BringUnit()
		{
		}

		public BringUnit(
			string p_id,
			string p_bringUnitName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_bringUnitName = p_bringUnitName;
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
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("BringUnitName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string BringUnitName
		{
			get { return _bringUnitName; }
			set
			{
				if ((_bringUnitName == null) || (value == null) || (!value.Equals(_bringUnitName)))
				{
                    object oldValue = _bringUnitName;
					_bringUnitName = value;
					RaisePropertyChanged(BringUnit.Prop_BringUnitName, oldValue, value);
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
					RaisePropertyChanged(BringUnit.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(BringUnit.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(BringUnit.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // BringUnit
}

