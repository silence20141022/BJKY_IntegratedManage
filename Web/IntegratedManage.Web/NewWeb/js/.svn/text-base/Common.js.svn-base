
//
//---------------------------------全局变量定义开始--------------------------------------------------------------
//

/**<doc type="varible" name="Global.PassCode">
	<desc>用户在登录系统时获得的PassCode</desc>
</doc>**/
var PassCode = "";

/**<doc type="varible" name="Global.PassCode">
	<desc>页面的唯一键值</desc>
</doc>**/
var PageKey = "";

/**<doc type="varible" name="Global.AppServer">
	<desc>应用服务器对应的网络HTTP地址</desc>
</doc>**/
var AppServer = {"Center":"http://localhost","Doc":"http://DocServer"};

/**<doc type="varible" name="Global.DebugState">
	<desc>是否要打开调试开关</desc>
</doc>**/
var DebugState=true;

/**<doc type="varible" name="Global.DebugState">
	<desc>是否要打开调试开关</desc>
</doc>**/
var DebugMethod="TextTrace";

/**<doc type="varible" name="Global.ErrorBgColor">
	<desc>表单字段校验错误后的背景颜色</desc>
</doc>**/
var ErrorBgColor="#FF4500";

/**<doc type="varible" name="Global.DisabledBgColor">
	<desc>表单字段不可控制的背景颜色</desc>
</doc>**/
var DisabledBgColor="#FFFFFF";

/**<doc type="varible" name="Global.ReadonlyBgColor">
	<desc>表单字段只读的背景颜色</desc>
</doc>**/
var ReadonlyBgColor="#FFFFFF";

/**<doc type="varible" name="Global.NormalBgColor">
	<desc>表单字段只读的背景颜色</desc>
</doc>**/
var NormalBgColor="#FFFFFF";

/**<doc type="varible" name="Global.NotEmptyBgColor">
	<desc>必须输入的表单字段的背景颜色</desc>
</doc>**/
var MustInputBgColor="#F0E68C";

/**<doc type="varible" name="Global.BeautyXmlString">
	<desc>格式化XML字符串变量，用于BeautyXml方法</desc>
</doc>**/
var BeautyXmlString="";


/**<doc type="varible" name="Global.DateAdjust">
	<desc>对当前电脑时间的调整，主要用于同步客户端和服务器端的日期,单位毫秒</desc>
</doc>**/
var DateAdjust=0;

var UiStylePath="/share";

/**<doc type="varible" name="Global.PageDoc">
	<desc>指向本页面的文档对象，当使用DataStore进行元素初始化时，可以通过改变此变量指向其他页面的文档对象</desc>
</doc>**/
var PageDoc=document;

//
//---------------------------------全局变量定义结束--------------------------------------------------------------
//





//
//---------------------------------系统对象增强开始--------------------------------------------------------------
//
/**<doc type="classext" name="Array.Find">
	<desc>查找数组中指定值位置</desc>
	<output>返回数组中指定值位置，没有则返回-1</output>
</doc>**/
Array.prototype.Find=function(value)
{	for(var i=0;i<this.length;i++)
		if(this[i]==value)return i;
	return -1;
}

/**<doc type="classext" name="String.fromZipBase64">
	<desc>将压缩过的base64编码还原</desc>
	<output>返回还原的字符串</output>
</doc>**/
String.prototype.fromZipBase64=function()
{	return str;
}

/**<doc type="classext" name="String.fromBase64">
	<desc>将base64编码还原</desc>
	<output>返回还原的字符串</output>
</doc>**/
String.prototype.fromBase64=function()
{	return str;
}

/**<doc type="classext" name="String.toZipBase64">
	<desc>将将字符串压缩并base64编码</desc>
	<output>压缩编码后的字符串</output>
</doc>**/
String.prototype.toZipBase64=function()
{	return str;
}

/**<doc type="classext" name="String.toBase64">
	<desc>将将字符串base64编码</desc>
	<output>编码后的字符串</output>
</doc>**/
String.prototype.toBase64=function()
{	return str;
}

/**<doc type="classext" name="String.fromNull">
	<desc>字符串过滤</desc>
	<output>如果为null或null串，返回空，否则返回原字符串</output>
</doc>**/
String.prototype.filterNull=function()
{	if(this.toLowerCase()=="null")return "";
	return "" + this;
}

/**<doc type="protofunc" name="String.trim">
	<desc>字符串对象定义修剪功能扩展</desc>
	<output>返回去除前后空格的字符串</output>
</doc>**/
String.prototype.trim = function()
{   return this.replace(/(^\s*)|(\s*$)/g, "");
}


/**<doc type="protofunc" name="String.bytelen">
	<desc>返回字节长度，中文字符长度为2，英文长度为1</desc>
	<output>返回字节长度</output>
</doc>**/
String.prototype.bytelen = function()
{   var count=this.length;
    var len=0;
    if(count!=0)
    for(var i=0;i<count;i++){
        if(this.charCodeAt(i)>=128)
			len+=2;
        else 
            len+=1;
    }
    return len;
}

/**<doc type="protofunc" name="String.bytelen">
	<desc>替换指定字符串</desc>
	<output>返回替换后的字符串</output>
</doc>**/
String.prototype.replaceAll = function(search, replace){
     var tmp=str=this;
     do { str = tmp;
        tmp = str.replace(search, replace);
     }while (str != tmp);
     return str;
}

/**<doc type="classext" name="Date.create">
	<desc>将指定格式的字符串转化为日期对象</desc>
	<input>
		<param name="str" type="string">输入字符串,格式为（yyyy-mm-dd hh:mm:ss）</param>
	</input>
	<output>返回日期对象</output>
</doc>**/
Date.parseDate=function(str)
{	
		var parts = str.split(" ");
		var dp = parts[0].split("-");
		var dt = new Date(dp[0],Number(dp[1])-1,dp[2]);
		if(parts.length>1)
		{	var tt = parts[1].split(":");
			dt.setHours(parseInt(tt[0]),parseInt(tt[1]),parseInt(tt[2]));
		}
		return dt;
}

/**<doc type="classext" name="Date.getDate">
	<desc>取得当前日期的字符串（yyyy-mm-dd）</desc>
	<output>返回日期字符串</output>
</doc>**/
//老大，你这个方法名和JScript的关于Date类型的方法重名，原方法的意思为取得当前日期的“日”，特此注释
//Date.getDate=function()
//{
//}
/**<doc type="classext" name="Date.getTime">
	<desc>取得当前日期的字符串（hh:mm:ss）</desc>
	<output>返回日期字符串</output>
</doc>**/
Date.getTime=function()
{
	var dt = new Date();
	return dt.getTimePart();
}
/**<doc type="classext" name="Date.getFullDate">
	<desc>取得当前日期的字符串（yyyy-mm-dd hh:mm:ss）</desc>
	<output>返回日期字符串</output>
</doc>**/
Date.prototype.getFullDate=function()
{
	return this.getDatePart() + " " + this.getTimePart();
}
/**<doc type="classext" name="Date.differ">
	<desc>取得两个日期的差值</desc>
	<input>
		<param name="dfrom" type="date">起始日期</param>
		<param name="dto" type="date">结束日期</param>
		<param name="type" type="enum">差值类型</param>
	</input>
	<output type="number">返回差值</output>
	<enum name="type">
		<item text="s">秒</item>
		<item text="n">分</item>
		<item text="h">小时</item>
		<item text="d">天</item>
		<item text="w">周</item>
	</enum>
</doc>**/
Date.differ=function(dfrom,dto,type)
{
	var dtfrom, dtto;

	if(!type)
	{
		type = 'd';
	}

	if(typeof(dfrom) == "string" && typeof(dto) == "string")
	{
		dtfrom = Date.parseDate(dfrom);
		dtto = Date.parseDate(dto);
	}
	else
	{
		dtfrom = dfrom;
		dtto = dto;
	}

	switch (type) {    
		case 's' :return Math.floor((dtto-dtfrom)/(1000));   
		case 'n' :return Math.floor((dtto-dtfrom)/(1000 * 60));   
		case 'h' :return Math.floor((dtto-dtfrom)/(1000 * 60 * 60));   
		case 'd' :return Math.floor((dtto-dtfrom)/(1000 * 60 * 60 * 24));   
		case 'w' :return Math.floor((dtto-dtfrom)/(1000 * 60 * 60 * 24 * 7)); 
	} 
}

/**<doc type="classext" name="Date.getTime">
	<desc>取得时间的字符串（ hh:mm:ss）</desc>
	<output>返回时间字符串</output>
</doc>**/
Date.prototype.getTimePart=function()
{
	var hour = this.getHours().toString();
	var minute = this.getMinutes().toString();
	var second = this.getSeconds().toString();
	if(hour.length == 1) hour = "0" + hour;
	if(minute.length == 1) minute = "0" + minute;
	if(second.length == 1) second = "0" + second;
	return(hour+":"+minute+":"+second);
}

/**<doc type="classext" name="Date.getDate">
	<desc>取得当前日期的字符串（yyyy-mm-dd）</desc>
	<output>返回日期字符串</output>
</doc>**/
Date.prototype.getDatePart=function()
{
	var month = (parseInt(this.getMonth())+1).toString();
	var day = this.getDate().toString();
	if(month.length == 1) month = "0" + month;
	if(day.length == 1) day = "0" + day;
	return(this.getFullYear()+"-"+month+"-"+day);
}

/**<doc type="classext" name="Date.add">
	<desc>将当前时间加上差值返回日期对象</desc>
	<input>
		<param name="type" type="enum">差值类型</param>
		<param name="delta" type="integer">差值</param>
	</input>
	<enum name="type">
		<item text="s">秒</item>
		<item text="m">分</item>
		<item text="h">小时</item>
		<item text="d">天</item>
		<item text="w">周</item>
		<item text="m">月</item>
		<item text="y">年</item>
	</enum>
</doc>**/
Date.prototype.add=function(type,delta)
{
	return this.DateAdd(type, delta);
}
/**<doc type="classext" name="Date.DateAdd">
	<desc>将当前时间加上差值返回日期对象</desc>
	<input>
		<param name="strInterval" type="enum">差值类型</param>
		<param name="Number" type="integer">差值</param>
	</input>
	<enum name="strInterval">
		<item text="s">秒</item>
		<item text="m">分</item>
		<item text="h">小时</item>
		<item text="d">天</item>
	</enum>
</doc>**/
Date.prototype.DateAdd = function(strInterval, Number) 
{    
	var dtTmp = this;   
	switch (strInterval) {    
		case 's' :return new Date(Date.parse(dtTmp) + (1000 * Number));   
		case 'n' :return new Date(Date.parse(dtTmp) + (60000 * Number));   
		case 'h' :return new Date(Date.parse(dtTmp) + (3600000 * Number));   
		case 'd' :return new Date(Date.parse(dtTmp) + (86400000 * Number));   
		case 'w' :return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));   
		case 'q' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number*3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
		case 'm' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
		case 'y' :return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
	}   
}   
/**<doc type="classext" name="Date.getFrom">
	<desc>获得当前日期在指定类型区间的开始日期对象</desc>
	<input>
		<param name="type" type="enum">区间类型</param>
	</input>
	<enum name="type">
		<item text="h">小时</item>
		<item text="d">天</item>
		<item text="w">周</item>
		<item text="m">月</item>
		<item text="y">年</item>
	</enum>
	<output>返回开始日期对象</output>
</doc>**/
Date.prototype.getFrom=function(type)//type=day,week,month,year
{
	switch(type.toLowerCase())
	{
		case "year":
			return new Date(this.getFullYear(),0,1);
		case "quarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3),1);
		case "month":
			return new Date(this.getFullYear(),this.getMonth(),1);
		case "week":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()-((this.getDay()+6)%7));
		case "preyear":
			return new Date(this.getFullYear()-1,0,1);
		case "prequarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3)-3,1);
		case "premonth":
			return new Date(this.getFullYear(),this.getMonth()-1,1);
		case "preweek":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()-((this.getDay()+6)%7)-7);
		case "nextyear":
			return new Date(this.getFullYear()+1,0,1);
		case "nextquarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3)+3,1);
		case "nextmonth":
			return new Date(this.getFullYear(),this.getMonth()+1,1);
		case "nextweek":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()-((this.getDay()+6)%7)+7);
		case "uphalfyear":
			return new Date(this.getFullYear(),0,1);
		case "downhalfyear":
			return new Date(this.getFullYear(),6,1);
		default:
			return this;
	}
}
/**<doc type="classext" name="Date.getTo">
	<desc>获得当前日期在指定类型区间的结束日期对象</desc>
	<input>
		<param name="type" type="enum">区间类型</param>
	</input>
	<enum name="type">
		<item text="h">小时</item>
		<item text="d">天</item>
		<item text="w">周</item>
		<item text="m">月</item>
		<item text="y">年</item>
	</enum>
	<output>返回结束日期对象</output>
</doc>**/
Date.prototype.getTo=function(type)
{
	switch(type.toLowerCase())
	{
		case "year":
			return new Date(this.getFullYear(),11,31);
		case "quarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3)+3,0);
		case "month":
			return new Date(this.getFullYear(),this.getMonth()+1,0);
		case "week":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()+(7-this.getDay()));
		case "preyear":
			return new Date(this.getFullYear()-1,11,31);
		case "prequarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3),0);
		case "premonth":
			return new Date(this.getFullYear(),this.getMonth(),0);
		case "preweek":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()-this.getDay());
		case "nextyear":
			return new Date(this.getFullYear()+1,11,31);
		case "nextquarter":
			return new Date(this.getFullYear(),((Math.ceil((this.getMonth()+1)/3)-1)*3)+6,0);
		case "nextmonth":
			return new Date(this.getFullYear(),this.getMonth()+2,0);
		case "nextweek":
			return new Date(this.getFullYear(),this.getMonth(),this.getDate()+(14-this.getDay()));
		case "uphalfyear":
			return new Date(this.getFullYear(),5,30);
		case "downhalfyear":
			return new Date(this.getFullYear(),11,30);
		default:
			return this;
	}
}

/**<doc type="classext" name="Date.differ">
	<desc>根据类型设置时间起始结束值</desc>
	<input>
		<param name="fromId" type="date">起始时间控件Id</param>
		<param name="toId" type="date">结束时间控件Id</param>
		<param name="type" type="enum">差值类型</param>
	</input>
	<output type="number">返回差值</output>
	<enum name="type">
		<item text="h">小时</item>
		<item text="d">天</item>
		<item text="w">周</item>
		<item text="m">月</item>
		<item text="y">年</item>
	</enum>
</doc>**/
function SetFormToDate(fromId,toId,type)
{
	var date = new Date();
	Co[fromId].SetValue(date.getFrom(type).getDatePart());
	Co[toId].SetValue(date.getTo(type).getDatePart());
}	

	
//
//---------------------------------系统对象增强结束--------------------------------------------------------------
//


//
//--------------------------------DataStore 相关对象定义开始---------------------------------------------------
//

//
//--------------------------------DataItem 对象定义开始--------------------------------------------------------
//

/**<doc type="objdefine" name="DataItem">
	<desc>DataItem定义</desc>
	<input>
		<param name="doc" type="object">构建DataItem的XML文档</param>
		<param name="ele" type="object">构建DataItem的XML元素/param>
	</input>	
	<property>
		<prop name="XmlDoc" type="object">DataItem对应的XML文档</param>
		<prop name="XmlEle" type="object">
		说明：DataItem对应的XML元素
		存储格式：
		</param>
		<prop name="Type" type="string">DataItem对应的类型</param>
	</property>		
</doc>**/
function DataItem(doc,ele)
{	this.XmlDoc=null;
	this.XmlEle=null;
	if(doc)this.XmlDoc=doc;
	if(ele)this.XmlEle=ele;
}

/**<doc type="protofunc" name="DataItem.GetAttr">
	<desc>取得DataItem的某个属性值</desc>
	<input>
		<param name="index" type="object">如果index的类型为number,则获取第index个属性的属性值;如果index的类型为string,则获取属性名为index的属性值</param>
	</input>
	<output type="string">对应的属性值</output>
</doc>**/
DataItem.prototype.GetAttr=function(index)
{	var value=null;
	if(typeof(index)=="number")
	{	var node=this.XmlEle.attributes.item(index);
		if(node)value=node.nodeValue.filterNull();
	}
	else if(typeof(index)=="string")
	{	value=this.XmlEle.getAttribute(index);
		//Start Modify By Sky
		//Memo:兼容Oracle
		//2006.2.24
		//if(!value)
		//	value=this.XmlEle.getAttribute("\"" + index + "\"");
		//End Modify By Sky
		if(value)value.filterNull();
	}
	return value;
}

/**<doc type="protofunc" name="DataItem.SetAttr">
	<desc>设置DataItem的某个属性值</desc>
	<input>
		<param name="index" type="object">如果index的类型为number,则设置第index个属性的属性值;如果index的类型为string,则设置属性名为index的属性值</param>
		<param name="value" type="string">设置的属性值</param>
	</input>
</doc>**/
DataItem.prototype.SetAttr=function(index,value)
{	if(typeof(index)=="number")
	{	var node=this.XmlEle.attributes.item(index);
		node.nodeValue=value;
	}
	else if(typeof(index)=="string")
	{
		this.XmlEle.setAttribute(index,value);
	}
}

