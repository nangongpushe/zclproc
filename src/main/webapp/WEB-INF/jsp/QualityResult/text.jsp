<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../common/AdminHeader.jsp"%>
<html>  
<head lang="en">  
    <meta charset="UTF-8">  
    <title>html 表格导出道</title>  
    <script language="JavaScript" type="text/javascript">  
        //第一种方法  
        function method1(tableid) {  
  
            var curTbl = document.getElementById(tableid);  
            var oXL = new ActiveXObject("Excel.Application");  
            var oWB = oXL.Workbooks.Add();  
            var oSheet = oWB.ActiveSheet;  
            var sel = document.body.createTextRange();  
            sel.moveToElementText(curTbl);  
            sel.select();  
            sel.execCommand("Copy");  
            oSheet.Paste();  
            oXL.Visible = true;  
  
        }  
        //第二种方法  
        function method2(tableid)  
        {  
  
            var curTbl = document.getElementById(tableid);  
            var oXL = new ActiveXObject("Excel.Application");  
            var oWB = oXL.Workbooks.Add();  
            var oSheet = oWB.ActiveSheet;  
            var Lenr = curTbl.rows.length;  
            for (i = 0; i < Lenr; i++)  
            {        var Lenc = curTbl.rows(i).cells.length;  
                for (j = 0; j < Lenc; j++)  
                {  
                    oSheet.Cells(i + 1, j + 1).value = curTbl.rows(i).cells(j).innerText;  
  
                }  
  
            }  
            oXL.Visible = true;  
        }  
        //第三种方法  
        function getXlsFromTbl(inTblId, inWindow){  
  
            try {  
                var allStr = "";  
                var curStr = "";  
                if (inTblId != null && inTblId != "" && inTblId != "null") {  
  
                    curStr = getTblData(inTblId, inWindow);  
  
                }  
                if (curStr != null) {  
                    allStr += curStr;  
                }  
  
                else {  
  
                    alert("你要导出的表不存在");  
                    return;  
                }  
                var fileName = getExcelFileName();  
                doFileExport(fileName, allStr);  
  
            }  
  
            catch(e) {  
  
                alert("导出发生异常:" + e.name + "->" + e.description + "!");  
  
            }  
  
        }  
  
        function getTblData(inTbl, inWindow) {  
  
            var rows = 0;  
            var tblDocument = document;  
            if (!!inWindow && inWindow != "") {  
  
                if (!document.all(inWindow)) {  
                    return null;  
                }  
  
                else {  
                    tblDocument = eval(inWindow).document;  
                }  
  
            }  
  
            var curTbl = tblDocument.getElementById(inTbl);  
            var outStr = "";  
            if (curTbl != null) {  
                for (var j = 0; j < curTbl.rows.length; j++) {  
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {  
  
                        if (i == 0 && rows > 0) {  
                            outStr += " t";  
                            rows -= 1;  
                        }  
  
                        outStr += curTbl.rows[j].cells[i].innerText + "t";  
                        if (curTbl.rows[j].cells[i].colSpan > 1) {  
                            for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) {  
                                outStr += " t";  
                            }  
                        }  
                        if (i == 0) {  
                            if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) {  
                                rows = curTbl.rows[j].cells[i].rowSpan - 1;  
                            }  
                        }  
                    }  
                    outStr += "rn";  
                }  
            }  
  
            else {  
                outStr = null;  
                alert(inTbl + "不存在 !");  
            }  
            return outStr;  
        }  
  
        function getExcelFileName() {  
            var d = new Date();  
            var curYear = d.getYear();  
            var curMonth = "" + (d.getMonth() + 1);  
            var curDate = "" + d.getDate();  
            var curHour = "" + d.getHours();  
            var curMinute = "" + d.getMinutes();  
            var curSecond = "" + d.getSeconds();  
            if (curMonth.length == 1) {  
                curMonth = "0" + curMonth;  
            }  
  
            if (curDate.length == 1) {  
                curDate = "0" + curDate;  
            }  
  
            if (curHour.length == 1) {  
                curHour = "0" + curHour;  
            }  
  
            if (curMinute.length == 1) {  
                curMinute = "0" + curMinute;  
            }  
  
            if (curSecond.length == 1) {  
                curSecond = "0" + curSecond;  
            }  
            var fileName = "table" + "_" + curYear + curMonth + curDate + "_"  
                    + curHour + curMinute + curSecond + ".csv";  
            return fileName;  
  
        }  
  
        function doFileExport(inName, inStr) {  
            var xlsWin = null;  
            if (!!document.all("glbHideFrm")) {  
                xlsWin = glbHideFrm;  
            }  
            else {  
                var width = 6;  
                var height = 4;  
                var openPara = "left=" + (window.screen.width / 2 - width / 2)  
                        + ",top=" + (window.screen.height / 2 - height / 2)  
                        + ",scrollbars=no,width=" + width + ",height=" + height;  
                xlsWin = window.open("", "_blank", openPara);  
            }  
            xlsWin.document.write(inStr);  
            xlsWin.document.close();  
            xlsWin.document.execCommand('Saveas', true, inName);  
            xlsWin.close();  
  
        }  
  
        //第四种  
        function method4(tableid){  
  
            var curTbl = document.getElementById(tableid);  
            var oXL;  
            try{  
                oXL = new ActiveXObject("Excel.Application"); //创建AX对象excel  
            }catch(e){  
                alert("无法启动Excel!\n\n如果您确信您的电脑中已经安装了Excel，"+"那么请调整IE的安全级别。\n\n具体操作：\n\n"+"工具 → Internet选项 → 安全 → 自定义级别 → 对没有标记为安全的ActiveX进行初始化和脚本运行 → 启用");  
                return false;  
            }  
            var oWB = oXL.Workbooks.Add(); //获取workbook对象  
            var oSheet = oWB.ActiveSheet;//激活当前sheet  
            var sel = document.body.createTextRange();  
            sel.moveToElementText(curTbl); //把表格中的内容移到TextRange中  
            sel.select(); //全选TextRange中内容  
            sel.execCommand("Copy");//复制TextRange中内容  
            oSheet.Paste();//粘贴到活动的EXCEL中  
            oXL.Visible = true; //设置excel可见属性  
            var fname = oXL.Application.GetSaveAsFilename("将table导出到excel.xls", "Excel Spreadsheets (*.xls), *.xls");  
            oWB.SaveAs(fname);  
            oWB.Close();  
            oXL.Quit();  
        }  
  
  
        //第五种方法  
        var idTmr;  
        function  getExplorer() {  
            var explorer = window.navigator.userAgent ;  
            //ie  
            if (explorer.indexOf("MSIE") >= 0) {  
                return 'ie';  
            }  
            //firefox  
            else if (explorer.indexOf("Firefox") >= 0) {  
                return 'Firefox';  
            }  
            //Chrome  
            else if(explorer.indexOf("Chrome") >= 0){  
                return 'Chrome';  
            }  
            //Opera  
            else if(explorer.indexOf("Opera") >= 0){  
                return 'Opera';  
            }  
            //Safari  
            else if(explorer.indexOf("Safari") >= 0){  
                return 'Safari';  
            }  
        }  
        function method5(tableid) {  
            if(getExplorer()=='ie')  
            {  
                var curTbl = document.getElementById(tableid);  
                var oXL = new ActiveXObject("Excel.Application");  
                var oWB = oXL.Workbooks.Add();  
                var xlsheet = oWB.Worksheets(1);  
                var sel = document.body.createTextRange();  
                sel.moveToElementText(curTbl);  
                sel.select();  
                sel.execCommand("Copy");  
                xlsheet.Paste();  
                oXL.Visible = true;  
  
                try {  
                    var fname = oXL.Application.GetSaveAsFilename("Excel.xls", "Excel Spreadsheets (*.xls), *.xls");  
                } catch (e) {  
                    print("Nested catch caught " + e);  
                } finally {  
                    oWB.SaveAs(fname);  
                    oWB.Close(savechanges = false);  
                    oXL.Quit();  
                    oXL = null;  
                    idTmr = window.setInterval("Cleanup();", 1);  
                }  
  
            }  
            else  
            {  
                tableToExcel(tableid)  
            }  
        }  
        function Cleanup() {  
            window.clearInterval(idTmr);  
            CollectGarbage();  
        }  
        var tableToExcel = (function() {  
            var uri = 'data:application/vnd.ms-excel;base64,',  
                    template = '<html><head><meta charset="UTF-8"></head><body><table>{table}</table></body></html>',  
                    base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) },  
                    format = function(s, c) {  
                        return s.replace(/{(\w+)}/g,  
                                function(m, p) { return c[p]; }) }  
            return function(table, name) {  
                if (!table.nodeType) table = document.getElementById(table)  
                var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}  
                window.location.href = uri + base64(format(template, ctx))  
            }  
        })()  
