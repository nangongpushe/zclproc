<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/AdminHeader.jsp" %> 
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${ctx}/css/combo.select.css">
<style type="text/css">
	#schemeDetail-data-list tr td[name="dealSerial"]{
		padding-left: 1%;
		text-align: left;
	}
	#schemeDetail-data-list tr td[name="deliveryPlace"]{
		padding-left: 1%;
		text-align: left;
	}
	#schemeDetail-data-list tr td[name="compleRate"]{
		padding-right: 1%;
		text-align: right;
	}
	#schemeDetail-data-list tr td[name="inviteType"]{
		padding-left: 1%;
		text-align: left;
	}
	#schemeDetail-data-list tr td[name="schemeBatch"]{
		padding-left: 1%;
		text-align: left;
	}
	#schemeDetail-data-list tr td[name="schemeName"]{
		padding-left: 1%;
		text-align: left;
	}

#outSide{
	width:94%;
	margin-left:2%;
	padding:1%;
	background:#fff;
	border-top:2px solid #23b7e5;
}

.infoArea{
	width:100%;
	padding:20px 0;
	border-bottom: 2px solid #e2e2e2;
}

.title{
	color: #23b7e5;
	font-weight:bold;
}

#infoArea{
	margin-top:20px;
	margin-left:4%;
}

#infoArea span{
	padding-right:100px;
}

.requiredData{
	color:red;
}

#mainInfo{
	margin-top:20px;
	margin-left:2.5%;
}

#mainInfo>div{
	padding:10px 0;
	width:100%;
}

#mainInfo>div span{
	width:17%;
	display:inline-block;
	text-align:left;
}

.inputArea{
	width:80%;
	padding:5px;
	outline: none;
	border:1px solid #ccc;
	resize: none;
}

.buttonArea{
	padding:5px 15px;
	background:#009688;
	border:none;
	color:#fff;
	cursor:pointer;
	display:inline;
}

#listArea{
	padding:20px 0;
	width:100%;
}

table{
	margin-top:20px;
	width:100%;
	text-align:center;
}

thead{
	background:#f2f2f2;
}

table tr td{
	width:9%;
	border:1px solid #e2e2e2;
	padding:10px 0;
}

#bottom-button{
	text-align:right;
	padding-right:20px;
	margin-top:20px;
}

#bottom-button>div{
	margin-right:10px;
}

#template-tr{
	display:none;
}

#float-alert{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}#float-alert-secon{
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:400;
	display:none;
}

#table-wapper{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:75%;
	height:550px;
} #table-wapper-secon{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%;
	width:50%;
	height:550px;
}

#table-wapper table{
	margin:0;
	border-bottom:none;
}

#table-wapper table td:first-child{
	width:3%;
}

#close-float-alert{
	position:relative;
	left:85.5%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}#close-float-alert-secon{
	position:relative;
	left:85.5%;
	font-size: 30px;
	color:RGB(42, 180, 168);
	cursor: pointer;
}

#schemeDetail-data-list input[type=checkbox]{
	width:50%;
	outline:none;
}

#out-table{
	height:310px;
	overflow:auto;
	margin-top:20px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>商务处理</li>
		<li>商务处理记录</li>
		<li class="active">
		<c:choose>
			<c:when test="${recording.id != null }">编辑</c:when>
			<c:otherwise>新增</c:otherwise>
		</c:choose>
		</li>
	</ol>
