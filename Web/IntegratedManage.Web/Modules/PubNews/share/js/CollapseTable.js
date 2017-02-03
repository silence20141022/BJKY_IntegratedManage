/***********************************************************

   author:tyaloo
   create Date:2007-10-01
   modify date:2008-5-1
   version:1.00
***************************************************************/



Date.prototype.toShortDateString=function()
                                {
                                  return this.getFullYear()+"-"+(this.getMonth()+1)+"-"+this.getDate();
                                }
                                
//获得当前日期是一年中的第几天,从0起                                
Date.prototype.GetYearDaysNum=function()
                               {
                                 var yearFirstDate=new Date(this.getFullYear(),0,1);
                                 
                                 var holeDayMilliseconds=86400000;
                                 var betweenDays  =  parseInt(Math.abs(this  -  yearFirstDate)  /holeDayMilliseconds);    //把相差的毫秒数转换为天数
                                 return betweenDays;
                               
                               } 
                               
                               
//获得当前日期是一季度中的第几天,从0起                                
Date.prototype.GetQuarterDaysNum=function()
                               {
                                 
                                 
                                var holeDayMilliseconds=86400000;
                                var nowMonth=this.getMonth();
                                var quarterFirstDate; 
                                if(nowMonth>=0&&nowMonth<=2)
								{
								  
							       quarterFirstDate=new Date(this.getFullYear(),0,1);
								}
								else if(nowMonth>=3&&nowMonth<=5)
								{
						
						          quarterFirstDate=new Date(this.getFullYear(),3,1);
								} 
								else if(nowMonth>=6&&nowMonth<=8)
								{
				                  quarterFirstDate=new Date(this.getFullYear(),6,1);
								} 
								else if(nowMonth>=9)
								{
			                       quarterFirstDate=new Date(this.getFullYear(),9,1);
								} 
                                var betweenDays  =  parseInt(Math.abs(this  -  quarterFirstDate)  /holeDayMilliseconds);    //把相差的毫秒数转换为天数
                                return betweenDays;
                               
                               }                                                                     
                                      
