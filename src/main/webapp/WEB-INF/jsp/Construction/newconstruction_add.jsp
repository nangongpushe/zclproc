<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css">
#outSide {
	width: 94%;
	margin-left: 2%;
	padding: 1%;
	background: #fff;
	border-top: 2px solid #23b7e5;
}

.infoArea {
	width: 100%;
	padding: 20px 0;
	border-bottom: 2px solid #e2e2e2;
}

.title {
	color: #23b7e5;
	font-weight: bold;
}

#infoArea {
	margin-top: 20px;
	margin-left: 4%;
}

#infoArea span {
	padding-right: 100px;
}

.requiredData {
	color: red;
}

#mainInfo {
	margin-top: 20px;
	margin-left: 2.5%;
}

#mainInfo>div {
	padding: 10px 0;
	width: 100%;
}

#mainInfo>div span {
	width: 10%;
	display: inline-block;
	text-align: center;
}

.inputArea {
	width: 89%;
	padding: 5px;
	outline: none;
	border: 1px solid #ccc;
	resize: none;
}

.buttonArea {
	padding: 5px 15px;
	background: #009688;
	border: none;
	color: #fff;
	cursor: pointer;
	display: inline;
}

#listArea {
	padding: 20px 0;
	width: 100%;
}

table {
	margin-top: 20px;
	width: 100%;
	text-align: center;
}

thead {
	background: #f2f2f2;
}

table tr td {
	width: 9%;
	border: 1px solid #e2e2e2;
	padding: 10px 0;
}

#bottom-button {
	text-align: right;
	padding-right: 20px;
	margin-top: 20px;
}

#bottom-button>div {
	margin-right: 10px;
}

#template-tr {
	display: none;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li>新增基建项目</li>
		<li class="active"><c:choose>
				<c:when test="${construction.id != null }">编辑</c:when>
				<c:otherwise>新增</c:otherwise>
			</c:choose></li>
	</ol>