function mergeTable(tabObj,colIndex){
alert(tabObj);
            if(tabObj != null){
                var i,j;
                var intSpan;
                var strTemp;
                for(i = 1; i < tabObj.rows.length; i++){
                    intSpan = 1;
                    strTemp = tabObj.rows[i].cells[colIndex].innerText ;
                    for(j = i + 1; j < tabObj.rows.length; j++){
                        if(strTemp == tabObj.rows[j].cells[colIndex].innerText){
                            intSpan++;
                            tabObj.rows[i].cells[colIndex].rowSpan = intSpan;
                            tabObj.rows[j].cells[colIndex].style.display = "none";
                            tabObj.rows[i].cells[3].rowSpan = intSpan;
                            tabObj.rows[j].cells[3].style.display = "none";
                            tabObj.rows[i].cells[4].rowSpan = intSpan;
                            tabObj.rows[j].cells[4].style.display = "none";
                        }else{
                            break;
                        }
                    }
                    i = j - 1;
                }
            }
        }
    </script>  
</head>  
<body>  
  
<div >  
    <button type="button" onclick="method1('tableExcel')">导出Excel方法一</button>  
    <button type="button" onclick="method2('tableExcel')">导出Excel方法二</button>  
    <button type="button" onclick="getXlsFromTbl('tableExcel','myDiv')">导出Excel方法三</button>  
    <button type="button" onclick="method4('tableExcel')">导出Excel方法四</button>  
    <button type="button" onclick="method5('tableExcel')">导出Excel方法五</button> 
    <button type="button" onclick="mergeTable('tableExcel',0)">text</button>  
