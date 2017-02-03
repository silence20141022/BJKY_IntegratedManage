var Co={};
var CoArray=new Array();
function InitDocument()
{
	var jcs=GetJcElements(document);
	for(var i=0;i<jcs.length;i++)
	{	var type=null;
		if(jcs[i].Co)continue;//已经初始化
		var tag=jcs[i].tagName.toLowerCase();
		if(tag=="input")
		{	if(jcs[i].type=="text"||jcs[i].type=="password"||jcs[i].type=="hidden")
				type="jctext";
			else if(jcs[i].type=="checkbox")
				type="jccheckbox";
		}else if(tag=="select")
			type="jcselect";
		else if(tag =="textarea")
			type="jctextarea";
		else 
		{ 	type=jcs[i].getAttribute("jctype");

		}
		if(InputElements.indexOf(type.toLowerCase())<0)continue;
		
		var obj=null;
		switch(type.toLowerCase())
		{	case "jctext":obj=new JcText(jcs[i]);break;
			case "jctextarea":obj=new JcTextArea(jcs[i]);break;
			case "jcselect":obj=new JcSelect(jcs[i]);break;
			case "jccheckbox":obj=new JcCheckBox(jcs[i]);break;
			case "jcradiogrp":obj=new JcRadioGrp(jcs[i]);break;
			case "jcupdown":obj=new JcUpDown(jcs[i]);break;
			case "jcdropdown":obj=new JcDropDown(jcs[i]);break;
			case "jcpopup":obj=new JcPopUp(jcs[i]);break;
			case "jcfile":obj=new JcFile(jcs[i]);break;
			case "jcenum":obj=new JcEnum(jcs[i]);break;
			case "jcgrid":obj=new JcGrid(jcs[i]);break;
			case "jcrep":obj=new JcRep(jcs[i]);break;
			case "jcgridnew":obj=new JcGridNew(jcs[i]);break;
			case "jcsign":obj=new JcSign(jcs[i]);break;
			case "jcsignpic":obj=new JcSignPic(jcs[i]);break;
			case "jcsignmutli":obj=new JcSignMutli(jcs[i]);break;
			case "jcgridtable":obj=new JcGridTable(jcs[i]);break;
			case "jcuserselect":obj=new JcUserSelect(jcs[i]);break;
		}
		if(obj)CoArray[CoArray.length]=obj;
		if(obj && jcs[i].id){Co[jcs[i].id]=obj;}
	}

	for(var i=0;i<jcs.length;i++)
	{	var type=null;
		var tag=jcs[i].tagName.toLowerCase();
		if(jcs[i].Co)continue;//已经初始化
		if(tag=="form")
			type="jcform";
		else			
			type=jcs[i].getAttribute("jctype");
		var obj=null;
		if(!type || InputElements.indexOf(type)>0)continue;
		switch(type.toLowerCase())
		{	case "jcform":obj=new JcForm(jcs[i]);break;
			case "jctree":obj=new JcTree(jcs[i]);break;
			case "jctable":obj=new JcTable(jcs[i]);break;
			case "jcbutton":
			if(jcs[i].getAttribute("IsEnterKey")=="true")
			{
				_defaultSubmitBtn =jcs[i];
			}
			obj=new JcButton(jcs[i]);break;
			case "jctab":obj=new JcTab(jcs[i]);break;
			case "jccoolbar":obj = new JcCoolBar(jcs[i]);break;
			case "jcmenubar":obj = new JcMenuBar(jcs[i]);break;
		}
		if(obj)CoArray[CoArray.length]=obj;
		if(obj && jcs[i].id){Co[jcs[i].id]=obj;}
	}

	document.attachEvent("onkeydown",EnterKeyDown); 
}

window.onbeforeunload=function()
{DestroyDocument();}
function DestroyDocument()
{	try{	
		for(var i=0;i<CoArray.length;i++)
		{	
			if(CoArray[i].Destroy)CoArray[i].Destroy();
			CoArray[i].HtmlEle.Co=null;
			CoArray[i].HtmlEle=null;
			for(var key in CoArray[i])
			{
				CoArray[i][key]=null;
			}
			CoArray[i]=null;
		}
		for(var key in Co)
		{	Co[key]=null;
		}
		CoArray=null;
		Co=null;
	}catch(e){}
}


