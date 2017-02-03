
/** all for IntelliSense **/
/**************************
 *      Static Member
 **************************/
FlowEditor.GridUnit = 8;    //FlowEditor的Grid象素
FlowEditor.StepWidth = 80;
FlowEditor.StepHeight = 60;
FlowEditor.ElementTypes = "Step,Cntor,Memo,Fields";
FlowEditor.StepProps = "Color,BkColor,Font,Border";
FlowEditor.CntorProps = "Color,DashStyle,DescColor,DescFont,StartArrow,EndArrow";
FlowEditor.MemoProps = "Color,BkColor,Font";
FlowEditor.Theme = "/workflow/images/newFlow/32/";
/**************************
 *     Instance Member
 **************************/
FlowEditor.prototype._htmlEle = null;    //editor container
FlowEditor.prototype._editor = null;    //editor(div element)
FlowEditor.prototype._maxIndex = 10000;
FlowEditor.prototype._curElement = null;
FlowEditor.prototype._editMode = "SEL";//select/addnew/movestep/movelinkdescr/movelinkermiddlepoint/movelinkerconnectpoint/moveall    //SEL/NEW/MST/LNK/DES/MID/CNN/ALL
FlowEditor.prototype._linkStep = null;//连接的中间步骤begin/end
FlowEditor.prototype._curHighlight = null;
FlowEditor.prototype._curCtrl = null;
FlowEditor.prototype._curRect = null;
FlowEditor.prototype._preX = null;
FlowEditor.prototype._preY = null;
FlowEditor.prototype._selections = new Array();
FlowEditor.prototype._memoResize = null;
FlowEditor.prototype._defineXml = null;
FlowEditor.prototype._settingXml = "<Setting />";
FlowEditor.prototype._minZIndex = 9999;
FlowEditor.prototype._maxZIndex = 20000;

FlowEditor.prototype._addLeft = -FlowEditor.GridUnit;
FlowEditor.prototype._addTop = -FlowEditor.GridUnit;

FlowEditor.prototype.EventArgs = new Object();

FlowEditor.prototype._isReadonly = false;
FlowEditor.prototype._isHideBorder = false;


/**<doc type="objdefine" name="FlowEditor">
	<desc>FlowEditor编辑类，用于流程图UI编辑处理</desc>
	<input>
		<param name="ele" type="object">构建FlowEditor的HtmlEle载体</param>
	</input>
</doc>**/
function FlowEditor(ele)
{
    this._initialize(ele);
}

/**<doc type="protofunc" name="FlowEditor._initialize">
	<desc>FlowEditor的构建器</desc>
	<input>
		<param name="ele" type="object">构建FlowEditor的HtmlEle载体</param>
	</input>
</doc>**/
FlowEditor.prototype._initialize = function(ele)
{
    this._initParameter(ele);
    this._initComponent();
    this._initEvent();
    this._loadFlow();
}

/**<doc type="protofunc" name="FlowEditor._initialize">
	<desc>初始化FlowEditor相关属性</desc>
	<input>
		<param name="ele" type="object">构建FlowEditor的相关参数，只读等</param>
	</input>
</doc>**/
FlowEditor.prototype._initParameter = function(ele)
{
    this._htmlEle = ele;    //editor container
    this._htmlEle.Editor = this;
    this._editor = null;    //editor(div element)
	var readonly = this._htmlEle.getAttribute("Readonly");
	if(readonly && readonly.toLowerCase() == "true")
		this._isReadonly = true;
	else
		this._isReadonly = false;
    this._reset();
}

FlowEditor.prototype._initComponent = function()
{
    var div = document.createElement("<div id='editorContainer' class='editor' unselectable='on' style='background-image:url(/share/image/flow/grid.jpg)'>");
    this._editor = div;
    this._htmlEle.appendChild(div);
}

FlowEditor.prototype._initEvent = function()
{
    var editor = this._editor;
    if(this._isReadonly)
    {
		editor.attachEvent("onmousedown",FlowEditor.ReadonlyMouseDown);
    }
    else
    {
		editor.attachEvent("onmousemove",FlowEditor.MouseMove);
		editor.attachEvent("onmousedown",FlowEditor.MouseDown);
		editor.attachEvent("onmouseup",FlowEditor.MouseUp);
		editor.attachEvent("onkeydown",FlowEditor.KeyDown);
		document.body.attachEvent("onkeydown",FlowEditor.KeyDown);
    }
}

FlowEditor.prototype._reset = function()
{
    if(this._editor)
        this._editor.innerHTML = "";
    this._maxIndex = 10000;
    this._minZIndex = 9999;
    this._maxZIndex = 20000;
    this._curElement = null;
    this._editMode = "SEL";//select/addnew/movestep/movelinkdescr/movelinkermiddlepoint/movelinkerconnectpoint/moveall    //SEL/NEW/MST/LNK/DES/MID/CNN/ALL
    this._linkStep = null;//连接的中间步骤begin/end
    this._curHighlight = null;
    this._curCtrl = null;
    this._curRect = null;
    this._preX = null;
    this._preY = null;
    this._selections = [];
    this._defineXml = null;
    this._settingXml = "<Setting />";
	this.EventArgs = {};
    //html element attribute
    var flowData = this._htmlEle.getAttribute("FlowData");
    if(flowData)
    {
		var defineXml = null;
		defineXml = GetDsNode(flowData).GetXmlValue();
		if(defineXml != null)
		{
			this._defineXml = defineXml;
		}
		else
		{
			alert("flowdata error!");
		}
	}
	var hideBorder = this._htmlEle.getAttribute("HideBorder");
	if(hideBorder && hideBorder.toLowerCase() == "true")
		this._isHideBorder = true;
	else
		this._isHideBorder = false;
}

FlowEditor.prototype._loadFlow = function()
{
    if(this._defineXml)
        this._setFlowXml(this._defineXml);
}

//每个一个环节的UI
FlowEditor.prototype._createStep1 = function(type,name,iconURL)
{
	var img = FlowEditor.Theme + ((iconURL!="")?iconURL:type) + ".GIF";
	
	var left = this._getAddLeft(FlowEditor.StepWidth);
	var top = this._getAddTop(FlowEditor.StepHeight);
	var data = "";
	data = this.GetInitData("Step",name);
	var div = document.createElement("<div id='ID" + (this._maxIndex) + "' Type='Step' TaskType='" + type + "' class='Step' style='left:" + left + ";top:" + top + "px;display:none;z-index:" + this._maxIndex++ + "'>");
	if(this._isHideBorder)
		div.style.border = "solid 1 white";
	var html = "<span style='position: relative'>";
	html += "<table id='_body' class='StepBody' height=100% cellspacing='0' cellpadding='0' width='100%' border='0'><tbody>";
	html += "<tr height='32'><td vAlign='middle' align='center'><img id='_img' src='" + img + "'></td></tr>";
	html += "<tr><td vAlign='middle' align='center' id='_name'>" + name + "</td></tr></tbody></table>";
	html += "<span id='_cntp' style='display:none;'>";
	html += this._getSetpCntorPoint(FlowEditor.StepWidth,FlowEditor.StepHeight)+"</span>";
	html += "<xml id='_data'><Step><Visual/><Data>" + data + "</Data></Step></xml></span>";
	div.innerHTML = html;
	this._editor.appendChild(div);
	this._clearSelect();
	this._curElement = div;
	this._selectElement(div,true);
	return div;
}
FlowEditor.prototype._createStep = function(type,name)
{
	var img = FlowEditor.Theme + type + ".png";
	var left = this._getAddLeft(FlowEditor.StepWidth);
	var top = this._getAddTop(FlowEditor.StepHeight);
	var data = "";
	data = this.GetInitData("Step",name);
	var div = document.createElement("<div id='ID" + (this._maxIndex) + "' Type='Step' TaskType='" + type + "' class='Step' style='left:" + left + ";top:" + top + "px;display:none;z-index:" + this._maxIndex++ + "'>");
	if(this._isHideBorder)
		div.style.border = "solid 1 white";
	var html = "<span style='position: relative'>";
	html += "<table id='_body' class='StepBody' height=100% cellspacing='0' cellpadding='0' width='100%' border='0'><tbody>";
	html += "<tr height='32'><td vAlign='middle' align='center'><img id='_img' src='" + img + "'></td></tr>";
	html += "<tr><td vAlign='middle' align='center' id='_name'>" + name + "</td></tr></tbody></table>";
	html += "<span id='_cntp' style='display:none;'>";
	html += this._getSetpCntorPoint(FlowEditor.StepWidth,FlowEditor.StepHeight)+"</span>";
	html += "<xml id='_data'><Step><Visual/><Data>" + data + "</Data></Step></xml></span>";
	div.innerHTML = html;
	this._editor.appendChild(div);
	this._clearSelect();
	this._curElement = div;
	this._selectElement(div,true);
	return div;
}

FlowEditor.prototype._removeStep = function(step)
{
	var cntp = step.all("_cntp");
	var cnts = cntp.childNodes;
	var cntc = cnts.length;
	for(var i=0;i<cntc;i++)
	{	
	    var rid = cnts[i].getAttribute("Router");
		if(rid && rid != "")
		{
			var rids = rid.split(",");//一个连接点上有多条路由
			var ridc = rids.length;
			for(var j=0;j<ridc;j++)
			{	
				if(rids[j] != "")
				{
					var cntor = this._editor.all(rids[j]);
					this._removeRouter(cntor);
				}
			}		
		}
	}
	this._editor.removeChild(step);
}
//添加路由
FlowEditor.prototype._createRouter = function(cx,cy,x,y)
{
	var pstr = x + "," + y + "," + x + "," + y;
	var data = "";
	data = this.GetInitData("Cntor");
	var div = document.createElement("<div id='ID" + (this._maxIndex) + "' Type='Cntor' RouterType='Strong' Points='" + pstr + "' style='position:absolute;left:" + cx + ";top:" + cy + ";display:none;z-index:" + this._maxIndex++ + "'>");
	var html = "<span style='position:relative'>";
	html += "<v:polyline id='_line' style='cursor:hand;position:absolute;' points='" + pstr + "' filled='f' strokecolor='black'>";
	html += "<v:stroke startarrow='oval' endarrow='classic'dashstyle='solid' endarrowlength='long'></v:stroke>";
	html += "</v:polyline>";
	html += "<span id='_desc' style='display:none;cursor:move;position:absolute;word-break:keep-all;'></span>";
	html += "<span id='_ctrl'></span><xml id='_data'><Cntor><Visual/><Data>" + data + "</Data></Cntor></xml></span>";
	div.innerHTML = html;
	this._editor.appendChild(div);
	return div;
}
//移除路由
FlowEditor.prototype._removeRouter = function(r)
{
	if(r.StartStep)
	{
		var step = this._editor.all(r.StartStep);
		var cnt = step.all("_cntp").childNodes[r.StartIndex];
		this._setCntorRouter(cnt,"remove",r.id,"start");
		//Sync Step Data
		this.SyncStepData(step);
	}
	if(r.EndStep)
	{
		var step = this._editor.all(r.EndStep);
		var cnt = step.all("_cntp").childNodes[r.EndIndex];
		this._setCntorRouter(cnt,"remove",r.id,"end");
		//Sync Step Data
		this.SyncStepData(step);
	}
	this._editor.removeChild(r);
}

