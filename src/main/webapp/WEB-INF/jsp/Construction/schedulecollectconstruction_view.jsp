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
		width: 25%;
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
		width:20%;
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
		<form id="select-parm" action="Collect.shtml?needreported=${needreported }" method="POST">
			<table>
				<thead>
				<tr>
					<td>
						<div>年月：</div>
						<input type="text" class="inputArea" name="yearMonth" />
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
		<table style="display:none">
			<tr id="template">
				<td style="text-align: left" name="reportTableName"></td>
				<td style="text-align: center" name="yearMonth"></td>
				<td style="text-align: right" name="approvedInvestmentSubtotal"></td>
				<td style="text-align: right" name="currentInvestmentSubtotal"></td>
				<td style="text-align: right" name="accumulateInvestmentSubtotal"></td>
				<td name="do">
					<span style="display:none" class="layui-btn layui-btn-primary layui-btn layui-btn-mini report" >上报</span>
					<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="" onclick="toView(this)">查看</a>
				</td>
			</tr>
		</table>
		<table class="layui-table sort-table">
			<thead>
			<tr>
				<td>上报表名称</td>
				<td>年月</td>
				<td>合计批准投资(万元)</td>
				<td>合计本月完成投资(万元)</td>
				<td>合计累计完成投资(万元)</td>
				<td>操作</td>
			</tr>
			</thead>
			<tbody id="data-list">
			<c:forEach items="${schedulelist.result }" var="schedule">
				<tr>
					<td align="left">${schedule.yearMonth }基建项目完成情况报表</td>
					<td align="center">${schedule.yearMonth }</td>
					<td align="right">${schedule.approvedInvestmentSubtotal }</td>
					<td align="right">${schedule.currentInvestmentSubtotal }</td>
					<td align="right">${schedule.accumulateInvestmentSubtotal }</td>
					<td>
						<c:if test="${schedule.reported ne 1 }">
							<span class="layui-btn layui-btn-primary layui-btn layui-btn-mini report" tag="${schedule.yearMonth }">上报</span>
						</c:if>
						<a class='layui-btn layui-btn-primary layui-btn layui-btn-mini detail' data-id="${schedule.id }&collect=${schedule.yearMonth}&needreported=${needreported }" onclick="toView(this)">查看</a>
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
                        template.find("td[name='approvedInvestmentSubtotal']").html(Result[i].approvedInvestmentSubtotal.toFixed(1));
                        template.find("td[name='currentInvestmentSubtotal']").html(Result[i].currentInvestmentSubtotal.toFixed(1));
                        template.find("td[name='accumulateInvestmentSubtotal']").html(Result[i].accumulateInvestmentSubtotal.toFixed(1));
                        var target = template.find("td[name='do']");
                        $(target).find("a").not(".detail").each(function(){$(this).attr("href",$(this).attr("href")+"&collect="+Result[i].yearMonth+"&needreported=${needreported }")});
                        $(target).find("a.detail").attr("data-id","&collect="+Result[i].yearMonth+"&needreported=${needreported }");
                        $(target).find("span").each(function(){$(this).attr("tag",Result[i].yearMonth)});
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

    $(".report").click(function(){
        var self=this;
        layer.confirm('你确定要'+$(self).html()+'吗？', {
            btn: ['是','否']
        }, function(){
            var yearMonth = $(self).attr("tag");
            $.ajax({
                url:"${ctx}/Construction/Schedule/Collect/Edit.shtml",
                data:{
                    "reported":"1",
                    "yearMonth":yearMonth
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