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
	margin-left: 4%;
}

#infoArea span {
	padding-right: 100px;
}

.requiredData {
	color: red;
}

#mainInfo {
	margin-top: 20px;
	margin-left: 2.5%;
}

#mainInfo>div {
	padding: 10px 0;
	width: 100%;
}

#mainInfo>div span {
	width: 10%;
	display: inline-block;
	text-align: right;
}

.inputArea {
	width:89%;
	padding:5px;
	outline: none;
	border:1px solid #ccc;
	resize: none;
}

.buttonArea {
	padding:5px 15px;
	background:#009688;
	border:none;
	color:#fff;
	cursor:pointer;
	display:inline;
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
	width: 9%;
	border:1px solid #e2e2e2;
	padding: 10px 0;
}

tbody tr {
	border-bottom: 1px solid #ccc;
}

#bottom-button {
	text-align: right;
	padding-right: 20px;
	margin-top: 20px;
}

#bottom-button>div {
	margin-right: 10px;
}

#template-tr {
	display:none;
}

#float-alert{
	position:absolute;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background:RGBA(0,0,0,0.75);
	z-index:2;
	display:none;
}

#table-wapper{
	display:none;
	margin:0 auto;
	margin-top:100px;
	background:#fff;
	border-top:1px solid RGB(42, 180, 168);
	padding:1%; 
	width:58.5%;
	height:400px;
} 

#table-wapper table{
	margin:0;
}

#table-wapper table td:first-child{
	width:3%;
}

#close-float-alert{
	position:relative;
	left:88.5%;
	font-size: 30px; 
	color:RGB(42, 180, 168);
	cursor: pointer;
}

#noticeDetail-data-list input[type=checkbox]{
	width:30%;
	outline:none;
}

#out-table{
	height:240px;
	overflow:auto;
	margin-top:20px;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>中转业务</li>
		<li>中转业务统计</li>
		<li class="active">${transfer.id!=null?'编辑':'新增' }中转业务</li>
	</ol>
</div>
<div id="outSide">
	<form action="Add.shtml" method="Post" enctype="multipart/form-data">
		<div id="dataArea" class="infoArea">
			<span class="title">中转业务信息</span>
			<div id="mainInfo">
				<div>
					<span><b class="requiredData">*</b>单位名称：</span>
					${transfer.unitName }
				</div>
				<div>
					<span><b class="requiredData">*</b>中转日期：</span>
					<input class="inputArea" id="transfer-date" name="transferDate" value="<fmt:formatDate value="${transfer.transferDate}" pattern="yyyy-MM-dd"/>"/>
				</div>
				<div>
					<span><b class="requiredData">*</b>填报时间：</span> 
					<fmt:formatDate value="${transfer.reportTime }" pattern="yyyy年MM月dd日"/>
				</div>
				<div>
					<span style="position:relative;bottom:4em">备注：</span>
					<textarea rows="4" class="inputArea" style="width:88%" name="remark" maxlength="400">${transfer.remark }</textarea>
				</div>
			</div>
		</div>
		<div id="listArea">
			<div class="buttonArea" id="add-list">新增</div>
			<table>
				<thead>
					<tr>
						<td>货主名称</td>
						<td>货物名称</td>
						<td>到港日期</td>
						<td>中转数量(吨)</td>
						<td>中转去向</td>
						<td>运输方式</td>
						<td>中转收入(万元)</td>
						<td>中转支出(万元)</td>
						<td>中转利润(万元)</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody id="data-result">
					<tr id="template-tr">
						<td name="shipperName">
							<input style="width:80%" class="inputArea" maxlength="45"/>
						</td>
						<td name="goodsName">
							<input style="width: 80%" class="inputArea" maxlength="45"/>
						</td>
						<td name="arrivalDate">
							<input style="width: 80%" class="inputArea dateNeed" id="arrivalDate"/>
						</td>
						<td name="quantity">
							<input style="width: 80%"  class="inputArea"   onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="15"/>
						</td>
						<td name="destination">
							<input style="width:80%" class="inputArea" maxlength="50"/>
						</td>
						<td name="shipType">
							<select class="inputArea">
								<option>船运</option>
								<option>汽运</option>
							</select>
						</td>
						<td name="income">
							<input style="width: 80%" class="inputArea"  onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="9" />

							</td>
						<td name="expend">
							<input style="width: 80%"  class="inputArea"  onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="9" />

						</td>
						<td name="profits"></td>
						<td><div class="buttonArea remove-detail">删除</div></td>
					</tr>
					<c:forEach items="${transfer.transferDetail }" var="item">
						<tr class="data-tr" tag="${item.id }">
							<td name="shipperName"><input style="width: 80%" class="inputArea"
								value="${item.shipperName}" maxlength="45"></td>
							<td name="goodsName"><input style="width: 80%"
								class="inputArea" value="${item.goodsName }" maxlength="45"></td>
							<td name="arrivalDate"><input style="width: 80%"
								class="inputArea dateNeed" value="${item.arrivalDate }"></td>
							<td name="quantity">
								<input style="width: 80%" class="inputArea" value="${item.quantity }"   onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="15"/>
							</td>
							<td name="destination">
								<input style="width: 80%" class="inputArea" value="${item.destination }" maxlength="50"/>
							</td>
							<td name="shipType"> 
								<select class="inputArea">
									<option <c:if test="${item.shipType == '船运'}">selected</c:if> >船运</option>
									<option <c:if test="${item.shipType == '汽运'}">selected</c:if> >汽运</option>
								</select>
							</td>
							<td name="income">
								<input style="width: 80%"  class="inputArea" type="text" value="${item.income }"   onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="9"/>

							</td>
							<td name="expend">

								<input style="width: 80%"  class="inputArea" type="text" value="${item.expend }"  onkeyup="value=value.replace(/[^\d\.]/g,'')" maxlength="9"/>
			</td> 
							<td name="profits">
								<fmt:formatNumber type="number" value="${item.income - item.expend }" pattern="0.00" maxFractionDigits="2"/>
							</td>
							<td><div class="buttonArea remove-detail">删除</div></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div id="bottom-button">
				<div class="buttonArea" id="save">
					<c:choose>
						<c:when test="${transfer.id != null }">编辑</c:when>
						<c:otherwise>保存</c:otherwise>
					</c:choose>
				</div>
				<div class="buttonArea" id="submit">提交</div>
				<div class="buttonArea" id="cancel">取消</div>
			</div>
		</div>
	</form>
