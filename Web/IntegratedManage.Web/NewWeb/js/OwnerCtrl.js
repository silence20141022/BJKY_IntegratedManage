



function OwnTable(ele)
{
   if(!ele) ele = document.createElement("<span class='JcTable'>");
   this.HtmlEle = ele;
   this.HtmlEle.Cm = this;
   this.ListData;
   this.HighLight=false;
   this.type=null;
   this.DefCol=new Array();
   this._TmpRow=null;
   this.SelectMode="none";
   this.SelectedRow=null;
   this.Event = new Object;
   this.Render ="client";
   this.TextCell ="<input type='text' id='DefineId'>";
   this.SelectCell ="<select id='DefineId'></select>";
   this.PopUpCell ="";
   this.Init(ele);
}


OwnTable.prototype.Init=function(ele)
{
     if(ele.getAttribute("list"))
     {
        this.ListData = GetDsNode(ele.getAttribute("list"));
        this._newList = GetDsNode(ele.getAttribute("list"));
        if(!this.ListData)
          alert("Error!")
     }
     else
     {
       this.ListData= new List();
       this._newList = new List();
     }
     if(ele.getAttribute("selectmode"))
       this.SelectMode = ele.getAttribute("selectmode");
       
     var div = document.createElement("<div class='JcTable_Body' style='width:100%;height:100%'></div>");
     div.appendChild(this.HtmlEle.childNodes[0]);   
     this.HtmlEle.appendChild(div);
     
     this._InitDefine();
     this.InitData();
     this.InitEvent();  
}


OwnTable.prototype._InitDefine = function()
{    
    
     var ele = this.HtmlEle;
     this._TmpRow = ele.getElementsByTagName("tr")[0];
     var drow = this._TmpRow;
     var trow = drow.cloneNode(false);
     trow.style.display="";
     var colCount = drow.childNodes.length;
     for(var i=0;i<colCount;i++)
     {
        var tdcell = document.createElement("td");        
        var defobj=this.DefCol[i]=new Object(); 
        //this.DefCol[i] =new Object(); 
        var cell = drow.childNodes[i];
        cell.className=this.GetSubCss("TitleTd");
        var type =GetAttr(cell,"type","data").toLowerCase();
        defobj["type"]=type; 
        if(this.SelectMode!="none"&&type=="selector")
        {
            this._SetSelectBox(tdcell,cell);
            this.DefCol[i]=defobj;
        }
        else
        {
           defobj["fieldname"] = GetAttr(cell,"fieldname","");           
           this.DefCol[defobj["fieldname"]]=defobj; 
           defobj["datatype"] = GetAttr(cell,"datatype","string");
           defobj["popurl"] = GetAttr(cell,"popurl","");
           defobj["popupparam"] = GetAttr(cell,"popupparam","");
           defobj["returnparam"] = GetAttr(cell,"returnparam","");
           defobj["valstring"] = GetAttr(cell,"valString","");
           if(cell.getAttribute("notallowempty")!=null)
               defobj["notallowempty"] = "true";
           else
               defobj["notallowempty"] = "false";
           defobj["popstyle"]=GetAttr(cell,"popstyle","");
           defobj["type"] = GetAttr(cell,"type","text");
           defobj["ctrstyle"] = GetAttr(cell,"ctrstyle","width:100%;");
           defobj["enum"]=GetAttr(cell,"enum",null);
           /*if(defobj["enum"])
              defobj["enumobject"]=GetStNode(defobj["enum"]);*/
           defobj["tooltip"]=GetAttr(cell,"tooltip",null);
           defobj["onchange"]=GetAttr(cell,"onchange",null);           
        }
        trow.appendChild(tdcell);
     }
     this._TmpRow = trow;       
}


OwnTable.prototype.InitData=function()
{
    var ele = this.HtmlEle;   
    if(!this.ListData)
    {
       alert("Error!");return false;
    }
    var list = this.ListData;   
    
    this.HtmlEle.childNodes[0].style.overflow ="auto";
    var tbody = document.createElement("<tbody id ='tbody'>");
    this.HtmlEle.childNodes[0].childNodes[0].appendChild(tbody);
   
    if(this.ListData && this.Render=="client")
    {   
       for(var i=0;i<this.ListData.GetItemCount();i++)
       {
          var row = this._TmpRow.cloneNode(true);
          var pos = i;
          if(pos%2==0)
            row.className = this.GetSubCss("Row1");
          else
            row.className = this.GetSubCss("Row2");
          row.setAttribute("RowIndex",i);
          row.setAttribute("PreClassName",row.className);   
          
          this.InitRow(row,this.ListData.GetItem(i),i);
          tbody.appendChild(row);
       }    
    }   
}


