<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>新增基建项目</title>
<%@include file="/common.jsp"%>
<script src="${ctx }/laydate/laydate.js"></script>
</head>
<body onload="IFrameResize()">
	<div class="location">
		<span>位置：<a href="../test.shtml">测试</a> >
		</span> <span class="type"></span>
		<c:if test="${auvp=='a' }">新增</c:if>
		<c:if test="${auvp=='u' }">修改</c:if>
	</div>
	<div class="container-box">
		<form id="form" class="form_input">
			<input type="hidden" name="auvp" value="${auvp}">
			<table class="table table-bordered">
				<!-- 表格内容 start -->
				<tbody>
					<tr>
						<td class="text-right"><span class="red">*</span><b>编号：</b></td>
						<td><input type="text" id="id2" name="id" value="${test.id }"
							class="form-control validate[required]" placeholder="--请输入--" /></td>
						<td class="text-right"><span class="red"></span><b>姓名：</b></td>
						<td><input type="text" name="name" value="${test.name }"
							class="form-control" placeholder="--请输入--" /></td>
					<tr>
						<td class="text-right"><span class="red"></span><b>年龄：</b></td>
						<td><input type="text" name="age" value="${test.age }"
							class="form-control" placeholder="--请输入--" /></td>
						<td class="text-right"><span class="red"></span><b></b></td>
						<td></td>
					</tr>
					<tr>
						<td class="text-right"><span>&nbsp;&nbsp;</span><b>备注：</b></td>
						<td colspan="3"><textarea rows="4" name="note"
								class="form-control" placeholder="--请输入--" maxlength="500">${test.note }</textarea></td>
					</tr>
					<!-- 表格内容 end -->
				</tbody>
			</table>
			<p>
				备注：带有<span class="red">*</span>为必填项！
			</p>
			<p class="btn-box text-center">
				<button id="btn_save" type="button" class="btn btn-big-solid"
					onclick="save()">提交</button>
				<button type="button" class="btn btn-big-solid"
					onclick="history.go(-1)">取消</button>
			</p>
		</form>
	</div>
	<script>
$(function(){
	var auvp = '${auvp}';
	if(auvp=='v'){
		$("form").find("input,textarea").prop("readonly", true);
		$('#btn_save').hide();
	}else if(auvp='u'){
		$('#id').prop("readonly", true);
	}
	
});

function save(){
   	saveForm("form","save.shtml",function(){
   		RedirectUrl("../test.shtml");
   	})
}
</script>
</body>
</html>