<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
	#outside {
		width: 94%;
		margin-left: 2%;
		padding: 1%;
		background: #fff;
	}
	
	#userInfo{
		margin-left:10%;
		padding-bottom:25px;
	}
	
	#userInfo>span{
		padding-right:5%;
	}
	
	#data-view table{
		width:100%;
		text-align: left;
	}
	
	#data-view thead{
		background:#aaa;
		color:#000;
	}
	
	#data-view td{
		padding:10px 5px;
	}
	
	#data-view tbody tr:hover{
		background:#eee;
	}
	
	.buttonArea{
		padding:5px 15px;
		background:#009688;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
</style>
<div class="row clear-m">
	<%--<ol class="breadcrumb">--%>
		<%--<li>基建管理</li>--%>
		<%--<li>新增项目</li>--%>
		<%--<li class="active">查看</li>--%>
	<%--</ol>--%>
</div>
<div id="outside">
	<div id="data-view">
		<table class="layui-table">
			<tr>
				<td>
					<div>
						<span>文号：</span>
						<span>${project.referenceNo }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目编号：</span>
						<span>${project.projectSerial }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目单位：</span>
						<span>${project.projectUnit }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>项目名称：</span>
						<span>${project.projectName }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目年份：</span>
						<span>${project.projectYear }</span>
					</div>
				</td>
				<td>
					<div>
						<span>立项时间：</span>
						<span>${project.projectTime }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>计划投资额（万元）：</span>
						<span><fmt:formatNumber type="number" value="${project.plannedInvestment}" pattern="0.00" maxFractionDigits="2"/></span>
					</div>
				</td>
				<td>
					<div>
						<span>建筑类别：</span>
						<span>${project.constructionType }</span>
					</div>
				</td>
				<td>
					<div>
						<span>建筑面积(㎡)：</span>
						<span>${project.constructionArea }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>项目状态：</span>
						<span>${project.projectStatus }</span>
					</div>
				</td>
				<td>
					<div>
						<span>仓容(万吨)：</span>
						<span>${project.capacity }</span>
					</div>
				</td>
				<td>
					<div>
						<span>计划开工时间：</span>
						<span>${project.plannedStartTime }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>计划完工日期：</span>
						<span>${project.plannedFinishTime }</span>
					</div>
				</td>
				<td>
					<div>
						<span>实际投资额(万元)：</span>
						<span><fmt:formatNumber type="number" value="${project.actualInvestment}" pattern="0.00" maxFractionDigits="2"/></span>
					</div>
				</td>
				<td>
					<div>
						<span>实际开工日期：</span>
						<span>${project.actualStartTime }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>实际完工日期：</span>
						<span>${project.actualFinishTime }</span>
					</div>
				</td>
				<td>
					<div>
						<span>勘察单位：</span>
						<span>${project.reconnaissance }</span>
					</div>
				</td>
				<td>
					<div>
						<span>设计单位：</span>
						<span>${project.designUnit }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div>
						<span>施工单位：</span>
						<span>${project.buildUnit }</span>
					</div>
				</td>
				<td>
					<div>
						<span>监理单位：</span>
						<span>${project.controlUnit }</span>
					</div>
				</td>
				<td>
					<div>
						<span>联系人：</span>
						<span>${project.contactor }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div>
						<span id="hetong" class="buttonArea">合同管理</span>
						<a href="${ctx }/Construction/Change/View.shtml" class="buttonArea">项目变更</a>
						<a href="${ctx }/Construction/Schedule/View.shtml" class="buttonArea">工程进度</a>
						<a href="${ctx }/Construction/Funds/View.shtml" class="buttonArea">工程款支付</a>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div>
						<span>联系方式：</span>
						<span>${project.contactWay }</span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<div>
						<span>备注：</span>
						<span>${project.remark }</span>
					</div>
				</td>
			</tr>
			<c:if test="${fn:length(files) > 0 }">
			<tr>
				<td colspan="3" style="text-align:left">
				<div style="text-align:left;">附件</div>
				<c:forEach items="${files }" var="item">
				<div style="width:45%;margin-right:1.5%;background:#fff;border:1px solid #ccc;display:inline-block;padding:10px;text-align:left">
					<i class="layui-icon">&#xe60a;</i>
					<span>${item.fileName }</span>
					<c:forEach items="${suffixMap}" var="m">
						<c:if test="${m.key == item.id}">
							<c:choose>
								<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
									<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${item.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
										预览
									</a>
								</c:when>
								<c:otherwise>
									<a style="color: yellowgreen" href="javascript:openAnnex('${item.id}')" id="openFile">
										预览
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>

					</c:forEach>
					<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}">下载</a>
				</div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
			<c:if test="${fn:length(filesImg) > 0 }">
			<tr>
				<td colspan="3" style="text-align:left">
				<div style="text-align:left;">图片</div>
				<c:forEach items="${filesImg }" var="item">
				<div style="width:45%;margin-right:1.5%;background:#fff;border:1px solid #ccc;display:inline-block;padding:10px;text-align:left">
					<i class="layui-icon">&#xe60a;</i>
					<span>${item.fileName }</span>
					<c:forEach items="${suffixImgMap}" var="m">
						<c:if test="${m.key == item.id}">
							<c:choose>
								<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
									<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${item.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
										预览
									</a>
								</c:when>
								<c:otherwise>
									<a style="color: yellowgreen" href="javascript:openAnnex('${item.id}')" id="openFile">
										预览
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>

					</c:forEach>
					<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}">下载</a>
				</div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
			<c:if test="${fn:length(datas) > 0 }">
			<tr>
				<td colspan="3" style="text-align:left">
				<div style="text-align:left;">资料</div>
				<c:forEach items="${datas }" var="data">
				<div style="width:45%;margin-right:1.5%;background:#fff;border:1px solid #ccc;display:inline-block;padding:10px;text-align:left">
					<i class="layui-icon">&#xe60a;</i>
					<span>${data.fileName }</span>
					<c:forEach items="${suffixDatasMap}" var="m">
						<c:if test="${m.key == data.id}">
							<c:choose>
								<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
									<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${data.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
										预览
									</a>
								</c:when>
								<c:otherwise>
									<a style="color: yellowgreen" href="javascript:openAnnex('${data.id}')" id="openFile">
										预览
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>

					</c:forEach>
					<a href="${ctx }/sysFile/download.shtml?fileId=${data.id}">下载</a>
				</div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
</div>
<script>
	$("data-view .buttonArea").click(function(){
		layer.open({
			  title:false,
			  area: ['500px', '300px'],
			  type: 1,
			  content:"<textarea readonly style='width:95%;height:95%;border:none;resize:none;padding:5%'>"+$(this).next("textarea").val()+"</textarea>"
		});  
	});
	
	$("#hetong").click(function(){
		window.open("${oaUrl }oa/contract/contract-info-list.do");
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>