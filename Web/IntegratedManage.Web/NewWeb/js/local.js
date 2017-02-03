Date.parse=function(str)
{	
		var parts = str.split(" ");
		var dp = parts[0].split("-");
		var dt = new Date(dp[0],dp[1],dp[2]);
		if(parts.length>1)
		{	var tt = parts[1].split(":");
			dt.setHours(parseInt(tt[0]),parseInt(tt[1]),parseInt(tt[2]));
		}
		return dt;
}
	function DrawTaskBar(tbl)
	{	
		var rows = tbl.childNodes[0].childNodes;
		var td=rows[0].childNodes[4];
		var from = Date.parse(td.getAttribute("From"));
		var to=Date.parse(td.getAttribute("To"));
		td.innerText += "("+ td.getAttribute("From")+"--"+td.getAttribute("To") +")";
		var differ=to-from;
		
		for(var i=1;i<rows.length;i++)
		{	if(rows[i].id!="PlanRow")continue;
			var tmpfrom = Date.parse(rows[i].childNodes[2].innerText);
			var tmpto = Date.parse(rows[i].childNodes[3].innerText);
			var tmpdif=tmpto-tmpfrom;
			var td=rows[i].childNodes[4];
			var len=td.childNodes[0].offsetWidth;
			var barlen=tmpdif/differ * len;
			var left = (tmpfrom-from)/differ * len;
			var tbar=document.createElement("<div id='TaskBar' class='TaskBar'>");
			tbar.style.width=barlen;
			tbar.style.left=left;
			var space="";
			for(var j=0;j<100;j++)
				space+="█";
			tbar.innerHTML="<nobr>"+space+"</nobr>";
			td.childNodes[0].appendChild(tbar);
		}
	}


	function CreateGante(ds)
	{
		var count = ds.GetNodeCount("list");
		for(var i=0;i<count;i++)
		{
			var list = ds.Lists(i);
			var div=document.createElement("<div id='"+list.GetName()+"'>");
			var titletbl= "<table class='TableNavigater' cellpadding=3 cellspacing=3>"+
							"<tr><td>"+list.GetAttr("PlanDesc")+"["+list.GetAttr("PlanDate")+"]"+
							"<Select id='ViewSelector' name='"+list.GetName()+"' onchange='ViewChange()'>"+
							"<Option selected>显示计划</Option><Option>显示所有</Option><Option>显示实际</Option></Select></td></tr></table>";
			var bodytbl= "<table id='Body_"+list.GetName()+"' class='TableList' cellspacing=0 cellpadding=0 width='100%' border=1 bordercolor='black' style='font-size:12px;border-collapse:collapse;border:solid 1 black;'>"+
							"<tr align='center' bgcolor='silver'  height=24><td width='15%'>任务名称</td><td width='8%'>负责人</td>"+
							"<td width='8%'>开始时间</td><td width='8%'>结束时间</td>"+
							"<td From='"+list.GetAttr("FromDate")+"' To='"+list.GetAttr("ToDate")+"'>图形表示</td>"+
							"<td width='128'>备注</td></tr>";
			var itemcount=list.GetItemCount();
			for(var j=0;j<itemcount;j++)
			{
				var itemhtml="<tr align='center' height=24 id='PlanRow'>";
				var item = list.GetItem(j);
				itemhtml+="<td>"+item.GetAttr("TaskName")+"</td>";
				itemhtml+="<td>"+item.GetAttr("DutyNames")+"</td>";
				itemhtml+="<td>"+item.GetAttr("PlanBegin")+"</td>";
				itemhtml+="<td>"+item.GetAttr("PlanEnd")+"</td>";
				itemhtml+="<td align=left ><div id='TaskDiv' class='TaskDiv'></div></td>";
				itemhtml+="<td width=128>"+item.GetAttr("Memo")+"</td>";
				itemhtml+="</tr>";
				itemhtml+="<tr align='center' height=24 id='FactRow' style='display:none;'>";
				itemhtml+="<td>"+item.GetAttr("TaskName")+"<br>("+item.GetAttr("FactState")+")</td>";
				itemhtml+="<td>"+item.GetAttr("DutyNames")+"</td>";
				itemhtml+="<td>"+item.GetAttr("PlanBegin")+"</td>";
				itemhtml+="<td>"+item.GetAttr("PlanEnd")+"</td>";
				itemhtml+="<td>"+item.GetAttr("Product")+"</td>";
				itemhtml+="<td width=128>"+item.GetAttr("Memo")+"</td>";
				itemhtml+="</tr>";
				bodytbl +=itemhtml;
					
			}
			bodytbl += "</table>";
			div.innerHTML = titletbl+bodytbl;
			document.body.appendChild(div);
		}
	}
	function ViewChange()
	{	var opt = event.srcElement;
		var text = opt.options[opt.selectedIndex].text;
		var plans = document.all("PlanRow");
		var facts = document.all("FactRow");
		if(text=="显示计划")
		{	plan=""; fact="none";
		}
		if(text=="显示实际")
		{	plan="none"; fact="";
		}
		if(text=="显示所有")
		{	plan=""; fact="";
		}
		for(var i=0;i<plans.length;i++)
		{	plans[i].style.display=plan;
			facts[i].style.display=fact;
		}
	}