OwnTable.prototype.InitEvent=function()
{
   var tbl = this.HtmlEle.childNodes[0].childNodes[0];   
   //tbl.onmouseover = this.MouseOver;
   //tbl.onmouseout = this.MouseOut;
   tbl.onclick = this.MouseClick;
}

OwnTable.prototype.InitRow = function(row,item,index)
{   

    if(item)
       row.Record = item;
    for(var i=0;i<this.DefCol.length;i++)
    {
       var celldef = this.DefCol[i];      
       var cell = row.childNodes[i];       
       var type = celldef["type"].toLowerCase();
       var cellhtml ="";
       var cellcrl = document.createElement("input")
       var cellcrl;
       var txt = celldef["fieldname"]+"_"+index.toString();
       var txtId = celldef["fieldname"]+"Id_"+index.toString();
       switch(type)
       {
          default:
            cellhtml = this.TextCell;  // 默认为 text 控件
            break;
          case "no":
            cellhtml = row.getAttribute("RowIndex")+1;
            cell.innerHTML = cellhtml;
            continue;
          case "selector":
            continue;
          case "jcfile":
            this.InitCtrl(celldef,cell,txt,txtId,item.GetAttr(celldef["fieldname"]));
            break;
          case "text":
            this.InitCtrl(celldef,cell,txt,txtId,item.GetAttr(celldef["fieldname"]));
            break;
          case "select":
            this.InitCtrl(celldef,cell,txt,txtId,item.GetAttr(celldef["fieldname"]));
            break;
          case "popup":
            var indexName = celldef["fieldname"]+"Id";
            var value = item.GetAttr(celldef["fieldname"]);
            var txtValue = item.GetAttr(indexName);
            if(txtValue==null)
                txtValue ="";
            this.InitCtrl(celldef,cell,txt,txtId,value,txtValue);
            cellhtml = cellhtml.replace("DefineId",txt);
            break;
       }
       
       cell.appendChild(cellcrl);       
    }
}

OwnTable.prototype.Copy = function(item)
{
    var row = this._TmpRow.cloneNode(true);
    var body = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);
    var index = 0;
    var index = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1).childNodes.length;
    //var pos = index;
    if(index%2==0)
        row.className = this.GetSubCss("Row1");
    else
        row.className = this.GetSubCss("Row2");
    row.setAttribute("PreClassName",row.className);   
          
    this.InitRow(row,item,index)
    body.appendChild(row);
     
}


OwnTable.prototype._SetSelectBox=function(tcell,cell)
{
   var ele = this.HtmlEle;
   tcell.style.width=22;
   cell.style.width=22;
   cell.style.align = "'center'";  
   tcell.style.align = "'center'";   
   if(this.SelectMode.toLowerCase()=="multi")
   {
     tcell.innerHTML = "<input type='checkbox'  id='selector' name='selector_"+ele.id+"'>";
     tcell.style.cssText ="align='center'";
     cell.innerHTML="<input type='checkbox' id='selmaster'>";
   }
   else if(this.SelectMode.toLowerCase()=="single")
   {
     tcell.innerHTML = "<input type='radio'  id='selector' name='selector_"+ele.id+"'>";
     cell.innerHTML="<input type='radio' id='selmaster' >";
   }  
}

OwnTable.prototype.GetSubCss=function(name)
{
   if(typeof(name)=="string")
      return "JcTable_"+name;
}

OwnTable.prototype.HighLigthRow=function(row,state)
{   
    var prow = this._HLRow;
    if(prow)
    {
      
       if(prow.selected)
          prow.className = this.GetSubCss("RowSelected");
       else
          prow.className = prow.getAttribute("PreClassName");
    }
    this._HLRow=row;
    if(row.selected)
    {
        if(this.HighLight)
           row.className=this.GetSubCss("RowSelHighlight");
        else
           row.className=this.GetSubCss("RowSelected");
    }
    else
    {
        if(this.HighLight)
           row.className = this.GetSubCss("RowHighlight");
        else
           row.className = row.getAttribute("PreClassName");
    }
}

/*撤销行的高亮状态*/
OwnTable.prototype.ClearHighLight=function()
{
   var prow = this._HLRow;
   if(prow)
   {
      if(prow.selected)
          prow.className=this.GetSubCss("RowSelHighlight");
      else
          prow.className = prow.getAttribute("PreClassName");
         
   } 
}


OwnTable.prototype.Fire=function(eventname)
{
   var onfunc = this.HtmlEle.getAttribute(eventname);
   if(onfunc)
      eval(onfunc);   
}


