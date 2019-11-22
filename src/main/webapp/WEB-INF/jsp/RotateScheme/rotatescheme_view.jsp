<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp" %> 
<%@ page trimDirectiveWhitespaces="true" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style type="text/css">
#data-list tr td[data-field="originId"],td[data-field="schemeName"],td[data-field="schemeType"],td[data-field="rotateType"],td[data-field="executeState"]{
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

#infoArea>form>div {
	display: inline;
	margin-right: 2%;
}

.selectArea {
	padding: 5px;
	outline: none;
	border: 1px solid #ccc;
	resize: none;
}

.inputArea {
	width: 90%;
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
}
table {
	margin-top: 20px;
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

thead {
	background: #eee;
}

table tr td {
	border: none;
	padding: 10px 0;
}

tbody tr {
	border-bottom: 1px solid #ccc;
} 

#jockerLay{
	background:#f2f2f2;
    border: 1px solid #e2e2e2;
    border-top:none;
	display: none;
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

#tableHead>th{
    text-align: center;
}

#template{
	display:none
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换方案</li>
		<li class="active">方案列表</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<div id="infoArea">
		<form id="select-parm" action="${type }/List.shtml" method="POST"  onsubmit="return false;">
		<table>
			<tr style="border:none;">
			<td>
				<span>方案名称：</span>
				<input type="text" class="selectArea" id="scheme-name" placeholder="请输入" name="schemeName" onkeydown='if(event.keyCode==13) return false;'/>
			</td>
			<td>
				<span>轮换类别：</span> 
				<select id="scheme-type" class="selectArea" name="schemeType">
					<option selected="selected" value="">全部</option>
				</select>
			</td>
			<td>
				<span>轮换方式：</span> 
				<select id="rotate-type" class="selectArea" name="rotateType">
					<option selected="selected" value="">全部</option>
				</select>
			</td>
			<td>
				<span>执行状态：</span> 
				<select class="selectArea" name="executeState">
					<option selected="selected" value="">全部</option>
					<option>未执行</option>
					<option>执行中</option>
					<option>已完成</option>
				</select>
			</td>
			<td>
			<div class="buttonArea" id="select-button">查询</div>
			</td>
				<td>
					<div class="buttonArea" id="clear-button">清空</div>
				</td>
			</tr>
			</table>
		</form>
		</div>
	</div>
	<div id="listArea">
		<table style="display:none">
			<tr id="template">
				<td data-field="originId" name='originName'></td>
				<td data-field="year" name="year"></td>
				<td data-field="schemeName" name="schemeName"></td>
				<td data-field="schemeType" name="schemeType"></td>
				<td data-field="rotateType" name="rotateType"></td>
				<td data-field="completeDate" name="completeDate"></td>
				<td data-field="executeState" name="executeState"></td>
				<td name="do">
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" onclick="goToDetailPage(this)" data-href="${ctx }/RotateScheme/Detail.shtml?sid=">查看</a>
					<shiro:hasPermission name="RotateScheme:delete">
						<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini delete">删除</span>
					</shiro:hasPermission>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
				<tr id="tableHead">
					<th>所属计划</th>
					<th>计划年份</th>
					<th>方案名称</th>
					<th>轮换类别</th>
					<th>轮换方式</th>
					<th>分发时间</th>
					<th>执行状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="data-list">
				<%--<c:forEach items="${schemelist.result }" var="scheme">--%>
					<%--<tr>--%>
						<%--<td data-field="originId">${originMapper[scheme.originId] }</td>--%>
						<%--<td data-field="year">${scheme.year }</td>--%>
						<%--<td data-field="schemeName">${scheme.schemeName }</td>--%>
						<%--<td data-field="schemeType">${scheme.schemeType }</td>--%>
						<%--<td data-field="rotateType">${scheme.rotateType }</td>--%>
						<%--<td data-field="completeDate">--%>
							<%--<c:choose>--%>
								<%--<c:when test="${scheme.completeDate == null}">--%>
									<%--———--%>
								<%--</c:when>--%>
								<%--<c:otherwise>--%>
									<%--<fmt:formatDate value="${scheme.completeDate}" pattern="yyyy年MM月dd日" />--%>
								<%--</c:otherwise>--%>
							<%--</c:choose>--%>
						<%--</td>--%>
						<%--<td data-field="executeState">${scheme.executeState }</td>--%>
						<%--<td><a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateScheme/Detail.shtml?sid=${scheme.id}&type=${type }">查看</a></td>--%>
					<%--</tr>--%>
				<%--</c:forEach>--%>
			</tbody>
		</table>
		<div id="jockerLay">
			<div  id="pagination" class="pull-right"></div>
			<div id="pageSelecter">
				<span style="padding-right:5px">到第</span>
				<input id="pageNumber" value="${schemelist.pageIndex}" style="display:inline;text-align:center;"/>
				<span style="padding-left:5px">页</span>
				<div id="page-in">确定</div>
			</div>
			<div style="display:inline;height:26px;">
				<span style="padding-right:5px">共</span><span id="total">${schemelist.totalCount}</span><span style="padding-left:5px">条</span>
				<select id="pageSize" style="border-radius:2px;border:1px #ccc solid;height:26px;">
					<option <c:if test="${schemelist.pageSize == 10}">selected</c:if> value="10">10 条/页</option>
					<option <c:if test="${schemelist.pageSize == 20}">selected</c:if> value="20">20 条/页</option>
					<option <c:if test="${schemelist.pageSize == 30}">selected</c:if> value="30">30 条/页</option>
					<option <c:if test="${schemelist.pageSize == 40}">selected</c:if> value="40">40 条/页</option>
					<option <c:if test="${schemelist.pageSize == 50}">selected</c:if> value="50">50 条/页</option>
					<option <c:if test="${schemelist.pageSize == 60}">selected</c:if> value="60">60 条/页</option>
					<option <c:if test="${schemelist.pageSize == 70}">selected</c:if> value="70">70 条/页</option>
					<option <c:if test="${schemelist.pageSize == 80}">selected</c:if> value="80">80 条/页</option>
					<option <c:if test="${schemelist.pageSize == 90}">selected</c:if> value="90">90 条/页</option>
				</select>
			</div>
		</div>
	</div>
