

var system_flowParaPanel;
var mask_layer;
var sele_item;
var flow_btn;
var flowTask_Table;
var flowName_field;

function InitFlowPage(jcHtmlEle)
{
  var buttonAreaId=jcHtmlEle.ButtonAreaId;

  var flowTaskDlPath=jcHtmlEle.FlowTaskDlPath;
  
  var jcTbName=jcHtmlEle.id;
  var btnName=jcHtmlEle.FlowButtonName;
  if(btnName==null||btnName=="")
    btnName="启动流程";
  
  
  var onBeforeFlowStart=jcHtmlEle.OnBeforeFlowStart;
  flowName_field=jcHtmlEle.FlowNameField;
  system_flowParaPanel= CreateFlowTaskExecutorPanel(flowTaskDlPath);
  document.body.appendChild(system_flowParaPanel);
  
	var btn=document.createElement("<button class='jcbutton' jctype='jcbutton'>");
	btn.innerText=btnName;

   if(onBeforeFlowStart==null||onBeforeFlowStart=="")
      onBeforeFlowStart="StartFlow('"+jcTbName+"')";
      

	btn.onclick=function()
				{
				
				  sele_item = eval(onBeforeFlowStart);
				  
				  if(sele_item!=null)
				  {
				    mask_layer.style.display="";
				    mask_layer.innerText="";
				    system_flowParaPanel.style.display="";
				  }
				
				
				}
	flow_btn=btn;
	
	
	var flowTraceBtn=document.createElement("<button class='jcbutton' jctype='jcbutton'>");
	
	var tracBtnName=jcHtmlEle.FlowTraceButtonName;
	
	 if(tracBtnName==null||tracBtnName=="")
        tracBtnName="流程跟踪";
	flowTraceBtn.innerText=tracBtnName;


	flowTraceBtn.onclick=function()
				{
				  System_ShowTrainList(jcTbName);
				
				}
			
	var jcTbButtonArea=document.getElementById(buttonAreaId);
	
	var btnSpace=document.createElement("span");
	btnSpace.innerText="  ";			
	jcTbButtonArea.appendChild(btnSpace);
	jcTbButtonArea.appendChild(flowTraceBtn);
	jcTbButtonArea.appendChild(btnSpace.cloneNode(true));
	jcTbButtonArea.appendChild(btn);
	




}

