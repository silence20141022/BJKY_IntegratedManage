/**<doc type="varible" name="Global.InputElements">
	<desc>所有表单元素串，用于快速过滤</desc>
</doc>**/
var InputElements="jctext,jctextarea,jcselect,jccheckbox,jcradiogrp,jcupdown,jcdropdown,jcpopup,jcenum,jcgrid,jcgridnew,jcfile,jcsign,jcuserselect";

/**<doc type="function" name="Global.CancelEvent">
	<desc>将事件的返回值置为false,从而终止事件的继续执行</desc>
</doc>**/
function CancelEvent()
{	event.returnValue=false;
	return false;
}

/**<doc type="function" name="Global.GetJcElements">
	<desc>得到某元素中的全部Jc元素数组</desc>
	<input>
		<param name="ele" type="object">包含Jc元素的元素</param>
	</input>
	<output type="Array">Jc元素数组</output>
</doc>**/
function GetJcElements(ele)
{	var jcs=new Array();
	var eles=ele.getElementsByTagName("span");
	for(var i=0;i<eles.length;i++)
	{
		if(eles[i].getAttribute("jctype"))
		{
			jcs[jcs.length]=eles[i];
		}	
	}	
	var eles=ele.getElementsByTagName("input");
	for(var i=0;i<eles.length;i++)
		if(eles[i].getAttribute("jctype"))jcs[jcs.length]=eles[i];
	var eles=ele.getElementsByTagName("select");
	for(var i=0;i<eles.length;i++)
		if(eles[i].getAttribute("jctype"))jcs[jcs.length]=eles[i];
	var eles=ele.getElementsByTagName("textarea");
	for(var i=0;i<eles.length;i++)
		if(eles[i].getAttribute("jctype"))jcs[jcs.length]=eles[i];
	var eles=ele.getElementsByTagName("form");
	for(var i=0;i<eles.length;i++)
		if(eles[i].getAttribute("jctype"))jcs[jcs.length]=eles[i];
	var eles=ele.getElementsByTagName("button");
	for(var i=0;i<eles.length;i++)
		if(eles[i].getAttribute("jctype"))jcs[jcs.length]=eles[i];
	return jcs;
}

/**<doc type="function" name="Global.GetParentJcElement">
	<desc>得到某元素的父Jc元素</desc>
	<input>
		<param name="eventele" type="object">待查找的元素</param>
	</input>
	<output type="object">父Jc元素</output>
</doc>**/
function GetParentJcElement(eventele)
{	var type,pnode,node;
	pnode = eventele;
	do{	node = pnode;
		if(node==document.body)return null;
		try{type = node.getAttribute("jctype");}catch(e){};
		pnode = node.parentNode;
	}while(type == null && pnode != null);
	if (pnode == null)return null;
	return node;
}

/**<doc type="function" name="Global.GetTableTr">
	<desc>得到某元素的父Tr元素</desc>
	<input>
		<param name="eventele" type="object">待查找的元素</param>
	</input>
	<output type="object">父Tr元素</output>
</doc>**/
function GetTableTr(eventele)
{	var type,ptype,pnode,node;
	pnode = eventele;
	do{	node = pnode;
		type = node.tagName.toLowerCase();
		pnode = node.parentNode;
		ptype = pnode.tagName.toLowerCase();
	}while(type != "tr" && ptype != "table" && type != "table");
	if (ptype == "table" || type=="table")return null;
	return node;
}

/**<doc type="function" name="Global.GetJcChildElement">
	<desc>得到某元素的父Jc元素的指定类型子元素</desc>
	<input>
		<param name="eventele" type="object">待查找的元素</param>
		<param name="objtype" type="string">子元素的类型</param>
	</input>
	<output type="object">指定类型的子元素</output>
</doc>**/
function GetJcChildElement(eventele,objtype)
{	var type,jtype,pnode,node;
	pnode = eventele;
	do{	node = pnode;
		type = node.getAttribute("Type");
		pnode = node.parentNode;
		jtype = pnode.getAttribute("JcType");
	}while(type != objtype && jtype == null);
	if (jtype != null && type==null)return null;
	return node;
}

//
//--------------------------------JcInput对象定义开始---------------------------------------------------
//

/**<doc type="objdefine" name="JcInput">
	<desc>数值型Jc元素的基类JcInput定义</desc>
	<property>
		<prop name="Type" type="string">元素类型</param>
		<prop name="DefValue" type="string">元素默认值</param>
		<prop name="HtmlEle" type="object">该元素对应的HTML</param>
		<prop name="Readonly" type="boolean">是否只读，缺省为false</param>
		<prop name="Disabled" type="boolean">是否禁用，缺省为false</param>
		<prop name="AllowEmpty" type="boolean">是否允许为空，却省为true</param>
		<prop name="Render" type="enum">client(由客户端绘制)/server(由服务器端绘制)</param>
		<prop name="Css" type="string">该元素采用的样式</param>
		<prop name="PreBgColor" type="string">控件背景色</param>
		<prop name="IsSubmit" type="boolean">是否提交，用于JcForm提交数据时用，缺省为true，若控件包含属性NotSubmit，则此属性将置为false</param>
	</property>
</doc>**/
function JcInput()
{	this.Type="";
	this.DefValue=null;
	this.HtmlEle=null;
	this.Readonly=false;
	this.Disabled=false;
	this.AllowEmpty=true;
	this.Render="client";
	this.Css="";
	this.PreBgColor="";
	this.IsSubmit=true;
}

/**<doc type="protofunc" name="JcInput.SuperInit">
	<desc>JcInput的默认构建器,主要用在继承初始化上</desc>
</doc>**/
JcInput.prototype.SuperInit=function()
{	
	var ele=this.HtmlEle;
	
	if(ele.getAttribute("NotSubmit")!=null)
	{
		this.IsSubmit=false;
	}
	
	// 是否显示控件边框（style.borderWidth=0）
	if(ele.getAttribute("HideBorder")!=null)
	{
		this.HideBorder();
	}
	
	if(ele.getAttribute("RenderAtServer")!=null)
	{
		this.Render="server";
	}
	
	if(ele.getAttribute("DefValue")!=null)
	{
		this.DefValue=ele.getAttribute("DefValue");
	}
	
	if(ele.className!="")	
	{
		this.Css=ele.className;	
	}
	else
	{
		if(this.Type.toLowerCase()!="jcselect")	//下框设置样式后win2003ie无法下拉
		{
			ele.className=this.Type;
		}
			
		this.Css=this.Type;	
	}
		
	//必填项标记
	if(ele.getAttribute("NotAllowEmpty")!=null)
	{
		this.SetAllowEmpty(false);
	}
	
	//默认颜色
	if(this.HtmlEle.currentStyle)
		this.PreBgColor=this.HtmlEle.currentStyle.backgroundColor;
	//操作性
	this.HtmlEle.onfocus=JcInput.OnFocus;	
	if(ele.disabled)this.SetDisabled(true);
	var rd=ele.getAttribute("readonly")+"";
	if(rd == "true" || rd == "" )this.SetReadonly(true);
	//默认初始值
	if(ele.getAttribute("Value")!=null)
		this.SetValue(ele.getAttribute("Value"));
}

/**<doc type="protofunc" name="JcInput.OnFocus">
	<desc>获得焦点时触发</desc>
</doc>**/
JcInput.OnFocus=function()
{
	var ele=GetParentJcElement(event.srcElement);
	ele.style.backgroundColor=ele.Co.PreBgColor;	
}

/**<doc type="protofunc" name="JcInput.GetValue">
	<desc>取得JcInput的值</desc>
	<output type="string">JcInput的值</output>
</doc>**/
JcInput.prototype.GetValue=function(){return "";}

/**<doc type="protofunc" name="JcInput.SetValue">
	<desc>设置JcInput的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcInput.prototype.SetValue=function(value){}

/**<doc type="protofunc" name="JcInput.Clear">
	<desc>设置JcInput为空</desc>
</doc>**/
JcInput.prototype.Clear=function()
{	this.SetValue(null);
}

/**<doc type="protofunc" name="JcInput.Reset">
	<desc>设置JcInput为初始值</desc>
</doc>**/
JcInput.prototype.Reset=function()
{	var dv=this.HtmlEle.getAttribute("DefValue");
	if(dv)this.SetValue(dv);
}

/**<doc type="protofunc" name="JcInput.Validate">
	<desc>验证JcInput的有效性</desc>
	<output type="object">返回ValidateResult</output>
</doc>**/
JcInput.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 

		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
	}
	return validateResult;	

	//ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
}

/**<doc type="protofunc" name="JcInput.Validate">
	<desc>验证JcInput的有效性，若验证出错，则弹出错误窗口</desc>
</doc>**/
JcInput.prototype.DoValidate=function()
{
	var Result = this.Validate();
	var msg = "";
	if(Result!=null&&!Result.Passed)
	{
		msg+=(j++)+")  "+Result.GetErrMsg()+"\n";
	}
	if (msg.length>0)
	{	
		window.showModalDialog("/share/page/ValidteError.htm",msg,
			"dialogHeight:360px;dialogWidth:500px;edge:Sunken;center:Yes;help:No;resizable:Yes;status:No;scroll:no");
		return false;
	}
	else	
		return true;
}

/**<doc type="protofunc" name="JcInput.SetAllowEmpty">
	<desc>设置JcInput是否必填</desc>
	<input>
		<param name="st" type="boolean">是否必填</param>
	</input>
</doc>**/
JcInput.prototype.SetAllowEmpty=function(st)
{	this.AllowEmpty=st;
	this.HtmlEle.AllowEmpty=st;
	this._SetBackgroundColor();
}

/**<doc type="protofunc" name="JcInput.SetReadonly">
	<desc>设置JcInput是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcInput.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	this._SetBackgroundColor();
}

/**<doc type="protofunc" name="JcInput.SetDisabled">
	<desc>设置JcInput是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcInput.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this._SetBackgroundColor();
}

/**<doc type="protofunc" name="JcInput.SetDisabled">
	<desc>显示此Jc控件为Label类似形式</desc>
	<input>
		<param name="st" type="boolean">是否显示</param>
	</input>
</doc>**/
JcInput.prototype.SetToView = function(st)
{
	//如果控件原本就是不显示的
	if(!this.View && this.HtmlEle.style.display == "none")
		return false;
	//如果控件本来就是隐藏的
	if(this.Type.toLowerCase() == "jctext" && this.HtmlEle.type.toLowerCase() == "hidden")
		return false;
	this.View = st;
	var viewEle = this.ViewEle;
	if(!viewEle)
		viewEle = this.ViewEle = document.createElement("<span>");
	if(st)
	{
		var text = "";
		if(this.GetText)
			text = this.GetText();
		else
			text = this.GetValue();
		if(this.HtmlEle.className) viewEle.className = this.HtmlEle.className;
		if(this.HtmlEle.cssText) viewEle.cssText = this.HtmlEle.cssText;
		viewEle.style.textDecoration = "underline";	//下划线样式
		viewEle.style.width = this.HtmlEle.offsetWidth;	//保持宽度不边
		viewEle.style.height = this.HtmlEle.offsetHeight;	//保持高度不变
		viewEle.innerHTML = text;
		this.HtmlEle.parentNode.insertBefore(viewEle,this.HtmlEle);
		this.HtmlEle.style.display = "none";
	}
	else
	{
		viewEle.style.display = "none";
		this.HtmlEle.style.display = "";
	}
}

/**<doc type="protofunc" name="JcInput._SetBackgroundColor">
	<desc>设置JcInput背景色</desc>
</doc>**/
JcInput.prototype._SetBackgroundColor=function()
{
	if(this.Disabled)
		this.HtmlEle.style.backgroundColor = DisabledBgColor;
	else if(this.Readonly)
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;
	else if(!this.AllowEmpty)
		this.HtmlEle.style.backgroundColor = MustInputBgColor;
	else
		this.HtmlEle.style.backgroundColor = NormalBgColor;
}

/**<doc type="protofunc" name="JcInput.HideBorder">
	<desc>设置JcInput隐藏边界</desc>
</doc>**/
JcInput.prototype.HideBorder=function(){}

/**<doc type="protofunc" name="JcInput.SubCss">
	<desc>设置JcInput的子样式</desc>
</doc>**/
JcInput.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}

//
//--------------------------------JcInput对象定义结束---------------------------------------------------
//

//
//--------------------------------JcText对象定义开始 从JcInput继承---------------------------------------------------
//
var _suggestAreaCount = 0;
/**<doc type="objdefine" name="JcText">
	<desc>JcText定义,由JcInput继承</desc>
	<property>
		<prop name="SubType" type="string">JcText元素的子元素类型</param>
	</property>
</doc>**/
function JcText(ele)
{	
	this.Type="jctext";
	this.SubType="";
	if(ele || typeof(ele)=="undefined"){this.Init(ele);}//为了便于JcTextara继承
}
JcText.prototype=new JcInput();

/**<doc type="protofunc" name="JcText.Init">
	<desc>JcText的构建器</desc>
	<input>
		<param name="ele" type="object">JcText对应的HTML元素</param>
	</input>	
</doc>**/
JcText.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<input type='text' class='jctext' jctype='jctext'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.SetType(ele.type);
	this.SuperInit();
	this.HtmlEle.attachEvent("onblur",JcText.OnBlur);
	this.HtmlEle.attachEvent("onfocus",JcText.OnFocus);

	//add by tyaloo ,add autocomplete function
	if(this.HtmlEle.canAutoComplete)
	{		
		_MakeJcEleCanAutoComplete(this); 						
	}
	else
	{
		this.HtmlEle.attachEvent("onkeydown",JcText.OnKeyDown);
	}
}

/**<doc type="protofunc" name="JcText.FormatDate">
	<desc></desc>
	<input>
		<param name="ele" type="object">JcText对应的HTML元素</param>
	</input>	
</doc>**/
JcText.prototype.FormatDate=function()
{
	var dateStr=this.HtmlEle.value;
	dateStr=dateStr.split(' ');
	this.HtmlEle.value=dateStr[0];
}

/**<doc type="protofunc" name="JcText.SetType">
	<desc>设置JcText的类型</desc>
	<input>
		<param name="type" type="string">JcText的类型(Text/Hidden/Password)</param>
	</input>	
</doc>**/
JcText.prototype.SetType=function(type)
{	
	type=type.toLowerCase();
	if(type=="text"||type=="hidden"||type=="password")
	{	this.HtmlEle.type=type;
		this.SubType=type;
	}else
	{	this.HtmlEle.type="text";
		this.SubType="text";
	}
}

/**<doc type="protofunc" name="JcText.GetValue">
	<desc>取得JcText的值</desc>
	<output type="string">JcText的值</output>
</doc>**/
JcText.prototype.GetValue=function()
{	JcText.UnFormat(this.HtmlEle);
	return this.HtmlEle.value;
}

/**<doc type="protofunc" name="JcText.SetValue">
	<desc>设置JcText的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcText.prototype.SetValue=function(value)
{	if(value==null)
		this.HtmlEle.value="";
	else
	{
		var ele = this.HtmlEle;
		var dt = ele.getAttribute("DataType");
		if(dt&&dt.toLowerCase()=="money")
			ele.value=FormatMoney(value);
		else
			ele.value=value;
	}	
}

/**<doc type="protofunc" name="JcText.HideBorder">
	<desc>设置JcText隐藏边界</desc>
</doc>**/
JcText.prototype.HideBorder=function()
{	this.HtmlEle.style.borderWidth=0;
}

/**<doc type="protofunc" name="JcText.OnKeyDown">
	<desc>设置JcText中按下键时操作,若按下回车键,则尝试提交表单</desc>
</doc>**/
JcText.OnKeyDown = function()
{
   var ele = event.srcElement;
   
    var action = kbActions[event.keyCode];
    
    if(action == "enter" && ele.ParentForm)	
	{
		 var  _ParentFormBtn = ele.ParentForm.SubmitBtn;
 
		   if(_ParentFormBtn) 
		   {
		     if(!confirm("确认要提交吗?")) return ;
		     _ParentFormBtn.click();
		   }
	}
}

/**<doc type="protofunc" name="JcText.OnBlur">
	<desc>设置JcText失去焦点时操作,若控件DataType为money则格式化内容</desc>
</doc>**/
JcText.OnBlur=function()
{
	var ele = event.srcElement;
	var dt = ele.getAttribute("DataType");
	if(!dt||dt.toLowerCase()!="money")return;
	JcText.UnFormat(ele);
	ele.value=FormatMoney(ele.value);
}

/**<doc type="protofunc" name="JcText.OnFocus">
	<desc>设置JcText获得焦点时操作,若控件DataType为money则格式化内容</desc>
</doc>**/
JcText.OnFocus=function()
{
	var ele = event.srcElement
	var dt = ele.getAttribute("DataType");
	if(dt&&dt.toLowerCase()=="money")
		JcText.UnFormat(ele);
	ele.select();
}

/**<doc type="protofunc" name="JcText.UnFormat">
	<desc>格式化指定元素</desc>
	<input>
		<param name="ele" type="object">指定元素</param>
	</input>
</doc>**/
JcText.UnFormat=function(ele)
{
	var dt = ele.getAttribute("DataType");
	if(!dt||dt.toLowerCase()!="money")return;
	var val = ele.value;
	val = val.replace(/,/g,"");
	val=val.replace("￥","");
	var lc=val.substr(val.length-1).toLowerCase();
	if(lc=="w"||lc=="k")
		val=val.substr(0,val.length-1);
	var fval=parseFloat(val);
	if(!fval) 
	{
		ele.value = "";
		return ;
	}
	if(lc=="w")
		fval=fval*10000;

	if(lc=="k")
		fval=fval*1000;
	ele.value = parseInt(fval);
}

//
//--------------------------------JcText对象定义结束---------------------------------------------------
//

//
//--------------------------------JcTextArea对象定义开始 从JcText继承---------------------------------------------------
//

/**<doc type="objdefine" name="JcTextArea">
	<desc>JcTextArea定义,由JcText继承</desc>
</doc>**/
function JcTextArea(ele)
{	this.Type="jctextarea";
	this.Init(ele);
}
JcTextArea.prototype = new JcText(null);

/**<doc type="protofunc" name="JcTextArea.Init">
	<desc>JcTextArea的构建器</desc>
	<input>
		<param name="ele" type="object">JcTextArea对应的HTML元素</param>
	</input>	
</doc>**/
JcTextArea.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<textarea type='text' class='jctextarea' jctype='jctextarea'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.SuperInit();
}

/**<doc type="protofunc" name="JcTextArea.HideBorder">
	<desc>设置JcTextArea隐藏边界</desc>
</doc>**/
JcTextArea.prototype.HideBorder=function()
{	this.HtmlEle.style.borderWidth=0;
	this.HtmlEle.style.overflow="hidden";
}

/**<doc type="protofunc" name="JcTextArea.SetType">
	<desc>设置JcTextArea的类型</desc>
	<input>
		<param name="type" type="string">JcTextArea的类型</param>
	</input>	
</doc>**/
JcTextArea.prototype.SetType=function(type){}

JcTextArea.prototype.GetValue=function()
{	return this.HtmlEle.value;
}

JcTextArea.prototype.SetValue=function(value)
{	if(value==null)
		this.HtmlEle.value="";
	else
	{
		this.HtmlEle.value=value;
		//this.HtmlEle.className="";
	}	
	
   //var OldHeight=this.HtmlEle.clientHeight;
    
   //this.HtmlEle.style.height=OldHeight+1;
  // this.HtmlEle.style.height=OldHeight;
}

JcTextArea.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	this._SetBackgroundColor();
}
//this.HtmlEle.className="";

/**<doc type="protofunc" name="JcInput.SetDisabled">
	<desc>设置JcInput是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcTextArea.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.readOnly=st;
	this._SetBackgroundColor();
}
//
//--------------------------------JcTextArea对象定义结束---------------------------------------------------
//

//
//--------------------------------JcSelect对象定义开始 从JcInput继承---------------------------------------------------
//

/**<doc type="objdefine" name="JcSelect">
	<desc>JcSelect定义,由JcInput继承</desc>
	<property>
		<prop name="OptionList" type="string">JcSelect元素对应的Option列表(通常在DataStore中的DataEnum或DataList中获得),格式为:[DataStore名称].[Enum/List].[Enum名称/List名称]</param>
		<prop name="TextField" type="string">OptionList的DataEnum(或DataList)对应JcSelect的显示字段</param>
		<prop name="ValueField" type="string">OptionList的DataEnum(或DataList)对应JcSelect的值字段</param>
	</property>	
	<demo>
		ele对应的HTML为:
			<select jctype="jcselect" id="Age" optionlist="Rds.Enum.Test"></select>
		或:	
			<select jctype="jcselect" id="Age" optionlist="Rds.List.Test"></select>
		DataList的格式为:
			<List Name="Test">
				<Row TextField="Hello" ValueField="0001" />
				<Row TextField="You" ValueField="0002" />
				<Row TextField="Bye" ValueField="0003" />
			</List>	
	</demo>
</doc>**/
function JcSelect(ele)
{	this.Type="jcselect";
	this.OptionList=null;
	this.TextField=null;
	this.ValueField=null;
	this._OldHandle=null;
	this.ReturnParam=null;
	
	this.Init(ele);
}
JcSelect.prototype=new JcInput();

/**<doc type="protofunc" name="JcSelect.Init">
	<desc>JcSelect的构建器</desc>
	<input>
		<param name="ele" type="object">JcSelect对应的HTML元素</param>
	</input>	
</doc>**/
JcSelect.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<select class='jcselect' jctype='jcselect'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this._OldHandle=this.HtmlEle.onchange;
	
	this.SuperInit();
	if(ele.getAttribute("OptionList")!=null)
	{	this.OptionList = GetDsNode(ele.getAttribute("OptionList"));
		if(this.OptionList)
		{	var type=this.OptionList.Type.toLowerCase();
			this.Reset(type,this.OptionList);
		}
	}
	
	//附加代码 by:gaozhenyu
	if(ele.getAttribute("ReturnParam") && this.OptionList)
	{
	   if(ele.getAttribute("ReturnParam")!=""&&this.OptionList.Type.toLowerCase()=="list"&&!ele.getAttribute("onchange")) //当定义了onchange的时候此功能失效
	   {
	      this.ReturnParam=ele.getAttribute("ReturnParam");
	     
	      this.HtmlEle.onchange=JcSelect.SetRelateValue;
	   }
	}
}

//这里表示设置子枚举
JcSelect.prototype.SetSonEnum=function() //当初始
{
    this.HtmlEle.onchange=null;//JcSelect.OnSonSelectChange;
     
	if(this.HtmlEle.getAttribute("onchange")||!this.OptionList||!this.HtmlEle.getAttribute("SonEnumId")) ///当外面有事件和或this.OptionList为空的时候 怎么不执行
		 return;
	
	if(this.GetValue().trim()=="")
	{
	  this.HtmlEle.onchange=JcSelect.OnSonSelectChange;
	  return;
	}
	
	var type = this.OptionList.Type.toLowerCase();
	
	if(type!="enum")//数据源不是枚举类型的时候返回
		return;
	var SelectIndexc=this.HtmlEle.selectedIndex;
	
	if(this.AllowEmpty)
		SelectIndexc=SelectIndexc-1;
	
	var SubEnumName=this.OptionList.GetSubEnum(SelectIndexc);
	
	if(!SubEnumName||SubEnumName.trim()=="")
	{
		this.HtmlEle.onchange=JcSelect.OnSonSelectChange; 
		var SonEnumElex=document.all(this.HtmlEle.getAttribute("SonEnumId")); 
		
		if(SonEnumElex)
		{
			if(SonEnumElex.Co)
			{
				SonEnumElex.Co.ClearOptionList();
			}
		}
		return;
	}
	
	var XmlPathArray=this.HtmlEle.getAttribute("OptionList").split('.');
	var XmlPathSon=XmlPathArray[0]+"."+XmlPathArray[1]+"."+SubEnumName;
	
	if(this.HtmlEle.getAttribute("SonEnumId"))//当前下拉框子枚举 JC控件ID不为空
	{
		if(document.all(this.HtmlEle.getAttribute("SonEnumId")))
		{
			var SonEnumEle=document.all(this.HtmlEle.getAttribute("SonEnumId"));
			
			if(SonEnumEle.Co)
			{
				SonEnumEleCo=SonEnumEle.Co;
				SonEnumEleCo.ClearOptionList();//首先清除原来有的数据
				var SonEnumOptionList=GetDsNode(XmlPathSon);//获取到子枚举控件的this.OptionList
				SonEnumEleCo.OptionList=SonEnumOptionList;
			    SonEnumEleCo.RenderObject();//
				this.HtmlEle.onchange=JcSelect.OnSonSelectChange; 
				/// SonEnumEleCo.SetValue(SonEnumEleCo.GetValue());
			}
		}
	}
}

JcSelect.OnSonSelectChange=function()
{
	var FileHtmlEle=event.srcElement;
	
	if(FileHtmlEle.Co)
	{
		FileHtmlEle.Co.SetSonEnum();
	}
}

/**<doc type="protofunc" name="JcSelect.Reset">
	<desc>根据指定类型重新渲染控件，常用于控件动态数据绑定，如：子枚举等</desc>
	<input>
		<param name="type" type="string">list/enum为list时，控件需设置TextField和ValueField默认"Text"和"Field"</param>
		<param name="dataSource" type="object">要绑定的数据源可位DataList或DataEnum类型</param>
	</input>	
</doc>**/
JcSelect.prototype.Reset=function(type,dataSource)
{
	if(!type) type = this.OptionList.Type.toLowerCase();
	if(!dataSource) dataSource = this.OptionList;
	ele = this.HtmlEle;
	this.OptionList = dataSource;
	type=type.toLowerCase();
	if(this.OptionList)
	{	
		if(type=="list")
		{	this.TextField=ele.getAttribute("TextField");
			if(!this.TextField)this.TextField="Text";
			this.ValueField=ele.getAttribute("ValueField");
			if(!this.ValueField)this.ValueField="Value";
		}else if(type=="enum")
		{	this.TextField="Text";
			this.ValueField="Value";
		}
	}
	if(this.Render=="client"&&this.OptionList)
		this.RenderObject();	
}

/**<doc type="protofunc" name="JcSelect.RenderObject">
	<desc>绘制JcSelect</desc>
</doc>**/
JcSelect.prototype.RenderObject=function()
{	
	var ele=this.HtmlEle;
	var width = ele.style.width;
	this.ClearOptionList();
	var isTopEmptyRow = GetAttr(ele, "isTopEmptyRow", true, "bool");	// 是否添加首空行- by rey .2009.2.27
	if(this.AllowEmpty && isTopEmptyRow)this.AddItem("","");
	if(!this.OptionList)return;
	var count=this.OptionList.GetItemCount();
	for(var i=0;i<count;i++)
	{	var dn=this.OptionList.GetItem(i);
		this.AddItem(dn.GetAttr(this.ValueField),dn.GetAttr(this.TextField));
	}
	//为了和IE7.0兼容的调整代码[但是会使该控件在同一百分比的时候存在不对齐的现象，暂时屏蔽]
	/*if(navigator.userAgent.toLowerCase().indexOf("msie 7.0") > 0)
	{
		if(width && width.indexOf("%")>0 && ele.parentNode.offsetWidth)
		{
			ele.style.width = ele.parentNode.offsetWidth * parseFloat(width)/100;
		}
	}*/
	
	if(this.HtmlEle.getAttribute("SonEnumId"))
	{
	    this.SetSonEnum();
	   // window.setTimeout("JcSelect.SetSonValue('"+this.HtmlEle.id+"')",1);
	}
	// this.SetSonEnum();
}

JcSelect.SetSonValue=function(objid)
{
	var FileHtmlEle=document.all(objid);
	
	FileHtmlEle.Co.SetSonEnum();
}

/**<doc type="protofunc" name="JcSelect.ClearOptionList">
	<desc>清空JcSelect的Option</desc>
</doc>**/
JcSelect.prototype.ClearOptionList=function()
{	var ele=this.HtmlEle;
	var count=ele.options.length;
	ele.options.innerHTML ="";
	/*for(var i=0;i<count;i++)
	{
		try{ele.options.remove(0);}catch(e){};
	}*/
}

/**<doc type="protofunc" name="JcSelect.GetValue">
	<desc>取得JcSelect的显示值</desc>
	<output type="string">JcSelect的显示值</output>
</doc>**/
JcSelect.prototype.GetText = function()
{
	var	ele = this.HtmlEle;
	return ele.options[ele.selectedIndex].text;
}

/*如果数据源是DataList,这个方法择是取出当前选中的DataItem by:Loosen
这样做是为了做感知所使用
*/
JcSelect.SetRelateValue = function()
{
    var ele=event.srcElement;
	var spc=new StringParam(ele.Co.ReturnParam);
	
	for(var i_tt=0;i_tt<spc.GetCount();i_tt++)
	{
	   
	   if(document.all(spc.Keys[i_tt])&&ele.options[ele.selectedIndex].text!=""&&ele.options[ele.selectedIndex].value!="")
	   {
	      Co[spc.Keys[i_tt]].SetValue(ele.Co.OptionList.GetItem(ele.getAttribute("ValueField"),ele.options[ele.selectedIndex].value).GetAttr(spc.Values[i_tt]));
	   }
	}
}

/**<doc type="protofunc" name="JcSelect.GetValue">
	<desc>取得JcSelect的值</desc>
	<output type="string">JcSelect的值</output>
</doc>**/
JcSelect.prototype.GetValue=function()
{	var ele=this.HtmlEle;
	if(ele.selectedIndex < 0)
		return "";
	else
		return ele.options[ele.selectedIndex].value;
}

///当select关联其他控件的时候用 此对象的方法进行初始化（如：在不为空的时候第一次打开页面的时候）by:gaozhenyu
JcSelect.prototype.InitRelate=function()
{	
    var ele=this.HtmlEle;
    if(!this.ReturnParam||ele.getAttribute("ValueField")==""||ele.getAttribute("TextField")=="")//其中一个不满足则不做任何的操作
    {
		return;
    }
	var spc=new StringParam(this.ReturnParam);
	for(var i_tt=0;i_tt<spc.GetCount();i_tt++)
	{
	   if(document.all(spc.Keys[i_tt])&&ele.options[ele.selectedIndex].text!=""&&ele.options[ele.selectedIndex].value!="")
	   {
	      Co[spc.Keys[i_tt]].SetValue(ele.Co.OptionList.GetItem(ele.getAttribute("ValueField"),ele.options[ele.selectedIndex].value).GetAttr(spc.Values[i_tt]));
	   }
	}
}

/**<doc type="protofunc" name="JcSelect.SetValue">
	<desc>设置JcSelect的值,如果传入的text值为null,则只匹配传入的value和Option列表中value的值;如果传入的text值不为null,则两者均要匹配</desc>
	<input>
		<param name="value" type="string">待设置的与Option列表中相对应的值</param>
		<param name="text" type="string">待设置的与Option列表中相对应的文本</param>
	</input>
	<demo>
		jcSelect.SetValue("value1",null);
		jcSelect.SetValue("value1","text1");
	</demo>
</doc>**/
JcSelect.prototype.SetValue=function(value,text)
{	var ele=this.HtmlEle;
	var count=ele.options.length;
	var prevalue="";
	if(ele.selectedIndex>=0)
		prevalue = ele.options[ele.selectedIndex].value;
	if(value==null)value = "";
	if(typeof(text)!="undefined")
	{	for(var i=0;i<count;i++)
			if(ele.options[i].value == value && ele.options[i].text == text)
			{	ele.selectedIndex=i;
				break;
			}
	}else 
	{	for(var i=0;i<count;i++)
			if(ele.options[i].value == value)
			{	
				ele.selectedIndex=i;//由于动态添加完Options后，立刻设置selectedIndex不产生效果
				try{ele.options[i].selected=true;}catch(e){}//使用此方法可以解决，但会产生异常
				break;
			}
	}
	/*if(prevalue!=value && ele.getAttribute("onchange"))
		ele.fireEvent("onchange");

	if(this.HtmlEle.getAttribute("SonEnumId"))
	{
	  ///这里是风险代码
	  this.SetSonEnum();
		//得到他子枚举的选项值
		//window.setTimeout("JcSelect.SetSonValue('"+this.HtmlEle.id+"')",1);
	}*/
			
}

JcSelect.prototype.SetSelectIndex=function(index)
{	var ele=this.HtmlEle;
	ele.selectedIndex = index;
			
}

/**<doc type="protofunc" name="JcSelect.AddItem">
	<desc>在JcSelect中加入一个Option</desc>
	<input>
		<param name="value" type="string">待加入的Option值</param>
		<param name="text" type="string">待加入的Option文本</param>
	</input>
</doc>**/
JcSelect.prototype.AddItem=function(value,text)
{	var opt=document.createElement("option");
	opt.value=value;
	opt.innerText=text;
	this.HtmlEle.appendChild(opt);
	return opt;
}

/**<doc type="protofunc" name="JcSelect.RemoveItem">
	<desc>在JcSelect中删除一个Option</desc>
	<input>
		<param name="index" type="object">如果index的类型为number,则删除Option列表的第index项;如果index的类型为string,则删除Option列表中与index值相同的项</param>
	</input>
</doc>**/
JcSelect.prototype.RemoveItem=function(index)
{	var ele=this.HtmlEle;
	var count=ele.options.length;
	if(typeof(index)=="number")
		ele.options.remove(index);
	else if(typeof(index)=="string")
	{	for(var i=0;i<count;i++)
			if(ele.options[i].value == index)
			{	
				ele.removeChild(ele.options[i]);
				//alert(ele.outerHTML);
				//ele.options.remove(i);
				
				break;
			}
	}	
}

/**<doc type="protofunc" name="JcSelect.SetReadonly">
	<desc>设置JcSelect是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcSelect.prototype.SetReadonly=function(st)
{	
	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	
	this._OldIndex=null;
	this._OldHandle=null;
	if(st)
	{	this._OldIndex=this.HtmlEle.selectedIndex;
		this._OldHandle=this.HtmlEle.onchange;
		this.HtmlEle.onchange=function(){this.selectedIndex=this.Co._OldIndex;};
	}else
	{
		this.HtmlEle.onchange=this._OldHandle;
	}
	if(this.Readonly)
		this.HtmlEle.style.backgroundColor=ReadonlyBgColor;
	else if(this.Disabled)
		this.HtmlEle.style.backgroundColor=DisabledBgColor;
	else
	{
		if(!this.AllowEmpty)
			this.HtmlEle.style.backgroundColor=MustInputBgColor;
		else
			this.HtmlEle.style.backgroundColor=NormalBgColor;
	}
}

/**<doc type="function" name="Global.SelectMultiChange">
	<desc>拉框级联 设置子枚举变化</desc>
	<input>
		<param name="cureleid" type="string">当前控件id</param>
		<param name="subid" type="string">当前子级联控件id</param>
		<param name="subdsid" type="string">子控件数据源对应数据岛id</param>
	</input>
</doc>**/
function SelectMultiChange(cureleid,subid,subdsid)
{
	var ds = GetDs(subdsid);
	var ctrl = document.getElementById(cureleid).Co;
	var subctrl = document.getElementById(subid).Co;
	var subenumkey = ctrl.OptionList.GetSubEnum(ctrl.GetValue());
	if(subenumkey)
	{	
		var subenum = ds.Enums(subenumkey);
		subctrl.Reset("enum",subenum);
		subctrl.SetValue("");
		
		var ele=subctrl.HtmlEle;
		ele.fireEvent("onchange");
	}else
	{
		subctrl.ClearOptionList();
		
		var ele=subctrl.HtmlEle;
		ele.fireEvent("onchange");
	}
}
//
//--------------------------------JcSelect对象定义结束---------------------------------------------------
//

//
//--------------------------------JcCheckBox对象定义开始 从JcInput继承---------------------------------------------------
//

/**<doc type="objdefine" name="JcCheckBox">
	<desc>JcCheckBox定义,由JcInput继承</desc>
</doc>**/
function JcCheckBox(ele)
{	this.Type="jccheckbox";
	this.Init(ele);
}
JcCheckBox.prototype=new JcInput();

/**<doc type="protofunc" name="JcCheckBox.Init">
	<desc>JcCheckBox的构建器</desc>
	<input>
		<param name="ele" type="object">JcCheckBox对应的HTML元素</param>
	</input>	
</doc>**/
JcCheckBox.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<input type='checkbox' class='jccheckbox' jctype='jccheckbox'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	var chked = this.HtmlEle.checked;
	this.SuperInit();
	this.SetValue(chked);
}

