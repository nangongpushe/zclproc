<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

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
		<li>库存管理</li>
		<li class="active">易耗品入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
   
    <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
          <input type="hidden" name="id"  value=""/>
           <input type="hidden" name="optionsId"  value=""/>
           <input type="hidden" name="groupId"  value=""/>
           <input type="hidden" name="storehouse"  value="" id="storehouse"/>

      <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>所入库房:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
						id="warehouseId">
						<option></option>

						<c:forEach var="item" items="${storehouses}">
							<option  value="${item.id}">${item.warehouseShort }</option>
						</c:forEach>

					</select>
					<!-- </div> -->
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="10" lay-verify="required" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">规格型号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="50" name="model" id="model" autocomplete="off">
				</div>
			</div>
		
				
			<div class="layui-inline">
				<label class="layui-form-label ">单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="15" name="unit" id="unit" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" maxlength="5" lay-verify="required|customNumber" name="incomingQuantity" id="incomingQuantity" onchange="changeIncomingQuantity(this)" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">本次领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="apply" id="apply" onchange="changeApply(this)" value="0" autocomplete="off">
				</div>
			</div>	
		
			<div class="layui-inline">
				<label class="layui-form-label ">累计领用:</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text"  name="totalApply" value="0" class="form-control" readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">剩余量:</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text"  name="surplus"  value="0" class="form-control"  readonly placeholder="0"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>单价(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customNumber" type="text"  placeholder="--请输入--" onchange="changeUnitPrice(this)" name="unitPrice"  class="form-control"   placeholder="0" maxlength="6"/>
				</div>
			</div>	
	
				
			<div class="layui-inline">
				<label class="layui-form-label ">金额(元):</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="amount"  id="amount" readonly autocomplete="off">
				</div>
			</div>		
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>生产厂家:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="20"  name="manufacturer" id="manufacturer" placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>出厂编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="15" name="serialNumber" id="serialNumber"  placeholder="--请输入--" autocomplete="off">
				</div>
			</div>	
		
				
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>供应商:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  maxlength="15" type="text" name="supplier"  class="form-control" placeholder="--请输入--"/>
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label ">随机资料:</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text" maxlength="20" name="options"  class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="storageDate" id="storageDate" autocomplete="off">
				</div>
			</div>
	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管员:</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text" lay-verify="required" readonly id="custodian" name="custodian" onclick="toAddInspectorManager('1','custodian')"   class="form-control"  placeholder="--请输入--"/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label"><span class="red">*</span>存放地点:</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  lay-verify="required" maxlength="30"  class="layui-input" placeholder=""  name="storagePlace" id="storagePlace"
						autocomplete="off">
				</div>
					
		</div>
		
			<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注:</label>
						<div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea"></textarea>
				    	</div>
			</div>
			
			<div class="layui-row title">
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="toAddImage();">添加附件</button>物资附件(可多个)</h5>
			</div>
			 
			<div class="layui-form-item">
				<input style="display:inline;width:50%" type="file" name="file" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>
			</div>


        <p id="addImage">备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
       </div>
    </form>
   
</div>


<script>
    function callUserSelect_custodian(data){
        $('#custodian').val(data.data.name);
    }
</script>