OwnTable.prototype.SelectAll = function()
{
    var rows = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1).childNodes; //span/div/table/tbody/row
    var items = new Array();
    for(var i=0;i<rows.length;i++)
    {
        items[i] = rows[i];
    }
    return items;
}


OwnTable.prototype.GetSelected = function(type)
{
    var rows = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1).childNodes;
    var items = new Array()
    for(var i=0;i<rows.length;i++)
    {
        if(rows[i].selected || (rows[i].all("selector")&&rows[i].all("selector").checked))
        {
            if(type&&type.toLowerCase()=="html")
            {
               items[items.length]=rows[i];
              
            }
            else
            {
               items[items.length]=this.ListData.GetItem(i);
            }
        }
        
    }
    return items;
}


OwnTable.prototype.SelectRow=function(row,state)
{   
    if(row.getAttribute("PreClassName")==null)
    {
        this.Event.returnValue = false;
        return false;
    }

    if(this.SelectMode=="single")
    {
        var prow = this.SelectedRow;
        if(prow!=null)
        {
           prow.selected = false;
           prow.className = prow.getAttribute("PreClassName")
        }
        row.selected = state;
        if(row.all("selector"))
        {
           row.all("selector").checked = state;          
        }
        if(state)
        {
           row.className = this.GetSubCss("RowSelected");
           this.SelectedRow = row;
        }
        else
        {
           row.className = row.getAttribute("PreClassName");
        }
    }
    else if(this.SelectMode=="multi")
    {
      
        row.selected = state;
        if(row.all("selector"))
        {
           row.all("selector").checked = state;
        }
        if(state)
        {
           row.className = this.GetSubCss("RowSelected");
        }
        else
        {
           row.className = row.getAttribute("PreClassName");    
        }
    }  
    
    //增加行选中状态变更事件
    this.Event = new Object;
    this.Event.Row = row;
    this.Event.Record = row.Record;
    this.Event.returnValue = true;
    this.Fire("onrowstatechange");
}


/*设置首行selector选中后的cmtable状态*/
OwnTable.prototype.MasterSelect= function(state)
{
     var eventEle = event.srcElement;
     var obj = GetParentCmElement(eventEle);
     var rows = obj.childNodes(0).childNodes(0).childNodes(1).childNodes;
     
     if(this.SelectMode=="multi")
     {
         for(var i=0;i<rows.length;i++)
         {
             this.SelectRow(rows[i],state);
         }
     }
     if(this.SelectMode =="single")
     {
          for(var i=0;i<rows.length;i++)
         {
             this.SelectRow(rows[i],false);
         }
     }   
    
}


OwnTable.prototype.MouseOver=function()
{
    var eventEle = event.srcElement;
    var ele = GetParentCmElement(eventEle);
    if(ele==null||ele.cmtype.toLowerCase()!="listtable")
    {
       event.returnValue = false;
       return false;
    }
    
    var row = GetTableTr(event.srcElement);
    if(!row||row==ele.childNodes[0].childNodes[0].childNodes[0].childNodes[0]) //span/div/table/tbody/tr
      return ;
    var obj = ele.Cm;
    
    if(obj.HighLight)
       obj.HighLigthRow(row,true);    
    
}

OwnTable.prototype.MouseOut=function()
{
    var ele = GetParentCmElement(event.srcElement);
    if(ele==null)
      return;
    var obj = ele.Cm;
    
    obj.ClearHighLight();
}

OwnTable.prototype.MouseClick=function()
{   
    var ele = GetParentCmElement(event.srcElement);
    //alert(ele.outerHTML);
    if(ele==null)
      return;
    var obj = ele.Cm;
    
    //有可能点中的是Table本身 此时取消 onclick 事件 
    if(event.srcElement.tagName.toLowerCase() =="table"||event.srcElement.tagName.toLowerCase()=="tbody")
    {
       //this.Event.returnValue = false;
       return false;
    }
    
    var row = GetTableTr(event.srcElement);
   
    if(event.srcElement.id =="selmaster"&&event.srcElement.tagName.toLowerCase()=="input")
    {  
       obj.MasterSelect(event.srcElement.checked);
       return;
    }

    if(obj.SelectMode=="single")
    {  
       obj.SelectRow(row,true);
    }
    else if(obj.SelectMode =="multi")
    {
        if(row.selected)
        {
           obj.SelectRow(row,false);
        }
        else
        {
           obj.SelectRow(row,true);
        }
        
    }
}


