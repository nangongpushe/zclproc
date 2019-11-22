<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
	#data-list tr td[name="type"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="advise"]{
		padding-left: 1%;
		text-align: left;
	}
	#data-list tr td[name="amount"]{
		padding-left: 1%;
		text-align: left;
	}

#outside {
	width: 94%;
	margin-left: 2%;
	padding: 1%;
	background: #fff;
}

#userInfo{
	padding:10px 0;
}

#userInfo>span{
	display: inline-block;
    width: 25%;
    margin: 2px 0;
}

#data-view table{
	width:100%;
	text-align: center;
}

#data-view thead{
	background:#aaa;
}

#data-view td{
	padding:10px 5px;
}

#data-view tbody tr:hover{
	background:#eee;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>商务处理</li>
		<li>商务处理记录</li>
		<li class="active">详情</li>
	</ol>
</div>
<div id="outside">
	<div>
		<h1 style="text-align:center;font-size:2em;">${recording.recordName }</h1>
		<span>所属成交结果子明细号：${recording.dealSerial }</span><br>
		<span>买方：${recording.buyer }</span><br>
		<span>卖方：${recording.seller }</span><br>
	</div>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
					<td style="text-align: center">所属种类</td>
					<td style="text-align: center">处理意见</td>
					<td style="text-align: center">金额(元)</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${recording.processDetail }" var="detail">
				<tr>
					<td name="type" style="text-align: left">${detail.type }</td>
					<td name="advise" style="text-align: left">${detail.advise }</td>
					<td name="amount" style="text-align: right">${detail.amount }</td>
				</tr>
				</c:forEach>
				<c:if test="${recording.processDetail==null || fn:length(recording.processDetail)==0}">
				<tr><td colspan="3" align="3">暂无数据</td></tr>
				</c:if>
			</tbody>
		</table>
		
		  <p class="btn-box text-center">
              <button type="button" class="layui-btn layui-btn-primary layui-btn-small reback">返回</button>
            
        </p>
  
	</div>
</div>
<%@ include file="../common/AdminFooter.jsp" %>

<script type="text/javascript">
 $(".reback").click(function(){
			history.go(-1);
		
	});
</script>
