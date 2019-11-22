<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>

<div class="row clear-m">
	<ol class="breadcrumb">
		<c:if test="${type==''}">
			<li>仓储管理</li>
			<li>粮油情监测管理</li>
			<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>

		</c:if>
		<c:if test="${type=='dc'}">
			<li>代储监管</li>
			<li>报表台账</li>

			<li><a href="${ctx }/storageGrainInspection.shtml">粮情检测记录</a></li>
		</c:if>
	</ol>
</div>

<style>
.layui-form-label{
	width:200px;
	text-align:right;
}
</style>

<div class="container-box clearfix" style="padding: 10px">
   	
   	<input type="hidden" name="id" value="${grainInspection.id }"/>
   	
   	<div class="layui-row ">
	   	<div class="layui-col-md6">
			<span>所属库点：</span>
			<span>${grainInspection.warehouse }</span>
		</div>
		<div class="layui-col-md6">
	   		<span>仓房编号：</span>
			<span>${grainInspection.encode }</span>
		</div>
	</div>
   
	<div class="layui-row ">
		<div class="layui-col-md6">
           	<span>填报日期：</span>
           	<span>${grainInspection.reportDateStr }
				<%--<fmt:formatDate value='${grainInspection.reportDate }' type='date' pattern='yyyy-MM-dd'/>--%></span>
		</div>
		<div class="layui-col-md6">
           	<span>天气：</span>
           	<span>${grainInspection.weather }</span>
		</div>
	</div>
	
	<div class="layui-row ">
		<div class="layui-col-md6">
	    	<span>实际数量（吨）：</span>
	    	<span>${grainInspection.quantity }</span>
	   	</div>
		<div class="layui-col-md6">
			<span>仓温（℃）：</span>
			<span>${grainInspection.storehouseTemp }</span>
		</div>
	</div>


	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>气温（℃）：</span>
			<span>${grainInspection.temperature }</span>
		</div>
        <div class="layui-col-md6">
        	<span>仓湿（RH%）：</span>
        	<span>${grainInspection.storehouseWet }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
	    	<span>气湿（RH%）：</span>
	    	<span>${grainInspection.airWet }</span>
	   	</div>
		<div class="layui-col-md6">
			<span>粮食品种：</span>
			<span>${grainInspection.grainType }</span>
		</div>
	</div>
    
    <!-- <div class="layui-row title">
		粮温检查情况：
	</div> -->
	
	  
	<!-- <fieldset class="layui-elem-field layui-field-title">
		<legend>粮温检查情况：</legend>
	</fieldset> -->
		
	<div class="layui-row title">
		<h5>粮温检查情况：</h5>
	</div>

	<table class="layui-table">
		<thead>
		<tr>
			<th style="width:10%;text-align: center">层数</th>
			<th style="text-align: center">最高(℃)</th>
			<th style="text-align: center">最低(℃)</th>
			<th style="text-align: center">平均(℃)</th>
		</tr>
		</thead>
		<!-- 表格内容start -->
		<tbody id="materialDetail" class="text-center">
		<%--['${idxStatus.count}']--%>
			<c:forEach items="${storageGrainInspectionTemps}" var="storageGrainInspectionTemp" varStatus="idxStatus">

		<tr><td style="width:6%" ><input type="hidden" name="storageGrainInspectionTemp[${idxStatus.index}].placeId" value="${storageGrainInspectionTemp.placeId}" style="width:0px;"/>第${idxStatus.count}层</td>
			<td ><input type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topMax" value="${storageGrainInspectionTemp.topMax}" lay-verify="" class="layui-input" placeholder="--请输入--"/></td>
			<td ><input type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topMin" value="${storageGrainInspectionTemp.topMin}" lay-verify="" class="layui-input" placeholder=""/></td>
			<td ><input type="text" name="storageGrainInspectionTemp[${idxStatus.index}].topAvg" value="${storageGrainInspectionTemp.topAvg}" lay-verify="" class="layui-input" placeholder=""/></td> </tr>

			</c:forEach>
		</tbody>
		<!-- 表格内容 end -->
		<td>整仓平均(℃)</td>
		<td colspan="3"><input type="text" name="temperatureAvg" value="${grainInspection.temperatureAvg}" lay-verify="" class="layui-input"   placeholder="--请输入--"/></td>
	</table>


