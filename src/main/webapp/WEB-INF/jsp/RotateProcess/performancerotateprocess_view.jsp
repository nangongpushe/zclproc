<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
	#data-head tr th{
		text-align: center;
	}

	#data-list tr td[name="dealSerial"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="bidSerial"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="storehouse"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="grainType"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="status"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="operator"]{
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
	width:25%;
	padding-bottom:5px;
	text-align: center;
}

#select-parm table td>div{
	font-size:14px;
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

#tab-btn{
	margin-top: 10px;
    margin-bottom:-16px;
}

#tab-btn div{
    display: inline;
    padding:5px 10px;
    cursor:pointer;
}

.tab-select{
	border:1px solid #e2e2e2;
	background:#f2f2f2;
	border-bottom: 0;
	border-radius:2px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>商务处理</li>
		<li class="active">合同履约管理</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="${type }/Performance.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<%--<td>--%>
						<%--<div>成交子明细号：</div>--%>
						<%--<input name="dealSerial" class="inputArea"/>--%>
					<%--</td>--%>
					<td>
						<div>标的号：</div>
						<input name="bidSerial" class="inputArea" autocapitalize="off"/>
					</td>
					<td>
						<div>仓号：</div>
						<input name="storehouse" class="inputArea" autocapitalize="off"/>
					</td>
						<td>
							<div>品种:</div>
							<%--<input name="grainType" class="inputArea"/>--%>
							<select name="grainType" id="grainType" class="inputArea">
								<option value="">全部</option>
								<c:forEach items="${varietyList }" var="item">
									<option value="${item.value }">${item.value }</option>
								</c:forEach>
							</select>
						</td>
						<td>
							<div>状态：</div>
							<select name="status" class="inputArea">
								<option value="" selected>全部</option>
								<option>待提交</option>
								<option>审核中</option>
								<option>审核通过</option>
								<option>驳回</option>
							</select>
						</td>
				</tr>
				</thead>
				<tbody id="total-search">
					<tr>
						<td id="endDate">
							<div>提货/出货截止时间：</div>
							<input name="takeEnd" class="inputArea dateNeed" autocapitalize="off" />
						</td>

						<td>
							<div>操作时间:</div>
							<input name="handleTime" class="inputArea dateNeed" autocapitalize="off"/>
						</td>
						<td>
							<div>操作人：</div>
							<input name="operator" class="inputArea"/>
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
			<div class="buttonArea" id="clearBtn">清空</div>
		</div>
	</div>
	<div id="listArea">
		<shiro:hasPermission name="RotatePerformance:add">
		<div class="buttonArea" id="add-performance">新增</div>
		</shiro:hasPermission>
		<div id="tab-btn">
			<div class="tab-select">出库</div>
			<div>入库</div>
		</div>
		<table style="display:none">
			<tr id="template">
				<td name="dealSerial"></td>
				<td name="bidSerial"></td>
				<td name="storehouse"></td>
				<td class="outBound" name="takeEnd"></td>
				<td class="inBound" name="deliveryEnd"></td>
				<td name="grainType"></td>
				<td name="status"></td>
				<td name="handleTime"></td>
				<td name="operator"></td>
				<td name="do">
					<shiro:hasPermission name="RotatePerformance:edit">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateProcess/Performance/Add.shtml?id=">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotatePerformance:submit">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotatePerformance:delete">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotatePerformance:pass">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass'>通过</span>
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotatePerformance:detail">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Performance/Detail.shtml?id=">查看</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead id="data-head">
				<tr>
					<th>成交子明细号</th>
					<th>标的号</th>
					<th>仓号</th>
					<th class="outBound">提货/出货截止时间</th>
					<th class="inBound">交货截止时间</th>
					<th>品种</th>
					<th>状态</th>
					<th>操作时间</th>
					<th>操作人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${performancelist.result }" var="performance">
					<tr>
						<td name="dealSerial">${performance.dealSerial}</td>
						<td name="bidSerial">${performance.bidSerial }</td>
						<td name="storehouse">${performance.storehouse }</td>
						<td name="takeEnd" class="outBound">${performance.takeEnd }</td>
						<td name="deliveryEnd" class="inBound">${performance.deliveryEnd }</td>
						<td name="grainType">${performance.grainType }</td>
						<td name="status">${performance.status }</td>
						<td name="handleTime"><fmt:formatDate value="${performance.handleTime }" pattern="yyyy年MM月dd日"/> </td>
						<td name="operator">${performance.operator }</td>
						<td>
						<c:if test="${performance.status == '待提交' or performance.status == '驳回' }">
							<shiro:hasPermission name="RotatePerformance:edit">
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateProcess/Performance/Add.shtml?id=${performance.id }">编辑</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="RotatePerformance:submit">
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit' tag="${performance.id }">提交</span>
							</shiro:hasPermission>
							<shiro:hasPermission name="RotatePerformance:delete">
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete' tag="${performance.id }">删除</span>
							</shiro:hasPermission>
						</c:if>
						<c:if test="${performance.status == '审核中' }">
							<shiro:hasPermission name="RotatePerformance:detail">
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Performance/Detail.shtml?id=${performance.id }">查看</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="RotatePerformance:pass">
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass' tag="${performance.id }">通过</span>
							<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass' tag="${performance.id }">驳回</span>
							</shiro:hasPermission>
						</c:if>
						<c:if test="${performance.status == '审核通过' }">
							<shiro:hasPermission name="RotatePerformance:detail">
							<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Performance/Detail.shtml?id=${performance.id }">查看</a>
							</shiro:hasPermission>
						</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${performancelist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${performancelist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${performancelist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${performancelist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${performancelist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${performancelist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${performancelist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${performancelist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${performancelist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${performancelist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${performancelist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>
<form id="simple-form" style="display:none" method="Post" enctype="multipart/form-data"></form>
<script>

	$("#clearBtn").click(function () {
		$("input[name='bidSerial']").val("");
		$("input[name='storehouse']").val("");
        $("input[name='takeEnd']").val("");
        $("input[name='handleTime']").val("");
        $("input[name='operator']").val("");


		$("select[name='grainType'] option:selected").attr("selected",false);
		$("select[name='grainType']").eq(0).attr("selected",true);
        $("select[name='status'] option:selected").attr("selected",false);
        $("select[name='status']").eq(0).attr("selected",true);
    });

	var PageIndex = Number("${performancelist.pageIndex}");
	var PageSize = Number("${performancelist.pageSize}");
	var TotalCount = Number("${performancelist.totalCount}");
	
	var laydate=layui.laydate;
	$(".dateNeed").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	})
	
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
	
	$(function(){
		//$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
		if($(".tab-select").html() == '入库'){
			$(".outBound").hide();
			$(".inBound").show();
		}else{
			$(".inBound").hide();
			$(".outBound").show();
		}
	});
	
	$("#tab-btn>div").click(function(){
		if($(".tab-select").html() == $(this).html()){
			return;
		}
		$(this).siblings().removeClass("tab-select");
		$(this).addClass("tab-select");
		if($(".tab-select").html() == '入库'){
			$(".outBound").hide();
			$(".inBound").show();

			$("#endDate div").html("交货截止时间：");
            $("#endDate input").attr("name","deliveryEnd");

		}else{
			$(".inBound").hide();
			$(".outBound").show();

            $("#endDate div").html("提货/出货截止时间：");
            $("#endDate input").attr("name","takeEnd");
		}
		FormSubmit(true);
	});

	function FormSubmit(NeedDrawPage){
		$("#select-parm").ajaxSubmit({
			data:{
				"type":$(".tab-select").html(),
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
						template.find("td[name='dealSerial']").html(Result[i].dealSerial);
						template.find("td[name='bidSerial']").html(Result[i].bidSerial);
						template.find("td[name='storehouse']").html(Result[i].storehouse);
						template.find("td[name='takeEnd']").html(Result[i].takeEnd);
						template.find("td[name='deliveryEnd']").html(Result[i].deliveryEnd);
						template.find("td[name='grainType']").html(Result[i].grainType);
						template.find("td[name='status']").html(Result[i].status);
						var time = new Date();
						time.setTime(Result[i].handleTime);
						template.find("td[name='operator']").html(Result[i].operator);
						template.find("td[name='handleTime']").html(time.getFullYear()+"年"+(time.getMonth() + 1)+"月"+time.getDate()+"日");
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)})
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交' || Result[i].status == '驳回'){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '审核中'){
							$(target).find(".detail,.pass,.unpass").show();
						}else if(Result[i].status == '审核通过'){
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
	
	$("#add-performance").click(function(){
		window.location.href = "${ctx}/RotateProcess/Performance/Add.shtml";
	});
	
	$(".submit,.pass,.unpass").click(function(){
		var mapper = {"提交":"审核中","通过":"审核通过","驳回":"驳回"}
		var self = $(this);
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$("#simple-form").ajaxSubmit({
		  		url:"${ctx}/RotateProcess/Performance/Edit.shtml",
		  		type:"post",
		  		data:{
		  			"status":mapper[$(self).html()],
		  			"id":id
		  		},
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
		  		url:"${ctx}/Construction/Delete/Performance/"+id+".shtml",
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
</script>
<%@ include file="../common/AdminFooter.jsp" %>