/**<doc type="protofunc" name="DataItem.RemoveAttr">
	<desc>删除DataItem的某个属性值</desc>
	<input>
		<param name="index" type="object">如果index的类型为number,则删除第index个属性的属性值;如果index的类型为string,则删除属性名为index的属性值</param>
	</input>
</doc>**/
DataItem.prototype.RemoveAttr=function(index)
{	if(typeof(index)=="number")
	{	var node=this.XmlEle.attributes.item(index);
		this.XmlEle.attributes.removeNamedItem(node.nodeName);
	}
	else if(typeof(index)=="string")
		this.XmlEle.attributes.removeNamedItem(index);
}

/**<doc type="protofunc" name="DataItem.GetAttrName">
	<desc>取得DataItem的某个属性名称</desc>
	<input>
		<param name="index" type="number">该属性对应的属性排列序号</param>
	</input>
	<output type="string">对应的属性名称</output>
</doc>**/
DataItem.prototype.GetAttrName=function(index)
{	return this.XmlEle.attributes.item(index).nodeName;
}

/**<doc type="protofunc" name="DataItem.GetAttrCount">
	<desc>取得DataItem的属性个数</desc>
	<output type="string">属性个数</output>
</doc>**/
DataItem.prototype.GetAttrCount=function()
{	return this.XmlEle.attributes.length;
}

/**<doc type="protofunc" name="DataItem.GetName">
	<desc>取得DataItem的元素名称</desc>
	<output type="string">对应的元素名称</output>
</doc>**/
DataItem.prototype.GetName=function()
{	return this.XmlEle.nodeName;
}

/**<doc type="protofunc" name="DataItem.GetValue">
	<desc>取得DataItem的元素值</desc>
	<output type="string">对应的元素值</output>
</doc>**/
DataItem.prototype.GetValue=function()
{	return this.XmlEle.text.filterNull();
}

/**<doc type="protofunc" name="DataItem.SetValue">
	<desc>设置DataItem的元素值</desc>
	<input>
		<param name="value" type="string">设置的值</param>
	</input>
</doc>**/
DataItem.prototype.SetValue=function(value)
{	this.XmlEle.text = value;
}

/**<doc type="protofunc" name="DataItem.GetXmlValue">
	<desc>取得DataItem的元素内的XML</desc>
	<output type="string">元素内的XML</output>
</doc>**/
DataItem.prototype.GetXmlValue=function()
{	if(this.XmlEle.childNodes.length>0)
		return this.XmlEle.childNodes[0].xml;
	else
		return "";
}

/**<doc type="protofunc" name="DataItem.SetXmlValue">
	<desc>设置DataItem的元素内的XML</desc>
	<input>
		<param name="value" type="string">设置的XML</param>
	</input>
</doc>**/
DataItem.prototype.SetXmlValue=function(value)
{	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.async=false;
	doc.loadXML(value);
	if(doc.documentElement)
		this.XmlEle.appendChild(doc.documentElement);
	else
		this.XmlEle.text = value;
}

/**<doc type="protofunc" name="DataItem.GetSubXmlNode">
	<desc>取得DataItem的元素内的XML结点</desc>
	<output type="string">元素内的XML结点</output>
</doc>**/
DataItem.prototype.GetSubXmlNode=function()
{	if(this.XmlEle.childNodes.length>0)
		return this.XmlEle.childNodes[0];
}

/**<doc type="protofunc" name="DataItem.GetDataStore">
	<desc>取得DataItem元素的父DataStore</desc>
	<output type="DataStore">父DataStore</output>
</doc>**/
DataItem.prototype.GetDataStore=function()
{	var ele = this.XmlEle;
	for(var i=0;i<10;i++)
	{	if(ele==null || ele.tagName.ToLower()=="datastore")break;
		ele=ele.parentNode;
	}
	if(ele==null)return null;
	return new DataStore(ele);
}

