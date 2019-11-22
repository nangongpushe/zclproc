<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<HTML>
<head>
<meta http-equiv="Content-Type"
		content="application/ms-excel; charset=utf-8">
</head>
	<BODY class="body_MarginLR10px" style="margin-right:1px;">	
	
		<TABLE id="box01" cellSpacing="0" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
		<tr>
            <td colspan="20" style="border-bottom-style:none" >
            <li style="text-align:center;">浙江省粮食局直属粮油储备库</li>
            <li style="text-align:center;font-size:25px">粮油质量检测报告</li>
            </td>
     	</tr>
     	<tr>
     	<td colspan="10" style="border-right-style:none;border-left-style:none;border-top-style:none;">检测单位(盖章)</td>
     	<td colspan="10" style="border-right-style:none;border-left-style:none;border-top-style:none;text-align:right;">NO:${entity.sampleNo }</td>
     	</tr>
			<!-- 表格内容 start -->
            <tbody>
            
     
     
            <tr>
                <td   colspan="5" class="text-right" ><span class="red"></span><b>样品名称:</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:@">${entity.sampleName }</td>
                <td   colspan="5" class="text-right" ><span class="red"></span><b>仓号:</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:@">${entity.storeEncode }</td>
                
            </tr>
            <tr>
                <td   colspan="5" class="text-right"><span class="red"></span><b>储备性质:</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:@">${entity.storeNature }    </td>
                <td   colspan="5" class="text-right" ><span class="red"></span><b>入库时间:</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:yyyy年mm月">${entity.storeDate }</td>
            </tr>
            <tr>
                <td   colspan="5" class="text-right"><span class="red"></span><b>数量(吨):</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:@">${entity.quantity }</td>
                <td   colspan="5" class="text-right"><span class="red"></span><b>检测时间:</b></td>
                <td   colspan="5" style="vnd.ms-excel.numberformat:yyyy年mm月dd日">${entity.testDate }</td>
            </tr>
            <!-- 表格内容 end -->
            
            </tbody>
            </table>
             <div class="manage">
            <TABLE id="box01" cellSpacing="0" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
							<tr >
								<td   colspan="4">检测项名称</td>
								<td   colspan="4">等级</td>
								<td   colspan="4">最低指标</td>
								<td   colspan="4">检测值</td>
								<td   colspan="4">备注</td>
							</tr>
						</thead>
                <!-- 表格内容start -->
                <tbody id="Detail" class="text-center" >
                <c:forEach items="${entityItem}" var="entityItem">  
                 <tr>
                 	<c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td   colspan="4" rowspan="${entityItem.repetition }" style="vnd.ms-excel.numberformat:@">${entityItem.itemName }</td>
                 	</c:if>
	                <td   colspan="4" style="vnd.ms-excel.numberformat:@">${entityItem.grade }</td>
	                <td   colspan="4" style="vnd.ms-excel.numberformat:@">${entityItem.standard }</td>
	                <c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td   colspan="4" rowspan="${entityItem.repetition }" style="vnd.ms-excel.numberformat:@">${entityItem.result }</td>
	                </c:if>
	                <c:if test="${entityItem.count==''||entityItem.count == null }">
	                <td   colspan="4" rowspan="${entityItem.repetition }" style="vnd.ms-excel.numberformat:@">${entityItem.remark }</td>
	                </c:if>
                	 
                   </tr>
                    </c:forEach>
                </tbody>

                <!-- 表格内容 end -->
            </table>
           <table class="layui-table" id="table1">
                <tr>
                <td   style="border-style:none" colspan="5">批准:</td>
                <td   style="border-style:none" colspan="5">主管:</td>
                <td   style="border-style:none" colspan="5">审核:</td>
                <td   style="border-style:none" colspan="5">主检:</td>
                </tr>
           </table>
        </div>
		
	</BODY>
</HTML>