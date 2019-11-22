<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	width:40%;
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
		<li>轮换业务</li>
		<li>通知书管理</li>
		<li class="active">提货单</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="Take/${type }.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
                        提货单编号：
						<input type="text" class="inputArea" name="serial" autocomplete="off"/>

					</td>

					<td>
						接收库点：
						<input name="receiveWarehouse" class="inputArea" autocomplete="off"/>
					</td>
					<td>
						分发时间：
						<input name="completeDate" class="inputArea dateNeed" autocomplete="off"/>
					</td>
					</td>
					<%--<td>
						<div>所属成交结果子明细号：</div>
						<input name="dealSerial" class="inputArea"/>
					</td>--%>
				</tr>
				</thead>
				<tbody id="total-search">
					<tr>
						<td>
							经 办 人 ：
							<input name="creater" class="inputArea" autocomplete="off"/>
						</td>
						<td>
							经办时间：
							<input name="createDate" class="inputArea dateNeed" autocomplete="off"/>
						</td>
						<td> 
							状态:
							<select name="status" class="inputArea">
								<option selected="selected" value="">全部</option>
								<option>待提交</option>
								<option>驳回</option>
								<option>待审核</option>
								<option>待签发</option>
								<option>已完成</option>
							</select>
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
			<div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>
		</div>

	</div>
	<div id="listArea">
		<shiro:hasPermission name="RotateTake:add">
		<div class="buttonArea" id="add-take">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td name="serial" align="left" style="width: 6%"></td>
				<td name="receiveWarehouse" align="left" style="width: 10%"></td>
				<td name="storeHouses" align="left" style="width: 15%"></td>
				<td name="creater" align="left" style="width: 6%"></td>
				<td name="payCompany" align="left" style="width: 35%"></td>
				<td name="createDate" style="width: 6%"></td>
				<td name="status" align="left" style="width: 5%"></td>
				<td name='completeDate' style="width: 6%"></td>
				<td name="do" style="width: 15%">
					<shiro:hasPermission name="RotateTake:edit">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateNotif/Take/Add.shtml?id=">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateTake:detail">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Take/Detail.shtml?id=">查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateTake:submit">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateTake:delete">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateTake:pass">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass'>通过</span>
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateTake:push">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini push'>签发</span>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td>提货单编号</td>
					<td>接收库点</td>
					<td>仓号</td>
					<td>经办人</td>
					<td>来款单位</td>
					<td>经办时间</td>
					<td>状态</td>
					<td>分发时间</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${takelist.result }" var="take">
					<tr>
						<td align="left" style="width: 6%">${take.serial }</td>
						<td align="left" style="width: 10%">${take.receiveWarehouse }</td>
						<td align="left" style="width: 15%">${take.storeHouses}</td>
						<td align="left" style="width: 6%">${take.creater }</td>
						<td align="left" style="width: 35%">${take.payCompany}</td>
						<td style="width: 6%"><fmt:formatDate value="${take.createDate }" pattern="yyyy-MM-dd" /></td>
						<td align="left" style="width: 5%">${take.status }</td>
						<td style="width: 6%">
						<c:choose>
							<c:when test="${take.completeDate eq null }">
							———
							</c:when>	
							<c:otherwise>
							<fmt:formatDate value="${take.completeDate}" pattern="yyyy-MM-dd HH:mm"/>
							</c:otherwise>					
						</c:choose>
						</td>
						<td style="width: 15%">
						<c:choose>
							<c:when test="${take.status eq '待提交' or take.status eq '驳回'}">
								<shiro:hasPermission name="RotateTake:edit">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateNotif/Take/Add.shtml?id=${take.id }">编辑</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateTake:submit">
								<span tag="${take.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateTake:delete">
								<span tag="${take.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${take.status eq '待审核'}">
								<shiro:hasPermission name="RotateTake:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Take/Detail.shtml?id=${take.id }">查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateTake:pass">
								<span tag="${take.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass'>通过</span>
								<span tag="${take.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${take.status eq '待签发'}">
								<shiro:hasPermission name="RotateTake:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Take/Detail.shtml?id=${take.id }">查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateTake:push">
								<span tag="${take.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini push'>签发</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${take.status eq '已完成'}">
								<shiro:hasPermission name="RotateTake:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Take/Detail.shtml?id=${take.id }">查看</a>
								</shiro:hasPermission>
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
				<input id="pageNumber" value="${takelist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${takelist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${takelist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${takelist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${takelist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${takelist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${takelist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${takelist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${takelist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${takelist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${takelist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>