</div>
<div id="outSide">
	<div id="userInfo" class="infoArea">
		<span class="title">填报人信息</span>
		<div id="infoArea">
			<span>经办人：${recording.operator }</span>
			<span name='createDate'>经办时间：<span><fmt:formatDate value="${recording.handleTime }" pattern="yyyy-MM-dd"/></span></span> 
		</div>
	</div>
	<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<input  name="tagId" id="tagId" type="hidden" value="${recording.tagId}"/>
	<div id="dataArea" class="infoArea">
		<span class="title">记录信息</span>
		<div id="mainInfo">
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>记录名称：</span>
				<input name="recordName" class="inputArea" value="${recording.recordName }" maxlength="45"/>
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>所属成交结果子明细号：</span>
				<input name="dealSerial" class="inputArea" style="width:73%" value="${recording.dealSerial }" readonly/>
				<div class="buttonArea" id="choose-deal">请选择</div>
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>买方：</span>
				<input name="buyer" class="inputArea" value="${recording.buyer }" readonly/>
				<input name="buyerId" class="inputArea" hidden value="${recording.buyerId }" />
			</div>
			<div>
				<span style="text-align:right"><b class="requiredData">*</b>卖方：</span>
				<input name="seller" class="inputArea"  value="${recording.seller }" readonly/>
				<input name="sellerId" class="inputArea" hidden value="${recording.sellerId }" />
			</div>
		</div>
	</div>
	<div id="listArea">
		<div class="buttonArea" id="add-list">新增</div>
		<table>
			<thead>
				<tr>
					<td>所属种类</td>
					<td>处理意见</td>
					<td>金额(元)</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody id="data-result">
				<tr id="template-tr">
					<td name="type">
						<%--<input class="inputArea" maxlength="15"/>--%>
						<select id = 'type' class="inputArea processType">
							<option value = ''>--请选择--</option>
							<c:forEach var="processType" items="${processTypes}">
								<option  value="${processType.value}">${processType.label }</option>
							</c:forEach>
						</select>
					</td>
					<td name='advise'>
						<input class="inputArea" maxlength="45"/>
					</td>
					<td name='amount'>
						<input class="inputArea" maxlength="15" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" onchange = "numberFixed(this,2)" min="0" type="text"/>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
				</tr>
				<c:forEach items="${recording.processDetail }" var="item">
				<tr class="data-tr" tag="${item.id }">
					<td name="type">
						<%--<input class="inputArea" value="${item.type }" maxlength="15"/>--%>
						<select class="inputArea requiredData">
							<option value = ''>--请选择--</option>
							<c:forEach var="processType" items="${processTypes}">
								<option <c:if test = "${processType.value eq item.type }">selected</c:if> value="${processType.value}">
										${processType.label }
								</option>
							</c:forEach>
						</select>
					</td>
					<td name="advise">
						<input class="inputArea" value="${item.advise }" maxlength="45"/>
					</td>
					<td name='amount'>
						<input class="inputArea" maxlength="15" onkeyup="clearNoNum(this);" onblur="checkAmounts(this);" onchange = "numberFixed(this,2)" min="0" type="text" value="${item.amount }"/>
					</td>
					<td><div class="buttonArea remove-detail">删除</div></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="bottom-button">
			<div class="buttonArea" id="save">
			<c:choose>
				<c:when test="${recording.id != null }">编辑</c:when>
				<c:otherwise>保存</c:otherwise>
			</c:choose>
			</div>
			<div class="buttonArea" id="submit">提交</div>
			<div class="buttonArea" id="cancel">取消</div>
		</div>
	</div>
	</form>