/**<doc type="protofunc" name="JcCheckBox.GetValue">
	<desc>取得JcCheckBox的值</desc>
	<output type="string">JcCheckBox的值,为"true"或"false"</output>
</doc>**/
JcCheckBox.prototype.GetValue=function(isFullValue)
{	if(isFullValue)
		return this.HtmlEle.checked +"";
	else
		return this.HtmlEle.checked?"T":"F";
}

/**<doc type="protofunc" name="JcCheckBox.SetValue">
	<desc>设置JcCheckBox的值</desc>
	<input>
		<param name="value" type="string">待设置的值,为"true"或"false"</param>
	</input>
</doc>**/
JcCheckBox.prototype.SetValue=function(value)
{	if(value==null)
		this.HtmlEle.checked=false;
	else
		this.HtmlEle.checked=ToBool(value);
}

/**<doc type="protofunc" name="JcCheckBox.SetReadonly">
	<desc>设置JcCheckBox是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcCheckBox.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	this.HtmlEle.disabled=st;
	/*this._OldClick=null;
	this._OldKeyDown=null;
	if(st)
	{	this._OldClick=this.HtmlEle.onclick;
		this._OldKeyDown=this.HtmlEle.onkeydown;
		this.HtmlEle.onclick=CancelEvent;
		this.HtmlEle.onkeydown=CancelEvent;
	}else
	{	this.HtmlEle.onkeydown=this._OldKeyDown;
		this.HtmlEle.onclick=this._OldClick;
	}*/
	if(!this.Disabled && this.Readonly)
		this.HtmlEle.style.backgroundColor=ReadonlyBgColor;
	else
		this.HtmlEle.style.backgroundColor=NormalBgColor;
}

//
//--------------------------------JcCheckBox对象定义结束---------------------------------------------------
//

//
//--------------------------------JcRadioGrp对象定义开始 从JcInput继承-------------------------------------
//

/**<doc type="objdefine" name="JcRadioGrp">
	<desc>JcRadioGrp定义,由JcInput继承</desc>
	<property>
		<prop name="Radios" type="Array">JcRadioGrp对应的Radio组</param>
	</property>		
</doc>**/
function JcRadioGrp(ele)
{	
	this.Type="jcradiogrp";
	this.Radios=new Array();
	this.Init(ele);
}
JcRadioGrp.prototype=new JcInput();

/**<doc type="protofunc" name="JcRadioGrp.Init">
	<desc>JcRadioGrp的构建器</desc>
	<input>
		<param name="ele" type="object">JcRadioGrp对应的HTML元素</param>
	</input>	
</doc>**/
JcRadioGrp.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcradiogrp' jctype='jcradiogrp'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	var eles = document.getElementsByName(ele.id+"_Item");
	for(var i=0;i<eles.length;i++)
	{	var name = eles[i].name;
		if(name && name.toLowerCase()==ele.id.toLowerCase()+"_item")
		{
			this.Radios[this.Radios.length]=eles[i];
		}	
	}
	for(var i=0;i<this.Radios.length;i++)
		this.Radios[i].Co=this;
	this.SuperInit();
	
	for(var i=0;i<this.Radios.length;i++)
	{	
		this.Radios[i].onclick=JcRadioGrp.OnClick;	
		this.Radios[i].style.backgroundColor=this.PreBgColor;
	}
	this.onclick=this.HtmlEle.attributes.getNamedItem("onclick").value;
}

/**<doc type="protofunc" name="JcRadioGrp.Fire">
	<desc>触发JcRadioGrp的eventname事件</desc>
	<input>
		<param name="eventname" type="string">触发的事件名，默认onclick事件，当前只支持onclick事件</param>
	</input>	
</doc>**/
JcRadioGrp.prototype.Fire=function(eventname)
{
	this.Event=new Object();
	this.Event.returnValue=true;
	if(!eventname){eventname = "onclick";}
	if(eventname=="onclick")
	{
		this.Event.Radio = event.srcElement;
		if(this.onclick)
			eval(this.onclick);
	}
	return this.Event.returnValue;
}
/**<doc type="protofunc" name="JcRadioGrp.Fire">
	<desc>触发JcRadioGrp的单击事件，且自动改变控件背景样式</desc>
</doc>**/
JcRadioGrp.OnClick=function()
{
	var obj=document.all((event.srcElement.name.split("_"))[0]).Co;
	for(var i=0;i<obj.Radios.length;i++)
	{	
		obj.Radios[i].style.backgroundColor=obj.PreBgColor;
	}
	obj.Fire("onclick");
}

/**<doc type="protofunc" name="JcRadioGrp.GetCheckedRadio">
	<desc>得到JcRadioGrp被选中的Radio</desc>
	<output type="object">返回选中的Radio</output>
</doc>**/
JcRadioGrp.prototype.GetCheckedRadio=function()
{	for(var i=0;i<this.Radios.length;i++)
		if(this.Radios[i].checked)
			return this.Radios[i];
	return null;
}

/**<doc type="protofunc" name="JcRadioGrp.GetValue">
	<desc>取得JcRadioGrp的值</desc>
	<output type="string">JcRadioGrp的值</output>
</doc>**/
JcRadioGrp.prototype.GetValue=function()
{	for(var i=0;i<this.Radios.length;i++)
		if(this.Radios[i].checked)
			return this.Radios[i].value;
	return "";
}

/**<doc type="protofunc" name="JcRadioGrp.SetValue">
	<desc>设置JcRadioGrp的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcRadioGrp.prototype.SetValue=function(value)
{	if(value==null)
	{	for(var i=0;i<this.Radios.length;i++)
		{	this.Radios[i].checked=false;
		}
	}else
	{	for(var i=0;i<this.Radios.length;i++)
		{	if(this.Radios[i].value==value)
				this.Radios[i].checked=true;
		}
	}
}

/**<doc type="protofunc" name="JcRadioGrp.CancelEvent">
	<desc>取消事件响应</desc>
</doc>**/
JcRadioGrp.CancelEvent=function()
{	event.returnValue=false;
	/*if(this.Co._OldChecked)
		this.Co._OldChecked.checked=true;*/
	return false;
}

/**<doc type="protofunc" name="JcRadioGrp.SetReadonly">
	<desc>设置JcRadioGrp是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcRadioGrp.prototype.SetReadonly=function(st)
{	
	for(var i=0;i<this.Radios.length;i++)
	{	var rdo=this.Radios[i];
		this.Readonly=st;
		rdo.disabled=st;
		if(!this.Disabled && this.Readonly)
			rdo.style.backgroundColor=ReadonlyBgColor;
		else
			rdo.style.backgroundColor=NormalBgColor;
			
	}
}

/**<doc type="protofunc" name="JcRadioGrp.SetDisabled">
	<desc>设置JcRadioGrp是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcRadioGrp.prototype.SetDisabled=function(st)
{	for(var i=0;i<this.Radios.length;i++)
	{	var rdo=this.Radios[i];
		this.Disabled=st;
		rdo.disabled=st;
		if(this.Disabled)
			rdo.style.backgroundColor=DisabledBgColor;
		else if(this.Readonly)
			rdo.style.backgroundColor=ReadonlyBgColor;
		else
		{
			if(!this.AllowEmpty)
				rdo.style.backgroundColor=MustInputBgColor;
			else
				rdo.style.backgroundColor=NormalBgColor;
		}
	}
}

/**<doc type="protofunc" name="JcRadioGrp.Validate">
	<desc>验证JcRadioGrp的有效性</desc>
</doc>**/
JcRadioGrp.prototype.Validate=function()
{	
	var selectRadio=this.GetCheckedRadio();
	var validateResult=new ValidateResult();
	
	if(!this.AllowEmpty)
		if(selectRadio==null)
		{
			validateResult.Message="必须选择！";
			validateResult.Passed=false;
		}	

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement("",valstr);
		
	if(!validateResult.Passed)	
	{
		for(var i=0;i<this.Radios.length;i++)
		{	
			this.Radios[i].style.backgroundColor=ErrorBgColor;
		}	
	}
	return validateResult;	
}

//
//--------------------------------JcRadioGrp对象定义结束---------------------------------------------------
//


//
//--------------------------------JcDropDown对象定义开始 从JcInput继承-------------------------------------
//
/**<doc type="objdefine" name="JcDropDown">
	<desc>JcDropDown定义,由JcInput继承</desc>
	<property>
		<prop name="DropType" type="string">JcDropDown的下拉类型:Calendar/List/Tree</param>
		<prop name="DropUrl" type="string">点击JcDropDown时对应的URL</param>
		<prop name="DropParam" type="string">JcDropDown的DropUrl对应的参数</param>
		<prop name="DropSize" type="string">JcDropDown的下拉框大小,以style的形式出现</param>
		<prop name="ReturnMode" type="string">JcDropDown返回的是单值(single)还是多值(multi)</param>
		<prop name="ReturnFields" type="string">JcDropDown返回的字段,以","分隔</param>
		<prop name="DropFrame" type="object">JcDropDown的下拉Frame</param>
		<prop name="SelectMode" type="object">JcDropDown的下拉Frame列表中的选择模式是单选(single)/多选(multi)</param>
	</property>		
</doc>**/
function JcDropDown(ele)
{
	this.Type="jcdropdown";
	this.DropType="";//所弹出的关联实体类型：Calendar,List,Tree
	this.DropMode="Normal";//弹出类型Normal/Url
	this.ListData = new DataList();
	this.DataType="";//日期类型:Normal,Start,End
	this.RelateDateID="";
	this.RelateStartDateID="";
	this.RelateEndDateID="";
	this.DropUrl="";
	this._DropUrl = "";
	this.DropParam="";
	this.DropSize="width:auto;height:auto;";
	this.ReturnMode="single";//single /multi/datalist
	this.ReturnFields=""; //id1,id2,id3
	this.DropFrame=null;
	this.MinWidth=null;
	this.MaxWidth=null;
	this.TClass="";
	this.AllowInput=true;
	//this.SelectMode="multi";	//add by yq_zhang 2008-7-29
	this.Init(ele);
}
JcDropDown.prototype=new JcInput();

/**<doc type="protofunc" name="JcDropDown.Init">
	<desc>JcDropDown的构建器</desc>
	<input>
		<param name="ele" type="object">JcDropDown对应的HTML元素</param>
	</input>	
</doc>**/
JcDropDown.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcdropdown' jctype='jcdropdown'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;

	if(ele.getAttribute("TClass"))
		this.TClass ="class='"+ ele.getAttribute("TClass")+"'";
	if(ele.getAttribute("DropParam"))
		this.DropParam = ele.getAttribute("DropParam");
	if(ele.getAttribute("ReturnParam"))
		this.ReturnParam = ele.getAttribute("ReturnParam");
	if(ele.getAttribute("DropUrl"))
		this.DropUrl = this._DropUrl = ele.getAttribute("DropUrl");
	if(ele.getAttribute("DropMode"))
		this.DropMode = ele.getAttribute("DropMode").toLowerCase();
	if(ele.getAttribute("MinWidth"))
		this.MinWidth = parseInt(ele.getAttribute("MinWidth"));
	if(ele.getAttribute("MaxWidth"))
		this.MaxWidth = parseInt(ele.getAttribute("MaxWidth"));
	//if(ele.getAttribute("SelectMode"))
	//	this.SelectMode = ele.getAttribute("SelectMode").toLowerCase();
	
	if(this.DropMode == "normal")
	{
		if(ele.getAttribute("ListData"))
			this.ListData = GetDsNode(ele.getAttribute("ListData"));
		if(ele.getAttribute("TextField"))
			this.TextField = ele.getAttribute("TextField") + "";
		if(ele.getAttribute("ValueField"))
			this.ValueField = ele.getAttribute("ValueField") + "";
		if(ele.getAttribute("SelectMode")=="Single")
		{  
		   this._DropUrl = "/share/page/ListPageSingle.htm";
		}
		else
		{
		   this._DropUrl = "/share/page/ListPage.htm";
		}
	}
	//添加多选情况 by t_wang 2008-11-21
	else if(this.DropMode == "multinormal")
	{
		if(ele.getAttribute("ListData"))
			this.ListData = GetDsNode(ele.getAttribute("ListData"));
		this._DropUrl = "/share/page/ListPage.htm";
	}

	if(ele.getAttribute("ReturnMode"))
		this.ReturnMode =ele.getAttribute("ReturnMode").toLowerCase();
	if(ele.getAttribute("ReturnFields"))
		this.ReturnFields =ele.getAttribute("ReturnFields");
	
	this.DropType=ele.getAttribute("DropType");
	if(ele.getAttribute("DataType"))
		this.DataType =ele.getAttribute("DataType");
	if(ele.getAttribute("RelateDateID"))
		this.RelateDateID =ele.getAttribute("RelateDateID");	
	if(ele.getAttribute("RelateStartDateID"))
		this.RelateStartDateID =ele.getAttribute("RelateStartDateID");	
	if(ele.getAttribute("RelateEndDateID"))
		this.RelateEndDateID =ele.getAttribute("RelateEndDateID");	
	if(ele.getAttribute("IsTime") == "T")
		this.IsTime = true;
	if(!this.DropType)this.DropType="List";
	var allowInput = (ele.getAttribute("AllowInput") + "").toLowerCase();
	if(allowInput == "true" || allowInput == "")
		this.AllowInput = true;
	this.SuperInit();
	this.RenderObject();
}

/**<doc type="protofunc" name="JcDropDown.OnContentChange">
	<desc>JcDropDown的内容改变时触发，处理临时值并尝试执行oncontentchange属性对应方法</desc>
</doc>**/
JcDropDown.OnContentChange = function()
{
	var ele=GetParentJcElement(event.srcElement);
	//alert(ele.Co.TempValue);
	var obj = ele.Co;
	if(!obj.TempValue)
	{
		if(obj.GetValue())
		{
			obj.TempValue = obj.GetValue();
			try{eval(ele.getAttribute("oncontentchange"))}catch(e){};//this对象指向的是Jc对象			
		}
	}
	else
	{
		if("" + obj.TempValue != "" + obj.GetValue())
		{
			obj.TempValue = obj.GetValue();
			try{eval(ele.getAttribute("oncontentchange"))}catch(e){};//this对象指向的是Jc对象
		}	
	}
}

/**<doc type="protofunc" name="JcDropDown.SetDropUrl">
	<desc>JcDropDown的内容改变时触发，处理临时值并尝试执行oncontentchange属性对应方法</desc>
</doc>**/
JcDropDown.prototype.SetDropUrl = function()
{
	var dropParam = "";
	if(this.DropParam)
	{
		var sp = new StringParam(this.DropParam);
		for(var i=0;i<sp.GetCount();i++)
		{
			dropParam += sp.Keys[i]+":";
			if(document.all(sp.Get(i)).Co)
				dropParam+=escape(document.all(sp.Get(i)).Co.GetValue())+";";
			else
				dropParam+=escape(document.all(sp.Get(i)).value)+";";	
		}
	}
	if(this._DropUrl.indexOf("?")>=0)
		this.DropUrl = this._DropUrl + "&CallElementId="+this.HtmlEle.id+"&DropParam="+dropParam;
	else
		this.DropUrl = this._DropUrl + "?CallElementId="+this.HtmlEle.id+"&DropParam="+dropParam;
	if(this.DropMode == "normal" || this.DropMode == "multinormal") //修改为可单选或多选 by t_wang 2008-11-24
	{
		JcDropDown._DropData = this.ListData;
	}
}

/**<doc type="protofunc" name="JcDropDown.ResetListData">
	<desc>重设控件ListData</desc>
	<input>
		<param name="dataList" type="string/object">设置当前ListData数据源</param>
	</input>
</doc>**/
JcDropDown.prototype.ResetListData = function(dataList)
{
	var xml = "";
	if(typeof dataList == "object")
		xml = dataList.ToString();
	else
		xml = dataList;
	this.ListData = new DataList(xml);
}

/**<doc type="protofunc" name="JcDropDown.GetCurDropData">
	<desc>获取此控件的_DropData</desc>
</doc>**/
JcDropDown.GetCurDropData = function()
{
	return JcDropDown._DropData;
}

/**<doc type="protofunc" name="JcDropDown.RenderObject">
	<desc>绘制JcDropDown</desc>
</doc>**/
JcDropDown.prototype.RenderObject=function()
{	
	var ele=this.HtmlEle;
	if(this.Render=="client")
	{	var elesrc = "<table cellspacing='0' cellpadding='0' border='0' style='width:100%'><tr>"+
			"<td><input   "+this.TClass+"  id='_text' type=text class='" + this.SubCss("Text") + "' style='width:100%' readonly onpropertychange='JcDropDown.OnContentChange();'></td>";
		if(this.DropType.toLowerCase()=="calendar")
			elesrc+="<td style='width:20;'><button id='_btn' class='" + this.SubCss("DateButton") + "' style='width:100%;height:21;background-image: url(/share/image/jsctrl/datebtndropdown.gif);'></button></td>";
		else	
			elesrc+="<td style='width:20;'><button id='_btn' class='" + this.SubCss("Button") + "' style='width:100%;height:21;'><img src='/share/image/jsctrl/btndropdown.gif'></button></td>";
		elesrc+="</tr></table>";
		ele.innerHTML= elesrc;
	}
	ele.style.height=20;
	var drop=null;
	if(this.DropType.toLowerCase()=="list")
	{	
		//this.SetDropUrl();
		//把Iframe元素添加到body元素中
		drop = document.createElement("<iframe id='_drop_"+ele.id+"' frameborder='0' scrolling='no' style='border:solid 1;position:absolute;z-index:10000;left:1;top:1;display:none;"+this.DropSize+"' src='"+this.DropUrl+"'></iframe>");
		//drop.className = this.SubCss("Drop");
		document.body.appendChild(drop);
	}	
	else if(this.DropType.toLowerCase()=="calendar")
	{
		drop = window.document.all("gToday:normal:agenda.js");
		if (drop==null)
		{	drop = window.document.createElement("<IFrame id='gToday:normal:agenda.js' frameborder='0' scrolling='no' name='gToday:normal:agenda.js' src='/share/js/date2/ipopeng.htm' style='position:absolute;top:0;left:0;display:none;'></iframe>");
			document.body.appendChild(drop);
		}
		if(this.AllowInput)
		{
			var _text = this.HtmlEle.all("_text");
			_text.readOnly = false;
			_text.onpropertychange = "";//_text.detachEvent("onpropertychange",JcDropDown.OnContentChange);
			_text.attachEvent("onfocus",JcDropDown.Focus);
			_text.attachEvent("onblur",JcDropDown.Blur);
			_text.PreValue = "";
		}
	}	
	this.DropFrame = drop;
	this.DropFrame.Master=this;//把Iframe元素和控制元素建立关联
	
	ele.all("_btn").onmousedown=JcDropDown.BtnMouseDown;
	ele.all("_btn").onclick=JcDropDown.BtnClick;
	drop.onblur=JcDropDown.DropBlur;
	if(!this.AllowEmpty)
		this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
}

/**<doc type="protofunc" name="JcDropDown.Focus">
	<desc>JcDropDown获得焦点时触发</desc>
</doc>**/
JcDropDown.Focus = function()
{
	var _text = event.srcElement;
	var ele = GetParentJcElement(_text);
	var drop = ele.Co.DropFrame;
	if(drop.style.display == "" && parseInt(drop.style.left) == ele.offsetLeft && parseInt(drop.style.top) == ele.offsetTop + ele.offsetHeight)
		JcDropDown.BtnClick();
	_text.select();
	if(JcDropDown.IsDate(_text.value))
		_text.PreValue = _text.value;
	JcDropDown.BtnClick();
}

/**<doc type="protofunc" name="JcDropDown.Focus">
	<desc>JcDropDown失去焦点时触发</desc>
</doc>**/
JcDropDown.Blur = function()
{
	var _text = event.srcElement;
	var value = _text.value;
	if(value == "") return;
	var isDate = JcDropDown.IsDate(value);
	if(isDate)
	{
		value = Date.parseDate(value).getDatePart();
		_text.value = value;
		if(!JcDropDown.CheckDate(_text))
			_text.value = _text.PreValue + "";
		else
			JcDropDown.OnContentChange();
		return;
	}
	if(IsInt(value))
	{
		var format = "";
		switch(value.length)
		{
			case 4:
				format = (new Date()).getFullYear() + "-" + value.substr(0,2) + "-" + value.substr(2,2);
				break;
			case 6:
				var year = value.substr(0,2) > 30 ? "19":"20";
				format = year + value.substr(0,2) + "-" + value.substr(2,2) + "-" + value.substr(4,2);
				break;
			case 8:
				format = value.substr(0,4) + "-" + value.substr(4,2) + "-" + value.substr(6,2);
				break;
			default:
				_text.value = _text.PreValue + "";
				return;
		}
		isDate = JcDropDown.IsDate(format);
		if(isDate)
		{
			_text.value = format;
			if(!JcDropDown.CheckDate(_text))
				_text.value = _text.PreValue + "";
			else
				JcDropDown.OnContentChange();
		}
		else
			_text.value = _text.PreValue + "";
	}
	else
		_text.value =  _text.PreValue + "";
}

/**<doc type="protofunc" name="JcDropDown.Focus">
	<desc>检查相应时间是否为日期时间型，有缺陷</desc>
</doc>**/
JcDropDown.IsDate = function(value)
{
	var re = /^\d{4}-\d{1,2}-\d{1,2}$/;
	//var re1 = /^\d{1,2}\\\d{1,2}\\\d{4}$/;	// 解决不同日期格式问题
	var r = value.match(re);
	if (r == null)
		return false;
	else
	{
		var s = value.split("-");
		var date = new Date(s[0],s[1] - 1,s[2]);
		if(date.getFullYear() != s[0] || date.getMonth() != s[1] - 1 || date.getDate() != s[2])
			return false;
		else if(date.getFullYear() < 1900 || date.getFullYear() > 2030)
			return false;
	}
	return true;
}

/**<doc type="protofunc" name="JcDropDown.Focus">
	<desc>检查相应时间是否满足一定格式</desc>
</doc>**/
JcDropDown.CheckDate = function(textele)
{
	var ele = GetParentJcElement(textele);
	if(ele.Co.DataType.toLowerCase() == "start")
	{
		var relDate = document.all(ele.Co.RelateDateID).all("_text").value;
		if(relDate == "") return true;
		if(textele.value > relDate)
		{
			alert("输入的日期不能在结束日期之后!")
			return false;
		}
	}
	else if(ele.Co.DataType.toLowerCase() == "end")
	{
		var relDate = document.all(ele.Co.RelateDateID).all("_text").value;
		if(relDate == "") return true;
		if(textele.value < relDate)
		{
			alert("输入的日期不能在开始日期之前!")
			return false;
		}
	}
	return true;
}


/**<doc type="protofunc" name="JcDropDown.BtnMouseDown">
	<desc>定义JcDropDown的左键按下事件，为内部方法一般不作外部调用</desc>
</doc>**/
JcDropDown.BtnMouseDown=function()
{
	if(event.button != 1) return;
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co,drop=obj.DropFrame;
	if(obj.DropType.toLowerCase() == "list")
	{
		obj.SetDropUrl();
		drop.src = obj.DropUrl;
	}
}

/**<doc type="protofunc" name="JcDropDown.BtnMouseDown">
	<desc>定义JcDropDown的获取焦点事件，为内部方法一般不作外部调用</desc>
</doc>**/
JcDropDown.OnFocus=function()
{
	var ele=GetParentJcElement(event.srcElement);
	ele.all("_text").style.backgroundColor=ele.Co.PreBgColor;	
	ele.style.backgroundColor=ele.Co.PreBgColor;
}

/**<doc type="function" name="Global.ClickEvent">
	<desc>触发jc控件的oncontentchange属性对应的方法</desc>
</doc>**/
function ClickEvent()
{
	var ele=GetParentJcElement(event.srcElement);
	if(!ele.Co.TempValue)
	{
		if(ele.Co.GetValue())
		{
		ele.Co.TempValue = ele.Co.GetValue();
		try{eval(ele.getAttribute("oncontentchange"))}catch(e){};//this对象指向的是Jc对象			
		}
	}
	else
	{
		if("" + ele.Co.TempValue != "" + ele.Co.GetValue())
		{
			ele.Co.TempValue = ele.Co.GetValue();
			try{eval(ele.getAttribute("oncontentchange"))}catch(e){};//this对象指向的是Jc对象
		}	
	}
}

/**<doc type="protofunc" name="JcDropDown.BtnClick">
	<desc>定义JcDropDown的点击事件</desc>
</doc>**/
JcDropDown.BtnClick=function()
{	
	JcDropDown.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	//by crow 
	try{eval(ele.getAttribute("ClickBeforeEvent"))}catch(e){};
	
	//end
	var obj=ele.Co,drop=obj.DropFrame;
	if(obj.DropType.toLowerCase()=="list")
	{	
		if(drop.style.display== "none")
		{	drop.style.left = Position.Left(ele);
			drop.style.top = Position.Top(ele)+Position.Height(ele);
			drop.style.backgroundColor="blue";
			drop.style.display="block";
			var width = obj.HtmlEle.offsetWidth;
			if(obj.MinWidth && width < obj.MinWidth)
				width = obj.MinWidth;
			if(obj.MaxWidth && width > obj.MaxWidth)
				width = obj.MaxWidth;
			drop.style.width = width;
			drop.style.height = "150px";
			drop.focus();
		}else
			drop.style.display="none";
	}	
	else if(obj.DropType.toLowerCase()=="calendar")
	{
		drop.style.display = "";
		if(obj.DataType.toLowerCase()=="normal")
		{
			gfPop.fPopCalendar(ele.all("_text"));
		}
		else if(obj.DataType.toLowerCase()=="start")
		{
			gfPop.fStartPop(ele.all("_text"),document.all(obj.RelateDateID).all("_text"));
		} 
		else if(obj.DataType.toLowerCase()=="end")
		{
			gfPop.fEndPop(document.all(obj.RelateDateID).all("_text"),ele.all("_text"));
		}
		else if(obj.DataType.toLowerCase()=="startend")
		{
			gfPop.fStartEndPop(ele.all("_text"),document.all(obj.RelateStartDateID).all("_text"),document.all(obj.RelateEndDateID).all("_text"));
		}	
	}
}

/**<doc type="protofunc" name="JcDropDown.DropBlur">
	<desc>定义JcDropDown的丢失焦点事件</desc>
</doc>**/
JcDropDown.DropBlur=function()
{	
	var obj=this.Master,drop=obj.DropFrame;
	//edit by yukai 2006-9-17 for the reason:使用submit方式会报错
	if(drop==null)
		return;
	if(drop.id != "gToday:normal:agenda.js")
	{
		drop.style.display="none";
	}
}

/**<doc type="protofunc" name="JcDropDown.SetReturn">
	<desc>设置JcDropDown的返回值</desc>
	<input>
		<param name="rtnstr" type="string">JcDropDown的返回值</param>
	</input>	
</doc>**/
JcDropDown.prototype.SetReturn=function(rtnstr)
{	
	this.returnValue=true;
	this.ReturnString=rtnstr;
	try{	eval(this.HtmlEle.getAttribute("onreturnbefore"));//this对象指向的是Jc对象
	}catch(e){}
	
	if(this.returnValue)
	{	switch(this.ReturnMode)
		{	case "single":
				this.HtmlEle.all("_text").value = this.ReturnString;
				break;
			case "multi":
				var flds = this.ReturnFields.split(",");
				var sp = new StringParam(this.ReturnString);
				for(var i=0;i<flds.length;i++)
				{	if(sp[flds[i]])
						document.all(flds[i]).SetValue(sp[flds[i]]);
				}
				break;
			case "datalist":
				var sp=new StringParam(this.ReturnParam);
				var dataList=new DataList(this.ReturnString);
				var dataItems=dataList.GetItems();
				var fieldValues=new Array();
				for(var j=0;j<sp.GetCount();j++)
				{
					fieldValues[j]="";
				}			
				for(var i=0;i<dataItems.length;i++)
				{
					for(var j=0;j<sp.GetCount();j++)
					{
						fieldValues[j]+=dataItems[i].GetAttr(sp.Get(j))+","
					}
				}
				for(var j=0;j<sp.GetCount();j++)
				{
					if(fieldValues[j].substring(fieldValues[j].length-1,fieldValues[j].length)==",")
						fieldValues[j]=fieldValues[j].substring(0,fieldValues[j].length-1);
					var obj=document.all(sp.Keys[j]);
					/////////////////////////////////兼容列表中多选控件////////////////////////
					if ( obj != null )
					{
						if(obj.Co)
							obj.Co.SetValue(fieldValues[j]);
						else
							obj.value=fieldValues[j];
					}
					else
					{
						newStr += fieldValues[j]+",";
						if ( j == sp.GetCount() - 1 )
						{
							this.HtmlEle.all("_text").value = newStr.substring(0,newStr.length-1);
						}
					}
					///////////////////////////////////////////////////////////////////////
				}
				
			break;
		}
		
	}
	
	try{	eval(this.HtmlEle.getAttribute("onreturnafter"));//this对象指向的是Jc对象
	}catch(e){}
}

/**<doc type="protofunc" name="JcDropDown.GetValue">
	<desc>取得JcDropDown的值</desc>
	<output type="string">JcDropDown的值</output>
</doc>**/
JcDropDown.prototype.GetValue=function()
{
    //这里处理带有时间的日期控件 第一版
    if(this.DropType.toLowerCase()=="calendar"&&this.HtmlEle.getAttribute("RelateTime")&&this.HtmlEle.all("_text").value.trim()!="")
    {
        var regstr=/(\d{4}-\d{1,2}-\d{1,2})\s(\d{1,2})[:](\d{1,2})/; //取出日期
		//var LeaveDateCom=dfrm.GetValue("LeaveDate").match(regstr);
		//if(LeaveDateCom)
			
		var RelateTimes=this.HtmlEle.getAttribute("RelateTime");
		var spc=new StringParam(RelateTimes);
		if(spc.GetCount()==2)
		{
			var Hoursc=spc.Get("Hour");
			var Minutesc=spc.Get("Minute");
			
			if(Hoursc.trim()!=""&&Minutesc.trim()!="")
			{
				var HourValue=Co[Hoursc].GetValue();
				var MinuteValue=Co[Minutesc].GetValue();
			    
				if(HourValue.trim()=="")
				HourValue="00";
				if(MinuteValue.trim()=="")
				MinuteValue="00";
			    
				var DateTimesc=this.HtmlEle.all("_text").value+" "+HourValue.trim()+":"+MinuteValue.trim();
			    
				var DateTimeReg=DateTimesc.match(regstr);
			    
				if(DateTimeReg)
				{
					return DateTimesc;
				}
				else
				{
					return "";
				}
		    }
		    else
				return "";
		}
		
		//var spc=new StringParam(SetLinkId);
    }
    
	return "" + this.HtmlEle.all("_text").value;
}

/**<doc type=
"protofunc" name="JcDropDown.SetValue">
	<desc>设置JcDropDown的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcDropDown.prototype.SetValue=function(value)
{
	if(value == null)
		value = "";
		
	//这里设置待时间的控件
	
	if(this.DropType.toLowerCase()=="calendar"&&this.HtmlEle.getAttribute("RelateTime")&&value!="")
	{
		var regstr=/(\d{4}-\d{1,2}-\d{1,2})\s(\d{1,2})[:](\d{1,2})/; //取出日期
			//var LeaveDateCom=dfrm.GetValue("LeaveDate").match(regstr);
			//if(LeaveDateCom)
		var DateTimeReg=value.match(regstr);
		if(DateTimeReg)
		{
			var RelateTimes=this.HtmlEle.getAttribute("RelateTime");
			var spc=new StringParam(RelateTimes);
			if(spc.GetCount()==2)
			{
				var Hoursc=spc.Get("Hour");
				var Minutesc=spc.Get("Minute");
				
				if(Hoursc.trim()!=""&&Minutesc.trim()!="")
				{
				    //这里做特殊处理 为的适应任何的 时间的枚举值
				    if(Co[Hoursc].HtmlEle.tagName.toLowerCase()=="select")
				    {
						//获取枚举值
						var HEValue= Co[Hoursc].OptionList.GetItem(0).GetAttr("Value");
						
						if(HEValue.length==2)
						{
							if(DateTimeReg[2].length==1)
							{
								DateTimeReg[2]="0"+DateTimeReg[2]
							}
						}
						//var HourscEnum=GetDsNode(Co[Hoursc].OptionList);
						//alert(HourscEnum);
				    }
				    
				    //数据库存储的 分钟的枚举值不超过10的时候  必定是2为 如:00,01  如果页面上的枚举值 是如:0,1,2 这样将无法找到匹配的值
				    if(Co[Minutesc].HtmlEle.tagName.toLowerCase()=="select")
				    {
						var HMValue= Co[Minutesc].OptionList.GetItem(0).GetAttr("Value");
						if(HMValue.length==1)
						{
							if(DateTimeReg[3].length==2)
							{
								if(DateTimeReg[3].substring(0,1)=="0")
								{
									DateTimeReg[3]=DateTimeReg[3]-0;
									DateTimeReg[3]=DateTimeReg[3]+"";
								}
							}
						}
						
				    }
					Co[Hoursc].SetValue(DateTimeReg[2]);
					Co[Minutesc].SetValue(DateTimeReg[3]);
				}
			}
		}
	}
	
	///------------------------------------------------------------------
	if(this.DropType.toLowerCase()=="calendar")
	{
		if(parseInt(value.split('-')[0]) < 1900)
			value = "";
		if(value.indexOf(" ") >= 0)
			value = value.substring(0,value.indexOf(" "));	
	}	
	this.HtmlEle.all("_text").value=value;
}

/**<doc type="protofunc" name="JcDropDown.SetDisabled">
	<desc>设置JcDropDown是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcDropDown.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this.HtmlEle.all("_text").disabled=st;
	this.HtmlEle.all("_btn").disabled = st;
	if(this.Disabled)
	{
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
		this.HtmlEle.style.backgroundColor = DisabledBgColor;
	}	
	else if(this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;
		this.HtmlEle.all("_btn").disabled = true;
	}	
	else
	{
		if(!this.AllowEmpty)
		{
			this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
			this.HtmlEle.style.backgroundColor=MustInputBgColor;
		}
		else
		{
			this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
			this.HtmlEle.style.backgroundColor = NormalBgColor;
		}
	}	
}

/**<doc type="protofunc" name="JcDropDown.SetReadonly">
	<desc>设置JcDropDown是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcDropDown.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	//this.HtmlEle.all("_text").readOnly=st;
	this.HtmlEle.all("_text").className = st?"":this.SubCss("Text");
	this.HtmlEle.all("_btn").style.display=st?"none":"";
	if(!this.Disabled && this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;
	}	
	else
	{
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
		this.HtmlEle.style.backgroundColor = NormalBgColor;
	}	
}

/**<doc type="protofunc" name="JcDropDown.Validate">
	<desc>
	对控件内容进行合法性验证
	验证字符串格式：ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
	</desc>
	<output type="object">返回ValidateResult对象</output>
</doc>**/
JcDropDown.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 
		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
	}
	return validateResult;	
}

//
//--------------------------------JcDropDown对象定义结束---------------------------------------------------
//

//
//--------------------------------JcFile对象定义开始 从JcInput继承----------------------------------------
//
/**<doc type="objdefine" name="JcFile">
	<desc>JcFile定义,由JcInput继承</desc>
	<property>
		<prop name="FileMode" type="string">JcFile是否为多文件控件，默认为single/multi</param>
	</property>
</doc>**/
function JcFile(ele)
{
	this.Type = "jcfile";
	this.FileMode = "single";
	this.Init(ele);
}
JcFile.prototype=new JcInput();