var _TargetWin=null;
/*
function Submit(url,action,method,data,target)
{	
	var frmhtml="<form ";
	if(url!=null)
		frmhtml+= "action='"+url+"' ";
	if(method!=null)
		frmhtml+= " method='"+method+"'>";
	var submitfrm =  document.createElement(frmhtml);
	var actionfld = document.createElement("<Input type='hidden' name='RequestAction'>");
	actionfld.value = action;
	var valuefld = document.createElement("<Input type='hidden' name='DataStore'>");
	if(typeof(data)=="string")
		valuefld.value = escape(data);
	else if(typeof(data)=="object")
		valuefld.value = escape(data.ToString());
	submitfrm.appendChild(valuefld);
	submitfrm.appendChild(actionfld);
	document.appendChild(submitfrm);
	if(target)
		submitfrm.target = target;
	else if(_TargetWin)
		submitfrm.target = _TargetWin;
	document.body.disabled=true;
	submitfrm.submit();
}*/
function Submit(url,action,method,data,target)
{	
	var frmhtml="<form ";
	if(url!=null)
		frmhtml+= "action='"+url+"' ";
	if(method!=null)
		frmhtml+= " method='"+method+"'>";
	var submitfrm =  document.createElement(frmhtml);
	var actionfld = document.createElement("<Input type='hidden' name='RequestAction'>");
	actionfld.value = action;
	var valuefld = document.createElement("<Input type='hidden' name='DataStore'>");
	if(typeof(data)=="string")
		valuefld.value = escape(data);
	else if(typeof(data)=="object")
		valuefld.value = escape(data.ToString());
	submitfrm.appendChild(valuefld);
	submitfrm.appendChild(actionfld);
	if(method=="get")AddQueryParam(submitfrm);
	document.appendChild(submitfrm);
	if(target)
		submitfrm.target = target;
	else if(_TargetWin)
		submitfrm.target = _TargetWin;
	document.body.disabled=true;
	submitfrm.submit();
}
function AddQueryParam(submitfrm)
{
	var params=GetQueryParams();
	for(var key in params)
	{
		if(key=="RequestAction"||key=="DataStore")continue;
		var fld = document.createElement("<Input type='hidden' name='"+key+"'>");
		fld.value=params[key];
		submitfrm.appendChild(fld);
	}
}

function _GetSubmitDs(nods,from)
{	var ds = new DataStore();
	var nod=null;
	var count = nods.length;
	if(count>from)
		for(var i=from;i<count;i++)
		{	if(typeof(nods[i])=="string")
				nod = GetDsNode(nods[i]);
			else
				nod = nods[i];
			ds.Add(nod);
		}
	return ds;
}
Submit.Post=function(action)
{	
	var ds = _GetSubmitDs(arguments,1);
	Submit(null,action,"post",ds.ToString());
}
Submit.Get=function(action)
{	
	var ds = _GetSubmitDs(arguments,1);
	Submit(null,action,"get",ds.ToString());
}

Submit.PostUrl=function(url,action)
{	var ds = _GetSubmitDs(arguments,2);
	Submit(url,action,"post",ds.ToString());
}
Submit.GetUrl=function(url,action)
{	var ds = _GetSubmitDs(arguments,2);
	Submit(url,action,"get",ds.ToString());
}

	
//判断是否为base64编码
var isBase64Encode = false;
var keyStr = "ABCDEFGHIJKLMNOP" + "QRSTUVWXYZabcdef" + "ghijklmnopqrstuv" + "wxyz0123456789+/" + "=";
function _Encode64(input) {
   input = escape(input);
   var output = "";
   var chr1, chr2, chr3 = "";
   var enc1, enc2, enc3, enc4 = "";
   var i = 0;
   do {
		chr1 = input.charCodeAt(i++);
		chr2 = input.charCodeAt(i++);
		chr3 = input.charCodeAt(i++);

		enc1 = chr1 >> 2;
		enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		enc4 = chr3 & 63;

		if (isNaN(chr2)) {
			enc3 = enc4 = 64;
		} else if (isNaN(chr3)) {
			enc4 = 64;
		}

		output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2) + keyStr.charAt(enc3) + keyStr.charAt(enc4);

		chr1 = chr2 = chr3 = "";
		enc1 = enc2 = enc3 = enc4 = "";
   }
   while (i < input.length);
   return output;
}

