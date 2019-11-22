<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>

<style>
	#mytable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="economicType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="registType"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="seniority"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="personIncharge"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="provinceCityArea"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="telephone"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="isStop"]{
		text-align: left;
	}
</style>
<style type="text/css">


.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
    width: 30% ;
    max-width:130px;
}

.layui-form-item .layui-input-inline{
  width: 65% ;
}
.layui-form-item {
    margin-bottom: 1px;
    }

 #mytable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
	 text-align: left;
 }
#mytable + .layui-form .layui-table-body td[data-field="economicType"]{
	text-align: left;
}
#mytable + .layui-form .layui-table-body td[data-field="registType"]{
	text-align: left;
}
#mytable + .layui-form .layui-table-body td[data-field="seniority"]{
	text-align: left;
}
#mytable + .layui-form .layui-table-body td[data-field="personIncharge"]{
	text-align: left;
}
#mytable + .layui-form .layui-table-body td[data-field="provinceCityArea"]{
	text-align: left;
}
#mytable + .layui-form .layui-table-body td[data-field="telephone"]{
	text-align: right;
}
#mytable + .layui-form .layui-table-body td[data-field="isStop"]{
	text-align: left;
}


</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>企业信息</li>
		<li class="active">企业基本信息</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
		
   

		<shiro:hasPermission name="StoreEnterprise:search">  					
		<div class="layui-form" id="search" >
	
		 <div class="layui-form-item">
		 
			<div class="layui-inline">
				<label class="layui-form-label ">企业名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="enterpriseName" id="enterpriseName" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">登记注册类型:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="registType" lay-filter="aihao"
						id="registType">
						<option></option>
						<option value="有限责任公司">有限责任公司</option>
						<option value="股份有限公司">股份有限公司</option>
						<option value="非公司企业法人">非公司企业法人</option>
						<option value="个人独资企业">个人独资企业</option>
						<option value="合伙企业">合伙企业</option>
						<option value="中外合作企业">中外合作企业</option>
						<option value="合营企业">合营企业</option>
						<option value="外商独资企业">外商独资企业</option>
					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">企业经济类型:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="economicType" lay-filter="aihao"
						id="economicType">
						<option></option>
						<option value="国有经济">国有经济</option>
						<option value="集体经济">集体经济</option>
						<option value="私营经济">私营经济</option>
						<option value="个体经济">个体经济</option>
						<option value="联营经济">联营经济</option>
						<option value="股份制">股份制</option>
						<option value="外商投资">外商投资</option>
						<option value="港澳台投资">港澳台投资</option>
						<option value="其他经济类">其他经济类</option>
												
					</select>
					<!-- </div> -->
				</div>
			</div>

		
				<div class="layui-inline" >
				
	               <label class="layui-form-label">企业行政区划：</label>
	                <div class="btn-select-parent">
	                    <div id="distpicker" class="form-inline">
	                        <div>
	                            <label class="sr-only" for="province">Province</label>
	                            <select class="form-control  pull-left" style="width: 22%" name="province" id="province"></select>
	                        </div>
	                        <div>
	                            <label class="sr-only" for="city">City</label>
	                            <select class="form-control  pull-left" style="width: 22%" name="city"  id="city"></select>
	                        </div>
	                        <div>
	                            <label class="sr-only" for="district">District</label>
	                            <select class="form-control  pull-left" style="width: 22%" name="area" id="district"></select>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        
	           <div  class="layui-inline">
					<label class="layui-form-label">是否具备中央储备粮代储资格:</label>
					<div class="layui-input-inline">
						<!-- <div class="layui-inline" style="width: 170px"> -->
						<select class="layui-input" name="seniority" lay-filter="aihao"
							id="seniority">
							<option></option>
							<option value="是">是</option>
							<option value="否">否</option>
						
						</select>
						<!-- </div> -->
					</div>
				</div>

			 <div class="layui-inline">
				 <label class="layui-form-label"><span class="red"></span>是否停用:</label>
				 <div class="layui-input-inline">
					 <!-- <div class="layui-inline" style="width: 170px"> -->
					 <select class="layui-input" lay-verify="required"  name="isStop" lay-filter="aihao"
							 id="isStop">

						 <option value=""></option>
						 <option value="N">否</option>
						 <option value="Y">是</option>


					 </select>
					 <!-- </div> -->
				 </div>
			 </div>


	            	<div  class="layui-inline">
					<button class="layui-btn layui-btn-primary layui-btn-small" id="searchBtn"  >查询</button>
					</div>
			 </div>
        </div>	
			</shiro:hasPermission>
		
  	
  
        <p class="btn-box" style="padding-top:0px;margin-left:10px">
            <shiro:hasPermission name="StoreEnterprise:add">  
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small"  onclick="window.location.href='${ctx }/StoreEnterprise/add.shtml?'">新增</button>
            </shiro:hasPermission> 
               <shiro:hasPermission name="StoreEnterprise:export">  
              <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="exportxls();">导出</button>
            </shiro:hasPermission>
             <!--   <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="exportxls();" >打印</button>        -->
        </p>
   
         
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>

		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			
			 <shiro:hasPermission name="StoreEnterprise:edit">  
  			<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>  
 			<shiro:lacksPermission name="StoreEnterprise:edit">  
  			<a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">编辑</a>
			</shiro:lacksPermission>  
			<shiro:hasPermission name="StoreEnterprise:print">  
		   <a class="layui-btn layui-btn layui-btn-mini" lay-event="print">打印</a>
		   </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreEnterprise:print">  
		   <a class="layui-btn layui-btn-disabled layui-btn layui-btn-mini" lay-event="">打印</a>
		   </shiro:lacksPermission> 

			<shiro:hasPermission name="StoreEnterprise:delete">  
  			<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
			 </shiro:hasPermission> 
			<shiro:lacksPermission name="StoreEnterprise:delete">  
  			<a class="layui-btn layui-btn-disabled layui-btn-danger layui-btn layui-btn-mini" lay-event="">删除</a>
			 </shiro:lacksPermission> 
			
		</script>
	<%--<script type="text/html" id="isStop">--%>
		<%--if({{d.isStop}}=='Y'){是}else if({{d.isStop}}=='N'){否}--%>
	<%--</script>--%>



