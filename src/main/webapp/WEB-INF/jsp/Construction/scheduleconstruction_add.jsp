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
	color: #23b7e5;
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
	width:10%;
	display:inline-block;
	text-align:center;
}

.inputArea{
	width:89%;
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
	
#float-alert{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}

#table-wapper{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:38.5%;
	height:200px;
} 

#table-wapper>textarea{
	margin-top:10px;
	width:99%;
}

#close-float-alert{
	position:relative;
	left:81%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li>工程进度</li>
		<li class="active">
		<c:choose>
			<c:when test="${schedule.id != null }">编辑</c:when>
			<c:otherwise>新增</c:otherwise>
		</c:choose>
		</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<span class="title">填报人信息</span>
		<div id="infoArea">
			<span>经办人：${schedule.operator }</span> 
			<span>经办时间：<fmt:formatDate value="${schedule.handleTime }" pattern="yyyy年MM月dd日"/> </span>
		</div>
	</div>
	<form action="Add.shtml" method="Post" enctype="multipart/form-data">
	<div id="dataArea" class="infoArea">
		<span class="title">工程进度信息</span>
		<div id="mainInfo">
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>年月：</span>
				<input class="inputArea" value='${schedule.yearMonth }' name="yearMonth"/>
			</div>
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
				<input class="inputArea" value='${schedule.projectUnit }' name="projectUnit" readonly/>
				<input value='${schedule.warehouseId }' name="warehouseId" type="hidden"/>
			</div>
			<div>
				<span style="text-align: right"><b class="requiredData">*</b>投资额度：</span>
				<select class="inputArea" name="investmentQuota">
					<option value="1">大于10万</option>
					<option value="0">小于10万</option>
				</select>
			</div>
		</div>
	</div>
	<div id="listArea">
		<div class="buttonArea" id="add-list">新增</div>
		<table>
			<thead>
				<tr>
					<td>项目编号</td>
					<td>序号</td>
					<td>项目名称</td>
					<td>批准投资(万元)</td>
					<td>本月完成投资(万元)</td>
					<td>累计完成投资(万元)</td>
					<td>形象进度</td>
					<td>备注</td>
					<td>操作</td>
					<%--<td>项目ID</td>--%>
				</tr>
			</thead>
			<tbody id="data-result">
				<tr id="template-tr">
					<td name="projectSerial">
						<select class="inputArea">
						<option></option>
						<c:forEach items="${projectList }" var="project">
							<option tag="${project.plannedInvestment >= 10 ?'1':'0' }">${project.projectSerial }</option>
						</c:forEach>
						</select>
					</td>
					<td name='serial'>
						<input class="inputArea" maxlength="2"/>
					</td>
					<td name='projectName'></td>
					<td name='approvedInvestment'>
						<input type="number" onblur="checkNumberformat(this)" lay-verify="number" class="inputArea" />
					</td>
					<td name='currentInvestment'>
						<input type="number" onblur="checkNumberformat(this)" lay-verify="number" class="inputArea"/>
					</td>
					<td name='accumulateInvestment'>
						<input type="number" onblur="checkNumberformat(this)" lay-verify="number" class="inputArea"/>
					</td>
					<td name='progress'>
						<input class="inputArea"/>
						<input type="hidden" name="projectId"  class="inputArea"/>
					</td>
					<td name='remark'>
						<div class="buttonArea remark">备注</div>
						<textarea style="display:none;"></textarea>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
					<%--<td><input type="hidden" name="projectId"  class="inputArea"/></td>--%>
				</tr>
				<c:forEach items="${schedule.scheduleDetail }" var="item">
				<tr class="data-tr" tag="${item.id }">
					<td name="projectSerial">
						<select class="inputArea">
						<option></option>
						<c:forEach items="${projectList }" var="project">
							<option tag="${project.plannedInvestment >= 100000 ?'1':'0' }" <c:if test="${item.projectSerial eq project.projectSerial}">selected</c:if>>${project.projectSerial }</option>
						</c:forEach>
						</select>
					</td>
					<td name="serial">
						<input class="inputArea" maxlength="2" value="${item.serial }"/>
					</td>
					<td name='projectName'>
					</td>
					<td name='approvedInvestment'>
						<input type="number"  onblur="checkNumberformat(this)" class="inputArea"  value="${item.approvedInvestment }"/>
					</td>
					<td name='currentInvestment'>
						<input type="number"  onblur="checkNumberformat(this)" class="inputArea" value="${item.currentInvestment}"/>
					</td>
					<td name='accumulateInvestment'>
						<input type="number"  onblur="checkNumberformat(this)"  class="inputArea" value="${item.accumulateInvestment}"/>
					</td>
					<td name='progress'>
						<input class="inputArea" value="${item.progress }"/>
						<input type="hidden" name="projectId"  value="${item.projectId }"  class="inputArea"/>
					</td>
					<td name='remark'>
						<div class="buttonArea remark">备注</div>
						<textarea style="display:none;">${item.remark }</textarea>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
					<%--<td><input type="text" name="projectId" value="${item.projectId }"  class="inputArea"/></td>--%>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${schedule.id != null }">编辑</c:when>
				<c:otherwise>保存</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="submit">提交</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
	</div>
	</form>