function CreateFlowTaskExecutorPanel(flowTaskDlPath)
{

   var flowTaskDl=GetDsNode(flowTaskDlPath);

   	var	maskLayer=CreateMaskLayer(101);
    mask_layer=maskLayer;

	var flowTaskCount=flowTaskDl.GetItemCount();
	
	var flowParaForm=document.createElement("form");
	flowParaForm.jctype="jcform";
	flowParaForm.id="System_FlowParaForm";
	
	var flowParaPanel=document.createElement("<div style='DISPLAY: none; Z-INDEX: 201; LEFT: 30%;  POSITION: absolute; TOP: 30%'/>");
	var taskInfoTable=document.createElement("<table cellpadding=0 width=400 class='ChartParamPanel' border='0'  style='TABLE-LAYOUT: fixed;'/>");
	
	flowTask_Table=taskInfoTable;
	
	for(var i=0;i<flowTaskCount;i++)
	{
	
	var taskInfoRow=taskInfoTable.insertRow();
	var taskItem=flowTaskDl.GetItem(i);
	var taskId=taskItem.GetAttr("TaskId");
	var taskName=taskItem.GetAttr("TaskName");
	var taskUserIds=taskItem.GetAttr("UserIds");
	var taskUserNames=taskItem.GetAttr("UserNames");
	var taskUserReadOnly=taskItem.GetAttr("ReadOnly");
	var taskNameCell=taskInfoRow.insertCell();
	
	taskInfoRow.id=taskId;
	
	taskNameCell.innerText=taskName;
	
	var taskUserEleCell=taskInfoRow.insertCell();					
	var userSeleEle=document.createElement("span");
	userSeleEle.id= taskId+"_UserName";
	userSeleEle.width="90%";
	userSeleEle.jctype=	"jcpopup";
	userSeleEle.ValString="Title:"+taskName;
	userSeleEle.NotAllowEmpty=true;
	userSeleEle.ReturnParam=taskId+"_UserName:Name;"+taskId+"_UserId:Id;";	
	userSeleEle.PopParam="Name:"+taskId+"_UserName;Id:"+taskId+"_UserId;";
	userSeleEle.ReturnMode="DataList";	
	userSeleEle.PopType="Url";
	userSeleEle.ReadOnly=taskUserReadOnly;
	userSeleEle.PopUrl="/orgauth/NewMultiChooseUser.aspx";
	userSeleEle.PopStyle="width=750,height=480,scrollbars=no,resizable=no";
	userSeleEle.InitValue=taskUserNames;
	var userIdEle=document.createElement("Input");
	userIdEle.id=taskId+"_UserId";
	userIdEle.jctype="jctext";
	userIdEle.type="hidden";
	userIdEle.value=taskUserIds;
	
	taskUserEleCell.appendChild(userSeleEle);
	taskUserEleCell.appendChild(userIdEle);
			     			
	
	
	}
	var taskInfoCaption=taskInfoTable.createCaption();
	taskInfoCaption.innerText="流程环节人指定";
	taskInfoCaption.style.fontWeight="bold";
	taskInfoCaption.style.color="white";
	taskInfoCaption.style.fontSize="20px";
	taskInfoCaption.style.backgroundColor="#000";
	
	
	var taskInfoTHead=taskInfoTable.createTHead();
	var theadRow= taskInfoTHead.insertRow();
	var title1Cell=theadRow.insertCell();
	title1Cell.width="35%";
	title1Cell.innerText="流程环节";
	var title2Cell=theadRow.insertCell();
	title2Cell.innerText="环节执行人";
	taskInfoTHead.style.backgroundColor="#0099ff";
	taskInfoTHead.style.fontWeight="bold";
	taskInfoTHead.style.color="white";
	
	var  taskInfoTFoot=taskInfoTable.createTFoot();
	
	var tfootRow= taskInfoTFoot.insertRow();
	tfootRow.height="50px";
	var foot1Cell=tfootRow.insertCell();
	foot1Cell.align="center";
    foot1Cell.colSpan=2;
	
	var cancelBtn=document.createElement("button");
	cancelBtn.jctype="jcbutton";
	cancelBtn.IconType="cancel";
	cancelBtn.onclick=function(){
		
		                          if(flow_btn)
	                              flow_btn.disabled=false;	
	                              flowParaPanel.maskLayer.style.display="none";
	                              flowParaPanel.style.display="none";
	                             };
	cancelBtn.innerText="取消";
	
	var flowBtn=document.createElement("button");
	flowBtn.jctype="jcbutton";
	flowBtn.IconType="edit";
	flowBtn.onclick=function(){
	                             RealStartFlow(sele_item);	
	                          };
	                          
	flowBtn.innerText="启动流程";
	
	
	foot1Cell.appendChild(flowBtn);	
	var blankSpan=document.createElement("span");
	blankSpan.innerText="   ";
	foot1Cell.appendChild(blankSpan);
	foot1Cell.appendChild(cancelBtn);
	
	flowParaForm.appendChild(taskInfoTable);
	flowParaPanel.appendChild(flowParaForm);

   flowParaPanel.submitBtn=flowBtn;
   flowParaPanel.maskLayer=mask_layer;
   flowParaPanel.getFlowTaskExecutorDl=System_GetTaskExecutor;
	return flowParaPanel;
	

}

function StartFlow(jcTbName)
{
    
     var items=Co[jcTbName].GetSelected();
           	
	if (items.length == 0) {alert("请先选择记录");return null;}
	
	var seleItem=items[0];

	flow_btn.disabled=true;		

	if(seleItem.GetAttr("IsStartFlow")=="T")
	{ 
		alert("该条目已已启动流程，不能多次启动！！");
		flow_btn.disabled=false;

		return null; 
	}
	else
	   return seleItem;
	
			
	



}


