<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseName"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="warehouseShort"]{
        text-align: left;
    }
    #enterpriseTable + .layui-form .layui-table-body td[data-field="enterpriseName"]{
        text-align: left;
    }


    #SWTZ_table + .layui-form .layui-table-body td[data-field="reportWarehouse"]{
        text-align: left;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="reportMonth"]{
        text-align: center;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="storehouse"]{
        text-align: left;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="variety"]{
        text-align: left;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="quantity"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="harvestYear"]{
        text-align: center;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="origin"]{
        text-align: left;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="brown"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="unitWeight"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="impurity"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="dew"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="yellowRice"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="unsoundGrain"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="wetGluten"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="koh"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="mmol"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="advisedDeposit"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="slightlyUnsuitable"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="severeUnsuitable"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="packing"]{
        text-align: right;
    }
    #SWTZ_table + .layui-form .layui-table-body td[data-field="bulk"]{
        text-align: right;
    }
</style>
<style>
.layui-form-item  .layui-form-label{
	padding:9px 10px 2px 10px !important;
}
</style>


<div class="row clear-m">
	<ol class="breadcrumb">
		<li>报表台账</li>
		<li>统计分析</li>
		<li class="active">库存查询</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">


    <%--//来自远程监管系统--%>
    <input type="hidden"  id="userId" name="userId" value="${userId}">
    <div class="demoTable">
        月份:
        <div class="layui-inline" style="width:10%">
            <input class="layui-input" id="month" name="month" autocomplete="off" >
        </div>
        <%--<div class="layui-inline">--%>
            <%--库点类别:--%>
            <%--<select name="warehouseType" id="warehouseType">--%>
                <%--<option></option>--%>
                <%--<option value="储备库">储备库</option>--%>
                <%--<option value="代储库">代储库</option>--%>
            <%--</select>--%>
        <%--</div>--%>
        库点:
        <div class="layui-inline">
            <input type="hidden" name="reportWarehouseId" id="reportWarehouseId">
            <input class="layui-input" autocomplete="off" readonly id="reportWarehouse"
                   placeholder="请选择报库点..." onclick="addActiveClass(this)"/>
        </div>

        企业名称:
        <div class="layui-inline">
                <select name="storeEnterprise" id="storeEnterprise">
                    <option value="">--请选择--</option>
                    <c:forEach items="${enterprises}" var="item">
                        <option value="${item.id}">${item.shortName}</option>
                    </c:forEach>
                </select>
        </div>

        粮油品种:
        <div class="layui-inline">
            <select name="variety" id="variety">
                <option value="">--请选择--</option>
                <c:forEach items="${varietyList }" var="item">
                    <option value="${item.value }">${item.value }</option>
                </c:forEach>
            </select>
        </div>
        <c:if test="${isShowSuper == 'Y'}">
            是否包含最新监管库点:
        <div class="layui-inline">
                <%--<input type="checkbox" checked ="checked"  id="isSuperivise" name="isSuperivise" value="1" title="是" lay-skin="primary"/>--%>
               <select name="isSuperivise" id="isSuperivise">
                        <option value="1">是</option>
                        <option value="0">否</option>
                </select>
        </div>
        </c:if>
			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			<button class="layui-btn layui-btn-primary layui-btn-small" data-toggle="modal" data-target=".bs-example-modal-lg">高级查询</button>
            <button class="layui-btn layui-btn-primary layui-btn-small"  id="chongzi">清空</button>
		</div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			
	</fieldset>
	<table class="layui-hide" id="SWTZ_table" lay-filter="demoEvent"></table>
	
	

	</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog"  style="width:800px;">
        <div class="modal-content">
            <div class="modal-header"><!-- data-dismiss="modal"  -->
                <button type="button" class="close" aria-hidden="true" onclick="removeActiveClass()">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    选择库点
                </h4>
            </div>
            <div class="modal-body">
                <div class="layui-form" id="search">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">库点类型:</label>
                            <div class="layui-input-inline">
                                <select class="layui-input" name="warehouse_type" id="warehouse_type">
                                    <option value="">全部</option>
                                    <option value="储备库">直属单位</option>
                                    <option value="代储库">代储库</option>
                                </select>
                            </div>
                            <label class="layui-form-label">库点名称:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="warehouseName"
                                       name="warehouseName">
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                                    id="enterpriseSearch">查询
                            </button>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">库点简称:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="warehouseShort"
                                       name="warehouseShort">
                            </div>
                            <label class="layui-form-label">企业名称:</label>
                            <div class="layui-input-inline">
                                <input class="layui-input" autocomplete="off" id="enterpriseName"
                                       name="enterpriseName">
                            </div>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-small"
                                    id="qingkong">清空
                            </button>
                        </div>
                    </div>
                </div>
                <table lay-filter="operation" id="enterpriseTable"></table>
                <script type="text/html" id="bar">
                    <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="choose">选择</a>
                </script>
            </div>
            <div class="modal-footer">
                <button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="removeActiveClass()">关闭
                </button>
                <!-- <button type="button" class="layui-btn layui-btn-primary layui-btn-small" id="selectBtn" onclick="selectEnterprise()">
                    选择
                </button> -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->

