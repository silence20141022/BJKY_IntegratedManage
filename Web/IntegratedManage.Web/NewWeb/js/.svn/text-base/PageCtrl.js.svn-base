/**<doc type="varible" name="Global.PageElements">
	<desc>所有表单元素串，用于快速过滤</desc>
</doc>**/
var PageElements="jctree,jcsheet,jccalandar,jcmenu,jctab,jccool";
var Jc={};

/*<doc type="function">
<desc>JcTree对象定义</desc>
<param name="htmlele">所关联的HTML根元素节点</param>
<interface name="className"></interface>
</doc>*/
function JcTree(htmlele)
{	this.Type="jctree";
	if(!htmlele)htmlele=document.createElement("<span class='jctree' jctype='jctree'>");
	this.HtmlEle = htmlele;
	this.HtmlEle.setAttribute("type","jctree");
	this.HtmlEle.Co=this;
	this.HtmlEle.onunload=function(){this.innerHTML="";};
	this.Css = htmlele.className;
	if(!this.Css)
	{	htmlele.className="jctree";
		this.Css="jctree";
	}
	this.Init();

	this.HtmlRootNode = document.createElement("div");
	this.HtmlEle.appendChild(this.HtmlRootNode);
	this.CurrentHtmlNode=null;
	this.selectedHtmlNodes=new Array();
	this.refreshContent=false;
	this.isRunning=false;
	this.caller=null;
	this.renderCache=new Array();
	this.cacheIndex=0;
	//---------东北电力加入-------------
	this.MoveEle=null;
	this.MoveOverEle=null;
	this.MoveIn=null;
	this.MoveOut=null;
	this.MoveY=null;
	//---------东北电力加入-------------
	
	this.HtmlEle["onclick"]=JcTree.DoClick;
	this.HtmlEle["ondblclick"]=JcTree.DoDblClick;
	this.HtmlEle["onmouseover"]=JcTree.DoMouseOver;
	this.HtmlEle["onmouseout"]=JcTree.DoMouseOut;
	this.HtmlEle["oncontextmenu"]=JcTree.DoContextMenu;
	
	//by crow
	this.srcJcNode = null;
	this.aimJcNode = null;
	this.floatObject = null;
	this.mouseOffset = null;
	this.position = null;
	this.orderAction = null;
	this.IsDragAndDrop = null;
	this.HtmlEle["onmousedown"] = JcTree.DoMouseDown;
	this.HtmlEle["onmousemove"] = JcTree.DoMouseMove;
	this.HtmlEle["onmouseup"] = JcTree.DoMouseUp;
	
	this.checkedNode = null;

	//end
	this.redraw();
	if(this.IsExpandAll)
	{	var root=this.GetRootNode();
		if(root)root.ExpandAll();
	}
}

JcTree.prototype.Init=function()
{
	this.HasLinker=GetAttr(this.HtmlEle,"HasLinker",true,"bool");//是否绘制连接线
	this.HideRoot=GetAttr(this.HtmlEle,"HideRoot",false,"bool");//是否隐藏根元素
	this.HasCheckBox=GetAttr(this.HtmlEle,"HasCheckBox",false,"bool");//是否有CheckBox
	this.HasPartCheckBox = GetAttr(this.HtmlEle,"HasPartCheckBox",false,"bool");//是否部分显示 by crow
	this.HasIcon=GetAttr(this.HtmlEle,"HasIcon",false,"bool");//是否有Icon
	this.IsCopyCutPaste=GetAttr(this.HtmlEle,"IsCopyCutPaste",false,"bool");//是否为全部展开状态
	this.IsDragAndDrop=GetAttr(this.HtmlEle,"IsDragAndDrop",false,"bool");//是否为全部展开状态
	this.IsAsyncRender=GetAttr(this.HtmlEle,"IsAsyncRender",false,"bool");//是否异步绘制
	this.IsHighLight=GetAttr(this.HtmlEle,"IsHighLight",true,"bool");
	this.IsFullRowSelect=GetAttr(this.HtmlEle,"IsFullRowSelect",false,"bool");
	this.IsRenderAll=GetAttr(this.HtmlEle,"IsRenderAll",true,"bool");//是否为全部展开状态
	this.IsExpandAll=GetAttr(this.HtmlEle,"IsExpandAll",false,"bool");//是否为全部展开状态
	this.IsThreeCheckState=GetAttr(this.HtmlEle,"IsThreeCheckState",false,"bool");//是否为全部展开状态
	this.CheckParents=GetAttr(this.HtmlEle,"CheckParents",false,"bool");//
	this.CheckChilds=GetAttr(this.HtmlEle,"CheckChilds",true,"bool");//
	this.MetrixColumn=GetAttr(this.HtmlEle,"MetrixColumn",1,"int");
	this.CellsData=GetAttr(this.HtmlEle,"CellsData",null);//username:[width];userage:[width];
	
	this.ContextMenu=GetAttr(this.HtmlEle,"ContextMenu",null);//是否为全部展开状态
	//if(this.ContextMenu)this.InitContextMenu(this.ContextMenu);
	
	this.imagePath=GetAttr(this.HtmlEle,"imagepath",UiStylePath+"/image/jsctrl/tree");
	this.iconPath=GetAttr(this.HtmlEle,"iconpath",UiStylePath+"/image/jsCtrl/jscoolbar/ico");
	this.ViewMode=GetAttr(this.HtmlEle,"ViewMode","free");//JcTree的显示模式free:自由显示/onlyone:只允许一个主节点显示
	this.keyField=GetAttr(this.HtmlEle,"keyfield","key");
	this.xmlTag=GetAttr(this.HtmlEle,"xmltag","jtnode");
	
	this.LinkData=GetAttr(this.HtmlEle,"LinkData",null);
	this.LinkUrl=GetAttr(this.HtmlEle,"LinkUrl",null);
	this.LinkTarget=GetAttr(this.HtmlEle,"LinkTarget",null);
	this.LinkStyle=GetAttr(this.HtmlEle,"LinkStyle",null);

	this.onnodeclick=GetAttr(this.HtmlEle,"onnodeclick",null);
	this.onctrlclick=GetAttr(this.HtmlEle,"onctrlclick",null);
	this.onnodecheck=GetAttr(this.HtmlEle,"onnodecheck",null);
	this.onactionbefore=GetAttr(this.HtmlEle,"onactionbefore",null);
	this.onactionafter=GetAttr(this.HtmlEle,"onactionafter",null);
	//-----------------------------------------------------------
	//2007-08-21 by liuli 解决图档动态树加载的问题
	this.onnodeexpand=GetAttr(this.HtmlEle,"onnodeexpand",null);
	//-----------------------------------------------------------
	
	//by crow 
	this.IsDragAndDrop = GetAttr(this.HtmlEle,"IsDragAndDrop",null);
	this.ondraganddrop = GetAttr(this.HtmlEle,"ondraganddrop",null);
	//end
	this.XmlDoc=null;
	if(GetAttr(this.HtmlEle,"NodeList"))
	{	var node=GetDsNode(GetAttr(this.HtmlEle,"NodeList"));
		if(node)
		{	var xmlnode = node.GetSubXmlNode();
			if(xmlnode)
				this.XmlDoc = LoadXml(xmlnode.xml);
		}
	}	
	if(!this.XmlDoc)
		this.XmlDoc=LoadXml("<jtroot type='_default'></jtroot>");//JcTree的Xml数据
	this.XmlRootNode = this.XmlDoc.documentElement;
	this.NodeTemplate=null;
	if(GetAttr(this.HtmlEle,"NodeTemplate"))
	{	this.NodeTemplate= GetDsNode(GetAttr(this.HtmlEle,"NodeTemplate"));
	}	
}

JcTree.prototype.Destroy=function()
{
	this.HtmlEle.removeChild(this.HtmlEle.childNodes[0]);
}

JcTree.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}

//by crow 2006-9-21 添加拖拽
JcTree.DoMouseDown = function(e)
{
	if(this.IsDragAndDrop==null)
		return false;
	var ev=event; 
	//var this.floatObject = ev.srcElement.parentNode.parentNode.parentNode.all("IconTd");
	//alert(ev.srcElement.parentNode.parentNode.parentNode.all("IconTd").childNodes[0].outerHTML);
	if(ev.srcElement.getAttribute("Id") =="Icon")
	{
		var o = ev.srcElement.parentNode.parentNode.parentNode.all("ContentTd").childNodes[0].childNodes[0];
		
		//创建悬浮层的UI
		this.floatObject=document.createElement("DIV");
		this.floatObject.style.width= "100px";
		this.floatObject.style.height= "20px";
		//this.floatObject.setAttribute("Id","JIANGNING20071101");
		//this.floatObject.Id = "JIANGNING20071101"
		var table_node = document.createElement("Table");
		var tbody_node = document.createElement("tbody");
		var tr_node = document.createElement("TR")
		var td_node1 = document.createElement("TD")
		td_node1.appendChild(ev.srcElement.parentNode.parentNode.parentNode.all("IconTd").childNodes[0].cloneNode(true));
		tr_node.appendChild(td_node1);
		var td_node2 = document.createElement("TD")
		td_node2.appendChild(o.cloneNode(true));				
		tr_node.appendChild(td_node2);		
		tbody_node.appendChild(tr_node);
		table_node.appendChild(tbody_node);			
		this.floatObject.appendChild(table_node);
		
		var jso=this.Co;
		if(!jso || !jso.IsHighLight)return;
		var enode=JcTree.GetEventElement(this,o,"title");
		var hnode=JcTree.GetEventElement(this,o,"node");
		
		if(enode==null||hnode==null)return;
		var tnode= new JcTreeNode(jso,hnode.XmlNode,hnode);
		//alert(tnode.XmlNode.xml)
		this.srcJcNode = tnode;
		//alert(tnode.XmlNode.xml)
		//by crow 拖拽
	}	
}

JcTree.DoMouseMove = function(e)
{
	if(this.IsDragAndDrop==null)
		return false;
	
		
	ev  = window.event;
	var mousePos = mouseCoords(ev);
	if(this.floatObject)
	{
		
		document.body.insertBefore(this.floatObject);
		//移动功能
		with(this.floatObject.style)
		{
			position="absolute";
			left=mousePos.x+5;//event.x;
			top=mousePos.y+5;//event.y;
		}
		//end
		var enode=JcTree.GetEventElement(this,event.srcElement,"ctrler,title,cell,icon,check");
		if(enode!=null)
		{
			this.orderAction  = false;
			this.position = event.y;
			switch(enode.type)
			{
				case "Icon":
				{
					//var enode=JcTree.GetEventElement(this,event.srcElement,"ctrler,title,cell,icon,check");
					var hnode=JcTree.GetEventElement(this,event.srcElement,"node");
					//if(enode!=null||hnode!=null)
					//{	
						var tnode= new JcTreeNode(this.Co,hnode.XmlNode,hnode);
						this.mouseOffset = tnode;
					//}					
					break;
				}
				case "title":
				{
					//var enode=JcTree.GetEventElement(this,event.srcElement,"ctrler,title,cell,icon,check");
					var hnode=JcTree.GetEventElement(this,event.srcElement,"node");
					//if(enode!=null||hnode!=null)
					//{	
						var tnode= new JcTreeNode(this.Co,hnode.XmlNode,hnode);
						this.mouseOffset = tnode;	
					//}	
					break;
				}
				default:
					break;
			}
			
		}
		else
		{
			this.orderAction  = true;			
		}
		
		return false;
	}
}

JcTree.DoMouseUp = function(e)
{
	try
	{
		// 右键菜单（由姜宁组/宁波石化V2导入）
		if(window.event.button == 2)
		{
			if(GetDsNode("Rds.Param.SignState").GetValue()!="Sign")
				return;
			var ValidateFullId = GetDsNode("Rds.Param.ValidateFullId").GetValue();
			var srcele=window.event.srcElement;
			
			if(srcele.getAttribute("Id") =="Icon")
			{
				srcele = srcele.parentNode.parentNode.parentNode.all("ContentTd").childNodes[0].childNodes[0];
				
			}		
			var tree=JcTree.GetEventElement(document.body,srcele,"jctree");
			
			if(!tree)return;
			var jtobj = tree.Co;
			
			var hnode=JcTree.GetEventElement(tree,srcele,"node");
			jtobj.SetCurrentNode(hnode);
			var fullId = hnode.XmlNode.getAttribute("FullId");
			
			if(fullId.indexOf(ValidateFullId)==-1)
			{
				document.all("menu").innerHTML = "";
				return false;
			}
			
			/*alert(hnode.XmlNode.getAttribute("Id"))
			
			alert(hnode.XmlNode.xml)*/
			var param = "";
			var t = hnode.XmlNode.getAttribute("Type");
			if(t!=null && t!=undefined)
			{
				switch(t)
				{
					case "Project":
					{
						var menu = new RightMenu();
						document.all("menu").innerHTML="";
						break;	
					 }
					 case "Phase":
					 {
						var menu = new RightMenu();
						document.all("menu").innerHTML="";
						//param="Major";
						//menu.AddItem("AddNewNodes","start_update","4","<font class=w2kfont>添加专业</font>","rbpm","AddEnumNode",param);
						break;
					 } 
					 case "Major":
					 {
						var menu = new RightMenu();
						param = "TaskItem";
						menu.AddItem("AddNewNodes1","start_update1","4","<font class=w2kfont>添加工作包</font>","rbpm","AddNodeByHand",param);
						param = "DesignTask";
						menu.AddItem("AddNewNodes2","start_update2","4","<font class=w2kfont>添加工作项</font>","rbpm","AddNodeByHand",param);
						document.all("menu").innerHTML=menu.GetMenu();
						
						break;
					 }
					  case "TaskItem":
					  {
						 var menu = new RightMenu();
						param = "TaskItem";
						menu.AddItem("AddNewNodes1","start_update1","4","<font class=w2kfont>添加工作包</font>","rbpm","AddNodeByHand",param);
						param = "DesignTask";
						menu.AddItem("AddNewNodes2","start_update2","4","<font class=w2kfont>添加工作项</font>","rbpm","AddNodeByHand",param);
						
						menu.AddItem("sperator","","","","rbpm","aaa",param);
						menu.AddItem("AddNewNodes3","start_update3","4","<font class=w2kfont>删除</font>","rbpm","DelNode","");
						document.all("menu").innerHTML=menu.GetMenu();
						break;
					  }
					  case "DesignTask":
					 {
						var menu = new RightMenu();
						param = "DesignTask";
						
						menu.AddItem("AddNewNodes3","start_update3","4","<font class=w2kfont>删除</font>","rbpm","DelNode","");
						document.all("menu").innerHTML=menu.GetMenu();
						break;
					 }
					 default:
					 {
						break;
					 }
				 }
			}
		}
		
		if(this.IsDragAndDrop==null)
			return false;
		if(this.floatObject!=null)
		{
			try{
				document.body.removeChild(this.floatObject);
			}catch(e){}
			this.floatObject = null;
			
			var srcele=window.event.srcElement;
			
			if(ev.srcElement.getAttribute("Id") =="Icon")
			{
				srcele = ev.srcElement.parentNode.parentNode.parentNode.all("ContentTd").childNodes[0].childNodes[0];
			}		
			var tree=JcTree.GetEventElement(document.body,srcele,"jctree");
			
			
			if(!tree)return;
			var jtobj = tree.Co;
			
			var enode=JcTree.GetEventElement(tree,srcele,"ctrler,title,cell,icon,check");
			var hnode=JcTree.GetEventElement(tree,srcele,"node");
			if(enode!=null||hnode!=null)
			{		
				var tnode= new JcTreeNode(jtobj,hnode.XmlNode,hnode);
				this.aimJcNode = tnode;
				if(!this.srcJcNode || !this.aimJcNode) return;
				jtobj.SetCurrentNode(hnode);	
			}
			else
			{
				this.aimJcNode = this.mouseOffset;
				if(this.orderAction)
				{
					if(this.position > event.y)
						this.orderAction = "insertbefore";
					else
						this.orderAction = "insertbehind";
				}
			}
			
			//触发事件委托
			this.Event=new Object();
			this.Event.returnValue=true;
			this.Event.srcJcNode = new Object();
			this.Event.aimJcNode = new Object();
			this.Event.orderAction = new Object();
			this.Event.srcJcNode = this.srcJcNode;
			this.Event.aimJcNode  = this.aimJcNode;
			this.Event.orderAction = this.orderAction;
			this.Event.checkedNode = this.checkedNode;
			//if(ev.srcElement.tagName.toLowerCase()=="nobr" || ev.srcElement.tagName.toLowerCase()=="img")
			//{
				if(this.ondraganddrop)
					eval(this.ondraganddrop);
			//}
			this.srcJcNode = null;
			
			//jtobj.redraw();
		}
	}catch(e){}
	//ondraganddrop
	
}



function getMouseOffset(target, ev){
 ev = window.event;
 var docPos    = getPosition(target);
 var mousePos  = mouseCoords(ev);
 return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
}

function getPosition(e)
{
	var left = 0;
	var top  = 0;
	while (e.offsetParent)
	{
		left += e.offsetLeft;
		top  += e.offsetTop;
		e     = e.offsetParent;
	}
 }

function mouseCoords(ev)
{
	if(ev.pageX || ev.pageY)
	{
		return {x:ev.pageX, y:ev.pageY};
	}
	return 	{x:ev.clientX+ document.body.scrollLeft- document.body.clientLeft, y:ev.clientY+ document.body.scrollTop-document.body.clientTop};
}

//end crow



JcTree.GetNodePosition=function(node)//xml node
{	if(node.parentNode.nodeType=="#document")return "";//node is root
	if(node.parentNode.childNodes.length==1)return "A";//only one node
	if(node.previousSibling==null)return "F";//first node
	if(node.nextSibling==null)return "L";//last node
	return "M";//middle node
};
JcTree.GetEventElement=function(parentele,srcele,typestr)
{	var match,js,pnode,node;
	pnode = srcele;
	try{
		do{	node = pnode;
			match = node.getAttribute("type");
			pnode = node.parentNode;
		}while(typestr.indexOf(match)<0 && pnode != null&& node!=parentele);
		if (pnode == null)return null;
		if(typestr.indexOf(match)>=0)return node;
	}catch(e){}
	return null;
}

JcTree.DoDblClick=function (e)
{	var ev=event;
	var jso=this.Co;
	var enode=JcTree.GetEventElement(this,ev.srcElement,"title,cell,icon");
	var hnode=JcTree.GetEventElement(this,ev.srcElement,"node");
	if(enode==null||hnode==null)return;
	switch(enode.type)
	{	case "title":
			break;
		case "cell":
			break;
		case "icon":
			//-----------------------------------------------------------
			//2007-08-21 by liuli 解决图档动态树加载的问题
			jso.SetCurrentNode(hnode);
			if(jso.onnodeexpand)
			{
				if (hnode.XmlNode.childNodes.length==0)
				{
					rtnvalue=jso.Fire("onnodeexpand");
					jso.ExpandCollapse(hnode.XmlNode,hnode);
				}
				else
				{
					rtnvalue=jso.Fire("onnodeexpand");
				}
			}
			//edit by shawn 2006-8-8 for 异步读取
			jso.ExpandCollapse(hnode.XmlNode,hnode);
			//---------------------------------------------------
			
			break;
	}
}
JcTree.DoClick=function(e)
{	
	var srcele=event.srcElement;
	var tree=JcTree.GetEventElement(document.body,srcele,"jctree");
	if(!tree)return;
	var jtobj = tree.Co;
	var enode=JcTree.GetEventElement(tree,srcele,"ctrler,title,cell,icon,check");
	var hnode=JcTree.GetEventElement(tree,srcele,"node");
	if(enode==null||hnode==null)return;
	var tnode= new JcTreeNode(jtobj,hnode.XmlNode,hnode);	
	var ctrl=event.ctrlKey;
	if(event.type=="click")
	{	switch(enode.type)
		{	case "icon":
			case "check":
				break;
			case "title":
			case "cell":
				jtobj.SetCurrentNode(hnode);
				var rtnvalue=true;
				if(jtobj.onnodeclick)
				{
					rtnvalue=jtobj.Fire("onnodeclick");
				}
				if(rtnvalue)
					JcTree.LinkTo(jtobj,hnode.XmlNode);
				break;
			case "ctrler":
				jtobj.SetCurrentNode(hnode);
				var rtnvalue=true;
				if(jtobj.onctrlclick)
				{
					rtnvalue=jtobj.Fire("onctrlclick");
				}				

				//-----------------------------------------------------------
				//2007-08-21 by liuli 解决图档动态树加载的问题
				if(jtobj.onnodeexpand)
				{
					if (hnode.XmlNode.childNodes.length==0)
					{
						rtnvalue=jtobj.Fire("onnodeexpand");
						jtobj.ExpandCollapse(hnode.XmlNode,hnode);
					}
					else
					{
						rtnvalue=jtobj.Fire("onnodeexpand");
					}
				}
				//---------------------------------------------------
				jtobj.ExpandCollapse(hnode.XmlNode,hnode);
				break;
		}
	}
	/*//by crow 拖拽
	if(event.srcElement.tagName. =="NOBR")
	{
		var tnode= new JcTreeNode(jtobj,hnode.XmlNode,hnode);
		this.srcJcNode = tnode;
	}
	//end crow*/
	
}

JcTree._GetLinkUrl=function(item,linkUrl,linkData)
{
	var returnUrl="";
	if(linkData)
	{
		returnUrl=item.getAttribute(linkData);
	}
	else if(linkUrl)
	{	returnUrl=linkUrl;
		while(returnUrl.indexOf("[")!=-1)
		{
			var replaceParam=returnUrl.substring(returnUrl.indexOf("[")+1,returnUrl.indexOf("]"));
			var replaceValue=(item.getAttribute(replaceParam)+"").filterNull();
			returnUrl=returnUrl.replace("[" + replaceParam + "]",escape(replaceValue));
		}
		if(returnUrl.indexOf("{")!=-1)
		{
			var replaceParam=returnUrl.substring(returnUrl.indexOf("{")+1,returnUrl.indexOf("}"));
			var replaceValue=AppServer[replaceParam];
			returnUrl=returnUrl.replace("{" + replaceParam + "}",replaceValue);
		}
	}
	return returnUrl;	
}

JcTree.LinkTo=function(jtobj,xmlnode)
{	
	try
	{
		var linkurl=null,linkdata=null,target=null,style=null;
		if(jtobj.LinkData)
			linkurl = xmlnode.getAttribute(jtobj.LinkData);
		if(!linkurl)
			linkurl = xmlnode.getAttribute("LinkUrl");
		
		target =  xmlnode.getAttribute("LinkTarget");
		style =  xmlnode.getAttribute("LinkStyle");
		
		var item=jtobj.NodeTemplate.GetItem("./*[@Type='" + xmlnode.getAttribute("Type") + "']");
		var typenode=null;
		if(item)
			typenode=item.XmlEle;

		if(typenode)
		{	if(!linkurl)linkurl = typenode.getAttribute("LinkUrl");
			if(!linkdata)linkdata = typenode.getAttribute("LinkData");
			if(!target)target = typenode.getAttribute("LinkTarget");
			if(!style)style = typenode.getAttribute("LinkStyle");
			linkurl=JcTree._GetLinkUrl(xmlnode,linkurl,linkdata);
		}	
		if(!linkurl)linkurl = jtobj.LinkUrl;
		if(!target)target = jtobj.LinkTarget;
		if(!style)style = jtobj.LinkStyle;
		if(linkurl)	
		{	var win = ParamLinkTo(linkurl,xmlnode,target,style);
			if(win)win.focus();
		}
	}
	catch(e){}
}

JcTree.DoMouseOver=function(e)
{	
	var ev=event; 
	var jso=this.Co;
	if(!jso || !jso.IsHighLight)return;
	var enode=JcTree.GetEventElement(this,ev.srcElement,"title");
	var hnode=JcTree.GetEventElement(this,ev.srcElement,"node");
	if(enode==null||hnode==null)return;
	var selstr=ToBool(hnode.getAttribute("select"))? "SelHighLight":"HighLight";
	if(!jso.IsFullRowSelect)
	{	
		enode.className=jso.SubCss("Title"+selstr);
	}
	else
	{
		hnode.childNodes[0].className=jso.SubCss("Title"+selstr);
	}
	event.returnValue=false;
	event.cancelBubble=true;
	this.MoveOut=false;
	this.MoveY=event.y;
	this.MoveOverEle=event.srcElement;
	return false;
}
JcTree.DoMouseOut=function(e)
{	
	var ev=event;
	var jso=this.Co;
	if(!jso || !jso.IsHighLight)return;
	var enode=JcTree.GetEventElement(this,ev.srcElement,"title");
	var hnode=JcTree.GetEventElement(this,ev.srcElement,"node");
	if(enode==null||hnode==null)return;
	var selstr=ToBool(hnode.getAttribute("select"))? "Selected":"";
	if(!jso.IsFullRowSelect)
	{	
		enode.className=jso.SubCss("Title"+selstr);
	}
	else
	{	
		hnode.childNodes[0].className=jso.SubCss("Title"+selstr);
	}
	event.returnValue=false;
	event.cancelBubble=true;
	this.MoveOut=true;
	this.MoveY=event.y;
	return false;
}
JcTree.DoContextMenu=function()
{	var tree=JcTree.GetEventElement(document.body,event.srcElement,"jctree");
	var enode=JcTree.GetEventElement(tree,event.srcElement,"title,cell");
	var hnode=JcTree.GetEventElement(tree,event.srcElement,"node");
	if(enode==null||hnode==null)return;
	event.returnValue=false;
	event.cancelBubble=true;
	return false;
}


JcTree.DoCheckClick=function()
{	
	var ele=event.srcElement;
	var hnode=JcTree.GetEventElement(this,ele,"node");
	var tree=JcTree.GetEventElement(document.body,ele,"jctree");
	var tnode= new JcTreeNode(tree.Co,hnode.XmlNode,hnode);

	var chk=ele.parentNode.childNodes[0];
	var state="";
	if(ToBool(hnode.XmlNode.getAttribute("Disabled")))return;
	
	//Start Modify By Sky
	//Memo:加入OnNodeCheck时的事件
	var rtnvalue = true;
	if(tree.Co.onnodecheck)
	{	rtnvalue=tree.Co.Fire("onnodecheck");
	}
	if(!rtnvalue)
	{
		ele.checked = ! ele.checked;
		return false;
	}	
	//End Modify By Sky
	
	if(tree.Co.IsThreeCheckState)
	{	var val=chk.value;
		if(val=="true")
			state="false";
		else if(val=="false")
			state="default";
		else if(val=="default")
			state="true";
	}else
	{	if(chk.checked)
			state="true";
		else 
			state="false";
	}
	tnode.SetCheckState(state);
}

