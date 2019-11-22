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
	width:33%;
	padding-bottom:5px;
	text-align: center;
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
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li class="active">管理项目</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="View.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						项目名称：
						<input type="text" class="inputArea" name="projectName"/>
					</td>
					<td>
						建筑类型：
						<select class="inputArea" name="constructionType">
							<option value="">全部</option>
							<option>新建</option>
							<option>续建</option>
							<option>其他</option>
						</select>
					</td>
					<td>
						项目状态：
						<select name="projectStatus" class="inputArea">
							<option value="">全部</option>
							<option>前期</option>
							<option>开工建设</option>
							<option>已竣工</option>
						</select>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
				<tr>
					<td>
						项目年份：
						<input id="project_year" name="projectYear" class="inputArea"/>
					</td>
					<td>
						父项目编号：
						<input id="parentSerial" name="parentProject.projectSerial" class="inputArea" autocomplete="off"/>
					</td>
					<td>
						父项目名称：
						<input id="parentName" name="parentProject.projectName" class="inputArea" autocomplete="off"/>
					</td>
				</tr>
				<tr <c:if test="${identity ne null}">style="display:none"</c:if> >
					<td >
						项目单位：
						<input name="projectUnit" class="inputArea"/>
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
		<table style="display:none">
			<tr id="template">
				<td style="text-align: left;padding-left: 1%;" name="projectSerial"></td>
				<td style="text-align: center" name="projectYear"></td>
				<td style="text-align: left;padding-left: 1%;" name="projectName"></td>
				<td style="text-align: left;padding-left: 1%;" name="parentProject"></td>
				<td style="text-align: left;padding-left: 1%;" name="projectUnit"></td>
				<td style="text-align: left;padding-left: 1%;" name="constructionType"></td>
				<td style="text-align: right;padding-right: 1%;" name="plannedInvestment"></td>
				<td style="text-align: center" name="projectTime"></td>
				<td style="text-align: center" name="plannedStartTime"></td>
				<td style="text-align: center" name="plannedFinishTime"></td>
				<td style="text-align: left;padding-left: 1%;" name="projectStatus"></td>
				<td name="do">
					<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${construction.id }" onclick="toView(this)">查看</a>
					<shiro:hasPermission name="newConstruction:edit">
					<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini' href="${ctx }/Construction/Manage/Edit.shtml?cid=">编辑</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td style="text-align: center">项目编号</td>
					<td style="text-align: center">项目年份</td>
					<td style="text-align: center">项目名称</td>
					<td style="text-align: center">父项目编号(名称)</td>
					<td style="text-align: center">项目单位</td>
					<td style="text-align: center">建筑类别</td>
					<td style="text-align: center">项目预估总额（万元）</td>
					<td style="text-align: center">项目立项时间</td>
					<td style="text-align: center">项目计划开始时间</td>
					<td style="text-align: center">项目计划结束时间</td>
					<td style="text-align: center">项目状态</td>
					<td style="text-align: center">操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${constructionlist.result }" var="construction">
					<tr>
						<td align="left" style="padding-left: 1%">${construction.projectSerial }</td>
						<td align="center">${construction.projectYear }</td>
						<td align="left" style="padding-left: 1%">${construction.projectName }</td>
						<td style="text-align: left;padding-left: 1%"><c:if test="${not empty construction.parentProject}">${construction.parentProject.projectSerial}(${construction.parentProject.projectName})</c:if></td>
						<td align="left" style="padding-left: 1%">${construction.projectUnit }</td>
						<td align="left" style="padding-left: 1%">${construction.constructionType }</td>
						<td align="right" style="padding-right: 1%"><fmt:formatNumber type="number" value="${construction.plannedInvestment}" pattern="0.00" maxFractionDigits="2"/></td>
						<td align="center">${construction.projectTime }</td>
						<td align="center">${construction.plannedStartTime }</td>
						<td align="center">${construction.plannedFinishTime }</td>
						<td align="left" style="padding-left: 1%">${construction.projectStatus }</td>
						<td>
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${construction.id }" onclick="toView(this)">查看</a>
							<shiro:hasPermission name="newConstruction:edit">
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini' href="${ctx }/Construction/Manage/Edit.shtml?cid=${construction.id }">编辑</a>
							</shiro:hasPermission>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${constructionlist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${constructionlist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${constructionlist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${constructionlist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${constructionlist.pageIndex}");
	var PageSize = Number("${constructionlist.pageSize}");
	var TotalCount = Number("${constructionlist.totalCount}");
	
	var laydate=layui.laydate;
	laydate.render({
		elem:"#project_year",
		type:"year"
	});
	
	$(function(){
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
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
						
						template.find("td[name='projectSerial']").html(Result[i].projectSerial)
						template.find("td[name='projectYear']").html(Result[i].projectYear);
						template.find("td[name='projectName']").html(Result[i].projectName);
						if(Result[i].parentProject !=null){
                            template.find("td[name='parentProject']").html(Result[i].parentProject.projectSerial+"("+Result[i].parentProject.projectName+")");
						}
						template.find("td[name='projectUnit']").html(Result[i].projectUnit);
						template.find("td[name='constructionType']").html(Result[i].constructionType);
						template.find("td[name='plannedInvestment']").html((Result[i].plannedInvestment).toFixed(1));
						template.find("td[name='projectTime']").html(Result[i].projectTime);
						template.find("td[name='plannedStartTime']").html(Result[i].plannedStartTime);
						template.find("td[name='plannedFinishTime']").html(Result[i].plannedFinishTime);
						template.find("td[name='projectStatus']").html(Result[i].projectStatus);
						var target = template.find("td[name='do']");
						$(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)});
						$(target).find("a.detail").attr('data-id',Result[i].id);
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
					}
					if(NeedDrawPage)
						DrawPageButton("pagination");
				}else{
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='11'>搜索目标无结果</td></tr>");
					DrawPageButton("pagination");
				}
			}
		});
	}
	
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

    function toView(o){
        var index = layer.open({
            type: 2,
            title: '查看',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '600px'],
            content: '${ctx }/Construction/New/Detail.shtml?cid='+$(o).attr('data-id')
        });
        layer.full(index);
    }
</script>
<%@ include file="../common/AdminFooter.jsp" %>