FlowEditor.prototype._createMemo = function(memo)
{
	if(!memo) memo = "";
	var left = this._getAddLeft(128);
	var top = this._getAddTop(50);
	var data = "";
	data = this.GetInitData("Memo",memo);
	var div = document.createElement("<div id='ID" + (this._maxIndex) + "' Type='Memo' MemoType='Standard' class='Memo' style='left:" + left + ";top:" + top + "px;display:none;z-index:" + this._maxIndex++ + ";width:128px;height:50px;'>");
	var html = "<span style='position: relative'>";
	html += "<v:roundrect id='_body' strokecolor='gray' style='position:relative;width:128px;height:50px;'>";
    html += "<v:shadow on='T' type='single' color='#b3b3b3' offset='5px,5px'/>";
    html += "<v:textbox id='_text' inset='5pt,5pt,5pt,5pt' style='font-size:10.2pt;'>" + memo + "</v:textbox>";
    html += "</v:roundrect>";
    html += "<xml id='_data'><Memo><Visual/><Data>" + data + "</Data></Memo></xml></span>";
	div.innerHTML = html;
	this._editor.appendChild(div);
	this._clearSelect();
	this._curElement = div;
	this._selectElement(div,true);
	return div;
}

FlowEditor.prototype._removeMemo = function(memo)
{
	this._editor.removeChild(memo);
}

FlowEditor.prototype._getAddLeft = function(width)
{
    this._addLeft += FlowEditor.GridUnit;
    if(this._addLeft + width > this._editor.offsetWidth)
        this._addLeft = 0;
    return this._addLeft;
}

FlowEditor.prototype._getAddTop = function(height)
{
    this._addTop += FlowEditor.GridUnit;
    if(this._addTop + height > this._editor.offsetHeight)
        this._addTop = 0;
    return this._addTop;
}

FlowEditor.prototype._drawRect = function(left,top)
{
    var div = document.createElement("<div style='position:absolute;filter:alpha(opacity=30);background-color:#A5A5D2;z-index:10000000;overflow:hidden;border:dotted 1 blue;left:" + left + ";top:" + top + ";width:1;height:1;'>");
	this._editor.appendChild(div);
	return div;
}

FlowEditor.prototype._getSelections = function(left,top,width,height)
{
	var eles = this._editor.childNodes;
	for(var i=0;i<eles.length;i++)
	{
	    var type = eles[i].getAttribute("Type");
		if(type == "Step")
		{	
		    var step = eles[i];
			if( step.offsetLeft >= left && step.offsetTop >= top && 
				step.offsetLeft + step.offsetWidth <= left + width &&
				step.offsetTop + step.offsetHeight <= top + height )
		    {
			    this._selections[this._selections.length] = step;
		    }
		}
		else if(type == "Memo")
		{	
		    var memo = eles[i];
			if( memo.offsetLeft >= left && memo.offsetTop >= top && 
				memo.offsetLeft + memo.offsetWidth <= left + width &&
				memo.offsetTop + memo.offsetHeight <= top + height )
		    {
			    this._selections[this._selections.length] = memo;
		    }
		}
		else if(type == "Cntor")
		{
			var cnt=eles[i];
			var l = left - cnt.offsetLeft;//获得相对坐标
			var t = top - cnt.offsetTop;
			var ps = cnt.getAttribute("Points").split(",");
			var isin = true;
			for(var j=0;j<ps.length;j+=2)//测试所有点
			{
				var x = parseInt(ps[j]);
				var y = parseInt(ps[j+1]);
				if(!(x >= l && x < l + width))
					isin = false;
				if(!(y >= t && y < t + height))
					isin = false;
				if(!isin) break;	
			}
			if(isin)
				this._selections[this._selections.length] = cnt;
		}
	}
	for(var i=0;i<this._selections.length;i++)
	{
	    var ele=this._selections[i];
		if(ele.Type == "Step")
		{
			ele.setAttribute("preborder",ele.style.border);
			ele.style.border = "solid 1 blue";
		}
		if(ele.Type == "Cntor") 
		{
			ele.setAttribute("prestrokecolor","" + ele.all("_line").strokecolor);//vml attribute is different from html attribute
			ele.setAttribute("predesccolor",ele.all("_desc").style.color);
		    ele.all("_line").strokecolor = "blue";
		    ele.all("_desc").style.color = "blue";
		}
		if(ele.Type == "Memo")
		{
			ele.setAttribute("prestrokecolor",ele.all("_body").strokecolor + "");//vml attribute is different from html attribute
			ele.all("_body").strokecolor = "blue";
		}
	}
}

FlowEditor.prototype._clearSelections = function()
{
	for(var i=0;i<this._selections.length;i++)
	{
		var ele = this._selections[i];
		if(ele.Type == "Step")
		{
			if(this._isHideBorder)
				ele.style.border = "solid 1 white";
			else
			{
				var preBorder = ele.getAttribute("preborder");
				if(!preBorder) preBorder = "solid 1 gray";
				ele.style.border = preBorder;
			}
		}
		if(ele.Type == "Cntor")
		{
			var preStrokecolor = ele.getAttribute("prestrokecolor");
			if(!preStrokecolor) preStrokecolor = "black";
			var preDesccolor = ele.getAttribute("predesccolor");
			if(!preDesccolor) preDesccolor = "black";
			ele.all("_line").strokecolor = preStrokecolor;
			ele.all("_desc").style.color = preDesccolor;
		}
		if(ele.Type == "Memo")
		{
			var preStrokecolor = ele.getAttribute("prestrokecolor");
			if(!preStrokecolor) preStrokecolor = "gray";
			ele.all("_body").strokecolor = preStrokecolor;
		}
	}
	this._selections = new Array();
}

FlowEditor.prototype._removeSelections = function()
{
    var length = this._selections.length;
	for(var i=0;i<length;i++)
	{
		if(this._selections[i].Type == "Step") this._removeStep(this._selections[i]);
		if(this._selections[i].Type == "Memo") this._removeMemo(this._selections[i]);
	}
	this._selections = new Array();
}
//element是否在selections集合里
FlowEditor.prototype._isElementInSelections = function(element)
{
    var length = this._selections.length;
	for(var i=0;i<length;i++)
		if(this._selections[i] == element)
		    return true;
	return false;
}

FlowEditor.prototype._getSnapCntor = function(step)
{
	var cntp = step.all("_cntp");
	if(!cntp) return;
	var cnts = cntp.childNodes;
	if(cnts.length <= 0) return;
	for(var i=0;i<cnts.length;i++)
		if(cnts[i].style.backgroundColor == "red")
			return cnts[i];
	return null;
}

FlowEditor.prototype._setCntorRouter = function(cnt,action,rid,pos)
{
	var r = cnt.getAttribute("Router");
	if(!r) r = "";
	var p = cnt.getAttribute("Position");
	if(!p) p = "";
	var nr = "";
	var np = "";
	if(action == "add")
	{
		nr = r+ ((r=="")?"":",") + rid;
		np = p+ ((p=="")?"":",") + pos;
	}
	else if(action=="remove")
	{
		var rs = r.split(",");
		var ps = p.split(",");
		for(var i=0;i<rs.length;i++)
		{
			if(rs[i] != rid && rs[i] != "")
			{	nr += rs[i] + ",";
				np += ps[i] + ",";
			}	
		}
		if(nr != "") nr=nr.substr(0,nr.length - 1);
		if(np != "") np=np.substr(0,np.length - 1);
	}
	cnt.setAttribute("Router",nr);
	cnt.setAttribute("Position",np);
}
//设置路由元素的点
FlowEditor.prototype._setRouterPoint = function(cnt,pindex,rx,ry,xymode,mindex)
{
	var ln = cnt.all("_line");
	var dc = cnt.all("_desc");
	var ps = cnt.getAttribute("Points").split(",");
	var pi = -1;//点在线中的索引位置
	if(pindex == "start") pi=0;
	if(pindex == "end") pi=ps.length/2-1;
	if(pindex == "add") pi=ps.length/2;
	if(pindex == "insert") pi=mindex;
	if(pindex == "remove") pi=mindex;
	if(typeof(pindex)=="number") pi=pindex;
	var x=0,y=0;
	if(xymode == "delta")//偏移量
	{
		x = parseInt(ps[pi * 2]) + rx;
		y = parseInt(ps[pi * 2 + 1]) + ry;
	}
	else if(xymode=="relative")//相对连接元素
	{	
		x = rx;
		y = ry;
	}
	else//相对this._editor
	{
		x = rx - cnt.offsetLeft;
		y = ry - cnt.offsetTop;
	}
	
	var pstr = "";
	if(pi * 2 >= ps.length)//添加
		pstr += cnt.getAttribute("Points") + "," + x + "," + y;
	else
	{
		for(var i=0;i<ps.length;i+=2)
		{	
			if(i/2 == pi)
			{	if(pindex == "insert")
					pstr += ps[i] + "," + ps[i+1] + "," + x + "," + y + ",";//插入
				else if(pindex != "remove")
					pstr += x + "," + y + ",";//更新
			}
			else
				pstr += ps[i] + "," + ps[i+1] + ",";
		}	
		pstr=pstr.substr(0,pstr.length - 1);
	}
	cnt.setAttribute("Points",pstr);
	ln.points.Value = pstr;
	//set desc position
	this._setDescPosition(dc,cnt.getAttribute("Points"));
}