OwnTable.prototype.AddRow=function()
{
    var row = document.createElement("tr");
    var drow = this._TmpRow;
    var index=0;
    var body = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);

    index = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1).childNodes.length;
    
    if(index%2==0)
      row.className=this.GetSubCss("Row1");
    else
      row.className=this.GetSubCss("Row2");
   
    row.setAttribute("RowIndex",index);
    row.setAttribute("PreClassName",row.className); //增加原有行的css属性 
    
    for(var i=0;i<this.DefCol.length;i++)
    {
       var celldef = this.DefCol[i];      
       var cell = document.createElement("td");  
       var txt = celldef["fieldname"]+"_"+index.toString();
       var txtId = celldef["fieldname"]+"Id_"+index.toString();
      
       var type = celldef["type"].toLowerCase();
       var tdcell = drow.childNodes[i];
       switch(type)
       {
          default:
            cellhtml = this.TextCell;  // 默认为 text 控件
            break;
          case "no":
            cellhtml = row.getAttribute("RowIndex")+1;
            cell.innerHTML = cellhtml;
            break;
          case "selector":          
            this._SetSelectBox(cell,tdcell);
            break;
          case "jcfile":
            this.InitCtrl(celldef,cell,txt,txtId);
            break;
          case "text":
            this.InitCtrl(celldef,cell,txt,txtId);
            break;
          case "select":
            this.InitCtrl(celldef,cell,txt,txtId);
            break;
          case "popup":
            this.InitCtrl(celldef,cell,txt,txtId);
            break;
       }
       row.appendChild(cell);      
    }  
    body.appendChild(row);
}


OwnTable.prototype.InitCtrl = function(celldef,cell,id,popupid)
{  
   //debugger;
   var popUrl=celldef["popurl"]+"";
   var popParam=celldef["popupparam"]+"";
   var returnParam=celldef["returnparam"]+"";
   var popStyle = celldef["popstyle"]+"";
   var valString = celldef["valstring"]+"";
   var allowEmpty = celldef["notallowempty"]+"";
   var style = celldef["ctrstyle"]+"";
   var type = celldef["type"];
   var enumName = celldef["enum"];
   var ctrl; 
   var popctrl; 
   var txtvalue="";
   var popValue="";
   if(arguments.length > 4)   
   {  
      txtvalue=arguments[4];
      if(arguments[5]!=null)
      popValue = arguments[5];
   }   
   
   switch(type)
   {
     default:
       break;
     case"popup":
       //增加popup的text
       ctrl = document.createElement("<input>");
       ctrl.setAttribute("jctype","jctext");
       ctrl.type="hidden";
       ctrl.id = popupid; 
       
       cell.appendChild(ctrl);
       ctrl= new JcText(ctrl); 
       ctrl.SetValue(popValue);
       
       //增加popup span
       popctrl=document.createElement("<span>");
       popctrl.id=id;       
       popParam = popParam.replace("DefineId",popupid);
       popParam = popParam.replace("DefineName",id);       
       returnParam = returnParam.replace("DefineId",popupid);
       returnParam = returnParam.replace("DefineName",id);       
       popctrl.setAttribute("jctype","jcpopup");
       popctrl.setAttribute("PopUrl",popUrl);
       popctrl.setAttribute("PopParam",popParam);
       popctrl.setAttribute("ReturnParam",returnParam);
       popctrl.setAttribute("PopStyle",popStyle);
       popctrl.setAttribute("ReturnMode","DataList");
       popctrl.setAttribute("PopType","Url");
       popctrl.type="popup"
       popctrl.style.width="100%";
       if(valString!="")
          popctrl.setAttribute("ValString",valString);
       if(allowEmpty=="true")
          popctrl.setAttribute("NotAllowEmpty","true");        
       cell.appendChild(popctrl);  
       popctrl = new JcPopUp(popctrl);
       popctrl.SetValue(txtvalue);        
       break;
     case"jcfile":
       ctrl = document.createElement("<span>");
       ctrl.setAttribute("jctype","jcfile");
       ctrl.setAttribute("filemode","Single");
       ctrl.type ="jcfile";
       ctrl.style.width="100%";
       ctrl.id = id;
       if(valString!="")
          ctrl.setAttribute("ValString",valString);
       if(allowEmpty=="true")
          ctrl.setAttribute("NotAllowEmpty","true");  
       cell.appendChild(ctrl);
       ctrl = new JcFile(ctrl);
       ctrl.SetValue(txtvalue);  
       break;
     case"text":
       ctrl = document.createElement("<input>");
       ctrl.setAttribute("jctype","jctext");
       ctrl.style.width="100%";
       ctrl.id = id;
       if(valString!="")
          ctrl.setAttribute("ValString",valString);
       if(allowEmpty=="true")
          ctrl.setAttribute("NotAllowEmpty","true");  
       cell.appendChild(ctrl);   
       ctrl = new JcText(ctrl); 
       ctrl.SetValue(txtvalue);          
       break;
     case"select":
       ctrl = document.createElement("<select>");
       ctrl.setAttribute("jctype","jcselect");
       ctrl.id = id;
       if(valString!="")
          ctrl.setAttribute("ValString",valString);
       if(allowEmpty=="true")
          ctrl.setAttribute("NotAllowEmpty","true");
       ctrl.setAttribute("OptionList",enumName);
       ctrl.style.width="100%";
       cell.appendChild(ctrl);
       ctrl = new JcSelect(ctrl);
       ctrl.SetValue(txtvalue);  
       break;
   }          
}