<%--&nbsp;&nbsp;<span class="title">上层</span>
	<div class="layui-row ">
		<div class="layui-col-md4">
			<span>最高温（℃）：</span>
			<span>${grainInspection.topMax }</span>
		</div>
		<div class="layui-col-md4">
			<span>最低温（℃）：</span>            		
			<span>${grainInspection.topMin }</span>
		</div>
		
		<div class="layui-col-md4" >
			<span>平均温（℃）：</span>
			<span>${grainInspection.topAvg }</span>
		</div>
	</div>

	<!-- <div class="layui-row title">
		<h5>中上层</h5>
	</div> -->
	&nbsp;&nbsp;<span class="title">中上层</span>	
	<div class="layui-row ">
		<div class="layui-col-md4">
			<span>最高温（℃）：</span>
			<span>${grainInspection.topMiddleMax }</span>
		</div>
		<div class="layui-col-md4">
			<span>最低温（℃）：</span>
			<span>${grainInspection.topMiddleMin }</span>
		</div>
		<div class="layui-col-md4">
			<span>平均温（℃）：</span>
			<span>${grainInspection.topMiddleAvg }</span>
		</div>
  	</div>
  	    
	<!-- <div class="layui-row title">
		<h5>中下层</h5>
	</div> -->
	&nbsp;&nbsp;<span class="title">中下层</span>	
	<div class="layui-row ">
		<div class="layui-col-md4">
			<span>最高温（℃）：</span>
			<span>${grainInspection.lowMiddleMax }</span>
		</div>
		<div class="layui-col-md4">
			<span>最低温（℃）：</span>
			<span>${grainInspection.lowMiddleMin }</span>
		</div>
	
		<div class="layui-col-md4">
			<span>平均温（℃）：</span>
			<span>${grainInspection.lowMiddleAvg }</span>
		</div>
	</div>
			
	<!-- <div class="layui-row title">
		<h5>下层</h5>
	</div> -->
	&nbsp;&nbsp;<span class="title">下层</span>	
	<div class="layui-row ">
		<div class="layui-col-md4">
			<span>最高温（℃）：</span>
			<span>${grainInspection.lowMax }</span>
		</div>
		<div class="layui-col-md4">
			<span>最低温（℃）：</span>
			<span>${grainInspection.lowMin }</span>
		</div>
	  	<div class="layui-col-md4">
	  		<span>平均温（℃）：</span>
	  		<span>${grainInspection.lowAvg }</span>
	   	</div>
	</div>
	--%>
	<%--<div class="layui-row ">
		<div class="layui-col-md6">
     		<span>整仓平均粮温（℃）：</span>
     		<span>${grainInspection.temperatureAvg }</span>
		</div>
		&lt;%&ndash;<div class="layui-col-md6">
			<span>粮温是否异常：</span>
			<span>
				<c:if test="${grainInspection.temperatureAbnormal eq '1' }">是</c:if>
				<c:if test="${grainInspection.temperatureAbnormal eq '0' }">否</c:if>
			</span>
		</div>&ndash;%&gt;
	</div>--%>
	<div class="layui-row title">
		<h5>气体浓度：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md2">
		氧气(%)
		</div>
		<div class="layui-col-md5">
			<span>空间：</span>
			<span>${grainInspection.spaceOxy }</span>
		</div>
		<div class="layui-col-md5">
			<span>粮堆：</span>
			<span>${grainInspection.grainBulkOxy }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md2">
			磷化氢(ppm)
		</div>
		<div class="layui-col-md5">
			<span>空间：</span>
			<span>${grainInspection.spacePhosphine }</span>
		</div>
		<div class="layui-col-md5">
			<span>粮堆：</span>
			<span>${grainInspection.grainBulkPhosphine }</span>
		</div>
	</div>

           
	<div class="layui-row title"></div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>虫害检测方式：</span>
			<span>
				<c:forEach var="item" items="${grainInspection.pestCheckTypeList}">
					${item }
				</c:forEach>
			</span>
		</div>
	</div>
	<div class="layui-row">
		<span>虫害采样部位：</span>
		<span>
		<c:forEach var="item" items="${grainInspection.pestSampleSiteList }">
			${item }
		</c:forEach>
		</span>
	</div>
	<div class="layui-row ">
	    <div class="layui-col-md6">
	    	<span>检测点数（个）：</span>
	    	<span>${grainInspection.checkNum }</span>
		</div>
		<div class="layui-col-md6">
			<span>其中有害虫点数（个）：</span>
			<span>${grainInspection.pestSpot }</span>
		</div>
	</div>
    <div class="layui-row ">
		<div class="layui-col-md6">
			<span>发现虫害位置：</span>
		   	<span>${grainInspection.pestInsect }</span>
		</div>
      	<div class="layui-col-md6">
      		<span>虫害名称：</span>
      		<span>${grainInspection.pestNames }</span>
      	</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
	        <span>最高害虫密度（头/kg）：</span>
	    	<span>${grainInspection.pestDensity }</span>
		</div>
		<div class="layui-col-md6">
           	<span>其中主要害虫密度（头/kg）：</span>
           	<span>${grainInspection.majorPestDensity }</span>
		</div>
	</div>
    <div class="layui-row ">
		<div class="layui-col-md6">
			<span>判定虫粮等级：</span>
			<span>${grainInspection.pestLevel }</span>
		</div>
		<%--<div class="layui-col-md6">
			<span>熏蒸措施：</span>
			<span>${grainInspection.suffocate }</span>
		</div>--%>
	</div>