JcTree.nodeIndex=100000;
JcTree.GetId=function ()
{	return "N"+JcTree.nodeIndex++;
}

JcTree.prototype.Fire=function(eventname)
{	
	this.Event=new Object();
	this.Event.returnValue=true;
	if(eventname=="onnodeclick")
	{	
		this.Event.TreeNode = this.GetCurrentNode();
		if(this.onnodeclick)
			eval(this.onnodeclick);
	}
	else if(eventname=="onnodecheck")
	{	
		var ele=event.srcElement;
		var hnode=JcTree.GetEventElement(this,ele,"node");
		var tree=JcTree.GetEventElement(document.body,ele,"jctree");
		var tnode= new JcTreeNode(tree.Co,hnode.XmlNode,hnode);	
		this.Event.TreeNode = tnode;
		
		if(this.onnodecheck)
			eval(this.onnodecheck);
	}
	//-----------------------------------------------------------
	//2007-08-21 by liuli 解决图档动态树加载的问题
	else if(eventname=="onnodeexpand")
	{
		var ele=event.srcElement;
		var hnode=JcTree.GetEventElement(this,ele,"node");
		var tnode= new JcTreeNode(this,hnode.XmlNode,hnode);	
		this.Event.TreeNode = tnode;
		if(this.onnodeexpand)
			eval(this.onnodeexpand);
	}
	//-------------------------------------------------------------
	else if(eventname=="onctrlclick")
	{
		this.Event.TreeNode = this.GetCurrentNode();
		if(this.onctrlclick)
			eval(this.onctrlclick);
	}
	return this.Event.returnValue;
}

JcTree.prototype._setSelect=function(htmlnode,state)
{	var selstr=state?"Selected":"";
	var titletd=htmlnode.childNodes[0].all("Title");
	if(state)
		htmlnode.setAttribute("select","true");
	else
		htmlnode.setAttribute("select","false");
	if(!this.IsFullRowSelect)
		titletd.className=this.SubCss("Title"+selstr);
	else
		htmlnode.childNodes[0].className=this.SubCss("Title"+selstr);
}

JcTree.prototype.SetCurrentNode=function(htmlnode)
{	
	if(this.CurrentHtmlNode && htmlnode != this.CurrentHtmlNode)
	{	this._setSelect(this.CurrentHtmlNode,false);
		this.CurrentHtmlNode=null;
	}
	this.CurrentHtmlNode=htmlnode;
	this._setSelect(htmlnode,true);
}


JcTree.prototype.clear=function()
{	this.HtmlRootNode.innerHTML="";
}
JcTree.prototype.SubCss=function(name)
{	return this.Css+"_"+name;
}
/*<doc type="function">重新绘制树</doc>*/
JcTree.prototype.redraw=function()
{	var roottype=this.XmlRootNode.getAttribute("type");	
	if(roottype=="_default")return;
	this.HtmlRootNode.innerHTML="";
	this.HtmlRootNode.id="";
	this._renderNode(this.XmlRootNode,this.HtmlRootNode,"",this.IsRenderAll);
	if(this.HideRoot)
		this.HtmlRootNode.childNodes[0].style.display="none";
	this._renderSubNodes(this.XmlRootNode,this.HtmlRootNode.childNodes[1],this.HtmlRootNode.deep,this.IsRenderAll);
	if(this.IsAsyncRender)
		this._execCacheRender();
	//alert(this.HtmlRootNode.outerHTML);
}
/*<doc type="function">刷新节点内容，对发生变化的节点进行更新添加或删除</doc>*/
JcTree.prototype.refresh=function()
{	this._renderSubNodes(this.XmlRootNode,this.HtmlRootNode.childNodes[1],this.HtmlRootNode.deep,true);
}

/*<doc type="function"></doc>*/
JcTree.prototype.SetCss=function(cssname)
{
	this.HtmlEle.className = this.SubCss(cssname);
}


/*<doc type="function">
<param name="srcjtnode">源节点</param>
<param name="desjtnode">目标位置节点</param>
</doc>*/
JcTree.prototype.CopyNode=function(srcjtnode,desjtnode)
{	desjtnode.AddChildByXml(srcjtnode.XmlNode.xml,true);
}
/*<doc type="function">
<param name="srcjtnode">源节点</param>
<param name="desjtnode">目标位置节点</param>
</doc>*/
JcTree.prototype.MoveNode=function(srcjtnode,desjtnode)
{	this.CopyNode(srcjtnode,desjtnode);
	srcjtnode.Remove();
}
/*<doc type="function">
<param name="jtnode">需要全部展开的节点，允许缺省为根节点</param>
</doc>*/
JcTree.prototype.ExpandAll=function()
{	window.status = "正在全部展开树结点,稍候......";
	this.GetRootNode().ExpandAll();
	window.status = "展开结束";
}
/*<doc type="function">
<param name="jtnode">需要全部折叠的节点，允许缺省为根节点</param>
</doc>*/
JcTree.prototype.CollapseAll=function()
{	this.GetRootNode().CollapseAll();
}


/*<doc type="function">
<param name="id">系统内部唯一标识</param>
</doc>*/
JcTree.prototype.ViewNodeById=function(id,selected)
{	var hnode=document.getElementById(id);
	if(hnode == this.HtmlRootNode)
		return new JcTreeNode(this,hnode.XmlNode,hnode);
	var htmp=hnode;
	do{	
		if(htmp.parentNode.style.display=="none")
		{	htmp.parentNode.style.display="";
			var phnode=htmp.parentNode.parentNode;
			phnode.XmlNode.setAttribute("Expand","true");
			this._refreshNodeLinker(phnode.XmlNode,phnode,phnode.deep,false);
		}
		htmp=htmp.parentNode.parentNode;
	}while(htmp != this.HtmlRootNode)
	var rtnnode= new JcTreeNode(this,hnode.XmlNode,hnode);
	if(selected)rtnnode.setSelected(true);
	return rtnnode;
}
/*<doc type="function">
<param name="key">用户唯一标识</param>
</doc>*/
JcTree.prototype.ViewNode=function(keyname,keyvalue,selected)
{	var xnode=this.XmlDoc.selectSingleNode("//*[@"+this.keyname+"='"+keyvalue+"']");
	if(!xnode)return null;
	var id=xnode.getAttribute("_jtid");
	if(id)
	{	return this.ViewNodeById(id,selected);
	}else
	{	return this.ViewNodeByXmlNode(xnode,selected);
	}
}
/*<doc type="function">
<param name="xpath">条件</param>
</doc>*/
JcTree.prototype.ViewNodeByXmlNode=function(xmlnode,selected)
{	var id=xmlnode.getAttribute("_jtid");
	if(id)	return this.ViewNodeById(id);
	var hnode=this._renderPathNode(xmlnode,true);
	var rtnnode= new JcTreeNode(this,hnode.XmlNode,hnode);
	if(selected)rtnnode.setSelected(true);
	return rtnnode;
}
/*<doc type="function">
<param name="id">系统内部唯一标识</param>
</doc>*/
JcTree.prototype.GetNodeByInnerId=function(id)
{	var hnode=document.getElementById(id);
	return new JcTreeNode(this,hnode.XmlNode,hnode);
}
/*<doc type="function">
<param name="key">用户唯一标识</param>
</doc>*/
JcTree.prototype.GetNode=function(keyname,keyvalue)
{	var xnode=this.XmlDoc.selectSingleNode("//*[@"+keyname+"='"+keyvalue+"']");
	if(!xnode)return null;
	var id=xnode.getAttribute("_jtid");
	if(id)
	{	return this.GetNodeByInnerId(id);
	}else
	{	return this.GetNodeByXmlNode(xnode);
	}
}

//add by zhangwf
JcTree.prototype.GetNodeByPath=function(xmlPath)
{	var xnode=this.XmlDoc.selectSingleNode(xmlPath);
	if(!xnode)return null;
	var id=xnode.getAttribute("_jtid");
	if(id)
	{	return this.GetNodeByInnerId(id);
	}else
	{	return this.GetNodeByXmlNode(xnode);
	}
}
JcTree.prototype.GetNodeByXmlNode=function(xmlnode)
{	
	var id=xmlnode.getAttribute("_jtid");

	if(id)	return this.GetNodeByInnerId(id);
	var hnode=this._renderPathNode(xmlnode);//保持原状态
	return new JcTreeNode(this,hnode.XmlNode,hnode);
}

/*<doc type="function"></doc>*/
JcTree.prototype.GetRootNode=function()
{	if(this.XmlRootNode.getAttribute("type")=="_default")
	{	throw new Error(0,"root node is not created.");
	}
	return new JcTreeNode(this,this.XmlRootNode,this.HtmlRootNode);
}

/*<doc type="function">取得当前选中的节点，即最后选中的节点</doc>*/
JcTree.prototype.GetCurrentNode=function()
{	if(this.CurrentHtmlNode)
		return new JcTreeNode(this,this.CurrentHtmlNode.XmlNode,this.CurrentHtmlNode);
	else
		return null;
}

/*<doc type="function">
<param name="jtnode">取得某一节点下Checked的节点</param>
</doc>*/
JcTree.prototype.GetCheckedNodes=function()
{	return this.GetNodes("//*[@CheckState='true']");
}
/*<doc type="function">
<param name="xpath">选择条件</param>
</doc>*/
JcTree.prototype.GetNodes=function(xpath,xmlele)
{	if(xmlele)
		var xnodes=xmlele.selectNodes(xpath);	
	else
		var xnodes=this.XmlDoc.selectNodes(xpath);	
	return this.ToNodes(xnodes);
}

JcTree.prototype.ToNode=function(xmlnode)
{	
	var id=xmlnode.getAttribute("_jtid");
	if(id)
	{	return this.GetNodeByInnerId(id);
	}else
	{	var hnode=this._renderPathNode(xmlnode);//保持原状态
		return new JcTreeNode(this,hnode.XmlNode,hnode);
	}
}
JcTree.prototype.ToNodes=function(xmlnodes)
{
	var nods = new Array();
	for(var i=0;i<xmlnodes.length;i++)
	{	var id=xmlnodes[i].getAttribute("_jtid");
		if(id)
		{	nods[nods.length]=this.GetNodeByInnerId(id);
		}else
		{	var hnode=this._renderPathNode(xmlnodes[i]);//保持原状态
			nods[nods.length]= new JcTreeNode(this,hnode.XmlNode,hnode);
		}
	}
	return nods;
}

JcTree.prototype.ExpandCollapse=function(xmlnode,htmlnode)
{	var deep=htmlnode.deep;
	var exp=ToBool(xmlnode.getAttribute("Expand"));
	var sub=htmlnode.childNodes[1];
	//子节点没有绘制
	if(!exp && xmlnode.childNodes.length>0&&sub.childNodes.length<=0)
	{	xmlnode.setAttribute("Expand","false");//初始化值
		this._renderSubNodes(xmlnode,sub,deep,false);
	}
		if(sub.style.display=="")
		{	sub.style.display="none";
			xmlnode.setAttribute("Expand","false");
		}else
		{	if(sub.innerHTML!="")
			{	sub.style.display="";
				xmlnode.setAttribute("Expand","true");
			}
		}
	
	this._refreshNodeLinker(xmlnode,htmlnode,htmlnode.deep,false);
}

JcTree.GetNodeTmplValue=function(nodetmpl,type,name)
{	var item=null;
	if(!nodetmpl)return null;
	item = nodetmpl.GetItem("Type",type);
	if(!item)return null;
	return item.GetAttr(name);
}
function JcTree.CacheItem(nodebodydiv,xmlnode,deep)
{	this.nodeBodyDiv=nodebodydiv;
	this.XmlNode=xmlnode;
	this.deep=deep;
}
JcTree.prototype._cacheRender=function(nodebodydiv,xmlnode,deep)
{	this.renderCache[this.cacheIndex++]=new JcTree.CacheItem(nodebodydiv,xmlnode,deep);
}
JcTree.prototype._execCacheRender=function()
{	this.isRunning=true;
	this.cacheIndex=0;
	this.caller = new JcCaller(this,2,"_asyncRenderNode");
	this.caller.execTimeout();
}
JcTree.prototype._asyncRenderNode=function()
{	var citem=this.renderCache[this.cacheIndex++];
	this._renderNodeBody(citem.nodeBodyDiv,citem.XmlNode,citem.deep);
	if(this.cacheIndex>=this.renderCache.length)
	{	this.isRunning=false;
		this.cacheIndex=0;
		this.renderCache=new Array();
		this.caller.remove();
		this.caller=null;
	}else
		this.caller.execTimeout();
}

/*<doc type="function">绘制任意一个节点，必须同时绘制节点的所有父节点</doc>*/
JcTree.prototype._renderPathNode=function(xmlnode,expand)
{	var path=Jc.xmlNodePath(xmlnode);
	var nos=path.split("/");
	var count=nos.length;
	var i=2;//first is empty second is root
	var parent=this.XmlRootNode,node=null,hnode=this.HtmlRootNode;
	var sub=hnode.childNodes[1];
	//alert(path);
	while(hnode)
	{	if(nos[i]!="")
		{	sub=hnode.childNodes[1];
			if(expand && sub.style.display=="none")
			{	sub.style.display="";
				parent.setAttribute("Expand","true");
				this._refreshNodeLinker(parent,hnode,hnode.deep,false);
			}
			this._renderSubNodes(parent,sub,hnode.deep,false);
			node = parent.childNodes[parseInt(nos[i])];
			parent = node;
			hnode = sub.childNodes[parseInt(nos[i])];
		}
		i++;
	}
	return sub.parentNode;
}

JcTree.prototype._renderNode=function(xmlnode,htmlnode,deep,includesub)
{	var sub=null;
	var id=xmlnode.getAttribute("_jtid");
	if(!id ||id=="" || !htmlnode.id)
	{	htmlnode.setAttribute("type","node");
		htmlnode.XmlNode=xmlnode;
		//added by huangming 取得已存在树节点Id的最大值,并赋给新增节点
		if(id!="" && id!=null && id.substring(1,7)>JcTree.nodeIndex)
		{
			JcTree.nodeIndex=id.substring(1,7);
		}
		//add end
		if(!id||id==""||id==null)
			htmlnode.id=JcTree.GetId();
		if(!htmlnode.id)
			htmlnode.id=id;
		xmlnode.setAttribute("_jtid",htmlnode.id);
		htmlnode.deep=deep;
		sub=this._renderSubDiv(xmlnode,htmlnode,deep);//sub div include subnodediv
	}else
	{	sub=htmlnode.childNodes[1];
	}
	var expand=ToBool(xmlnode.getAttribute("Expand"));
	if(!includesub&&!expand)return htmlnode;
	if(expand)sub.style.display="";
	this._renderSubNodes(xmlnode,sub,deep,includesub);
	return htmlnode;
}
/*
JcTree.prototype._renderSubNodes=function(xmlnode,subdiv,deep,includesub)
{	var pos=JcTree.GetNodePosition(xmlnode);//get xmlnode position in parent node 
	var nods=xmlnode.childNodes;
	//if(nods.length==hnods.length)return;
//	if(hnods.length>0)subdiv.innerHTML="";
	if(nods.length<=0){
		subdiv.innerHTML="";
		return;
	}
	
	//找到第一个发生变化的元素
	var count=nods.length;
	var begin=0;
	if(!this.refreshContent)//不刷新内容
	{	var hnods=subdiv.childNodes;
		for(var begin=0;begin<count;begin++)
			if(begin>=hnods.length || nods[begin].getAttribute("_jtid") != hnods[begin].id)
				break;
		if(begin>0)begin--;//最后一个元素的Linker可能发生变化
	}
	for(var i=begin;i<count;i++)
	{	var id=nods[i].getAttribute("_jtid");
		if(!id||id=="")//不存在节点
		{	var div = document.createElement("div");
			if(subdiv.childNodes.length<=i)
				subdiv.appendChild(div);
			else
				subdiv.insertBefore(div,subdiv.childNodes[i]);
			this._renderNode(nods[i],div,deep+pos,includesub);
			div._exist="true";
		}else//已经存在节点
		{	var div = subdiv.all(id);
			subdiv.appendChild(div);//变换位置
			this._refreshNodeLinker(div.XmlNode,div,div.deep,true);
			//if(this.refreshContent)
			//	this._refreshNode(div.XmlNode,div,false);
			if(includesub&&nods[i].getAttribute("Expand")=="true")
				this._renderSubNodes(nods[i],div.childNodes[1],div.deep,includesub);
			div._exist="true";
		}
	}
	var hnods=subdiv.childNodes;
	for(var i=begin;i<hnods.length;i++)
		if(hnods[i]._exist != "true")
			subdiv.removeChild(hnods[i--]);
		else
			hnods[i]._exist = "";
}*/

JcTree.prototype._renderSubNodes=function(xmlnode,subdiv,deep,includesub)
{	var pos=JcTree.GetNodePosition(xmlnode);//get xmlnode position in parent node 
	var nods=xmlnode.childNodes;
	var hnods=subdiv.childNodes;
	if(nods.length==hnods.length)return;
	if(hnods.length>0)subdiv.innerHTML="";
	if(nods.length<=0)return;
	var count=nods.length;
	for(var i=0;i<count;i++)
	{	var div = document.createElement("div");
		subdiv.appendChild(div);
		this._renderNode(nods[i],div,deep+pos,includesub);
	}
}
JcTree.prototype._renderSubDiv=function(xmlnode,htmlnode,deep)
{	var div = document.createElement("div");
	div.setAttribute("type","nodebody");
	div.style.cursor="hand";
	htmlnode.appendChild(div);
	if(this.IsAsyncRender)
	{	this._cacheRender(div,xmlnode,deep);
	}else
	{	this._renderNodeBody(div,xmlnode,deep);
	}
	//div.innerHTML=xmlnode.nodeName;
	var subdiv = document.createElement("div");
	subdiv.setAttribute("type","subdiv");
	subdiv.style.display="none";
	htmlnode.appendChild(subdiv);
	return subdiv;
}

//JcTree.NodeDecorate接口
JcTree.prototype._renderNodeBody=function(div,xmlnode,deep)
{	
	var linkerhtml=this._getLinkerHtml(deep);
	var ctrlerhtml=this._getCtrlerHtml(xmlnode,deep);
	var size=deep.length*20;//<=1?deep.length:deep.length+1;
	var cnthtml=this._getNodeContentHtml(xmlnode);
	var ihtml="<table id='NodeBody' class='"+this.SubCss("NodeBody")+"' border=0 cellpadding=0 cellspacing=0 height=20><tr>"+
				"<td id='LinkerTd' width='"+size+"'>"+linkerhtml+ctrlerhtml+"</td>";
	var nocheck=xmlnode.getAttribute("NoCheck");
	//这里的style是由于三态图片的定位
	if(this.HasPartCheckBox && (!ToBool(nocheck) && xmlnode.getAttribute("Displayed")=="T"))
	{
		ihtml+="<td id='CheckTd' width='20' type='check' style='position:relative'>"+this._getCheckHtml(xmlnode)+"</td>";
	}else if(this.HasCheckBox && (!ToBool(nocheck)) )
		ihtml+="<td id='CheckTd' width='20' type='check' style='position:relative'>"+this._getCheckHtml(xmlnode)+"</td>";
	var noicon=xmlnode.getAttribute("NoIcon");
	if(this.HasIcon && (!ToBool(noicon)) )
	{	ihtml+="<td id='IconTd' width='20' type='icon'>"+this._getIconHtml(this.NodeTemplate,xmlnode)+"</td>";
	}
	ihtml+="<td id='ContentTd'>"+cnthtml+"</td><tr></table>";
	div.innerHTML=ihtml;
	//-------------
	if(typeof(JcTree.NodeDecorate)=="function")
		JcTree.NodeDecorate(this,div,xmlnode);
};


 JcTree.prototype._getLinkerHtml=function(deep)
{	var imgstr="";
	if(!deep || deep.length<=1)return "";
	for (var i=1; i< deep.length;i++)//添加结点的填充空或竖线,忽略根节点的退格
	{	var ch=deep.charAt(i);
		if (ch == "F" || ch == "M"){ 
			imgstr+="<img src='"+this.imagePath+"/Line.gif'>";
		}else 
		if (ch == "L"|| ch == "A"){
			imgstr+="<img src='"+this.imagePath+"/Null.gif'>";
		}
	}
	return imgstr;
}
JcTree.prototype._getCtrlerHtml=function (xmlnode,deep)
{	if(deep=="")return "";
	var imgstr="";
	var pos =JcTree.GetNodePosition(xmlnode);
	var vstr="";
	if(xmlnode.childNodes.length>0)
	{	if(ToBool(xmlnode.getAttribute("Expand")))vstr="E";
		else vstr="C";
	}
	if(xmlnode.childNodes.length<=0 && ToBool(xmlnode.getAttribute("IsFolder")))
	{
		vstr="C";
	}
	if(deep.length==1 && this.HideRoot)
	{
		if((xmlnode.childNodes.length==0 && ToBool(xmlnode.getAttribute("IsFolder"))!=true) || (xmlnode.childNodes.length==0))
		{	if(pos=="A")
				imgstr="AN";
			else if( pos=="L")
				imgstr="LN";
			else if(pos=="M")
				imgstr="MN";
			else if(pos=="F")
				imgstr="FN";
		}	
		else
		{	
			if(pos=="A")
				imgstr="AF";
			else if( pos=="L")
				imgstr="LF";
			else if(pos=="M")
				imgstr="MF";
			else if(pos=="F")
				imgstr="FF";
		}
	}else
	{	if((xmlnode.childNodes.length==0 && ToBool(xmlnode.getAttribute("IsFolder"))!=true) || (xmlnode.childNodes.length==0))
		{	if(pos=="A"|| pos=="L")
				imgstr="LN";
			else if(pos=="M"||pos=="F")
				imgstr="MN";
		}
		else
		{	if(pos=="A"|| pos=="L")
				imgstr="LF";
			else if(pos=="M"||pos=="F")
				imgstr="MF";
		}
	}
	return "<img src='"+this.imagePath+"/"+imgstr+vstr+".gif' type='ctrler'>";
};


//提供JcTree_TitleRender接口
JcTree.prototype._getNodeTitleHtml=function (xmlnode)
{	if(typeof(JcTree_TitleRender)=="function")
		return JcTree_TitleRender(this,name,xmlnode);
	else
	{	var title=xmlnode.getAttribute("Title");
		if(!title)title=xmlnode.tagName;
		return "<nobr>"+unescape(title)+"</nobr>";
	}
}
//提供JcTree_CellRender接口
JcTree.prototype._getNodeCellHtml=function (name,xmlnode)
{	if(typeof(JcTree_CellRender)=="function")
		return JcTree_CellRender(this,name,xmlnode);
	else
	{	
		var value=xmlnode.getAttribute(name);
		if(value)return "<nobr>"+unescape(value)+"</nobr>";
		else return "";
	}
}

JcTree.prototype._getNodeContentHtml=function(xmlnode)
{	var html="";
	if(this.CellsData && this.CellsData.length>0)
	{	var sp= new StringParam(this.CellsData);
		html="<table class='" + this.SubCss("Table") + "' style='TABLE-LAYOUT: fixed'><tr>";
		html+="<td height=100% ><div type='title' id='Title' unselectable='on'>"+this._getNodeTitleHtml(xmlnode)+"</div></td>";
		var count=sp.GetCount();
		for(var i=0;i<count;i++)
		{	var valary = sp.GetArray(i);
			var cls="",wid="";
			if(valary.length>1)
				cls="class='"+this.SubCss(valary[1])+"' ";
			else
				cls="class='"+this.SubCss("Cell")+"' ";
			if(valary.length>0)
				wid="width='"+valary[0]+"' ";
			html+="<td type='cell' "+cls+wid+" id='cell' name='"+sp.Keys[i]+"'>"+this._getNodeCellHtml(sp.Keys[i],xmlnode)+"</td>";
		}
		html+="</tr></table>";	
	}else
	{
		if ( xmlnode.getAttribute("FontColor") != null )
			html= "<div type='title' id='Title' unselectable='on' style='color:"+xmlnode.getAttribute("FontColor")+"'>"+this._getNodeTitleHtml(xmlnode)+"</div>";
		else
			html= "<div type='title' id='Title' unselectable='on'>"+this._getNodeTitleHtml(xmlnode)+"</div>";
	}
	return html;
};

JcTree.prototype._getCheckHtml=function(xmlnode)
{	var state=xmlnode.getAttribute("CheckState");
	if(state)
		state=state.toLowerCase();
	else 
	{	if(this.IsThreeCheckState)
			state="default";
		else
			state="false";
	}
	var isDisplay = xmlnode.getAttribute("Displayed")
	if(isDisplay=="T")
	{
		inpdis = "display:none;";
	}
	
	var value=ToBool(state);
	var chked= value ? "checked" : "";
	var inpdis="",triimg="",disabled="";
	if(this.IsThreeCheckState)//处在三态
	{	var imgdis="",img="TriCheck.png";
		if(state!="false")//不是否定则不显示
		{	imgdis="display:none;";
			inpdis="visibility:visible;";
		}else
		{	imgdis="display:;";
			inpdis="visibility:hidden;";
		}
		if(ToBool(xmlnode.getAttribute("Disabled")))
		{	if(state=="false")
				img="TriCheckDis.png";
			disabled=" disabled "; 
		}	
		triimg="<IMG src='/share/image/jsctrl/tree/"+img+"' style='"+imgdis+"position:absolute;left:0;top:0;' onclick='JcTree.DoCheckClick();'>";
	}else
	{	if(ToBool(xmlnode.getAttribute("Disabled")))
			disabled=" disabled ";
	}
	return "<input type='checkbox' "+ chked + " id='Check' "+disabled+" Value='"+state+"' style='"+inpdis+"' onclick='JcTree.DoCheckClick();'>"+triimg; 
}
JcTree.prototype._getIconHtml=function(nodetmpl,xmlnode)
{	//return "<span class='"+this+"'></span>"
	var nodetype = xmlnode.getAttribute("Type");
	var icon=JcTree.GetNodeTmplValue(nodetmpl,nodetype,"Icon");
	if(!nodetmpl||!nodetype||!icon)
		return "<img src='"+this.iconPath+"/044_s.ico' id='Icon'>"; 
	else
		return  "<img src='"+icon+"' id='Icon'>"; 
}


