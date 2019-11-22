<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/combo.select.css">
<style>
<!--

/* a:hover {text-decoration:underline;}  */
-->
</style>
<div class="container-box">
 <ol class="breadcrumb">
		<li>仓储管理</li>
		<li class="active"><c:if test="${auvp=='a'}">
		新增
		</c:if>
		<c:if test="${auvp=='u'}">
		编辑
		</c:if>
		<c:if test="${auvp=='v'}">
		查看
		</c:if>
		全国查库</li>
	</ol>
    <!--检验结果表-->
     <form class="form_input"  action="save.shtml" method="post" enctype="multipart/form-data">
     <input type="hidden" name="auvp" value="${auvp}" class="form-control ">
     <input type="hidden" name="id"  value="${entity.id }" class="form-control "/>
        <table class="table table-bordered">
            <!-- 表格内容 start -->
            <tbody id="Detail">
             <tr>
                <td class="text-right"><span class="red">*</span><b>年度:</b></td>
                <td><input type="text" name="year" id="year" readonly="readonly" value='${entity.year }' class="form-control "  placeholder=""/></td>
                <td class="text-right"><span class="red">*</span><b>填报单位:</b></td>
                 <td>
                     <input type="text" name="reportUnit" <c:if test="${entity.reportUnit =='' }"> placeholder="很抱歉该账号没有添加权限"  </c:if> readonly="readonly"value='${entity.reportUnit }' class="form-control validate[required]"  placeholder=""/>
                     <input type="hidden" name="warehouseId" value="${entity.warehouseId}">
                 </td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>检查开始日期:</b></td>
                <td><input type="text" name="inspectStart" id="inspectStart"  value='${entity.inspectStart }' class="form-control "  placeholder=""/></td>
                <td class="text-right"><span class="red">*</span><b>检查结束日期:</b></td>
                <td><input type="text" name="inspectEnd" id="inspectEnd" value='${entity.inspectEnd }' class="form-control "  placeholder=""/></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>检查内容:</b></td>
                <td><textarea rows="4" name="inspectContent" class="form-control  validate[required]" placeholder="--请输入--" maxlength="200">${entity.inspectContent }</textarea>
                <%-- <input type="text" name="inspectContent" value='${entity.inspectContent }' class="form-control validate[required]"  placeholder=""/> --%></td>
                <td class="text-right"><span class="red">*</span><b>检查结果:</b></td>
                <td><textarea rows="4" name="inspectResult" class="form-control validate[required]" placeholder="--请输入--" maxlength="200">${entity.inspectResult }</textarea>
                <%-- <input type="text" name="inspectResult" value='${entity.inspectResult }' class="form-control validate[required]"  placeholder=""/> --%></td>
            </tr>
            <tr>
                <td class="text-right"><span class="red">*</span><b>检查经费(万元):</b></td>
                <td><input type="text" maxlength="5" onkeyup="clearNoNum(this) " onblur="checkAmounts(this);" id="inspectFunds" name="inspectFunds" value='${entity.inspectFunds }' class="form-control validate[required]"  placeholder=" "/></td>
                <td class="text-right"><span class="red">*</span><b>检查负责人 :</b></td>
                <td >
                <c:if test="${auvp=='v'}">
                    <select  class="form-control validate[required]"  name="inspector" id="inspector"  disabled="disabled">
                        <option value="">--请选择--</option>
                        <c:forEach items="${listSysUser}" var="listSysUser">
                            <option value="${listSysUser.id}">${listSysUser.name}【${listSysUser.position}】</option>
                        </c:forEach>
                    </select>
                </c:if>
                <c:if test="${auvp!='v'}">
                <select class="form-control validate[required]"  name="inspector" id="inspector"  >
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${listSysUser}" var="listSysUser">  
		        			<option value="${listSysUser.id}">${listSysUser.name}【${listSysUser.position}】</option>
		   				 </c:forEach>
   					</select>
   				</c:if>
                </td>
            </tr>
            
            <tr>
                <td class="text-right"><span class="red">*</span><b>填报人:</b></td>
                <td><input type="text" name="creator" readonly="readonly" value='${entity.creator }' class="form-control"  placeholder=""/></td>
                <td class="text-right"><span class="red">*</span><b>填报时间:</b></td>
                <td><input type="text" name="createDate"  readonly="readonly" value='${entity.createDate }' class="form-control"  placeholder=""/></td>
            <tr>
            <td  class="text-center" colspan="4"><div class="layui-btn layui-btn-primary layui-btn-small" id="importFile">添加附件</div><a id="afileName" style="color:red;margin:auto 20px;"   >只允许上传xlx、xlsx和jpg文件</a></td>
            </tr>
            <c:forEach items="${listsysFile}" var="listsysFile"  varStatus="status">  
            <tr>
            	<td class="text-right" colspan="1">
                    <c:if test="${auvp!='v'}"><a href="javascript:void(0);" onclick="toDelete(this);" class="layui-btn layui-btn-small layui-bg-red" data-id='${listsysFile.id }' data-name='${listsysFile.fileName }' id="delete">删除</a></c:if>
            	    <c:if test="${auvp=='v'}">附件</c:if>
                </td>
                <td colspan="3">
                <a onclick="download('${ctx}/sysFile/download.shtml?fileId=${listsysFile.id }');"  href="${ctx}/sysFile/download.shtml?fileId=${listsysFile.id }"  >${listsysFile.fileName }</a>
                    <c:forEach items="${suffixMap}" var="m">
                        <c:if test="${m.key == listsysFile.id}">
                            <c:choose>
                                <c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
                                    <a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${listsysFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
                                        预览
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a style="color: yellowgreen" href="javascript:openAnnex('${listsysFile.id}')" id="openFile">
                                        预览
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                    </c:forEach>
                </td>
            </tr>
            </c:forEach> 
            <!-- 表格内容 end -->
            </tbody>
        </table>
        <p>备注：带有<span class="red">*</span>为必填项！</p>
        <p class="btn-box text-center">
             <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">取消</button>
            <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
        </p>
  

    </form>
    <div class="jumpPage" id="displayPage"></div>
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
layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({ 
	  elem: '#inspectStart'
	  ,format: 'yyyy-MM-dd' //可任意组合
	});
}); 
 layui.use('laydate', function(){
  var laydate = layui.laydate;
  laydate.render({ 
	  elem: '#inspectEnd'
	  ,format: 'yyyy-MM-dd' //可任意组合
	  ,done:function(value, date){
		  if($("#inspectStart").val()!=''){
			  var start = $("#inspectStart").val().replace(/[^0-9]/ig,"");
			  var end = value.replace(/[^0-9]/ig,"");
			  if(Number(start)>Number(end)){
				  layer.msg("结束日期不可大于开始日期");
				  $("#inspectEnd").val("");
			  }
		  }
	  }
	});
}); 