//提交客户端DataStore数据
//url--目的URL
//datastr--要提交的DataStore XML字符串
//action--页面的Action代码
function Execute(url,action,data,method){
	var acturl = url+"";
	var hrf =  document.createElement("<A href='"+url+"'>");//URL格式化
	var tg = "DataStore";
	document.appendChild(hrf);
	acturl= hrf.href;
	if(url=="#")
	{	acturl=acturl.replace("#","");
		var pos=acturl.indexOf("?");
		if(pos>0)acturl=acturl.substr(0,pos);
	}
	if (acturl.indexOf("?") > 0)
		acturl = acturl + "&IsExec=True&RequestAction=" + action;
	else
		acturl = acturl + "?IsExec=True&RequestAction=" + action;
	
	var _data = "";
	var execdata="";
	if(typeof(data)=="object")
		_data = data.ToString(); 
	else if(typeof(data)=="string")
		_data = data;
	if(!isBase64Encode)
	{
		execdata = _data.replace(/\xB7/g,"%B7");//由于服务器端Request处理中点，解码时会变成问号
		execdata = escape(execdata).replace(/\+/g,"%2B")//由于服务器端Request处理"+"解码时会变成空格
		execdata = execdata.replace(/\xD7/g,"%D7");//×	// 解决乱码问题
		execdata = execdata.replace(/\xF7/g,"%F7");//÷	// 解决乱码问题
		execdata = execdata.replace(/\xB1/g,"%B1");//±	// 解决乱码问题
	}
	else
	{
		tg="DataStoreBase64";
		execdata = _Encode64(_data);
	}
	var resdata;
	if(!method)method="post";
	if(method.toLowerCase() == "get")
		resdata = GetRequest(acturl+"&"+tg+"="+execdata);
	else
		resdata = PostRequest(acturl,tg+"="+execdata);
		
	return new ExecResult(resdata,acturl,action,_data,method);
}
	

//调用一个URL，Post DataStore,返回一个DataStore对象

Execute.Get=function(action)
{	var ds = _GetSubmitDs(arguments,1);
	return Execute("#",action,ds.ToString(),"get");
}
Execute.Post=function(action)
{	var ds = _GetSubmitDs(arguments,1);
	return Execute("#",action,ds.ToString(),"post");
}
Execute.GetUrl=function(url,action)
{	var ds = _GetSubmitDs(arguments,2);
	return Execute(url,action,ds.ToString(),"get");
}
Execute.PostUrl=function(url,action)
{	var ds = _GetSubmitDs(arguments,2);
	return Execute(url,action,ds.ToString(),"post");
}

//异步调用
Execute.AsyncGet=function(action,callback,showWatting,msg)
{	var ds = _GetSubmitDs(arguments,4);
	AsyncExecute("#",action,ds.ToString(),"get",callback,showWatting,msg);
}
Execute.AsyncPost=function(action,callback,showWatting,msg)
{	var ds = _GetSubmitDs(arguments,4);
	AsyncExecute("#",action,ds.ToString(),"post",callback,showWatting,msg);
}
Execute.AsyncGetUrl=function(url,action,callback,showWatting,msg)
{	var ds = _GetSubmitDs(arguments,5);
	AsyncExecute(url,action,ds.ToString(),"get",callback,showWatting,msg);
}
Execute.AsyncPostUrl=function(url,action,callback,showWatting,msg)
{	var ds = _GetSubmitDs(arguments,5);
	AsyncExecute(url,action,ds.ToString(),"post",callback,showWatting,msg);
}
//AsyncExecute
function AsyncExecute(url,action,data,method,callback,showWatting,msg){
	var acturl = url+"";
	var hrf =  document.createElement("<A href='"+url+"'>");//URL格式化
	var tg = "DataStore";
	document.appendChild(hrf);
	acturl= hrf.href;
	if(url=="#")
	{	acturl=acturl.replace("#","");
		var pos=acturl.indexOf("?");
		if(pos>0)acturl=acturl.substr(0,pos);
	}
	if (acturl.indexOf("?") > 0)
		acturl = acturl + "&IsExec=True&RequestAction=" + action;
	else
		acturl = acturl + "?IsExec=True&RequestAction=" + action;
	
	var _data = "";
	var execdata="";
	if(typeof(data)=="object")
		_data = data.ToString(); 
	else if(typeof(data)=="string")
		_data = data;
	if(!isBase64Encode)
	{
		execdata = _data.replace(/\xB7/g,"%B7");//由于服务器端Request处理中点，解码时会变成问号
		execdata = escape(execdata).replace(/\+/g,"%2B")//由于服务器端Request处理"+"解码时会变成空格
	}
	else
	{
		tg="DataStoreBase64";
		execdata = _Encode64(_data);
	}
	var resdata;
	if(!method)method="post";
	//AsyncParam
	var asyncParam = new AsyncParam(acturl,action,_data,method);
	if(showWatting)
		ShowWaitting(msg);
	if(method.toLowerCase() == "get")
		return AsyncGetRequest(acturl+"&"+tg+"="+execdata,asyncParam,callback,showWatting);
	else
		return AsyncPostRequest(acturl,tg+"="+execdata,asyncParam,callback,showWatting);
}

