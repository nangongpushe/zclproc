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
			<li>招投标</li>
			<li class="active">
			<c:choose>
				<c:when test="${bidding.id != null }">编辑</c:when>
				<c:otherwise>新增</c:otherwise>
			</c:choose></li>
		</ol>
	</div>
	<div id="outSide">
		<div id="userInfo" class="infoArea">
			<span class="title">填报人信息</span>
			<div id="infoArea">
				<span>经办人：${bidding.operator }</span> 
				<span>经办时间：<fmt:formatDate value="${bidding.handleTime }" pattern="yyyy年MM月dd日"/> </span>
				<span>经办部门：${bidding.department }</span>
			</div>
		</div>
		<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">招投标信息</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目单位：</span>
					<%--<input class="inputArea" name="projectUnit" value="${bidding.projectUnit }"/>--%>
					
					<c:if test="${defaultProjectUnit!=null&&defaultProjectUnit!='' }">
					  <input type="text" name="projectUnit" value="${defaultProjectUnit }" readonly class="inputArea"/>
					 <input type="hidden" name="warehouseId" value="${warehouseId }"/>
					</c:if>
					<c:if test="${defaultProjectUnit==null||defaultProjectUnit=='' }">
						<select name="projectUnit"class="inputArea" id="souce-plan" lay-verify="required" lay-filter="encode">
							<option value=""></option>
							<c:forEach items="${projectUnitList }" var="item">
								<option value="${item.warehouseShort }" <c:if test = "${bidding.projectUnit eq item.warehouseShort }">selected</c:if>>${item.warehouseShort }</option>
							</c:forEach>
						</select>
					</c:if>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目名称：</span>
					<select class="inputArea" name="projectName">
					<option value="">请选择</option>
					<c:forEach items="${projectList }" var="project">
						<option tag="${project.projectUnit }" <c:if test="${bidding.projectName eq project.projectName}">selected</c:if>>${project.projectName }</option>
					</c:forEach>
					</select>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目编号：</span>
					<span name="projectSerial" style="padding:0;text-align:left;"></span>
					<input type="hidden" name="projectId" />
				</div>
				
				<div>
					<span style="text-align: right"><b class="requiredData"></b>父项目编号(名称)：</span>
					<span name="parentProject" style="padding:0;text-align:left;"></span>
				</div>

				<div>
					<span style="text-align: right"><b class="requiredData">*</b>项目年份：</span>
					<span name="projectYear" style="padding:0;text-align:left;"></span>
				</div>
				<div>
					<span style="position:relative;bottom:15px;text-align: right">图片：</span>
					<ul style="width:85%;display:inline-block;" class = "image_ul">
					<c:forEach var="n" begin="0" end="9" varStatus="status">
					<li style="float:left;margin-right:5px;line-height:40px;">
					<div index="${status.index }" <c:choose><c:when test="${filesImg[status.index] == null }">style="display:none"</c:when><c:otherwise>data="${filesImg[status.index].id }"</c:otherwise></c:choose> class="buttonArea image-button"><lable>${filesImg[status.index] ne null?filesImg[status.index].fileName : '添加图片' }</lable>

						<c:forEach items="${suffixImgMap}" var="m">
							<c:if test="${m.key == filesImg[status.index].id}">
								<c:choose>
									<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${filesImg[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filesImg[status.index].downloadUrl}','width=1200px;height=800px;')" id="openExcel">
											预览
										</a>
									</c:when>
									<c:otherwise>
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${filesImg[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color: yellowgreen" href="javascript:openAnnex('${filesImg[status.index].id}')" id="openFile">
											预览
										</a>
									</c:otherwise>
								</c:choose>
							</c:if>

						</c:forEach>
						<i <c:if test="${filesImg[status.index] == null }">style="display:none"</c:if> class="layui-icon">&#x1006;</i>
					</div>
					<input index="${status.index }" type="file" style="display:none;" onchange="CheckFile(this)" class="file-image-input" name="imageFile" /> 
					</li>
					</c:forEach>
					</ul>
				</div>
				<div>
					<span style="position:relative;bottom:15px;text-align: right">附件：</span>
					<ul style="width:85%;display:inline-block;" class ="file_ul">
					<c:forEach var="n" begin="0" end="4" varStatus="status">
					<li style="float:left;margin-right:5px;line-height:40px;">
					<div index="${status.index }" <c:choose><c:when test="${files[status.index] == null }">style="display:none"</c:when><c:otherwise>data="${files[status.index].id }"</c:otherwise></c:choose> class="buttonArea file-button"><lable>${files[status.index] ne null?files[status.index].fileName : '添加附件' }</lable>

						<c:forEach items="${suffixMap}" var="m">
							<c:if test="${m.key == files[status.index].id}">
								<c:choose>
									<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${files[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${files[status.index].downloadUrl}','width=1200px;height=800px;')" id="openExcel">
											预览
										</a>
									</c:when>
									<c:otherwise>
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${files[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color: yellowgreen" href="javascript:openAnnex('${files[status.index].id}')" id="openFile">
											预览
										</a>
									</c:otherwise>
								</c:choose>
							</c:if>

						</c:forEach>
						<i <c:if test="${files[status.index] == null }">style="display:none"</c:if> class="layui-icon">&#x1006;</i>
					</div>
					<input index="${status.index }" type="file" style="display:none;" class="file-input" name="file"/> 
					</li>
					</c:forEach>
					</ul>	
				</div>
				<div>
					<span style="position:relative;bottom:15px;text-align: right">相关会议纪要：</span>
					<ul style="width:85%;display:inline-block;" class="meet_ul">
					<c:forEach var="n" begin="0" end="4" varStatus="status">
					<li style="float:left;margin-right:5px;line-height:40px;">
					<div index="${status.index }" <c:choose><c:when test="${filesMeets[status.index] == null }">style="display:none"</c:when><c:otherwise>data="${filesMeets[status.index].id }"</c:otherwise></c:choose> class="buttonArea meet-button"><lable>${filesMeets[status.index] ne null?filesMeets[status.index].fileName : '添加文件' }</lable>
						<c:forEach items="${suffixMeetsMap}" var="m">
							<c:if test="${m.key == filesMeets[status.index].id}">
								<c:choose>
									<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${filesMeets[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filesMeets[status.index].downloadUrl}','width=1200px;height=800px;')" id="openExcel">
											预览
										</a>
									</c:when>
									<c:otherwise>
										<div id="afileName" style="display:inline-block;font-size:14px;" >
											<a href="${ctx }/sysFile/download.shtml?fileId=${filesMeets[status.index].id }" style="margin:0 10px;">下载</a>
										</div>
										<a style="color: yellowgreen" href="javascript:openAnnex('${filesMeets[status.index].id}')" id="openFile">
											预览
										</a>
									</c:otherwise>
								</c:choose>
							</c:if>

						</c:forEach>
						<i <c:if test="${filesMeets[status.index] == null }">style="display:none"</c:if> class="layui-icon">&#x1006;</i>
					</div>
					<input index="${status.index }" type="file" style="display:none;" class="file-meet-input" name="meetFile"/>
					</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${bidding.id != null }">编辑</c:when>
				<c:otherwise>保存</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
		</form>
	</div>
<script>
	var projectList = [];

	<c:forEach items="${projectList}" var="item">
		projectList.push({"${item.projectName}":"${item.projectSerial},${item.projectYear},${item.id}<c:if test="${not empty item.parentProject}">,${item.parentProject.projectSerial}(${item.parentProject.projectName})</c:if>"});
	</c:forEach>

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

    $(document).on("click",".image-button>lable",function(){
        let index = $(this).parent().attr("index");
        $(".file-image-input").eq(index).click();
    });


    $(document).on("change",".file-image-input",function(){
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
    $(document).on("click",".image-button>i",function () {
        let flage = $(this).parent().attr("index");	// 记录当前编号
        $(".image_ul li").eq(flage).remove();	//	删除当前元素

        // 修改编号
        for(;flage < $(".image_ul li").length;flage++){
            $(".image-button").eq(flage).attr("index",flage);
            $(".file-image-input").eq(flage).attr("index",flage);
        }

        // 在末尾追加新列
        $(".image_ul").append('<li style="float:left;margin-right:5px;line-height:40px;">' + '<div index="9"  style="display:none"  class="buttonArea image-button"><lable>添加图片</lable><i style="display:none" class="layui-icon">&#x1006;</i>' +
            '</div>' +
            '<input index="9" type="file" style="display:none;" onchange="CheckFile(this)" class="file-image-input" name="imageFile"> ' +
            '</li>');
    });



    $(document).on("click",".file-button>lable",function(){
        let index = $(this).parent().attr("index");
        $(".file-input").eq(index).click();
    });


    $(document).on("change",".file-input",function(){
        var filename = $(this).val().split("\\");
        if(filename != ""){
            $(".file-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
            $(".file-button").eq($(this).attr("index")).find("i").show();
            $(".file-button").each(function(){
                if($(this).css("display")!="none" && $(this).find("lable").html() == '添加附件')
                    return false;
                if($(this).css("display") == "none"){
                    $(this).show();
                    return false;
                }
            });
        }
    });
    $(document).on("click",".file-button>i",function () {
        let flage = $(this).parent().attr("index");	// 记录当前编号
        $(".file_ul li").eq(flage).remove();	//	删除当前元素

        // 修改编号
        for(;flage < $(".file_ul li").length;flage++){
            $(".file-button").eq(flage).attr("index",flage);
            $(".file-input").eq(flage).attr("index",flage);
        }

        // 在末尾追加新列
        $(".file_ul").append('<li style="float:left;margin-right:5px;line-height:40px;">' + '<div index="4"  style="display:none"  class="buttonArea file-button"><lable>添加附件</lable><i style="display:none" class="layui-icon">&#x1006;</i>' +
            '</div>' +
            '<input index="4" type="file" style="display:none;" class="file-input" name="file"> ' +
            '</li>');
    });



    $(document).on("click",".meet-button>lable",function(){
        let index = $(this).parent().attr("index");
        $(".file-meet-input").eq(index).click();
    });


    $(document).on("change",".file-meet-input",function(){
        var filename = $(this).val().split("\\");
        if(filename != ""){
            $(".meet-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
            $(".meet-button").eq($(this).attr("index")).find("i").show();
            $(".meet-button").each(function(){
                if($(this).css("display")!="none" && $(this).find("lable").html() == '添加文件')
                    return false;
                if($(this).css("display") == "none"){
                    $(this).show();
                    return false;
                }
            });
        }
    });
    $(document).on("click",".meet-button>i",function () {
        let flage = $(this).parent().attr("index");	// 记录当前编号
        $(".meet_ul li").eq(flage).remove();	//	删除当前元素

        // 修改编号
        for(;flage < $(".meet_ul li").length;flage++){
            $(".meet-button").eq(flage).attr("index",flage);
            $(".file-meet-input").eq(flage).attr("index",flage);
        }

        // 在末尾追加新列
        $(".meet_ul").append('<li style="float:left;margin-right:5px;line-height:40px;">' + '<div index="4"  style="display:none"  class="buttonArea meet-button"><lable>添加文件</lable><i style="display:none" class="layui-icon">&#x1006;</i>' +
            '</div>' +
            '<input index="4" type="file" style="display:none;" class="file-meet-input" name="meetFile"> ' +
            '</li>');
    });

	$(function(){
		$(".image-button").eq(0).show();
		$(".file-button").eq(0).show();
		$(".meet-button").eq(0).show();
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
		<c:if test="${filesMeets ne null}">
		$(".meet-button").each(function(){
			if($(this).css("display")!="none" && $(this).find("lable").html() == '添加文件')
				return false;
			if($(this).css("display") == "none"){
				$(this).show();
				return false;
			}
		});
		</c:if>
	});

	var key = $("select[name='projectName']").val();
	var undefind = undefind;
	if(key!=""&&key!=undefind){
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
				if(data.length>=4)
					$("span[name='parentProject']").html(data[3]);
				break;
			}
		}
	}
	
	$("select[name='projectName']").change(function(){
		var key = $(this).val();
		var  index=$(this).get(0).selectedIndex-1;
		for(var i=0;i<projectList.length;i++){
			if(projectList[i][key] != undefind&&index==i){
				var data = projectList[i][key].split(",");
				$("span[name='projectSerial']").html(data[0]);
				$("span[name='projectYear']").html(data[1]);
				$("input[name='projectId']").val(data[2]);
        
                if(data.length>=4)
                    $("span[name='parentProject']").html(data[3]);
                else{
                    $("span[name='parentProject']").html("");
				}
				break;
			}
		}
	});
	
	/*$(".file-button>lable").click(function(){
		$(".file-input").eq($(this).parent().attr("index")).click();
	});*/
	
	// $(".image-button>lable").click(function(){
	//     let index = $(this).parent().attr("index");
	// 	$(".file-image-input").eq(index).click();
	// });
	
	/*$(".meet-button>lable").click(function(index,i){
		$(".file-meet-input").eq($(this).parent().attr("index")).click();

	});*/
	
	// $(".image-button>i").click(function(){
     //    debugger
    //
	// 	let flage = $(this).parent().attr("index");	// 记录当前编号
	// 	$(".image_ul li").eq(flage).remove();	//	删除当前元素
    //
	// 	// 修改编号
	// 	for(;flage < $(".image_ul li").length;flage++){
	// 	    $(".image-button").eq(flage).attr("index",flage);
	// 	    $(".file-image-input").eq(flage).attr("index",flage);
	// 	}
    //
	// 	// 在末尾追加新列
	// 	$(".image_ul").append('<li style="float:left;margin-right:5px;line-height:40px;">' + '<div index="9"  style="display:none"  class="buttonArea image-button"><lable>添加图片</lable><i style="display:none" class="layui-icon">&#x1006;</i>' +
     //        '</div>' +
     //        '<input index="9" type="file" style="display:none;" onchange="CheckFile(this)" class="file-image-input" name="imageFile"> ' +
     //        '</li>');
    //
	// });
	
	/*$(".file-button>i").click(function(){
		$(".file-input").eq($(this).parent().attr("index")).val("");
		$(this).parent().removeAttr("data");
		if($(this).parent().attr('index') != 0){
			$(this).parent().find("lable").html("添加附件")
			$(this).parent().hide();
			$(this).hide();
			for(var i = $(".file-button").length - 1;i>=0;i++){
				if($(".file-button").eq(i).css("display")!="none" && $(".file-button").eq(i).find("lable").html() == '添加附件')
					return false;
				if($(".file-button").eq(i).css("display") == "none"){
					$(".file-button").eq(i).show();
					return false;
				}
			}
		}else{
			$(this).parent().find("lable").html("添加附件")
			$(this).hide();
		}
	});*/
	
	/*$(".meet-button>i").click(function(){
		$(".file-meet-input").eq($(this).parent().attr("index")).val("");
		$(this).parent().removeAttr("data");
		if($(this).parent().attr('index') != 0){
			$(this).parent().find("lable").html("添加文件")
			$(this).parent().hide();
			$(this).hide();
			for(var i = $(".meet-button").length - 1;i>=0;i++){
				if($(".meet-button").eq(i).css("display")!="none" && $(".meet-button").eq(i).find("lable").html() == '添加文件')
					return false;
				if($(".meet-button").eq(i).css("display") == "none"){
					$(".meet-button").eq(i).show();
					return false;
				}
			}
		}else{
			$(this).parent().find("lable").html("添加文件")
			$(this).hide();
		}
	});*/
	
	/*$(".file-input").change(function(){
		var filename = $(this).val().split("\\");
		if(filename != ""){
			$(".file-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
			$(".file-button").eq($(this).attr("index")).find("i").show();
			$(".file-button").each(function(){
				if($(this).css("display")!="none" && $(this).find("lable").html() == '添加附件')
					return false;
				if($(this).css("display") == "none"){
					$(this).show();
					return false;
				}
			});
		}
	});*/
	
	// $(".file-image-input").change(function(){
	// 	var filename = $(this).val().split("\\");
	// 	if(filename != ""){
	// 		$(".image-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
	// 		$(".image-button").eq($(this).attr("index")).find("i").show();
	// 		$(".image-button").each(function(){
	// 			if($(this).css("display")!="none" && $(this).find("lable").html() == '添加图片')
	// 				return false;
	// 			if($(this).css("display") == "none"){
	// 				$(this).show();
	// 				return false;
	// 			}
	// 		});
	// 	}
	// });
	
	/*$(".file-meet-input").change(function(){
		var filename = $(this).val().split("\\");
		if(filename != ""){
			$(".meet-button").eq($(this).attr("index")).find("lable").html(filename[filename.length - 1]);
			$(".meet-button").eq($(this).attr("index")).find("i").show();
			$(".meet-button").each(function(){
				if($(this).css("display")!="none" && $(this).find("lable").html() == '添加文件')
					return false;
				if($(this).css("display") == "none"){
					$(this).show();
					return false;
				}
			});
		}
	});*/
	
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
		var meetIds = [];
		$(".image-button").each(function(){if($(this).attr("data")!=undefind&&$(this).attr("data")!="")imageIds.push($(this).attr("data"))})
		$(".file-button").each(function(){if($(this).attr("data")!=undefind&&$(this).attr("data")!="")fileIds.push($(this).attr("data"))})
		$(".meet-button").each(function(){if($(this).attr("data")!=undefind&&$(this).attr("data")!="")meetIds.push($(this).attr("data"))})
		$("[name='projectUnit']").removeAttr("disabled");
		layer.load();
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"dataType":"招投标",
					"projectSerial":$("span[name='projectSerial']").html(),
					"projectYear":$("span[name='projectYear']").html(),
					"projectId":$("span[name='projectId']").html()
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Bidding/View.shtml?identity=${ident}";
						});
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"dataType":"招投标",
					"projectSerial":$("span[name='projectSerial']").html(),
					"projectYear":$("span[name='projectYear']").html(),
					"projectId":$("span[name='projectId']").html(),
					"imageIds":JSON.stringify(imageIds),
					"fileIds":JSON.stringify(fileIds),
					"meetIds":JSON.stringify(meetIds),
					"id":"${bidding.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Construction/Bidding/View.shtml?identity=${ident}";
						});
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
		  	window.location.href = "${ctx}/Construction/Bidding/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>