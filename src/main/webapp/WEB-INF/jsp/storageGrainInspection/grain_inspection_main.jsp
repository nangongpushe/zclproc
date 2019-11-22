<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/AdminHeader.jsp"%>
<style>
	#manage_table + .layui-form .layui-table-body td[data-field="reportDateStr"]{
		text-align: center;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="warehouse"]{
		text-align: left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="encode"]{
		text-align: left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="weather"]{
		text-align: left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="quantity"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="storehouseTemp"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="temperature"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="storehouseWet"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="airWet"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="temperatureAvg"]{
		text-align: right;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="pestLevel"]{
		text-align: left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="checkProperty"]{
		text-align:left;
	}
	#manage_table + .layui-form .layui-table-body td[data-field="checkCharge"]{
		text-align: left;
	}
</style>
<style>
    #detailForm{
        display: inline-block;
    }
</style>
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
  <input type="hidden" value="${type}" id="type">
<%-- self --%>
<%--<div class="" id="self-grain-cover" style=""></div>--%>
<div class="" id="self-cover-grain" style="">
    <div class="dialogsCont-" style="">
        <div class="grain-cont-detail"></div>
        <a class="cancalButtons" onclick="displayNone()" style="">返回</a>
    </div>
</div>
<style>
    #self-grain-cover {
        z-index: 20000000;
        opacity: 0.3;
        background-color: rgb(0, 0, 0);
        position: fixed;
        top: 0px;
        display: none;
        left: 0px;
        width: 100%;
        height: 100%;
    }
    .dialogsCont-{
        padding-top: 10px;
        padding: 0 15px 12px;
        pointer-events: auto;
        user-select: none;
        -webkit-user-select: none;
    }
    .cancalButtons{
        height: 28px;
        display: inline-block;
        line-height: 28px;
        margin: 5px 5px 0;
        padding: 0 15px;
        border: 1px solid #dedede;
        background-color: #fff;
        color: #333;
        position: absolute;
        border-radius: 2px;
        font-weight: 400;
        top: 0;
        right: 16px;
        cursor: pointer;
        text-decoration: none;
    }
    #self-cover-grain {
        z-index: 3;
        overflow: scroll;
        min-width: 260px;
        top: 0;
        margin: 0;
        width: 100%;
        height: 100%;
        padding: 0;
        display: none;
        background-color: #fff;
        position: fixed;
        -webkit-background-clip: content;
        border-radius: 2px;
        box-shadow: 1px 1px 50px rgba(0, 0, 0, .3);
    }
</style>
<script>
    //点击弹框取消按钮
    function displayNone() {
        $('#self-cover-grain').css({'display':'none'})
        $('#self-grain-cover').css({'display':'none'})
        $('.grain-cont-detail').html('')
        //searchReload()
    }
</script>
<%-- self --%>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search">
		<div class="layui-form-item" style="height:25px; width:1000px">
			<div class="layui-inline">
		    	<label class="layui-form-label">所属库点：</label>
		    	<div class="layui-input-inline">
		    		<input class="layui-input" autocomplete="off" name="warehouse"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">仓房编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="storehouseEncode"/>
			    </div>
			</div>
			<div class="layui-inline">
		    	<label class="layui-form-label">仓房状态：</label>
		    	<div class="layui-input-inline">
		    		<select name="storehouseStatus">
		    			<option value=""></option>
		    			<c:forEach items="${ststusList }" var="item">
		    				<option value="${item.value }">${item.value }</option>
		    			</c:forEach>
		    		</select>
		    		<!-- <input class="layui-input" autocomplete="off" name="storehouseStatus"/> -->
				</div>
			</div>
		</div>	
		<div class="layui-form-item" style="height:25px">
			<div class="layui-inline">
				<label class="layui-form-label">检查性质：</label>
				<div class="layui-input-inline">
                		<select name="checkProperty" lay-verify="required">
            				<option value=""></option>
            				<option value="上级单位检查">上级单位检查</option>
            				<option value="月普查">月普查</option>
            				<option value="季鉴定">季鉴定</option>
            				<option value="保管员自查">保管员自查</option>
            			</select>
                	</div>
			</div>
			<div class="layui-inline">
		    	<label class="layui-form-label">填报日期：</label>
		    	<div class="layui-input-inline">
		    		<input class="layui-input date-need" autocomplete="off" name="reportDate"/>
				</div>
			</div>
			<div class="layui-inline">
				<button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="search_btn" onclick="searchReload()">查询</button>
			</div>
		</div>
	</div>
	<div class="manage">
	<br>
		<shiro:hasPermission name="GrainInspection:add">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/storageGrainInspection/addPage.shtml?type=${type}'">新增</button>
		</shiro:hasPermission>	
        <%-- <p class="btn-box">
        	<shiro:hasPermission name="GrainInspection:add">
            	<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/storageGrainInspection/addPage.shtml'">新增</button>
            </shiro:hasPermission> --%>
            <!-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="editPage_btn">编辑</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="del_btn">删除</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="view_btn">查看</button> -->
            
            <!-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small">导出</button>
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small">打印</button> -->
        <!-- </p> -->

        <table lay-filter="operation" id="manage_table"></table>
        <script type="text/html" id="rowOperation">
            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="copy">复制</a>
			<shiro:hasPermission name="GrainInspection:edit">
            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="GrainInspection:del">
            <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
			</shiro:hasPermission>

        </script>
	</div>
