<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">

	#data-list tr td[name="unit_name"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="total_count"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[name="total_income"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[name="total_expend"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[name="total_profits"]{
		padding-right: 1%;
		text-align: right;
	}
	#data-list tr td[name="status"]{
		padding-left: 1%;
		text-align: left;
	}

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
		<li>中转业务</li>
		<li class="active">中转业务统计</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="Transfer.shtml" method="Post">
			<table>
				<thead>
				<tr>
					<td>
						单位名称：
						<input type="text" class="inputArea" id="transfer-name" placeholder="请输入" name="unitName"/>
					</td>
					<td>
						中转日期：
						<input id="storage-date" name="transferDate" class="inputArea"/>
					</td>
					<td>
						状态：
						<select id="transfer-type" class="inputArea" name="status">
							<option selected="selected" value="">全部</option>
							<option>待提交</option>
							<option>驳回</option>
							<option>审核中</option>
							<option>已通过</option>
							<option>已上报</option>
						</select>
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
		<shiro:hasPermission name="transit:add">
		<div class="buttonArea" id="add-inboundnotif">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td name="unit_name"></td>
				<td name="transfer_date"></td>
				<td name="total_count"></td>
				<td name="total_income"></td>
				<td name="total_expend"></td>
				<td name="total_profits"></td>
				<td name="status"></td>
				<td name="do">
					<shiro:hasPermission name="transit:edit">
					<a style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini edit" href="${ctx }/Transfer/Edit.shtml?tid=${transfer.id }">编辑</a>
					</shiro:hasPermission>
					<a style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" href="${ctx }/Transfer/Detail.shtml?tid=${transfer.id }">查看</a>
					<shiro:hasPermission name="transit:edit">
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini submit">提交</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="transit:pass">
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini pass">通过</span>
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini unpass">驳回</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="transit:push">
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini push">上报</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="transit:edit">
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini delete">删除</span>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table">
			<thead>
				<tr>
					<td>单位名称</td>
					<td>中转日期</td>
					<td>中转总数(吨)</td>
					<td>中转总收入(万元)</td>
					<td>中转总支出(万元)</td>
					<td>中转总利润(万元)</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${transferlist.result }" var="transfer">
					<tr>
						<td name="unit_name" >${transfer.unitName }</td>
						<td name="transfer_date" ><fmt:formatDate value="${transfer.transferDate }" pattern="yyyy年MM月dd日" /></td>
						<td name="total_count" ><fmt:formatNumber value="${transfer.totalCount }" type="number" maxFractionDigits="3"/></td>
						<td name="total_income" ><fmt:formatNumber value="${transfer.totalIncome }" type="number" maxFractionDigits="3"/></td>
						<td name="total_expend" ><fmt:formatNumber value="${transfer.totalExpend }" type="number" maxFractionDigits="3"/></td>
						<td name="total_profits" ><fmt:formatNumber value="${transfer.totalProfits }" type="number" maxFractionDigits="2"/></td>
						<td name="status">${transfer.status }</td>
						<td>
						<c:choose>
							<c:when test="${transfer.status == '待提交' or transfer.status == '驳回'}">
								<shiro:hasPermission name="transit:edit">
								<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini edit" href="${ctx }/Transfer/Edit.shtml?tid=${transfer.id }">编辑</a>
								<span tag="${transfer.id }" class="layui-btn layui-btn-primary layui-btn layui-btn-mini submit">提交</span>
								<span tag="${transfer.id }" class="layui-btn layui-btn-primary layui-btn layui-btn-mini delete">删除</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${transfer.status == '审核中'}">
								<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" href="${ctx }/Transfer/Detail.shtml?tid=${transfer.id }">查看</a>
								<shiro:hasPermission name="transit:pass">
								<span tag="${transfer.id }" class="layui-btn layui-btn-primary layui-btn layui-btn-mini pass">通过</span>
								<span tag="${transfer.id }" class="layui-btn layui-btn-primary layui-btn layui-btn-mini unpass">驳回</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${transfer.status == '已通过'}">
								<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" href="${ctx }/Transfer/Detail.shtml?tid=${transfer.id }">查看</a>
								<shiro:hasPermission name="transit:push">
								<span tag="${transfer.id }" class="layui-btn layui-btn-primary layui-btn layui-btn-mini push">上报</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${transfer.status == '已上报'}">
								<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" href="${ctx }/Transfer/Detail.shtml?tid=${transfer.id }">查看</a>
							</c:when>
						</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${transferlist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${transferlist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${transferlist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${transferlist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${transferlist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${transferlist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${transferlist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${transferlist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${transferlist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${transferlist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${transferlist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${transferlist.pageIndex}");
	var PageSize = Number("${transferlist.pageSize}");
	var TotalCount = Number("${transferlist.totalCount}");
	
	var laydate=layui.laydate;
	laydate.render({
		elem:"#storage-date",
		type:"date",
		format:"yyyy-MM-dd",	
	});
	
	$(function(){
		DrawPageButton("pagination");
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
	
	$("#select-button").click(function() {
		PageIndex = 1;
		$("#bottom-button").empty();
		FormSubmit(true);
	});
	
	function FormSubmit(NeedDrawPage){
		$("#select-parm").ajaxSubmit({
			data:{
				"pageindex":Number(PageIndex),
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
						
						template.find("td[name='unit_name']").html(Result[i].unitName);

						var time = new Date();
						time.setTime(Result[i].transferDate);
						template.find("td[name='transfer_date']").html(time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+time.getDate()+"日");
						
						template.find("td[name='total_count']").html(Result[i].totalCount)
						template.find("td[name='total_income']").html(Result[i].totalIncome.toFixed(2));
						template.find("td[name='total_expend']").html(Result[i].totalExpend.toFixed(2));
						template.find("td[name='total_profits']").html(Result[i].totalProfits.toFixed(2));
						template.find("td[name='status']").html(Result[i].status);
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).attr("href",$(this).attr("href")+ Result[i].id)});
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交' || Result[i].status == '驳回' ){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '审核中'){
							$(target).find(".detail,.pass,.unpass").show();
						}else if(Result[i].status == '已通过'){
							$(target).find(".detail,.push").show();
						}else if(Result[i].status == '已上报'){
							$(target).find(".detail").show();
						}
						$("#data-list").append($(template));
						$(template).show();
					}
					if(NeedDrawPage)
						DrawPageButton("pagination");
				}else{
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='9'>搜索目标无结果</td></tr>");
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
	
	$(".submit,.pass,.unpass,.push").click(function(){
		var self=this;
		var mapper = {"提交":"审核中","通过":"已通过","驳回":"驳回","上报":"已上报"};
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$.ajax({
		  		url:"${ctx}/Transfer/Edit.shtml",
		  		data:{
		  			"status":mapper[$(self).html()],
		  			"id":id
		  		},
		  		type:"post",
		  		success:function(data){
		  			if(data.success){
		  				layerMsgSuccess("信息"+$(self).html()+"成功",function(){
		  					location.reload();
		  				});
		  			}else{
		  				layerMsgError("信息"+$(self).html()+"失败");
		  			}
		  		}
		  	});
		}, function(){
		  
		});
	})
	
	$(".delete").click(function(){
		var self=this;
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$.ajax({
		  		url:"${ctx}/Transfer/Delete.shtml",
		  		data:{
		  			"id":id
		  		},
		  		type:"post",
		  		success:function(data){
		  			if(data.success){
		  				layerMsgSuccess("信息"+$(self).html()+"成功",function(){
		  					location.reload();
		  				});
		  			}else{
		  				layerMsgError("信息"+$(self).html()+"失败");
		  			}
		  		}
		  	});
		}, function(){
		  
		});
	});
	
	$("#add-inboundnotif").click(function(){
		window.location.href = "${ctx}/Transfer/Add.shtml";
	});
</script>
<%@ include file="../common/AdminFooter.jsp" %>