/**<doc type="protofunc" name="JcFile.Init">
	<desc>JcFile的构建器</desc>
	<input>
		<param name="ele" type="object">JcFile对应的HTML元素</param>
	</input>	
</doc>**/
JcFile.prototype.Init=function(ele)
{	
	if(!ele)
		ele = document.createElement("<span class='jcfile' jctype='jcfile'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co = this;
	
	if(ele.getAttribute("FileMode"))
		this.FileMode = ele.getAttribute("FileMode").toLowerCase();
		
	if(ele.getAttribute("ViewAble"))
		this.ViewAble = ele.getAttribute("ViewAble").toLowerCase();

	this.SuperInit();
			
	if(this.FileMode == "multi")
	{
		this.FileTemplateString =   "<table width=100%>" + 
										"<tbody>" +
											"<tr>" +
												"<td align=right width=5><input type=checkbox id=_FileId value='?FileId?'></td>" +
												"<td width=16><img width=16 height=16 src='/share/image/jsctrl/JsCoolBar/ico/040_S.ico'></img></td>" +
												"<td align=left><span class='" + this.SubCss("MultiMode_FileName") + "' id=_FileName><a onclick=JcFile.DoDownload('?TrueId?','"+ele.id+"') href='#'>?FileName?</a></span></td>" +
											"</tr>" +										
										"</tbody>" +									
									"</table>"; 	
	}	

	this.RenderObject();
	this.InitEvent();	
}

/**<doc type="protofunc" name="JcFile.DoDownload">
	<desc>查看JcFile中的文件时触发</desc>
	<input>
		<param name="TrueId" type="string">文件Id</param>
		<param name="cid" type="string">控件状态</param>
	</input>	
</doc>**/
JcFile.DoDownload = function(TrueId,cid)//edit by shawn for force priviledge // 设置为Readonly时可以下载 bu t_wang 2008-11-11
{
	if(!cid)
		return;
	if(Co[cid].Disabled)
		return;
	else
		LinkTo("/SysModule/FileSystem/Download.aspx?IsExec=true&Key=Goodway_BE-DownLoad&Id=" + TrueId,"_blank","width=800,height=600,top=20000,left=20000");
}

/**<doc type="protofunc" name="JcFile.DoDownload">
	<desc>初始化JcFile中按钮控件事件</desc>
</doc>**/
JcFile.prototype.InitEvent=function()
{	
	var ele=this.HtmlEle;
	ele.all("_addbtn").onclick=JcFile.AddBtnClick;
	ele.all("_clearbtn").onclick=JcFile.ClearBtnClick;
	//单文件附件没有删除按钮
	if(ele.all("_removebtn"))
		ele.all("_removebtn").onclick=JcFile.RemoveBtnClick;
	if(ele.all("_viewbtn"))
		ele.all("_viewbtn").onclick=JcFile.ViewBtnClick;		
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>构建单选JcFile控件的HTML代码</desc>
</doc>**/
JcFile.prototype.RenderSingleModeObject = function()
{
    var elesrc;
    if(this.ViewAble=="false")
	{
		elesrc = "<table cellspacing='0' cellpadding='1' border='0' style='height:20;width:100%'>" +
					"<tr>" +
						"<td>" +
							"<input id='_value' value='' type='hidden'>" +
							"<input id='_text' readonly class='" + this.SubCss("Text") + "' style='width:100%'>" +
						"</td>" +
						"<td style='width:20;padding-right:4;padding-left:4'>" +
							"<button id='_addbtn' class='" + this.SubCss("AddButton") + "'>添加</button>" + 
						"</td>" +
						"<td style='width:20;padding-right:4;'>" +
							"<button id='_clearbtn' class='" + this.SubCss("ClearButton") + "'>清空</button>" + 
						"</td>" +											
					"</tr>" +
				  "</table>";
	}
	else
	{
	      elesrc = "<table cellspacing='0' cellpadding='1' border='0' style='height:20;width:100%'>" +
					"<tr>" +
						"<td>" +
							"<input id='_value' value='' type='hidden'>" +
							"<input id='_text' readonly class='" + this.SubCss("Text") + "' style='width:100%'>" +
						"</td>" +
						"<td style='width:20;padding-right:4;padding-left:4'>" +
							"<button id='_addbtn' class='" + this.SubCss("AddButton") + "'>添加</button>" + 
						"</td>" +
						"<td style='width:20;padding-right:4;'>" +
							"<button id='_clearbtn' class='" + this.SubCss("ClearButton") + "'>清空</button>" + 
						"</td>" +	
						"<td style='width:20;padding-right:4;'>" +
							"<button id='_viewbtn' class='" + this.SubCss("ClearButton") + "'>浏览</button>" + 
						"</td>" +												
					"</tr>" +
				  "</table>";
	}
	this.HtmlEle.innerHTML = elesrc;
	this.ValidateEle = "_text";
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>构建多选JcFile控件的HTML代码</desc>
</doc>**/
JcFile.prototype.RenderMultiModeObject = function()
{
	var elesrc = "<table border='0' width='100%' id='table1'>" +
					"<tr>" +
						"<td>" +
							"<span id=_BodyMain class='" + this.SubCss("MultiMode_BodyMain") + "'></span>" +
						"</td>" +
						"<td width='40'>" +
							"<table border='0' width='100%'><tr><td><input type='button' value='添加'  class='" + this.SubCss("AddButton") + "' ID='_addbtn'></td></tr>" +
							"<tr><td><input type='button' value='删除'  class='" + this.SubCss("RemoveButton") + "' ID='_removebtn'></td></tr>" +
							"<tr><td><input type='button' value='清空'  class='" + this.SubCss("ClearButton") + "' ID='_clearbtn'></td></tr></table>" +
						"</td>" +
					"</tr>" +
				  "</table>";
	this.HtmlEle.innerHTML = elesrc;	
	this.ValidateEle = "_BodyMain";
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>构建JcFile控件的HTML代码</desc>
</doc>**/
JcFile.prototype.RenderObject=function()
{
	if(this.FileMode == "single")
		this.RenderSingleModeObject();
	else if(this.FileMode == "multi")
		this.RenderMultiModeObject();
	
	if(!this.AllowEmpty)
		this.HtmlEle.all(this.ValidateEle).style.backgroundColor=MustInputBgColor;					
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>JcFile控件获取焦点时触发</desc>
</doc>**/
JcFile.OnFocus=function()
{
	var ele=GetParentJcElement(event.srcElement);
	ele.all(ele.Co.ValidateEle).style.backgroundColor=ele.Co.PreBgColor;	
	ele.style.backgroundColor=ele.Co.PreBgColor;	
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>JcFile点击清空按钮时触发</desc>
</doc>**/
JcFile.ClearBtnClick = function()
{
	JcFile.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	obj.SetValue("");
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>JcFile点击查看按钮时触发</desc>
</doc>**/
JcFile.ViewBtnClick = function()
{
	JcFile.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	if(obj.GetValue().trim() == "")
		return false;
	LinkTo("/SysModule/FileSystem/Download.aspx?IsExec=true&Key=Goodway_BE-DownLoad&Id=" + escape(obj.GetValue()),"_Blank",CenterWin("width=800,height=600"));
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>JcFile点击删除按钮时触发</desc>
</doc>**/
JcFile.RemoveBtnClick = function()
{
	JcFile.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	obj.RemoveValue();	
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>JcFile点击添加按钮时触发</desc>
</doc>**/
JcFile.AddBtnClick = function()
{	
	JcFile.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	var returnValue = "";
	if(obj.FileMode == "single")
	{
		returnValue = window.showModalDialog("/share/upload/UploadSingle.aspx",1,"dialogHeight:364px; dialogWidth:495px;edge:Sunken; help:No; resizable:no; status:No;scroll=no;");
		obj.SetValue(returnValue);
	}	
	else if(obj.FileMode == "multi")
	{
		returnValue = window.showModalDialog("/share/upload/UploadMulti.aspx",1,"dialogHeight:468px; dialogWidth:568px;edge:Sunken; help:No; resizable:no; status:No;scroll=no;");	
		obj.AddValue(returnValue);
	}	
	
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>获取JcFile控件内文件名字符串</desc>
</doc>**/
JcFile.prototype.GetText = function()
{
	if(this.FileMode == "single")
		return this.HtmlEle.all("_text").value;
	else if(this.FileMode == "multi")
	{
		var names = "";
		var item = ToArray(document.all("_FileName"));
		for(var i = 0;i < item.length;i++)
		{
			names += item[i].innerHTML + ",";
		}	
		if(names.substring(names.length - 1,names.length) == ",")
			names = names.substring(0,names.length - 1);
		return names;		
	}	
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>获取JcFile控件内文件Id字符串</desc>
</doc>**/
JcFile.prototype.GetValue = function()
{
	if(this.FileMode == "single")
		return this.HtmlEle.all("_value").value;
	else if(this.FileMode == "multi")
	{
		var ids = "";
		var item = ToArray(this.HtmlEle.all("_FileId"));
		for(var i = 0;i < item.length;i++)
		{
			ids += item[i].value + ",";
		}
		if(ids.substring(ids.length - 1,ids.length) == ",")
			ids = ids.substring(0,ids.length - 1);	
		return ids;			
	}
}

/**<doc type="protofunc" name="JcFile.RenderSingleModeObject">
	<desc>获取JcFile内清空文件</desc>
</doc>**/
JcFile.prototype.Clear = function()
{
	if(this.FileMode.toLowerCase() == "single")
	{
		this.HtmlEle.all("_value").value = "";
		this.HtmlEle.all("_text").value = "";
	}	
	else
	{
	var item = this.HtmlEle.all("_BodyMain").childNodes;
	var itemCount = item.length;
	for(var i = 0;i < itemCount;i++)
		this.HtmlEle.all("_BodyMain").removeChild(item[0]);	
	}
}

/**<doc type="protofunc" name="JcFile.Init">
	<desc>向JcFile添加文件</desc>
	<input>
		<param name="value" type="string">文件信息</param>
	</input>	
</doc>**/
JcFile.prototype.AddValue = function(value)
{
	var fileId = value.split(",");
	for(var i = 0;i < fileId.length;i++)
	{
		if(fileId[i].trim() != "")
		{
			var span = document.createElement("<span style='width:100;height:20'>");
			this.HtmlEle.all("_BodyMain").appendChild(span);
			var name = "";
			var trueId = "";
			if(fileId[i].substring(3,4) == "+")
			{
				name = fileId[i].substring(fileId[i].lastIndexOf("+") + 1,fileId[i].length);
				trueId = fileId[i];
			}	
			else
			{
				name = fileId[i].substring(fileId[i].lastIndexOf("_") + 1,fileId[i].length);
				trueId = fileId[i].substring(0,fileId[i].lastIndexOf("_"));
			}
			span.innerHTML = this.FileTemplateString.replace("?FileName?",name).replace("?FileId?",fileId[i]).replace("?TrueId?",escape(trueId));			
		}
	}
}

/**<doc type="protofunc" name="JcFile.GetParantSpanElement">
	<desc>得到子控件的父控件引用</desc>
	<input>
		<param name="ele" type="obj">子控件</param>
	</input>	
</doc>**/
JcFile.prototype.GetParantSpanElement = function(ele)
{
	while(ele != null & ele.tagName.toLowerCase() !="span")
		ele = ele.parentElement;
	return ele;
}

/**<doc type="protofunc" name="JcFile.RemoveValue">
	<desc>从JcFile移除所有值信息</desc>
</doc>**/
JcFile.prototype.RemoveValue = function()
{
	var item = ToArray(this.HtmlEle.all("_FileId"));
	var removeItem = new Array();
	for(var i = 0;i < item.length;i++)
	{
		if(item[i].checked == true)
		{
			var ele = this.GetParantSpanElement(item[i]);
			if(ele != null)
				removeItem[removeItem.length] = ele;
		}
	}
	for(var i = 0;i < removeItem.length;i++)
		this.HtmlEle.all("_BodyMain").removeChild(removeItem[i]);
}

/**<doc type="protofunc" name="JcFile.Fire">
	<desc>从JcFile触发相应类型信息方法</desc>
</doc>**/
JcFile.prototype.Fire=function(type)
{	var onfunc=this.HtmlEle.getAttribute(type);
	if(onfunc)
		eval(onfunc);
}

/**<doc type="protofunc" name="JcFile.SetValue">
	<desc>设置JcFile值</desc>
	<input>
		<param name="ele" type="">设置控价值</param>
	</input>	
</doc>**/
JcFile.prototype.SetValue = function(value)
{	
	this.Event = new Object();
	this.Event.returnValue=true;
	this.Event.Value=value;
	this.Fire("OnContentChange");
	if(!this.Event.returnValue)
	{	
		return false;
	}
	
	if(this.FileMode == "single")
	{
		this.HtmlEle.all("_value").value = value;
		if(value.trim() == "")
		{
			this.HtmlEle.all("_text").value = "";
		}
		else
		{	
			if(value.substring(3,4) == "+")
				this.HtmlEle.all("_text").value = value.substring(value.lastIndexOf("+") + 1,value.length);
			else
				this.HtmlEle.all("_text").value = value.substring(value.lastIndexOf("_") + 1,value.length);
		}
	}
	else if(this.FileMode == "multi")
	{
		this.Clear();
		this.AddValue(value);
	}
}

/**<doc type="protofunc" name="JcFile.SetCheckBoxState">
	<desc>设置JcFile值</desc>
	<input>
		<param name="ele" type="">设置控价选中状态</param>
	</input>	
</doc>**/
JcFile.prototype.SetCheckBoxState = function(state)
{
	var ele = this.HtmlEle.all("_FileId");
	if(ele)
	{
		ele = ToArray(ele);
		var eleCount = ele.length;
		for(var i = 0;i < eleCount;i++)
		{
			if(state)
				ele[i].style.visibility = "";
			else
				ele[i].style.visibility = "hidden";
		}
	}	
}

/**<doc type="protofunc" name="JcFile.SetState">
	<desc>设置JcFile只读属性值，功能按钮是否可见等方法</desc>
</doc>**/
JcFile.prototype.SetState = function()
{
	this.HtmlEle.disabled = this.Disabled;
	this.HtmlEle.readOnly = this.Readonly;
	if(this.Disabled)
	{
		this.HtmlEle.all("_addbtn").disabled = true;
		this.HtmlEle.all("_clearbtn").disabled = true;	
		if(this.HtmlEle.all("_removebtn"))
			this.HtmlEle.all("_removebtn").disabled = true;	
		if(this.FileMode == "single")
		{
			this.HtmlEle.all("_text").disabled = true;
			this.HtmlEle.all("_text").readonly = false;
			this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
		}
		else if(this.FileMode == "multi")
		{
			this.SetCheckBoxState(false);
			this.HtmlEle.all("_BodyMain").style.backgroundColor=DisabledBgColor;
		}
		this.HtmlEle.style.backgroundColor = DisabledBgColor;		
	}
	else
	{
		this.HtmlEle.all("_addbtn").disabled = false;
		this.HtmlEle.all("_clearbtn").disabled = false;	
		if(this.HtmlEle.all("_removebtn"))
			this.HtmlEle.all("_removebtn").disabled = false;
	}
	
	if(this.Readonly)
	{
		this.HtmlEle.all("_addbtn").style.display = "none";
		this.HtmlEle.all("_clearbtn").style.display = "none";
		if(this.HtmlEle.all("_removebtn"))
			this.HtmlEle.all("_removebtn").style.display = "none";	
		if(this.FileMode == "single")
		{
			this.HtmlEle.all("_text").disabled = false;
			this.HtmlEle.all("_text").readonly = true;
			this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		}
		else if(this.FileMode == "multi")
		{
			this.SetCheckBoxState(false);
			this.HtmlEle.all("_BodyMain").style.backgroundColor=ReadonlyBgColor;
			
		}	
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;		
	}
	else
	{
		this.HtmlEle.all("_addbtn").style.display = "";
		this.HtmlEle.all("_clearbtn").style.display = "";
		if(this.HtmlEle.all("_removebtn"))
			this.HtmlEle.all("_removebtn").style.display = "";
		if(this.FileMode == "single")
		{
			this.HtmlEle.all("_text").disabled = false;
			this.HtmlEle.all("_text").readonly = false;		
		}
		else if(this.FileMode == "multi")
		{
			this.SetCheckBoxState(true);
		}
	}
	if(!this.Disabled && !this.Readonly)
	{
		if(!this.AllowEmpty)
		{
			this.HtmlEle.style.backgroundColor = MustInputBgColor;
			if(this.FileMode == "single")
				this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
			else
				this.HtmlEle.all("_BodyMain").style.backgroundColor=MustInputBgColor;
		}
		else
		{
			this.HtmlEle.style.backgroundColor = NormalBgColor;
			if(this.FileMode == "single")
				this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
			else
				this.HtmlEle.all("_BodyMain").style.backgroundColor=NormalBgColor;
		}
	}
}

JcFile.prototype.SetDisabled=function(st)
{	
	this.Disabled=st;
	this.SetState();
}


JcFile.prototype.SetReadonly=function(st)
{	
	this.Readonly=st;
	this.SetState();
}

JcFile.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all(this.ValidateEle).style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 

		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all(this.ValidateEle).style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
	}
	return validateResult;	

	//ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
}

//
//--------------------------------JcFile对象定义结束---------------------------------------------------
//

//
//--------------------------------JcPopUp对象定义开始 从JcInput继承----------------------------------------
//

/**<doc type="objdefine" name="JcPopUp">
	<desc>JcPopUp定义,由JcInput继
	承</desc>
	<property>
		<prop name="PopType" type="string">JcPopUp的弹出类型:Calendar/List/Tree/Url</param>
		<prop name="PopUrl" type="string">JcPopUp所弹出的关联URL</param>
		<prop name="PopParam" type="string">JcPopUp所弹出的关联参数</param>
		<prop name="PopStyle" type="string">JcPopUp的弹出样式,默认值为compact</param>
		<prop name="PopMode" type="string">JcPopUp的弹出模式,默认值为window(dialog/window)</param>
		<prop name="PopSize" type="string">JcPopUp的弹出尺寸大小</param>
		<prop name="ReturnMode" type="string">JcPopUp返回的是单值(single)还是多值(multi),默认值为single</param>
		<prop name="ReturnFields" type="string">JcPopUp返回的字段,以","分隔</param>
	</property>		
</doc>**/
function JcPopUp(ele)
{
	this.Type="jcpopup";
	this.PopType="";//所弹出的关联实体类型：Calendar,List,Tree,Url
	this.PopUrl="";//所弹出的关联URL
	this.PopParam="";//所弹出的关联参数
	this.System="System";
	this.OnPopBefore="";
	this.OnPopAfter="";
	this.PopStyle="compact"; //
	this.PopMode="window"; //dialog/window
	this.PopSize="";
	this.ReturnMode="single";
	this.SetReadOnly="true";
	this.ReturnParam="";
	
	this.LayOut="a";//组件的子控件的布局模式A表示以前一行模式 //by:gaozhenyu
	this.TextareaHeight="60px";//table的高度用于 其他模式的时候使用
	this.ButtonValue="选择";//选择按钮的名称
	
	this.TClass="Text";//这里为了设置个性化的文本框而准备 默认为系统
	
	this.Init(ele);
}
JcPopUp.prototype=new JcInput();

/**<doc type="protofunc" name="JcPopUp.SetPopUrl">
	<desc>内部方法，设置PopUp页面的弹出窗口</desc>	
</doc>**/
JcPopUp.prototype.SetPopUrl = function()
{
	if(this.HtmlEle.getAttribute("PopUrl"))
		this.PopUrl=this.HtmlEle.getAttribute("PopUrl");
	var lowerCasePopType=this.PopType.toLowerCase();
	switch(lowerCasePopType)
	{
		case "list":
			this.PopUrl = "/share/page/jclist.htm";
			this.PopUrl +="?CallElement="+this.HtmlEle.id+"&PopParam="+this.PopParam;//Page.List.Default
		break;
		case "url":
			if(this.PopUrl)
			{
				var prefix="";
				if(this.PopUrl.indexOf("?")>=0 )
					prefix="&";
				else
					prefix="?";
				if(this.OnPopAfter)	//如果设置了回调方法
					this.PopUrl +=prefix+"CallElementId="+this.HtmlEle.id+"&OnPopAfter="+this.OnPopAfter;//Page.List.Default
				else
				{
				
					this.PopUrl +=prefix+"CallElementId="+this.HtmlEle.id;//Page.List.Default
				}	
			}	
			//else
			//{
			//	alert("弹出框URL未设置!");
			//	return false;
			//}		
		break;
	}
}

/**<doc type="protofunc" name="JcPopUp.Init">
	<desc>JcPopUp的构建器</desc>
	<input>
		<param name="ele" type="object">JcPopUp对应的HTML元素</param>
	</input>	
</doc>**/
JcPopUp.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcpopup' jctype='jcpopup'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	
	if(ele.getAttribute("PopMode"))
		this.PopMode = ele.getAttribute("PopMode").toLowerCase();
	if(ele.getAttribute("SetReadOnly"))
		this.SetReadOnly = ele.getAttribute("SetReadOnly").toLowerCase();		
	if(ele.getAttribute("PopStyle"))
		this.PopStyle = ele.getAttribute("PopStyle");
	else
	{ 
		if(this.PopMode=="window")
			this.PopStyle="compact";
		else(this.PopMode=="dialog")
			this.PopStyle="dialogHeight:400px;dialogWidth:400px;edge:Sunken;center:Yes;help:No;resizable:No;status:No;";	
	}
	if(ele.getAttribute("PopParam"))
		this.PopParam = ele.getAttribute("PopParam");
	if(ele.getAttribute("System"))
		this.System = ele.getAttribute("System");
	
	if(ele.getAttribute("ReturnMode"))
		this.ReturnMode =ele.getAttribute("ReturnMode").toLowerCase();
	if(ele.getAttribute("ReturnParam"))
		this.ReturnParam =ele.getAttribute("ReturnParam");

	if(ele.getAttribute("PopType"))
		this.PopType=ele.getAttribute("PopType");
	if(!this.PopType)this.PopType="List";


	if(ele.getAttribute("OnPopBefore"))
		this.OnPopBefore=ele.getAttribute("OnPopBefore");		
	if(ele.getAttribute("OnPopAfter"))
		this.OnPopAfter=ele.getAttribute("OnPopAfter");
		
	if(ele.className!="")	
		this.Css=ele.className;	
	else
	{	if(this.Type.toLowerCase()!="jcselect")//下框设置样式后win2003ie无法下拉
			ele.className=this.Type;
		this.Css=this.Type;	
	}
		
	 if(this.HtmlEle.getAttribute("LayOut")) //布局模式
	   this.LayOut=this.HtmlEle.getAttribute("LayOut").toLowerCase();
     else
       this.LayOut="a";
		
	if(this.HtmlEle.getAttribute("TextareaHeight")) //
        this.TextareaHeight=this.HtmlEle.getAttribute("TextareaHeight");
        
   if(this.HtmlEle.getAttribute("ButtonValue"))
       this.ButtonValue=this.HtmlEle.getAttribute("ButtonValue");
       
    if(this.HtmlEle.getAttribute("TClass"))
       this.TClass=" class='"+this.HtmlEle.getAttribute("TClass")+"'   ";
		
	this.SetPopUrl();
	this.SuperInit();
	this.RenderObject();
	this.InitEvent();	
	
}

/**<doc type="protofunc" name="JcPopUp.InitEvent">
	<desc>设置JcPopUp的绑定事件</desc>
</doc>**/
JcPopUp.prototype.InitEvent=function()
{	var ele=this.HtmlEle;
	ele.all("_btn").onclick=JcPopUp.BtnClick;
	if(!this.AllowEmpty)
		this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
}
JcPopUp.OnFocus=function()
{
	var ele=GetParentJcElement(event.srcElement);
	ele.all("_text").style.backgroundColor=ele.Co.PreBgColor;	
	ele.style.backgroundColor=ele.Co.PreBgColor;	
}

/**<doc type="protofunc" name="JcPopUp.RenderObject">
	<desc>绘制JcPopUp</desc>
</doc>**/
JcPopUp.prototype.RenderObject=function()
{
	if(this.Render=="client"&&this.LayOut=="a")
	{
	   //reason 为控件增加初始值
	   var initValue=initValue=this.HtmlEle.InitValue;
	   if(initValue==null)
	      initValue ="";
		var elesrc = "<table cellspacing='0' cellpadding='0' border='0' style='height:20;width:100%'><tr>";
		if(this.SetReadOnly == "true")
			elesrc += "<td><input id='_text' "+this.TClass+"  readonly class='" + this.SubCss("Text") + "' style='width:100%'  ></td>";
		else
			elesrc += "<td><input id='_text' "+this.TClass+"  class='" + this.SubCss("Text") + "' style='width:100%'  ></td>";
		elesrc += "<td style='width:20;'>";
		var popType=this.PopType.toLowerCase();	
		//if(popType=="ftpfile"||popType=="ftpmultifile"||popType=="ftpfolderfile")	
		//	elesrc+="<button id='_btn' class='" + this.SubCss("UploadButton") + "' style='width:100%;height:21;'><img src='/share/image/jsctrl/uploadbtnpopup.gif'></button>";
		//else
			elesrc+="<button id='_btn' class='" + this.SubCss("Button") + "'></button>";
		elesrc+="</td></tr></table>";
		this.HtmlEle.innerHTML= elesrc;
		this.HtmlEle.style.height=20;
	}
	else if(this.Render=="client"&&this.LayOut=="b") ///by:gaozhenyu
	{
	   var elesrc = "<table cellspacing='0' cellpadding='0' border='0' style='width:100%'><tr>";
		if(this.SetReadOnly == "true")
			elesrc += "<tr><td><textarea   "+this.TClass+"   id='_text' readonly class='jctextarea' style='width:100%;height:"+this.TextareaHeight+"'  "   +this.TClass+"></textarea></td></tr>";
		else
			elesrc += "<tr><td><textarea id='_text' class='jctextarea' style='width:100%;height:"+this.TextareaHeight+"'   " +this.TClass+"></textarea></tr>";
		elesrc += "<tr><td style='width:100%;'>";
		var popType=this.PopType.toLowerCase();	
		
			elesrc+="<button id='_btn' class='jcbutton'  value='"+this.ButtonValue+"' style='width:100%;height:20;'>"+this.ButtonValue+"</button>";
		elesrc+="</td></tr></table>";
		this.HtmlEle.innerHTML= elesrc;
		//this.HtmlEle.style.height=20;
	}
	else if(this.Render=="client"&&this.LayOut=="c") ///by:gaozhenyu
	{
	   var elesrc = "<table cellspacing='0' cellpadding='0' border='0' style='width:100%'><tr>";
		if(this.SetReadOnly == "true")
			elesrc += "<td><textarea id='_text' readonly class='jctextarea' style='width:100%;height:"+this.TextareaHeight+"'  "+this.TClass+"></textarea></td>";
		else
			elesrc += "<td><textarea id='_text' class='jctextarea' style='width:100%;height:"+this.TextareaHeight+"'  "+this.TClass+"></textarea></td>";
		elesrc += "<td style='width:20px'>";
		var popType=this.PopType.toLowerCase();	
		//if(popType=="ftpfile"||popType=="ftpmultifile"||popType=="ftpfolderfile")	
		//	elesrc+="<button id='_btn' class='" + this.SubCss("UploadButton") + "' style='width:100%;height:21;'><img src='/share/image/jsctrl/uploadbtnpopup.gif'></button>";
		//else
			elesrc+="<button id='_btn' class='jcbutton'  value='"+this.ButtonValue+"'  style='writing-mode:tb-rl;width:20px;height:"+this.TextareaHeight+"'>"+this.ButtonValue+"</button>";
		elesrc+="</td></tr></table>";
		this.HtmlEle.innerHTML= elesrc;
		this.HtmlEle.style.height=this.TextareaHeight;
	}

	//add by tyaloo start
	if(this.HtmlEle.canAutoComplete)
	{
		_MakeJcEleCanAutoComplete(this);
	}
}

JcPopUp.prototype.Fire=function(type)
{	var onfunc=this.HtmlEle.getAttribute(type);
	if(onfunc)
		eval(onfunc);
}

/**<doc type="protofunc" name="JcPopUp.BtnClick">
	<desc>定义JcPopUp的点击事件</desc>
</doc>**/
JcPopUp.BtnClick=function()
{	
	JcPopUp.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	
	obj.Event = new Object();
	obj.Event.returnValue=true;
	obj.Fire("OnPopBefore");
	if(!obj.Event.returnValue)
	{	
		return false;
	}	
	
	var popParam="";

	if(obj.PopParam)
	{
		var sp=new StringParam(obj.PopParam);
		for(var i=0;i<sp.GetCount();i++)
		{
			popParam+=sp.Keys[i]+":";
			if(document.all(sp.Get(i)).Co)
			{
				popParam+=escape(document.all(sp.Get(i)).Co.GetValue())+";";
			}	
			else
				popParam+=escape(document.all(sp.Get(i)).value)+";";	
		}
	}
	//else if(obj.OnPopBefore)
	//{
	//	popParam=eval(obj.OnPopBefore)();
	//}	
	obj.SetPopUrl();	
	var popUrl=obj.PopUrl;
	if(obj.PopUrl.indexOf("?")>0)
		popUrl+="&PopParam=" + popParam;
	else
		popUrl+="?PopParam=" + popParam;	

	switch(obj.PopType.toLowerCase())
	{
		case "list":
			if(obj.PopMode.toLowerCase()=="window")
				window.open(popUrl,ele.id+"_win",CenterWin(obj.PopStyle));
			else
			{	window.showModalDialog(popUrl,window,CenterWin(obj.PopStyle,true));
			}
		break;
		default:
			if(obj.PopMode.toLowerCase()=="window")
			{
				window.open(popUrl,ele.id+"_win",CenterWin(obj.PopStyle));
			}	
			else
			{	
				window.showModalDialog(popUrl,window,CenterWin(obj.PopStyle,true));
			}
		break;		
	}		
}

/**<doc type="protofunc" name="JcPopUp.GetValue">
	<desc>取得JcPopUp的值</desc>
	<output type="string">JcPopUp的值</output>
</doc>**/
JcPopUp.prototype.GetValue=function()
{
	return this.HtmlEle.all("_text").value;
}

/**<doc type="protofunc" name="JcPopUp.SetValue">
	<desc>设置JcPopUp的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcPopUp.prototype.SetValue=function(value)
{
	if(value == null) value = "";
	this.HtmlEle.all("_text").value=value;
	
	if(!this.AllowEmpty&&value!="")
	this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
}

/**<doc type="protofunc" name="JcPopUp.SetReturn">
	<desc>设置JcPopUp的返回值</desc>
	<input>
		<param name="rtnstr" type="string">JcPopUp的返回值</param>
	</input>	
</doc>**/
JcPopUp.prototype.SetReturn=function(rtnstr)
{	
	this.returnValue=true;
	this.ReturnString=rtnstr;
	try
	{
		eval(this.HtmlEle.getAttribute("onreturnbefore"));//this对象指向的是Jc对象
	}
	catch(e)
	{}
	
	if(this.returnValue)
	{	switch(this.ReturnMode.toLowerCase())
		{	
			case "single":
				switch(this.PopType.toLowerCase())
				{
					case "list":
						this.HtmlEle.all("_text").value = this.ReturnString;
					break;
				}		
			break;
			case "multi":
				var flds = this.ReturnParam.split(",");
				var sp = new StringParam(this.ReturnString);
				for(var i=0;i<flds.length;i++)
				{
					if(sp.Get(flds[i]))
						Co[flds[i]].SetValue(sp.Get(flds[i]));
				}
			break;
			case "datalist":
				var sp=new StringParam(this.ReturnParam);
				var dataList=new DataList(rtnstr);
				var dataItems=dataList.GetItems();
				var fieldValues=new Array();
				for(var j=0;j<sp.GetCount();j++)
				{
					fieldValues[j]="";
				}			
				for(var i=0;i<dataItems.length;i++)
				{
					for(var j=0;j<sp.GetCount();j++)
					{
						fieldValues[j]+=dataItems[i].GetAttr(sp.Get(j))+","
					}
				}
				for(var j=0;j<sp.GetCount();j++)
				{
					if(fieldValues[j].substring(fieldValues[j].length-1,fieldValues[j].length)==",")
						fieldValues[j]=fieldValues[j].substring(0,fieldValues[j].length-1);
					var obj=document.all(sp.Keys[j]);
					if(obj.Co)
						obj.Co.SetValue(fieldValues[j]);
					else
						obj.value=fieldValues[j];
				}				
			break;
		}
		
	}
	
	try{	
		eval(this.HtmlEle.getAttribute("onreturnafter"));//this对象指向的是Jc对象
	}
	catch(e)
	{}
}

/**<doc type="protofunc" name="JcPopUp.SetDisabled">
	<desc>设置JcPopUp是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcPopUp.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this.HtmlEle.all("_text").disabled=st;
	this.HtmlEle.all("_btn").disabled=st;
	if(this.Disabled)
	{
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
		this.HtmlEle.style.backgroundColor = DisabledBgColor;
	}	
	else if(this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;
	}	
	else
	{	
		if(!this.AllowEmpty)
		{
			this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
			this.HtmlEle.style.backgroundColor = MustInputBgColor;
		}
		else
		{
			this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
			this.HtmlEle.style.backgroundColor = NormalBgColor;
		}
	}	
}
/**<doc type="protofunc" name="JcPopUp.SetDisabled">
	<desc>设置JcPopUp是否可写</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcPopUp.prototype.SetWrited=function(st)
{	//this.Disabled=st;
	//this.HtmlEle.disabled=st;
	//this.HtmlEle.all("_text").disabled=st;
//debugger
		//this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
//		this.HtmlEle.style.backgroundColor=DisabledBgColor;

	this.HtmlEle.all("_text").style.display="none";
	
}

/**<doc type="protofunc" name="JcPopUp.SetReadonly">
	<desc>设置JcPopUp是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcPopUp.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	this.HtmlEle.all("_text").readOnly=true;
	this.HtmlEle.all("_btn").disabled=st;
	if(this.Disabled)
	{
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
		this.HtmlEle.style.backgroundColor = DisabledBgColor;
	}	
	else if(this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor = ReadonlyBgColor;
	}	
	else
	{	
		if(!this.AllowEmpty)
		{
			this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
			this.HtmlEle.style.backgroundColor = MustInputBgColor;
		}
		else
		{
			this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
			this.HtmlEle.style.backgroundColor = NormalBgColor;
		}
	}	
}

JcPopUp.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 

		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
	}
	return validateResult;	

	//ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
}

//
//--------------------------------JcPopUp对象定义结束---------------------------------------------------
//

//
//--------------------------------自动完成辅助方法开始--------------------------------------------------
//

//add by tyaloo start

function _MakeJcEleCanAutoComplete(jcObj)
{
	var jcType = jcObj.Type; 

	var _needAutoInput;
	var _parentEle=jcObj.HtmlEle;
	switch(jcType)
	{
		case "jcpopup":
		_needAutoInput = _parentEle.all("_text");
		break;
		case "jctext":
		_needAutoInput = _parentEle;
		break;
	}
   
	_needAutoInput.autocomplete="off";
	_needAutoInput.AutoCompleteType = jcType;
	// 如何获取数据, 本机还是服务器, 默认服务器	by rey - 2009.2.26
	_needAutoInput.AutoType = (jcObj.HtmlEle.getAttribute("AutoType") ? jcObj.HtmlEle.getAttribute("AutoType") : "server").toLowerCase();
	if(jcType=="jcpopup")
	{
		_needAutoInput.PopParent = jcObj; 
		_needAutoInput.readOnly=false;
	}
	var _suggestArea = document.createElement("<div style='border:solid 1px black;display:none;position:absolute;z-index:1000;left:0px;top:0px;'>");

	_suggestAreaCount+=1;
	var _suggestAreaId = "_suggestArea"+_suggestAreaCount; 
	_suggestArea.id=_suggestAreaId;
	_suggestArea.SeleValue = "";
	
	_suggestArea.hasFocus=false;
	_needAutoInput.onblur = function(){window.setTimeout("HideSuggestArea('"+_suggestAreaId+"')",200);};
	_needAutoInput.SuggestAreaEle = _suggestArea;
	_suggestArea.NeedAutoInput = _needAutoInput;
	_suggestArea.ContainJcType= jcType;
	_parentEle.insertAdjacentElement("afterEnd",_suggestArea);
	
	_needAutoInput.onkeydown = _AutoCompleteInputOnkeydown;
	
	var _autoCompleteModel = _parentEle.AutoCompleteModel;
	if(_autoCompleteModel)
	{
		var _selectModel = AutoCompleteModel[_autoCompleteModel];
		_suggestArea._acTableName = _selectModel.TableName;
		_suggestArea._acFieldNames = _selectModel.FieldNames;
		_suggestArea._acFieldMatch = _selectModel.FieldMatch;
		_suggestArea._acFieldWidths = _selectModel.FieldWidths;
		_suggestArea._acFieldTitles = _selectModel.FieldTitles;
	}
	else
	{
		_suggestArea._acTableName = _parentEle.TableName;
		_suggestArea._acFieldNames = _parentEle.FieldNames;
		_suggestArea._acFieldMatch = _parentEle.FieldMatch;
		_suggestArea._acFieldWidths = _parentEle.FieldWidths;
		_suggestArea._acFieldTitles = _parentEle.FieldTitles;
	}
    _suggestArea._CustomWidth = _parentEle.CustomWidth;	
    
	if(jcType=="jcpopup")
	{
		_suggestArea._acPopParam = _parentEle.PopAutoParam;
		var _acAttachField = new String();
		var tmpPopParam = _suggestArea._acPopParam;
		
		if(tmpPopParam && tmpPopParam != "")
		{
			var _acParams = tmpPopParam.split(";");
			for(var i=0;i<_acParams.length;i++)
			{
				var _seleParam = _acParams[i];
				if(_seleParam=="") continue;
				var _mapParam = _seleParam.split(":");

				_acAttachField += _mapParam[0]+",";
			}
		}
		
		if(_acAttachField != "")
		_acAttachField= _acAttachField.substring(0,_acAttachField.length-1); 
		_suggestArea._acAttachField = _acAttachField;
	}
	_needAutoInput.onkeyup = _AutoCompleteInputOnkeyup;

    _needAutoInput.queryFinish = true;
}

function _DoAutoComplete(jcControlName,jcType, autoType)
{
    var srcEle = Co[jcControlName].HtmlEle;

	switch(jcType)
	{
		case "jcpopup":
		srcEle = srcEle.all("_text");
		break;
	}

 	var mySuggestAreaEle = srcEle.SuggestAreaEle;
	
	var newWidth = 0;
	ApplyElementPositionToElement(srcEle,mySuggestAreaEle);
	newWidth = mySuggestAreaEle._CustomWidth;      
    if(!newWidth)
     newWidth = srcEle.scrollWidth;
	mySuggestAreaEle.style.width = newWidth;
	var suggestContenTable = new JcSeleTable(null,mySuggestAreaEle._acFieldNames,mySuggestAreaEle._acFieldTitles,mySuggestAreaEle._acFieldWidths);
	suggestContenTable.TableName=mySuggestAreaEle._acTableName;
	suggestContenTable.QueryField = mySuggestAreaEle._acFieldMatch;

	switch(srcEle.AutoCompleteType)
	{
	 case "jcpopup":
	 suggestContenTable.OnSelect= _JcPopOnSelect;
	 suggestContenTable.AttachField = mySuggestAreaEle._acAttachField;
	 break;
	 case "jctext":
	 suggestContenTable.OnSelect=_JcTextOnSelect;
	 break;
	}
	suggestContenTable.AutoEle = srcEle;
	suggestContenTable.ClearParentForm = _ClearParentForm;
	// 增加本机数据源情况 - by rey . 2009.2.26
	if(autoType == "local")
	{
		mySuggestAreaEle.SelectTable = suggestContenTable;
		suggestContenTable.LocalDraw(srcEle,mySuggestAreaEle);
	}
	else
	{
		mySuggestAreaEle.SelectTable = suggestContenTable;
		suggestContenTable.AsynDraw(srcEle,mySuggestAreaEle);
	}
}

function _AutoCompleteInputOnkeyup()
{//alert(this.needQuery + "||" + this.queryFinish)
    //if(this.value == this.oldValue) {event.cancelBubble=true;return;}
	if(!this.needQuery)
	{
	 return ;
	}
    this.queryFinish = false;
    var eleName = this.id;
    var eleType = "jctext";
    var autoType = GetAttr(this, "autoType");	// 数据由本地获取还是服务器获取
    
    if(this.PopParent)
    {
      eleType = "jcpopup";
      eleName = this.PopParent.HtmlEle.id;
      autoType = this.PopParent.HtmlEle.AutoType;
    }
    
    // 非本地获取无需判断是否完成
    if(autoType.toLowerCase() != "local" && !this.queryFinish)
    {
		return;
    }
    
    var funcStr = "_DoAutoComplete('"+eleName + "','"+eleType+"','"+autoType+"')";
	window.setTimeout(funcStr,800);
}

function _ClearParentForm()
{
	var srcEle = this.AutoEle;

	if(srcEle.PopParent==null)
	{
		srcEle.value = "";
		return;
	}
    srcEle.PopParent.SetValue("");
    srcEle.SuggestAreaEle.SeleValue = "";

	var _acPopParam = srcEle.SuggestAreaEle._acPopParam;
	
	if(_acPopParam && _acPopParam != "")
	{
		var _acParams = _acPopParam.split(";");
		for(var i=0;i<_acParams.length;i++)
		{
			var _seleParam = _acParams[i];
			if(_seleParam=="") continue;
			var _mapParam = _seleParam.split(":");
			Co[_mapParam[1]].SetValue("");
		}
	}
}

function _AutoCompleteInputOnkeydown()
{
 this.oldValue=this.value;
 this.needQuery = true;
 var action = kbActions[event.keyCode];
 if (action)	
 {
	if(action == "down"&&this.SuggestAreaEle)
	{
	 if(this.SuggestAreaEle.hasFocus)
	 {
	   _DoRowDown(this.SuggestAreaEle.firstChild);
	   this.needQuery = false;
	   return ;
	 }  
	 
	 this.SuggestAreaEle.style.display="";
	 
	 if(this.SuggestAreaEle.firstChild==null) return;
	 var nowSeleRow = this.SuggestAreaEle.firstChild.seleRow;
	
	 if(nowSeleRow==null)
	  nowSeleRow = this.SuggestAreaEle.SelectTable.SelectRow(0);
	 //this.SuggestAreaEle.SelectTable.HtmlEle.focus(); 
	 
	 this.SuggestAreaEle.hasFocus = true;
	}
	else if(action == "up"&&this.SuggestAreaEle)
	{
		if(this.SuggestAreaEle.hasFocus)
		{
			_DoRowUp(this.SuggestAreaEle.firstChild);
		}  
	}
	else if(action == "enter"&&this.SuggestAreaEle)	
	{
	    if(this.SuggestAreaEle.hasFocus)
		{
		 
		 _DoRowClick(this.SuggestAreaEle.firstChild);

		} 
		else
		{
	       var _ParentFormBtn;
		   if(this.ParentForm)
		   {
		     _ParentFormBtn = this.ParentForm.SubmitBtn;
		   }
		   else
		   {		   
		     _ParentFormBtn=this.PopParent.HtmlEle.ParentForm.SubmitBtn;
		   }
		   
		   if(_ParentFormBtn) 
		   {
		     HideSuggestArea(this.SuggestAreaEle.id);
		     if(!confirm("确认要提交吗?")) return ;
		     _ParentFormBtn.click();
		   }
		}
	}
    this.needQuery = false;
  }
}

/**<doc type="func" name="Global._JcTextOnSelect">
	<desc></desc>
	<input>
		<param name="ele" type="dsrc">JcText对应数据源</param>
		<param name="ele" type="srcEle">JcText对应的HTML元素</param>
	</input>	
</doc>**/
function _JcTextOnSelect(dsrc,srcEle)
{
   var rtnText = dsrc.GetAttr(srcEle.getAttribute("FieldMatch"));
   
   srcEle.value = rtnText;
   srcEle.SuggestAreaEle.style.display = "none";
   srcEle.SuggestAreaEle.hasFocus = false;
}

function _JcPopOnSelect(dataSrc,srcEle)
{
	var _seleValue = dataSrc.GetAttr(srcEle.SuggestAreaEle._acFieldMatch);
	srcEle.PopParent.SetValue(_seleValue);
	srcEle.SuggestAreaEle.SeleValue = _seleValue;
	var _acPopParam = srcEle.SuggestAreaEle._acPopParam;

	if(_acPopParam && _acPopParam != "")
	{
		var _acParams = _acPopParam.split(";");
		for(var i=0;i<_acParams.length;i++)
		{
			var _seleParam = _acParams[i];
			if(_seleParam=="") continue;
			var _mapParam = _seleParam.split(":");
			Co[_mapParam[1]].SetValue(dataSrc.GetAttr(_mapParam[0]));
		}
	}
	
	srcEle.SuggestAreaEle.style.display = "none";
	srcEle.SuggestAreaEle.hasFocus = false;
	   
	if(srcEle.PopParent.HtmlEle.OnAutoCompleteFinish)
	{
		eval(srcEle.PopParent.HtmlEle.OnAutoCompleteFinish); 
	}
}

/**<doc type="func" name="Global.HideSuggestArea">
	<desc></desc>
	<input>
		<param name="srcId" type="string">JcText对应的HTML元素id</param>
	</input>	
</doc>**/
function HideSuggestArea(srcId)
{
  //var srcEle = $(srcId);
  var srcEle = document.getElementById(srcId);
  
  if(srcEle)
  {
    srcEle.style.display="none";
    srcEle.hasFocus = false;
  }
  
  if(srcEle.ContainJcType == "jcpopup")
  {
    srcEle.NeedAutoInput.value = srcEle.SeleValue;
  }
}

//by tyaloo end

//
//--------------------------------自动完成辅助方法结束---------------------------------------------------
//

//
//--------------------------------JcUpDown对象定义开始 从JcInput继承------------------------------------
//

/**<doc type="objdefine" name="JcUpDown">
	<desc>JcUpDown定义,由JcInput继承</desc>
	<property>
		<prop name="AllowEdit" type="boolean">是否允许编辑</param>
		<prop name="Increase" type="number">每次按箭头值的增减量</param>
	</property>		
</doc>**/
function JcUpDown(ele)
{
	this.Type="jcupdown";
    this.AllowEdit=true;//所弹出的关联实体类型：Calendar,List,Tree
    this.Increase=1;//所弹出的关联实体ID
    this.Render="client";
	this.Init(ele);
}
JcUpDown.prototype=new JcInput();

/**<doc type="protofunc" name="JcUpDown.Init">
	<desc>JcUpDown的构建器</desc>
	<input>
		<param name="ele" type="object">JcUpDown对应的HTML元素</param>
	</input>	
</doc>**/
JcUpDown.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcupdown' jctype='jcupdown'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.Css=ele.className;
	if(ele.getAttribute("Increase"))
     {
         var inc=ele.getAttribute("Increase");
         if(parseFloat(inc)+""!="NaN")
              this.Increase=parseFloat(inc);
     }
     if(ele.getAttribute("NotAllowEdit"))
         this.AllowEdit=false;
         
	this.SuperInit();
	this.RenderObject();
}

/**<doc type="protofunc" name="JcUpDown.RenderObject">
	<desc>绘制JcUpDown</desc>
</doc>**/
JcUpDown.prototype.RenderObject=function()
{	if(this.Render=="client")
	{	 var elesrc = "<table cellspacing='0' cellpadding='0' border='0' style='width:100%;height:20'><tr>" +
              "<td rowspan='2'><input id='_text' class='" + this.SubCss("text") + "' style='width:100%;'></td>" +
              "<td style='width:20;'><button id='_btnup' class='" + this.SubCss("button") + 
              "' style='width:100%;'><img src='/share/image/jsctrl/btnudup.gif'></button></td></tr>"+
              "<tr><td><button id='_btndown' class='" + 
              this.SubCss("button") + "' style='width:100%;'><img src='/share/image/jsctrl/btnuddown.gif'></button></td></tr></table>";
         this.HtmlEle.innerHTML= elesrc;
	}
	if(!this.AllowEmpty)
		this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
	this.HtmlEle.all("_text").onfocus = JcUpDown.OnFocus;	
	var ele=this.HtmlEle;
     ele.all("_btnup").onclick=JcUpDown.BtnUpClick;
     ele.all("_btndown").onclick=JcUpDown.BtnDownClick;
}

/**<doc type="protofunc" name="JcUpDown.OnFocus">
	<desc>JcUpDown获取焦点时触发</desc>
</doc>**/
JcUpDown.OnFocus=function()
{
	var ele=GetParentJcElement(event.srcElement);
	ele.all("_text").style.backgroundColor=ele.Co.PreBgColor;	
	ele.style.backgroundColor=ele.Co.PreBgColor;	
}

/**<doc type="protofunc" name="JcUpDown.BtnUpClick">
	<desc>定义JcUpDown的点击向上箭头事件</desc>
</doc>**/
JcUpDown.BtnUpClick=function()
{	
	JcUpDown.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	var val=ele.all("_text").value;
	if(parseFloat(val)+""=="NaN")val=0;
	ele.all("_text").value = parseFloat(val)+obj.Increase;
}

/**<doc type="protofunc" name="JcUpDown.BtnDownClick">
	<desc>定义JcUpDown的点击向下箭头事件</desc>
</doc>**/
JcUpDown.BtnDownClick=function()
{	
	JcUpDown.OnFocus();
	var ele=GetParentJcElement(event.srcElement);
	var obj=ele.Co;
	var val=ele.all("_text").value;
	if(parseFloat(val)+""=="NaN")val=0;
	ele.all("_text").value = parseFloat(val)-obj.Increase;
}

/**<doc type="protofunc" name="JcUpDown.GetValue">
	<desc>取得JcUpDown的值</desc>
	<output type="string">JcUpDown的值</output>
</doc>**/
JcUpDown.prototype.GetValue=function()
{
	return this.HtmlEle.all("_text").value;
}

/**<doc type="protofunc" name="JcUpDown.SetValue">
	<desc>设置JcUpDown的值</desc>
	<input>
		<param name="value" type="string">待设置的值</param>
	</input>
</doc>**/
JcUpDown.prototype.SetValue=function(value)
{
	this.HtmlEle.all("_text").value=value;
}

/**<doc type="protofunc" name="JcUpDown.SetDisabled">
	<desc>设置JcUpDown是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcUpDown.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this.HtmlEle.all("_text").disabled=st;
	if(this.Disabled)
	{
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
		this.HtmlEle.style.backgroundColor=DisabledBgColor;
	}	
	else if(this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor=ReadonlyBgColor;
	}	
	else
	{
		if(!this.AllowEmpty)
		{
			this.HtmlEle.all("_text").style.backgroundColor=MustInputBgColor;
			this.HtmlEle.style.backgroundColor=MustInputBgColor;
		}
		else
		{
			this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
			this.HtmlEle.style.backgroundColor=NormalBgColor;
		}
	}	
}

/**<doc type="protofunc" name="JcUpDown.SetReadonly">
	<desc>设置JcUpDown是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcUpDown.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	this.HtmlEle.all("_text").readOnly=st;
	this.HtmlEle.all("_btn").disabled=st;
	if(!this.Disabled && this.Readonly)
	{
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
		this.HtmlEle.style.backgroundColor=ReadonlyBgColor;
	}	
	else
	{
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
		this.HtmlEle.style.backgroundColor=NormalBgColor;
	}	
}

JcUpDown.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 

		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.all("_text").style.backgroundColor = ErrorBgColor;
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
	}
	return validateResult;	

	//ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
}

//
//--------------------------------JcUpDown对象定义结束---------------------------------------------------
//

//
//--------------------------------JcForm对象定义开始-----------------------------------------------------
//

/**<doc type="objdefine" name="JcForm">
	<desc>JcForm定义</desc>
	<property>
		<prop name="HtmlEle" type="object">JcForm对应的HTML元素</param>
		<prop name="Elements" type="Array">JcForm下的Jc元素数组</param>
	</property>	
</doc>**/
function JcForm(ele)
{	
	this.HtmlEle = null;
	this.PreValue="";
	this.IsDirty="";
	this.OnDirty=null;
	this.Elements=new Array();
	this.Init(ele);
}

/**<doc type="protofunc" name="JcForm.Init">
	<desc>JcForm的构建器</desc>
	<input>
		<param name="ele" type="object">JcForm对应的HTML元素</param>
	</input>	
</doc>**/
JcForm.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<form jctype='jcform' >");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	var eles=GetJcElements(this.HtmlEle);
	for(var i=0;i<eles.length;i++)
	{	
	    var seleEle = eles[i];
	    var type=seleEle.jctype;
	    if(type && InputElements.indexOf(type.toLowerCase())>=0)
		{
		    //modify by tyaloo
		    //for form elements can get thier parent form.
		    //add give form a default submit btn.
		    
		    seleEle.ParentForm = ele;
		    
			this.Elements[this.Elements.length]=seleEle;
		}
		else if(seleEle.IsSubmitBtn)
		{
		      ele.SubmitBtn = seleEle
		}
	}
	this.OnDirty=this.HtmlEle.getAttribute("OnDirty");
	if(this.HtmlEle.disabled)this.SetDisabled(true);
	if(this.HtmlEle.readOnly)this.SetReadonly(true);
	//this.HtmlEle.attachEvent("onkeydown",this.OnKeyDown);是否需要捕捉回车按钮
}



/**<doc type="protofunc" name="JcForm.Clear">
	<desc>设置JcForm为空</desc>
</doc>**/
JcForm.prototype.Clear=function()
{	for(var i=0;i<this.Elements.length;i++)
	{	var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	obj.Clear();
		}
	}
}

/**<doc type="protofunc" name="JcForm.Reset">
	<desc>设置JcForm为初始值</desc>
</doc>**/
JcForm.prototype.Reset=function()
{	for(var i=0;i<this.Elements.length;i++)
	{	var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	obj.Reset();
		}
	}
}

/**<doc type="protofunc" name="JcForm.Validate">
	<desc>验证JcForm的有效性</desc>
</doc>**/
JcForm.prototype.Validate=function()
{	
	var jcObject=this.Elements;
	if(jcObject.length<=0)
		return true;
		
	var jcElement=new Array();
	for(var i=0;i<jcObject.length;i++)
	{
		jcElement[jcElement.length]=jcObject[i].Co;
	}	
	
	var msg="";	
	var j=1;
	for(var i=0;i<jcElement.length;i++)
	{
		var validateResult=jcElement[i].Validate();
		if(validateResult!=null&&!validateResult.Passed)
		{
			msg+=(j++)+")  "+validateResult.GetErrMsg()+"\n";
		}	
	}	
	
	if (msg.length>0)
	{	
		window.showModalDialog("/share/page/ValidteError.htm",msg,
			"dialogHeight:360px;dialogWidth:500px;edge:Sunken;center:Yes;help:No;resizable:Yes;status:No;scroll:no");
		return false;
	}else
	{	return true;
	}
}
JcForm._CheckForm=null;

/**<doc type="protofunc" name="JcForm.Validate">
	<desc>开始验证JcForm的数据是否过期</desc>
</doc>**/
JcForm.prototype.StartCheckDirty=function()
{
	this.PreValue=this.GetElementsValues();
	JcForm._CheckForm=this;
	window.setTimeout(JcForm.CheckDirty,200);
}

JcForm.prototype.Fire=function(eventname)
{
	this.IsDirty=true;
	if(this.OnDirty)
		eval(this.OnDirty);
	//var e = this.HtmlEle.getAttribute(eventname);
	//if(e)
	//	eval(e);
}

/**<doc type="protofunc" name="JcForm.Validate">
	<desc>验证JcForm的数据是否过期</desc>
</doc>**/
JcForm.CheckDirty=function()
{
	var obj=JcForm._CheckForm;
	if(!obj)
		return;
	if(obj.PreValue!=obj.GetElementsValues())
	{
		obj.Fire("OnDirty");
		JcForm._CheckForm=null;
	}
	else
		window.setTimeout(JcForm.CheckDirty,200);		
}

/**<doc type="protofunc" name="JcForm.OnKeyDown">
	<desc>JcForm中按下键时触发</desc>
</doc>**/
JcForm.prototype.OnKeyDown = function()
{
	if(event.keyCode==13)
	{
		var ele = event.srcElement;
		while( ele && ele.tagName!="body" && ele.getAttribute("jctype")!="jcform")
		{
			ele = ele.parentNode;
		}
		var obj = ele.Co;
		obj.Fire("onenter");
	}
}

/**<doc type="protofunc" name="JcForm.GetElementsValues">
	<desc>得到JcForm控件中元素值字符串</desc>
</doc>**/
JcForm.prototype.GetElementsValues=function()
{
	var value="";
	for(var i=0;i<this.Elements.length;i++)
	{	
		var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	
			value+=obj.GetValue()+",";
		}
	}
	return value;
}

/**<doc type="protofunc" name="JcForm.SetReadonly">
	<desc>设置JcForm是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcForm.prototype.SetReadonly=function(st)
{	for(var i=0;i<this.Elements.length;i++)
	{	var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	obj.SetReadonly(st);
		}
	}
}

/**<doc type="protofunc" name="JcForm.SetDisabled">
	<desc>设置JcForm是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcForm.prototype.SetDisabled=function(st)
{	for(var i=0;i<this.Elements.length;i++)
	{	var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	obj.SetDisabled(st);
		}
	}
}

/**<doc type="protofunc" name="JcInput.SetDisabled">
	<desc>显示此JcForm下所有Jc控件为Label类似形式</desc>
	<input>
		<param name="st" type="boolean">是否显示</param>
	</input>
</doc>**/
JcForm.prototype.SetToView = function(st)
{
	for(var i=0;i<this.Elements.length;i++)
	{	
		var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{
			obj.SetToView(st);
		}
	}
}

/**<doc type="protofunc" name="JcForm.GetDataForm">
	<desc>从JcForm中获取DataForm</desc>
	<input>
		<param name="df" type="DataForm">从该DataForm中获取要从JcForm中获取哪些字段;如果该DataForm为null,则获取JcForm中所有的字段(忽略标记用NotSubmit的字段)</param>
	</input>
</doc>**/
JcForm.prototype.GetDataForm=function(df)
{
	if(typeof(df)=="object" && df != null)
	{
		for(var i=0;i<this.Elements.length;i++)
		{	
			var obj=this.Elements[i].Co;
			if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
			{	
			    if(obj.Type.toLowerCase() == "jcgrid") continue;
				if(df.GetValue(obj.HtmlEle.id)!=null)
				{
					if(obj.IsSubmit)
					{
						//df.SetValue(obj.HtmlEle.id,obj.GetValue(obj.HtmlEle.id));
						df.SetValue(obj.HtmlEle.id,obj.GetValue());
						//if(obj.GetValue(obj.HtmlEle.id)!="")
						//	alert(obj.GetValue());
					}	
				}
			}
		}		
		return df;
	}
	else
	{	if(typeof(df)=="string")
			var name = df;
		else
			var name = "";
		var dataForm=new DataForm();
		dataForm.SetName(name);
		for(var i=0;i<this.Elements.length;i++)
		{	
			var obj=this.Elements[i].Co;
			if(InputElements.indexOf(obj.Type.toLowerCase())>=0&&obj.HtmlEle.NotSubmit==null)
			{	
				if(obj.Type.toLowerCase() == "jcgrid") continue;
				if(obj.IsSubmit)
					dataForm.AddItem(obj.HtmlEle.id,obj.GetValue());
			}
		}
		return dataForm;	
	}
}

/**<doc type="protofunc" name="JcForm.SetDataForm">
	<desc>将DataForm设置到JcForm中</desc>
	<input>
		<param name="df" type="DataForm">被设置的DataForm</param>
	</input>
</doc>**/
JcForm.prototype.SetDataForm=function(df)
{
	for(var i=0;i<this.Elements.length;i++)
	{	
		var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	
			if(df.GetValue(obj.HtmlEle.id)!=null)
			{
				obj.SetValue(df.GetValue(obj.HtmlEle.id));
				//add by tyaloo
				//date 2007-12-1
				if(obj.HtmlEle.IsSign)
				{
				  var signEle=obj.HtmlEle;
				  
				  var uId=obj.GetValue();
				  if(uId!="")
				  {
				  var signImg=document.createElement("img");
			      signImg.src = "/share/page/ShowImage.aspx?UserId="+uId;
			      signImg.style.height=signEle.style.height;
			      signImg.style.width=signEle.style.width; 

				  signEle.replaceNode(signImg);
				  }
				  signEle=null;
				}
			}
		}
	}
}

JcForm.prototype.CheckIsChange=function(df)
{
	var isChange = false;
	for(var i=0;i<this.Elements.length;i++)
	{	
		var obj=this.Elements[i].Co;
		if(InputElements.indexOf(obj.Type.toLowerCase())>=0)
		{	
			if(df.GetValue(obj.HtmlEle.id)!=null)
			{
				if ( obj.GetValue() != df.GetValue(obj.HtmlEle.id) )
				{
					isChange = true;
					break;
				}
			}
		}
	}
	return isChange;
}

//
//--------------------------------JcForm对象定义结束---------------------------------------------------
//

//
//--------------------------------JcEnum对象定义开始 从JcInput继承-------------------------------------
//

/**<doc type="objdefine" name="JcEnum">
	<desc>JcEnum定义,由JcInput继承</desc>
	<property>
		<prop name="EnumData" type="string">JcEnum所关联的DataEnum</param>
		<prop name="ItemWidth" type="string">JcEnum的单位宽度</param>
		<prop name="ItemHeight" type="string">JcEnum的单位高度</param>
		<prop name="AllowMulti" type="boolean">是否允许多选,默认值为false</param>
		<prop name="HighLight" type="boolean">是否高亮显示,默认值为false</param>
		<prop name="ColumnCount" type="number">JcEnum显示的列数</param>
		<prop name="HasIcon" type="boolean">是否附有图标,默认值为false</param>
		<prop name="_HlItem" type="string">????</param>
	</property>		
</doc>**/
function JcEnum(ele)
{	this.Type="jcenum";
	this.GroupName = null;
	this.DataType="Enum";//Enum/List
	this.TextField = "Text";
	this.ValueField = "Value";
	this.EnumData=null;
	this.ItemWidth="100%";
	this.ItemHeight=20;
	this.AllowMulti=false;//single/multi
	this.HighLight=false;
	this.ColumnCount=1;
	this.HasIcon=false;
	this._HlItem=null;
	this.Init(ele);
}
JcEnum.prototype=new JcInput();

/**<doc type="protofunc" name="JcEnum.Init">
	<desc>JcEnum的构建器</desc>
	<input>
		<param name="ele" type="object">JcEnum对应的HTML元素</param>
	</input>	
</doc>**/
JcEnum.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcenum' jctype='jcenum'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.Css=ele.className;
	
	if(ele.getAttribute("DataType"))
		this.DataType=ele.getAttribute("DataType").toLowerCase();
	if(ele.getAttribute("TextField"))
		this.TextField=ele.getAttribute("TextField").toLowerCase();
	if(ele.getAttribute("ValueField"))
		this.ValueField=ele.getAttribute("ValueField").toLowerCase();
	
	if(ele.getAttribute("EnumData"))
	{	this.EnumData = GetDsNode(ele.getAttribute("EnumData"));
		if(!this.EnumData){alert("JcEnum Init Data Error!");};
	}else
	{
		if(this.DataType == "enum")
			this.EnumData = new DataEnum();
		else
			this.EnumData = new DataList();
	}
			
	if(ele.getAttribute("AllowMulti")!=null)
		this.AllowMulti =true;
	if(ele.getAttribute("GroupName")!=null)
		this.GroupName = ele.getAttribute("GroupName");
	else
		this.GroupName = this.HtmlEle.id;	
		
	var count=ele.getAttribute("ColumnCount");
	if(count && parseInt(count)+""!="NaN")
	{	this.ColumnCount =parseInt(count);
		this.ItemWidth = parseInt(100/this.ColumnCount)+"%";	
	}
	if(ele.getAttribute("HighLight")!=null)
	{	this.HighLight = true;
	}
	ele.style.overflowY="auto";
	ele.style.cursor="default";
	this.SuperInit();	
	this.RenderObject();
}

/**<doc type="protofunc" name="JcEnum.RenderObject">
	<desc>绘制JcEnum</desc>
</doc>**/
JcEnum.prototype.RenderObject=function()
{	if( this.EnumData && this.Render=="client")
	{	var rowcount=this.EnumData.GetItemCount();
		var width = this.HtmlEle.clientWidth;
		//var eleitem = document.createElement("<span type='_jcenumitem' class='"+this.SubCss("Item")+"' style='width:"+this.ItemWidth+";height:"+this.ItemHeight+";overflow:hidden;'>");
		var eleitem = document.createElement("<span type='_jcenumitem' class='"+this.SubCss("Item")+"' style='width:"+this.ItemWidth+";height:"+this.ItemHeight+";'>");
		var type="radio";
		if(this.AllowMulti)type="checkbox";
		eleitem.innerHTML="<table height=100% cellSpacing=0 cellPadding=0 border=0 width=100%>"+
						"<tr><td width='20'><input type='"+type+"' name='sel_"+this.GroupName+"' id='_selector'></td><td id='_text' class='"+this.SubCss("Text")+"' ></td></tr></table>";
		for(var i=0;i<rowcount;i++)
		{		var item = this.EnumData.GetItem(i);
				var eletmp = eleitem.cloneNode(true);
				eletmp.all("_selector").setAttribute("value",item.GetAttr(this.ValueField));
				eletmp.all("_text").innerHTML=item.GetAttr(this.TextField);
				if(!this.AllowEmpty)
				{
					eletmp.style.backgroundColor=MustInputBgColor;				
				}	
				this.HtmlEle.appendChild(eletmp);
		}
	}
	this.HtmlEle.onmouseover=JcEnum.MouseOver;
	this.HtmlEle.onmouseout=JcEnum.MouseOut;
	this.HtmlEle.onclick=JcEnum.MouseClick;
}

/**<doc type="protofunc" name="JcEnum.SelectItem">
	<desc>改变JcEnum中某个Item的点选状态</desc>
	<input>
		<param name="item" type="object">要改变点选状态的Item(如果JcEnum设为单选,则设置与item相反的状态(与state无关),这儿的逻辑待商榷????</param>
		<param name="state" type="boolean">点选状态</param>
	</input>	
</doc>**/
JcEnum.prototype.SelectItem = function(item,state)
{	//if(!this.AllowMulti)
	//{
	item.all("_selector").checked = state;	
	//}else
	//{	var ischk=item.all("_selector").checked;
	//	if(ischk)
	//		item.all("_selector").checked = false;
	//	else
	//		item.all("_selector").checked = true;
	//}
}

/**<doc type="protofunc" name="JcEnum.ClearSelect">
	<desc>清除JcEnum中每个Item的"选择"状态</desc>
</doc>**/
JcEnum.prototype.ClearSelect=function()
{			
	var items= this.HtmlEle.childNodes;
	for(var i=0;i<items.length;i++)
		this.SelectItem(items[i],false);
}


/**<doc type="protofunc" name="JcEnum.GetSelectedItems">
	<desc>获得JcEnum中选中的Item</desc>
</doc>**/
JcEnum.prototype.GetSelectedItems=function()
{	
	var returnItems=new Array();
	//var items= this.HtmlEle.childNodes;
	var items = document.all("sel_"+this.GroupName);
	for(var i=0;i<items.length;i++)
	{
		//if(items[i].all("_selector").checked)
		if(items[i].checked)
			returnItems[returnItems.length]=items[i];
	}		
	return returnItems;
}

JcEnum.prototype.GetValue=function()
{
	var selectedItems=this.GetSelectedItems();
	//var selectedItems = document.all("sel_"+this.GroupName);
	var value="";
	for(var i=0;i<selectedItems.length;i++)
	{
		value+=selectedItems[i].getAttribute("Value")+",";
	}
	if(value.substring(value.length-1,value.length)==',')
		value=value.substring(0,value.length-1);
	return value;	
}

//Edit By Devil Date:2007-11-20
JcEnum.prototype.GetText = function()
{
	var selectedItems=this.GetSelectedItems();
	//var selectedItems = document.all("sel_"+this.GroupName);
	var text="";
	for(var i=0;i<selectedItems.length;i++)
	{
		var value = selectedItems[i].getAttribute("Value");
		text+=this.EnumData.GetItem(this.ValueField,value).GetAttr(this.TextField)+",";
	}
	if(text!="")
		text=text.substring(0,text.length-1);
	return text;
}

//Edit By Devil Date:2007-11-20
JcEnum.prototype.GetDataList = function(name,type)
{
	if(!name) name="";
	if(!type) type="single";
	var dataList = new DataList();
	dataList.SetName(name);
	var value = this.GetValue();
	var text = this.GetText();
	if(type.toLowerCase() == "single")
	{
		var item = dataList.NewItem();
		item.SetAttr("Value",value);
		item.SetAttr("Text",text);
	}
	else
	{
		var values = value.split(",");
		var texts = text.split(",");
		var itemCount = values.length;
		for(var i=0;i<itemCount;i++)
		{
			var item = dataList.NewItem();
			item.SetAttr("Value",values[i]);
			item.SetAttr("Text",texts[i]);
		}
	}
	return dataList;
}

JcEnum.prototype.SetValue=function(values)
{
	values="," + values + ",";
	var items= this.HtmlEle.childNodes;
	for(var i=0;i<items.length;i++)
	{
		if(values.indexOf(","+items[i].all("_selector").getAttribute("Value")+",")>=0)
		{
			items[i].all("_selector").checked=true;
		}	
	}		
}

/**<doc type="protofunc" name="JcEnum.GetAllItems">
	<desc>获得JcEnum中所有的Item</desc>
</doc>**/
JcEnum.prototype.GetAllItems=function()
{
	return this.HtmlEle.childNodes;
}

/**<doc type="protofunc" name="JcEnum.ClearItems">
	<desc> 在JcEnum中清空Item</desc>
</doc>**/
JcEnum.prototype.ClearItems=function()
{	
	var items= this.HtmlEle.childNodes;
	for(var i=0;i<items.length;i++)
	{
		this.HtmlEle.removeChild(items[i]);
	}	
}

/**<doc type="protofunc" name="JcEnum.RemoveItems">
	<desc>往JcEnum中删除Item</desc>
</doc>**/
JcEnum.prototype.RemoveItems=function(items)
{	
	for(var i=0;i<items.length;i++)
		this.HtmlEle.removeChild(items[i]);
}

/**<doc type="protofunc" name="JcEnum.AddItems">
	<desc>往JcEnum中添加Item</desc>
</doc>**/
JcEnum.prototype.AddItems=function(items)
{	
	for(var i=0;i<items.length;i++)
		this.HtmlEle.appendChild(items[i]);
}

/**<doc type="protofunc" name="JcEnum.MouseOver">
	<desc>定义JcEnum的MouseOver事件</desc>
</doc>**/
JcEnum.MouseOver=function()
{	var item=GetJcChildElement(event.srcElement,"_jcenumitem");
	if(!item)return;
	var ele =GetParentJcElement(item);
	var obj =ele.Co;
	if(!obj.HighLight)return;
	var pitem=obj._HlItem;
	if(pitem)
		pitem.className = obj.SubCss("Item");	
	obj._HlItem=item;
	item.className = obj.SubCss("ItemHighLight");	
	item.all("_Text").className=obj.SubCss("TextHighLight");	
}

/**<doc type="protofunc" name="JcEnum.MouseClick">
	<desc>定义JcEnum的MouseClick事件</desc>
</doc>**/
JcEnum.MouseClick=function()
{
	//Modify by Devil for Readonly function Date:2007-07-20
	var evele = event.srcElement;
	var ele = GetParentJcElement(evele);
	if(evele == ele) return;
	var obj = ele.Co;
	//此处为“异或”关系，特此注释
	if(obj.Readonly != (evele.tagName.toLowerCase() == "input"))
	{
		if(!obj.Readonly)
		{
			try{
				eval(obj.HtmlEle.getAttribute("onitemclick"));
			}catch(e){}
		}
		return;
	}
	var item = GetJcChildElement(evele,"_jcenumitem");
	if(!item)return;
	if(!obj.AllowMulti)
		obj.SelectItem(item,true);
	else
	{
		obj.SelectItem(item,!item.all("_selector").checked)
	}
	if(obj.Readonly) return;
	if(obj.AllowEmpty)
	{
		ele.style.backgroundColor=NormalBgColor;
		var ele = ToArray(obj.HtmlEle.childNodes);
		for(var i = 0;i < ele.length;i++)
			ele[i].style.backgroundColor = NormalBgColor;			
	}	
	else
	{
		ele.style.backgroundColor=MustInputBgColor;	
		var ele = ToArray(obj.HtmlEle.childNodes);
		for(var i = 0;i < ele.length;i++)
			ele[i].style.backgroundColor = MustInputBgColor;		
	}
	try{
		eval(obj.HtmlEle.getAttribute("onitemclick"));
	}catch(e){}
}

/**<doc type="protofunc" name="JcEnum.MouseOut">
	<desc>定义JcEnum的MouseOut事件</desc>
</doc>**/
JcEnum.MouseOut=function()
{	var ele =GetParentJcElement(event.srcElement);
	var obj =ele.Co;
	if(!obj.HighLight)return;
	var pitem=obj._HlItem;
	if(pitem)
	{
		pitem.className = obj.SubCss("Item");	
		pitem.all("_Text").className=obj.SubCss("Text");	
	}	
}

JcEnum.prototype.SetReadonly = function(st)
{
	this.Readonly = st;
	var items = ToArray(this.HtmlEle.childNodes);
	for(var i=0;i<items.length;i++)
	{
		if(this.Readonly)
			items[i].style.backgroundColor = ReadonlyBgColor;
		else if(this.Disabled)
			items[i].style.backgroundColor = DisabledBgColor;
		else
		{
			if(!this.AllowEmpty)
				items[i].style.backgroundColor=MustInputBgColor;
			else
				items[i].style.backgroundColor=NormalBgColor;
		}
	}
}

JcEnum.prototype.SetDisabled = function(st)
{
	this.Disabled=st;
	this.HtmlEle.disabled=st;
	if(this.Disabled)
		this.HtmlEle.onclick=null;
	else
		this.HtmlEle.onclick=JcEnum.MouseClick;
	var items = ToArray(this.HtmlEle.childNodes);
	for(var i=0;i<items.length;i++)
	{
		if(this.Disabled)
			items[i].style.backgroundColor=DisabledBgColor;
		else if(this.Readonly)
			items[i].style.backgroundColor=ReadonlyBgColor;
		else
		{
			if(!this.AllowEmpty)
				items[i].style.backgroundColor=MustInputBgColor;
			else
				items[i].style.backgroundColor=NormalBgColor;
		}
	}
}

JcEnum.prototype.Validate=function()
{	
	var value=this.GetValue()
	var validateResult=new ValidateResult();

	var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		var ele = ToArray(this.HtmlEle.childNodes);
		for(var i = 0;i < ele.length;i++)
			ele[i].style.backgroundColor = ErrorBgColor;
		return validateResult;	
	}		
	if(!this.AllowEmpty)
		validateResult.ValidateNotAllowEmpty(value); 

		
	if(!validateResult.Passed)	
	{
		this.HtmlEle.style.backgroundColor = ErrorBgColor;
		var ele = ToArray(this.HtmlEle.childNodes);
		for(var i = 0;i < ele.length;i++)
			ele[i].style.backgroundColor = ErrorBgColor;		
	}
	return validateResult;	

	//ValString="DataType:String;Title:客户名称;Max:12;Min:5;RegExp:00000;"
}

