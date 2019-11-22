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
			<li>管理项目</li>
			<li class="active">编辑</li>
		</ol>
	</div>
	<div id="outSide">
		<form action="Edit.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">基建项目信息${construction.reconnaissance }</span>
			<div id="mainInfo">
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>实际投资额(万元)：</span>
					<input  name="actualInvestment" id="actualInvestment"  onkeyup="value=value.replace(/[^\d\.]/g,'')" lay-verify="number" type="number" maxlength="10" class="inputArea" value="<c:if test="${construction.actualInvestment > 0}">${construction.actualInvestment }</c:if>"/>
				</div>
				<div>
					<span style="text-align: right"><b></b>实际开工日期：</span>
					<input class="inputArea needDateFormat" name="actualStartTime" value="${construction.actualStartTime }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>实际完工日期：</span>
					<input class="inputArea needDateFormat" name="actualFinishTime" value="${construction.actualFinishTime }"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>勘察单位：</span>
					<input class="inputArea" name="reconnaissance" value="${construction.reconnaissance }" maxlength="250"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>设计单位：</span>
					<input class="inputArea" type="text" value="${construction.designUnit }" name="designUnit"  maxlength="250">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>施工单位：</span>
					<input class="inputArea" type="text" value="${construction.buildUnit }" name="buildUnit"  maxlength="250">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>监理单位：</span>
					<input class="inputArea" type="text" value="${construction.controlUnit }" name="controlUnit"  maxlength="250">
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>联系人：</span>
					<input class="inputArea" name="contactor" value="${construction.contactor }"  maxlength="25"/>
				</div>
				<div>
					<span style="text-align: right"><b class="requiredData">*</b>联系方式：</span>
					<input class="inputArea" lay-verify="phone" id="contactWay" name="contactWay" value="${construction.contactWay }" maxlength="11"/>
				</div>
				<div>
					<span style="text-align: right">资料：</span>
					<ul style="width:80%;display:inline-block;" templateId="template-file-data" length=5 id="ul-data">
						<c:forEach items="${datas}" var="item">
					<li style="float:left;margin-right:5px;line-height:40px;">
						<div data="${item.id}" class="buttonArea file-button">
							<lable>${item.fileName}</lable>
							<c:forEach items="${suffixDatasMap}" var="m">
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
						</div>
						<input type="file" style="display:none;" class="file-input" name="data"/>
					</li>
					</c:forEach>
						<c:if test="${fn:length(datas) < 5 }">
							<li style="float:left;margin-right:5px;line-height:40px;">
								<div data="" class="buttonArea file-button">
									<lable class="toUpload">添加资料</lable>
									<i style="display:none" class="layui-icon">&#x1006;</i>
								</div>
								<input type="file" style="display:none;" class="file-input" name="data"/>
							</li>
						</c:if>
					</ul>
				</div>
				<div>
					<span style="text-align: right">附件：</span>
					<ul style="width:80%;display:inline-block;" templateId="template-file" length=5 id="ul-file">
						<c:forEach items="${files}" var="item">
					<li style="float:left;margin-right:5px;line-height:40px;">
						<div data="${item.id}" class="buttonArea file-button">
							<lable>${item.fileName}</lable>
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
						</div>
						<input type="file" style="display:none;" class="file-input" name="file"/>
					</li>
					</c:forEach>
						<c:if test="${fn:length(files) < 5 }">
							<li style="float:left;margin-right:5px;line-height:40px;">
								<div data="" class="buttonArea file-button">
									<lable class="toUpload">添加附件</lable>
									<i style="display:none" class="layui-icon">&#x1006;</i>
								</div>
								<input type="file" style="display:none;" class="file-input" name="file"/>
							</li>
						</c:if>
					</ul>
				</div>
				<div>
					<span style="position:relative;bottom:4em;text-align: right">备注：</span>
					<textarea rows="4" class="inputArea" style="width:88%" name="remark">${construction.remark }</textarea>
				</div>
			</div>
		</div>
		<div id="bottom-button">
			<div class="buttonArea" id="save">保存</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
		</form>
	</div>

<%--模板--%>
<div id="template-file-data" style="display:none">
	<li style="float:left;margin-right:5px;line-height:40px;">
		<div data="" class="buttonArea file-button">
			<lable class="toUpload">添加资料</lable>
			<i class="layui-icon" style="display:none">&#x1006;</i>
		</div>
		<input type="file" style="display:none;" class="file-input" name="data" />
	</li>
