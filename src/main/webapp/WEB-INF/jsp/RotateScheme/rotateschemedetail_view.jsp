<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
#data-list tr
td[data-field="schemeBatch"],
td[data-field="rotateType"],
td[data-field="libraryId"],
td[data-field="branNumber"],
td[data-field="foodType"],
td[data-field="ogirin"]
{
	text-align: left;
}

#data-list tr
td[data-field="rotateNumber"],
td[data-field="qualityDetail"]{
	text-align: right;
}

#soure-template2
td[name="name"],
td[name="level"],
td[name="stand"],
td[name="value"],
td[name="commend"]{
	text-align: left;
}

#soure-template3
td[name="name"],
td[name="level"],
td[name="stand"],
td[name="value"],
td[name="commend"]{
	text-align: left;
}

#outside {
	width: 94%;
	margin-left: 2%;
	padding: 1%;
	background: #fff;
}

#userInfo{
	margin-left:10%;
	padding:25px 0;
	width:80%;
}

#userInfo>span{
	padding-right:5%;
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
table{
	margin-top:20px;
	width:100%;
	text-align:center;
}

table thead{
	background:#f2f2f2;
}

table tr td{
	width:7.5%;
	font-size:0.9em;
	border:1px solid #e2e2e2;
	padding:10px 0;
}
#float-alert2{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}
#table-wapper2{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:75%;
	height:550px;
	overflow-y:auto;
} 
#table-wapper2 table{
	margin:0;
	border-bottom:none;
}
#close-float-alert2{
	position:relative;
	left:88.5%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}