</div>
<div id="float-alert">
	<div id="table-wapper">
		<span class="title">成交子明细选择</span>
		<i id="close-float-alert" class="layui-icon">&#x1006;</i>
		<div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">
		<form  lay-filter="search" id="concluteForm" action="${ctx }/rotateConclute/ListDetail.shtml" method="POST">
			<div class="layui-form" >
			<%--成交明细号：--%>
			<%--<select name="sid" style="width:50%;" class="inputArea">--%>
			<%--<c:forEach items="${concluteList}" var="conclute">--%>
				<%--<option value="${conclute.id }">${conclute.dealSerial }</option>--%>
			<%--</c:forEach>--%>
			<%--</select>--%>
			<%--<div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div> --%>
				<input type="hidden" name="rotateProcessFlag" value="">
				<div class="layui-form-item">
					<div class="layui-inline">
						<label class="layui-form-label">粮食品种：</label>
						<div class="layui-input-inline">
							<select name="grainType" id="filter-grainType" style="width:15%;" class="inputArea" style="display:none">
								<option value="">全部</option>
								<c:forEach items="${varietyList }" var="item">
									<option value="${item.value }">${item.value }</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="layui-inline">
						<label class="layui-form-label">库点：</label>
						<div class="layui-input-inline">
							<select name="receivePlace" id="filter-receivePlace" lay-search lay-filter="receivePlace"  >
								<option value="">全部</option>
								<c:forEach items="${basepoint }" var="point">
									<option value="${point }">${point }</option>
								</c:forEach>
							</select >
						</div>
					</div>

					<div class="layui-inline">
						<label class="layui-form-label">轮换类型：</label>
						<div class="layui-input-inline">
							<select name="noticeType" id="filter-noticeType" style="width:15%;" class="inputArea" style="display:none">
								<option value="入库">入库</option>
								<option value="出库">出库</option>
							</select >
						</div>
					</div>

					<div class="layui-inline">
						<label class="layui-form-label">收获年份：</label>
						<div class="layui-input-inline">
							<input name="warehoueYear" id="filter-warehoueYear" class="layui-input"/>
						</div>
					</div>

					<div class="layui-inline">
						<label class="layui-form-label">仓号：</label>
						<div class="layui-input-inline">
							<input name="storehouse" id="filter-storehouse" class="layui-input"/>
						</div>
					</div>

					<div class="layui-inline">
						<label class="layui-form-label">计划数：</label>
						<div class="layui-input-inline">
							<input name="quantity" id="filter-quantity" class="layui-input"/>
						</div>
					</div>
				</div>
			</div>
			<div>


				<div id="concluteButton" style="margin-left:20px;" class="buttonArea">搜索</div>
				<div class="buttonArea" id="select-button1" onclick="chongzi();">重置</div>
			</div>
		</form>
		<form id="out-table">
		<table>
			<thead>
				<tr>
					<td>选择</td>
					<td>成交子明细号</td>
					<td class="customer" style="display: none" >客户</td><%--买方--%>
					<td	class="supply">供应商</td><%--卖方--%>
					<td>进度(%)</td>
					<td>轮换方式</td>
					<td>批次</td>
					<td>方案名称</td>
					<td>竞价时间</td>
					<td>轮换开始时间</td>
					<td>轮换结束时间</td>
					<td class="forShowOrHide">质检详情</td>
				</tr>
			</thead>
			<tbody id="data-list">
				<tr id="conclute-template" style="display:none" >
					<td>
						<input type="radio" name="conclute-radio">
						<input name="tagId" type="hidden" value=""/>
                        <input name="receiveId" type="hidden" value=""/>
                        <input name="deliveryId" type="hidden" value=""/>
						<input name="enterpriseId" type="hidden" value="">
                    </td>
					<td name="dealSerial"></td>
					<td name="receivePlace" class="customer"></td>
					<td name="deliveryPlace" class="supply"></td>
					<td name="compleRate"></td>
					<td name="inviteType"></td>
					<td name="schemeBatch"></td>
					<td name="schemeName"></td>
					<td name="biddingTime"></td>
					<td name="startTime"></td>
					<td name="endTime"></td>
					<td name="qualityResult" class="forShowOrHide"></td>

				</tr>
		</tbody>
			<tbody id="schemeDetail-data-list">
				<%--<c:forEach items="${list }" var="item">--%>
					<%--<tr>--%>
						<%--<td><input  type="radio" name="conclute-radio">--%>
							<%--<input name="tagId" type="hidden" value="${item.id }">--%>
                            <%--<input name="receiveId" type="hidden" value="${item.receiveId }">--%>
                            <%--<input name="deliveryId" type="hidden" value="${item.deliveryId }">--%>
                        <%--</td>--%>
						<%--<td  name="dealSerial">${item.dealSerial}</td>--%>
						<%--&lt;%&ndash;<c:if test="${item.inviteType.trim() eq '竞价销售' ||item.inviteType.trim() eq '协议销售'||item.inviteType.trim() eq '内部招标'||item.inviteType.trim() eq '其他'||item.inviteType.trim() eq '内部销售'}">&ndash;%&gt;--%>

						<%--<td name="receivePlace" class="customer" <c:if test="${item.inviteType.trim() eq '招标采购'||item.inviteType.trim() eq '订单采购'||item.inviteType.trim() eq '进口粮采购'}"> style="display: none" </c:if>>${item.receivePlace}</td>&lt;%&ndash;买方&ndash;%&gt;--%>
						<%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
						<%--&lt;%&ndash;<c:if test="${item.inviteType.trim() eq '招标采购'||item.inviteType.trim() eq '订单采购'||item.inviteType.trim() eq '进口粮采购'}">&ndash;%&gt;--%>
							<%--<td name="deliveryPlace" class="supply"<c:if test="${item.inviteType.trim() eq '竞价销售' ||item.inviteType.trim() eq '协议销售'||item.inviteType.trim() eq '内部招标'||item.inviteType.trim() eq '其他'||item.inviteType.trim() eq '内部销售'}">style="display: none"</c:if>>${item.deliveryPlace}</td>&lt;%&ndash;卖方&ndash;%&gt;--%>
						<%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
						<%--<td name="compleRate">${item.compleRate}</td>--%>

						<%--<td name="inviteType">${item.inviteType}</td>--%>
						<%--<td name="schemeBatch">${item.schemeBatch}</td>--%>
						<%--<td name="schemeName">${item.schemeName}</td>--%>
						<%--<td name="biddingTime">${item.biddingTime}</td>--%>
						<%--<td name="startTime">${item.startTime}</td>--%>
						<%--<td name="endTime">${item.endTime}</td>--%>

						<%--<td><div tag="${item.dealSerial }" onclick="gi(this)" class="buttonArea quality-detail ">质量详情</div></td>--%>
					<%--</tr>--%>
				<%--</c:forEach>--%>
			</tbody>
		</table>
		</form>
		<div style="text-align:right;margin-top:20px;">
			<div class="buttonArea" id="add-tolist">添加</div>
		</div>
	</div>