//
//--------------------------------JcEnum对象定义结束---------------------------------------------------
//

//
//--------------------------------JcGrid对象定义开始 从JcInput继承-------------------------------------
//

/**<doc type="objdefine" name="JcGrid">
	<desc>JcGrid定义,由JcInput继承</desc>
	<property>
		<prop name="ListData" type="DataList">JcGrid所关联的DataList</param>
		<prop name="ShowTitle" type="boolean">是否显示Title,默认值为true</param>
		<prop name="Border" type="string">是否显示Border,默认值为true</param>
		<prop name="ColDef" type="string"></param>
		<prop name="_DefRow" type="object">JcGrid的表头定义</param>
		<prop name="_TmplRow" type="string">JcGrid的表的主体模块定义</param>
		<prop name="CurrentCell" type="string"></param>
		<prop name="_CurCellHtml" type="string"></param>
		<prop name="CurrentRow" type="string"></param>
		<prop name="State" type="string">JcGrid的表的状态——对于Enum列，'edit'状态返回value，'view'状态返回text</param>
		<prop name="_OrigMaxRowNo" type="string[]">原始行号标识，大于此行号的行为新增行</param>
		<prop name="MaxRowNo" type="string">最大行号标识，增加行增大，删除行不减小</param>
	</property>		
</doc>**/
function JcGrid(ele)
{	this.Type="jcgrid";
	this.id=null;
	this.ListData=null;
	this.DeletedRows=[];
	this.ShowTitle=true;
	this.Border=true;
	this.ColDef=new Array();
	this._DefRow=null;
	this._TmplRow=null;
	this.CurrentCell=null;
	this._CurCellHtml="";
	this.CurrentRow=null;
	this.PopMenu=null;
	this.HideTitle=null;
	this.State="edit";
	this._OrigMaxRowNo=-1;
	this.MaxRowNo=-1;
	this.OnAddAfter=null;
	this.Init(ele);
	
}
JcGrid.prototype=new JcInput();

