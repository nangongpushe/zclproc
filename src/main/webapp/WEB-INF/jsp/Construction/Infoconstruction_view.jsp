<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
#outSide {
	width:94%;
	margin-left:2%;
	padding:1%;
	background:#fff;
	border-top:2px solid #23b7e5;
}

.infoArea {
	width: 100%;
	padding: 20px 0;
	border-bottom: 2px solid #e2e2e2;
}

.title{
	color: #23b7e5;
	font-weight: bold;
}

#infoArea {
	margin-top: 20px;
}

.selectArea {
	width: 15%;
	padding: 5px;
	outline: none;
	border: 1px solid #ccc;
	resize: none;
}

.inputArea {
	width: 50%;
	padding: 5px;
	outline: none;
	border: 1px solid #ccc; 
	resize: none;
}

.buttonArea {
	color: #fff;
    background-color: #009688;
    border: 1px solid #d2d2d2;
    padding:5px 30px;
	cursor: pointer;
	display:inline-block;
}

#listArea {
	padding: 20px 0;
	width: 100%;
	clear: both;
}

#listArea table {
	margin-top: 20px;
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

#listArea thead {
	background: #eee;
}

#listArea table tr td {
	font-size:0.9em;
	padding: 10px 0;
}

#listArea tbody tr {
	border-bottom: 1px solid #ccc;
}
#jockerLay{
	background:#f2f2f2;
    border: 1px solid #e2e2e2;
    border-top:none;
    font-size:0.9em;
}

#pagination {
	text-align: left;
	float: inherit !important;
	display:inline-block;
}

.layui-laypage {
    display: inline-block;
    vertical-align: middle;
    font-size: 0px;
    margin:0;
    margin:5px 0;
}

.layui-table {
    width: 100%;
    margin:0;
    background-color: #fff;
}

.layui-laypage a, .layui-laypage span {
    display: inline-block;
    vertical-align: middle;
    padding: 0 12px;
    height: 28px;
    line-height: 28px;
    background-color: #f2f2f2;
    color: #333;
    margin:0;
    font-size: 12px;
    border:none;
 }
 
#pageSelecter{
	display:inline-block;
	width:152px;
	height:28px;
}

.pageSelecter-disable{
	color:#999;
}

.pageSelecter-disable input,select{
	background:RGB(255,255,255)
}
 
#pageNumber{
	height:24px;
 	width:40px;
 	border-radius:2px;
 	border:1px #ccc solid;
}

#page-in{
	width:46px;
	height:26px;
	text-align:center;
	display:inline-block;
	cursor:pointer;
	border-radius:2px;
	border:1px #ccc solid;
	line-height:1.7;
	background:#fff;
	padding:1px
}

#template{
	display:none
}

a {
	text-decoration: none;
}

.PageButton-UnSelect{
	padding: 5px 15px;
	background:#fff;
	border:1px solid #009688;
	color:#009688;
	cursor: pointer;
	display: inline;
}

.PageButton-Select{
	padding: 5px 15px;
	background: #009688;
	border: none;
	color: #fff;
	cursor: pointer;
	display: inline;
}
#select-parm{
	width:80%;
	display:inline-block;
}

#select-parm>table{
	width:100%;
}

#select-parm table td{
	font-size:14px;
	width:25%;
	padding-bottom:5px;
	text-align: center;
}

#select-parm table td>div{
	width:45%;
	display:inline-block;
	text-align:left;
}

#total-search{
	width:100%;
	display:none;
}

#search-button-area{
	display:inline;
	position: absolute;
}

#search-button-area div{
	margin-right:5px;
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
	width:80%;
	height:500px;
} 

#table-wapper>textarea{
	margin-top:10px;
	width:99%;
}

#close-float-alert{
	position:relative;
	left:90%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}

#file-wapper{
	height:325px;
	overflow-y: auto;
	overflow-x: hidden;
}

.flie-data{
	margin:2px 0.25%;
	height: 75px;
	width:49%;
	display:inline-block;
	border:1px solid #ccc;
}

.flie-data i{
	font-size: 53px;
}