</div>
<%--  --%>
<div id="float-alert-secon">
	<div id="table-wapper-secon">
		<span class="title">质量明细</span>  <%-- TODO--%>
		<i id="close-float-alert-secon" class="layui-icon">&#x1006;</i>
		<p>入库质检</p>
		<div style="margin-top:2%;padding-bottom:2%;border-bottom:1px solid #ccc">

		<form id="out-table-secon" style="    overflow: scroll;height: 420px;">
		<table>
			<thead>
				<tr>
					<td>检测项名称</td>
					<td>等级</td>
					<td>标准值</td>
					<td>检测值</td>
					<td>结论</td>
					<%--<td class="forShowOrHide1">质检详情</td>--%>
				</tr>
				<tr id="conclute-template1" style="display:none" >
					<td name="name"></td>
					<td name="level"></td>
					<td name="stand"></td>

					<td name="result"></td>
					<td name="commend"></td>
					<%--<td name="qualityResult" class="forShowOrHide"></td>--%>
				</tr>
			</thead>
			<tbody id="schemeDetail-data-list-secon">
				<%--<c:forEach items="${list }" var="item">
					<tr>
						<td><input type="radio" name="conclute-radio"></td>
						<td name="dealSerial">${item.dealSerial}</td>
						<td name="dealUnit">${item.dealUnit}</td>
						<td name="deliveryPlace">${item.deliveryPlace}</td>

						<td name="compleRate">${item.compleRate}</td>
						<td name="inviteType">${item.inviteType}</td>
						<td><div tag="${item.dealSerial }" onclick="gi(this)" class="buttonArea quality-detail ">质量详情</div></td>
					</tr>
				</c:forEach>--%>
			</tbody>
		</table>
		</form>
		<%--<div style="text-align:right;margin-top:20px;">
			<div class="buttonArea" id="add-tolist-secon">添加</div>
		</div>--%>
	</div>