.buttonArea{
	padding:5px 15px;
	background:#009688;
	border:none;
	color:#fff;
	cursor:pointer;
	display:inline-block;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换方案</li>
		<li>方案列表</li>
		<li class="active">查看</li>
	</ol>
</div>
<div id="outside">
	<h1 name="scheme-title" style="text-align:center;font-size:1.5em">${scheme.schemeName }</h1>
	<div id="userInfo">
		<span name="scheme-year">计划年份：${scheme.year }年</span>
		<br>
		<span>填报部门：&nbsp;${scheme.department }</span> 
		<span>经办人：&nbsp;${scheme.creater }</span> 
		<span>经办时间：&nbsp;<fmt:formatDate value="${scheme.createTime }" pattern="yyyy年MM月dd日"/></span>
		<c:if test="${myFile.fileName ne null and type eq 'proviceunit'}">
		<p>附件：</p>
		<div style="border:1px solid #ccc;padding:10px;">
			<i class="layui-icon">&#xe60a;</i>
			<span>${myFile.fileName }</span>
			<a href="${ctx }/sysFile/download.shtml?fileId=${scheme.annex}">下载</a>
			<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
				预览
			</a>
			<a href="javascript:openAnnex('${myFile.id}')" id="openFile" style="display: none">
				预览
			</a>
		</div>
		
		</c:if>
		<br/><span>备注：&nbsp;${scheme.description }</span> 
	</div>
	<div id="data-view">
		<table class="layui-table">
			<thead>
				<tr>
				
				<c:if test="${ scheme.schemeType!='年度轮换方案'}">
					<td>批次</td>
					<td>竞价时间</td>
					<td>轮换开始时间</td>
					<td>轮换结束时间</td>
				</c:if>
					<td>轮换方式</td>
					<td>企业</td>
					<td>库点</td>
					<td>仓房</td>
					<td>粮食品种</td>
					<td>收获年份</td>
					<td>产地</td>
					<td>轮出数量(t)</td>
					<td>轮入数量(t)</td>
					<td>存储方式</td>
					<td>质量详情</td>
					<td>质检数量</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<c:forEach items="${scheme.schemeDetail }" var="item">
				<tr>
				<c:if test="${ scheme.schemeType!='年度轮换方案'}">
					<td data-field="schemeBatch">${item.schemeBatch }</td>
					<td data-field="biddingTime"><fmt:formatDate value="${item.biddingTime }" pattern="yyyy年MM月dd日" /></td>
					<td data-field="startTime"><fmt:formatDate value="${item.startTime }" pattern="yyyy年MM月dd日" /></td>
					<td data-field="endTime"><fmt:formatDate value="${item.endTime }" pattern="yyyy年MM月dd日" /></td>
				</c:if>
					<td data-field="rotateType">${item.rotateType }</td>
					<td data-field="enterpriseName">${item.enterpriseName}</td>
					<td data-field="libraryId">${item.libraryId }</td>
					<td data-field="branNumber">${item.branNumber }</td>
					<td data-field="foodType">${item.foodType }</td>
					<td data-field="yieldTime">${item.yieldTime }</td>
					<td data-field="ogirin">${item.ogirin }</td>
					<td data-field="rotateNumber">
					<c:choose>
						<c:when test="${item.schemeType eq '入库'}">
							————
						</c:when>
						<c:otherwise>
							${item.rotateNumber }
						</c:otherwise>
					</c:choose>
					</td>
					<td data-field="rotateNumber">
					<c:choose>
						<c:when test="${item.schemeType eq '出库'}">
							————
						</c:when>
						<c:otherwise>
							${item.rotateNumber }
						</c:otherwise>
					</c:choose>
					</td>

					<td data-field="storeType">${item.storeType }</td>
					<td data-field="qualityDetail">
						<c:choose>
							<c:when test="${item.schemeType eq '出库'}">
								————
							</c:when>
							<c:otherwise>
								${item.qualityDetail }
							</c:otherwise>
						</c:choose>
					</td>
					<td data-field="qualityResultNum">
						<c:choose>
							<c:when test="${item.schemeType eq '出库'}">
								${item.qualityResultNum}
							</c:when>
							<c:otherwise>
								————
							</c:otherwise>
						</c:choose>
					</td>

					<td data-field="planDetailId">
						<c:choose>
						<c:when test="${item.schemeType eq '出库'}">
							<div tag="${item.planDetailId }" class="buttonArea quality-detail">质量详情</div>
						</c:when>
							<c:otherwise>
								————
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" href="${ctx }/RotateScheme/ExportExcel.shtml?sid=${scheme.id}&type=${type }">导出</a>
	<p class="btn-box text-center">
    	<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>
        
            
      </p>
</div>
<div id="float-alert2">
	<div id="table-wapper2">
		<span class="title">质量明细</span>
		<i id="close-float-alert2" class="layui-icon">&#x1006;</i>
		<p>入库质检</p>
		<table>
			<thead>
				<tr>
					<td>检测项名称	</td>
					<td>等级</td>
					<td>标准值</td>
					<td>检测值</td>
					<td>结论</td>
				</tr>
				<tr id="soure-template2" style="display:none" >
					<td name='name'></td>
					<td name="level"></td>
					<td name="stand"></td>
					<td name="value"></td>
					<td name="commend"></td>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list2">
				
			</tbody>
		</table>
		<p>出库质检</p>
		<table>
			<thead>
				<tr>
					<td>检测项名称</td>
					<td>等级</td>
					<td>标准值</td>
					<td>检测值</td>
					<td>结论</td>
				</tr>
				<tr id="soure-template3" style="display:none" >
					<td name='name'></td>
					<td name="level"></td>
					<td name="stand"></td>
					<td name="value"></td>
					<td name="commend"></td>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list3">
				
			</tbody>
		</table>
	</div>
	<%--<p class="btn-box text-center">--%>
    	<%--<a type="button"  class="layui-btn layui-btn-primary layui-btn-small reback">返回</a>--%>
        <%----%>
            <%----%>
      <%--</p>--%>
</div>

<script>
    if ("${scheme.annex}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
	// 点击返回上一页的按钮
	 $(".reback").click(function(){
			history.go(-1);
         sessionStorage.setItem("rotateschemedetail_view_back", "back");
	});

$(".quality-detail").click(function(){
    //debugger
	var planId = $(this).attr("tag");
	var storehouse = $(this).parent().parent().find("[data-field='branNumber']").html();
	$.ajax({
		url:"${ctx}/rotatePlan/GetQualityInfo.shtml",
		type:"post",
		data:{
			"planDetailid":planId,
			"storehouse":storehouse,
		},
		success:function(data){
			data = data.data;
			$("#schemeDetail-data-list2,#schemeDetail-data-list3").empty();
			if(data.In != null){
				var inData = typeof(data.In.qualityResultItems) != "undefined" ? data.In.qualityResultItems : data.In.qualityThirdItems;
				for(var i=0;i<inData.length;i++){
					var dataTamplate = $("#soure-template2").clone();
					$(dataTamplate).find("td[name='name']").html(inData[i].itemName);
					$(dataTamplate).find("td[name='level']").html(inData[i].grade);
					$(dataTamplate).find("td[name='stand']").html(inData[i].standard);
					$(dataTamplate).find("td[name='value']").html(inData[i].result);
					$(dataTamplate).find("td[name='commend']").html(inData[i].remark);
					$("#schemeDetail-data-list2").append(dataTamplate);
					$(dataTamplate).show();
				}
			}else{
				$("#schemeDetail-data-list2").append("<td colspan='5'>无对应数据</td>")
			}

			if(data.Out != null){
				var inData = typeof(data.Out.qualityResultItems) != "undefined" ? data.Out.qualityResultItems : data.Out.qualityThirdItems;
				for(var i=0;i<inData.length;i++){
					var dataTamplate = $("#soure-template3").clone();
					$(dataTamplate).find("td[name='name']").html(inData[i].itemName);
					$(dataTamplate).find("td[name='level']").html(inData[i].grade);
					$(dataTamplate).find("td[name='stand']").html(inData[i].standard);
					$(dataTamplate).find("td[name='value']").html(inData[i].result);
					$(dataTamplate).find("td[name='commend']").html(inData[i].remark);
					$("#schemeDetail-data-list3").append(dataTamplate);
					$(dataTamplate).show();
				}
			}else{
				$("#schemeDetail-data-list3").append("<td colspan='5'>无对应数据</td>")
			}
			$("#float-alert2").slideToggle(500,function(){
				$("#table-wapper2").slideToggle(500);			
			});
		}
	});
});

$("#close-float-alert2").click(function(){
	$("#table-wapper2").slideToggle(500,function(){
		$("#float-alert2").slideToggle(500);			
	});
});
</script>
<%@ include file="../common/AdminFooter.jsp" %>