//refresh node body
JcTree.prototype._refreshNode=function(xmlnode,htmlnode,includesub)
{	
	//Start Modify By Sky
	//Memo:解决叶结点下的子节点尚未读取时报错的情况
	//Date:20061023
	if(!htmlnode)
		return;
	//End Modify By Sky
		
	htmlnode.childNodes[0].all("ContentTd").innerHTML=this._getNodeContentHtml(xmlnode);
	if(!includesub)return;
	var subdiv=htmlnode.childNodes[1];
	var nods=xmlnode.childNodes;
	var count=nods.length;
	if(count<=0)return;
	for(var i=0;i<count;i++)
	{	var node=subdiv.childNodes[i];
		this._refreshNode(nods[i],node);
	}
};


//refresh node linker
JcTree.prototype._refreshNodeLinker=function(xmlnode,htmlnode,deep,includesub)
{	
	htmlnode.childNodes[0].all("LinkerTd").innerHTML=this._getLinkerHtml(deep)+this._getCtrlerHtml(xmlnode,deep);
	htmlnode.deep=deep;
	
	if(!includesub)return;
	var subdiv=htmlnode.childNodes[1];
	var pos=JcTree.GetNodePosition(xmlnode);//get xmlnode position in parent node 
	var nods=xmlnode.childNodes;
	var count=nods.length;
	if(count<=0)return;
	for(var i=0;i<count;i++)
	{	var node=subdiv.childNodes[i];
		if(node)//存在子节点未绘制的情况
			this._refreshNodeLinker(nods[i],node,deep+pos,includesub);
	}
}

JcTree.prototype._expandNode=function(htmlnode,includesub)
{	var sub=htmlnode.childNodes[1];
	sub.style.display="";
	htmlnode.XmlNode.setAttribute("Expand","true");
	var hnods=sub.childNodes;
	var xnods=htmlnode.XmlNode.childNodes;
	if(hnods.length!=xnods.length)
	{	if(hnods.length>0)sub.innerHTML="";
		if(xnods.length>0)this._renderSubNodes(htmlnode.XmlNode,sub,htmlnode.deep,false);
	}
	if(xnods.length==0)return;
	else this._refreshNodeLinker(htmlnode.XmlNode,htmlnode,htmlnode.deep,false);
	if(!includesub)return;
	var hnods = htmlnode.childNodes[1].childNodes;
	for(var i=0;i<hnods.length;i++)
	{	this._expandNode(hnods[i],includesub);
	}
}
JcTree.prototype._collapseNode=function(htmlnode,includesub)
{	htmlnode.childNodes[1].style.display="none";
	htmlnode.XmlNode.setAttribute("Expand","false");
	if(htmlnode.XmlNode.childNodes.length==0)return;
	this._refreshNodeLinker(htmlnode.XmlNode,htmlnode,htmlnode.deep,false);
	if(!includesub)return;
	var hnods = htmlnode.childNodes[1].childNodes;
	for(var i=0;i<hnods.length;i++)
	{	this._collapseNode(hnods[i],includesub);
	}
}


/*<doc type="function">
<desc>JcTree节点对象定义</desc>
<param name="owner">所属于的JcTree对象</param>
<param name="xmlnode">关联的XML元素节点</param>
<param name="htmlnode">关联的HTML元素节点</param>
</doc>*/
function JcTreeNode(owner,xmlnode,htmlnode)
{	this.Owner=owner;
	this.XmlNode=xmlnode;
	this.HtmlNode=htmlnode;
}
//刷新节点内容,不考虑节点的添加删除及位置改变
JcTreeNode.prototype.Refresh=function(includesub)
{	if(!includesub)includesub=false;
	this.Owner._refreshNode(this.XmlNode,this.HtmlNode,includesub);
}

JcTreeNode.prototype.Redraw=function(includesub)
{	
	this.HtmlNode.innerHTML="";
	this.HtmlNode.id="";
	this._renderNode(this.XmlNode,this.HtmlNode,this.HtmlNode.deep,false);
	this._renderSubNodes(this.XmlNode,this.HtmlNode.childNodes[1],this.HtmlNode.deep,true);
	if(this.IsAsyncRender)
		this._execCacheRender();
}

JcTreeNode.prototype.Expand=function()
{	
	this.Owner._expandNode(this.HtmlNode,false);
}
JcTreeNode.prototype.Collapse=function()
{	
	this.Owner._collapseNode(this.HtmlNode,false);
}
JcTreeNode.prototype.ExpandAll=function()
{	window.status = "正在展开树结点,稍候......";
	this.Owner._expandNode(this.HtmlNode,true);
	window.status = "展开结束";
	window.setTimeout("window.status='';",1000);
}
JcTreeNode.prototype.CollapseAll=function()
{	
	this.Owner._collapseNode(this.HtmlNode,true);
}

JcTreeNode.prototype.AddChildByXmlNode=function(xmlnode,beforenode)
{	
	xmlnode.attributes.removeNamedItem("_jtid");
	var sub=this.HtmlNode.childNodes[1];
	var div = document.createElement("div");
	var lastchild = this.HtmlNode.childNodes[1].lastChild;
	if(beforenode)
	{	this.XmlNode.insertBefore(xmlnode,beforenode.XmlNode);
		sub.insertBefore(div,beforenode.HtmlNode);
	}else
	{	this.XmlNode.appendChild(xmlnode);
		sub.appendChild(div);
	}
	//本节点在父节点中的位置
	var pos=JcTree.GetNodePosition(this.XmlNode);
	var deep = this.HtmlNode.deep;
	this.Owner._renderNode(xmlnode,div,deep+pos,true);
	//进行Append的情况下刷最后一个子节点连接线,包括其所有的儿子
	if(!beforenode && lastchild)
		this.Owner._refreshNodeLinker(lastchild.XmlNode,lastchild,lastchild.deep,true);
	//刷新本节点连接线
	this.Owner._refreshNodeLinker(this.XmlNode,this.HtmlNode,this.HtmlNode.deep,false);
	return new JcTreeNode(this.Owner,xmlnode,div);
}

JcTreeNode.prototype.AddChild=function(title,type,beforenode,tag)
{	if(!tag)tag="Node";
	var ele = this.Owner.XmlDoc.createElement(tag);
	ele.setAttribute("Title",title);
	ele.setAttribute("Type",type);
	return this.AddChildByXmlNode(ele,beforenode);
}
//includeroot缺省为false
JcTreeNode.prototype.AddChildByXml=function(xmlstr,includeroot,beforenode)
{	
	if(this.XmlNode.childNodes.length == 0)
		var refnode = this.Owner.ToNode(this.XmlNode);
	else
		var refnode = this.Owner.ToNode(this.XmlNode.parentNode.lastChild);

	var xmldoc = LoadXml(xmlstr);
	if(!xmldoc.documentElement)return;
	var rtnary= new Array()
	var xmlele = xmldoc.documentElement;
	var nods = xmldoc.selectNodes("//*");
	for(var i=0;i<nods.length;i++)
		nods[i].attributes.removeNamedItem("_jtid");
		
	if(includeroot)
	{	this.AddChildByXmlNode(xmlele,beforenode);
		rtnary[rtnary.length]=xmlele;
	}
	else
	{	var count=xmlele.childNodes.length;
		if(count<=0)return rtnary;
		//由于采用appendChild[0]是因为appendChild会移除原有节点
		for(var i=0;i<count;i++)
		{	rtnary[rtnary.length]=xmlele.childNodes[0];
			this.AddChildByXmlNode(xmlele.childNodes[0],beforenode);
		}
	}
	return this.Owner.ToNodes(rtnary);
}

JcTreeNode.prototype.Remove=function()
{	//refnode需要刷新连接线的节点
	var last=this.XmlNode.nextSibling;
	if(last ==null)
		last = this.XmlNode.previousSibling
	if(last == null)
		var refnode = this.Owner.ToNode(this.XmlNode.parentNode);
	else
		var refnode = this.Owner.ToNode(last);
		
	if(this.HtmlNode==this.Owner.CurrentHtmlNode)
		this.Owner.CurrentHtmlNode=null;
	this.XmlNode.parentNode.removeChild(this.XmlNode);
	this.HtmlNode.parentNode.removeChild(this.HtmlNode);
	
	var sub=refnode.HtmlNode.childNodes[1];
	this.Owner._refreshNodeLinker(refnode.XmlNode,refnode.HtmlNode,refnode.HtmlNode.deep,false);
}

JcTreeNode.prototype.GetRoot=function()
{	return this.Owner.ToNode(this.Owner.XmlRootNode);
}

JcTreeNode.prototype.SetCss=function(cssName)
{	
	var ele=this.HtmlNode.childNodes[0].childNodes[0].childNodes[0];
	if(!ele)return;
	ele.className=cssName;
}
JcTreeNode.prototype.GetParent=function()
{	if(this.XmlNode == this.Owner.XmlRootNode)
		return null;
	return this.Owner.ToNode(this.XmlNode.parentNode);
}

JcTreeNode.prototype.GetChilds=function()
{	if(this.XmlNode.childNodes.length==0)
		return new Array();
	return this.Owner.ToNodes(this.XmlNode.childNodes);
}

JcTreeNode.prototype.GetCheckedNodes=function(state)
{	if(!state)state="true";
	var nods= this.Owner.GetNodes(".//*[@CheckState='"+state+"']",this.XmlNode);
	if(this.GetCheckState(true)=="true")
		nods[nods.length]=this;
	return nods;
}
//---  .//*[@Name='xx'] 取得本节点下所有符合条件的节点
JcTreeNode.prototype.GetNodes=function(xpath)
{	return this.Owner.GetNodes(xpath,this.XmlNode);
}

JcTreeNode.prototype.GetCheckState=function(isFullValue)
{	var chk = this.HtmlNode.childNodes[0].all("Check");
	var state=chk.getAttribute("Value");
	if(isFullValue)
		return state;
	else
		return ToBool(state)?"T":"F"; 
}

JcTreeNode.prototype.SetCurrent=function()
{
	this.Owner.SetCurrentNode(this.HtmlNode);
}

JcTreeNode.SetCheckState=function(chk,state,isthree)
{	var value = ToBool(state);
	chk.checked = value;
	chk.value=state;
	var img=chk.parentNode.childNodes[1];
	if( isthree && state=="false")
	{	
		if(img)//Modify By Sky
			img.style.display="";
		chk.style.visibility="hidden";
	}else
	{	
		if(img)//Modify By Sky
			img.style.display="none";
		chk.style.visibility="visible";
		chk.checked=value;
	}
}
JcTreeNode.prototype.SetCheckState=function(state,includesub,includeparent)
{	
	var st=(state+"").toLowerCase();
	var inc=includesub+"";
	var incp=includeparent+"";
	if((inc=="true"||this.Owner.CheckChilds)&&(inc!="false"))
	{	
		var chks = ToArray(this.HtmlNode.all("Check"));
		for(var i=0;i<chks.length;i++)
		{	var hnode=JcTree.GetEventElement(this,chks[i],"node");
			JcTreeNode.SetCheckState(chks[i],st,this.Owner.IsThreeCheckState);
			hnode.XmlNode.setAttribute("CheckState",st);
		}
	}else
	{	
		var chk = this.HtmlNode.childNodes[0].all("Check");
		if(chk)
		{	
			JcTreeNode.SetCheckState(chk,st,this.Owner.IsThreeCheckState);
			this.XmlNode.setAttribute("CheckState",st);
		}
	}
	if((incp=="true"||this.Owner.CheckParents)&&(incp!="false")&&ToBool(state))
	{
		var node=this.XmlNode.parentNode;
		while(node.nodeName!="#document")
		{
			this.Owner.GetNodeByXmlNode(node).SetCheckState(true,false,true);
			node=node.parentNode;	
		}
	}	
}
JcTreeNode.prototype.SetCheckDisabled=function(state,includesub)
{	var st=ToBool(state);
	var path="/share/image/jsctrl/tree/";
	if(includesub)
	{	var chks = ToArray(this.HtmlNode.all("Check"));
		for(var i=0;i<chks.length;i++)
		{	var hnode=JcTree.GetEventElement(this,chks[i],"node");
			if(this.Owner.IsThreeCheckState && chks[i].value=="false")
			{	chks[i].parentNode.childNodes[1].src=path+(st?"TriCheckDis.png":"TriCheck.png");
			}
			chks[i].disabled=st;
			hnode.XmlNode.setAttribute("Disabled",st+"");
		}
	}else
	{	var chk = this.HtmlNode.childNodes[0].all("Check");
		if(chk)
		{	
			if(chk.value=="false"&&this.Owner.IsThreeCheckState)
			{	chk.parentNode.childNodes[1].src=path+(st?"TriCheckDis.png":"TriCheck.png");
			}
			chk.disabled=st;
			this.XmlNode.setAttribute("Disabled",st+"");
		}
	}
}

/*<doc type="function">
<param name="fieldname">所要组合的字段名,缺省为_jtid</param>
<param name="stopdeep">取到那一层为止0为缺省值，为根节点</param>
</doc>*/
JcTreeNode.prototype.GetPath=function(fieldname,stopdeep,gap)
{	var node = this.XmlNode;
	var strary=new Array();
	if(!gap)gap=".";
	if(!stopstep)stopstep=0;
	while(node.nodeType != "#document")
	{	if(node.getAttribute(fieldname))
			strary[strary.length]=node.getAttribute(fieldname);
		if(node.getAttribute("PathId").length/8-1<=stopdeep)
			break;
		node = node.parentNode; 
	}
	var ary = strary.slice(stopstep);
	if(ary.length<=0)return "";
	return ary.join(gap);
	
}




//add by tyaloo
//get current treenode full path
JcTreeNode.prototype.GetFullPath=function(fieldname,gap)
{	var node = this;
	var strary=new Array();
	if(!gap)gap=".";

	while(true)
	{
	 var attrValue=node.GetAttr(fieldname);	
	
	  if(attrValue)
			strary.push(attrValue);
		node = node.GetParent(); 
	  if(!node)
	  break;	
	}
   var ary = strary.reverse();
   
	if(ary.length<=0)return "";
	return ary.join(gap);
	
}

JcTreeNode.prototype.SetAttr=function(name,value,refresh)
{	
	//Start Modify By Sky
	//Memo:由于第一次return了,故第二句没有机会执行
	//return this.XmlNode.setAttribute(name,value);
	//End Modify By Sky
	this.XmlNode.setAttribute(name,value);
	if(refresh)this.Refresh(true);	
}

JcTreeNode.prototype.GetType=function()
{	return this.XmlNode.getAttribute("Type");
}

JcTreeNode.prototype.GetAttr=function(name)
{	return this.XmlNode.getAttribute(name);
}
JcTreeNode.prototype.GetHtmlEle=function(name)
{	return this.HtmlEle.childNodes[0].all(name);
}

//
//--------------------------------JcTable对象定义开始---------------------------------------------------
//

/**<doc type="objdefine" name="JcTable">
	<desc>JcTable定义</desc>
	<input>
		<param name="ele" type="object">构建JcTable的XML元素/param>
	</input>	
	<property>
		<prop name="ListData" type="object">JcTable所关联的DataList</param>
		<prop name="ShowTitle" type="object">是否显示Title,默认值为true</param>
		<prop name="SelectMode" type="string">是否为允许单选,多选或禁止选择(none/single/multi)</param>
		<prop name="Border" type="string">是否显示Border,默认值为true</param>
		<prop name="ColDef" type="string">DataItem对应的类型</param>
		<prop name="_DefRow" type="string">JcTable的表头定义</param>
		<prop name="_TmplRow" type="string">JcTable的表的主体模块定义</param>
		<prop name="HighLight" type="boolean">是否高亮显示,默认值为false</param>
		<prop name="IsFullRowSelect" type="string">DataItem对应的类型</param>
		<prop name="CrossRowStyle" type="string">是否有记录间斑马线的样式,默认值为false</param>
		<prop name="SelectedIndex" type="string">DataItem对应的类型</param>
		<prop name="SelectedRow" type="string">DataItem对应的类型</param>
		<prop name="_HLRow" type="object">JcTable的原高亮行</param>
	</property>		
</doc>**/
function JcTable(ele)
{	this.Type="jctable";
	if(!ele)ele=document.createElement("<span class='jctable' jctype='jctable'>");
	this.HtmlEle = ele;
	this.HtmlEle.Co=this;
	this.Css=ele.className;
	if(!this.Css)
	{	//ele.className="jctable";
		this.Css="jctable";
	}
	this.ListData=null;
	this._newData=null;//新增 用来list页面修改
	this.SelectMode="none";//single/multi
	this.Border=true;
	this.ColDef=new Array();
	this._DefRow=null;
	this._TmplRow=null;
	this.HighLight=false;
	this.IsFullRowSelect=false;
	this.CrossRowStyle=false;
	this.SelectedIndex=-1;
	this.SelectedRow=null;
	this.OldIndex=-1;//新增 用来设置上次选中的值
	this._HLRow=null;
	this.PageBar=null;
	this.SummaryBar=null;
	this.PageIndex=null;
	this.QueryForm=null;
	this.Render="client";
	this.TableBody=null;
	this.ContentTBody=null;
	this.Event=new Object();
	this.Init(ele);
}
JcTable.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}
/**<doc type="protofunc" name="JcTable.Init">
	<desc>JcTable的构建器</desc>
	<input>
		<param name="ele" type="object">JcTable对应的HTML元素</param>
	</input>	
</doc>**/
JcTable.prototype.Init=function(ele)
{	
	if(ele.getAttribute("ListData"))
	{	this.ListData = GetDsNode(ele.getAttribute("ListData"));
		this._newData = GetDsNode(ele.getAttribute("ListData"));
		if(!this.ListData){alert("Error!");};
	}else{
		this.ListData = new DataList();
		this._newData = new DataList();
	}
		
	if(ele.getAttribute("SelectMode"))
		this.SelectMode =ele.getAttribute("SelectMode").toLowerCase();
	if(ele.getAttribute("QueryForm"))
		this.QueryForm =GetDsNode(ele.getAttribute("QueryForm"));		
	if(this.QueryForm)
		this.PageIndex = new StringParam(this.QueryForm.GetAttr("PageIndex"));		
			
	//添加滚动条控制元素
	var div = document.createElement("<div class='jctable_body' style='width:100%;height:100%;'>");
	this.TableBody=div;
	this.HtmlEle.childNodes[0].className = "jctable_body";
	this.HtmlEle.childNodes[0].cellPadding = 1;
	this.HtmlEle.childNodes[0].cellSpacing = 1;
	this.HtmlEle.childNodes[0].border = 0;
	div.appendChild(this.HtmlEle.childNodes[0]);
	this.HtmlEle.appendChild(div);
	
	
	if(ele.getAttribute("HighLight")!=null)
		this.HighLight = true;
	if(ele.getAttribute("HasPageBar")!=null)
		this.PageBar = this.GetPageBar();//取得翻页条
		

	if(ele.getAttribute("HasSummaryBar")!=null)
	{
		this.SummaryBarHtmlEle=this.GetSummaryBar();	//取得总计条
	}	
	this.IsAsyncRender=GetAttr(this.HtmlEle,"IsAsyncRender",false,"bool");//是否异步绘制

	this._InitDefine();
	this.RenderObject();
	this.InitEvent();

}

//---------东北电力加入-------------
// 重绘表
JcTable.prototype.Redrow=function(dl)
{
	while( this.ListData.GetItemCount() > 0 )
		this.RemoveRow( 0 );
	this.ListData = dl;
	this._InitDefine();
	this.RenderObject();
	var cn = this.HtmlEle.childNodes[0].childNodes[0];
	cn.removeChild( cn.childNodes[1] );
}

JcTable.prototype.Destroy=function()
{
	this.HtmlEle.removeChild(this.HtmlEle.childNodes[0]);
}

JcTable.prototype.GetSummaryBar=function()
{
	var apb = document.createElement("<DIV>");
	var pageBarHTML="<TABLE cellspacing=0 cellpadding=0 border=0 width=100% height=20 ID=SummaryBar class='"+this.SubCss("SummaryBar")+"'>" +
					"<TD ID='Total' class='"+this.SubCss("SummaryTotal")+"'>共" + this.ListData.GetItemCount() + "条</TD>" + 
					"<TD ID='Content' class='"+this.SubCss("SummaryContent")+"'></TD>" + 
					"</TABLE>";
	apb.innerHTML=pageBarHTML;
	this.SummaryBar=apb;
	this.HtmlEle.appendChild(apb);
	return apb;	
}

///TRC:总的记录数;TPC:总的页数;RCPP:每页记录数;CPN:当前页页码;CPRC:当前页记录数
JcTable.prototype.GetPageBar=function()
{	
	var apb = document.createElement("<DIV>");
	var pageBarHTML="<TABLE  cellspacing=0 cellpadding=0 border=0 width=100% height=20 ID=PageBar class='"+this.SubCss("PageBar")+"'>" +
					"<TD ID='PageInfo' class='"+this.SubCss("PageInfo")+"'></TD>" + 
					"<TD nowrap ID='PageNum' class='"+this.SubCss("PageNum")+"'>"+
						"<BUTTON ID='PageFirst' class='"+ this.SubCss("PageFirst")+"'></BUTTON>&nbsp;" +
						"<BUTTON ID='PagePre' class='"+this.SubCss("PagePre")+"'></BUTTON>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + 
					"</TD>" + 
					"<TD ID='PageArea' align=right class='"+this.SubCss("PageArea")+"'>" + 
						"<BUTTON ID='PageNext' class='"+this.SubCss("PageNext")+"'></BUTTON>&nbsp;" +
						"<BUTTON ID='PageLast' class='"+this.SubCss("PageLast")+"'></BUTTON>&nbsp" + 
					"</TD>" + 
					"</TABLE>";
	var trc = this.PageIndex.Get("TRC");
	apb.innerHTML=pageBarHTML;
	if(trc != null && trc != "0")					
	{
		if ( apb.all("PageFirst") )
			apb.all("PageFirst").onclick = JcTable.DoPageEvent;
		if ( apb.all("PagePre") )
			apb.all("PagePre").onclick = JcTable.DoPageEvent;
		if ( apb.all("PageNext") )
			apb.all("PageNext").onclick = JcTable.DoPageEvent;
		if ( apb.all("PageLast") )
			apb.all("PageLast").onclick = JcTable.DoPageEvent;
	}
	
	if(this.PageIndex)
	{
		this.SetPageInfo(apb);
		this.SetPageNum(apb);
	}
	this.HtmlEle.appendChild(apb);
	return apb;
}
JcTable.prototype.SetPageNum=function(apb)
{	
	var MaxPageNo=8;
	if (this.PageIndex==null) return;
	var pnhtml = "";
	var pnum = parseInt(this.PageIndex.Get("TPC"));
	var cpnum = parseInt(this.PageIndex.Get("CPN"));
	if (pnum<= 0) return;
	var tenBase = parseInt(cpnum/10)*10;
	var tenLeft = cpnum - parseInt(cpnum/10)*10;
	//alert(tenBase);
	//alert(tenLeft);
	if(tenLeft==0)
	{
		if(tenBase>=10)
			tenBase = tenBase-10;
		else
			tenBase = 0;
	}
	for (var i=tenBase; i<pnum; i++)
	{	
		var spn = document.createElement("<SPAN PageNo='" + (i+1) + "'>");
		if (cpnum == i+1)
		{	spn.title="当前为第"+cpnum+"页";
			spn.className = this.SubCss("CurPageNo");
		}else
		{	spn.title="跳转至第"+(i+1)+"页";
			spn.className = this.SubCss("PageNo");
			spn.id="PageJump";
			//jnp edit for alink appearance 08-3-22
			spn.onmouseover="this.className='JcTable_CurPageNo';this.style.cursor='hand';";
			spn.onmouseout="this.className='JcTable_PageNo';this.style.cursor='hand';";
		}
		spn.innerText = i+1;
		if (pnhtml.length == 0 )		
			pnhtml = spn.outerHTML ;
		else
			pnhtml =  pnhtml +"" + spn.outerHTML ;
		if (i>MaxPageNo+tenBase)
		{	pnhtml = pnhtml + "...";
			break;
		}
	}	
	
	var preTen = document.createElement("<SPAN>");
	preTen.title="前十页";
	preTen.className = this.SubCss("PageNo");
	preTen.id="PageJump";
	preTen.innerText = "<<";
	if(tenBase>10)
		preTen.PageNo=tenBase-9;
	else
		preTen.PageNo=1;
	var nextTen = document.createElement("<SPAN>");
	nextTen.title="后十页";
	nextTen.className = this.SubCss("PageNo");
	nextTen.id="PageJump";
	nextTen.innerText = ">>";
	if(tenBase<pnum)
		nextTen.PageNo=tenBase+11;
	else
		nextTen.PageNo==tenBase;
	
	if(pnhtml.trim() != "")
		apb.all("PageNum").innerHTML += "<nobr>"+preTen.outerHTML+"第 "+pnhtml+" 页"+nextTen.outerHTML+"</nobr>";
	var trc = this.PageIndex.Get("TRC");
	if(trc != null && trc != "0")					
	{
		apb.all("PageFirst").onclick = JcTable.DoPageEvent;
		apb.all("PagePre").onclick = JcTable.DoPageEvent;
	}
	var nods = apb.all("PageNum").all("PageJump");
	if(nods)
	{
		if(nods.length)
			for (var i=0; i<nods.length;i++)
			{	nods[i].onclick = JcTable.PageJumpEvent;
			}
		else
			nods.onclick = JcTable.PageJumpEvent;	
	}
}
JcTable.PageJumpEvent=function()
{
	JcTable.DoPageEvent(event.srcElement.PageNo);
}

JcTable.OnPerPageCountChange = function()
{
	if(event.keyCode == 13)
	{
		JcTable.DoPageEvent();
	}
}