function AsyncParam(url,action,data,method)
{
	this.url = url;
	this.action = action;
	this.data = data;
	this.method = method;
}

function AsyncPostRequest(url,data,asyncParam,callback,showWatting)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange = function()
	{
		if(xmlhttp.readyState == 4)
		{
			if(showWatting) HideWaitting();
			var rtn = new ExecResult(xmlhttp.responseText,asyncParam.url,asyncParam.action,asyncParam.data,asyncParam.method);
			if(callback && typeof callback == "function")
			{
				try{callback(rtn)}catch(e){};
			}
		}
	}
	xmlhttp.Open("POST",url,true);
	xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlhttp.send(data);
	return xmlhttp;
}
function AsyncGetRequest(url,asyncParam,callback,showWatting)
{
	var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange = function()
	{
		if(xmlhttp.readyState == 4)
		{
			if(showWatting) HideWaitting();
			var rtn = new ExecResult(xmlhttp.responseText,asyncParam.url,asyncParam.action,asyncParam.data,asyncParam.method);
			if(callback && typeof callback == "function")
			{
				try{callback(rtn)}catch(e){};
			}
		}
	}
	xmlhttp.Open("GET",url,true);
	xmlhttp.send();
	return xmlhttp;
}

/**用Execute方式执行的返回结果的统一处理**/
var DbResult=new Array("Successful","SystemError","SqlError","RecordExist","RecordNotExist","RecordHasModified","Unspecified");
//0,1,2,3,4,5,6

function ExecResult(rtndata,url,action,data,method)
{	rtndata = unescape(rtndata);
	this.ExecUrl=url;
	this.ExecAction=action;
	this.ExecData = data;
	this.ExecMethod=method;
	this.ReturnDs=null;
	this.RetrunParam=null;
	this.Result=0;
	this.ErrorMsg=null;
	this.ErrorParam=null;
	this.ErrorSrc=null;
	this.HasError=true;

	if(rtndata.indexOf("<DataStore") != 0)
	{	this.Result = DbResult.SystemError;
		this.ErrorSrc = rtndata;
	}else
	{	try{
			this.ReturnDs=new DataStore(unescape(rtndata));
			this.ReturnParam = this.ReturnDs.Params("ExecReturn");
			if(this.ReturnParam==null)
				throw new Error(0,"Can't find param node in return datastore!");
			this.Result = this.ReturnParam.GetAttr("Result");
			if(this.Result>0)
			{	this.ErrorMsg = this.ReturnParam.GetAttr("ErrorMsg");
				this.ErrorParam = this.ReturnParam.GetAttr("ErrorParam");
			}
		}catch(e)
		{	this.Result=1;
			this.ReturnDs=null;
			this.ErrorSrc = rtndata;
		}
	}
	if(this.Result==0)
		this.HasError=false;
}

ExecResult.prototype.ShowError=function()
{	if(this.Result == 0)return ;
	if(this.Result == DbResult.SystemError)
	{	if(this.ErrorSrc)
		{	}else 
		alert("发生系统错误,请查看系统错误日志!");
	}else	//根据ErrorMsg及ErrorParam构造错误显示
	{
		alert(this.ErrorMsg);
	}
}

