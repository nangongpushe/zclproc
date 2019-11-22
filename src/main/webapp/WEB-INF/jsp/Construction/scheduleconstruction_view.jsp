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
	width: 45%;
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
#select-parm table td>div{
	width:50%;
	display:inline-block;
	text-align:left;
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
		<li class="active">工程进度</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="View.shtml" method="POST">
			<table>
				<thead>
					<tr>
						<td>
							<div>年月：</div>
							<input type="text" class="inputArea" name="yearMonth" />
						</td>
						<td>
							<div>上报时间：</div>
							<input type="text" class="inputArea dateNeed" name="reportTime" />
						</td>
						<td>
							<div>批准投资小计：</div>
							<input name="approvedInvestmentSubtotal" type="number" class="inputArea" value=""/>
						</td>
					</tr>
				</thead>
				<tbody id="total-search">
				<tr>
					<td>
						<div>本月完成投资小计：</div>
						<input name="currentInvestmentSubtotal" type="number" class="inputArea"  value=""/>
					</td>
					<td>
						<div>累计完成投资小计：</div>
						<input name="accumulateInvestmentSubtotal" type="number" class="inputArea"  value=""/>
					</td>
					<td>
						<div>状态：</div>
						<select name="status" class="inputArea">
							<option value="">全部</option>
							<option>待提交</option>
							<option>审核中</option>
							<option>已通过</option>
							<option>已汇总</option>
							<option>驳回</option>
						</select>
					</td>
				</tr>
				<tr <c:if test="${ident ne null}">style="display:none"</c:if>>
					<td>
						<div>项目单位：</div>
						<input name="projectUnit" class="inputArea" />
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
		<shiro:hasPermission name="constructionSchedule:add">
		<div class="buttonArea" id="add-schedule">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td style="text-align: left" name="reportTableName"></td>
				<td style="text-align: center" name="yearMonth"></td>
				<td style="text-align: left" name="projectUnit"></td>
				<td style="text-align: center" name="handleTime"></td>
				<td style="text-align: center" name="reportTime"></td>
				<td style="text-align: right" name="approvedInvestmentSubtotal"></td>
				<td style="text-align: right" name="currentInvestmentSubtotal"></td>
				<td style="text-align: right" name="accumulateInvestmentSubtotal"></td>
				<td style="text-align: left" name="status"></td>
				<td name="do">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${schedule.id }" onclick="toView(this)">查看</a>
					<shiro:hasPermission name="constructionSchedule:edit">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/Construction/Schedule/Edit.shtml?cid=${schedule.id }">编辑</a>
					<span style="display:none" tag='${schedule.id }' class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionSchedule:collect">
					<span style="display:none" tag='${schedule.id }' class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionSchedule:push">
					<span style="display:none" tag='${schedule.id }' class='layui-btn layui-btn-primary layui-btn layui-btn-mini push'>上报</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionSchedule:collect">
					<span style="display:none" tag='${schedule.id }' class='layui-btn layui-btn-primary layui-btn layui-btn-mini collect'>汇总</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionSchedule:edit">
					<span style="display:none" tag='${schedule.id }' class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td>上报表名称</td>
					<td>年月</td>
					<td>项目单位</td>
					<td>经办时间</td>
					<td>上报时间</td>
					<td>批准投资小计(万元)</td>
					<td>本月完成投资小计(万元)</td>
					<td>累计完成投资小计(万元)</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${schedulelist.result }" var="schedule">
					<tr>
						<td align="left">${schedule.yearMonth }基建项目完成情况报表</td>
						<td align="center">${schedule.yearMonth }</td>
						<td align="left">${schedule.projectUnit }</td>
						<td align="center"><fmt:formatDate value="${schedule.handleTime }" pattern="yyyy年MM月dd日"/></td>
						<td align="center">${schedule.reportTime }</td>
						<td align="right">${schedule.approvedInvestmentSubtotal }</td>
						<td align="right">${schedule.currentInvestmentSubtotal }</td>
						<td align="right">${schedule.accumulateInvestmentSubtotal }</td>
						<td align="left">${schedule.status }</td>
						<td>
							<c:choose>
								<c:when test="${schedule.status == '待提交' or schedule.status == '驳回'}">
									<shiro:hasPermission name="constructionSchedule:edit">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/Construction/Schedule/Edit.shtml?cid=${schedule.id }">编辑</a>
									<span tag=${schedule.id } class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
									<span tag=${schedule.id } class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
									</shiro:hasPermission>
								</c:when>
								<c:when test="${schedule.status == '审核中'}">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${schedule.id }" onclick="toView(this)">查看</a>
								</c:when>
								<c:when test="${schedule.status == '已通过'}">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${schedule.id }" onclick="toView(this)">查看</a>
									<c:if test="${ schedule.investmentQuota == 1 }">
									<shiro:hasPermission name="constructionSchedule:push">
									<span tag=${schedule.id } class='layui-btn layui-btn-primary layui-btn layui-btn-mini push'>上报</span>
									</shiro:hasPermission>
									</c:if>
								</c:when>
								<c:when test="${schedule.status == '待汇总' and  schedule.investmentQuota == 1}">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${schedule.id }" onclick="toView(this)">查看</a>
									<shiro:hasPermission name="constructionSchedule:collect">
									<span tag=${schedule.id } class='layui-btn layui-btn-primary layui-btn layui-btn-mini collect'>汇总</span>
									<span tag=${schedule.id } class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
									</shiro:hasPermission>
								</c:when>
								<c:when test="${schedule.status == '已汇总' and  schedule.investmentQuota == 1}">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini' href="${ctx }/Construction/Schedule/Detail.shtml?id=${schedule.id }">查看</a>
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
				<input id="pageNumber" value="${schedulelist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${schedulelist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${schedulelist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${schedulelist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${schedulelist.pageIndex}");
	var PageSize = Number("${schedulelist.pageSize}");
	var TotalCount = Number("${schedulelist.totalCount}");

	var laydate = layui.laydate;
	laydate.render({
		elem : "input[name='yearMonth']",
		type : "month",
		format:"yyyy年MM月"
	});
	
	laydate.render({
		elem : "input[name='reportTime']",
		type : "date",
		format:"yyyy年MM月dd日"
	});

	$(function() {
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
	});
	$("input[name='approvedInvestmentSubtotal'],input[name='currentInvestmentSubtotal'],input[name='accumulateInvestmentSubtotal']").blur(function(){
		if($(this).val() == '')
			$(this).val("0");
	});
	

	function FormSubmit(NeedDrawPage) {
		$("#select-parm").ajaxSubmit({
			data : {
				"pageindex" : PageIndex,
				"pagesize" : PageSize,
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
						template.find("td[name='reportTableName']").html(Result[i].yearMonth+"基建项目完成情况报表")
						template.find("td[name='yearMonth']").html(Result[i].yearMonth);
						template.find("td[name='projectUnit']").html(Result[i].projectUnit);
                        var time = new Date();
                        time.setTime(Result[i].handleTime);
                        template.find("td[name='handleTime']").html(time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+(time.getDate()<10?'0'+time.getDate():time.getDate())+"日");
                        /*template.find("td[name='handleTime']").html(Result[i].handleTime);*/
						template.find("td[name='reportTime']").html(Result[i].reportTime);
						template.find("td[name='approvedInvestmentSubtotal']").html(Result[i].approvedInvestmentSubtotal.toFixed(1));
						template.find("td[name='currentInvestmentSubtotal']").html(Result[i].currentInvestmentSubtotal.toFixed(1));
						template.find("td[name='accumulateInvestmentSubtotal']").html(Result[i].accumulateInvestmentSubtotal.toFixed(1));
						template.find("td[name='status']").html(Result[i].status);
						var target = template.find("td[name='do']");
						$(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href") + Result[i].id)});
						$(target).find("a.detail").attr("data-id", Result[i].id);
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交' || Result[i].status == '驳回'){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '审核中'){
							$(target).find(".detail").show();
						}else if(Result[i].status == '已通过'){
							$(target).find(".detail").show();
							if(Result[i].investmentQuota == 1)
								$(target).find(".push").show();
						}else if(Result[i].status == '待汇总' && Result[i].investmentQuota == 1){
							$(target).find(".detail,.collect,.unpass").show();
						}else if(Result[i].status == '已汇总' && Result[i].investmentQuota == 1){
							$(target).find(".detail").show();
						}
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
					}
					if (NeedDrawPage)
						DrawPageButton("pagination");
				} else {
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='"+$("#template>td").length+"'>搜索目标无结果</td></tr>");
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

	$("#add-schedule").click(function() {
		window.location.href = "${ctx}/Construction/Schedule/Add.shtml";
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
		  		url:"${ctx}/Construction/Delete/Schedule/"+id+".shtml",
		  		type:"post",
		  		data:{
		  			"childTable":"ScheduleDetail",
		  			"forignKey":"SCHEDULE_ID"
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
	var saveFlag=0;
	$(".submit,.pass,.unpass,.push,.collect").click(function(){
		var self=this;
		var mapper = {"提交":"审核中","通过":"已通过","驳回":"驳回","上报":"待汇总","汇总":"已汇总"};
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
			if(saveFlag==1){
			    return;
			}
			saveFlag=1;
		  	$.ajax({
		  		url:"Edit.shtml",
		  		data:{
		  			"status":mapper[$(self).html()],
		  			"id":id
		  		},
		  		type:"post",
		  		success:function(data){
                    saveFlag=0;
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
            content: '${ctx }/Construction/Schedule/Detail.shtml?id='+$(o).attr('data-id')
        });
        layer.full(index);
    }
</script>
<%@ include file="../common/AdminFooter.jsp"%>