JcTable.prototype.SetPageInfo=function(apb)
{	
	if (this.PageIndex!=null)
	{
		var tdrc = this.PageIndex.Get("TDRC");
		var trc = this.PageIndex.Get("TRC");
		var tpc = this.PageIndex.Get("TPC");
		//if (parseInt(tdrc,10)<=parseInt(trc,10))
		if (tdrc<=trc)
		{
			apb.all("PageInfo").innerHTML = 
			"<nobr>共<B>"+(trc==null?0:trc)+"</B>条/<B>" +(tpc==null?0:tpc)+ "</B>页"+
			"&nbsp;每页<input onkeypress='JcTable.OnPerPageCountChange();' type='text' style='width:20' class='jctext' id='RecPerPage'>条</nobr>";
		}
		else
		{
			apb.all("PageInfo").innerHTML = 
			"<nobr>共<B>"+(tdrc==null?0:tdrc)+"</B>条【当前显示<B>"+(trc==null?0:trc)+"</B>条】/<B>" +(tpc==null?0:tpc)+ "</B>页"+
			"&nbsp;每页<input onkeypress='JcTable.OnPerPageCountChange();' type='text' style='width:20' class='jctext' id='RecPerPage'>条</nobr>";
		}
		if(trc != null && trc != "0")
		{
			if ( apb.all("PageFirst") )
				apb.all("PageFirst").onclick = JcTable.DoPageEvent;
			if ( apb.all("PagePre") )
				apb.all("PagePre").onclick = JcTable.DoPageEvent;
			if ( apb.all("PageNext") )
				apb.all("PageNext").onclick = JcTable.DoPageEvent;
			if ( apb.all("PageLast") )
				apb.all("PageLast").onclick = JcTable.DoPageEvent;
		}
		
	}
	apb.all("RecPerPage").value = this.PageIndex.Get("RCPP");
}

JcTable.prototype.Fire=function(type)
{	var onfunc=this.HtmlEle.getAttribute(type);
	try
	{
		if(onfunc)
			eval(onfunc);
	}
	catch(e)
	{
	}
}

JcTable.FunctionButtonClick=function()
{
	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	var obj =ele.Co;
	obj.Event = new Object();
	var funcEle=evele;
	while(!funcEle.functype)
	{
		funcEle=funcEle.parentNode;
	}	
	obj.Event.FuncType=funcEle.functype;
	var trEle=evele;
	while(!trEle.Record)
	{
		trEle=trEle.parentNode;
	}
	obj.Event.returnValue=true;
	obj.Event.Record=trEle.Record;
	obj.Event.Row = trEle;//add by shawn 2008-9-4
	
	var rows= obj.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	for(var i=0;i<rows.length;i++)
	{
		if(rows[i].Record == trEle.Record)
		{
			obj.Event.Index = i;
		}
	}		
	
	obj.Fire("OnFunction");
	if(!obj || !obj.Event || !obj.Event.returnValue)
	{	event.cancelBubble=true;
		event.returnValue=false;
	}
	else
	{
		JcTable.LinkTo();
	}
}

//add by:tyaloo
//date:2007-11-1
//reason:为表格中编辑框绑定事件
JcTable.OnCellInputChange=function()
{
  var evele=event.srcElement;
	
	var ele =GetParentJcElement(evele);
	var obj =ele.Co;
	obj.Event = new Object();


	obj.Event.returnValue=true;
	obj.Event.Row=evele.nowRow;
	

	obj.Fire("OnCellInputChange");


}

JcTable.prototype.SetRecPerPage=function(frm)
{	
	if (this.PageBar==null)return true;
	var rpp = this.PageBar.all("RecPerPage");
	if (!IsInt(rpp.value)||rpp.value <= 0)
	{	alert("请在每页的记录数中填入整数页");
		rpp.value = this.PageIndex.Get("RCPP");
		return false;
	}else
	{	var pi=frm.GetAttr("PageIndex");
		if (pi!=null && pi!="")
		{	var sp = new StringParam(pi);
			sp.Set("RCPP",rpp.value);
			frm.SetAttr("PageIndex",sp.ToString());
		}
		return true;
	}
}

JcTable.DoPageEvent=function(jumpno)
{	
	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	var obj =ele.Co;
	if (obj.QueryForm == null)
	{	alert("没有设定查询DataForm！");
		return;
	}
	obj.Event = new Object();
	if(jumpno)
	{
		obj.Event.PageNo=jumpno;
		obj.QueryForm.SetAttr("JumpNo",jumpno);
	}	
	obj.Event.PageAction=event.srcElement.id;
	obj.QueryForm.SetAttr("PageAction",event.srcElement.id);
	obj.Event.returnValue=true;
	if(!obj.SetRecPerPage(obj.QueryForm))
		return false;
	//df.SetAttr("PageAction",pageAction);
	//if(typeof(jumpno)!="undefined")df.SetAttr("PageJumpNo",jumpno);	
	obj.Fire("OnPageChange");
	if(!obj.Event || !obj.Event.returnValue)return;
	else
		Submit.Get("Query",obj.QueryForm);
}

JcTable.DoSortEvent=function()
{
	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	var obj =ele.Co;
	if (obj.QueryForm == null)
	{	alert("没有设定查询DataForm！");
		return;
	}
	var objTD = event.srcElement;
	while(objTD.tagName!="TD")
	{	objTD=objTD.parentNode;
	}
	var cursortst,newsortst;
	if (objTD.getAttribute("SortState") != null)
		cursortst = objTD.getAttribute("SortState");
	else
		cursortst ="ASC";
	if( cursortst == "ASC")
		newsortst = "DESC";
	else
		newsortst = "ASC";
	obj.QueryForm.SetAttr("OrderBy",objTD.getAttribute("Name")+":"+newsortst+";");
	obj.QueryForm.SetAttr("PageAction","");
	if(!obj.SetRecPerPage(obj.QueryForm))
		return false;
	obj.Event = new Object();
	obj.Event.returnValue=true;
	obj.Fire("OnSort");
	if(!obj.Event || !obj.Event.returnValue)return;
	else
		Submit.Get("Query",obj.QueryForm);
}

/**<doc type="protofunc" name="JcTable._InitDefine">
	<desc>构建JcTable的结构</desc>
</doc>**/
JcTable.prototype._InitDefine=function()
{	var ele = this.HtmlEle;
	this._DefRow=ele.getElementsByTagName("tr")[0];
	var drow=this._DefRow;
	drow.className=this.SubCss("Title");
	var colnum=drow.childNodes.length;
	var trow = drow.cloneNode(false);
	var sortSp=null;
	trow.style.display="";
	
	if (this.QueryForm !=null)
	{	var strob=this.QueryForm.GetAttr("OrderBy");
		if (strob!=null)
			sortSp = new StringParam(strob);
	}		
	for(var i=0;i<colnum;i++)
	{	var tcell=document.createElement("td");
		var cell=drow.childNodes[i];
		cell.className=this.SubCss("TitleTd");
		this._SetSortColumn(cell,sortSp);
		
		tcell.style.cssText = GetAttr(cell,"CellStyle"," ");
		var type=GetAttr(cell,"Type","Data").toLowerCase();
		//设置选择框
		var defobj=this.ColDef[i]=new Object();
		defobj["Type"]=type;
		if(this.SelectMode!="none" && type =="selector")
		{	
			this._SetSelectBox(tcell,cell);
		}
		else
		{	
			if(type=="function")
			{
				tcell.innerHTML=this._GetFunctionHtml(cell);
			}
			else
			{	
				defobj["Name"]=GetAttr(cell,"Name","");
				this.ColDef[defobj["Name"]]=defobj;
				//defobj["DataType"]=GetAttr(cell,"DataType","string");
				defobj["DataType"]=GetAttr(cell,"DataType","string");
				defobj["Enum"]=GetAttr(cell,"Enum",null);
				if(defobj["Enum"])
				{
				  var enumPath=defobj["Enum"];
					defobj["EnumObject"] = GetDsNode(enumPath);
					var enumType=defobj["EnumObject"].GetAttr("Type");
					if(enumType=="RichColor")
					  MakeRichColorEnum(enumPath); 
				}
				defobj["Format"]=GetAttr(cell,"Format",null);
				defobj["IsIcon"]=GetAttr(cell,"IsIcon",null);
			}
			defobj["ColTitle"]=cell.innerText;
			defobj["ToolTip"]=GetAttr(cell,"ToolTip",null);
			defobj["AllowEdit"]=GetAttr(cell,"AllowEdit",null);
			defobj["FuncType"]=GetAttr(cell,"FuncType","default");			
			defobj["LinkUrl"]=GetAttr(cell,"LinkUrl",null);
			defobj["LinkTarget"]=GetAttr(cell,"LinkTarget",null);
			defobj["LinkStyle"]=GetAttr(cell,"LinkStyle",null);
			defobj["LinkData"]=GetAttr(cell,"LinkData",null);
			defobj["DateOnly"]=GetAttr(cell,"DateOnly",null);
			defobj["FilterTime"]=GetAttr(cell,"FilterTime",null);
			defobj["IsTotalCol"]=GetAttr(cell,"IsTotalCol",null);
			defobj["HasTotal"]=GetAttr(cell,"HasTotal",null);
			//alert(GetAttr(cell,"HasTotal",null));
			
			defobj["ValueType"]=GetAttr(cell,"ValueType",null);
			defobj["ColTotal"]=0;
			defobj["RowTotal"]=0;//行合计  zhangwf 2008-09-25
			//新增onchange方法
			defobj["OnChange"]=GetAttr(cell,"OnChange",null);
			defobj["OnMouseOverEvent"] = GetAttr(cell,"OnMouseOverEvent",null);
			//新增onblur方法 zhangwf  2008-09-25
			defobj["OnBlurEvent"] = GetAttr(cell,"OnBlurEvent",null);
			
			defobj["ValueType"]=GetAttr(cell,"ValueType",null);
			defobj["NumberRangeColor"]=GetAttr(cell,"NumberRangeColor",null);
			defobj["ColorColName"]=GetAttr(cell,"ColorColName",null);
			defobj["ColTotal"]=0;
		}
		trow.appendChild(tcell);
	}
	this._TmplRow=trow;
}

JcTable.prototype._SetSortColumn=function(cell,sortSp)
{
	//添加拖动列宽功能jnp 09-2-16
	cell.onmouseover=JcTable.ColumnOnMouseOver;
	cell.onmousedown=JcTable.ColumnOnMouseDown;
	cell.onmousemove=JcTable.ColumnOnMouseMove;
	cell.onmouseup=JcTable.ColumnOnMouseUp;
	cell.onmouseout=JcTable.ColumnOnMouseOut;
	if (cell==null||sortSp==null||cell.getAttribute("AllowSort")==null)return;
	var ele=document.createElement("<div width='100%' height='100%' style='text-align:center;'>");
	var innerHTML = cell.innerHTML;
	//如果是第一子节点是DIV，则以DIV的内容替换 By gd_xiao
	if (  cell.childNodes.length > 0 && cell.childNodes[0].nodeName == "DIV" )
		innerHTML = cell.childNodes[0].innerHTML;
	ele.innerHTML=innerHTML;cell.innerHTML="";//将原Td中的内容放到Div中去
	cell.appendChild(ele);
	if (sortSp.Get(cell.getAttribute("Name"))!=null)
	{	
		if (sortSp.Get(cell.getAttribute("Name")).toUpperCase() == "ASC")
		{	
			ele.className=this.SubCss("SortInc");
			cell.setAttribute("SortState","ASC");	
		}else
		{	
			ele.className=this.SubCss("SortDes");
			cell.setAttribute("SortState","DESC");
		}
	}else
	{	ele.className=this.SubCss("Sort");
		cell.setAttribute("SortState","none");//ASC/DESC
	}
}
/**增加拖动列宽功能 jnp 09-2-16**/
JcTable.ColumnOnMouseOver = function()
{
	if(event.offsetX>this.offsetWidth-10&&this.getAttribute("Type")!="selector")
	{
		this.style.cursor='col-resize';
		this.style.borderRightStyle='dotted';
		this.style.borderRightColor = "red";
	}
	else
	{
        this.style.cursor='default';
    }
}
JcTable.ColumnOnMouseDown = function()
{
	this.mouseDownX=event.clientX;  
 	this.pareneTdW=this.offsetWidth;  
 	this.pareneTableW=this.parentNode.parentNode.parentNode.offsetWidth;  
 	this.setCapture(); 
}
JcTable.ColumnOnMouseMove = function()
{
	if(this.getAttribute("Type")=="selector")return;
	if(!this.mouseDownX)
	{
		return false;  
	}
	else
		this.style.cursor='col-resize';
	var newWidth=this.pareneTdW*1+event.clientX*1-this.mouseDownX;  
	if(newWidth>0)  
	{  
		this.style.width = newWidth; 
		this.parentNode.parentNode.parentNode.style.width=this.pareneTableW*1+event.clientX*1-this.mouseDownX;  
	}  
}
JcTable.ColumnOnMouseUp = function()
{
	//非拖拽事件触发排序
	if(this.mouseDownX&&event.clientX==this.mouseDownX&&this.getAttribute("AllowSort")!=null&&this.getAttribute("Type")!="selector")
	{
		this.onclick = JcTable.DoSortEvent;	
		return;
	}
	this.style.cursor='default';
	this.style.borderRightStyle='';
 	this.releaseCapture();  
	event.cancelBubble = true;
	event.returnValue = false;
 	this.mouseDownX=null;  
}
JcTable.ColumnOnMouseOut = function()
{
	this.style.cursor='default';
	this.style.borderRightStyle='';
}
/**拖动列功能宽增加完毕**/

JcTable.prototype._GetFunctionHtml=function(cell)
{	var ele = this.HtmlEle;	
	var html="";
	var type = cell.getAttribute("FuncType");
	if(!type)return html;
	var type0 = type.toLowerCase();
	html="<img  id='funcflag' onclick='JcTable.FunctionButtonClick();' functype='"+type+"' src='[icon]'>";
	switch(type0)
	{	case "delete":
			html = html.replace("[icon]","/share/image/jsctrl/delete.gif");
			break;
		case "modify":
			html = html.replace("[icon]","/share/image/jsctrl/edit.gif");
			break;
		case "enter":
			html = html.replace("[icon]","/share/image/jsctrl/enter.gif");
			break;
		case "default":
			html = html.replace("[icon]","/share/image/jsctrl/edit.gif");
			break;
		case "view":
			html = html.replace("[icon]","/share/image/jsctrl/Button_see.gif");
			break;
		default:
			if(cell.getAttribute("Icon"))
			{
				html = html.replace("[icon]",cell.getAttribute("Icon"));
			}
			else
			{
				html = "<span onclick='JcTable.FunctionButtonClick();' functype='"+type+"' >" + GetAttr(cell,"FuncHtml","") + "</span>";
			}	
			break;
	}
	return "<span id='_FunctionHtml' content='" + escape(html) + "' class='" + this.SubCss("Link") + "'></span>";
}
JcTable.prototype._SetSelectBox=function(tcell,cell)
{	var ele = this.HtmlEle;	
	tcell.style.width=22;
	cell.style.width=22;
	if(this.SelectMode == "multi")
	{	tcell.innerHTML="<input type='checkbox' id='selector' name='sel_"+ele.id+"'>";
		cell.innerHTML="<input type='checkbox' id='selmaster'>";
	}else if(this.SelectMode == "single")
	{	tcell.innerHTML="<input type='radio' id='selector' name='sel_"+ele.id+"'>";
		cell.innerHTML="<input type='radio' id='selmaster'>";
	}
}
/**<doc type="protofunc" name="JcTable._GetOutputExt">
	<desc>得到每个字段的扩展描述</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="item" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">单元格内的显示文本的扩展信息</output>	
</doc>**/
JcTable.prototype._GetOutputExt=function(def,item)
{	
	return (item.GetAttr(def["Name"]+"_Ext")+"").filterNull();
}
/**<doc type="protofunc" name="JcTable._GetOutput">
	<desc>设置某单元格内的显示格式</desc>
	<input>
		<param name="def" type="object">单元格的定义对象</param>
		<param name="item" type="DataItem">单元格内所设的DataItem</param>
	</input>
	<output type="string">单元格内的显示文本</output>	
</doc>**/
JcTable.prototype._GetOutput=function(index,def,item)
{	
	var colName=def["Name"];
    var colArray=colName.split("+");
    var colArrayLen=colArray.length;
    var txt;
    if(colArrayLen>1)
    {
      var totalValue=0;
      for(var i=0;i<colArrayLen;i++)
      {
         var seleCol=colArray[i];
         var colValue= item.GetAttr(seleCol)-0;
         
         if(!isNaN(colValue))
            totalValue+=colValue;
      }
      txt=totalValue;
    }
    else
    {
		txt=(item.GetAttr(colName)+"").filterNull();
	}
	return this._GetColText(index,def["Name"],txt);
}

/**<doc type="protofunc" name="JcTable._GetColText">
	<desc>设置某单元格内的显示文本</desc>
	<input>
		<param name="name" type="string">单元格名称</param>
		<param name="value" type="string">单元格内所设的值</param>
	</input>
	<output type="string">单元格内的显示文本</output>		
</doc>**/
JcTable.prototype._GetColText=function(index,name,value)
{	
	if(this.ColDef[index].DataType.toLowerCase() != "enum")
    {
		var def = this.ColDef[index];
       	if(def["ValueType"]=="number")
		{
			value =parseFloat(value);
			if(isNaN(value))
				value =0;
			def["ColTotal"]+=value;  

        }    
		return  value;	
	}
	else
	{	
		//****原代码****
		//var txt=this.ColDef[index].EnumObject.GetText(value);
		//if(!txt)return "";
		//return txt;
		//****原代码结束***
		 // modify by MeteorCui on 2006-08-22(此段代码解决ＥＮＵＭ类型多选的情况下，在列表中显示的问题)
	    var valArray = value.split(',');
	    var txtArray = new Array();
	    for(var i=0;i<valArray.length;i++)
	    {
		   var txt=this.ColDef[index].EnumObject.GetText(valArray[i]);
		   if(!txt) 
		      txtArray[i]= "";
		   else
		      txtArray[i]= txt;
		}
		return txtArray.join(',');
	}
}

JcTable.prototype._GetLinkUrl=function(item,linkUrl,linkData)
{
	var returnUrl="";
	if(linkData)
	{
		returnUrl=item.GetAttr(linkData);
	}
	else if(linkUrl)
	{	returnUrl=linkUrl;
		while(returnUrl.indexOf("[")!=-1)
		{
			var replaceParam=returnUrl.substring(returnUrl.indexOf("[")+1,returnUrl.indexOf("]"));
			var replaceValue=(item.GetAttr(replaceParam)+"").filterNull();
			returnUrl=returnUrl.replace("[" + replaceParam + "]",escape(replaceValue));
		}
		if(returnUrl.indexOf("{")!=-1)
		{
			var replaceParam=returnUrl.substring(returnUrl.indexOf("{")+1,returnUrl.indexOf("}"));
			var replaceValue=AppServer[replaceParam];
			returnUrl=returnUrl.replace("{" + replaceParam + "}",replaceValue);
		}
	}
	return returnUrl;	
}

JcTable.prototype.RenderAsyncObject=function()
{	var tbody = this.HtmlEle.all("tbody");
	var row = this._TmplRow.cloneNode(true);
	if(this._CurRenderIndex%2==0)
		row.className=this.SubCss("Row1");
	else
		row.className=this.SubCss("Row2");
	row.setAttribute("PreClassName",row.className);
	this.RenderRow(row,this.ListData.GetItem(this._CurRenderIndex));
	tbody.appendChild(row);	
	this._CurRenderIndex++;
	var rowcount=this.ListData.GetItemCount();
	if(this._CurRenderIndex<rowcount)
		this._AsyncCall.execTimeout();
}

JcTable.prototype._RenderFunctionHtml=function(tbody)
{
	var funcSpan=tbody.all("_FunctionHtml");
	if(funcSpan)
	{
		if(funcSpan.length)
		{
			for(var i=0;i<funcSpan.length;i++)
			{
				funcSpan.item(i).innerHTML=unescape(funcSpan.item(i).content);
			}
		}
		else
		{
			funcSpan.innerHTML=unescape(funcSpan.content);
		}
	}
}

/**<doc type="protofunc" name="JcTable.RenderObject">
	<desc>根据ListData绘制JcTable的主体</desc>
</doc>**/
JcTable.prototype.RenderObject=function()
{	
	if(this.HtmlEle.clientHeight>60 )
	{	if(this.PageBar!=null || this.SummaryBar!=null)
			this.HtmlEle.childNodes[0].style.height=this.HtmlEle.clientHeight-24;
		else
			this.HtmlEle.childNodes[0].style.height=this.HtmlEle.clientHeight;
	}
	this.HtmlEle.childNodes[0].style.overflow="auto";
	//如果已经加过tbody的，则删除 by gd_xiao
	if( this.HtmlEle.childNodes[0].childNodes[0].childNodes.length > 1 )
		this.HtmlEle.childNodes[0].childNodes[0].removeChild(this.HtmlEle.childNodes[0].childNodes[0].childNodes[1]);
	var tbody = document.createElement("<tbody id='tbody'>"); 
	this.ContentTBody=tbody;
	this.HtmlEle.childNodes[0].childNodes[0].appendChild(tbody);
	this.HtmlEle.childNodes[0].childNodes[0].childNodes(0).className = this.SubCss("Title");
	if( this.ListData && this.Render=="client")
	{	/*this._CurRenderIndex=0;
		if(this.IsAsynRender)
		{	this._AsyncCall = new JcCaller(this,10,"RenderAsyncObject");
			this._AsyncCall.execTimeout();
			return;
		}*/
		var rowcount=this.ListData.GetItemCount();
		for(var i=0;i<rowcount;i++)
		{	var row = this._TmplRow.cloneNode(true);
			var pos = i;//GetNodeIndex(row);
			if(pos%2==0)
				row.className=this.SubCss("Row1");
			else
				row.className=this.SubCss("Row2");
			row.setAttribute("PreClassName",row.className);
			//add by tyaloo
			if(this.PageIndex!=null)
			{
				var cpn = parseInt(this.PageIndex.Get("CPN")-1);
				if(cpn<0)
					cpn =0;
				row.index=i+1+cpn*parseInt(this.PageIndex.Get("RCPP"));
			}
			this.RenderRow(row,this.ListData.GetItem(i));
			tbody.appendChild(row);	
		}
		
		//是否有小计
		//是否有合计
		//add by tyaloo
		//date :2007-11-31
		var statTotalSrc=this.HtmlEle.StatTotalSrc;
		if(this.HtmlEle.getAttribute("HasSubTotal")!=null||statTotalSrc!=null)
		{
		 	var subTotalRow;
		 	var totalRow;
		 
		 	if(statTotalSrc!=null&&row!=null)
		    	totalRow=row.cloneNode(true);
		 
		 	if(this.HtmlEle.HasSubTotal&&row!=null)   
		   		subTotalRow=row.cloneNode(true);
		   
		 	var colLen=this.ColDef.length;
		 
		 	var hasTitle=false;
		 	var totalHasTitle=false;
	
			for(var n=0;n<colLen;n++)
			{
				var def=this.ColDef[n];
				if(subTotalRow!=null)
				{
					var seleSubCell=subTotalRow.childNodes[n];
					if(def["ValueType"]=="number")
					{
						seleSubCell.innerText=def["ColTotal"].toFixed(2);
						seleSubCell.style.color="";
		                seleSubCell.style.backgroundColor="";

						//如果是行合计 zhangwf 2008-09-25
						if(def["IsTotalCol"])
						{
							seleSubCell.innerText=def["RowTotal"].toFixed(2);
						}
						else
						{
							seleSubCell.innerText=def["ColTotal"].toFixed(2);
						}
					}
					else if(def["ValueType"]=="title"&&!hasTitle)
					{
						seleSubCell.innerText="小计";
						hasTitle=true;
					}
					else
					{
						seleSubCell.innerText="";
						seleSubCell.style.color="";
		                seleSubCell.style.backgroundColor="";
					}
				}
				if(totalRow!=null)
				{
					var  seleCell=totalRow.childNodes[n];
					if(def["ValueType"]=="number")
					{
						var tmpDf=GetDsNode(statTotalSrc);  
						seleCell.innerText=tmpDf.GetValue(def["Name"]);
						seleCell.style.color="";
		                seleCell.style.backgroundColor="";
					}
					else if(def["ValueType"]=="title"&&!totalHasTitle)
					{
						seleCell.innerText="合计";
						totalHasTitle=true;
					}
					else
					{
						seleCell.innerText="";
						seleCell.style.color="";
						seleCell.style.backgroundColor="";
					}
				}
			}	
			if(subTotalRow!=null)
			{
				subTotalRow.style.backgroundColor = "yellow";
				tbody.appendChild(subTotalRow);
			}
			if(totalRow!=null)
			{
				totalRow.style.backgroundColor = "D09900";
				tbody.appendChild(totalRow);
			}
		}
		this._RenderFunctionHtml(tbody);
	}
}