<script>

    var num ="";
    function toAddInspectorManager(a,eles){
        var inspectorManager = $("#inspectorManager").val();
        num=a;
        $.colorbox({
            title : '选择人员',
            iframe : true,
            opacity	: 0.2,
            href : "${ctx}/StoreFeedBack/select_user_list.shtml?storehouse="+$("#storehouse").val()+"&inspectorManager="+inspectorManager+"&temp_page="+eles,
            innerWidth : '800px',
            innerHeight : '75%',
            close : '×15151',
            fixed : true
        });
    }

    function callUserSelect(data){
        if(num=="1"){
            $("#custodian").val(data.name);
        }else if(num=='2'){
            $("#guardian").val(data.name);
        }else if(num=='3'){
            $("#operator").val(data.name);
        }


    }
     function changeIncomingQuantity(ob){
     	 if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		  $("input[name='incomingQuantity']").val("");
   		  return;
  		 }else{
  		   $("input[name='surplus']").val($(ob).val()) ;

             $("input[name='apply']").val("0");
			 $("input[name='totalApply']").val("0");
             var unitPrice =$("input[name='unitPrice']").val();
             if(unitPrice!=''&&unitPrice!=null){
                 var incomingQuantity =$("input[name='incomingQuantity']").val();
                 incomingQuantity=parseFloat(incomingQuantity);
                 unitPrice=parseFloat(unitPrice);
                 //总价
                 $("input[name='amount']").val((unitPrice*incomingQuantity).toFixed(2));
             }

  		 }
  		// var apply =$("input[name='apply']").val();
  		
	
     }
    
     function changeUnitPrice(ob){
     	 
  		 var incomingQuantity =$("input[name='incomingQuantity']").val();
  		 if(incomingQuantity==''||incomingQuantity==null){
    	 alert("请先输入入库量");
    	 $("input[name='unitPrice']").val("");
    	 return;
    	}
    	if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		  $("input[name='unitPrice']").val("");
   		 return;
  		 }
  		 
    	var unitPrice =$("input[name='unitPrice']").val();
    	incomingQuantity=parseFloat(incomingQuantity);
    	unitPrice=parseFloat(unitPrice);
    	var mon=unitPrice*incomingQuantity;
        mon = (mon).toFixed(2);
    	if (mon.toString().length<=8){
            //总价
            $("input[name='amount']").val(mon);
		}else {
    	    alert("金额超过最大限制数量，请更改单价或入库量");
            $("input[name='unitPrice']").val("");
		}

		
     }
     
     function changeApply(ob){
        var incomingQuantity =$("input[name='incomingQuantity']").val();
         incomingQuantity=parseInt(incomingQuantity);
    	var apply =$("input[name='apply']").val();
    	
    	if(incomingQuantity==''||incomingQuantity==null){
    	 alert("请先输入入库量");
    	 $("input[name='apply']").val("");
    	 return;
    	}
    	
     	 if(isNaN($(ob).val())){
   		 alert("请输入数字");
   		 $("input[name='apply']").val("");
   		 return;
  		 }
  		  incomingQuantity=parseInt(incomingQuantity);
  		  apply=parseInt(apply);
  		 if(apply>incomingQuantity){
  		 alert("领用量不可以大于入库量");
  		  $("input[name='apply']").val("");
  		 return;
  		 }
  		
  		
  		  $("input[name='totalApply']").val(apply);
  		   var surplus =$("input[name='surplus']").val();
  		  surplus=parseInt(surplus); 		  
  		 $("input[name='surplus']").val(incomingQuantity-apply);
    	
	
     }



     layui.use(['form', 'laydate'], function(){
         var form = layui.form;
         form.render();
         var laydate = layui.laydate;

         //执行一个laydate实例
         laydate.render({
             elem: '#purchaseDate' //指定元素
         });

         laydate.render({
             elem: '#storageDate' //指定元素
         });

         form.on('select(warehouseId)', function(data){
             $("#storehouse").val($("#warehouseId option:selected").text());
         });

         //自定义验证规则
         form.verify({
             //非零开头的最多带两位小数的数字
             customNumber: function(value){
                 if(value.length!=0){
                     if(!(/^\d+(\.\d+)?$/.test(value))){
                         return '只能输入大于0的数';
                     }
                 }
             }
         });


         //监听提交
  form.on('submit(save)', function(data){
    layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						location.href="${ctx}/Consumables.shtml";
					})
						
				}
				}); 
    return false;
  });
  
  
});
    
	
	 function toAddImage(){
    var tr =   '<div class="layui-form-item">'
				+'<input style="display:inline;width:50%" type="file" name="file" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>'
			+'</div>'
          
   	$("#addImage").before(tr);
   }
    
    function toDeleteImage(ob){
      $(ob).parent().remove();
    }
	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	

	// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

	var storageDate  = new Date().Format("yyyy-MM-dd");
	$("input[name='storageDate']").val(storageDate);
	
</script>
