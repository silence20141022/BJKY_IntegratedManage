

function linkRender(val, p, rec, rowIndex, columnIndex, store) {
    var rtn = "";
    var url = "";
    switch (this.id) {
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
        case "UserNames":
        case "DeptName":
        case "SecondDeptNames":
        case "Code":
        case "Remark":
        case "RootName":
        case "ImportantRemark":
            val = val || "";
            p.attr = 'ext:qtitle =""' + ' ext:qtip ="' + val + '"';
            return val;
            break;
        case "TaskProgress":
            val = val == null ? "0" : val;
            rtn = "<div style='cursor:hand;width:98%;border-style:solid; border-width:1px; border-color:#8DB2E3;' onclick=\"showWin('/Task/A_ChargeProgresList.aspx','" + progressStyle + "')\"><span style='width:" + val + "%;background-color:#8DB2E3;'></span><span style='position:absolute;left:6px;'>" + val + "%</span></div>";
            break;
        case "execute":
            return "<img src='/images/shared/arrow_turnback.gif' style='cursor:hand' onclick=\"showWin('/Task/A_ChargeProgresList.aspx','" + progressStyle + "')\"/>";
            break;
        case "Attach":
            rtn = "<a  class='aim-ui-link' href=\"javascript:showWin('/Task/A_TaskAttachmentList.aspx','" + progressStyle + "')\">相关附件</a>";
            break;
        case "WorkLog":
            rtn = "<a  class='aim-ui-link' href=\"javascript:showWin('/Task/WorkTimeFactListEdit.aspx','" + progressStyle + "')\">工作日志</a>";
            break;
        case "PubDoc":
            rtn = "<a  class='aim-ui-link' href=\"javascript:showWin('/Task/A_PubDocList.aspx','" + progressStyle + "')\">相关公文</a>";
            break;
    }
    return rtn;
}
var progressStyle = "dialogWidth:900px; dialogHeight:500px; scroll:yes; center:yes; status:no; resizable:yes;"
function showWin(url, style, op, rec) {
    op = op || "c";
    rec = rec || grid.getSelectionModel().getSelections()[0];
    OpenModelWin(url, { op: op, TaskId: rec.id }, style, function() {
    });
    store.reload();
}