</div>
<script>
    function clearNoNum(obj){
        obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3');//只能输入两个小数
        if(obj.value.indexOf(".")< 0 && obj.value !=""){//以上已经过滤，此处控制的是如果没有小数点，首位不能为类似于 01、02的金额
            obj.value= parseFloat(obj.value);
        }
    }
    function checkAmounts(obj) {
        var reg = /[A-Za-z]+/;
        var optionNum = $(obj).val();
        if (reg.test(optionNum)) {
            alert("只能输入数字");
            $(obj).val("");
        }
    }
    layui.form.render("select","search");
    var laydate=layui.laydate;
    laydate.render({
        elem:"#filter-warehoueYear",
        type:"year",
		change: function(value, date, endDate){
            //debugger
            $("#filter-warehoueYear").val(value);
            if($(".layui-laydate").length){
                $(".layui-laydate").remove();
            }
        },
        format:"yyyy",
    });

    function chongzi(){
        $("#filter-grainType option:selected").attr("selected",false);
        $("#filter-grainType").eq(0).attr("selected",true);
        $("#filter-receivePlace option:selected").attr("selected",false);
        $("#filter-receivePlace").eq(0).attr("selected",true);
        $("#filter-noticeType option:selected").attr("selected",false);
        $("#filter-noticeType").eq(0).attr("selected",true);


        $("#filter-warehoueYear").val("");
        $("#filter-quantity").val("");
        $("#filter-storehouse").val("");
        layui.form.render();
	}

	$("input[name='thisShipment']").blur(function(){
		var number = Number($(this).val()) + Number($("input[name='ladingBills']").val());
		if(Number($("input[name='contract']").val()) >= number){
			$("input[name='accumulatedBills']").val(number);
		}else{
			layer.msg("不能大于剩余数量!",{icon:0});
			$("input[name='accumulatedBills']").val("");
		}
	});

	$("#save,#submit").click(function(){
		var patchAll = true;
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				alert("*项为必填项,请补全相关信息");
				patchAll = false;
				return false;
			}
		});
        /*$(".processType").each(
            function (i,ele) {
				console.log($(this))
                console.log(ele.value)
				if(!$(this).val()){
                    alert("所属种类为必填项！");
                    patchAll = false;
                    return false;
				}
            }
		)*/
		if(!patchAll)
			return;
		var detailData = [];
		$(".data-tr").each(function(){
		    debugger
            var a = $(this).find("td[name='type']>select").val()
			detailData.push({
				"type":$(this).find("td[name='type']>select").val(),
				"advise":$(this).find("td[name='advise']>input").val(),
				"amount":parseFloat($(this).find("td[name='amount']>input").val()),
			});
		});
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData),
					"handleTime":$("span[name='createDate']>span").html(),
					"status":"待提交"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1},function(){
		  					window.location.href = "${ctx}/RotateProcess/Recording.shtml?type=Total";
						});
					}
				}
			});
		}else if($(this).html().indexOf('提交')!=-1){
			var way = $("#save").html().indexOf("保存")!=-1 ? "Add.shtml" : "Edit.shtml";
			$("form").ajaxSubmit({
				url:way,
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData),
					"handleTime":$("span[name='createDate']>span").html(),
					"status":"待审核",
					"id":"${recording.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1},function(){
		  					window.location.href = "${ctx}/RotateProcess/Recording.shtml?type=Total";
						});
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData),
					"handleTime":$("span[name='createDate']>span").html(),
					"id":"${recording.id }"
				},
				success:function(data){
					if(data.success){
						layer.msg("信息保存成功",{icon:1},function(){
		  					window.location.href = "${ctx}/RotateProcess/Recording.shtml?type=Total";
						});
					}
				}
			});
		}else{
			return false;
		}
	});
	
	$("#add-list").click(function(){
		var template = $("#template-tr").clone(true);
		$(template).removeAttr("id");
		$(template).addClass("data-tr");
		$("#data-result").append($(template));
		$(template).show();
	});
	
	$(".remove-detail").click(function(){
		$(this).parent().parent().hide(500,function(){
			$(this).remove();
		})
	});
	
	$("#choose-deal").click(function(){
	    $("#concluteButton").click();
		$("#float-alert").slideToggle(500,function(){
			$("#table-wapper").slideToggle(500);			
		});
	});




    $("#close-float-alert").click(function(){
		$("#table-wapper").slideToggle(500,function(){
			$("#float-alert").slideToggle(500,function(){
				//$("#schemeDetail-data-list").find("tr").remove();
			});
		});
	});
    $("#close-float-alert-secon").click(function(){
		$("#table-wapper-secon").slideToggle(500,function(){
			$("#float-alert-secon").slideToggle(500,function(){
				$("#schemeDetail-data-list-secon").find("tr").remove();
			});
		});
	});
	
	$("#add-tolist").click(function(){
		var soucedata = $("#schemeDetail-data-list").find("input[name='conclute-radio']:checked").eq(0);
		var trdata = $(soucedata).parent().parent();
		var aa=$(trdata).find("input[name='tagId']").val();

		$("#tagId").val(aa);
        $("input[name='buyerId']").val($(trdata).find("input[name='receiveId']").val());
        $("input[name='sellerId']").val($(trdata).find("input[name='deliveryId']").val());
		$("input[name='dealSerial']").val($(trdata).find("td[name='dealSerial']").html());
		$("input[name='buyer']").val($(trdata).find("td[name='receivePlace']").html());
		$("input[name='seller']").val($(trdata).find("td[name='deliveryPlace']").html());
		$("#close-float-alert").click();
		$("input[name='dealSerial']").change();
	});

    /**
     * 出库 隐藏  入库 显示 //点击搜索按钮
     * */
	$("#concluteButton").click(function(){
	    layer.load();
	    // debugger
		var getSelectVal = $('select[name="noticeType"]').val();
		$("#concluteForm").ajaxSubmit({
			success:function(data){
				$("#schemeDetail-data-list").find("tr").remove();
				for(var i = 0;i<data.length;i++){
				    var getIR = data[i]["dealSerial"];
				    var aa=data[i]["deliveryPlace"];
					var dataMode = $("#conclute-template").clone(true);

					let enterpriseId = data[i]["enterpriseId"];
					if(getSelectVal == '入库'){
						if(enterpriseId!=null && enterpriseId!=''){
							$(dataMode).find("input[name='receiveId']").val(enterpriseId);
							$(dataMode).find("td[name='receivePlace']").html(data[i]["enterpriseName"]);

						}else{
							$(dataMode).find("input[name='receiveId']").val(data[i]["receiveId"]);
							$(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
						}
                    }else{
                        $(dataMode).find("input[name='receiveId']").val(data[i]["receiveId"]);
                        $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
					}

                    $(dataMode).find("input[name='enterpriseId']").val(data[i]["enterpriseId"]);

                    $(dataMode).find("input[name='tagId']").val(data[i]["id"]);
                    // $(dataMode).find("input[name='receiveId']").val(data[i]["receiveId"]);
                    $(dataMode).find("input[name='deliveryId']").val(data[i]["deliveryId"]);
					$(dataMode).find("td[name='dealSerial']").html(data[i]["dealSerial"]);
					// $(dataMode).find("td[name='receivePlace']").html(data[i]["receivePlace"]);
					$(dataMode).find("td[name='deliveryPlace']").html(aa);
					$(dataMode).find("td[name='compleRate']").html(data[i]["compleRate"]);
                    $(dataMode).find("td[name='inviteType']").html(data[i]["inviteType"]);
                    $(dataMode).find("td[name='schemeBatch']").html(data[i]["schemeBatch"]);
                    $(dataMode).find("td[name='biddingTime']").html(data[i]["biddingTime"]);
                    $(dataMode).find("td[name='startTime']").html(data[i]["startTime"]);
                    $(dataMode).find("td[name='endTime']").html(data[i]["endTime"]);
                    $(dataMode).find("td[name='schemeName']").html(data[i]["schemeName"]);
                   /* $('.supply').css({'display': getSelectVal == '入库' ? 'block':'none'})
                    $('.customer').css({'display': getSelectVal == '出库' ? 'block':'none'})*/

                   if(getSelectVal == '入库'){

                      /* $('.supply').show();
                       $('.customer').hide();*/
                       //style="display: none"
                       $('.supply').css("display","");
                       $('.customer').css("display","none");
                   }else{
                       /*$('.supply').hide();
                       $('.customer').show();*/
                       $('.customer').css("display","");
                       $('.supply').css("display","none");
				   }
					 $('.forShowOrHide').css({'display': getSelectVal == '入库' ? 'table-cell':'none'})
                    getSelectVal == '入库' ?
						$(dataMode).find("td[name='qualityResult']").html('<div onclick="gi(this)" tag="'+getIR+'" class=" buttonArea quality-detail">质量详情</div>') : '';
                    //getSelectVal == '入库' ? 'block':$(dataMode).find("td[name='qualityResult']").remove()
                    $("#schemeDetail-data-list").append($(dataMode));
					$(dataMode).show();
				}
				layer.closeAll();
			},
			error : function () {
                layer.closeAll();
            }
		});
	});
	
	$("#filter-concluteButton").click(function(){
		var grainType = $("#filter-grainType").val();
		var receivePlace = $("#filter-receivePlace").val();
		$("#schemeDetail-data-list").find("input[type='checkbox']").each(function(){
			var trdata = $(this).parent().parent();
			var tempgrain = $(trdata).find("td[name='grainType']").html();
			var tempreceive = $(trdata).find("td[name='receivePlace']").html()
			if(tempgrain.indexOf(grainType) == -1){
				$(trdata).hide();
				return;
			}else if(tempreceive.indexOf(receivePlace) == -1){
				$(trdata).hide();
				return;
			}
			$(trdata).show();
		});
	});

	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/RotateProcess/Recording.shtml?type=Total";
		}, function(){
		  
		});
	});
	//点击  质量详情 按钮
    function gi(th){

        var dealSerial = $(th).attr("tag");
        $.ajax({
            url:"${ctx}/rotateConclute/GetQualityResult.shtml",
            type:"post",
            data:{
                "dealSerial":dealSerial
            },
            success:function(data){
                data = data.data;
                $("#schemeDetail-data-list-secon").empty();
                if(data.In != null){
                    var inData = typeof(data.In.qualityResultItems) != "undefined" ? data.In.qualityResultItems : data.In.qualityThirdItems;

                     for(var i=0;i<inData.length;i++){
                         var dataTamplate = $("#conclute-template1").clone();
                         $(dataTamplate).find("td[name='name']").html(inData[i].itemName);
                         $(dataTamplate).find("td[name='level']").html(inData[i].grade);
                        $(dataTamplate).find("td[name='stand']").html(inData[i].standard);
                         $(dataTamplate).find("td[name='result']").html(inData[i].result);
                         $(dataTamplate).find("td[name='commend']").html(inData[i].remark);
                         $("#schemeDetail-data-list-secon").append(dataTamplate);
                         $(dataTamplate).show();
                     }
                }else{
                    $("#schemeDetail-data-list-secon").append("<td colspan='5'>无对应数据</td>")
                }
                $("#float-alert-secon").slideToggle(400,function(){
                    $("#table-wapper-secon").slideToggle(400);
                  });
            }
        });
    };
</script>
	<script src="${ctx}/js/select/jquery.combo.select.js"></script>
	<script>
		layui.form.render();

        function numberFixed(obj,op){
            number = $(obj).val();
            if(number==null ||number =="" ){
                return
            }
            number = parseFloat(number).toFixed(op);
            $(obj).val(number);
        }


	</script>

<%@ include file="../common/AdminFooter.jsp" %>