JcTable.prototype.RenderRow=function(row,item)
{	
	if(item)
		row.Record=item;
	var colcount = this.ColDef.length;
	//行的合计 zhangwf 2008-09-25
	var totalColValue=0;//合计值
	var totalColIndex=-1;
	//--------------------------------
	for(var j=0;j<colcount;j++)
	{	var def = this.ColDef[j];
		var cell=row.childNodes[j];
		var type=def["Type"].toLowerCase();
		
		if(type!="selector"&&type!="function"&&type!="sn")
		{	//cell.innerHTML="";
			var output = this._GetOutput(j,def,item);
			//add by tyaloo
		    var colorColName=def["ColorColName"];

			//是否合计列  zhangwf 2008-09-25
			if(def["IsTotalCol"])
			{
				totalColIndex=j;
			}
			//是否是需要合计的列
			if(def["HasTotal"])
			{
				var value =parseFloat(output);
				if(isNaN(output))
					value =0;
				totalColValue+=value;  
			}
			//-----------------------------------------

		    if(colorColName!=null&&colorColName!=""&&output!="")
		    {
		     var colorEnum=GetDsNode(def["Enum"]);
		     var colorItem=colorEnum.GetItem("*[@Value='"+item.GetAttr(colorColName)+"']");
		     if(colorItem)
		     {
		     
		      var textColor=colorItem.GetAttr("TextColor");
		
		      var textBackColor=colorItem.GetAttr("TextBackColor");
		      cell.style.color=textColor;
		      cell.style.backgroundColor=textBackColor;
		      }
		    }
		    //add by tyaloo
			//为数字列变色
			if(def["ValueType"]=="number")
			{
			  var numberRangeColor=def["NumberRangeColor"];
			   
			  if(numberRangeColor!=""&&numberRangeColor!=null)
			  {
                 eval(numberRangeColor); 
			   }
			}
		  
			if(def["IsIcon"] && def["IsIcon"].toLowerCase() == "true")
				if(output.trim() == "")
					cell.innerHTML="<span style='width:0;height:0;'></span>";
				else
					cell.innerHTML="<span style='width:1;height:1;'><img src='" + output + "'></span>";
			else
			{
				if(def["DateOnly"] != null && def["DateOnly"].toLowerCase() != "false" && output.indexOf(" ") >= 0)
				{
					if(output.substring(0,8) == "1900-1-1" || output.substring(0,10) == "1900-01-01")
						cell.innerHTML="<span style='width:1;height:1;'><nobr></nobr></span>";
					else{
							if(def["ToolTip"] != null)
							{
								cell.innerHTML="<span style='width:1;height:1;' title='"+ output.substring(0,output.indexOf(" ")) +"'><nobr>" + output.substring(0,output.indexOf(" ")) + "</nobr></span>";
							}else
							{
								cell.innerHTML="<span style='width:1;height:1;' ><nobr>" + output.substring(0,output.indexOf(" ")) + "</nobr></span>";
							}
						}
				}
				else if(def["FilterTime"] != null && def["FilterTime"].toLowerCase() != "false" && output.indexOf(" ") >= 0)
				{
					if(output.substring(0,8) == "1900-1-1" || output.substring(0,10) == "1900-01-01")
						cell.innerHTML="<span style='width:1;height:1;'><nobr></nobr></span>";
					else{	
						if(def["ToolTip"] != null)
						{
							cell.innerHTML="<span style='width:1;height:1;' title='"+output+"'><nobr>" + output + "</nobr></span>";					
						}else
						{
							cell.innerHTML="<span style='width:1;height:1;'><nobr>" + output + "</nobr></span>";					
						}
					}	
				}
				else
				{
					var _title = "";
					if(def["ToolTip"] != null)
					{
						if(def["ToolTip"]=="T")
							_title = "title='"+output+"'";
						else
							_title = "title='"+item.GetAttr(def["ToolTip"]).filterNull()+"'";
						//alert(_title);
					}
					if(def["AllowEdit"] != null && (def["AllowEdit"]=="T" || def["AllowEdit"]=="true"))
					{
						if(this._GetOutputExt(def,item)=="readonly")
							cell.innerHTML="<span style='width:1;height:1;'"+_title+"><nobr>" + output + "</nobr></span>";
						else
						{
							var _change = "";
							if(def["OnChange"])
							{
								var _temp = def["OnChange"];
								
								_temp = _temp.replace("{Value}","this.value");
								while(_temp.indexOf("{")>-1)
								{
									var _field = _temp.substring(_temp.indexOf("{")+1,_temp.indexOf("}"));
									_temp = _temp.replace("{"+_field+"}","'"+item.GetAttr(_field).filterNull()+"'");
								}
								_change = "onchange=\""+_temp+"\"";
								
							}
							
							if(def.DataType.toLowerCase()!="enum")
							{
								var OnMouseOver = "";
								if(def["OnMouseOverEvent"])
								{
									OnMouseOver = def["OnMouseOverEvent"];
								}
								//cell.innerHTML="<span style='width:100%;height:1;'"+_title+"><input class=CellTextInput style='WIDTH:100%' value='"+output+"'></span>";
								
								//modify by:tyaloo
								//date:2007-11-1
								//reason:为表格中编辑框绑定事件
								//cell.innerHTML="<span style='width:100%;height:1;'"+_title+"><input class=CellTextInput style='WIDTH:100%' value='"+output+"' "+ _change +"></span>";
								//cell.childNodes(0).childNodes(0).onfocus = JcTable.InputSelectRow;
								cell.innerHTML="<span style='width:100%;height:1;'"+_title+"></span>";

								var cellInput=document.createElement("input");
								cellInput.className="CellTextInput";
								cellInput.style.width="100%";
								cellInput.style.height="100%";
								cellInput.value=output;
								cellInput.nowRow=row;
								cellInput.onchange=JcTable.OnCellInputChange;
							    cell.firstChild.appendChild(cellInput);
								cell.childNodes(0).childNodes(0).onfocus = JcTable.InputSelectRow;
							}
							else
							{
								var _html = "<span style='width:100%;height:1;'"+_title+"><select id='"+j+"' style='WIDTH:100%' "+ _change +">";
								var _enumNode = def.EnumObject;
								var count=_enumNode.GetItemCount();
								for(var p=0;p<count;p++)
								{	var dn = _enumNode.GetItem(p);
									if(output==dn.GetAttr("Text"))
										_html += "<option value='"+dn.GetAttr("Value")+"' selected>" + dn.GetAttr("Text") + "</option>";
									else
										_html += "<option value='"+dn.GetAttr("Value")+"'>" + dn.GetAttr("Text") + "</option>";
								}
								_html += "</select></span>";
								cell.innerHTML = _html;
							}
						}
					}
					else
					{
						if ( def["VColor"] != null )
						{
							var sp= new StringParam(def["VColor"]);
							var count=sp.GetCount();
							var value = output;
							if(def["VColorField"] != null)
								value = item.GetAttr(def["VColorField"]).filterNull();
							var isExist = false;
							for(var i=0;i<count;i++)
							{
								if ( value == sp.Keys[i] )
								{
									if(def["ToolTip"] != null)
									{
										cell.innerHTML="<span style='width:1;height:1;' "+_title+"><nobr><font color="+sp.Values[i]+">" + output + "</font></nobr></span>";
									}else
									{
										cell.innerHTML="<span style='width:1;height:1;'><nobr><font color="+sp.Values[i]+">" + output + "</font></nobr></span>";
									}
									isExist =true;
									break;
								}
							}
							if ( !isExist )
							{
								if(def["ToolTip"] != null)
								{
									cell.innerHTML="<span style='width:1;height:1;' "+_title+"><nobr>" + output + "</nobr></span>";					
								}else
								{
									cell.innerHTML="<span style='width:1;height:1;'><nobr>" + output + "</nobr></span>";					
								}
							}
						} else {
							if(def["ToolTip"] != null)
							{
								cell.innerHTML="<span style='width:1;height:1;' "+_title+"><nobr>" + output + "</nobr></span>";					
							}else
							{
								cell.innerHTML="<span style='width:1;height:1;'><nobr>" + output + "</nobr></span>";					
							}
						}
					}
					
				}
			}	
			if(def["LinkUrl"]||def["LinkData"])
			{	
				//alert(cell.outerHTML);
				cell.childNodes(0).className = this.SubCss("Link");
				cell.childNodes(0).onclick=JcTable.LinkTo;
			}
		}
		else if(type=="function")
		{	
			//cell.className = this.SubCss("Link");
			//cell.onclick=JcTable.LinkTo;
		}
		else if(type=="sn")
		{
		  cell.innerText=row.index;
		
		}
	}

	//设置行合计 zhangwf 2008-09-25
	if(totalColIndex!=-1)
	{
		var cell=row.childNodes[totalColIndex];
		var def = this.ColDef[totalColIndex];
		def["RowTotal"]+=totalColValue;
		//cell.innerHTML="<span style='width:100%;height:1;'"+_title+"><input class=CellTextInput style='WIDTH:100%' value='"+output+"'></span>";
		cell.innerHTML="<span style='width:1;height:1;'"+_title+"><nobr>" + totalColValue.toFixed(2) + "</nobr></span>";
	}
	//alert(cell.innerHTML);
}

JcTable.InputSelectRow=function()
{
	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	if(ele==null)
		return;
	var obj =ele.Co;
	var row = evele.parentNode.parentNode.parentNode;
	obj.SelectRow(row,true);	
}

JcTable.LinkTo=function()
{	var cell=event.srcElement;
	while(cell.tagName!="TD")
	{	cell = cell.parentNode;
	}
	var row=cell.parentNode;
	var ele =GetParentJcElement(row);
	var obj =ele.Co;
	var def = obj.ColDef[GetNodeIndex(cell)];
	var item = row.Record;
	var url=obj._GetLinkUrl(item,def["LinkUrl"],def["LinkData"]);
	var target=def["LinkTarget"];
	var style= CenterWin(def["LinkStyle"]);
	obj.Event = new Object;
	obj.Event.Record=item;
	obj.Event.Name=def["Name"];
	obj.Event.FuncType=def["FuncType"];
	
	var rows= obj.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	for(var i=0;i<rows.length;i++)
	{
		if(rows[i].Record == item)
		{
			obj.Event.Index = i;
		}
	}	
		
	obj.Event.LinkUrl=url;
	obj.Event.returnValue=true;
	obj.Fire("OnLink");
	
	if(!obj || !obj.Event || !obj.Event.returnValue)
	{	
		event.returnValue=false;
		event.cancelBubble=true;
	}
	else
	{
		var win=LinkTo(url,target,style);
		if(win) win.focus();
	}	
}

/**<doc type="protofunc" name="JcTable.InitEvent">
	<desc>初始化JcTable的相关事件</desc>
</doc>**/
JcTable.prototype.InitEvent=function()
{	var tbl=this.HtmlEle.childNodes[0].childNodes[0];

	tbl.onmouseover=JcTable.MouseOver;
	tbl.onmouseout=JcTable.MouseOut;
	tbl.onclick=JcTable.MouseClick;
}

JcTable.prototype.SetDisabled=function(st)
{
	this.Disabled = st;
	this.HtmlEle.disabled = this.Disabled;
}

JcTable.prototype.MasterSelect=function(state)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;//span/div/table/tbody[1]/rows
	for(var i=0;i<rows.length;i++)
	{
		if(this.SelectMode=="single")
		{
			this.SelectRow(rows[i],false);
		}	
		else if(this.SelectMode=="multi")
			this.SelectRow(rows[i],state);
	}
}

JcTable.prototype.GetSelected=function(type)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;//span/div/table/tbody[1]/rows
	var items=new Array();
	for(var i=0;i<rows.length;i++)
	{
		if(rows[i].className.indexOf("RowSelected")>0 || (rows[i].all("selector") && rows[i].all("selector").checked))
		{
			if(type&&type.toLowerCase()=="htmlele")
				items[items.length]=rows[i];
			else
				items[items.length]=this.ListData.GetItem(i);
				
			this.SelectedIndex = i;
		}	
	}
	return items;
}

JcTable.prototype.SetLastRowColor=function(color)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	var count=rows.length;
	var row=rows[count-1];
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{	
		var cell=row.childNodes[j];
		cell.bgColor=color;
		
	}	
}

//add by tyaloo
//GetNewList value
JcTable.prototype.GetModifedSelected=function(type)
{
   var newListData=this.NewListData();
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;//span/div/table/tbody[1]/rows
	var items=new Array();
	for(var i=0;i<rows.length;i++)
	{
		if(rows[i].className.indexOf("RowSelected")>0 || (rows[i].all("selector") && rows[i].all("selector").checked))
		{
			if(type&&type.toLowerCase()=="htmlele")
				items[items.length]=rows[i];
			else
				items[items.length]=newListData.GetItem(i);
		}	
	}
	return items;
}

/**<doc type="protofunc" name="JcTable.SelectRow">
	<desc>设置某一行是否被选中</desc>
	<input>
		<param name="row" type="object">设置的行</param>
		<param name="state" type="boolean">是否选择该行</param>
	</input>
</doc>**/
JcTable.prototype.SelectRow = function(row,state)
{
	//不能选中Title
	if(!row.getAttribute("PreClassName"))
	{
		event.returnValue=false;
		return false;
	}
		
	if(this.SelectMode=="single")
	{
		var prow=this.SelectedRow;
		if(prow)
		{	prow.selected = false;
			prow.className=prow.getAttribute("PreClassName");
		}
		row.selected = state;
		if(row.all("selector"))
		{
			row.all("selector").checked=state;
		}	
		if(state)
		{	
			row.className=this.SubCss("RowSelected");
			this.SelectedRow=row;
		}else
		{	
			row.className=row.getAttribute("PreClassName");
		}		
	}
	else if(this.SelectMode=="multi")
	{
		row.selected = state;
		if(row.all("selector"))
		{
			row.all("selector").checked=state;
		}	
		if(state)
		{	
			row.className=this.SubCss("RowSelected");
		}else
		{	
			row.className=row.getAttribute("PreClassName");
		}	
	}
	this.Event = new Object;
	this.Event.Row = row;
	this.Event.Record=row.Record;
    //增加index索引 shawnyu
    this.Event.OldIndex = this.OldIndex;
    this.Event.Index = -1;
    var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	for(var i=0;i<rows.length;i++)
	{
		if(rows[i] == row)
		{
			this.Event.Index = i;
			break;
		}
	}
	this.OldIndex = this.Event.Index;
    
	this.Event.returnValue=true;
	this.Fire("OnRowStateChange");	
}

JcTable.prototype.SelectRowByFieldValue=function(fieldName,fieldValue,state)
{	
	if(typeof(state)=="undefined"||state==null)
		var state=true;
		
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	for(var i=0;i<rows.length;i++)
	{
		var item=rows[i].Record;
		if(item.GetAttr(fieldName)==fieldValue)
		{
			this.SelectRow(rows[i],state);
		}
	}
}


/**<doc type="protofunc" name="JcTable.HighLightRow">
	<desc>设置某一行是否被高亮显示</desc>
	<input>
		<param name="row" type="object">设置的行</param>
		<param name="state" type="boolean">是否高亮显示该行</param>
	</input>
</doc>**/
JcTable.prototype.HighLightRow = function(row,state)
{	var prow=this._HLRow;
	if(prow)
	{	if(prow.selected)
			prow.className=this.SubCss("RowSelected");
		else
			prow.className=prow.getAttribute("PreClassName");
	}
	this._HLRow=row;
	if(row.selected)
		if(this.HighLight)
			row.className=this.SubCss("RowSelHighLight");	
		else
			row.className = this.SubCss("RowSelected");	
	else
		if(this.HighLight)
			row.className = this.SubCss("RowHighLight");	
		else
			row.className=row.getAttribute("PreClassName");
}

/**<doc type="protofunc" name="JcTable.ClearHighLight">
	<desc>清除高亮显示</desc>
</doc>**/
JcTable.prototype.ClearHighLight=function()
{	var prow=this._HLRow;
	if(prow)
	{	if(prow.selected)
			prow.className=this.SubCss("RowSelected");
		else
		{
			prow.className = prow.getAttribute("PreClassName");	
		}	
	}
}

/**<doc type="protofunc" name="JcTable.ClearSelected">
	<desc>清除选择</desc>
</doc>**/
JcTable.prototype.ClearSelected=function()
{			
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;//span/div/table/tbody[1]/rows
	for(var i=0;i<rows.length;i++)
		this.SelectRow(rows[i],false);
}

JcTable.prototype.GetRowByRecord=function(rec)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	for(var i=0;i<rows.length;i++)
	{
		var item=rows[i].Record;
		if(item==rec)
			return rows[i];
	}
	return null;
}

//add by tyaloo
JcTable.prototype.GetRowByIndex=function(index)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	var rowLen=rows.length;
    if(typeof(index)=="number"&&index<rowLen)
    return rows[index];
	return null;
}

JcTable.prototype.RemoveRowByFieldValue = function()
{
	var tbody=this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
	var removeTr = new Array();
	for(var i = 0;i < tbody.childNodes.length;i++)
	{
		var flag = true;
		var tr = tbody.childNodes(i);

		for(var j = 0;j < arguments.length;j = j + 2)
		{
			if(tr.Record.GetAttr(arguments[j]) != arguments[j + 1])
				flag = false;
		}
		if(flag == true)
			removeTr[removeTr.length] = tr;
	}
	for(var i = 0;i < removeTr.length;i++)
	{
	  //add by tyaloo 
	  //reason: before delete row,fire OnRowStateChange event,cancel the job when row selected done. 
		var deleRow=removeTr[i];
		deleRow.selected=false;
		this.Event = new Object;
		this.Event.Row = deleRow;
		this.Event.Record=deleRow.Record;
		this.Event.returnValue=true;
		this.Fire("OnRowStateChange");	
	  //end 	
	  
		this.ListData.Remove(deleRow.Record);
		tbody.removeChild(deleRow);	
	}
}
JcTable.prototype.RemoveRow=function(index,type)
{
	var tbody=this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
	var tr=null;
	
	if(!type)
		type="htmlele";
	
	if(typeof(index)=="number")
		tr=tbody.childNodes(index);
	else if(type.toLowerCase()=="htmlele")
	{
		tr=index;
	}
	else if(type.toLowerCase()=="record")
	{
		tr=this.GetRowByRecord(index);
	}
	
	if(tr)
	{	
		this.ListData.Remove(tr.Record);
		tbody.removeChild(tr);
	}
}

//by tyaloo
JcTable.prototype.RemoveRowByRow=function(tr)
{
	var tbody=this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
	
	if(tr)
	{	
		this.ListData.Remove(tr.Record);
		tbody.removeChild(tr);
	}
}
// by crow
JcTable.prototype.SelectAll=function()
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;//span/div/table/tbody[1]/rows
	var items = new Array();
	for(var i=0;i<rows.length;i++)
	{
		items[items.length]=rows[i];
				
	}
	return items;
}

JcTable.prototype.AddRow=function()
{
	var row = this._TmplRow.cloneNode(true); 
	var item=this.ListData.NewItem();	
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
	var table=this.HtmlEle.childNodes(0).childNodes(0);
	var tbody=table.childNodes(1);
	if(tbody.childNodes.length==0)
		row.className="jctable_row1";
	else
	{
		var preRowClass=tbody.childNodes(tbody.childNodes.length-1).className;
		if(preRowClass.toLowerCase()=="jctable_row1")
			row.className="jctable_row2";
		else
			row.className="jctable_row1";	
	}	
	
	row.setAttribute("PreClassName",row.className);	
	this.RenderRow(row,item);
	tbody.appendChild(row);
	this._RenderFunctionHtml(tbody);
	table.scrollIntoView(false);
	return row;
}

//add by MeteorCui on 2006-08-29
JcTable.prototype.AddItem=function(item)
{
	var row = this._TmplRow.cloneNode(true); 
	this.ListData.AddItem(item);
	var table=this.HtmlEle.childNodes(0).childNodes(0);
	var tbody=table.childNodes(1);
	if(tbody.childNodes.length==0)
		row.className="jctable_row1";
	else
	{
		var preRowClass=tbody.childNodes(tbody.childNodes.length-1).className;
		if(preRowClass.toLowerCase()=="jctable_row1")
			row.className="jctable_row2";
		else
			row.className="jctable_row1";	
	}	
	
	row.setAttribute("PreClassName",row.className);	
	this.RenderRow(row,item);
	tbody.appendChild(row);
	this._RenderFunctionHtml(tbody);
	table.scrollIntoView(false);
	return row;
}

JcTable.prototype.UpdateRow=function(row)
{
	var item = row.Record;
	for(var i=1;i<arguments.length;i=i+2)
	{
		var name=arguments[i];
		var value=arguments[i+1];
		item.SetAttr(name,value);
	}
	this.RenderRow(row,item);
}

/**<doc type="protofunc" name="JcTable.MouseOver">
	<desc>定义MouseOver事件</desc>
</doc>**/
JcTable.MouseOver=function()
{	
	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	//edit by shawn ,屏蔽拖拽事件到控件外,date 20060926
	if(ele==null||ele.jctype.toLowerCase()!="jctable")
	{
		event.returnValue = false;
		return false;
	}
	var row=GetTableTr(event.srcElement);
	if(!row||row==ele.childNodes[0].childNodes[0].childNodes[0].childNodes[0])return;//span/div/table/tbody/tr/
	
	var obj =ele.Co;
	//Start Modify By Sky
	//Memo:添加OnMouseMoveOver事件
	//Date:20060627
	obj.Event = new Object;
	obj.Event.returnValue = true;
	obj.Event.Record=row.Record;
	obj.Fire("OnMouseMoveOver");
	if(!obj || !obj.Event || !obj.Event.returnValue)
	{	event.cancelBubble=true;
		event.returnValue=false;
		return false;
	}
	//End Modify By Sky		
	if(obj.HighLight)
		obj.HighLightRow(row,true);
}

/**<doc type="protofunc" name="JcTable.MouseClick">
	<desc>定义MouseClick事件</desc>
</doc>**/
JcTable.MouseClick=function()
{	var evele=event.srcElement;
	var ele =GetParentJcElement(evele);
	if(ele==null)
		return;
	var obj =ele.Co;
	//由于在点选中响应的可能是Table本身,或者是TBody,此时将该事件Cancel掉
	if(evele.tagName.toLowerCase()=="table"||evele.tagName.toLowerCase()=="tbody")
	{
		event.returnValue = false;
		return false;
	}	
	//Start Modify By Sky
	//Memo:当JcTable被禁止时，不能相应MouseClick事件
	//Date:20060623
	if(obj.Disabled)
	{
		event.returnValue = false;
		return false;	
	}
	//End Modify By Sky	
	var row=GetTableTr(evele);
	if(row)
	{
		if(evele.tagName!="INPUT")
		{
			obj.Event = new Object;
			obj.Event.Record=row.Record;
			obj.Event.returnValue=true;
			obj.Fire("OnRowClick");
			if(!obj.Event.returnValue)
			{	return;
			}	
		}
		if(evele.tagName.toLowerCase()=="input" && evele.id=="selmaster")
		{	
			obj.MasterSelect(evele.checked);
			return;
		}
		if(!row||row.all("selmaster"))return;
		if(obj.SelectMode=="single")
		{
			obj.SelectRow(row,true);
		}
		else if(obj.SelectMode=="multi")
		{
			obj.SelectRow(row,!row.selected);	
		}	
	}
}

/**<doc type="protofunc" name="JcTable.MouseOut">
	<desc>定义MouseOut事件</desc>
</doc>**/
JcTable.MouseOut=function()
{	var ele =GetParentJcElement(event.srcElement);
	if(ele==null)
		return;
	var obj =ele.Co;
	obj.ClearHighLight();
}

/**<doc type="protofunc" name="JcTable.MouseOut">
	<desc>定义MouseOut事件</desc>
</doc>**/
JcTable.prototype.NewListData=function()
{
	var _idxs = _names = "";
	var colcount = this.ColDef.length;
	for(var j=0;j<colcount;j++)
	{
		var def = this.ColDef[j];
		if(def["AllowEdit"] != null && (def["AllowEdit"]=="T" || def["AllowEdit"]=="true"))
		{
			_idxs += j + ",";
			_names += def["Name"] + ",";
		}
	}
	if(_idxs=="")
		return this._oldData;
	else
	{
		var tbody=this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
		_idxs = _idxs.substring(0,_idxs.length-1);
		_names = _names.substring(0,_names.length-1);
		var _tempvalue = null;
		var _idxa = _idxs.split(',');
		var _namea = _names.split(',');
		for(var j=0;j<this._newData.GetItemCount();j++)
		{
			var tr=tbody.childNodes(j);
			for(var p=0;p<_idxa.length;p++)
			{
				_tempvalue = tr.childNodes(_idxa[p]).childNodes(0).childNodes(0);
				if(_tempvalue.tagName.toLowerCase()=="input"||_tempvalue.tagName.toLowerCase()=="select")
					this._newData.GetItem(j).SetAttr(_namea[p],_tempvalue.value);
				else
				{
					this._newData.GetItem(j).SetAttr(_namea[p],_tempvalue.innerText);
				}
			}
		}
		return this._newData;
	}
}

JcTable.prototype.Reset = function(dataList)
{
	var count = this.ListData.GetItemCount();
	for(var i=0;i<count;i++)
		this.RemoveRow(0);
	
	count = dataList.GetItemCount();
	for(var i=0;i<count;i++)
		this.AddRow(dataList.GetItem(i));
}

//jnpadd客户端重绘
JcTable.prototype.ReRender = function(datalist)
{
	var table = this.HtmlEle.childNodes[0].childNodes[0];
	var tbody = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
	table.removeChild(tbody);//清除,否则会叠加
	this.ListData=datalist;
	this.RenderObject();
}
//ReRender End

//created by tyaloo
//for:export jctable to excel
//create date:2007-11-18
JcTable.prototype.ToExcel=function(changeStyle)
{
   if(changeStyle==null)
      changeStyle =false; 
   HTMLToExcel(this.TableBody,changeStyle);
}

//created by tyaloo
//for:export jctable to word
//create date:2007-11-18
JcTable.prototype.ToWord=function()
{
    HTMLToWordForJcTable(this.TableBody);
}

//jnpadd 08-6-12
JcTable.prototype.SetRowClassByValue=function(col,colValue,color,changeColorNow)
{
	var rows= this.HtmlEle.childNodes[0].childNodes[0].childNodes[1].childNodes;
	var count=rows.length;
	for(var i=0;i<rows.length;i++)
	{
		var row=rows[i];
		if(row.Record.GetAttr(col)==colValue)
		{
			if(changeColorNow)
				row.className = color;
			row.PreClassName = color;
		}	
	}
}

//
//--------------------------------JcTable对象定义结束---------------------------------------------------
//


//
//--------------------------------JcPopMenu对象定义开始-------------------------------------------------
//
function JcPopMenu(dataStore,invoker)
{
	this.Type="jcpopmenu";
	this.Invoker=invoker;
	this.Init(dataStore);
}
JcPopMenu.prototype.Init=function(dataStore)
{	
	for(var i=0;i<dataStore.GetNodeCount("List");i++)
	{
		var type=dataStore.Lists(i).GetAttr("Type");
		if(type&&type=="Menu")
		{	
			var name=dataStore.Lists(i).GetAttr("Name");
			JcPopMenuItem.Menus[name]=new JcPopMenuItem(GetDsNode(dataStore.GetAttr("Name")+".List."+name,dataStore).ToString());
			JcPopMenuItem.Menus[name].Invoker=this.Invoker;
		}
	}
}
JcPopMenu.prototype.Show=function(menuName,left,top,parentObject)
{
	if(parentObject)
		JcPopMenuItem.Menus[menuName].Show(left,top,parentObject);
	else
		JcPopMenuItem.Menus[menuName].Show(left,top,this);
	AttachBodyMouseDown("_Cb_JcPopMenu",this,JcPopMenu.HideAll);
}
JcPopMenu.HideAll=function(obj)
{
	for(var menuName in JcPopMenuItem.Menus)
	{
		JcPopMenuItem.Menus[menuName].Hide();
	}
}
JcPopMenu.prototype.Hide=function(menuName)
{
	if(menuName)
		JcPopMenuItem.Menus[menuName].Hide();
	else
		JcPopMenu.HideAll();
}
JcPopMenu.prototype.Get=function(menuName)
{
	return JcPopMenuItem.Menus[menuName];
}
//
//--------------------------------JcPopMenu对象定义结束---------------------------------------------------
//


