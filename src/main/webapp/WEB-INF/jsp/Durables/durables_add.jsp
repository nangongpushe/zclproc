<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
		<li class="active">设备入库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <!--检验结果表-->
      <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="id"  value=""/>
     <input type="hidden" name="groupId"  value=""/>
		  <input type="hidden" name="storehouse"  value="" id="storehouse"/>

		  <div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>物资编码：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="encode" id="encode" maxlength="25" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>类型：</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" lay-verify="required" name="type" lay-filter="aihao"
						id="type">
						<option></option>
						<option value="物资">物资</option>

						<option value="药剂类">药剂类</option>

						
					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>品名：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="25" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label ">规格型号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="model" maxlength="25" id="model" autocomplete="off">
				</div>
			</div>	
			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>制造单位：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="unit" id="unit" maxlength="25" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>目前状态：</label>
				<div class="layui-input-inline">
					
					<select class="layui-input" lay-verify="required" name="status" lay-filter="aihao"
						id="status">
						
						
						 <c:forEach var="item" items="${states}">
						 
						  <option  value="${item.value}">${item.value }</option>
						 
						</c:forEach>	
						
					</select>
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>金额(元)：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="amount" id="amount" maxlength="15"  autocomplete="off" onkeyup="clearNoNum(this) " onBlur="checkAmount(this);">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>生产厂家：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" maxlength="40" name="manufacturer" id="manufacturer" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>出厂编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="serialNumber" maxlength="40" id="serialNumber" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>供应商：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="supplier" maxlength="40" id="supplier" autocomplete="off">
				</div>
			</div>	
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red"></span>随机资料：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  name="options" id="options"  maxlength="40"   autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>入库时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="storageDate" id="storageDate" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>所入库房：</label>
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
				<label class="layui-form-label "><span class="red">*</span>是否建立卡片：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-verify="required" name="needCard" lay-filter="aihao"
						id="needCard">
					
						<option value="是">是</option>
						<option value="否">否</option>
					
						
					</select>
					
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>采购时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="purchaseDate" id="purchaseDate" autocomplete="off">
				</div>
			</div>

			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>功率：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" name="power"  maxlength="25" id="power" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>产量：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required|customNumber"  maxlength="25" name="yield" id="yield" autocomplete="off" onkeyup="value=value.replace(/[^\d\.]/g,'')" data-rule="integer;length[1~10]" min="0">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>外形尺寸：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="overallDimension"  maxlength="25" id="overallDimension" autocomplete="off">
				</div>
			</div>

			
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>主要功能：</label>
				<div class="layui-input-inline">
					<input class="layui-input"  lay-verify="required" name="majorFunction"  maxlength="25" id="majorFunction" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>保管负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="custodian" id="custodian" onclick="toAddInspectorManager('1','durables_add')"   readOnly autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>维护负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required" name="guardian" id="guardian" onclick="toAddInspectorManager('2','guardian')"   readOnly autocomplete="off">
				</div>
			</div>
		
			<div class="layui-inline">
				<label class="layui-form-label "><span class="red">*</span>操作负责人：</label>
				<div class="layui-input-inline">
					<input class="layui-input" type="text" lay-verify="required" name="operator"  id="operator" onclick="toAddInspectorManager('3','operator')"   readOnly   placeholder=""/>
				</div>
			</div>	
		</div>
		
		<div class="layui-form-item">
			
				<label class="layui-form-label">主要保管要求：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input" placeholder="" maxlength="45" name="storageRequire" id="storageRequire"
						autocomplete="off">
				</div>
				
					
		</div>
		
		<div class="layui-form-item">
					
				<label class="layui-form-label">存放地点：</label>
				<div class="layui-input-inline" style="width:75%">
					<input type="text"  class="layui-input" placeholder=""  maxlength="45" oninput="if(value.length>45)value=value.slice(0,45)"  name="storagePlace" id="storagePlace"
						autocomplete="off">
				</div>
					
		</div>
		
			<div class="layui-form-item">
					
						<label class="layui-form-label"><span class="red"></span>备注：</label>
						 <div class="layui-input-inline" style="width:75%">
				    	  <textarea   placeholder="--限500字--" maxlength="500" name="remark" class="layui-textarea"></textarea>
				    	</div>
			</div>
           <div class="layui-row title">
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="toAddImage();">添加图片</button>    物资照片(可多个)</h5>
			</div>
			 
			<div class="layui-form-item">
				<input style="display:inline;width:50%" type="file" name="file" accept="image/*" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>
			</div>
	   
	   		<div id="addImage" class="layui-row title">
				<h5> <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="addOption();">随机附件</button>    随机附件、备件及工具</h5>
			</div>
			 
			<table class="layui-table" >
                <thead>
                <tr>
                    <th style="width:6%;text-align: center">操作</th>
                    <th style="width:25%;text-align: center"><span class="red"></span>名称</th><th style="width:15%;text-align: center"><span class="red"></span>规格型号</th><th style="width:10%;text-align: center"><span class="red"></span>数量 </th><th style="text-align: center">存放地点</th>
                </tr>
                </thead>
                <!-- 表格内容start -->
                <tbody id="addOption" class="text-center">
                
                </tbody>
                <!-- 表格内容 end -->
            </table>
            
          
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
		  </div>
    </form>
    <div class="jumpPage" id="displayPage"></div>