/**<doc type="protofunc" name="JcGrid.Init">
	<desc>JcGrid的构建器</desc>
	<input>
		<param name="ele" type="object">JcGrid对应的HTML元素</param>
	</input>	
</doc>**/
JcGrid.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='jcgrid' jctype='jcgrid' style='height:400px;overflow-y:scroll'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co = this;
	this.Css=ele.className;
	this.id=ele.id;
	if(ele.getAttribute("ListData"))
	{	this.ListData = GetDsNode(ele.getAttribute("ListData"));
		if(!this.ListData){alert("Error!");};
	}else
		this.ListData = new DataList();
	if(ele.getAttribute("HideTitle")!=null)
	{
		this.HideTitle=true;
	}
	if(ele.getAttribute("OnAddAfter")!=null)
	{
		this.OnAddAfter=ele.getAttribute("OnAddAfter");
	}	
	this.SuperInit();		
	this._InitDefine();
	this.RenderObject();
	this.InitEvent();
	
	var menuDataStore="<DataStore Name='_Rds' Type='MyType'>";
	menuDataStore+="<Lists>";
	menuDataStore+="	<List Name='_Menu' Type='Menu'>";
	menuDataStore+="		<Row Type='Normal' Title='添加' Method='JcGrid.OnAdd'/>"; //ShortCut='Ctrl-A'
	/*
	menuDataStore+="		<Row Type='Normal' Title='复制' ShortCut='Ctrl-C' Method='JcGrid.OnCopy'/>";
	menuDataStore+="		<Row Type='Normal' Title='删除' ShortCut='Ctrl-D' Method='JcGrid.OnDelete'/>";
	*/
	menuDataStore+="	</List>";
	menuDataStore+="</Lists>";
	menuDataStore+="  </DataStore>";
	this.PopMenu=new JcPopMenu(new DataStore(menuDataStore),JcGrid.MenuEvent);
}

/**<doc type="protofunc" name="JcGrid.GetSelectedTrs">
	<desc>获取JcGrid对象中已选择的行元素数组</desc>
	<input>
		<param name="jcGridObject" type="object">传入的JcGrid对象</param>
	</input>
	<output type="Array">已选择的行元素数组</output>	
</doc>**/
JcGrid.GetSelectedTrs=function(jcGridObject)
{
	var trsArray=new Array();
	var trs=JcGrid.GetRows(jcGridObject);
	for(var i=0;i<trs.length;i++)
	{
		if(trs.item(i).selected=="true")
		{
			trsArray[trsArray.length]=trs.item(i);
		}
	}
	return trsArray;
}

/**<doc type="protofunc" name="JcGrid.GetSelectedTrs">
	<desc>获取JcGrid对象中已行数组</desc>
	<input>
		<param name="jcGridObject" type="object">传入的JcGrid对象</param>
	</input>
	<output type="Array">行元素数组</output>	
</doc>**/
JcGrid.GetRows=function(jcGridObject)
{
	var trs=jcGridObject.HtmlEle.childNodes(0).childNodes(1).childNodes;
	return trs;
}

/**<doc type="protofunc" name="JcGrid.GetSelectedTrs">
	<desc>响应JcGrid的菜单事件</desc>
	<input>
		<param name="type" type="string">菜单命令(JcGrid.OnAdd/JcGrid.OnCopy/JcGrid.OnDelete)</param>
		<param name="parentObject" type="object">传入的JcGrid对象</param>
	</input>
</doc>**/
JcGrid.MenuEvent=function(type,parentObject)
{
	var trsArray=JcGrid.GetSelectedTrs(parentObject);
	switch(type)
	{
		case "JcGrid.OnAdd":
		    var rowNo = parentObject.MaxRowNo+1;
			var row = parentObject.RenderRow(rowNo, true);
			//row.className=parentObject.SubCss("Row");
			row.state="origin"; //数据行处于原始数据状态
			parentObject.HtmlEle.childNodes(0).childNodes(1).appendChild(row);
			row.childNodes(1).focus();
			this.CurrentRow = row;
			if(parentObject.OnAddAfter!=null)
			    eval(parentObject.OnAddAfter.replace("this","parentObject"));
		break;
		case "JcGrid.OnCopy":
			for(var i=0;i<trsArray.length;i++)
			{
				JcGrid.SetUnSelect(trsArray[i]);
				parentObject.HtmlEle.childNodes(0).childNodes(1).appendChild(trsArray[i].cloneNode(true));
			}		
		break;
		case "JcGrid.OnDelete":
			for(var i=0;i<trsArray.length;i++)
			{
				JcGrid.SetUnSelect(trsArray[i]);
				JcGrid.DeleteRow(trsArray[i]);
			}		
		break;				
	}
	parentObject.PopMenu.Hide("_Menu");	
}

JcGrid.prototype.AddRow=function()
{
	//var row = this._TmplRow.cloneNode(true); 
	// 原来的AddRow存在Bug，在此修改， by rey - 2009.2.27
	var row = this.RenderRow((this.MaxRowNo), true);
	var item= this.ListData.NewItem();
	if(arguments[1]==null)
	{
		for(var k=0;k<arguments[0].GetAttrCount();k++)
		{
			item.SetAttr(arguments[0].GetAttrName(k),arguments[0].GetAttr(k));
		}
	}
	else
	{
		for(var i=0;i<arguments.length;i=i+2)
		{
			var name=arguments[i];
			var value=arguments[i+1];
			item.SetAttr(name,value);
		}
	}
	
	row.state="origin"; //数据行处于原始数据状态
	row.Record=item;
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{	var def = this.ColDef[j];
		var type=def["_DefCell"].getAttribute("Type");
		if(!type||(type.toLowerCase()!="indicator"&&type.toLowerCase()!="function"&&type.toLowerCase()!="custom"))
		{	
			row.childNodes[j].childNodes[0].value=this._GetOutput(def,item);
		}
	}
	this.HtmlEle.childNodes(0).childNodes(1).appendChild(row);
	
	return row;
}

JcGrid.prototype.AddItem=function(item)
{
	this.ListData.AddItem(item);
	var row = this._TmplRow.cloneNode(true); 
	row.state="origin"; //数据行处于原始数据状态
	row.Record=item;
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{	var def = this.ColDef[j];
		var type=def["_DefCell"].getAttribute("Type");
		if(!type||(type.toLowerCase()!="indicator"&&type.toLowerCase()!="function"&&type.toLowerCase()!="custom"))
		{	
			row.childNodes[j].childNodes[0].value=this._GetOutput(def,item);
		}
	}
	this.HtmlEle.childNodes(0).childNodes(1).appendChild(row);
	return row;
}

/**<doc type="protofunc" name="JcGrid.SetRowIsDirty">
	<desc>得到JcGrid下指定行或行号中指定控件</desc>
	<input>
		<param name="row" type="obj">要获取的行</param>
		<param name="name" type="string/number">控件序号或控件名</param>
	</input>
	<author>rey 2009.2.25</author>	
</doc>**/ 
JcGrid.prototype.GetJcControl = function(row, name)
{	
	var _rowno;
	if(typeof(row) == "number")
	{	_rowno = row;
		//row = JcGrid.GetRows(this)[_rowno];
		// 由于没有统一的生成id的方法，这种算法不太可靠-by rey 2009.2.25
		row = document.getElementById(this.id + "_TR" + _rowno);	
	}else{_rowno = GetAttr(row, "rowNo", 1,"int");}
	
	var jcs = GetJcElements(row);
	
	if(typeof(name) == "number")
	{return jcs[name].Co;
	}else if(typeof(name) == "string")
	{	for(var i=0; i<jcs.length; i++)
		{	// 由于没有统一的生成id的方法，这种算法不太可靠-by rey 2009.2.25
			if(jcs[i].id == (this.id + "_TR" + _rowno + "_" + name))
			{	return jcs[i].Co;	}
		}
	}else
	{	return null;
	}
}


JcGrid.DeleteRow=function(ele)
{
	var obj=GetParentJcElement(ele).Co;
	while(ele&&ele.tagName.toLowerCase()!="tr")
		ele=ele.parentNode;
	ele.style.display="none";
	
	obj.DeletedRows[obj.DeletedRows.length]=ele.rowNo;//记录被删除的行号
	obj.HtmlEle.childNodes(0).childNodes(1).removeChild(ele);
	
	//alert(ele.innerHTML)
	if(obj.HtmlEle.getAttribute("OnDeleteAfter")!=""&&obj.HtmlEle.getAttribute("OnDeleteAfter")!=null)
		 eval(obj.HtmlEle.getAttribute("OnDeleteAfter").replace("this","ele"));
	
}

/**<doc type="protofunc" name="JcGrid._InitDefine">
	<desc>构建JcGrid的结构</desc>
</doc>**/
JcGrid.prototype._InitDefine=function()
{	var ele = this.HtmlEle;
    var id = ele.id;
	this._DefRow=ele.getElementsByTagName("tr")[0];
	var drow=this._DefRow;
	if(this.HideTitle)
		drow.style.display="none";
	var colnum=drow.childNodes.length;
	var trow = drow.cloneNode(false);
	trow.className=this.SubCss("Common");
	trow.style.display="block";
	for(var i=0;i<colnum;i++)
	{	var tcell=document.createElement("td");
		var cell=drow.childNodes[i];
		cell.className=this.SubCss("Title");
		if( cell.getAttribute("CellValign"))
			tcell.setAttribute("VALIGN", cell.getAttribute("CellValign"));
		if( cell.getAttribute("CellAlign"))
			tcell.setAttribute("ALIGN",cell.getAttribute("CellAlign"));
		/*if(cell.getAttribute("NotAllowEmpty")!=null)
		{
			tcell.style.backgroundColor=MustInputBgColor;
			tcell.NotAllowEmpty="";
		}
		tcell.setAttribute("PreBgColor",tcell.style.backgroundColor);*/
		if(cell.getAttribute("ValString"))
		{
			tcell.id="EleValidate";
			tcell.ValString=cell.getAttribute("ValString");
		}
		if(cell.getAttribute("Hidden")!=null)
		{
			cell.style.display="none";
			tcell.style.display="none";
		}
						
		//tcell.style.cssText = GetAttr(cell,"CellStyle"," ")
		tcell.setAttribute("Name",cell.getAttribute("Name"));
		tcell.style.cursor="text";
		tcell.setAttribute("type","_jgcell");
		
		var defobj=this.ColDef[i]=this.ColDef[cell.getAttribute("Name")]=new Object();
		defobj["Name"]=GetAttr(cell,"Name","");
		defobj["_DefCell"]=cell; //保存定义的单元格
		defobj["DataType"]=GetAttr(cell,"DataType","string");
		if(cell.getAttribute("NotAllowEmpty")!=null)
		    defobj["NotAllowEmpty"]=true;
		defobj["Format"]=GetAttr(cell,"Format",null);
		    
		defobj["Enum"]=GetAttr(cell,"Enum",null);
		if(defobj["Enum"])
			defobj["EnumObject"] = GetDsNode(defobj["Enum"]);
		
		trow.appendChild(tcell);
		//alert(defobj["_DefCell"].outerHTML);
		var type=defobj["_DefCell"].getAttribute("Type");
		if(type)
		{	
			if(type.toLowerCase()=="indicator")
			{
				tcell.innerHTML="<button class='" + this.SubCss("Button") + "' id='_indicator' type='_indicator' pos='body'></button>";
				cell.innerHTML="<button id='_indicator' type='_indicator' class=jcbutton pos='header' title='添加'>添加</button>";
			//class='" + this.SubCss("HeadButton") + "'
			}
			else if(type.toLowerCase()=="function")
			{
				tcell.innerHTML="<img id='_deletor' type='_deletor' pos='body' onclick='JcGrid.DeleteRow(this)'  src='/share/image/jsctrl/delete.gif' style='cursor:hand;'>";
			}
			continue;
		}
	}
	this._TmplRow=trow;
}

/**<doc type="protofunc" name="JcGrid.RenderObject">
	<desc>根据ListData绘制JcGrid的主体</desc>
</doc>**/
JcGrid.prototype.RenderObject=function()
{	
	if( this.ListData)
	{	
		this._OrigMaxRowNo=this.ListData.GetItemCount()-1;
		this.MaxRowNo=this._OrigMaxRowNo;
		this.DeletedRows=[];
		
		var tbody = document.createElement("tbody"); 
		this.HtmlEle.childNodes[0].appendChild(tbody);
		var rowcount=this.ListData.GetItemCount();
		for(var i=0;i<rowcount;i++)
		{
			if(this.Render=="client")
			{
			    var row = this.RenderRow(i);
				tbody.appendChild(row);
			}
			tbody.childNodes[i].Record=this.ListData.GetItem(i);
		}
	}
}

/**<doc type="protofunc" name="JcGrid.RenderRow">
	<desc>初始化一行</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="IsNew" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">初始化的一行</output>	
</doc>**/
JcGrid.prototype.RenderRow=function(RowNo, IsNew)
{
    if(RowNo>this.MaxRowNo) this.MaxRowNo=RowNo;

	var row = this._TmplRow.cloneNode(true);
	//row.className=this.SubCss("Row");
	row.state="origin"; //数据行处于原始数据状态
	row.rowNo=RowNo;
	row.id=this.id+"_TR"+RowNo;
	row.isNew = IsNew;
	var item = this.ListData.GetItem(RowNo);
	row.Record=item;
	// JcGrid换行变色
	if(RowNo%2==0)
	{
		row.style.backgroundColor="#cdcdcd";
	}
	else
	{}
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{
		var def = this.ColDef[j];
		var type=def["_DefCell"].getAttribute("Type");
		
		if(!type||(type.toLowerCase()!="indicator"&&type.toLowerCase()!="function"))
		//if(def["Name"].toLowerCase()!="_indicator")
		{	
            var cell=this._DefRow.childNodes[j];//定义单元TDtcell.

            var defobj=this.ColDef[j]=this.ColDef[cell.getAttribute("Name")]=new Object();
            defobj["Name"]=GetAttr(cell,"Name","");
            defobj["_DefCell"]=cell; //保存定义的单元格
    		
            defobj["DataType"]=GetAttr(cell,"DataType","string");
            defobj["Format"]=GetAttr(cell,"Format",null);
            
            var ed=cell.getAttribute("Editor");
            var edstyle=cell.getAttribute("EditorStyle");
            if(!ed)ed="jctext";
            ed = ed.toLowerCase();
            var edobj=null,edele=null;
            switch(ed)
            {	
                case "jctext":
	                edobj = new JcText();
	                edobj.HtmlEle.style.cssText=(edstyle ? edstyle :"width:100%;");	// 控制被渲染控件样式，默认宽度100%
	                //alert(edobj.HtmlEle.outerHTML)
	                edobj.HtmlEle.OnChangeMethodBody = GetAttr(cell,"onchange",null);
	                if(edobj.HtmlEle.OnChangeMethodBody != null)
	                    edobj.HtmlEle.attachEvent("onblur",JcGrid.OnChange);
	                break;
                case "jcselect":
	                edobj = new JcSelect();
	                edobj.HtmlEle.OptionList=GetAttr(cell,"Enum",null);        //转义属性
	                edobj.HtmlEle.OnChangeMethodBody = GetAttr(cell,"onchange",null);
	                if(edobj.HtmlEle.OnChangeMethodBody != null)
	                    edobj.HtmlEle.attachEvent("onchange",JcGrid.OnChange);
	                break;
                case "jcdropdown":
	                edobj = new JcDropDown();
	                edobj.HtmlEle.DropType=GetAttr(cell,"DropType","");//所弹出的关联实体类型：Calendar,List,Tree
	                edobj.HtmlEle.DataType=GetAttr(cell,"DataType","");//日期类型:Normal,Start,End
	                edobj.HtmlEle.DropUrl=GetAttr(cell,"DropUrl","");
	                edobj.HtmlEle.DropParam=GetAttr(cell,"DropParam","");
	                edobj.HtmlEle.DropSize=GetAttr(cell,"DropSize","width:auto;height:auto;");
	                edobj.HtmlEle.ReturnMode=GetAttr(cell,"ReturnMode","single");//single /multi
	                edobj.HtmlEle.ReturnFields=GetAttr(cell,"ReturnFields",""); //id1,id2,id3	
	                ////////////////////新增-多选 BY RICHARD///////////////////
	                edobj.HtmlEle.ListData=GetAttr(cell,"ListData","");
	                edobj.HtmlEle.ReturnParam=GetAttr(cell,"ReturnParam","");
	                edobj.HtmlEle.TextField=GetAttr(cell,"TextField","");
	                edobj.HtmlEle.ValueField=GetAttr(cell,"ValueField","");
	                edobj.HtmlEle.DropMode=GetAttr(cell,"DropMode","");
	                edobj.HtmlEle.SelectMode=GetAttr(cell,"SelectMode","single");
	                ///////////////////////////////////////////////////////////
	                edobj.HtmlEle.style.width="100%";
	                //id相关
	                var RelateDateID=GetAttr(cell,"RelateDateID",null)
	                if(RelateDateID!=null)
						edobj.HtmlEle.RelateDateID=row.id+"_"+RelateDateID;
	                break;
                case "jcpopup":
	                //构建对象
	                edobj = new JcPopUp();
	                edobj.HtmlEle.PopMode=GetAttr(cell,"PopMode","");
	                edobj.HtmlEle.SetReadOnly=GetAttr(cell,"SetReadOnly","");
	                edobj.HtmlEle.PopStyle=GetAttr(cell,"PopStyle","");
	                edobj.HtmlEle.System=GetAttr(cell,"System","");
	                edobj.HtmlEle.ReturnMode=GetAttr(cell,"ReturnMode","");
	                edobj.HtmlEle.PopType=GetAttr(cell,"PopType","");
	                edobj.HtmlEle.PopUrl=GetAttr(cell,"PopUrl","");
	                edobj.HtmlEle.OnPopBefore=GetAttr(cell,"OnPopBefore",null);
	                edobj.HtmlEle.OnPopAfter=GetAttr(cell,"OnPopAfter",null);
    				
	                //id相关
	                var newPopParam = GetAttr(cell,"PopParam",null);
	                if(newPopParam!=null)
	                {
						var PopParamArray = newPopParam.split(';');
						newPopParam = "";
						for(var k=0; k<PopParamArray.length; k++)
						{
						    if(PopParamArray[k]!="")
						    {
							    var aa = PopParamArray[k].split(':');
							    PopParamArray[k] = aa[0]+":"+row.id+"_"+aa[1];
							    newPopParam += PopParamArray[k]+";";
							}
						}
						edobj.HtmlEle.PopParam=newPopParam;
    				}
    				
	                var newReturnParam = GetAttr(cell,"ReturnParam",null);
	                if(newPopParam!=null)
	                {
						var ReturnParamArray = newReturnParam.split(';');
						newReturnParam = "";
						for(var k=0; k<ReturnParamArray.length; k++)
						{
						    if(PopParamArray[k]!="")
						    {
							    var aa = ReturnParamArray[k].split(':');
							    ReturnParamArray[k] = row.id+"_"+aa[0]+":"+aa[1];
							    newReturnParam += ReturnParamArray[k]+";";
							}
						}
						edobj.HtmlEle.ReturnParam = newReturnParam;
	                }
	                break;
                case "jctextarea":
	                edobj = new JcTextArea();
	                edobj.HtmlEle.style.paddingLeft=0;
	                break;
            }
            if(edobj)
            {
	            edobj.HtmlEle.id=row.id+"_"+GetAttr(cell,"Name","");
	            if(cell.NotAllowEmpty=="")
	                edobj.HtmlEle.NotAllowEmpty = "";
	            
	             edobj.Init(edobj.HtmlEle);
	            
	            //modify by zhangwf 2008-09-09
	            //var readonly=GetAttr(cell,"readonly",null);
	            var readonly=cell.getAttribute("readonly")
	            //alert(cell.getAttribute("readonly"));
	            if(readonly!=null)
	            {
	                edobj.SetReadonly(true);
	            }
	            var disable=GetAttr(cell,"disable",null);
	            if(disable!=null)
	                edobj.SetDisabled(true);
							
                row.childNodes[j].appendChild(edobj.HtmlEle);
                
			    //赋值
                if(IsNew)
                {
		            var value=def["_DefCell"].getAttribute("DefValue");
			        edobj.SetValue(value);
			    }
                else
			        edobj.SetValue(this._GetOutput(def,item));
            }			
		}
	}
	return row;
}

/**<doc type="protofunc" name="JcGrid.InitEvent">
	<desc>初始化JcGrid的相关事件</desc>
</doc>**/
JcGrid.prototype.InitEvent=function()
{	var tbl=this.HtmlEle.childNodes[0];
	tbl.onclick=JcGrid.MouseClick;
	tbl.onkeydown=JcGrid.KeyDown;
	tbl.oncontextmenu = JcGrid.ContextMenu;
	tbl.ondeactivate=JcGrid.DeActivate;
}

JcGrid.OnChange = function()
{
    var ele = event.srcElement;
    var myEvent = ele.OnChangeMethodBody;
    myEvent = myEvent.replace("[id]","'" + ele.id + "'");
    ele=GetTableTr(ele);
    myEvent = myEvent.replace("[rowNo]","'" + ele.rowNo + "'");
    
    eval(myEvent);
}

/**<doc type="protofunc" name="JcGrid.MouseClick">
	<desc>定义JcGrid的MouseClick事件</desc>
</doc>**/
JcGrid.MouseClick=function()
{	
	var idc=GetJcChildElement(event.srcElement,"_indicator");
	
	// 选中当前行
	var _ctr = event.srcElement.parentNode;
	if(_ctr.tagName.toLowerCase() == "tr")
	{
		JcGrid.SetSelect(_ctr);
	}
	else if(_ctr.parentNode.tagName.toLowerCase() == "tr")
	{
		JcGrid.SetSelect(_ctr.parentNode);
	}
	
	if(idc&&idc.pos=="header")
	{
		var ele=GetParentJcElement(idc);
		JcGrid.MenuEvent("JcGrid.OnAdd",ele.Co);
		return false;
	}
}

/**<doc type="protofunc" name="JcGrid.ContextMenu">
	<desc>定义JcGrid的鼠标右键事件</desc>
</doc>**/
JcGrid.ContextMenu=function()
{	
	var ele=GetParentJcElement(event.srcElement);//get jcgrid object
	var obj=ele.Co;
	var idc=GetJcChildElement(event.srcElement,"_indicator");
	if(idc)
	{	
		obj.PopMenu.Hide("_Menu");
		obj.PopMenu.Show("_Menu",window.event.x,window.event.y,obj);
		event.returnValue=false;
		return;	
	}else
	{	JcGrid.MouseClick();
	}
 }

/**<doc type="protofunc" name="JcGrid.GetValue">
	<desc>从JcGrid获取DataList的XML</desc>
	<input>
		<param name="dlname" type="string">获取的DataList的名称</param>
	</input>	
	<output type="string">获取的DataList的XML????</output>
</doc>**/ 
JcGrid.prototype.GetValue=function(dlname)
{
	var dl = new DataList();
	//字段列表
	var flds=this._GetFields();
	dl.SetAttr("Fields",flds);
	
	//获得数据行
	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var j=0;j<count;j++)
	{
		var item = dl.NewItem();
		this.GetItemData(rows[j],item);
		item.SetAttr("__STATE","");
		item.SetAttr("__rowNo",rows[j].rowNo);
	}
	
	if(dlname)dl.SetName(dlname);
	return dl;
}

//删除行的原始数据
JcGrid.prototype.GetDeletedValue=function(dlname)
{
	var dl = new DataList();
	//字段列表
	var flds=this._GetFields();
	dl.SetAttr("Fields",flds);
	
	//获得删除行数据
	for(var i=0;i<this.DeletedRows.length;i++)
		if(this.DeletedRows[i]>this._OrigMaxRowNo)
			return dl;
		else
		{
			var item = this.ListData.GetItem(this.DeletedRows[i]);
			item.SetAttr("__STATE","Deleted");
			item.SetAttr("__rowNo",this.DeletedRows[i]);
			dl.AddItem(item);
		}
			
	if(dlname)dl.SetName(dlname);
	return dl;
}

//除控间数据外的初始化或SetValue后的原始数据被删除的行
JcGrid.prototype.GetAllValue=function(dlname)
{
    var dl = this.GetValue();
    var dlDeleted = this.GetDeletedValue();
	for(var i=0;i<dlDeleted.GetItemCount();i++)
	{
		var item = dlDeleted.GetItem(i);
		dl.AddItem(item);
	}
	
	if(dlname)dl.SetName(dlname);
	return dl;
}

JcGrid.prototype._GetFields=function()
{
	//字段列表
	var flds="";
	for(var i=0;i<this._TmplRow.childNodes.length;i++)
	{	var cell = this._TmplRow.childNodes[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		flds+=name+",";
	}
	if(flds.length>0)flds=flds.substr(0,flds.length-1);
	flds=flds+",__STATE";
	
	return flds;
}

/**<doc type="protofunc" name="JcGrid.GetItemData">
	<desc>从JcGrid获取DataList的XML</desc>
	<input>
	</input>	
	<output type="string">获取的DataItem的XML????</output>
</doc>**/ 
JcGrid.prototype.GetItemData = function(row,item)
{
	for(var i=0;i<row.cells.length;i++)
	{	var cell = row.cells[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		var ele=cell.childNodes[0];
		if(ele.tagName.toLowerCase()=="input"||ele.tagName.toLowerCase()=="textarea" )
		{
			item.SetAttr(name,this._GetColValue(name,ele.value));
		}	
		else if(ele.getAttribute("jctype")!=null)
		{	
			item.SetAttr(name,ele.Co.GetValue());
		}
	}
}

/**<doc type="protofunc" name="JcGrid.SetValue">
	<desc>设置JcGrid的值</desc>
	<input>
		<param name="value" type="string">待设置的DataList的XML</param>
	</input>
</doc>**/
JcGrid.prototype.SetValue=function(dl)
{	
	var tbl = this.HtmlEle.childNodes[0];
	tbl.removeChild(tbl.childNodes[1]);
	if(typeof(dl) == "object")
		this.ListData = dl;
	else
		this.ListData = new DataList(dl);
	this.RenderObject();
}

/**<doc type="protofunc" name="JcGrid.Validate">
	<desc>验证JcGrid的有效性</desc>
	<output type="object">ValidateResult对象</output>	
</doc>**/
JcGrid.prototype.Validate=function()
{
	var fullResult=new ValidateResult();
	
	//按行改变ValString
	var sp=new StringParam(this.HtmlEle.getAttribute("ValString"));
	var Title = sp.Get("Title");
	//获得数据行
	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var j=0;j<count;j++)
	{
		for(var i=0;i<rows[j].cells.length;i++)//获得单元格
		{	var cell = rows[j].cells[i];
			var name=cell.getAttribute("Name");
			if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
			var ele=cell.childNodes[0];
			
            var cell=this._DefRow.childNodes[i];//定义单元TDtcell.
            var ValString = GetAttr(cell,"ValString","");
            if(ValString!="")
            {
				var sp2=new StringParam(ValString);
				var Title2 = sp2.Get("Title");
				ele.setAttribute("ValString",ValString.replace(Title2,Title+"(第"+(j+1)+"行)"+Title2));
			}
		}
	}
	
	var msg = "";
	var j=1;
	var eles=GetJcElements(tbody);//当前Grid下的控件
	for(var i=0;i<eles.length;i++)
	{	var type=eles[i].getAttribute("jctype");
		if(type && InputElements.indexOf(type.toLowerCase())>=0)
		{
			var Result = eles[i].Co.Validate();
			if(Result!=null&&!Result.Passed)
			{
				msg+=(j++)+")  "+Result.GetErrMsg()+"\n";
			}
		}	
	}
	
	fullResult.Message = msg;
	
	return fullResult;
}

/**<doc type="protofunc" name="JcInput.Validate">
	<desc>验证JcGrid的有效性</desc>
</doc>**/
JcGrid.prototype.DoValidate=function()
{
	var msg = this.Validate().Message;
	
	if (msg.length>0)
	{	
		window.showModalDialog("/share/page/ValidteError.htm",msg,
			"dialogHeight:360px;dialogWidth:500px;edge:Sunken;center:Yes;help:No;resizable:Yes;status:No;scroll:no");
		return false;
	}
	else	
		return true;
}

//////////////////////////////////////////
//	以下为暂未使用的原方法	Tag By Bruce//
//////////////////////////////////////////
/**<doc type="protofunc" name="JcGrid.SetUnSelect">
	<desc>响应JcGrid的未选中事件</desc>
	<input>
		<param name="tr" type="object">未选中的行元素</param>
	</input>
</doc>**/
JcGrid.SetUnSelect=function(tr)
{
	var obj=GetParentJcElement(tr).Co;
	tr.className=obj.SubCss("Common");
	tr.selected="false";
}

/**<doc type="protofunc" name="JcGrid.SetSelect">
	<desc>响应JcGrid的选中事件</desc>
	<input>
		<param name="tr" type="object">选中的行元素</param>
	</input>
</doc>**/
JcGrid.SetSelect=function(tr)
{
	var obj=GetParentJcElement(tr).Co;
	tr.className=obj.SubCss("Select");
	tr.selected="true";
	obj.CurrentRow = tr;
}

/**<doc type="protofunc" name="JcGrid.SetDisabled">
	<desc>设置JcGrid是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcGrid.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this.HtmlEle.all("_text").disabled=st;
	var eles = this.HtmlEle.all("_deletor");
	var tbl=this.HtmlEle.childNodes[0];
	if(!this.Readonly && !this.Disabled)
	{
		tbl.onclick=JcGrid.MouseClick;
		tbl.onkeydown=JcGrid.KeyDown;
		tbl.oncontextmenu = JcGrid.ContextMenu;
		tbl.ondeactivate=JcGrid.DeActivate;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick","JcGrid.DeleteRow(this)");
		else if(eles)
			eles.setAttribute("onclick","JcGrid.DeleteRow(this)");
	}
	else
	{
		tbl.onclick=null;
		tbl.onkeydown=null;
		tbl.oncontextmenu=null;
		tbl.ondeactivate=null;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick",null);
		else if(eles)
			eles.setAttribute("onclick",null);
	}
	/*
	if(this.Disabled)
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
	else if(this.Readonly)
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
	else
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
	*/
}

/**<doc type="protofunc" name="JcGrid.SetReadonly">
	<desc>设置JcGrid是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcGrid.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	var eles = this.HtmlEle.all("_deletor");
	var tbl=this.HtmlEle.childNodes[0];
	if(!this.Readonly && !this.Disabled)
	{
		tbl.onclick=JcGrid.MouseClick;
		tbl.onkeydown=JcGrid.KeyDown;
		tbl.oncontextmenu = JcGrid.ContextMenu;
		tbl.ondeactivate=JcGrid.DeActivate;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick","JcGrid.DeleteRow(this)");
		else if(eles)
			eles.setAttribute("onclick","JcGrid.DeleteRow(this)");
	}
	else
	{
		tbl.onclick=null;
		tbl.onkeydown=null;
		tbl.oncontextmenu=null;
		tbl.ondeactivate=null;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick",null);
		else if(eles)
			eles.setAttribute("onclick",null);
	}
	/*
	this.HtmlEle.all("_text").readOnly=st;
	this.HtmlEle.all("_btn").disabled=st;
	if(!this.Disabled && this.Readonly)
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
	else
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
		*/
}

/**<doc type="protofunc" name="JcGrid._GetOutput">
	<desc>设置某单元格内的显示格式</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="item" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">单元格内的显示文本</output>	
</doc>**/
JcGrid.prototype._GetOutput=function(def,item)
{	var txt=(item.GetAttr(def["Name"])+"").filterNull();
	return this._GetColText(def["Name"],txt);
}

/**<doc type="protofunc" name="JcGrid._GetColValue">
	<desc>获取某单元格所设的值</desc>
	<input>
		<param name="name" type="string">Enum单元格名称</param>
		<param name="text" type="string">单元格内的显示文本</param>
	</input>
	<output type="string">单元格所设的值</output>	
</doc>**/
JcGrid.prototype._GetColValue=function(name,text)
{	
	if(this.ColDef[name].DataType.toLowerCase() != "enum")
		return text;
	else
	{	var val= this.ColDef[name].EnumObject.GetValue(text);
		if(!val)return "";
		return val;
	}
}

/**<doc type="protofunc" name="JcGrid._GetColText">
	<desc>设置某单元格内的显示文本</desc>
	<input>
		<param name="name" type="string">单元格名称</param>
		<param name="value" type="string">单元格内所设的值</param>
	</input>
	<output type="string">单元格内的显示文本</output>		
</doc>**/
JcGrid.prototype._GetColText=function(name,value)
{	
	if(this.ColDef[name].DataType.toLowerCase()!="enum" ||this.State=="edit")
		return value;
	else
	{	var txt=this.ColDef[name].EnumObject.GetText(value);
		if(!txt)return "";
		return txt;
	}
}