<!-- 	<fieldset class="layui-elem-field layui-field-title"> -->
<!-- 		<legend>粮情变化情况：</legend> -->
<!-- 	</fieldset> -->
	<%--<div class="layui-row title">
		<h5>粮情变化情况：</h5>
	</div>
	<div class="layui-row ">
           &lt;%&ndash;	<div class="layui-col-md6">
				<span>粮食有无发现发热：</span>
                <span>
                	<c:if test="${grainInspection.heat eq '1' }">有</c:if>
                	<c:if test="${grainInspection.heat eq '0' }">无</c:if>
                </span>
			</div>&ndash;%&gt;

			&lt;%&ndash;<div class="layui-col-md6">
                <span>粮食有无发现霉变：</span>
                <span>
                	<c:if test="${grainInspection.rot eq '1' }">有</c:if>
                	<c:if test="${grainInspection.rot eq '0' }">无</c:if>
                </span>
			</div>&ndash;%&gt;
	</div>--%>
	<!-- <fieldset class="layui-elem-field layui-field-title">
		<legend>仓房安全情况：</legend>
	</fieldset> -->
	<div class="layui-row title">
		<h5>仓房安全情况：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>仓房设施方面：</span>
			<span>
				<c:if test="${grainInspection.shedLeakage eq '1' }">有</c:if>
              	<c:if test="${grainInspection.shedLeakage eq '0' }">无</c:if>
			</span>
		</div>
		<div class="layui-col-md6">
        	<span>漏雨防潮方面：</span>
        	<span>
				<c:if test="${grainInspection.wallLeakage eq '1' }">有</c:if>
              	<c:if test="${grainInspection.wallLeakage eq '0' }">无</c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>防火安全方面：</span>
			<span>
				<c:if test="${grainInspection.doorLeakage eq '1' }">有</c:if>
				<c:if test="${grainInspection.doorLeakage eq '0' }">无</c:if>
			</span>
		</div>
	    <div class="layui-col-md6">
	    	<span>用电安全方面：</span>
	        <span>
	        	<c:if test="${grainInspection.shedCrack eq '1' }">有</c:if>
				<c:if test="${grainInspection.shedCrack eq '0' }">无</c:if>
	    	</span>
		</div>
	</div>
	<%--<div class="layui-row ">
		<div class="layui-col-md6">
			<span>墙体、地坪有无发现裂缝：</span>
			<span>
				<c:if test="${grainInspection.wallCrack eq '1' }">有</c:if>
				<c:if test="${grainInspection.wallCrack eq '0' }">无</c:if>
			</span>
		</div>
		<div class="layui-col-md6">
			<span>门窗有无发现裂缝：</span>
			<span>
				<c:if test="${grainInspection.doorCrack eq '1' }">有</c:if>
				<c:if test="${grainInspection.doorCrack eq '0' }">无</c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>仓内照明是否故障：</span>
            <span>
            	<c:if test="${grainInspection.light eq '1' }">是</c:if>
            	<c:if test="${grainInspection.light eq '0' }">否</c:if>
            </span>
        </div>
     	<div class="layui-col-md6">
			<span>上下楼梯是否安全：</span>
			<span>
				<c:if test="${grainInspection.stairs eq '1' }">有</c:if>
				<c:if test="${grainInspection.stairs eq '0' }">无</c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>辅助设施是否完好：</span>
			<span>
				<c:if test="${grainInspection.facilities eq '1' }">是</c:if>
				<c:if test="${grainInspection.facilities eq '0' }">否</c:if>
			</span>
		</div>
	</div>--%>
	<!-- <fieldset class="layui-elem-field layui-field-title">
		<legend>仓内清卫情况：</legend>
	</fieldset> -->
	<div class="layui-row title">
		<h5>鼠雀卫生情况：</h5>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
		<span>仓内有无发现鼠雀：</span>
		<span>
			<c:if test="${grainInspection.mouse eq '1' }">有</c:if>
			<c:if test="${grainInspection.mouse eq '0' }">无</c:if>
		</span>
		</div>
		<%--<div class="layui-col-md6">
		    <span>仓内有无发现蛛网：</span>
		    <span>
		    	<c:if test="${grainInspection.cobweb eq '1' }">有</c:if>
		    	<c:if test="${grainInspection.cobweb eq '0' }">无</c:if>
		    </span>
		</div>--%>
	</div>
	<div class="layui-row ">
    	<div class="layui-col-md6">
			<span>仓内卫生情况：</span>
           	<span>
           		<c:if test="${grainInspection.hygiene eq '1' }">好</c:if>
           		<c:if test="${grainInspection.hygiene eq '0' }">差</c:if>
           	</span>
  		</div>
	</div>
	<div class="layui-row title"></div>	
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>检查情况评估：</span>
			<span>
				<c:if test="${grainInspection.checkSituation eq '1' }">粮情稳定，储存安全</c:if>
				<c:if test="${grainInspection.checkSituation eq '0' }">存在隐患，处理意见：
					<span>${grainInspection.advice}</span></c:if>
			</span>
		</div>
	</div>
	<div class="layui-row ">
       	<div class="layui-col-md6">
       		<span>检查性质：</span>
			<span>${grainInspection.checkProperty }</span>
		</div>
		<div class="layui-col-md6">
			<span>检查负责人：</span>
          	<span>${grainInspection.checkCharge }</span>
		</div>
	</div>
	<div class="layui-row ">
		<div class="layui-col-md6">
			<span>检查人员：</span>
            <span>${grainInspection.checker }</span>             	
		</div>
		<div class="layui-col-md6">
			<span>保管员：</span>
			<span>${grainInspection.keeper }</span>
		</div>
	</div>
	<div class="layui-row ">
		<span>备注：</span>
		<p>
			${grainInspection.remark }
		</p>
		<%-- <textarea class="layui-textarea" style="width:800px">${grainInspection.remark }</textarea> --%>
	</div>
    <p class="btn-box text-center">
    	<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="cancel_btn"
        onclick="cancelOperate('${auvp }', '${ctx }/storageGrainInspection.shtml?type=${type}')">返回</button>
    </p>
