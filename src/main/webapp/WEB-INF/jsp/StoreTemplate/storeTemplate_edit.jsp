<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
  
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
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">考评模板表</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
    <form class="layui-form form_input"  action="Create.shtml" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id"  value="${storeTemplate.id }"/>
      <input type="hidden" name="templetNo" id="templetNo" value="${storeTemplate.templetNo }"/>
   
       <div class="layui-form" id="search" >
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>模板名称：</label>
				<div class="layui-input-inline">
					<input maxlength="20" class="layui-input" lay-verify="required" value="${storeTemplate.templetName }"  autocomplete="off" id="templetName" name="templetName">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right"><span class="red">*</span>模板类型：</label>
						<div class="layui-input-inline">
							<select class="layui-input"  lay-filter="SelectType" lay-verify="required" name="type" 
								id="type">
								
								<c:if test="${storeTemplate.type == '1'}">
								 <option selected="selected" value="1">四化粮库</option>
								 </c:if>
								  <c:if test="${storeTemplate.type != '1'}">
								 	<option  value="1">四化粮库</option>
								 </c:if>
								  <c:if test="${storeTemplate.type == '0'}">
								 	<option selected="selected" value="0">非四化粮库</option>
								 </c:if>
								  <c:if test="${storeTemplate.type != '0'}">
								 <option  value="0">非四化粮库</option>
								 </c:if>									
							</select>	
						</div>
			</div>
			<div class="layui-form-item">
			
				<label class="layui-form-label" style="text-align:right"><span class="red"></span>备注：</label>
				  <div style="margin-left: 111px"; class="layui-input-block">
		    	  <textarea   placeholder="--限250字--" maxlength="250" name="remark" class="layui-textarea">${storeTemplate.remark }</textarea>
		    	</div>
			</div>
		</div>	
      
      
     	 <hr class="layui-bg-green">

           <p>请选择考评选项</p>
		  <div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
		</div>
        
          <p class="btn-box text-center">
             <a type="button"  class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
             <a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
        </p>
  

    </form>
  
</div>
    



<script>
layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	 form.on("select(SelectType)", function(data){
   TemplateContent();
  });
  
  //监听提交
  form.on('submit(save)', function(data){
    var ids= new Array();
         var names= new Array();
           var scores= new Array();
         var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getCheckedNodes(true);
		if(nodes.length==0){
			alert("请选择考评选项!")
			return;
		}
		var all=0;
		for (var i=0;i<nodes.length;i++){
			var par = $("#"+nodes[i].tId);
				var score = par.find("input").val();
				ids.push(nodes[i].pId);
				names.push(nodes[i].id);
				scores.push(score);
				all=all+parseInt(score);
				
		}
   	  if(all!=100){
   	    alert("总分必须要为100分！");
   	    return;
   	  }
		if($(".form_input").validationEngine('validate')==true){
			$(".form_input").ajaxSubmit({
			type:"post",
			data: {
			"ids": ids.toString(),
			"items": names.toString(),
			"scores": scores.toString(),
			}, 
			success:function(data){
				
			layer.msg("保存成功",{icon:1}, function(){
					location.href="${ctx}/StoreTemplate.shtml";
				})
			}
			});
		}
    return false;
  });
  
  
});
	
	 $(".cancel").click(function(){
		layer.confirm('您是否要放弃编辑', function(index) {
				history.go(-1);
			});
		
	});
	
	

		var IDMark_Switch = "_switch",
		IDMark_Icon = "_ico",
		IDMark_Span = "_span",
		IDMark_Input = "_input",
		IDMark_Check = "_check",
		IDMark_Edit = "_edit",
		IDMark_Remove = "_remove",
		IDMark_Ul = "_ul",
		IDMark_A = "_a";
		
		var setting = {
			check: {
				enable:true ,
				nocheckInherit: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			view: {

				addDiyDom: addDiyDom
			},
			callback: {
				onCheck: onCheck
			}
		};

		



		function onCheck(e, treeId, treeNode) {
			

		}

	/* 	function addDiyDom(treeId, treeNode) {
			if (treeNode.nocheck ==true) return;

			var aObj = $("#" + treeNode.tId + IDMark_A);
			var editStr = "<input id='diyBtn_" +treeNode.id+ "'  class=' validate[custom[number]]' style='width:60px' placeholder='请输入分数' type='text'>";
			aObj.after(editStr);

		} */

	  function addDiyDom(treeId, treeNode) {
	  if (treeNode.nocheck ==true) return;
            var spaceWidth = 5;
            var switchObj = $("#" + treeNode.tId + "_switch"),
            checkObj = $("#" + treeNode.tId + "_check"),
            icoObj = $("#" + treeNode.tId + "_ico");
            switchObj.remove();
            checkObj.remove();
            icoObj.parent().before(switchObj);
            icoObj.parent().before(checkObj);

            var spantxt = $("#" + treeNode.tId + "_span").html();
            if (spantxt.length > 60) {
                spantxt = spantxt.substring(0, 60) + "...";
                $("#" + treeNode.tId + "_span").html(spantxt);
            }
            	var aObj = $("#" + treeNode.tId + IDMark_A);
			var editStr = "<input id='diyBtn_" +treeNode.id+ "'  class=' validate[custom[number]]' style='width:60px' placeholder='请输入分数' type='text'>";
			aObj.after(editStr);
         
  }
	
		$(document).ready(function(){
		var type=$("#type").val();
			var templateId = $("#templetNo").val();
			$.ajax({
	  type: 'POST',
	  url:"${ctx}/StoreTemplate/TemplateContent.shtml?templateId="+templateId+'&type='+type,
	  dataType: "json",
	  success:function(data){
	 /*  	var zNodes =data.data; */
	  	var zNodes =data.data[0];
       	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
       		for (var i=0;i<data.data[1].length;i++){
       			var ob = data.data[1][i];
       			var par = $("#diyBtn_"+ob.itemId);
       			par.val(ob.standard);
			
				var id =	par.parent().attr("id");
				 var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var node1 = treeObj.getNodeByTId(id);
				treeObj.checkNode(node1, true, false, false);
			
				
       		}
     
       } 
	  });
		});


		
		

	function TemplateContent(){
	
			var type=$("#type").val();
				$.ajax({
			  type: 'POST',
			  url:"${ctx}/StoreTemplate/TemplateContent.shtml?type="+type,
			  dataType: "json",
			  success:function(data){
			 /*  	var zNodes =data.data; */
			  	var zNodes =data.data[0];
		       	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		       
		       } 
			  });
	}
	
		/* 
	  function addDiyDom(treeId, treeNode) {
	  if (treeNode.nocheck ==true) return;
            var spaceWidth = 5;
            var switchObj = $("#" + treeNode.tId + "_switch"),
            checkObj = $("#" + treeNode.tId + "_check"),
            icoObj = $("#" + treeNode.tId + "_ico");
            switchObj.remove();
            checkObj.remove();
            icoObj.parent().before(switchObj);
            icoObj.parent().before(checkObj);

            var spantxt = $("#" + treeNode.tId + "_span").html();
            if (spantxt.length > 60) {
                spantxt = spantxt.substring(0, 60) + "...";
                $("#" + treeNode.tId + "_span").html(spantxt);
            }
            var editStr = "<input id='diyBtn_" +treeNode.id+ "'  class=' validate[custom[number]]' style='width:70px' placeholder='请输入分数' type='text'>";
			$("#" + treeNode.tId + "_span").after(editStr);
         
  }
	 */
</script>