FlowEditor.prototype._setDescPosition = function(desc,points)
{
	if(desc.style.display == "")
	{
		var ps = points.split(",");
	    var left=0,top=0;
	    if(ps.length % 4 == 2)
	    {
    	    left = ps[ps.length / 2 - 1];
    	    top = ps[ps.length / 2];
	    }
	    else
	    {
	        var p0 = ps[ps.length / 2 - 1];
	        var p1 = ps[ps.length / 2];
	        left = Math.round((parseInt(ps[ps.length / 2 - 2]) + parseInt(ps[ps.length / 2])) / 2);
	        top = Math.round((parseInt(ps[ps.length / 2 - 1]) + parseInt(ps[ps.length / 2 + 1])) / 2);
	    }
	    desc.style.left = left?left:desc.style.left;
	    desc.style.top = top?top:desc.style.top;
	}
}
//存储环节元素连接连接线的状态
FlowEditor.prototype._storeRouterPoint = function(step)
{
	var cntp = step.all("_cntp");
	var cnts = cntp.childNodes;
	var cntc = cnts.length;
	for(var i=0;i<cntc;i++)
	{
		var rid = cnts[i].getAttribute("Router");
		if(rid && rid != "")
		{
			var rids = rid.split(",");
			var points = "";
			for(var j=0;j<rids.length;j++)
			{	
				if(rids[j] != "")
				{
					var cntor = this._editor.all(rids[j]);
					points += cntor.getAttribute("Points") + "|";
				}
			}
			points = points.substr(0,points.length - 1)
			cnts[i].setAttribute("PrePoints",points);
		}
	}
}
//移动环节元素时同时移动路由元素
FlowEditor.prototype._setStepRouter = function(step,dx,dy)
{
	var cntp = step.all("_cntp");
	var cnts = cntp.childNodes;
	var cntc = cnts.length;
	for(var i=0;i<cntc;i++)
	{
		var rid=cnts[i].getAttribute("Router");
		if(rid && rid != "")
		{
			var rids = rid.split(",");//一个连接点上有多条路由
			var poss = cnts[i].getAttribute("Position").split(",");
			var pary = cnts[i].getAttribute("PrePoints").split("|");
			for(var j=0;j<rids.length;j++)
			{	
				if(rids[j] != "")
				{
					var cntor = this._editor.all(rids[j]);
					var x,y;
					//如果路由在选择集合内,且其相连的两个环节也在集合内,则不调整位置,为了实现多元素平移
					if(this._isElementInSelections(cntor))
					{
						if(this._isElementInSelections(this._editor.all(cntor.StartStep))&&
							this._isElementInSelections(this._editor.all(cntor.EndStep)))continue;
					}
					var ps = pary[j].split(",");
					var pos = poss[j];
					if(pos == "start")
					{
						x = parseInt(ps[0]);
						y = parseInt(ps[1]);
					}
					else if(pos == "end")
					{
						var x = parseInt(ps[ps.length - 2]);
						var y = parseInt(ps[ps.length - 1]);
					} 
					this._setRouterPoint(cntor,pos,x + dx,y + dy,"relative");
				}
			}
		}
	}
}

FlowEditor.prototype._setCtrlPoint = function(cntor,state)
{
	if(state)
	{	
	    var ps = cntor.getAttribute("Points").split(",");
		for(var i=0;i<ps.length;i+=2)
		{
			var x = parseInt(ps[i]);
			var y = parseInt(ps[i+1]);
			if(i == 0)
				var cp = document.createElement("<div class='lnkp' Type='Ctrl' Position='start'>");
			else if(i == ps.length-2)
				var cp = document.createElement("<div class='lnkp' Type='Ctrl' Position='end'>");
			else
				var cp = document.createElement("<div class='midp' Type='Ctrl' Position='mid'>");
			cp.style.left = x - 2;
			cp.style.top = y - 2;
			cntor.all("_ctrl").appendChild(cp);
		}
	}
	else
	{
		var ctrl = cntor.all("_ctrl");
		var count = ctrl.childNodes.length;
		for(var i=count-1;i>=0;i--)
			ctrl.removeChild(ctrl.childNodes[i]);
	}
}

FlowEditor.prototype._setHighlight = function(step,state,snapx,snapy)
{
	var cntp = step.all("_cntp");
	if(!cntp) return;
	if(state)
	    cntp.style.display = "";
	else
		cntp.style.display = "none";
	if(!snapx) return;
	var cnts = cntp.childNodes;
	if(cnts.length<=0) return;
	var cntc = cnts.length;
	for(var i=0;i<cntc;i++)
		cnts[i].style.backgroundColor = "transparent";
	var minlen = FlowEditor.getDistance(snapx,snapy,cnts[0]),minindex = 0;
	for(var i=1;i<cntc;i++)
	{
		var tmplen = FlowEditor.getDistance(snapx,snapy,cnts[i]);
		if(minlen > tmplen)
		{
			minlen = tmplen;
			minindex = i;
		}
	}
	cnts[minindex].style.backgroundColor = "red";
}

FlowEditor.prototype._clearSelect = function()
{
	if(this._curElement != null)
		this._selectElement(this._curElement,false);
	this._curElement = null;
}

FlowEditor.prototype._selectElement = function(ele,state)
{
	var type = ele.getAttribute("Type");
	switch(type)
	{
		case "Step":
			if(state)
			{
				ele.setAttribute("preborder",ele.style.border);
				ele.style.border = "solid 1 red";
			}
			else
			{
				if(this._isHideBorder)
					ele.style.border = "solid 1 white";
				else
				{
					var preBorder = ele.getAttribute("preborder");
					if(!preBorder) preBorder = "solid 1 gray";
					ele.style.border = preBorder;
				}
			}
			break;
		case "Cntor":
			if(state)
			{
				ele.setAttribute("prestrokecolor","" + ele.all("_line").strokecolor);//vml attribute is different from html attribute
				ele.setAttribute("predesccolor",ele.all("_desc").style.color);
				ele.all("_line").strokecolor = "red";
				ele.all("_desc").style.color = "red";
				this._setCtrlPoint(ele,true);
				this._curCtrl = null;
			}
			else
			{
				var preStrokecolor = ele.getAttribute("prestrokecolor");
				if(!preStrokecolor) preStrokecolor = "black";
				var preDesccolor = ele.getAttribute("predesccolor");
				if(!preDesccolor) preDesccolor = "black";
				ele.all("_line").strokecolor = preStrokecolor;
				ele.all("_desc").style.color = preDesccolor;
				this._setCtrlPoint(ele,false);
				this._curCtrl = null;
			}
			break;
		case "Memo":
		    if(state)
		    {
				ele.setAttribute("prestrokecolor",ele.all("_body").strokecolor + "");//vml attribute is different from html attribute
		        ele.all("_body").strokecolor = "red";
		    }
		    else
		    {
				var preStrokecolor = ele.getAttribute("prestrokecolor");
				if(!preStrokecolor) preStrokecolor = "gray";
		        ele.all("_body").strokecolor = preStrokecolor;
			}
			break;
		default:
			return;
	}
	if(this._isReadonly) return;
	if(state)
		this._fireEvent("OnElementSelected",ele);
	else
		this._fireEvent("OnElementSelected",null);
}
//取得影响元素表现的属性
FlowEditor.prototype._getElementProp = function(ele,pname)
{
	var xmlele = ele.all("_data").XMLDocument.documentElement;
	var vis = xmlele.selectSingleNode("Visual");
	var pvalue = "";
	if(ele.Type == "Step")
	{
	    switch(pname)
	    {
	        case "Color":
			    pvalue = ele.all("_body").style.color;
	            break;
	        case "BkColor":
			    pvalue = ele.all("_body").style.backgroundColor;
	            break;
	        case "Font":
			    pvalue = ele.all("_body").style.font;
	            break;
	        case "Border":
	            pvalue = ele.style.border;
	            break;
	        case "TaskType":	//private
	            pvalue = ele.getAttribute("TaskType");
	            xmlele.setAttribute("Type",pvalue);
	            return;
	    }		
	}
	else if(ele.Type == "Cntor")
	{
	    switch(pname)
	    {
	        case "Color":
			    pvalue = ele.all("_line").strokecolor;
	            break;
	        case "DashStyle":
			    pvalue = ele.all("_line").childNodes[0].dashstyle;
	            break;
	        case "DescColor":
			    pvalue = ele.all("_desc").style.color;
	            break;
	        case "DescFont":
	            pvalue = ele.all("_desc").style.font;
	            break;
	        case "StartArrow":
				pvalue = ele.all("_line").childNodes[0].startarrow;
				break;
	        case "EndArrow":
				pvalue = ele.all("_line").childNodes[0].endarrow;
				break;
	        case "RouterType":	//private
	            pvalue = ele.getAttribute("RouterType");
	            xmlele.setAttribute("Type",pvalue);
	            return pvalue;
	        case "Desc":	//private and not set to visual
	            pvalue = ele.all("_desc").innerHTML;
	            xmlele.setAttribute("Desc",pvalue);
	            return pvalue;
	    }
	}
	else if(ele.Type == "Memo")
	{
	    switch(pname)
	    {
	        case "Color":
			    pvalue = ele.all("_body").strokecolor;
	            break;
	        case "BkColor":
			    pvalue = ele.all("_text").style.backgroundColor;
	            break;
	        case "Font":
			    pvalue = ele.all("_text").style.font;
	            break;
	    }
	}
	vis.setAttribute(pname,pvalue);//for update prop
	return pvalue;
}
//设置影响元素表现的属性
FlowEditor.prototype._setElementProp = function(ele,pname,pvalue)
{
	var xmlele = ele.all("_data").XMLDocument.documentElement;
	var vis = xmlele.selectSingleNode("Visual");
	try
	{
	    if(ele.Type == "Step")
	    {
	        switch(pname)
	        {
	            case "Color":
			        ele.all("_body").style.color = pvalue;
	                break;
	            case "BkColor":
					ele.all("_body").style.backgroundColor = pvalue;
	                break;
	            case "Font":
	                if(pvalue)
			        ele.all("_body").style.font = pvalue;
	                break;
	            case "Border":
					if(this._isHideBorder)
						pvalue = "solid 1 white";
	                ele.style.border = pvalue;
	                ele.setAttribute("preborder",pvalue);
	                break;
				case "TaskType":	//private 
					var img = "/share/image/flow/" + pvalue + ".gif";
					ele.all("_img").src = img;
					ele.setAttribute("TaskType",pvalue);
					xmlele.setAttribute("Type",pvalue);
					return true;
	        }		
	    }
	    else if(ele.Type == "Cntor")
	    {
	        switch(pname)
	        {
	            case "Color":
			        ele.all("_line").strokecolor = pvalue;
			        ele.setAttribute("prestrokecolor",pvalue);
	                break;
	            case "DashStyle":
			        ele.all("_line").childNodes[0].dashstyle = pvalue;
	                break;
	            case "DescColor":
			        ele.all("_desc").style.color = pvalue;
			        ele.setAttribute("predesccolor",pvalue);
	                break;
	            case "DescFont":
	                if(pvalue)
	                    ele.all("_desc").style.font = pvalue;
	                break;
	            case "StartArrow":
					ele.all("_line").childNodes[0].startarrow = pvalue;
					break;
	            case "EndArrow":
					ele.all("_line").childNodes[0].endarrow = pvalue;
					break;
				case "RouterType":	//private 
					if(pvalue == "Weak")
						ele.all("_line").childNodes[0].dashstyle = "Dash";
					else if(pvalue == "Strong")
						ele.all("_line").childNodes[0].dashstyle = "Solid";
					else
						throw new Error(0,"unknown RouterType:" + pvalue);
					ele.setAttribute("RouterType",pvalue);
					xmlele.setAttribute("Type",pvalue);
					return true;
				case "Desc":	//private and not set to visual
					var desc = ele.all("_desc");
					desc.innerHTML = pvalue;
					if(pvalue)
						desc.style.display = "";
					else
						desc.style.display = "none";
					this._setDescPosition(desc,ele.Points);
					ele.setAttribute("Desc",pvalue);
					xmlele.setAttribute("Desc",pvalue);
					return true;
	        }
	    }
	    else if(ele.Type == "Memo")
	    {
	        switch(pname)
	        {
	            case "Color":
			        ele.all("_body").strokecolor = pvalue;
			        ele.setAttribute("prestrokecolor",pvalue);
	                break;
	            case "BkColor":
			        ele.all("_text").style.backgroundColor = pvalue;
	                break;
	            case "Font":
	                if(pvalue)
			            ele.all("_text").style.font = pvalue;
	                break;
	        }
	    }
		vis.setAttribute(pname,pvalue);
		return true;
	}
	catch(e)
	{
	    return false;
	}
}

