
//
//---------------------------------ȫ�ֱ������忪ʼ--------------------------------------------------------------
//

/**<doc type="varible" name="Global.PassCode">
	<desc>�û��ڵ�¼ϵͳʱ��õ�PassCode</desc>
</doc>**/
var PassCode = "";

/**<doc type="varible" name="Global.PassCode">
	<desc>ҳ���Ψһ��ֵ</desc>
</doc>**/
var PageKey = "";

/**<doc type="varible" name="Global.AppServer">
	<desc>Ӧ�÷�������Ӧ������HTTP��ַ</desc>
</doc>**/
var AppServer = {"Center":"http://localhost","Doc":"http://DocServer"};

/**<doc type="varible" name="Global.DebugState">
	<desc>�Ƿ�Ҫ�򿪵��Կ���</desc>
</doc>**/
var DebugState=true;

/**<doc type="varible" name="Global.DebugState">
	<desc>�Ƿ�Ҫ�򿪵��Կ���</desc>
</doc>**/
var DebugMethod="TextTrace";

/**<doc type="varible" name="Global.ErrorBgColor">
	<desc>���ֶ�У������ı�����ɫ</desc>
</doc>**/
var ErrorBgColor="#FF4500";

/**<doc type="varible" name="Global.DisabledBgColor">
	<desc>���ֶβ��ɿ��Ƶı�����ɫ</desc>
</doc>**/
var DisabledBgColor="#FFFFFF";

/**<doc type="varible" name="Global.ReadonlyBgColor">
	<desc>���ֶ�ֻ���ı�����ɫ</desc>
</doc>**/
var ReadonlyBgColor="#FFFFFF";

/**<doc type="varible" name="Global.NormalBgColor">
	<desc>���ֶ�ֻ���ı�����ɫ</desc>
</doc>**/
var NormalBgColor="#FFFFFF";

/**<doc type="varible" name="Global.NotEmptyBgColor">
	<desc>��������ı��ֶεı�����ɫ</desc>
</doc>**/
var MustInputBgColor="#F0E68C";

/**<doc type="varible" name="Global.BeautyXmlString">
	<desc>��ʽ��XML�ַ�������������BeautyXml����</desc>
</doc>**/
var BeautyXmlString="";


/**<doc type="varible" name="Global.DateAdjust">
	<desc>�Ե�ǰ����ʱ��ĵ�������Ҫ����ͬ���ͻ��˺ͷ������˵�����,��λ����</desc>
</doc>**/
var DateAdjust=0;

var UiStylePath="/share";

/**<doc type="varible" name="Global.PageDoc">
	<desc>ָ��ҳ����ĵ����󣬵�ʹ��DataStore����Ԫ�س�ʼ��ʱ������ͨ���ı�˱���ָ������ҳ����ĵ�����</desc>
</doc>**/
var PageDoc=document;

//
//---------------------------------ȫ�ֱ����������--------------------------------------------------------------
//





//
//---------------------------------ϵͳ������ǿ��ʼ--------------------------------------------------------------
//
/**<doc type="classext" name="Array.Find">
	<desc>����������ָ��ֵλ��</desc>
	<output>����������ָ��ֵλ�ã�û���򷵻�-1</output>
</doc>**/
Array.prototype.Find=function(value)
{	for(var i=0;i<this.length;i++)
		if(this[i]==value)return i;
	return -1;
}

/**<doc type="classext" name="String.fromZipBase64">
	<desc>��ѹ������base64���뻹ԭ</desc>
	<output>���ػ�ԭ���ַ���</output>
</doc>**/
String.prototype.fromZipBase64=function()
{	return str;
}

/**<doc type="classext" name="String.fromBase64">
	<desc>��base64���뻹ԭ</desc>
	<output>���ػ�ԭ���ַ���</output>
</doc>**/
String.prototype.fromBase64=function()
{	return str;
}

/**<doc type="classext" name="String.toZipBase64">
	<desc>�����ַ���ѹ����base64����</desc>
	<output>ѹ���������ַ���</output>
</doc>**/
String.prototype.toZipBase64=function()
{	return str;
}

/**<doc type="classext" name="String.toBase64">
	<desc>�����ַ���base64����</desc>
	<output>�������ַ���</output>
</doc>**/
String.prototype.toBase64=function()
{	return str;
}

/**<doc type="classext" name="String.fromNull">
	<desc>�ַ�������</desc>
	<output>���Ϊnull��null�������ؿգ����򷵻�ԭ�ַ���</output>
</doc>**/
String.prototype.filterNull=function()
{	if(this.toLowerCase()=="null")return "";
	return "" + this;
}

/**<doc type="protofunc" name="String.trim">
	<desc>�ַ����������޼�������չ</desc>
	<output>����ȥ��ǰ��ո���ַ���</output>
</doc>**/
String.prototype.trim = function()
{   return this.replace(/(^\s*)|(\s*$)/g, "");
}


/**<doc type="protofunc" name="String.bytelen">
	<desc>�����ֽڳ��ȣ������ַ�����Ϊ2��Ӣ�ĳ���Ϊ1</desc>
	<output>�����ֽڳ���</output>
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
	<desc>�滻ָ���ַ���</desc>
	<output>�����滻����ַ���</output>
</doc>**/
String.prototype.replaceAll = function(search, replace){
     var tmp=str=this;
     do { str = tmp;
        tmp = str.replace(search, replace);
     }while (str != tmp);
     return str;
}

/**<doc type="classext" name="Date.create">
	<desc>��ָ����ʽ���ַ���ת��Ϊ���ڶ���</desc>
	<input>
		<param name="str" type="string">�����ַ���,��ʽΪ��yyyy-mm-dd hh:mm:ss��</param>
	</input>
	<output>�������ڶ���</output>
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
	<desc>ȡ�õ�ǰ���ڵ��ַ�����yyyy-mm-dd��</desc>
	<output>���������ַ���</output>
</doc>**/
//�ϴ��������������JScript�Ĺ���Date���͵ķ���������ԭ��������˼Ϊȡ�õ�ǰ���ڵġ��ա����ش�ע��
//Date.getDate=function()
//{
//}
/**<doc type="classext" name="Date.getTime">
	<desc>ȡ�õ�ǰ���ڵ��ַ�����hh:mm:ss��</desc>
	<output>���������ַ���</output>
</doc>**/
Date.getTime=function()
{
	var dt = new Date();
	return dt.getTimePart();
}
/**<doc type="classext" name="Date.getFullDate">
	<desc>ȡ�õ�ǰ���ڵ��ַ�����yyyy-mm-dd hh:mm:ss��</desc>
	<output>���������ַ���</output>
</doc>**/
Date.prototype.getFullDate=function()
{
	return this.getDatePart() + " " + this.getTimePart();
}
/**<doc type="classext" name="Date.differ">
	<desc>ȡ���������ڵĲ�ֵ</desc>
	<input>
		<param name="dfrom" type="date">��ʼ����</param>
		<param name="dto" type="date">��������</param>
		<param name="type" type="enum">��ֵ����</param>
	</input>
	<output type="number">���ز�ֵ</output>
	<enum name="type">
		<item text="s">��</item>
		<item text="n">��</item>
		<item text="h">Сʱ</item>
		<item text="d">��</item>
		<item text="w">��</item>
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
	<desc>ȡ��ʱ����ַ����� hh:mm:ss��</desc>
	<output>����ʱ���ַ���</output>
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
	<desc>ȡ�õ�ǰ���ڵ��ַ�����yyyy-mm-dd��</desc>
	<output>���������ַ���</output>
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
	<desc>����ǰʱ����ϲ�ֵ�������ڶ���</desc>
	<input>
		<param name="type" type="enum">��ֵ����</param>
		<param name="delta" type="integer">��ֵ</param>
	</input>
	<enum name="type">
		<item text="s">��</item>
		<item text="m">��</item>
		<item text="h">Сʱ</item>
		<item text="d">��</item>
		<item text="w">��</item>
		<item text="m">��</item>
		<item text="y">��</item>
	</enum>
</doc>**/
Date.prototype.add=function(type,delta)
{
	return this.DateAdd(type, delta);
}
/**<doc type="classext" name="Date.DateAdd">
	<desc>����ǰʱ����ϲ�ֵ�������ڶ���</desc>
	<input>
		<param name="strInterval" type="enum">��ֵ����</param>
		<param name="Number" type="integer">��ֵ</param>
	</input>
	<enum name="strInterval">
		<item text="s">��</item>
		<item text="m">��</item>
		<item text="h">Сʱ</item>
		<item text="d">��</item>
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
	<desc>��õ�ǰ������ָ����������Ŀ�ʼ���ڶ���</desc>
	<input>
		<param name="type" type="enum">��������</param>
	</input>
	<enum name="type">
		<item text="h">Сʱ</item>
		<item text="d">��</item>
		<item text="w">��</item>
		<item text="m">��</item>
		<item text="y">��</item>
	</enum>
	<output>���ؿ�ʼ���ڶ���</output>
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
	<desc>��õ�ǰ������ָ����������Ľ������ڶ���</desc>
	<input>
		<param name="type" type="enum">��������</param>
	</input>
	<enum name="type">
		<item text="h">Сʱ</item>
		<item text="d">��</item>
		<item text="w">��</item>
		<item text="m">��</item>
		<item text="y">��</item>
	</enum>
	<output>���ؽ������ڶ���</output>
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
	<desc>������������ʱ����ʼ����ֵ</desc>
	<input>
		<param name="fromId" type="date">��ʼʱ��ؼ�Id</param>
		<param name="toId" type="date">����ʱ��ؼ�Id</param>
		<param name="type" type="enum">��ֵ����</param>
	</input>
	<output type="number">���ز�ֵ</output>
	<enum name="type">
		<item text="h">Сʱ</item>
		<item text="d">��</item>
		<item text="w">��</item>
		<item text="m">��</item>
		<item text="y">��</item>
	</enum>
</doc>**/
function SetFormToDate(fromId,toId,type)
{
	var date = new Date();
	Co[fromId].SetValue(date.getFrom(type).getDatePart());
	Co[toId].SetValue(date.getTo(type).getDatePart());
}	

	
//
//---------------------------------ϵͳ������ǿ����--------------------------------------------------------------
//