function JcPopMenuItem(menuxml)
{	this.Type="jcpopmenuitem";
	this.MenuFrame=null;
	this.MenuList=new DataList(menuxml);
	this.Invoker=null;
	this.Init();
}

JcPopMenuItem.Menus={};

JcPopMenuItem.prototype.Init=function()
{	
	var frm = document.createElement("<iframe id='_jcmenu_' frameborder='0' scrolling='no' style='border:solid 1;position:absolute;z-index:10000;width:1;height:1;display:none;' src='/share/page/jcmenu.htm'></iframe>");
	frm.className = "JcMenu_Frame";
	document.body.appendChild(frm);
	this.MenuFrame = frm;
	this.MenuFrame.Master=this;//把Iframe元素和控制元素建立关联
	this.MenuFrame.State="init";//设置为初始化状态
	this.MenuFrame.onblur=JcPopMenuItem.Blur;
}

JcPopMenuItem.prototype.GetItemTr=function(index)
{
	var win = this.MenuFrame.contentWindow;
	return win.GetItemTr(index);
}

JcPopMenuItem.prototype.RenderMenu=function(parentObject)
{	
	var frm=this.MenuFrame;
	var win = this.MenuFrame.contentWindow;
	var doc = win.document;
	win.RenderMenu(this,parentObject);
	frm.style.width = doc.body.scrollWidth+2;
	frm.style.height = doc.body.scrollHeight+2;
}

JcPopMenuItem.prototype.Show=function(left,top,parentObject)
{	var frm = this.MenuFrame;
	if(frm.style.display== "none")
	{	frm.style.left = left;
		frm.style.top =top;
		frm.style.display="block";
		frm.focus();
	}
	if(frm.State=="init")
	{	this.RenderMenu(parentObject);
		frm.State="render";
	}
}
JcPopMenuItem.prototype.Hide=function()
{
	var frm=this.MenuFrame;
	var win = this.MenuFrame.contentWindow;
	win.HideSubMenu();
	frm.style.display="none";
}
JcPopMenuItem.Blur=function()
{
}



//
//--------------------------------JsGridMap对象定义开始---------------------------------------------------
//

function JsGridMap(rownum,colnum)
{	this.Datas=new Array();
	
	for(var j=0;j<rownum;j++)
	{	this.Datas[j]=new Array();
		for(var i=0;i<colnum;i++)
			this.Datas[j][i]=j+","+i;
	}

}
JsGridMap.prototype.Merge=function(rowstart,rowend,colstart,colend)
{	var value=this.Datas[rowstart][colstart];
	for(var j=rowstart;j<=rowend;j++)
	{	for(var i=colstart;i<=colend;i++)
			this.Datas[j][i]=value;
	}
}
//Logic(Row,Col)->Table
JsGridMap.prototype.CellIndex=function(row,col)
{	
	if(row<0||row>=this.Datas.length)
		return null;
	var rary = this.Datas[row];
	if(!rary || col<0||col>=rary.length)
		return null;
	var tmpcol=-1;
	for(var i=0;i<=col;i++)
		if(rary[i]==row+","+i)
			tmpcol++;
	if(tmpcol<0)return null;
	return new Array(row,tmpcol);
}

//
//--------------------------------JsGridMap对象定义结束---------------------------------------------------
//

//
//--------------------------------JcSheet对象定义开始---------------------------------------------------
//

function JcSheet(ele)
{	
	this.Type="jcsheet";
	if(!ele)	
		ele=document.createElement("<span class='jcsheet' jctype='jcsheet'>");
	this.HtmlEle=ele;
	this.HtmlEle.Co=this;
	this.Css=ele.className;
	if(!this.Css)
	{	htmlele.className="jctree";
		this.Css="jctree";
	}
	this.Format="free";
	this.ListData=null;
	this.CurrentCell=null;
	this.GridMap=null;
	this.Init();
}

JcSheet.prototype.Init=function()
{	var ele=this.HtmlEle;
	if(ele.getAttribute("Format"))
		this.Format=ele.getAttribute("Format").toLowerCase();
	if(ele.getAttribute("ListData"))
		this.ListData = GetDsNode(ele.getAttribute("ListData"));

	var frm = document.createElement("<form id='Form' jctype='jcform'>");
	this.HtmlEle.appendChild(frm);
	var body=document.createElement("<span id='body'>");
	frm.appendChild(body);
	body.style.cssText=this.ListData.GetAttr("Style");
	body.style.textAlign="left";
	body.style.width=this.ListData.GetAttr("Width");
	body.style.height=this.ListData.GetAttr("Height");
	body.style.position="relative";
	if(this.Format=="grid")
		this.RenderGrid();	
	else
		this.RenderFree();
}
JcSheet.prototype.RenderFree=function()
{
	var body=this.HtmlEle.all("body");
	for(var i=0;i<this.ListData.GetItemCount();i++)
	{
		var item=this.ListData.GetItem(i);
		var ele=null;
		var cls = item.GetAttr("Class").toLowerCase();
		if(cls.indexOf("data")>=0)
			ele=document.createElement("span");
		else if(cls.indexOf("show")>=0)
			ele=document.createElement("div");
		ele.style.cssText=item.GetAttr("Style");
		ele.style.left=item.GetAttr("Left");
		ele.style.top=item.GetAttr("Top");
		ele.style.width=item.GetAttr("Width");
		ele.style.height=item.GetAttr("Height");
		ele.style.position="absolute";
		body.appendChild(ele);
		if(cls.indexOf("data")>=0)
			this.SetDataElement(ele,item);
		else if(cls.indexOf("show")>=0)
			this.SetShowElement(ele,item);
	}
	InitDocument();
}
JcSheet.prototype.SetDataElement=function(ele,item,hideborder)
{	
	if(hideborder)
		hideborder=" HideBorder='true' ";
	else
		hideborder="";
	var fldtype = item.GetAttr("Class").toLowerCase().split(".")[1];
	var field=null;
	var tagHtml="";
	switch(fldtype)
	{
		case "normal":
			tagHtml="<input type='text' jctype='jctext' class='jctext'";
			break;
		case "multiline":
			tagHtml="<textarea jctype='jctextarea' class='jctextarea'";
			break;
		case "personsingle":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span jctype='jcpopup' ReturnMode='DataList' PopType='Url' PopStyle='width=350,height=398,scrollbars=no,resizable=no' PopUrl='/orgauth/ChooseUser.aspx'" +
			" ReturnParam='" + fieldKey + ":UserName;Correlative_" + fieldKey + ":Id;' PopParam='UserName:" + fieldKey + ";Id:Correlative_" + fieldKey + ";'";
			break;
		case "personmulti":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span jctype='jcpopup' ReturnMode='DataList' PopType='Url' PopStyle='width=650,height=480,scrollbars=no,resizable=no' PopUrl='/orgauth/NewMultiChooseUser.aspx'" +
			" ReturnParam='" + fieldKey + ":Name;Correlative_" + fieldKey + ":Id;' PopParam='Name:" + fieldKey + ";Id:Correlative_" + fieldKey + ";'";
			break;
		case "deptsingle":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span jctype='jcpopup' ReturnMode='DataList' PopType='Url' PopStyle='width=250,height=460,scrollbars=no,resizable=no' PopUrl='/orgauth/ChoosePropertyTree.aspx?TypeId=PTE00001&amp;Class=System'" +
			" ReturnParam='" + fieldKey + ":Name;Correlative_" + fieldKey + ":Id;' PopParam='Name:" + fieldKey + ";Id:Correlative_" + fieldKey + ";'";
			break;
		case "deptmulti":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span jctype='jcpopup' ReturnMode='DataList' PopType='Url' PopStyle='width=250,height=460,scrollbars=no,resizable=no' PopUrl='/orgauth/MultiChoosePropTree.aspx?TypeId=PTE00001&amp;Class=System'" +
			" ReturnParam='" + fieldKey + ":Name;Correlative_" + fieldKey + ":Id;' PopParam='Name:" + fieldKey + ";Id:Correlative_" + fieldKey + ";'";
			break;
		case "date":
			tagHtml="<span class='jcdropdown' jctype='jcdropdown' DataType='Normal' DropType='Calendar'";
			break;
		case "enum":
			var enumName = item.GetAttr("EnumKey"); 
			while(enumName.indexOf(".")>=0)
			{
				enumName=enumName.replace(".","_");
			}
			tagHtml="<select jctype='jcselect' OptionList='Rds.Enum." + enumName + "'";
			break;
		case "filesingle":
			tagHtml="<span jctype='jcfile' filemode='single'";
			break;
		case "filemulti":
			tagHtml="<span jctype='jcfile' filemode='multi'";
			break;
		case "sign":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span id='" + fieldKey + "' jctype='jcsign' class='jcsign' mode='single' hasadvice='false' style='height:100%;width:100%;overflow:auto;'";
			break;
		case "advicesign":
			var fieldKey = item.GetAttr("FieldKey");
			var relHtml="<input class='jctext' id='Correlative_" + fieldKey + "' type='hidden' jctype='jctext'>";
			ele.appendChild(document.createElement(relHtml));
			tagHtml="<span id='" + fieldKey + "' jctype='jcsign' class='jcsign' mode='multi' hasadvice='true' style='height:100%;width:100%;overflow:auto;'";
			break;
	}
	/*
	if(ToBool(item.GetAttr("ReadOnly")))
		tagHtml += " ReadOnly ";
	if(ToBool(item.GetAttr("NoSubmit")))
		tagHtml += " NoSubmit ";
	if(ToBool(item.GetAttr("NotAllowEmpty")))
		tagHtml += " NotAllowEmpty ";
	if(item.GetAttr("ValidateType"))
		tagHtml += " ValType='" + item.GetAttr("ValidateType") + "' ";
	if(item.GetAttr("ValidateString"))
		tagHtml += " ValString='" + item.GetAttr("ValidateString") + "' ";
	*/
	tagHtml += hideborder + "id='" + item.GetAttr("FieldKey") + "' style='width:100%;height:100%;'>";
	field = document.createElement(tagHtml);


	ele.appendChild(field);
}


JcSheet.prototype.SetShowElement=function(ele,item)
{	
	var vtype = item.GetAttr("Class").toLowerCase().split(".")[1];
	if(vtype=="text")
		ele.innerHTML=unescape(item.GetAttr("Text"));
	else if(vtype=="linktext")
		ele.innerHTML="<A HREF='"+item.GetAttr("V1")+"'>"+unescape(item.GetAttr("Text"))+"</A>";
}


JcSheet.prototype.Destroy=function()
{
	this.HtmlEle.removeChild(this.HtmlEle.childNodes[0]);
}

JcSheet.prototype.RenderGrid=function()
{	
	var body=this.HtmlEle.all("body");
	this.ColWidths=this.ListData.GetAttr("ColWidths").split(",");
	this.RowHeights=this.ListData.GetAttr("RowHeights").split(",");
	var colnum=this.ColWidths.length;
	var tblhtml="<TABLE id='table' BORDERCOLOR='white' BORDER=0 CELLSPACING=0 CELLPADING=1 STYLE='TABLE-LAYOUT:fixed;FONT-SIZE:12px;BORDER-COLLAPSE:collapse'><COLGROUP id=colgrp>";
	var trhtml="<TR>";
	for(var i=0;i<colnum;i++)
	{	tblhtml+="<COL STYLE='WIDTH:"+this.ColWidths[i]+"'>";
		trhtml+="<TD></TD>";
	}	
	trhtml+="</TR>";
	tblhtml+="</COLGROUP><TBODY id='tbody'>";
	var rownum=this.RowHeights.length;
	for(var i=0;i<rownum;i++)
		tblhtml+=trhtml;
	tblhtml+="</TBODY></TABLE>";
	body.innerHTML=tblhtml;
	var tbody=body.all("tbody");
	for(var i=0;i<rownum;i++)
	{	var tr=tbody.childNodes[i];
		tr.style.height=this.RowHeights[i];
	}
	this.GridMap=new JsGridMap(rownum,colnum);
	this.RenderGridData();
}
JcSheet.prototype.Merge=function(rowstart,rowend,colstart,colend)
{
	var tbody=this.HtmlEle.all("tbody");
	var pos=this.GridMap.CellIndex(rowstart,colstart);
	var cell=tbody.rows(pos[0]).cells(pos[1]);
	for(var j=rowend;j>=rowstart;j--)
	{	for(var i=colend;i>=colstart;i--)
		{	var pos=this.GridMap.CellIndex(j,i);
			if(this.GridMap.Datas[j][i]==j+","+i)
			if(pos && tbody.rows(pos[0]).cells(pos[1])!=cell)
				tbody.rows(pos[0]).deleteCell(pos[1]);
		}
	}
	cell.rowSpan=rowend-rowstart+1;
	cell.colSpan=colend-colstart+1;
	this.GridMap.Merge(rowstart,rowend,colstart,colend);
}
JcSheet.prototype.RenderGridData=function()
{	var count = this.ListData.GetItemCount();
	var tbody=this.HtmlEle.all("tbody");
	for(var i=0;i<count;i++)
	{	var item = this.ListData.GetItem(i);
		var col=parseInt(item.GetAttr("Left"));
		var row=parseInt(item.GetAttr("Top"));
		var w=parseInt(item.GetAttr("Width"));
		var h=parseInt(item.GetAttr("Height"));
		if(w>1||h>1)
			this.Merge(row,row+h-1,col,col+w-1);
		var pos=this.GridMap.CellIndex(row,col);
		var cell = tbody.rows(pos[0]).cells(pos[1]);
		cell.style.cssText = item.GetAttr("Style");
		cell.style.verticalAlign="top";
		var cls = item.GetAttr("Class").toLowerCase();
		var fldtype=cls.split(".")[1];
		if(cls.indexOf("show")>=0)
			this.SetShowElement(cell,item);
		else if(cls.indexOf("data")>=0)
		{	
			//this.SetDataElement(cell,item,true);
			this.SetDataElement(cell,item,false);
		}
	}
	InitDocument();
}

JcSheet.prototype.Validate=function()
{
	var frm = this.HtmlEle.all("Form");
	return frm.Validate();
}

JcSheet.prototype.GetDataForm=function(name)
{	var frm = this.HtmlEle.all("Form");
	return frm.Co.GetDataForm(name);
}

JcSheet.prototype.SetDataForm=function(dataform)
{	var frm = this.HtmlEle.all("Form");
	return frm.Co.SetDataForm(dataform);
}

//
//--------------------------------JcSheet对象定义结束---------------------------------------------------
//
//
//--------------------------------JcButton对象定义开始---------------------------------------------------
//
function JcButton(htmlele)
{	this.Type="jcbutton";
	if(!htmlele)htmlele=document.createElement("<button class='jcbutton' jctype='jcbutton'>");
	this.HtmlEle = htmlele;
	this.HtmlEle.Co=this;
	this.Css = htmlele.className;
	this.Image=null;
	if(!this.Css)
	{	htmlele.className="jcbutton";
		this.Css="jcbutton";
	}
	this.Init();
}
JcButton.prototype.Init=function()
{	this.IconType = GetAttr(this.HtmlEle,"IconType","Normal");
	this.IconUrl= GetAttr(this.HtmlEle,"IconUrl",null);
	var img=document.createElement("<Img class='"+this.SubCss("Image")+"'>");
	
	//这里让jcbutton支持回车键
	
	
	if(this.IconUrl)
		 img.src=this.IconUrl;
	else
	switch(this.IconType.toLowerCase())
	{	case "add":
			img.src="/share/image/jsctrl/Button_add.gif";
			break;
		case "cancel":
			img.src="/share/image/jsctrl/Button_cancel.gif";
			break;
		case "delete":
			img.src="/share/image/jsctrl/Button_delete.gif";
			break;
		case "edit":
			img.src="/share/image/jsctrl/Button_edit.gif";
			break;
		case "ok":
			img.src="/share/image/jsctrl/Button_ok.gif";
			break;
		case "reset":
			img.src="/share/image/jsctrl/Button_reset.gif";
			break;
		case "save":
			img.src="/share/image/jsctrl/Button_save.gif";
			break;				
		case "search":
			img.src="/share/image/jsctrl/Button_search.gif";
			break;	
		case "see":
			img.src="/share/image/jsctrl/Button_see.gif";
			break;	
		case "return":
			img.src="/share/image/jsctrl/Button_return.gif";
			break;	
		case "upload":
			img.src="/share/image/jsctrl/Button_upload.gif";
			break;		
		case "open":
			img.src="/share/image/jsctrl/Button_open.gif";
			break;			
		case "prop":
			img.src="/share/image/jsctrl/Button_edit.gif";
			break;	
		case "repeal":
			img.src="/share/image/jsctrl/Button_repeal.gif";
			break;			
		case "print":
			img.src="/share/image/jsctrl/Button_print.gif";
			break;
		case "product":
			img.src="/share/image/jsctrl/ACAD.gif";
			break;
		case "up":
			img.src="/share/image/jsctrl/btnudup.gif";
			break;
		case "down":
			img.src="/share/image/jsctrl/btnuddown.gif";
			break;
		case "excel":
		    img.src="/share/image/jsctrl/Button_ToExcel.gif";	
		    break;
		case "word":
		    img.src="/share/image/jsctrl/Button_ToWord.gif";
		    break;
		case "copy":
			img.src="/share/image/jsctrl/Button_ToCopy.gif";
		    break;
		case "send":
		    img.src="/share/image/jsctrl/Button_ToSend.gif";	
		    break;	
		default:
			img =null;
	}
	this.Image=img;
	if(img)
	{	
		//var txt=this.HtmlEle.innerText;
		//this.HtmlEle.style.width=(parseInt(txt.bytelen()/4))*36+24;
		//this.HtmlEle.innerHTML="&nbsp;"+this.HtmlEle.innerHTML;
		this.HtmlEle.insertBefore(img,this.HtmlEle.firstChild);
		
	}
	//加上分割线jnp 09-2-23
	//不要分割线请加控件属性IsShowSeperate = false；
	if(ToBool(GetAttr(this.HtmlEle,"IsShowSeperate",true)))
	{
		img = document.createElement("<Img class='"+this.SubCss("Image")+"'>");
		img.src = "/share/image/page/h_break.gif";
		this.HtmlEle.innerHTML=this.HtmlEle.innerHTML +"&nbsp";
		this.HtmlEle.appendChild(img);
	}
}
JcButton.prototype.SetDisabled=function(state)
{	if(this.Image )
	{	if(ToBool(state))	
			this.Image.className=this.SubCss("ImageDis");
		else
			this.Image.className=this.SubCss("Image");
	}	
	this.HtmlEle.disabled=ToBool(state);
}

JcButton.prototype.SubCss=function(name)
{	return this.Css +"_"+ name;
}
JcButton.prototype.Destroy=function()
{
	
}
//
//--------------------------------JcButton对象定义结束---------------------------------------------------
//

//
//--------------------------------JcTab对象定义开始---------------------------------------------------
//

function JcTab(ele)
{
	this.Css=null;
	this.Type=null;
	this.ListData=null;
	this.LinkTarget=null;
	this.TabType=null;
	this.SelectLeftImg=null;
	this.SelectCommon=null;
	this.SelectRightImg=null;
	this.UnselectLeftImg=null;
	this.UnselectCommon=null;
	this.UnselectRightImg=null;
	this.SelectedIndex=null;
	//是否第一次加载自动打开url  jnpadd
	this.AutoLink="true";
	this.Init(ele);
	this.Event=null;
}

JcTab.prototype.Init=function(ele)
{
	if(!ele)
	{
		document.createElement("<span style='JcTab' jctype='jctab'>");
	}
	this.HtmlEle=ele;
	this.HtmlEle.Co=this;
	this.HtmlEle.className="JcTab";
	this.Type="JcTab";
	this.Css="JcTab";
	if(this.HtmlEle.getAttribute("ListData"))
		this.ListData=GetDsNode(this.HtmlEle.getAttribute("ListData"));	
	if(this.HtmlEle.getAttribute("LinkTarget"))
		this.LinkTarget=document.all(this.HtmlEle.getAttribute("LinkTarget"));
	if(this.HtmlEle.getAttribute("TabType"))
		this.TabType=this.HtmlEle.getAttribute("TabType");	
	if(this.HtmlEle.getAttribute("AutoLink"))
		this.AutoLink=this.HtmlEle.getAttribute("AutoLink");	
	if(!this.TabType)
		this.TabType="Common";
	switch(this.TabType.toLowerCase())
	{
		case "XP":
		break;
		default:
			this.SelectLeftImg= "<span id='leftimg' style='width:11;' src='/share/image/jsctrl/JsTab/SelectLeft.gif'></span>";
			this.SelectRightImg="<span id='rightimg' style='width:11;' src='/share/image/jsctrl/JsTab/SelectRight.gif'></span>";
			this.UnselectLeftImg="<span id='leftimg' style='width:11;' src='/share/image/jsctrl/JsTab/UnselectLeft.gif'></span>";
			this.UnselectRightImg="<span id='rightimg' style='width:11;' src='/share/image/jsctrl/JsTab/UnselectRight.gif'></span>";
	}
	this.SelectCommon=this.SubCss(this.TabType)+"Select";
	this.UnselectCommon=this.SubCss(this.TabType)+"Unselect";
	if(this.HtmlEle.getAttribute("SelectedIndex"))
		this.SelectedIndex=parseInt(this.HtmlEle.getAttribute("SelectedIndex"));
	else
		this.SelectedIndex=0;									
		
	this.RenderObject();
}

JcTab.prototype.Fire=function(eventname)
{	var evt = this.HtmlEle.getAttribute(eventname);
	if(evt)
	{
		try{eval(evt);}catch(e){};
	}
}
JcTab.prototype.Reset = function()
{
	var jcEle = this.HtmlEle;
	var divEles=jcEle.childNodes;
	for(var i=1;i<divEles.length;i++)
	{
		divEles[i].style.zIndex=1000;
		divEles[i].all("DivLeft").innerHTML=this.UnselectLeftImg;
		divEles[i].all("DivIcon").className=this.UnselectCommon;
		divEles[i].all("DivCenter").className=this.UnselectCommon;
		divEles[i].all("DivRight").innerHTML=this.UnselectRightImg;
	}	
	this._UpdateImage();
}

JcTab.SelectTab=function()
{
	var ele=event.srcElement;
	var jcEle=GetParentJcElement(ele);
	var divEles=jcEle.childNodes;
	for(var i=1;i<divEles.length;i++)
	{
		divEles[i].style.zIndex=1000;
		divEles[i].all("DivLeft").innerHTML=jcEle.Co.UnselectLeftImg;
		divEles[i].all("DivIcon").className=jcEle.Co.UnselectCommon;
		divEles[i].all("DivCenter").className=jcEle.Co.UnselectCommon;
		divEles[i].all("DivRight").innerHTML= jcEle.Co.UnselectRightImg;
	}
	var parentDivEle=ele;
	while(parentDivEle&&parentDivEle.tagName.toLowerCase()!="div")
	{
		parentDivEle=parentDivEle.parentNode;
	}	
	parentDivEle.style.zIndex=1005;		
	parentDivEle.all("DivLeft").innerHTML=jcEle.Co.SelectLeftImg ;
	parentDivEle.all("DivIcon").className=jcEle.Co.SelectCommon;
	parentDivEle.all("DivCenter").className=jcEle.Co.SelectCommon;
	parentDivEle.all("DivRight").innerHTML= jcEle.Co.SelectRightImg ;
	//设置索引 jnpadd
	jcEle.Co.SelectedIndex = parentDivEle.getAttribute("Index");
	jcEle.Co.Event = new Object;
	//Add By Devil for add TabIndex and ActionKey and LinkUrl parameter.2008-01-11
	var index = GetNodeIndex(parentDivEle);
	jcEle.Co.Event.TabIndex = index - 1;
	jcEle.Co.Event.ActionKey = jcEle.Co.ListData.GetItem(index - 1).GetAttr("ActionKey");
	jcEle.Co.Event.LinkUrl = parentDivEle.getAttribute("LinkUrl");
	//End
	//jcEle.Co.Event.ActionKey="";
	jcEle.Co.Event.returnValue=true;
	jcEle.Co.Fire("OnTabClick");
	if(jcEle.Co.Event.returnValue)
		jcEle.Co.LinkTarget.src=parentDivEle.getAttribute("LinkUrl");
	jcEle.Co._UpdateImage();
}
JcTab.prototype._UpdateImage=function()
{
	var leftimgs= ToArray(this.HtmlEle.all("leftimg"));
	for(var i=0;i<leftimgs.length;i++)
	{
		if(!leftimgs[i].firstChild)
			leftimgs[i].innerHTML="<img src='"+leftimgs[i].src+"'>";
	}
	var rightimgs= ToArray(this.HtmlEle.all("rightimg"));
	for(var i=0;i<rightimgs.length;i++)
	{
		if(!rightimgs[i].firstChild)
			rightimgs[i].innerHTML="<img src='"+rightimgs[i].src+"'>";
	}
}
JcTab.prototype.RenderObject=function()
{
	this.HtmlEle.innerHTML="<DIV class='JcTab_Line' style='z-index:1002;	POSITION:absolute;left:" + this.HtmlEle.style.left + ";'></DIV>";
	
	var dataList=this.ListData;
	var tabs=dataList.GetItems();
	var tabTemplate=document.createElement("<DIV style='Z-INDEX:1000;POSITION:absolute;top:" + this.HtmlEle.style.top + ";'>");
	tabTemplate.innerHTML="<table height=100% cellspacing=0 cellpadding=0 border=0>"
	+ "							<tr>"
	+ "								<td id=DivLeft>" + this.UnselectLeftImg + "</td>"
	+ "								<td onclick='JcTab.SelectTab();' id=DivIcon class=" + this.UnselectCommon + "></td>"
	+ "								<td onclick='JcTab.SelectTab();' id=DivCenter align=center valign=middle class=" + this.UnselectCommon + "></td>"
	+ "								<td id=DivRight>" + this.UnselectRightImg + "</td>"
	+ "							</tr>"
	+ "						</table>";
	
	var preTabEle=null;
	for(var i=0;i<tabs.length;i++)
	{
		var tabEle=tabTemplate.cloneNode(true);
		
		var linkUrl=tabs[i].GetAttr("LinkUrl");
		if(linkUrl&&linkUrl!="")
		{
			tabEle.setAttribute("LinkUrl",linkUrl);
			//索引
			tabEle.setAttribute("Index",i);
		}
		else
		{
			alert("第" + (i+1) + "项的LinkUrl未设置!");
			return false;
		}
		
		var icon=tabs[i].GetAttr("Icon");
		if(icon&&icon!="")
		{
			tabEle.all("DivIcon").innerHTML="&nbsp;<img src='" + icon + "'></img>";
		}
		
		if(this.SelectedIndex==i)
		{
			tabEle.all("DivLeft").innerHTML= this.SelectLeftImg ;
			tabEle.all("DivIcon").className=this.SelectCommon;
			tabEle.all("DivCenter").className=this.SelectCommon;
			tabEle.all("DivRight").innerHTML= this.SelectRightImg ;
			if(this.AutoLink.toLowerCase()=="true")
			{
			    this.LinkTarget.src=tabEle.getAttribute("LinkUrl");
			}
			tabEle.style.zIndex=1005;
		}
		else
		{
			tabEle.style.zIndex=1000;
		}
		var title=tabs[i].GetAttr("Title");
		//var tabwidth = title.bytelen()*7 + 24;   width=100% 
		//tabEle.style.width = tabwidth;
		//绘制元素可能导致定位错误，可以采用绝对定位的方式解决
		//背景切换可能导致出错
		tabEle.all("DivCenter").innerHTML="<nobr>&nbsp;" + title + "&nbsp;</nobr>";
		this.HtmlEle.appendChild(tabEle);
		if(i==0)
		{
			tabEle.style.left=this.HtmlEle.style.left;
			this.HtmlEle.childNodes(0).style.top=20;//tabEle.offsetTop+tabEle.offsetHeight-1;
		}
		else
		{
			tabEle.style.left=preTabEle.offsetLeft+preTabEle.offsetWidth-14;
		}
		preTabEle=tabEle;
	}	
	this._UpdateImage();
}
JcTab.prototype.Destroy=function()
{
	
}
JcTab.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}
//
//--------------------------------JcTab对象定义结束---------------------------------------------------
//