/**<doc type="protofunc" name="DataItem.GetSubDataForm">
	<desc>取得DataItem的元素内的DataForm</desc>
	<output type="DataForm">元素内的DataForm</output>
</doc>**/
DataItem.prototype.GetSubDataForm=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataForm(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataList">
	<desc>取得DataItem的元素内的DataList</desc>
	<output type="DataList">元素内的DataList</output>
</doc>**/
DataItem.prototype.GetSubDataList=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataList(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataEnum">
	<desc>取得DataItem的元素内的DataEnum</desc>
	<output type="DataEnum">元素内的DataEnum</output>
</doc>**/
DataItem.prototype.GetSubDataEnum=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataEnum(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataParam">
	<desc>取得DataItem的元素内的DataParam</desc>
	<output type="DataParam">元素内的DataParam</output>
</doc>**/
DataItem.prototype.GetSubDataParam=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataParam(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.ToStringParam">
	<desc>取得DataItem的元素内由属性名称和属性值构建而成的StringParam</desc>
	<output type="StringParam">由属性名称和属性值构建而成的StringParam</output>
</doc>**/
DataItem.prototype.ToStringParam = function()
{	var objParam = new StringParam();
	for (var i = 0; i< this.XmlEle.attributes.length; i++)
		objParam.AddItem(this.XmlEle.attributes.item(i).nodeName,
					 this.XmlEle.attributes.item(i).nodeValue);
	return objParam;
}

/**<doc type="protofunc" name="DataItem.ToDataForm">
	<desc>取得DataItem的元素内由属性名称和属性值构建而成的DataForm</desc>
	<input>
		<param name="name" type="string">DataForm的名称</param>
	</input>	
	<output type="DataForm">由属性名称和属性值构建而成的DataForm</output>
</doc>**/
DataItem.prototype.ToDataForm=function(name)
{	if(!name)name="";
	var node=this.XmlDoc.createElement("Form");
	node.setAttribute("Name",name);
	var df = new DataForm(null,this.XmlDoc,node);
	for (var i = 0; i< this.XmlEle.attributes.length; i++)
		df.AddItem(this.XmlEle.attributes.item(i).nodeName,
					 this.XmlEle.attributes.item(i).nodeValue);
	return df;
}

/**<doc type="protofunc" name="DataItem.ToString">
	<desc>取得DataItem的元素对应的XML</desc>
	<output type="string">DataItem的元素对应的XML</output>
</doc>**/
DataItem.prototype.ToString = function()
{	return this.XmlEle.xml;
}

//
//--------------------------------DataItem 对象定义结束--------------------------------------------------------
//


//
//--------------------------------DataNode 对象定义开始,从DataItem继承-----------------------------------------
//

/**<doc type="objdefine" name="DataNode">
	<desc>DataNode定义,从DataItem继承</desc>
	<input>
		<param name="xmlsrc" type="object">
		说明：如果类型为object,则xmlsrc表示为一个XML结点;如果类型为string,则xmlsrc表示为一段XML
		存储格式：</param>
		<param name="doc" type="object">构建DataNode的XML文档</param>
		<param name="ele" type="object">构建DataNode的XML元素</param>
	</input>	
</doc>**/
function DataNode(xmlsrc,doc,ele)
{	this.Type="Node";
	this.Init(xmlsrc,doc,ele);
}
DataNode.prototype = new DataItem();

/**<doc type="protofunc" name="DataNode.Init">
	<desc>DataNode的构建器</desc>
	<input>
		<param name="xmlsrc" type="object">如果类型为object,则xmlsrc表示为一个XML结点;如果类型为string,则xmlsrc表示为一段XML</param>
		<param name="doc" type="object">构建DataNode的XML文档</param>
		<param name="ele" type="object">构建DataNode的XML元素</param>
	</input>	
</doc>**/
DataNode.prototype.Init = function(xmlsrc,doc,ele)
{	
 
	if(typeof(xmlsrc)=="object" && xmlsrc==null && typeof(doc)=="undefined")return;
	if(typeof(xmlsrc)=="string")
	{	this.XmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		this.XmlDoc.async=false;
		this.XmlDoc.loadXML(xmlsrc);
		this.XmlDoc.setProperty("SelectionLanguage","XPath");//add by shawn 2008-11-20
		this.XmlEle = this.XmlDoc.documentElement;
	}else if(typeof(xmlsrc)=="undefined")
	{	this.XmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		this.XmlDoc.async=false;
		switch(this.Type.toLowerCase())
		{	case "form":this.XmlDoc.loadXML("<Form Name='' ></Form>");break;
			case "list":this.XmlDoc.loadXML("<List Name='' Fields=''></List>");break;
			case "enum":this.XmlDoc.loadXML("<Enum Name='' ></Enum>");break;
			case "param":this.XmlDoc.loadXML("<Param Name=''></Param>");break;
		}
		this.XmlEle=this.XmlDoc.documentElement;
	}else if(typeof(xmlsrc)=="object" && xmlsrc!=null )
	{	
	 var node=xmlsrc.cloneNode(true);
		this.XmlDoc = node.ownerDocument;
		this.XmlEle = node;
		 
		/*
		this.XmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		this.XmlDoc.async=false;
		this.XmlDoc.loadXML(xmlsrc.ToString());
		this.XmlDoc.setProperty("SelectionLanguage","XPath");//add by shawn 2008-11-20
		this.XmlEle = this.XmlDoc.documentElement;
		*/
	}
	else
	{	if(doc)this.XmlDoc=doc;
		if(ele)this.XmlEle=ele;
	}
	//add by shawn 2007-1-31 for reason : ie7 cann't recognize the default xpath syntax
	this.XmlDoc.setProperty("SelectionLanguage","XPath");
}

/**<doc type="protofunc" name="DataNode.AddItem">
	<desc>向DataNode中添加子项</desc>
</doc>**/
DataNode.prototype.AddItem = function(){}

/**<doc type="protofunc" name="DataNode.NewItem">
	<desc>在DataNode中新建子项</desc>
</doc>**/
DataNode.prototype.NewItem = function(){}

/**<doc type="protofunc" name="DataNode.Remove">
	<desc>在DataNode中删除子项</desc>
	<input>
		<param name="index" type="object">如果类型为object,则表示要删除的XML结点;如果类型为number,则表示要删除第index个结点</param>
	</input>
</doc>**/
DataNode.prototype.Remove = function(index)
{	if(typeof(index)=="object")
	{	var obj=index;
		if(this.XmlEle == obj.XmlEle.parentNode)
			obj.XmlEle.parentNode.removeChild(obj.XmlEle);
	}else if(typeof(index)=="number")
	{	var node=this.XmlEle.childNodes[index];
		if(node)node.parentNode.removeChild(node);
	}
}

/**<doc type="protofunc" name="DataNode.Clear">
	<desc>清空DataNode的子项</desc>
</doc>**/
DataNode.prototype.Clear = function()
{	var nodes=this.XmlEle.childNodes;
	var count=nodes.length;
	for(var i=count-1;i>=0;i--)
		this.XmlEle.removeChild(nodes[i]);
}

/**<doc type="protofunc" name="DataNode.GetItemCount">
	<desc>得到DataNode的子项个数</desc>
	<output type="number">DataNode的子项个数</output>
</doc>**/
DataNode.prototype.GetItemCount=function()
{	return this.XmlEle.childNodes.length;
}

/**<doc type="protofunc" name="DataNode.GetItem">
	<desc>根据index获得DataNode的子项</desc>
	<input>
		<param name="index" type="object">如果类型为number,则返回DataNode对应的XML元素的第index项;如果类型为string,则返回DataNode对应的XML元素的对应名称为index的项</param>
	</input>		
	<output type="DataItem">获得的DataItem</output>
</doc>**/
DataNode.prototype.GetItem = function(index,value)
{	var node=null,xp="";
	if(typeof(index)=="number")
	{	node = this.XmlEle.childNodes[index];
	}else if(typeof(index)=="string")
	{	if(!value)
			node = this.XmlEle.selectSingleNode(index);
		else
			node = this.XmlEle.selectSingleNode("*[@"+index+"='"+value+"']");
	}
	if(!node)return null;
	return new DataItem(this.XmlDoc,node);
}

/**<doc type="protofunc" name="DataNode.GetItems">
	<desc>根据XPath获得DataNode的子项数组</desc>
	<input>
		<param name="xpath" type="string">XPath查询条件</param>
	</input>		
	<output type="DataItem">对应的DataItem数组</output>
</doc>**/
DataNode.prototype.GetItems = function(xpath)
{	var nodes=null;
	if(typeof(xpath)=="undefined")
		nodes= this.XmlEle.childNodes;
	else
		nodes=this.XmlEle.selectNodes(xpath);
	var diary=new Array();
	for(var i=0;i<nodes.length;i++)
		diary[i]=new DataItem(this.XmlDoc,nodes[i]);
	return diary;
}

/**<doc type="protofunc" name="DataNode.GetName">
	<desc>取得DataNode的元素名称</desc>
	<output type="string">对应的元素名称</output>
</doc>**/
DataNode.prototype.GetName = function()
{	return this.XmlEle.getAttribute("Name");
}

/**<doc type="protofunc" name="DataNode.SetName">
	<desc>设置DataNode的元素名称</desc>
	<input>
		<param name="name" type="string">设置的名称</param>
	</input>		
</doc>**/
DataNode.prototype.SetName = function(name)
{	this.XmlEle.setAttribute("Name",name);
}

/**<doc type="protofunc" name="DataNode.CloneXmlNode">
	<desc>克隆DataNode对应的XML结点(是克隆XML结点好,还是克隆整个DataNode好????)</desc>
	<input>
		<param name="name" type="string">克隆的DataNode的XML结点名称</param>
	</input>
	<output type="string">对应的XML结点</output>		
</doc>**/
DataNode.prototype.CloneXmlNode=function(name)
{	if(!name)name="";
	var node = this.XmlEle.cloneNode(true);
	node.setAttribute("Name",name);
	return node;
}


//type=tag/attr
DataNode.prototype.Sort=function(type,index,datatype)
{
}

//
//--------------------------------DataNode 对象定义结束--------------------------------------------------------
//

//
//--------------------------------DataStore 对象定义开始,从DataItem继承----------------------------------------
//

/**<doc type="objdefine" name="DataStore">
	<desc>数据存储对象定义</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		说明：初始化字符串
		存储格式：<DataStore><Forms></Forms><Lists></Lists><Enums></Enums><Params></Params></DataStore>
		</param>
		<param name="type" type="empty/enum">字符串类型</param>
	</input>
	<enum name="type">
		<item text="[empty]">一般xml字符串</item>
		<item text="b64">编码后的xml字符串</item>
		<item text="zb64">压缩并编码的xml字符串</item>
	</enum>
	<output>返回开始日期对象</output>
</doc>**/
function DataStore(xmlsrc,type)
{	if(!type)type="";
	if(typeof(xmlsrc)=="undefined")
	{	xmlsrc="<DataStore></DataStore>";
		type = "";
	}
	if(typeof(xmlsrc)=="string")
	{	this.XmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		this.XmlDoc.async=false;
		var xmlstr=null;
		switch(type)
		{	case "":xmlstr = xmlsrc;break;
			case "b64":xmlstr=xmlsrc.fromBase64();break;
			case "zb64":xmlstr=xmlsrc.fromZipBase64();break;
		}
		this.XmlDoc.loadXML(xmlstr);
		if (this.XmlDoc.parseError.errorCode != 0)
			throw new Error(0,"DataStore Constructor:"+this.XmlDoc.parseError.reason);

		this.XmlEle = this.XmlDoc.documentElement;
	}else if(typeof(xmlsrc)=="object")
	{	var node=xmlsrc.documentElement;
		this.XmlDoc = xmlsrc;
		this.XmlEle = node;
	}
}
DataStore.prototype = new DataItem();

/**<doc type="protofunc" name="DataStore._GetTag">
	<desc>获取Tag</desc>
	<input>
		<param name="type" type="string">根据type(form/list/enum/param)返回相应的值(Forms/Lists/Enums/Params)</param>
		<param name="isformat" type="boolean">如果isformat为true,则返回的Tag为type的改变值(type首字母大写,其余字母小写);如果isformat为false,则根据type的值来返回Tag</param>
	</input>
	<output type="string">对应的Tag</output>		
</doc>**/
DataStore.prototype._GetTag=function(type,isformat)
{	type=type.toLowerCase();
	if(isformat)
	{	return type.charAt(0).toUpperCase()+type.substr(1);
	}
	switch(type)
	{	case "form":type="Forms";break;
		case "list":type="Lists";break;
		case "enum":type="Enums";break;
		case "param":type="Params";break;
	}
	return type;
}

/**<doc type="protofunc" name="DataStore.GetParam">
	<desc>获取DataStore的Param值，如果不存在则返回null或defvalue</desc>
	<input>
		<param name="name" type="string">Param的Name属性</param>
		<param name="defvalue" type="string">默认值</param>
	</input>
	<output type="string">对应的Param的值</output>		
</doc>**/
DataStore.prototype.GetParam=function(name,defvalue)
{	var dp = this.Params(name);
	if(dp == null){
		if(defvalue)
			return defvalue;
		else 
			return null;
	}
	return dp.GetValue();
}

/**<doc type="protofunc" name="DataStore.SetParam">
	<desc>设置DataStore的Param值</desc>
	<input>
		<param name="name" type="string">Param的Name属性</param>
		<param name="value" type="string">Param的值</param>
	</input>		
</doc>**/
DataStore.prototype.SetParam=function(name,value)
{	var dp = this.Params(name);
	if(dp == null)
	{	dp = new DataParam(name,value);
		this.Add(dp);
	}else
		dp.SetValue(value);
}

/**<doc type="protofunc" name="DataStore.Get">
	<desc>返回对应的DataForm/DataList/DataEnum/DataParam</desc>
	<input>
		<param name="type" type="string">根据type(form/list/enum/param)找到对应的类型(DataForm/DataList/DataEnum/DataParam)</param>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的结点</param>
	</input>
	<output type="string">对应的DataForm/DataList/DataEnum/DataParam</output>		
</doc>**/
DataStore.prototype.Get=function(type,index)
{	type=type.toLowerCase();
	switch(type)
	{	case "form":return this.Forms(index);
		case "list":return this.Lists(index);
		case "enum":return this.Enums(index);
		case "param":return this.Params(index);
	}
	return null;
}

/**<doc type="protofunc" name="DataStore.GetXmlNode">
	<desc>得到DataStore的指定Xml节点</desc>
	<input>
		<param name="type" type="string">根据type(form/list/enum/param)找到对应的类型(DataForm/DataList/DataEnum/DataParam)XmlNode节点</param>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的XmlNode节点</param>
	</input>
	<output type="number">指定index的Xml节点</output>
</doc>**/
DataStore.prototype.GetXmlNode=function(type,index)
{	var node=null,xp="";
	var tag = this._GetTag(type);
	type=this._GetTag(type,true);
	if(typeof(index)=="number")
	{	node = this.XmlEle.selectSingleNode(tag).childNodes[index];
	}else if(typeof(index)=="string")
	{	node = this.XmlEle.selectSingleNode(tag+"/"+type+"[@Name='"+index+"']");
	}
	return node;
}

/**<doc type="protofunc" name="DataStore.Add">
	<desc>添加Xml节点到DataStore</desc>
	<input>
		<param name="dnode" type="xmlsrc">XmlNode节点</param>
	</input>
</doc>**/
DataStore.prototype.Add=function(dnode)
{	var type=dnode.Type.toLowerCase();
	var tag=this._GetTag(type);
	var pnode=this.XmlEle.selectSingleNode(tag);
	if(pnode==null)
	{	pnode = this.XmlDoc.createElement(tag);
		this.XmlEle.appendChild(pnode);
	}
	var node = pnode.appendChild(dnode.XmlEle.cloneNode(true));
}

/**<doc type="protofunc" name="DataStore.New">
	<desc>得到DataStore的指定Xml节点</desc>
	<input>
		<param name="type" type="string">根据type(form/list/enum/param)在DataStore下创建到对应的类型(DataForm/DataList/DataEnum/DataParam)</param>
	</input>
	<output type="number">在DataStore下创建的对象</output>
</doc>**/
DataStore.prototype.New=function(type)
{	type=type.toLowerCase();
	var tag=this._GetTag(type);
	var pnode=this.XmlEle.selectSingleNode(tag);
	var node=null,nodeobj=null;
	if(pnode==null)
	{	pnode = this.XmlDoc.createElement(tag);
		this.XmlEle.appendChild(pnode);
	}
	switch(type)
	{	case "form":
			node=this.XmlDoc.createElement("Form");
			pnode.appendChild(node);
			nodeobj = new DataForm(null,this.XmlDoc,node);
			break;
		case "list":
			node=this.XmlDoc.createElement("List");
			pnode.appendChild(node);
			nodeobj = new DataList(null,this.XmlDoc,node);
			break;
		case "enum":
			node=this.XmlDoc.createElement("Enum");
			pnode.appendChild(node);
			nodeobj = new DataEnum(null,this.XmlDoc,node);
			break;
		case "param":
			node=this.XmlDoc.createElement("Param");
			pnode.appendChild(node);
			nodeobj = new DataParam(null,this.XmlDoc,node);
			break;
	}
	return nodeobj;
}

/**<doc type="protofunc" name="DataStore.GetCount">
	<desc>得到DataStore下各元素数目</desc>
</doc>**/
DataStore.prototype.GetCount=function()
{	return this.GetNodeCount("Form")+this.GetNodeCount("Enum")+this.GetNodeCount("List")+this.GetNodeCount("Param");
}

/**<doc type="protofunc" name="DataStore.GetCount">
	<desc>得到DataStore下指定类型元素数目</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)在DataStore对应的类型(DataForm/DataList/DataEnum/DataParam)</param>
	</input>
</doc>**/
DataStore.prototype.GetNodeCount=function(type)
{	var node=null;
	var tag = this._GetTag(type);
	node = this.XmlEle.selectSingleNode(tag);
	if(!node) return 0;
	return node.childNodes.length;
}

/**<doc type="protofunc" name="DataStore.Forms">
	<desc>得到DataStore的指定Form节点</desc>
	<input>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的Form节点</param>
	</input>
	<output type="number">指定index的Form节点</output>
</doc>**/
DataStore.prototype.Forms=function(index)
{	var node = this.GetXmlNode("Form",index);
	if(!node)return null;
	return new DataForm(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Lists">
	<desc>得到DataStore的指定List节点</desc>
	<input>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的List节点</param>
	</input>
	<output type="number">指定index的List节点</output>
</doc>**/
DataStore.prototype.Lists=function(index)
{	var node = this.GetXmlNode("List",index);
	if(!node)return null;
	return new DataList(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Enums">
	<desc>得到DataStore的指定Enum节点</desc>
	<input>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的Enum节点</param>
	</input>
	<output type="number">指定index的Enum节点</output>
</doc>**/
DataStore.prototype.Enums=function(index)
{	var node = this.GetXmlNode("Enum",index);
	if(!node)return null;
	return new DataEnum(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Params">
	<desc>得到DataStore的指定Param节点</desc>
	<input>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的Param节点</param>
	</input>
	<output type="number">指定index的Param节点</output>
</doc>**/
DataStore.prototype.Params=function(index)
{	var node = this.GetXmlNode("Param",index);
	if(!node)return null;
	return new DataParam(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Remove">
	<desc>移除指定类型下指定名称或序号的元素</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)在DataStore对应的类型(DataForm/DataList/DataEnum/DataParam)</param>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的节点</param>
	</input>
</doc>**/
DataStore.prototype.Remove=function(type,index)
{	if(typeof(type)=="object")
	{	var obj=type;
		if(this.XmlDoc == obj.XmlDoc)
			obj.XmlEle.parentNode.removeChild(obj.XmlEle);
	}else{
		var node=null,xp="";
		node=this.GetXmlNode(type,index);
		if(node)node.parentNode.removeChild(node);
	}
}

/**<doc type="protofunc" name="DataStore.Clear">
	<desc>清空DataStore下指定类型元素</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)在DataStore对应的类型(DataForm/DataList/DataEnum/DataParam)</param>
	</input>
</doc>**/
DataStore.prototype.Clear=function(type)
{	if(typeof(type)=="undefined")
	{	var nodes=this.XmlEle.childNodes;
		var pnode=this.XmlEle;
	}else
	{	var tag = this._GetTag(type);
		var pnode=this.XmlEle.selectSingleNode(tag);
		var nodes = pnode.childNodes;
	}
	var count=nodes.length;
	for(var i=count-1;i>=0;i--)
		pnode.removeChild(nodes[i]);
}
DataStore.prototype.ToZipBase64=function()
{	return this.ToString();
}
DataStore.prototype.ToBase64=function()
{	return this.ToString();
}

DataStore.prototype.Clone=function(deep)
{	if(typeof(deep)=="undefined")deep=true;
	return new DataStore(this.XmlEle.cloneNode(deep).xml);
}




/**<doc type="objdefine" name="DataForm">
	<desc>数据存储对象定义</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		说明：初始化字符串
		存储格式：<Form Name=""></Form>
		</param>
	</input>
</doc>**/
function DataForm(xmlsrc,doc,ele)
{	this.Type="Form";
	this.Init(xmlsrc,doc,ele);
}
DataForm.prototype = new DataNode(null);

/**<doc type="protofunc" name="DataStore.AddItem">
	<desc>向DataForm的添加节点相当于SetValue,不同的是此函数有返回值</desc>
	<input>
		<param name="name" type="string">Item的名字</param>
		<param name="value" type="string">Item的值</param>
	</input>
	<output type="DataItem">指定name与value的DataItem</output>
</doc>**/
DataForm.prototype.AddItem = function(name,value)
{	var node=this.XmlDoc.createElement(name);
	this.XmlEle.appendChild(node);
	node.text=value;
	return new DataItem(this.XmlDoc,node);
}

DataForm.prototype.AddItemByItem= function(item)
{	var node = item.XmlEle.cloneNode(true);
	this.XmlEle.appendChild(node);
	return new DataItem(this.XmlDoc,node);
}

DataForm.prototype.NewItem = function(){}

DataForm.prototype.GetValue=function(name)
{	var node=this.XmlEle.selectSingleNode(name);
	if(node==null) return null;
	return node.text.filterNull();
}

DataForm.prototype.SetValue = function(name,value)
{	var node=this.XmlEle.selectSingleNode(name);
	if(node==null)
	{	node=this.XmlDoc.createElement(name);
		this.XmlEle.appendChild(node);
	}
	node.text=value;
}
/**<doc type="protofunc" name="DataStore.ToDataItem">
	<desc>将DataForm装换为指定tag的DataItem，所有节点的nodeName转换为属性名，text转换为属性值</desc>
	<input>
		<param name="tag" type="string">转换后DataItem的标签名</param>
	</input>
	<output type="DataItem">转黄后的DataItem</output>
</doc>**/
DataForm.prototype.ToDataItem=function(tag)
{	if(!tag)tag="Item";
	var node=this.XmlDoc.createElement(tag);
	var nodes=this.XmlEle.childNodes;
	var count = nodes.length;
	for(var i=0;i<count;i++)
		node.setAttribute(nodes[i].nodeName,nodes[i].text);
	return new DataItem(this.XmlDoc,node);
}

DataForm.prototype.Clone=function(name)
{	var node=this.CloneNode(name);
	return new DataForm(null,this.XmlDoc,node);
}


/**<doc type="objdefine" name="DataList">
	<desc>数据存储对象定义</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		说明：初始化字符串
		存储格式：<List Name=""></List>
		</param>
	</input>
</doc>**/
function DataList(xmlsrc,doc,ele)
{	this.Type="List";
	this.Init(xmlsrc,doc,ele);
}
DataList.prototype = new DataNode(null);

DataList.prototype.AddItem = function(item)
{	var node = item.XmlEle.cloneNode(true);
	this.XmlEle.appendChild(node);
	return new DataItem(this.XmlDoc,node);
}

DataList.prototype.NewItem = function()
{	var node = this.XmlDoc.createElement("Item");
	this.XmlEle.appendChild(node);
	return new DataItem(this.XmlDoc,node);
}

DataList.prototype.GetValue=function(index,name)
{	var node=this.XmlEle.childNodes[index];
	if(node==null)return null;
	var value=node.getAttribute(name);
	if(!value)return null;
	return value.filterNull();
}

DataList.prototype.SetValue = function(index,name,value)
{	var node=this.XmlEle.childNodes[index];
	if(node==null)return;
	node.setAttribute(name,value);
}

/**<doc type="protofunc" name="DataList.GetFields">
	<desc>得到DataList所有域名数组</desc>
	<output type="Array">ataList所有域名数组</output>
</doc>**/
DataList.prototype.GetFields = function()
{	var fldstr=this.XmlEle.getAttribute("Fields");
	var rtnary = new Array();
	if(!fldstr)return rtnary;
	var ary = fldstr.split(",");
	var j = 0;
	for (var i=0; i<ary.length;i++)
		if (ary[i] != "")rtnary[j++] = ary[i];
	return rtnary;
}

/**<doc type="protofunc" name="DataList.SetFields">
	<desc>设置DataList的域</desc>
	<input>
		<param name="fld" type="string/Array">域名数组或由","分割的的字符串</param>
	</input>
</doc>**/
DataList.prototype.SetFields = function (fld)
{	if (typeof(fld)=="string")
		this.XmlEle.setAttribute("Fields",fld);
	if (typeof(fld) == "object")
		this.XmlEle.setAttribute("Fields",fld.join(","));
}
DataList.prototype.Clone=function(name)
{	var node=this.CloneNode(name);
	return new DataList(null,this.XmlDoc,node);
}



/**<doc type="objdefine" name="DataEnum">
	<desc>数据存储对象定义</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		说明：初始化字符串
		存储格式：<Enum Name=""></Enum>
		</param>
	</input>
</doc>**/
function DataEnum(xmlsrc,doc,ele)
{	this.Type="Enum";
	this.Init(xmlsrc,doc,ele);
}
DataEnum.prototype = new DataList(null);

DataEnum.prototype.AddItem = function(text,value)
{	var node=this.XmlDoc.createElement("Item");
	this.XmlEle.appendChild(node);
	node.setAttribute("Text",text);
	node.setAttribute("Value",value);
	return new DataItem(this.XmlDoc,node);
}

DataEnum.prototype.NewItem = function()
{	var node = this.XmlDoc.createElement("Item");
	this.XmlEle.appendChild(node);
	return new DataItem(this.XmlDoc,node);
}

DataEnum.prototype.GetValue=function(text)
{	
	var node=this.XmlEle.selectSingleNode("Item[@Text='"+text+"']");
	if(node==null)return null;
	return node.getAttribute("Value").filterNull();
}
DataEnum.prototype.SetValue = function(){}

DataEnum.prototype.GetText=function(value)
{	
	var node=this.XmlEle.selectSingleNode("Item[@Value='"+value+"']");
	if(node==null)return null;
	return node.getAttribute("Text").filterNull();
}

/**<doc type="protofunc" name="DataEnum.GetSubEnum">
	<desc>得到子枚举的EnumKey</desc>
	<input>
		<param name="index" type="string/number">根据名称(string)或序号(number)找到对应的结点</param>
	</input>
</doc>**/
DataEnum.prototype.GetSubEnum=function(index)
{	var rtn="",node;
	if (typeof(index) == "string")
		node= this.XmlEle.selectSingleNode("Item[@Value='"+index+"']");
	else if (typeof(index) == "number")
		node= this.XmlEle.childNodes[index];
	else if(typeof(index)=="object")
		node = index.XmlEle;//DataItem
	if(!node)return null;
	var se=null;
	if(node)se = node.getAttribute("SubEnum");
	if(!se)return null;
	return se;
}

DataEnum.prototype.GetFields = function(){}
DataEnum.prototype.SetFields = function(){}
DataEnum.prototype.Clone=function(name)
{	var node=this.CloneNode(name);
	return new DataEnum(null,this.XmlDoc,node);
}



/**<doc type="objdefine" name="DataParam">
	<desc>数据存储对象定义</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		说明：初始化字符串
		存储格式：<Param Name=""></Param>
		</param>
	</input>
</doc>**/
function DataParam(xmlsrc,doc,ele)
{	this.Type="Param";
	if(typeof(xmlsrc)=="string" && typeof(doc)=="string")
	{	this.Init(); //提供new DataParam(name,value)构造
		this.SetName(xmlsrc);
		this.SetValue(doc);
	}
	else	
		this.Init(xmlsrc,doc,ele);
}
DataParam.prototype = new DataNode(null);
DataParam.prototype.Remove = function(index){}
DataParam.prototype.Clear = function(){}
DataParam.prototype.GetItemCount=function(){}
DataParam.prototype.GetItem = function(index){}
DataParam.prototype.GetItems = function(xpath){}
DataParam.prototype.Clone=function(name)
{	var node = this.CloneNode(name);
	return new DataParam(null,this.XmlDoc,node);
}
//
//--------------------------------DataStore 相关对象定义结束---------------------------------------------------
//
//dsdef   Xml.List.UserList

/**<doc type="function" name="Global.GetDs">
	<desc>指定id的数据岛信息并转换为DataStore</desc>
	<input>
		<param name="xmlid" type="string">数据岛id</param>
	</input>
	<output type="DataStore">DataStore</output>
</doc>**/
function GetDs(xmlid)
{	var eledoc=PageDoc.all(xmlid).XMLDocument;
	if(!eledoc)return null;
	return new DataStore(eledoc);
}

/**<doc type="function" name="Global.GetDsNode">
	<desc>得到指定数据岛信息并转换为DataStore</desc>
	<input>
		<param name="nodpath" type="string">xpath格式为"数据岛id.数据类型.元素名"</param>
		<param name="ds" type="string">制定数据岛，默认为nodepath的首位</param>
	</input>
	<output type="DataForm/DataList/DataEnum/DataParam">根据nodepath返回不同类型</output>
</doc>**/
function GetDsNode(nodpath,ds)
{	 
	try{
		var eledoc=null;
		var ary=nodpath.split(".");
		
		if(!ds)
			eledoc=PageDoc.all(ary[0]).XMLDocument;
		else
			eledoc=ds.XmlDoc;
		var xmlele=eledoc.documentElement;
		var rtnobj=null,rtnele=null;
		var type=ary[1].toLowerCase();
		if (ary.length>3)
		{	for(var i=3;i<ary.length;i++)
			{	ary[2]+="."+ary[i];
			}
		}
		if(eledoc && xmlele)
		{	
			switch(type)
			{	case "form":
					rtnele=xmlele.selectSingleNode("Forms/Form[@Name='"+ary[2]+"']");
					if(!rtnele)throw new Error(nodpath +"Not Found!");
					rtnobj=new DataForm(null,eledoc,rtnele);
					break;
				case "list":
					rtnele=xmlele.selectSingleNode("Lists/List[@Name='"+ary[2]+"']");
					if(!rtnele)throw new Error(nodpath +"Not Found!");
					rtnobj=new DataList(null,eledoc,rtnele);
					break;
				case "enum":
					rtnele=xmlele.selectSingleNode("Enums/Enum[@Name='"+ary[2]+"']");
					if(!rtnele)throw new Error(nodpath +"Not Found!");
					rtnobj=new DataEnum(null,eledoc,rtnele);
					break;
				case "param":
					rtnele=xmlele.selectSingleNode("Params/Param[@Name='"+ary[2]+"']");
					if(!rtnele)throw new Error(nodpath +"Not Found!");
					rtnobj=new DataParam(null,eledoc,rtnele);
					break;
			}
		}
		return rtnobj;
	}catch(e)
	{	Debug(e.message,"GetDsNode(nodepath=" + nodpath + ",ds=" + ds + ")\n" );
		return null;
	}
}


//过滤DataForm字段，fields为保留字段
function FilterDataForm(df,fields)
{	if (fields == ""||fields==null)return df;
	var node = df.XmlEle.cloneNode(false);
	var newdf = new DataForm(node.xml);
	var fldary = fields.split(",");
	for(var i=0;i<fldary.length;i++)
	{	newdf.Add(fldary[i],df.GetValue(fldary[i]));
	}
	return newdf;
}
//过滤DataList字段，fields为保留列
function FilterDataList(dl,fields)
{	if (fields == ""||fields==null)return dl;
	if(dl.GetItemCount()==0)return dl;
	var node = dl.XmlEle.cloneNode(false);
	var newdl = new DataList(node.xml);
	var fldary = fields.split(",");
	var count=dl.GetItemCount();
	for(var i=0;i<count;i++)
	{	var item = newdl.NewItem();
		for(var j=0;j<fldary.length;j++)
		{	item.SetAttr(fldary[j],dl.GetItem(i).GetAttr(fldary[j]));
		}
	}
	return newdl;
}



/**获取DataParam的元素值，如果没有设置返回缺省值**/
function GetParam(define,deftype)
{	var node = GetDsNode(define);
	if(!node)
		return deftype;
	else
	{	var ftype = node.GetValue();
		if(ftype)
			return ftype;
		else
			return deftype;
	}
}


//
//---------------------------------全局函数定义开始--------------------------------------------------------------
//

/**<doc type="function" name="Global.OnError">
	<desc>错误处理函数</desc>
</doc>**/
function OnError(msg,url,lineno)
{	window.status ="(错误: " + msg + ") " +" (位置: " + url + ")  (行号: " + lineno+")";
	window.setTimeout("window.status='';",5000);
	return true;
}

/*<doc type="function" name="Global.Debug"></doc>*/
function Debug(msg,src)
{	if(!DebugState)return;
	var txt = document.all("_debug_text");
	if(!txt)
	{	txt = document.createElement("<textarea id='_debug_text' style='width:100%;height:128;'>");
		document.body.appendChild(txt);
	}
	var errmsg = msg;
	if(src)errmsg = "Error:"+msg+"\nSource:"+src;
	switch(DebugMethod.toLowerCase())
	{	case "alert":
			alert(errmsg);
			break;
		case "status":
			window.status = errmsg;
			break;
		case "text":
			txt.value = errmsg;
			break;
		case "texttrace":
			txt.value+=errmsg;
	}
}

/**<doc type="classext" name="ToBool">
	<desc>将字符串转化为bool类型</desc>
	<input>
		<param name="str" type="string">输入字符串</param>
	</input>
	<output>返回bool类型</output>
</doc>**/
function ToBool(value)
{	if(typeof(value)=="boolean")return value;
	if(!value)return false;
	value = (value+"").toLowerCase();
	if(value=="true" || value=="t"|| value=="yes"|| value=="on"|| value=="ok")return true;
	else return false;
}

function ToInt(value)
{	return parseInt(value);
}
function ToFloat(value)
{	return parseFloat(value);
}



/**<doc type="classext" name="Date.create">
	<desc>将指定格式的字符串转化为日期对象</desc>
	<input>
		<param name="str" type="string">输入字符串,格式为（yyyy-mm-dd hh:mm:ss）</param>
	</input>
	<output>返回日期对象</output>
</doc>**/
function ToDate(str)
{
	try{
		var parts = str.split(" ");
		var dp = parts[0].split("-");
		//var dt = new Date();//parseInt("09")等有BUG
		//dt.setFullYear(parseInt(parseFloat(dp[0])),parseInt(parseFloat((dp[1])-1)),parseInt(parseFloat(dp[2])));
		var dt = new Date(dp[0],dp[1]-1,dp[2]);
		if(parts.length>1)
		{	var tt = parts[1].split(":");
			dt.setHours(parseInt(tt[0]),parseInt(tt[1]),parseInt(tt[2]));
		}
		else
			dt.setHours(0,0,0,0);
		return dt;
	}catch(e)
	{	return null;}
}
/**<doc type="function" name="Global.LinkTo">
	<desc>链接到一个应用系统的一个页面</desc>
	<input>
		<param name="appname" type="string">链接的应用系统的标识名称[Global.AppServer]</param>
		<param name="url" type="string">链接的目标地址，相对地址</param>
		<param name="target" type="empty/object/string">链接到的目标窗口,可以是本窗口、Frame、IFrame或是新窗口</param>
		<param name="style"  type="empty/string">新窗口的样式</param>
	</input>
</doc>**/
function LinkTo(url,target,style)
{	var desurl=url;
	var win=null;
	if(desurl==null||desurl=="")
	{
		return false;
	}	
	if(desurl.indexOf("{")!=-1)
	{	var param=returnUrl.substring(desurl.indexOf("{")+1,desurl.indexOf("}"));
		var value=AppServer[param];
		desurl=desurl.replace("{" + param + "}",value);
	} 
	try{var target = eval(target);}catch(e){}
	if(!target||target=="null")
	{	window.location.href = desurl;
	}else if(typeof(target)=="object")
		target.location.href = desurl;
	else if(typeof(target)=="string")
	{	
		if(!style)style="compact";
		else style += ",resizable=yes";
		if(target=="")
			target="_SELF";
		
       // if (target.toUpperCase() == "_SELF" || target.toUpperCase() == "_PARENT" || target.toUpperCase() == "_TOP")
        //{   
		//	try
		//	{
        //       eval("window."+target.substr(1).toLowerCase()+".location.href ='"+ desurl+"';");
        //    }catch(e){}
        //}
        //else
        //{   
            if(target.toUpperCase() == "_BLANK")
            {
                win = window.open(desurl,"",style);
            }    
            else
            {
                win = window.open(desurl,target,style); 
            }    
            if(!win) alert("哎呀，你阻止了弹出窗口！");
        //}		
		//win = window.open(desurl,target,style);
	}
	if(win)return win;
}

/**<doc type="function" name="Global.ParamLinkTo">
	<desc>链接到一个应用系统的一个页面</desc>
	<input>
		<param name="url" type="string">链接的目标地址，相对地址</param>
		<param name="xmlnode" type="string">DataItem用于设置url总"[]"中的项的值</param>
		<param name="target" type="empty/object/string">链接到的目标窗口,可以是本窗口、Frame、IFrame或是新窗口</param>
		<param name="style"  type="empty/string">新窗口的样式</param>
	</input>
</doc>**/
function ParamLinkTo(url,xmlnode,target,style)
{	returnUrl=url;
	while(returnUrl.indexOf("[")!=-1)
	{
		var param=returnUrl.substring(returnUrl.indexOf("[")+1,returnUrl.indexOf("]"));
		var value ="null";
		if(xmlnode)
			value=(xmlnode.getAttribute(param)+"").filterNull();//获得XML属性值
		if(value == "")
			value=(xmlnode.getAttribute(param.toUpperCase())+"").filterNull();
		if(value == "null")
		{	value = eval(param);//获得全局变量值
			if(typeof(value)=="undefined") 
				value="";
		}
		returnUrl=returnUrl.replace("[" + param + "]",value);
	}
	return LinkTo(returnUrl,target,style);
}


/**
</doc>**//**<doc type="function" name="Global.ArrayFind">
	<desc>查找指定数组中值位置</desc>
	<output>返回数组中指定值位置</output>
</doc>**/
ArrayFind=function(ary,value)
{	for(var i=0;i<ary.length;i++)
		if(ary[i]==value)return i;
	return -1;
}


/**<doc type="function" name="Global.ToArray">
	<desc>用于将object.all(xx)取回的值统一转换成数组</desc>
	<input>
		<param name="ele" type="variant">需要转换的变量或数组</param>
	</input>
</doc>**/
function ToArray(ele)
{	if (ele == null) return new Array();
	if (typeof(ele.length)=="undefined")
	{	var ary = new Array();
		ary[0] = ele;
		return ary;
	}else
		return ele;
}

/**<doc type="function" name="Global.Get">
	<desc>获得HTML元素对象</desc>
	<input>
		<param name="id" type="string">元素的ID</param>
	</input>
	<ouput type="object">返回HTML对象</output>
</doc>**/
function Get(id)
{
}


/**<doc type="function" name="Global.GetValue">
	<desc>获得元素的值</desc>
	<input>
		<param name="id" type="string">元素的ID</param>
	</input>
	<ouput type="variant">返回数据</output>
</doc>**/
function GetValue(ele)
{	if(typeof(ele)=="string")
		ele = document.all(ele);
	switch(ele.tagName)
	{	case "INPUT":
			switch(ele.type)
			{	case "text":
					return ele.value;
				case "checkbox":
					return ele.checked?"T":"F";
				case "radio":
					return ele.value;
			}
		case "SELECT":
			return ele.options[ele.selectedIndex].value;
		case "TEXTAREA":
			return ele.value;
		default:
			return ele.innerText;
	}
}

/**<doc type="function" name="Global.SetValue">
	<desc>设置元素的值</desc>
	<input>
		<param name="id" type="string">元素的ID</param>
		<param name="value" type="variant">元素的值</param>
	</input>
</doc>**/
function SetValue(ele,value)
{	if(typeof(ele)=="string")
		ele = document.all(ele);
	switch(ele.tagName)
	{	case "INPUT":
			switch(ele.type)
			{	case "text":
					ele.value=value;
					break;
				case "checkbox":
					ele.checked=ToBool(value);
				case "radio":
					var eles = ToArray(ele);
					for(var i=0;i<eles.length;i++)
						if (eles[i].value == value)
						{	eles[i].checked = true;
							break;
						}
					break;
			}
		case "SELECT":
			for(var i=0;i<ele.length-1;i++)
				if (ele.options[i].value == value)
				{	ele.selectedIndex = i;
					break;
				}
			break;
		case "TEXTAREA":
			rele.value=value;
			break;
		default:
			ele.innerText=value;
			break;
	}
}

/**<doc type="function" name="Global.SetDisabled">
	<desc>将HTML元素设置为不可控/可控状态</desc>
	<input>
		<param name="id" type="string">元素的ID</param>
		<param name="st" type="boolean">状态</param>
	</input>
</doc>**/
function SetDisabled(id,st)
{
	document.getElementById(id).disabled = st;
}

/**<doc type="function" name="Global.SetReadonly">
	<desc>将HTML元素设置为不可编辑/可编辑状态</desc>
	<input>
		<param name="id" type="string">元素的ID</param>
		<param name="id" type="boolean">状态</param>
	</input>
</doc>**/
function SetReadonly(id,st)
{
	document.getElementById(id).readOnly = st;
}

/**<doc type="function" name="Global.BeautyXml">
	<desc>格式化xml字符串，并检查xml的合法性</desc>
	<input>
		<param name="xml" type="string">输入的xml字符串</param>
	</input>
	<output>输出格式化后的字符串</output>
</doc>**/
function BeautyXml(xml){
	BeautyXmlString="";
	var xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
	xmlDoc.async = false;
	xmlDoc.loadXML(xml);
	if (xmlDoc.parseError.errorCode != 0)
		throw new Error(10,xmlDoc.parseError.reason + "\n" +xmlDoc.parseError.srcText);
	return GetFormatXml(xmlDoc.documentElement,0);
}


/**<doc type="function" name="Global.GetTab">
	<desc>获得指定数目Tab字符</desc>
	<input>
		<param name="len" type="integer">Tab串长度</param>
	</input>
	<output>返回Tab串</output>
</doc>**/
function GetTab(len)
{	if (len == 0) return "";
	var str = "";
	for(var i = 0; i < len; i++)
		str += "\t";
	return str;
}


/**<doc type="function" name="Global.GetFormatXml">
	<desc>获得格式化后的XML字符串格式(递归法)</desc>
	<input>
		<param name="xml" type="string">xml元素</param>
		<param name="deep" type="integer">深度</param>
	</input>
	<output>输出格式化后的字符串</output>
</doc>**/
function GetFormatXml(xmlele,deep)
{	var tmpnode;
	if (xmlele.childNodes.length > 1 || 
		(xmlele.childNodes.length == 1 && xmlele.childNodes(0).nodeType == 1)){
		tmpnode = xmlele.cloneNode(false);  //只克隆父节点
		var tmpstr = tmpnode.xml;
		tmpstr = tmpstr.replace("/","");	//Tow Case: <AA/>  <AA></AA>
		var pos = tmpstr.indexOf(">");
		tmpstr = tmpstr.substr(0,pos + 1);  //取出节点标签
		BeautyXmlString +=  GetTab(deep) + tmpstr + "\n";
		for(var i = 0; i < xmlele.childNodes.length;i ++)
			GetFormatXml(xmlele.childNodes[i],deep + 1);
		BeautyXmlString += GetTab(deep) + "</" + tmpnode.nodeName + ">" + "\n";
	}
	else{
		BeautyXmlString += GetTab(deep) + xmlele.xml + "\n";
	}
	return BeautyXmlString;
} 


/**<doc type="function" name="Global.GetSpace">
	<desc>获得指定数目空字符串</desc>
	<input>
		<param name="len" type="integer">空字符串长度</param>
		<param name="len" type="integer">填充字符</param>
	</input>
	<output>返回空字符串</output>
</doc>**/
function GetSpace(len,ch)
{	if (len == 0) return "";
	var str = "";
	if(!ch) ch = " ";
	for(var i = 0; i < len; i++)
		str += ch;
	return str;
}

/**<doc type="function" name="Global.GetAttr">
	<desc>返回指定对象的指定属性值</desc>
	<input>
		<param name="ele" type="object">目标对象</param>
		<param name="name" type="string">指定目标对象属性名</param>
		<param name="defvalue" type="string">不存在指定属性时,返回的默认值</param>
		<param name="type"  type="bool/string/int/float/date">返回值类型</param>
	</input>
</doc>**/
function GetAttr(ele,name,defvalue,type)
{	var value=ele.getAttribute(name);
	if(!value && typeof(defvalue)!="undefined")
	{	value = defvalue;
		return value;
	}
	if(typeof(type)=="undefined")type="string";
	switch(type.toLowerCase())
	{	case "bool":return ToBool(value);
		case "string":return value;
		case "int":return parseInt(value);
		case "float":return parseFloat(value);
		case "date":return Date.parse(value);
	}
	return value;
}

/**<doc type="function" name="Global.GetAttr">
	<desc>设置指定对象的指定属性值</desc>
	<input>
		<param name="ele" type="object">目标对象</param>
		<param name="name" type="string">指定目标对象属性名</param>
		<param name="value" type="string">指定目标对象属性值</param>
	</input>
</doc>**/
function SetAttr(ele,name,value)
{	ele.setAttribute(name,value+"");
}

/**<doc type="function" name="Global.GetAttr">
	<desc>加载xml,并返回xml文档</desc>
	<input>
		<param name="xmlstring" type="string">xml数据</param>
	</input>
</doc>**/
function LoadXml(xmlstring)
{	var xmldoc=new ActiveXObject('Microsoft.XMLDOM');
	xmldoc.async=false;xmldoc.loadXML(xmlstring);
	if(xmldoc.parseError.errorCode!=0)
	{	Debug('[Global.LoadXml] load error!\n',xmldoc.parseError.reason); 
		return null;
	}else 
	return xmldoc;
}

/**<doc type="function" name="Global.SetPageKey">
	<desc>设置顶层窗口的PageKey</desc>
	<input>
		<param name="pkey" type="string">PageKey</param>
	</input>
</doc>**/
function SetPageKey(pkey)
{	PageKey = pkey;
	var curwin=window;
	try{
		while(curwin!=curwin.parent)
		{
			if(curwin.parent.IsTopWindow)
			{	var win=curwin.parent;
				win.TitleBar.PageKeyChanged(pkey);
				break;
			}
			curwin = curwin.parent;
		}
	}catch(e){}
}

/**<doc type="function" name="Global.GetNodeIndex">
	<desc>返回一个XML节点在父节点中的位置，也可用于HTML元素</desc>
	<input>
		<param name="node" type="xmlnode">XML节点</param>
	</input>
</doc>**/
function GetNodeIndex(node)
{	var pnode = node.parentNode;
	var count = pnode.childNodes.length;
	for(var i=0;i<count;i++)
		if(pnode.childNodes[i]==node)return i;
}

/**<doc type="function" name="Global.PostRequest">
	<desc>后台用Post提交数据</desc>
	<input>
		<param name="url" type="string">链接的目标地址，相对地址</param>
		<param name="data"  type="xml">需要提交的数据</param>
	</input>
</doc>**/
function PostRequest(url,data)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("POST",url,false);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(data);
	return xmlhttp.responseText;
}

/**<doc type="function" name="Global.GetRequest">
	<desc>后台用Get提交数据</desc>
	<input>
		<param name="url" type="string">链接的目标地址，相对地址</param>
	</input>
</doc>**/
function GetRequest(url)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.Open("GET",url,false);
	xmlhttp.send();
	return xmlhttp.responseText;
}


/**<doc type="function" name="Global.SubmitRequest">
	<desc>前台提交数据（需要刷新页面）相当于将data放入Input中提交</desc>
	<input>
		<param name="url" type="string">链接的目标地址，相对地址</param>
		<param name="data"  type="xml">需要提交的数据</param>
		<param name="action"  type="string">操作类型，后台可用RequestAction获得</param>
		<param name="method"  type="string">提交形式：post或get</param>
		<param name="target"  type="empty/object/string">链接到的目标窗口,可以是本窗口、Frame、IFrame或是新窗口</param>
	</input>
</doc>**/
function SubmitRequest(url,data,action,method,target)
{	
	var actionurl = url + "";	//Why?may be com string is different from js string
	
	if (typeof(target) == "undefined")
		var target = "_self";
	if (typeof(method) == "undefined")
		var method = "post";
	
	var frm =  document.createElement("<Form>");
	frm.method = method;
	
	if (actionurl.indexOf("?")>0)
		frm.action = actionurl + "&RequestAction=" + action;
	else
		frm.action = actionurl + "?RequestAction=" + action;
	frm.target = target;
	var fld = document.createElement("<Input type='hidden' name='DataStore'>");
	fld.value = escape(data);
	frm.appendChild(fld);
	document.appendChild(frm);
	frm.submit();
//	alert(frm.outerHTML);
//	document.body.disabled = true;
}

/**<doc type="function" name="Global.GetQueryString">
	<desc>得到指定url中传入的指定属性值,默认url为本页面url</desc>
	<input>
		<param name="prop"  type="string">属性名</param>
		<param name="url" type="string">链接的目标地址，相对地址</param>
	</input>
</doc>**/
function GetQueryString( prop, url ) 
{	var re = new RegExp( prop + "=([^\\&]*)", "i" );
	if(!url)
	{
		url = document.location.search;
	}
	else
	{
		if(url.indexOf("?")>=0)
		{
			url = url.split("?")[1];
		}
		else
		{
			url = "";
		}
	}
	//alert(url)
	var a = re.exec( url );
	if ( a == null )return null;
	return a[1];
}

/**<doc type="function" name="Global.GetQueryParams">
	<desc>分析本地URL,获得相关参数</desc>
	<output type="[]">返回键值对</output>
</doc>**/
function GetQueryParams(url)
{
	var params=[];
    var value = ""; 
    var sURL = window.document.URL;
	if(url) sURL = url;
    if (sURL.indexOf("?") > 0)
	{
		var arrayParams = sURL.split("?");
		if(arrayParams.length==1)return params;
        var arrayURLParams = arrayParams[1].split("&");
        for (var i = 0; i < arrayURLParams.length; i++)
        {
            var sParam =  arrayURLParams[i].split("=");
            if (sParam[0] != "")
            {
                params[sParam[0]] = unescape(sParam[1]);
            }
         }        
     }
	return params;
}

var fadeArray = new Array();	// 渐显/渐隐元素容器
/**<doc type="function" name="Global.FadeShow">
	<desc>逐渐显示一个元素</desc>
	<input>
		<param name="el"  type="object">元素</param>
		<param name="fadeIn" type="bool">true(渐显)/false(渐隐)</param>
		<param name="steps"  type="int">显示步骤</param>
		<param name="msec"  type="int">每步毫秒数</param>
	</input>
</doc>**/
function FadeShow(el, fadeIn, steps, msec) {

	if (steps == null) steps = fadeSteps;
	if (msec == null) msec = fademsec;
	
	if (el.fadeIndex == null)
		el.fadeIndex = fadeArray.length;
	fadeArray[el.fadeIndex] = el;
	
	if (el.fadeStepNumber == null) {
		if (el.style.visibility == "hidden")
			el.fadeStepNumber = 0;
		else
			el.fadeStepNumber = steps;
		if (fadeIn)
			el.style.filter = "Alpha(Opacity=0)";
		else
			el.style.filter = "Alpha(Opacity=100)";
	}
			
	window.setTimeout("RepeatFade(" + fadeIn + "," + el.fadeIndex + "," + steps + "," + msec + ")", msec);
}

//////////////////////////////////////////////////////////////////////////////////////
//  Used to iterate the fading
function RepeatFade(fadeIn, index, steps, msec) {	
	el = fadeArray[index];
	c = el.fadeStepNumber;
	if (el.fadeTimer != null)
	{
		window.clearTimeout(el.fadeTimer);
	}
	if ((c == 0) && (!fadeIn)) {			//Done fading out!
		el.style.visibility = "hidden";		// If the platform doesn't support filter it will hide anyway
//		el.style.filter = "";
		return;
	}
	else if ((c==steps) && (fadeIn)) {	//Done fading in!
		el.style.filter = "";
		el.style.visibility = "visible";
		return;
	}
	else {
		(fadeIn) ? 	c++ : c--;
		el.style.visibility = "visible";
		el.style.filter = "Alpha(Opacity=" + 100*c/steps + ")";

		el.fadeStepNumber = c;
		el.fadeTimer = window.setTimeout("RepeatFade(" + fadeIn + "," + index + "," + steps + "," + msec + ")", msec);
	}
}

/**<doc type="function" name="Global.GetEval">
	<desc>得到eval后的返回值,若执行出错则返回null</desc>
	<input>
		<param name="evalstr"  type="string">要执行的语句</param>
	</input>
</doc>**/
function GetEval(evalstr)
{	try{
		return eval(evalstr);
	}catch(e)
	{	return null;
	}
}

/**<doc type="function" name="Global.CenterWin">
	<desc>得到居中样式字符串</desc>
	<input>
		<param name="linkStyle"  type="string">连接样式</param>
		<param name="isDialog"  type="bool">是否为对话框</param>
	</input>
</doc>**/
function CenterWin(linkStyle,isDialog)
{	
	if(!linkStyle)return "";
	if(isDialog)
		var sp = new StringParam(linkStyle.toLowerCase());
	else
		var sp = new StringParam(linkStyle.toLowerCase(),",","=");
	if(sp.Get("left")||sp.Get("top"))
	{
		return linkStyle;
	}
	else
	{
		var width = sp.Get("width");
		if(width==null)
			width=window.screen.width/2;
		else
			sp.Remove("width");
		var height =sp.Get("height");
		if(height==null)
			height=window.screen.height/2;
		else
			sp.Remove("height");
		var left = (window.screen.width-width)/2;
		var top = (window.screen.height-height)/2;
		return "left="+left+",top="+top+",width="+width+",height="+height+","+sp.ToString();
	}
}

/**<doc type="function" name="Global.GetCookie">
	<desc>得到指定的Cookie值</desc>
	<input>
		<param name="name"  type="string">指定Cookie名</param>
	</input>
</doc>**/
function GetCookie(name)
{
	beg = document.cookie.indexOf(name+"=");
	if (beg==-1)
		return "";
	buff = document.cookie.substr(beg);
	end = buff.indexOf(";");
	if (end==-1)
		end = buff.length+1;
	return document.cookie.substr(beg+name.length+1,end - name.length - 1);
}

/**<doc type="function" name="Global.GetPassCode">
	<desc>从Cookie中获取PassCode值</desc>
</doc>**/
function GetPassCode()
{	if (PassCode.length <= 0)
	{	try
		{	PassCode = window.top().PassCode;
		}
		catch(err){	}
		if (PassCode.length <= 0)
		{	try
			{	PassCode = GetCookie("PassCode");
			}
			catch(err){
				alert("不能获取系统通行代码!");
			}
		}
					
	}
	return PassCode;
}

/**<doc type="function" name="Global.GetPassCode">
	<desc>获取字符串长度（Unicode每个字符两个长度）</desc>
</doc>**/
function StringLen(valuestr){
         var  strInput=valuestr;
         var count=strInput.length;
         var len=0;
         if(count!=0)
                   for(var i=0;i<count;i++){
                            if(strInput.charCodeAt(i)>=128)
                                     len+=2;
                            else 
                                     len+=1;
                   }
         return len;
}

/**<doc type="function" name="Global.GetRequest">
	<desc>判断制定值是否符合制定日期格式</desc>
	<input>
		<param name="value" type="string">给定用于判断的值</param>
		<param name="fm" type="string">日期格式"YYYY-MM-DD","YY-MM-DD",默认"YYYY-MM-DD"</param>
	</input>
</doc>**/
function IsDate(value,fm)
{	
	if(!fm)
	{	fm = "YYYY-MM-DD";
	}
	if (fm=="YYYY-MM-DD")
	{	var re=/^\d{4}-\d{1,2}-\d{1,2}$/;
		var r=value.match(re);
		if (r==null)
			return false;
		else{
				var s=value.split("-");
				if (s[0].substring(0,2)<19 ||s[0].substring(0,2)>21 || s[1]>12 || s[1]<1 || s[2]>31 || s[2]<1)
					return false;
			}
		return true;
	}else if (fm=="YY-MM-DD")
	{	var re=/^\d{1,2}-\d{1,2}-\d{1,2}$/;
		var r=value.match(re);
		if (r==null)
			return false;
		else{
				var s=value.split("-");
				if ( s[1]>12 || s[1]<1 || s[2]>31 || s[2]<1)
					return false;
			}
		return true;
	}
	
}
/**<doc type="function" name="Global.GetRequest">
	<desc>判断制定值是否符合制定日期时间格式</desc>
	<input>
		<param name="value" type="string">给定用于判断的值</param>
		<param name="minYear" type="int">最小年份，默认0</param>
		<param name="maxYear" type="int">最大年份，默认9999</param>
		<param name="hassec" type="bool">是否验证秒，默认false</param>
	</input>
</doc>**/
function IsDateTime(value,minYear,maxYear,hassec)
{
	if(!maxYear)
	{	maxYear = 9999;
	}
	if(!minYear)
	{	maxYear = 0;
	}
	var reg;
	if(hassec)
		reg = /^(\d+)-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;  
	else
		reg = /^(\d+)-(\d{1,2})-(\d{1,2}) (\d{1,2}):(\d{1,2})$/;  	
	var r = value.match(reg); 
	//如果不验证秒,则将秒默认设置为0
	if(r==null)return false;  
	if(!r[6])
		r[6] = 0;	
	r[2]=r[2]-1;  
	var d= new Date(r[1], r[2],r[3], r[4],r[5], r[6]);  
	if(d.getFullYear()!=r[1] || r[1] < minYear || r[1] > maxYear)return false;  
	if(d.getMonth()!=r[2])return false;  
	if(d.getDate()!=r[3])return false;  
	if(d.getHours()!=r[4])return false;  
	if(d.getMinutes()!=r[5])return false;  
	if(d.getSeconds()!=r[6])return false;  
	return true; 
}

/**<doc type="function" name="Global.GetRequest">
	<desc>判断指定值是否符合时间格式</desc>
	<input>
		<param name="value" type="string">给定用于判断的值</param>
		<param name="hassec" type="bool">是否验证秒，默认false</param>
	</input>
</doc>**/
function IsTime(value,hassec)
{	if (typeof(hassec)=="undefined")
		var hassec=false;
	if (hassec) //需要判断秒
	{	var re=/^\d{1,2}:\d{1,2}:\d{1,2}$/;
		var r=value.match(re);
		if (r==null)
			return false;
		else{
				var s=value.split(":");
				if (s[0]<0 || s[0]>23 || s[1]<0 || s[1]>59 || s[2]<0 || s[2]>59)
					return false;
			}
		return true;
	}else
	{	var re=/^\d{1,2}:\d{1,2}$/;
		var r=value.match(re);
		if (r==null)
			return false;
		else{
				var s=value.split(":");
				if (s[0]<0 || s[0]>23 || s[1]<0 || s[1]>59)
					return false;
			}
		return true;
		
	}
}

function IsFloat(value)
{
    var re=/^\d{1,}$|^\d{1,}\.\d{1,}$/;
    var r=value.match(re);
    if (r==null)
		return false;
    else
		return true;
}

function IsInt(value)
{
	var re=/^\d{0,}$/;
	var r=value.match(re);
	if (r==null)
		return false;
	else
		return true;
}

function IsEmail(value)
{
	var re=/^\w+@\w+\.\w{2,3}/;
    var r=value.match(re);
    if (r==null)
		return false
	else
		return true;

}

function IsPhone(value)
{
	var re=/^(([0-9]+)-)?\d{7,11}$/;
    var r=value.match(re);
    if (r==null)
		return false
	else
		return true;
}

// 判断是否合法居民身份证号（中国）
function IsIDCard(value)
{
	var _re15 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;	// 15位
	var _re18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;	// 18位

	return (IsValueMatch(value, _re15) || IsValueMatch(value, _re18))
}

// 验证指定值是否符合指定正则表达式
function IsValueMatch(value, re)
{
	var r = value.match(re)
    if (r==null)
		return false
	else
		return true;
}

/**<doc type="function" name="Global.GetFileSize">
	<desc>得到指定文件的大小,以kb为单位</desc>
	<input>
		<param name="fname" type="string">指定文件</param>
	</input>
</doc>**/
function GetFileSize(fname)
{	try{
		var FSO=new ActiveXObject("Scripting.FileSystemObject"); 
		var file=FSO.GetFile(fname); 
		var fileSize=Math.ceil(file.Size/1024);
		return fileSize;
	}catch(e)
	{	return -1;
	}
}

/**<doc type="function" name="Global.GetFileSize">
	<desc>判断指定文本是否符合制定正则表达式</desc>
	<input>
		<param name="value" type="string">指定文本</param>
		<param name="exp" type="expstr">正则表达式</param>
	</input>
</doc>**/
function MatchExp(value,exp)
{	var expobj = new RegExp(exp,"i");
	var r=value.match(expobj);
    if (r==null)
		return false;
    else
		return true;
}

/**<doc type="function" name="Global.GetFileSize">
	<desc>获取指定字符串或Date类型的时间部分</desc>
	<input>
		<param name="date" type="string/object">指定字符串</param>
	</input>
</doc>**/
function Dateonly(date)
{
	if(typeof date == 'string')
		return date.split(" ")[0];
	else if(typeof date == 'object')
		return date.getDatePart();
}
//
//---------------------------------全局函数定义结束--------------------------------------------------------------
//



//
//--------------------------------Collection 对象定义开始--------------------------------------------------
//

/**<doc type="objdefine" name="Collection">
	<desc>字符串对象定义修剪功能扩展</desc>
	<property>
		<prop name="Keys" type="array">键数组</param>
	</property>
</doc>**/
function Collection()
{	this.Type="";
	this.Keys=new Array();
	this.Values=new Array();
}

/**<doc type="protofunc" name="Collection.Add">
	<desc>添加一个元素</desc>
	<input>
		<param name="key" type="string">键值</param>
		<param name="value" type="variant">数值</param>
	</input>
</doc>**/
Collection.prototype.Add=function(key,value)
{	if(this.Exist(key))
	{	throw new Error(0,key+" has exist!");
		return;
	}
	this.Values.push(value);
	this.Keys.push(key);
}

/**<doc type="protofunc" name="Collection.Exist">
	<desc>是否存在一个元素</desc>
	<input>
		<param name="key" type="string">键值</param>
	</input>
</doc>**/
Collection.prototype.Exist=function(key)
{	if(ArrayFind(this.Keys,key)>=0)return true;
	return false;
}
/**<doc type="protofunc" name="Collection.Set">
	<desc>设置一个元素，不存在则添加，存在则覆盖</desc>
	<input>
		<param name="key" type="string">键值</param>
		<param name="value" type="variant">数值</param>
	</input>
</doc>**/
Collection.prototype.Set=function(key,value)
{	
	if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos>=0)
			this.Values[pos]=value;
		else
		{	this.Values.push(value);
			this.Keys.push(key);
		}
	}
	else if(typeof(key)=="number")
	{	if(key<0||key>=this.Keys.length)
			throw new Error(0, key +" not in scope!");
		this.Values[key]=value;
	}	
}

/**<doc type="protofunc" name="Collection.Remove">
	<desc>删除一个元素</desc>
	<input>
		<param name="keyindex" type="string/number">键值或索引</param>
	</input>
</doc>**/
Collection.prototype.Remove=function(key)
{	if(typeof(key)=="number")
	{	if(key<0||key>=this.Keys.length)
			return false;
		this.Keys.splice(key,1);
		this.Values.splice(key,1);
		return true;
	}else if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos<0)
			return false;
		this.Keys.splice(pos,1);
		this.Values.splice(pos,1);
		return true;
	}
}


/**<doc type="protofunc" name="Collection.Clear">
	<desc>清除所有元素</desc>
</doc>**/
Collection.prototype.Clear=function()
{	this.Keys.splice(0,this.Keys.length);
	this.Values.splice(0,this.Values.length);
}

/**<doc type="protofunc" name="Collection.Insert">
	<desc>插入一个元素，以之前插入为优先,在IsSort为true的情况下，等同于Add</desc>
	<input>
		<param name="key" type="string">键值</param>
		<param name="value" type="variant">数值</param>
		<param name="before" type="null/string/int">在之前插入</param>
		<param name="after" type="null/string/int">在之后插入</param>
	</input>
	<demo>
		col.Insert("key","value","key0");
		col.Insert("key","value",null,"key0");
	</demo>
</doc>**/
Collection.prototype.Insert=function(key,value,before)
{	
	if(ArrayFind(this.Keys,key)>=0)
	{	throw new Error(0, key+" has exist!");
		return;
	}
	if(typeof(before)=="undefined")
	{	this.Add(key,value);
		return;
	}
	if( typeof(before)=="number"  )
	{	if((before<0 || before>=this.Keys.length))
			this.Add(key,value);
		else
		{	this.Keys.splice(before,0,key);
			this.Values.splice(before,0,value);
		}
	}
	if( typeof(before)=="string"  )
	{	var bpos=ArrayFind(this.Keys,before);
		if(bpos<0)
			this.Add(key,value);
		else
		{	this.Keys.splice(bpos,0,key);
			this.Values.splice(bpos,0,value);
		}
	}

}

/**<doc type="protofunc" name="Collection.GetCount">
	<desc>获得元素个数</desc>
	<output type="number">元素的个数</output>
</doc>**/
Collection.prototype.GetCount=function()
{	return this.Keys.length;
}

/**<doc type="protofunc" name="Collection.GetItem">
	<desc>获得一个元素</desc>
	<input>
		<param name="keyindex" type="string/number">键值或索引</param>
	</input>
	<output type="variant">元素的数值</output>
</doc>**/
Collection.prototype.Get=function(key)
{	if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos<0)return null;
		return this.Values[pos];
	}
	if(typeof(keyindex)=="number")
	{	if((key<0 || key>=this.Keys.length))
			return null;
		return this.Values[key];
	}
}

/**<doc type="protofunc" name="Collection.Clone">
	<desc>复制本集合</desc>
	<output type="object">Collection对象</output>
</doc>**/
Collection.prototype.Clone=function()
{	var newcol = new Collection();
	var count=this.Keys.length;
	for(var i=0;i<count;i++)
	{	newcol.Keys[i] = this.Keys[i];
		newcol.Values[i] = this.Values[i];
	}
	return newcol;
}

/**<doc type="protofunc" name="Collection.ToString">
	<desc>返回字符串类型</desc>
	<output type="string">格式"Key:Value;"</output>
</doc>**/
Collection.prototype.ToString=function()
{
	var str="";
	var count=this.Keys.length;
	for(var i=0;i<count;i++)
	{	str+=this.Keys[i]+":"+this.Values[i]+";";
	}
	if(str.length>0)
		return str.substr(0,str.length-1);
	return "";
}
//
//--------------------------------Collection 对象定义结束---------------------------------------------------
//


//
//--------------------------------StringParam 对象定义开始---------------------------------------------------
//

/**<doc type="objdefine" name="StringParam" inhert="Collection">
	<desc>串参数集合对象定义</desc>
	<input>
		<param name="spstr" type="string">初始化参数串</param>
		<param name="type" type="enum">参数串类型</param>
	</input>
	<enum name="type">
		<item value="style" isdefault="true">Key:Value;Key1:Value0;Key1:Value1;</item>
		<item value="query" >Key=Value&Key1=Value0&Key1=Value1</item>
	</enum>
</doc>**/
function StringParam(spstr,divchar,gapchar)
{	this.Keys=new Array();
	this.Values=new Array();
	this.DivChar=";";
	this.GapChar=":";
	if(divchar && gapchar)
	{	this.DivChar=divchar;
		this.GapChar=gapchar; 
	}	
	if(spstr)
	{	var ary=spstr.split(this.DivChar);
		for(var i=0;i<ary.length;i++)
		{	var subary=ary[i].split(this.GapChar);
			if(subary[0]!="")
			{	this.Values.push(subary[1]);
				this.Keys.push(subary[0]);
			}
		}
	}
}
/**<doc type="protofunc" name="StringParam.GetCount">
	<desc>获得元素个数</desc>
	<output type="number">元素的个数</output>
</doc>**/
StringParam.prototype.GetCount=function()
{	return this.Keys.length;
}


/**<doc type="protofunc" name="StringParam.Add">
	<desc>添加元素</desc>
	<input>
		<param name="key" type="string">元素key</param>
		<param name="value" type="string">元素value</param>
	</input>
</doc>**/
StringParam.prototype.Add=function(key,value)
{	var pos=ArrayFind(this.Keys,key);
	if(pos>=0)
	{	var ary = this.Values[pos].split(",");
		if(ArrayFind(ary,escape(value))<0)
			this.Values[pos]=this.Values[pos]+","+escape(value);
		else
			throw new Error(0, "("+key+" , "+value+") has exist!");
	}
	else
	{	this.Values.push(escape(value));
		this.Keys.push(key);
	}
}

/**<doc type="protofunc" name="StringParam.Set">
	<desc>设置元素值</desc>
	<input>
		<param name="key" type="string">元素key</param>
		<param name="value" type="string">元素value</param>
		<param name="notclear" type="bool">为true时查询原Values中是否包含指定值，不包含则加入</param>
	</input>
</doc>**/
StringParam.prototype.Set=function(key,value,notclear)
{	
	if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos>=0)
		{	if(notclear)
			{	var ary = this.Values[pos].split(",");
				if(ArrayFind(ary,escape(value))<0)
					this.Values[pos]=this.Values[pos]+","+escape(value);
			}else
				this.Values[pos]=escape(value);
		}else
		{	this.Values.push(escape(value));
			this.Keys.push(key);
		}
	}
	else if(typeof(key)=="number")
	{	if((key<0 || key>=this.Keys.length))
			throw new Error(0, key +" not in scope!");
		if(notclear)
		{	var ary = this.Values[key].split(",");
			if(ArrayFind(ary,escape(value))<0)
				this.Values[key]=this.Values[key]+","+escape(value);
		}else
			this.Values[key]=escape(value);
	}
}

/**<doc type="protofunc" name="StringParam.Insert">
	<desc>在StringParam的制定位置插入值</desc>
	<input>
		<param name="key" type="string">元素key</param>
		<param name="value" type="string">元素value</param>
		<param name="before" type="number/string">制定位置或值得位置,默认为末位</param>
	</input>
</doc>**/
StringParam.prototype.Insert=function(key,value,before)
{	
	if(ArrayFind(this.Keys,key)>=0)
	{	throw new Error(0, key+" has exist!");
		return;
	}
	if(typeof(before)=="undefined")
	{	this.Add(key,escape(value));
		return;
	}
	if( typeof(before)=="number"  )
	{	if((before<0 || before>=this.Keys.length))
			this.Add(key,value);
		else
		{	this.Keys.splice(before,0,key);
			this.Values.splice(before,0,escape(value));
		}
	}
	if( typeof(before)=="string"  )
	{	var bpos=ArrayFind(this.Keys,before);
		if(bpos<0)
			this.Add(key,escape(value));//这里有错误?
		else
		{	this.Keys.splice(bpos,0,key);
			this.Values.splice(bpos,0,escape(value));
		}
	}

}

/**<doc type="protofunc" name="StringParam.Get">
	<desc>得到指定位置的值</desc>
	<input>
		<param name="key" type="string/number">元素key或位置</param>
	</input>
</doc>**/
StringParam.prototype.Get=function(key)
{	if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos<0)return null;
		return unescape(this.Values[pos]);
	}
	if(typeof(key)=="number")
	{	if((key<0 || key>=this.Keys.length))return null;
		return unescape(this.Values[key]);
	}
}