</div>
<%--</form>--%>
<script>
	var form = layui.form;
	form.render();
    //加载日历插件
    var laydate = layui.laydate;
    $('.date-need').each(function(){
		laydate.render({
			elem: this
		});
	});
    var table = layui.table;
    table.render();
    //执行渲染
    table.render({
        elem : '#manage_table',
        url : '${ctx }/storageGrainInspection/list.shtml',
        method : "POST",
        cols : [[
            /* {checkbox : true}, */
            {field : 'reportDateStr', title : '填报日期', width : 120,align:'center'},
            {field : 'warehouse', title: '库点名称', width : 100,align:'center'},
            {field : 'encode', title : '仓房编号', width : 100,align:'center'},
            {field : 'status', title : '仓房状态', width : 100,align:'center'},
            {field : 'weather', title : '天气', width : 100,align:'center'},
            {field : 'quantity', title : '实际数量（吨）', width : 140,align:'center'},
            // {field : 'dew', title : '水分（%）', width : 100},
            // {field : 'impurity', title : '杂质（%）', width : 100},
            {field : 'storehouseTemp', title : '仓温（%）', width : 100,align:'center'},
            {field : 'temperature', title : '气温（%）', width : 100,align:'center'},
            {field : 'storehouseWet', title : '仓湿（RH%）', width : 140,align:'center'},
            {field : 'airWet', title : '气湿（RH%）', width : 140,align:'center'},
            {field : 'temperatureAvg', title : '整仓平均粮温（℃）', width : 160,align:'center'},
            {field : 'pestLevel', title : '虫粮等级', width : 100,align:'left'},
            {field : 'checkProperty', title : '检查性质', width : 100,align:'center'},
            {field : 'checkCharge', title : '检查负责人', width : 100,align:'center'},
            {fixed: 'right', title : '操作', align : 'center', toolbar : '#rowOperation', width:300},
        ]],//设置表头
        request : {
            pageName : 'page', 
            limitName : 'pageSize'
        },
        page:true,//开启分页
        limit:10,
        id:'manage_tableId',
        done:function(res,curr,count){
            $('#manage_table + .layui-form .layui-table-fixed-r .layui-table-body tr').each(function (i, v) {
                    $(v).data('id',res.data[i].id)
            })
        },
    });
    
    //监听工具条
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		if (obj.event === 'detail') {
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/storageGrainInspection/viewPage.shtml",
                {id:data.id,type:$("#type").val(),Projectile:'Projectile'})
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/storageGrainInspection/remove.shtml", {
					id : data.id,type:'${type}'
				}, function(result) {
					if (result.success) {
						obj.del();
						layer.msg(result.msg,{time:1000,icon:1});
						//layer.msg(result.msg,{icon:2});
					} else {
						layer.msg(result.msg,{icon:2});
					}
				});
			});
		} else if (obj.event === 'edit') {
			/*location.href = "${ctx}/storageGrainInspection/editPage.shtml?id="
					+ data.id+"&type="+$("#type").val();*/
            layer.load(2, {time: 6000});
            $('#self-cover-grain').css({'display':'block'})
            $('#self-grain-cover').css({'display':'block'})
            $('.grain-cont-detail').load("${ctx}/storageGrainInspection/editPage.shtml",
                {id:data.id,type:$("#type").val(),Projectile:'Projectile'})
		}else if(obj.event === 'copy'){
            location.href = '${ctx}/storageGrainInspection/editPage.shtml?id='
                + data.id + '&operatorFlag=c'+"&type="+$("#type").val();
		}
	});
    

    //搜索操作
    function searchReload(){
        table.reload('manage_tableId', {
        	method:"POST",
            where : {
                warehouse : $('#search input[name="warehouse"]').val(),
                storehouseEncode : $('#search input[name="storehouseEncode"]').val(),
                storehouseStatus : $('#search select[name="storehouseStatus"]').val(),
                checkProperty : $('#search select[name="checkProperty"]').val(),
                reportDate : $('#search input[name="reportDate"]').val(),
            }
        });
    };
</script>
