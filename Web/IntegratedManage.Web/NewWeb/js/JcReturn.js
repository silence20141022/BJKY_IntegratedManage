//从http://url?Prop=xxxx取出xxxx
var CallElementId=null,CallDoc=null,CallWin=null,PopParam=null;
function GetQueryString( prop ) 
{	var re = new RegExp( prop + "=([^\\&]*)", "i" );
	var a = re.exec( document.location.search );
	if ( a == null )return null;
	return a[1];
}

function GetPopParam(name)
{
	return PopParam.Get(name);
}

function CloseWin()
{	if(window.opener)//从窗口打开本页面时
	{	window.close();
	}else if(typeof(window.dialogArguments)=="object")//从对话框打开本页面时
	{	window.close();
	}else //隐藏包含本页面的IFrame元素
	{	var frms=window.parent.frames;
		for(var i=0;i<frms.length;i++)
		{	if(window.document == frms[i].document)
			{	frms[i].frameElement.style.display="none";
				break;
			}
		}
	}
}

function SetCallDoc()
{	
	
	var doc=null,win=null;
	if(window.opener)
	{	doc = window.opener.document;
		win = window.opener;
	}else if(window.dialogHeight)
	{	
		/*
		if(typeof(window.dialogArguments)!="object" || typeof(window.dialogArguments.body)!="object")
			alert("对话框的输入参数没有设置为父窗口的document对象!");
		else
			win = window.dialogArguments;//由于对话框无window.opener,所以由参数传入
		*/
		if(typeof(window.dialogArguments)!="object" || typeof(window.dialogArguments.document)!="object")
			alert("对话框的输入参数没有设置为父窗口的window对象!");
		else
		{
			win = window.dialogArguments;//由于对话框无window.opener,所以由参数传入		
			doc=win.document;	
		}	
	}
	else if(window.parent == window)
	{	win = window;
		doc = window.document;
	}else
	{	win = window.parent;
		doc = window.parent.document;
	}	
	if(doc==null)
	{	alert("找不到返回文档!");
		CloseWin();
		return;
	}
	CallDoc = doc;
	CallWin = win;
}

function ReturnValue(rtnstr,notclose)
{	
	if(!CallDoc)
	{	alert("找不到返回文档!");
		CloseWin();
		return;
	}
	var onPopAfter=CallWin.GetEval(OnPopAfter);//获得回调方法;
	var ele = CallDoc.all(CallElementId);
	if(!onPopAfter&&!ele)
	{	
	    if(typeof(window.dialogArguments)=="object")
	    {
		    var HEle=window.parent.document.all(CallElementId);
		    if(HEle.getAttribute("jctype")=="JcDropDown"&&HEle.getAttribute("DropMode")=="Normal"&&HEle.getAttribute("DropType")=="List")
		    {
				var medl=new DataList(rtnstr);
				
				if(medl.GetItemCount()==1)
				{
					var dimc=medl.GetItem(0);
					
					var ValueStr=dimc.GetAttr("Value");
					var TextStr=dimc.GetAttr("Text");

					var ReturnParamstr=HEle.getAttribute("ReturnParam");
					
					var spc=new StringParam(ReturnParamstr);
					
					for(var ik=0;ik<spc.GetCount();ik++)
					{
						window.parent.Co[spc.Keys[ik]].SetValue(dimc.GetAttr(spc.Values[ik]));
					}
					//this.DropFrame
					if(window.parent.Co[CallElementId])
					{
						window.parent.Co[CallElementId].DropFrame.style.display="none";
					}
					return true;
				}
		    }
			
	    }
		alert("指定返回方法错误!")
	}
	else if(onPopAfter)
		onPopAfter(CallElementId,rtnstr);//回调方法onPopAfter(id,rtnvalue)
	
	else if(ele)
	{	if(ele.Co)//属于Jc系列元素input type=text jctype='jcpopup'
		{	if(!ele.Co.SetReturn)
			{	
				if(ele.Co.SetValue)
					ele.Co.SetValue(rtnstr);
				else
					alert("指定返回元素没有实现SetReturn(str)接口!")
			}
			else
				ele.Co.SetReturn(rtnstr);
		}
		else
			ele.value=rtnstr;//属于一般元素如input type=text
	}
	
	if(!notclose)
		CloseWin();
}

function InitReturn()
{
	CallElementId=GetQueryString("CallElementId");
	OnPopAfter=GetQueryString("OnPopAfter");
	//edit by shawn for 参数过长,改变传递方式为窗口 2007-9-13
	PopParam=new StringParam(GetQueryString("PopParam"));
	//if(window.opener)
	//	PopParam=new StringParam(window.opener._popParam);
		
	//if(!CallElementId&&!OnPopAfter)
	//{	alert("请指定返回方法!")
	//	CloseWin();
	//}
	SetCallDoc();
}