//
//--------------------------------JcCoolBar对象定义开始---------------------------------------------------
//

function JcCoolBar(htmlele)
{
	this.Type="jccoolbar";
	this.Css=null;
	this.Column=null;
	this.PopupMethod=null;
	this.ListData=null;
	this.DataStore=null;
	this.LinkTarget=null;
	this.LinkStyle=null;
	this.Event=null;
	this.SelectedItem = null;
	this.Menus=new Array();
	this.IsPopup=false;
	this.Init(htmlele);
}
JcCoolBar.prototype.Init=function(htmlele)
{
	if(!htmlele)htmlele=document.createElement("<span class='jccoolbar' jctype='jccoolbar'>");
	this.HtmlEle = htmlele;
	this.HtmlEle.Co=this;
	this.Css = htmlele.className;
	if(!this.Css)
	{	htmlele.className="jccoolbar";
		this.Css="jccoolbar";
	}
	var md=GetAttr(this.HtmlEle,"ListData",null);
	if(md)
	{	this.ListData=GetDsNode(md);	
		this.DataStore = GetDs(md.split(".")[0]);
	}
	this.LinkTarget=GetAttr(this.HtmlEle,"LinkTarget",null);
	this.LinkStyle=GetAttr(this.HtmlEle,"LinkStyle",null);
	this.Column=GetAttr(this.HtmlEle,"Column",100);
	this.ButtonStyle=GetAttr(this.HtmlEle,"ButtonStyle","Small").toLowerCase();
	this.InitMenuBar();
}
JcCoolBar.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}			
JcCoolBar.Offset=function(dir)
{
	var jcele=GetParentJcElement(event.srcElement);	
	var cspan = jcele.all("_cspan");
	//alert(cspan.scrollWidth);
	var tb = cspan.firstChild;
	var left=tb.offsetLeft;
	var width=cspan.offsetWidth;
	var dx=60;
	if(dir==1)
	{
		if(left + tb.offsetWidth-dx>width)
			cspan.firstChild.style.left=left-dx;
		else
			cspan.firstChild.style.left=width-tb.offsetWidth;
	}
	if(dir==0)
	{
		if(left+dx<=0)
			cspan.firstChild.style.left=left+dx;
		else
			cspan.firstChild.style.left=0;
	}
}

JcCoolBar.prototype.InitMenuBar=function()
{
	var mblst=this.ListData;
	var width = this.HtmlEle.offsetWidth;
	var wstr = (width==0)?"":"style='width:"+(width-40)+";overflow-x:hidden;vertical-align:top;'";
	var html="<nobr><span unselectable=on id=_left style='cursor:hand;display:none;' onclick='JcCoolBar.Offset(0)'>"
		+"<img style='width:16;height:50;' src='/portal/image/arrow_left.gif'></span><span id=_cspan "+wstr+"><table id='TableCollBarContent' style='position:relative;' cellpadding='0' cellspacing='0' border=0 class='"+this.SubCss("Body")+"' >";
	//加入了ID:"TableCollBarContent"为了在TitleBar判断是否内容过长，当内容过长的时候显示左右按钮不过长的时候不显示左右按钮   2008.02.29 by yang
	var num=0,count=this.ListData.GetItemCount();
	while(num<count)
	{
		html+="<tr>";
		for(var i=0;i<this.Column;i++)
		{
			var item = this.ListData.GetItem(num);//"+GetMenuItemHtml()+"
			html+="<td align=center><div type='baritem'  style='cursor:hand;' class='"+this.SubCss("Item")+"' id='"+item.GetAttr("Id")+"'  onmouseenter='JcCoolBar.MouseEnter(event.srcElement,this)' onmouseleave=JcCoolBar.MouseLeave(event.srcElement,this) onclick=JcCoolBar.Click(event.srcElement,this)>"+this.RenderBarItem(item)+"</div></td>";
			num++;
			if(num>=count)break;
		}
		html+="</tr>";
	}
	html+="</table></span><span unselectable=on id=_right style='cursor:hand;display:none;' onclick='JcCoolBar.Offset(1)'>"
		+"<img style='width:16;height:50;' src='/portal/image/arrow_right.gif'></span></nobr>";
	this.HtmlEle.innerHTML = html;
	this.CreateMenuArray(this.ListData,window);
	//alert(this.HtmlEle.outerHTML);
	var cspan=this.HtmlEle.all("_cspan");
	if(cspan.firstChild.offsetWidth>cspan.offsetWidth)//如果设定了宽度
	{	this.HtmlEle.all("_right").style.display="";
		this.HtmlEle.all("_left").style.display="";
	}
}

JcCoolBar.prototype.RenderBarItem=function(item)
{
	var html="<table cellpadding='0' cellspacing='0' border=0 >";
	var icon=item.GetAttr("Icon");
	var title=item.GetAttr("Title");
	var type=item.GetAttr("Type");
	var onlyicon=(item.GetAttr("OnlyIcon")+"").toLowerCase();
	var sublist=this.DataStore.Lists(item.GetAttr("Id"));
	if(this.ButtonStyle=="small")
	{	html+="<tr height='24'>";
		if( icon && icon!="")
		{	if(onlyicon=="true" && title & title!="")
				var tl=title;
			else 
				var tl="";
			html+="<td  id='Icon' width=24 title='"+tl+"' class='"+this.SubCss("ItemIcon")+"' ><img style='width:16;height:16;' src='"+item.GetAttr("Icon")+"'></td>";
		}
		if(title && title!="" && onlyicon!="true")
			html+="<td  id='Title'  class='"+this.SubCss("ItemTitle")+"' ><nobr>"+title+"</nobr></td>";
		if(item.GetAttr("Type")=="SubMenu" && sublist && sublist.GetItemCount()>0)
			html+="<td id='DropBtn' class='"+this.SubCss("ItemDrop")+"' ><img src='/share/image/jsctrl/JsCoolBar/dropbtn.gif'></td>";
		html+="</tr></table>";
	}else
	{
		html+="<tr>";
		if( icon && icon!="")
		{	if(onlyicon=="true" && title & title!="")
				var tl=title;
			else 
				var tl="";
			html+="<td  id='Icon'  title='"+tl+"' class='"+this.SubCss("ItemIcon")+"' ><img style='width:32;height:32;' src='"+item.GetAttr("Icon")+"'></td>";
		}
		if(item.GetAttr("Type")=="SubMenu" && sublist && sublist.GetItemCount()>0)
			html+="<td id='DropBtn' rowspan=2  class='"+this.SubCss("ItemDrop")+"' ><img src='/share/image/jsctrl/JsCoolBar/dropbtn.gif'></td>";
		html+="</tr><tr>";
		if(title && title!="" && onlyicon!="true")
			html+="<td  id='Title'  class='"+this.SubCss("ItemTitle")+"' ><nobr>&nbsp;"+title+"&nbsp;</nobr></td>";
		html+="</tr></table>";
		
	}
	
	return html;
}
JcCoolBar.prototype.CreateMenuArray=function(mlst,pwin)
{
	var count=mlst.GetItemCount();
	for(var i=0;i<count;i++)
	{	var item = mlst.GetItem(i);

		if(item.GetAttr("Type")=="SubMenu")
		{	
			var sublist = this.DataStore.Lists(item.GetAttr("Id"));
			if(sublist)
				JcMenu.CreateMenuArray(this,this.Menus,this.DataStore,sublist,window);
		}
	}
}
JcCoolBar.AutoHide=function(jcobj)
{
	var ele=null;
	if(jcobj.CurSubMenu && !jcobj.CurSubMenu.isOpen)
	{	
		JcCoolBar.SetItemStyle(jcobj,null,"item");
		jcobj.CurSubMenu = null;
		jcobj.IsPopup = false;
	}
	else
		jcobj.HideCaller.execTimeout(false);
	
}
JcCoolBar.prototype.Fire=function(eventname)
{	var e = this.HtmlEle.getAttribute(eventname);
	if(e)
		eval(e);
}
JcCoolBar.SetJoin=function(jcobj,menu,ele)
{
	if(!menu.document.all("JoinLine"))
	{	ln = menu.document.createElement("<span id='JoinLine' style='position:absolute;overflow:hidden;left:1;top:0;width:"+(ele.offsetWidth-2)+";"+JcMenu.Style_JoinLine+"'>");
		menu.document.body.appendChild(ln);
	}
}
JcCoolBar.MouseEnter=function(src,ele)
{
	var jcele=GetParentJcElement(ele);	
	var jcobj =jcele.Co;
	if(!jcobj)return;
	var menu = jcobj.Menus[ele.id];
	JcCoolBar.SetItemStyle(jcobj,ele,"itemmouseover");
	if(jcobj.IsPopup)
	{
		 if(jcobj.CurSubMenu)
		{	
			JcCoolBar.SetItemStyle(jcobj,null,"item");//滞后设置样式
			jcobj.CurSubMenu.hide();
			jcobj.CurSubMenu=null;
			jcobj.HideCaller.clearTimeout();
		}	
		if(menu&&menu.document.ListData.GetItemCount()>0)
		{	JcMenu.ShowMenu(menu,ele);
			JcCoolBar.SetJoin(jcobj,menu,ele);
			jcobj.CurSubMenu=menu;
			JcCoolBar.SetItemStyle(jcobj,ele,"itemclick");
			if(!jcobj.HideCaller)
			{	jcobj.HideCaller=new JcCaller(JcCoolBar.AutoHide,200,jcobj);
			}else
				jcobj.HideCaller.clearTimeout();
			jcobj.HideCaller.execTimeout(false);
			
		}
	}
}
JcCoolBar.SetItemStyle=function(jcobj,ele,type)
{
	if(!ele)
	{	if(jcobj.CurSubMenu)
			ele = jcobj.HtmlEle.all(jcobj.CurSubMenu.document.ListData.GetName());
		else
			return;
	}	
	switch(type)
	{
		case "item":
			ele.className = jcobj.SubCss("Item");
			if(ele.all("DropBtn"))
				ele.all("DropBtn").className=jcobj.SubCss("ItemDrop")
			break;
		case "itemmouseover":
			ele.className = jcobj.SubCss("ItemMouseOver");
			if(ele.all("DropBtn"))
				ele.all("DropBtn").className=jcobj.SubCss("ItemDropMouseOver")
			break;
		case "itemclick":
			ele.className = jcobj.SubCss("ItemClick");
			if(ele.all("DropBtn"))
				ele.all("DropBtn").className=jcobj.SubCss("ItemDropClick")
			break;
	}
}
JcCoolBar.MouseLeave=function(src,ele)
{
	var jcele=GetParentJcElement(ele);
	var jcobj =jcele.Co;
	try
	{
		if(jcobj.CurSubMenu && jcobj.CurSubMenu.isOpen)
			return;		//采用滞后设置样式
		if(jcobj.SelectedItem != ele)
			JcCoolBar.SetItemStyle(jcobj,ele,"item"); //本处不使用try的话会产生BUG
	}
	catch(e){return;}
}
JcCoolBar.Click=function(src,ele)
{
	var jcele=GetParentJcElement(ele);	
	var jcobj =jcele.Co;
	if(!jcobj)return;
	var menu = jcobj.Menus[ele.id];
	var item = jcobj.ListData.GetItem("Id",ele.id);
	var linkurl = item.GetAttr("LinkUrl");
	var dropbtn = ele.all("DropBtn");
	//下拉条件：存在Menu并且为设置LinkUrl或点击dropbtn
	if(menu && (!linkurl||linkurl==""||(dropbtn && dropbtn.contains(src))))
	{		
		if(!jcobj.HideCaller)
		{	jcobj.HideCaller=new JcCaller(JcCoolBar.AutoHide,200,jcobj);
		}else
			jcobj.HideCaller.clearTimeout();
		if(jcobj.IsPopup)
		{	menu.hide();
			jcobj.IsPopup=false;
			JcCoolBar.SetItemStyle(jcobj,ele,"itemmouseover");
		}
		else
		{	JcMenu.ShowMenu(menu,ele);
			JcCoolBar.SetJoin(jcobj,menu,ele);
			jcobj.IsPopup=true;
			jcobj.CurSubMenu=menu;
			JcCoolBar.SetItemStyle(jcobj,ele,"itemclick");
			jcobj.HideCaller.execTimeout(false);
		}
	}else
	{	
		JcMenu.ItemClick(jcobj,item);
		if(jcobj.SelectedItem != ele)
		{
			if(jcobj.SelectedItem)
				JcCoolBar.SetItemStyle(jcobj,jcobj.SelectedItem,"item"); 
			jcobj.SelectedItem = ele;
		}
	}
}

var JcMenu={};
JcMenu.Style_Body="font-size:10pt;border:solid 1 black;padding-left:2px;padding-right:2px;";
JcMenu.Style_Item="height:22;width:100%;padding-top:3px;border:solid 1 white;background-color:white;";
JcMenu.Style_ItemMouseOver="height:22;padding-top:3px;border:solid 1 gray;background-color:silver;";
JcMenu.Style_ItemIcon="";
JcMenu.Style_ItemTitle="font-size:10pt;padding-left:2px;";
JcMenu.Style_ItemSubMenu="";	
JcMenu.Style_JoinLine="height:1px;background-color:silver;";


JcMenu.ItemClick=function(jcobj,item)
{
	jcobj.Event = new Object;
	jcobj.Event.DataItem=item;
	jcobj.Event.returnValue=true;
	jcobj.Fire("OnButtonClick");
	if(jcobj.Event.returnValue)
	{	var linkurl = item.GetAttr("LinkUrl");
		if(linkurl&&linkurl!="")
		{	
			var linkstyle=item.GetAttr("LinkStyle");//
			var linktarget=item.GetAttr("LinkTarget");//jcobj.LinkTarget;
			if(linkstyle==null || linkstyle=="")
				linkstyle=jcobj.LinkStyle;
			if(linktarget==null || linktarget=="")
				linktarget=jcobj.LinkTarget;
			var style=CenterWin(linkstyle);	
			ParamLinkTo(linkurl,item.XmlEle,linktarget,style);	
		}
	}
}

JcMenu.CreateMenuArray=function(masobj,mnuary,ds,mlst,pwin)
{
	
	mnuary[mlst.GetName()]=JcMenu.CreateMenu(mlst,masobj,pwin,ds);
	var count=mlst.GetItemCount();
	for(var i=0;i<count;i++)
	{	var item = mlst.GetItem(i);
		if(item.GetAttr("Type")=="SubMenu")
		{	
			var sublist = ds.Lists(item.GetAttr("Id"));
			if(sublist)
				JcMenu.CreateMenuArray(masobj,mnuary,ds,sublist,mnuary[mlst.GetName()].document.parentWindow);
		}
	}
}
//MasterObject必须实现Menus接口
JcMenu.CreateMenu=function(mlst,masobj,pwin,ds)
{
	var popup = pwin.createPopup();
	popup.document.RootWindow = window;
	popup.document.MasterObject = masobj;
	popup.document.ListData=mlst;
	var count=mlst.GetItemCount();
	var html="<table cellpadding='0' cellspacing='0' align='center' border=0 style='"+JcMenu.Style_Body+"'>";
	for(var i=0;i<count;i++)
	{	html+="<tr height=24>";
		var item = mlst.GetItem(i);//"+GetMenuItemHtml()+"
		html+="<td ><div style='"+JcMenu.Style_Item+"' type='menuitem' id='"+item.GetAttr("Id")+"' onmouseenter=RootWindow.JcMenu.MouseEnter(this) onmouseleave=RootWindow.JcMenu.MouseLeave(this) onclick=RootWindow.JcMenu.Click(this) >"+JcMenu.RenderMenuItem(item,ds)+"</div></td>";
		html+="</tr>";
	}
	html+="</table>";
	popup.document.body.innerHTML = html;
	return popup;
}
JcMenu.SetItemStyle=function(ele,type)
{
	switch(type)
	{
		case "item":
			ele.style.cssText = JcMenu.Style_Item;
			break;
		case "itemmouseover":
			ele.style.cssText = JcMenu.Style_ItemMouseOver;
			break;
	}
}
JcMenu.MouseEnter=function(ele)
{
	var doc=GetDoc(ele);
	var jcobj=doc.MasterObject;
	var menu = jcobj.Menus[ele.id];
	JcMenu.SetItemStyle(ele,"itemmouseover");
	if(menu&&menu.document.ListData.GetItemCount()>0)
	{	if(JcMenu.ShowCaller)//取消已存在的延迟显示
		{	JcMenu.ShowCaller.clearTimeout();
			JcMenu.ShowCaller.remove();
		}
		doc.CurSubMenu = menu;
		if(menu == JcMenu.PreSubMenu)//取消已存在的延迟隐藏
		{	clearTimeout(JcMenu.HideHandle);
			JcMenu.HideHandle=-1;
			JcMenu.PreSubMenu=null;
		}else//设置延迟显示
		{	JcMenu.ShowCaller=new JcCaller(JcMenu.Show,200,menu,ele,true);
			JcMenu.ShowCaller.execTimeout(true);
		//ShowMenu(menu,ele,true);
		}
	}
	else
	{	
		if(doc.CurSubMenu)
		{	JcMenu.PreSubMenu = doc.CurSubMenu;
			JcMenu.HideHandle = setTimeout("JcMenu.Hide();",200);
		}
		doc.CurSubMenu=null;
	}
}
JcMenu.MouseLeave=function(ele)
{
	JcMenu.SetItemStyle(ele,"item");

}
JcMenu.Click=function(ele)
{
	var doc=GetDoc(ele);
	var jcobj=doc.MasterObject;
	var menu = jcobj.Menus[ele.id];
	var item = doc.ListData.GetItem("Id",ele.id);
	var linkurl = item.GetAttr("LinkUrl");
	//下拉条件：存在Menu并且为设置LinkUrl或点击dropbtn
	if(menu && (!linkurl||linkurl==""))
	{		
		JcMenu.Show(menu,ele,true);
	}else 
	{	
		for(var key in jcobj.Menus)
		{	jcobj.Menus[key].hide();
			jcobj.Menus[key].document.CurSubMenu=null;
		}
		JcMenu.ItemClick(jcobj,item);
		JcMenu.SetItemStyle(ele,"item");
		
	}

}
JcMenu.ShowCaller=null;
JcMenu.HideHandle=-1;
JcMenu.CurSubMenu=null;
JcMenu.PreSubMenu=null;
JcMenu.Hide=function()
{
	if(JcMenu.PreSubMenu)
	{	JcMenu.PreSubMenu.hide();
		JcMenu.PreSubMenu=null;
	}
}
JcMenu.Show=function(menu,ele,issub)
{
	JcMenu.ShowMenu(menu,ele,issub);
	JcMenu.ShowCaller=null;
}


JcMenu.ShowMenu=function(popwin,relele,issub,x,y)
{
		if(popwin.isOpen)return;
		var width=1;
		var height=1;
		popwin.show(0, 0, width, height);
		var left = relele.offsetWidth;
		var top = relele.offsetHeight;
		width = popwin.document.body.scrollWidth;
		height = popwin.document.body.scrollHeight;
		if(issub!=true)
		{	left = 0;top--;}
		else
		{	top = 0;left--;}
		popwin.hide();
	if(!x&&!y)
		popwin.show(left, top, width, height, relele);
	else
		popwin.show(x, y, width, height, relele);
}
JcMenu.RenderMenuItem=function(item,ds)
{
	var html="<table cellpadding='0' cellspacing='0' border=0 width=100%>";
	html+="<tr>";
	var icon=item.GetAttr("Icon");
	var title=item.GetAttr("Title");
	var type=item.GetAttr("Type");
	var sublist=(ds==null)?null:ds.Lists(item.GetAttr("Id"));
	var onlyicon=(item.GetAttr("OnlyIcon")+"").toLowerCase();
	if( icon && icon!="")
	{	if(onlyicon=="true" && title & title!="")
			var tl=title;
		else 
			var tl="";
		html+="<td  id='Icon' width=16 title='"+tl+"' style='"+JcMenu.Style_ItemIcon+"' ><img style='width:16;height:16;' src='"+item.GetAttr("Icon")+"'></td>";
	}
	if(title && title!="" && onlyicon!="true")
		html+="<td  id='Title' align='left'  style='"+JcMenu.Style_ItemTitle+"' ><nobr>"+title+"&nbsp;&nbsp;</nobr></td>";
	if(item.GetAttr("Type")=="SubMenu" && sublist && sublist.GetItemCount()>0)
		html+="<td id='SubMenu' width=10  style='"+JcMenu.Style_ItemSubMenu+"' ><img src='/share/image/jsctrl/submenu.gif'></td>";
	else
		html+="<td width=10 ></td>";
	html+="</tr></table>";
	return html;
}
function GetDoc(ele)
{	while(ele.nodeType!=9)
		ele = ele.parentNode;
	return ele;
}

//
//--------------------------------JcCoolBar对象定义结束---------------------------------------------------
//

//
//--------------------------------JcMenuBar对象定义开始---------------------------------------------------
//

function JcMenuBar(ele)
{
	this.Css=null;
	this.Type=null;
	this.ListData=null;
	this.MenuName = null;
	this.LinkTarget=null;
	this.SelectedItem = null;	
	this.Init(ele);
}

JcMenuBar.prototype.Init=function(ele)
{
	if(!ele)
	{
		document.createElement("<span style='JcMenuBar' jctype='JcMenuBar'>");
	}
	this.HtmlEle=ele;
	this.HtmlEle.Co=this;
	
	this.Type="JcMenuBar";
	this.Css="JcMenuBar";
	this.ListData=GetDsNode(GetAttr(this.HtmlEle,"ListData",null));	
	this.MenuName=GetAttr(this.HtmlEle,"MenuName","");	
	this.LinkTarget=GetAttr(this.HtmlEle,"LinkTarget",null);
	if(this.LinkTarget)
		this.LinkTarget=document.all(this.LinkTarget);

	this.RenderObject();
}
JcMenuBar.prototype._UpdateImage=function()
{
	var icons= ToArray(this.HtmlEle.all("_icon"));
	for(var i=0;i<icons.length;i++)
	{
		if(!icons[i].firstChild)
			icons[i].innerHTML="<img src='"+icons[i].src+"'>";
	}
	var displays= ToArray(this.HtmlEle.all("_display"));
	for(var i=0;i<displays.length;i++)
	{
		if(!displays[i].firstChild)
			displays[i].innerHTML="<img src='"+displays[i].src+"'>";
	}
}

JcMenuBar.HideMenu = function()
{
	var mtd=document.all('MenuTd');
	if(mtd.style.display=='')
	{	mtd.style.display ='none';
		parent.WorkArea.cols='8,*';
		DisTd.childNodes[0].childNodes[0].src='/share/image/outbar/OutBarDisplayBtn1.gif';
		//OutBarDisplayBtn.src='/share/image/outbar/OutBarDisplayBtn1.gif';
	}else
	{	mtd.style.display = '';
		parent.WorkArea.cols='160,*';
		DisTd.childNodes[0].childNodes[0].src='/share/image/outbar/OutBarDisplayBtn.gif';
		//OutBarDisplayBtn.src='/share/image/outbar/OutBarDisplayBtn.gif';
	}
}

JcMenuBar.HideSubMenu = function(div)
{	
	var subdiv = div.parentElement.all(div.getAttribute("SubDiv"));
	if(subdiv.style.display=="")
	{	subdiv.style.display ="none";
		div.parentElement.all("_display").childNodes[0].src="/share/image/outbar/OutBarDisplaydown.gif";
	}else
	{	subdiv.style.display ="";
		div.parentElement.all("_display").childNodes[0].src="/share/image/outbar/OutBarDisplayUp.gif";
	}
}

