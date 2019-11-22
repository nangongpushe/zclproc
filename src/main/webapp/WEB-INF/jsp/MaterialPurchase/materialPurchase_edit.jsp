<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
	#data-head tr th{
		text-align: center;
	}
.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
	text-align: right;
    width: 30% ;
    max-width:120px;
}

.layui-form-item .layui-input-inline{
  width: 65% ;
}
.layui-form-item {
    margin-bottom: 1px;
    }

</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>物资管理</li>
		<li class="active">采购管理</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

 <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
    <div class="layui-form" id="search" >
 	 <input type="hidden" name="id"  value="${materialPurchase.id }"/>
     <input type="hidden" name="purchaseSerial"  value="${materialPurchase.purchaseSerial }"/>
		<div class="layui-form-item">
			
			<div class="layui-inline ">
				<label class="layui-form-label " ><span class="red">*</span>申购部门:</label>
				<div class="layui-input-inline ">
					<input type="text" lay-verify="required" value="${materialPurchase.purchaseDept }" readOnly class="layui-input" name="purchaseDept" id="purchaseDept" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline ">
				<label class="layui-form-label"><span class="red">*</span>预计总金额:</label>
				<div class="layui-input-inline">
					<input type="text" lay-verify="number|customNumber" readonly="readonly" style="background:#CCCCCC"  value="<fmt:formatNumber type="number" value="${materialPurchase.totalAmount}" pattern="0.00" maxFractionDigits="2"/>" class="layui-input" name="totalAmount" id="totalAmount"
						autocomplete="off" maxlength="10" >

				</div>
			</div>
			
		
			
			<div class="layui-inline ">
				<label class="layui-form-label "><span class="red">*</span>申购人:</label>
				<div class="layui-input-inline">
					<input type="text" lay-verify="required" class="layui-input" value="${materialPurchase.purchaseMan }" readOnly name="purchaseMan" id="purchaseMan" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline ">
				<label class="layui-form-label"><span class="red">*</span>申购日期:</label>
				<div class="layui-input-inline">
					<input type="text" lay-verify="required" value="${materialPurchase.purchaseDate }"  class="layui-input" name="purchaseDate" id="purchaseDate"
						autocomplete="off">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item layui-form-text">
		    <label class="layui-form-label"><span class="red">*</span>采购原因</label>
		    <div class="layui-input-inline" style="width:75%">
		      <textarea  lay-verify="required" placeholder="--限500字--" maxlength="500" name="purchaseReason" class="layui-textarea">${materialPurchase.purchaseReason } </textarea>
		    </div>
	  </div>
	
	<!-- </div> -->
	
	 <hr class="layui-bg-green">

       
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addMaterialName();">新增明细</button>
                
          
        	<table class="layui-table" >
                <thead id="data-head">
                <tr>
                     <th style="width:6%">操作</th>
                    <th><span class="red">*</span>物资/材料名称</th><th><span class="red">*</span>规格型号</th><th><span class="red">*</span>采购数量 </th><th><span class="red">*</span>单价(元)</th><th><span class="red">*</span>预计单价(元)</th><th>备注</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                 <tbody id="materialDetail" class="text-center">
                 <c:forEach items="${materialPurchaseDeatils}" var="materialPurchaseDeatil">  
                 <tr>
	                 <td style="width:6%"><input type="hidden" name="purchaseId" value="${materialPurchaseDeatil.purchaseId }" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small" onclick="toDelete(this);">删除</a>	</td>
	                 <td ><input type="text" name="materialName" maxlength="20" value="${materialPurchaseDeatil.materialName }" lay-verify="required" class="layui-input"   placeholder="--请输入--"/></td>
	                 <td ><input type="text" name="model" value="${materialPurchaseDeatil.model }" maxlength="10"  class="form-control validate[required] "  placeholder=""/></td>
	                  <td ><input type="text" name="quantity" onblur ="sumPic(this);" maxlength="5" value="${materialPurchaseDeatil.quantity }"  lay-verify="required" class="layui-input"  placeholder="" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
	                  <td ><input type="text" name="unitPrice" onBlur="checkAmounts(this);" maxlength="5" value="${materialPurchaseDeatil.unitPrice }"  lay-verify="required"  class="layui-input"  placeholder="" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/></td>
	                  <td ><input type="text" name="estimatedUnitPrice" onblur ="sumPic(this);" maxlength="5" value="${materialPurchaseDeatil.estimatedUnitPrice }" lay-verify="required" class="layui-input"   placeholder="" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/></td>
	                  <td ><textarea type="text" name="remark" maxlength="500"  class="form-control" placeholder="--限500字--">${materialPurchaseDeatil.remark }</textarea></td>
                   </tr>
                    </c:forEach>
                </tbody>
                <!-- 表格内容 end -->
            </table>
      
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
                <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
  
    	</div>
	</div>
    </form>
    
   
</div>


<script>

layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#purchaseDate' //指定元素
	  });


    //自定义验证规则
    form.verify({
        //非零开头的最多带两位小数的数字
        customNumber: function(value){
            if(value.length!=0){
                if(value<=0){
                    return '只能输入大于0的数';
                }
                /*if(!(/^\d+(\.\d+)?$/.test(value))){
                    return '只能输入大于0的数';
                }*/
            }
        }});
    ;


    //监听提交
  form.on('submit(save)', function(data){
	  layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/MaterialPurchase.shtml";
					})
					
				}
				}); 
    return false;
  });
  
  
});
function checkAmounts(obj) {
    var reg = /[A-Za-z]+/;
    var optionNum = $(obj).val();
    if (reg.test(optionNum)) {
        alert("只能输入数字");
        $(obj).val("");
    }
}
function sumPic(obj) {
    var reg = /[A-Za-z]+/;
    var optionNum = $(obj).val();
    if (reg.test(optionNum)) {
        alert("只能输入数字");
        $(obj).val("");
    }
    var quantityList=  $("input[name='quantity']")
    var estimatedUnitPriceList=  $("input[name='estimatedUnitPrice']")
    var sum=0;
	for (var i=0;i<quantityList.length;i++){
        var quantity=$( quantityList[i]).val()
        var estimatedUnitPrice=$( estimatedUnitPriceList[i]).val()
		if (quantity!=null&&quantity!=''&&estimatedUnitPrice!=null&&estimatedUnitPrice!=''){
            var acc = accMul(quantity, estimatedUnitPrice);
            sum=accAdd(sum,acc);;
		}else{
		    /*if (quantity==null||quantity==''){
                alert("第"+(i+1)+"行请先填写采购数量");
                document.getElementById("totalAmount").value="";
                return;
			}else if (estimatedUnitPrice==null||estimatedUnitPrice1==''){
                alert("第"+(i+1)+"行请先填写预计单价");
                document.getElementById("totalAmount").value="";
                return;
			}*/
		}

	}
    document.getElementById("totalAmount").value=sum;

   /* if (quantity != null && quantity != '') {
        var totalAmount = document.getElementById("totalAmount").value;
        var acc = accMul(quantity, obj.value);
        if (totalAmount != null && totalAmount != '') {
            var sum=accAdd(totalAmount,acc);
            document.getElementById("totalAmount").value=sum;
        }else {
            document.getElementById("totalAmount").value=acc;
        }
        quantity='';
    } else {
        alert("请先填写采购数量");
        obj.value = '';
    }
*/
}

function accMul(arg1, arg2) {
    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
    try {
        m += s1.split(".")[1].length;
    } catch (e) {
    }
    try {
        m += s2.split(".")[1].length;
    } catch (e) {

    }
    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
}

function accAdd(arg1, arg2) {
    var r1, r2, m, c;
    try {
        r1 = arg1.toString().split(".")[1].length;
    } catch (e) {
        r1 = 0;
    }
    try {
        r2 = arg2.toString().split(".")[1].length;
    } catch (e) {
        r2 = 0;
    }
    c = Math.abs(r1 - r2);
    m = Math.pow(10, Math.max(r1, r2));
    if (c > 0) {
        var cm = Math.pow(10, c);
        if (r1 > r2) {
            arg1 = Number(arg1.toString().replace(".", ""));
            arg2 = Number(arg2.toString().replace(".", "")) * cm;
        } else {

            arg1 = Number(arg1.toString().replace(".", "")) * cm;

            arg2 = Number(arg2.toString().replace(".", ""));

        }

    } else {

        arg1 = Number(arg1.toString().replace(".", ""));

        arg2 = Number(arg2.toString().replace(".", ""));

    }
    return (arg1 + arg2) / m;

}
   function addMaterialName(){
   var tr =   '<tr><td style="width:6%"><input type="hidden" name="purchaseId" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn-primary layui-btn-small" onclick="toDelete(this);">删除</a>	</td>'
                +'<td ><input type="text" lay-verify="required" maxlength="20" class="layui-input" name="materialName"    placeholder="--请输入--"/></td>'
                +'<td ><input type="text" name="model" lay-verify="required" maxlength="10" class="layui-input"  placeholder=""/></td>'
                +'<td ><input type="text" name="quantity" onblur ="sumPic(this);" maxlength="5" lay-verify="number|customNumber" class="layui-input"   placeholder="" /></td>'
                +'<td ><input type="text" name="unitPrice" onBlur="checkAmounts(this);" maxlength="5" lay-verify="number|customNumber" class="layui-input"   placeholder="" /></td>'
                +'<td ><input type="text" name="estimatedUnitPrice" onblur ="sumPic(this);" maxlength="5"  lay-verify="number|customNumber" class="layui-input"  placeholder=""/></td>'
                +'<td ><textarea type="text" name="remark"  maxlength="500"  class="form-control" placeholder="--限500字--"></textarea></td> </tr>'
         
   	$("#materialDetail").append(tr);
   }
    
    function toDelete(ob){
      $(ob).parent().parent().remove();
        sumPic();
    }
    
    
	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	

	
</script>
