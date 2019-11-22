<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css">
	#outSide{
		width:94%;
		margin-left:2%;
		padding:1%;
		background:#fff;
		border-top:2px solid #23b7e5;
	}
	
	.infoArea{
		width:100%;
		padding:20px 0;
		border-bottom: 2px solid #e2e2e2;
	}
	
	.title{
		color:RGB(25,174,136);
		font-weight:bold;
	}
	
	#infoArea{
		margin-top:20px;
		margin-left:4%;
	}
	
	#infoArea span{
		padding-right:100px;
	}
	
	.requiredData{
		color:red;
	}
	
	#mainInfo{
		margin-top:20px;
		margin-left:2.5%;
	}
	
	#mainInfo>div{
		padding:10px 0;
		width:100%;
	}
	
	#mainInfo>div span{
		width:17%;
		display:inline-block;
		text-align:left;
	}
	
	.inputArea{
		width:80%;
		padding:5px;
		outline: none;
		border:1px solid #ccc;
		resize: none;
	}
	
	.buttonArea{
		padding:5px 15px;
		background:#009688;
		border:none;
		color:#fff;
		cursor:pointer;
		display:inline;
	}
	
	#listArea{
		padding:20px 0;
		width:100%;
	}
	
	table{
		margin-top:20px;
		width:100%;
		text-align:center;
	}
	
	thead{
		background:#f2f2f2;
	}
	
	table tr td{
		width:9%;
		border:1px solid #e2e2e2;
		padding:10px 0;
	}
	
	#bottom-button{
		text-align:right;
		padding-right:20px;
		margin-top:20px;
	}
	
	#bottom-button>div{
		margin-right:10px;
	}
	
	#template-tr{
		display:none;
	}