ExecResult.prototype.ShowDebug=function()
{	
	//this.ShowError();
	//return;
	try{
		var win = window.open("about:blank","_Error","width=600,height=540,left=0,top=0,resizable=yes,compact");
		if(this.ReturnDs!=null)
			var rtnxml=BeautyXml(this.ReturnDs.ToString());
		else
			var rtnxml = this.ErrorSrc;
		win.document.write("<html><body><table height=100% width=100%>"+
							"<tr style='height:20;font-color:red;font-size:20;'><td>查看调用信息</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>调用地址："+this.ExecUrl+"</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>调用操作："+this.ExecAction+"</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>调用方法："+this.ExecMethod+"</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>调用数据：</td></tr>"+
							"<tr style='font-size:14;'><td><textarea style='width:100%;height:100%;'>"+BeautyXml(this.ExecData)+"</textarea></td></tr>"+
							"<tr style='height:16;font-size:14;'><td>错误类型："+DbResult[this.Result]+"</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>错误信息："+this.ErrorMsg+"</td></tr>"+
							"<tr style='height:16;font-size:14;'><td>返回数据：</td></tr>"+
							"<tr style='height:200;font-size:14;'><td><textarea style='width:100%;height:100%;'>"+rtnxml+"</textarea></td></tr>"+
							"</table></body></html>");
	}catch(e){}
}

function RefreshPage()
{	//window.location.reload();
	try
	{
	if(DoQuery)
		DoQuery();//防止刷新重试
	else
		window.location.reload();
	}
	catch(e)
	{
		window.location.reload();
	}
}
function RefreshPage1()
{	//window.location.reload("/sysmodule/Message/MsgPersonReceiveList.aspx?Type=normal");
    //parent.document.all("WorkArea").src="/sysmodule/Message/MsgnoreadList.aspx?Type=normal";
    window.open("/sysmodule/Message/MsgnoreadList.aspx?Type=normal","","scrollbars=yes,resizable=no, width=850,height=450");
}

/**	返回式关闭窗口，如果是弹出窗口则刷新父窗口，否则返回缺省页面**/
function ReturnClose(pfunc)
{	
   var opener= window.opener;

    if(opener)
	{
		if(!pfunc)
		{
	       opener.setTimeout("RefreshPage();",100);
	    }	
		else
			window.opener.setTimeout(pfunc,100);
		window.close();
	}else
	{	//LinkerTo(DefaultPage);
	}
}

function CancelClose()
{	if(window.opener)
		window.close();
	else
	{	//LinkerTo(DefaultPage);
	}
}


function GotoDefaultPage(system)
{
}

var j=0;
var w=0;
function Hide() {
				if (j%2 == 0 ){
					SearchBar.style.display = "block";
				
				}else{
					SearchBar.style.display = "none";
				}
				j++;	
				}
function ListHeight()
	{
		if (w%2 == 0 ){
				ListShow.src = "/share/image/ToolBar_up.gif";
				ListShow.title = "收缩列表";
				MyTable.childNodes[0].style.height = "100%";
				
			
			}else{
				ListShow.src = "/share/image/ToolBar_down.gif";
				ListShow.title = "展开列表";
				MyTable.childNodes[0].style.height = "266";
				
			}
			w++;	}



var _ToExcelWin=null;
var _TableID=null;
/**<doc type="function" name="Global.ToExcel">
	<desc>将指定对象导出Excel</desc>
	<input>
		<param name="tblid" type="string">指定对象id一般为table</param>
		<param name="xlsurl" type="object">模板xls文件地址</param>
		<param name="index" type="object">导出开始位置</param>
		<param name="range" type="number">导出范围</param>
		<param name="qryfrm" type="number">导出数据的查询表单</param>
		<param name="qryfunc" type="number">导出数据的查询方法</param>
	</input>	
</doc>**/
function ToExcel(tblid,xlsurl,index,range,qryfrm,qryfunc)
{
	_XlsUrl = xlsurl;
	_SheetIndex = index;
	_TableID = tblid;
	_SheetRange = range;
	var win = document.all("ToExcelWin");
	if(!win)
	{
		win = document.createElement("<iframe id=ToExcelWin name=ToExcelWin src='about:blank' style='display:none'>");
		document.body.appendChild(win);
	}
	_ToExcelWin=win;
	var tbl = document.all(tblid);
//	var rpp = tbl.all("RecPerPage");
//	var oldrpp=rpp.value;
	
//	rpp.value=1000;
	_TargetWin="ToExcelWin";
	if(qryfrm)
		var qf = qryfrm;
	else
		var qf =GetDsNode(tbl.getAttribute("QueryForm"));		
	var pi=qf.GetAttr("PageIndex");
	if (pi!=null && pi!="")
	{	var sp = new StringParam(pi);
		sp.Set("RCPP","5000");
		sp.Set("CPN","1");
		qf.SetAttr("PageIndex",sp.ToString());
	}

	if(qryfunc)
		qryfunc();
	else
	{	qf = Co.QueryForm.GetDataForm(qf);//alert(qryfrm.ToString());
		Submit.Post("Query",qf);
	}
	//rpp.value=oldrpp;
	_TargetWin=null;
	_ToExcelWin.attachEvent("onreadystatechange",ToExcel.OnReady);
	_ToExcelWin.attachEvent("onload",ToExcel.OnLoad);
}