/**<doc type="protofunc" name="StringParam.GetArray">
	<desc>返回指定Key对应的Value并转化为数组</desc>
	<output type="object">由指定Key对应的Value转化的数组</output>
</doc>**/
StringParam.prototype.GetArray=function(key)
{	var value;
	if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos<0)return null;
		value = this.Values[pos];
	}
	if(typeof(key)=="number")
	{	if((key<0 || key>=this.Keys.length))return null;
		value = this.Values[key];
	}
	var ary = value.split(",");
	for(var i=0;i<ary.length;i++)
		ary[i] = unescape(ary[i]);
	return ary;
}
/**<doc type="protofunc" name="StringParam.Remove">
	<desc>删除一个元素</desc>
	<input>
		<param name="keyindex" type="string/number">键值或索引</param>
	</input>
</doc>**/
StringParam.prototype.Remove=function(key)
{	if(typeof(key)=="number")
	{	if(key<0||key>=this.Keys.length)
			return false;
		this.Keys.splice(key,1);
		this.Values.splice(key,1);
		return true;
	}else if(typeof(key)=="string")
	{	var pos=ArrayFind(this.Keys,key);
		if(pos<0)
			return false;
		this.Keys.splice(pos,1);
		this.Values.splice(pos,1);
		return true;
	}
}