.flie-data .file-download{
	cursor:pointer;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li class="active">工程资料</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="View.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div>文号：</div>
						<input type="text" class="inputArea" name="referenceNo"/>
					</td>
					<td>
						<div>项目编号：</div>
						<input name="projectSerial" class="inputArea"/>
					</td>
					<td>
						<div>项目单位：</div>
						<input name="projectUnit" class="inputArea"/>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
					<tr>
						<td>
							<div>项目名称：</div>
							<input name="projectName" class="inputArea"/>
						</td>
						<td>
							<div>项目年份：</div>
							<input name="projectYear" class="inputArea yearNeed"/>
						</td>
						<td>
							<div>建筑类型：</div>
							<select name="constructionType" class="inputArea">
								<option value="">全部</option>
								<option>新建</option>
								<option>续建</option>
								<option>其他</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<div>项目状态：</div>
							<select name="projectStatus" class="inputArea">
								<option value="">全部</option>
								<option>前期</option>
								<option>开工建设</option>
								<option>已竣工</option>
							</select>
						</td>
						<td>
							<div>父项目编号：</div>
							<input type="text" class="inputArea" name="parentProject.projectSerial" />
						</td>
						<td>
							<div>父项目名称：</div>
							<input type="text" class="inputArea" name="parentProject.projectName" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="search-button-area">
			<div class="buttonArea" id="select-button">查询</div>
			<div class="PageButton-UnSelect" id="show-total-search">
				v 高级搜索
			</div>
		</div>
	</div>
	<div id="listArea">
		<table style="display:none;">
			<tr id="template">
				<td style="text-align: left" name="referenceNo"></td>
				<td style="text-align: left" name="projectSerial"></td>
				<td style="text-align: left" name="projectUnit"></td>
				<td style="text-align: left" name="projectName"></td>
				<td style="text-align: left" name="parentProject"></td>

				<td style="text-align: center" name="projectYear"></td>
				<td style="text-align: left" name="constructionType"></td>
				<td style="text-align: left" name="projectStatus"></td>
				<td name="do">
					<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini viewDataGroup'>查看资料</span>
					<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini uploadFile'>上传资料</span>
				</td>
			</tr>
		</table>
		<table class="layui-table">
			<thead>
				<tr>
					<td>文号</td>
					<td>项目编号</td>
					<td>项目单位</td>
					<td>项目名称</td>
					<td>父项目编号(名称)</td>
					<td>项目年份</td>
					<td>建筑类型</td>
					<td>项目状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${projectlist.result }" var="project">
					<tr>
						<td align="left">${project.referenceNo }</td>
						<td align="left">${project.projectSerial }</td>
						<td align="left">${project.projectUnit }</td>
						<td align="left">${project.projectName }</td>
						<td align="left"><c:if test="${not empty project.parentProject}">${project.parentProject.projectSerial}(${project.parentProject.projectName})</c:if></td>
						<td align="center">${project.projectYear }</td>
						<td align="left">${project.constructionType }</td>
						<td align="left">${project.projectStatus }</td>
						<td>
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini viewDataGroup' tag="${project.id }">查看资料</span>
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini uploadFile' tag="${project.id }">上传资料</span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${projectlist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${projectlist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${projectlist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${projectlist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${projectlist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${projectlist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${projectlist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${projectlist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${projectlist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${projectlist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${projectlist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>
<div id="float-alert">
	<div id="table-wapper">
		<span class="title">资料</span>
		<i id="close-float-alert" class="layui-icon">&#x1006;</i>
		<div id="file-group">
			<hr/>
			<span class="file-upload">资料上传：</span>
			<div class="buttonArea file-upload" id="upload">上传</div>
			<div class="buttonArea file-download" id="download">下载</div>
			<form id="simple-form" style="display:none" enctype="multipart/form-data">
				<input type="file" name="file"/>
			</form>
			<hr/>
			<div class="flie-data layui-row" id="file-template" style="display:none">
				<div class="layui-col-md3">
					<i class="layui-icon ">&#xe621;</i>
				</div>
   				<div class="layui-col-md7" style="margin-left: 10px;margin-top: 10px;overflow:hidden;">
     				<div class="file-name layui-col-md12" title=""></div>
					<input type="checkbox" name="c_download" class="file-download"/>
   				</div>
   				<i class="layui-icon delete" onclick="deleteConfirm(this)" style="font-size:2rem;position: relative;left: 3.5rem;cursor:pointer">&#xe640;</i>
			</div>
			<div id="file-wapper"></div>
		</div>
		<div style="text-align:right;margin-top:10px;">
			<div class="buttonArea" id="add-tolist">确认</div>
		</div>
	</div>
</div>
<script>
	var PageIndex = Number("${projectlist.pageIndex}");
	var PageSize = Number("${projectlist.pageSize}");
	var TotalCount = Number("${projectlist.totalCount}");
	
	function deleteConfirm(target){
		layer.confirm("您确定要删除该文件么？",function(index){
			$.get("${ctx}/sysFile/delete.shtml",{ id:$(target).attr("fileId")},function(response){
				if(response.success){
					layer.msg("删除成功");
					var wapper = $(target).parent().parent();
					$("#file-wapper").empty();
					AjaxFileList($(wapper));
				}
				else
					layer.msg("删除失败");
			});
			layer.close(index);
		});
	}
	
	var laydate=layui.laydate;
	laydate.render({
		elem:"input[name='projectYear']",
		type:"year"
	});
	
	$(function(){
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
		pageToolBar();
	});
	
	$("#upload").click(function(){
		$("#simple-form>input[type='file']").click();
	});
	
	function download(name, href) {
      var a = document.createElement("a"), //创建a标签
          e = document.createEvent("MouseEvents"); //创建鼠标事件对象
      e.initEvent("click", false, false); //初始化事件对象
      a.href = href; //设置下载地址
      a.download = name; //设置下载文件名
      a.dispatchEvent(e); //给指定的元素，执行事件click事件
	}
	
	$("#download").click(function(){
		$("#file-wapper").find("input:checkbox[name='c_download']:checked").each(function(index,ele){
		    //alert()
			let getHtml = $(ele).prev().html().split('.')
			var a = getHtml[getHtml.length-1];
            //console.log(getHtml[getHtml.length-1])
			//let getHtml = $(ele).prev().html();
            //getHtml.substr(getHtml.indexOf('txt'),getHtml.length)
			//console.log($(ele).prev().html().indexOf('txt'))
			download("第"+(index + 1)+"个文件."+a,$(ele).val());
		})
	});
	$("#simple-form>input[type='file']").change(function(){
		$("#simple-form").ajaxSubmit({
			url:"${ctx}/Construction/Info/Upload.shtml",
			data:{
				"id":$("#file-wapper").attr("tag")
			},
			type:"post",
			success:function(data){
				if(data.success){
					layer.msg("文件上传成功!",{icon:1});
					$("#file-wapper").empty();
					AjaxFileList($("#file-wapper"));
				}else{
					layer.msg("文件上传失败!",{icon:0});
				}
			},
			error:function(){
				layer.msg("系统错误,请联系管理员",{icon:2});
			}
		});
	});
	
	function FormSubmit(NeedDrawPage){
		$("#select-parm").ajaxSubmit({
			data:{
				"pageindex":PageIndex,
				"pagesize":PageSize
			},
			success:function(data){
				$("#data-list").empty();
				TotalCount = data.totalCount;
				$("#total").html(TotalCount); 
				if(data.totalCount > 0){
					var Result = data.result;
					for(var i = 0;i < Result.length; i++){
						var template = $("#template").clone(true);
						template.attr("id","");
						template.find("td[name='referenceNo']").html(Result[i].referenceNo)
						template.find("td[name='projectSerial']").html(Result[i].projectSerial);
						template.find("td[name='projectUnit']").html(Result[i].projectUnit);
						template.find("td[name='projectName']").html(Result[i].projectName);
                        if(Result[i].parentProject!=null)
                            template.find("td[name='parentProject']").html(Result[i].parentProject.projectSerial+"("+Result[i].parentProject.projectName+")");
						template.find("td[name='projectYear']").html(Result[i].projectYear);
						template.find("td[name='constructionType']").html(Result[i].constructionType);
						template.find("td[name='projectStatus']").html(Result[i].projectStatus);
						var target = template.find("td[name='do']");
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						$("#data-list").append($(template));
						$(template).show();
					}
					if(NeedDrawPage)
						DrawPageButton("pagination");
				}else{
					$("#data-list").empty();  
					$("#data-list").append("<tr><td colspan='"+$("#template>td").length+"'>搜索目标无结果</td></tr>");
					DrawPageButton("pagination");
				}
			}
		});
	}
	
	function AjaxFileList(ele){
		$.ajax({
			url:"${ctx}/Construction/Info/ViewFile.shtml",
			data:{
				id:$(ele).attr("tag")
			},
			type:"get",
			success:function(data){
				for(var i=0;i<data.length;i++){
					var template = $("#file-template").clone(true);
					$(template).find(".file-name").html(data[i].fileName);
					$(template).find(".file-name").attr("title",data[i].fileName);
					$(template).find("input[type='checkbox']").val("${ctx}/sysFile/download.shtml?fileId="+data[i].id);
					$(template).find(".delete").attr("fileId",data[i].id);
					$("#file-wapper").append($(template));
					$(template).removeAttr("id");
					$(template).show();
				}
			}
		});
	}
	
	$(".viewDataGroup,.uploadFile").click(function(){
	    if($(this).hasClass('viewDataGroup')){
			$(".file-upload").hide();
			$(".file-download").show();
		}else{
            $(".file-upload").show();
			$(".file-download").hide();
		}
		var self = $(this);
		
		$("#file-wapper").attr("tag",$(self).attr("tag"));
		
		$("#file-wapper").empty();
		
		AjaxFileList($(self));
		
		$("#float-alert").slideToggle(500,function(){
			$("#table-wapper").slideToggle(500);			
		});
	});
	
	$("#close-float-alert,#add-tolist").click(function(){
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500);			
		});
	});
	
	$("#select-button").click(function(){
		PageIndex = 1;
		$("#bottom-button").empty();
		FormSubmit(true);
	});
	
	$("#show-total-search").click(function(){
		if($(this).hasClass("PageButton-UnSelect")){
			$(this).removeClass().addClass("PageButton-Select");
			$(this).html("^ 简单搜索");
		}else{
			$(this).removeClass().addClass("PageButton-UnSelect");
			$(this).html("v 高级搜索");
		} 
		$("#total-search").fadeToggle("fast");
	});

	function DrawPageButton(elemId){
		var self=this;
		$("#"+elemId).children('div').remove();
		layui.laypage.render({
			elem:elemId,
			count:TotalCount,
			limit:PageSize,
			curr:PageIndex,
			prev:"<i class='layui-icon'>&#xe603;</i>",
			next:"<i class='layui-icon'>&#xe602;</i>",
			jump:function(obj,first){
				if(!first){
					PageIndex=obj.curr;
					PageSize=obj.limit;
					FormSubmit(false);
				}
			}
		})
	}
	
	$("#select-button").click(function(){
		PageIndex = 1;
		$("#bottom-button").empty();
		FormSubmit(true);
	});
	
	function pageToolBar(){
		if((TotalCount / Number($("#pageSize").val()))<=1){
			$("#pageSelecter").addClass("pageSelecter-disable");
		}else{
			$("#pageSelecter").removeClass("pageSelecter-disable");
		}
	}
	
	$("#page-in").click(function(){
		var pagesize = Number($("#pageSize").val());
		var maxPage;
		if(TotalCount % pagesize == 0){
			maxPage = TotalCount/pagesize;
		}else{
			maxPage = (TotalCount/pagesize)+1;
		}
		if($("#pageNumber").val() > maxPage){
			$("#pageNumber").val(1);
			return;
		}else{
			PageSize = pagesize;
			PageIndex = Number($("#pageNumber").val());
			FormSubmit(true);
		}
	});
	
	$("#pageSize").change(function(){
		PageIndex = 1;
		PageSize = Number($(this).val());
		FormSubmit(true);	
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>