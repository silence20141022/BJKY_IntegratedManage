
function linkRender(val, p, rec, rowIndex, columnIndex, store) {
    var rtn = "";
    var url = "";
    switch (this.id) {
        case "State":
            val = enumType[val];
            return val;
            break;
        case "Flag":
            var title = "未开始";
            url = "green.png";
            if (rec.get("State") == "0") {
                url = "gray.png";
            }
            else if (rec.get("State") == "1" || rec.get("State") == "2") {
                url = "green.png";
                title = "正常";
                if (rec.get("State") == "1")
                    url = "gray.png";
                if (rec.get("PlanEndDate") != null && rec.get("PlanEndDate") != "" && (rec.get("FactEndDate") == null || rec.get("FactEndDate") == "") && rec.get("PlanEndDate") < new Date()) {
                    url = "red.png";
                    title = "已延期";
                }
                else if (rec.get("PlanEndDate") != null && rec.get("PlanEndDate") != "" && rec.get("FactEndDate") != null && rec.get("FactEndDate") != "" && rec.get("PlanEndDate") < rec.get("FactEndDate")) {
                    url = "red.png";
                    title = "已延期";
                }
            }
            val = "<img style='width:18px; height:18px; padding:0px; margin:0px; border:0px;' src='/images/shared/" + url + "' title='" + title + "'/>";
            return val;
            break;
        case "DutyName":
        case "TaskName":
        case "DeptName":
        case "SecondDeptNames":
        case "Code":
        case "Remark":
        case "ImportantRemark":
            val = val || "";
            p.attr = 'ext:qtitle =""' + ' ext:qtip ="' + val + '"';
            return val;
            break;
        case "TaskProgress":
            val = val == null ? "0" : val;
            rtn = "<div style='cursor:hand;width:98%;border-style:solid; border-width:1px; border-color:#8DB2E3;' onclick=\"showWin('A_ChargeProgresList.aspx','" + progressStyle + "')\"><span style='width:" + val + "%;background-color:#8DB2E3;'></span><span style='position:absolute;left:6px;'>" + val + "%</span></div>";
            break;
    }
    return rtn;
}

var progressStyle = "dialogWidth:900px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;"
function showWin(url, style, op, rec) {
    op = op || "c";
    rec = rec || grid.getSelections()[0];
    OpenModelWin(url, { op: op, TaskId: rec.id }, style, function() {
        var expnode = null; // 重新加载后需要展开的节点
        switch (op) {
            case 'c':
                if (rec && rec.json.ParentID) {
                    var pnode = store.getById(rec.json.ParentID);
                    expnode = pnode;
                    store.remove(pnode);
                    if (pnode.parentNode) {
                        store.reload({ params: { data: { ids: [pnode.id], pids: [pnode.id]}} });
                    }
                    else {
                        store.reload({ params: { data: { ids: [pnode.id]}} });
                    }
                }
                break;
            case 'cs':
            case 'u':
                store.remove(rec);
                store.reload({ params: { data: { ids: [rec.id]}} });

                if (op == 'cs') {
                    expnode = rec;
                }
                break;
        }
        if (expnode && expnode.id) {
            // 展开节点
            $.ensureExec(function() {
                var npnode = store.getById(expnode.id);
                if (npnode) {
                    store.expandNode(npnode);
                    return true;
                }

                return false;
            });
        }
        store.singleSort('SortIndex', 'ASC');
    });
}

function ViewChart() {
    var chartdata = {
        total: AimState["ChartData"] == null ? 0 : AimState["ChartData"].length,
        records: AimState["ChartData"] || []
    };

    // 表格数据源
    var cstore = new Ext.ux.data.AimJsonStore({
        dsname: 'ChartData',
        idProperty: 'TaskType',
        data: chartdata,
        fields: [
			{ name: 'DeptName' },
			{ name: 'TaskName' },
			{ name: 'CountFinish' },
			{ name: 'CountNormal' },
			{ name: 'TaskType' }
			], listeners: { "aimbeforeload": function(proxy, options) {
			    options.data = options.data || {};
			    options.data.ChartSearch = "T";
			    options.data.Year = CYear;
			    options.data.DeptName = Ext.getCmp("Department").getValue();
			}, "aimload": function(obj, response, result, arg, scope) {
			}
			}
    });
    var w = new Ext.Window({
        title: '图形分析',
        width: 700,
        height: 500,
        items: {
            xtype: 'stackedbarchart',
            type: 'stackcolumn',
            store: cstore,
            xField: 'TaskType',
            yAxis: new Ext.chart.NumericAxis({
                stackingEnabled: true
            }),
            series: [{
                yField: 'CountFinish',
                displayName: '已完成'
            }, {
                yField: 'CountNormal',
                displayName: '未完成'
}],
                listeners: {
                    itemclick: function(o) {
                        CKBEvt = false;
                        for (var item in AimState["AimType"]) {
                            Ext.getCmp("ckb" + item).setValue(false);
                        }
                        CKBEvt = true;
                        Ext.getCmp("ckb" + o.item.TaskType).setValue(true);
                        w.close();
                    }
                }
            }
        }).show();
        cstore.reload();

    }