/**<doc type="protofunc" name="StringParam.Clear">
	<desc>清除所有元素</desc>
</doc>**/
StringParam.prototype.Clear=function()
{	this.Keys.splice(0,this.Keys.length);
	this.Values.splice(0,this.Values.length);
}

/**<doc type="protofunc" name="StringParam.Clone">
	<desc>复制本集合</desc>
	<output type="object">StringParam对象</output>
</doc>**/
StringParam.prototype.Clone=function()
{	var newsp = new StringParam();
	var count=this.Keys.length;
	for(var i=0;i<count;i++)
	{	newsp.Keys[i] = this.Keys[i];
		newsp.Values[i] = this.Values[i];
	}
	return newsp;
}

/**<doc type="protofunc" name="StringParam.ToString">
	<desc>返回StringParam的字符串形式格式为 "Key+GapChar+Value"</desc>
	<input>
		<param name="noescape" type="bool">是否用unescape编码Value</param>
	</input>
</doc>**/
StringParam.prototype.ToString=function(noescape)
{
	var str="",value;
	var count=this.Keys.length;
	for(var i=0;i<count;i++)
	{	if(noescape)
			value=unescape(this.Values[i]);
		else
			value=this.Values[i];
		str+=this.Keys[i]+this.GapChar+value+this.DivChar;
	}
	if(str.length>0)
		return str.substr(0,str.length-1);
	return "";
}
//
//--------------------------------StringParam 对象定义结束---------------------------------------------------
//

