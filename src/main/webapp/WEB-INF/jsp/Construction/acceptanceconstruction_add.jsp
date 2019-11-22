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
</style>
	<div class="row clear-m">
		<ol class="breadcrumb">
			<li>基建管理</li>
			<li>工程验收</li>
			<li class="active">
			<c:choose>
				<c:when test="${acceptance.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					新增
				</c:otherwise>
			</c:choose>
			</li>
		</ol>
	</div>
	<div id="outSide">
		<div id="userInfo" class="infoArea">
			<span class="title">填报人信息</span>
			<div id="infoArea">
				<span>经办人：${acceptance.operator }</span> 
				<span>经办时间：<fmt:formatDate value="${acceptance.handleTime }" pattern="yyyy年MM月dd日"/> </span>
				<span>经办部门：${acceptance.department }</span>
			</div>
		</div>
		<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">验收信息</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
					<%--<input class="inputArea" name="projectUnit" value="${acceptance.projectUnit }"/>--%>
					<c:if test="${defaultProjectUnit != null && defaultProjectUnit != ''}">
					  <input type="text" name="projectUnit" value="${defaultProjectUnit}" readonly class="inputArea"/>
					<input type="hidden" name="warehouseId" value="${warehouseId }"/>
					</c:if>
					<c:if test="${defaultProjectUnit == null || defaultProjectUnit == ''}">
						<select name="projectUnit"class="inputArea" id="souce-plan" lay-verify="required" lay-filter="encode" onchange="changeProjectUnitListener(this.value);">
							<option value="">请选择</option>
							<c:forEach items="${projectUnitList }" var="item">
								<option value="${item.warehouseShort }" <c:if test = "${acceptance.projectUnit eq item.warehouseShort }">selected</c:if>>${item.warehouseShort }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目名称：</span>
					<select class="inputArea" name="projectName">
					<option value="">请选择</option>
					<c:forEach items="${projectList}" var="project">
						<option tag="${project.projectUnit }" <c:if test="${acceptance.projectName eq project.projectName}">selected</c:if>>${project.projectName }</option>
					</c:forEach>
					</select>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目编号：</span>
					<span name="projectSerial" style="padding:0;text-align:left;"></span>
					<input type="hidden" name="projectId" />
				</div>
				<div>
					<span style="text-align: right">父项目编号：</span>
					<span name="parentProject" style="padding:0;text-align:left;"></span>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目年份：</span>
					<span name="projectYear" style="padding:0;text-align:left;"></span>
				</div>
				<div>
					<span style="text-align: right">图片：</span>
					<ul style="width: 80%; display: inline-block;"
						templateId="template-image" length=10 id="ul-image">
						<c:forEach items="${filesImg}" var="item">
							<li style="float: left; margin-right: 5px; line-height: 40px;">
								<div data="${item.id}" class="buttonArea file-button">
									<div id="afileName" style="display:inline-block;font-size:14px;" >
										<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}" style="margin:0 10px;">${item.fileName}</a>
									</div>
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
									<i class="layui-icon">&#x1006;</i>
								</div> <input type="file" accept="image/*" onchange="CheckFile(this);"
								style="display: none;" class="file-input" name="imageFile" />
							</li>
						</c:forEach>
						<c:if test="${fn:length(filesImg) < 10 }">
							<li style="float: left; margin-right: 5px; line-height: 40px;">
								<div data="" class="buttonArea file-button">
									<lable class="toUpload">添加图片</lable>
									<i class="layui-icon" style="display: none">&#x1006;</i>
								</div> <input type="file" accept="image/*" onchange="CheckFile(this);"
								style="display: none;" class="file-input" name="imageFile" />
							</li>
						</c:if>
					</ul>
				</div>
				<div>
					<span style="text-align: right">附件：</span>
					<ul style="width: 80%; display: inline-block;"
						templateId="template-file" length=5 id="ul-file">
						<c:forEach items="${files}" var="item">
							<li style="float: left; margin-right: 5px; line-height: 40px;">
								<div data="${item.id}" class="buttonArea file-button">
									<div id="" style="display:inline-block;font-size:14px;" >
										<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}" style="margin:0 10px;">${item.fileName}</a>
									</div>
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
									<i class="layui-icon">&#x1006;</i>
								</div> <input type="file" style="display: none;" class="file-input"
								name="file" />
							</li>
						</c:forEach>
						<c:if test="${fn:length(files) < 5 }">
							<li style="float: left; margin-right: 5px; line-height: 40px;">
								<div data="" class="buttonArea file-button">
									<lable class="toUpload">添加附件</lable>
									<i style="display: none" class="layui-icon">&#x1006;</i>
								</div> <input type="file" style="display: none;" class="file-input"
								name="file" />
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${acceptance.id != null }">
					编辑
				</c:when>
				<c:otherwise>
					保存
				</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
		</form>
	</div>
	
	
	<%--模板--%>
<div id="template-image" style="display: none">
	<li style="float: left; margin-right: 5px; line-height: 40px;">
		<div data="" class="buttonArea file-button">
			<lable class="toUpload">添加图片</lable>
			<i class="layui-icon" style="display: none">&#x1006;</i>
		</div> <input type="file" accept="image/*" style="display: none;"
		class="file-input" name="imageFile" />
	</li>
</div>
<div id="template-file" style="display: none">
	<li style="float: left; margin-right: 5px; line-height: 40px;">
		<div data="" class="buttonArea file-button">
			<lable class="toUpload">添加附件</lable>
			<i style="display: none" class="layui-icon">&#x1006;</i>
		</div> <input type="file" style="display: none;" class="file-input"
		name="file" />
	</li>
