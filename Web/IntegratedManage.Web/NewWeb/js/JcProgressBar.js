function JcProgressBar(htmlele)
{
	this.Type="jcprogressbar";
	this.Css=null;
	this.Event=null;
	
	this.RangeStart=null;
	this.RangeEnd=null;
	this.PlanDateStart=null;
	this.PlanDateEnd=null;
	this.DateStart=null;
	this.DateEnd=null;		

	this.PlanColor = null;
	this.Color=null;
	this.PlanToolTip=null;	
	this.ToolTip=null;	
	
	this.Init(htmlele);
}

JcProgressBar.prototype.GetDate = function(date)
{
	if(date.indexOf(" ") >= 0)
		date = date.substring(0,date.indexOf(" "))
	var unit = date.split("-");
	return new Date(unit[0],parseInt(unit[1]) - 1,unit[2]);
}

JcProgressBar.prototype.Init=function(htmlele)
{
	if(!htmlele)htmlele=document.createElement("<span class='jcprogressbar' jctype='jcprogressbar'>");
	this.HtmlEle = htmlele;
	this.HtmlEle.Co=this;
	this.Css = htmlele.className;
	if(!this.Css)
	{	htmlele.className="jcprogressbar";
		this.Css="jcprogressbar";
	}
	this.RangeStart=GetAttr(this.HtmlEle,"RangeStart",null);
	this.RangeEnd=GetAttr(this.HtmlEle,"RangeEnd",null);
	this.PlanDateStart=GetAttr(this.HtmlEle,"PlanDateStart",null);
	this.PlanDateEnd=GetAttr(this.HtmlEle,"PlanDateEnd",null);
	this.DateStart=GetAttr(this.HtmlEle,"DateStart",null);
	this.DateEnd=GetAttr(this.HtmlEle,"DateEnd",null);	
	
	if(this.RangeStart != null)
		this.RangeStart = this.GetDate(this.RangeStart);
	if(this.RangeEnd != null)
		this.RangeEnd = this.GetDate(this.RangeEnd);
	if(this.PlanDateStart != null)
		this.PlanDateStart = this.GetDate(this.PlanDateStart);		
	if(this.PlanDateEnd != null)
		this.PlanDateEnd = this.GetDate(this.PlanDateEnd);	
	if(this.DateStart != null)
		this.DateStart = this.GetDate(this.DateStart);		
	if(this.DateEnd != null)
		this.DateEnd = this.GetDate(this.DateEnd);				
	
	this.PlanColor=GetAttr(this.HtmlEle,"PlanColor",null);
	this.Color=GetAttr(this.HtmlEle,"Color",null);
	this.PlanToolTip=GetAttr(this.HtmlEle,"PlanToolTip","");
	this.ToolTip=GetAttr(this.HtmlEle,"ToolTip","");
	this.InitProgressBar();
}
JcProgressBar.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}			

JcProgressBar.prototype.InitProgressBar=function()
{
	var startPosition = null;
	var length = null;
	var range = null;
	
	if(this.PlanDateStart != null && this.PlanDateEnd != null)
	{
		if(this.PlanDateStart == null && this.PlanDateEnd != null)
			this.PlanDateStart = this.PlanDateEnd;
		else if(this.PlanDateStart != null && this.PlanDateEnd == null)
			this.PlanDateEnd = this.PlanDateStart;
		if(this.PlanDateStart < this.RangeStart)	
			this.PlanDateStart = this.RangeStart;
		if(this.PlanDateStart > this.RangeEnd)	
			this.PlanDateStart = this.RangeEnd;	
		if(this.PlanDateEnd < this.RangeStart)	
			this.PlanDateEnd = this.RangeStart;
		if(this.PlanDateEnd > this.RangeEnd)	
			this.PlanDateEnd = this.RangeEnd;						
			
		
		startPosition = this.PlanDateStart - this.RangeStart;
		length = this.PlanDateEnd - this.PlanDateStart +86400000  ;
		range = this.RangeEnd - this.RangeStart +86400000;
		
		this.HtmlEle.appendChild(this.GetUnitSpan(80,Math.round(startPosition/range*100),Math.round(length/range*100),this.PlanColor,this.PlanToolTip));
	}

	if(this.DateStart != null && this.DateEnd != null)
	{
		if(this.DateStart == null && this.DateEnd != null)
			this.DateStart = this.DateEnd;
		else if(this.DateStart != null && this.DateEnd == null)
			this.DateEnd = this.DateStart;
		if(this.DateStart < this.RangeStart)	
			this.DateStart = this.RangeStart;
		if(this.DateStart > this.RangeEnd)	
			this.DateStart = this.RangeEnd;	
		if(this.DateEnd < this.RangeStart)	
			this.DateEnd = this.RangeStart;
		if(this.DateEnd > this.RangeEnd)	
			this.DateEnd = this.RangeEnd;			
			
		
		startPosition = this.DateStart - this.RangeStart;
		length = this.DateEnd - this.DateStart +86400000;
		range = this.RangeEnd - this.RangeStart +86400000;

		this.HtmlEle.appendChild(this.GetUnitSpan(40,Math.round(startPosition/range*100),Math.round(length/range*100),this.Color,this.ToolTip));
	}	
}

JcProgressBar.prototype.GetUnitSpan = function(heightRate,startRate,lengthRate,color,toolTip)
{
	var height = this.HtmlEle.offsetHeight;
	var width = this.HtmlEle.offsetWidth;
	var spanHeight = Math.round(height * heightRate / 100);
	var spanTop = (height - spanHeight) / 2;
	var spanLeft = Math.round(width * startRate / 100);
	var spanWidth = Math.round(width * lengthRate / 100);
	var ele = document.createElement("<span title='" + toolTip + "' style='border:1 solid black;overflow:hidden;top:" + spanTop + ";height:" + spanHeight + ";left:" + spanLeft + ";width:" + spanWidth + ";background-color:" + color + ";position:absolute;'>");
	return ele;
}


JcProgressBar.prototype.Fire=function(eventname)
{	var e = this.HtmlEle.getAttribute(eventname);
	if(e)
		eval(e);
}