</div>
<script src="${ctx}/js/app/setBackFill.js"></script>
<script>
	var SchemeType = [ "入库", "出库","出入库", "年度轮换方案" ];
	var InRotateType = [ "竞价销售", "协议销售", "内部招标", "招标采购", "订单采购", "进口粮采购", "其他" ];
	
	var PageIndex = ${schemelist.pageIndex};
	var PageSize = ${schemelist.pageSize};
	var TotalCount = ${schemelist.totalCount};
	layui.form.render("select","search");

    //回填原来的参数
    function initPageParams() {
        if(sessionStorage.getItem("rotateschemedetail_view_back") == 'back'){ //如果这里相等 说明是返回按钮回来的
            new setBackFill({
                getSelectedId: 'select-parm', //获得需要的id
                back:'yes',  //
                whereName:"rotatescheme",
                // selfDefinedParam:[{'PageIndex':PageIndex}],
                callBack:''
            });
            PageIndex = sessionStorage.getItem("rotatescheme_view_PageIndex")//第几页
            sessionStorage.setItem("rotateschemedetail_view_back",'');
        }
    }
    //  查看
    function goToDetailPage(thi) {
        setSessionStorage();
        window.location.href = $(thi).data('href')

    }
    //点击查看按钮之后设置 sessionStorage
    function setSessionStorage() {
        new setBackFill({  //填充数据
            getSelectedId: 'select-parm', //获得需要的id
            whereName:"rotatescheme",
            // selfDefinedParam:[{'PageIndex':PageIndex}]
        })
        sessionStorage.setItem("rotatescheme_view_PageIndex",PageIndex)//第几页
    }


	$(function(){
		//$(".sort-table").tablesorter(); 
		for(var i = 0;i<SchemeType.length;i++){
			$("#scheme-type").append("<option>"+SchemeType[i]+"</option>")
		}
		for(var i = 0;i<InRotateType.length;i++){
			$("#rotate-type").append("<option>"+InRotateType[i]+"</option>")
		}
		//DrawDownPage("pagination");
		pageToolBar();FormSubmit(true)
	});
	
	function FormSubmit(NeedDrawPage){
        layer.load(2, {time: 3000});
        initPageParams()
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
						
						template.find("td[name='originName']").html(data.otherPram[Result[i].planMainId]);
						template.find("td[name='schemeName']").html(Result[i].schemeName);
						template.find("td[name='schemeType']").html(Result[i].schemeType)
						template.find("td[name='rotateType']").html(Result[i].rotateType);
						template.find("td[name='year']").html(Result[i].year);
						template.find("td[name='creater']").html(Result[i].creater);
						var time = new Date();
						time.setTime(Result[i].completeDate);
						template.find("td[name='completeDate']").html(Result[i].completeDate == null?'———':time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+((time.getDate()<10)?'0'+time.getDate():time.getDate())+"日");
						template.find("td[name='executeState']").html(Result[i].executeState);
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).data("href",$(this).data("href")+Result[i].id+"&type=${type }")});
						$("#data-list").append($(template));
						$(template).show();
						$(".sort-table").trigger("update")
					}
					if(NeedDrawPage)
						DrawDownPage("pagination");
					
				}else{
					$("#data-list").empty();
					$("#data-list").append("<tr><td colspan='9'>搜索目标无结果</td></tr>");
					DrawDownPage("pagination");
				}
                setTimeout(function () {
                    $('#jockerLay').css({'display':'block'})
                }, 500)
			}
		});
	}
	
	function DrawDownPage(elemId){
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
	
	$("#clear-button").click(function () {
		$("#scheme-name").val("");

		$("#scheme-type option:selected").attr("selected",false);
		$("#scheme-type").eq(0).attr("selected",true);

        $("#rotate-type option:selected").attr("selected",false);
        $("#rotate-type").eq(0).attr("selected",true);

        $("select[name='executeState'] option:selected").attr("selected",false);
        $("select[name='executeState']").eq(0).attr("selected",true);
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
                url:"${ctx}/RotateScheme/Delete/Scheme/"+id+".shtml",
                data:{
                    "childTable":"SchemeDetail",
                    "forignKey":"SCHEME_ID"
                },
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
</script>
<%@ include file="../common/AdminFooter.jsp" %> 