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

.select-title{
	width: 100px;
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
		<li class="active">入库通知书</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="${type }/In/List.shtml" method="POST" class="layui-form">
			<table>
				<thead>
				<tr>
					<td>
						<div style="width: 100px">通知书编号：</div>
						<div class="">
							<input type="text" class="layui-input" id="scheme-name" name="noticeSerial" autocomplete="off"/>
						</div>
					</td>
					<td>
						<div style="width: 100px">接收单位：</div>
						<div>
							<select name="storeEnterprise.id" lay-search lay-skin="primary">
								<option value="" selected="selected">全部</option>
								<c:forEach items="${basepoints }" var="point">
									<option value="${point.id}">${point.enterpriseName}</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td>
						<div style="width: 100px">入库截止时间：</div>
						<div><input id="storage-date" name="storageDate" class="layui-input" autocomplete="off"/></div>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
				<tr>
					<td>
						<div style="width: 100px">文号：</div>
						<div><input name="documentNumber" class="layui-input" autocomplete="off"/></div>
					</td>
					<td>
						<div style="width: 100px">经办人：</div>
						<div><input name="creater" class="layui-input" autocomplete="off"/></div>
					</td>
					<td>
						<div style="width: 100px">经办时间：</div>
						<div><input id="create-time" name="createTime" class="layui-input" autocomplete="off"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div style="width: 100px">状态：</div>
						<select class="" name="status">
							<option selected="selected" >全部</option>
							<option>待提交</option>
							<option>驳回</option>
							<option>待审核</option>
							<option>待签发</option>
							<option>已完成</option>
						</select>
					</td>
					<td>
						<div style="width: 100px">分发时间：</div>
						<div><input id="complete-date" name="completeDate" class="layui-input" autocomplete="off"/></div>
					</td>
					<td>
						<div style="width: 100px">回单状态：</div>
						<select name="reportProgress">
							<option value="">全部</option>
							<option value="1">是</option>
							<option value="0">否</option>
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
		<shiro:hasPermission name="RotateNotice:add">
		<div class="buttonArea" id="add-inboundnotif">新增 </div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td name="noticeSerial" align="left"><a></a></td>
				<td name="accepteUnit" align="left"></td>
				<td name="storageDate"></td>
				<td name="documentNumber" align="left"></td>
				<td name="creater" align="left"></td>
				<td name="createtime"></td>
				<td name="status" align="left"></td>
				<td name="completeDate"></td>
				<td name="do">
					<shiro:hasPermission name="RotateNotice:edit">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateNotif/newIn/newEdit.shtml?nId=">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateNotice:detail">
					<a style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Detail.shtml?nId=">查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateNotice:detail">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit'>提交</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateNotice:pass">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass'>通过</span>
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass'>驳回</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateNotice:push">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini push'>签发</span>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateNotice:delete">
					<span style="display:none" class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete'>删除</span>
					</shiro:hasPermission>				
				</td>
			</tr>
		</table>
		<table class="layui-table">
			<thead>
				<tr>
					<td>通知书编号</td>
					<td>接收单位</td>
					<td>入库截止时间</td>
					<td>文号</td>
					<td>经办人</td>
					<td>经办时间</td>
					<td>状态</td>
					<td>分发时间</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${noticelist.result }" var="notice">
					<tr <c:if test="${!notice.reportProgress}">style="background-color: rgb(255,192,203)"</c:if> <c:if test="${notice.reportProgress}">style="background-color: rgb(176,224,230)"</c:if>>
						<td align="left">${notice.noticeSerial }</td>
						<td align="left">${notice.storeEnterprise.enterpriseName }</td>
						<td><fmt:formatDate value="${notice.storageDate }" pattern="yyyy年MM月dd日" /></td>
						<td align="left">${notice.documentNumber }</td>
						<td align="left">${notice.creater }</td>
						<td><fmt:formatDate value="${notice.createTime }" pattern="yyyy年MM月dd日" /></td>
						<td align="left">${notice.status }</td>
						<td>
						<c:choose >
							<c:when test="${notice.completeDate != null }">
								<fmt:formatDate value="${notice.completeDate }" pattern="yyyy年MM月dd日" />
							</c:when>
							<c:otherwise>
								———
							</c:otherwise>
						</c:choose>
						</td>
						<td>
						<c:choose>
							<c:when test="${notice.status == '待提交' or notice.status == '驳回'}">
								<shiro:hasPermission name="RotateNotice:edit">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateNotif/newIn/newEdit.shtml?nId=${notice.id }">编辑</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateNotice:submit">
								<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini submit' tag="${notice.id }">提交</span>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateNotice:delete">
								<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini delete' tag="${notice.id }">删除</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${notice.status == '待审核'}">
								<shiro:hasPermission name="RotateNotice:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Detail.shtml?nId=${notice.id }">查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateNotice:pass">
								<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini pass' tag="${notice.id }">通过</span>
								<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini unpass' tag="${notice.id }">驳回</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${notice.status == '待签发'}">
								<shiro:hasPermission name="RotateNotice:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Detail.shtml?nId=${notice.id }">查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateNotice:push">
								<span class='layui-btn layui-btn-primary layui-btn layui-btn-mini push' tag="${notice.id }">签发</span>
								</shiro:hasPermission>
							</c:when>
							<c:when test="${notice.status == '已完成'}">
								<shiro:hasPermission name="RotateNotice:edit">
								<%--<c:if test="${targetIdentity eq 'warehouse' }">--%>
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini edit' href="${ctx }/RotateNotif/newIn/newEdit.shtml?nId=${notice.id }">编辑</a>
								<%--</c:if>--%>
								</shiro:hasPermission>
								<shiro:hasPermission name="RotateNotice:detail">
								<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' href="${ctx }/RotateNotif/Detail.shtml?nId=${notice.id }">查看</a>
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
				<input id="pageNumber" value="${noticelist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${noticelist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${noticelist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${noticelist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${noticelist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${noticelist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${noticelist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${noticelist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${noticelist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${noticelist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${noticelist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>
<form id="simple-form" style="display:none" enctype="multipart/form-data"></form>
<script>
	var PageIndex = Number("${noticelist.pageIndex}");
	var PageSize = Number("${noticelist.pageSize}");
	var TotalCount = Number("${noticelist.totalCount}");

	layui.use("form",function () {
		var form = layui.form;
		form.render("select");
    })


	var laydate=layui.laydate;
	laydate.render({
		elem:"#storage-date",
		type:"date",
		format:"yyyy-MM-dd",	
	});
	
	laydate.render({
		elem:"#complete-date",
		type:"date",
		format:"yyyy-MM-dd",	
	});
	
	laydate.render({
		elem:"#create-time",
		type:"date",
		format:"yyyy-MM-dd",	
	});
	
	$(function(){
		DrawPageButton("pagination");
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
						if(Result[i].reportProgress){
                            template.css("background-color","rgb(176,224,230)")
						}else{
						    template.css("background-color","rgb(255,192,203)")
						}

						
						template.find("td[name='noticeSerial']").html(Result[i].noticeSerial);
						template.find("td[name='accepteUnit']").html(Result[i].storeEnterprise==null?"":Result[i].storeEnterprise.enterpriseName);
						var time_s = Result[i].storageDate.split('-');
						template.find("td[name='storageDate']").html(time_s[0]+"年"+time_s[1]+"月"+time_s[2]+"日");
						
						template.find("td[name='documentNumber']").html(Result[i].documentNumber);
						template.find("td[name='creater']").html(Result[i].creater);
						var time = new Date();
						time.setTime(Result[i].createTime);
						template.find("td[name='createtime']").html(time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+(time.getDate()<10?'0'+time.getDate():time.getDate())+"日");
						time.setTime(Result[i].createTime);
						template.find("td[name='completeDate']").html(Result[i].completeDate!=null?time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+(time.getDate()<10?'0'+time.getDate():time.getDate())+"日":"———");
						template.find("td[name='status']").html(Result[i].status);
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).attr("href",$(this).attr("href")+Result[i].id)});
						$(target).find("span").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].status == '待提交'||Result[i].status == '驳回'){
							$(target).find(".edit,.submit,.delete").show();
						}else if(Result[i].status == '待审核'){
							$(target).find(".detail,.pass,.unpass").show();
						}else if(Result[i].status == '待签发'){
							$(target).find(".detail,.push").show();
						}else if(Result[i].status == '已完成'){
							$(target).find(".detail").show();
							if(${targetIdentity eq 'warehouse'})
								$(target).find(".edit").show();
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
        layui.form.render("select");
    };
	
	$("#add-inboundnotif").click(function(){
		window.location.href = "${ctx}/RotateNotif/In/Add.shtml";
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
	
	$(".submit,.pass,.unpass,.push").click(function(){
		var stateMapper = {"提交":"待审核","通过":"待签发","驳回":"驳回","签发":"已完成"}
		var self= this;
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function( index ){
		    layer.close(index);
			let data = {
                "status":stateMapper[$(self).html()],
                "id":$(self).attr("tag"),
            };
		    if($(self).hasClass("push")){
				let html = ' <div class="row" style="width: 420px;  margin-left:7px; margin-top:10px;">'
                    +'<div class="col-sm-12">'
                    +'<div class="input-group">'
                    +'<span class="input-group-addon"> 签发日期（若未填写默认当前日期）：</span>'
                    +'<input id="completeDate" type="text" class="form-control" autocomplete="off" readonly>'
                    +'</div>'
                    +'</div>'
                    +'</div>';
                layer.open({
					type:1,
					title:"请输入签发日期",
                	skin:'layui-layer-rim',
                    area:['450px', 'auto'],
                    content: html,
                    btn:['保存'],
                    btn1: function (index,layero) {
                        data["completeDate"] = $("#completeDate").val();
                        updateStatus(data);
                        layer.close(index);
                    },
				});
                layui.use("laydate",function () {
					var laydate = layui.laydate;

					laydate.render({
                        elem:"#completeDate",
                        format: 'yyyy-MM-dd',
                        btns: ['clear', 'confirm'],
					});
                });
			}else {
                updateStatus(data);
			}


		}, function(){
		  
		});
	})

	function updateStatus(data){
        $("#simple-form").ajaxSubmit({
            url:"${ctx }/RotateNotif/In/Edit.shtml",
            data:data,
            type:"post",
            success:function(data){
                if(data.success){
                    layerMsgSuccess("状态更改成功",function(){
                        location.reload();
                    });
                }else{
                    if(data.msg)
                        layerMsgError(data.msg);
                    else
                    	layerMsgError("状态更改失败");
                }
            }
        });
	}
	
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
		  		url:"${ctx}/RotateScheme/Delete/Notice/"+id+".shtml",
		  		type:"post",
		  		data:{
		  			"childTable":"NoticeDetail",
		  			"forignKey":"NOTICE_ID"
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
</script>
<%@ include file="../common/AdminFooter.jsp" %>