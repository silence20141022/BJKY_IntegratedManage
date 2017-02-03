

var legendPanel;


function yhWriteChart(TargetID,SIZE,DATA)
{
 legendPanel=document.getElementById("legendPanel"); 
 if(document.getElementById==null || TargetID==null){return;};
 var TargetObj = document.getElementById(TargetID);
 if(TargetObj==null || TargetObj.tagName ==null || DATA==null){return;};
 SIZE = Math.ceil( Math.max(SIZE,150));
 DATA = DATA.toString().split(",");
 var SUM = 0;
 var SortData = new Array();
 for(var i=0;i<DATA.length;i++)
 {
   DATA[i] = DATA[i].split(":");
   if(DATA[i].length!=2){alert("invalid chart data :" + DATA[i]);return;}
   if(isNaN(DATA[i][1])){alert("invalid chart data :" + DATA[i]);return;}
   
   var sliceValue=parseFloat(DATA[i][1]);
   if(isNaN(sliceValue))
     sliceValue=0;
   DATA[i][1] = sliceValue;
   SUM += DATA[i][1];   
 }
 //sort data

function sortNumbers(a, b) { return b[1] - a[1] } 
DATA = DATA.sort(sortNumbers);





 if(window.createPopup && document.all) {yhWritePieChart();}//IE5.5

//Get a pie chart=============================

  function yhWritePieChart()
  {
  /*
  if(document.all.tags("arc").length<=0)
  {document.write('<?xml:namespace Prefix="v" \/>');}
*/
  
  var zIndex= 0
  function getSlice(ColumnName,ColumnData,size,start,end,fillcolor,extrusion)
  {
	      
          if(extrusion){fillcolor = "#FF0000";};
		  size = size - 40;
		  zIndex++;		  
		  var r = size/2;
		  var colRate;
		  var ang1 = (  start / 360)*(Math.PI*2);
		  var ang2 = (  end / 360)*(Math.PI*2);
		  var x1 = r + Math.sin( ang1 )*r +"px";
		  var y1 = r - Math.cos( ang1)*r+"px";
		  
		  var xy = "";
		  var gef =start;
		  var deg = Math.ceil((end - start)/5);
          while( gef < end)
		  {
             gef += (end - start)/deg;
			 var ang_1 = (  gef / 360)*(Math.PI*2);
		     var ang_2 = (  gef / 360)*(Math.PI*2);
			 xy += r + Math.sin( (ang_1 + ang_2 )/2 )*(r)+"px";
			 xy += r - Math.cos( (ang_1 + ang_2 )/2)*(r)+"px"; 
		  }
    	 
		  
		  var x2 = r + Math.sin( ang2 )*r+"px";
		  var y2 = r - Math.cos( ang2 )*r+"px";
		  
		  var MI = (zIndex%2)?(12):(0);
		  var legenx = r + Math.sin(  (ang1 + ang2 )/2 )*(r + MI+40)+"px";
		  var legeny = r - Math.cos( (ang1 + ang2 )/2 )*(r + MI+20 )+"px";
		  
          var behavior = 'style="behavior:url(#default#VML);"';
		  var style = 'behavior:url(#default#VML);width:'+size+';height:'+size+';position:absolute;left:0px;top:-6px;';
		  var angle = (end - start).toFixed(2);


		  var arc = '<v:arc style="'+style+';z-index:'+zIndex+'" startangle="'+start+'" endangle="'+ end+'" strokecolor="'+fillcolor+'" fillcolor="'+fillcolor+'" strokeweight="3px">';
		       arc +='<v:fill  '+behavior+' type = "gradient" color2="fill darken(202)" angle = "'+angle+'" focus = "0%"></v:fill>';
               if(extrusion ==true)
			   {arc +='<o:extrusion style="'+style+';"  v:ext="view" on="t" rotationangle="6,0" viewpoint="0,0"  viewpointorigin="90,0" skewangle="0" skewamt="0" lightposition="-50000,-50000"  lightposition2="50000"    backdepth ="60px"/>';//type="perspective" 
			   }			   
			   arc +='</v:arc>';
           
		  var poly ='<v:polyline '+' style="'+style+';z-index:'+(zIndex+1)+'"  points="'+r+'px,'+r+'px,'+x1 +','+y1+','+xy+','+x2+','+y2+'" strokeweight="0.1pt" stroked="f" strokecolor="#666666" fillcolor="'+fillcolor+'" strokeweight="1pt">';
		       poly +='<v:fill  '+behavior+' type = "gradient" color2="fill lighten(100)" angle = "'+angle+'" focus = "0%"></v:fill>';
			   poly +='</v:polyline>'; 

			   //legend line
			   if(extrusion !=true)
			   { 
			     poly +='<v:polyline  style="'+style+';z-index:'+(zIndex - 2)+'"  points="'+r+'px,'+r+'px,'+legenx+','+legeny+'"  stroked="t" strokecolor="'+fillcolor+'" filled="f" strokeweight="1.5pt">';
			     poly +='</v:polyline>';
			     colRate=((ColumnData/SUM)*100).toFixed(2)+'%';
				 var info = ColumnName+ ':' +' - '+colRate;
				 var infoStrLen=info.length;
				var infoFontSize=(infoStrLen+40)/50*13;
				
				
				 poly +="<span "+' onmouseover="'+"this.lastBgColor=this.style.backgroundColor;this.style.backgroundColor='black';this.lastColor=this.style.color;this.style.color='lightgreen';"+'this.style.zoom=1.2;this.lastIndex=this.style.zIndex;this.style.zIndex=505"   onmouseout="this.style.zoom=0.8;this.style.backgroundColor=this.lastBgColor;this.style.zIndex=this.lastIndex;this.style.color=this.lastColor" style="cursor:hand;font-size:'+infoFontSize+'px;zoom:0.8;background:'+fillcolor+';filter:Alpha(opacity=80);border:solid 1px #cccccc; padding:1px;font-family:Verdana;z-index:'+(zIndex + 2 + DATA.length)+';position:absolute;left:'+(parseInt(legenx) - ColumnName.length*3 )+'px;top:'+(parseInt(legeny)-15)+'px;">'+info +'</span>';
			   }
			   
			   if(ColumnName !="Total")
			   {
			   var lpRow=legendPanel.insertRow();
			   lpRow.height="15px";
			   var colorCell= lpRow.insertCell();
			   var valueCell=lpRow.insertCell();
			   colorCell.style.backgroundColor=fillcolor;
			   valueCell.innerHTML="<nobr>"+ColumnName+"["+colRate+"]</nobr>";
			   valueCell.title=ColumnName+"["+colRate+"]--"+ColumnData;
			   }
			    
			   	  
		  return arc  +   poly ;
  }
   /*
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
  }*/

      
	
	var VML = "";
	var START = 0;
	var END =0;
    
	VML +=  getSlice("Total",SUM,SIZE ,0,360,"#ffffcc",true);
    while(DATA.length >0)
	{
	  var INC =Math.ceil(( DATA[0][1] / SUM )*360 );
	  END =  START + INC;
	  VML +=  getSlice(DATA[0][0], DATA[0][1], SIZE ,START, END,  getColor());
	  START = END;
	  DATA.shift();
	}
    //	VML = '<v:roundrect strokecolor="#cccccc" style="behavior:url(#default#VML);;filter:progid:DXImageTransform.Microsoft.Graxdient(startColorStr=#FFFFFF, endColorStr=#DEDEDE, gradientType=0) progid:DXImageTransform.Microsoft.Shadow(color=#222222,direction=135,strength=2);;width:'+SIZE +'px;height:'+SIZE +'px;"><div style="position:relative;margin:20px;">' + VML + '</div></v:roundrect>';
   // var TITLE = '<div style="position:absolute;top:122px left:12px;z-index:999;width:'+(SIZE - 40) +'px;font-size:11px;font-family:Verdana;">Chart TitleChart TitleChart TitleChart TitleChart Title</div>'
	VML = '<div onselectstart="event.returnValue=false; return false;" style="width:'+SIZE +'px;height:'+SIZE +'px;border:solid 1px #cccccc;text-align:left;"><div style="position:relative;margin:20px;">' + VML + '</div></div>';
	var DD = document.createElement("div");
	//TargetObj.style.position="relative";
	DD.width="100%";
	DD.innerHTML = VML;
	TargetObj.insertAdjacentElement("BeforeBegin",DD);
	TargetObj.removeNode(true);
	chartTotalTitle.innerText="×Ü¼Æ:"+SUM.toFixed(2);

 }
}