</div>
	
<!-- 模态框（Modal） -->
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg">
       <div class="modal-content">
           <form class="layui-form" action="${ctx }/sysRole/save.shtml" method="post">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <h4 class="modal-title" id="myModalLabel2">高级查询</h4>
      </div>
      <div class="modal-body">
          <div class="layui-form-item">
              <div class="layui-inline">
                  <label class="layui-form-label" style="text-align:right">粮食品种：</label>
                  <div class="layui-input-inline">
                      <input type="text" name="variety" id="variety" autocomplete="off" class="layui-input">
                  </div>
              </div>
              <div class="layui-inline">
                  <label class="layui-form-label" style="text-align:right">数量(吨)：</label>
                  <div class="layui-input-inline" style="width: 100px;">
                      <input type="text" name="minQuantity" id="minQuantity" autocomplete="off" class="layui-input">
                  </div>
                  <div class="layui-form-mid">至</div>
                  <div class="layui-input-inline" style="width: 100px;">
                      <input type="text" name="maxQuantity" id="maxQuantity" autocomplete="off" class="layui-input">
                  </div>
              </div>
          </div>

		  <div class="layui-form-item">

          <div class="layui-inline">
            <label class="layui-form-label" style="text-align:right">产地：</label>
            <div class="layui-input-inline">
              <input type="text" name="origin" id="origin" autocomplete="off" class="layui-input">
            </div>
          </div>


          <div class="layui-inline">
            <label class="layui-form-label" style="text-align:right">收获年份：</label>
            <div class="layui-input-inline" style="width: 100px;">
              <input type="text" name="minMonth" id="minMonth" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">至</div>
            <div class="layui-input-inline" style="width: 100px;">
              <input type="text" name="maxMonth" id="maxMonth" autocomplete="off" class="layui-input">
            </div>
          </div>
	  </div>
			  
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label" style="text-align:right">粮食指标：</label>
            <div class="layui-input-inline">
          		<select name="quota" lay-filter="aihao" class="layui-input" id="quota">
	            <option value="" selected></option>
	            <option value="BROWN">出糙(%)</option>
	            <option value="UNIT_WEIGHT">容重(g/l)</option>
	            <option value="IMPURITY">杂质(%)</option>
	            <option value="DEW">水分(%)</option>
	            <option value="YELLOW_RICE">黄粒米(%)</option>
	            <option value="UNSOUND_GRAIN">不完善粒(%)</option>
	            <option value="WET_GLUTEN">小麦湿面筋(%)</option>
	            <option value="KOH">酸价(KOH)(mg/g)</option>
	            <option value="MMOL">过氧化值(mmol/kg)</option>
	            <option value="ADVISED_DEPOSIT">宜数量存(吨)</option>
	            <option value="SLIGHTLY_UNSUITABLE">轻度不适宜存放数量(吨)</option>
	            <option value="SEVERE_UNSUITABLE">重度不适宜存放数量(吨)</option>
	          </select>
             <!--  <input type="text" name="quota" id="quota" autocomplete="off" class="layui-input"> -->
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label" style="text-align:right">指标范围：</label>
            <div class="layui-input-inline" style="width: 100px;">
              <input type="text" name="minQuota" id="minQuota" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid">至</div>
            <div class="layui-input-inline" style="width: 100px;">
              <input type="text" name="maxQuota" id="maxQuota" autocomplete="off" class="layui-input">
            </div>
          </div>
      </div>
  