//获得当前月总共有多少天
Date.prototype.GetMonthDays=function()
   
				{
				 var y=this.getFullYear();
				 var m=this.getMonth();
				var solarMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
                var febDays=((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 29: 28; 
					if(m==1)
						return febDays; 
					else
						return solarMonth[m];
				}




Date.GetYearDays=function(y)

				{
				var totalDay=((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 366: 365;
					

				return totalDay;
				}

Date.GetMonthDays=function(y,m)
   
				{
				var solarMonth=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
                var febDays=((y%4 == 0) && (y%100 != 0) || (y%400 == 0))? 29: 28; 
				if(m==1)
					return febDays; 
				else
					return solarMonth[m];
				}




  




//计算天数差的函数，通用  
   function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2002-12-18格式  
       var  aDate,  oDate1,  oDate2,  iDays  
       aDate  =  sDate1.split("-")  
       oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])    //转换为12-18-2002格式  
       aDate  =  sDate2.split("-")  
       oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0])  
       iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /86400000)    //把相差的毫秒数转换为天数  
       return  iDays  
   } 
   
   
   
   //根据起始和结束日期获得甘特图表示HTML
   function  GetGanttchartByDate(sDate,  eDate,ganttType){    //sDate和eDate是2002-12-18格式  
       var  dateArray,  startDate,  endDate;  
       var startWeek,endWeek;
       var rtnArray=new Array();
       var weekTemplate=document.getElementById("weekTemplate");
       dateArray  =  sDate.split("-");  
       startDate  =  new  Date(dateArray[1]  +  '-'  +  dateArray[2]  +  '-'  +  dateArray[0]);    //转换为12-18-2002格式  
       startWeek=startDate.getDay();
        
       
       dateArray  =  eDate.split("-");  
       endDate  =  new  Date(dateArray[1]  +  '-'  +  dateArray[2]  +  '-'  +  dateArray[0]);  
       endWeek=endDate.getDay();
       
       
       var holeDayMilliseconds=86400000;
       var betweenDays  =  parseInt(Math.abs(startDate  -  endDate)  /holeDayMilliseconds);    //把相差的毫秒数转换为天数
       
       var totalWidth=0;
       switch(ganttType)
       {
         case "year":
			var startYear=startDate.getFullYear();
			var endYear=endDate.getFullYear();
			var yearBetweenCount=endYear-startYear+1;
			var rtnHTML="<table height='100%' cellpadding =0 cellspacing =0 border=0><tr>";
			weekTemplate.height = weekTemplate.scrollHeight;
			weekTemplate.deleteRow(1);
			for(var i=0;i<yearBetweenCount;i++)
			{
			var tbwidth=Date.GetYearDays(startYear)*0.3;
	        weekTemplate.width= tbwidth+"px";   
	        totalWidth+=tbwidth;   
			weekTemplate.rows[0].cells[0].innerHTML=startYear+"年";
	           
			rtnHTML+= "<td>"+weekTemplate.outerHTML+"</td>";
			startYear +=1;
	         
			}
			rtnHTML =rtnHTML+"</tr></table>";
					
			rtnArray.push(rtnHTML);
			rtnArray.push(totalWidth);
         
         break;
         case "halfYear":
      	    var startYear=startDate.getFullYear();
			var endYear=endDate.getFullYear();
			var yearBetweenCount=endYear-startYear+1;
			var startMonth=startDate.getMonth();
			var endMonth=endDate.getMonth();
            
            var startHalfYear;
            var endHalfYear;
            var startIndex=0;
		    var halfYearCount=yearBetweenCount*2;
			
			if(startMonth<6)
			{
			  startHalfYear='上半年';
			}
			else
			{
			 startHalfYear='下半年';
			 startIndex=1;
			} 
			
			if(endMonth<6)
			{
			  endHalfYear='上半年';
			  halfYearCount-=1;
			}
			else
			 endHalfYear='下半年';
			
         
			

			
			
			var rtnHTML="<table height='100%' cellpadding =0 cellspacing =0 border=0><tr>";
			weekTemplate.height = weekTemplate.scrollHeight;
			weekTemplate.deleteRow(1);
			for(var h=startIndex;h<halfYearCount;h++)
			{
			    
				weekTemplate.rows[0].cells[0].innerHTML=startYear+startHalfYear;

				rtnHTML+= "<td>"+weekTemplate.outerHTML+"</td>";
				

                
				if(h%2!=2)
				{
					if(startHalfYear=="上半年")
					  startHalfYear="下半年";
					else
					{
					    startHalfYear="上半年";
						startYear+=1;
					}
				}

			
			}
         
            rtnHTML =rtnHTML+"</tr></table>";
			
			rtnArray.push(rtnHTML);
			if(startIndex>0)
			 halfYearCount=halfYearCount-startIndex;
			rtnArray.push(halfYearCount*105);
         break;
         case "quarter":
            var startYear=startDate.getFullYear();
			var endYear=endDate.getFullYear();
			var yearBetweenCount=endYear-startYear+1;
			var startMonth=startDate.getMonth();
			var endMonth=endDate.getMonth();
            
            var startQuarter;
            var endQuarter;
            var startIndex=0;
		    var quarterCount=yearBetweenCount*4;
			
			if(startMonth>=0&&startMonth<=2)
			{
			  startQuarter='第一季度';
			}
			else if(startMonth>=3&&startMonth<=5)
			{
			 startQuarter='第二季度';
			 startIndex=1;
			} 
			else if(startMonth>=6&&startMonth<=8)
			{
			 startQuarter='第三季度';
			 startIndex=2;
			} 
			else if(startMonth>=9)
			{
			 startQuarter='第四季度';
			 startIndex=3;
			} 
			
			if(endMonth>=0&&endMonth<=2)
			{
			  endQuarter='第一季度';
			  quarterCount-=3;
			}
			else if(endMonth>=3&&endMonth<=5)
			{
			 endQuarter='第二季度';
			 quarterCount-=2;
			} 
			else if(endMonth>=6&&endMonth<=8)
			{
			 endQuarter='第三季度';
			 quarterCount-=1;
			} 
			else if(endMonth>=9)
			{
			 endQuarter='第四季度';
			 
			} 
			
           
			

			
			
			var rtnHTML="<table height='100%' cellpadding =0 cellspacing =0 border=0><tr>";
			weekTemplate.height = weekTemplate.scrollHeight;
			weekTemplate.deleteRow(1);
			for(var h=startIndex;h<quarterCount;h++)
			{
			    
				weekTemplate.rows[0].cells[0].innerHTML=startYear+startQuarter;

				rtnHTML+= "<td>"+weekTemplate.outerHTML+"</td>";
			    if(h%4!=4)
			    {
					if(startQuarter=="第一季度")
					startQuarter="第二季度";
				     
					else if(startQuarter=="第二季度")
					startQuarter="第三季度";
					else if(startQuarter=="第三季度")
					startQuarter="第四季度";
					else if(startQuarter=="第四季度")
					{
					startQuarter="第一季度";
					startYear+=1;
				       
					} 
			    
			    }  	
               
			
			}
         
            rtnHTML =rtnHTML+"</tr></table>";
			
			rtnArray.push(rtnHTML);
			
			if(startIndex>0)
			 quarterCount=quarterCount-startIndex;
			
			rtnArray.push(quarterCount*105);
           
         break;
         case "month":
			var startYear=startDate.getFullYear();
			var endYear=endDate.getFullYear();
			var yearBetweenCount=endYear-startYear;
			var startMonth=startDate.getMonth();
			var endMonth=endDate.getMonth();
			var monthBetweenCount=endMonth-startMonth;
			var totalMonthCount=yearBetweenCount *12+monthBetweenCount+1;
			var rtnHTML="<table height='100%' cellpadding =0 cellspacing =0 border=0><tr>";
			weekTemplate.height = weekTemplate.scrollHeight;
			weekTemplate.deleteRow(1);
			var totalWidth=0;
			for(var m=0;m<totalMonthCount;m++)
			{
			  
				weekTemplate.rows[0].cells[0].innerHTML=startYear+"年"+(startMonth+1)+"月";
		        var tbWidth=Date.GetMonthDays(startYear,startMonth)*4;
		        weekTemplate.width =tbWidth+"px";
		        totalWidth+= tbWidth;  
				rtnHTML+= "<td>"+weekTemplate.outerHTML+"</td>";
				
				startMonth +=1;
				if(startMonth==12)
				{
				startMonth =0;
				startYear +=1;
				}
			
			}
         
            rtnHTML =rtnHTML+"</tr></table>";
			
			rtnArray.push(rtnHTML);
			rtnArray.push(totalWidth);
         
         
         break;
         case "week":
				var allWeekDays =startWeek +betweenDays +(7-endWeek);
		       
		       
				startDate=new Date(startDate.getTime()-startWeek*holeDayMilliseconds);

				var weekCount=allWeekDays/7;
				var rtnHTML="<table height='100%' cellpadding =0 cellspacing =0 border=0><tr>";
				
				for(var n=0;n<weekCount;n++)
				{
					weekTemplate.rows[0].cells[0].innerHTML=startDate.toShortDateString();
					rtnHTML+= "<td>"+weekTemplate.outerHTML+"</td>";
					startDate=new Date(startDate.getTime()+7*holeDayMilliseconds);
			       
				}
			         
				rtnHTML =rtnHTML+"</tr></table>";
				
				rtnArray.push(rtnHTML);
				rtnArray.push(allWeekDays*15);
         break;
         default:
         break;
         
       
       
       }
       
       return rtnArray;
       
         
   }  
   
   
      //根据起始和结束日期获得甘特图进度条
   function  GetGanttProgressBartByDate(sDate,eDate,ganttType){    //sDate和eDate是2002-12-18格式  
       var  dateArray,  startDate,  endDate;  
       var startWeek,endWeek;
       
       var holeDayMilliseconds=86400000;
       dateArray  =  sDate.split("-");  
       startDate  =  new  Date(dateArray[1]  +  '-'  +  dateArray[2]  +  '-'  +  dateArray[0]);    //转换为12-18-2002格式  
       startWeek=startDate.getDay();
        
       
       dateArray  =  eDate.split("-");  
       endDate  =  new  Date(dateArray[1]  +  '-'  +  dateArray[2]  +  '-'  +  dateArray[0]);  
       endWeek=endDate.getDay();
       
       var betweenDays  =  parseInt(Math.abs(startDate  -  endDate)  /holeDayMilliseconds);    //把相差的毫秒数转换为天数
       
       
       var spanLeft=0;
       var spanLength=0;
       
       
       switch(ganttType)
       {
         case "year":
        
             spanLeft=startDate.GetYearDaysNum()*0.3;
             spanLength =betweenDays*0.3;
         
         break;
         case "halfYear":
              spanLeft=startDate.GetYearDaysNum()*(105/365);
             spanLength =betweenDays*(210/365);
         break;
         case "quarter":
             spanLeft=startDate.GetQuarterDaysNum()*(105/92);
             spanLength =betweenDays*(420/365);
         break;
         case "month":
             spanLeft=Math.ceil(4*startDate.getDate());
             spanLength =Math.ceil(4*(betweenDays));
         break;
         case "week":
		       spanLeft=startWeek*15;
               spanLength=(betweenDays+1)*15;		
         break;
         default:
         break;
         
       
       
       } 
       
       
        var progressSpan=document.createElement("span");
        progressSpan.style.left="0px";   
        progressSpan.style.width="100%";   
        progressSpan.style.position="relative";
        progressSpan.style.top="0px";
        progressSpan.style.height="100%";
        
        var progressSpanChild=document.createElement("span");
        progressSpanChild.style.backgroundColor="yellow"; 
        progressSpanChild.style.left=spanLeft+"px";   
        progressSpanChild.style.width=spanLength+"px";   
        progressSpanChild.style.position="relative";
        progressSpanChild.style.height="80%";
        progressSpanChild.style.top="10%";
        progressSpanChild.style.border="black 1px solid";
        
        progressSpan.appendChild(progressSpanChild);
           
      
       return progressSpan;
         
   }   