</div>


<script>
    function callUserSelect_da(data){
        // console.log(data)
        $('#custodian').val(data.data.name);
    }
    function callUserSelect_operator(data){
        $('#operator').val(data.data.name);
	}
    function callUserSelect_guardian(data){
        $('#guardian').val(data.data.name);
    }
</script>
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
    function checkAmount(obj) {
        if (obj.value.indexOf(".")< 0&& obj.value !=""){
            alert("输入数值要有两位小数");
            obj.value="";
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
        }});


    //监听提交
  form.on('submit(save)', function(data){

      var beginDate=$("#purchaseDate").val();
      var endDate=$("#storageDate").val();
      var d1 = new Date(beginDate.replace(/\-/g, "\/"));
      var d2 = new Date(endDate.replace(/\-/g, "\/"));

      if(beginDate!=""&&endDate!=""&&d1>d2)
      {
          alert("入库时间不能小于采购时间！");
          return;
      }
	 layer.load();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				layer.closeAll('loading');
                    if (data.success){
                        if(data.data!=null){
                            alert(data.data);
                        }else{
                            layer.msg("保存成功",{icon:1}, function(){
                                location.href="${ctx}/Durables.shtml?";
                            })

                        }
                    }else {
                        // alert(data.msg);
                        layerMsgError("保存失败");
                    }

					
				}
				}); 
    return false;
  });
  
  
});

	
 
   function addOption(){
    var tr =   '<tr>'
		+'<td style="width:6%;text-align: center;"><input type="hidden" name="purchaseId" style="width:0px;"/><a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDelete(this);">删除</a>	</td>'
		+'<td style="width:25%" >'
		+'<input type="hidden" style="width:0%"  name="durablesId" value="${durablesOption.durablesId}"  class="layui-input" placeholder=""/>'
		+'<input  style="display:inline;width:100%"   class="form-control" type="text" name="optionName" maxlength="25"  placeholder=""/>'
		+' </td>'
		+'<td style="width:15%" ><input type="text" name="optionModel" class="form-control" maxlength="15"  placeholder=""/></td>'
        +'<td style="width:10%"><input type="text" maxlength="7"  onkeyup="clearNoNum(this) " onBlur="checkAmounts(this);" '
		+ 'class="form-control" name="optionNum" id="optionNum"  placeholder=""/></td>'
        +'<td ><input type="text" name="optionPlace"  maxlength="40"  class="form-control"  placeholder=""/></td>'
        +'</tr>';
          
   	$("#addOption").before(tr);
   }
    
    function toDelete(ob){
      $(ob).parent().parent().remove();
    }
    
  	 function toAddImage(){
    var tr =   '<div class="layui-form-item">'
				+'<input style="display:inline;width:50%" type="file" name="file" accept="image/*" class="form-control"/> <a href="javascript:void(0);" class="layui-btn layui-btn layui-btn-mini" onclick="toDeleteImage(this);">删除</a>'
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
