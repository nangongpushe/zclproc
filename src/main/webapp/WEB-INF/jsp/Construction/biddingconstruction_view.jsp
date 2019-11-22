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
	font-size: 0.9em;
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

.PageButton-UnSelect {
	padding: 5px 15px;
	background: #fff;
	border: 1px solid #888;
	color: #888;
	cursor: pointer;
	border-radius: 5px;
	display: inline;
}

.PageButton-Select {
	padding: 5px 15px;
	background: RGB(25, 174, 136);
	border: none;
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
	display: inline;
}

#select-parm {
	width: 80%;
	display: inline-block;
}

#select-parm>table {
	width: 100%;
}

#select-parm table td {
	font-size:14px;
	width: 33%;
	padding-bottom: 5px;
	text-align: center;
}

#total-search {
	width: 100%;
	display: none;
}

#search-button-area {
	display: inline;
	position: absolute;
}

#search-button-area div {
	margin-right: 5px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li class="active">招投标</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="View.shtml" method="POST">
			<table>
				<thead>
					<tr>
						<td>项目名称： <input type="text" class="inputArea" name="projectName" />
						</td>
						<td>项目年份： <input type="text" class="inputArea" name="projectYear" />
						</td>
						<td>项目单位： <input name="projectUnit" class="inputArea" />
						</td>
					</tr>
					<tr>
						<td>父项目编号： <input type="text" class="inputArea" name="parentProject.projectSerial" />
						</td>
						<td>父项目名称： <input type="text" class="inputArea" name="parentProject.projectName" />
						</td>
					</tr>
				</thead>
			</table>
		</form>
		<div id="search-button-area">
			<div class="buttonArea" id="select-button">查询</div>
		</div>
	</div>
	<div id="listArea">
		<shiro:hasPermission name="constructionInfo:add">
		<div class="buttonArea" id="add-bidding">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td style="text-align: left" name="projectSerial"></td>
				<td style="text-align: center" name="projectYear"></td>
				<td style="text-align: left" name="projectName"></td>
				<td style="text-align: left" name="projectUnit"></td>
				<td style="text-align: left" name="parentProject"></td>
				<td style="text-align: center" name="do">
					<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="" onclick="toView(this)">查看</a>
					<shiro:hasPermission name="constructionInfo:edit">
					<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/Construction/Bidding/Edit.shtml?cid=">编辑</a>
					<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
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
					<td style="text-align: center">项目单位</td>
					<td style="text-align: center">父项目编号(名称)</td>
					<td style="text-align: center">操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${biddinglist.result }" var="bidding">
					<tr>
						<td align="left">${bidding.projectSerial }</td>
						<td align="center">${bidding.projectYear }</td>
						<td align="left">${bidding.projectName }</td>
						<td align="left">${bidding.projectUnit }</td>
						<td style="text-align: left"><c:if test="${not empty bidding.parentProject}">${bidding.parentProject.projectSerial}(${bidding.parentProject.projectName})</c:if></td>
						<td>
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${bidding.id }" onclick="toView(this)">查看</a>
							<shiro:hasPermission name="constructionInfo:edit">
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/Construction/Bidding/Edit.shtml?cid=${bidding.id }">编辑</a>
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete' tag="${bidding.id }">删除</span>
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
				<input id="pageNumber" value="${biddinglist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${biddinglist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${biddinglist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${biddinglist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${biddinglist.pageIndex}");
	var PageSize = Number("${biddinglist.pageSize}");
	var TotalCount = Number("${biddinglist.totalCount}");

	var laydate = layui.laydate;
	laydate.render({
		elem : "input[name='projectYear']",
		type : "year"
	});

	$(function() {
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
	});

	function FormSubmit(NeedDrawPage) {
		$("#select-parm").ajaxSubmit({
			data : {
				"pageindex" : PageIndex,
				"pagesize" : PageSize
			},
			success : function(data) {
				$("#data-list").empty();
				TotalCount = data.totalCount;
				$("#total").html(TotalCount); 
				if (data.totalCount > 0) {
					var Result = data.result;
					for (var i = 0; i < Result.length; i++) {
						var template = $("#template").clone(true);
						template.attr("id", "");

						template.find("td[name='projectSerial']").html(Result[i].projectSerial)
						template.find("td[name='projectYear']").html(Result[i].projectYear);
						template.find("td[name='projectName']").html(Result[i].projectName);
						template.find("td[name='projectUnit']").html(Result[i].projectUnit);
						if(Result[i].parentProject!=null)
                        template.find("td[name='parentProject']").html(Result[i].parentProject.projectSerial+"("+Result[i].parentProject.projectName+")");
						var target = template.find("td[name='do']");
						$(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)});
						$(target).find("a.detail").attr("data-id",Result[i].id);
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
					}
					if (NeedDrawPage)
						DrawPageButton("pagination");
				} else {
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='5'>搜索目标无结果</td></tr>");
					DrawPageButton("pagination");
				}
			}
		});
	}

	$("#select-button").click(function() {
		PageIndex = 1;
		$("#bottom-button").empty();
		FormSubmit(true);
	});

	$("#add-bidding").click(function() {
		window.location.href = "${ctx}/Construction/Bidding/Add.shtml";
	});
	
	$(".delete").click(function(){
		DeleteFunction($(this));
	});
	
	function DeleteFunction(ele){
		var self = $(ele);
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$.ajax({
		  		url:"${ctx}/Construction/Delete/Info/"+id+".shtml",
		  		type:"post",
		  		success:function(data){
		  			if(data.success){
		  				layerMsgSuccess("数据删除成功",function(){
		  					location.reload();
		  				});
		  			}else{
		  				layerMsgError("数据删除失败");
		  			}
		  		}
		  	});
		}, function(){
		  
		});
	}
	
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
            content: '${ctx }/Construction/Detail/Bidding.shtml?id='+$(o).attr('data-id')
        });
        layer.full(index);
    }
</script>
<%@ include file="../common/AdminFooter.jsp"%>