var pList=null;
var globalTemplateTable;
var gType="";
try
{
gType=GetQueryString("gType");
}
catch(e)
{
gType ="week";
}





function CollapseTable(ctEle,treeImgPath,prjTypeImgPath) {
 
 
 this.TreeImagesPath = treeImgPath;
 this.HTMLEle = ctEle;
 this.PrjTypeImagesPath = prjTypeImgPath;
 this.DataSource = GetDsNode(ctEle.DataSource);
 
 this.HTMLEle.oncontextmenu=this.OnContextmenu;
 //var ganttSort=document.getElementById("ganttSort");
 //ganttSort.value =gType;
 
 
}

CollapseTable.prototype.Init=function()
{

  
 this.DataSource.XmlDoc.async =true; 
 this.DataSource.XmlDoc.setProperty("SelectionLanguage", "XPath");  


 var pcol=this.DataSource.GetItems("Item[string-length(@FullId)<=8]");
 
  if(pcol[0]==null)  return ;

 var templateRow=this.HTMLEle.firstChild.tHead.rows[0];
 var cellCount=templateRow.cells.length;
    
    for(var cellIndex=1;cellIndex <cellCount;cellIndex++)
    {
		var nowCell=templateRow.cells[cellIndex];
		var cellType=nowCell.cellType;
		
		if(!cellType)
		cellType="normal";

		 //nowCell.innerHTML="";   

		switch(cellType)
		{
		case "Gantt":
                          var titleCellArray=GetGanttchartByDate("2006-1-30","2008-8-11",gType);
                          nowCell.width=titleCellArray[1];
                          globalTemplateTable=this.HTMLEle.firstChild.cloneNode(true);
                          nowCell.innerHTML=titleCellArray[0];
			break;

		default:
                  globalTemplateTable=this.HTMLEle.firstChild.cloneNode(true);
		break;     
		
		}
    
    }
  
  

  var childHolder=document.createElement("div");
  childHolder.id="h"+this.HTMLEle.id;

  this.HTMLEle.appendChild(childHolder); 
  
  var colCount=pcol.length-1;
  if(colCount<0)
    return;
    
   for(i=0;i<colCount;i++) 
   {
    

     this.TableCreater(pcol[i],childHolder.id,false); 
     
   
   }

   var lastDiv = this.TableCreater(pcol[colCount],childHolder.id,true);
    var buttomLine = document.createElement("div");
    buttomLine.style.borderTop="black 1px solid";
    
    var buttomLineWidth = lastDiv.firstChild.firstChild.clientWidth;
    buttomLineWidth = buttomLineWidth -0;
    //alert(buttomLineWidth);
    buttomLine.style.width = buttomLineWidth+"px";
     buttomLine.style.height ="1px"; 
    lastDiv.appendChild(buttomLine);
    



}