FlowEditor.prototype._updateProps = function(ele,names)
{
	var ns = names.split(",");
	for(var i=0;i<ns.length;i++)
		this._getElementProp(ele,ns[i]);
}

FlowEditor.prototype._getElementSetting = function(ele)
{
	var xmlele = ele.all("_data").XMLDocument.documentElement;
	var vis = xmlele.selectSingleNode("Visual");
	var data = xmlele.selectSingleNode("Data");
	xmlele.setAttribute("ID",ele.id);
	xmlele.setAttribute("ZIndex",ele.style.zIndex);
	vis.setAttribute("Left",ele.offsetLeft);
	vis.setAttribute("Top",ele.offsetTop);
	switch(ele.Type)
	{
		case "Step":
			xmlele.setAttribute("Type",ele.TaskType);
			xmlele.setAttribute("Name",ele.all("_name").innerHTML);
		    var cnts = ele.all("_cntp").childNodes;
		    var cntstr = "",posstr = "";
		    for(var i=0;i<cnts.length;i++)
		    {
			    if(cnts[i].Router && cnts[i].Router != "")
			    {
				    cntstr += i + ":" + cnts[i].Router + ";";
				    posstr += i + ":" + cnts[i].Position + ";";
			    }
		    }
		    if(cntstr != "")
			    cntstr = cntstr.substr(0,cntstr.length - 1);
		    if(posstr != "")
			    posstr = posstr.substr(0,posstr.length - 1);
		    vis.setAttribute("Router",cntstr);
		    vis.setAttribute("Position",posstr);
			this._updateProps(ele,"Color,BkColor,Font,Border");
			break;
		case "Cntor":
			xmlele.setAttribute("Type",ele.RouterType?ele.RouterType:"");
			var desc = ele.all("_desc").innerHTML;
			xmlele.setAttribute("Desc",desc);
			if(desc)
			    ele.all("_desc").style.display = "";
			else
			    ele.all("_desc").style.display = "none";
			vis.setAttribute("Points",ele.getAttribute("Points"));
			vis.setAttribute("StartStep",ele.StartStep);
			vis.setAttribute("StartIndex",ele.StartIndex);
			vis.setAttribute("EndStep",ele.EndStep);
			vis.setAttribute("EndIndex",ele.EndIndex);
			vis.setAttribute("DescLeft",ele.all("_desc").offsetLeft);
			vis.setAttribute("DescTop",ele.all("_desc").offsetTop);
			this._updateProps(ele,"Color,DashStyle,DescColor,DescFont,StartArrow,EndArrow");
			break;
		case "Memo":
			xmlele.setAttribute("Type",ele.MemoType?ele.MemoType:"");
			xmlele.setAttribute("Text",ele.all("_text").innerHTML);
			vis.setAttribute("Width",ele.style.width);
			vis.setAttribute("Height",ele.style.height);
			this._updateProps(ele,"Color,BkColor,Font");
			break;
	}
	return xmlele.xml;
}

FlowEditor.prototype._setElementSetting = function(ele,xml)
{	
	ele.all("_data").innerHTML = xml;
	var xmldoc = ele.all("_data").XMLDocument;
	xmldoc.loadXML(xml);
	xmlele = xmldoc.documentElement;
	var vis = xmlele.selectSingleNode("Visual");
	var data = xmlele.selectSingleNode("Data");
	ele.id = xmlele.getAttribute("ID");
	ele.style.zIndex = xmlele.getAttribute("ZIndex");
	ele.style.left = vis.getAttribute("Left");
	ele.style.top = vis.getAttribute("Top");
	switch(ele.Type)
	{
		case "Step":
		    var cp = vis.getAttribute("Router");
		    var po = vis.getAttribute("Position");
			var cps = cp==""?[]:cp.split(";");//maybe String.Empty parse error
			var pos = po==""?[]:po.split(";");
			var cnts = ele.all("_cntp").childNodes;
			for(var i=0;i<cps.length;i++)
			{
				var ps = cps[i].split(":");
				var po = pos[i].split(":");
				cnts[parseInt(ps[0])].Router = ps[1];
				cnts[parseInt(ps[0])].Position = po[1];
			}
			break;
		case "Cntor":
			ele.RouterType = xmlele.getAttribute("Type")?xmlele.getAttribute("Type"):"";
			if(ele.RouterType == "Weak")
			    if(!xmlele.getAttribute("DashStyle"))
			        vis.setAttribute("DashStyle","dash");
			ele.setAttribute("Points",vis.getAttribute("Points"));
			ele.all("_line").points.Value = ele.Points;
			ele.StartStep = vis.getAttribute("StartStep");
			ele.StartIndex = vis.getAttribute("StartIndex");
			ele.EndStep = vis.getAttribute("EndStep");
			ele.EndIndex = vis.getAttribute("EndIndex");
			var desc = xmlele.getAttribute("Desc");
			ele.all("_desc").innerHTML = desc;
			ele.all("_desc").style.left = vis.getAttribute("DescLeft");
			ele.all("_desc").style.top = vis.getAttribute("DescTop");
			if(desc)
			    ele.all("_desc").style.display = "";
			else
			    ele.all("_desc").style.display = "none";
			break;
		case "Memo":
			ele.MemoType = xmlele.getAttribute("Type")?xmlele.getAttribute("Type"):"";
			ele.style.width = ele.childNodes[0].childNodes[0].style.width = vis.getAttribute("Width");
			ele.style.height = ele.childNodes[0].childNodes[0].style.height = vis.getAttribute("Height");
			break;
	}
	for(var i=0;i<vis.attributes.length;i++)
	{	
		var atr = vis.attributes[i];
		this._setElementProp(ele,atr.name,atr.value);
	}
}

FlowEditor.prototype._setElementData = function(ele,xml)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.loadXML(xml);
	if(doc.parseError.errorCode != 0)
	{
		alert("xml parse error!\n" + xml);
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	var data = xmlele.selectSingleNode("Data");
	data.removeChild(data.childNodes[0]);
	data.appendChild(doc.documentElement);
	//判断是否路由
	if(ele.Type=="Cntor")
	{
		var preTaskId = ele.StartStep;//ele.getAttribute("StartStep");//出任务id
		var nextTaskId = ele.EndStep;//出任务id
		
		var stepNode = this._editor.all(ele.StartStep).all("_data");
		var route = stepNode.selectSingleNode("//List[@Name='Outgoing']/Item[@TaskId='"+nextTaskId+"']");
		
		//alert(doc.documentElement);
		var xmlDs = new DataStore(xml);
		var rtype = xmlDs.Forms(0).GetValue("Type");
		if(rtype)
			route.setAttribute("Type",rtype);
	}
	//compatible method
	if(this.SyncElementVisual)
		this.SyncElementVisual(ele,xml);
}

FlowEditor.prototype._setElementAllData = function(ele,xml)
{
	FlowEditor.SetElementAllData(ele,xml);
	//compatible method
	if(this.SyncElementVisual)
		this.SyncElementVisual(ele,xml);
}

FlowEditor.prototype._getElementData = function(ele)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	var data = xmlele.selectSingleNode("Data");
	return data.childNodes[0].xml;
}

