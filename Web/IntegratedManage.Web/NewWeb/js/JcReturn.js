//��http://url?Prop=xxxxȡ��xxxx
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
{	if(window.opener)//�Ӵ��ڴ򿪱�ҳ��ʱ
	{	window.close();
	}else if(typeof(window.dialogArguments)=="object")//�ӶԻ���򿪱�ҳ��ʱ
	{	window.close();
	}else //���ذ�����ҳ���IFrameԪ��
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
			alert("�Ի�����������û������Ϊ�����ڵ�document����!");
		else
			win = window.dialogArguments;//���ڶԻ�����window.opener,�����ɲ�������
		*/
		if(typeof(window.dialogArguments)!="object" || typeof(window.dialogArguments.document)!="object")
			alert("�Ի�����������û������Ϊ�����ڵ�window����!");
		else
		{
			win = window.dialogArguments;//���ڶԻ�����window.opener,�����ɲ�������		
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
	{	alert("�Ҳ��������ĵ�!");
		CloseWin();
		return;
	}
	CallDoc = doc;
	CallWin = win;
}

function ReturnValue(rtnstr,notclose)
{	
	if(!CallDoc)
	{	alert("�Ҳ��������ĵ�!");
		CloseWin();
		return;
	}
	var onPopAfter=CallWin.GetEval(OnPopAfter);//��ûص�����;
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
		alert("ָ�����ط�������!")
	}
	else if(onPopAfter)
		onPopAfter(CallElementId,rtnstr);//�ص�����onPopAfter(id,rtnvalue)
	
	else if(ele)
	{	if(ele.Co)//����Jcϵ��Ԫ��input type=text jctype='jcpopup'
		{	if(!ele.Co.SetReturn)
			{	
				if(ele.Co.SetValue)
					ele.Co.SetValue(rtnstr);
				else
					alert("ָ������Ԫ��û��ʵ��SetReturn(str)�ӿ�!")
			}
			else
				ele.Co.SetReturn(rtnstr);
		}
		else
			ele.value=rtnstr;//����һ��Ԫ����input type=text
	}
	
	if(!notclose)
		CloseWin();
}

function InitReturn()
{
	CallElementId=GetQueryString("CallElementId");
	OnPopAfter=GetQueryString("OnPopAfter");
	//edit by shawn for ��������,�ı䴫�ݷ�ʽΪ���� 2007-9-13
	PopParam=new StringParam(GetQueryString("PopParam"));
	//if(window.opener)
	//	PopParam=new StringParam(window.opener._popParam);
		
	//if(!CallElementId&&!OnPopAfter)
	//{	alert("��ָ�����ط���!")
	//	CloseWin();
	//}
	SetCallDoc();
}