CollapseTable.prototype.OnContextmenu = function()
{
  
  return false;



}



CollapseTable.prototype.TableCreater=function(xmlNode,divId,IsLast)
{

	if(xmlNode==null || divId==null)
		return false;
   
   
   var nowcollapseTb = this;   
   var nowDiv=document.getElementById(divId); 
   var parentNode=nowDiv.parentNode;
   var parentNId=parentNode.Id;
   var parentId=divId.substr(1,(divId.length-1));
   if(parentId!=this.HTMLEle.id)
    {
     
      var parentDiv=document.getElementById(parentId); 
     
   } 
 
   var child=document.createElement("div");
    child.IsLast=IsLast;
    
    child.id=xmlNode.GetAttr("FullId");
    child.name=xmlNode.GetAttr("Name");
 
    //获取模板
    var templateTable=globalTemplateTable.cloneNode(true);
    var newRow=templateTable.rows[0];
    
    var type=xmlNode.GetAttr("Type");
    newRow.className=type;
    
	var tmpDivId=divId.replace(/\./,"");
   
	var space=tmpDivId.length/8;
    
    var befix = ".gif";
     
    /*
    if(type.indexOf("Task")>0)
	{
		befix = ".ico";
	}
	*/
	
	var spaceSpan=document.createElement("span");
	spaceSpan.style.width=space*20;
	var spaceLeftImg,spaceRightImg;
	 if(IsLast==false)
	 {
	  spaceLeftImg="Line.gif";
	  spaceRightImg="MN.gif";
	 }
	 else
	 {
	  spaceLeftImg="Line.gif";
	  spaceRightImg="LN.gif";
	 
	 }
	
	for(var spaceIndex=0;spaceIndex<space;spaceIndex++)
	{
	  var spaceImg=document.createElement("img");
	  spaceImg.height='20';
	  spaceImg.width='20';
	  if(spaceIndex==0)
	    spaceImg.src= this.TreeImagesPath + "" + "Null.gif";
	  else if(spaceIndex<space-2)
	   {
              
	       spaceImg.src= this.TreeImagesPath + "" + spaceLeftImg;    
	  
           }
           else if(spaceIndex>=space-2&&spaceIndex<space-1)
            {
              if(parentDiv.IsLast&&IsLast)
                spaceImg.src= this.TreeImagesPath + "" + "Null.gif";
              else
               spaceImg.src= this.TreeImagesPath + "" + spaceLeftImg; 
            }
          else
	  spaceImg.src= this.TreeImagesPath + "" + spaceRightImg;
	 
	  spaceSpan.appendChild(spaceImg);
	
	} 
	
	
	
	
			                    
	  var typeImg=document.createElement("img");
	  typeImg.height='20';
	  typeImg.width='20';
	  typeImg.src= this.PrjTypeImagesPath + type + befix ;
	  
	  
	  var img=document.createElement("img");
	  img.id= child.id;
	  img.title= child.name;
	  img.height='20';
	  img.width='20';
	  img.border='0';
	  img.iconType=type;
	  img.name='close';
	  img.src= this.TreeImagesPath +"/FC.gif";

      img.onclick=function(){
                             ExpandCollapse(img,nowcollapseTb);
                            }
    newRow.img = img;
    newRow.cells[0].innerText="";
    
    var taskInfoCell=document.createElement("nobr"); 
    taskInfoCell.insertBefore(spaceSpan);
    if(type!="DesignTask")
    taskInfoCell.insertBefore(img);
    taskInfoCell.insertBefore(typeImg);
    
    
    var nodeId=xmlNode.GetAttr("Id");
    var nodePrjId=xmlNode.GetAttr("PrjId");
    var nodeName=xmlNode.GetAttr(newRow.cells[0].name);
    if(type=="DesignTask")
    {
      var workLink=document.createElement("a");
      var href="PrjProductList.aspx?pathId="+child.id;

      workLink.href="#";
      workLink.onclick=function()
                       {
                        window.open(href,"_blank","height=400,width=600,status=yes,toolbar=no,menubar=no,location=no");
                       }
      workLink.innerText=nodeName;
      taskInfoCell.insertBefore(workLink);
    
    
    }
    else 
    {
    
    typeImg.insertAdjacentText("afterEnd",nodeName);
    }
    newRow.cells[0].insertBefore(taskInfoCell);

    newRow.onmouseover=OnRowMouseover;
                              
    newRow.onmouseout=OnRowMouseout;
                           
    newRow.onclick=function()
                            {
                              if(nowcollapseTb.HTMLEle.seleRow==this) 
                                return ;
                              else if(nowcollapseTb.HTMLEle.seleRow!=null) 
                               {
                                  nowcollapseTb.HTMLEle.seleRow.onmouseout = OnRowMouseout;
                                  nowcollapseTb.HTMLEle.seleRow.style.backgroundColor=this.lastBgColor;


	                          nowcollapseTb.HTMLEle.seleRow.style.color=this.lastColor;

                                }  
                              if(this.onmouseout!=null)
                                this.onmouseout=null;
                              else
                                 this.onmouseout=OnRowMouseout;
                              nowcollapseTb.HTMLEle.seleRow = this;
                            }
    newRow.ondblclick=function()
                             {
                            
                               if(this.img)
                                  this.img.click();
 
                             
                             
                             }
    newRow.style.cursor="hand";        
    

    var cellCount=newRow.cells.length;
    
    for(var cellIndex=1;cellIndex <cellCount;cellIndex++)
    {
		var nowCell=newRow.cells[cellIndex];
		var cellType=nowCell.cellType;
		var cellName=nowCell.name;
		if(!cellType)
		cellType="normal";
		 nowCell.innerHTML="";   

		switch(cellType)
		{
		case "Gantt":
			var GanttStartDate=xmlNode.GetAttr(nowCell.GanttStartDate);
			var GanttEndDate=xmlNode.GetAttr(nowCell.GanttEndDate);
			var GanttBar=GetGanttProgressBartByDate(GanttStartDate,GanttEndDate,gType);
			
			nowCell.vAlign="top";
			nowCell.appendChild(GanttBar);
			break;
		case "normal":
			if(cellName)
				nowCell.innerText=xmlNode.GetAttr(cellName);
				else
				nowCell.innerText="";
			break; 
		default:
		break;     
		
		}
    
    }
    
    child.appendChild(templateTable); 
    nowDiv.appendChild(child);


   return nowDiv;


}






