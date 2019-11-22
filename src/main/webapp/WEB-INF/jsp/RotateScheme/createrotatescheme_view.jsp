<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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


#data-list tr td[data-field='column1'] {
	text-align: left;
	padding-left: 1%;
}
#data-list tr td[data-field='column3']{
	text-align: left;
	padding-left: 1%;
}
#data-list tr td[data-field='column4']{
	text-align: left;
	padding-left: 1%;
}
#data-list tr td[data-field='column5']{
	text-align: left;
	padding-left: 1%;
}
#data-list tr td[data-field='column6']{
	text-align: left;
	padding-left: 1%;
}
#data-list tr td[data-field='column8']{
	text-align: left;
	padding-left: 1%;
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
    border-top:none; display: none;
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
	width:35%;
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
		<li>轮换方案</li>
		<li class="active">创建方案</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<form id="select-parm" action="${type}create/List.shtml" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div>所属计划：</div>
						<input type="text" class="inputArea" name="originId"/>
					</td>
					<td>
						<div>计划年份：</div>
						<input type="text" class="inputArea" name="year">
					</td>
					<td>
						<div>方案名称：</div>
						<input id="storage-date" name="schemeName" class="inputArea"/>
					</td>
				</tr>
				</thead>
				<tbody id="total-search">
				<tr>
					<td>
						<div>轮换类别：</div>
						<select name="schemeType" class="inputArea">
							<option value="">全部</option>
							<option>出库</option>
							<option>入库</option>
                            <option>出入库</option>
							<option>年度轮换方案</option>
						</select>
					</td>
					<td>
						<div>轮换方式：</div>
						<select name="rotateType" class="inputArea">
							<option value="">全部</option>
							<option>竞价销售</option>
							<option>协议销售</option>
							<option>内部招标</option>
							<option>招标采购</option>
							<option>订单采购</option>
							<option>进口粮采购</option>
							<%--<option>其他</option>--%>
						</select>
					</td>
					<td>
						<div>审批状态：</div>
						<select name="state" class="inputArea">
							<option value="">全部</option>
							<option>待提交</option>
							<option>OA审核中</option>
							<option>审核通过</option>
							<option>已完成</option>
							<option>已驳回</option>
						</select>
					</td>
				</tr>
				</tbody>
			</table>
		</form>

		<div id="search-button-area">
			<div class="buttonArea" id="select-button">查询</div>
			<div class="PageButton-UnSelect" id="show-total-search">v 高级搜索</div>
			<div class="buttonArea" id="clearBtn">清空</div>
		</div>
	</div>
	<div id="listArea">
		<shiro:hasPermission name="RotateScheme:add">
		<div class="buttonArea" id="add-scheme">新增</div>
		</shiro:hasPermission>
		<table style="display:none">
			<tr id="template">
				<td data-field="column1" name="originName"></td>
				<td data-field="column2" name="year"></td>
				<td data-field="column3" name="schemeName"></td>
				<td data-field="column4" name="schemeType"></td>
				<td data-field="column5" name="rotateType"></td>
				<td data-field="column6" name="creater"></td>
				<td data-field="column7" name="createTime"></td>
				<td data-field="column8" name="state"></td>
				<td data-field="column9" name="isEnd"></td>
				<td name="do">
					<shiro:hasPermission name="RotateScheme:edit">
					<a style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini edit"  onclick="goToCreatePage(this)" data-href="${ctx }/RotateScheme/Create.shtml?sid=">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateScheme:detail">
					<a style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail"  onclick="goToDetailPage(this)" data-href="${ctx }/RotateScheme/Detail.shtml?sid=">查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateScheme:submit">
					<button style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini submit">提交</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateScheme:delete">
					<button style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini delete">删除</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateScheme:agree">
					<button style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini agree">同意</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="RotateScheme:push">
					<button style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini push">分发</button>
					</shiro:hasPermission>

					<button style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini end">终结</button>
				</td>
			</tr>
		</table>
		<table class="layui-table">
			<thead>
				<tr>
					<td>所属计划</td>
					<td>计划年份</td>
					<td>方案名称</td>
					<td>轮换类别</td>
					<td>轮换方式</td>
					<td>创建人</td>
					<td>创建时间</td>
					<td>审批状态</td>
					<td>是否终结</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<%--<c:forEach items="${schemelist.result }" var="scheme">--%>
					<%--<tr>--%>
						<%--<td data-field="column1"><c:out value="${originMapper[scheme.originId]}"/></td>--%>
						<%--<td data-field="column2">${scheme.year }</td>--%>
						<%--<td data-field="column3">${scheme.schemeName }</td>--%>
						<%--<td data-field="column4">${scheme.schemeType }</td>--%>
						<%--<td data-field="column5">${scheme.rotateType }</td>--%>
						<%--<td data-field="column6">${scheme.creater }</td>--%>
						<%--<td data-field="column7"><fmt:formatDate value="${scheme.createTime }" pattern="yyyy年MM月dd日"/> </td>--%>
						<%--<td data-field="column8">${scheme.state }</td>--%>
						<%--<td>--%>
						<%--<c:choose>--%>
							<%--<c:when test="${scheme.state == '待提交'}">--%>
								<%--<shiro:hasPermission name="RotateScheme:edit">--%>
								<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini"  onclick="goToCreatePage(this)" data-href="${ctx }/RotateScheme/Create.shtml?sid=${scheme.id }">编辑</a>--%>
								<%--</shiro:hasPermission>--%>
								<%--<shiro:hasPermission name="RotateScheme:submit">--%>
								<%--<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini submit" tag="${scheme.id }">提交</span>--%>
								<%--</shiro:hasPermission>--%>
								<%--<shiro:hasPermission name="RotateScheme:delete">--%>
								<%--<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini delete" tag="${scheme.id }">删除</span>--%>
								<%--</shiro:hasPermission>--%>
							<%--</c:when>--%>
							<%--<c:when test="${scheme.state == 'OA审核中'}">--%>
								<%--<shiro:hasPermission name="RotateScheme:detail">--%>
								<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" onclick="goToDetailPage(this)" data-href="${ctx }/RotateScheme/Detail.shtml?sid=${scheme.id }&type=${type }">查看</a>--%>
								<%--</shiro:hasPermission>--%>
								<%--<shiro:hasPermission name="RotateScheme:edit">--%>
								<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini edit" onclick="goToCreatePage(this)" data-href="${ctx }/RotateScheme/Create.shtml?sid=${scheme.id }">编辑</a>--%>
								<%--</shiro:hasPermission>--%>
								<%--<shiro:hasPermission name="RotateScheme:agree">--%>
								<%--<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini agree" tag="${scheme.id }">同意</span>--%>
								<%--</shiro:hasPermission>--%>
							<%--</c:when>--%>
							<%--<c:when test="${scheme.state == '审核通过'}">--%>
								<%--<shiro:hasPermission name="RotateScheme:detail">--%>
								<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" onclick="goToDetailPage(this)" data-href="${ctx }/RotateScheme/Detail.shtml?sid=${scheme.id }&type=${type }">查看</a>--%>
								<%--</shiro:hasPermission>--%>
								<%--<shiro:hasPermission name="RotateScheme:push">--%>
								<%--<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini push" tag="${scheme.id }">分发</span>--%>
								<%--</shiro:hasPermission>--%>
							<%--</c:when>--%>
							<%--<c:when test="${scheme.state == '已完成'}">--%>
								<%--<shiro:hasPermission name="RotateScheme:detail">--%>
								<%--<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini detail" onclick="goToDetailPage(this)" data-href="${ctx }/RotateScheme/Detail.shtml?sid=${scheme.id }&type=${type }">查看</a>--%>
								<%--</shiro:hasPermission>--%>
							<%--</c:when>--%>
						<%--</c:choose>--%>
						<%--</td>--%>
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
<form style="display:none" id="simple-form" enctype="multipart/form-data"/>
<script src="${ctx}/js/app/setBackFill.js"></script>
<script>
	var PageIndex = Number("${schemelist.pageIndex}");
	var PageSize = Number("${schemelist.pageSize}");
	var TotalCount = Number("${schemelist.totalCount}");
	//回填原来的参数
	function initPageParams() {
        if(sessionStorage.getItem("rotateschemedetail_view_back") == 'back'){ //如果这里相等 说明是返回按钮回来的
            new setBackFill({
                getSelectedId: 'select-parm', //获得需要的id
                whereName:"createrotatescheme",
                back:'yes',
                // selfDefinedParam:[{'PageIndex':PageIndex}],
                callBack:''
            });
            PageIndex = sessionStorage.getItem("createrotatescheme_view_PageIndex")//第几页
            sessionStorage.setItem("rotateschemedetail_view_back",'');
        }
    }
    //点击查看按钮之后设置 sessionStorage
	function setSessionStorage() {
        new setBackFill({  //填充数据
            getSelectedId: 'select-parm', //获得需要的id
            whereName:"createrotatescheme",
            // selfDefinedParam:[{'PageIndex':PageIndex}]
        })
        sessionStorage.setItem("createrotatescheme_view_PageIndex",PageIndex)//第几页
    }
    //  查看
    function goToDetailPage(thi) {
        setSessionStorage();
	    window.location.href = $(thi).data('href')
    }
    //  编辑
    function goToCreatePage(thi) {
        window.location.href = $(thi).data('href');
    }

	var laydate=layui.laydate;
	laydate.render({
		elem:"input[name='year']",
		type:"year",
        change: function(value, date, endDate){
            //debugger
            $("input[name='year']").val(value);
            if($(".layui-laydate").length){
                $(".layui-laydate").remove();
            }
        },
	});

	//最后的提交按钮
	function FormSubmit(NeedDrawPage){
        layer.load(2, {time: 2000});
        initPageParams();
		$("#select-parm").ajaxSubmit({
			data:{
				"pageindex":Number(PageIndex),
				"pagesize":PageSize
			},
			success:function(data){
				$("#data-list").empty();
				TotalCount = data.totalCount;
				if(data.totalCount > 0){
					var Result = data.result;
					for(var i = 0;i < Result.length; i++){
						var template = $("#template").clone(true);
						template.attr("id","");
						
						template.find("td[name='originName']").html(data.otherPram[Result[i].planMainId]);
						template.find("td[name='year']").html(Result[i].year)
						var time = new Date();
						time.setTime(Result[i].storageDate);
						template.find("td[name='schemeName']").html(Result[i].schemeName);
						template.find("td[name='schemeType']").html(Result[i].schemeType);
						template.find("td[name='rotateType']").html(Result[i].rotateType);
						template.find("td[name='creater']").html(Result[i].creater);
						time.setTime(Result[i].createTime);
						template.find("td[name='createTime']").html(time.getFullYear()+"年"+((time.getMonth()+1)<10?"0"+(time.getMonth()+1):(time.getMonth()+1))+"月"+time.getDate()+"日");
						template.find("td[name='state']").html(Result[i].state);
                        template.find("td[name='isEnd']").html((Result[i].isEnd==null|| Result[i].isEnd == '0')?"未终结":"已终结");
						template.find("td[name='completeDate']").html(Result[i].completeDate==null?"—————":Result[i].completeDate);
						var target = template.find("td[name='do']");
						$(target).find("a").each(function(){$(this).data("href",$(this).data("href")+Result[i].id+"&type=${type}")})
						$(target).find("button").each(function(){$(this).attr("tag",Result[i].id)});
						if(Result[i].state == '待提交' && Result[i].isEnd != '1'){
							$(target).find(".edit,.submit,.delete,.end").show();
						}else if(Result[i].state == 'OA审核中' && Result[i].isEnd != '1'){
							$(target).find(".agree,.detail,.end").show();
						}else if(Result[i].state == '审核通过' && Result[i].isEnd != '1'){
							$(target).find(".push,.detail,.end").show();
						}else if(Result[i].state == '已驳回' && Result[i].isEnd != '1'){
                            $(target).find(".edit,.submit,.delete,.end").show();
						}else if(Result[i].state == '已完成'&& Result[i].isEnd != '1'){
							$(target).find(".detail,.end").show();
						}else if(Result[i].isEnd == '1'){
                            $(target).find(".detail").show();
						}
						/*if(Result[i].state.isEnd != '1' ){
                            $(target).find(".end").show();
						}else{

						}*/
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
                setTimeout(function () {
                    $('#jockerLay').css({'display':'block'})
                }, 500)
			}
		});
	}
	//点击查询按钮
	$("#select-button").click(function(){
		PageIndex = 1;
		$("#bottom-button").empty();
		FormSubmit(true);
	});
	//点击清空按钮
	$("#clearBtn").click(function () {
		$("input[name='originId']").val("");
		$("input[name='year']").val("");
		$("input[name='schemeName']").val("");

		$("select[name='schemeType'] option:selected").attr("selected",false);
		$("select[name='schemeType']").eq(0).attr("selected",true);

        $("select[name='rotateType'] option:selected").attr("selected",false);
        $("select[name='rotateType']").eq(0).attr("selected",true);

        $("select[name='state'] option:selected").attr("selected",false);
        $("select[name='state']").eq(0).attr("selected",true);

        layui.form.render();
    });
	//简单搜索  高级搜索 之间的切换
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
	//新增
	$("#add-scheme").click(function(){
		window.location.href = "${ctx}/RotateScheme/Create.shtml";
	});
	
	$(".submit,.agree,.push").click(function(){
	    // 将按钮设置成不可点击
		$(".submit,.agree,.push").attr("disabled",true);

		var stateMapper = {"提交":"OA审核中","同意":"审核通过","分发":"已完成"}
		var self= this;
		layer.confirm('你确定要'+$(self).html()+'吗？', {
			btn: ['是','否']
		}, function(index){
            layer.close(index);
			var id = $(self).attr("tag");
		  	$("#simple-form").ajaxSubmit({
		  		url:"Edit.shtml",
		  		data:{
		  			"state":stateMapper[$(self).html()],
		  			"id":id
		  		},
		  		type:"post",
		  		success:function(data){
		  			if(data.success){
		  				layerMsgSuccess("状态更改成功",function(){
		  					location.reload();
		  				});
		  			}else{
		  			    // 设置按钮为可点击
                        $(".submit,.agree,.push").removeAttr("disabled");
		  				layerMsgError("状态更改失败");
		  			}
		  		},
				error:function () {
                    $(".submit,.agree,.push").removeAttr("disabled");
                }
		  	});
		}, function(){
            $(".submit,.agree,.push").removeAttr("disabled");
		});
	})

    $(".end").click(function(){
        // 将按钮设置成不可点击
        $(".end").attr("disabled",true);

        var stateMapper = {"终结":"1"}
        var self= this;
        layer.confirm('你确定要'+$(self).html()+'吗？', {
            btn: ['是','否']
        }, function(index){
            layer.close(index);
            var id = $(self).attr("tag");
            $("#simple-form").ajaxSubmit({
                url:"Edit.shtml",
                data:{
                    "isEnd":stateMapper[$(self).html()],
                    "id":id
                },
                type:"post",
                success:function(data){
                    if(data.success){
                        layerMsgSuccess("状态更改成功",function(){
                            location.reload();
                        });
                    }else{
                        // 设置按钮为可点击
                        $(".end").removeAttr("disabled");
                        layerMsgError("状态更改失败");
                    }
                },
                error:function () {
                    $(".end").removeAttr("disabled");
                }
            });
        }, function(){
            $(".end").removeAttr("disabled");
        });
    })
	
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
	//点击分页的按钮
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
                $("#total").text(TotalCount);

			}
		})




	}
	//
	// $("#select-button").click(function(){
	// 	PageIndex = 1;
	// 	$("#bottom-button").empty();
	// 	FormSubmit(true);
	// });
	//
	function pageToolBar(){
		if((TotalCount / Number($("#pageSize").val()))<=1){
			$("#pageSelecter").addClass("pageSelecter-disable");
		}else{
			$("#pageSelecter").removeClass("pageSelecter-disable");
		}
	}
	//点击分页的确定按钮
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
    FormSubmit(true)//初始化

</script>
<%@ include file="../common/AdminFooter.jsp" %>