//
//--------------------------------JcCaller 对象定义开始---------------------------------------------------
//

/*<doc type="function"></doc>*/
function JcCaller(body,time,method)
{	
	this.type="";
	this.body=body;
	var argstart=0;
	if (typeof(body)=="string")
	{	this.type="eval";
		argstart=2;	
	}else if(typeof(body)=="function")
	{	this.type="func";
		argstart=2;	
	}else if(typeof(body)=="object")
	{	this.type="objref";
		argstart=3;	
	}else
	{	Debug(this,"create caller error!");
	}
	if (time=="undefined")
		this.time=0;
	else 
		this.time=time;
	this.timeout=this.time;
	this.interval=this.time;
	this.method=method;
	this.args=new Array(16);
	if (arguments.length>argstart)
	{	for(var i=argstart;i<arguments.length;i++)
		this.args[i-argstart]=arguments[i];
	}
	this.id="JcCaller_"+JcCaller.idIndex++;
	JcCaller.store[this.id]=this;
	this.intervalTimeId=0;
	this.delayTimeId=0;
}
/*<doc type="function"></doc>*/
JcCaller.prototype.exec=function(isremove)
{	switch(this.type)
	{	case "eval":
			eval(this.body);
			break;
		case "func":
			this.body(this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5],this.args[6],this.args[7],this.args[8],this.args[9],this.args[10],this.args[11],this.args[12],this.args[13],this.args[14],this.args[15]);
			break;
		case "objref":
			this.body[this.method](this.args[0],this.args[1],this.args[2],this.args[3],this.args[4],this.args[5],this.args[6],this.args[7],this.args[8],this.args[9],this.args[10],this.args[11],this.args[12],this.args[13],this.args[14],this.args[15]);
			break;
	}
	if(isremove=="true")this.remove();
}
/*<doc type="function"></doc>*/
JcCaller.prototype.execTimeout=function(isremove)
{	 this.delayTimeId = setTimeout('try{JcCaller.store["' + this.id + '"].exec('+isremove+');}catch(e){Debug(this,"[JcCaller.execTimeout]:JcCaller object is not exist or removed!");}', this.timeout);
}
/*<doc type="function"></doc>*/
JcCaller.prototype.clearTimeout=function()
{	clearTimeout(this.delayTimeId);
}
/*<doc type="function"></doc>*/
JcCaller.prototype.execInterval=function()
{	 this.intervalTimeId = setInterval('try{JcCaller.store["' + this.id + '"].exec();}catch(e){Debug(this,"[JcCaller.execTimeout]:JcCaller object is not exist or removed!");}', this.interval);
}

/*<doc type="function"></doc>*/
JcCaller.prototype.clearInterval=function()
{	clearInterval(this.intervalTimeId);
}

/*<doc type="function"></doc>*/
JcCaller.prototype.remove=function()
{	delete(JcCaller.store[this.id]);
}
/*<doc type="varible"></doc>*/
JcCaller.idIndex=10000;
/*<doc type="varible"></doc>*/
JcCaller.store={};
/*<doc type="function"></doc>*/
JcCaller.remove=function(id)
{	delete(JcCaller.store[id]);
}
/*<doc type="function"></doc>*/
JcCaller.clear=function()
{	for(var idx in JcCaller.store)
		delete(JcCaller.store[idx])
}

//
//--------------------------------JcCaller 对象定义结束---------------------------------------------------
//

//
//--------------------------------全局对象对象实例定义开始---------------------------------------------------
//



/**<doc type="object" name="Global.Position">
	<desc>HTML元素的位置处理对象</desc>
	<property>
		<prop name="IeBox"/>
	</property>
</doc>**/
var Position = 
{	IeBox:		function (el) {
		return this.ie && el.document.compatMode != "CSS1Compat";
	},
	ClientLeft:	function (el) {
		var r = el.getBoundingClientRect();
		return r.left - this.BorderLeftWidth(this.CanvasElement(el));
	},
	ClientTop:	function (el) {
		var r = el.getBoundingClientRect();
		return r.top - this.BorderTopWidth(this.CanvasElement(el));
	},
	Left:	function (el) {
		return this.ClientLeft(el) + this.CanvasElement(el).scrollLeft;
	},

	Top:	function (el) {
		return this.ClientTop(el) + this.CanvasElement(el).scrollTop;
	},
	InnerLeft:	function (el) {
		return this.Left(el) + this.BorderLeftWidth(el);
	},

	InnerTop:	function (el) {
		return this.Top(el) + this.BorderTopWidth(el);
	},
	Width:	function (el) {
		return el.offsetWidth;
	},
	Height:	function (el) {
		return el.offsetHeight;
	},
	CanvasElement:	function (el) {
		var doc = el.ownerDocument || el.document;	// IE55 bug
		if (doc.compatMode == "CSS1Compat")
			return doc.documentElement;
		else
			return doc.body;
	},

	BorderLeftWidth:	function (el) {
		return el.clientLeft;
	},

	BorderTopWidth:	function (el) {
		return el.clientTop;
	},

	ScreenLeft:	function (el) {
		var doc = el.ownerDocument || el.document;	// IE55 bug
		var w = doc.parentWindow;
		return w.screenLeft + this.BorderLeftWidth(this.CanvasElement(el)) +
			this.ClientLeft(el);
	},

	ScreenTop:	function (el) {
		var doc = el.ownerDocument || el.document;	// IE55 bug
		var w = doc.parentWindow;
		return w.screenTop + this.BorderTopWidth(this.CanvasElement(el)) +
			this.ClientTop(el);
	}
};


/**<doc type="function" name="Global.CheckEnvironment">
	<desc>检查当前环境</desc>
	<input>
		<param name="type" type="enum">检查类型</param>
	</input>
	<enum name="type">
		<item text="isie">是否为IE浏览器</item>
		<item text="ieversion">IE浏览器版本是否在5.0以上</item>
		<item text="activex">是否支持Microsoft.XMLDOM控件</item>
		<item text="owc">是否安装OWC组件</item>
		<item text="viewer">是否和AutoVueX组件一同安装</item>
		<item text="becom">是否支持GsCommon.DataStore控件</item>
	</enum>
</doc>**/
function CheckEnvironment(type)
{	var result=false;
	switch(type.toLowerCase())
	{	case "isie":
			if(navigator.appName.indexOf("Internet Explore")>0)
				result = true;
			break;
		case "ieversion":
			var pos = navigator.appVersion.indexOf('MSIE');
			var vernum = navigator.appVersion.substr(pos+4,4);
			if(parseFloat(vernum)>5)
				result = true;
   			break;
		case "activex":
			try{	var test = new ActiveXObject("Microsoft.XMLDOM");
					result = true;
					test = null;
				}catch(e){}
			break;
		case "owc"://同OWC组件共同安装
			try{	var test = new ActiveXObject("GsOffice.OwcTool");
					result = true;
					test = null;
				}catch(e){}
			break;
		case "viewer"://和AutoVueX组件一同安装
			try{	var test = new ActiveXObject("GsViewer.ViewerTool");
					result = true;
				}catch(e){}
			break;
		case "becom":
			try{	var test = new ActiveXObject("GsCommon.DataStore");
					result = true;
				}catch(e){}
			break;
		case "beext":
			break;
	}
	return result;
}

//
//--------------------------------ValidateResult对象定义开始-------------------------------------
//

/**<doc type="objdefine" name="ValidateResult">
	<desc>验证结论对象定义</desc>
	<property>
		<prop name="Passed" type="boolean">是否通过验证</prop>
		<prop name="FieldName" type="string">验证的字段名称</prop>
		<prop name="Message" type="string">出错信息</prop>
		<prop name="ErrorType" type="string">出错类型</prop>
		<prop name="ValExpMsg" type="string">验证的正则表达式</prop>
	</property>		
</doc>**/
function ValidateResult()
{	this.Passed=true;
	this.FieldName="";
	this.Message="";
	this.ErrorType="";
	this.ValExpMsg="";
}