//add by shawn 2008-11-30
FlowEditor.prototype.setFieldsSetting = function(fieldList)
{
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.setProperty("SelectionLanguage", "XPath");
	doc.loadXML(this._settingXml);
	if(doc.parseError.errorCode != 0)
	{
		alert("xml parse error!\n" + xml);
		return false;
	}
	var fs = doc.selectSingleNode("/Setting/FieldSetting");
	if(fs==null)
		fs = doc.createElement("FieldSetting");
	doc.firstChild.appendChild(fs);
	var ds = doc.selectSingleNode("/Setting/FieldSetting/DataStore");
	if(ds==null)
		ds = doc.createElement("DataStore");
	fs.appendChild(ds);
	var ls = doc.selectSingleNode("/Setting/FieldSetting/DataStore/Lists");
	if(ls==null)
		ls = doc.createElement("Lists");
	ds.appendChild(ls);
	var oriField = doc.selectSingleNode("/Setting/FieldSetting/DataStore/Lists/List[@Name='Field']");
	if(oriField!=null) ls.removeChild(oriField);
	
	ls.appendChild(fieldList.XmlEle);
	this._settingXml = doc.xml;
	//修改每个环节
	
	
	
	
	
	return true;
	//alert(doc.xml);
}

FlowEditor.prototype.getFieldsSetting = function()
{
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.setProperty("SelectionLanguage", "XPath");
	doc.loadXML(this._settingXml);
	var fs = doc.selectSingleNode("/Setting/FieldSetting/DataStore/Lists/List[@Name='Field']");
	if(fs==null)
		return "<List Name='Field' /></Lists>";
	else
		return fs.xml;
}

FlowEditor.prototype._getFlowXml = function()
{
	var eles = this._editor.childNodes;
	var length = eles.length;
	var fxml = "<FlowDefine MaxIndex='" + this._maxIndex + "' MinZIndex='" + this._minZIndex + "' MaxZIndex='" + this._maxZIndex + "'>";
	var settingxml = "",stepxml = "",cntxml = "",memoxml = "";
	settingxml = this._settingXml;
	for(var i=0;i<length;i++)
	{
		if(eles[i].Type == "Step")
			stepxml += this._getElementSetting(eles[i]) + "\n";
		else if(eles[i].Type == "Cntor")
			cntxml += this._getElementSetting(eles[i]) + "\n";
		else if(eles[i].Type == "Memo")
			memoxml += this._getElementSetting(eles[i]) + "\n";
	}
	fxml += settingxml + "<StepSet>" + stepxml + "</StepSet>" + "<CntorSet>" + cntxml + "</CntorSet>" + "<MemoSet>" + memoxml + "</MemoSet>";
	fxml += "</FlowDefine>";
	return fxml;
}

FlowEditor.prototype._setFlowXml = function(xml)
{
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.loadXML(xml);
	if(doc.parseError.errorCode != 0)
	{
		alert("xml parse error!\n" + xml);
		return;
	}
	this._reset();
	this._defineXml = xml;
	var xmlele = doc.documentElement;
	var settingNode = xmlele.selectSingleNode("Setting");
	if(settingNode)
		this._settingXml = xmlele.selectSingleNode("Setting").xml;
	else
		this._settingXml = "<Setting />";
	var steps = xmlele.selectSingleNode("StepSet").childNodes;
	for(var i=0;i<steps.length;i++)
	{
		/*
		var step = this._createStep(steps[i].getAttribute("Type"),steps[i].getAttribute("Name"));
		this._setElementSetting(step,steps[i].xml);
		step.style.display = "";
		*/
		
		//2008-7-18添加
		var step;
		var ds = new DataStore(xmlele.selectSingleNode("//Step [@ID='"+steps[i].getAttribute("ID")+"']//Data//DataStore").xml);
		var df = ds.Forms("BasicInfo");
		
		if(df.GetValue("ICONURL")!=null)
		{
			
			if(df.GetValue("ICONURL")!="")
			{
				step = this._createStep1(steps[i].getAttribute("Type"),steps[i].getAttribute("Name"),df.GetValue("ICONURL"));
			}else
			{
				step = this._createStep(steps[i].getAttribute("Type"),steps[i].getAttribute("Name"));
			}
		}else {
			step = this._createStep(steps[i].getAttribute("Type"),steps[i].getAttribute("Name"));
		}
		this._setElementSetting(step,steps[i].xml);
		step.style.display = "";
	}
	var cntors = xmlele.selectSingleNode("CntorSet").childNodes;
	for(var i=0;i<cntors.length;i++)
	{
		var xmlcnt = cntors[i];
		var cnt = this._createRouter(1,1,1,1);
		this._setElementSetting(cnt,cntors[i].xml);
		cnt.style.display = "";
	}
	var memos = xmlele.selectSingleNode("MemoSet").childNodes;
	for(var i=0;i<memos.length;i++)
	{
	    var memo = this._createMemo(memos[i].getAttribute("Text"));
	    this._setElementSetting(memo,memos[i].xml);
	    memo.style.display = "";
	}
	this._maxIndex = xmlele.getAttribute("MaxIndex");
	this._minZIndex = xmlele.getAttribute("MinZIndex");
	this._maxZIndex = xmlele.getAttribute("MaxZIndex");
	this._editor.focus();
}

FlowEditor.prototype._setElementToBack = function(ele)
{
    ele.style.zIndex = this._minZIndex--;
}

FlowEditor.prototype._setElementToFront = function(ele)
{
    ele.style.zIndex = this._maxZIndex++;
}

FlowEditor.prototype._getElementByID = function(id)
{
	return this._editor.all(id);
}

FlowEditor.MouseMove = function()
{
    var editor = FlowEditor.getEditor(event.srcElement);
    if(!editor) return;
    var ele = FlowEditor.getElement(event.srcElement);
	var dx = Math.round((event.clientX - editor._preX) / FlowEditor.GridUnit) * FlowEditor.GridUnit;
	var dy = Math.round((event.clientY - editor._preY) / FlowEditor.GridUnit) * FlowEditor.GridUnit;
	switch(editor._editMode)
	{
		case "SEL":
		    if(ele != null && ele.Type == "Memo")
		    {
		        if(ele.offsetWidth - event.offsetX <= 10 && ele.offsetHeight - event.offsetY <= 10)
		        {
		            ele.style.cursor = "se-resize";
		            editor._memoResize = true;
		        }
		        else
		        {
		            ele.style.cursor = "hand";
		            editor._memoResize = false;
		        }
		    }
			break;
		case "RCT":
			var rct = editor._curRect;
			if(dx < 0)
			{
				rct.style.left = rct.PreLeft + dx;
				rct.style.width = Math.abs(dx);
			}
			else
			{
				rct.style.left = rct.PreLeft;
				rct.style.width = dx;
			}
			if(dy < 0)
			{
				rct.style.top = rct.PreTop+dy;
				rct.style.height = Math.abs(dy);
			}
			else
			{
				rct.style.top = rct.PreTop;
				rct.style.height = dy;
			}
			break;
		case "ADD":
			break;
		case "LNK":
			if(editor._linkStep == "begin" || editor._linkStep == "middle")
			{	if(editor._curHighlight != null && (ele != editor._curHighlight || ele == null))
				{
					editor._setHighlight(editor._curHighlight,false);
					editor._curHighlight = null;
				}
				if(ele != null && ele.Type == "Step")
				{
					editor._curHighlight = ele;
					editor._setHighlight(editor._curHighlight,true,event.x,event.y);
				}
			}
			if(editor._linkStep == "middle")//处于路由线绘制中
			{
				if(event.srcElement == editor._editor || (ele != null && ele.Type == "Cntor"))//在编辑器空白处移动
					editor._setRouterPoint(editor._curElement,"end",editor._getEventX(),editor._getEventY());
				else
				{	
					if(ele == null && ele.Type != "Step") return;
					var step = ele;
					var cnt = editor._getSnapCntor(step);
					if(cnt != null)
						editor._setRouterPoint(editor._curElement,"end",step.offsetLeft+FlowEditor.getCenterX(cnt),step.offsetTop+FlowEditor.getCenterY(cnt));
				}
			}
			break;
		case "MME":
		    var sels = editor._selections;
		    var length = sels.length;
			for(var i=0;i<length;i++)
			{
				if(sels[i].Type == "Cntor")
				{	
					var cnt = sels[i];
					if(!( editor._isElementInSelections(editor._editor.all(cnt.StartStep)) &&
						  editor._isElementInSelections(editor._editor.all(cnt.EndStep)) ) )
						continue;
					sels[i].style.left = sels[i].PreLeft + dx;
				}
				sels[i].style.left = sels[i].PreLeft + dx;
				sels[i].style.top = sels[i].PreTop + dy;
				if(sels[i].Type == "Step")
					editor._setStepRouter(sels[i],dx,dy);
			}
			break;
		case "MST"://MoveStep
			var step = editor._curElement;
			step.style.left = step.PreLeft + dx;
			step.style.top = step.PreTop + dy;
			editor._setStepRouter(step,dx,dy);
			break;
		case "MMO"://MoveMemo
			var memo = editor._curElement;
			memo.style.left = memo.PreLeft + dx;
			memo.style.top = memo.PreTop + dy;
			//editor._setStepRouter(step,dx,dy);
			break;
		case "MDS"://MoveDesc
			var desc = editor._curElement.all("_desc");
			desc.style.left = desc.PreLeft + dx;
			desc.style.top = desc.PreTop + dy;
			break;
		case "RMO":
		    var memo = editor._curElement;
		    var width = memo.PreWidth + dx;
		    var height = memo.PreHeight + dy;
		    if(width >= FlowEditor.GridUnit)
	            memo.style.width = memo.childNodes[0].childNodes[0].style.width = width;
		    if(height >= FlowEditor.GridUnit)
	            memo.style.height = memo.childNodes[0].childNodes[0].style.height = height;
		    break;
		case "MCR":
			var ctrl = editor._curCtrl;
			editor._curElement.NewStart = null;
			editor._curElement.NewEnd = null;
			if(editor._curHighlight != null && (ele != editor._curHighlight || ele == null))
			{
				editor._setHighlight(editor._curHighlight,false);
				editor._curHighlight = null;
			}
			if(ele != null && ele.Type == "Step")
			{
				editor._curHighlight = ele;
				editor._setHighlight(editor._curHighlight,true,event.x,event.y);
			}
			if(ctrl.className != "lnkp" || ele == null || ele == ctrl) //路由控制点移动到环节上
			{
				ctrl.style.left = ctrl.PreLeft + dx;
				ctrl.style.top = ctrl.PreTop + dy;
				var px = parseInt(ctrl.style.left) + 2;
				var py = parseInt(ctrl.style.top) + 2;
				editor._setRouterPoint(editor._curElement,FlowEditor.getIndex(ctrl),px,py,"relative");
			}
			else if(ele != null && ele.Type == "Step") //路由连接点移动到环节上
			{
				var step = ele;
				var cnt = editor._getSnapCntor(step);
				if(cnt != null)
				{	
					ctrl.style.left = cnt.offsetLeft+step.offsetLeft-editor._curElement.offsetLeft;
					ctrl.style.top = cnt.offsetTop+step.offsetTop-editor._curElement.offsetTop;
					editor._setRouterPoint(editor._curElement,ctrl.Position,step.offsetLeft + FlowEditor.getCenterX(cnt),step.offsetTop + FlowEditor.getCenterY(cnt));
					if(ctrl.Position == "start")
					{
						editor._curElement.NewStart = step.id;
						editor._curElement.NewStartIndex = FlowEditor.getIndex(cnt);
					}
					else
					{
						editor._curElement.NewEnd = step.id;
						editor._curElement.NewEndIndex = FlowEditor.getIndex(cnt);
					}
				}
			}
			break;
	}
}