</div>  
<div id="myDiv">  
      <%-- <table class="table table-bordered" id="tableId">
            <!-- 表格内容 start -->
            <tbody>
            <tr>
                <td class="text-right"><span class="red"></span><b>样品名称:</b></td>
                <td>${entity.sampleName }</td>
                <td class="text-right"><span class="red"></span><b>罐号:</b></td>
                <td>${entity.oilcanSerial }</td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>储备性质:</b></td>
                <td>${entity.storeNature }
                </td>
                <td class="text-right"><span class="red"></span><b>入库时间:</b></td>
                <td>${entity.storeDate }</td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>数量(吨):</b></td>
                <td>${entity.quantity }</td>
                <td class="text-right"><span class="red"></span><b>检测时间:</b></td>
                <td>${entity.testDate }</td>
            </tr>
            <!-- 表格内容 end -->
            </tbody>
        </table> --%>
        <div class="manage">
        <body onload="mergeTable11(tableExcel,0)">
            <table class="layui-table" id="tableExcel" width="100%" border="1" cellspacing="0" cellpadding="0">
             <tbody>
            <tr>
                <td class="text-right"><span class="red"></span><b>样品名称:</b></td>
                <td>${entity.sampleName }</td>
                <td class="text-right"><span class="red"></span><b>罐号:</b></td>
                <td>${entity.oilcanSerial }</td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>储备性质:</b></td>
                <td>${entity.storeNature }
                </td>
                <td class="text-right"><span class="red"></span><b>入库时间:</b></td>
                <td>${entity.storeDate }</td>
            </tr>
            <tr>
                <td class="text-right"><span class="red"></span><b>数量(吨):</b></td>
                <td>${entity.quantity }</td>
                <td class="text-right"><span class="red"></span><b>检测时间:</b></td>
                <td>${entity.testDate }</td>
            </tr>
            <!-- 表格内容 end -->
            </tbody>
						<thead>
							<tr>
								<td>检测项名称</td>
								<td>等级</td>
								<td>最低指标</td>
								<td>检测值</td>
								<td>备注</td>
							</tr>
						</thead>
                <!-- 表格内容start -->
                <tbody id="Detail" class="text-center" >
                <c:forEach items="${entityItem}" var="entityItem">  
                 <tr>
	                <c:if test="${entityItem.itemName=='容重' }"><td style="border-right-style:none" ></td></c:if>
	                <c:if test="${entityItem.itemName!='容重' }"><td >${entityItem.itemName } </td></c:if>
	                
	                <td >${entityItem.grade }</td>
	                <td >${entityItem.standard }</td>
	                <td >${entityItem.result }</td>
	                <td >${entityItem.remark }</td>
                   </tr>
                    </c:forEach>
                </tbody>
                <!-- 表格内容 end -->
                <tr>
                <td style="border-style:none" colspan="1">批准:</td>
                <td style="border-style:none" colspan="1">主管:</td>
                <td style="border-style:none" colspan="1">审核:</td>
                <td style="border-style:none" colspan="1">主检:</td>
                </tr>
            </table>
           </body>
        </div>
        
        <p class="btn-box text-center">
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
             <button type="button" id="btnPrint"  class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
             <button type="button" id="btnExport" onclick="method5('tableExcel')" class="layui-btn layui-btn-primary layui-btn-small ">导出</button>
        </p>
  
           
     
</div>  
</body>  
</html>  