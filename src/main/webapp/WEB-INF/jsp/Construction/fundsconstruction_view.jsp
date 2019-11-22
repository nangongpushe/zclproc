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
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>基建管理</li>
		<li class="active">工程拨款</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="View.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div>项目名称：</div>
						<input type="text" class="inputArea" name="projectName"/>
					</td>
					<td>
						<div>承建单位：</div>
						<input name="contractor" class="inputArea"/>
					</td>
					<td>
						<div>申报时间：</div>
						<input name="reportTime" class="inputArea"/>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
					<tr>
						<td>
							<div>工程总投资额：</div>
							<input name="investmentTotal" class="inputArea"/>
						</td>
						<td>
							<div>已预拨数：</div>
							<input name="alreadyDialed" class="inputArea" autocomplete="off" type="number" />
						</td>
						<td>
							<div>本次申请拨款额：</div>
							<input name="thisAppropriation" class="inputArea"/>
						</td>
					</tr>
					<tr>
						<td>
							<div>状态：</div>
							<select name="status" class="inputArea">
								<option value="">全部</option>
								<option>待提交</option>
								<option>审核中</option>
								<option>已通过</option>
							<!-- 	<option>上报中</option> -->
								<option>已上报</option>
								<option>已完成</option>
								<option>驳回</option>
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
		<shiro:hasPermission name="constructionFunds:add">
		<div class="buttonArea" id="add-funds">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td style="text-align: left" name="projectSerial"></td>
				<td style="text-align: left" name="projectName"></td>
				<td style="text-align: left" name="parentProject"></td>
				<td style="text-align: left" name="contractor"></td>
				<td style="text-align: center" name="reportTime"></td>
				<td style="text-align: right" name="investmentTotal"></td>
				<td style="text-align: right" name="alreadyDialed"></td>
				<td style="text-align: right" name="thisAppropriation"></td>
				<td style="text-align: left" name="status"></td>
				<td name="do">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail'  data-id="" onclick="toView(this)">查看</a>
					<shiro:hasPermission name="constructionFunds:edit">
						<c:if test="${user.originCode != 'CBL'}">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit'  href="${ctx }/Construction/Funds/Edit.shtml?cid=">编辑</a>
					<button style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit btn' >提交</button>
						</c:if>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionFunds:pass">
						<c:if test="${user.originCode != 'CBL'}">
					<button style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass btn' >通过</button>
					<button style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass btn' >驳回</button>
						</c:if>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionFunds:push">
						<c:if test="${user.originCode != 'CBL'}">
					<button style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini push btn' >上报</button>
						</c:if>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionFunds:funds">
					<button style="display:none" tag="${funds.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini funds btn'>拨款</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="constructionFunds:edit">
					<button style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete btn' >删除</button>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td>项目编号</td>
					<td>项目名称</td>
					<td>父项目编号(名称)</td>
					<td>承建单位</td>
					<td>申报时间</td>
					<td>工程总投资额</td>
					<td>已预拨数（万元）</td>
					<td>本次申请拨款额</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${fundslist.result }" var="funds">
					<tr>
						<td align="left">${funds.projectSerial }</td>
						<td  align="left">${funds.projectName }</td>
						<td  align="left"><c:if test="${not empty change.parentProject}">${change.parentProject.projectSerial}(${change.parentProject.projectName})</c:if></td>
						<td  align="left">${funds.contractor }</td>
						<td align="center">${funds.reportTime }</td>
						<td align="right">${funds.investmentTotal }</td>
						<td align="right">${funds.alreadyDialed }</td>
						<td align="right">${funds.thisAppropriation }</td>
						<td align="left">${funds.status }</td>
						<td>
						<c:choose>
							<c:when test="${funds.status eq '待提交' || funds.status eq '驳回'}"> 
								<shiro:hasPermission name="constructionFunds:edit">
									<c:if test="${user.originCode != 'CBL'}">
										<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini'  href="${ctx }/Construction/Funds/Edit.shtml?cid=${funds.id }">编辑</a>
										<button class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit btn' tag="${funds.id }">提交</button>
										<button class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete btn' tag="${funds.id }" >删除</button>
									</c:if>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${funds.status eq '审核中' or funds.status eq '上报中' or funds.status eq '已完成'}">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail btn'  data-id="${funds.id }" onclick="toView(this)">查看</a>
							</c:when>
							<c:when test="${funds.status eq '已通过'}"> 
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail'  href="${ctx }/Construction/Funds/Detail.shtml?id=${funds.id }">查看</a>
								<shiro:hasPermission name="constructionFunds:push">
									<c:if test="${user.originCode != 'CBL'}">
										<button tag="${funds.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini push btn'>上报</button>
									</c:if>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${funds.status eq '已上报' }">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail'  href="${ctx }/Construction/Funds/Detail.shtml?id=${funds.id }">查看</a>
								<shiro:hasPermission name="constructionFunds:funds">
								<button tag="${funds.id }" class='layui-btn layui-btn-primary layui-btn layui-btn-mini funds btn'>拨款</button>
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
				<input id="pageNumber" value="${fundslist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${fundslist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${fundslist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${fundslist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${fundslist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${fundslist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${fundslist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${fundslist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${fundslist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${fundslist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${fundslist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${fundslist.pageIndex}");
	var PageSize = Number("${fundslist.pageSize}");
	var TotalCount = Number("${fundslist.totalCount}");
	
	var laydate=layui.laydate;
	laydate.render({
		elem:"input[name='reportTime']",
		type:"date",
		format:"yyyy年MM月dd日"
	});
	
	$(function(){
		$(".sort-table").tablesorter(); 
		DrawPageButton("pagination");
		pageToolBar();
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
						template.find("td[name='projectName']").html(Result[i].projectName);
                        if(Result[i].parentProject!=null)
                            template.find("td[name='parentProject']").html(Result[i].parentProject.projectSerial+"("+Result[i].parentProject.projectName+")");
						template.find("td[name='contractor']").html(Result[i].contractor);
						template.find("td[name='reportTime']").html(Result[i].reportTime);
						template.find("td[name='investmentTotal']").html(Result[i].investmentTotal);
						template.find("td[name='alreadyDialed']").html(Result[i].alreadyDialed.toFixed(1));
						template.find("td[name='thisAppropriation']").html(Result[i].thisAppropriation);
						template.find("td[name='status']").html(Result[i].status);
						var target = template.find("td[name='do']");
						$(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href") + Result[i].id)});
						$(target).find("a.detail").attr("data-id",Result[i].id);
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交' || Result[i].status == '驳回'){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '审核中'||Result[i].status == '上报中'||Result[i].status == '已完成'){
							$(target).find(".detail").show();
						}else if(Result[i].status == '已通过'){
							$(target).find(".detail,.push").show();
						}else if(Result[i].status == '已上报'){
							$(target).find(".detail,.funds").show();
						}
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update");
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
	
	$("#add-funds").click(function(){
		window.location.href = "${ctx}/Construction/Funds/Add.shtml";
	});
	
	// $("input[name='alreadyDialed']").blur(function(){
	// 	if($(this).val() == ''){
	// 		$(this).val("0");
	// 	}
	// });
	
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
		  		url:"${ctx}/Construction/Delete/Funds/"+id+".shtml",
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
	
	$(".submit,.pass,.unpass,.push,.funds").click(function(){
	    $(".btn").attr("disabled",true);
        let lock = false;
		var self=this;
		var mapper = {"提交":"审核中","通过":"已通过","驳回":"驳回","上报":"已上报","拨款":"已完成"}
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(index){
		    if(!false){
		        lock = true;
				var id = $(self).attr("tag");
				$.ajax({
					url:"Edit.shtml?isEdit=1",
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
							$(".btn").attr("disabled",false);
						}
					}
				});
            }
            layer.close(index);
		}, function(){
            $(".btn").attr("disabled",false);
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
	
	function pageToolBar(){
		if((TotalCount / Number($("#pageSize").val()))<=1){
			$("#pageSelecter").addClass("pageSelecter-disable");
		}else{
			$("#pageSelecter").removeClass("pageSelecter-disable");
		}
	}
	
	$("#page-in").click(function(){
	    debugger;
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
            content: '${ctx }/Construction/Funds/Detail.shtml?id='+$(o).attr('data-id')
        });
        layer.full(index);
    }
</script>
<%@ include file="../common/AdminFooter.jsp" %>