</div>
<div id="template-file" style="display:none">
	<li style="float:left;margin-right:5px;line-height:40px;">
		<div data="" class="buttonArea file-button">
			<lable class="toUpload">添加附件</lable>
			<i style="display:none" class="layui-icon">&#x1006;</i>
		</div>
		<input type="file" style="display:none;" class="file-input" name="file"/>
	</li>
</div>
<script>

    $(document).on("click",".file-button>lable", function() {
        $(this).parent().next().click();
    });

    //上传图片
    $(document).on("change",".file-input", function() {
        var filename = $(this).val().split("\\");
        if(filename != ""){
            $(this).parent().find('lable').html(filename[filename.length - 1]);
            $(this).parent().find('lable').removeClass("toUpload");
            $(this).parent().find('i').show();
            var length = $(this).parent().parent().attr('length'); //限制数
            var fileLength = $(this).parent().parent().children('li').length; //已有数
            if(fileLength < length){
                var templateId = $(this).parent().parent().attr('templateId');
                $(this).parent().parent().append($('#' + templateId).html());
            }
        }
    });
    
   

    //删除图片
    $(document).on("click",".file-button>i", function() {
        if($(this).parent().parent().parent().find('.toUpload').length==0){
            var templateId = $(this).parent().parent().parent().attr('templateId');
            $(this).parent().parent().parent().append($('#' + templateId).html());
        }
        $(this).parent().parent().remove();
    });

	var laydate=layui.laydate;
	laydate.render({
		elem:"#projectYear",
		type:"year",
	});
	
	$(".needDateFormat").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy年MM月dd日"
		});
	});
	
	// function CheckTimeRight(){
	// 	var time = new Date();
	// 	var actualStartTime = parseInt($("input[name='actualStartTime']").val().replace(/[^0-9]/ig,""));
	// 	var actualFinishTime = parseInt($("input[name='actualFinishTime']").val().replace(/[^0-9]/ig,""));
	//
	// 	if(actualStartTime>actualFinishTime){
	// 		layer.msg("开工时间不能大于完工时间",{icon:0});
	// 		return false;
	// 	}
	// 	return true;
	// }
	
	$("#add-annex").click(function(){
		$("#file-input").click();
	});
	
	$("#add-project-annex").click(function(){
		$("#file-project-input").click();
	});

	$("#file-project-input").change(function(){
		var filename = $(this).val().split("\\");
		$("#add-project-annex").html(filename[filename.length - 1]);
	});
	
	$("#save").click(function(){
		var patchAll = true;
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				$(this).focus();
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});


		var actualInvestment = $("#actualInvestment").val();
		
		 if(actualInvestment!=='' && !/^\d{1,7}(\.\d{1,2})?$/.test(actualInvestment)) {
               layer.msg("实际投资额请输入最长7位，小数位最多2位的数字");  
               return false;
           }


            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;//手机号码
            var isMob = /^0?1[3|4|5|8][0-9]\d{8}$/;// 座机格式
            if (isMob.test($("#contactWay").val()) || isPhone.test($("#contactWay").val())) {

            }
            else {
                layer.msg("联系方式格式不对");
                return false;
            }

		
		if(!patchAll)
			return;
		// if(!CheckTimeRight())
		// 	return;
		var undefind = undefind;	
		var fileIds = [];
		var dataIds = [];
		$("#ul-data .file-button").each(function(){if($(this).attr("data")!=undefind&&$(this).attr("data")!="")dataIds.push($(this).attr("data"))});
		$("#ul-file .file-button").each(function(){if($(this).attr("data")!=undefind&&$(this).attr("data")!="")fileIds.push($(this).attr("data"))});
       var actualInvestment = $('#actualInvestment').val();
       // alert(changeTwoDecimal(actualInvestment));
		$('#actualInvestment').val(changeTwoDecimal(actualInvestment));
		$("form").ajaxSubmit({
			data:{
				"id":"${construction.id }",
				"dataIds":JSON.stringify(dataIds),
				"fileIds":JSON.stringify(fileIds)
			},
			success:function(data){
				if(data.success){
					layer.msg("信息保存成功",{icon:1}, function(){
					  	window.location.href = "${ctx}/Construction/Manage/View.shtml?identity=${ident}";
					})
				}else{
					layer.msg("信息保存失败",{icon:2})
				}
			}
		});
	});
	
	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/Construction/Manage/View.shtml?identity=${ident}";
		}, function(){
		  
		});
	});

    function changeTwoDecimal(x)
    {
        var f_x = parseFloat(x);
        if (isNaN(f_x))
        {
            alert('function:changeTwoDecimal->parameter error');
            return false;
        }
        f_x = Math.round(f_x *100)/100;

        return f_x;
    }
</script>
<%@ include file="../common/AdminFooter.jsp" %>