</div>
<div id="outSide">
	<form action="New.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">基建项目信息</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span> <input
						class="inputArea"
						name="projectUnit" value="${construction.projectUnit}" disabled="disabled" />
						<input
						type="hidden"
						name="warehouseId" value="${construction.warehouseId}"  />
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目年份：</span> <input
						class="inputArea" id="projectYear" name="projectYear"
						value="${construction.projectYear }" autocomplete="off" />
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>建筑类别：</span> <select
						class="inputArea" id="souce-plan" name="constructionType">
						<option
							<c:if test="${construction.constructionType eq '新建' }">selected</c:if>>新建</option>
						<option
							<c:if test="${construction.constructionType eq '续建' }">selected</c:if>>续建</option>
						<option
							<c:if test="${construction.constructionType eq '其他' }">selected</c:if>>其他</option>
					</select>
				</div>
				<div>
					<span style="text-align: right">
						<%--<b class="requiredData">*</b>--%>
						建筑面积(㎡)：</span> <input
						 name="constructionArea"
						value="${construction.constructionArea}" class="inputArea" onkeyup="value=value.replace(/[^\d]/g,'')" autocomplete="off" maxlength="9"/>
				</div>
				<div>
					<span style="text-align: right">
						<%--<b class="requiredData">*</b>--%>
						仓容(万吨)：</span> <input
						 name="capacity" value="<fmt:formatNumber type="number" value="${construction.capacity}" pattern="0.00" maxFractionDigits="2"/>"
						class="inputArea" onkeyup="value=value.replace(/[^\d\.]/g,'')" autocomplete="off" maxlength="9"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>立项时间：</span> <input
						class="inputArea needDateFormat" name="projectTime"
						value="${construction.projectTime }" autocomplete="off"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>文号：</span> <input
						class="inputArea" type="text" maxlength="15" value="${construction.referenceNo }"
						name="referenceNo" id="referenceNo" autocomplete="off">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目编号：</span> <input
						class="inputArea" type="text"
						value="${construction.projectSerial }" autocomplete="off" maxlength="15" id="projectSerial" name="projectSerial">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目名称：</span> <input
						class="inputArea" id="projectName" autocomplete="off" maxlength="25" onblur="checkIsSameName();" type="text" value="${construction.projectName }"
						name="projectName">
				</div>

				<div>
					<span style="text-align: right">父项目编号(名称)：</span>
					<select class="inputArea " name="parentProject.id" <c:if test="${construction.hasChildProject}">disabled="disabled"</c:if></select>
						<option value=""></option>
						<c:forEach items="${parentList}" var="project">
							<c:if test="${construction.id != project.id}">
								<option <c:if test="${construction.parentProject.id == project.id}">selected="selected"</c:if> value="${project.id}">${project.projectSerial}(${project.projectName})</option>
							</c:if>
						</c:forEach>
					</select>
				</div>

				<div>
					<span style="text-align: right"><b class="requiredData">*</b>计划投资额（万元）：</span> <input
						class="inputArea" name="plannedInvestment" autocomplete="off" onkeyup="value=value.replace(/[^\d\.]/g,'')"
						value="<c:if test="${construction.plannedInvestment > 0 }" ><fmt:formatNumber type="number" value="${construction.plannedInvestment}" pattern="0.00" maxFractionDigits="2"/></c:if>" maxlength="10"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目状态：</span> <select
						class="inputArea" name="projectStatus">
						<option
							<c:if test="${construction.projectStatus eq '前期' }">selected</c:if>>前期</option>
						<option
							<c:if test="${construction.projectStatus eq '开工建设' }">selected</c:if>>开工建设</option>
						<option
							<c:if test="${construction.projectStatus eq '已竣工' }">selected</c:if>>已竣工</option>
					</select>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>仓容类型：</span> <select
						class="inputArea" name="storageCapacity">
						<option
							<c:if test="${construction.storageCapacity eq '散装储粮' }">selected</c:if>>散装储粮</option>
						<option
							<c:if test="${construction.storageCapacity eq '包装储粮' }">selected</c:if>>包装储粮</option>
						<option
							<c:if test="${construction.storageCapacity eq '其他' }">selected</c:if>>其他</option>
						<option
							<c:if test="${construction.storageCapacity eq '无' }">selected</c:if>>无</option>
					</select>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>计划开工时间：</span> <input
						class="inputArea needDateFormat " name="plannedStartTime"
						value='${construction.plannedStartTime }' />
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>计划完工时间：</span> <input
						class="inputArea needDateFormat " name="plannedFinishTime"
						value='${construction.plannedFinishTime }' />
				</div>
				<div>
					<span style="text-align: right">图片：</span>
					<ul style="width: 80%; display: inline-block;"
						templateId="template-image" length=10 id="ul-image">
						<c:forEach items="${filesImg}" var="item">
							<li style="float: left; margin-right: 5px; line-height: 40px;">
								<div data="${item.id}" class="buttonArea file-button">
									<%--<lable>${item.fileName}</lable>--%>
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
								</div> <input type="file" accept="image/*"
											  onchange="CheckFile(this);"
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
									<%--<lable>${item.fileName}</lable>--%>
										<div id="afileName" style="display:inline-block;font-size:14px;" >
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
				<div>
					<span style="position: relative; bottom: 4em;text-align: right">备注：</span>
					<textarea rows="4" max="300" class="inputArea" style="width: 88%"
						name="remark">${construction.remark }</textarea>
				</div>
			</div>
		</div>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
				保存
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
	var laydate = layui.laydate;
	laydate.render({
		elem : "#projectYear",
		type : "year",
	});

	$(".needDateFormat").each(function() {
		laydate.render({
			elem : $(this)[0],
			type : "date",
			format : "yyyy年MM月dd日"
		});
	});

	$("input[name='projectSerial']").blur(function() {
		if ($(this).val() != '') {
			var self = this;
			$.ajax({
				type : "GET",
				url : "${ctx}/Construction/DataExits.shtml",
				data : {
					"projectSerial" : $(this).val(),
                    "id" : "${construction.id}"
				},
				success : function(data) {
					if (data.success && data.exits) {
						layer.msg("项目编号已存在", {
							icon : 0
						});
						$(self).val("");
					}
				}
			});
		}
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
	
	
	

	
	
	function checkIsSameName(){
		var projectName=$("#projectName").val();
		var projectSerial=$("#projectSerial").val();

			$.ajax({
		        type: "POST",
                url: "${ctx}/Construction/checkIsAddSameName.shtml", //请求地址
                data: {"projectName": projectName,"projectSerial":projectSerial}, //参数列表
                datatype: "json", //返回数据的格式
                success: function (data) {

                    if (data>0) {
                      layer.msg("项目名称已存在", {
							icon : 0
						});
						$(self).val("");
                    }else{
                    	
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
  
                    alert("校验异常，请联系系统管理员！");
                }
            });
}
	
	

	$(
			"input[name='plannedInvestment'],input[name='capacity'],input[name='constructionArea']")
			.blur(function() {
				if ($(this).val() != '') {
					var value = parseFloat($(this).val());
					if (value < 0) {
						layer.msg("数值不可小于0");
						$(this).val("");
					}
				}
			});

	function CheckTimeRight() {
		var time = new Date();
		var currentTime = parseInt(time.getFullYear()
				+ ""
				+ (time.getMonth().length == 1 ? "0" + time.getMonth() : time
						.getMonth())
				+ ""
				+ (time.getDate().length == 1 ? "0" + time.getDate() : time
						.getDate()));
		var projectTime = parseInt($("input[name='projectTime']").val()
				.replace(/[^0-9]/ig, ""));
		var plannedStartTime = parseInt($("input[name='plannedStartTime']")
				.val().replace(/[^0-9]/ig, ""));
		var plannedFinishTime = parseInt($("input[name='plannedFinishTime']")
				.val().replace(/[^0-9]/ig, ""));

		if (projectTime > plannedStartTime) {
			layer.msg("立项时间不能大于计划开始时间", {
				icon : 0
			});
			return false;
		} else if (plannedStartTime < currentTime) {
			layer.msg("计划开始时间不能小于当前日期", {
				icon : 0
			});
			return false;
		} else if (plannedStartTime > plannedFinishTime) {
			layer.msg("计划开始时间不能大于计划结束时间", {
				icon : 0
			});
			return false;
		}
		return true;
	}

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

	$("#save")
			.click(
					function() {
					    debugger;
						var patchAll = true;
						$(".requiredData").parent().parent().find(
								"input,select").each(function() {
							if ($(this).val() == "") {
								alert("*项为必填项,请补全相关信息");
								patchAll = false;
								return false;
							}
						});
						if (!patchAll)
							return;
						if (!CheckTimeRight())
							return;
						var undefind = undefind;
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
						layer.load();
						
						if (${construction.id == null }) {
						
						  
						  var projectName=$("#projectName").val();

							$.ajax({
						        type: "POST",
				                url: "${ctx}/Construction/checkIsAddSameName.shtml", //请求地址
				                data: {"projectName": projectName,"projectSerial":null}, //参数列表
				                datatype: "json", //返回数据的格式
				                success: function (data) {
				                    if (data>0) {
				                    
				                    if(confirm("项目名称："+projectName+" 已存在，是否继续保存？")){
				                    
				                       $("form")
										.ajaxSubmit(
												{
													type : "post",
													data : {
														"state" : "待提交",
													},
													success : function(data) {
														if (data.success) {
															layer
																	.msg(
																			"信息保存成功",
																			{
																				icon : 1
																			},
																			function() {
																				window.location.href = "${ctx}/Construction/Add/View.shtml?identity=${ident}";
																			});
														}
													}
											});
										}else{
										var index = layer.load();
										    layer.close(index);
											return false;
										}
				                    }else{
				        
				                    	$("form")
									.ajaxSubmit(
											{
												type : "post",
												data : {
													"state" : "待提交",
												},
												success : function(data) {
													if (data.success) {
														layer
																.msg(
																		"信息保存成功",
																		{
																			icon : 1
																		},
																		function() {
																			window.location.href = "${ctx}/Construction/Add/View.shtml?identity=${ident}";
																		});
													}
												}
											});
				                    }
				                },
				                error: function (XMLHttpRequest, textStatus, errorThrown) {
				  
				                    alert("校验异常，请联系系统管理员！");
				                }
				            });
						  
						  
						
							
						} else if (${construction.id != null }) {
						
						
							var projectName=$("#projectName").val();
							var	projectSerial=$("#projectSerial").val();
							$.ajax({
						        type: "POST",
				                url: "${ctx}/Construction/checkIsAddSameName.shtml", //请求地址
				                data: {"projectName": projectName,"projectSerial":projectSerial}, //参数列表
				                datatype: "json", //返回数据的格式
				                success: function (data) {
				
				                    if (data>0) {
				                      if(confirm("项目名称："+projectName+" 已存在，是否继续保存？")){
				                      	  $("form")
											.ajaxSubmit(
												{
													url : "Edit.shtml",
													type : "post",
													data : {
														"id" : "${construction.id }",
														"imageIds" : JSON
																.stringify(imageIds),
														"fileIds" : JSON
																.stringify(fileIds)
													},
													success : function(data) {
														if (data.success) {
															layer
																.msg(
																		"信息保存成功",
																		{
																			icon : 1
																		},
																		function() {
																			window.location.href = "${ctx}/Construction/Add/View.shtml?identity=${ident}";
																		})
													}
												}
											});
				                      }else{
				                      	var index = layer.load();
										    layer.close(index);
				                      	  return false;
				                      }
				                    }else{
				                    	$("form")
									.ajaxSubmit(
											{
												url : "Edit.shtml",
												type : "post",
												data : {
													"id" : "${construction.id }",
													"imageIds" : JSON
															.stringify(imageIds),
													"fileIds" : JSON
															.stringify(fileIds)
												},
												success : function(data) {
													if (data.success) {
														layer
																.msg(
																		"信息保存成功",
																		{
																			icon : 1
																		},
																		function() {
																			window.location.href = "${ctx}/Construction/Add/View.shtml?identity=${ident}";
																		})
													}
												}
											});
				                    }
				                },
				                error: function (XMLHttpRequest, textStatus, errorThrown) {
				  
				                    alert("校验异常，请联系系统管理员！");
				                }
				            });

						} 
					});

	$("#cancel")
			.click(
					function() {
						layer
								.confirm(
										'你确定要放弃编辑吗？',
										{
											btn : [ '是', '否' ]
										},
										function() {
											window.location.href = "${ctx}/Construction/Add/View.shtml?identity=${ident}";
										}, function() {

										});
					});
</script>
<%@ include file="../common/AdminFooter.jsp"%>