<!--   <div class="layui-form-item">
    <label class="layui-form-label">审核状态</label>
    <div class="layui-input-block">
      <input type="radio" name="status" value="全部" title="全部" checked>
      <input type="radio" name="status" value="待提交" title="待提交">
      <input type="radio" name="status" value="审核中" title="审核中">
      <input type="radio" name="status" value="已通过" title="已通过">
      <input type="radio" name="status" value="已签发" title="已签发">
      <input type="radio" name="status" value="已驳回" title="已驳回">
    </div>
  </div> -->
  
    </div>
      <div class="modal-footer">
        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal" data-type="reload">确认</button>
        <button class="layui-btn layui-btn-primary layui-btn-small" data-dismiss="modal">取消</button>
      </div>
     </form>
       </div><!-- /.modal-content -->
   </div><!-- /.modal -->
</div>

<script>

    // var arr = new Date();
    // var year = arr.getFullYear(); //获取当前日期的年份
    // var month = arr.getMonth(); //获取当前日期的月份
    // var year2 = year;
    // if (month == 0) {             //如果是1月份，则取上一年的12月份
    //     year2 = parseInt(year2) - 1;
    //     month = 12;
    // }
    // if (month < 10) {
    //     month = '0' + month;//月份填补成2位。
    // }
    // var t2 = year2 + '-' + month;
    var laydate = layui.laydate;
    //执行一个laydate实例
    laydate.render({
        elem: '#month' //指定元素
        , type: 'month'
        //, value: t2
    });

    $('#chongzi').click(function () {
        $('#month').val("");
        // $('#reportWarehouseId').val("");
        $('#variety').val(""); //
        $('input[name="variety"]').val(""); //   弹框的 粮食品种
        $('#minQuantity').val("");
        $('#maxQuantity').val("");
        $('#origin').val(""); //产地
        $('#minMonth').val("");
        $('#maxMonth').val("");
        $('#minQuota').val("");
        $('#maxQuota').val("");

        $('select[name="quota"]').val("");
        $('select[name="quota"]').next().find('input[type="text"]').val('')
        $("#storeEnterprise").val("");
        $("#isSuperivise").val("1");
        $('#reportWarehouse').val("");
        $('#reportWarehouseId').val("");
        /*$('#reportWarehouse1').val("")
        $('#reportWarehouseId1').val("");*/

    });

    //为当前点击的行新增activeClass
    function addActiveClass(obj) {
        $('#myModal1').modal({backdrop: 'static'}).modal('show');
    }

    //移除activeClass
    function removeActiveClass(obj) {
        $('#myModal1').modal('hide');
        $('.activeEnterprise').removeClass('activeEnterprise');
    }

    layui.use(['table'], function() {
        var table = layui.table;
        table.render({
            elem : '#enterpriseTable',
            //url : '${ctx}/storageWarehouse/limitPageList.shtml',
            url : '${ctx}/storageWarehouse/listWarehouseByCompany.shtml',
            method : "POST",
            cols : [[
                {fixed : 'left', title : '操作', width : 100, align : 'center', toolbar : '#bar'},
                {field : 'warehouseName',title : '库点名称',width:150},
                {field : 'warehouseShort',title : '库点简称',width:150},
                {field : 'enterpriseName',title : '所属企业名称(代储库点用)',width:200}
            ]],//设置表头
            request : {
                pageName : 'page',
                limitName : 'pageSize'
            },
            page:true,//开启分页
            limit:10,
            id:'enterpriseTableId',
            done:function(res,curr,count){
            },
        });

        //搜索
        $('#enterpriseSearch').click(function() {
            table.reload("enterpriseTableId", {
                method: 'post', //如果无需自定义HTTP类型，可不加该参数
                where : {
                    warehouse_type: $('#search #warehouse_type').val(),
                    warehouseName: $('#search #warehouseName').val(),
                    warehouseShort: $('#search #warehouseShort').val(),
                    enterpriseName: $('#search #enterpriseName').val(),
                    userId: $('#userId').val()

                }
            });
        });

        table.reload("enterpriseTableId", {
            method: 'post', //如果无需自定义HTTP类型，可不加该参数
            where : {
                warehouse_type: $('#search #warehouse_type').val(),
                warehouseName: $('#search #warehouseName').val(),
                warehouseShort: $('#search #warehouseShort').val(),
                enterpriseName: $('#search #enterpriseName').val(),
                userId: $('#userId').val()

            }
        });
        //清除查询条件
        $('#qingkong').click(function () {
            $('select[name="warehouse_type"]').next().find('input[type="text"]').val('');
            $('#warehouseName').val("");
            $('#warehouseShort').val("");
            $('#enterpriseName').val("");
        });

        table.on('tool(operation)', function(obj) {
            var data = obj.data;
            if (obj.event === 'choose') {
                var warehouseShort = data.warehouseShort;

                $('#reportWarehouse').val(warehouseShort);
                $('#reportWarehouseId').val(data.id);
                $('#reportWarehouse1').val(warehouseShort)
                $('#reportWarehouseId1').val(data.id);

            }
            $('#myModal1').modal('hide');
        });
        //监听FORM结束

    });

  $('#myModal').on('show.bs.modal', function (event) {  
  	 
  })