OwnTable.prototype.DeleteRow=function(rowIndex)
{
    var body = this.HtmlEle.childNodes(0).childNodes(0).childNodes(1);    
    var tr =null;
    if(typeof(rowIndex)=="number")
       tr = body.childNodes(rowIndex);
    else if(rowIndex.tagName.toLowerCase()=="tr")
       tr = rowIndex;    
    else if(typeof(rowIndex).toLowerCase()=="object")
    {
       var rows = body.childNodes;
       for(var i=0; i< rows.length;i++)
       {
           if(rows[i].Record==rowIndex) 
           { 
              tr = body.childNodes(i);break;
           }           
       }       
    }
    if(tr!=null)
    {
        var item = tr.Record;
        body.removeChild(tr);      
        this.ListData.Remove(item);  
        
        //当删除行后，重新调整页面的CSS样式，列表格式出现混乱
        for(var i=0;i<body.childNodes.length;i++)
        {
            var trrow = body.childNodes(i);
            if(i%2==0)
            {
               trrow.className=this.GetSubCss("Row1"); 
               trrow.setAttribute("PreClassName",this.GetSubCss("Row1"));
            }  
            else 
            {
               trrow.className=this.GetSubCss("Row2"); 
               trrow.setAttribute("PreClassName",this.GetSubCss("Row2"));
            }  
        }       
    }   
}

OwnTable.prototype.GetNewList = function()
{
   var ele = this.HtmlEle;
   var body = ele.childNodes(0).childNodes(0).childNodes(1);
   var list = new DataList();
   for(var i=0;i<body.childNodes.length;i++)
   {
      var row = body.childNodes[i];
      var item = list.NewItem();
      for(var m=0;m<row.childNodes.length;m++)
      {   
          var td = row.childNodes[m];
          for(var k=0;k<td.childNodes.length;k++)
          {  
             var ctr = td.childNodes[k];
             if(ctr.attributes==null)
                continue;
             if(ctr.id=="selector"||ctr.getAttribute("type").toLowerCase()=="radio"||ctr.getAttribute("type").toLowerCase()=="checkbox")
                continue; 
             else if(ctr.getAttribute("type").toLowerCase()=="jcfile")  
             {
                var name = ctr.id.split("_")[0];
                item.SetAttr(name,ctr.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].value); //table/tbody/tr/td/input
             }
             else if(ctr.getAttribute("type").toLowerCase()=="popup")  
             {  
                var name = ctr.id.split("_")[0];
                item.SetAttr(name,ctr.childNodes[0].childNodes[0].childNodes[0].childNodes[0].childNodes[0].value); //table/tbody/tr/td/input
             }  
             else
             {                
                var name = ctr.id.split("_")[0];
                //为防止有多余的非自定义html标签造成xml赋值错误,增加判断
                if(name==""||name==null)
                  continue; 
                item.SetAttr(name,ctr.value);
             }     
          }
      }
      row.Record = item;
   }
   this.ListData = list;
   this._newList =list;
}


OwnTable.prototype.Validate=function()
{	
	var jcObject=new Array();
	jcObject = GetJcElements(this.HtmlEle);
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

function GetTableTr(eventele)
{	var type,ptype,pnode,node;
	pnode = eventele;
	do{	node = pnode;
		type = node.tagName.toLowerCase();
		pnode = node.parentNode;
		ptype = pnode.tagName.toLowerCase();
	}while((type != "tr" && ptype != "table" && type != "table")|| node.getAttribute("PreClassName")==null);
	if (ptype == "table" || type=="table")return null;
	return node;
}


function GetParentCmElement(eventele)
{
    var type,pnode,node;
    pnode = eventele;
    do
    {   
        node = pnode;
        if(node==document.body) return null;
        type = node.getAttribute("cmtype");
        pnode = node.parentNode;
    }while(type==null&&pnode!=null)
    if(pnode==null) return null;
    return node;
}