/**<doc type="protofunc" name="JcGrid.RestoreCell">
	<desc>还原单元格的样式</desc>
</doc>**/
JcGrid.prototype.RestoreCell=function()
{	
	var td=this.CurrentCell;
	if(!td)
		return;
	prehtml = this._CurCellHtml;
	var name=td.getAttribute("Name");
	var edele = td.all("_jcgrideditor");
	if(!edele)//is jctext,jctextarea
	{	type = td.childNodes[0].getAttribute("type");
		if(type=="text"||type=="textarea")
			td.childNodes[0].select();
		return;
	}
	var tdval = edele.Co.GetValue();
	edele.style.display="none";
	this.ColDef[name]._DefCell.appendChild(edele);
	td.innerHTML = prehtml;
	td.childNodes[0].value=this._GetColText(td.getAttribute("Name"),tdval);
	//td.childNodes[0].onfocus=function(){this.click();};
	this.CurrentCell=null;
	this.CurrentHtml="";
}

/**<doc type="protofunc" name="JcGrid.StoreCell">
	<desc>设置单元格的样式</desc>
</doc>**/
JcGrid.prototype.StoreCell=function(td)
{	
	//if(td.NotAllowEmpty!=null)
	//	td.style.backgroundColor=MustInputBgColor;
	//else
	//	td.style.backgroundColor=NormalBgColor;	
	td.style.backgroundColor=td.PreBgColor;
	var defele=td.childNodes[0];
	if(defele.nochange=="true")
	{	type=defele.getAttribute("type");
		if(type=="text"||type=="textarea")
			defele.select();
		return;
	}
	JcGrid._StoreCellFlag=true;
	window.setTimeout("JcGrid._StoreCellFlag=false;",100);
	var tdtext = td.childNodes[0].value;
	var tdval = this._GetColValue(td.getAttribute("Name"),tdtext);
	this._CurCellHtml = td.innerHTML;
	var name=td.getAttribute("Name");
	var edele = this.ColDef[name]._DefCell.all("_jcgrideditor");
	if(edele)
	{
	    td.innerHTML="";
		edele.style.width = "100%";
		edele.style.display="";
		td.appendChild(edele);
		edele.Co.SetValue(tdval);
		if(edele.all("_text"))
		{	edele.all("_text").focus();
			edele.all("_text").select();
		}else
		{	edele.focus();
			edele.setActive();
		}
	}
}


/**<doc type="protofunc" name="JcGrid.ClearSelect">
	<desc>清除JcGrid的选中行</desc>
</doc>**/
JcGrid._StoreCellFlag=false;
JcGrid.prototype.ClearSelect=function()
{	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	if(!tbody)return;
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var i=0;i<count;i++)
	{	if(rows[i].selected=="true")
		{	
			rows[i].style.backgroundColor=rows[i].PreBgColor;
			//rows[i].style.backgroundColor="white";
			rows[i].selected="false";
		}
	}
}

/**<doc type="protofunc" name="JcGrid.DeActivate">
	<desc>定义JcGrid的DeActivate事件</desc>
</doc>**/
JcGrid.DeActivate=function()
{	var ele=GetParentJcElement(event.srcElement);//get jcgrid object
	if(!ele.Co)	return;	// 由于刷新时会导致Co失效，在此判断 by rey 2009.2.24
	if(ele.Co.Type != "jcgrid")
		ele = GetParentJcElement(ele.parentNode);
	if(JcGrid._StoreCellFlag)return;
	if(document.activeElement)
	{	if(ele.contains(document.activeElement) )return;// sometime body is active element
		if(document.activeElement.Master)return;//如果活动元素是下拉iFRAME
	}
	ele.Co.RestoreCell();
	window.clearTimeout(JcGrid._CheckTimeout);
	ele.Co.ClearSelect();
	ele.Co.PopMenu.Hide("_Menu");
};

/**<doc type="protofunc" name="JcGrid.GetCell">
	<desc>通过指定规则获取指定td的相应单元格</desc>
	<input>
		<param name="td" type="object">指定的td元素</param>
		<param name="type" type="string">获取规则:next/pre/down/up</param>
	</input>	
</doc>**/
JcGrid.GetCell=function(td,type)
{	
	var tbody = td.parentNode.parentNode;
	var tcol = td.parentNode.childNodes.length;
	var trow = tbody.childNodes.length;
	var col = GetNodeIndex(td);
	var row = GetNodeIndex(td.parentNode);
	
	switch(type)
	{	case "next":
			col++;
			if(col>=tcol){	col=1;row++;}
			if(row>=trow){ row=trow-1;col=tcol-1;}
			break;
		case "pre":
			col--;
			if(col<0){	col=tcol-1;row--;}
			if(row<0){  row=0;col=1;}
			break;
		case "down":
			row--;
			if(row<0){	row=0;}
			break;
		case "up":
			row++;
			if(row>=trow){	row=trow-1;}
			break;
	}
	var cell = tbody.childNodes[row].childNodes[col];
	return cell;
}

/**<doc type="protofunc" name="JcGrid.KeyDown">
	<desc>定义JcGrid的KeyDown事件</desc>
</doc>**/
JcGrid.KeyDown=function()
{	
	var td=GetJcChildElement(event.srcElement,"_jgcell");
	if(!td)return;
	var kc=event.keyCode;
	var ctrl=event.ctrlKey;
	var shift=event.shiftKey;
	var ncell=null;
	if(kc==9 ||(kc==39 && ctrl))
		ncell=JcGrid.GetCell(td,"next");
	if((kc==37 && ctrl)||(kc==9 && shift))
		ncell=JcGrid.GetCell(td,"pre");
	if(kc==38 && ctrl)
		ncell=JcGrid.GetCell(td,"down");
	if(kc==40 && ctrl)
		ncell=JcGrid.GetCell(td,"up");
	if(ncell || kc==9)	
		event.returnValue=false;
	if(ncell)
		ncell.click();
}

/**<doc type="protofunc" name="JcGrid.CheckDirty">
	<desc>检查JcGrid中的某一行是否Dirty</desc>
	<input>
		<param name="row" type="obj">要检查的行</param>
	</input>	
</doc>**/  
JcGrid._CheckTimeout=0;
JcGrid._CheckRow=null;
JcGrid.CheckDirty=function (row)
{	if (typeof(row)!="undefined")
	{	JcGrid._CheckRow = row;
		JcGrid._CheckTimeout = window.setTimeout(JcGrid.CheckDirty,200);
		return;
	}
	var state=JcGrid._CheckRow.getAttribute("state");
	if( typeof(state)!="undefined" && state!="origin")
	{	return;
	}
	var isdirty = JcGrid.IsRowDirty(JcGrid._CheckRow);
	if (isdirty)
		JcGrid.SetRowIsDirty(JcGrid._CheckRow);
	else
		JcGrid._CheckTimeout = window.setTimeout(JcGrid.CheckDirty,200);
}

/**<doc type="protofunc" name="JcGrid.IsRowDirty">
	<desc>判断JcGrid中的某一行状态是否为Dirty</desc>
	<input>
		<param name="row" type="obj">要判断的行</param>
	</input>	
</doc>**/ 
JcGrid.IsRowDirty=function (row)
{	var ele=GetParentJcElement(row);//get jcgrid object
	var obj=ele.Co;
	var rowvalue="";
	for(var i=0;i<row.cells.length;i++)
	{	var cell = row.cells[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		var ele=cell.childNodes[0];
		if(ele.tagName.toLowerCase()=="input" )
			rowvalue+=obj._GetColValue(name,ele.value);
		else if(ele.getAttribute("jctype")!=null)
		{	rowvalue+=ele.Co.GetValue();
		}
	}	
	if(typeof(row.origin)=="undefined")
	{	row.origin = rowvalue;
		return false;
	}
	if(row.origin != rowvalue)
		return true;
	else 
		return false;
}

/**<doc type="protofunc" name="JcGrid.SetRowIsDirty">
	<desc>设置JcGrid中的某一行为Dirty(状态为N(new)/M(modify))</desc>
	<input>
		<param name="row" type="obj">要设置的行</param>
	</input>	
</doc>**/ 
JcGrid.SetRowIsDirty=function(row)
{	var idc = row.all("_indicator");
	if(!idc)return;
	if(!row.state)
		row.state = "new";
	if(row.state=="new")
		idc.innerHTML="N";
	if(row.state == "origin")
	{	idc.state == "modify";
		idc.innerHTML = "●";
	}	
	
}
//
//--------------------------------JcGrid对象定义结束---------------------------------------------------




//
//--------------------------------JcGridNew对象定义开始 从JcInput继承-------------------------------------
//

/**<doc type="objdefine" name="JcGridNew">
	<desc>JcGridNew定义,由JcInput继承</desc>
	<property>
		<prop name="ListData" type="DataList">JcGridNew所关联的DataList</param>
		<prop name="ShowTitle" type="boolean">是否显示Title,默认值为true</param>
		<prop name="Border" type="string">是否显示Border,默认值为true</param>
		<prop name="ColDef" type="string"></param>
		<prop name="_DefRow" type="object">JcGridNew的表头定义</param>
		<prop name="_TmplRow" type="string">JcGridNew的表的主体模块定义</param>
		<prop name="CurrentCell" type="string"></param>
		<prop name="_CurCellHtml" type="string"></param>
		<prop name="CurrentRow" type="string"></param>
		<prop name="State" type="string">JcGridNew的表的状态——对于Enum列，'edit'状态返回value，'view'状态返回text</param>
		<prop name="_OrigMaxRowNo" type="string[]">原始行号标识，大于此行号的行为新增行</param>
		<prop name="MaxRowNo" type="string">最大行号标识，增加行增大，删除行不减小</param>
	</property>		
</doc>**/
function JcGridNew(ele)
{	this.Type="JcGridNew";
	this.id=null;
	this.ListData=null;
	this.DeletedRows=[];
	this.ShowTitle=true;
	this.Border=true;
	this.ColDef=new Array();
	this._DefRow=null;
	this._TmplRow=null;
	this.CurrentCell=null;
	this._CurCellHtml="";
	this.CurrentRow=null;
	this.PopMenu=null;
	this.HideTitle=null;
	this.State="edit";
	this._OrigMaxRowNo=-1;
	this.MaxRowNo=-1;
	this.OnAddAfter=null;
	this.Init(ele);
	
}
JcGridNew.prototype=new JcInput();

/**<doc type="protofunc" name="JcGridNew.Init">
	<desc>JcGridNew的构建器</desc>
	<input>
		<param name="ele" type="object">JcGridNew对应的HTML元素</param>
	</input>	
</doc>**/
JcGridNew.prototype.Init=function(ele)
{	if(!ele)ele=document.createElement("<span class='JcGridNew' jctype='JcGridNew' style='height:400px;overflow-y:scroll'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.Css=ele.className;
	this.id=ele.id;
	if(ele.getAttribute("ListData"))
	{	this.ListData = GetDsNode(ele.getAttribute("ListData"));
		if(!this.ListData){alert("Error!");};
	}else
		this.ListData = new DataList();
	if(ele.getAttribute("HideTitle")!=null)
	{
		this.HideTitle=true;
	}
	if(ele.getAttribute("OnAddAfter")!=null)
	{
		this.OnAddAfter=ele.getAttribute("OnAddAfter");
	}	
	this.SuperInit();		
	this._InitDefine();
	this.RenderObject();
	this.InitEvent();
	
	var menuDataStore="<DataStore Name='_Rds' Type='MyType'>";
	menuDataStore+="<Lists>";
	menuDataStore+="	<List Name='_Menu' Type='Menu'>";
	menuDataStore+="		<Row Type='Normal' Title='添加' Method='JcGridNew.OnAdd'/>"; //ShortCut='Ctrl-A'
	/*
	menuDataStore+="		<Row Type='Normal' Title='复制' ShortCut='Ctrl-C' Method='JcGridNew.OnCopy'/>";
	menuDataStore+="		<Row Type='Normal' Title='删除' ShortCut='Ctrl-D' Method='JcGridNew.OnDelete'/>";
	*/
	menuDataStore+="	</List>";
	menuDataStore+="</Lists>";
	menuDataStore+="  </DataStore>";
	this.PopMenu=new JcPopMenu(new DataStore(menuDataStore),JcGridNew.MenuEvent);
}

/**<doc type="protofunc" name="JcGridNew.GetSelectedTrs">
	<desc>获取JcGridNew对象中已选择的行元素数组</desc>
	<input>
		<param name="JcGridNewObject" type="object">传入的JcGridNew对象</param>
	</input>
	<output type="Array">已选择的行元素数组</output>	
</doc>**/
JcGridNew.GetSelectedTrs=function(JcGridNewObject)
{
	var trsArray=new Array();
	var trs=JcGridNewObject.HtmlEle.childNodes(0).childNodes(1).childNodes;
	for(var i=0;i<trs.length;i++)
	{
		if(trs.item(i).selected=="true")
		{
			trsArray[trsArray.length]=trs.item(i);
		}
	}
	return trsArray;
}

/**<doc type="protofunc" name="JcGridNew.GetSelectedTrs">
	<desc>响应JcGridNew的菜单事件</desc>
	<input>
		<param name="type" type="string">菜单命令(JcGridNew.OnAdd/JcGridNew.OnCopy/JcGridNew.OnDelete)</param>
		<param name="parentObject" type="object">传入的JcGridNew对象</param>
	</input>
</doc>**/
JcGridNew.MenuEvent=function(type,parentObject)
{
	var trsArray=JcGridNew.GetSelectedTrs(parentObject);
	switch(type)
	{
		case "JcGridNew.OnAdd":
		    var rowNo = parentObject.MaxRowNo+1;
			var row = parentObject.RenderRow(rowNo, true);
			//row.className=parentObject.SubCss("Row");
			row.state="origin"; //数据行处于原始数据状态
			parentObject.HtmlEle.childNodes(0).childNodes(1).appendChild(row);
			row.childNodes(1).focus();
			if(parentObject.OnAddAfter!=null)
			    eval(parentObject.OnAddAfter.replace("this","parentObject"));
		break;
		case "JcGridNew.OnCopy":
			for(var i=0;i<trsArray.length;i++)
			{
				JcGridNew.SetUnSelect(trsArray[i]);
				parentObject.HtmlEle.childNodes(0).childNodes(1).appendChild(trsArray[i].cloneNode(true));
			}		
		break;
		case "JcGridNew.OnDelete":
			for(var i=0;i<trsArray.length;i++)
			{
				JcGridNew.SetUnSelect(trsArray[i]);
				JcGridNew.DeleteRow(trsArray[i]);
			}		
		break;				
	}
	parentObject.PopMenu.Hide("_Menu");	
}

JcGridNew.DeleteRow=function(ele)
{
	var obj=GetParentJcElement(ele).Co;
	while(ele&&ele.tagName.toLowerCase()!="tr")
		ele=ele.parentNode;
	ele.style.display="none";
	
	obj.DeletedRows[obj.DeletedRows.length]=ele.rowNo;//记录被删除的行号
	obj.HtmlEle.childNodes(0).childNodes(1).removeChild(ele);
}

/**<doc type="protofunc" name="JcGridNew._InitDefine">
	<desc>构建JcGridNew的结构</desc>
</doc>**/
JcGridNew.prototype._InitDefine=function()
{	var ele = this.HtmlEle;
    var id = ele.id;
    
	this._DefRow=ele.getElementsByTagName("tr")[0];
	var drow=this._DefRow;
	if(this.HideTitle)
		drow.style.display="none";
	var colnum=drow.childNodes.length;
	var trow = drow.cloneNode(false);
	trow.className=this.SubCss("Common");
	trow.style.display="block";
	for(var i=0;i<colnum;i++)
	{	var tcell=document.createElement("td");
		var cell=drow.childNodes[i];
		cell.className=this.SubCss("Title");
		if( cell.getAttribute("CellValign"))
			tcell.setAttribute("VALIGN", cell.getAttribute("CellValign"));
		if( cell.getAttribute("CellAlign"))
			tcell.setAttribute("ALIGN",cell.getAttribute("CellAlign"));
		/*if(cell.getAttribute("NotAllowEmpty")!=null)
		{
			tcell.style.backgroundColor=MustInputBgColor;
			tcell.NotAllowEmpty="";
		}
		tcell.setAttribute("PreBgColor",tcell.style.backgroundColor);*/
		if(cell.getAttribute("ValString"))
		{
			tcell.id="EleValidate";
			tcell.ValString=cell.getAttribute("ValString");
		}
		if(cell.getAttribute("Hidden")!=null)
		{
			cell.style.display="none";
			tcell.style.display="none";
		}
						
		//tcell.style.cssText = GetAttr(cell,"CellStyle"," ")
		tcell.setAttribute("Name",cell.getAttribute("Name"));
		tcell.style.cursor="text";
		tcell.setAttribute("type","_jgcell");
		
		var defobj=this.ColDef[i]=this.ColDef[cell.getAttribute("Name")]=new Object();
		defobj["Name"]=GetAttr(cell,"Name","");
		defobj["_DefCell"]=cell; //保存定义的单元格
		defobj["DataType"]=GetAttr(cell,"DataType","string");
		if(cell.getAttribute("NotAllowEmpty")!=null)
		    defobj["NotAllowEmpty"]=true;
		defobj["Format"]=GetAttr(cell,"Format",null);
		    
		defobj["Enum"]=GetAttr(cell,"Enum",null);
		if(defobj["Enum"])
			defobj["EnumObject"] = GetDsNode(defobj["Enum"]);
		
		trow.appendChild(tcell);
		//alert(defobj["_DefCell"].outerHTML);
		var type=defobj["_DefCell"].getAttribute("Type");
		if(type)
		{	
			if(type.toLowerCase()=="indicator")
			{
				tcell.innerHTML="<button class='" + this.SubCss("Button") + "' id='_indicator' type='_indicator' pos='body'></button>";
				cell.innerHTML="<button id='_indicator' type='_indicator' pos='header' title='添加'>添加</button>";
			//class='" + this.SubCss("HeadButton") + "'
			}
			else if(type.toLowerCase()=="function")
			{
				tcell.innerHTML="<img id='_deletor' type='_deletor' pos='body' onclick='JcGridNew.DeleteRow(this)'  src='/share/image/jsctrl/delete.gif' style='cursor:hand;'>";
			}
			continue;
		}
	}
	this._TmplRow=trow;
}

/**<doc type="protofunc" name="JcGridNew.RenderObject">
	<desc>根据ListData绘制JcGridNew的主体</desc>
</doc>**/
JcGridNew.prototype.RenderObject=function()
{	
	if( this.ListData)
	{	
		this._OrigMaxRowNo=this.ListData.GetItemCount()-1;
		this.MaxRowNo=this._OrigMaxRowNo;
		this.DeletedRows=[];
		
		var tbody = document.createElement("tbody"); 
		this.HtmlEle.childNodes[0].appendChild(tbody);
		var rowcount=this.ListData.GetItemCount();
		for(var i=0;i<rowcount;i++)
		{
			if(this.Render=="client")
			{
			    var row = this.RenderRow(i);
				tbody.appendChild(row);
			}
			tbody.childNodes[i].Record=this.ListData.GetItem(i);
		}
	}
}

/**<doc type="protofunc" name="JcGridNew.RenderRow">
	<desc>初始化一行</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="IsNew" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">初始化的一行</output>	
</doc>**/
JcGridNew.prototype.RenderRow=function(RowNo, IsNew)
{
    if(RowNo>this.MaxRowNo) this.MaxRowNo=RowNo;

	var row = this._TmplRow.cloneNode(true);
	//row.className=this.SubCss("Row");
	row.state="origin"; //数据行处于原始数据状态
	row.rowNo=RowNo;
	row.id=this.id+"_TR"+RowNo;
	row.isNew = IsNew;
	var item = this.ListData.GetItem(RowNo);
	row.Record=item;
	
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{
		var def = this.ColDef[j];
		var type=def["_DefCell"].getAttribute("Type");
		
		if(!type||(type.toLowerCase()!="indicator"&&type.toLowerCase()!="function"))
		//if(def["Name"].toLowerCase()!="_indicator")
		{	
            var cell=this._DefRow.childNodes[j];//定义单元TDtcell.

            var defobj=this.ColDef[j]=this.ColDef[cell.getAttribute("Name")]=new Object();
            defobj["Name"]=GetAttr(cell,"Name","");
            defobj["_DefCell"]=cell; //保存定义的单元格
    		
            defobj["DataType"]=GetAttr(cell,"DataType","string");
            defobj["Format"]=GetAttr(cell,"Format",null);
            
            var ed=cell.getAttribute("Editor");
            if(!ed)ed="jctext";
            ed = ed.toLowerCase();
            var edobj=null,edele=null;
            switch(ed)
            {	
                case "jctext":
                    
	                edobj = new JcText();
	                edobj.HtmlEle.OnChangeMethodBody = GetAttr(cell,"onchange",null);
	                if(edobj.HtmlEle.OnChangeMethodBody != null)
	                    edobj.HtmlEle.attachEvent("onblur",JcGridNew.OnChange);
	                break;
                case "jcselect":
	                edobj = new JcSelect();
	                edobj.HtmlEle.OptionList=GetAttr(cell,"Enum",null);        //转义属性
	                edobj.HtmlEle.OnChangeMethodBody = GetAttr(cell,"onchange",null);
	                if(edobj.HtmlEle.OnChangeMethodBody != null)
	                    edobj.HtmlEle.attachEvent("onchange",JcGridNew.OnChange);
	                break;
                case "jcdropdown":
	                edobj = new JcDropDown();
	                edobj.HtmlEle.DropType=GetAttr(cell,"DropType","");//所弹出的关联实体类型：Calendar,List,Tree
	                edobj.HtmlEle.DataType=GetAttr(cell,"DataType","");//日期类型:Normal,Start,End
	                edobj.HtmlEle.DropUrl=GetAttr(cell,"DropUrl","");
	                edobj.HtmlEle.DropParam=GetAttr(cell,"DropParam","");
	                edobj.HtmlEle.DropSize=GetAttr(cell,"DropSize","width:auto;height:auto;");
	                edobj.HtmlEle.ReturnMode=GetAttr(cell,"ReturnMode","single");//single /multi
	                edobj.HtmlEle.ReturnFields=GetAttr(cell,"ReturnFields",""); //id1,id2,id3	
	                edobj.HtmlEle.style.width="100%";
	                //id相关
	                var RelateDateID=GetAttr(cell,"RelateDateID",null)
	                if(RelateDateID!=null)
						edobj.HtmlEle.RelateDateID=row.id+"_"+RelateDateID;
	                break;
                case "jcpopup":
	                //构建对象
	                edobj = new JcPopUp();
	                edobj.HtmlEle.PopMode=GetAttr(cell,"PopMode","");
	                edobj.HtmlEle.SetReadOnly=GetAttr(cell,"SetReadOnly","");
	                edobj.HtmlEle.PopStyle=GetAttr(cell,"PopStyle","");
	                edobj.HtmlEle.System=GetAttr(cell,"System","");
	                edobj.HtmlEle.ReturnMode=GetAttr(cell,"ReturnMode","");
	                edobj.HtmlEle.PopType=GetAttr(cell,"PopType","");
	                edobj.HtmlEle.PopUrl=GetAttr(cell,"PopUrl","");
	                edobj.HtmlEle.OnPopBefore=GetAttr(cell,"OnPopBefore",null);
	                edobj.HtmlEle.OnPopAfter=GetAttr(cell,"OnPopAfter",null);
    				
	                //id相关
	                var newPopParam = GetAttr(cell,"PopParam",null);
	                if(newPopParam!=null)
	                {
						var PopParamArray = newPopParam.split(';');
						newPopParam = "";
						for(var k=0; k<PopParamArray.length; k++)
						{
						    if(PopParamArray[k]!="")
						    {
							    var aa = PopParamArray[k].split(':');
							    PopParamArray[k] = aa[0]+":"+row.id+"_"+aa[1];
							    newPopParam += PopParamArray[k]+";";
							}
						}
						
						edobj.HtmlEle.PopParam=newPopParam;
    				}
    				
	                var newReturnParam = GetAttr(cell,"ReturnParam",null);
	                if(newPopParam!=null)
	                {
						var ReturnParamArray = newReturnParam.split(';');
						newReturnParam = "";
						for(var k=0; k<ReturnParamArray.length; k++)
						{
						    if(PopParamArray[k]!="")
						    {
							    var aa = ReturnParamArray[k].split(':');
							    ReturnParamArray[k] = row.id+"_"+aa[0]+":"+aa[1];
							    newReturnParam += ReturnParamArray[k]+";";
							}
						}
						edobj.HtmlEle.ReturnParam = newReturnParam;
	                }
	                break;
                case "jctextarea":
	                edobj = new JcTextArea();
	                edobj.HtmlEle.style.paddingLeft=0;
	                break;
            }
            if(edobj)
            {
	            edobj.HtmlEle.id=row.id+"_"+GetAttr(cell,"Name","");
	            if(cell.NotAllowEmpty=="")
	                edobj.HtmlEle.NotAllowEmpty = "";
	            
	            edobj.Init(edobj.HtmlEle);
	            var readonly=GetAttr(cell,"readonly",null);
	            if(readonly!=null)
	                edobj.SetReadonly(true);
	            var disable=GetAttr(cell,"disable",null);
	            if(disable!=null)
	                edobj.SetDisabled(true);
									
                row.childNodes[j].appendChild(edobj.HtmlEle);
                
			    //赋值
                if(IsNew)
                {
		            var value=def["_DefCell"].getAttribute("DefValue");
			        edobj.SetValue(value);
			    }
                else
			        edobj.SetValue(this._GetOutput(def,item));
            }			
		}
	}
	return row;
}

/**<doc type="protofunc" name="JcGridNew.InitEvent">
	<desc>初始化JcGridNew的相关事件</desc>
</doc>**/
JcGridNew.prototype.InitEvent=function()
{	var tbl=this.HtmlEle.childNodes[0];
	tbl.onclick=JcGridNew.MouseClick;
	tbl.onkeydown=JcGridNew.KeyDown;
	tbl.oncontextmenu = JcGridNew.ContextMenu;
	tbl.ondeactivate=JcGridNew.DeActivate;
}

JcGridNew.OnChange = function()
{
    var ele = event.srcElement;
    var myEvent = ele.OnChangeMethodBody;
    myEvent = myEvent.replace("[id]","'" + ele.id + "'");
    ele=GetTableTr(ele);
    myEvent = myEvent.replace("[rowNo]","'" + ele.rowNo + "'");
  
    eval(myEvent);
}

/**<doc type="protofunc" name="JcGridNew.MouseClick">
	<desc>定义JcGridNew的MouseClick事件</desc>
</doc>**/
JcGridNew.MouseClick=function()
{	
	var idc=GetJcChildElement(event.srcElement,"_indicator");
	if(idc&&idc.pos=="header")
	{
		var ele=GetParentJcElement(idc);
		JcGridNew.MenuEvent("JcGridNew.OnAdd",ele.Co);
		return false;
	}
}

/**<doc type="protofunc" name="JcGridNew.ContextMenu">
	<desc>定义JcGridNew的鼠标右键事件</desc>
</doc>**/
JcGridNew.ContextMenu=function()
{	
	var ele=GetParentJcElement(event.srcElement);//get JcGridNew object
	var obj=ele.Co;
	//var idc=GetJcChildElement(event.srcElement,"_indicator");
	//if(idc)
	//{	
		obj.PopMenu.Hide("_Menu");
		obj.PopMenu.Show("_Menu",window.event.x,window.event.y,obj);
		event.returnValue=false;
		return;	
	//}else
	//{	JcGridNew.MouseClick();
	//}
 }

/**<doc type="protofunc" name="JcGridNew.GetValue">
	<desc>从JcGridNew获取DataList的XML</desc>
	<input>
		<param name="dlname" type="string">获取的DataList的名称</param>
	</input>	
	<output type="string">获取的DataList的XML????</output>
</doc>**/ 
JcGridNew.prototype.GetValue=function(dlname)
{
	var dl = new DataList();
	//字段列表
	var flds=this._GetFields();
	dl.SetAttr("Fields",flds);
	
	//获得数据行
	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var j=0;j<count;j++)
	{
		var item = dl.NewItem();
		this.GetItemData(rows[j],item);
		item.SetAttr("__STATE","");
		item.SetAttr("__rowNo",rows[j].rowNo);
	}
	
	if(dlname)dl.SetName(dlname);
	return dl;
}

//删除行的原始数据
JcGridNew.prototype.GetDeletedValue=function(dlname)
{
	var dl = new DataList();
	//字段列表
	var flds=this._GetFields();
	dl.SetAttr("Fields",flds);
	
	//获得删除行数据
	for(var i=0;i<this.DeletedRows.length;i++)
		if(this.DeletedRows[i]>this._OrigMaxRowNo)
			return dl;
		else
		{
			var item = this.ListData.GetItem(this.DeletedRows[i]);
			item.SetAttr("__STATE","Deleted");
			item.SetAttr("__rowNo",this.DeletedRows[i]);
			dl.AddItem(item);
		}
			
	if(dlname)dl.SetName(dlname);
	return dl;
}

//除控间数据外的初始化或SetValue后的原始数据被删除的行
JcGridNew.prototype.GetAllValue=function(dlname)
{
    var dl = this.GetValue();
    var dlDeleted = this.GetDeletedValue();
	for(var i=0;i<dlDeleted.GetItemCount();i++)
	{
		var item = dlDeleted.GetItem(i);
		dl.AddItem(item);
	}
	
	if(dlname)dl.SetName(dlname);
	return dl;
}

JcGridNew.prototype._GetFields=function()
{
	//字段列表
	var flds="";
	for(var i=0;i<this._TmplRow.childNodes.length;i++)
	{	var cell = this._TmplRow.childNodes[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		flds+=name+",";
	}
	if(flds.length>0)flds=flds.substr(0,flds.length-1);
	flds=flds+",__STATE";
	
	return flds;
}

/**<doc type="protofunc" name="JcGridNew.GetItemData">
	<desc>从JcGridNew获取DataList的XML</desc>
	<input>
	</input>	
	<output type="string">获取的DataItem的XML????</output>
</doc>**/ 
JcGridNew.prototype.GetItemData = function(row,item)
{
	for(var i=0;i<row.cells.length;i++)
	{	var cell = row.cells[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		var ele=cell.childNodes[0];
		if(ele.tagName.toLowerCase()=="input"||ele.tagName.toLowerCase()=="textarea" )
		{
			item.SetAttr(name,this._GetColValue(name,ele.value));
		}	
		else if(ele.getAttribute("jctype")!=null)
		{	
			item.SetAttr(name,ele.Co.GetValue());
		}
	}
}

/**<doc type="protofunc" name="JcGridNew.SetValue">
	<desc>设置JcGridNew的值</desc>
	<input>
		<param name="value" type="string">待设置的DataList的XML</param>
	</input>
</doc>**/
JcGridNew.prototype.SetValue=function(dl)
{	
	var tbl = this.HtmlEle.childNodes[0];
	tbl.removeChild(tbl.childNodes[1]);
	this.ListData = dl;
	this.RenderObject();
}

/**<doc type="protofunc" name="JcGridNew.Validate">
	<desc>验证JcGridNew的有效性</desc>
	<output type="object">ValidateResult对象</output>	
</doc>**/
JcGridNew.prototype.Validate=function()
{
}

/**<doc type="protofunc" name="JcInput.Validate">
	<desc>验证JcGridNew的有效性</desc>
</doc>**/
JcGridNew.prototype.DoValidate=function()
{
	//按行改变ValString
	var sp=new StringParam(this.HtmlEle.getAttribute("ValString"));
	var Title = sp.Get("Title");
	//获得数据行
	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var j=0;j<count;j++)
	{
		for(var i=0;i<rows[j].cells.length;i++)//获得单元格
		{	var cell = rows[j].cells[i];
			var name=cell.getAttribute("Name");
			if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
			var ele=cell.childNodes[0];
			
            var cell=this._DefRow.childNodes[i];//定义单元TDtcell.
            var ValString = GetAttr(cell,"ValString","");
            if(ValString!="")
            {
				var sp2=new StringParam(ValString);
				var Title2 = sp2.Get("Title");
				ele.setAttribute("ValString",ValString.replace(Title2,Title+"(第"+(j+1)+"行)"+Title2));
			}
		}
	}
	
	var fullResult=new ValidateResult();
	var msg = "";
	var j=1;
	var eles=GetJcElements(tbody);//当前Grid下的控件
	for(var i=0;i<eles.length;i++)
	{	var type=eles[i].getAttribute("jctype");
		if(type && InputElements.indexOf(type.toLowerCase())>=0)
		{
			var Result = eles[i].Co.Validate();
			if(Result!=null&&!Result.Passed)
			{
				msg+=(j++)+")  "+Result.GetErrMsg()+"\n";
			}
		}	
	}
	
	if (msg.length>0)
	{	
		window.showModalDialog("/share/page/ValidteError.htm",msg,
			"dialogHeight:360px;dialogWidth:500px;edge:Sunken;center:Yes;help:No;resizable:Yes;status:No;scroll:no");
		return false;
	}
	else	
		return true;
}

//////////////////////////////////////////
//	以下为暂未使用的原方法	Tag By Bruce//
//////////////////////////////////////////
/**<doc type="protofunc" name="JcGridNew.SetUnSelect">
	<desc>响应JcGridNew的未选中事件</desc>
	<input>
		<param name="tr" type="object">未选中的行元素</param>
	</input>
</doc>**/
JcGridNew.SetUnSelect=function(tr)
{
	var obj=GetParentJcElement(tr).Co;
	tr.className=obj.SubCss("Common");
	tr.selected="false";
}

/**<doc type="protofunc" name="JcGridNew.SetSelect">
	<desc>响应JcGridNew的选中事件</desc>
	<input>
		<param name="tr" type="object">选中的行元素</param>
	</input>
</doc>**/
JcGridNew.SetSelect=function(tr)
{
	var obj=GetParentJcElement(tr).Co;
	tr.className=obj.SubCss("Select");
	tr.selected="true";
}

/**<doc type="protofunc" name="JcGridNew.SetDisabled">
	<desc>设置JcGridNew是否禁止</desc>
	<input>
		<param name="st" type="boolean">是否禁止</param>
	</input>
</doc>**/
JcGridNew.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	this.HtmlEle.all("_text").disabled=st;
	var eles = this.HtmlEle.all("_deletor");
	var tbl=this.HtmlEle.childNodes[0];
	if(!this.Readonly && !this.Disabled)
	{
		tbl.onclick=JcGridNew.MouseClick;
		tbl.onkeydown=JcGridNew.KeyDown;
		tbl.oncontextmenu = JcGridNew.ContextMenu;
		tbl.ondeactivate=JcGridNew.DeActivate;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick","JcGridNew.DeleteRow(this)");
		else if(eles)
			eles.setAttribute("onclick","JcGridNew.DeleteRow(this)");
	}
	else
	{
		tbl.onclick=null;
		tbl.onkeydown=null;
		tbl.oncontextmenu=null;
		tbl.ondeactivate=null;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick",null);
		else if(eles)
			eles.setAttribute("onclick",null);
	}
	/*
	if(this.Disabled)
		this.HtmlEle.all("_text").style.backgroundColor=DisabledBgColor;
	else if(this.Readonly)
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
	else
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
	*/
}

/**<doc type="protofunc" name="JcGridNew.SetReadonly">
	<desc>设置JcGridNew是否只读</desc>
	<input>
		<param name="st" type="boolean">是否只读</param>
	</input>
</doc>**/
JcGridNew.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	var eles = this.HtmlEle.all("_deletor");
	var tbl=this.HtmlEle.childNodes[0];
	if(!this.Readonly && !this.Disabled)
	{
		tbl.onclick=JcGridNew.MouseClick;
		tbl.onkeydown=JcGridNew.KeyDown;
		tbl.oncontextmenu = JcGridNew.ContextMenu;
		tbl.ondeactivate=JcGridNew.DeActivate;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick","JcGridNew.DeleteRow(this)");
		else if(eles)
			eles.setAttribute("onclick","JcGridNew.DeleteRow(this)");
		//modify by zhangwf 2009-09-03
		//每行的空间都改变属性
		
		var rows=this.HtmlEle.childNodes[0].childNodes[1].childNodes;
		for(var i=0;i<rows.length;i++)
		{
			var cells=rows[i].cells;
			for(var j=0;j<cells.length;j++)
			{
				var name=cells[j].getAttribute("Name");
				if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
				var ele=cells[j].childNodes[0];
				ele.Co.SetReadonly(false);
			}
		}
	}
	else
	{
		tbl.onclick=null;
		tbl.onkeydown=null;
		tbl.oncontextmenu=null;
		tbl.ondeactivate=null;
		if(eles&&eles.length)
			for(var i=0;i<eles.length;i++)
				eles[i].setAttribute("onclick",null);
		else if(eles)
			eles.setAttribute("onclick",null);
	}
	/*
	this.HtmlEle.all("_text").readOnly=st;
	this.HtmlEle.all("_btn").disabled=st;
	if(!this.Disabled && this.Readonly)
		this.HtmlEle.all("_text").style.backgroundColor=ReadonlyBgColor;
	else
		this.HtmlEle.all("_text").style.backgroundColor=NormalBgColor;
		*/
}

