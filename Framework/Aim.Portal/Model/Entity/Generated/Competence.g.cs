// Business class Competence generated from Competence
// Creator: Ray
// Created Date: [2013-03-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace Portal.Model
{
	[ActiveRecord("Competence")]
    public partial class Competence : EntityBase<Competence>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_PId = "PId";
		public static string Prop_PName = "PName";
		public static string Prop_Type = "Type";
		public static string Prop_Ext1 = "Ext1";
		public static string Prop_Ext2 = "Ext2";
		public static string Prop_Ext3 = "Ext3";

		#endregion

		#region Private_Variables

		private string _id;
		private string _pId;
		private string _pName;
		private string _type;
		private string _ext1;
		private string _ext2;
		private string _ext3;


		#endregion

		#region Constructors

		public Competence()
		{
		}

		public Competence(
			string p_id,
			string p_pId,
			string p_pName,
			string p_type,
			string p_ext1,
			string p_ext2,
			string p_ext3)
		{
			_id = p_id;
			_pId = p_pId;
			_pName = p_pName;
			_type = p_type;
			_ext1 = p_ext1;
			_ext2 = p_ext2;
			_ext3 = p_ext3;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("PId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PId
		{
			get { return _pId; }
			set
			{
				if ((_pId == null) || (value == null) || (!value.Equals(_pId)))
				{
                    object oldValue = _pId;
					_pId = value;
					RaisePropertyChanged(Competence.Prop_PId, oldValue, value);
				}
			}

		}

		[Property("PName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string PName
		{
			get { return _pName; }
			set
			{
				if ((_pName == null) || (value == null) || (!value.Equals(_pName)))
				{
                    object oldValue = _pName;
					_pName = value;
					RaisePropertyChanged(Competence.Prop_PName, oldValue, value);
				}
			}

		}

		[Property("Type", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 60)]
		public string Type
		{
			get { return _type; }
			set
			{
				if ((_type == null) || (value == null) || (!value.Equals(_type)))
				{
                    object oldValue = _type;
					_type = value;
					RaisePropertyChanged(Competence.Prop_Type, oldValue, value);
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
					RaisePropertyChanged(Competence.Prop_Ext1, oldValue, value);
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
					RaisePropertyChanged(Competence.Prop_Ext2, oldValue, value);
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
					RaisePropertyChanged(Competence.Prop_Ext3, oldValue, value);
				}
			}

		}

		#endregion
	} // Competence
}