FlowEditor.MouseDown = function()
{
    var ele = FlowEditor.getElement(event.srcElement);
    var editor = FlowEditor.getEditor(event.srcElement);
    if(!editor) return;
	switch(editor._editMode)
	{
		case "SEL":
			if(ele != null && ele.Type == "Ctrl") //路由控制点
			{
				editor._editMode = "MCR";//MoveCtrl
				if(editor._curCtrl != null && ele != editor._curCtrl)
					editor._curCtrl.style.backgroundColor = "red";
				ele.style.backgroundColor = "green";
				editor._curCtrl = ele;
				//如果添加控制点，可能导致控制点不在FlowEditor.GridUnit上
				ele.style.left = Math.round(ele.offsetLeft / FlowEditor.GridUnit) * FlowEditor.GridUnit - 2;
				ele.style.top = Math.round(ele.offsetTop / FlowEditor.GridUnit) * FlowEditor.GridUnit - 2;
				ele.setCapture();
			}
			else
			{	
				if(ele == null)
				{	
					if(editor._curElement != null)
						editor._selectElement(editor._curElement,false);
					editor._curElement = ele;
					editor._editMode = "RCT"; //绘制选择框
					editor._clearSelections();
					ele = editor._curRect = editor._drawRect(editor._getEventX(),editor._getEventY());
				}
				else
				{
					if(editor._isElementInSelections(ele))//选择的元素在选择集合中
					{
					    var sels = editor._selections;
					    var length = sels.length;
						for(var i=0;i<length;i++)
						{
							if(sels[i].Type == "Step")
								editor._storeRouterPoint(sels[i]);	
							sels[i].PreLeft = parseInt(sels[i].style.left);
							sels[i].PreTop = parseInt(sels[i].style.top);
						}
						editor._curElement = ele;
						editor._editMode = "MME";//MoveMultiElement
						ele.setCapture();
					}
					else
					{
			            editor._clearSelections();
						if(editor._curElement != null)
							editor._selectElement(editor._curElement,false);
						editor._curElement = ele;
						editor._selectElement(ele,true);
						if(ele.Type == "Step")
						{
							editor._storeRouterPoint(ele);//将连接线的状态保存
							editor._editMode = "MST";//MoveStep
							ele.setCapture();
						}
						else if(ele.Type == "Cntor")
						{
							if(event.srcElement.id == "_desc")
							{	
								var desc = event.srcElement;
								desc.PreLeft = desc.offsetLeft;
								desc.PreTop = desc.offsetTop;
								editor._editMode = "MDS";//MoveDesc
								desc.setCapture();
							}
						}
						else if(ele.Type == "Memo")
						{
						    if(editor._memoResize)
						    {
						        ele.PreWidth = ele.offsetWidth;
						        ele.PreHeight = ele.offsetHeight;
						        editor._editMode = "RMO";//MoveMemo
						    }
						    else
							    editor._editMode = "MMO";//MoveMemo
							ele.setCapture();
						}
					}
				}
			}
			ele.PreLeft = parseInt(ele.style.left);
			ele.PreTop = parseInt(ele.style.top);
			editor._preX = event.clientX;
			editor._preY = event.clientY;
			break;
		case "ADD":
			break;
		case "LNK":
			if(editor._linkStep == "begin")
			{
				if(ele == null || ele.Type != "Step") return;
				var step = ele;
				var cnt = editor._getSnapCntor(step);
				if(cnt == null) return;
				editor._curElement = editor._createRouter(step.offsetLeft,step.offsetTop,FlowEditor.getCenterX(cnt),FlowEditor.getCenterY(cnt));
				editor._curElement.style.display = "";
				editor._setCntorRouter(cnt,"add",editor._curElement.id,"start");//建立环节连接点到路由的联系
				editor._curElement.StartStep = step.id;//建立路由到环节的联系
				editor._curElement.StartIndex = FlowEditor.getIndex(cnt);
				//Sync Cntor Data
				if(editor.SyncCntorData)
					editor.SyncCntorData(editor._curElement);
				editor._linkStep = "middle";
			}
			else if(editor._linkStep == "middle")
			{
				if(ele != null && ele.Type == "Step")
				{
					var step = ele;
					var cnt = editor._getSnapCntor(step);
					if(cnt != null)
					{
						editor._setRouterPoint(editor._curElement,"end",step.offsetLeft+FlowEditor.getCenterX(cnt),step.offsetTop+FlowEditor.getCenterY(cnt));
						editor._setCntorRouter(cnt,"add",editor._curElement.id,"end");
						editor._curElement.EndStep = step.id;
						editor._curElement.EndIndex = FlowEditor.getIndex(cnt);
						//Sync Cntor Data
						if(editor.SyncCntorData)
							editor.SyncCntorData(editor._curElement);
						//Sync Step Data
						editor.SyncStepData(editor._getElementByID(editor._curElement.StartStep));
						editor.SyncStepData(editor._getElementByID(editor._curElement.EndStep));
						editor._linkStep = "over";
						editor._setHighlight(step,false);
						editor._selectElement(editor._curElement,true);
					}
				}
				else
					editor._setRouterPoint(editor._curElement,"add",editor._getEventX(),editor._getEventY());
			}	
			break;
		case "MST":
			break;
	}
}

FlowEditor.MouseUp = function()
{
    var editor = FlowEditor.getEditor(event.srcElement);
    if(!editor) return;
    var ele = FlowEditor.getElement(event.srcElement);
	switch(editor._editMode)
	{
		case "SEL":
			break;
		case "RCT":
			editor._getSelections(editor._curRect.offsetLeft,editor._curRect.offsetTop,editor._curRect.offsetWidth,editor._curRect.offsetHeight);
			editor._editor.removeChild(editor._curRect);
			editor._editMode = "SEL";
			break;
		case "ADD":
			break;
		case "LNK":
			if(editor._linkStep == "over")
				editor._editMode = "SEL";
			break;
		case "MME":
			editor._curElement.releaseCapture();
			editor._editMode = "SEL";
			break;
		case "MST":
			var step = editor._curElement;
			step.releaseCapture();
			editor._editMode = "SEL";
			break;
	    case "RMO":
		case "MMO":
			var memo = editor._curElement;
			memo.releaseCapture();
			editor._editMode = "SEL";
			break;
		case "MDS"://MoveDesc
			var desc = editor._curElement.all("_desc");
			desc.releaseCapture();
			editor._editMode="SEL";
			break;
		case "MCR":
			editor._curCtrl.releaseCapture();
			if(ele != null && ele.Type == "Step")
			    editor._setHighlight(ele,false);
			if(editor._curCtrl.Position != "mid")
			{
				var rt = editor._curElement;
				if(rt.NewStart || rt.NewEnd)
				{
					if(rt.NewStart)//路由起点发生变化
					{	
						var cnt = editor._editor.all(rt.StartStep).all("_cntp").childNodes[rt.StartIndex];
						editor._setCntorRouter(cnt,"remove",rt.id,"start");
						var newcnt = editor._editor.all(rt.NewStart).all("_cntp").childNodes[rt.NewStartIndex];
						editor._setCntorRouter(newcnt,"add",rt.id,"start");
						//Sync Step Data
						editor.SyncStepData(editor._getElementByID(rt.StartStep));
						editor.SyncStepData(editor._getElementByID(rt.EndStep));
						rt.StartStep = rt.NewStart;
						rt.StartIndex = rt.NewStartIndex;
						//Sync Step Data
						editor.SyncStepData(editor._getElementByID(rt.NewStart));
						editor.SyncStepData(editor._getElementByID(rt.EndStep));
					}
					if(rt.NewEnd)//路由终点发生变化
					{
						var cnt = editor._editor.all(rt.EndStep).all("_cntp").childNodes[rt.EndIndex];
						editor._setCntorRouter(cnt,"remove",rt.id,"end");
						var newcnt = editor._editor.all(rt.NewEnd).all("_cntp").childNodes[rt.NewEndIndex];
						editor._setCntorRouter(newcnt,"add",rt.id,"end");
						//Sync Step Data
						editor.SyncStepData(editor._getElementByID(rt.StartStep));
						editor.SyncStepData(editor._getElementByID(rt.EndStep));
						rt.EndStep = rt.NewEnd;
						rt.EndIndex = rt.NewEndIndex;
						//Sync Step Data
						editor.SyncStepData(editor._getElementByID(rt.StartStep));
						editor.SyncStepData(editor._getElementByID(rt.NewEnd));
					}
					//Sync Cntor Data
					if(editor.SyncCntorData)
						editor.SyncCntorData(editor._curElement);
				}
				else	
				{
					editor._setRouterPoint(editor._curElement,editor._curCtrl.Position,editor._curCtrl.PreLeft + 2,editor._curCtrl.PreTop + 2,"relative");
					editor._curCtrl.style.left = editor._curCtrl.PreLeft;
					editor._curCtrl.style.top = editor._curCtrl.PreTop;
				}
			}
			editor._editMode="SEL";
			break;
	}
	//fire event
	editor._fireEvent("OnElementClick",editor._curElement);
}

