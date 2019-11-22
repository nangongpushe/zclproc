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
			<li>项目变更</li>
			<li class="active">
			<c:choose>
				<c:when test="${change.id != null }">编辑</c:when>
				<c:otherwise>新增</c:otherwise>
			</c:choose></li>
		</ol>
	</div>
	<div id="outSide">
		<div id="userInfo" class="infoArea">
			<span class="title">填报人信息</span>
			<div id="infoArea">
				<span>经办人：${change.operator }</span> 
				<span>经办时间：<fmt:formatDate value="${change.handleTime }" pattern="yyyy年MM月dd日"/> </span>
				<span>经办部门：${change.department }</span>
			</div>
		</div>
		<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title" style="text-align: right">变更单信息</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>变更单编号：</span>
					<input name="changeSerial" class="inputArea" value="${change.changeSerial }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目名称：</span>
					<select class="inputArea" name="projectId">
					<c:forEach items="${projectList }" var="project">
						<option value="${project.id}" <c:if test="${change.projectId eq project.id}">selected</c:if>>${project.projectName }</option>
					</c:forEach>
					</select>
					<input name="projectName" type="hidden" value="${change.projectName}"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
					<input name="projectUnit" class="inputArea" readonly/>
					<input name="warehouseId" type="hidden">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目编号：</span>
					<input name="projectSerial" class="inputArea" readonly/>
				</div>
				<div>
					<span style="text-align: right">父项目编号(名称)：</span>
					<input name="parentProject" class="inputArea" disabled="disabled"/>
				</div>

				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目年份：</span>
					<input name="projectYear"  class="inputArea" readonly/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>变更日期：</span>
					<input name="changeDate"  class="inputArea" value="<fmt:formatDate value='${change.changeDate}'
            		type='date' pattern='yyyy-MM-dd'/>"/>
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
				<c:when test="${change.id != null }">
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

<%--<script type="text/html" id="colletorDateFormat">--%>
	<%--{{Date_format(d.colletorDate,true)}}--%>
<%--</script>--%>

<script>
	var projectList = [];
	<c:forEach items="${projectList}" var="item">
		projectList.push({"${item.id}":"${item.projectSerial},${item.projectYear},${item.projectUnit},${item.warehouseId},<c:if test="${not empty item.parentProject}">,${item.parentProject.projectSerial}(${item.parentProject.projectName})</c:if>"});
	</c:forEach>



        layui.laydate.render({
            elem:$('[name="changeDate"]')[0],
            type:"date",
            format:"yyyy-MM-dd",
        });
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

	var key = $("select[name='projectId']").val();
    let projectName = $("select[name='projectId']").find("option:selected").html();
    $("input[name='projectName']").val(projectName);
	var undefind = undefind;
	if(key!=""&&key!=undefind){
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("input[name='projectSerial']").val(data[0]);
				$("input[name='projectYear']").val(data[1]);
				$("input[name='projectUnit']").val(data[2]);
				$("input[name='warehouseId']").val(data[3]);
				if(data.length>=5)
				    $("input[name='parentProject']").val(data[4]);
				break;
			}
		}
	}
	
	$("select[name='projectId']").change(function(){
	    let projectName = $(this).find("option:selected").html();
	    $("input[name='projectName']").val(projectName);
		var key = $(this).val();
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("input[name='projectSerial']").val(data[0]);
				$("input[name='projectYear']").val(data[1]);
				$("input[name='projectUnit']").val(data[2]);
				$("input[name='warehouseId']").val(data[3])
                if(data.length>=5)
                    $("input[name='parentProject']").val(data[4]);
                else
                    $("input[name='parentProject']").val("");
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
	
	
	function CheckFile(obj) {
		var array = new Array('gif', 'jpeg', 'png', 'jpg'); //可以上传的文件类型 
		if (obj.value == '') {
			alert("让选择要上传的图片!");
			return false;
		} else {
			var fileContentType = obj.value.match(/^(.*)(\.)(.{1,8})$/)[3];
			var isExists = false;
			for ( var i in array) {
				if (fileContentType.toLowerCase() == array[i].toLowerCase()) {
					isExists = true;
					return true;
				}
			}
			if (isExists == false) {
				obj.value = null;
				alert("上传图片类型不正确!");
				return false;
			}
			return false;
		}
	}
	
	$(".file-image-input").change(function(){
		var filename = $(this).val().split("\\");
		if(filename != ""){
			$(".image-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
			$(".image-button").eq($(this).attr("index")).find("i").show();
			$(".image-button").each(function(){
				if($(this).css("display")!="none" && $(this).find("lable").html() == '添加图片')
					return false;
				if($(this).css("display") == "none"){
					$(this).show();
					return false;
				}
			});
		}
	});


	var  saveFlag=0;
	
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
		if(saveFlag==1){
		    return;
		}
		saveFlag =1;
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"dataType":"变更计划",
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Change/View.shtml";
						})
					}else {
					    saveFlag=0;
                    }
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"dataType":"变更计划",
					"imageIds":JSON.stringify(imageIds),
					"fileIds":JSON.stringify(fileIds),
					"id":"${change.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Change/View.shtml";
						})
					}else {
                        saveFlag=0;
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
		  	window.location.href = "${ctx}/Construction/Change/View.shtml";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>