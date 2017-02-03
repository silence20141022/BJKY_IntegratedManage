	
	var NOPICSTR="";
	
	
	//by tyaloo
	function ChangeTextToImg()
	{
		var allInput=document.getElementsByTagName("input");
		var inputCount=allInput.length;
		for(var i=0;i<inputCount;i++)
		{
			if(allInput[i].IsImage)
		    {
		    var newImg=document.createElement("img");
		    newImg.width=100;
		    newImg.height=35;
		    newImg.src="/share/page/ShowImage.aspx?UserId="+allInput[i].value; 
		    
		    allInput[i].insertAdjacentElement("afterEnd",newImg);
		    }
		} 
	
	
	
	function ExportToHQB(DataStore,DataForm,array)
	{
	    var StartX;
		var StartY;
		var EndX;
		var EndY;
		
		if (DataForm.Type!="Form")
		{
			return false;
		}

		//创建EXCEL对象
		var xls  = new ActiveXObject( "Excel.Application" );
		
		//显示EXCEL文件窗口
		xls.visible = true;
		
		var x1Book
		//判断当前的操作模式(是新开Excel文件(NewFile),还是打开已有的Excel文件(OpenFile))
		if (DataForm.GetAttr("OperatorMode").toUpperCase()=="NEWFILE" || DataForm.GetAttr("OperatorMode").toUpperCase()=="")
		{
			x1Book = xls.Workbooks.Add;
		}
		else if (DataForm.GetAttr("OperatorMode").toUpperCase()=="OPENFILE")
		{
			//判断目标文件是否存在
			var xlsFileName = DataForm.GetAttr("FilePath") +DataForm.GetAttr("FileName");
			//获取对应的配置文件
			try
			{
				x1Book = xls.Workbooks.Open(xlsFileName);	//打开临时文件
			}
			catch(e)
			{
				alert("XML Config Info [FilePath] is Error!");
				//x1Book.Close;
				xls.visible = false;
				xls.Quit();
				return; 
			}
			
		}
		else
		{
			alert("XML Config Info [OperatorMode] is Error!");
			x1Book.Close;
			xls.visible = false;
			xls.Quit();
			return;
		}
		//判断如果文件名不为空的话，
		//	如果文件不存在的话报错
		//	如果存在的话,拷贝文件,并打开文件,然后将数据写入文件
		//如果文件名为空的话,就直接新开Excel文件

		//----------------------------------------------------------------------------
		//判断是否需要显示XML配置项中指定的Title
		if (DataForm.GetAttr("ShowTitle").toUpperCase()=="TRUE")
		{
			StartX=parseInt(DataForm.GetAttr("Title_X_Start"));
			StartY=parseInt(DataForm.GetAttr("Title_Y_Start"));
			EndX=parseInt(DataForm.GetAttr("Title_X_End"));
			EndY=parseInt(DataForm.GetAttr("Title_Y_End"));
			xls.ActiveSheet.Cells(StartY,StartX).Value = DataForm.GetAttr("Title");
			//xls.ActiveSheet.Range(xls.ActiveSheet.Cells(StartY,StartX),xls.ActiveSheet.Cells(EndY,EndX)).Select;
			//xls.Windows.Selection.Merge;
			
			if (DataForm.GetAttr("DrawLine").toUpperCase()=="TRUE")
				DrawLine(xls,Y,X);
		}
         
		//----------------------------------------------------------------------------
	
		
		//循环显示DataStore中的DataLists

		  ExportHQB(DataStore.Lists(0),array,xls);
		
		  

		
		
		//循环显示DataStore中的DataForm
		for (var i=0;i<DataStore.GetNodeCount("Form");i++)
		{
			var sheetValue = DataStore.Forms(i).GetAttr("Sheet");
			if ( sheetValue == null )
			{
			
			
				ExportExcel(DataStore.Forms(i),DataForm,xls);
			}
			else
			{
				
				CreateSheet(xls,sheetValue);
				ExportExcelEx(DataStore.Forms(i),DataForm,xls);
			}			
		}
	
	   ExportExcel(DataStore.Lists(0),DataForm,xls);
	
	
	
	}
	
	
	

	function ExportHQB(DataValue,array,xls)
	{
	    
	     var x,y;
		for(var i=0;i<DataValue.GetItemCount();i++)	//行循环
		{
		   x=parseInt(array[i][0].split(",")[0]);
		   y=parseInt(array[i][0].split(",")[1]);  
		   xls.ActiveSheet.Cells(y,x).Value=DataValue.GetItem(i).GetAttr("Major");
		   
		   x=parseInt(array[i][1].split(",")[0]);
		   y=parseInt(array[i][1].split(",")[1]);
		   
		   var topPoint=xls.ActiveSheet.Cells(y,x).Top+3;
			var picPath="http://"+window.location.host+"/share/page/ShowImage.aspx?UserId=";
				
			var pictureUrl=picPath+DataValue.GetItem(i).GetAttr("DutyId");
			var leftPoint=xls.ActiveSheet.Cells(y,x).Left+3;
			var picWidth=xls.ActiveSheet.Cells(y,x).MergeArea.Width-5;
			var picHeight=xls.ActiveSheet.Cells(y,x).MergeArea.Height-5;
			try
			{
				xls.ActiveSheet.Shapes.AddPicture(pictureUrl,0,1,leftPoint,topPoint,picWidth,picHeight);
			}
			catch(e)
			{
				xls.ActiveSheet.Cells(y,x).Value=DataValue.GetItem(i).GetAttr("DutyName");
			}
		   
		  // xls.ActiveSheet.Cells(y,x).Value=DataValue.GetItem(i).GetAttr("DutyId");
		   
		   
		   x=parseInt(array[i][2].split(",")[0]);
		   y=parseInt(array[i][2].split(",")[1]);
		   
		   xls.ActiveSheet.Cells(y,x).Value=DataValue.GetItem(i).GetAttr("FillinDate");
		  
		
		}
	
	
	
	}
	


   function ChangeToPhotoCell(seleCell,xls,Id,Name)
   {
            var topPoint=seleCell.Top+3;
			var picPath="http://"+window.location.host+"/share/page/ShowImage.aspx?UserId=";
				
			var pictureUrl=picPath+Id;
			var leftPoint=seleCell.Left+3;
			var picWidth=seleCell.MergeArea.Width-5;
			var picHeight=seleCell.MergeArea.Height-5;
			try
			{
				xls.ActiveSheet.Shapes.AddPicture(pictureUrl,0,1,leftPoint,topPoint,picWidth,picHeight);
			}
			catch(e)
			{
				seleCell.Value=Name;
			}
   
   
   }	
	
	
	
	
    function ExportForItemAndSpecialityForm(DataStore,DataForm,copyCount)
	{
		var StartX;
		var StartY;
		var EndX;
		var EndY;
		
		if (DataForm.Type!="Form")
		{
			return false;
		}

		//创建EXCEL对象
		var xls  = new ActiveXObject( "Excel.Application" );
		
		//显示EXCEL文件窗口
		xls.visible = true;
		
		var x1Book
		//判断当前的操作模式(是新开Excel文件(NewFile),还是打开已有的Excel文件(OpenFile))
		if (DataForm.GetAttr("OperatorMode").toUpperCase()=="NEWFILE" || DataForm.GetAttr("OperatorMode").toUpperCase()=="")
		{
			x1Book = xls.Workbooks.Add;
		}
		else if (DataForm.GetAttr("OperatorMode").toUpperCase()=="OPENFILE")
		{
			//判断目标文件是否存在
			var xlsFileName = DataForm.GetAttr("FilePath") +DataForm.GetAttr("FileName");
			//获取对应的配置文件
			try
			{
				x1Book = xls.Workbooks.Open(xlsFileName);	//打开临时文件
			}
			catch(e)
			{
				alert("XML Config Info [FilePath] is Error!");
				//x1Book.Close;
				xls.visible = false;
				xls.Quit();
				return; 
			}
			
		}
		else
		{
			alert("XML Config Info [OperatorMode] is Error!");
			x1Book.Close;
			xls.visible = false;
			xls.Quit();
			return;
		}
		
		
			//循环显示DataStore中的DataForm
		for (var i=0;i<DataStore.GetNodeCount("Form");i++)
		{
			var sheetValue = DataStore.Forms(i).GetAttr("Sheet");
			if ( sheetValue == null )
			{
			
			
				ExportExcel(DataStore.Forms(i),DataForm,xls);
			}
			else
			{
				
				CreateSheet(xls,sheetValue);
				ExportExcelEx(DataStore.Forms(i),DataForm,xls);
			}			
		}
		
		
		 var listCount=DataStore.GetNodeCount("List");
		 var dListSrc=new Array();
		 var noInsertListSrc=new Array();
		
		for (var i=0;i<listCount;i++)
		{
		    var dbType=DataStore.Lists(i).GetAttr("DBType");
		    
		  	if(dbType=="Special")
			{
			
			   
			   FillMajorSign(DataStore.Lists(i),xls);
			   
			
			}
			else if(dbType=="DList")
			{
			 dListSrc.push(DataStore.Lists(i));
			
			}
			else if(dbType=="NoInsertList")
			{
			
			  noInsertListSrc.push(DataStore.Lists(i));
			}
		
		}
		
		
		
		for(var cpCount=0;cpCount<copyCount;cpCount++)
		{
		    var startYPoint=38*(cpCount+1)+1;
			xls.ActiveSheet.Rows("1:38").Select;
			xls.Selection.Copy;
			
			var rows=startYPoint+":"+startYPoint;
            xls.ActiveSheet.Rows(rows).Select;
			xls.ActiveSheet.paste;
				
		
		
		}
		
		
		
		var dlistCount=dListSrc.length;
	
		for(var i=0;i<dlistCount;i++)
		 FillDoubleList(dListSrc[i],DataForm,xls);
		 
		 
		var noInserListCount=noInsertListSrc.length; 
		
		for(var i=0;i<noInserListCount;i++)
		 ExportExcel(noInsertListSrc[i],DataForm,xls);
		
		//判断如果文件名不为空的话，
		//	如果文件不存在的话报错
		//	如果存在的话,拷贝文件,并打开文件,然后将数据写入文件
		//如果文件名为空的话,就直接新开Excel文件

		//----------------------------------------------------------------------------
		//判断是否需要显示XML配置项中指定的Title
		if (DataForm.GetAttr("ShowTitle").toUpperCase()=="TRUE")
		{
			StartX=parseInt(DataForm.GetAttr("Title_X_Start"));
			StartY=parseInt(DataForm.GetAttr("Title_Y_Start"));
			EndX=parseInt(DataForm.GetAttr("Title_X_End"));
			EndY=parseInt(DataForm.GetAttr("Title_Y_End"));
			xls.ActiveSheet.Cells(StartY,StartX).Value = DataForm.GetAttr("Title");
			//xls.ActiveSheet.Range(xls.ActiveSheet.Cells(StartY,StartX),xls.ActiveSheet.Cells(EndY,EndX)).Select;
			//xls.Windows.Selection.Merge;
			
			if (DataForm.GetAttr("DrawLine").toUpperCase()=="TRUE")
				DrawLine(xls,Y,X);
		}
         
		//----------------------------------------------------------------------------
	
		

		
		
		
	

	}
	
	
	
	
	
	
	
	
	
	
	
	function Export(DataStore,DataForm)
	{
		var StartX;
		var StartY;
		var EndX;
		var EndY;
		
		if (DataForm.Type!="Form")
		{
			return false;
		}

		//创建EXCEL对象
		var xls  = new ActiveXObject( "Excel.Application" );
		
		//显示EXCEL文件窗口
		xls.visible = true;
		
		var x1Book
		//判断当前的操作模式(是新开Excel文件(NewFile),还是打开已有的Excel文件(OpenFile))
		if (DataForm.GetAttr("OperatorMode").toUpperCase()=="NEWFILE" || DataForm.GetAttr("OperatorMode").toUpperCase()=="")
		{
			x1Book = xls.Workbooks.Add;
		}
		else if (DataForm.GetAttr("OperatorMode").toUpperCase()=="OPENFILE")
		{
			//判断目标文件是否存在
			var xlsFileName = DataForm.GetAttr("FilePath") +DataForm.GetAttr("FileName");
			//获取对应的配置文件
			try
			{
				x1Book = xls.Workbooks.Open(xlsFileName);	//打开临时文件
			}
			catch(e)
			{
				alert("XML Config Info [FilePath] is Error!");
				//x1Book.Close;
				xls.visible = false;
				xls.Quit();
				return; 
			}
			
		}
		else
		{
			alert("XML Config Info [OperatorMode] is Error!");
			x1Book.Close;
			xls.visible = false;
			xls.Quit();
			return;
		}
		//判断如果文件名不为空的话，
		//	如果文件不存在的话报错
		//	如果存在的话,拷贝文件,并打开文件,然后将数据写入文件
		//如果文件名为空的话,就直接新开Excel文件

		//----------------------------------------------------------------------------
		//判断是否需要显示XML配置项中指定的Title
		if (DataForm.GetAttr("ShowTitle").toUpperCase()=="TRUE")
		{
			StartX=parseInt(DataForm.GetAttr("Title_X_Start"));
			StartY=parseInt(DataForm.GetAttr("Title_Y_Start"));
			EndX=parseInt(DataForm.GetAttr("Title_X_End"));
			EndY=parseInt(DataForm.GetAttr("Title_Y_End"));
			xls.ActiveSheet.Cells(StartY,StartX).Value = DataForm.GetAttr("Title");
			//xls.ActiveSheet.Range(xls.ActiveSheet.Cells(StartY,StartX),xls.ActiveSheet.Cells(EndY,EndX)).Select;
			//xls.Windows.Selection.Merge;
			
			if (DataForm.GetAttr("DrawLine").toUpperCase()=="TRUE")
				DrawLine(xls,Y,X);
		}
         
		//----------------------------------------------------------------------------
	
		
		//循环显示DataStore中的DataLists
		for (var i=0;i<DataStore.GetNodeCount("List");i++)
		{
			var sheetValue = DataStore.Lists(i).GetAttr("Sheet");
			
			
			//判断DATALIST是否为充分列显示，若是使用特殊方法
			if(DataStore.Lists(i).GetAttr("DBType")=="DList")
			{
			  
			   FillDoubleList(DataStore.Lists(i),DataForm,xls);
			   
			}
			else if(DataStore.Lists(i).GetAttr("DBType")=="Special")
			{
			
			
			   FillMajorSign(DataStore.Lists(i),xls);
			
			
			}
			else
			{   
			if ( sheetValue == null )
			{
			   
				ExportExcel(DataStore.Lists(i),DataForm,xls);
			}
			else
			{  
				ExportExcelEx(DataStore.Lists(i),DataForm,xls);
			}
			
			}	
			/*DataForm.SetAttr("ShowTitle","False");
			for(var j=0;j<DataForm.GetItemCount();j++)
			{
				DataForm.GetItem(j).SetAttr("DBName","Title");
				DataForm.GetItem(j).SetAttr("Value_Y",parseInt(DataForm.GetItem(j).GetAttr("Value_Y"))+1);
				DataForm.GetItem(j).SetAttr("ShowName","False");
			}*/
		}
		
		
		//循环显示DataStore中的DataForm
		for (var i=0;i<DataStore.GetNodeCount("Form");i++)
		{
			var sheetValue = DataStore.Forms(i).GetAttr("Sheet");
			if ( sheetValue == null )
			{
			
			
				ExportExcel(DataStore.Forms(i),DataForm,xls);
			}
			else
			{
				
				CreateSheet(xls,sheetValue);
				ExportExcelEx(DataStore.Forms(i),DataForm,xls);
			}			
		}

	}

  function ExportMultiColList(DataForm,DataValue,xls)
  {

        var j =0;
		var isfind = false;
		
		for(j=0;j<DataForm.GetItemCount();j++)	//列循环
		{
			if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
			{
				isfind = true;
				break;
			}
		}
		
		if(isfind)

        {
		    var start_x =parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
		    var start_y =parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
		    var repeate_x=parseInt(DataForm.GetItem(j).GetAttr("Repeat_X"));
		    var templateRowCoordinate="A"+start_y+":AZ"+start_y;
		    var dataItemCount=DataValue.GetItemCount();
		    
		    
		    
            if(dataItemCount>0&&dataItemCount<3)
		     xls.ActiveSheet.Range(templateRowCoordinate).Delete;		    
		    else if(dataItemCount>3)
		      xls.ActiveSheet.Range(templateRowCoordinate).Copy;

		    else
		    {
             xls.ActiveSheet.Range(templateRowCoordinate).Delete;
             xls.ActiveSheet.Range(templateRowCoordinate).Delete;
            }
		    

		        var lastRowCol= dataItemCount%repeate_x;
				for(n=0,m=0;n<dataItemCount;n++,m++)
				{
			        
			    
					
			        
					var newY=start_y+m;
	                
					
					if(n>0&&n<dataItemCount-3)
					{
					
					var newP = "A"+newY+":AZ"+newY;
					xls.ActiveSheet.Range(newP).Rows.Insert;
						
					xls.ActiveSheet.Range(newP).paste;
					}

					ChangeToPhotoCell(xls.ActiveSheet.Cells(start_y,start_x),xls,DataValue.GetItem(n).GetAttr("OwnerUserId"),DataValue.GetItem(n).GetAttr("OwnerUserName"));
					
					xls.ActiveSheet.Cells(start_y,start_x+2).Value=DataValue.GetItem(n).GetAttr("FinishTime");
					
					
					
					if(n>dataItemCount-3&&lastRowCol==2)
					{
						
						ChangeToPhotoCell(xls.ActiveSheet.Cells(start_y,start_x+4),xls,DataValue.GetItem(n+1).GetAttr("OwnerUserId"),DataValue.GetItem(n+1).GetAttr("OwnerUserName"));
						xls.ActiveSheet.Cells(start_y,start_x+5).Value=DataValue.GetItem(n+1).GetAttr("FinishTime");
						xls.ActiveSheet.Cells(start_y,start_x+6).Value="";
						xls.ActiveSheet.Cells(start_y,start_x+7).Value="";


			        }
			        else if(n>dataItemCount-3&&lastRowCol==1)
			        {
			            xls.ActiveSheet.Cells(start_y,start_x+4).Value="";
						xls.ActiveSheet.Cells(start_y,start_x+5).Value="";
						xls.ActiveSheet.Cells(start_y,start_x+6).Value="";
						xls.ActiveSheet.Cells(start_y,start_x+7).Value="";

			            
			        }
			        else
			        {
			            
						ChangeToPhotoCell(xls.ActiveSheet.Cells(start_y,start_x+4),xls,DataValue.GetItem(n+1).GetAttr("OwnerUserId"),DataValue.GetItem(n+1).GetAttr("OwnerUserName"));

						xls.ActiveSheet.Cells(start_y,start_x+5).Value=DataValue.GetItem(n+1).GetAttr("FinishTime");
						
						ChangeToPhotoCell(xls.ActiveSheet.Cells(start_y,start_x+6),xls,DataValue.GetItem(n+2).GetAttr("OwnerUserId"),DataValue.GetItem(n+2).GetAttr("OwnerUserName"));
						xls.ActiveSheet.Cells(start_y,start_x+7).Value=DataValue.GetItem(n+2).GetAttr("FinishTime");

			        }
			    

			        start_y +=1;
					n+=2;

				}
		                     
		                
	 }				
  
  }




	function ExportExcel(DataValue,DataForm,xls)
	{
		var X;
		var Y;
		var FieldName;
		
		switch (DataValue.Type)
		{
		
			case "List":
				//导出表头
				//导出数据【支持DataList，DataForm】
				for(var i=0;i<DataForm.GetItemCount();i++)
				{
					//判断当前字段格式对应的数据源是否和当前数据源一致
					if (DataForm.GetItem(i).GetAttr("DBName")==DataValue.GetAttr("Name"))
					{
						//判断是否需要显示XML配置项中的Filed
						if (DataForm.GetItem(i).GetAttr("ShowName")=="True")
						{
							//填入数据
							X=parseInt(DataForm.GetItem(i).GetAttr("Name_X"));
							Y=parseInt(DataForm.GetItem(i).GetAttr("Name_Y"));
							//获得Sheet的值
							var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							if ( isNaN(sheetValue) )
								xls.Sheets(sheetValue).Select;
							else
								xls.Sheets(parseInt(sheetValue)).Select;
							xls.ActiveSheet.Cells(Y,X).Value = DataForm.GetItem(i).GetAttr("Name");
							
							//判断是否需要画边框
							if (DataForm.GetItem(i).GetAttr("DrawLine")=="True")
								DrawLine(xls,Y,X);
						}
					}
				 }
				var value_y;
				
				
				
				
				
				//循环填入数据(列表方式)
                var dbType=DataValue.GetAttr("DBType");
               
                if(dbType=="multiColList")
                {
                 ExportMultiColList(DataForm,DataValue,xls);
                 break;
                
                }
                var listTotalCount= DataValue.GetItemCount();
                
                
     

				for(var i=0;i<listTotalCount;i++)	//行循环
				{
					var j =0;
					var isfind = false;
					
					for(j=0;j<DataForm.GetItemCount();j++)	//列循环
					{
						if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
						{
							isfind = true;
							break;
						}
					}
					
					if(isfind)
					{
					
					
		              
						if(dbType!="NoInsertList")
						{   
						
							var oldp = "A"+DataForm.GetItem(j).GetAttr("Value_Y")+":AZ"+DataForm.GetItem(j).GetAttr("Value_Y");
							 xls.ActiveSheet.Range(oldp).Copy;
							 //xls.ActiveSheet.Range(oldp).PasteSpecial(-4122);
				
							var value_x =DataForm.GetItem(j).GetAttr("Value_X");
							
							value_y = parseInt(DataForm.GetItem(j).GetAttr("Value_Y"))+i;
							var p = "A"+value_y+":AZ"+value_y;
							
							if(i>0)
							{
							var seleRange=xls.ActiveSheet.Range(p);
							seleRange.Rows.Insert;
							
							seleRange.paste;
				
							}
						}
						//xls.ActiveSheet.Range(p).RowHeight=30;
						
						
						for(var j=0;j<DataForm.GetItemCount();j++)	//列循环
						{
							//判断当前字段格式对应的数据源是否和当前数据源一致
							
							if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
							{
							
								X=parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
								var stepX = DataForm.GetItem(j).GetAttr("Step_X");
								if (DataForm.GetItem(j).GetAttr("Change_X")=="+")
								{
									X+=stepX*i;
								}
								else if(DataForm.GetItem(j).GetAttr("Change_X")=="-")
								{
									X-=stepX*i;
								}
								Y=parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
								var stepY = DataForm.GetItem(j).GetAttr("Step_Y");
								if (DataForm.GetItem(j).GetAttr("Change_Y")=="+")
								{
									Y+=stepY*i;
								}
								else if(DataForm.GetItem(j).GetAttr("Change_Y")=="-")
								{
									Y-=stepY*i;
								}
								//填入数据
								FieldName=DataForm.GetItem(j).GetAttr("Value");
								var Type= DataForm.GetItem(j).GetAttr("Type");
								
								//获得Sheet的值
								var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							
								if(sheetValue==null)
								{
									sheetValue = 1;
								}
								if ( isNaN(sheetValue) )
									xls.Sheets(sheetValue).Select;
								else
									xls.Sheets(parseInt(sheetValue)).Select;
								
								if(Type=="Photo")
								{
									var topPoint=xls.ActiveSheet.Cells(Y,X).Top+3;
									var picPath="http://"+window.location.host+"/share/page/ShowImage.aspx?UserId=";
									//
									var pictureUrl=picPath+DataValue.GetValue(i,FieldName);
									var leftPoint=xls.ActiveSheet.Cells(Y,X).Left+3;
									var picWidth=xls.ActiveSheet.Cells(Y,X).MergeArea.Width-5;
									var picHeight=xls.ActiveSheet.Cells(Y,X).MergeArea.Height;
									try
									{
									
									  
					
										xls.ActiveSheet.Shapes.AddPicture(pictureUrl,true,true,leftPoint,topPoint,picWidth,picHeight);
                                                                                //change by yc 2007-4-24
                                                                                 var picName = DataValue.GetValue(i,FieldName);
                                                                                var cellname = "+Y+" + "+x+";
                                                                                xls.ActiveSheet.Shapes(picName).Top = Range(cellname).Top + (Range(cellname).Height-xls.ActiveSheet.Shapes(picName).Height)/2
                                                                                xls.ActiveSheet.Shapes(picName).Left = Range(cellname).Left+(Range(cellname).Width - xls.ActiveSheet.Shapes(picName).Width) / 2
									}
									catch(e)
									{
									   xls.ActiveSheet.Cells(Y,X).Value=NOPICSTR;
									}
								}	
								else
										
									xls.ActiveSheet.Cells(Y,X).Value = DataValue.GetItem(i).GetAttr(FieldName);
								
	  
								if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
									DrawLine(xls,Y,X);
							}
						}
					}	
				}
				value_y = value_y+1;
				var p = "A"+value_y+":Z"+value_y;
			
				break;
			case "Form":
			   
				for(var j=0;j<DataForm.GetItemCount();j++)	//列循环
				{
					//判断当前字段格式对应的数据源是否和当前数据源一致
					//alert(DataForm.GetItem(j).GetAttr("DBName")+"-----"+DataValue.GetAttr("Name"));
			
					if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
					{
						//处理字段名称
						//判断是否需要显示XML配置项中的Filed
						
						if (DataForm.GetItem(j).GetAttr("ShowName")=="True")
						{ 
							//填入数据
							X=parseInt(DataForm.GetItem(j).GetAttr("Name_X"));
							Y=parseInt(DataForm.GetItem(j).GetAttr("Name_Y"));
							//获得Sheet的值
							
							var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							
							if ( isNaN(sheetValue) )
								xls.Sheets(sheetValue).Select;
							else
								xls.Sheets(parseInt(sheetValue)).Select;
							
							xls.ActiveSheet.Cells(Y,X).Value = DataForm.GetItem(j).GetAttr("Name");

							//判断是否需要画边框
							if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
								DrawLine(xls,Y,X);
						}

						//处理字段的值
						//填入数据
						X=parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
						Y=parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
						FieldName=DataForm.GetItem(j).GetAttr("Value");
						var Type= DataForm.GetItem(j).GetAttr("Type")
						
						
					//	alert(DataValue.GetValue(FieldName));
					//	alert(DataForm.GetItem(j).ToString())
						//获得Sheet的值
						var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
						if(sheetValue==null)
						{
							sheetValue =1;
						}
						
						if ( isNaN(sheetValue) )
						{
							xls.Sheets(sheetValue).Select;
							
						}
						else
						{
							
						
							xls.Sheets(parseInt(sheetValue)).Select;
							
						}
						
						//alert(X+","+Y+" "+DataValue.GetValue(FieldName));
						if(Type=="Photo")
						{
							var topPoint=xls.ActiveSheet.Cells(Y,X).Top+3;
							var picPath="http://"+window.location.host+"/share/page/ShowImage.aspx?UserId=";
							 
							var pictureUrl=picPath+DataValue.GetValue(FieldName);
							var leftPoint=xls.ActiveSheet.Cells(Y,X).Left+3;
							var picWidth=xls.ActiveSheet.Cells(Y,X).MergeArea.Width-5;
							var picHeight=xls.ActiveSheet.Cells(Y,X).MergeArea.Height-5;
						 try
						 {
                                                       xls.ActiveSheet.Shapes.AddPicture(pictureUrl,true,true,leftPoint,topPoint,picWidth,picHeight);
                                                       //change by yc 2007-4-24
                                                       var picName = DataValue.GetValue(i,FieldName);
                                                       var cellname = "+Y+" + "+x+";
                                                       xls.ActiveSheet.Shapes(picName).Top = Range(cellname).Top + (Range(cellname).Height-xls.ActiveSheet.Shapes(picName).Height)/2
                                                       xls.ActiveSheet.Shapes(picName).Left = Range(cellname).Left+(Range(cellname).Width - xls.ActiveSheet.Shapes(picName).Width) / 2
                                                       
						 }
						 catch(e)
						 {
						   xls.ActiveSheet.Cells(Y,X).Value=NOPICSTR;
						 }
						}
						else
							xls.ActiveSheet.Cells(Y,X).Value = DataValue.GetValue(FieldName);
						
						//判断是否需要画边框
						if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
							DrawLine(xls,Y,X);
					}
				}
				
				break;
				
				
		
		}
	}
	
	function ExportExcelEx(DataValue,DataForm,xls)
	{
		var X;
		var Y;
		var FieldName;
		
		switch (DataValue.Type)
		{
			case "List":
				//导出表头
				//导出数据【支持DataList，DataForm】
				for(var i=0;i<DataForm.GetItemCount();i++)
				{
					//判断当前字段格式对应的数据源是否和当前数据源一致
					if (DataForm.GetItem(i).GetAttr("DBName")==DataValue.GetAttr("Name"))
					{
						//判断是否需要显示XML配置项中的Filed
						if (DataForm.GetItem(i).GetAttr("ShowName")=="True")
						{
							//填入数据
							X=parseInt(DataForm.GetItem(i).GetAttr("Name_X"));
							Y=parseInt(DataForm.GetItem(i).GetAttr("Name_Y"));
							//获得Sheet的值
							var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							if ( isNaN(sheetValue) )
								xls.Sheets(sheetValue).Select;
							else
								xls.Sheets(parseInt(sheetValue)).Select;
							xls.ActiveSheet.Cells(Y,X).Value = DataForm.GetItem(i).GetAttr("Name");
							
							//判断是否需要画边框
							if (DataForm.GetItem(i).GetAttr("DrawLine")=="True")
								DrawLine(xls,Y,X);
						}
					}
				}
				//循环填入数据(列表方式)
				for(var i=0;i<DataValue.GetItemCount();i++)	//行循环
				{
					for(var j=0;j<DataForm.GetItemCount();j++)	//列循环
					{
						//判断当前字段格式对应的数据源是否和当前数据源一致
						if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
						{
							X=parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
							var stepX = DataForm.GetItem(j).GetAttr("Step_X");
							if (DataForm.GetItem(j).GetAttr("Change_X")=="+")
							{
								X+=stepX*i;
							}
							else if(DataForm.GetItem(j).GetAttr("Change_X")=="-")
							{
								X-=stepX*i;
							}
							Y=parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
							var stepY = DataForm.GetItem(j).GetAttr("Step_Y");
							if (DataForm.GetItem(j).GetAttr("Change_Y")=="+")
							{
								Y+=stepY*i;
							}
							else if(DataForm.GetItem(j).GetAttr("Change_Y")=="-")
							{
								Y-=stepY*i;
							}
							//填入数据
							FieldName=DataForm.GetItem(j).GetAttr("Value");
							//获得Sheet的值
							var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							if ( isNaN(sheetValue) )
								xls.Sheets(sheetValue).Select;
							else
								xls.Sheets(parseInt(sheetValue)).Select;
							xls.ActiveSheet.Cells(Y,X).Value = DataValue.GetItem(i).GetAttr(FieldName);

							//判断是否需要画边框
							if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
								DrawLine(xls,Y,X);
						}
					}
				}
				break;
			case "Form":
				for(var j=0;j<DataForm.GetItemCount();j++)	//列循环
				{
					//判断当前字段格式对应的数据源是否和当前数据源一致
					if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
					{
						//处理字段名称
						//判断是否需要显示XML配置项中的Filed
						if (DataForm.GetItem(j).GetAttr("ShowName")=="True")
						{
							//填入数据
							X=parseInt(DataForm.GetItem(j).GetAttr("Name_X"));
							Y=parseInt(DataForm.GetItem(j).GetAttr("Name_Y"));
							//获得Sheet的值
							var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
							if ( isNaN(sheetValue) )
								xls.Sheets(sheetValue).Select;
							else
								xls.Sheets(parseInt(sheetValue)).Select;
							xls.ActiveSheet.Cells(Y,X).Value = DataForm.GetItem(j).GetAttr("Name");

							//判断是否需要画边框
							if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
								DrawLine(xls,Y,X);
						}

						//处理字段的值
						//填入数据
						X=parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
						Y=parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
						FieldName=DataForm.GetItem(j).GetAttr("Value");
						
						//获得Sheet的值
						xls.ActiveSheet.Cells(Y,X).Value = DataValue.GetValue(FieldName);
						
						//判断是否需要画边框
						if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
							DrawLine(xls,Y,X);
					}
				}
				break;
		}
	}
	
	//为指定单元格绘制边框
	function DrawLine(xls,Y,X)
	{
		xls.ActiveSheet.Cells(Y,X).Borders(4).LineStyle = 1
		xls.ActiveSheet.Cells(Y,X).Borders(1).LineStyle = 1
		xls.ActiveSheet.Cells(Y,X).Borders(2).LineStyle = 1
		xls.ActiveSheet.Cells(Y,X).Borders(3).LineStyle = 1	
	}
	
	function CreateSheet(xls,sheet)
	{
		//如果Sheet不存在则创建Sheet by Dino 2006-07-13
		//var sheetValue = DataForm.GetAttr("Sheet");
		var sheetObject = null;
		if ( sheet != null )
		{
			if ( isNaN(sheet) )
			{
				for ( var i = 1; i <= xls.Sheets.Count; i++ )
				{
					if ( xls.Sheets(i).Name.toLowerCase() == sheet.toLowerCase() )
					{
						sheetObject = xls.Sheets(sheet);
						break;
					}
				}
			}
			else
			{
				if ( parseInt(sheet) <= xls.Sheets.Count )
					sheetObject = xls.Sheets(parseInt(sheet));
			}
			if ( sheetObject == null )
			{
				//sheetObject = xls.Sheets(1);
				sheetObject = xls.Sheets(xls.Sheets.Count);
				sheetObject.Copy(null,sheetObject);
				sheetObject = xls.Sheets(xls.Sheets.Count);
				sheetObject.Name = sheet;
			}
			sheetObject.Select;
		}
	}
	
	
	
	
	
	
	function FillDoubleList(DataValue,DataForm,xls)
	{

        
		var value_y;
				
		//循环填入数据(列表方式)
		var listWidth=12;
		var listMAXRows=19;

        var listTotalCount=DataValue.GetItemCount();	
		
		var listMulti=Math.ceil(listTotalCount/listMAXRows);
  
                    
                   
		for(var i=0;i<listTotalCount;i++)	//行循环
		{
			var j =0;
			for(j=0;j<DataForm.GetItemCount();j++)	//列循环
			{
				if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
				{
					break;
				}
			}
            
			
			for(var j=0;j<DataForm.GetItemCount();j++)	//列循环
			{
				//判断当前字段格式对应的数据源是否和当前数据源一致
				//alert(DataForm.GetItem(j).GetAttr("DBName")+"-----"+DataValue.GetAttr("Name"))
				
				if (DataForm.GetItem(j).GetAttr("DBName")==DataValue.GetAttr("Name"))
				{
					
					X=parseInt(DataForm.GetItem(j).GetAttr("Value_X"));
					
					var stepX = DataForm.GetItem(j).GetAttr("Step_X");
					if (DataForm.GetItem(j).GetAttr("Change_X")=="+")
					{
						X+=stepX*i;
					}
					else if(DataForm.GetItem(j).GetAttr("Change_X")=="-")
					{
						X-=stepX*i;
					}
					Y=parseInt(DataForm.GetItem(j).GetAttr("Value_Y"));
					var stepY = DataForm.GetItem(j).GetAttr("Step_Y");
					if (DataForm.GetItem(j).GetAttr("Change_Y")=="+")
					{
						Y+=stepY*i;
					}
					else if(DataForm.GetItem(j).GetAttr("Change_Y")=="-")
					{
						Y-=stepY*i;
					}
					//填入数据
					FieldName=DataForm.GetItem(j).GetAttr("Value");
					
					//获得Sheet的值
					
					var sheetValue = DataForm.GetItem(j).GetAttr("Sheet");
					if(sheetValue==null)
					{
						sheetValue = 1;
					}
					if ( isNaN(sheetValue) )
						xls.Sheets(sheetValue).Select;
					else
						xls.Sheets(parseInt(sheetValue)).Select;
					if(Math.ceil(i/listMAXRows)>1)
					   {
					    X+=parseInt(DataForm.GetItem(j).GetAttr("Step_X"));
					    Y-=listMAXRows+1;
					   }
					   
					   
					xls.ActiveSheet.Cells(Y,X).Value = DataValue.GetItem(i).GetAttr(FieldName);
					

					if (DataForm.GetItem(j).GetAttr("DrawLine")=="True")
						DrawLine(xls,Y,X);
				}
			}
			
		}
		value_y = value_y+1;
		var p = "A"+value_y+":Z"+value_y;
		
	
	
	
	
	
	}
	
	
	function FillMajorSign(DataValue,xls)
	{
			
		var value_y;
		//循环填入数据(列表方式)

        var step_x=0;
        var step_y=0;
        var xLength=4;
		for(var i=0;i<DataValue.GetItemCount();i++)	//行循环
		{
			var tmpY=step_y;
			if(i>=12)//因为每行只可以牵四条数据，但到了第三行的时候可以牵五条。所以做了判断（专业协作计划表）
			{
				if(i>=13)
					step_y=4
				else
					step_y=3
			}
			else
				step_y=Math.ceil((i+1)/xLength);
			if(step_y-tmpY>=1)
			 {
			   step_x=0; 		
		       if(step_y>2)
		      {
		        step_x=-5; 
		      }
		    }
		    
		    
		    var picPath="http://"+window.location.host+"/share/page/ShowImage.aspx?UserId=";
						 
			var pictureUrl=picPath+DataValue.GetItem(i).GetAttr("OwnerUserId");
			//var pictureUrl="C:\\Documents and Settings\\Administrator\\My Documents\\chucuo1.JPG";
			var topPoint=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).Top+3;
			var leftPoint=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).Left+3;
			var picWidth=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).MergeArea.Width-3;
			var picHeight=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).MergeArea.Height-3;
			try
			{
			xls.ActiveSheet.Shapes.AddPicture(pictureUrl,0,1,leftPoint,topPoint,picWidth,picHeight);
			}
			catch(e)
			{
			
			}
		   // xls.ActiveSheet.Cells(29+step_y-1,21+step_x).Value = DataValue.GetItem(i).GetAttr("OwnerUserId");
            step_x+=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).MergeArea.Count;
            
            xls.ActiveSheet.Cells(29+step_y-1,21+step_x).Value =  ","+DataValue.GetItem(i).GetAttr("FinishTime");
            
            step_x+=xls.ActiveSheet.Cells(29+step_y-1,21+step_x).MergeArea.Count; 
              
					
				
		
			
		}
		
	
	
	
	}