</div>

<script src="${ctx }/js/cities.data.js"></script>

<script>

	  $('#distpicker').distpicker({
	    autoSelect: false,
        placeholder: true,
            province: '请选择',
       		 city: '请选择',
        	district:'请选择',
        });
       /*     $('#distpicker').distpicker.setDefaults = Distpicker.setDefaults; */
	
    var form = layui.form;
	form.render();
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreEnterprise/thisList.shtml',
		method:'POST',
		cols : [[
			
 			{align:'center',field:'enterpriseName',title: '企业名称',width:200,fixed: true},
			/* {align:'center',field : 'organizationCode',title : '组织机构代码',width:200}, */
			{align:'center',field : 'economicType',title : '企业经济类型',width:200},
/* 			{align:'center',field : 'businessNo',title : '工商登记注册号',width:200}, */
			{align:'center',field : 'registType',title : '登记注册类型',width:200},
			{align:'center',field : 'seniority',title : '是否具备中央储备粮代储资格',width:220},
			{align:'center',field : 'personIncharge',title : '法定代表人',width:200},
			{align:'center',field : 'provinceCityArea',title : '企业行政区划名称',width:200},
			{align:'center',field : 'telephone',title : '企业电话',width:200},
            {align:'center',field : 'isStop',title : '是否停用',width:100},
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:250},
			
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'myTableID',
		done:function(res,curr,count){
            //分类显示中文名称
            $("[data-field='isStop']").children().each(function(){
                if($(this).text()=='Y'){
                    $(this).text("是")
                }else if($(this).text()=='N'){
                    $(this).text("否")
                }
            })

        },
	});
	
	//监听工具条

	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/StoreEnterprise/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StoreEnterprise/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					var tip = result.msg;
                    if(tip.indexOf("失败") != -1){
                        tip = '该公司有库点删除失败'
					}
					layer.msg(tip,{icon:1}, function(){
                        table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								enterpriseName : $('#search #enterpriseName').val(),
								seniority : $('#search #seniority').val(),
								registType : $('#search #registType').val(),
								economicType : $('#search #economicType').val(),
								province : $('#search #province').val(),
								city : $('#search #city').val(),
								area : $('#search #district').val(),
                                isStop : $('#search #isStop').val(),
							
								
							}
						});
						})
						
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StoreEnterprise/edit.shtml?id="
					+ data.id;
		}else if (obj.event === 'print') {
			location.href = "${ctx}/StoreEnterprise/print.shtml?id="
					+ data.id;
		}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
					enterpriseName : $('#search #enterpriseName').val(),
					seniority : $('#search #seniority').val(),
					registType : $('#search #registType').val(),
					economicType : $('#search #economicType').val(),
					province : $('#search #province').val(),
					city : $('#search #city').val(),
					area : $('#search #district').val(),
                    isStop : $('#search #isStop').val(),
				
			}
		});
	});
	
	function exportxls(){
		
	
		var enterpriseName =$('#enterpriseName').val();
			var seniority =$('#seniority').val();
		var registType =$('#registType').val();
		var economicType =$(' #economicType').val();
		var province =$(' #province').val();
		var city =$(' #city').val();
		var district =$(' #district').val();

		
		window.location.href="${ctx }/StoreEnterprise/exportxls.shtml?enterpriseName="+enterpriseName+"&registType="
		+registType+"&economicType="+economicType+"&province="+province+"&city="+city+"&district="+district+"&seniority="+seniority;
	}
	/* //    省市级联动
    $(function () {
        $('#distpicker,#distpicker1').distpicker({
             province: '浙江省',
            city: '苏州市',
        });
    }); */
    
    $("#province").siblings(".layui-unselect").remove();
    $("#city").siblings(".layui-unselect").remove();
    $("#district").siblings(".layui-unselect").remove();
    

</script>
<%@include file="../common/AdminFooter.jsp"%>