</div>
<script>
	var ctx = "${ctx}";
	var projectList = [];
	<c:forEach items="${projectList}" var="item">
		projectList.push({"${item.projectName}":"${item.projectSerial},${item.projectYear},${item.id}<c:if test="${not empty item.parentProject}">,${item.parentProject.projectSerial}(${item.parentProject.projectName})</c:if>"});
	</c:forEach>
	
	$(function(){
		$(".image-button").eq(0).show();
		$(".file-button").eq(0).show();
		<c:if test="${files ne null}">
		$(".file-button").each(function(){
			if($(this).css("display")!="none" && $(this).find("lable").html() == '添加附件')
				return false;
			if($(this).css("display") == "none"){
				$(this).show();
				return false;
			}
		});
		</c:if>
		<c:if test="${filesImg ne null}">
		$(".image-button").each(function(){
			if($(this).css("display")!="none" && $(this).find("lable").html() == '添加图片')
				return false;
			if($(this).css("display") == "none"){
				$(this).show();
				return false;
			}
		});
		</c:if>
	});
	
	var key = $("select[name='projectName']").val();
	var undefind = undefined;
	if(key!=""&&key!=undefind){
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
				if(data.length>=4){
                    $("span[name='parentProject']").html(data[3]);
                }
				break;
			}
		}
	}
	
	$("select[name='projectName']").change(function(){
		var key = $(this).val();
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
                if(data.length>=4){
                    $("span[name='parentProject']").html(data[3]);
                }else{
                    $("span[name='parentProject']").html("");
				}
				break;
			}
		}
	});
	
	$(document).on("click", ".file-button>lable", function() {
		$(this).parent().next().click();
	});

	//上传图片
	$(document).on("change", ".file-input", function() {
		var filename = $(this).val().split("\\");
		if (filename != "") {
			$(this).parent().find('lable').html(filename[filename.length - 1]);
			$(this).parent().find('lable').removeClass("toUpload");
			$(this).parent().find('i').show();
			var length = $(this).parent().parent().attr('length'); //限制数
			var fileLength = $(this).parent().parent().children('li').length; //已有数
			if (fileLength < length) {
				var templateId = $(this).parent().parent().attr('templateId');
				$(this).parent().parent().append($('#' + templateId).html());
			}
		}
	});

	//删除图片
	$(document)
			.on(
					"click",
					".file-button>i",
					function() {
						if ($(this).parent().parent().parent()
								.find('.toUpload').length == 0) {
							var templateId = $(this).parent().parent().parent()
									.attr('templateId');
							$(this).parent().parent().parent().append(
									$('#' + templateId).html());
						}
						$(this).parent().parent().remove();
					});

	var key = $("select[name='projectName']").val();
	var undefind = undefined;
	if(key!=""&&key!=undefind){
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
				break;
			}
		}
	}
	
	$("select[name='projectName']").change(function(){
		var key = $(this).val();
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
				break;
			}
		}
	});
	
	$("#save").click(function(){
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
			
		var undefind = undefined;
						var fileIds = [];
						var imageIds = [];
						$("#ul-image .file-button").each(
								function() {
									if ($(this).attr("data") != undefind
											&& $(this).attr("data") != "")
										imageIds.push($(this).attr("data"))
								});
						$("#ul-file .file-button").each(
								function() {
									if ($(this).attr("data") != undefind
											&& $(this).attr("data") != "")
										fileIds.push($(this).attr("data"))
								});	
			
			
		$("[name='projectUnit']").removeAttr("disabled");
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"dataType":"工程验收",
					"projectSerial":$("span[name='projectSerial']").html(),
					"projectYear":$("span[name='projectYear']").html(),
					"imageIds" : JSON.stringify(imageIds),
					 "fileIds" : JSON.stringify(fileIds),
					"projectId":$("span[name='projectId']").html()
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Acceptance/View.shtml?identity=${ident}";
						})
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"dataType":"工程验收",
					"projectSerial":$("span[name='projectSerial']").html(),
					"projectYear":$("span[name='projectYear']").html(),
					"id":"${acceptance.id }",
					"imageIds" : JSON.stringify(imageIds),
					 "fileIds" : JSON.stringify(fileIds),
					"projectId":$("span[name='projectId']").html()
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Acceptance/View.shtml?identity=${ident}";
						})
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
		  	window.location.href = "${ctx}/Construction/Acceptance/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});

	function changeProjectUnitListener(projectUnitVal){
        $("span[name='projectSerial']").text("");
        $("span[name='projectYear']").text("");
		$("input[name='projectId']").val("");
	    var urlStr = ctx+"/Construction/Acceptance/getConstructionProject.shtml";
		$.ajax({
            type : "POST",
            url : urlStr,
			data : {projectUnit:projectUnitVal},
			dataType : "json",
			success : function(data){
                if(data != null){
                    var selectEle = $("select[name='projectName']");
                    selectEle.empty();//清空下拉框
					selectEle.append(new Option("请选择",""));
                    for(var i = 0; i<data.length;i++){
						var opt = new Option(data[i].projectName,data[i].projectName);
						selectEle.append(opt);
                    }
				}
			},
			error : function(xhr,status,err){
				layer.msg("报错啦~",{icon:2,time:2000});
			}
        });
	}
</script>
<%@ include file="../common/AdminFooter.jsp" %>