FlowEditor.KeyDown = function()
{
    var step = FlowEditor.getElement(event.srcElement);
    var editor = FlowEditor.getEditor(event.srcElement);
    if(!editor) return;
	switch(editor._editMode)
	{
		case "SEL":
			if(event.keyCode == 46)
			{
				if(editor._selections.length>0)//先处理选择集
				{
					if(window.confirm("确实要删除"+editor._selections.length+"个元素吗?"))
					{
						editor._removeSelections();
					}
				}
				else if(editor._curElement != null)
				{	
					if(window.confirm("确实要删除元素吗?"))
					{
						if(editor._curElement.Type == "Cntor")
							editor._removeRouter(editor._curElement);
						else if(editor._curElement.Type == "Step")
							editor._removeStep(editor._curElement);
						else if(editor._curElement.Type == "Memo")
						    editor._removeMemo(editor._curElement);
						editor._curElement = null;
					}
				}
			}
			break;
		case "NEW":
			break;
		case "LNK":
			if(event.keyCode == 27 || event.keyCode == 46)
			{
			   	if(editor._curElement != null && editor._curElement.Type == "Cntor")
					editor._removeRouter(editor._curElement);
				editor._editMode = "SEL";
			}
			//取消当前的Link操作
			break;
		case "MST":
			break;
	}
}

FlowEditor.ReadonlyMouseDown = function()
{
	var ele = FlowEditor.getElement(event.srcElement);
    var editor = FlowEditor.getEditor(event.srcElement);
    if(!editor) return;
	if(editor._curElement)
		editor._selectElement(editor._curElement,false);
    if(ele && ele.Type != "Ctrl")
    {
		editor._curElement = ele;
		editor._selectElement(ele,true);
		editor._fireEvent("OnElementClick",editor._curElement);
    }
    else
    {
		//add by shawn for especial mouse click
		editor._fireEvent("OnElseClick",editor._curElement);  
    }
}

FlowEditor.getElement = function(srcele)
{
	while(srcele != null)
	{
		if(srcele.tagName.toLowerCase() == "body")
		{
			srcele = null;
			break;
		}
		if(srcele.scopeName.toLowerCase()=="v")  //VML对象使用getAttribute取不存在的属性会导致致命错误,使IE的VML分析引擎一致处于错误状态
		{
			srcele = srcele.parentNode;
			continue;
		}	
		var type = srcele.getAttribute("Type");
		if(type == "Step" || type == "Cntor" || type == "Memo" || type == "Ctrl")
			break;
		srcele = srcele.parentNode;
	}
	return srcele;
}

FlowEditor.getIndex = function(ele)
{
	var count = ele.parentNode.childNodes.length;
	for(var i=0;i<count;i++)
		if(ele.parentNode.childNodes[i]==ele)
			return i;
}
FlowEditor.prototype._getEventX = function()
{
	var x = event.clientX - this._editor.offsetLeft + document.body.scrollLeft - this._htmlEle.offsetLeft + this._htmlEle.scrollLeft;
	return Math.round(x / FlowEditor.GridUnit) * FlowEditor.GridUnit;
}
FlowEditor.prototype._getEventY = function()
{
	var y = event.clientY - this._editor.offsetTop + document.body.scrollTop - this._htmlEle.offsetTop + this._htmlEle.scrollTop;
	return Math.round(y / FlowEditor.GridUnit) * FlowEditor.GridUnit;
}
FlowEditor.getCenterX = function(ele)
{
	return ele.offsetLeft + Math.round(ele.offsetWidth / 2);
}
FlowEditor.getCenterY = function (ele)
{
	return ele.offsetTop + Math.round(ele.offsetHeight / 2);
}

FlowEditor.getDistance = function (x,y,ele)
{
	var cx = ele.offsetLeft + ele.offsetWidth / 2;
	var cy = ele.offsetTop + ele.offsetHeight / 2;
	return Math.sqrt((cx - x) * (cx - x) + (cy - y) * (cy - y));
}

FlowEditor.prototype._fireEvent = function(ename,ele)
{
	var func = this._htmlEle.getAttribute(ename);
	if(!func) return;
	this.EventArgs.Element = ele;
	try
	{
	    eval(func);
	}
	catch(e)
	{
	    alert(ename + " event handler error!\n" + e.description);
	}
}

FlowEditor.prototype._getSetpCntorPoint = function(w,h)
{
	var size = 3;
	var html = "<span class='cntp' style='left:" + (w / 2 - size) + "px;top:" + (0 - size) + "px'></span>";
	html += "<span class='cntp' style='left:" + (w - size - 1) + "px;top:"+(h / 2 - size) + "px'></span>";
	html += "<span class='cntp' style='left:" + (w / 2 - size) + "px;top:"+(h - size - 1) + "px'></span>";
	html += "<span class='cntp' style='left:" + (0 - size) + "px;top:"+(h / 2 - size) + "px'></span>";
	return html;
}

FlowEditor.getEditor = function(node)
{
	if(!node) node = event.srcElement;
	while(true)
	{
		if(!node) return null;
		if(node == document.body)
		{
			var divs = document.getElementsByTagName("div");
			for(var i=0;i<divs.length;i++)
			{
				if(divs[i].Editor)
					return divs[i].Editor;
			}
			return null;
		}
		else if(node.Editor)
            return node.Editor;
        else
			node = node.parentNode;
	}
}
 
/*************Prototype Interface********************/

//开始连接Step
FlowEditor.prototype.DoLink = function()
{
    this._linkStep="begin";
    this._editMode="LNK";
    this._clearSelect();
}
//添加Step
FlowEditor.prototype.AddStep = function(value,text)
{
	var step = this._createStep(value,text);
	step.style.display="";
	step.focus();
	this._editor.focus();
}
//添加Memo
FlowEditor.prototype.AddMemo = function(memo)
{
	var memo = this._createMemo(memo);
	memo.style.display = "";
	memo.focus();
	this._editor.focus();
}
//获得流程定义的Xml
FlowEditor.prototype.GetFlowXml = function()
{
	this._clearSelect();
	this._clearSelections();
	return this._getFlowXml();
}
//重新设置流程
FlowEditor.prototype.SetFlowXml = function(xml)
{
	this._setFlowXml(xml);
}
//添加控制点
FlowEditor.prototype.AddRouterPoint = function()
{
	if(this._curElement == null || this._curElement.Type != "Cntor")
	{	
		alert("请选择路由!");
		return;
	}
	var after=0;
	if(this._curCtrl != null && this._curCtrl.Position == "mid")
		after = FlowEditor.getIndex(this._curCtrl);
	var rx,ry;
	var ps = this._curElement.getAttribute("Points").split(",");
	rx = (parseInt(ps[after * 2]) + parseInt(ps[after * 2 + 2])) / 2;
	ry = (parseInt(ps[after * 2 + 1]) + parseInt(ps[after * 2 + 3])) / 2;
	this._setRouterPoint(this._curElement,"insert",rx,ry,"relative",after);
	this._selectElement(this._curElement,false);
	this._selectElement(this._curElement,true);
	
}
//删除控制点
FlowEditor.prototype.RemoveRouterPoint = function()
{
	if(this._curElement == null || this._curElement.Type != "Cntor")
	{	
		alert("请选择路由!");
		return;
	}
	var ps = this._curElement.getAttribute("Points").split(",");
	if(ps.length <= 4)
	{
		alert("没有路由控制点可以删除!");
		return;
	}
	var index=1;
	if(this._curCtrl != null && this._curCtrl.Position == "mid")
	{
		index = FlowEditor.getIndex(this._curCtrl);
		this._curCtrl = null;
	}
	this._setRouterPoint(this._curElement,"remove",0,0,"relative",index);
	this._selectElement(this._curElement,false);
	this._selectElement(this._curElement,true);
}
//获得Element的Data
FlowEditor.prototype.GetElementData = function(ele)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		return this._getElementData(ele);
	else
		alert("不是有效的Element元素");
	return null;
}

FlowEditor.prototype.GetElementAllData = function(ele)
{
	
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		return FlowEditor.GetElementAllData(ele);
	else
		alert("不是有效的Element元素");
	return null;
}

//设置Element的Data
FlowEditor.prototype.SetElementData = function(ele,data)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		this._setElementData(ele,data);
	else
		alert("不是有效的Element元素");
}

FlowEditor.prototype.SetElementAllData = function(ele,data)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		this._setElementAllData(ele,data);
	else
		alert("不是有效的Element元素");
}

//获得Element的Prop
FlowEditor.prototype.GetElementProp = function(ele,propName)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
	{
		if(propName && FlowEditor[ele.Type + "Props"].indexOf(propName) >= 0)
			this._getElementProp(ele,propName);
		else
			alert(propName + "不是有效的属性名!有效的属性名包括" +　FlowEditor[ele.Type + "Props"]);
	}
	else
		alert("不是有效的Element元素");
}
//设置Element的Prop
FlowEditor.prototype.SetElementProp = function(ele,propName,propValue)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
	{
		if(propName && FlowEditor[ele.Type + "Props"].indexOf(propName) >= 0)
			this._setElementProp(ele,propName,propValue);
		else
			alert(propName + "不是有效的属性名!有效的属性名包括" +　FlowEditor[ele.Type + "Props"]);
	}
	else
		alert("不是有效的Element元素");
}
//根据ID获得Element
FlowEditor.prototype.GetElementByID = function(id)
{
	return this._getElementByID(id);
}
//Element前置
FlowEditor.prototype.SetElementFront = function(ele)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		this._setElementToFront(ele);
	else
		alert("不是有效的Element元素");
}
//Element后置
FlowEditor.prototype.SetElementBack = function(ele)
{
	if(ele && ele.Type && FlowEditor.ElementTypes.indexOf(ele.Type) >= 0)
		this._setElementToBack(ele);
	else
		alert("不是有效的Element元素");
}

FlowEditor.prototype.GetMemoContent = function(ele)
{
	return FlowEditor.GetMemoContent(ele);
}

FlowEditor.prototype.SetMemoContent = function(ele,content)
{
	FlowEditor.SetMemoContent(ele,content);
}


FlowEditor.prototype.GetFieldContent = function()
{
	var fieldxml = "";
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.loadXML(this._defineXml);
	var xmlele = doc.documentElement;
	var fieldsNode = xmlele.selectSingleNode("Fields");
	if(fieldsNode)
		fieldxml = fieldsNode.text;
	return fieldxml;
}

/*************Prototype Interface End********************/

FlowEditor.GetElementData = function(ele)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	var data = xmlele.selectSingleNode("Data");
	return data.childNodes[0].xml;
}
FlowEditor.GetElementAllData = function(ele)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	var data = xmlele.xml
	return data;
}

