<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>报表台账</li>
		<li>报表管理</li>
		<li class="active">年报填报</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

		<!-- <div id="userInfo" class="infoArea">
			<span class="title">条件</span>
				
				<div>
					<span><b class="requiredData">*</b>方案类别：</span>
					<select class="inputArea" id="scheme-type" name="schemeType" style="width:15%">
						<option>年报</option>
						<option>出库</option>
						<option>年度轮换方案</option>
					</select>
				</div>
		</div> -->
		
		<div id="dataArea" class="infoArea">
			<span class="title">查询条件</span>
			
	     <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">年份：</label>
            <div class="layui-input-inline">

              <input type="text" name="reportYear" id="search_year" autocomplete="off" class="layui-input">
            </div>
			  <%--<div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->--%>
				  <%--<input type="text" class="layui-input" id="test1">--%>
			  <%--</div>--%>
          </div>
          
          <div class="layui-inline">
			 <label class="layui-form-label">名称：</label>
			    <div class="layui-input-block">
		          <select id="reportName" name="reportName" class="layui-select">
		            	<option>规模库存</option>
						<option>人员基本情况</option>
						<option>单位基本情况</option>
						<option>粮油科技基本情况</option>
						<option>仓储设施基本情况</option>
						<option>粮食流通基础设施建设投资情况</option>
		          </select>
	        	</div>
          </div>
           <div class="layui-inline"><button class="layui-btn layui-btn-primary layui-btn-small" style="text-align:center" id="search_report">查询</button></div>
          	 <div class="layui-inline"> <div class="layui-btn layui-btn-small" data-toggle="modal" data-target="#myModal" data-whatever="">新增报表 </div>  </div>
      </div>
		</div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			
	</fieldset>
		<div id="listArea">
            <div id="resText" style="width:100%; height:405px; overflow:scroll;">${data }</div>
			<!-- <table class="layui-hide" id="LAY_table_GMKC"  lay-filter="demoEvent"></table> -->
		</div>
		
	</div>
	<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    
    <form id="myForm" class="layui-form" action="${ctx }/yearReport/saveReport.shtml" method="post">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body">
   	  	<div class="layui-form-item">
			 <label class="layui-form-label"><span class="red">*</span>名称：</label>
			    <div class="layui-input-block">
		          <select id="reportNameAdd" name="reportName" lay-filter="reportNameAdd">
		            	<option>规模库存</option>
						<option>人员基本情况</option>
						<option>单位基本情况</option>
						<option>粮油科技基本情况</option>
						<option>仓储设施基本情况</option>
						<option>粮食流通基础设施建设投资情况</option>
		          </select>
	        	</div>
          </div>
	  	 <div class="layui-form-item">
	  		<label class="layui-form-label">模板下载:</label>
	  		<div class="layui-input-inline">
              	<div class="layui-btn layui-btn-small" onclick="downTemplate()">下载模板</div>
            </div>
	  	</div>
	  	<div class="layui-form-item">
	  		<label class="layui-form-label"><span class="red">*</span>年份：</label>
            <div class="layui-input-block">
              <input type="text" name="reportYear" lay-verify="required" id="form_year" autocomplete="off" class="layui-input">
            </div>
	  	</div>
	  	 <div class="layui-form-item">
	  		<label class="layui-form-label"><span class="red">*</span>选择文件:</label>
	  		<div class="layui-input-block">
              	<div class="layui-btn layui-btn-small" id="importYear">导入文件</div><label id="fileNameText"></label>
            </div>
		   	<input name="fileId" id="fileId" hidden>
		   	<input name="fileName" id="fileName" hidden lay-verify="fileName">
		  </div>
      </div>
      <div class="modal-footer">
        <button class="layui-btn layui-btn-small" lay-filter="submit" lay-submit="" id="add">确认</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
      </div>
     </form>
      
    </div>
  </div>
</div>
</html>

<script>
$('#myModal').on('show.bs.modal', function (event) {  
      var label = $(event.relatedTarget) // 触发事件的标签 
      var recipient = label.data('whatever') // 解析出whatever内容  
      var modal = $(this)  //获得模态框本身
      modal.find('.modal-title').text('新增报表'/*  + recipient */)  //			
      /* modal.find('.modal-body input').val(recipient)   */
  })  
$("#search_report").on("click", function() {
      $.ajax({
             type: "POST",
             url: "${ctx}/yearReport/getReport.shtml",
             data: {reportYear:$("#search_year").val(), reportName:$("#reportName").val()},
             dataType: "json",
             success: function(res){ 		
             		if(res.code==0){
            			 $('#resText').empty();   //清空resText里面的所有内容
            			 $('#resText').html(res.data);
             		}else{
             			$('#resText').html("");
             			alert(res.msg);
             		}
                 }
         });
 });

layui.use(['form','laydate', 'table'],function(){
var laydate = layui.laydate;
var upload = layui.upload;

var form = layui.form;
form.render();
//render初始化参数
form.verify({
	fileName: function(value){
	    if(!value){
	        return '请导入文件!';
		}
	  var reportName = $("#reportNameAdd option:selected").text();
      if(reportName != value){
        return '上传文件为'+value+','+'与选中的名称不符';
      }
    }
})	
	
 //执行一个laydate实例
  laydate.render({
    elem: '#search_year' //指定元素
    ,type: 'year'

    ,value: new Date().getFullYear()
  });

//执行一个laydate实例
    laydate.render({
        elem: '#test1' //指定元素
    });
   function checkSame(){
	   var fileName = $("#fileName").val();
	   var year = $("#form_year").val();
	   if(fileName != '' && fileName != $("#reportNameAdd option:selected").text()){
		   $("#add").hide();
		   return false;
	   }
	   $("#add").show();
   }
   
   //执行一个laydate实例
  laydate.render({
    elem: '#form_year', //指定元素
    type: 'year',

    done: function(value, date, endDate){
    	checkSame();
    }
  });
   
  	form.on('select(reportNameAdd)', function(data){
	  checkSame();
	});
   
    //执行实例
  var uploadInst = upload.render({
    elem: '#importYear', //绑定元素
    url: '${ctx }/yearReport/uploadFile.shtml', //上传接口
    accept: 'file', //普通文件
    done: function(res, index, upload){
      if(res.code==0){
      	var fileName = res.data.fileName.substring(0,res.data.fileName.length-5);
      	$("#fileId").val(res.data.fileId);
      	$("#fileName").val(fileName);
      	$("#fileNameText").html("&nbsp;&nbsp;&nbsp;"+res.data.fileName);
      	checkSame();
      }
      if(res.code==1) {
      	layer.alert(res.msg);
      }    
    }
    ,error: function(){
      //请求异常回调
    }
  });
  
    //监听提交
  form.on('submit(myForm)', function(data){
    layer.alert(JSON.stringify(data.field), {
      title: '最终的提交信息'
    })
    return false;
  });
	
});

function downTemplate(){
	var form = layui.form
	form.render('select'); //刷新select选择框渲染
	var reportNameAdd = $("#reportNameAdd").val();
	window.location.href = "${ctx}/yearReport/download.shtml?reportName="+reportNameAdd;
}



</script>

<%@ include file="../../common/AdminFooter.jsp" %>