</div>
<script>

	var laydate=layui.laydate;
	laydate.render({
		elem:"#transfer-date",
		type:"date",
		format:"yyyy-MM-dd"
	});
	
	$(".dateNeed").each(function(){
		laydate.render({
			elem:$(this)[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
	});
	
	$("#save,#submit").click(function(){
		var patchAll = true;
		$(".requiredData").parent().parent().find("input,select").each(function(){
			if($(this).val() == ""){
				layer.msg("*项为必填项,请补全相关信息",{icon:0})
				patchAll = false;
				return false;
			}
		});
		$(".data-tr input").each(function(){
			if($(this).val() == ""){
				layer.msg("*项为必填项,请补全相关信息",{icon:0})
				patchAll = false;
				return false;
			}
		});
		if($(".data-tr").length == 0){
			layer.msg("明细至少需要一条",{icon:0});
			patchAll = false;
			return false;
		}
		
		var detailData = [];
		var falg=0;
		$(".data-tr").each(function(){
          var income=  $(this).find("td[name='income']").find("input").val();
            var expend=  $(this).find("td[name='expend']").find("input").val();
            
            var quantity=  $(this).find("td[name='quantity']").find("input").val();
            /*if(!(/^\d+(\.\d+)?$/.test(income))){
                falg=1;
            }if(!(/^\d+(\.\d+)?$/.test(expend))){
                falg=1;

            }*/
            
            if(quantity!=='' && !/^\d{1,9}(\.\d{1,3})?$/.test(quantity)) {
               layer.msg("中转数量请输入最长9位，小数位最多3位的数字",{icon:0}); 
               patchAll=false; 
               return false;
           }
			if(income!=='' && !/^\d{1,9}(\.\d{1,3})?$/.test(income)) {
               layer.msg("中转收入请输入最长9位，小数位最多3位的数字",{icon:0}); 
               patchAll=false; 
               return false;
           }
           
           if(expend!=='' && !/^\d{1,9}(\.\d{1,3})?$/.test(expend)) {
               layer.msg("中转支出请输入最长9位，小数位最多3位的数字",{icon:0}); 
               patchAll=false; 
               return false;
           }

            detailData.push({
				"id":$(this).attr("tag") == ""?0:$(this).attr("tag"),
				"shipperName":$(this).find("td[name='shipperName']").find("input").val(),
				"goodsName":$(this).find("td[name='goodsName']").find("input").val(),
				"arrivalDate":$(this).find("td[name='arrivalDate']").find("input").val(),
				"quantity":parseFloat($(this).find("td[name='quantity']").find("input").val()),
				"destination":$(this).find("td[name='destination']").find("input").val(),
				"shipType":$(this).find("td[name='shipType']").find("select").val(),
				"income":parseFloat($(this).find("td[name='income']").find("input").val()),
				"expend":parseFloat($(this).find("td[name='expend']").find("input").val()),
				"profits":parseFloat($(this).find("td[name='profits']").html())
			});
		});
		
		if(!patchAll)
			return;
		if(falg==1) {
            alert("中转收入与支出必须为大于0的数")
            return;
        }
		if($(this).html().indexOf('保存')!=-1){
			$("form").ajaxSubmit({
				type:"post",
				data:{
					"detailList":JSON.stringify(detailData),
					"status":"待提交"
				},
				success:function(data){
					if(data.success){
						layer.msg("保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Transfer.shtml";
						})
					}else{
						layer.msg("保存失败",{icon:2})
					}
				}
			});
		}else if($(this).html().indexOf('提交')!=-1){
			var url = $("#save").html().indexOf("保存")!=-1?"Add.shtml":"Edit.shtml";
			$("form").ajaxSubmit({
				url:url,
				data:{
					"id":"${transfer.id}",
					"status":"审核中",
					"detailList":JSON.stringify(detailData)
				},
				type:"post",
				success:function(data){
					if(data.success){
						layer.msg("保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Transfer.shtml";
						});
					}else{
						layer.msg("保存失败",{icon:2})
					}
				}
			});
		}else if($(this).html().indexOf('编辑')!=-1){
			$("form").ajaxSubmit({
				url:"Edit.shtml",
				data:{
					"id":"${transfer.id}",
					"detailList":JSON.stringify(detailData)
				},
				type:"post",
				success:function(data){
					if(data.success){
						layer.msg("保存成功",{icon:1}, function(){
						  	window.location.href = "${ctx}/Transfer.shtml";
						});
					}else{
						layer.msg("保存失败",{icon:2})
					}
				}
			});
		}else{
			return false;
		}
	});
	
	$("#add-list").click(function(){
		var template = $("#template-tr").clone(true);
		$(template).find("td[name='shipperName']").find("input").val();
		$(template).find("td[name='goodsName']").find("input").val();
		$(template).find("td[name='arrivalDate']").find("input").val();
		$(template).find("td[name='quantity']").find("input").val();
		$(template).find("td[name='destination']").val();
		$(template).find("td[name='shipType']").find("select").val();
		$(template).addClass("data-tr");
		$("#data-result").append($(template));
		laydate.render({
			elem:$(template).find("td[name='arrivalDate']>input")[0],
			type:"date",
			format:"yyyy-MM-dd"
		});
		$(template).slideToggle(500);
	});
	
	$(".remove-detail").click(function(){
		$(this).parent().parent().hide(500,function(){
			$(this).remove();
		});
	});
	
	$("td[name='income']>input,td[name='expend']>input").blur(function(){
		var tr = $(this).parent().parent();
		var incomeval = $(tr).find("td[name='income']>input").val();
		var expendval = $(tr).find("td[name='expend']>input").val();
		if(incomeval !='' && expendval !=''){
			$(tr).find("td[name='profits']").html(accSub(incomeval,expendval));
//            alert(accSub(incomeval,expendval));
		}else{
			$(tr).find("td[name='profits']").html("");
		}
	});

    function accSub(arg1, arg2) {
        var r1, r2, m, n,k1,k2;
        try {
            r1 = arg1.toString().split(".")[1].length;
            k1 = arg1.toString().split(".")[0].length;
            if (r1>3){
                alert("中转收入小数点后只能输入三位");
                return;
			}
			if (k1>9){
                alert("中转收入小数点前只能输入三位");
                return;
			}
        }    catch (e) {
            r1 = 0;

        }    try {
            r2 = arg2.toString().split(".")[1].length;
            k2 = arg2.toString().split(".")[0].length;
            if (r2>3){
                alert("中转支出小数点后只能输入三位");
                return;
            }
            if (k2>9){
                alert("中转支出小数点前只能输入三位");
                return;
            }
        }    catch (e) {
            r2 = 0;
        }
        m = Math.pow(10, Math.max(r1, r2)); //last modify by deeka //动态控制精度长度
        n = (r1 >= r2) ? r1 : r2;    return ((arg1 * m - arg2 * m) / m).toFixed(n);
    };
	$("#cancel").click(function(){
		layer.confirm('你确定要放弃编辑吗？', {
			btn: ['是','否']
		}, function(){
		  	window.location.href = "${ctx}/Transfer.shtml";
		}, function(){
		  
		});
	});
</script>
<%@ include file="../common/AdminFooter.jsp"%>