<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<script src="${ctx}/js/echarts.min.js"></script>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}


</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓库管理</li>
		<li class="active">能耗管理</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
 	 <div class="layui-form" id="search" >
 	 
		<div class="layui-form-item">
		 <form action="" id="form-query">
			<div class="layui-inline">
				<label class="layui-form-label">库点名称：</label>
				<div class="layui-input-inline">
					<select class="layui-input" lay-filter="warehouseName" lay-verify="required" name="warehouseName" 
						id="warehouseName">
						
						  <c:forEach var="item" items="${storehouses}" varStatus="status">
						 
						  <option  class="${ status.index + 1}"  value="${item.warehouseShort}">${item.warehouseShort }</option>
						 
						</c:forEach>									
					</select>					
				</div>
				
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">工作类型：</label>
				<div class="layui-input-inline">
					<select class="layui-input"  name="workType" maxlength="16" lay-filter="aihao"
						id="workType">
						<option value=""></option>
						<option value="通风">通风</option>
						<option value="气调">气调</option>
						<option value="熏蒸">熏蒸</option>
						<option value="控温">控温</option>
						<option value="出入库">出入库</option>
						<option value="中转">中转</option>
						
					</select>
				</div>
				
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red"></span>作业时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input"  autocomplete="off" id="workTime" name="workTime">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label"><span class="red">*</span>月份:</label>
				<div class="layui-input-inline">
					<input class="layui-input" lay-verify="required"  autocomplete="off" id="month" name="month">
				</div>
			</div>
			
			
			<div class="layui-inline">
			<a type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small ">查询</a>
				
			</div>
			
			</form>
			
		</div>

	
   

    <div class="manage">
        <p class="btn-box" style="padding-top:0px">
        	 <shiro:hasPermission name="StorageStarUnit:add">  
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="importFile();">导入</button>
              </shiro:hasPermission>
             </p>
        
         
		
    </div>
    <div id="main" style="width: 88%;height:400px; margin-top:20px;"></div>
   	</div>
</div>


<script>


layui.use(['form', 'laydate'], function(){
  	var form = layui.form;
	form.render();
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#workTime' //指定元素
	  });
 	//执行一个laydate实例
	  laydate.render({
	    elem: '#month' //指定元素
	    ,type: 'month'
	  });
   //监听提交
  form.on('submit(save)', function(data){
      var workTime  = $("#workTime").val();
      var month  = $("#month").val();
      if(workTime!=""){
         if(workTime.indexOf(month) == -1 ){
             alert("作业时间的年月必须与月份的年月一致")
             return false;
		 }
	  }


    query();
    return false;
  });
  
  
  
});

 function importFile(){
     debugger;
 	layer.open({
  			content: '<form id="form-import" method="post" enctype="multipart/form-data"><div class="layui-form-item"><label style=" width: 100%; text-align: left;" class="layui-form-label"><span class="red"></span>导入模板：（文件后缀必须为xls,xlsx）</label><input type="file" class="form_txt70" name="file" style="width:400px" id="file"/></div><div class="layui-form-item"><button type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="download();">模板下载</button> </div></form>'
  			,btn: ['保存', '取消']
  			,area: ['500px', '300px']
  			,yes: function(index, layero){
  				layer.load();
  						var opt = {
							async: false, //默认true异步
							url:"${ctx}/StorageEnergy/importxls.shtml",
							type:"POST",
							dataType:"json",
							success:function(data) {
							    if(data.success){
                                    layer.closeAll('loading');
                                    layer.closeAll(); //疯狂模式，关闭所有层
                                    layer.msg("导入成功",{icon:1}, function(){

                                    })
                                }else {
                                    layer.closeAll(); //疯狂模式，关闭所有层
                                    alert(data.msg);
                                }

							}
							
					 };
						var form = $("#form-import").ajaxSubmit(opt);	
  			
				
			  }
			  ,btn2: function(index, layero){
			    //按钮【按钮二】的回调
			    layer.closeAll(); //疯狂模式，关闭所有层
			    //return false 开启该代码可禁止点击该按钮关闭
			  }
			  
			  ,cancel: function(){ 
			    //右上角关闭回调
			    
			    //return false 开启该代码可禁止点击该按钮关闭
			  }
			});
 
 }
	
	
	
    var myChart = echarts.init(document.getElementById('main'));
	
  
   // 使用刚指定的配置项和数据显示图表。
    myChart.setOption({
    title: {
        text: '折线图堆叠'
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:[]
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: []
    },
    yAxis: {
        type: 'value',
         name:'能耗',
    },
    series: [
     
    ]
});
  //查询某天入场人数
	 function query()  {
	   		layer.load();
	     	 var obj;
						var opt = {
							async: false, //默认true异步
							url:"${ctx}/StorageEnergy/list.shtml",
							type:"POST",
							dataType:"json",
							success:function(data) {
							layer.closeAll('loading');
								var series=[];
								var legend = [];
								var xAxis =[];
								var name="";
								var workTime = $("#workTime").val();
								if(workTime == ""){
									for(var i = 1;i<32;i++){   
								   	xAxis.push(i);
									}
									name="天数";
								}else{
									for(var i = 0;i<25;i++){   
								   	xAxis.push(i);
									}
									name="小时";
								}
								
									myChart.clear();
								if(data.data.data==null){
									
								}else{
									for(var i = 0;i<data.data.data.length;i++){   								
		   								var ob=data.data.data[i];	
		   								legend.push(ob.workType);									
								        series.push({
								            name: ob.workType,
								            type: 'line',
								            stack: '总量',
								           data:ob.hour.split(';')								          
								        });
								}
   								
    						}
    					
    						
								/* series=series.toString(); */
								
								// 使用刚指定的配置项和数据显示图表。
									    myChart.setOption({
									    	title: {
										        text: '折线图堆叠'
										    },
										    tooltip: {
										        trigger: 'axis'
										    },
										    
										    grid: {
										        left: '3%',
										        right: '4%',
										        bottom: '3%',
										        containLabel: true
										    },
										    toolbox: {
										        feature: {
										            saveAsImage: {}
										        }
										    },
										    xAxis: {
										        type: 'category',
										        boundaryGap: false,
										        data: []
										    },
										    yAxis: {
										        type: 'value',
										         name:'能耗',
										    },
									        legend: {
      										  data:legend
  											  },
  											  xAxis: {
										      type: 'category',
										      boundaryGap: false,
										      name:name,
										      data: xAxis
										    },
									       series: series
 
																				        
									   });
							
								}
					};
			var form = $("#form-query").ajaxSubmit(opt);	

	     }           
	

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

	var workTime  = new Date().Format("yyyy-MM");
	$("input[name='month']").val(workTime);
    
    query();
    
function download(){
	window.location.href="${ctx}/StorageEnergy/download.shtml";
}
</script>
<%@include file="../common/AdminFooter.jsp"%>
