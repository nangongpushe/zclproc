
	<%@ page language="java" contentType="text/html; charset=UTF-8"
			 pageEncoding="UTF-8"%>

	<%@ include file="../common/AdminHeader.jsp"%>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<jsp:useBean id="sysDate" class="java.util.Date" scope="page"/>
	<c:set var="ctx" value="${pageContext.request.contextPath}" />

	<div class="row clear-m"  style="top: 40px!important;">
		<ol class="breadcrumb">
			<li>代储监管</li>
			<li><a href="${ctx }/StoreSupervise.shtml">分片监管</a></li>
			<li class="active">分片监管信息</li>
		</ol>
	</div>

	<div class="container-box clearfix" style="padding: 10px">
	<div id="search_model">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">企业名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="enterpriseName" id="enterpriseName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">企业编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="enterpriseSerial" id="enterpriseSerial">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">库点名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="warehouseName" id="warehouseName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">监管开始年份：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="supervise" id="supervise">
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn_model">查询</button>
			</div>
		</div>
	</div>
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${supervise.superviseName}</legend>
	</fieldset>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>计划编号：</span> <span data-field="department">${supervise.superviseSerial}</span>
		</div>
		<div class="layui-col-md4">
			<span>制定人</span> <span data-field="colletor">${supervise.creator}</span>
		</div>
		<div class="layui-col-md4">
			<span>制定人部门：</span> <span data-field="modifier">${supervise.createDept}</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>计划名称：</span> <span data-field="department">${supervise.superviseName}</span>
		</div>
		<div class="layui-col-md4">
			<span>计划年份：</span> <span data-field="colletor">${supervise.superviseYear}</span>
		</div>
		<div class="layui-col-md4">
			<span>附件：</span> <span data-field="modifier">${myFile.fileName }</span>
			<c:if test="${supervise.groupId ne null and supervise.groupId ne '' }">
			<div style="display:inline-block;font-size:20px;" id="openExce">
				<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
					预览
				</a>
				<a href="javascript:openAnnex('${supervise.groupId}')" id="openFile" style="display: none">
					预览
				</a>
			</div>
				<a href="${ctx }/sysFile/download.shtml?fileId=${supervise.groupId }" 
				class="layui-btn layui-btn-primary layui-btn-small">下载文件</a>
			</c:if>
		</div>
	</div>
		<c:if test="${supervise.detail.size()!=0}">
	<table class="layui-table" id="myTB">
		<thead>
			<tr>
				<td style="width:45px" align="center">序号</td>
				<td style="width:90px" align="center">库点名称</td>
				<td style="width:90px" align="center">企业编号</td>
				<td style="width:90px" align="center">企业名称</td>
				<td style="width:135px" align="center">统一社会信用代码</td>
				<td style="width:135px" align="center">行政区划名称</td>
				<td style="width:90px" align="center">法人代表</td>
				<td style="width:90px" align="center">联系电话</td>
				<td style="width:135px" align="center">监管开始时间</td>
				<td style="width:135px" align="center">监管结束时间</td>
			</tr>
		</thead>
		<tbody id="table_model">
		<c:forEach items="${supervise.detail}" var="item" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td name='warehouseName'  align="left">${item.warehouseName}</td>
				<td name='enterpriseSerial'  align="left">${item.enterpriseSerial}</td>
				<td name='enterpriseName'  align="left">${item.enterpriseName}</td>
				<td  align="left">${item.socialCreditCode}</td>
				<td  align="left">${item.division}</td>
				<td  align="left">${item.personIncharge}</td>
				<td  align="right">${item.telephone}</td>
				<td name='superviseStart'  align="center"><fmt:formatDate value="${item.superviseStart}" pattern="yyyy-MM-dd"/></td>
				<td name='superviseEnd' align="center"><fmt:formatDate value="${item.superviseEnd}" pattern="yyyy-MM-dd"/></td>
			</tr>
		</c:forEach>
		<tbody id="table_model2">
	
			<tr>
				<td colspan="10" align="center">
						暂无数据
				</td>
			</tr>

		</tbody>
	</table>
		</c:if>
	   <p class="btn-box text-center">
    	<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
        
            
      </p>
</div>
<script>
    if ("${supervise.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
$("#table_model2 tr").hide();
	layui.laydate.render({
		elem:"#supervise",
		range: true 
	});
	
	 $(".reback").click(function(){
			history.go(-1);
		
	});
	$("#page-wrapper").css("top","30px")
	$("#searchBtn_model").click(function(){
        var warehouseName = $("#search_model #warehouseName").val();
        var enterpriseSerial = $("#search_model #enterpriseSerial").val();
        var enterpriseName = $("#search_model #enterpriseName").val();
        var supervise = $("#search_model #supervise").val();
		$("#table_model2 tr").hide();
		$("#table_model tr").show();
		if($("#table_model tr").length>0){
		var isShow=true;
            $("#table_model2 tr").hide();
			$("#table_model tr").each(function(index,element){
			if($(element).find("td[name='warehouseName']").html().indexOf(warehouseName) == -1){
                debugger;
				$(element).hide();
				if (isShow){
                    $("#table_model2 tr").show();
				}

			}else if($(element).find("td[name='enterpriseSerial']").html().indexOf(enterpriseSerial) == -1){
				$(element).hide();
                if (isShow){
                    $("#table_model2 tr").show();
                }

			}else if($(element).find("td[name='enterpriseName']").html().indexOf(enterpriseName) == -1){
				$(element).hide();
                if (isShow){
                    $("#table_model2 tr").show();
                }

			}else if(supervise!=''){
				var superviseSE = supervise.split(' - ');
				var superviseStart = $(element).find("td[name='superviseStart']").html();
				var date_1 = new Date();
				date_1.setFullYear(superviseSE[0].split('-')[0]);
				date_1.setMonth(superviseSE[0].split('-')[1]);
				date_1.setDate(superviseSE[0].split('-')[2]);
				var date_2 = new Date();
				date_2.setFullYear(superviseSE[1].split('-')[0]);
				date_2.setMonth(superviseSE[1].split('-')[1]);
				date_2.setDate(superviseSE[1].split('-')[2]);
				var date_3 = new Date();
				date_3.setFullYear(superviseStart.split('-')[0]);
				date_3.setMonth(superviseStart.split('-')[1]);
				date_3.setDate(superviseStart.split('-')[2]);
				if(!(date_1<=date_3&&date_2>=date_3)){
					$(element).hide();
					$("#table_model2 tr").show();
				}
			}else{
				isShow=false;
			}
		});
		}else{
			$("#table_model2 tr").show();
		}
		
		
	});
</script>