/**<doc type="protofunc" name="JcGridNew._GetOutput">
	<desc>设置某单元格内的显示格式</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="item" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">单元格内的显示文本</output>	
</doc>**/
JcGridNew.prototype._GetOutput=function(def,item)
{	var txt=(item.GetAttr(def["Name"])+"").filterNull();
	return this._GetColText(def["Name"],txt);
}

/**<doc type="protofunc" name="JcGridNew._GetColValue">
	<desc>获取某单元格所设的值</desc>
	<input>
		<param name="name" type="string">Enum单元格名称</param>
		<param name="text" type="string">单元格内的显示文本</param>
	</input>
	<output type="string">单元格所设的值</output>	
</doc>**/
JcGridNew.prototype._GetColValue=function(name,text)
{	
	if(this.ColDef[name].DataType.toLowerCase() != "enum")
		return text;
	else
	{	var val= this.ColDef[name].EnumObject.GetValue(text);
		if(!val)return "";
		return val;
	}
}

/**<doc type="protofunc" name="JcGridNew._GetColText">
	<desc>设置某单元格内的显示文本</desc>
	<input>
		<param name="name" type="string">单元格名称</param>
		<param name="value" type="string">单元格内所设的值</param>
	</input>
	<output type="string">单元格内的显示文本</output>		
</doc>**/
JcGridNew.prototype._GetColText=function(name,value)
{	
	if(this.ColDef[name].DataType.toLowerCase()!="enum" ||this.State=="edit")
		return value;
	else
	{	var txt=this.ColDef[name].EnumObject.GetText(value);
		if(!txt)return "";
		return txt;
	}
}

/**<doc type="protofunc" name="JcGridNew.RestoreCell">
	<desc>还原单元格的样式</desc>
</doc>**/
JcGridNew.prototype.RestoreCell=function()
{	
	var td=this.CurrentCell;
	if(!td)
		return;
	prehtml = this._CurCellHtml;
	var name=td.getAttribute("Name");
	var edele = td.all("_JcGridNeweditor");
	if(!edele)//is jctext,jctextarea
	{	type = td.childNodes[0].getAttribute("type");
		if(type=="text"||type=="textarea")
			td.childNodes[0].select();
		return;
	}
	var tdval = edele.Co.GetValue();
	edele.style.display="none";
	this.ColDef[name]._DefCell.appendChild(edele);
	td.innerHTML = prehtml;
	td.childNodes[0].value=this._GetColText(td.getAttribute("Name"),tdval);
	//td.childNodes[0].onfocus=function(){this.click();};
	this.CurrentCell=null;
	this.CurrentHtml="";
}

/**<doc type="protofunc" name="JcGridNew.StoreCell">
	<desc>设置单元格的样式</desc>
</doc>**/
JcGridNew.prototype.StoreCell=function(td)
{	
	//if(td.NotAllowEmpty!=null)
	//	td.style.backgroundColor=MustInputBgColor;
	//else
	//	td.style.backgroundColor=NormalBgColor;	
	td.style.backgroundColor=td.PreBgColor;
	var defele=td.childNodes[0];
	if(defele.nochange=="true")
	{	type=defele.getAttribute("type");
		if(type=="text"||type=="textarea")
			defele.select();
		return;
	}
	JcGridNew._StoreCellFlag=true;
	window.setTimeout("JcGridNew._StoreCellFlag=false;",100);
	var tdtext = td.childNodes[0].value;
	var tdval = this._GetColValue(td.getAttribute("Name"),tdtext);
	this._CurCellHtml = td.innerHTML;
	var name=td.getAttribute("Name");
	var edele = this.ColDef[name]._DefCell.all("_JcGridNeweditor");
	if(edele)
	{
	    td.innerHTML="";
		edele.style.width = "100%";
		edele.style.display="";
		td.appendChild(edele);
		edele.Co.SetValue(tdval);
		if(edele.all("_text"))
		{	edele.all("_text").focus();
			edele.all("_text").select();
		}else
		{	edele.focus();
			edele.setActive();
		}
	}
}


/**<doc type="protofunc" name="JcGridNew.ClearSelect">
	<desc>清除JcGridNew的选中行</desc>
</doc>**/
JcGridNew._StoreCellFlag=false;
JcGridNew.prototype.ClearSelect=function()
{	var tbody = this.HtmlEle.childNodes[0].childNodes[1];
	if(!tbody)return;
	var rows = tbody.childNodes;
	var count = rows.length;
	for(var i=0;i<count;i++)
	{	if(rows[i].selected=="true")
		{	
			rows[i].style.backgroundColor=rows[i].PreBgColor;
			//rows[i].style.backgroundColor="white";
			rows[i].selected="false";
		}
	}
}

/**<doc type="protofunc" name="JcGridNew.DeActivate">
	<desc>定义JcGridNew的DeActivate事件</desc>
</doc>**/
JcGridNew.DeActivate=function()
{	var ele=GetParentJcElement(event.srcElement);//get JcGridNew object
	if(ele.Co.Type != "JcGridNew")
		ele = GetParentJcElement(ele.parentNode);
	if(JcGridNew._StoreCellFlag)return;
	if(document.activeElement)
	{	if(ele.contains(document.activeElement) )return;// sometime body is active element
		if(document.activeElement.Master)return;//如果活动元素是下拉iFRAME
	}
	ele.Co.RestoreCell();
	window.clearTimeout(JcGridNew._CheckTimeout);
	ele.Co.ClearSelect();
	ele.Co.PopMenu.Hide("_Menu");
};

/**<doc type="protofunc" name="JcGridNew.GetCell">
	<desc>通过指定规则获取指定td的相应单元格</desc>
	<input>
		<param name="td" type="object">指定的td元素</param>
		<param name="type" type="string">获取规则:next/pre/down/up</param>
	</input>	
</doc>**/
JcGridNew.GetCell=function(td,type)
{	
	var tbody = td.parentNode.parentNode;
	var tcol = td.parentNode.childNodes.length;
	var trow = tbody.childNodes.length;
	var col = GetNodeIndex(td);
	var row = GetNodeIndex(td.parentNode);
	
	switch(type)
	{	case "next":
			col++;
			if(col>=tcol){	col=1;row++;}
			if(row>=trow){ row=trow-1;col=tcol-1;}
			break;
		case "pre":
			col--;
			if(col<0){	col=tcol-1;row--;}
			if(row<0){  row=0;col=1;}
			break;
		case "down":
			row--;
			if(row<0){	row=0;}
			break;
		case "up":
			row++;
			if(row>=trow){	row=trow-1;}
			break;
	}
	var cell = tbody.childNodes[row].childNodes[col];
	return cell;
}

/**<doc type="protofunc" name="JcGridNew.KeyDown">
	<desc>定义JcGridNew的KeyDown事件</desc>
</doc>**/
JcGridNew.KeyDown=function()
{	
	var td=GetJcChildElement(event.srcElement,"_jgcell");
	if(!td)return;
	var kc=event.keyCode;
	var ctrl=event.ctrlKey;
	var shift=event.shiftKey;
	var ncell=null;
	if(kc==9 ||(kc==39 && ctrl))
		ncell=JcGridNew.GetCell(td,"next");
	if((kc==37 && ctrl)||(kc==9 && shift))
		ncell=JcGridNew.GetCell(td,"pre");
	if(kc==38 && ctrl)
		ncell=JcGridNew.GetCell(td,"down");
	if(kc==40 && ctrl)
		ncell=JcGridNew.GetCell(td,"up");
	if(ncell || kc==9)	
		event.returnValue=false;
	if(ncell)
		ncell.click();
}

/**<doc type="protofunc" name="JcGridNew.CheckDirty">
	<desc>检查JcGridNew中的某一行是否Dirty</desc>
	<input>
		<param name="row" type="obj">要检查的行</param>
	</input>	
</doc>**/  
JcGridNew._CheckTimeout=0;
JcGridNew._CheckRow=null;
JcGridNew.CheckDirty=function (row)
{	if (typeof(row)!="undefined")
	{	JcGridNew._CheckRow = row;
		JcGridNew._CheckTimeout = window.setTimeout(JcGridNew.CheckDirty,200);
		return;
	}
	var state=JcGridNew._CheckRow.getAttribute("state");
	if( typeof(state)!="undefined" && state!="origin")
	{	return;
	}
	var isdirty = JcGridNew.IsRowDirty(JcGridNew._CheckRow);
	if (isdirty)
		JcGridNew.SetRowIsDirty(JcGridNew._CheckRow);
	else
		JcGridNew._CheckTimeout = window.setTimeout(JcGridNew.CheckDirty,200);
}

/**<doc type="protofunc" name="JcGridNew.IsRowDirty">
	<desc>判断JcGridNew中的某一行状态是否为Dirty</desc>
	<input>
		<param name="row" type="obj">要判断的行</param>
	</input>	
</doc>**/ 
JcGridNew.IsRowDirty=function (row)
{	var ele=GetParentJcElement(row);//get JcGridNew object
	var obj=ele.Co;
	var rowvalue="";
	for(var i=0;i<row.cells.length;i++)
	{	var cell = row.cells[i];
		var name=cell.getAttribute("Name");
		if(!name||name.toLowerCase()=="_indicator")continue;//不是数据单元格
		var ele=cell.childNodes[0];
		if(ele.tagName.toLowerCase()=="input" )
			rowvalue+=obj._GetColValue(name,ele.value);
		else if(ele.getAttribute("jctype")!=null)
		{	rowvalue+=ele.Co.GetValue();
		}
	}	
	if(typeof(row.origin)=="undefined")
	{	row.origin = rowvalue;
		return false;
	}
	if(row.origin != rowvalue)
		return true;
	else 
		return false;
}

/**<doc type="protofunc" name="JcGridNew.SetRowIsDirty">
	<desc>设置JcGridNew中的某一行为Dirty(状态为N(new)/M(modify))</desc>
	<input>
		<param name="row" type="obj">要设置的行</param>
	</input>	
</doc>**/ 
JcGridNew.SetRowIsDirty=function(row)
{	var idc = row.all("_indicator");
	if(!idc)return;
	if(!row.state)
		row.state = "new";
	if(row.state=="new")
		idc.innerHTML="N";
	if(row.state == "origin")
	{	idc.state == "modify";
		idc.innerHTML = "●";
	}	
	
}
//
//--------------------------------JcGridNew对象定义结束---------------------------------------------------
//

//
//-------------------------JcSign对象定义开始(现仅用于自定义表单)--------------------------------------
//

/**<doc type="objdefine" name="JcSign">
	<desc>JcSign定义,由JcInput继承</desc>
	<property>
		<prop name="Scale" type="number">横向签名数量,默认为1</param>
		<prop name="Mode" type="string">签名模式(单签或多签)</param>
		<prop name="HasAdvice" type="bool">是否包含意见域</param>
		<prop name="Dateonly" type="bool">签名时间是否包含Time</param>
	</property>		
</doc>**/
function JcSign(ele)
{
	this.Type="jcsign";
	this.Scale = null;
	this.Mode = null;
	this.HasAdvice = null;
	this.Dateonly = null;
	this.ItemCount = 0;
	this.Items = [];
	this.Init(ele);
}

JcSign.prototype = new JcInput();

/**<doc type="protofunc" name="JcSign.Init">
	<desc>JcSign的构建器</desc>
	<input>
		<param name="ele" type="object">JcSign对应的HTML元素</param>
	</input>	
</doc>**/
JcSign.prototype.Init = function(ele)
{
	if(!ele) ele = document.createElement("<span jctype='jcsign' class='jcsign' scale='1' mode='single' hasAdvice='false'>");
	this.Scale = GetAttr(ele,"scale","1","int");
	this.Mode = GetAttr(ele,"mode","single","string");
	this.HasAdvice = GetAttr(ele,"hasadvice","false","bool");
	this.Dateonly = GetAttr(ele,"dateonly","false","bool");
	var table = "<table style='width:100%;table-layout:fixed;' border=0 cellspacing=0 cellpadding=0 style='border-color:gray;'><tbody></tbody></table>";
	ele.innerHTML = table;
	this.HtmlEle = ele;
	this.HtmlEle.Co = this;
	this.SuperInit();
	this._trTmpl = document.createElement("<tr style='height:60px;'>");
	for(var i=0;i<this.Scale;i++)
		this._trTmpl.appendChild(document.createElement("<td style='width:" + 100 / this.Scale + "%;'>"));
}

/**<doc type="protofunc" name="JcSign.SetValue">
	<desc>设置JcSign的值</desc>
	<input>
		<param name="dataList" type="string/DataList">待设置的值</param>
	</input>
</doc>**/
JcSign.prototype.SetValue = function(dataList)
{
	if(dataList == null)
	{
		this.Destroy();
		return;
	}
	if(typeof dataList == 'string')
		dataList = new DataList(dataList);
	var length = dataList.GetItemCount();
	for(var i=0;i<length;i++)
		this.AddItem(dataList.GetItem(i));
}

/**<doc type="protofunc" name="JcSign.GetValue">
	<desc>取得JcSign的值</desc>
	<output type="string">JcSign的值</output>
</doc>**/
JcSign.prototype.GetValue = function()
{
	var dataList = new DataList();
	var ele = this.HtmlEle.firstChild.firstChild;	//span.table.tbody
	var trCount = ele.childNodes.length;
	for(var i=0;i<trCount;i++)
	{
		for(var j=0;j<this.Scale;j++)
		{
			var td = ele.childNodes[i].childNodes[j];
			if(td.firstChild)
			{
				var value = td.firstChild.Co.GetValue();//这里是否能够执行，说明签名图片也是JC控件
				var item = dataList.NewItem();
				item.SetAttr("id",value.id);
				item.SetAttr("date",value.date);
				item.SetAttr("advice",value.advice);
			}
			else
				break;
		}
	}
	return dataList.ToString();
}

JcSign.prototype.Destroy = function()
{
	this.ItemCount = 0;
	var ele = this.HtmlEle.firstChild.firstChild;//span.table.tbody
	while(ele.firstChild)
	{
		ele.removeChild(ele.firstChild);
	}
}

JcSign.prototype.SetReadonly = function(st)
{
	var eles = this.HtmlEle.all("_advice");
	if(eles == null) return;
	if(eles.length)
		for(var i=0;i<eles.length;i++)
			eles[i].readOnly = st;
	else
		eles.readOnly = st;
}

JcSign.prototype.SetDisabled = function(st)
{
	var eles = this.HtmlEle.all("_advice");
	if(eles == null) return;
	if(eles.length)
		for(var i=0;i<eles.length;i++)
			eles[i].disabled = st;
	else
		eles.disabled = st;
}

/**<doc type="protofunc" name="JcSign.SetValue">
	<desc>添加签名</desc>
	<input>
		<param name="arg0" type="DataItem/string">DataItem/id</param>
		<param name="arg1" type="string/Date">date</param>
		<param name="arg2" type="string">advice</param>
	</input>
</doc>**/
JcSign.prototype.AddItem = function(arg0,arg1,arg2)
{
	if(this.Mode.toLowerCase() == "single")
		this.Destroy();
	if(typeof arg0 == 'object')
	{
		arg2 = arg0.GetAttr("advice");
		arg1 = arg0.GetAttr("date");
		arg0 = arg0.GetAttr("id");
	}
	if(typeof arg1 == 'object')
		arg1 = arg1.getFullDate();
	if(this.Dateonly == true)
		arg1 = Dateonly(arg1);
	var	item = new JcSignItem(this.HasAdvice,arg0,arg1,arg2);
	this.Items[this.ItemCount] = item;
	var pos = this.ItemCount % this.Scale;
	if(pos == 0)//span.table.tbody
		this.HtmlEle.firstChild.firstChild.appendChild(this._trTmpl.cloneNode(true));		//span.table.tbody
	this.HtmlEle.firstChild.firstChild.lastChild.childNodes[pos].appendChild(item.HtmlEle);	//span.table.tbody.tr[last].td[pos]
	this.ItemCount++;
}

function JcSignItem(hasAdvice,id,date,advice)
{
	var display = "none";
	if(hasAdvice == true)
		display = "";
	var span = document.createElement("<span>");
	var table = "<table style='width:100%;height:60px;table-layout:fixed;' border=0 cellspacing=0 cellpadding=0>" +
					"<tbody>" +
						"<tr><td style='font-size:9pt;height:60px;display:" + display + ";'><textarea id='_advice' class='jctextarea' style='width:100%;height:100%;'></textarea></td>" +
						"<td style='width:120px;height:60px;'><table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0'><tbody><tr><td><img id='_img' width=120 height=40 style='width:120px;height:40px;'></img></td></tr>" +
						"<tr><td style='font-size:9pt;width:120px;height:20px;'><input id='_date' type='text' readonly='true' class='jctext' style='background-color:transparent;width:100%;height:100%;border-width:0;padding-left:0;overflow:hidden;text-align:center;'/></td></tr></tbody></table></td></tr>" +
					"</tbody>" +
				"</table>";
	span.innerHTML = table;
	this.HtmlEle = span;
	this.HtmlEle.Co = this;
	this.id = this.date = this.advice = "";
	this.SetValue(id,date,advice);
}

JcSignItem.ImgSrc = "/sysmodule/filesystem/DownLoad.aspx?Key=Goodway_BE-DownLoad&IsExec=true&Id=";

JcSignItem.prototype.SetValue = function(id,date,advice)
{
	if(id) this.id = id;
	this.HtmlEle.all("_img").src = JcSignItem.ImgSrc + this.id;
	if(date) this.date = date;
	this.HtmlEle.all("_date").value = this.date;
	if(advice) this.advice = advice;
	this.HtmlEle.all("_advice").value = this.advice; 
}

JcSignItem.prototype.GetValue = function()
{
	this.advice = this.HtmlEle.all("_advice").value;
	return {"id":this.id,"date":this.date,"advice":this.advice};
}

//
//--------------------------------JcSign对象定义结束---------------------------------------------------
//

//
//----------------------------------JcSignPic定义开始(轻量级签名只是适合单个签名的图片使用)----------------------------------------------------------
//
function JcSignPic(ele)
{
  
   this.Type="jcsignpic";
   this.HtmlEle=null;
   this.ShowButton=false;//是否需要弹出签名密码页面的按钮
   this.RelationId="";//关联的UserId字段
   this.RelationValue="";
   this.IsPW=false;//是否需要签名密码
   this.ImgUrl="/sysmodule/Sign/ShowImage.aspx?UserId=";//img 解析图片的地址
   this.OpenUrl="/sysmodule/Sign/SignPasswordx.aspx";//
   this.LayOut="|";//按钮竖直---attribute:LayOut
   this.TbWidth="100%";  //---attribute:TbWidth
   this.TbHeight="100%"; //---htmlattributeTbHeight
   this.ButtonText="签 名";//---ButtonText
   this.OpenW="380px";
   this.OpenH="30px";
   
   this.ImgW="";
   this.ImgH="";
   
   this.ImgWi="";
   this.ImgHi="";
   
   this.Init(ele);
}

JcSignPic.prototype = new JcInput();

JcSignPic.prototype.Init=function(ele)
{
	if(!ele) ele = document.createElement("<span jctype='jcsignpic' class='jcsign'>");  
	
	
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	
	
	if(ele.getAttribute("ShowButton"))
	{
	  
	   this.ShowButton=true;
	}
	if(ele.getAttribute("IsPW"))
	{
	   
	   this.IsPW=true;
	}
	if(ele.getAttribute("LayOut"))
	{
	   if(ele.getAttribute("LayOut")!="")
	   {
	        this.LayOut=ele.getAttribute("LayOut");
	   }
	}
	if(ele.getAttribute("ButtonText"))
	{
	    if(ele.getAttribute("ButtonText")!="")
	   {
	        this.ButtonText=ele.getAttribute("ButtonText");
	   }
	}
	
	if(ele.getAttribute("ImgW"))
	{
	    if(ele.getAttribute("ImgW")!="")
	   {
	        this.ImgW=ele.getAttribute("ImgW");
	        this.ImgWi="width="+"\""+ this.ImgW+"\"";
	   }
	}
	else
	{
	    this.ImgWi="";
	}
	if(ele.getAttribute("ImgH"))
	{
	    if(ele.getAttribute("ImgH")!="")
	   {
	        this.ImgH=ele.getAttribute("ImgH");
	        this.ImgHi="height="+"\""+ this.ImgH+"\"";
	   }
	}
	else
	{
		this.ImgHi="";
	}
	
	if(ele.getAttribute("OpenW")&&ele.getAttribute("OpenW").trim()!="")
	{
	    this.OpenW=ele.getAttribute("OpenW").trim();
	}
	
	if(ele.getAttribute("OpenH")&&ele.getAttribute("OpenH").trim()!="")
	{
	    this.OpenH=ele.getAttribute("OpenH").trim();
	}
	
	if(ele.getAttribute("RelationId")) //如果有关联则不允许有签名密码的业务
	{
	  // if(ele.getAttribute("RelationId")!=""）
	   if(ele.getAttribute("RelationId")!="")
	   {
	   
	        this.RelationId=ele.getAttribute("RelationId");
			var relaElement=document.getElementById(ele.getAttribute("RelationId"));
			
			this.ShowButton=false;
			this.IsPW=false;
	   }
	}
	
	//绘制控件
	this.SuperInit();
	this.DrawControl();
	this.EventInit();
	
}

JcSignPic.prototype.DrawControl=function()
{
   
    var Htmltext="<table border=\"0\"   cellspacing=\"0\" cellpadding=\"0\"  style=\"height:"+this.TbHeight+";width:"+this.TbWidth+"\"><tr>"; //默认为充满整个容器<spa> 
    
    if(this.LayOut=="|"&&this.ShowButton&&this.IsPW)
    {
       
        Htmltext+="<td style=\"width:100%\"  ><img id=\"_SignPic_\" src=\"/sysmodule/Sign/noneImage.gif\" border=\"0\" "+this.ImgHi+" "+this.ImgWi+"  ><input width=\"0px\" height=\"0px\" id=\"_Value_\" type=\"hidden\"></td>";
      
        Htmltext+="<td style=\"width:20px\"  align=\"right\"><button id=\"_SignButton_\" type=\"button\" class=\"jcbutton\"  style=\"writing-mode:tb-rl;width:20px;height:100px\">"+this.ButtonText+"</button></td></tr></table>";
        this.HtmlEle.innerHTML= Htmltext;
        this.HtmlEle.all("_SignButton_").style.height=this.HtmlEle.all("_SignPic_").height-1;
        
    }
    else if(this.LayOut=="-"&&this.ShowButton&&this.IsPW)
    {
        Htmltext+="<td width=\"100%\"><img id=\"_SignPic_\" src=\"/sysmodule/Sign/noneImage.gif\" border=\"0\"   "+this.ImgHi+" "+this.ImgWi+" ><input width=\"0px\" height=\"0px\" id=\"_Value_\" type=\"hidden\"></td></tr>";
        Htmltext+="<tr><td width=\"100%\"><button id=\"_SignButton_\" type=\"button\" class=\"jcbutton\"  style=\"width:100%;height:20px\">"+this.ButtonText+"</button></tr></table>";
        this.HtmlEle.innerHTML= Htmltext;
        this.HtmlEle.all("_SignButton_").style.width=this.HtmlEle.all("_SignPic_").width-1;
    }
    else
    {
         Htmltext+="<td width=\"100%\"><img id=\"_SignPic_\" border=\"0\" src=\"/sysmodule/Sign/noneImage.gif\"  "+this.ImgHi+" "+this.ImgWi+"  ><input width=\"0px\" height=\"0px\" id=\"_Value_\" type=\"hidden\"></td></tr></table>";
         this.HtmlEle.innerHTML= Htmltext; 
    }
}
JcSignPic.prototype.EventInit=function()
{
	
	if(this.ShowButton&&this.IsPW)
	{
	   
		this.HtmlEle.getElementsByTagName("button")[0].onclick=JcSignPic.BtnClick;
		
	}
}
JcSignPic.BtnClick=function()
{
   var FireEle= event.srcElement;
   //var jcEle=FireEle.parentNode.parentNode.parentNode.parentNode;//td.tr.table.spa  GetParentJcElement()
   var jcEle=GetParentJcElement(FireEle);
   if(jcEle.Co)
   {
      var jcEleCo=jcEle.Co;//控件初始化完毕
      
      var eventId=jcEle.id;
      
      
      
      var dialogFeatures = "dialogHeight:"+jcEleCo.OpenH+";dialogWidth:"+jcEleCo.OpenW+";edge:Raised;center:Yes;help:no;resizable:no;status:no;";

	  var returnValueI =window.showModalDialog(jcEleCo.OpenUrl+"?eventId="+eventId,window,dialogFeatures);
	  
	  if(returnValueI)
	  {
		  if(returnValueI=="Lost")
		  {
		       //jcEleCo.SetValue("Lost");
		       
		      
		  }
		  else
		  {
				jcEleCo.SetValue(returnValueI);
		  }
	  }
	
   }
  
   
}
JcSignPic.prototype.SetValue=function(value)
{
   if(value=="Lost")
   {
       this.HtmlEle.all("_SignPic_").src="/sysmodule/Sign/noneImage.gif";
       this.HtmlEle.all("_Value_").value="";
   }
   else if(value&&value.trim()!=""&&this.RelationId.trim()=="")
   {
		this.ImgUrl="/sysmodule/Sign/ShowImage.aspx?UserId="+value;
		this.HtmlEle.all("_SignPic_").src=this.ImgUrl;
		this.HtmlEle.all("_Value_").value=value;
   }
   else if(this.RelationId.trim()!="") 
   {
        
        var RelationEle=document.getElementById(this.RelationId);
        if(RelationEle&&RelationEle.Co)
        {
           this.RelationValue=RelationEle&&RelationEle.Co.GetValue();
        }
		this.ImgUrl="/sysmodule/Sign/ShowImage.aspx?UserId="+this.RelationValue.trim();
		this.HtmlEle.all("_SignPic_").src=this.ImgUrl;
		this.HtmlEle.all("_Value_").value=this.RelationValue;
   }
}
JcSignPic.prototype.GetValue=function()
{
	return this.HtmlEle.all("_Value_").value;
}



JcSignPic.prototype.SetDisabled=function(st)
{	this.Disabled=st;
	this.HtmlEle.disabled=st;
	
	if(this.Disabled) 
	{
		if(this.ShowButton&&this.IsPW&&this.LayOut=="|")
		{
			this.HtmlEle.getElementsByTagName("td")[1].style.display="none";//spa.table.tr.td
		}
		else if(this.ShowButton&&this.IsPW&&this.LayOut=="-")
		{
			this.HtmlEle.getElementsByTagName("tr")[1].style.display="none";//spa.table.tr
		}
		else
		{
		}
	}
	else
	{
			if(this.ShowButton&&this.IsPW&&this.LayOut=="|")
			{
				this.HtmlEle.getElementsByTagName("td")[1].style.display="";//spa.table.tr.td
			}
			else if(this.ShowButton&&this.IsPW&&this.LayOut=="-")
			{
				this.HtmlEle.getElementsByTagName("tr")[1].style.display="";//spa.table.tr
			}
	}	
	
}
JcSignPic.prototype.SetReadonly=function(st)
{	this.Readonly=st;
	this.HtmlEle.readOnly=st;
	if(this.Readonly) 
	{
		if(this.ShowButton&&this.IsPW&&this.LayOut=="|")
		{
			
			this.HtmlEle.getElementsByTagName("td")[1].style.display="none";//spa.table.tr.td
		}
		else if(this.ShowButton&&this.IsPW&&this.LayOut=="-")
		{
			this.HtmlEle.getElementsByTagName("tr")[1].style.display="none";//spa.table.tr
		}
		
	}
	else
	{
		if(this.ShowButton&&this.IsPW&&this.LayOut=="|")
		{
			
			this.HtmlEle.getElementsByTagName("td")[1].style.display="";//spa.table.tr.td
		}
		else if(this.ShowButton&&this.IsPW&&this.LayOut=="-")
		{
			this.HtmlEle.getElementsByTagName("tr")[1].style.display="";//spa.table.tr
		}
	}	
}

JcSignPic.prototype.Validate=function()
{	
   //只是验证是否为空
   var value=this.GetValue()
   
   var validateResult=new ValidateResult();
   
   var valstr=this.HtmlEle.getAttribute("ValString");
	if(valstr)
		validateResult.ValidateFormElement(value,valstr);		
	
	if(!this.AllowEmpty)
	{
		validateResult.ValidateNotAllowEmpty(value); 
		validateResult.Message="";	
	}
	return validateResult;
}

JcSignPic.prototype.Reset=function(value)
{
   this.SetValue(value);
}

///此时页面上的jc控件已经全部创建完毕，无需担心引用空值的错误,可以执行特殊的逻辑
/*
此时可能
*/
/*JcSignPic.prototype.Initialize=function()
{
     if(this.RelationId!="")
     {
             var ImgEml= this.HtmlEle.all("_SignPic_");
           
             var relaElement=document.getElementById(this.HtmlEle.getAttribute("RelationId"));
			
			if(relaElement.Co)
			{
				relaObj=relaElement.Co;
				this.RelationValue=relaObj.GetValue();
				alert(this.RelationValue);
				this.SetValue(this.RelationValue);
			}
			
			alert(this.ImgUrl);
       
     }
}*/


//----------------------------------JcRep定义开始----------------------------------------------------------
function JcRep(ele)
{
	this.Type="jcrep";
	this.HtmlEle=null;
	this.Init(ele);
	this.FileName=null;//附件的名称作为返回值
	this.FileCount=null;//附件个数
	this.FileType=false;
	this.DrawWay="|";//默认为树向绘制
	this.CellWidth=0;//表格直接的空隙
	this.TBorder=0;//表格边框的大小
	this.TitleName="附件";//每个附件前面的小标题
	this.TWidth="100%";
	this.FontColor="blue";
	
	
	//一下处理流程信息
	this.IsFlow=false;
	this.RelateId=null;//流程中的表单ID
	this.FlowDefineId=null;//流程定义的id
	this.TaskDefineId=null//流程环节ID
	this.ShowModel="0";// 为表格的现实模式 默认为0
	this.ListData=null;
	
	this.IsDate=false;//是否只要日期,不要时间
	
	this.Init(ele);
}

JcRep.prototype.Init=function(ele)
{
	if(!ele) ele = document.createElement("<span jctype='jcrep' class='jcsign'>");  
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	
	if(this.HtmlEle.getAttribute("FileType"))
	{
		this.FileType=true;
		
		//NNN+04241845484545706++套红001.doc    FFL019UA_套红演示001.doc
		this.FtpReg=/^NNN\+(\w)+\+\+(([^\u00-\uFF]*|\w*)*)([.]((\w)+))$/;//[^\u00-\uFF]汉字的最大字集(目前这样认为) 解析FTP里的文件[2][5]
		this.FileReg=/^\w+[_](([^\u00-\uFF]*|\w*)*)([.]((\w)+))$/;//解析上传到文件夹里的文件[1]文件名称[4]后缀名称
	}
	if(this.HtmlEle.getAttribute("DrawWay"))
	{
		this.DrawWay=this.HtmlEle.GetAttribute("DrawWay");
	}
	if(this.HtmlEle.getAttribute("cellSpacing"))
	{
		this.CellWidth=this.HtmlEle.GetAttribute("cellSpacing");
	}
	if(this.HtmlEle.getAttribute("TBorder"))
	{
		this.TBorder=this.HtmlEle.GetAttribute("TBorder");
	}
	if(this.HtmlEle.getAttribute("TWidth"))
	{
		this.TWidth=this.HtmlEle.getAttribute("TWidth");
	}
	if(this.HtmlEle.getAttribute("FontColor"))
	{
		this.FontColor=this.HtmlEle.getAttribute("FontColor");
	}
	
	if(this.HtmlEle.getAttribute("IsDate"))
	{
		this.IsDate=true;//为只为日期
	}
	
	///流程中的意见
	if(!this.HtmlEle.getAttribute("IsFlow")){return;}

	this.IsFlow=true;
	this.IsIdear=true;//是否展示意见
	
	this.HrStyle="border:1px dashed ThreeDLightShadow; height:1;";
	
	if(this.HtmlEle.getAttribute("IsIdear"))
	{
		this.IsIdear=true;
	}
	else
	{
		this.IsIdear=false;
	}
	
	if(this.HtmlEle.getAttribute("HrStyle")&&this.HtmlEle.getAttribute("HrStyle").trim()!="")
	{
		this.HrStyle=this.HtmlEle.getAttribute("HrStyle");
	}
	
	if(this.HtmlEle.getAttribute("ShowModel")&&this.HtmlEle.getAttribute("ShowModel").trim()!="")
	{
		this.ShowModel=this.HtmlEle.getAttribute("ShowModel");
	}
	if(this.HtmlEle.getAttribute("RelateId")&&this.HtmlEle.getAttribute("RelateId").trim()!="")
	{
		this.RelateId=GetQueryString(this.HtmlEle.getAttribute("RelateId"));
	}
	else
	{
		this.IsFlow=false;
	}
	if(this.HtmlEle.getAttribute("FlowDefineId")&&this.HtmlEle.getAttribute("FlowDefineId").trim()!="")
	{
		this.FlowDefineId=this.HtmlEle.getAttribute("FlowDefineId");
	}
	else 
	{
		this.IsFlow=false;
	}
	
	if(this.HtmlEle.getAttribute("TaskDefineId")&&this.HtmlEle.getAttribute("TaskDefineId").trim()!="")
	{
		this.TaskDefineId=this.HtmlEle.getAttribute("TaskDefineId");
	}
	else
	{
		this.IsFlow=false;
	}
	
	//绘制流程意见信息
	if(this.IsFlow)
	{  
	    this.DateRegExp=/^\d{4}-\d{1,2}-\d{1,2}/;
		this.BuildFlowInfo();//绘制流程的意见信息
	}
}

JcRep.prototype.SetValue=function(value)
{
	this.HtmlEle.innerHTML=value;
	
	if(this.FileType)
	{
	    if(value.trim()!="")
	    {
			this.DrawControl(value);
		}
	}
	
	//判断是否为 只要日期的格式
	if(this.IsDate)
	{
		if(value.trim()!="")
		{
			var DateRegExp=/^\d{4}-\d{1,2}-\d{1,2}/;
			
			var DateRp=value.match(DateRegExp);
			
			if(DateRp)
			{
				this.HtmlEle.innerHTML=DateRp[0];
			}
		}
	}
}

JcRep.prototype.GetValue=function(value)
{
	return this.HtmlEle.innerHTM;
}

