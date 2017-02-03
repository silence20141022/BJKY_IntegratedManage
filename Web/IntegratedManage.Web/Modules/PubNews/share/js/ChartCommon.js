
//author tyaloo
//for chart construct
 var ColorScheme = "#6633FF,#FFFF00,#FF6600,#FF0000,#99CC66,#66CC00,#220088,#FFCCCC,#CCFF66,#FFFF99,#66CCFF,#CC0000,#669900,#FF9900,#333399";
 ColorScheme = ColorScheme.split(",")

 function RenderTable(ID)
 {
 
   var oContainer=document.getElementById(ID);
  if(oContainer)
  {
   var DataString= new Array();
   var tbd = oContainer.getElementsByTagName("tbody")[0];
   for(var r=0;r<tbd.rows.length;r++)
   {
    DataString[r] = new Array();
   	DataString[r][0] =  tbd.rows[r].cells[0].innerHTML;
	DataString[r][1] =  tbd.rows[r].cells[1].innerHTML;
	DataString[r] = DataString[r].join(":");
   }
   DataString = DataString.join(",");

 
   if(document.body.getBoundingClientRect){ yhWriteChart(ID,oContainer.offsetWidth,DataString);}
   else if(document.getBoxObjectFor){yhWriteBar(ID,oContainer.offsetWidth,DataString);}
	
  }

 }
 
 
 
   var K =0;
  
  function getColor()
  { 
    if(ColorScheme.length>0)
	{
     return ColorScheme.shift();
	}
	else
	{
		K+=30;
		var R = Math.ceil(K * Math.random());
		var G = Math.ceil(K * Math.random());
		var B = Math.ceil(K * Math.random());
		var C = "rgb("+R+","+G+","+B+")";
		return C;
	}
  }
  
  
  	function ChartConfig(title)
	{
		this.ChartTitle=title;
		this.Width=0;
		this.YvalueIndex=null;
		this.XName=null;
		this.XDisplayName=null;
		this.YColName=null;
		this.YDisplayName=null;
		this.SubtractCount=0;
		this.StyleTbId=null;
		this.DlPath=null;
		this.Type="chart";
		this.StatType="page";
		this.ChartDl=null;
		this.ClusterScaleWidth=100;
		this.XNameOnlyShowShortDate=false;
	
	
	}
		function ConstructReportParamSetArea(srcJcTable)
		{
		    var chartParamSetArea=document.getElementById("chartParamSetArea");
			var graphNameArea=chartParamSetArea.all("graphNameItem");
			var graphValueArea=chartParamSetArea.all("graphValueItem");

			var colRow=srcJcTable._TmplRow;
			var colDef=srcJcTable.ColDef;  
			var colcount = colDef.length;
			
			var chartDataType=srcJcTable.HtmlEle.ChartDataType;
				
			for(var j=0;j<colcount;j++)
			{	
				var def = colDef[j];
				var type=def["Type"].toLowerCase();
				if(type!="selector"&&type!="function"&type!="sn")
				{
					var colName=def["Name"];
					var colDisplayName=def["ColTitle"];
					
					if(def["ValueType"]=="number")
					{
						var graphValueSpan=document.createElement("nobr");
						checkEle=document.createElement("input");
						checkEle.id="check_"+colName;
						checkEle.dataDisplayName=colDisplayName;
						checkEle.data=colName;
						checkEle.type="checkbox";
						graphValueSpan.appendChild(checkEle);
						graphValueSpan.innerHTML+=colDisplayName;
						graphValueSpan.title=colDisplayName;
						graphValueArea.appendChild(graphValueSpan);
						if(j%5==0&&j!=0)
						{
						brEle=document.createElement("br");
						graphValueArea.appendChild(brEle);
						
						}
					}
					else if(def["ValueType"]=="title")
					{

						var graphNameSpan=document.createElement("nobr");



						var checkEle=document.createElement("input");
						checkEle.id="check_"+colName;
						checkEle.data=colName;
						checkEle.dataDisplayName=colDisplayName;
						checkEle.type="checkbox";
						graphNameSpan.appendChild(checkEle);
						graphNameSpan.innerHTML+=colDisplayName;

						graphNameArea.appendChild(graphNameSpan);

						var brEle=document.createElement("br");
						graphNameArea.appendChild(brEle);
					
					
					
					
					}
					


				}

			}
			
			
			if(chartDataType=="DB")
			{
			
			  var graphValueSpan=document.createElement("nobr");
			  var colName="System#$Count";
			  var colDisplayName="统计数目";
				checkEle=document.createElement("input");
				checkEle.id="check_"+colName;
				checkEle.dataDisplayName=colDisplayName;
				checkEle.data=colName;
				checkEle.type="checkbox";
				graphValueSpan.appendChild(checkEle);
				graphValueSpan.innerHTML+=colDisplayName;
				graphValueSpan.style.backgroundColor="blue";
				graphValueSpan.style.color="yellow";
				
				graphValueSpan.title=colDisplayName;
				graphValueArea.appendChild(graphValueSpan);
				if(j%5==0&&j!=0)
				{
				brEle=document.createElement("br");
				graphValueArea.appendChild(brEle);
				
				}
			
			
			}




		}
		
		
		
		function CreateChart()
		{
		  var chartParamSetArea=document.getElementById("chartParamSetArea");
		  var graphNameArea=chartParamSetArea.all("graphNameItem");
		  var inputArray= graphNameArea.getElementsByTagName("input"); 
		  var inputCount=inputArray.length;
		  var seleColName=new String();
		  var seleColNameDisplayName=new String();
		  for(var i=0;i<inputCount;i++)
		  {
			var seleInput=inputArray[i];
			if(seleInput.checked)
			{
			seleColName+=seleInput.data+",";
			seleColNameDisplayName+=seleInput.dataDisplayName+",";
			}
			  
			  
			}
			
			seleColName =seleColName.substr(0,seleColName.length-1); 
			seleColNameDisplayName =seleColNameDisplayName.substr(0,seleColNameDisplayName.length-1); 
			  
			  
			var graphValueArea=chartParamSetArea.all("graphValueItem");
			var inputArray= graphValueArea.getElementsByTagName("input"); 
			var inputCount=inputArray.length;
			var seleColValue=new String();
			var seleColValueDisplayName=new String();
			var hasCountStat=false; //是否统计数目
			for(var i=0;i<inputCount;i++)
		{
				var seleInput=inputArray[i];
				if(seleInput.checked)
				{
				var seleInputDate=seleInput.data;
				if(seleInputDate!="System#$Count")
				{
				seleColValue+=seleInputDate+",";
				seleColValueDisplayName+=seleInput.dataDisplayName+","; 
				}
				else
				hasCountStat=true;
				}
			  
			  
			}
			seleColValue =seleColValue.substr(0,seleColValue.length-1);
			  
			seleColValueDisplayName =seleColValueDisplayName.substr(0,seleColValueDisplayName.length-1);  
			  
			  
			  

			var chartType =chartParamSetArea.all("chartType"); 
			var colValueCount=seleColValue.length;
			var colNameCount=seleColName.length;
	          
			if((colValueCount==0||colNameCount==0)&&hasCountStat==false)
				{
				alert("必须选择统计项和统计数值!");
	             
				return;
	             
				}
	          
	          
			if(chartType[0].checked)
				chartType="bar";
			else if(chartType[1].checked)
				chartType="line";
			else 
			{
				if(seleColValue.indexOf(",")>0)
				{
				alert("生成饼图时只能选择一项统计值！");
				return;
				} 
				chartType="pie";
			}  

			 
			var chartSrcListPath=chartParamSetArea.srcListPath;
			var chartSrcList=chartParamSetArea.srcJcTable.ListData;
			var chartTitle=chartParamSetArea.srcChartTitle;
			var jcTableHtmlEle=chartParamSetArea.srcJcTableHtmlEle;
			var subtractCount=typeof(jcTableHtmlEle.SubtractCount)=="undefined"?0:jcTableHtmlEle.SubtractCount;
			var chartDataType=jcTableHtmlEle.ChartDataType;
			 
			 
			var chartSrcData;
			 
			
		if(chartDataType=="DB")
		{
				var sum_Field=new DataParam("SumField",seleColValue);
				var group_Field=new DataParam("GroupField",seleColName);
				var count_Field=new DataParam("HasCountField","false");
				
				if(hasCountStat)
				{
				 
				count_Field.SetValue("true");
				if(seleColValue!="")
				{
				seleColValue+=",System_Count";
				seleColValueDisplayName+=",个"; 
				}
				else 
				{
				seleColValue+="System_Count";
				seleColValueDisplayName+="个"; 
				}
				
				}

	            
				var rtn=Execute.Post("System_Stat",sum_Field,group_Field,count_Field);
				if(rtn.HasError)
				rtn.ShowDebug();
				else
				{
				var rtnDs=rtn.ReturnDs;
				var rtnDl=rtnDs.Lists("SYSTEMDL");
				  
				chartSrcData=rtnDl;

				   
				}    
			 
			}
			else
			{
				chartSrcData=chartSrcList;//GetDsNode(chartSrcListPath);
			       
			}
			 
			if(chartType=="pie")
			{
				DrawPieChart(chartTitle,seleColName,seleColValue,seleColNameDisplayName,seleColValueDisplayName,chartSrcData,subtractCount); 
			} 
			else
			{
				DrawBarChart(chartTitle,seleColName,seleColValue,seleColNameDisplayName,seleColValueDisplayName,chartSrcData,subtractCount,chartType)
			}
		
		}
		
		function ChartSetAreaCancel()
		{
		  //var maskLayer=document.getElementById("maskLayer");
		  //var chartParamSetArea=document.getElementById("chartParamSetArea");
		  _MaskLayer.style.display="none";
		  chartParaSetArea.style.display="none";
		
		
		
		}
		
		function DrawPieChart(chartTitle,nameColName,valueColName,nameColNameDisplay,valueColNameDisplay,chartDl,subtractCount)
		{
		
		  var mychartConfig=new ChartConfig();
	 
		  
		  with(mychartConfig)
		  {
				ChartTitle=chartTitle;
				YColName=valueColName;
				YDisplayName=valueColNameDisplay;
				XName=nameColName;
				XDisplayName=nameColNameDisplay;
				ChartDl=chartDl;
				SubtractCount=subtractCount;
				Width=500;
		  }
		  window.chartConfig=mychartConfig;
		
		  var url ="/share/page/PieStat.htm";
		  
		  
		  window.showModalDialog(url,window,"dialogHeight:800px; dialogWidth:800px;edge:Sunken; help:No; resizable:yes; status:no;scroll=no;");
		
		
		
		
		}
		
		function DrawBarChart(chartTitle,nameColName,valueColName,nameColNameDisplay,valueColNameDisplay,chartDl,subtractCount,chartType)
		{
		
  
		  var mychartConfig=new ChartConfig();
		  mychartConfig.ChartTitle=chartTitle;
		  mychartConfig.YColName=valueColName;
		  mychartConfig.XName=nameColName;
		  mychartConfig.XDisplayName=nameColNameDisplay;
		  mychartConfig.YDisplayName=valueColNameDisplay;
		  mychartConfig.SubtractCount=subtractCount;
		  mychartConfig.ChartDl=chartDl;
		  mychartConfig.Type=chartType;
		  
		  window.chartConfig=mychartConfig;
		  var url ="/share/page/ChartComon.htm";
		  
		  
		  window.showModalDialog(url,window,"dialogHeight:480px; dialogWidth:1050px;edge:Sunken; help:No; resizable:yes; status:no;scroll=no;");
		
		
		}
		
		
		function CreateChartParaSetArea(zIndex,DataSrcType)
		{
		 
		 var chartParamSetArea=document.createElement("<div id='PieChartParaArea'  style='Z-INDEX:102;LEFT:30%;POSITION:absolute;TOP:20%'></div>");
		 chartParamSetArea.id="chartParamSetArea";
		 chartParamSetArea.style.display="none";
		 if(zIndex!=null)
		   chartParamSetArea.style.zIndex=zIndex;
		 var chartSetAreaStr=" "+
			"<table cellpadding='2' width='400' class='ChartParamPanel' border='0'  style='TABLE-LAYOUT: fixed;'>"+
				"<thead>"+
					"<tr>"+
						"<td colspan='4' valign='middle'>"+
							"<font size='3' color='white'><strong>统计图表生成["+DataSrcType+"]</strong></font>"+
						"</td>"+
					"</tr>"+
					"<tr style='background-color:#0099ff;font-weight:strong;color:white'>"+
						"<td >统计项</td>"+
						"<td colspan='3'>统计项数值</td>"+
					"</tr>"+
				"</thead>"+
				"<tbody>"+
					"<tr>"+
						"<td width='25%'>"+
							"<div id='graphNameItem' style='TABLE-LAYOUT: fixed; OVERFLOW-Y: auto; OVERFLOW-X: hidden; WIDTH: 100%; HEIGHT: 200px'></div>"+
						"</td>"+
						"<td colspan='3' valign='top'>"+
							"<div id='graphValueItem' style='TABLE-LAYOUT: fixed; OVERFLOW-Y: auto; OVERFLOW-X: auto; WIDTH: 100%; HEIGHT: 200px'>"+
								
							"</div>"+
						"</td>"+
					"</tr>"+
					"<tr>"+
						"<td colspan='4'>"+
							"<INPUT type='radio' name='chartType' checked> 柱状图 <INPUT type='radio' name='chartType'> 折线图  <INPUT type='radio' name='chartType'> 饼图"+
						"</td>"+
					"</tr>"+
					"<tr align='center' height='50'>"+
						"<td colSpan='4' valign='middle'>"+
							"<button id='ButtonAdd' onclick='CreateChart();' type='button' class='jcbutton' jctype='jcbutton' IconType='graph'>"+
								"生成图表</button>&nbsp; <button  class='jcbutton' id='ButtonCancel' onclick='ChartSetAreaCancel();' type='button' jctype='jcbutton' IconType='cancel'>"+
								"取消</button>"+
						"</td>"+
					"</tr>"+
				"</tbody>"+
			"</table>";
			
			chartParamSetArea.innerHTML=chartSetAreaStr;
			document.body.appendChild(chartParamSetArea);

		return chartParamSetArea;
		
		
		}
		
		
		var _MaskLayer;
		var chartParaSetArea;
		function MakeJcTableChartAbility(srcJcTable,zIndex)
		{
		  var srcJcTableHtmlEle=srcJcTable.HtmlEle;
		  var chartDataType=srcJcTableHtmlEle.ChartDataType;
		  var dataTypeStr=new String();
		  if(chartDataType=="DB")
		     dataTypeStr ="全局";
		  else
		     dataTypeStr ="页面";
		  if(zIndex!=null)
		  { 
				_MaskLayer=CreateMaskLayer(zIndex);
				chartParaSetArea=CreateChartParaSetArea(parseInt(zIndex)+1,dataTypeStr);
		  }
		  else
		  {
				_MaskLayer=CreateMaskLayer();
				chartParaSetArea=CreateChartParaSetArea(102,dataTypeStr);
		  } 
		  chartParaSetArea.srcListPath=srcJcTableHtmlEle.ListData;
		  chartParaSetArea.srcJcTable=srcJcTable;
		  chartParaSetArea.srcChartTitle=srcJcTableHtmlEle.ChartTitle;
		   chartParaSetArea.srcJcTableHtmlEle=srcJcTableHtmlEle;
		   
		   
		   ConstructReportParamSetArea(srcJcTable);
		   
		   //<button class="jcbutton" onclick="ShowGraph()" type="button" jctype="jcbutton" IconType="graph">
		   var jcTbButtonAreaId=srcJcTableHtmlEle.ButtonAreaId;
		   var jcTbButtonArea=document.getElementById(jcTbButtonAreaId);
		   
		   var btn=document.createElement("<button class='jcbutton' jctype='jcbutton'>");
		   btn.innerText="生成统计图表";
		   var img=document.createElement("img");
		   img.src="/share/image/jsctrl/Button_graph.jpg";
		   img.style.verticalAlign="middle";
		   btn.insertBefore(img,btn.firstChild);
		   
		   btn.onclick=function()
		    {
				_MaskLayer.style.display="";
				chartParaSetArea.style.display="";
		    }
		   jcTbButtonArea.appendChild(btn);
		}
