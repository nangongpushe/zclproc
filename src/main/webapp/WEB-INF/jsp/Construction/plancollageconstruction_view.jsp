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
	border:1px solid #888;
	color:#888;
	cursor: pointer;
	border-radius: 5px;
	display: inline;
}

.PageButton-Select{
	padding: 5px 15px;
	background: RGB(25, 174, 136);
	border: none;
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
	display: inline;
}
#select-parm{
	width:25%;
	display:inline-block;
}

#select-parm>table{
	width:100%;
}

#select-parm table td{
	font-size:14px;
	width:25%;
	padding-bottom:5px;
}

#select-parm table td>div{
	width:20%;
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
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li class="active">年度计划(汇总)</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="Collage.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div>年份：</div>
						<input name="year" class="inputArea"/>
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
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td>年度计划名称</td>
					<td>年份</td>
					<td>总投资合计(万元)</td>
					<td>上年底累计投资额合计(万元)</td>
					<td>本年计划投资额合计(万元)</td>
					<td>操作</td>
				</tr>
				<tr id="template">
					<td style="text-align: left" name="planName"></td>
					<td style="text-align: center" name="year"></td>
					<td style="text-align: right" name="investmentTotal"></td>
					<td style="text-align: right" name="lastInvestmentTotal"></td>
					<td style="text-align: right" name="currentInvestmentTotal"></td>
					<td name="do">
						<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="" onclick="toView(this)">查看</a>
					</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${planlist.result }" var="plan">
					<tr>
						<td align="left">${plan.year }年度基建项目投资计划表</td>
						<td align="center">${plan.year }</td>
						<td align="right">${plan.investmentTotal }</td>
						<td align="right">${plan.lastInvestmentTotal }</td>
						<td align="right">${plan.currentInvestmentTotal }</td>
						<td>
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${plan.id }&collect=${plan.year}" onclick="toView(this)">查看</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${planlist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${planlist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${planlist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${planlist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${planlist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${planlist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${planlist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${planlist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${planlist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${planlist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${planlist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${planlist.pageIndex}");
	var PageSize = Number("${planlist.pageSize}");
	var TotalCount = Number("${planlist.totalCount}");
	
	var laydate=layui.laydate;
	laydate.render({
		elem:"input[name='handleTime']",
		type:"date",
		format:"yyyy-MM-dd"
	});
	
	laydate.render({
		elem:"input[name='year']",
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
						
						template.find("td[name='planName']").html(Result[i].year + "年度基建项目投资计划表");
						template.find("td[name='year']").html(Result[i].year);
						template.find("td[name='projectUnit']").html(Result[i].projectUnit);
						template.find("td[name='investmentTotal']").html(Result[i].investmentTotal);
						template.find("td[name='lastInvestmentTotal']").html(Result[i].lastInvestmentTotal);
						template.find("td[name='currentInvestmentTotal']").html(Result[i].currentInvestmentTotal);
						var target = template.find("td[name='do']");
						$(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id+"&collect="+Result[i].year)});
						$(target).find("a.detail").attr("data-id",Result[i].id+"&collect="+Result[i].year);
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
					}
					if(NeedDrawPage)
						DrawPageButton("pagination");
				}else{
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='"+$("#template td").length+"'>搜索目标无结果</td></tr>");
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
	
	$("#add-plan").click(function(){
		window.location.href = "${ctx}/Construction/Plan/Add.shtml";
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
		  		url:"${ctx}/Construction/Delete/Plan/"+id+".shtml",
		  		type:"post",
		  		data:{
		  			"childTable":"PlanDetail",
		  			"forignKey":"PLAN_ID"
		  		},
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
            content: '${ctx }/Construction/Plan/Detail.shtml?pid='+$(o).attr('data-id')
        });
        layer.full(index);
    }
</script>
<%@ include file="../common/AdminFooter.jsp" %>