JcMenuBar.prototype.AddSubMenu = function(div,item)
{
	var ele = document.createElement("<div style='width:100%;overflow-x:hidden;'>");
	ele.innerHTML = "<div style='height:3; overflow:hidden;'></div> " +
					"<div id='SubMenuItemDiv' style='Cursor:hand;WIDTH:100%;font-size:10pt' style='border: 1px solid #FFFFFF; background-image: url(\"/share/image/outbar/OutBarTitleBtnBg.gif\"); background-repeat: repeat-x;height:25' onclick='JcMenuBar.HideSubMenu(this)' SubDiv='SubMenuItemSetDiv'> " +
						"<table class='DefaultTable'> " +
							"<tbody> " +
								"<tr> " +
									"<td width='99%' style='padding-left:5;padding-top:2;' align='middle'><font color='gray'>" + item.GetAttr("Title") + "</font></td> " +
									"<td width='1%'><span id='_display'  src=\"/share/image/outbar/OutBarDisplayUp.gif\"></span></td> " +
								"</tr> " +
							"</tbody> " +
						"</table> " +
					"</div> " +
					"<div style='height:3; overflow:hidden;'></div> " +
					"<div id='SubMenuItemSetDiv' align='left' style='WIDTH:100%;BACKGROUND-COLOR:#E6ECF4;border: 1px solid #FFFFFF'> " +//原色值是DBE6F2
					"</div>	";
	var tmp = GetAttr(this.HtmlEle,"ListData",null);
	var datastoreName = tmp.substring(0,tmp.indexOf("."));
	var listData = GetDsNode(datastoreName + ".List." + item.GetAttr("Id"));
	var itemcount=0;//modify by rider 2004-07-28					
	for(var i = 0;i < listData.GetItemCount();i++)
	{
		this.AddMenuItem(ele.all("SubMenuItemSetDiv"),listData.GetItem(i));
		itemcount++;
	}
	if (itemcount>0)
		div.appendChild(ele);
}

JcMenuBar.prototype.Fire=function(eventname)
{	var e = this.HtmlEle.getAttribute(eventname);
	if(e)
		eval(e);
}

JcMenuBar.OnButtonClick=function()
{
	var ele=event.srcElement;
	while(ele.id != "MenuItemSpan")
		ele = ele.parentElement;
	var item = ele.DataItem;
	var obj=GetParentJcElement(ele).Co;

	obj.Event = new Object;
	obj.Event.DataItem=item;
	obj.Event.returnValue=true;
	obj.Fire("OnButtonClick");
	if(obj.Event.returnValue)
	{
		var style=CenterWin(item.GetAttr("LinkStyle"));	
		if(item.GetAttr("LinkUrl")&&item.GetAttr("LinkUrl")!="")
			ParamLinkTo(item.GetAttr("LinkUrl"),item.XmlEle,item.GetAttr("LinkTarget"),style);	
		if(obj.SelectedItem != ele)
		{
			if(obj.SelectedItem)	
				obj.SelectedItem.className = obj.SubCss("OnMouseOut");
			obj.SelectedItem = ele;
		}			
	}
}

JcMenuBar.OnMouseOver = function()
{
	var ele = event.srcElement;
	if ( ele && ele.tagName.toLowerCase() == "td" )
	{
		if (ele.previousSibling)
		{
			ele.previousSibling.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbga.JPG')";
		}
		else if (ele.nextSibling)
		{
			ele.nextSibling.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbga.JPG')";
		}
		ele.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbga.JPG')";
		while(ele.id != "MenuItemSpan")
			ele = ele.parentElement;
		var obj=GetParentJcElement(ele).Co;	
		ele.className = obj.SubCss("OnMouseOver");
	}
}

JcMenuBar.OnMouseMove = function()
{
	var ele = event.srcElement;
	while(ele.id != "MenuItemSpan")
		ele = ele.parentElement;
	var obj=GetParentJcElement(ele).Co;	
	ele.className = obj.SubCss("OnMouseMove");
}


JcMenuBar.OnMouseOut = function()
{
	var ele = event.srcElement;
	if ( ele &&  ele.tagName.toLowerCase() == "td" )
	{
		if (ele.previousSibling)
		{
			ele.previousSibling.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbg.JPG')";
		}
		else if (ele.nextSibling)
		{
			ele.nextSibling.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbg.JPG')";
		}
		ele.style.backgroundImage = "url('/portal/image/outbar/leftmenu_tdbg.JPG')";
		while(ele.id != "MenuItemSpan")
			ele = ele.parentElement;
		var obj=GetParentJcElement(ele).Co;		
		if(obj.SelectedItem != ele)
			ele.className = obj.SubCss("OnMouseOut");
	}
}

JcMenuBar.prototype.AddMenuItem = function(div,item)
{
	var ele = document.createElement("<span id='MenuItemSpan' onclick='JcMenuBar.OnButtonClick();' onmousemove='JcMenuBar.OnMouseMove();' onmouseout='JcMenuBar.OnMouseOut();' onmouseover='JcMenuBar.OnMouseOver();' class='" + this.SubCss("OnMouseOut") + "'>");
	ele.DataItem = item;
	ele.innerHTML = "<table height='100%' width='200%' cellpadding='0' cellspacing='0' style='FONT-SIZE:9pt'> " +
						"<tbody> " +
							"<tr height='23' width='32'> " +
								"<td id='ItemIcon' align='center' width='28' ><img style='width:8;height:8;' src='"+item.GetAttr("Icon")+"'></td> " +
								"<td id='ItemTitle' valign='middle' align='left' >" + item.GetAttr("Title") + "</td> " +
							"</tr> " +
						"</tbody> " +	
					"</table>";
	div.appendChild(ele);				
}

JcMenuBar.prototype.RenderObject=function()
{
	this.HtmlEle.innerHTML = "<TABLE width='100%' height='100%' cellSpacing='0' cellPadding='0' style='backgroundcolor:#FFFFFF'> " +
								"<TR> " +
									"<TD id='MenuTd'> " +
										"<table width='100%' height='100%'> " +
											"<tr height='24'> " +
												"<td id='MenuTitleTd' style='border: 1px solid #FFFFFF; padding-left:5;padding-top:2; background-image: url(\"/share/image/outbar/OutBarTitleBtnBg.gif\"); background-repeat: repeat-x;height:20'>" + this.MenuName + "</td> " +
											"</tr> " +
											"<tr valign='top'> " +
												"<td> " +
													"<div style='FONT-SIZE:10pt;OVERFLOW-x:hidden;WIDTH:100%;HEIGHT:100%'> " +
														"<div id='MenuItemSetDiv' align='left' style='WIDTH:100%;BACKGROUND-COLOR:#DBE6F2;border: 1px solid #FFFFFF'> " + 
														"</div>" + 
													"</div> " +
												"</td> " +
											"</tr> " +													
										"</table> " +
									"</TD> " +
									"<TD style='background-color:#759ED0; cursor:hand; width:8px;'> " +
										"<table width='100%' height='100%' cellpadding='0' cellspacing='0'> " +
											"<tr height='24'> " +
												"<td></td> " +
											"</tr> " +
											"<tr> " +
												"<td onclick='JcMenuBar.HideMenu();' id='DisTd'><span id='_display' src='/share/image/outbar/OutBarDisplayBtn.gif'></span></td> " +
											"</tr> " +
										"</table> " +
									"</TD> " +
								"</TR> " +
							"</TABLE>";
	var subMenu = new Array();	
	var itemcount=0;//modify by rider 2004-07-28					
	for(var i = 0;i < this.ListData.GetItemCount();i++)
	{
		var item = this.ListData.GetItem(i);
		if(item.GetAttr("Type")&&item.GetAttr("Type").toLowerCase() == "submenu")
		{
			subMenu[subMenu.length] = item;
		}
		else
		{
			this.AddMenuItem(this.HtmlEle.all("MenuItemSetDiv"),item);
			itemcount++;
		}
	}
	if (itemcount==0)
	{	this.HtmlEle.all("MenuTd").childNodes[0].childNodes[0].childNodes[0].style.display="none";//table/tbody/tr
		this.HtmlEle.all("MenuItemSetDiv").style.display="none";
	}
	for(var i = 0;i < subMenu.length;i++)
	
	{
		this.AddSubMenu(this.HtmlEle.all("MenuItemSetDiv").parentElement,subMenu[i]);
	}				
	this._UpdateImage();
}

JcMenuBar.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}
//
//--------------------------------JcMenuBar对象定义结束---------------------------------------------------
//

//
//--------------------------------JcTab1对象定义开始---------------------------------------------------
//
function JcTab1(ele)
{
	this.Css=null;
	this.Type=null;
	this.ListData=null;
	this.LinkTarget=null;
	this.TabType=null;
	this.SelectCommon=null;
	this.UnselectCommon=null;
	this.SelectedIndex=null;
	this.Init(ele);
	this.Event=null;
}

JcTab1.prototype.Init=function(ele)
{
	if(!ele)
	{
		document.createElement("<span style='JcTab1' jctype='jctab1'>");
	}
	this.HtmlEle=ele;
	this.HtmlEle.Co=this;
	this.HtmlEle.className="JcTab1";
	this.Type="JcTab1";
	this.Css="JcTab1";
	if(this.HtmlEle.getAttribute("ListData"))
		this.ListData=GetDsNode(this.HtmlEle.getAttribute("ListData"));	
	if(this.HtmlEle.getAttribute("LinkTarget"))
		this.LinkTarget=document.all(this.HtmlEle.getAttribute("LinkTarget"));
	if(this.HtmlEle.getAttribute("TabType"))
		this.TabType=this.HtmlEle.getAttribute("TabType");	
	if(!this.TabType)
		this.TabType="Common";
	switch(this.TabType.toLowerCase())
	{
		case "XP":
		break;
		default:
		break;
	}
	this.SelectCommon=this.SubCss(this.TabType)+"Select";
	this.UnselectCommon=this.SubCss(this.TabType)+"Unselect";
	if(this.HtmlEle.getAttribute("SelectedIndex"))
		this.SelectedIndex=parseInt(this.HtmlEle.getAttribute("SelectedIndex"));
	else
		this.SelectedIndex=0;
	this.t1="<table width=100% height=100% cellspacing=0 cellpadding=0 border=0>"
	+ "							<tr>"
	+ "								<td id=DivCenter align=center valign=middle onclick='JcTab1.SelectTab();' class=" + this.SelectCommon + ">"
	+ "								</td>"
	+ "							</tr>"
	+ "						</table>";
	this.t2="<table width=100% height=100% cellspacing=0 cellpadding=0 border=0>"
	+ "							<tr height='20%'>"
	+ "								<td>"
	+ "								</td>"
	+ "							</tr>"
	+ "							<tr height='80%'>"
	+ "								<td id=DivCenter align=center valign=middle onclick='JcTab1.SelectTab();' class=" + this.UnselectCommon + ">"
	+ "								</td>"
	+ "							</tr>"
	+ "						</table>";
	this.RenderObject();
}

JcTab1.prototype.Fire=function(eventname)
{	var e = this.HtmlEle.getAttribute(eventname);
	if(e)
		eval(e);
}

JcTab1.SelectTab=function()
{
	var ele=event.srcElement;
	var jcEle=GetParentJcElement(ele);
	var selectTitle = ele.innerHTML;

	var divEles=ele.parentNode.parentNode.parentNode.parentNode.parentNode.childNodes;
	var cele = ele.parentNode.parentNode.parentNode.parentNode;
	var tabs=jcEle.Co.ListData.GetItems();
	for(var i=0;i<divEles.length;i++)
	{
		//divEles[i].style.zIndex=1000;
		if ( cele != divEles[i])
			divEles[i].innerHTML = jcEle.Co.t2;
		else
		{
			cele.innerHTML = jcEle.Co.t1;
				jcEle.Co.SelectedIndex = i;
		}
		var title=tabs[i].GetAttr("Title");
		divEles[i].all("DivCenter").innerHTML= title;
	}
	//alert(ele.parentNode.parentNode.parentNode.outerHTML);
	//var parentDivEle=ele.parentNode.parentNode.parentNode.parentNode;
	/*
	while(parentDivEle&&parentDivEle.tagName.toLowerCase()!="div")
	{
		parentDivEle=parentDivEle.parentNode;
	}
	*/
	//parentDivEle.style.zIndex=1005;
	//parentDivEle.all("DivCenter").className=jcEle.Co.SelectCommon;
	//parentDivEle.innerHTML= jcEle.Co.t1;
	//parentDivEle.all("DivCenter").innerHTML= selectTitle;
	jcEle.Co.Event = new Object;
	jcEle.Co.Event.ActionKey="";
	jcEle.Co.Event.returnValue=true;
	jcEle.Co.Fire("OnTabClick");
	if(jcEle.Co.Event.returnValue && jcEle.Co.LinkTarget)
		jcEle.Co.LinkTarget.src=parentDivEle.getAttribute("LinkUrl");
}

JcTab1.prototype.RenderObject=function()
{
	//this.HtmlEle.innerHTML="<DIV class='JcTab_Line' style='z-index:1002;POSITION:absolute;left:" + this.HtmlEle.style.left + ";'></DIV>";
	this.HtmlEle.innerHTML="<table style='width:"+this.HtmlEle.getAttribute("width")+";height:"+this.HtmlEle.getAttribute("height")+";' cellpadding='0' cellspacing='0' class=JcTab1_border><tr></tr></table>";
	
	var dataList=this.ListData;
	var tabs=dataList.GetItems();
	var tabTemplate=document.createElement("<td></td>");
	
	var preTabEle=null;
	for(var i=0;i<tabs.length;i++)
	{
		var tabEle=tabTemplate.cloneNode(true);
		
		/*
		var linkUrl=tabs[i].GetAttr("LinkUrl");
		if(linkUrl&&linkUrl!="")
		{
			tabEle.setAttribute("LinkUrl",linkUrl);
		}
		else
		{
			alert("第" + (i+1) + "项的LinkUrl未设置!");
			return false;
		}
		*/
		if(this.SelectedIndex==i)
		{
			if ( this.LinkTarget )
				this.LinkTarget.src = tabEle.getAttribute("LinkUrl");
			tabEle.style.zIndex=1005;
			tabEle.innerHTML = this.t1;
			tabEle.all("DivCenter").className=this.SelectCommon;
		}
		else
		{
			tabEle.style.zIndex=1000;
			tabEle.innerHTML = this.t2;
		}
		var title=tabs[i].GetAttr("Title");
		//var tabwidth = title.bytelen()*7 + 24;   width=100% 
		//tabEle.style.width = tabwidth;
		//绘制元素可能导致定位错误，可以采用绝对定位的方式解决
		//背景切换可能导致出错
		tabEle.all("DivCenter").innerHTML= title ;
		//alert(this.HtmlEle.childNodes[0].childNodes[0].childNodes[0].childNodes[0].outerHTML);
		this.HtmlEle.childNodes[0].childNodes[0].childNodes[0].appendChild(tabEle);
		if(i==0)
		{
			tabEle.style.left=this.HtmlEle.style.left;
			this.HtmlEle.childNodes(0).style.top=20;//tabEle.offsetTop+tabEle.offsetHeight-1;
		}
		else
		{
			tabEle.style.left=preTabEle.offsetLeft+preTabEle.offsetWidth;
		}
		preTabEle=tabEle;
	}	
}
JcTab1.prototype.Destroy=function()
{
	
}
JcTab1.prototype.SubCss=function(name)
{
	return this.Css + "_" + name;
}
//
//--------------------------------JcTab1对象定义结束---------------------------------------------------
//

var j=0;
var w=0;
function Hide() 
{
	if (j%2 == 0 )
	{
		SearchBar.style.display = "block";
	}
	else
	{
		SearchBar.style.display = "none";
	}
	j++;	
}

function ListHeight()
{
	if (w%2 == 0 )
	{
		ListShow.src = "/share/image/ToolBar_up.gif";
		ListShow.title = "收缩列表";
		MyTable.style.height = "100%";
	}else
	{
		ListShow.src = "/share/image/ToolBar_down.gif";
		ListShow.title = "展开列表";
		MyTable.style.height = "300";
	}
	w++;	
}




//
//-------------------------------------JcSeleTable对象定义开始-----------------------------
//				author:tyaloo


function JcSeleTable(dataSrc,listFields,titleNames,fieldWidths)
{
   this.ListData = dataSrc;
   this.TitleNames = titleNames;
   this.ListFields = listFields;
   this.FieldWidths = fieldWidths;
   this.TableName = "";
   this.QueryField = "";
   this.OnSelect = null;
   this.AutoEle = null;
   this.HtmlEle = null;
   this.ClearParentForm = null;
}

JcSeleTable.prototype.Draw = function(parentEle)
{
	var _listCount = this.ListData.GetItemCount();
	
	var titleNameArray = this.TitleNames.split(",");
	var fieldNameArray = this.ListFields.split(",");

	var fieldWidthArray = this.FieldWidths.split(",");
    var fieldNameCount = fieldNameArray.length;

    if(fieldNameCount !=titleNameArray.length)
    {
		throw("字段名数目和标题名数目不匹配!");
    } 
    
    var _parentEleChild = parentEle.firstChild;

	if(_parentEleChild)
	    parentEle.removeChild(_parentEleChild);


	var _newTable = document.createElement("table");
    _newTable.className = "JcSeleTable";
	
	var _newThead = _newTable.createTHead();
	
	var _newTheadRow = _newThead.insertRow();
	for(var n=0;n<fieldNameCount;n++)
	{
		var _newTd = document.createElement("td");
		_newTd.innerText = titleNameArray[n];
        _newTd.width = fieldWidthArray[n]+"%";
        _newTheadRow.appendChild(_newTd);
	
	}
	
	//_newTable.appendChild(_newThead);

	if(fieldNameCount==1) _newThead.style.display="none";
	
	var _newTBody = _newTable.tBodies[0];
	
	
	//_newTable.onkeydown = _JcSeleTableOnkeydown;
    // _newTable.onblur = _JcSeleTableOnblur; 
	for(var i=0;i<_listCount;i++)
	{
		var _dataItem = this.ListData.GetItem(i);

		var _newRow = document.createElement("tr");
		
		_newRow.DataSource = _dataItem;
		_newRow.onmouseout = _OnSeleTableRowMouseout;
		_newRow.onmouseover = _OnSeleTableRowMouseover;
		
		_newRow.onclick = _OnSeleTableRowClick;
		_newRow.OnSelect = this.OnSelect;
		_newRow.AutoEle = this.AutoEle;
		
		 for(var n=0;n<fieldNameCount;n++)
         {
           var seleField = fieldNameArray[n];
           var _newTd = document.createElement("td");
           
           _newTd.innerHTML ="<nobr>"+ _dataItem.GetAttr(seleField)+"</nobr>";
           _newRow.appendChild(_newTd);
         
         
         }  
		  _newTBody.appendChild(_newRow);
	}
		
	var _newTfoot = _newTable.createTFoot();
	var _newTfootRow = _newTfoot.insertRow();

	var _newTd = document.createElement("td");
	_newTd.style.textAlign = "right";
	_newTd.colSpan=fieldNameCount;
	var _newLink = document.createElement("a");
	_newLink.innerText = "清除";
	_newLink.href="#";
	_newLink.AutoEle = this.AutoEle;
	_newLink.onclick = this.ClearParentForm;
	_newTd.appendChild(_newLink);

	_newTd.onclick = function(){event.cancelBubble=true;};

	_newTfootRow.appendChild(_newTd);

	_newTable.JcObject = this;    
	this.HtmlEle = _newTable;
	parentEle.appendChild(_newTable);
}


function _JcSeleTableOnblur()
{
  var jcSeleTb = this.JcObject;
  
  if(jcSeleTb.AutoEle)
  {
     alert(this.parentNode.id);    
     jcSeleTb.AutoEle.onblur = function(){window.setTimeout("HideSuggestArea('"+this.parentNode.id+"')",200);};
  }
}


JcSeleTable.prototype.SelectRow=function(rowIndex)
{
   var seleRow = this.HtmlEle.tBodies[0].rows[rowIndex];

   if(seleRow)
   {
   	seleRow.lastBgColor=seleRow.style.backgroundColor;
	seleRow.style.backgroundColor='orange';
	seleRow.lastColor=seleRow.style.color;
	seleRow.style.color='white';
   
     this.HtmlEle.seleRow = seleRow;
   }

   return seleRow;
}

function _OnSeleTableRowClick()
{

    this.OnSelect(this.DataSource,this.AutoEle);
    this.AutoEle.focus();
}
                            
function _OnSeleTableRowMouseover()
{
  if(this.onmouseout!=null)
  {
	this.lastBgColor=this.style.backgroundColor;
	this.style.backgroundColor='orange';
	this.lastColor=this.style.color;
	this.style.color='white';
  }	
}

function _OnSeleTableRowMouseout()
{
	this.style.backgroundColor=this.lastBgColor;
    
	this.style.color=this.lastColor;
}

function _JcSeleTableOnkeydown()
{
	var action = kbActions[event.keyCode];
	if (action)
	{
		switch(action)
		{
			case "down":
			_DoRowDown(event.srcElement);
			break;
			case "up":
			_DoRowUp(event.srcElement);
			break;
			case "enter":
			_DoRowClick(event.srcElement);
			break;
		}
		event.returnValue = false;
		event.cancelBubble = true;
	}
}

function _DoRowClick(srcElement)
{
	var nowSeleRow = srcElement.seleRow;
	
	if(nowSeleRow) nowSeleRow.click();
}
	
function _DoRowDown(srcElement)
{
	var nowSeleRow = srcElement.seleRow;

	if(nowSeleRow==null)
	{
	    try
	    {
	    nowSeleRow = srcElement.tBodies[0].rows[0];
	    }
	    catch(e){return;}

	    if(nowSeleRow)
	    {
	    nowSeleRow.lastBgColor=nowSeleRow.style.backgroundColor;
	    nowSeleRow.style.backgroundColor='orange';
	    nowSeleRow.lastColor=nowSeleRow.style.color;
	    nowSeleRow.style.color='white';

        srcElement.seleRow = nowSeleRow;
        }
	    return;
	}  
	//var parentCell = srcElement.parentNode;
			
	var nextRow = nowSeleRow.nextSibling;
	if(nextRow)
	{
	var lastSeleRow = srcElement.seleRow; 
	if(lastSeleRow)
	{ 
	lastSeleRow.style.backgroundColor=lastSeleRow.lastBgColor;
	lastSeleRow.style.color=lastSeleRow.lastColor;
	}
	srcElement.seleRow = nextRow;
	nextRow.lastBgColor=nextRow.style.backgroundColor;
	nextRow.style.backgroundColor='orange';
	nextRow.lastColor=nextRow.style.color;
	nextRow.style.color='white';  
	}
	else
	{
		return ;
	}
}

function _DoRowUp(srcElement)
{
	var nowSeleRow = srcElement.seleRow;
	
	if(nowSeleRow)
	{
	var previousRow = nowSeleRow.previousSibling;
	if(previousRow)
	{
	if(nowSeleRow)
	{ 
	nowSeleRow.style.backgroundColor=nowSeleRow.lastBgColor;
	nowSeleRow.style.color=nowSeleRow.lastColor;
	}

	srcElement.seleRow = previousRow;
	previousRow.lastBgColor=previousRow.style.backgroundColor;
	previousRow.style.backgroundColor='orange';
	previousRow.lastColor=previousRow.style.color;
	previousRow.style.color='white';

	}
	else
	{
	nowSeleRow.style.backgroundColor=nowSeleRow.lastBgColor;
	nowSeleRow.style.color=nowSeleRow.lastColor;
	srcElement.seleRow = null;
	srcElement.JcObject.AutoEle.focus();
	}	
	}
}

JcSeleTable.prototype.AsynDraw=function(queryEle,suggestArea)
{
    var _nowJcSeleTable = this;    
    var queryValue = queryEle.value;
    if(queryValue=="")
    {

		var _parentEleChild = suggestArea.firstChild;
	    if(_parentEleChild)
	        suggestArea.removeChild(_parentEleChild);
        queryEle.queryFinish = true;
        suggestArea.hasFocus = false;
		return false;
    
    
    }
    
	var url="/Share/AutoCompleteDataProvider.aspx";
	
	var _fields = this.ListFields;
	if(this.AttachField && this.AttachField != "")
		_fields += "," + this.AttachField;
	
	var queryParameters = "TableName="+this.TableName;
	queryParameters +="&FieldNames="+_fields;
	queryParameters +="&MatchField="+this.QueryField;
	queryParameters +="&QueryValue="+queryValue;
	queryParameters +="&DisplayFields="+this.ListFields;
	
	
	var myAjax = new Ajax.Request(
		url,
		{method:'post',
		parameters:queryParameters,
			onComplete: function(resp)
				{
					queryEle.queryFinish = true;
					_nowJcSeleTable.ListData = new DataList(resp.responseText);
					
					if(_nowJcSeleTable.ListData.GetItemCount()==0)
					{
						suggestArea.style.display="none";
						suggestArea.hasFocus = false;
						return false;
		            } 
					_nowJcSeleTable.Draw(suggestArea);
					
					suggestArea.style.display="";
				},
			onSuccess:function(){
			}
		}
	);
}

// 添加本地获取数据方法
JcSeleTable.prototype.LocalDraw=function(queryEle,suggestArea)
{
    var _nowJcSeleTable = this;
    
    if(queryEle && queryEle.Co && queryEle.AutoList)
    {
		var _orgdl = GetDsNode(GetAttr(queryEle,"AutoList"));
		var _tmpdl = new DataList();
		var _tmpval = (queryEle.value ? queryEle.value : queryEle.all("_text").value);
		var _tmpcount = _orgdl.GetItemCount();
		for(var i=0; i<_tmpcount; i++)
		{
			var _tmpitem = _orgdl.GetItem(i);
			if((_tmpitem.GetAttr(this.QueryField).toLowerCase()).indexOf(_tmpval.toLowerCase()) == 0)
			{
				_tmpdl.AddItem(_tmpitem);
			}
		}
		
		_nowJcSeleTable.ListData = _tmpdl;
		queryEle.queryFinish = true;
    }
    else
    {
		//_nowJcSeleTable.ListData = new DataList(dl);
		throw "couldn't find the autocomplete datasource ";
		return;
	}
	
	if(_nowJcSeleTable.ListData.GetItemCount()==0)
	{
		suggestArea.style.display="none";
		suggestArea.hasFocus = false;
		return false;
	} 
	_nowJcSeleTable.Draw(suggestArea);
	
	suggestArea.style.display="";
}