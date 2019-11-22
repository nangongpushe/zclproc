<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">

	#data-list tr td[name="recordName"]{
		padding-left: 1%;
		text-align: left;
	 }
	#data-list tr td[name="dealSerial"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="buyer"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="seller"]{
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
		<li>轮换业务</li>
		<li>商务处理</li>
		<li class="active">商务处理记录</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="${type}/Recording.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div style="width: 80px">记录名称：</div>
						<input name="recordName" class="inputArea"/>
					</td>
					<td>
						<div>所属成交子明细：</div>
						<input name="dealSerial" class="inputArea"/>
					</td>
					<td>
						<div style="width: 80px">买方：</div>
						<input name="buyer" class="inputArea"/>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
					<tr>
						<td>
							<div style="width: 80px">卖方：</div>
							<input name="seller" class="inputArea"/>
						</td>
						<td>
							<div>经办时间:</div>
							<input name="handleTime" class="inputArea dateNeed"/>
						</td>
						<td>
							<div style="width: 80px">经办人:</div>
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
		<shiro:hasPermission name="RotateRecording:add">
		<div class="buttonArea" id="add-process">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td name="recordName"></td>
				<td name="dealSerial"></td>
				<td name="buyer"></td>
				<td name="seller"></td>
				<td name="status"></td>
				<td name="operator"></td>
				<td name="handleTime"></td>
				<td name="do">
					<shiro:hasPermission name="RotateRecording:edit">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateProcess/Recording/Add.shtml?id=">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateRecording:detail">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Recording/Add.shtml?id=">查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateRecording:delete">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete' tag="${process.id }">删除</span>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr>
					<td>记录名称</td>
					<td>所属成交子明细</td>
					<td>买方</td>
					<td>卖方</td>
					<td>状态</td>
					<td>经办人</td>
					<td>经办时间</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${processlist.result }" var="process">
					<tr>
						<td name="recordName" align="left">${process.recordName}</td>
						<td name="dealSerial" align="left">${process.dealSerial }</td>
						<td name="buyer" align="left">${process.buyer }</td>
						<td name="seller" align="left">${process.seller }</td>
						<td name="status" align="left">${process.status }</td>
						<td name="operator" align="left">${process.operator }</td>
						<td name="handleTime" align="center"><fmt:formatDate value="${process.handleTime }" pattern="yyyy年MM月dd日"/> </td>
						<td>



							<c:if test="${process.status =='待提交' or process.status == '驳回' }">
								<shiro:hasPermission name="RotateRecording:edit">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateProcess/Recording/Add.shtml?id=${process.id }">编辑</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateRecording:submit">
									<a  class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit' tag="${process.id }">提交</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateRecording:detail">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Recording/Detail.shtml?id=${process.id }">查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateRecording:delete">
									<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete' tag="${process.id }">删除</span>
								</shiro:hasPermission>
							</c:if>
							<c:if test="${process.status =='待审核'}">

							<shiro:hasPermission name="RotateRecording:pass">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass' tag="${process.id }">通过</a>
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini nopass' tag="${process.id }">驳回</a>
							</shiro:hasPermission>
								<shiro:hasPermission name="RotateRecording:detail">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Recording/Detail.shtml?id=${process.id }">查看</a>
								</shiro:hasPermission>
							</c:if>

							<c:if test="${process.status =='审核通过'}">


								<shiro:hasPermission name="RotateRecording:detail">
									<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateProcess/Recording/Detail.shtml?id=${process.id }">查看</a>
								</shiro:hasPermission>
							</c:if>





						</td>
					</tr>
				</c:forEach>
				
			<c:if test="${processlist.totalCount==0 }">
				<tr>
					<td colspan="8" align="center">搜索目标无结果</td>
				</tr>
			</c:if>
			</tbody>
			
			
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${processlist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${processlist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${processlist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${processlist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${processlist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${processlist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${processlist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${processlist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${processlist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${processlist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${processlist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>

<script>
	var PageIndex = Number("${processlist.pageIndex}");
	var PageSize = Number("${processlist.pageSize}");
	var TotalCount = Number("${processlist.totalCount}");

    $("#clearBtn").click(function () {
        $("input[name='recordName']").val("");
        $("input[name='dealSerial']").val("");
        $("input[name='buyer']").val("");
        $("input[name='seller']").val("");
        $("input[name='handleTime']").val("");
        $("input[name='operator']").val("");

    });
	var laydate=layui.laydate;
	laydate.render({
		elem:".dateNeed",
		type:"date",
		format:"yyyy-MM-dd"
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
						
						template.find("td[name='recordName']").html(Result[i].recordName);
						template.find("td[name='dealSerial']").html(Result[i].dealSerial);
						template.find("td[name='buyer']").html(Result[i].buyer);
						template.find("td[name='seller']").html(Result[i].seller);
						template.find("td[name='status']").html(Result[i].status);
						template.find("td[name='operator']").html(Result[i].operator);
						var time = new Date();
						time.setTime(Result[i].handleTime);
						template.find("td[name='operator']").html(Result[i].operator);
						template.find("td[name='handleTime']").html(time.getFullYear()+"年"+(time.getMonth() + 1)+"月"+time.getDate()+"日");
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)});
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						$(target).find(".edit,.detail,.delete").show();
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
	
	$("#add-process").click(function(){
		window.location.href = "${ctx}/RotateProcess/Recording/Add.shtml";
	});
	
	$(".delete").click(function(){
        updateState($(this),3);
	});

    $(".submit").click(function(){
        updateState($(this),0);
    });

    $(".pass").click(function(){
        updateState($(this),1);
    });
    $(".nopass").click(function(){
        updateState($(this),2);
    });


    function updateState(ele,state){
        if(state==0){
            state="待审核";
		}else if(state==1){
            state="审核通过";
		}else if(state==2){
            state="驳回";
        }else if(state==3){
            state="删除";
        }
        var self = $(ele);
        layer.confirm('你确定要'+$(self).html()+'吗？', {
            btn: ['是','否']
        }, function(){
            var id = $(self).attr("tag");
            $.ajax({
                url:"${ctx}/RotateProcess/Recording/updateState.shtml",
                type:"post",
                data:{
                    "id":id,
                    "state":state
                },
                success:function(data){
                    if(data.success){
                        layerMsgSuccess("数据"+$(self).html()+"成功",function(){
                            location.reload();
                        });
                    }else{
                        layerMsgError("数据"+$(self).html()+"失败");
                    }
                }
            });
        }, function(){

        });
    }

	function DeleteFunction(ele){
		var self = $(ele);
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(){
			var id = $(self).attr("tag");
		  	$.ajax({
		  		url:"${ctx}/RotateScheme/Delete/Process/"+id+".shtml",
		  		type:"post",
		  		data:{
		  			"childTable":"ProcessDetail",
		  			"forignKey":"PROCESS_ID"
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
</script>
<%@ include file="../common/AdminFooter.jsp" %>