</div>

<script src="${ctx}/js/app/storage/common.js"></script>
<script>

if ('${auvp }' !== 'a') {
 	//为所有radio赋值
	$("input[name='heat'][value=${grainInspection.heat }]").attr("checked",true);
	$("input[name='temperatureAbnormal'][value=${grainInspection.temperatureAbnormal }]").attr("checked",true);
	$("input[name='rot'][value=${grainInspection.rot }]").attr("checked",true);
	$("input[name='shedLeakage'][value=${grainInspection.shedLeakage }]").attr("checked",true);
	$("input[name='wallLeakage'][value=${grainInspection.wallLeakage }]").attr("checked",true);
	$("input[name='doorLeakage'][value=${grainInspection.doorLeakage }]").attr("checked",true);
	$("input[name='shedCrack'][value=${grainInspection.shedCrack }]").attr("checked",true);
	$("input[name='wallCrack'][value=${grainInspection.wallCrack }]").attr("checked",true);
	$("input[name='doorCrack'][value=${grainInspection.doorCrack }]").attr("checked",true);
	$("input[name='stairs'][value=${grainInspection.stairs }]").attr("checked",true);
	$("input[name='facilities'][value=${grainInspection.facilities }]").attr("checked",true);
	$("input[name='mouse'][value=${grainInspection.mouse }]").attr("checked",true);
	$("input[name='light'][value=${grainInspection.light }]").attr("checked",true);
	$("input[name='cobweb'][value=${grainInspection.cobweb }]").attr("checked",true);
	$("input[name='hygiene'][value=${grainInspection.hygiene }]").attr("checked",true);
	$("input[name='checkSituation'][value=${grainInspection.checkSituation }]").attr("checked",true);

    //为所有checkbox赋值
	var arr = new Array();
 	<c:forEach items="${grainInspection.pestSampleSiteList }" var="t">  
		arr.push("${t}");
		//console.log("${t}");
	</c:forEach>
 	for (i in arr) {
 		$("input:checkbox[value=" + arr[i] + "]").attr('checked','true');
 	}

    //虫害检测方式
    var arr1 = new Array();
    <c:forEach items="${grainInspection.pestCheckTypeList}" var="u">
    arr1.push("${u}")
    </c:forEach>
    for (j in arr1) {
        $("input:checkbox[value=" + arr1[j] + "]").attr('checked','true');
    }
 	
 	/* $("textarea[name=remark]").val("${grainInspection.remark }"); */
} 