CollapseTable.prototype.ExpandTreeNodeByType=function(nodeType)
{
	var imgs=this.HTMLEle.getElementsByTagName("img");
	imgs[0].click();
	imgs=document.getElementsByTagName("img");  
	for(i=0;i<imgs.length;i++)
	{
		if(imgs[i].name=="close")
		{
			if(imgs[i].iconType!=null && imgs[i].iconType!=nodeType)
			imgs[i].click();
		}
	}
}


function ExpandCollapse(eventSrc,collapseTb)
{


       //获取母容器ID 
		//var nid=eventSrc.title;
		var nid=eventSrc.id;

		var state=eventSrc.name;

	   //根据母容器ID获得,第一子容器ID	
		var childDiv=document.getElementById("h"+nid); 




		if(state=="close")
		{

		   
			if(childDiv==null)
			ExpandCreater(nid,collapseTb);
			else
			childDiv.style.display="";     
		 
		   
			eventSrc.name="open";
			eventSrc.src=collapseTb.TreeImagesPath + "FE.gif";
		}

		else if(state=="open")
		{

		childDiv.style.display="none";
		eventSrc.name="close";
		eventSrc.src=collapseTb.TreeImagesPath + "FC.gif";

		}
		     
 



}



function ExpandCreater(nid,collapseTb)
{

 var nowDiv=document.getElementById(nid); 
 var idLen=nid.length+9;
 var xpathStr="Item[contains(@FullId,'"+nid+"') and string-length(@FullId)="+idLen+"]";
  var pcol=collapseTb.DataSource.GetItems(xpathStr); 
    
   var childHolder=document.createElement("div");
   childHolder.id="h"+nid;
  
  nowDiv.appendChild(childHolder); 
  
  var colCount=pcol.length-1;
  if(colCount<0)
    return;
   for(i=0;i<colCount;i++) 
   {
    

     collapseTb.TableCreater(pcol[i],childHolder.id,false); 
     
   
   }
   collapseTb.TableCreater(pcol[colCount],childHolder.id,true);


}




  

