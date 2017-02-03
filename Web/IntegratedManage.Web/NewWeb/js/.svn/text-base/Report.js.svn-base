
	function GetColor(webcolor)
	{
		var wc = webcolor.replace("#","");
		var r= parseInt(wc.substr(0,2),16);
		var g= parseInt(wc.substr(2,2),16);
		var b= parseInt(wc.substr(4),16);
		return r+g*256+b*65536;
	}
	var __ExcelCtrl;
	function GetExcel(dso)
	{
		if(__ExcelCtrl==null)
			__ExcelCtrl = new ExcelCtrl(dso);
		return __ExcelCtrl;
	}
	function ExcelCtrl(dso)
	{
		this.Framer = dso;
		this.WorkBook = dso.ActiveDocument;
		this.WorkBook.WorkSheets(1).Activate();
	}
	ExcelCtrl.prototype.AddSheet=function(name)
	{
	}
	ExcelCtrl.prototype.GetSheet=function(index)
	{
		if(typeof(index)=="object")
			return new ExcelSheet(index);
		else
			return new ExcelSheet(this.WorkBook.WorkSheets(index));
	}
	ExcelCtrl.prototype.DelSheet=function(index)
	{
	}
	//设置工具条，菜单及是否允许编辑
	ExcelCtrl.prototype.SetFrame=function(editable,toolbar,menu)
	{
		
	}
	//设置Excel菜单\工具条等
	ExcelCtrl.prototype.SetEnv=function()
	{
		
	}
	ExcelCtrl.prototype.GetNames=function()
	{
		var names = this.WorkBook.Application.Names;
		var n="";
		for(var i=1;i<=names.Count;i++)
		{
			n+=names(i).Name+"  ->  "+names(i).RefersTo+"\n";
		}
		return n;
	}

	
	
	function ExcelSheet(sheet)
	{
		this.WorkSheet = sheet;
	}

	
	ExcelSheet.prototype.SetBkColor=function(rngindex,color)
	{
		var objsheet = this.WorkSheet;
		var rng = objsheet.Range(rngindex);
		rng.Interior.Color=GetColor(color);
	}
	ExcelSheet.prototype.SetColor=function(rngindex,color)
	{
		var objsheet = this.WorkSheet;
		var rng = objsheet.Range(rngindex);
		rng.Font.Color=GetColor(color);
	}
	var ExcelBorderLineStyle={"line":1,"dash":-4115,"dashdot":4,"dashdotdot":5,"dot":-4118,"double":-4119,"none":-4142,"slantdashdot":13};
	var ExcelBorderIndex={"top":8,"bottom":9,"left":7,"right":10,"diadown":5,"diaup":6,"innervert":11,"innerhorz":12};
	ExcelSheet.prototype.SetBorder=function(rngindex,linestyle,index,color)
	{
		if(!color)color="#000000";
		if(!index)
			index="bottom";
		else
			index=index.toLowerCase();
		if(!linestyle)
			linestyle="line";
		else
			linestyle=linestyle.toLowerCase();
		var objsheet = this.WorkSheet;
		var rng = objsheet.Range(rngindex);
		if(index)
		{
			rng.Borders(ExcelBorderIndex[index]).LineStyle=ExcelBorderLineStyle[linestyle];
			rng.Borders(ExcelBorderIndex[index]).Color=GetColor(color);
		}else
		{
			rng.Borders.LineStyle=ExcelBorderLineStyle[linestyle];
			rng.Borders.Color=GetColor(color);
		}
	}
	//style:Bold Italic UnderLine
	ExcelSheet.prototype.SetFont=function(rngindex,name,size,style)
	{
		var objsheet = this.WorkSheet;
		var rng = objsheet.Range(rngindex);
		if(name)
			rng.Font.Name=name;
		if(size)
			rng.Font.Size=size;
		if(style)
			rng.Font.FontStyle=style;
	}

