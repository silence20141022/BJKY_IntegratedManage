// Business class Holiday generated from Holiday
// Creator: Ray
// Created Date: [2014-05-04]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace IntegratedManage.Model
{
	[ActiveRecord("Holiday")]
	public partial class Holiday : IMModelBase<Holiday>
	{
		#region Property_Names

		public static string Prop_ID = "ID";
		public static string Prop_Year = "Year";
		public static string Prop_Date = "Date";

		#endregion

		#region Private_Variables

		private string _id;
		private string _year;
		private DateTime? _date;


		#endregion

		#region Constructors

		public Holiday()
		{
		}

		public Holiday(
			string p_id,
			string p_year,
			DateTime? p_date)
		{
			_id = p_id;
			_year = p_year;
			_date = p_date;
		}

		#endregion

		#region Properties

		[PrimaryKey("ID", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string ID
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Year", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Year
		{
			get { return _year; }
			set
			{
				if ((_year == null) || (value == null) || (!value.Equals(_year)))
				{
                    object oldValue = _year;
					_year = value;
					RaisePropertyChanged(Holiday.Prop_Year, oldValue, value);
				}
			}

		}

		[Property("Date", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? Date
		{
			get { return _date; }
			set
			{
				if (value != _date)
				{
                    object oldValue = _date;
					_date = value;
					RaisePropertyChanged(Holiday.Prop_Date, oldValue, value);
				}
			}

		}

		#endregion
	} // Holiday
}