function OnRowMouseover()
{
  if(this.onmouseout!=null)
  {
	this.lastBgColor=this.style.backgroundColor;
	this.style.backgroundColor='orange';
	this.lastColor=this.style.color;
	this.style.color='white';
  }	


}

function OnRowMouseout()
{

	this.style.backgroundColor=this.lastBgColor;


	this.style.color=this.lastColor;


}


function ganttSort_onchange() {
 var ganttSort=document.getElementById("ganttSort");
  gType=ganttSort.value;

  var url ="PrjTaskTraceGante.aspx?gType="+gType;
  LinkTo(url, "_self", CenterWin("width=500,height=550,toolbar=no,scrollbars=no"));//LINKTO：链接页面地址，CENTERWIN：设定打开的页面的宽度，高度，有无滚动条，是否可拖动

}

/*

<div id="Template" style="visibility:hidden">
		<table id="weekTemplate" style="TABLE-LAYOUT: fixed; BORDER-COLLAPSE: collapse" borderColor="black"
			cellSpacing="0" cellPadding="0" width="105" bgColor="gainsboro" border="0">
			<tr>
				<td style="BORDER-RIGHT: black 1px solid; BORDER-BOTTOM: black 1px solid" colSpan="7">2006-1-30</td>
			</tr>
			<tr>
				<td width="15">日</td>
				<td width="15">一</td>
				<td width="15">二</td>
				<td width="15">三</td>
				<td width="15">四</td>
				<td width="15">五</td>
				<td style="BORDER-RIGHT: black 1px solid" width="15">六</td>
			</tr>
		</table>
		</div>

*/