JcRep.prototype.DrawControl=function(value)//这个控件主要用来处理附件绘制
{
	
	if(value.trim()=="")return;
	
	var FileObj=this.FormatFileName(value);
	
	var FileLength=FileObj.length;
	
	if(FileLength==0)return;
	
	var TableStr="<table  id='FileTable' border='"+this.TBorder+"' cellSpacing='"+this.CellWidth+"' width='"+this.TWidth+"'>"
	
	
	for(var ik=0;ik<FileLength;ik++)
	{
	    var FileNumber=ik+1;
		if(this.DrawWay=="|")
		{
			TableStr+="<tr><td style='width:100%;color:"+this.FontColor+"' align='left'>"+this.TitleName+FileNumber+":&nbsp;&nbsp;<a style='cursor:hand' title='点击下载' onclick=\"JcRep.OpenFile('"+FileObj[ik].FullName+"')\" >"+FileObj[ik].Name+"</a></td></tr>"
		}
		else if(this.DrawWay=="-")
		{
		}
	}
	TableStr+="</table>";
	
	this.HtmlEle.innerHTML=TableStr;
	
	
}
JcRep.prototype.BuildFlowInfo=function()//这个控件主要用来处理附件绘制
{
	var RelatePara=new DataParam("RelateId",this.RelateId);
	var FlowDefinePara=new DataParam("FlowDefineId",this.FlowDefineId);
	var TaskDefinePara=new DataParam("TaskDefineId",this.TaskDefineId);
	var Url="/officeauto/SelfControl/SystemPage/Asynch/FlowInfo.aspx";
    
	var ReturnInfo=Execute.PostUrl(Url,"GetTaskInfo",RelatePara,FlowDefinePara,TaskDefinePara);
	
	if(ReturnInfo)
	{
	    if(ReturnInfo.HasError)
	    {
			return;
	    }
	   
		if(ReturnInfo.ReturnDs)
		{
			var JepList=ReturnInfo.ReturnDs.Lists("FlowList");
			this.ListData=JepList;//提供外部的接口如果 有特殊描绘 请重载DrawFlowInfo方法
			this.DrawFlowInfo(this.ListData);
		}
	}
}
JcRep.prototype.DrawFlowInfo=function(ListObject)
{
	var listcount=ListObject.GetItemCount();
	if(listcount==0) return;
	var FormStrs="";//绘制的字符串
	
	//Id,TaskName,FlowName,OwnerUserId,OwnerUserName, FinishTime,Advice,Dept,DeptId
	
	if(this.ShowModel=="0")//普通的显示的模式
	{
		FormStrs="<table style='color:"+this.FontColor+"'  id='FileTable' border='"+this.TBorder+"' cellSpacing='"+this.CellWidth+"' width='"+this.TWidth+"'>"
		for(var ik=0;ik<listcount;ik++)
		{
		    var Itemcx=ListObject.GetItem(ik);
		    var RegE=Itemcx.GetAttr("FinishTime").match(this.DateRegExp);
		    var RegEStr="";
		    if(RegE)
		    {
				RegEStr=RegE[0];
		    }
		    else 
		    {
				RegEStr="";
		    }
		    
			FormStrs+="<tr><td style='width:5%'></td>";
			
			FormStrs+="<td style='width:28%' align='left'>"+Itemcx.GetAttr("Dept")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+Itemcx.GetAttr("OwnerUserName")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+RegEStr+"</td>";
			FormStrs+="<td style='width:20%' align='center'></td></tr>";
			
			var IsAdviceStr=Itemcx.GetAttr("Advice")+"";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			{
			   
				FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
				var AdviceStr="&nbsp;&nbsp;&nbsp;&nbsp;"
				AdviceStr+=Itemcx.GetAttr("Advice");
				FormStrs+="<tr><td align='left' colspan='5'>"+AdviceStr+"</td></tr>";//意见
			}
			
			FormStrs+="<tr><td colspan='5'   ><hr width='100%' size='1' style='"+this.HrStyle+"'></hr></td></tr>";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
			
			///class="Line " colSpan="3" height="1" cellspacing="1"
		}
		FormStrs+="</table>";
		
		this.HtmlEle.innerHTML=FormStrs;
	}
	if(this.ShowModel=="00")//普通的显示的模式(增强模式签名办)
	{
		FormStrs="<table style='color:"+this.FontColor+"'  id='FileTable' border='"+this.TBorder+"' cellSpacing='"+this.CellWidth+"' width='"+this.TWidth+"'>"
		for(var ik=0;ik<listcount;ik++)
		{
		    var Itemcx=ListObject.GetItem(ik);
		    var RegE=Itemcx.GetAttr("FinishTime").match(this.DateRegExp);
		    var RegEStr="";
		    if(RegE)
		    {
				RegEStr=RegE[0];
		    }
		    else 
		    {
				RegEStr="";
		    }
			
			var IsAdviceStr=Itemcx.GetAttr("Advice")+"";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			{
				FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
				var AdviceStr="&nbsp;&nbsp;&nbsp;&nbsp;"
				AdviceStr+=Itemcx.GetAttr("Advice");
				FormStrs+="<tr><td align='left' colspan='5'>"+AdviceStr+"</td></tr>";//意见
			}
		
			FormStrs+="<tr><td style='width:5%'></td>";
			FormStrs+="<td style='width:28%' align='left'>"+Itemcx.GetAttr("Dept")+"</td>";
			
			//FormStrs+="<td style='width:28%'  align='left'>"+Itemcx.GetAttr("OwnerUserName")+"</td>";
			///sysmodule/Sign/ShowImage.aspx?UserId=
			
			FormStrs+="<td style='width:28%'  align='left'><img  border='0' width='80px' height='20px' src='/sysmodule/Sign/ShowImage.aspx?UserId="+Itemcx.GetAttr("OwnerUserId")+"'</td>";
			
			FormStrs+="<td style='width:28%'  align='left'>"+RegEStr+"</td>";
			FormStrs+="<td style='width:20%' align='center'></td></tr>"; 
			
			
			FormStrs+="<tr><td colspan='5'   ><hr width='100%' size='1' style='"+this.HrStyle+"'></hr></td></tr>";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
			
			///class="Line " colSpan="3" height="1" cellspacing="1"
		}
		FormStrs+="</table>";
		
		this.HtmlEle.innerHTML=FormStrs;
	}
	if(this.ShowModel=="1")//普通的显示的模式
	{
		FormStrs="<table style='color:"+this.FontColor+"'  id='FileTable' border='"+this.TBorder+"' cellSpacing='"+this.CellWidth+"' width='"+this.TWidth+"'>"
		for(var ik=0;ik<listcount;ik++)
		{
		    var Itemcx=ListObject.GetItem(ik);
		    var RegE=Itemcx.GetAttr("FinishTime").match(this.DateRegExp);
		    var RegEStr="";
		    if(RegE)
		    {
				RegEStr=RegE[0];
		    }
		    else 
		    {
				RegEStr="";
		    }
		    
			/*FormStrs+="<tr><td style='width:5%'></td>";
			FormStrs+="<td style='width:28%' align='left'>"+Itemcx.GetAttr("Dept")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+Itemcx.GetAttr("OwnerUserName")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+RegEStr+"</td>";
			FormStrs+="<td style='width:20%' align='center'></td></tr>";*/
			
			var IsAdviceStr=Itemcx.GetAttr("Advice")+"";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			{
			   
				FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
				var AdviceStr="&nbsp;&nbsp;&nbsp;&nbsp;"
				AdviceStr+=Itemcx.GetAttr("Advice");
				FormStrs+="<tr><td align='left' colspan='5'>"+AdviceStr+"</td></tr>";//意见
				FormStrs+="<tr><td  colspan='10' height='10px'></td></tr>";
			}
			
			FormStrs+="<tr><td colspan='5'  align='right' >姓名:"+Itemcx.GetAttr("OwnerUserName")+"&nbsp;&nbsp;&nbsp;&nbsp;"+RegEStr+"</td></tr>";
			
			FormStrs+="<tr><td colspan='5'   ><hr width='100%' size='1' style='"+this.HrStyle+"'></hr></td></tr>";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
			
			///class="Line " colSpan="3" height="1" cellspacing="1"			
		}
		FormStrs+="</table>";
		this.HtmlEle.innerHTML=FormStrs;
	}
	
	if(this.ShowModel=="11")//普通的显示的模式 (增强模式签名办)
	{
		FormStrs="<table style='color:"+this.FontColor+"'  id='FileTable' border='"+this.TBorder+"' cellSpacing='"+this.CellWidth+"' width='"+this.TWidth+"'>"
		for(var ik=0;ik<listcount;ik++)
		{
		    var Itemcx=ListObject.GetItem(ik);
		    var RegE=Itemcx.GetAttr("FinishTime").match(this.DateRegExp);
		    var RegEStr="";
		    if(RegE)
		    {
				RegEStr=RegE[0];
		    }
		    else 
		    {
				RegEStr="";
		    }
		    
			/*FormStrs+="<tr><td style='width:5%'></td>";
			
			FormStrs+="<td style='width:28%' align='left'>"+Itemcx.GetAttr("Dept")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+Itemcx.GetAttr("OwnerUserName")+"</td>";
			FormStrs+="<td style='width:28%'  align='left'>"+RegEStr+"</td>";
			FormStrs+="<td style='width:20%' align='center'></td></tr>";*/
			
			var IsAdviceStr=Itemcx.GetAttr("Advice")+"";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			{
			   
				FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
				var AdviceStr="&nbsp;&nbsp;&nbsp;&nbsp;"
				AdviceStr+=Itemcx.GetAttr("Advice");
				FormStrs+="<tr><td align='left' colspan='5'>"+AdviceStr+"</td></tr>";//意见
				FormStrs+="<tr><td  colspan='10' height='10px'></td></tr>";
			}
			
			var ImgUrl="/sysmodule/Sign/ShowImage.aspx?UserId="+Itemcx.GetAttr("OwnerUserId");//img 解析图片的地址
			//<img id=\"_SignPic_\" src=\"/sysmodule/Sign/noneImage.gif\" border=\"0\" "+this.ImgHi+" "+this.ImgWi+"  >
			//FormStrs+="<tr><td colspan='5'  align='right' >姓名:"+Itemcx.GetAttr("OwnerUserId")+"&nbsp;&nbsp;&nbsp;&nbsp;"+RegEStr+"</td></tr>";
			FormStrs+="<tr><td colspan='5'  align='right' >"+"<img id='_SignPic_' width='80px' height='20px'  border='0' src='"+ImgUrl+"'>"  +"&nbsp;&nbsp;&nbsp;&nbsp;"+RegEStr+"</td></tr>";
			FormStrs+="<tr><td colspan='5'   ><hr width='100%' size='1' style='"+this.HrStyle+"'></hr></td></tr>";
			if(this.IsIdear&&IsAdviceStr.trim()!="")
			FormStrs+="<tr><td  colspan='5' height='10px'></td></tr>";
			
			///class="Line " colSpan="3" height="1" cellspacing="1"
		}
		FormStrs+="</table>";
		
		this.HtmlEle.innerHTML=FormStrs;
	}
}
JcRep.OpenFile=function(value)
{
    if(value.trim()=="")return;
    
    LinkTo("/SysModule/FileSystem/Download.aspx?IsExec=true&Key=Goodway_BE-DownLoad&Id=" + value,"_blank","width=800,height=600,top=20000,left=20000");
}

//格式化附件 返回对象数组
JcRep.prototype.FormatFileName=function(value)
{
	var FileObjectX=new Array();//文件对象数组 [FullName]文件的全名 [Name]文件的名字 [Fix]文件的后缀名 [Url]打开文件指定的地址{扩展功能暂时不实现}
	var FileArray=value.split(",");
	
	for(var ik=0;ik<FileArray.length;ik++)
	{
	    var comvalue=this.GetFileType(FileArray[ik]);
		if(typeof(comvalue)=="object")
		{
			FileObjectX[FileObjectX.length]=comvalue;
		}
	}
	
	return FileObjectX;
}

JcRep.prototype.GetFileType=function(value)
{
	var ReturnStr=value.match(this.FtpReg);
	var retval=new Object();
	if(ReturnStr)
	{
	    
	    retval["FullName"]=ReturnStr[0];
	    retval["Name"]=ReturnStr[2];
	    retval["Fix"]=ReturnStr[5];
	    //retval["Url"]="/SysModule/FileSystem/Download.aspx?IsExec=true&Key=Goodway_BE-DownLoad&Id=" + ReturnStr[0];
	    return retval;
	}
	
	ReturnStr=value.match(this.FileReg);
	if(ReturnStr)
	{
		retval["FullName"]=ReturnStr[0];
	    retval["Name"]=ReturnStr[1];
	    retval["Fix"]=ReturnStr[4];
	    //retval["Url"]="/SysModule/FileSystem/Download.aspx?IsExec=true&Key=Goodway_BE-DownLoad&Id=" + ReturnStr[0];
	    return retval;
	}
	
	return null;
}

//
//--------------------------------JcUserSelect对象定义开始---------------------------------------------------
//
function JcUserSelect(ele)
{	
	this.Type = "jcuserselect";
	this.TextArea = null;
	this.DropFrame = null;
	this.SelectMode = null;//single/multi
	this.QueryMode = null;//dynamic/static
	this.RelateId = null;
	this.XmlHttp = null;
	this.QueryUrl = "/orgauth/JcUserSelectQuery.aspx";
	this.curQueryString = "";
	this.TClass="";
	this.Init(ele);
}

JcUserSelect.prototype = new JcInput();

JcUserSelect.prototype.Init = function(ele)
{	
	if(!ele) ele = document.createElement("<span class='jcuserselect' jctype='jcuserselect'>");
	var table = "<table cellpadding=0 cellspacing=0 border=0 style='table-layout:fixed;width:100%;'><tr><td id='$textarea' style='width:100%;'></td><td id='$popup' style='width:20;'></td></tr></table>";
	ele.innerHTML = table;
	this.HtmlEle = ele;
	this.HtmlEle.Co = this;
	if(ele.getAttribute("SelectMode"))
		this.SelectMode = ele.getAttribute("SelectMode").toLowerCase();
	if(ele.getAttribute("QueryUrl"))
		this.QueryUrl = ele.getAttribute("QueryUrl").toLowerCase();
	if(ele.getAttribute("QueryMode"))
		this.QueryMode = ele.getAttribute("QueryMode").toLowerCase();
	else
		this.QueryMode = "dynamic";
	if(ele.getAttribute("RelateId"))
		this.RelateId = ele.getAttribute("RelateId");
		
	if(ele.getAttribute("TClass"))
	{
		this.TClass = "class='"+ele.getAttribute("TClass")+"'";
	}

	this.RenderText();
	this.RenderPopup(ele);
	this.SuperInit();
	this.InitFrame();
	this.InitEvent();
}

JcUserSelect.prototype.RenderText = function()
{
	var text = document.createElement("<textarea class='JcUserSelect_txt'  "+this.TClass+"  rows='1' wrap='off' style='width:100%;overflow:hidden;' >");
	text.title = this.SelectMode=="single"?"人员单选":"人员多选";
	if(!this.AllowEmpty)
		text.style.backgroundColor = MustInputBgColor;
	this.TextArea = text;
	this.HtmlEle.all("$textarea").appendChild(text);
	this.HtmlEle.attachEvent("onpropertychange",function(){
		if(event.propertyName=="style.backgroundColor")
			event.srcElement.all("$textarea").firstChild.style.backgroundColor = event.srcElement.style.backgroundColor;
	});
	
}

JcUserSelect.prototype.RenderPopup = function(ele)
{
	var btn;
	if(this.Readonly!="true"&&this.Disabled!="true")
	{
		btn = document.createElement("<button id='userselect_btn' class='JcPopUp_Button'  style='width:20px;height:21px;background-image:url(/share/image/jsctrl/UserSelect.gif);'>");
	}
	else
	{
		btn = document.createElement("<button id='userselect_btn' class='JcPopUp_Button' style='width:20px;height:21px;background-image:url(/share/image/jsctrl/UserSelect.gif);filter:gray();display:none'>");
	}
	this.Popup = btn;
	this.HtmlEle.all("$popup").appendChild(btn);
	if(this.SelectMode == "single")
	{
		this.PopUrl = "/orgauth/ChooseUser.aspx";
		this.PopStyle = "width=350,height=398";
	}
	else if(this.SelectMode == "multi")
	{
		this.PopUrl = "/orgauth/NewMultiChooseUser.aspx";
		this.PopStyle = "width=660,height=470";
	}
	this.PopUrl += "?CallElementId=" + this.HtmlEle.id + "&OnPopAfter=JcUserSelect.OnPopAfter";
	
	if(ele && ele.getAttribute("PopUrl"))
	{
		this.PopUrl = ele.getAttribute("PopUrl").toLowerCase()+"&CallElementId=" + this.HtmlEle.id + "&OnPopAfter=JcUserSelect.OnPopAfter";
	}
	if(ele && ele.getAttribute("PopStyle"))
	{
		this.PopStyle = ele.getAttribute("PopStyle").toLowerCase();
	}
	//resize
	this.TextArea.style.width = this.HtmlEle.offsetWidth - this.Popup.offsetWidth;
}

JcUserSelect.prototype.InitFrame = function()
{
	var iframe = document.createElement("<iframe id='_iframe_" + this.HtmlEle.id + "' frameborder='no' scrolling='no' style='border:solid 1;position:absolute;z-index:10000;display:none;'>");
	document.body.appendChild(iframe);
	this.DropFrame = iframe;
	window.setTimeout("JcUserSelect.InitFrame('" + this.HtmlEle.id + "')",1);
}

JcUserSelect.InitFrame = function(id)
{
	var iframe = document.getElementById("_iframe_" + id);
	iframe.contentWindow.Master = window;
	var doc = iframe.contentWindow.document;
	var body = doc.body;
	body.leftMargin = "0";
	body.topMargin = "0";
}

JcUserSelect.prototype.InitEvent = function()
{
	this.TextArea.attachEvent("onfocus",JcUserSelect.OnFocus);
	this.TextArea.attachEvent("onblur",JcUserSelect.OnBlur);
	this.TextArea.attachEvent("onkeydown",JcUserSelect.KeyDown);
	this.TextArea.attachEvent("onpropertychange",JcUserSelect.OnPropertyChange);
	this.Popup.attachEvent("onmouseup",JcUserSelect.OnClick);
}

JcUserSelect.OnClick = function()
{
	var ele = event.srcElement;
	var obj = GetParentJcElement(ele).Co;
	if(!obj) return;
	if(obj.Readonly || obj.Disabled) return;
	//set _popParam
	var nameField = obj.SelectMode=="single"?"UserName":"Name";
	var ids = obj.GetIds();
	var names = obj.GetNames();
	_popParam = "Id:" + escape(ids) + ";" + nameField + ":" + escape(names);
	//open window
	window.open(obj.PopUrl,"_win" + obj.HtmlEle.id.replace(".","_"),CenterWin(obj.PopStyle));
}

JcUserSelect.prototype.Fire=function(type)
{	var onfunc=this.HtmlEle.getAttribute(type);
	if(onfunc)
		eval(onfunc);
}

JcUserSelect.OnPopAfter = function(ctrlId,returnString)
{
	var ctrl = Co[ctrlId];
	var nameField = ctrl.SelectMode=="single"?"UserName":"Name";
	var dataList = new DataList(returnString);
	ctrl.Clear();
	for(var i=0,count=dataList.GetItemCount();i<count;i++)
	{
		var item = dataList.GetItem(i);
		ctrl.AddItem(item.GetAttr("Id"),item.GetAttr(nameField));
	}
	//alert(ctrl.HtmlEle.getAttribute("OnPopAfterSubFunc"))
	if(ctrl.HtmlEle.getAttribute("OnPopAfterSubFunc"))
		eval(ctrl.HtmlEle.getAttribute("OnPopAfterSubFunc"));
}

JcUserSelect.prototype.Clear = function()
{
	this.TextArea.innerHTML = "";
}

JcUserSelect.prototype._GetContent = function(type)
{
	var value = "";
	var count = this.TextArea.childNodes.length;
	for(var i=0;i<count;i++)
	{
		var node = this.TextArea.childNodes[i];
		if(node.nodeType == 1 && node.getAttribute("temp") != "true")
			value += (type=="value"?node.getAttribute("id"):node.innerText) + ",";
	}
	if(value != "")
		value = value.substr(0,value.length-1);
	return value;
}

JcUserSelect.prototype.GetValue = function()
{
	return this._GetContent("text");
}

JcUserSelect.prototype.SetValue = function(value)
{
	window.setTimeout("JcUserSelect.SetValue('" + this.HtmlEle.id + "','" + value + "')",10);
}

JcUserSelect.prototype.SetIdName = function(id,name)
{
	var idary = [];
	var nameary = [];
	if(id != "")
	{
		idary = id.split(",");
		nameary = name.split(",");
	}
	this.TextArea.innerHTML = "";
	var count = idary.length;
	for(var i=0;i<count;i++)
		this.AddItem(idary[i],nameary[i]);
	this.FormatText();
}

JcUserSelect.SetValue = function(ctrlId,value)
{
	var obj = Co[ctrlId];
	var id = Co[obj.RelateId].GetValue();
	obj.SetIdName(id,value);
}

JcUserSelect.prototype.GetNames = function()
{
	return this._GetContent("text");
}

JcUserSelect.prototype.GetIds = function()
{
	return this._GetContent("value");
}

JcUserSelect.prototype.AddItem = function(value,text)
{
	var span = document.createElement("<span id='" + value + "' title='" + value + "' unselectable='on' contenteditable='false' style='text-decoration:underline;font-family:宋体;font-size:9pt;'>");
	span.innerHTML = text;
	var textarea = this.TextArea;
	if(this.SelectMode == "single")
	{
		textarea.innerHTML = "";
		textarea.appendChild(span);
	}
	else
	{
		this.FormatText();
		if(textarea.value)
			textarea.appendChild(document.createTextNode(","));
		textarea.appendChild(span);
		textarea.appendChild(document.createTextNode(","));
	}
		this.SetCursor();
	return span;
}

JcUserSelect.prototype.AddTempItem = function(value,text)
{
	JcUserSelect.RemoveWatch();
	this.RemoveTempItem();
	var item = this.AddItem(value,text);
	item.setAttribute("temp","true");
	item.style.textDecoration = "";
	window.setTimeout("JcUserSelect.AddWatch()",1);
}

JcUserSelect.prototype.RemoveTempItem = function()
{
	var count = this.TextArea.childNodes.length;
	for(var i=count-1;i>=0;i--)
	{
		var node = this.TextArea.childNodes[i];
		if(node.nodeType == 1 && node.getAttribute("temp") == "true")
		{
			this.TextArea.removeChild(this.TextArea.childNodes[i]);
			break;
		}
	}
}
//add item by mouse click
JcUserSelect.ClickAddItem = function(value,text)
{
	var ele = document.all(JcUserSelect.CurrentId);
	var obj = ele.Co;
	obj.RemoveTempItem();
	obj.AddItem(value,text);
}
//上下选择回到文本框上的处理
JcUserSelect.prototype.Resume = function()
{
	JcUserSelect.RemoveWatch();
	this.RemoveTempItem();
	var lastNode = this.TextArea.lastChild;
	if(lastNode && lastNode.nodeType == 3 && lastNode.nodeValue == ",")
		lastNode.nodeValue = this.curQueryString;
	else
		this.TextArea.appendChild(document.createTextNode(this.curQueryString));
	this.SetCursor();
	window.setTimeout("JcUserSelect.AddWatch()",1);
}

JcUserSelect.HideFrame = function()
{
	var obj = document.all(JcUserSelect.CurrentId);
	obj.Co.HideFrame();
}
//watch onpropertychange event
JcUserSelect.AddWatch = function()
{
	var ele = document.all(JcUserSelect.CurrentId);
	ele.Co.TextArea.attachEvent("onpropertychange",JcUserSelect.OnPropertyChange);
}
//remove watch onpropertychange event
JcUserSelect.RemoveWatch = function()
{
	var ele = document.all(JcUserSelect.CurrentId);
	ele.Co.TextArea.detachEvent("onpropertychange",JcUserSelect.OnPropertyChange);
}

JcUserSelect.prototype.FormatText = function()
{
	if(this.TextArea.value == "") return;
	//delete textnode
	var node = this.TextArea.childNodes[0];
	while(node)
	{
		var nextNode = node.nextSibling;
		if(node.nodeType == 3)
			node.parentNode.removeChild(node);
		else if(node.nodeType == 1 && node.getAttribute("temp") == "true")
		{
			node.setAttribute("temp","false");
			node.style.textDecoration = "underline";
		}
		node = nextNode;
	}
	//add ","
	var count = this.TextArea.childNodes.length;
	for(var i=0;i<count-1;i++)
	{
		var item = this.TextArea.childNodes[2*i+1];
		this.TextArea.insertBefore(document.createTextNode(","),item);
	}
}

JcUserSelect.prototype.ValidateUser = function()
{
	var count = this.TextArea.childNodes.length;
	for(var i=0;i<count;i++)
	{
		var node = this.TextArea.childNodes[i];
		if(node.nodeType == 1 && node.getAttribute("temp") == "true")
		{
			node.setAttribute("temp","false");
			node.style.textDecoration = "underline";
			if(this.DropFrame.style.display != "none")
			{
				var doc = this.DropFrame.contentWindow.document;
				var row = JcUserSelect.RemoveRow(doc.body.childNodes[0].childNodes[0],node.getAttribute("id"));
			}
		}
	}
}

JcUserSelect.prototype.GetQueryString = function()
{
	var count = this.TextArea.childNodes.length;
	var qryStr = "";
	if(count > 0)
	{
		var lastNode = this.TextArea.childNodes[count-1];
		if(lastNode.nodeType == 3)	//TextNode
		{
			var value = lastNode.nodeValue;
			if(value.length>0)
			{
				var fc = value.substr(0,1);
				if(fc == " " || fc == ",")
					qryStr = value.substr(1,value.length-1);
				else
					qryStr = value;
			}
		}
	}
	return qryStr;
}

JcUserSelect.prototype.SetCursor = function()
{
    var range = this.TextArea.createTextRange(); 
    range.collapse(false); 
    range.moveStart('character',this.TextArea.value.length); 
    range.select();
}

JcUserSelect.prototype.TryCancelQuery = function()
{
	if(this.XmlHttp && this.XmlHttp.readyState != 0 && this.XmlHttp.readyState != 4)
		this.XmlHttp.abort();
}
//dynamic query
JcUserSelect.prototype.QueryData = function(queryString)
{
	this.curQueryString = queryString;
	var qryDp = new DataParam();
	qryDp.SetName("QueryString");
	qryDp.SetValue(queryString);
	var idsDp = new DataParam();
	idsDp.SetName("Ids");
	idsDp.SetValue(this.GetIds());
	this.XmlHttp = Execute.AsyncPostUrl(this.QueryUrl,"JcUserSelectQuery",JcUserSelect.QueryComplete,false,null,qryDp,idsDp);
}

JcUserSelect.CurrentId = null;

JcUserSelect.Regist = function(id)
{
	JcUserSelect.CurrentId = id;
}
//dynamic query complete
JcUserSelect.QueryComplete = function(rtn)
{
	if(!JcUserSelect.CurrentId) return;
	if(rtn && !rtn.HasError)
	{
		var ele = document.getElementById(JcUserSelect.CurrentId);
		var ds = rtn.ReturnDs;
		var list = ds.Lists("QueryData");
		if(list.GetItemCount() > 0)
		{
			var df = ds.Forms("UniqueData");
			if(df)//Add Unique Value
			{
				var ids = df.GetValue("Ids").split(",");
				var names = df.GetValue("Names").split(",");
				var count = ids.length;
				for(var i=0;i<count;i++)
					ele.Co.AddItem(ids[i],names[i]);
			}
			else	//Show Frame
				ele.Co.ShowFrame(list);
		}
	}
}

JcUserSelect.DropRowHeight = 15;
JcUserSelect.DropRowCount = 10;

JcUserSelect.prototype.CreateHtml = function(dataList)
{
	var count = dataList.GetItemCount();
	var height = (count > JcUserSelect.DropRowCount?JcUserSelect.DropRowCount:count) * JcUserSelect.DropRowHeight;
	var html_start = "<div style='width:100%;height:" + height + ";overflow-y:auto;'><table cellpadding='0' cellspacing='0' border='0' style='table-layout:fixed;font-family:宋体;font-size:9pt;cursor:hand;width:100%;height:" + (count * JcUserSelect.DropRowHeight) + ";'><tbody>";
	var html_end = "</tbody></table></div>";
	var html_tr = "<tr id='{Id}' valign='middle' height='" + JcUserSelect.DropRowHeight + "' onmouseover=\"Master.JcUserSelect.SelectRow(this.parentNode.parentNode,'move',this);\" onmousedown=\"Master.JcUserSelect.ClickAddItem(this.id,this.childNodes[0].innerText);Master.JcUserSelect.HideFrame();\"><td align='left' style='color:gray;'>{UserName}</td><td align='right' style='color:green;'>{WorkNo}</td></tr>";
	var htmls = [];
	htmls[0] = html_start;
	for(var i=0;i<count;i++)
	{
		var item = dataList.GetItem(i);
		htmls[i+1] = html_tr.replace("{Id}",item.GetAttr("Id")).replace("{UserName}",item.GetAttr("UserName")).replace("{WorkNo}",item.GetAttr("WorkNo"));
	}
	htmls[count + 1] = html_end;
	return htmls.join("");
}

JcUserSelect.prototype.ShowFrame = function(dataList)
{
	var ele = this.HtmlEle;
	var iframe = this.DropFrame;
	
	var doc = iframe.contentWindow.document;
	doc.body.innerHTML = this.CreateHtml(dataList);
	var count = dataList.GetItemCount();
	var height = (count>JcUserSelect.DropRowCount?JcUserSelect.DropRowCount:count) * JcUserSelect.DropRowHeight;
	
	iframe.style.left = Position.Left(ele);
	iframe.style.top = Position.Top(ele) + Position.Height(ele) - 1;
	iframe.style.width = ele.offsetWidth - 2;
	iframe.style.height = height;
	iframe.style.display = "block";
}

JcUserSelect.prototype.HideFrame = function()
{
	var iframe = this.DropFrame;
	iframe.style.display = "none";
}

JcUserSelect.OnFocus = function()
{
	var ele = event.srcElement;
	var obj = GetParentJcElement(ele).Co;
	JcUserSelect.Regist(obj.HtmlEle.id);
	obj.HtmlEle.style.backgroundColor = obj.PreBgColor;	
	obj.SetCursor();
}

JcUserSelect.OnBlur = function()
{
	var ele = event.srcElement;
	var obj = GetParentJcElement(ele).Co;
	if(!obj) return
	obj.TryCancelQuery();
	obj.FormatText();
	obj.HideFrame();
	//set id
	Co[obj.RelateId].SetValue(obj.GetIds());
	
	
	
	///一下处理关联的功能 zy_gao
	if(obj.HtmlEle.getAttribute("SetLinkId")&&obj.SelectMode=="single"&&obj.GetValue().trim()!="")
	{
		var UserIdc=new DataParam("UserId",obj.GetIds());
		var Url="/officeauto/SelfControl/SystemPage/Asynch/UserInfo.aspx";
		
		var ReturnInfo=Execute.PostUrl(Url,"getdeptinfo",UserIdc);
		
		if(ReturnInfo)
		{
			if(ReturnInfo.HasError)
			{
				return;
			}
			if(ReturnInfo.ReturnDs)
			{
			    var SetLinkId=obj.HtmlEle.getAttribute("SetLinkId");
			    var spc=new StringParam(SetLinkId);
				var DeptList=ReturnInfo.ReturnDs.Lists("DeptInfo");//人力资源表的信息
				
				if(!DeptList||DeptList.GetItemCount()==0)return;
				
				var DeptItem=DeptList.GetItem(0);
				
				for(var ik=0;ik<spc.GetCount();ik++)
				{
					Co[spc.Keys[ik]].SetValue(DeptItem.GetAttr(spc.Values[ik]));
				}
				
			}
		}
		
		
	}
	if(obj.HtmlEle.getAttribute("SetLinkId")&&obj.SelectMode=="single"&&obj.GetValue().trim()=="")
	{
	    var SetLinkId=obj.HtmlEle.getAttribute("SetLinkId");
	    var spc=new StringParam(SetLinkId);
		for(var ik=0;ik<spc.GetCount();ik++)
		{
			Co[spc.Keys[ik]].SetValue("");
		}
	}
	
}

JcUserSelect.OnPropertyChange = function()
{
	if(event.propertyName == "value")
	{
		var ele = event.srcElement;
		//format text
		var count = ele.childNodes.length;
		for(var i=0;i<count;i++)
		{
			var node = ele.childNodes[i];
			if(ele.childNodes[i].nodeType == 3)	//TextNode
			{
				var text = node.nodeValue;
				var newText = text.replaceAll(/[\f\n\r\t\v]/,"");
				if(text != newText)
				{
					node.nodeValue = newText;
					return;
				}
			}
		}
		//reset query
		var obj = GetParentJcElement(ele).Co;
		if(obj.QueryMode == "dynamic")
		{
			obj.HideFrame();
			obj.TryCancelQuery();
			obj.QueryData(obj.GetQueryString());
		}
		else if(obj.QueryMode == "static")
		{
			obj.HideFrame();
			//reset iframe by static data
		}
	}
}

JcUserSelect.KeyEnabled = true;
JcUserSelect.KeyDown = function()
{
	//prevent key down too fast
	if(!JcUserSelect.KeyEnabled)
		return CancelEvent();
	var ele = event.srcElement;
	var obj = GetParentJcElement(ele).Co;
	if(obj.Readonly)
		return CancelEvent();
	switch(event.keyCode)
	{
		case 38:	//up
		case 40:	//down
			JcUserSelect.KeyEnabled = false;
			var action = event.keyCode==38?"up":"down";
			var iframe = obj.DropFrame;
			if(iframe.style.display != "none")
			{
				var doc = iframe.contentWindow.document;
				var row = JcUserSelect.SelectRow(doc.body.childNodes[0].childNodes[0],action);
				if(row)
					obj.AddTempItem(row.getAttribute("id"),row.cells[0].innerText);
				else
					obj.Resume();
			}
			window.setTimeout("JcUserSelect.KeyEnabled=true;",1);
			//
			break;
		case 27:	//esc
			obj.HideFrame();
		case 13:	//enter
			JcUserSelect.KeyEnabled = false;
			obj.ValidateUser();
			if(obj.SelectMode == "single")
				obj.HideFrame();
			else	//resize DropFrame
				obj.AdjustDropFrame();
			window.setTimeout("JcUserSelect.KeyEnabled=true;",1);
			return CancelEvent();
		case 9:
			return CancelEvent();
		case 8:		//backspace
		case 46:	//delete
			break;
		default:
			if(obj.SelectMode == "single")
				if(obj.curQueryString != ele.value)
					ele.value = "";
			obj.ValidateUser();
			if(obj.DropFrame.style.display != "none")
				obj.AdjustDropFrame();
	}
}
//action:up/down/move
JcUserSelect.SelectRow = function(table,action,row)
{
	var index = parseInt(table.getAttribute("SelectRowIndex"));
	if(index == null) index = -1;
	var preRow = index==-1?null:table.rows[index];
	var curRow = null;
	if(action == "move")
		curRow = row;
	else
	{
		if(preRow == null)
			curRow = action=="up"?table.rows[table.rows.length-1]:table.rows[0];
		else if(action == "up")
			curRow = preRow==table.rows[0]?null:table.rows[index-1];
		else if(action == "down")
			curRow = preRow==table.rows[table.rows.length-1]?null:table.rows[index+1];
	}
	if(preRow)
		preRow.style.backgroundColor = "white";
	if(curRow)
	{
		curRow.style.backgroundColor = "lime";
		var div = table.parentNode;
		table.setAttribute("SelectRowIndex",curRow.rowIndex);
		//auto scroll
		if(curRow.offsetTop + curRow.offsetHeight >= div.offsetHeight + div.scrollTop)
			div.scrollTop = curRow.offsetTop + curRow.offsetHeight - div.offsetHeight;
		else if(curRow.offsetTop <= div.scrollTop)
			div.scrollTop = curRow.offsetTop;
	}
	else
		table.setAttribute("SelectRowIndex",-1);
	return curRow;
}

JcUserSelect.RemoveRow = function(table,id)
{
	var row = table.all(id);
	var index = row.rowIndex;
	table.childNodes[0].removeChild(row);
	return JcUserSelect.SelectRow(table,"move",table.rows[table.rows.length==index?index-1:index]);
}

JcUserSelect.prototype.AdjustDropFrame = function()
{
	var doc = this.DropFrame.contentWindow.document;
	var table = doc.body.childNodes[0].childNodes[0];
	var height = JcUserSelect.DropRowHeight * table.rows.length;
	table.style.height = height;
	if(height < JcUserSelect.DropRowHeight * JcUserSelect.DropRowCount)
		this.DropFrame.style.height = height;
	if(height == 0)
		this.HideFrame();
}

JcUserSelect.prototype.SetReadonly = function(st)
{	
	this.Readonly = st;
	this.HtmlEle.readOnly=st;
	this.HtmlEle.all("userselect_btn").disabled=st;
	this.TextArea.readOnly = st;
	this._SetBackgroundColor();
}

JcUserSelect.prototype.SetDisabled = function(st)
{	
	this.Disabled = st;
	this.TextArea.disabled = st;
	this._SetBackgroundColor();
}
//
//--------------------------------JcUserSelect对象定义结束---------------------------------------------------
//