//
//--------------------------------DataStore ��ض����忪ʼ---------------------------------------------------
//

//
//--------------------------------DataItem �����忪ʼ--------------------------------------------------------
//

/**<doc type="objdefine" name="DataItem">
	<desc>DataItem����</desc>
	<input>
		<param name="doc" type="object">����DataItem��XML�ĵ�</param>
		<param name="ele" type="object">����DataItem��XMLԪ��/param>
	</input>	
	<property>
		<prop name="XmlDoc" type="object">DataItem��Ӧ��XML�ĵ�</param>
		<prop name="XmlEle" type="object">
		˵����DataItem��Ӧ��XMLԪ��
		�洢��ʽ��
		</param>
		<prop name="Type" type="string">DataItem��Ӧ������</param>
	</property>		
</doc>**/
function DataItem(doc,ele)
{	this.XmlDoc=null;
	this.XmlEle=null;
	if(doc)this.XmlDoc=doc;
	if(ele)this.XmlEle=ele;
}

/**<doc type="protofunc" name="DataItem.GetAttr">
	<desc>ȡ��DataItem��ĳ������ֵ</desc>
	<input>
		<param name="index" type="object">���index������Ϊnumber,���ȡ��index�����Ե�����ֵ;���index������Ϊstring,���ȡ������Ϊindex������ֵ</param>
	</input>
	<output type="string">��Ӧ������ֵ</output>
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
		//Memo:����Oracle
		//2006.2.24
		//if(!value)
		//	value=this.XmlEle.getAttribute("\"" + index + "\"");
		//End Modify By Sky
		if(value)value.filterNull();
	}
	return value;
}

/**<doc type="protofunc" name="DataItem.SetAttr">
	<desc>����DataItem��ĳ������ֵ</desc>
	<input>
		<param name="index" type="object">���index������Ϊnumber,�����õ�index�����Ե�����ֵ;���index������Ϊstring,������������Ϊindex������ֵ</param>
		<param name="value" type="string">���õ�����ֵ</param>
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
	<desc>ɾ��DataItem��ĳ������ֵ</desc>
	<input>
		<param name="index" type="object">���index������Ϊnumber,��ɾ����index�����Ե�����ֵ;���index������Ϊstring,��ɾ��������Ϊindex������ֵ</param>
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
	<desc>ȡ��DataItem��ĳ����������</desc>
	<input>
		<param name="index" type="number">�����Զ�Ӧ�������������</param>
	</input>
	<output type="string">��Ӧ����������</output>
</doc>**/
DataItem.prototype.GetAttrName=function(index)
{	return this.XmlEle.attributes.item(index).nodeName;
}

/**<doc type="protofunc" name="DataItem.GetAttrCount">
	<desc>ȡ��DataItem�����Ը���</desc>
	<output type="string">���Ը���</output>
</doc>**/
DataItem.prototype.GetAttrCount=function()
{	return this.XmlEle.attributes.length;
}

/**<doc type="protofunc" name="DataItem.GetName">
	<desc>ȡ��DataItem��Ԫ������</desc>
	<output type="string">��Ӧ��Ԫ������</output>
</doc>**/
DataItem.prototype.GetName=function()
{	return this.XmlEle.nodeName;
}

/**<doc type="protofunc" name="DataItem.GetValue">
	<desc>ȡ��DataItem��Ԫ��ֵ</desc>
	<output type="string">��Ӧ��Ԫ��ֵ</output>
</doc>**/
DataItem.prototype.GetValue=function()
{	return this.XmlEle.text.filterNull();
}

/**<doc type="protofunc" name="DataItem.SetValue">
	<desc>����DataItem��Ԫ��ֵ</desc>
	<input>
		<param name="value" type="string">���õ�ֵ</param>
	</input>
</doc>**/
DataItem.prototype.SetValue=function(value)
{	this.XmlEle.text = value;
}

/**<doc type="protofunc" name="DataItem.GetXmlValue">
	<desc>ȡ��DataItem��Ԫ���ڵ�XML</desc>
	<output type="string">Ԫ���ڵ�XML</output>
</doc>**/
DataItem.prototype.GetXmlValue=function()
{	if(this.XmlEle.childNodes.length>0)
		return this.XmlEle.childNodes[0].xml;
	else
		return "";
}

/**<doc type="protofunc" name="DataItem.SetXmlValue">
	<desc>����DataItem��Ԫ���ڵ�XML</desc>
	<input>
		<param name="value" type="string">���õ�XML</param>
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
	<desc>ȡ��DataItem��Ԫ���ڵ�XML���</desc>
	<output type="string">Ԫ���ڵ�XML���</output>
</doc>**/
DataItem.prototype.GetSubXmlNode=function()
{	if(this.XmlEle.childNodes.length>0)
		return this.XmlEle.childNodes[0];
}