/**<doc type="function" name="Global.ToExcel">
	<desc>
	将指定对象导出Excel
	用于图档的导出（出自戴涛组/九江石化）自动获取docSpaceId枚举
	</desc>
	<input>
		<param name="tblid" type="string">指定对象id一般为table</param>
		<param name="xlsurl" type="object">模板xls文件地址</param>
		<param name="index" type="object">导出开始位置</param>
		<param name="range" type="number">导出范围</param>
	</input>	
</doc>**/
function ToExcelForDocument(tblid,xlsurl,index,range)
{	_XlsUrl = xlsurl;
	_SheetIndex = index;
	_TableID = tblid;
	_SheetRange = range;
	var win = document.all("ToExcelWin");
	if(!win)
	{
		win = document.createElement("<iframe id=ToExcelWin name=ToExcelWin src='about:blank' style='display:none'>");
		document.body.appendChild(win);
	}
	_ToExcelWin=win;
	var tbl = document.all(tblid);
//	var rpp = tbl.all("RecPerPage");
//	var oldrpp=rpp.value;
	
//	rpp.value=1000;
	_TargetWin="ToExcelWin";
	var qf =GetDsNode(tbl.getAttribute("QueryForm"));		
	var pi=qf.GetAttr("PageIndex");
	if (pi!=null && pi!="")
	{	var sp = new StringParam(pi);
		sp.Set("RCPP","5000");
		sp.Set("CPN","1");
		qf.SetAttr("PageIndex",sp.ToString());
	}
	var enumForm = Co["nodeTypeIdForm"].GetDataForm("nodeTypeId");
	var docSpaceId = GetDsNode("Rds.Param.DocSpaceId");
	Submit.Get("Query",docSpaceId,enumForm,qf);
	//rpp.value=oldrpp;
	_TargetWin=null;
	_ToExcelWin.attachEvent("onreadystatechange",ToExcel.OnReady);
	_ToExcelWin.attachEvent("onload",ToExcel.OnLoad);
}

/**<doc type="function" name="Global.ToExcelForTreeNodeList">
	<desc>
	将指定对象导出Excel
	用于图档节点的导出（出自戴涛组/九江石化）自动获取docSpaceId和NodeTypeId枚举
	</desc>
	<input>
		<param name="tblid" type="string">指定对象id一般为table</param>
		<param name="xlsurl" type="object">模板xls文件地址</param>
		<param name="index" type="object">导出开始位置</param>
		<param name="range" type="number">导出范围</param>
		<param name="enummap" type="object">导出范围</param>
	</input>	
</doc>**/
function ToExcelForTreeNodeList(tblid,xlsurl,index,range,enummap)
{	_XlsUrl = xlsurl;
	_SheetIndex = index;
	_TableID = tblid;
	_SheetRange = range;
	_EnumMap = enummap;
	
	var win = document.all("ToExcelWin");
	if(!win)
	{
		win = document.createElement("<iframe id=ToExcelWin name=ToExcelWin src='about:blank' style='display:none'>");
		document.body.appendChild(win);
	}
	_ToExcelWin=win;
	var tbl = document.all(tblid);
//	var rpp = tbl.all("RecPerPage");
//	var oldrpp=rpp.value;
	
//	rpp.value=1000;
	_TargetWin="ToExcelWin";
	var qf =GetDsNode(tbl.getAttribute("QueryForm"));		
	var pi=qf.GetAttr("PageIndex");
	if (pi!=null && pi!="")
	{	var sp = new StringParam(pi);
		sp.Set("RCPP","5000");
		sp.Set("CPN","1");
		qf.SetAttr("PageIndex",sp.ToString());
	}
	var enumForm =GetDsNode("Rds.Param.NodeTypeId");
	var docSpaceId = GetDsNode("Rds.Param.DocSpaceId");
	Submit.Get("Query",qf,docSpaceId,enumForm);
	//rpp.value=oldrpp;
	_TargetWin=null;
	_ToExcelWin.attachEvent("onreadystatechange",ToExcel.OnReady);
	_ToExcelWin.attachEvent("onload",ToExcel.OnLoad);
}

