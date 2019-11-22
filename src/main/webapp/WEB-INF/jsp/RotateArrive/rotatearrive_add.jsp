<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>货款管理</li>
		<li class="active">
		<c:if test="${!isEdit}">
			货款到账单新增
		</c:if>
		<c:if test="${isEdit}">
			货款到账单编辑
		</c:if>
		</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px" id="rotatearrive_add">

	<div class="layui-row title">
		<h5>货款到帐单信息</h5>
	</div>
	
	<form class="layui-form"  lay-filter="form1" enctype="multipart/form-data">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">付款人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="payer"
						autocomplete="off" placeholder="请输入付款人"
						value="${model.payer}" maxlength="20">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">付款单位:</label>
				<div class="layui-input-inline">
					<select name="payUnitId" id="payUnitSel" lay-search>
						<option value="">--请选择--</option>
						<c:forEach items="${customers}" var="custom">
							<option value="${custom.id}">${custom.clientName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>收款日期:</label>
				<div class="layui-input-inline">
					<input type="text" name="arriveDate" lay-verify="required"
						autocomplete="off" placeholder="请输入收款日期" class="layui-input"
						value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${model.arriveDate}" />">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>来款金额(元):</label>
				<div class="layui-input-inline">
					<input type="text" name="arriveAmount" 
						autocomplete="off" placeholder="请输入来款金额" class="layui-input" maxlength="15"
						value='<fmt:formatNumber value="${model.arriveAmount}" type="number" groupingUsed="false"/>' lay-verify="required|number" data-bind="event:{keyup:function(){$root.checkAmount($element);}}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">备注:</label>
				<div class="layui-input-inline">
					<textarea placeholder="最多500字符" class="layui-textarea"
						name="remark" maxlength="500">${model.remark}</textarea>
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">附件:</label>
				<div class="layui-input-inline">

						<c:choose>
							<c:when test="${model.groupId!=null and model.groupId!=''}">
							<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
								<i class="layui-icon"></i>上传
							</button>
								<span id="fileName">
									<a href="${ctx }/sysFile/download.shtml?fileId=${model.groupId}" style="margin:0 10px;">${filename.fileName}</a>
								</span>
								<%--<div id="afileName" style="display:inline-block;font-size:14px;" >
									<a href="${ctx }/sysFile/download.shtml?fileId=${model.groupId}" style="margin:0 10px;">${filename.fileName}</a>
								</div>--%>
								<div style="display:inline-block;font-size:20px;" id="openExce">
									<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filename.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
										预览
									</a>
									<a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
										预览
									</a>
								</div>
								<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" <c:if test="${!(model.groupId!=null and model.groupId!='')}"> style="display: none" </c:if> id="deleteFile" data-bind="click:function(){$root.deleteFile();}">
									删除
								</button>
							</c:when>
							<c:otherwise>
							<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="uploadFile" name="file">
								<i class="layui-icon"></i>上传
							</button>
							</c:otherwise>
						</c:choose>

				</div>
				<div class="layui-input-inline">
					<input type="text" name="groupId" readonly
						style="display: none;" id="fileId" autocomplete="off"
						class="layui-input form-control" value="${model.groupId}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">填报时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="reportDate" autocomplete="off" readonly
						value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${model.reportDate}" />'>
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">填报部门:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="reportDept" autocomplete="off" readonly
						value="${model.reportDept}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label" style="text-align:right">填报人:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="reporter" autocomplete="off" readonly
						value="${model.reporter}">
				</div>
			</div>
		</div>

		<c:if test="${isEdit}">
		<div class="layui-form-item layui-form-text">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">修改人:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="modifier" autocomplete="off"
						lay-verify="reqiured" readonly value="${model.modifier }">
				</div>
			</div>
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">修改时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="modifyDate" autocomplete="off" readonly
						lay-verify="reqiured" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${model.modifyDate}" />'>
				</div>
			</div>
		</div>
		</c:if>
		<hr class="layui-bg-green">

		<div class="layui-form-item text-center">
				<button type="button" class="layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save" data-status="1" data-msg="是否要保存数据?">保存</button>
				<button type="button" class="layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save" data-status="2" data-msg="提交后将进入审核流程，确定要提交吗?">提交</button>
				<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
		</div>
	</form>

</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotatearrive/rotatearrive_add.js"></script>
<script>
    if ("${model.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
	var isedit=${isEdit};
	var id = '${model.id}'||0;
	if(isedit){
		$('.layui-form-item [name="payUnitId"]').val("${model.payUnitId}");
	}
	var vm = new Add(isedit,id);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
	UploadFile();
</script>

<%@include file="../common/AdminFooter.jsp"%>