</div>
<div id="float-alert">
	<div id="table-wapper">
		<span class="title">明细备注</span>
		<i id="close-float-alert" class="layui-icon">&#x1006;</i>
		<textarea rows="4" name="data-show" maxlength="200" class="inputArea"></textarea>
		<div style="text-align:right;margin-top:10px;">
			<div class="buttonArea" id="add-tolist">确认</div>
		</div>
	</div>
</div>
<script>
	
	var projectlist = [];
	var undefind = undefind;
	
	var defaultInvestmentQuota = "${schedule.investmentQuota}";
	
	<c:forEach items="${projectList}" var="project">
		projectlist.push({"${project.projectSerial}":"${project.projectName},${project.id}"});
	</c:forEach>
	
	function checkNumberformat(target){
		if(Number(target.value) < 0){
			layer.msg("内容数字不可小于0！")
			target.value = 0;			
		}
	}
	
	$("td[name='projectSerial']").each(function(){
		var serial =  $(this).find("select").val();
		for(var i=0;i<projectlist.length;i++){
			if(projectlist[i][serial] != undefind){
				var data = projectlist[i][serial].split(",");
				$(this).parent().find("td[name='projectName']").html(data[0]);
				$(this).parent().find("input[name='projectId']").val(data[1]);
				return;
			}
		}
	});
	
	$(function(){
		$("select[name='investmentQuota']").find("option").each(function(){
			if($(this).val() == defaultInvestmentQuota){
				$(this).attr("selected","selected");
				return;
			}
		});
		var bol = $("select[name='investmentQuota']").val();
		$("td[name='projectSerial']").each(function(){
			$(this).find("select>option").each(function(){
				if($(this).attr("tag") == bol){
					$(this).show();
				}else{
					$(this).hide();
				}
			});
		});
	});
	
	$("select[name='investmentQuota']").focus(function(){
		if($(".data-tr").length>0){
			layer.msg("更改投资额度需清空明细",{icon:0});
			$(this).attr("disabled","disabled");
		}
	});
	
	$("select[name='investmentQuota']").change(function(){
		var bol = $(this).val();
		$("td[name='projectSerial']").each(function(){
			$(this).find("select>option").each(function(){
				if($(this).attr("tag") == bol){
					$(this).show();
				}else{
					$(this).hide();
				}
			});
		});
	});
	
	$("td[name='projectSerial']").change(function(){
		var serial =  $(this).find("select").val();
		for(var i=0;i<projectlist.length;i++){
			if(projectlist[i][serial] != undefind){
				var data = projectlist[i][serial].split(",");
				$(this).parent().find("td[name='projectName']").html(data[0]);
				$(this).parent().find("input[name='projectId']").val(data[1]);
				return;
			}
		}
		$(this).parent().find("td[name='projectName']").html("");
		$(this).parent().find("input[name='projectId']").val("");
	});
	
	var laydate=layui.laydate;
	laydate.render({
	  elem: "input[name='yearMonth']",
	  type: 'month',
	  format:"yyyy年MM月"
	});
    var lastClickTime = 0;
    var lastClickTime1 = 0;
    var lastClickTime2 = 0;
    var DELAY = 20000;
	$("#save,#submit").click(function(){
		var patchAll = true;
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});
		$(".data-tr").each(function(){
			if($(this).find("input").val()==""){
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});
		if(!patchAll)
			return;
		var detailData = [];
		$(".data-tr").each(function(){
			detailData.push({
				"id":$(this).attr("tag") == ""?0:$(this).attr("tag"),
				"projectSerial":$(this).find("td[name='projectSerial']").find("select").val(),
				"serial":Number($(this).find("td[name='serial']").find("input").val()),
				"projectName":$(this).find("td[name='projectName']").html(),
				"projectId":$(this).find("input[name='projectId']").val(),
				"approvedInvestment":parseFloat($(this).find("td[name='approvedInvestment']").find("input").val()),
				"currentInvestment":parseFloat($(this).find("td[name='currentInvestment']").find("input").val()),
				"accumulateInvestment":parseFloat($(this).find("td[name='accumulateInvestment']").find("input").val()),
				"progress":$(this).find("td[name='progress']").find("input").val(),
				"remark":$(this).find("td[name='remark']").find("textarea").val(),
			});
		});
		layer.load();
		if($(this).html().indexOf('保存')!=-1){
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#save").hide();
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"status":"待提交",
					"detailList":JSON.stringify(detailData)
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Schedule/View.shtml?identity=${ident}";
						});
					}else {
                        $("#save").show();
					}
				}
			});}
		}else if($(this).html().indexOf('提交')!=-1){
		
		$(".submit").attr("disabled","true");
		
			var way = $("#save").html().indexOf("保存")!=-1 ? "Add.shtml" : "Edit.shtml";
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#submit").hide();
			$("form").ajaxSubmit({
				url:way,
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData),
					"status":"审核中",
					"id":"${schedule.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息提交成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Schedule/View.shtml?identity=${ident}";
						});
					}else{
						layer.msg("信息提交失败",{icon:2})
						layer.closeAll();
                        $("#submit").show();
					}
				}
			});}
		}else if($(this).html().indexOf('编辑')!=-1){
            var currentTime = Date.parse(new Date());
            if (currentTime - lastClickTime > DELAY) {
                lastClickTime = currentTime;
                $("#save").hide();
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				data:{
					"detailList":JSON.stringify(detailData),
					"id":"${schedule.id}"
				},
				type:"post",
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Schedule/View.shtml?identity=${ident}";
						});
					}else {
                        $("#save").show();
					}
				}
			});}
		}else{
			return false;
		}
	});
	
	$("#add-list").click(function(){
		var template = $("#template-tr").clone(true);
		$(template).addClass("data-tr");
		$("#data-result").append($(template));
		$(template).show(500);
	});
	
	$(".remove-detail").click(function(){
		$(this).parent().parent().hide(500,function(){
			$(this).remove();
			if($(".data-tr").length == 0){
				$("select[name='investmentQuota']").removeAttr("disabled");
			}
		})
	});
	
	$(".remark").click(function(){
		$(this).attr("tag","true");
		var data = $(this).next("textarea").val();
		$("#table-wapper").find("textarea").val(data);
		$("#float-alert").slideToggle(500,function(){
			$("#table-wapper").slideToggle(500);			
		});
	});
	
	$("#close-float-alert").click(function(){
		$(".remark[tag='true']").removeAttr("tag");
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500);			
		});
	});
	
	$("#add-tolist").click(function(){
		var textarea = $("#table-wapper").find("textarea");
		$(".remark[tag='true']").next("textarea").val($(textarea).val());
		$(".remark[tag='true']").removeAttr("tag");
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500);			
		});
	});
	
	$("td[name='serial']>input").blur(function(){
		var target = $(this);
		var value = $(target).val();
		if(value == '')
			return;
		$(".data-tr td[name='serial']>input").each(function(){
			if(!$(this).is(target) && $(this).val() == value){
				layer.msg("明细序号不可重复",{icon:0});
				$(target).val("");
				return;
			}
		});
	});
	
	$("#cancel").click(function(){
		layer.confirm('你确定要取消吗？', {
			btn: ['确认','取消']
		}, function(){
		  	window.location.href = "${ctx}/Construction/Schedule/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>