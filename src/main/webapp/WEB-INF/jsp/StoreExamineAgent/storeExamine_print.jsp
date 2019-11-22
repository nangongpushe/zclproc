<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>
<script type="text/javascript" src="${ctx }/plugins/jQueryPrint/js/jQuery.print.js"></script>
<style type="text/css">
	@media print{
		input,.noprint{
			display:none
		}
		.printonly{
			display:block;
			width:100%
		}
	}
	@page {
		size: auto;  /* auto is the initial value */
		margin: 0mm; /* this affects the margin in the printer settings */
	}
.form_input td:nth-child(odd) {
    width: 18%; 
     padding-right: 0px !important; 
}
.td-size {
   
    font-size: 14;
    text-align: left;
}


p {
    font-size: 15px;
    line-height: 25px;
     padding-top: 0px; 
}
body {height: auto;}
</style>


<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">考核评分</li>
	</ol>
</div>
<div >
	 <input type="hidden" name="id"  value="${storeExamine.id }"/>
	 <input type="hidden" name="points" value="${storeExamine.points }" />
	<input type="hidden" name="examineTemplet" value="${storeExamine.examineTemplet }"/>	
	<input type="hidden" class="layui-input" id="examineSerial" value="${storeExamine.examineSerial }" >
	<div id="templatePrint" class="container-box clearfix" style="padding: 10px">
			<h3 style="text-align:center"> 代储库点仓储管理工作考核评分表</h3>
			<br>
			<c:if test="${ empty storeExamine.enterpriseName }">
			<label ><span class="red"></span>库点名称:${storeExamine.storehouse }</label>
		  	</c:if>
			<c:if test="${not empty storeExamine.enterpriseName }">
			   <label ><span class="red"></span>库点名称:${storeExamine.enterpriseName }</label>			
			</c:if>					
			<div id="template" class="layui-row title">
				
			</div>
			
			
	</div>		
			<p  class="btn-box text-center">
			      <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
	              <button type="button"  onclick="jQuery('#templatePrint').print()" class="layui-btn layui-btn-primary layui-btn-small ">打印</button>
	           
	        </p>
	        
</div>

<script>
  var  alltotal=0;

layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#reportDate' //指定元素
	  });
 
  
  //监听提交
  form.on('submit(save)', function(data){
      
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
					
					location.href="${ctx}/StoreExamineAgent.shtml?";
				}
				}); 
    return false;
  });
  
  
});
 $('.dropdown-mul-2').dropdown({
      searchable: false,
      choice: function() {
      
      }
    });

    
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#examineTime' //指定元素
	  });
	});

	 $(".cancel").click(function(){
		location.href="${ctx}/StoreExamineAgent.shtml?";
	});
	
 function toAddTemplet(){
/* 	$.colorbox({
		title : '选择考核模板',
		iframe : true,
		opacity	: 0.2,
		href : "${ctx}/StoreExamine/select_templet_list.shtml?",
		innerWidth : '800px',
		innerHeight : '75%',
		close : '×15151',
		fixed : true
	}); */
}	


 function callTemplateSelect(data){
  
  
 	var templateId =  $("input[name='examineTemplet']").val();
 	var examineSerial =$("#examineSerial").val();
	 $.ajax({
	  type: 'POST',
	 url:"${ctx}/StoreExamine/getStoreTemplate.shtml?templateId="+templateId+"&examineId="+examineSerial+"&type=0",
	  dataType: "json",
	  success:function(data){
	    $("#templateTab").remove();
	 	var table='<table class="td-size" id="templateTab" cellpadding="1" cellspacing="1" border="1">'
				     +'<thead>'
				     +'<tr>'
				         +'<th   colspan="2" style="width: 20%;"><p  style="text-align: center">'+data.data.itemName+'</p></th>'
				         +'<th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>'
				         +'<th  ><p  style="text-align: center">分数</p></th>'
				     +'</tr>'  
				      +'</thead>';
				      
		   for(var i=0;i<data.data.children.length;i++){
		      var item = data.data.children[i];
		     table+='<tbody>'		 
				 	  +'<tr>'
				 	  +'<td style="width: 20%;" rowspan='+item.rowspan+'>'+'&nbsp;&nbsp;'+item.itemName+'</td>';
				 	   for(var j=0;j<item.children.length;j++){
				 	   	 var item1 = item.children[j];
				 	   	    table+='<td rowspan='+item1.children.length+'>'+'&nbsp;&nbsp;'+item1.itemName+'</td>';
				 	   	      for(var k=0;k<item1.children.length;k++){
				 	   	        var num = parseInt(k)+1;
				 	   	       var item2 = item1.children[k];
				 	   	       
				 	   	        
				 	   	         if(k==0){
				 	   	         	 table+='<td><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"  value='+item2.itemName+' name="itemName" /><input type="hidden"  value='+item2.standard+' name="standard" />'+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'('+item2.standard+'分)'+'</td>'
		     			  			  +'<td><span style="display: none">'+item2.standard+'</span> <input style="text-align: center" onchange="changeStandard(this)" name="point" value='+item2.point+' type="text"/></td> </tr>	';
				 	   	         }else{
				 	   	         
								table+='<tr><td ><input type="hidden"  value='+item2.parentId+' name="parentId" /><input type="hidden"   value='+item2.itemName+' name="itemName" /><input type="hidden" value='+item2.standard+' name="standard" /> '+'&nbsp;&nbsp;'+num+'.&nbsp;&nbsp;'+item2.itemName+'('+item2.standard+'分)'+'</td>'
		     			  			  +'<td ><span style="display: none">'+item2.standard+'</span><input  style="text-align: center" onchange="changeStandard(this)" name="point" value='+item2.point+' type="text"/></td> </tr>'	;
		   					
				 	   	         }
				 	   	      }
				 	   }
				 	   table+='</tbody>';
				 	   
				 	  
		  }
		  
		  	var points =  $("input[name='points']").val();
		   table+='<tbody>'		 
		   			 
				 	  +'<tr>'
				 	  +'<td  style="text-align: center;width:50%;"; colspan="2">'+'得分合计'+'</td>'
				 	  +'<td  style="text-align: center"; colspan="2"><span id="alltotal">'+points+'</span></td>'
				 	  +'</tr>'
				 	  +'</tbody></table>';
			  table+='<div style="height:150px;">'
			  			+'<div style="padding-left:18px; font-size:18px;line-height:150px;display:inline-block;width:49%;height:100%">代储库点负责人(签字)：</div>'
			   			+'<div style="padding-left:18px; font-size:18px;line-height:150px;display:inline-block;width:48%;height:100%">考评组成员(签字)：</div>'
						+'</div>';
		   			 
				 	 
	 	$("#template").after(table);
	 		$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	
	 
	 	
       } 
	  });
 	
 	}
 	
 	
 	callTemplateSelect();
		$("input").attr("readOnly","true");
 	$("textarea").attr("readOnly","true");	
	
	
</script>