//halign:center/left/right/
//valing:bottom/top/center
	ExcelSheet.prototype.SetAlign=function(rngindex,halign,valign)
	{
		var objsheet = this.WorkSheet;
		halign = (halign+"").toLowerCase();
		valign = (valign+"").toLowerCase();
		switch(halign)
		{
			case "left":
				objsheet.Range(rngindex).HorizontalAlignment=-4131;
				break;
			case "center":
				objsheet.Range(rngindex).HorizontalAlignment=-4108;
				break;
			case "right":
				objsheet.Range(rngindex).HorizontalAlignment=-4152;
				break;
		}
		switch(valign)
		{
			case "top":
				objsheet.Range(rngindex).VerticalAlignment=-4160;
				break;
			case "center":
				objsheet.Range(rngindex).VerticalAlignment=-4108;
				break;
			case "bottom":
				objsheet.Range(rngindex).VerticalAlignment=-4107;
				break;
		}
	}
	//Color:xxx;BkColor:xxx;Border[-index]:type,color;Font:name,size,style;
	ExcelSheet.prototype.SetStyle=function(rngindex,style)
	{
		if(!style)return;
		var sp = new StringParam(style);
		var count = sp.GetCount();
		for(var i=0;i<count;i++)
		{
			var key = sp.Keys[i].toLowerCase().trim();
			var val = sp.Values[i].trim();
			if(key=="color")
				this.SetColor(rngindex,val);
			else if(key=="bkcolor")
				this.SetBkColor(rngindex,val);
			else if(key.indexOf("border")==0)
			{
				var index=(key.length>7)?key.substr(7):null;
				var vals = val.split(",");
				if(!vals[1])vals[1]=null;
				this.SetBorder(rngindex,vals[0],index,vals[1]);
				
			}else if(key=="font")
			{
				var vals = val.split(",");
				this.SetFont(rngindex,vals[0],parseInt(vals[1]),vals[2]);
			}
		}
	}

	
	ExcelSheet.prototype.SetRange=function(rngindex,value,vtype)
	{
		var objsheet = this.WorkSheet;
		var lastcell=null;
		if(!vtype || vtype=="single")
		{	lastcell = objsheet.Range(rngindex)=value;
			return lastcell;
		}
		var rngrow = objsheet.Range(rngindex).Row;
		var rngcol = objsheet.Range(rngindex).Column;
		switch(vtype.toLowerCase())
		{
			case "horzarr":
				for(var i=0;i<value.length;i++)
					lastcell = objsheet.Cells(rngrow,rngcol+i) = value[i];
				break;
			case "vertarr":
				for(var i=0;i<value.length;i++)
					lastcell = objsheet.Cells(rngrow+i,rngcol) = value[i];
				break;
			case "horzxml":
				for(var i=0;i<value.attributes.length;i++)
					lastcell = objsheet.Cells(rngrow,rngcol+i) = value.attributes[i].nodeValue;
				break;
			case "vertxml":
				for(var i=0;i<value.attributes.length;i++)
					lastcell = objsheet.Cells(rngrow+i,rngcol) = value.attributes[i].nodeValue;
				break;
		}
		return lastcell;
	}
	ExcelSheet.prototype.SetCell=function(row,col,value)
	{
		var objsheet = this.WorkSheet;
		var lastcell = objsheet.Cell(row,col)=value;
		 return lastcell;
	}
	ExcelSheet.prototype.SetField=function(rngindex,value)
	{
		if(rngindex.charAt(0)=="_")//byname
		{
			var name = this.WorkSheet.Application.Names(rngindex);
			if(!name)alert(rngindex+" not exist!");
			this.WorkSheet.Application.Range(name.RefersTo)=value;
		}else //by excel index
		{
			return this.SetRange(rngindex,value);
		}
	}
	ExcelSheet.prototype.GetField=function(rngindex,value)
	{
		var objsheet = this.WorkSheet;
		return objsheet.Range(rngindex).value;
			
	}
	//enummap    FieldName:EnumFullName(XMLID.Enum.Name)
	ExcelSheet.prototype.SetDataForm=function(frm,enummap)
	{
		var emsp=enummap?new StringParam(enummap):null;
		var count=frm.GetItemCount();
		for(var i=0;i<count;i++)
		{
			var item = frm.GetItem(i);
			var value=item.GetValue();
			if(enummap && enummap.indexOf(atrname)>=0)
			{
				var val = emsp.Get(item.GetName());
				value = MapEnumValueToText(val,value);
			}
			this.SetField("_"+item.GetName(),value);
		}
	}
	
	ExcelSheet.prototype.SetDataList=function(rngindex,list,enummap,direction)
	{
		var objsheet = this.WorkSheet;
		var rngrow = objsheet.Range(rngindex).Row;
		var rngcol = objsheet.Range(rngindex).Column;
		if(!direction)
			direction="horz";
		else
			direction=direction.toLowerCase();
		var emsp=enummap?new StringParam(enummap):null;
		var count=list.GetItemCount();
		for(var i=0;i<count;i++)
		{
			var item = list.GetItem(i);
			var atrnum=item.GetAttrCount();
			for(var j=0;j<atrnum;j++)
			{
				var atrname=item.GetAttrName(j);
				var value=item.GetAttr(j);
				if(enummap && enummap.indexOf(atrname)>=0)
				{
					var val = emsp.Get(atrname);
					value = MapEnumValueToText(val,value);
				}
				if(direction=="horz")
					objsheet.Cells(rngrow+i,rngcol+j) = value;
				else
					objsheet.Cells(rngrow+j,rngcol+i) = value;
			}			
		}
	}
	ExcelSheet.prototype.UnMerge=function(rngindex)
	{
		var objsheet = this.WorkSheet;
		objsheet.Range(rngindex).UnMerge();
	}
	ExcelSheet.prototype.Merge=function(rngindex)
	{
		var objsheet = this.WorkSheet;
		objsheet.Range(rngindex).Merge();
	}
	ExcelSheet.prototype.Insert=function(rngindex)
	{
		var objsheet = this.WorkSheet;
		objsheet.Range(rngindex).Rows.Insert();
	}
	ExcelSheet.prototype.FormulaR1C1=function(rngindex,expression)
	{
		var objsheet = this.WorkSheet;
		objsheet.Range(rngindex).FormulaR1C1 = expression;
	}
	ExcelSheet.prototype.SaveAs=function(path)
	{
		var obj = this.WorkBook;
		obj.SaveAs(path);
	}
	ExcelSheet.prototype.Clear=function(rngindex)
	{
		var objsheet = this.WorkSheet;
		if(rngindex)
			objsheet.Range(rngindex).Clear();
		else
			objsheet.Range("1:65536").Clear();
			
	}

	ExcelSheet.prototype.DelRow=function(startRow,rowCount)
	{
		var objsheet = this.WorkSheet;
		
		for(var i=0;i<rowCount;i++)
		{
			objsheet.Rows(startRow).Delete();	
		}
	}
	
	ExcelSheet.prototype.Copy=function(rngindex)
	{
		var objsheet = this.WorkSheet;
		if(rngindex)
			objsheet.Range(rngindex).Copy();
		else
			objsheet.Range("1:65536").Copy();
			
	}
	ExcelSheet.prototype.Paste=function(rngindex,param2)
	{
		var objsheet = this.WorkSheet;
		if(rngindex)
		{	if(typeof(rngindex)=="string")
				objsheet.Range(rngindex).PasteSpecial();
			else if(typeof(rngindex)=="number")
				objsheet.Cells(rngindex,param2).PasteSpecial();
		}
		else
			objsheet.Range("A1").PasteSpecial();
			
	}
	ExcelSheet.prototype.SetActivate=function()
	{
		this.WorkSheet.Activate();
	}
	//state:auto/manual/none
	ExcelSheet.prototype.SetPageBreak=function(rngindex,state)
	{
			var objsheet = this.WorkSheet;
			if(!state || state=="manual")
				objsheet.Range(rngindex).PageBreak=-4135;
			else if(state=="none")
				objsheet.Range(rngindex).PageBreak=-4142;
			else if(state == "auto")
				objsheet.Range(rngindex).PageBreak=-4105;
	}
	
	function MapEnumValueToText(enumkey,value)
	{
		var en = GetDsNode(enumkey);
		if(!en)return value;
		return en.GetText(value);
	}
	
	ExcelSheet.prototype.InsertImage=function()
	{
	}
	
	ExcelCtrl.prototype.DetailArrange=function(datalist,srcsheet,srcrng,enummap,dessheet,desrng,col,row)
	{
		var src = this.GetSheet(srcsheet);
		var des = this.GetSheet(dessheet);
		var desrng = des.WorkSheet.Range(desrng);
		var desrngrow = desrng.Row;
		var desrngcol = desrng.Column;
		var rngwidth= src.WorkSheet.Range(srcrng).Rows.Count;
		var rngheight=src.WorkSheet.Range(srcrng).Columns.Count;
		var count=datalist.GetItemCount();
		for(var i=0;i<col;i++)
		{
			for(var j=0;j<row;j++)
			{
				var index = i*row+j;
				if(index>=count)
					return;
				var item = datalist.GetItem(i);
				var dfrm = item.ToDataForm("Detail");
				src.SetDataForm(dfrm,enummap);
				src.Copy(srcrng);
				des.Paste(desrngrow+j*rngwidth,desrngcol+i*rngheight);
			}
		}
		
	}
	
	function Test()
	{
		var e=GetExcel(oframe);
		alert(e.GetNames());
		var s1 = e.GetSheet(1);
		var s2 = e.GetSheet(2);
		/*e.SetRange(1,"A1",new Array("xxx","yy","xxx","555"),"VertArr");
		e.SetRange(1,"B1",new Array("xxx","yy","xxx","555"),"HorzArr");
		e.SetRange(1,"B1",new Array(new Array("xxx","yy","xxx","555"),new Array("xxx","yyyy","uuuu","4444")),"GridArr");
		e.SetRange(1,"A10",xmldoc.documentElement,"VertXml");
		e.SetRange(1,"B10",xmldoc.documentElement,"HorzXml");
		e.SetRange(1,"B10",xmldoc.documentElement,"GridXml");*/
		//e.SetBorder("$C$5:$F$10","line",null,"#FFFF00");
		//e.SetFont("$C$5:$F$10","黑体",20,"Bold Italic UnderLine");
		//e.SetStyle("$C$5:$F$10","Border:line,#fff000;BkColor:#FF0000;Color:#0000FF;Font:黑体,20,Bold Italic UnderLine");
		/*var dlist = new DataList( "<List Name='UserList'>"+
						"<Item Name='你' Age='23' Sex='F'></Item>"+
						"<Item Name='你' Age='23' Sex='F'></Item>"+
						"</List>");*/
		/*var dform = new DataForm( "<Form Name='UserInfo'>"+
						"<Name>1xxx0</Name>"+
						"<Age>2xxxx0</Age>"+
						"</Form>");
		e.SetDataList("A1",dlist,null,"vert");
		e.SetDataForm(dform);*/
		//e.Copy();
		//e2.Paste();
		/*e.DetailArrange(dlist,"Setting","$A$1:$B$3",null,"Form","A1",2,2);*/
	}