FlowEditor.SetElementData = function(ele,xml)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.loadXML(xml);
	if(doc.parseError.errorCode != 0)
	{
		alert("xml parse error!\n" + xml);
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	var data = xmlele.selectSingleNode("Data");
	data.removeChild(data.childNodes[0]);
	data.appendChild(doc.documentElement);
}
FlowEditor.SetElementAllData = function(ele,xml)
{
	var dataNode = ele.all("_data");
	if(!dataNode)
	{
		alert("不是有效的Element元素");
		return;
	}
	var doc = new ActiveXObject("Microsoft.XMLDOM");
	doc.loadXML(xml);
	if(doc.parseError.errorCode != 0)
	{
		alert("xml parse error!\n" + xml);
		return;
	}
	var xmlele = dataNode.XMLDocument.documentElement;
	//var data = xmlele.selectSingleNode("Data");
	//data.removeChild(data.childNodes[0]);
	xmlele.appendChild(doc.documentElement);
}

//其它方法(主要是数据兼容)
FlowEditor.prototype.SyncElementVisual = function(ele,xml)
{
	switch(ele.Type)
	{
		case "Step":
			var ds = new DataStore(xml);
			var form = ds.Forms("BasicInfo");
			var newName = form.GetValue("Name");
			var oldName = ele.all("_name").innerText;
			if(newName && newName != oldName)
			{
				ele.all("_name").innerText = newName;
				var cnts = ele.all("_cntp").childNodes;
				for(var i=0;i<cnts.length;i++)
				{
					if(cnts[i].Router && cnts[i].Router != "")
					{
						var idary = cnts[i].Router.split(",");
						for(var j=0;j<idary.length;j++)
							this.SyncCntorData(this._getElementByID(idary[j]));
					}
				}
			}
			break;
		case "Cntor":
			var ds = new DataStore(xml);
			var form = ds.Forms("BasicInfo");
			var type = form.GetValue("Type");
			if(type && type == "OuterLink")
				type = "Weak";
			else
				type = "Strong";
			var desc = form.GetValue("Description");
			this._setElementProp(ele,"RouterType",type);	//not use SetElementProp because of filter prop
			this._setElementProp(ele,"Desc",desc);			//not use SetElementProp because of filter prop
			break;
		case "Memo":
			var ds = new DataStore(xml);
			var form = ds.Forms("BasicInfo");
			var content = form.GetValue("Memo");
			ele.all("_text").innerHTML = content;
			break;
	}
}

//edited by yq_zhang 因项目状态跟踪模版需要,隐掉step选项中的老data
FlowEditor.prototype.GetInitData = function(type)
{
	var data = null;
	switch(type)
	{
		case "Step":
			//data = "<DataStore><Forms><Form Name=\"BasicInfo\"><Type/><Key/><Name>" + arguments[1] + "</Name><Grade/><Description/><WorkDay/></Form><Form Name=\"Executor\"><Type/><Executor/><ExecutorContent/><DispatchType/><IsAllowSelectUser/></Form><Form Name=\"Incoming\"><Type/><ScriptCode/><Expression/></Form><Form Name=\"Submit\"><ScriptCode/><Expression/></Form><Form Name=\"End\"><ScriptCode/></Form></Forms><Lists><List Name=\"ExecuteObject\" /><List Name=\"Parameter\" /><List Name=\"Incoming\" /><List Name=\"Outgoing\" /><List Name=\"Warn\" /></Lists></DataStore>";
			data = "<DataStore><Forms><Form Name=\"BasicInfo\"><Type/><Key/><Name>" + arguments[1] + "</Name><Grade/><Description/><WorkDay/><URL/><URLStyle/><ICONURL/></Form><Form Name=\"Executor\"><Type/><Executor/><ExecutorContent/><DispatchType/><IsAllowSelectUser/></Form><Form Name=\"Incoming\"><Type/><ScriptCode/><Expression/></Form><Form Name=\"Submit\"><ScriptCode/><Expression/></Form><Form Name=\"End\"><ScriptCode/></Form></Forms><Lists><List Name=\"ExecuteObject\" /><List Name=\"Parameter\" /><List Name=\"Incoming\" /><List Name=\"Outgoing\" /><List Name=\"Field\" /><List Name=\"Warn\" /></Lists></DataStore>";
			break;
		case "Cntor":
			data = "<DataStore><Forms><Form Name=\"BasicInfo\"><FromId/><FromName/><ToId/><ToName/><Description/><Type/></Form></Forms></DataStore>";
			break;
		case "Memo":
			data = "<DataStore><Forms><Form Name=\"BasicInfo\"><Memo>" + arguments[1] + "</Memo></Form></Forms></DataStore>";
			break;
	}
	return data;
}


FlowEditor.prototype.SyncStepData = function(ele)
{
	var ds = new DataStore(this._getElementData(ele));
	var inList = ds.Lists("Incoming");
	var outList = ds.Lists("Outgoing");
	var inIds = [];
	var outIds = [];
	var cnts = ele.all("_cntp").childNodes;
	for(var i=0;i<cnts.length;i++)
	{
		if(cnts[i].Router && cnts[i].Router != "")
		{
			var idary = cnts[i].Router.split(",");
			var seary = cnts[i].Position.split(",");
			for(var j=0;j<idary.length;j++)
			{
				if(seary[j] == "end")
					inIds[inIds.length] = this._editor.all(idary[j]).StartStep;
				if(seary[j] == "start")
					outIds[outIds.length] = this._editor.all(idary[j]).EndStep;
			}
		}
	}
	var newInItems = [];
	var newOutItems = [];
	for(var i=0;i<inIds.length;i++)
	{
		newInItems[i] = { "TaskId":inIds[i],
						"TaskName":this._editor.all(inIds[i]).all("_name").innerText,
						"Method":"",
						"Condition":""};
		var item = inList.GetItem("TaskId",inIds[i]);
		if(item)
		{
			newInItems[i]["Method"] = item.GetAttr("Method")+"";
			newInItems[i]["Condition"] = item.GetAttr("Condition")+"";
		}
	}
	for(var i=0;i<outIds.length;i++)
	{
		newOutItems[i] = { "TaskId":outIds[i],
						"TaskName":this._editor.all(outIds[i]).all("_name").innerText,
						"Method":"",
						"Condition":"",
						"Name":"",
						"Type":"",
						"ConditionType":""};
		var item = outList.GetItem("TaskId",outIds[i]);
		if(item)
		{
			newOutItems[i]["Method"] = item.GetAttr("Method")+"";
			newOutItems[i]["Condition"] = item.GetAttr("Condition")+"";
			newOutItems[i]["Name"] = item.GetAttr("Name")+"";
			newOutItems[i]["ConditionType"] = item.GetAttr("ConditionType")+"";
			newOutItems[i]["Type"] = item.GetAttr("Type")+"";
		}
	}
	inList.Clear();
	outList.Clear();
	for(var i=0;i<inIds.length;i++)
	{
		var item = inList.NewItem();
		for(key in newInItems[i])
			item.SetAttr(key,newInItems[i][key]+"");
	}
	for(var i=0;i<outIds.length;i++)
	{
		var item = outList.NewItem();
		for(key in newOutItems[i])
			item.SetAttr(key,newOutItems[i][key]+"");
	}
	this._setElementData(ele,ds.ToString());
}

FlowEditor.prototype.SyncCntorData = function(ele)
{	
	var ds = new DataStore(this._getElementData(ele));
	var form = ds.Forms("BasicInfo");
	var sid = ele.StartStep;
	var eid = ele.EndStep;
	if(sid)
	{
		form.SetValue("FromId",sid);
		form.SetValue("FromName",this._editor.all(sid).all("_name").innerText);
	}
	if(eid)
	{
		form.SetValue("ToId",eid);
		form.SetValue("ToName",this._editor.all(eid).all("_name").innerText);
	}
	this._setElementData(ele,ds.ToString());
}
//备用方法
FlowEditor.prototype._getSettingXml = function()
{
	return this._settingXml;
}

FlowEditor.prototype._setSettingXml = function(xml)
{
	this._settingXml = xml;
}

FlowEditor.GetOldFlowSetting = function(editor)
{
	var xml = editor._getSettingXml();
	var pos = xml.indexOf("<FlowSetting>");
	return xml.substr(pos,xml.length - pos - 10);
}

FlowEditor.SetOldFlowSetting = function(editor,xml)
{
	xml = xml;
	editor._setSettingXml(xml);
}
//Extension
FlowEditor.prototype._getCntorsByStartEnd = function(startId,endId)
{
	var eles = [];
	if(!startId && !endId) return eles;
	var polyLines = this._htmlEle.getElementsByTagName("polyline");
	var length = polyLines.length;
	for(var i=0;i<length;i++)
	{
		var xmlele = polyLines[i].parentNode.all("_data").XMLDocument.documentElement;
		var visual = xmlele.selectSingleNode("Visual");
		var isStart = true;
		var isEnd = true;
		if(startId) isStart = visual.getAttribute("StartStep") == startId;
		if(endId) isEnd = visual.getAttribute("EndStep") == endId;
		if(isStart && isEnd)
			eles[eles.length] = polyLines[i].parentNode.parentNode;
	}
	return eles;
}

FlowEditor.prototype.GetCntorsByStartEnd = function(startId,endId)
{
	return this._getCntorsByStartEnd(startId,endId);
}

FlowEditor.prototype.GetCntorsByStart = function(startId)
{
	return this._getCntorsByStartEnd(startId);
}

FlowEditor.prototype.GetCntorsByEnd = function(endId)
{
	return this._getCntorsByStartEnd(null,endId);
}

FlowEditor.prototype._getElements = function(type)
{
	var eles = [];
	var length = this._editor.childNodes.length;
	for(var i=0;i<length;i++)
	{
		var ele = this._editor.childNodes[i];
		if(ele.Type == type)
			eles[eles.length] = ele;
	}
	return eles;
}

FlowEditor.prototype.GetSteps = function()
{
	return this._getElements("Step");
}

FlowEditor.prototype.GetCntors = function()
{
	return this._getElements("Cntor");
}

FlowEditor.prototype.GetMemos = function()
{
	return this._getElements("Memo");
}