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
<%--<div class="row clear-m">--%>
	<%--<ol class="breadcrumb">--%>
		<%--<li>基建管理</li>--%>
		<%--<li>工程演示</li>--%>
		<%--<li class="active">查看</li>--%>
	<%--</ol>--%>
<%--</div>--%>
<div id="outside">
	<div id="data-view">
		<table class="layui-table">
			<tr>
				<td>
					<div>
						<span>项目单位：</span>
						<span>${info.projectUnit }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目名称：</span>
						<span>${info.projectName }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目编号：</span>
						<span>${info.projectSerial }</span>
					</div>
				</td>
				<td>
					<div>
						<span>项目年份：</span>
						<span>${info.projectYear }</span>
					</div>
				</td>
			</tr>
			<c:if test="${fn:length(files) > 0 }">
			<tr>
				<td colspan="4" style="text-align:left">
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
				<td colspan="4" style="text-align:left">
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
			<c:if test="${fn:length(filesMeets) > 0 }">
			<tr>
				<td colspan="4" style="text-align:left">
				<div style="text-align:left;">相关会议纪要</div>
				<c:forEach items="${filesMeets }" var="meet">
				<div style="width:45%;margin-right:1.5%;background:#fff;border:1px solid #ccc;display:inline-block;padding:10px;text-align:left">
					<i class="layui-icon">&#xe60a;</i>
					<span>${meet.fileName }</span>
					<a href="${ctx }/sysFile/download.shtml?fileId=${meet.id}">下载</a>
				</div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
		</table>
		
		 <p class="btn-box text-center">
              <%--<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>--%>
			<button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
            
        </p>
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
	
	    $("#cancel").click(function(){
            history.go(-1);
    });
</script>
<%@ include file="../common/AdminFooter.jsp" %>