debugger
var isSuperivise = $("#isSuperivise").val();
layui.use(['form', 'layedit', 'laydate','table'],function(){
var table =layui.table;
var laydate =layui.laydate;

var form = layui.form;
form.render();

    laydate.render({
        elem: '#month'
        ,format: 'yyyy-MM'
        ,type: 'month'
    })

laydate.render({
 elem: '#minMonth'
 ,format: 'yyyy'
 ,type: 'year'
})
laydate.render({
 elem: '#maxMonth'
 ,format: 'yyyy'
 ,type: 'year'
})
//render初始化参数
table.render({elem:'#SWTZ_table'
	,url:'${ctx}/kccx/list.shtml?userId=${userId}'
	,cols:[[
		/* {field:'id',title:'ID',width:200,sort:true} */
	{field:'extendsWarehouse',title:'库点名称',width:100,align:'center'}
	,{field:'reportMonth',title:'报表月份',width:100,align:'center'}
	,{field:'storehouse',title:'仓号',width:100,align:'center'}
	,{field:'variety',title:'品种',width:100, align:'center'}
    ,{field:'quantity',title:'数量(吨)',width:100,align:'center'}
    ,{field:'harvestYear',title:'收获年份',width:100, align:'center'}
    ,{field:'origin',title:'产地',width:100,align:'center'}
    ,{field:'brown',title:'出糙(%)',width:100, align:'center'}
    ,{field:'unitWeight',title:'容重(g/l)',width:100, align:'center'}
    ,{field:'impurity',title:'杂质(%)',width:100, align:'center'}
    ,{field:'dew',title:'水分(%)',width:100,align:'center'}
    ,{field:'yellowRice',title:'黄粒米(%)',width:100, align:'center'}
    ,{field:'unsoundGrain',title:'不完善粒(%)',width:100, align:'center'}
    ,{field:'wetGluten',title:'小麦湿面筋(%)',width:100,align:'center'}
    ,{field:'koh',title:'酸价(KOH)(mg/g)',width:100, align:'center'}
    ,{field:'mmol',title:'过氧化值(mmol/kg)',width:100, align:'center'}
    ,{field:'advisedDeposit',title:'宜数量存(吨)',width:100,align:'center'}
    ,{field:'slightlyUnsuitable',title:'轻度不适宜存放数量(吨)',width:130,align:'center'}
    ,{field:'severeUnsuitable',title:'重度不适宜存放数量(吨)',width:130, align:'center'}
    ,{field:'packing',title:'包装(吨)',width:130, align:'center'}
    ,{field:'bulk',title:'散装(吨)',width:130, align:'center'}
		]],
        where: {
            //传值 startDate : startDate,
            isSuperivise : isSuperivise
        }
	,id:'testReload' 
	,page:true
	,even: true //开启隔行背景
	,height:490
	});
	
	var $ =layui.$;

	var active = {

	    reload:function(){
	        var demoReload =$('#demoReload');
	        var variety = $("#variety");
            var origin = $('#origin');
            var minQuantity =$('#minQuantity');
            var maxQuantity =$('#maxQuantity');
            var minMonth =$('#minMonth');
            var maxMonth =$('#maxMonth');
            var quota = $('#quota');
            var minQuota =$('#minQuota');
            var maxQuota =$('#maxQuota');
  		    table.reload('testReload',{
                where:{ //设定异步数据接口的额外参数
                    isSuperivise : $('#isSuperivise').val(),
                    key:{
                          variety:variety.val(),
                          origin:origin.val(),
                          minQuantity:minQuantity.val(),
                          maxQuantity:maxQuantity.val(),
                          minMonth:minMonth.val(),
                          maxMonth:maxMonth.val(),
                          quota:quota.val(),
                          minQuota:minQuota.val(),
                          maxQuota:maxQuota.val(),
                          month : $('#month').val(),
                          warehouse : $('#reportWarehouse').val(),
                          warehouseId : $("#reportWarehouseId").val(),
                          enterpriseId : $("#storeEnterprise").val(),
                        }
                    }
  		    });
	     }
	};
	

    $('.layui-btn').on('click',function(){
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });

});

</script>


<%@ include file="../../common/AdminFooter.jsp" %>