</style>
	<div class="row clear-m">
		<ol class="breadcrumb">
			<li>基建管理</li>
			<li>工程拨款</li>
			<li class="active">
			<c:choose>
				<c:when test="${funds.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					新增
				</c:otherwise>
			</c:choose></li>
		</ol>
	</div>
	<div id="outSide">
		<div id="userInfo" class="infoArea">
			<span class="title">填报人信息</span>
			<div id="infoArea">
				<span>经办人：${funds.operator }</span> 
				<span>填报单位(盖章)：${funds.reportUnit }</span> 
					<input type="hidden" name="warehouseId" value="${funds.warehouseId }"</>
				<span>申报部门：${funds.reportDept }</span>
			</div>
		</div>
		<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">工程拨款信息</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目名称：</span>
					
					<select class="inputArea" name="projectId">
					<option value="">-请选择-</option>
					<c:forEach items="${projectList }" var="project">
						<option   value="${project.id }" <c:if test="${funds.projectId eq project.id}">selected</c:if>>${project.projectName }</option>
					</c:forEach>
					</select>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>承建单位：</span>
					<input name="contractor" class="inputArea" readonly/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
					<input name="projectUnit" class="inputArea" readonly/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目编号：</span>
					<input name="projectSerial" class="inputArea" readonly/>
					<input name="projectName" type="hidden" />
				</div>
				<div>
					<span style="text-align: right">父项目编号(名称)：</span>
					<input name="parentProjectName" class="inputArea" readonly/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>工程总投资额(万元)：</span>
					<input name="investmentTotalLittle" maxlength="20" type="number" class="inputArea" value="${funds.investmentTotalLittle }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>已预拨数(万元)：</span>
					<input name="alreadyDialed" class="inputArea" type="number"  value="${funds.alreadyDialed }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>工程进度：</span>
					<input name="process" class="inputArea" maxlength="50" value="${funds.process }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>本次申请拨款额(万元)：</span>
					<input class="inputArea" onblur="checkNumberLarge(this)" maxlength="20" type="number" name="thisAppropriationLittle" value="${funds.thisAppropriationLittle }" /> 
				</div>
			</div>
		</div>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${funds.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					保存
				</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="submit">提交</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
		</form>
	</div>
<script>
	var projectList = [];
	var alreadyDialedMap = [];
	
	<c:forEach items="${projectList}" var="item">
		projectList.push({"${item.id}":"${item.projectUnit},${item.projectSerial},${item.buildUnit},${item.projectName}<c:if test="${not empty item.parentProject}">,${item.parentProject.projectSerial}(${item.parentProject.projectName})</c:if>"});
	</c:forEach>
	<c:forEach items="${alreadyDialedMap}" var="item">
		alreadyDialedMap.push({
			"${item.key}":
				<c:choose>
					<c:when test='${item.value.status eq "已完成"}'>
						"${item.value.alreadyDialed + item.value.thisAppropriationLittle}"
					</c:when>
					<c:otherwise>
						"${item.value.alreadyDialed}"
					</c:otherwise>
				</c:choose> + ",${item.value.status}"
		});
	</c:forEach>
	
	function checkNumberLarge(target){
		if(Number($(target).val()) > Number($("input[name='investmentTotalLittle']").val())){
			layer.msg("本次拨款不能大于总投资额");
			$(target).val(0);
		}
	}
	
	var key = $("select[name='projectId']").val();
	var undefind = undefind;
	if(key!=""&&key!=undefind){
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("input[name='projectUnit']").val(data[0]);
				$("input[name='projectSerial']").val(data[1]);
				$("input[name='contractor']").val(data[2]);
				$("input[name='projectName']").val(data[3]);
                if(data.length>=5)
                    $("input[name='parentProjectName']").val(data[4]);
				break;
			}
		}
		if(${funds.id == null}){
			for(var i=0;i<alreadyDialedMap.length;i++){
				if(alreadyDialedMap[i][key] != undefind){
					var data = alreadyDialedMap[i][key].split(",");
					if(data[1] == '' || data[1] == '已完成' || $("#save").html().indexOf("编辑")!=-1){
						$("input[name='alreadyDialed']").val(data[0] == ''?0:data[0]);
						
					}else{
						$("input[name='alreadyDialed']").val("");
						
						layer.msg("当前项目还有未通过审核的请求，无法新增拨款请求！",{icon:0});
					}
				}
			}
		}
	}
	
	
	$("select[name='projectId']").change(function(){

		var key = $(this).val();
		

		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind) {
                var data = projectList[i][key].split(",");
                $("input[name='projectUnit']").val(data[0]);
                $("input[name='projectSerial']").val(data[1]);
                $("input[name='contractor']").val(data[2]);
                $("input[name='projectName']").val(data[3]);
      
                if (data.length >= 5) {
                    $("input[name='parentProjectName']").val(data[4]);
                } else {
                	$("input[name='parentProjectName']").val("");
            	}
            	break;
			}
		}
		for(var i=0;i<alreadyDialedMap.length;i++){
			if(alreadyDialedMap[i][key] != undefind){
				var data = alreadyDialedMap[i][key].split(",");
				if(data[1] == '' || data[1] == '已完成' || $("#save").html().indexOf("编辑")!=-1){
					$("input[name='alreadyDialed']").val(data[0] == ''?0:data[0]);
					$("#save").show();
					$("#submit").show();
				}else{
					$("input[name='alreadyDialed']").val("");
					$("#save").hide();
					$("#submit").hide();
					layer.msg("当前项目还有未通过审核的请求，无法新增拨款请求！",{icon:0});
				}
			}
		}
	});
	
	$("#save,#submit").click(function(){
		var patchAll = true;
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});
		if(!patchAll)
			return;
		layer.load();
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"status":"待提交"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Funds/View.shtml?identity=${ident}";
						});
					}else{
						layer.msg("信息保存失败",{icon:2})
					}
                    layer.closeAll();
				}
				,error:function () {
                    layer.closeAll();
                    layer.msg("信息保存失败",{icon:2})
                }
			});
		}else if($(this).html().indexOf('提交')!=-1){
			var way = $("#save").html().indexOf("保存")!=-1 ? "Add.shtml" : "Edit.shtml";
			$("form").ajaxSubmit({
				url:way,
				type:"post",
				data:{
					"status":"审核中",
					"id":"${funds.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息提交成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Funds/View.shtml?identity=${ident}";
						});
					}else{
						layer.msg("信息提交失败",{icon:2})
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"id":"${funds.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Funds/View.shtml?identity=${ident}";
						});
					}else{
						layer.msg("信息保存失败",{icon:2})
					}
				}
			});
		}else{
			return false;
		}
	});
	
	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/Construction/Funds/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>