/**<doc type="function" name="Global.ToExcel">
	<desc>
	将指定对象导出Excel
	用于图档借阅日志的导出（出自戴涛组/九江石化）自动获取docSpaceId枚举
	</desc>
	<input>
		<param name="tblid" type="string">指定对象id一般为table</param>
		<param name="xlsurl" type="object">模板xls文件地址</param>
		<param name="index" type="object">导出开始位置</param>
		<param name="range" type="number">导出范围</param>
		<param name="ApplyDp" type="object">DataParam传入后台</param>
	</input>	
</doc>**/
function ToExcelForLendLogList(tblid,xlsurl,index,range,ApplyDp)
{	_XlsUrl = xlsurl;
	_SheetIndex = index;
	_TableID = tblid;
	_SheetRange = range;
	var win = document.all("ToExcelWin");
	if(!win)
	{
		win = document.createElement("<iframe id=ToExcelWin name=ToExcelWin src='about:blank' style='display:none'>");
		document.body.appendChild(win);
	}
	_ToExcelWin=win;
	var tbl = document.all(tblid);
//	var rpp = tbl.all("RecPerPage");
//	var oldrpp=rpp.value;
	
//	rpp.value=1000;
	_TargetWin="ToExcelWin";
	var qf =GetDsNode(tbl.getAttribute("QueryForm"));		
	var pi=qf.GetAttr("PageIndex");
	if (pi!=null && pi!="")
	{	var sp = new StringParam(pi);
		sp.Set("RCPP","5000");
		sp.Set("CPN","1");
		qf.SetAttr("PageIndex",sp.ToString());
	}
	//var enumForm =GetDsNode("Rds.Param.NodeTypeId");
	var docSpaceId = GetDsNode("Rds.Param.DocSpaceId");
	Submit.Get("Query",qf,docSpaceId,ApplyDp);
	//rpp.value=oldrpp;
	_TargetWin=null;
	_ToExcelWin.attachEvent("onreadystatechange",ToExcel.OnReady);
	_ToExcelWin.attachEvent("onload",ToExcel.OnLoad);
}



ToExcel.OnReady=function()
{
	var doc=_ToExcelWin.document;
	doc.body.onload=null;
}
var _List=null,_Cols=null,_XlsUrl=null,_SheetIndex=null,_SheetRange=null,_Enums=null;
ToExcel.OnLoad=function()
{
	var doc=_ToExcelWin.document;
	var win=_ToExcelWin.contentWindow;
	var tbl=doc.all(_TableID);
	//_List = win.GetDsNode(tbl.getAttribute("ListData"));
	_List = GetDsNode(tbl.getAttribute("ListData"));
	//span->span->table->tbody->tr->tds
	_Cols=tbl.firstChild.firstChild.firstChild.firstChild.childNodes;
	document.body.disabled=false;
	setTimeout("OutputToExcel();",100);
}
ToExcel.OnLoad=function()
{
	var doc=_ToExcelWin.document;
	var win=_ToExcelWin.contentWindow;
	var tbl=doc.all(_TableID);
	_List = win.GetDsNode(tbl.getAttribute("ListData"));
	_Enums = window.parent._EnumsList;
	if(window._EnumsList)_Enums = window._EnumsList;
	//span->span->table->tbody->tr->tds
	_Cols=tbl.firstChild.firstChild.firstChild.firstChild.childNodes;
	document.body.disabled=false;
	setTimeout("OutputToExcel();",100);
}
function OutputToExcel()
{
	if(_List==null||_Cols==null)return;
	window.open("/share/page/Excel.htm","ToExcel","left=100,top=40,width=800,height=600,resizable=yes,compact");
}
//收发文专用
function ToExcel1(tblid,xlsurl,index,range)
{	_XlsUrl = xlsurl;
	_SheetIndex = index;
	_TableID = tblid;
	_SheetRange = range;
	var win = document.all("ToExcelWin");
	if(!win)
	{
		win = document.createElement("<iframe id=ToExcelWin name=ToExcelWin src='about:blank' style='display:none'>");
		document.body.appendChild(win);
	}
	_ToExcelWin=win;
	var tbl = document.all(tblid);
//	var rpp = tbl.all("RecPerPage");
//	var oldrpp=rpp.value;
	
//	rpp.value=1000;
	_TargetWin="ToExcelWin";
	var qf =GetDsNode(tbl.getAttribute("QueryForm"));		
	var pi="MRC:1000;TRC:37;TPC:3;RCPP:14;CPN:1;CPRC:14;";
	if (pi!=null && pi!="")
	{	var sp = new StringParam(pi);
		sp.Set("RCPP","5000");
		sp.Set("CPN","1");
		qf.SetAttr("PageIndex",sp.ToString());
	}
	Submit.Get("Query",qf);
	//rpp.value=oldrpp;
	_TargetWin=null;
	_ToExcelWin.attachEvent("onreadystatechange",ToExcel.OnReady);
	_ToExcelWin.attachEvent("onload",ToExcel.OnLoad1);
}
ToExcel.OnLoad1=function()
{
	var doc=_ToExcelWin.document;
	var win=_ToExcelWin.contentWindow;
	var tbl=doc.all(_TableID);
	//_List = win.GetDsNode(tbl.getAttribute("ListData"));
	_List = GetDsNode(tbl.getAttribute("ListData"));
	//span->span->table->tbody->tr->tds
	_Cols=tbl.firstChild.firstChild.firstChild.firstChild.childNodes;
	document.body.disabled=false;
	setTimeout("OutputToExcel();",100);
}