/**<doc type="protofunc" name="ValidateResult.GetErrMsg">
	<desc>获取出错信息</desc>
	<output type="string">出错信息</output>	
</doc>**/
ValidateResult.prototype.GetErrMsg=function()
{	return "["+this.FieldName+"]"+this.Message;
}

/**<doc type="protofunc" name="ValidateResult.ValidateNotAllowEmpty">
	<desc>验证指定对象是否为空</desc>
	<input>
		<param name="value" type="object">需要验证的对象</param>
		<param name="allowspace" type="bool">是否允许空格默认否</param>
	</input>
</doc>**/
ValidateResult.prototype.ValidateNotAllowEmpty=function(value,allowspace)
{	
	var isempty=false;
	if (typeof(allowspace)=="undefined")
		var allowspace = false;
	if (typeof(value)=="undefined"||value==null)
		isempty = true;
	else if (allowspace && value=="") isempty = true;
	else if(!allowspace && value.trim() =="")isempty = true;
	if (!isempty)
		this.Passed = true;
	else
	{	this.Passed = false;
		this.Message = "不允输入空值！";
	}
}

/**<doc type="protofunc" name="ValidateResult.ValidateFormElement">
	<desc>验证指定对象是否满足相应valstr对应的规则</desc>
	<input>
		<param name="value" type="object">需要验证的对象</param>
		<param name="valstr" type="string">规则字符串</param>
	</input>
</doc>**/
ValidateResult.prototype.ValidateFormElement=function(value,valstr)
{	
	var len,errmsg="",min,max,equ,pas=false,val,fm,exp=null;
	var sp= new StringParam(valstr);
	
	this.FieldName=sp.Get("Title");
	var valtype=sp.Get("DataType");
	if(!valtype)
		return true;	
	if(value && ("" + value).trim() != "")
	{
	valtype = valtype.toUpperCase();
	switch(valtype)
	{	case "STRING":
			
			len = StringLen(value);
			min = sp.Get("Min");max = sp.Get("Max");equ=sp.Get("Equ");
			exp = sp.Get("Exp");eds = sp.Get("ExpDes");
			if ( min!=null && max!=null && (len<parseInt(min) ||len>parseInt(max) ) )
				errmsg = "长度需在"+min+"到"+max+"之间!";
			else if (min!=null && len<parseInt(min))
				errmsg = "长度必需大于"+min+"!";
			else if (max!=null && len>parseInt(max))
				errmsg = "长度必需小于"+max+"!";
			else if(equ!=null && equ != len)
				errmsg = "长度必需等于"+equ+"!";
			if (exp!=null && MatchExp(value,exp)==false)
			{	if(eds==null) eds="";
				errmsg = eds;//this.ValExpMsg;
			}
			if (errmsg==""){ pas=true;}
			break;
		case "FLOAT":
			if (!IsFloat(value))
			{	errmsg = "必须输入数字!";
				break;
			}
			if (valstr!="")
			{	val = parseFloat(value);
				min = sp.Get("Min");max = sp.Get("Max");
				if ( min!=null && max!=null && (val<parseFloat(min) ||val>parseFloat(max) ) )
					errmsg = "数值需在"+min+"到"+max+"之间!";
				else if (min!=null && val<parseFloat(min))
					errmsg = "数值必需大于"+min+"!";
				else if (max!=null && val>parseFloat(max))
					errmsg = "数值必需小于"+max+"!";
			}
			if (errmsg==""){ pas=true;}
			break;
		
		case "FILE":
			if (valstr!="")
			{	val = GetFileSize(value);
				if (val>0)
				{	min = sp.Get("Min");max = sp.Get("Max");
					if ( min!=null && max!=null && (val<parseInt(min) ||val>parseInt(max) ) )
						errmsg = "文件尺寸需在"+min+"到"+max+"之间!";
					else if (min!=null && val<parseInt(min))
						errmsg = "文件尺寸必需大于"+min+"!";
					else if (max!=null && val>parseInt(max))
						errmsg = "文件尺寸必需小于"+max+"!";
				}
			}
			if (errmsg==""){ pas=true;}
			break;
		case "INT":
			if (!IsInt(value))
			{	errmsg = "必须输入整数！";
				break;
			}
			if (valstr!="")
			{	val = parseInt(value);
				min = sp.Get("Min");max = sp.Get("Max");
				if ( min!=null && max!=null && (val<parseInt(min) ||val>parseInt(max)))
				{	errmsg = "数值需在"+min+"到"+max+"之间！";
				}else if (min!=null && val<parseInt(min))
				{	errmsg = "数值必需大于"+min+"！";
				}else if (max!=null && val>parseInt(max))
				{	errmsg = "数值必需小于"+max+"！";
				}
			}
			if (errmsg==""){ pas=true;}
			break;

		case "DATE":
			fm = sp.Get("Format");
			if (fm==null)fm = "YYYY-MM-DD";
			if (!IsDate(value,fm))
			{	if(fm=="YYYY-MM-DD")
					errmsg = "必须输入正确的日期格式（"+fm+"）!\n      其中YYYY范围(1900-2100),MM范围(1-12),DD范围(1-31)。";
				else if(fm=="YY-MM-DD")
					errmsg = "必须输入正确的日期格式（"+fm+"）!\n      其中YY范围(00-29为2000-2029，30-99为1930-1999),MM范围(1-12),DD范围(1-31)。";
				
				break;
			}
			if (valstr!="")
			{	val = new Date(FormatDate(value,"MM-DD-YYYY"));//js必需用mmddyyyy格式
				min = sp.Get("Min");max = sp.Get("Max");
				//FormatDate Add By ZhouBin
				if ( min!=null && max!=null && (val-new Date(FormatDate(min,"MM-DD-YYYY"))<0 ||val-new Date(FormatDate(max,"MM-DD-YYYY"))>0 ) )
					errmsg = "范围需在"+min+"到"+max+"之间！";
				else if (min!=null && val-new Date(FormatDate(min,"MM-DD-YYYY"))<0)
					errmsg = "必需早于"+min+"！";
				else if (max!=null && val-new Date(FormatDate(max,"MM-DD-YYYY"))>0)
					errmsg = "必需晚于"+max+"！";
			}
			if (errmsg==""){ pas=true;}
			break;
		case "DATETIME":
			var minYear = sp.Get("MinYear");
			if(!minYear) minYear = 1900;
			var maxYear = sp.Get("MaxYear");
			if(!maxYear) maxYear = 2100;
			if(!IsDateTime(value,minYear,maxYear))
			{
				errmsg = "必须输入正确的日期时间格式(YYYY-MM-DD hh:mm)!\n            其中YYYY范围(" + minYear + "-" + maxYear + "),MM范围(1-12),DD范围(1-31),\n            hh范围(0-23),mm范围(0-59)。";
			}
			if (errmsg==""){ pas=true;}
			break;
		case "TIME":
		case "FULLTIME":
		case "SHORTTIME":
			if (valtype=="TIME"||valtype=="SHORTTIME")
			{

				if (!IsTime(value,false))
				{	errmsg = "必须输入正确的时间格式（HH:MM）!\n            其中HH范围(0-23),MM范围(0-59)。";
					break;
				}
			}	
			if (valtype == "FULLTIME")
				if (!IsTime(value,true))
					{	errmsg = "必须输入正确的时间格式（HH:MM:SS）!\n            其中HH范围(0-23),MM范围(0-59),SS范围(0-59)。";
						break;
					}
			if (valstr!="")
			{
				val = new Date("1-1-2000 "+value);//js必需用mmddyyyy格式
				min = sp.Get("Min");max = sp.Get("Max");
				if (min!=null)min = "1-1-2000 "+min;
				if (max!=null)max = "1-1-2000 "+max;
				if ( min!=null && max!=null && (val-new Date(min)<0 ||val-new Date(max)>0 ) )
					errmsg = "范围需在"+min+"到"+max+"之间！";
				else if (min!=null && val-new Date(min)<0)
					errmsg = "必需早于"+min+"！";
				else if (max!=null && val-new Date(max)>0)
					errmsg = "必需晚于"+max+"！";
			}
			if (errmsg==""){ pas=true;}
			break;
		case "IDNAME":
		case "PASSWORD":
			if (!IsIDName(value))
			{	errmsg = "必须由[A~Z,a~z,0~9,_]组成！";
				break;
			}
			if (value.length>50||value.length<4)
			{	errmsg = "长度必须在4到50之间！";
				break;
			}
			if (errmsg==""){ pas=true;}
		case "EMAIL":
			if (!IsEmail(value))
			{	errmsg = "必须是合法的E-mail格式（xx@xxx.xxx）！";
				break;
			}else{ pas=true;}		
			break;
		case "PHONE":
			if (!IsPhone(value))
				errmsg = "必须输入电话号码！";
			else
				pas=true;
			break;
	}
	}
	else
	{
		pas = true;
		errmsg = "";
	}
	this.Passed = pas;
	this.Message = errmsg;
}

/**<doc type="function" name="Global.FormatDate">
	<desc>格式化日期类型,貌视没用</desc>
</doc>**/
function FormatDate(value,Format)
{
	var aDate = value.split("-");
	var sDate = aDate[1] + "-" + aDate[2] + "-" + aDate[0];
	return sDate
}

/**<doc type="function" name="Global.FormatDate">
	<desc>格式化货币类型</desc>
</doc>**/
function FormatMoney( number)
{
	number=number+""; 
	var f1=parseFloat(parseFloat(number)-parseInt(number));
	var f2=f1+"";
	var f3=0;
	if(f1>0)
	{
		number=number.substr(0,number.indexOf('.'));
		if(parseInt(f2.substring(4,5))>4)
		{
			f3=parseFloat(f2.substring(0,4))+0.01;
		}
		else
		{
			f3=parseFloat(f2.substring(0,4));
		}
	}
	if(number=="null" || number=="")return "";
	var rtnval="",divlen=3;
	var l=number.length;
	var tmp=parseInt((l/divlen)+"");
	var part = (l%divlen==0)?tmp:tmp+1;
	for(var i=0;i<part;i++)
	{
		if(l-(i+1)*divlen<0)
		{	rtnval =","+number.substr(0,l%divlen)+rtnval;
			
		}
		else
		{	
			rtnval =","+number.substr(l-(i+1)*divlen,divlen)+rtnval;
		}
	}
	if(f1==0)
	{
	    return "￥"+rtnval.substring(1)+".00";
	}
	else
	{
		f3=parseInt(f3*100);
		return "￥"+rtnval.substring(1)+"."+f3;
	}
} 

//
//--------------------------------ValidateResult对象定义结束-------------------------------------
//

/**<doc type="objdefine" name="PopupWin">
	<desc>验证结论对象定义</desc>
	<property>
		<prop name="left" type="boolean">Popup页面位置</prop>
		<prop name="top" type="string">Popup页面位置</prop>
		<prop name="width" type="string">Popup页面宽</prop>
		<prop name="height" type="string">Popup页面高</prop>
		<prop name="relele" type="string">Popup页面的元素</prop>
	</property>		
</doc>**/
function PopupWin(left,top,width,height,relele)
{	this.curPopHeight = 0;
	this.popupWin = window.createPopup();
	this.popRelativeElement = relele;
	this.isDroping = false;
	this.dropSpeed = 20;
	this.popHeight = height;
	this.popWidth = width;
	this.popLeft = left;
	this.popTop = top;
}

/**<doc type="protofunc" name="PopupWin.GetDocument">
	<desc>获取Popup页面的document</desc>
</doc>**/
PopupWin.prototype.GetDocument = function()
{	return this.popupWin.document;
}

/**<doc type="protofunc" name="PopupWin.Show">
	<desc>显示Popup页面</desc>
</doc>**/
PopupWin.prototype.Show = function()
{	this.popupWin.show(this.popLeft,this.popTop,this.popWidth,this.popHeight,this.popRelativeElement);
}

/**<doc type="protofunc" name="PopupWin.Hide">
	<desc>隐藏Popup页面</desc>
</doc>**/
PopupWin.prototype.Hide = function()
{	this.popupWin.hide();
}

// 存储当前的Popup页面
var _curDropPopupWin =null;
/**<doc type="function" name="Global.DropPopupWin">
	<desc>显示Popup页面</desc>
	<input>
		<param name="pop" type="object">指定PopupWin对象</param>
	</input>
</doc>**/
function DropPopupWin(pop)
{	if (typeof(pop) != "undefined")
	{	_curDropPopupWin = pop;
		_curDropPopupWin.curPopHeight = 0;
		_curDropPopupWin.isDroping = true;
		window.setTimeout(DropPopupWin,25);
		return;
	}
	var curpop = _curDropPopupWin;
	curpop.curPopHeight += curpop.dropSpeed;
	if (curpop.curPopHeight > curpop.popHeight)
	{	curpop.popupWin.show(curpop.popLeft,curpop.popTop,curpop.popWidth,curpop.popHeight,curpop.popRelativeElement);
		curpop.isDroping = false;
	}
	else
	{	curpop.popupWin.show(curpop.popLeft,curpop.popTop,curpop.popWidth,curpop.curPopHeight,curpop.popRelativeElement);
		window.setTimeout(DropPopupWin,25);
	}	
}
	
//
//--------------------------------全局对象对象实例定义开始---------------------------------------------------
//




//
//---------------------------------内嵌代码开始--------------------------------------------------------------
//
/**<doc type="inline" name="Global.SetErrorHandle">
	<desc>设置错误处理函数</desc>
</doc>**/
//window.onerror = OnError;
window.onresize = function(){try{document.body.focus();}catch(e){}};

/**<doc type="objdefine" name="CallBack">
	<desc>回调对象</desc>
	<input>
		<param name="name" type="string">对象名</param>
		<param name="fromobj" type="object">对象源</param>
		<param name="callback" type="object">Function对象</param>
		<param name="timeout" type="number">触发延迟时间</param>
	</input>	
</doc>**/
var Attachs={};
function CallBack(name,fromobj,callback,timeout)
{	this.Name = name;
	this.FromObject = fromobj;
	this.CallBack=callback;
	this.Timeout=timeout;
	this.TimeoutHandle=-1;
}

/**<doc type="protofunc" name="CallBack.Exec">
	<desc>执行回调对象,并从对列中去掉此对象</desc>
</doc>**/
CallBack.prototype.Exec=function()
{	var rtn=Attachs[this.Name].CallBack(Attachs[this.Name].FromObject);
	if(rtn == false)return;
	Attachs[this.Name]=null;
	delete(Attachs[this.Name]);
}

/**<doc type="protofunc" name="CallBack.ClearTimeout">
	<desc>清除本对象TimeoutHandle</desc>
</doc>**/
CallBack.prototype.ClearTimeout=function()
{	window.clearTimeout(this.TimeoutHandle);
	this.TimeoutHandle=-1;
}

/**<doc type="protofunc" name="CallBack.SetTimeout">
	<desc>设置时间延迟</desc>
	<input>
		<param name="time" type="number">时间延迟数</param>
	</input>
</doc>**/
CallBack.prototype.SetTimeout=function(time)
{	if(!time)time=100;
	this.TimeoutHandle=window.setTimeout("Attachs['"+this.Name+"'].Exec();",time);
}


/**<doc type="function" name="Global.DoBodyMouseDown">
	<desc>执行document.body的onmousedown方法，并解除回调绑定</desc>
</doc>**/
function DoBodyMouseDown()
{	
	for(var name in Attachs)
	{	if(Attachs[name])Attachs[name].Exec();
	}
}

/**<doc type="function" name="Global.AttachBodyMouseDown">
	<desc>将指定方法贴到document.body的onmousedown方法上</desc>
	<input>
		<param name="name" type="string">回调对象名</param>
		<param name="fromobj" type="object">源对象</param>
		<param name="callback" type="function">回调方法</param>
		<param name="timeout" type="number">时间延迟数</param>
	</input>
</doc>**/
function AttachBodyMouseDown(name,fromobj,callback,timeout)
{	if(!document.body.onmousedown)	
		document.body.onmousedown=DoBodyMouseDown;
	if(Attachs[name])
		delete(Attachs[name]);
	if(!timeout)timeout=false;
	Attachs[name]=new CallBack(name,fromobj,callback,timeout);
	
}
//
//---------------------------------内嵌代码结束--------------------------------------------------------------
//


function correctPNG()
{
	for(var i=0; i<document.images.length; i++)
    {
		var img = document.images[i]
		var imgName = img.src.toUpperCase()
		if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
    	{
			var imgID = (img.id) ? "id='" + img.id + "' " : ""
			var imgClass = (img.className) ? "class='" + img.className + "' " : ""
			var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' "
			var imgStyle = "display:inline-block;" + img.style.cssText
			if (img.align == "left") imgStyle = "float:left;" + imgStyle
			if (img.align == "right") imgStyle = "float:right;" + imgStyle
			if (img.parentElement.href) imgStyle = "cursor:hand;" + imgStyle  
			var strNewHTML = "<span " + imgID + imgClass + imgTitle
				+ " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
    			+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
				+ "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>"
			img.outerHTML = strNewHTML
			i = i-1
    	}
    }
}
window.attachEvent("onload", correctPNG);


//
//-----------------------------------------Waiting Box-------------------------------------------------------
//