<form style="display:none;" id="simpleForm" enctype="multipart/form-data"></form>
<script>
	var PageIndex = Number("${takelist.pageIndex}");
	var PageSize = Number("${takelist.pageSize}");
	var TotalCount = Number("${takelist.totalCount}");
	
	var laydate=layui.laydate;
	$(".dateNeed").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	});
	
	$(function(){
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
	});


	
	function FormSubmit(NeedDrawPage){
		$.ajax({
			url:"${ctx}/RotateNotif/Take/"+PageIndex+".shtml",
			type:"post",
			contentType:"application/json",
			data: JSON.stringify({
				"serial": $("#select-parm input[name='serial']").val(),
				"receiveWarehouse": $("#select-parm input[name='receiveWarehouse']").val(),
				"completeDate":$("#select-parm input[name='completeDate']").val(),
				"creater":$("#select-parm input[name='creater']").val(),
				"createDate":$("#select-parm input[name='createDate']").val(),
				"status":$("#select-parm select[name='status']").val(),
			}),
			success:function(data){
				$("#data-list").empty();
				TotalCount = data.totalCount;
				$("#total").html(TotalCount);
				if(data.totalCount > 0){
					var Result = data.result;
					for(var i = 0;i < Result.length; i++){
						var template = $("#template").clone(true);
						template.attr("id","");

						template.find("td[name='serial']").html(Result[i].serial)
						template.find("td[name='receiveWarehouse']").html(Result[i].receiveWarehouse);
						template.find("td[name='storeHouses']").html(Result[i].storeHouses);
						template.find("td[name='creater']").html(Result[i].creater);
						template.find("td[name='payCompany']").html(Result[i].payCompany);
						var time = new Date();
						time.setTime(Result[i].createDate);
						template.find("td[name='createDate']").html(time.getFullYear()+"-"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"-"+time.getDate());
						template.find("td[name='status']").html(Result[i].status);
						time.setTime(Result[i].completeDate);
						template.find("td[name='completeDate']").html(Result[i].completeDate==null?'———':time.getFullYear()+"-"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"-"+time.getDate()+" "+time.getHours()+":"+time.getMinutes());
						template.find("td[name='status']").html(Result[i].status);
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)});
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交' || Result[i].status == '驳回'){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '待审核'){
							$(target).find(".detail,.pass,.unpass").show();
						}else if(Result[i].status == '待签发'){
							$(target).find(".detail,.push").show();
						}else if(Result[i].status == '已完成'){
							$(target).find(".detail").show();
						}
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
					}
					if(NeedDrawPage)
						DrawPageButton("pagination");
				}else{
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='9'>搜索目标无结果</td></tr>");
					DrawPageButton("pagination");
				}
			}
		})
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
    function chongzi(){
        document.getElementById("select-parm").reset();
        FormSubmit(true);
    };
	
	$("#add-take").click(function(){
		window.location.href = "${ctx}/RotateNotif/Take/Add.shtml";
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
		  		url:"${ctx}/RotateScheme/Delete/TakeMain/"+id+".shtml",
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
	
	$(".submit,.pass,.unpass,.push").click(function(){
		var stateMapper = {"提交":"待审核","通过":"待签发","驳回":"驳回","签发":"已完成"}
		var self= this;
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$.ajax({
		  		url:"${ctx }/RotateNotif/Take/Edit.shtml",
		  		data:JSON.stringify({
		  			"status":stateMapper[$(self).html()],
		  			"id":id
		  		}),
		  		type:"post",
				contentType: "application/json",
		  		success:function(data){
		  			if(data.success){
		  				layerMsgSuccess("状态更改成功",function(){
		  					location.reload();
		  				});
		  			}else{
		  				layerMsgError("状态更改失败");
		  			}
		  		}
		  	});
		}, function(){
		  
		});
	});

</script>
<%@ include file="../common/AdminFooter.jsp" %>