//create by tyaloo
//for rich color Enum
	function MakeRichColorEnum(nodePath)
	{
		
		var colorEnum=GetDsNode(nodePath);
		var itemCount=colorEnum.GetItemCount();
		for(var i=0;i<itemCount;i++)
		{
			var nowItem=colorEnum.GetItem(i);
			var textColor=nowItem.GetAttr("TextColor");
		
			var textBackColor=nowItem.GetAttr("TextBackColor");
			if(textColor!=""||textBackColor!="")
			{
				var spanEle=document.createElement("span");
				spanEle.style.color=textColor;
				spanEle.style.width=nowItem.GetAttr("TextBackWidth");
				spanEle.style.height=nowItem.GetAttr("TextBackHeight");
				spanEle.style.backgroundColor=textBackColor;
				spanEle.innerText=nowItem.GetAttr("Text");
				nowItem.SetAttr("Text",spanEle.outerHTML)
			}
		}
	}

var _defaultSubmitBtn;
function EnterKeyDown()
{
	var keyCode=event.keyCode;
	if(keyCode==13&&_defaultSubmitBtn!=null&&_defaultSubmitBtn.style.display!="none"&&!_defaultSubmitBtn.disabled)
	{
		event.returnValue=false;
		event.cancel=true;
		_defaultSubmitBtn.click();
	}
}

// 
function pageX(elem){
	return elem.offsetParent ?
		//如果能继续获得上一个元素，增加当前的偏移量并继续向上递归
		elem.offsetLeft + pageX(elem.offsetParent) :
		//否则，获取当前的偏移量
		elem.offsetLeft;
}

function pageY(elem){
	return elem.offsetParent?elem.offsetTop + pageY(elem.offsetParent) : elem.offsetTop;
}

//流程跟踪 add by meteorcui 2008-9-25
function FlowTrace(flowId)
{
    if(flowId)
    {
        var _link = "/workflow/businessframe/FlowTraceList.aspx?FlowId=" +flowId;
		LinkTo(_link,"_Blank",CenterWin("width=1020,height=800,status=no,scrollbars=n"));
    }
    else
    {
		var items=Co["MyTable"].GetSelected();
		if (items.length != 1) 
		{
			alert("请选择一条记录") ; 
			return;
		}
		else
		{
			var formId = items[0].GetAttr("Id");
			if( formId == "" )
			{
				alert("请选择记录!");
				return;
			}
			
			var _link = "/workflow/businessframe/FlowTraceList.aspx?FormId=" +formId;
			LinkTo(_link,"_Blank",CenterWin("width=1020,height=800,status=no,scrollbars=n"));
		}
	}
}	