$(function(){
	var auvp = '${auvp}';
	
	if(auvp=='v'){$("#cancel").text("返回");}else{$("#cancel").text("取消");}
	if(auvp=='v'){
		$("form").find("input,textarea,select").prop("readonly", true);
		$('#btnSave').hide();
		$('div#importFile').hide();
	}else if(auvp=='u'){
		$('#id').prop("readonly", true);
	}

    if(auvp=='v'){
        var inspector ='${entity.inspector }';
        document.getElementById("inspector").value =inspector;
    }else{
        $('#inspector').comboSelect();
        var inspector ='${entity.inspector }';
        document.getElementById("inspector").value =inspector;
        $('#inspector').comboSelect().val(inspector);
    }


});
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#purchaseDate' //指定元素
	  });
	});
	//自定义错误显示位置 
 $('.form_input').validationEngine({ 
  promptPosition: 'bottomRight', 
  addPromptClass: 'formError-white'
 });
 
    
    
   $("#btnSave").click(function(){
   var inspectStart= document.getElementById("inspectStart").value;
   var inspectEnd= document.getElementById("inspectEnd").value;

       var beginDate=document.getElementById("inspectStart").value;;
       var endDate=document.getElementById("inspectEnd").value;;
       var d1 = new Date(beginDate.replace(/\-/g, "\/"));
       var d2 = new Date(endDate.replace(/\-/g, "\/"));

       if(beginDate!=""&&endDate!=""&&d1>d2)
       {
           alert("开始日期不能大于结束时间！");
           return;
       }
   var str="";
   if(inspectStart==""){
   if(str==""){
   			str+="检查开始日期不能为空";
   			}else{
   			str+=",检查开始日期不能为空";
   			}
   }
   if(inspectEnd==""){
   if(str==""){
   			str+="检查结束日期不能为空";
   			}else{
   			str+=",检查结束日期不能为空";
   			}
   }

   if(parseFloat($("#inspectFunds").val())<0){
       alert("检查经费不可以小于0");
       return;
   }
   if(str==""){
   		if($(".form_input").validationEngine('validate')==true){
			$(".form_input").ajaxSubmit({
			type:"post",
			success:function(data){
				if(data.success){
				alert("保存成功"); 
				location.href="${ctx}/StorageInspect.shtml";
				}else{
				alert("保存失败"); 
				}
			}
			});
		}
   }else{
   		layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: str
		}); 
   }
		
	});
	
	 $("#cancel").click(function(){
	 var auvp = '${auvp}';
	 if(auvp=='v'){
	 history.go(-1);
	 }else{
		layer.confirm('您是否要放弃', function(index) {
				history.go(-1);
			});
	 
	 }
		
	});
	