function System_GetTaskExecutor()
{
  	   var taskExecutorTb=flowTask_Table.tBodies[0];
	   var taskExecutorDl=new DataList();
	   
	   var tExecutorTbRows=taskExecutorTb.rows;
	   var tExecutorTbRCount=tExecutorTbRows.length;
	   
	   for(var i=0;i<tExecutorTbRCount;i++)
	   {
	     var taskItem=taskExecutorDl.NewItem();
	     var seleRow=tExecutorTbRows[i];
	     
	     taskItem.SetAttr("TaskId",seleRow.id);
	     var infoCell=seleRow.cells[1];
	     var exeUserNames=infoCell.firstChild.all("_text").value;
	     var exeUserIds=infoCell.childNodes[1].value;
	     var exeNamesArray=exeUserNames.split(",");
	     var exeIdsArray=exeUserIds.split(",");
	     var exeUserCount=exeNamesArray.length;
	     var executorStr=new String();
	     for(var n=0;n<exeUserCount;n++)
	     {
	       executorStr+=exeNamesArray[n]+"("+exeIdsArray[n]+"),";
	     }
	     
	     executorStr =executorStr.substr(0,executorStr.length-1);
	     
	     taskItem.SetAttr("Executor",executorStr);
	   
	   }
	   taskExecutorDl.SetName("System_TaskExecutorDl");
   
    return taskExecutorDl;

}


	function RealStartFlow(seleItem)
	{
	
	  if(!Co["System_FlowParaForm"].Validate())
		   return false;	
	
	   
	   
	   system_flowParaPanel.style.display="none";
	   
       	mask_layer.innerText="流程启动中请稍候！";
		mask_layer.align="center";
		mask_layer.style.color="white";
		mask_layer.style.paddingTop="30%";
		mask_layer.style.fontSize="50px";
	   


		var formId=seleItem.GetAttr("Id");
		
		
		var flowName=seleItem.GetAttr(flowName_field);
		var formIdPara=new DataParam();
		formIdPara.SetName("FormId");
		formIdPara.SetValue(formId);
		
		var cNameIdPara=new DataParam();
		cNameIdPara.SetName("FlowName");
		cNameIdPara.SetValue(flowName);

				
		
		var rtn=Execute.Post("startflow",cNameIdPara,formIdPara,System_GetTaskExecutor());
		if(rtn.HasError)
		{
			flow_btn.disabled=false;
			mask_layer.style.display="none";
			rtn.ShowDebug();
		}	
		else
		{
			alert("流程启动成功！！");
		
			
			var wid=rtn.ReturnDs.GetParam("WorkItemId");
			LinkTo("/workflow/businessframe/TaskBus.aspx?WorkItemId=" + wid, "_OnlyOne", CenterWin("width=820,height=600,scrollbars=yes"));
			window.location.reload();
			
			
			
		
		}
				
	}
	
	
		function System_ShowTrainList(jcTbName)
		{
			var items=Co[jcTbName].GetSelected();
			
			var jcHtmlEle=Co[jcTbName].HtmlEle;
			
			var FlowTraceField=jcHtmlEle.FlowTraceField;

			if(FlowTraceField==null||FlowTraceField=="")
			  FlowTraceField="Id";
			

	
	
	        var BeforeFlowTrace=jcHtmlEle.BeforeFlowTrace;

			if(BeforeFlowTrace==null||BeforeFlowTrace=="")
			{
			   if(!System_JudgeCanTrace(items)) return;
			}
			else
			  if(!eval(BeforeFlowTrace)) return;    

			var RelationId = items[0].GetAttr(FlowTraceField);
			LinkTo("/workflow/businessframe/BusinessTrack.aspx?RelateId="+RelationId,"_Blank",CenterWin("width=820,height=600,scrollbars=yes"));
		}
		
		function System_JudgeCanTrace(seleItems)
		{
		  
		
		   	if(seleItems.length<=0)
			{
				alert("请选择您要进行流程跟踪条目!");return false;
			}
		
		     var seleItem =seleItems[0];
		  	if(seleItem.GetAttr("IsStartFlow")=="")
			{
				alert("该条目还未启动流程!");return false;
			}
			else
			   return true;
		
		}