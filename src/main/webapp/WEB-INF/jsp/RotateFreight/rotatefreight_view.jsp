<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>


<style>
	table#view td{
	width:100px;
	}
</style>

<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>运费方案名称:</span> <span>${model.freightName}</span>
		</div>
		<div class="layui-col-md3">
			<span>招标单位:</span> <span>${model.inviteUnit}</span>
		</div>
		<div class="layui-col-md3">
			<span>招标时间:</span> <span><fmt:formatDate value="${model.inviteTime}" pattern="yyyy-MM-dd"/></span>
		</div>
		<div class="layui-col-md3">
			<c:if test="${model.groupId==null or model.groupId=='' }">
				<span>方案文件:</span> <span>暂无文件</span>
			</c:if>
			<c:if test="${model.groupId ne null and model.groupId ne '' }">
				<%--<span>方案文件:</span>--%>
				<span>方案文件<a  href="../sysFile/download.shtml?fileId=${model.groupId}" style="color: #0000FF; margin-left: 20px">${myFile.fileName}</a></span>
				<div style="display:inline-block;font-size:20px;" id="openExce">
					<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
						预览
					</a>
					<a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
						预览
					</a>
				</div>

			</c:if>
		</div>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
				<tr>
					<td align="center">成交子明细号</td>
					<td align="center">轮换类型</td>
					<td align="center">标段</td>
	
					<td align="center">运输方式</td>
					<td align="center">发货地址</td>
	
					<td align="center">收货地址</td>

					<td align="center">距离(公里)</td>
					<td align="center">计划数量(吨)</td>
					<td align="center">附件</td>
					<td>备注</td>
					<c:if test="${view_type=='invite' }">
						<td align="center">中标单位</td>
						<td align="center">报价(元/吨)</td>
					</c:if>
				</tr>


		</thead>
		<tbody>

				<c:forEach items="${model.freightDetails}" var="item"
					varStatus="status">
					<tr>
						<td align="left">${item.dealSerial}</td>
						<td align="left">${item.inviteType}</td>
						<td align="left">${item.tenders}</td>
						<td align="left">${item.shipType}</td>
						<td align="left">${item.deliveryAddress}</td>

						<td align="left">${item.receiveAddress}</td>

						<td align="right">${item.distance}</td>
						<td align="right">${item.planNumber}</td>
						<c:if test="${item.groupId==null or item.groupId=='' }">
							<td align="left">暂无附件</td>
						</c:if>
						<c:if test="${item.groupId ne null and item.groupId ne '' }">
							<td align="left"><a href="../sysFile/download.shtml?fileId=${item.groupId}" style="color: #0000FF; margin-left: 20px">点击下载</a></td>
						</c:if>
						<td align="left">${item.remark}</td>
						<c:if test="${view_type=='invite' }">
                            <c:forEach items="${customers}" var="customers">
                                <c:choose>
                                    <c:when test="${customers.id==item.clientId}">
                                        <td align="left">${customers.clientName}</td>
                                    </c:when>
                                </c:choose>
                            </c:forEach>

							<%--<td align="left">${item.clientName }</td>--%>
							<td align="right">${item.price }</td>
						</c:if>
					</tr>
				</c:forEach>

		</tbody>
	</table>

</div>



<script>
    if ("${model.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>