var upload = layui.upload;
var i=0;
	   //执行实例
  var uploadInst = upload.render({
    elem: '#importFile' //绑定元素
    ,url: '${ctx }/sysFile/uploadFileNew.shtml?type=xls,xlsx,jpg&groupId=${entity.id }' //上传接口
    ,accept: 'file' //普通文件
   /*  ,exts: 'xls|xlsx|jpg' //只允许上传xlx和xlsx文件 */
    ,done: function(res){
    
       if(res.code==0){
      	i++;   
      	addList(i,res.data.fileId,res.data.fileName);
      	/* $("#fileId_"+i).val(res.data.fileId);
      	$("#fileName_"+i).val(res.data.fileName);
      	$("#afileName").text(res.data.fileName); */
		/* document.getElementById("afileName").setAttribute("href","${ctx}/sysFile/download.shtml?fileId="+res.data.fileId);  */
      }
      var msg=res.msg;
      layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: msg
		});       
    }
    ,error: function(){
      //请求异常回调
    }
  });	
  function addList(i,fileId,fileName){
   var tr =    '<tr>'
    			+'<td class="text-right" colspan="1">'
    			+'<a href="javascript:void(0);" onclick="toDelete(this);" class="layui-btn layui-btn-small layui-bg-red" data-id="'+fileId+'" data-name="'+fileName+'" id="delete">删除</a></td>'
                +'<td colspan="3"><a   href="${ctx}/sysFile/download.shtml?fileId='+fileId+'"  >'+fileName+'</a>'
               /*  +'<input name="groupId"   type="hidden" value="'+fileId+'" class="form-control ">'
		        +'<input name="fileName"   type="hidden" class="form-control " value="'+fileName+'">'  */
		        +'</td>'
                +'</tr>'
   	$("#Detail").append(tr);
  }
  
function toDelete(ob){
layer.confirm('您确认要删除附件('+$(ob).attr("data-name")+')吗？', function(index) {
$.post("${ctx }/sysFile/delete.shtml",{
					id : $(ob).attr("data-id")
				}, function(result) {  
	if (result.success) {
		layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: '附件:'+$(ob).attr("data-name")+'删除成功'
		}); 
		$(ob).parent().parent().remove();
	}else{
		layer.closeAll(); //疯狂模式，关闭所有层
		layer.open({
		title: '提示信息'
		,content: '删除失败'
		}); 
	}
});

    
});

 }
  
</script>

<script src="${ctx}/js/select/jquery.combo.select.js"></script>