/**<doc type="protofunc" name="DataItem.GetDataStore">
	<desc>ȡ��DataItemԪ�صĸ�DataStore</desc>
	<output type="DataStore">��DataStore</output>
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
	<desc>ȡ��DataItem��Ԫ���ڵ�DataForm</desc>
	<output type="DataForm">Ԫ���ڵ�DataForm</output>
</doc>**/
DataItem.prototype.GetSubDataForm=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataForm(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataList">
	<desc>ȡ��DataItem��Ԫ���ڵ�DataList</desc>
	<output type="DataList">Ԫ���ڵ�DataList</output>
</doc>**/
DataItem.prototype.GetSubDataList=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataList(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataEnum">
	<desc>ȡ��DataItem��Ԫ���ڵ�DataEnum</desc>
	<output type="DataEnum">Ԫ���ڵ�DataEnum</output>
</doc>**/
DataItem.prototype.GetSubDataEnum=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataEnum(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.GetSubDataParam">
	<desc>ȡ��DataItem��Ԫ���ڵ�DataParam</desc>
	<output type="DataParam">Ԫ���ڵ�DataParam</output>
</doc>**/
DataItem.prototype.GetSubDataParam=function()
{	if(this.XmlEle.childNodes.length<=0)
		return null;
	if(this.XmlEle.childNodes[0].nodeType == 3)
		return new DataParam(null,this.XmlDoc,this.XmlEle.childNodes[0]);
	return null;
}

/**<doc type="protofunc" name="DataItem.ToStringParam">
	<desc>ȡ��DataItem��Ԫ�������������ƺ�����ֵ�������ɵ�StringParam</desc>
	<output type="StringParam">���������ƺ�����ֵ�������ɵ�StringParam</output>
</doc>**/
DataItem.prototype.ToStringParam = function()
{	var objParam = new StringParam();
	for (var i = 0; i< this.XmlEle.attributes.length; i++)
		objParam.AddItem(this.XmlEle.attributes.item(i).nodeName,
					 this.XmlEle.attributes.item(i).nodeValue);
	return objParam;
}

/**<doc type="protofunc" name="DataItem.ToDataForm">
	<desc>ȡ��DataItem��Ԫ�������������ƺ�����ֵ�������ɵ�DataForm</desc>
	<input>
		<param name="name" type="string">DataForm������</param>
	</input>	
	<output type="DataForm">���������ƺ�����ֵ�������ɵ�DataForm</output>
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
	<desc>ȡ��DataItem��Ԫ�ض�Ӧ��XML</desc>
	<output type="string">DataItem��Ԫ�ض�Ӧ��XML</output>
</doc>**/
DataItem.prototype.ToString = function()
{	return this.XmlEle.xml;
}

//
//--------------------------------DataItem ���������--------------------------------------------------------
//


//
//--------------------------------DataNode �����忪ʼ,��DataItem�̳�-----------------------------------------
//

/**<doc type="objdefine" name="DataNode">
	<desc>DataNode����,��DataItem�̳�</desc>
	<input>
		<param name="xmlsrc" type="object">
		˵�����������Ϊobject,��xmlsrc��ʾΪһ��XML���;�������Ϊstring,��xmlsrc��ʾΪһ��XML
		�洢��ʽ��</param>
		<param name="doc" type="object">����DataNode��XML�ĵ�</param>
		<param name="ele" type="object">����DataNode��XMLԪ��</param>
	</input>	
</doc>**/
function DataNode(xmlsrc,doc,ele)
{	this.Type="Node";
	this.Init(xmlsrc,doc,ele);
}
DataNode.prototype = new DataItem();

/**<doc type="protofunc" name="DataNode.Init">
	<desc>DataNode�Ĺ�����</desc>
	<input>
		<param name="xmlsrc" type="object">�������Ϊobject,��xmlsrc��ʾΪһ��XML���;�������Ϊstring,��xmlsrc��ʾΪһ��XML</param>
		<param name="doc" type="object">����DataNode��XML�ĵ�</param>
		<param name="ele" type="object">����DataNode��XMLԪ��</param>
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
	<desc>��DataNode���������</desc>
</doc>**/
DataNode.prototype.AddItem = function(){}

/**<doc type="protofunc" name="DataNode.NewItem">
	<desc>��DataNode���½�����</desc>
</doc>**/
DataNode.prototype.NewItem = function(){}

/**<doc type="protofunc" name="DataNode.Remove">
	<desc>��DataNode��ɾ������</desc>
	<input>
		<param name="index" type="object">�������Ϊobject,���ʾҪɾ����XML���;�������Ϊnumber,���ʾҪɾ����index�����</param>
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
	<desc>���DataNode������</desc>
</doc>**/
DataNode.prototype.Clear = function()
{	var nodes=this.XmlEle.childNodes;
	var count=nodes.length;
	for(var i=count-1;i>=0;i--)
		this.XmlEle.removeChild(nodes[i]);
}

/**<doc type="protofunc" name="DataNode.GetItemCount">
	<desc>�õ�DataNode���������</desc>
	<output type="number">DataNode���������</output>
</doc>**/
DataNode.prototype.GetItemCount=function()
{	return this.XmlEle.childNodes.length;
}

/**<doc type="protofunc" name="DataNode.GetItem">
	<desc>����index���DataNode������</desc>
	<input>
		<param name="index" type="object">�������Ϊnumber,�򷵻�DataNode��Ӧ��XMLԪ�صĵ�index��;�������Ϊstring,�򷵻�DataNode��Ӧ��XMLԪ�صĶ�Ӧ����Ϊindex����</param>
	</input>		
	<output type="DataItem">��õ�DataItem</output>
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
	<desc>����XPath���DataNode����������</desc>
	<input>
		<param name="xpath" type="string">XPath��ѯ����</param>
	</input>		
	<output type="DataItem">��Ӧ��DataItem����</output>
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
	<desc>ȡ��DataNode��Ԫ������</desc>
	<output type="string">��Ӧ��Ԫ������</output>
</doc>**/
DataNode.prototype.GetName = function()
{	return this.XmlEle.getAttribute("Name");
}

/**<doc type="protofunc" name="DataNode.SetName">
	<desc>����DataNode��Ԫ������</desc>
	<input>
		<param name="name" type="string">���õ�����</param>
	</input>		
</doc>**/
DataNode.prototype.SetName = function(name)
{	this.XmlEle.setAttribute("Name",name);
}

/**<doc type="protofunc" name="DataNode.CloneXmlNode">
	<desc>��¡DataNode��Ӧ��XML���(�ǿ�¡XML����,���ǿ�¡����DataNode��????)</desc>
	<input>
		<param name="name" type="string">��¡��DataNode��XML�������</param>
	</input>
	<output type="string">��Ӧ��XML���</output>		
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
//--------------------------------DataNode ���������--------------------------------------------------------
//

//
//--------------------------------DataStore �����忪ʼ,��DataItem�̳�----------------------------------------
//

/**<doc type="objdefine" name="DataStore">
	<desc>���ݴ洢������</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		˵������ʼ���ַ���
		�洢��ʽ��<DataStore><Forms></Forms><Lists></Lists><Enums></Enums><Params></Params></DataStore>
		</param>
		<param name="type" type="empty/enum">�ַ�������</param>
	</input>
	<enum name="type">
		<item text="[empty]">һ��xml�ַ���</item>
		<item text="b64">������xml�ַ���</item>
		<item text="zb64">ѹ���������xml�ַ���</item>
	</enum>
	<output>���ؿ�ʼ���ڶ���</output>
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
	<desc>��ȡTag</desc>
	<input>
		<param name="type" type="string">����type(form/list/enum/param)������Ӧ��ֵ(Forms/Lists/Enums/Params)</param>
		<param name="isformat" type="boolean">���isformatΪtrue,�򷵻ص�TagΪtype�ĸı�ֵ(type����ĸ��д,������ĸСд);���isformatΪfalse,�����type��ֵ������Tag</param>
	</input>
	<output type="string">��Ӧ��Tag</output>		
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
	<desc>��ȡDataStore��Paramֵ������������򷵻�null��defvalue</desc>
	<input>
		<param name="name" type="string">Param��Name����</param>
		<param name="defvalue" type="string">Ĭ��ֵ</param>
	</input>
	<output type="string">��Ӧ��Param��ֵ</output>		
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
	<desc>����DataStore��Paramֵ</desc>
	<input>
		<param name="name" type="string">Param��Name����</param>
		<param name="value" type="string">Param��ֵ</param>
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
	<desc>���ض�Ӧ��DataForm/DataList/DataEnum/DataParam</desc>
	<input>
		<param name="type" type="string">����type(form/list/enum/param)�ҵ���Ӧ������(DataForm/DataList/DataEnum/DataParam)</param>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ�Ľ��</param>
	</input>
	<output type="string">��Ӧ��DataForm/DataList/DataEnum/DataParam</output>		
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
	<desc>�õ�DataStore��ָ��Xml�ڵ�</desc>
	<input>
		<param name="type" type="string">����type(form/list/enum/param)�ҵ���Ӧ������(DataForm/DataList/DataEnum/DataParam)XmlNode�ڵ�</param>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ��XmlNode�ڵ�</param>
	</input>
	<output type="number">ָ��index��Xml�ڵ�</output>
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
	<desc>���Xml�ڵ㵽DataStore</desc>
	<input>
		<param name="dnode" type="xmlsrc">XmlNode�ڵ�</param>
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
	<desc>�õ�DataStore��ָ��Xml�ڵ�</desc>
	<input>
		<param name="type" type="string">����type(form/list/enum/param)��DataStore�´�������Ӧ������(DataForm/DataList/DataEnum/DataParam)</param>
	</input>
	<output type="number">��DataStore�´����Ķ���</output>
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
	<desc>�õ�DataStore�¸�Ԫ����Ŀ</desc>
</doc>**/
DataStore.prototype.GetCount=function()
{	return this.GetNodeCount("Form")+this.GetNodeCount("Enum")+this.GetNodeCount("List")+this.GetNodeCount("Param");
}

/**<doc type="protofunc" name="DataStore.GetCount">
	<desc>�õ�DataStore��ָ������Ԫ����Ŀ</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)��DataStore��Ӧ������(DataForm/DataList/DataEnum/DataParam)</param>
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
	<desc>�õ�DataStore��ָ��Form�ڵ�</desc>
	<input>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ��Form�ڵ�</param>
	</input>
	<output type="number">ָ��index��Form�ڵ�</output>
</doc>**/
DataStore.prototype.Forms=function(index)
{	var node = this.GetXmlNode("Form",index);
	if(!node)return null;
	return new DataForm(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Lists">
	<desc>�õ�DataStore��ָ��List�ڵ�</desc>
	<input>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ��List�ڵ�</param>
	</input>
	<output type="number">ָ��index��List�ڵ�</output>
</doc>**/
DataStore.prototype.Lists=function(index)
{	var node = this.GetXmlNode("List",index);
	if(!node)return null;
	return new DataList(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Enums">
	<desc>�õ�DataStore��ָ��Enum�ڵ�</desc>
	<input>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ��Enum�ڵ�</param>
	</input>
	<output type="number">ָ��index��Enum�ڵ�</output>
</doc>**/
DataStore.prototype.Enums=function(index)
{	var node = this.GetXmlNode("Enum",index);
	if(!node)return null;
	return new DataEnum(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Params">
	<desc>�õ�DataStore��ָ��Param�ڵ�</desc>
	<input>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ��Param�ڵ�</param>
	</input>
	<output type="number">ָ��index��Param�ڵ�</output>
</doc>**/
DataStore.prototype.Params=function(index)
{	var node = this.GetXmlNode("Param",index);
	if(!node)return null;
	return new DataParam(null,this.XmlDoc,node);	
}

/**<doc type="protofunc" name="DataStore.Remove">
	<desc>�Ƴ�ָ��������ָ�����ƻ���ŵ�Ԫ��</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)��DataStore��Ӧ������(DataForm/DataList/DataEnum/DataParam)</param>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ�Ľڵ�</param>
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
	<desc>���DataStore��ָ������Ԫ��</desc>
	<input>
		<param name="type" type="string">type(form/list/enum/param)��DataStore��Ӧ������(DataForm/DataList/DataEnum/DataParam)</param>
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
	<desc>���ݴ洢������</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		˵������ʼ���ַ���
		�洢��ʽ��<Form Name=""></Form>
		</param>
	</input>
</doc>**/
function DataForm(xmlsrc,doc,ele)
{	this.Type="Form";
	this.Init(xmlsrc,doc,ele);
}
DataForm.prototype = new DataNode(null);

/**<doc type="protofunc" name="DataStore.AddItem">
	<desc>��DataForm����ӽڵ��൱��SetValue,��ͬ���Ǵ˺����з���ֵ</desc>
	<input>
		<param name="name" type="string">Item������</param>
		<param name="value" type="string">Item��ֵ</param>
	</input>
	<output type="DataItem">ָ��name��value��DataItem</output>
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
	<desc>��DataFormװ��Ϊָ��tag��DataItem�����нڵ��nodeNameת��Ϊ��������textת��Ϊ����ֵ</desc>
	<input>
		<param name="tag" type="string">ת����DataItem�ı�ǩ��</param>
	</input>
	<output type="DataItem">ת�ƺ��DataItem</output>
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
	<desc>���ݴ洢������</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		˵������ʼ���ַ���
		�洢��ʽ��<List Name=""></List>
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
	<desc>�õ�DataList������������</desc>
	<output type="Array">ataList������������</output>
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
	<desc>����DataList����</desc>
	<input>
		<param name="fld" type="string/Array">�����������","�ָ�ĵ��ַ���</param>
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
	<desc>���ݴ洢������</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		˵������ʼ���ַ���
		�洢��ʽ��<Enum Name=""></Enum>
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
	<desc>�õ���ö�ٵ�EnumKey</desc>
	<input>
		<param name="index" type="string/number">��������(string)�����(number)�ҵ���Ӧ�Ľ��</param>
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
	<desc>���ݴ洢������</desc>
	<input>
		<param name="xmlsrc" type="empty/string">
		˵������ʼ���ַ���
		�洢��ʽ��<Param Name=""></Param>
		</param>
	</input>
</doc>**/
function DataParam(xmlsrc,doc,ele)
{	this.Type="Param";
	if(typeof(xmlsrc)=="string" && typeof(doc)=="string")
	{	this.Init(); //�ṩnew DataParam(name,value)����
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
//--------------------------------DataStore ��ض��������---------------------------------------------------
//
//dsdef   Xml.List.UserList

/**<doc type="function" name="Global.GetDs">
	<desc>ָ��id�����ݵ���Ϣ��ת��ΪDataStore</desc>
	<input>
		<param name="xmlid" type="string">���ݵ�id</param>
	</input>
	<output type="DataStore">DataStore</output>
</doc>**/
function GetDs(xmlid)
{	var eledoc=PageDoc.all(xmlid).XMLDocument;
	if(!eledoc)return null;
	return new DataStore(eledoc);
}

/**<doc type="function" name="Global.GetDsNode">
	<desc>�õ�ָ�����ݵ���Ϣ��ת��ΪDataStore</desc>
	<input>
		<param name="nodpath" type="string">xpath��ʽΪ"���ݵ�id.��������.Ԫ����"</param>
		<param name="ds" type="string">�ƶ����ݵ���Ĭ��Ϊnodepath����λ</param>
	</input>
	<output type="DataForm/DataList/DataEnum/DataParam">����nodepath���ز�ͬ����</output>
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


//����DataForm�ֶΣ�fieldsΪ�����ֶ�
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
//����DataList�ֶΣ�fieldsΪ������
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



/**��ȡDataParam��Ԫ��ֵ�����û�����÷���ȱʡֵ**/
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
//---------------------------------ȫ�ֺ������忪ʼ--------------------------------------------------------------
//

/**<doc type="function" name="Global.OnError">
	<desc>��������</desc>
</doc>**/
function OnError(msg,url,lineno)
{	window.status ="(����: " + msg + ") " +" (λ��: " + url + ")  (�к�: " + lineno+")";
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
	<desc>���ַ���ת��Ϊbool����</desc>
	<input>
		<param name="str" type="string">�����ַ���</param>
	</input>
	<output>����bool����</output>
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
	<desc>��ָ����ʽ���ַ���ת��Ϊ���ڶ���</desc>
	<input>
		<param name="str" type="string">�����ַ���,��ʽΪ��yyyy-mm-dd hh:mm:ss��</param>
	</input>
	<output>�������ڶ���</output>
</doc>**/
function ToDate(str)
{
	try{
		var parts = str.split(" ");
		var dp = parts[0].split("-");
		//var dt = new Date();//parseInt("09")����BUG
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
	<desc>���ӵ�һ��Ӧ��ϵͳ��һ��ҳ��</desc>
	<input>
		<param name="appname" type="string">���ӵ�Ӧ��ϵͳ�ı�ʶ����[Global.AppServer]</param>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
		<param name="target" type="empty/object/string">���ӵ���Ŀ�괰��,�����Ǳ����ڡ�Frame��IFrame�����´���</param>
		<param name="style"  type="empty/string">�´��ڵ���ʽ</param>
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
            if(!win) alert("��ѽ������ֹ�˵������ڣ�");
        //}		
		//win = window.open(desurl,target,style);
	}
	if(win)return win;
}

/**<doc type="function" name="Global.ParamLinkTo">
	<desc>���ӵ�һ��Ӧ��ϵͳ��һ��ҳ��</desc>
	<input>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
		<param name="xmlnode" type="string">DataItem��������url��"[]"�е����ֵ</param>
		<param name="target" type="empty/object/string">���ӵ���Ŀ�괰��,�����Ǳ����ڡ�Frame��IFrame�����´���</param>
		<param name="style"  type="empty/string">�´��ڵ���ʽ</param>
	</input>
</doc>**/
function ParamLinkTo(url,xmlnode,target,style)
{	returnUrl=url;
	while(returnUrl.indexOf("[")!=-1)
	{
		var param=returnUrl.substring(returnUrl.indexOf("[")+1,returnUrl.indexOf("]"));
		var value ="null";
		if(xmlnode)
			value=(xmlnode.getAttribute(param)+"").filterNull();//���XML����ֵ
		if(value == "")
			value=(xmlnode.getAttribute(param.toUpperCase())+"").filterNull();
		if(value == "null")
		{	value = eval(param);//���ȫ�ֱ���ֵ
			if(typeof(value)=="undefined") 
				value="";
		}
		returnUrl=returnUrl.replace("[" + param + "]",value);
	}
	return LinkTo(returnUrl,target,style);
}


/**
</doc>**//**<doc type="function" name="Global.ArrayFind">
	<desc>����ָ��������ֵλ��</desc>
	<output>����������ָ��ֵλ��</output>
</doc>**/
ArrayFind=function(ary,value)
{	for(var i=0;i<ary.length;i++)
		if(ary[i]==value)return i;
	return -1;
}


/**<doc type="function" name="Global.ToArray">
	<desc>���ڽ�object.all(xx)ȡ�ص�ֵͳһת��������</desc>
	<input>
		<param name="ele" type="variant">��Ҫת���ı���������</param>
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
	<desc>���HTMLԪ�ض���</desc>
	<input>
		<param name="id" type="string">Ԫ�ص�ID</param>
	</input>
	<ouput type="object">����HTML����</output>
</doc>**/
function Get(id)
{
}


/**<doc type="function" name="Global.GetValue">
	<desc>���Ԫ�ص�ֵ</desc>
	<input>
		<param name="id" type="string">Ԫ�ص�ID</param>
	</input>
	<ouput type="variant">��������</output>
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
	<desc>����Ԫ�ص�ֵ</desc>
	<input>
		<param name="id" type="string">Ԫ�ص�ID</param>
		<param name="value" type="variant">Ԫ�ص�ֵ</param>
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
	<desc>��HTMLԪ������Ϊ���ɿ�/�ɿ�״̬</desc>
	<input>
		<param name="id" type="string">Ԫ�ص�ID</param>
		<param name="st" type="boolean">״̬</param>
	</input>
</doc>**/
function SetDisabled(id,st)
{
	document.getElementById(id).disabled = st;
}

/**<doc type="function" name="Global.SetReadonly">
	<desc>��HTMLԪ������Ϊ���ɱ༭/�ɱ༭״̬</desc>
	<input>
		<param name="id" type="string">Ԫ�ص�ID</param>
		<param name="id" type="boolean">״̬</param>
	</input>
</doc>**/
function SetReadonly(id,st)
{
	document.getElementById(id).readOnly = st;
}

/**<doc type="function" name="Global.BeautyXml">
	<desc>��ʽ��xml�ַ����������xml�ĺϷ���</desc>
	<input>
		<param name="xml" type="string">�����xml�ַ���</param>
	</input>
	<output>�����ʽ������ַ���</output>
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
	<desc>���ָ����ĿTab�ַ�</desc>
	<input>
		<param name="len" type="integer">Tab������</param>
	</input>
	<output>����Tab��</output>
</doc>**/
function GetTab(len)
{	if (len == 0) return "";
	var str = "";
	for(var i = 0; i < len; i++)
		str += "\t";
	return str;
}


/**<doc type="function" name="Global.GetFormatXml">
	<desc>��ø�ʽ�����XML�ַ�����ʽ(�ݹ鷨)</desc>
	<input>
		<param name="xml" type="string">xmlԪ��</param>
		<param name="deep" type="integer">���</param>
	</input>
	<output>�����ʽ������ַ���</output>
</doc>**/
function GetFormatXml(xmlele,deep)
{	var tmpnode;
	if (xmlele.childNodes.length > 1 || 
		(xmlele.childNodes.length == 1 && xmlele.childNodes(0).nodeType == 1)){
		tmpnode = xmlele.cloneNode(false);  //ֻ��¡���ڵ�
		var tmpstr = tmpnode.xml;
		tmpstr = tmpstr.replace("/","");	//Tow Case: <AA/>  <AA></AA>
		var pos = tmpstr.indexOf(">");
		tmpstr = tmpstr.substr(0,pos + 1);  //ȡ���ڵ��ǩ
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
	<desc>���ָ����Ŀ���ַ���</desc>
	<input>
		<param name="len" type="integer">���ַ�������</param>
		<param name="len" type="integer">����ַ�</param>
	</input>
	<output>���ؿ��ַ���</output>
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
	<desc>����ָ�������ָ������ֵ</desc>
	<input>
		<param name="ele" type="object">Ŀ�����</param>
		<param name="name" type="string">ָ��Ŀ�����������</param>
		<param name="defvalue" type="string">������ָ������ʱ,���ص�Ĭ��ֵ</param>
		<param name="type"  type="bool/string/int/float/date">����ֵ����</param>
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
	<desc>����ָ�������ָ������ֵ</desc>
	<input>
		<param name="ele" type="object">Ŀ�����</param>
		<param name="name" type="string">ָ��Ŀ�����������</param>
		<param name="value" type="string">ָ��Ŀ���������ֵ</param>
	</input>
</doc>**/
function SetAttr(ele,name,value)
{	ele.setAttribute(name,value+"");
}

/**<doc type="function" name="Global.GetAttr">
	<desc>����xml,������xml�ĵ�</desc>
	<input>
		<param name="xmlstring" type="string">xml����</param>
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
	<desc>���ö��㴰�ڵ�PageKey</desc>
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
	<desc>����һ��XML�ڵ��ڸ��ڵ��е�λ�ã�Ҳ������HTMLԪ��</desc>
	<input>
		<param name="node" type="xmlnode">XML�ڵ�</param>
	</input>
</doc>**/
function GetNodeIndex(node)
{	var pnode = node.parentNode;
	var count = pnode.childNodes.length;
	for(var i=0;i<count;i++)
		if(pnode.childNodes[i]==node)return i;
}

/**<doc type="function" name="Global.PostRequest">
	<desc>��̨��Post�ύ����</desc>
	<input>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
		<param name="data"  type="xml">��Ҫ�ύ������</param>
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
	<desc>��̨��Get�ύ����</desc>
	<input>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
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
	<desc>ǰ̨�ύ���ݣ���Ҫˢ��ҳ�棩�൱�ڽ�data����Input���ύ</desc>
	<input>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
		<param name="data"  type="xml">��Ҫ�ύ������</param>
		<param name="action"  type="string">�������ͣ���̨����RequestAction���</param>
		<param name="method"  type="string">�ύ��ʽ��post��get</param>
		<param name="target"  type="empty/object/string">���ӵ���Ŀ�괰��,�����Ǳ����ڡ�Frame��IFrame�����´���</param>
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
	<desc>�õ�ָ��url�д����ָ������ֵ,Ĭ��urlΪ��ҳ��url</desc>
	<input>
		<param name="prop"  type="string">������</param>
		<param name="url" type="string">���ӵ�Ŀ���ַ����Ե�ַ</param>
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
	<desc>��������URL,�����ز���</desc>
	<output type="[]">���ؼ�ֵ��</output>
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

var fadeArray = new Array();	// ����/����Ԫ������
/**<doc type="function" name="Global.FadeShow">
	<desc>����ʾһ��Ԫ��</desc>
	<input>
		<param name="el"  type="object">Ԫ��</param>
		<param name="fadeIn" type="bool">true(����)/false(����)</param>
		<param name="steps"  type="int">��ʾ����</param>
		<param name="msec"  type="int">ÿ��������</param>
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
	<desc>�õ�eval��ķ���ֵ,��ִ�г����򷵻�null</desc>
	<input>
		<param name="evalstr"  type="string">Ҫִ�е����</param>
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
	<desc>�õ�������ʽ�ַ���</desc>
	<input>
		<param name="linkStyle"  type="string">������ʽ</param>
		<param name="isDialog"  type="bool">�Ƿ�Ϊ�Ի���</param>
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
	<desc>�õ�ָ����Cookieֵ</desc>
	<input>
		<param name="name"  type="string">ָ��Cookie��</param>
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
	<desc>��Cookie�л�ȡPassCodeֵ</desc>
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
				alert("���ܻ�ȡϵͳͨ�д���!");
			}
		}
					
	}
	return PassCode;
}

/**<doc type="function" name="Global.GetPassCode">
	<desc>��ȡ�ַ������ȣ�Unicodeÿ���ַ��������ȣ�</desc>
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
	<desc>�ж��ƶ�ֵ�Ƿ�����ƶ����ڸ�ʽ</desc>
	<input>
		<param name="value" type="string">���������жϵ�ֵ</param>
		<param name="fm" type="string">���ڸ�ʽ"YYYY-MM-DD","YY-MM-DD",Ĭ��"YYYY-MM-DD"</param>
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
	<desc>�ж��ƶ�ֵ�Ƿ�����ƶ�����ʱ���ʽ</desc>
	<input>
		<param name="value" type="string">���������жϵ�ֵ</param>
		<param name="minYear" type="int">��С��ݣ�Ĭ��0</param>
		<param name="maxYear" type="int">�����ݣ�Ĭ��9999</param>
		<param name="hassec" type="bool">�Ƿ���֤�룬Ĭ��false</param>
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
	//�������֤��,����Ĭ������Ϊ0
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
	<desc>�ж�ָ��ֵ�Ƿ����ʱ���ʽ</desc>
	<input>
		<param name="value" type="string">���������жϵ�ֵ</param>
		<param name="hassec" type="bool">�Ƿ���֤�룬Ĭ��false</param>
	</input>
</doc>**/
function IsTime(value,hassec)
{	if (typeof(hassec)=="undefined")
		var hassec=false;
	if (hassec) //��Ҫ�ж���
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

// �ж��Ƿ�Ϸ��������֤�ţ��й���
function IsIDCard(value)
{
	var _re15 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;	// 15λ
	var _re18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;	// 18λ

	return (IsValueMatch(value, _re15) || IsValueMatch(value, _re18))
}

// ��ָ֤��ֵ�Ƿ����ָ��������ʽ
function IsValueMatch(value, re)
{
	var r = value.match(re)
    if (r==null)
		return false
	else
		return true;
}

/**<doc type="function" name="Global.GetFileSize">
	<desc>�õ�ָ���ļ��Ĵ�С,��kbΪ��λ</desc>
	<input>
		<param name="fname" type="string">ָ���ļ�</param>
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
	<desc>�ж�ָ���ı��Ƿ�����ƶ�������ʽ</desc>
	<input>
		<param name="value" type="string">ָ���ı�</param>
		<param name="exp" type="expstr">������ʽ</param>
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
	<desc>��ȡָ���ַ�����Date���͵�ʱ�䲿��</desc>
	<input>
		<param name="date" type="string/object">ָ���ַ���</param>
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
//---------------------------------ȫ�ֺ����������--------------------------------------------------------------
//



//
//--------------------------------Collection �����忪ʼ--------------------------------------------------
//

/**<doc type="objdefine" name="Collection">
	<desc>�ַ����������޼�������չ</desc>
	<property>
		<prop name="Keys" type="array">������</param>
	</property>
</doc>**/
function Collection()
{	this.Type="";
	this.Keys=new Array();
	this.Values=new Array();
}

/**<doc type="protofunc" name="Collection.Add">
	<desc>���һ��Ԫ��</desc>
	<input>
		<param name="key" type="string">��ֵ</param>
		<param name="value" type="variant">��ֵ</param>
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
	<desc>�Ƿ����һ��Ԫ��</desc>
	<input>
		<param name="key" type="string">��ֵ</param>
	</input>
</doc>**/
Collection.prototype.Exist=function(key)
{	if(ArrayFind(this.Keys,key)>=0)return true;
	return false;
}
/**<doc type="protofunc" name="Collection.Set">
	<desc>����һ��Ԫ�أ�����������ӣ������򸲸�</desc>
	<input>
		<param name="key" type="string">��ֵ</param>
		<param name="value" type="variant">��ֵ</param>
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
	<desc>ɾ��һ��Ԫ��</desc>
	<input>
		<param name="keyindex" type="string/number">��ֵ������</param>
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
	<desc>�������Ԫ��</desc>
</doc>**/
Collection.prototype.Clear=function()
{	this.Keys.splice(0,this.Keys.length);
	this.Values.splice(0,this.Values.length);
}

/**<doc type="protofunc" name="Collection.Insert">
	<desc>����һ��Ԫ�أ���֮ǰ����Ϊ����,��IsSortΪtrue������£���ͬ��Add</desc>
	<input>
		<param name="key" type="string">��ֵ</param>
		<param name="value" type="variant">��ֵ</param>
		<param name="before" type="null/string/int">��֮ǰ����</param>
		<param name="after" type="null/string/int">��֮�����</param>
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
	<desc>���Ԫ�ظ���</desc>
	<output type="number">Ԫ�صĸ���</output>
</doc>**/
Collection.prototype.GetCount=function()
{	return this.Keys.length;
}

/**<doc type="protofunc" name="Collection.GetItem">
	<desc>���һ��Ԫ��</desc>
	<input>
		<param name="keyindex" type="string/number">��ֵ������</param>
	</input>
	<output type="variant">Ԫ�ص���ֵ</output>
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
	<desc>���Ʊ�����</desc>
	<output type="object">Collection����</output>
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
	<desc>�����ַ�������</desc>
	<output type="string">��ʽ"Key:Value;"</output>
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
//--------------------------------Collection ���������---------------------------------------------------
//


//
//--------------------------------StringParam �����忪ʼ---------------------------------------------------
//

/**<doc type="objdefine" name="StringParam" inhert="Collection">
	<desc>���������϶�����</desc>
	<input>
		<param name="spstr" type="string">��ʼ��������</param>
		<param name="type" type="enum">����������</param>
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
	<desc>���Ԫ�ظ���</desc>
	<output type="number">Ԫ�صĸ���</output>
</doc>**/
StringParam.prototype.GetCount=function()
{	return this.Keys.length;
}


/**<doc type="protofunc" name="StringParam.Add">
	<desc>���Ԫ��</desc>
	<input>
		<param name="key" type="string">Ԫ��key</param>
		<param name="value" type="string">Ԫ��value</param>
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
	<desc>����Ԫ��ֵ</desc>
	<input>
		<param name="key" type="string">Ԫ��key</param>
		<param name="value" type="string">Ԫ��value</param>
		<param name="notclear" type="bool">Ϊtrueʱ��ѯԭValues���Ƿ����ָ��ֵ�������������</param>
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
	<desc>��StringParam���ƶ�λ�ò���ֵ</desc>
	<input>
		<param name="key" type="string">Ԫ��key</param>
		<param name="value" type="string">Ԫ��value</param>
		<param name="before" type="number/string">�ƶ�λ�û�ֵ��λ��,Ĭ��Ϊĩλ</param>
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
			this.Add(key,escape(value));//�����д���?
		else
		{	this.Keys.splice(bpos,0,key);
			this.Values.splice(bpos,0,escape(value));
		}
	}

}

/**<doc type="protofunc" name="StringParam.Get">
	<desc>�õ�ָ��λ�õ�ֵ</desc>
	<input>
		<param name="key" type="string/number">Ԫ��key��λ��</param>
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
	<desc>����ָ��Key��Ӧ��Value��ת��Ϊ����</desc>
	<output type="object">��ָ��Key��Ӧ��Valueת��������</output>
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
	<desc>ɾ��һ��Ԫ��</desc>
	<input>
		<param name="keyindex" type="string/number">��ֵ������</param>
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
	<desc>�������Ԫ��</desc>
</doc>**/
StringParam.prototype.Clear=function()
{	this.Keys.splice(0,this.Keys.length);
	this.Values.splice(0,this.Values.length);
}

/**<doc type="protofunc" name="StringParam.Clone">
	<desc>���Ʊ�����</desc>
	<output type="object">StringParam����</output>
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
	<desc>����StringParam���ַ�����ʽ��ʽΪ "Key+GapChar+Value"</desc>
	<input>
		<param name="noescape" type="bool">�Ƿ���unescape����Value</param>
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
//--------------------------------StringParam ���������---------------------------------------------------
//

//
//--------------------------------JcCaller �����忪ʼ---------------------------------------------------
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
//--------------------------------JcCaller ���������---------------------------------------------------
//

//
//--------------------------------ȫ�ֶ������ʵ�����忪ʼ---------------------------------------------------
//



/**<doc type="object" name="Global.Position">
	<desc>HTMLԪ�ص�λ�ô������</desc>
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
	<desc>��鵱ǰ����</desc>
	<input>
		<param name="type" type="enum">�������</param>
	</input>
	<enum name="type">
		<item text="isie">�Ƿ�ΪIE�����</item>
		<item text="ieversion">IE������汾�Ƿ���5.0����</item>
		<item text="activex">�Ƿ�֧��Microsoft.XMLDOM�ؼ�</item>
		<item text="owc">�Ƿ�װOWC���</item>
		<item text="viewer">�Ƿ��AutoVueX���һͬ��װ</item>
		<item text="becom">�Ƿ�֧��GsCommon.DataStore�ؼ�</item>
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
		case "owc"://ͬOWC�����ͬ��װ
			try{	var test = new ActiveXObject("GsOffice.OwcTool");
					result = true;
					test = null;
				}catch(e){}
			break;
		case "viewer"://��AutoVueX���һͬ��װ
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
//--------------------------------ValidateResult�����忪ʼ-------------------------------------
//

/**<doc type="objdefine" name="ValidateResult">
	<desc>��֤���۶�����</desc>
	<property>
		<prop name="Passed" type="boolean">�Ƿ�ͨ����֤</prop>
		<prop name="FieldName" type="string">��֤���ֶ�����</prop>
		<prop name="Message" type="string">������Ϣ</prop>
		<prop name="ErrorType" type="string">��������</prop>
		<prop name="ValExpMsg" type="string">��֤��������ʽ</prop>
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
	<desc>��ȡ������Ϣ</desc>
	<output type="string">������Ϣ</output>	
</doc>**/
ValidateResult.prototype.GetErrMsg=function()
{	return "["+this.FieldName+"]"+this.Message;
}

/**<doc type="protofunc" name="ValidateResult.ValidateNotAllowEmpty">
	<desc>��ָ֤�������Ƿ�Ϊ��</desc>
	<input>
		<param name="value" type="object">��Ҫ��֤�Ķ���</param>
		<param name="allowspace" type="bool">�Ƿ�����ո�Ĭ�Ϸ�</param>
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
		this.Message = "���������ֵ��";
	}
}

/**<doc type="protofunc" name="ValidateResult.ValidateFormElement">
	<desc>��ָ֤�������Ƿ�������Ӧvalstr��Ӧ�Ĺ���</desc>
	<input>
		<param name="value" type="object">��Ҫ��֤�Ķ���</param>
		<param name="valstr" type="string">�����ַ���</param>
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
				errmsg = "��������"+min+"��"+max+"֮��!";
			else if (min!=null && len<parseInt(min))
				errmsg = "���ȱ������"+min+"!";
			else if (max!=null && len>parseInt(max))
				errmsg = "���ȱ���С��"+max+"!";
			else if(equ!=null && equ != len)
				errmsg = "���ȱ������"+equ+"!";
			if (exp!=null && MatchExp(value,exp)==false)
			{	if(eds==null) eds="";
				errmsg = eds;//this.ValExpMsg;
			}
			if (errmsg==""){ pas=true;}
			break;
		case "FLOAT":
			if (!IsFloat(value))
			{	errmsg = "������������!";
				break;
			}
			if (valstr!="")
			{	val = parseFloat(value);
				min = sp.Get("Min");max = sp.Get("Max");
				if ( min!=null && max!=null && (val<parseFloat(min) ||val>parseFloat(max) ) )
					errmsg = "��ֵ����"+min+"��"+max+"֮��!";
				else if (min!=null && val<parseFloat(min))
					errmsg = "��ֵ�������"+min+"!";
				else if (max!=null && val>parseFloat(max))
					errmsg = "��ֵ����С��"+max+"!";
			}
			if (errmsg==""){ pas=true;}
			break;
		
		case "FILE":
			if (valstr!="")
			{	val = GetFileSize(value);
				if (val>0)
				{	min = sp.Get("Min");max = sp.Get("Max");
					if ( min!=null && max!=null && (val<parseInt(min) ||val>parseInt(max) ) )
						errmsg = "�ļ��ߴ�����"+min+"��"+max+"֮��!";
					else if (min!=null && val<parseInt(min))
						errmsg = "�ļ��ߴ�������"+min+"!";
					else if (max!=null && val>parseInt(max))
						errmsg = "�ļ��ߴ����С��"+max+"!";
				}
			}
			if (errmsg==""){ pas=true;}
			break;
		case "INT":
			if (!IsInt(value))
			{	errmsg = "��������������";
				break;
			}
			if (valstr!="")
			{	val = parseInt(value);
				min = sp.Get("Min");max = sp.Get("Max");
				if ( min!=null && max!=null && (val<parseInt(min) ||val>parseInt(max)))
				{	errmsg = "��ֵ����"+min+"��"+max+"֮�䣡";
				}else if (min!=null && val<parseInt(min))
				{	errmsg = "��ֵ�������"+min+"��";
				}else if (max!=null && val>parseInt(max))
				{	errmsg = "��ֵ����С��"+max+"��";
				}
			}
			if (errmsg==""){ pas=true;}
			break;

		case "DATE":
			fm = sp.Get("Format");
			if (fm==null)fm = "YYYY-MM-DD";
			if (!IsDate(value,fm))
			{	if(fm=="YYYY-MM-DD")
					errmsg = "����������ȷ�����ڸ�ʽ��"+fm+"��!\n      ����YYYY��Χ(1900-2100),MM��Χ(1-12),DD��Χ(1-31)��";
				else if(fm=="YY-MM-DD")
					errmsg = "����������ȷ�����ڸ�ʽ��"+fm+"��!\n      ����YY��Χ(00-29Ϊ2000-2029��30-99Ϊ1930-1999),MM��Χ(1-12),DD��Χ(1-31)��";
				
				break;
			}
			if (valstr!="")
			{	val = new Date(FormatDate(value,"MM-DD-YYYY"));//js������mmddyyyy��ʽ
				min = sp.Get("Min");max = sp.Get("Max");
				//FormatDate Add By ZhouBin
				if ( min!=null && max!=null && (val-new Date(FormatDate(min,"MM-DD-YYYY"))<0 ||val-new Date(FormatDate(max,"MM-DD-YYYY"))>0 ) )
					errmsg = "��Χ����"+min+"��"+max+"֮�䣡";
				else if (min!=null && val-new Date(FormatDate(min,"MM-DD-YYYY"))<0)
					errmsg = "��������"+min+"��";
				else if (max!=null && val-new Date(FormatDate(max,"MM-DD-YYYY"))>0)
					errmsg = "��������"+max+"��";
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
				errmsg = "����������ȷ������ʱ���ʽ(YYYY-MM-DD hh:mm)!\n            ����YYYY��Χ(" + minYear + "-" + maxYear + "),MM��Χ(1-12),DD��Χ(1-31),\n            hh��Χ(0-23),mm��Χ(0-59)��";
			}
			if (errmsg==""){ pas=true;}
			break;
		case "TIME":
		case "FULLTIME":
		case "SHORTTIME":
			if (valtype=="TIME"||valtype=="SHORTTIME")
			{

				if (!IsTime(value,false))
				{	errmsg = "����������ȷ��ʱ���ʽ��HH:MM��!\n            ����HH��Χ(0-23),MM��Χ(0-59)��";
					break;
				}
			}	
			if (valtype == "FULLTIME")
				if (!IsTime(value,true))
					{	errmsg = "����������ȷ��ʱ���ʽ��HH:MM:SS��!\n            ����HH��Χ(0-23),MM��Χ(0-59),SS��Χ(0-59)��";
						break;
					}
			if (valstr!="")
			{
				val = new Date("1-1-2000 "+value);//js������mmddyyyy��ʽ
				min = sp.Get("Min");max = sp.Get("Max");
				if (min!=null)min = "1-1-2000 "+min;
				if (max!=null)max = "1-1-2000 "+max;
				if ( min!=null && max!=null && (val-new Date(min)<0 ||val-new Date(max)>0 ) )
					errmsg = "��Χ����"+min+"��"+max+"֮�䣡";
				else if (min!=null && val-new Date(min)<0)
					errmsg = "��������"+min+"��";
				else if (max!=null && val-new Date(max)>0)
					errmsg = "��������"+max+"��";
			}
			if (errmsg==""){ pas=true;}
			break;
		case "IDNAME":
		case "PASSWORD":
			if (!IsIDName(value))
			{	errmsg = "������[A~Z,a~z,0~9,_]��ɣ�";
				break;
			}
			if (value.length>50||value.length<4)
			{	errmsg = "���ȱ�����4��50֮�䣡";
				break;
			}
			if (errmsg==""){ pas=true;}
		case "EMAIL":
			if (!IsEmail(value))
			{	errmsg = "�����ǺϷ���E-mail��ʽ��xx@xxx.xxx����";
				break;
			}else{ pas=true;}		
			break;
		case "PHONE":
			if (!IsPhone(value))
				errmsg = "��������绰���룡";
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
	<desc>��ʽ����������,ò��û��</desc>
</doc>**/
function FormatDate(value,Format)
{
	var aDate = value.split("-");
	var sDate = aDate[1] + "-" + aDate[2] + "-" + aDate[0];
	return sDate
}

/**<doc type="function" name="Global.FormatDate">
	<desc>��ʽ����������</desc>
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
	    return "��"+rtnval.substring(1)+".00";
	}
	else
	{
		f3=parseInt(f3*100);
		return "��"+rtnval.substring(1)+"."+f3;
	}
} 

//
//--------------------------------ValidateResult���������-------------------------------------
//

/**<doc type="objdefine" name="PopupWin">
	<desc>��֤���۶�����</desc>
	<property>
		<prop name="left" type="boolean">Popupҳ��λ��</prop>
		<prop name="top" type="string">Popupҳ��λ��</prop>
		<prop name="width" type="string">Popupҳ���</prop>
		<prop name="height" type="string">Popupҳ���</prop>
		<prop name="relele" type="string">Popupҳ���Ԫ��</prop>
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
	<desc>��ȡPopupҳ���document</desc>
</doc>**/
PopupWin.prototype.GetDocument = function()
{	return this.popupWin.document;
}

/**<doc type="protofunc" name="PopupWin.Show">
	<desc>��ʾPopupҳ��</desc>
</doc>**/
PopupWin.prototype.Show = function()
{	this.popupWin.show(this.popLeft,this.popTop,this.popWidth,this.popHeight,this.popRelativeElement);
}

/**<doc type="protofunc" name="PopupWin.Hide">
	<desc>����Popupҳ��</desc>
</doc>**/
PopupWin.prototype.Hide = function()
{	this.popupWin.hide();
}

// �洢��ǰ��Popupҳ��
var _curDropPopupWin =null;
/**<doc type="function" name="Global.DropPopupWin">
	<desc>��ʾPopupҳ��</desc>
	<input>
		<param name="pop" type="object">ָ��PopupWin����</param>
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
//--------------------------------ȫ�ֶ������ʵ�����忪ʼ---------------------------------------------------
//




//
//---------------------------------��Ƕ���뿪ʼ--------------------------------------------------------------
//
/**<doc type="inline" name="Global.SetErrorHandle">
	<desc>���ô�������</desc>
</doc>**/
//window.onerror = OnError;
window.onresize = function(){try{document.body.focus();}catch(e){}};

/**<doc type="objdefine" name="CallBack">
	<desc>�ص�����</desc>
	<input>
		<param name="name" type="string">������</param>
		<param name="fromobj" type="object">����Դ</param>
		<param name="callback" type="object">Function����</param>
		<param name="timeout" type="number">�����ӳ�ʱ��</param>
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
	<desc>ִ�лص�����,���Ӷ�����ȥ���˶���</desc>
</doc>**/
CallBack.prototype.Exec=function()
{	var rtn=Attachs[this.Name].CallBack(Attachs[this.Name].FromObject);
	if(rtn == false)return;
	Attachs[this.Name]=null;
	delete(Attachs[this.Name]);
}

/**<doc type="protofunc" name="CallBack.ClearTimeout">
	<desc>���������TimeoutHandle</desc>
</doc>**/
CallBack.prototype.ClearTimeout=function()
{	window.clearTimeout(this.TimeoutHandle);
	this.TimeoutHandle=-1;
}

/**<doc type="protofunc" name="CallBack.SetTimeout">
	<desc>����ʱ���ӳ�</desc>
	<input>
		<param name="time" type="number">ʱ���ӳ���</param>
	</input>
</doc>**/
CallBack.prototype.SetTimeout=function(time)
{	if(!time)time=100;
	this.TimeoutHandle=window.setTimeout("Attachs['"+this.Name+"'].Exec();",time);
}


/**<doc type="function" name="Global.DoBodyMouseDown">
	<desc>ִ��document.body��onmousedown������������ص���</desc>
</doc>**/
function DoBodyMouseDown()
{	
	for(var name in Attachs)
	{	if(Attachs[name])Attachs[name].Exec();
	}
}

/**<doc type="function" name="Global.AttachBodyMouseDown">
	<desc>��ָ����������document.body��onmousedown������</desc>
	<input>
		<param name="name" type="string">�ص�������</param>
		<param name="fromobj" type="object">Դ����</param>
		<param name="callback" type="function">�ص�����</param>
		<param name="timeout" type="number">ʱ���ӳ���</param>
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
//---------------------------------��Ƕ�������--------------------------------------------------------------
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
	<desc>��ʾ�ȴ���</desc>
	<input>
		<param name="msg" type="string">�ȴ���ʾ����</param>
		<param name="process" type="func/number">������ʾ(func:���Ȱٷֱ��ṩ����,�������뷵��0-1������,����������1ʱ���صȴ���;number:�ȴ�����ʾ��ʱ�䵥λΪ��)</param>
	</input>
</doc>**/
function ShowWaitting(msg,process)
{
    var win = ShowWaitting.HideTop?window.top:window;
    var width =win.document.body.offsetWidth
    var height=win.document.body.offsetHeight;
    if(typeof(msg)=="undefined")
        msg="����ִ�в����������Ե�...";
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
	<desc>���صȴ���</desc>
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
	<desc>��ʾ�ȴ���</desc>
	<input>
		<param name="msg" type="string">�ȴ���ʾ����</param>
		<param name="processProvider" type="func/number">������ʾ(func:���Ȱٷֱ��ṩ����,�������뷵��0-1������,����������1ʱ���صȴ���;number:�ȴ�����ʾ��ʱ�䵥λΪ��)</param>
		<param name="execFunc" type="func">�ȴ����ִ�еĺ���(��ѡ)</param>
		<param name="callback" type="func">�ȴ�����ʱִ�еĺ���(��ѡ)</param>
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
	��ָ��JcTable����World����ʽ��
	</desc>
	<input>
		<param name="ele" type="object">ָ��JcTableԪ��</param>
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
	<desc>�������ĵ�����Word</desc>
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
	<desc>��ָ��table����Excel</desc>
	<input>
		<param name="ele" type="object">ָ��Ԫ��</param>
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
	<desc>��ָ��Ԫ�ص���Excel����ʽ��</desc>
	<input>
		<param name="ele" type="object">ָ��Ԫ��</param>
		<param name="changeStyle" type="bool">�Ƿ����һ��</param>
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
	//����Ե
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
	<desc>����jctable�߶�ʹ����</desc>
	<input>
		<param name="jctableId" type="string">jctable�ؼ�Id��</param>
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
	�����ɰ�,һ���ڵȴ����ֹ�û�����ʱʹ��
	</desc>
	<input>
		<param name="zIndex" type="number">�ɰ��zIndex</param>
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
	��ָ��Ԫ�ص�λ��Ӧ������һ����
	</desc>
	<input>
		<param name="aEle" type="object">�ο�Ԫ��</param>
		<param name="bEle" type="object">��Ӧ��Ԫ��</param>
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
                                FieldTitles:"����,����"};
AutoCompleteModel.BasicSelectProject = {
                                TableName:"BEPROJECT_DEVELOPER.PrjBasicInfo",
                                FieldNames:"Code,Name,ManagerName", 
                                FieldMatch:"Name",
                                FieldWidths:"20,60,20",
                                FieldTitles:"���,����,��Ŀ����"};
 AutoCompleteModel.BasicSelectMajor = {
                                TableName:"BEPROJECT_DEVELOPER.MajorAndDeptMap",
                                FieldNames:"MajorKey,MajorName", 
                                FieldMatch:"MajorName",
                                FieldWidths:"30,70",
                                FieldTitles:"����,����"}; 
  AutoCompleteModel.BasicSelectCustomer = {
                                TableName:"BEMARKET_DEVELOPER.Market_Customer",
                                FieldNames:"Code,SimpleName", 
                                FieldMatch:"Code",
                                FieldWidths:"30,70",
                                FieldTitles:"���,����"};       

  AutoCompleteModel.BasicSelectDept = {
                                TableName:"BEADMIN_DEVELOPER.VW_DEPTLEARLIST",
                                FieldNames:"Dept", 
                                FieldMatch:"Dept",
                                FieldWidths:"100",
                                FieldTitles:""};                                                             

   function AsynExecuteDemo(url,action,xmlsrcId,maskLayerId,method){
	var acturl = url+"";
	var data = _GetSubmitDs(arguments,5);
	var hrf =  document.createElement("<A href='"+url+"'>");//URL��ʽ��
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
		execdata = _data.replace(/\xB7/g,"%B7");//���ڷ�������Request�����е㣬����ʱ�����ʺ�
		execdata = escape(_data).replace(/\+/g,"%2B")//���ڷ�������Request����"+"����ʱ���ɿո�
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