/**<doc type="func" name="WaittingCall">
	<desc>显示等待框</desc>
	<input>
		<param name="msg" type="string">等待显示文字</param>
		<param name="process" type="func/number">进度显示(func:进度百分比提供函数,函数必须返回0-1的数字,当函数返回1时隐藏等待框;number:等待框显示的时间单位为秒)</param>
	</input>
</doc>**/
function ShowWaitting(msg,process)
{
    var win = ShowWaitting.HideTop?window.top:window;
    var width =win.document.body.offsetWidth
    var height=win.document.body.offsetHeight;
    if(typeof(msg)=="undefined")
        msg="正在执行操作请求，请稍等...";
    else
        msg+="";
          
    if(typeof(process)=="undefined")
        process="";
    else
        process+="";
    var frmWait = win.document.all("__Waitting");
    if(!frmWait)
    {
        frmWait = win.document.createElement("<iframe id=__Waitting style='filter:alpha(opacity=50);position:absolute;display:none;left:0px;top:0px;width:"+width+"px;height:"+height+"px;' class='WaitingBox' src='/share/page/Waiting.htm?Message="+escape(msg)+"&Process="+process+"' frameborder='0' scrolling='no'>");
        win.document.body.appendChild(frmWait);
    }
    else
    {
        frmWait.contentWindow.document.all("Message").innerHTML=msg;
        frmWait.contentWindow.SetProcess(process);
    }
    //frmWait.style.left = (document.body.offsetWidth-BW)/2;
    //var h=(document.body.offsetHeight-BH)/2;
    //if(h<0)h=0;
    //frmWait.style.top = h;
    frmWait.style.display="";
    return frmWait;
}


/**<doc type="func" name="WaittingCall">
	<desc>隐藏等待框</desc>
</doc>**/
function HideWaitting()
{
	var win = ShowWaitting.HideTop?window.top:window;
    var frmWait = win.document.all("__Waitting");
    if(!frmWait)return;
    frmWait.style.display="none";
    frmWait.parentNode.removeChild(frmWait);
}

/**<doc type="function" name="WaittingCall">
	<desc>显示等待框</desc>
	<input>
		<param name="msg" type="string">等待显示文字</param>
		<param name="processProvider" type="func/number">进度显示(func:进度百分比提供函数,函数必须返回0-1的数字,当函数返回1时隐藏等待框;number:等待框显示的时间单位为秒)</param>
		<param name="execFunc" type="func">等待其间执行的函数(可选)</param>
		<param name="callback" type="func">等待结束时执行的函数(可选)</param>
	</input>
</doc>**/
function WaittingCall(msg,processProvider,execFunc,callback)
{
	WaittingCall.Overfunc = callback;
	if(typeof processProvider == "function")
	{
		var caller = new JcCaller(WaittingCall.WaittingProcess,100,processProvider);
		WaittingCall.RegistCaller(caller);
	}
	else if(typeof processProvider == "number")
	{
		ShowWaitting(msg);
		window.setTimeout("WaittingCall.OverCall()",processProvider * 1000);
	}
	if(execFunc && typeof execFunc == "function")
		window.setTimeout(execFunc,100);
}

WaittingCall.RegistCaller = function(caller)
{
	WaittingCall.Caller = caller;
	WaittingCall.Caller.execInterval();
}

WaittingCall.ClearCaller = function()
{
	WaittingCall.Caller.clearInterval();
	WaittingCall.Caller = null;
}

WaittingCall.OverCall = function()
{
	HideWaitting();
	if(WaittingCall.Overfunc && typeof WaittingCall.Overfunc == "function")
		WaittingCall.Overfunc();
}

WaittingCall.WaittingProcess = function(msg,processProvider)
{
	var process = processProvider();
	if(process <= 1)
	{
		ShowWaitting(msg,process);
	}
	else
	{
		WaittingCall.ClearCaller();
		WaittingCall.OverCall();
	}
}
//
//-----------------------------------------------------------------------------------------------------------
//

/**<doc type="function" name="Global.HTMLToExcel">
	<desc>
	created by tyaloo
	for:export dom element to word
	create date:2007-11-18
	将指定JcTable导入World并格式化
	</desc>
	<input>
		<param name="ele" type="object">指定JcTable元素</param>
	</input>
</doc>**/
function HTMLToWordForJcTable(ele)
{
    var controlRange= document.body.createControlRange();
    controlRange.add(ele);
    var  seletorAll=ele.all("selector");
    controlRange.select();
    document.execCommand("Copy");
    var wrd = new ActiveXObject("Word.Application");
    wrd.visible = true;
    var seleDoc= wrd.Documents.Add(); 
    wrd.ActiveDocument.Range().Paste();
    var nowTb= wrd.ActiveDocument.Tables.Item(1);
    if(seletorAll)
    nowTb.Columns(1).Delete();
    seletorAll=null;
    var tableBorderColor=new String();
    tableBorderColor=ele.firstChild.borderColor; 
    tableBorderColor=tableBorderColor.toLowerCase();
    if(tableBorderColor=="#ffffff"||tableBorderColor=="#fff"||tableBorderColor=="white")
    {
		with(nowTb.Borders)
		{
			OutsideLineStyle=1;
			OutsideColor=0;
			InsideLineStyle=1;
			InsideColor=0;
		}
    }
    document.selection.empty();
}

/**<doc type="function" name="Global.HTMLToExcel">
	<desc>将整个文档导入Word</desc>
</doc>**/
function AllAreaWord()
{
	var oWD = new ActiveXObject("Word.Application");
	var oDC = oWD.Documents.Add("",0,1);
	var oRange =oDC.Range(0,1);
	var sel = document.body.createTextRange();
	//sel.moveToElementText(PrintA);
	sel.select();
	sel.execCommand("Copy");
	oRange.Paste();
	oWD.Application.Visible = true;
	//window.close();
}

/**<doc type="function" name="Global.HTMLToExcel">
	<desc>将指定table导入Excel</desc>
	<input>
		<param name="ele" type="object">指定元素</param>
	</input>
</doc>**/
function TableToExcel(ele)
{
    var controlRange= document.body.createControlRange();
    controlRange.add(ele);
    controlRange.select();
    document.execCommand("Copy");
    var xls  = new ActiveXObject( "Excel.Application" );
    xls.visible = true;
    var xlBook=xls.Workbooks.Add;
    xls.DisplayAlerts=false;
    var activeSheet=xls.ActiveSheet;
    activeSheet.Paste();
    document.selection.empty();
}

/**<doc type="function" name="Global.HTMLToExcel">
	<desc>将指定元素导入Excel并格式化</desc>
	<input>
		<param name="ele" type="object">指定元素</param>
		<param name="changeStyle" type="bool">是否处理第一行</param>
	</input>
</doc>**/
function HTMLToExcel(ele,changeStyle)
{
	var controlRange= document.body.createTextRange();
	controlRange.moveToElementText(ele);
	controlRange.select();
	document.execCommand("Copy");
	var xls  = new ActiveXObject( "Excel.Application" );
	xls.visible = true;
	var xlBook=xls.Workbooks.Add;
	xls.DisplayAlerts=false;
	var activeSheet=xls.ActiveSheet;
	activeSheet.Paste();
	var titleRow= ele.firstChild.rows(0);
	var titleCells=titleRow.cells;
	var titleCellsCount=titleCells.length;
	//jnp edit
	if(changeStyle&&(typeof(activeSheet.Cells(1,2))=="undefined"||typeof(activeSheet.Cells(1,2).value)=="undefined"))
	{
		activeSheet.Rows("1:1").Delete();
	}
	for(var i=0;i<titleCellsCount;i++)
	{
		var seleCell=titleCells[i];
		var cellWidth=parseInt(seleCell.offsetWidth);
			
		var nowCharCode=i+65;
		var times=0;
		if(nowCharCode>90)
		{
			times =Math.ceil(nowCharCode/65);
			nowCharCode =nowCharCode -26;
		}   
		var columIndex=String.fromCharCode(nowCharCode);
		if(times>0)
		{
			columIndex =String.fromCharCode(63+times)+columIndex;
		}
		
		var columPath=columIndex+":"+columIndex;
		if(!isNaN(cellWidth))
		{
				cellWidth =cellWidth/10;
				activeSheet.Columns(columPath).ColumnWidth = cellWidth;
		}
		if(changeStyle)
		{
				activeSheet.Columns(columPath).Font.ColorIndex=0;
				activeSheet.Columns(columPath).Font.Underline=-4142;
				activeSheet.Columns(columPath).Interior.ColorIndex=-4142;
				activeSheet.Columns(columPath).NumberFormatLocal = "@";
		}
	}
	//画边缘
	for(var i=7;i<=12;i++)
	{
		xls.Selection.Borders(i).LineStyle = 1;
		xls.Selection.Borders(i).Weight = 2;
		xls.Selection.Borders(i).ColorIndex = -4105;
    }
	document.selection.empty();
	celex=null;
}
/**<doc type="function" name="Global.HTMLToExcel">
	<desc>调整jctable高度使满屏</desc>
	<input>
		<param name="jctableId" type="string">jctable控件Id名</param>
	</input>
</doc>**/
function AdjustJcTableHeight(jctableId)
{
	var height=0;
	for(var i=0;i<document.body.childNodes.length;i++)
	{
		if(document.body.childNodes(i).tagName!="!")
			height += document.body.childNodes(i).offsetHeight;
	}
	document.getElementById(jctableId).childNodes(0).style.height = document.getElementById(jctableId).offsetHeight+(document.body.offsetHeight-height)-40;
}

/**<doc type="function" name="Global.HTMLToExcel">
	<desc>
	create by tyaloo
	reason:create mask layer
	create date:2007-11-10
	创建蒙版,一般在等待或防止用户操作时使用
	</desc>
	<input>
		<param name="zIndex" type="number">蒙版层zIndex</param>
	</input>
</doc>**/
function CreateMaskLayer(zIndex)
{
   var maskLayer=document.createElement("div");
   maskLayer.id="maskLayer";
   maskLayer.className="maskLayer";
   maskLayer.style.display="none";
   maskLayer.style.position="absolute";
   maskLayer.style.top="0";
   maskLayer.style.left="0";
   maskLayer.style.width="100%";
   maskLayer.style.height="100%";
   if(zIndex!=null)
     maskLayer.style.zIndex=zIndex;
   else
      maskLayer.style.zIndex="101";  
    
     document.body.appendChild(maskLayer);
 
  return maskLayer;
}	

var PageTopCorrectValue=0;

/**<doc type="function" name="Global.ApplyElementPositionToElement">
	<desc>
	create by tyaloo START
	将指定元素的位置应用于另一属性
	</desc>
	<input>
		<param name="aEle" type="object">参考元素</param>
		<param name="bEle" type="object">被应用元素</param>
	</input>
</doc>**/
function ApplyElementPositionToElement(aEle,bEle)
{
  var newLeft = aEle.scrollLeft+aEle.offsetLeft;

  var newTop = aEle.scrollTop+aEle.offsetTop+aEle.scrollHeight-PageTopCorrectValue;
  
	while(aEle = aEle.offsetParent)
	{
		newLeft += aEle.offsetLeft;
		newTop += aEle.offsetTop;
	}
	
	bEle.style.top = newTop;
	bEle.style.left = newLeft;
}

//document.write("<SCRIPT src='/portal/BlockImages/prototype.js' type='text/javascript'></SCRIPT>");

 var kbActions = {
        13 : "enter",
	    37 :"left",
		38 : "up",
		39 : "right",
		40 : "down",
		33 : "pageUp",
		34 : "pageDown",
		36 : "home",
		35 : "end"	};
		
		
var AutoCompleteModel=new Object();

AutoCompleteModel.BasicSelectMan = {
                                TableName:"BEOFFICEAUTO_DEVELOPER.HrEmployee",
                                FieldNames:"EmployeeNO,Name", 
                                FieldMatch:"Name",
                                FieldWidths:"30,80",
                                FieldTitles:"工号,姓名"};
AutoCompleteModel.BasicSelectProject = {
                                TableName:"BEPROJECT_DEVELOPER.PrjBasicInfo",
                                FieldNames:"Code,Name,ManagerName", 
                                FieldMatch:"Name",
                                FieldWidths:"20,60,20",
                                FieldTitles:"编号,名称,项目经理"};
 AutoCompleteModel.BasicSelectMajor = {
                                TableName:"BEPROJECT_DEVELOPER.MajorAndDeptMap",
                                FieldNames:"MajorKey,MajorName", 
                                FieldMatch:"MajorName",
                                FieldWidths:"30,70",
                                FieldTitles:"简码,名称"}; 
  AutoCompleteModel.BasicSelectCustomer = {
                                TableName:"BEMARKET_DEVELOPER.Market_Customer",
                                FieldNames:"Code,SimpleName", 
                                FieldMatch:"Code",
                                FieldWidths:"30,70",
                                FieldTitles:"编号,名称"};       

  AutoCompleteModel.BasicSelectDept = {
                                TableName:"BEADMIN_DEVELOPER.VW_DEPTLEARLIST",
                                FieldNames:"Dept", 
                                FieldMatch:"Dept",
                                FieldWidths:"100",
                                FieldTitles:""};                                                             

   function AsynExecuteDemo(url,action,xmlsrcId,maskLayerId,method){
	var acturl = url+"";
	var data = _GetSubmitDs(arguments,5);
	var hrf =  document.createElement("<A href='"+url+"'>");//URL格式化
	var tg = "DataStore";
	document.appendChild(hrf);
	acturl= hrf.href;
	if(url=="#")
	{	acturl=acturl.replace("#","");
		var pos=acturl.indexOf("?");
		if(pos>0)acturl=acturl.substr(0,pos);
	}
	
	var realUrl=acturl;
	
	acturl =  "IsExec=True&RequestAction=" + action;
	
	var _data = "";
	var execdata="";
	if(typeof(data)=="object")
		_data = data.ToString(); 
	else if(typeof(data)=="string")
		_data = data;
	if(!isBase64Encode)
	{
		execdata = _data.replace(/\xB7/g,"%B7");//由于服务器端Request处理中点，解码时会变成问号
		execdata = escape(_data).replace(/\+/g,"%2B")//由于服务器端Request处理"+"解码时会变成空格
	}
	else
	{
		tg="DataStoreBase64";
		execdata = _Encode64(_data);
	}
	
	var queryParameters = acturl+"&"+tg+"="+escape(execdata);

	  document.all(maskLayerId).style.display = "";
	var myAjax = new Ajax.Request(
		realUrl,
		{method:'post',
		parameters:queryParameters,
			onComplete: function(resp)
				{
					//var  rtn =new ExecResult(resp.responseText,url,"GetPrjDesignTask",null,"post");
				
	                //PageDoc.all("Rds").XMLDocument.loadXml(resp.responseText);
                    if(xmlsrcId!="##")
                    {
                      PageDoc.all(xmlsrcId).XMLDocument.loadXML(resp.responseText); 
                      method();
                    }
                    else
                    {
                      var  rtn =new ExecResult(resp.responseText,url,action,null,"post");
                      
                      method(rtn);
                    }
	                  document.all(maskLayerId).style.display = "none";
	                //alert(PageDoc.all("Rds").XMLDocument.xml);				
				},
			onSuccess:function(){
			
			}
		}
		);
}	  

 
  //end by tyaloo 


//Link Method For MiniProject Market
function LinkToView(type)
{
	if(arguments.length <= 1) return;
	if(Co[arguments[1]].GetValue() == "") return;
	var linkurl = "";
	var linktype = "_blank_" + type;
	var linkstyle = "";
	switch(type.toLowerCase())
	{
		case "project":
			linkurl = "/Market/MarketProject/ProjectManageEdit.aspx?FuncType=View&Id=" + Co[arguments[1]].GetValue();
			linkstyle = "width=650,height=350";
			break;
		case "item":
			linkurl = "/Market/MarketItem/ItemManageEdit.aspx?FuncType=View&Id=" + Co[arguments[1]].GetValue();
			linkstyle = "width=650,height=620";
			break;
		case "contact":
			linkurl = "/Market/MarketContract/ContractManageEdit.aspx?FuncType=View&Id=" + Co[arguments[1]].GetValue() + "&ProjectId=" + Co[arguments[2]].GetValue();
			linkstyle = "width=650,height=700";
			break;
		case "customer":
			linkurl = "/Market/CRM/CustomerEdit.aspx?FuncType=View&Id=" + Co[arguments[1]].GetValue();
			linkstyle = "width=830,height=610";
			break;
		case "supply":
			linkurl = "/Market/MarketSupply/MarketSupplyInfoEdit.aspx?FuncType=View&Id=" + Co[arguments[1]].GetValue();
			linkstyle = "width=700,height=520";
			break;
		default:
			return;
	}
	LinkTo(linkurl,linktype,CenterWin(linkstyle));
}



	function MenuDisplayHidden()
	{
		if(document.all("QueryArea").style.display=='none')
		{	
			document.all("QueryArea").style.display ='';
			 
			imgTrace.src='/portal/BlockImages/MenuTpl/gray/Up.gif';
		}
		else
		{	
			document.all("QueryArea").style.display ='none';
			 
			imgTrace.src='/portal/BlockImages/MenuTpl/gray/Down.gif';
		}
		/*if(parent.document.all("WorkArea"))
		{
			if(parent.document.all("WorkArea").contentWindow.AdjustHeight)
			{
			    parent.document.all("WorkArea").contentWindow.AdjustHeight();
			}
		}*/
	}