if ('${auvp }' === 'v') {
	$('input').attr('disabled','disabled');
	$('select').attr('disabled','disabled');
	$('#cancel_btn').text('返回');//取消按钮
    $('#submit_btn').css('display','none');//提交按钮
    $('p[name=prompt]').css('display','none');//备注文字
    $("textarea[name=remark]").attr("disabled","disabled");

}

layui.use(['form', 'laydate'], function(){
	var laydate = layui.laydate,
	form = layui.form;
	
	$('.date-need').each(function(){
		laydate.render({
			elem: this
		});
	});
	
	form.render();
	
	form.on('submit(submit_btn)', function(){
		var form = $('#form');
      	var json = JSON.stringify(form.serializeObject());
      	console.log(json);
      	$.ajax({
          	type : 'POST',
          	url : '${ctx }/storageGrainInspection/save.shtml?auvp=${auvp}',
          	dataType : "json",
			contentType : "application/json",
          	data : json,
            error: function(request) {
               if(request.responseText){
                   layer.open({
                       type: 1,
                       area: ['700px', '430px'],
                       fix: false,
                       content: request.responseText
                   });
               }
           },
           success : function(result) {
  	                if (!result.success) {
  	                    layer.alert(result.msg, {icon:2});
  	                    return;
  	                } else {
  	                    layer.msg(result.msg,{time:1000,icon:1},function(){
  	                    	location.href = '${ctx }/storageGrainInspection.shtml';
  	                    });
  	                }
  	        }
      	});
	});
	
	form.on('select(encode)', function(data){
		if (data.value === "") {
			$("input[name='quantity']").val("");
			return false;
		}
		$.ajax({
			/* type : 'POST', */
	       	url : '${ctx }/storageGrainInspection/getQuantity.shtml',
	       	data : {
	       		'warehouse' : $("input[name='warehouse']").val(),
	       		'storehouse' : data.value,
	       	},
			error: function(request) {
				if(request.responseText){
				    layer.open({
				        type: 1,
				        area: ['700px', '430px'],
				        fix: false,
				        content: request.responseText
				    });
				}
				$("input[name='quantity']").val("");
			},
			success : function(result) {
				if (result.success) {
					$("input[name='quantity']").val(result.data);
				} else {
					layer.msg(result.msg + '，已经将实际数量置为"-1"',{icon : 0});
					$("input[name='quantity']").val('-1');
				}
				
			}
		});
	});
});

function calculateAverage() {
	var lowAvg = Number($('input[name="lowAvg"]').val());
	var lowMiddleAvg = Number($('input[name="lowMiddleAvg"]').val());
	var topMiddleAvg = Number($('input[name="topMiddleAvg"]').val());
	var topAvg = Number($('input[name="topAvg"]').val());
	var avg = ((lowAvg + lowMiddleAvg + topMiddleAvg + topAvg)/4).toFixed(2);
	$('input[name="temperatureAvg"]').val(avg);
}



</script>