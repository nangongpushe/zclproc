<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<%@include file="../common/AdminHeader.jsp" %>
<style type="text/css">
    .form_input td:nth-child(odd) {
        width: 18%;
        padding-right: 0px !important;
    }

    .td-size {

        font-size: 14px;
        text-align: left;
    }

    p {
        font-size: 15px;
        line-height: 25px;
        padding-top: 0px;
    }

    .layui-inline {
        width: 45%;
    }

    .layui-form-item .layui-form-label {
        width: 30%;
        max-width: 130px;
    }

    .layui-form-item .layui-input-inline {
        width: 65%;
    }

    .layui-form-item {
        margin-bottom: 1px;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>代储监管</li>
        <li>业务信息</li>
        <li class="active">考核评分</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    <form class="layui-form form_input" action="Create.shtml" method="post" enctype="multipart/form-data">
        <input value="${examineSerial }" type="hidden" name="examineSerial">
        <input type="hidden" name="id" value=""/>
        <input type="hidden" name="points" value=""/>
        <input type="hidden" name="examineTemplet" value=""/>
        <input type="hidden" name="storehouse" id="storehouse" value=""/>
        <c:forEach var="item" items="${manangers}" varStatus="status">
            <input type="hidden" id="${status.index + 1}" value="${item }"/>
        </c:forEach>


        <div class="layui-form" id="search">
            <div class="layui-form-item">
                <%--  <shiro:hasPermission name="StoreExamine:storehouse">   --%>

                <%-- <div class="layui-inline wareHouse"  style="display:inline-block;" >
                    <label class="layui-form-label"><span class="red">*</span>考评编号：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" value="${examineSerial }" readOnly autocomplete="off" >
                    </div>
                </div>


                <div class="layui-inline wareHouse"  style="display:inline-block;" >
                    <label class="layui-form-label"><span class="red">*</span>库点名称:</label>
                    <div class="layui-input-inline">
                    <input class="layui-input"  lay-verify="required" value="${wareHouse }" readOnly autocomplete="off" readOnly id="storehouse" name="storehouse">

                    </div>
                </div>


                    <div class="layui-inline wareHouse"  style="display:inline-block;" >
                    <label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input"  lay-verify="required" value="${mananger }" readOnly autocomplete="off" readOnly id="manager" name="manager">
                    </div>
                </div> --%>
                <%-- 	<input type="hidden"  value="${wareHouse }"   id="storehouse" name="storehouse">
                    <input type="hidden" value="${mananger }"   name="manager">
                    <shiro:hasAnyRoles name="代储管理员">    --%>
                <div class="layui-inline ">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评编号：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" value="${examineSerial }" readOnly autocomplete="off">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点名称：</label>
                    <div class="layui-input-inline">

                        <select class="layui-input" lay-verify="required" name="warehouseId"
                                lay-filter="warehouseId"
                                id="warehouseId">
                            <option value=""></option>
                            <c:forEach var="item" items="${storehouses}">

                                <option class="${ status.index + 1}" warehouse="${item.warehouseShort }"
                                        value="${item.id}">${item.warehouseShort }</option>

                            </c:forEach>

                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>库点负责人：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" maxlength="5" autocomplete="off" id="manager" name="manager">
                    </div>
                </div>
                <%-- <div class="layui-inline "  >
                    <label class="layui-form-label"><span class="red">*</span>库点名称:</label>
                    <div class="layui-input-inline">
                    <input class="layui-input" placeholder="请选择"   value="${enterpriseName }" readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">
                    </div>
                </div>


                <div class="layui-inline "   >
                    <label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
                    <div class="layui-input-inline">

                        <input class="layui-input"   value="${enterpriseManager }" readOnly autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
                    </div>
                </div> --%>
                <%-- 	</shiro:hasAnyRoles> --%>

                <%-- <shiro:lacksRole name="代储管理员">
                    <div class="layui-inline "   >
                        <label class="layui-form-label"><span class="red">*</span>考评编号：</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" value="${examineSerial }" readOnly autocomplete="off"">
                        </div>
                    </div>
                    <div class="layui-inline "  >
                        <label class="layui-form-label"><span class="red">*</span>库点名称:</label>
                        <div class="layui-input-inline">
                        <input class="layui-input" placeholder="请选择" onclick="toAddEnterpriseName()"  value="${enterpriseName }" readOnly autocomplete="off"  id="enterpriseName" name="enterpriseName">
                        </div>
                    </div>


                    <div class="layui-inline "   >
                        <label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
                        <div class="layui-input-inline">

                            <input class="layui-input"   value="${enterpriseManager }" readOnly autocomplete="off" readOnly id="enterpriseManager" name="enterpriseManager">
                        </div>
                    </div>
                </shiro:lacksRole> --%>
                <%-- 	</shiro:hasPermission> --%>

                <%-- <shiro:lacksPermission name="StoreExamine:storehouse">

                    <div class="layui-inline">
                        <label class="layui-form-label"><span class="red">*</span>考评编号：</label>
                        <div class="layui-input-inline">
                            <input class="layui-input" value="${examineSerial }" readOnly autocomplete="off" >
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label"><span class="red">*</span>库点名称:</label>
                        <div class="layui-input-inline">
                            <select class="layui-input" lay-filter="storehouse" lay-verify="required" name="storehouse"
                                id="storehouse">

                                  <c:forEach var="item" items="${storehouses}" varStatus="status">

                                  <option  class="${ status.index + 1}"  value="${item.value}">${item.value }</option>

                                </c:forEach>
                            </select>
                        </div>
                    </div>


                    <div class="layui-inline">
                        <label class="layui-form-label"><span class="red">*</span>库点负责人：</label>
                        <div class="layui-input-inline">
                            <input class="layui-input"  lay-verify="required" readOnly autocomplete="off" readOnly id="manager" name="manager">
                        </div>
                    </div>



                </shiro:lacksPermission> --%>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评名称：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" maxlength="25" autocomplete="off" id="examineName"
                               name="examineName">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评类型：</label>
                    <div class="layui-input-inline">
                        <select class="layui-input" lay-filter="examineType" lay-verify="required" name="examineType"
                                id="examineType">
                            <c:if test="${falg=='1' }">
                                <option selected="selected" value="企业自评">企业自评</option>
                            </c:if>
                            <c:if test="${falg=='' }">
                                <option selected="selected" value="检查考评">检查考评</option>
                            </c:if>
                            <!-- <option value="检查考评">检查考评</option>	 -->
                        </select>
                    </div>
                </div>

                <%-- <!-- 没有权限显示 -->
                <shiro:lacksRole name="代储管理员">
                    <div class="layui-inline">
                    <label class="layui-form-label"><span class="red">*</span>考评类型:</label>
                    <div class="layui-input-inline">
                        <select class="layui-input" lay-verify="required" name="examineType"
                            id="examineType">
                            <option value="检查考评">检查考评</option>
                        </select>
                    </div>
                    </div>


                </shiro:lacksRole> --%>

                <!-- <div class="layui-inline">
                    <label class="layui-form-label"><span class="red">*</span>考评类型:</label>
                    <div class="layui-input-inline">
                        <select class="layui-input" lay-filter="examineTempletType" lay-verify="required" name="examineTempletType"
                            id="examineTempletType">

                            <option  selected="selected" value="四化粮库">四化粮库</option>
                            <option  value="星级粮库">星级粮库</option>
                        </select>
                    </div>
                    </div> -->

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评时间：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" autocomplete="off" id="examineTime"
                               name="examineTime">
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评组成员：</label>
                    <div class="layui-input-inline" style="width:65%;">
                        <input style="display:inline-block;width:85%;" class="layui-input" lay-verify="required"
                               onclick="toAddInspectorManager()" readOnly placeholder="请选择" id="inspectors"
                               name="inspectors">
                        <a style="width:10px;" onclick="cleanInspectors();">清空</a>
                        <a style="width:10px;" onclick="cleanItemInspectors();">回删</a>
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>考评模板：</label>
                    <div class="layui-input-inline">
                        <input style="text-align:left;" type="button" onclick="toAddTemplet()" class="layui-input"
                               lay-verify="required" autocomplete="off" readOnly id="examineTemplet">
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>模板名称：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" readOnly autocomplete="off" id="templetName" name="templetName">
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>附件：</label>
                    <div class="layui-input-inline">
                        <input type="file" name="file" autocomplete="off"/>
                    </div>
                    <br/>
                    <div class="layui-input-inline">
                        <input type="button" name="clearFile" style="display: none;" value="删除"/>
                    </div>
                </div>
            </div>
            <div id="template" class="layui-row title">
                <h5>考核内容</h5>
            </div>


            <p class="btn-box text-center">
                <a type="button" class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
                <a type="button" lay-submit="" lay-filter="save"
                   class="layui-btn layui-btn-primary layui-btn-small ">保存</a>
            </p>


        </div>
    </form>
</div>
<!-- <div class="dropdown-mul-2" style="width:25%">
<select style="display:none" id="mul-2" class ="validate[required]" name="inspectors" multiple placeholder="请选择">
<option value="组成员1" >组成员1</option>
<option value="组成员2" >组成员2</option>

</select>
</div> -->


<script>

    $(function () {
        $("input[name='clearFile']").click(function () {
            $("input[name='file']").val("");
            $("input[name='clearFile']").css("display", "none"); // 隐藏按键
        });

        $("input[name='file']").change(function () {
            if ($(this).val() != null || $(this).val() != "") {
                $("input[name='clearFile']").css("display", ""); // 如果有值显示按键
            }
        });
    })

    function toAddInspectorManager(a) {
        num = a;
        $.colorbox({
            title: '选择人员',
            iframe: true,
            opacity: 0.2,
            href: "${ctx}/StoreFeedBack/getUserList.shtml?warehouseId=" + $("#warehouseId").val(),
            innerWidth: '800px',
            innerHeight: '75%',
            close: '×15151',
            fixed: true
        });
    }

    //选择考评组成员回调方法
    function callUserSelect(obj) {

        var inspectors = $("#inspectors").val();
        if (!obj.data.name) {
            return;
        }
        var addInspector = obj.data.name;
        if (inspectors == "") {
            $("#inspectors").val(addInspector);
        } else {
            //是否重复
            if (inspectors.indexOf(addInspector) == -1) {
                $("#inspectors").val(inspectors + ',' + addInspector);
            }
        }
    }

    function cleanInspectors() {
        $("#inspectors").val("");
    }

    function cleanItemInspectors() {
        var inspectors = $("#inspectors").val();
        var le = inspectors.toString().split(",").length;
        le--;
        var names = "";
        for (var i = 0; i < le; i++) {
            if (names == "") {
                names += inspectors.toString().split(",")[i];
            } else {
                names += "," + inspectors.toString().split(",")[i];
            }
        }
        $("#inspectors").val(names);
    }

    if ($("#manager").val() == null || $("#manager").val() == "") {
        $("#manager").val($("#1").val());
    }
    var alltotal = 0;

    layui.use(['form', 'laydate'], function () {
        var form = layui.form;
        form.render();
        form.on('select(warehouseId)', function (data) {

            var options = $("#warehouseId option:selected"); //获取选中的项


            $("#storehouse").val(options.text());

    })
	var laydate = layui.laydate;
	  
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#reportDate' //指定元素
	  });
 
    form.on('select(storehouse)', function(data){
        $("#inspectors").val("");
   var index= $(data.elem).find("option:selected").attr("class");
    $("#manager").val($('#'+index).val());
	});
	
	  form.on('select(examineType)', function(data){
		var value=  $(data.elem).find("option:selected").val();
		  if(value=='检查考评'){
		    /* $(".enterprise").css("display","inline-block");
		     $(".wareHouse").css("display","none");
		      $("#enterpriseName").attr("lay-verify","required");
		       $("#enterpriseName").val("");
		        $("#enterpriseManager").val(""); */
		  }else{
		  	 /*  $(".enterprise").css("display","none");
		  	  $(".wareHouse").css("display","inline-block");
		  	  $("#enterpriseName").removeAttr("lay-verify"); */
		  	 
	
		  }
     
	});
	
	 form.on('select(examineTempletType)', function(data){
		    $("#templateTab").remove();
     
	});
	
	
  //监听提交
  form.on('submit(save)', function(data){
           layer.load();
     var inspectorType = $('#inspectorType').val();
   	$(".form_input").ajaxSubmit({
				type:"post",
				success:function(data){
				 layer.closeAll('loading');
					layer.msg("保存成功",{icon:1}, function(){
						  location.href="${ctx}/StoreExamineAgent.shtml?";
						})
					
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


    layui.use('laydate', function () {
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: '#examineTime' //指定元素
        });
    });

    $(".cancel").click(function () {
        layer.confirm('您是否要放弃编辑', function (index) {
            location.href = "${ctx}/StoreExamineAgent.shtml?";
        });

    });

    function toAddTemplet() {
        var type = $("#examineTempletType").val();

        type = "0";

        $.colorbox({
            title: '选择考核模板',
            iframe: true,
            opacity: 0.2,
            href: "${ctx}/StoreExamine/select_templet_list.shtml?type=" + type,
            innerWidth: '800px',
            innerHeight: '75%',
            close: '×15151',
            fixed: true
        });
    }

    function toAddEnterpriseName() {
        var storehouse = $("#storehouse").val();
        storehouse = encodeURI(encodeURI(storehouse));
        $.colorbox({
            title: '选择考核库点',
            iframe: true,
            opacity: 0.2,
            href: "${ctx}/StoreExamine/select_EnterpriseName_list.shtml?storehouse=",
            innerWidth: '800px',
            innerHeight: '75%',
            close: '×15151',
            fixed: true
        });
    }


    function callEnterpriseNameSelect(data) {
        $("#enterpriseName").val(data.warehouseName);
        $("#enterpriseManager").val(data.creator);
    }

    function callTemplateSelect(data) {
        if (data.type == "1") {
            $("input[name='examineTemplet']").val(data.templetNo);
            $("input[name='templetName']").val(data.templetName);
            $("#examineTemplet").val(data.templetNo);
            layer.load();
            $.ajax({
                type: 'POST',
                url: "${ctx}/StoreTemplate/getStoreTemplate.shtml?templateId=" + data.templetNo + "&type=" + data.type,
                dataType: "json",
                success: function (data) {
                    layer.closeAll('loading');
                    $("#templateTab").remove();
                    var table = '<table class="td-size" id="templateTab" cellpadding="1" cellspacing="1" border="1">'
                        + '<thead>'
                        + '<tr>'
                        + '<th  style="width: 15%;" ><p  style="text-align: center">' + data.data.itemName + '</p></th>'
                        + '<th  style="width: 5%;" ><p  style="text-align: center">' + '分值' + '</p></th>'
                        + '<th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>'
                        + '<th  ><p  style="text-align: center">分数</p></th>'
                        + '</tr>'
                        + '</thead>';

                    for (var i = 0; i < data.data.children.length; i++) {
                        var item = data.data.children[i];
                        table += '<tbody>'
                            + '<tr>'
                            + '<td rowspan=' + item.rowspan + '>' + '&nbsp;&nbsp;' + item.itemName + '</td>';
                        for (var j = 0; j < item.children.length; j++) {
                            var item1 = item.children[j];
                            /*  table+='<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>';
                             +'<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>'
                             +'<td >'+'&nbsp;&nbsp;'+item1.itemName+'</td>' */
                            for (var k = 0; k < item1.children.length; k++) {
                                var num = parseInt(k) + 1;
                                var item2 = item1.children[k];


                                if (k == 0) {
                                    table += '<td style="text-align: center">' + '&nbsp;&nbsp;' + item2.standard + '</td>'
                                        + '<td><input type="hidden"  value=' + item2.parentId + ' name="parentId" /><input type="hidden"   value=' + item2.itemName + ' name="itemName" /><input type="hidden"  value=' + item2.standard + ' name="standard" />' + '&nbsp;&nbsp;' + num + '.&nbsp;&nbsp;' + item2.itemName + '</td>'

                                        + '<td><span style="display: none">' + item2.standard + '</span> <input lay-verify="number" style="text-align: center"  onchange="changeStandard(this)" name="point" type="text"/></td> </tr>	';
                                } else {

                                    table += '<tr><td style="text-align: center">' + '&nbsp;&nbsp;' + item2.standard + '</td><td><input type="hidden"  value=' + item2.parentId + ' name="parentId" /><input type="hidden"   value=' + item2.itemName + ' name="itemName" /><input type="hidden" value=' + item2.standard + ' name="standard" /> ' + '&nbsp;&nbsp;' + num + '.&nbsp;&nbsp;' + item2.itemName + '</td>'
                                        + '<td><span style="display: none">' + item2.standard + '</span><input  lay-verify="number"   style="text-align: center" onchange="changeStandard(this)" name="point" type="text"/></td> </tr>';

                                }
                            }
                        }
                        table += '</tbody>';


                    }
                    table += '<tbody>'
                        + '<tr>'
                        + '<td  style="text-align: right"; colspan="3">' + '总分' + '</td>'
                        + '<td  style="text-align: center"; colspan="1"><span id="alltotal">' + '0' + '</span></td>'
                        + '</tr>'
                        + '</tbody>';
                    $("#template").after(table);


                }
            });
        } else {
            $("input[name='examineTemplet']").val(data.templetNo);
            $("input[name='templetName']").val(data.templetName);
            $("#examineTemplet").val(data.templetNo);
            layer.load();
            $.ajax({
                type: 'POST',
                url: "${ctx}/StoreTemplate/getStoreTemplate.shtml?templateId=" + data.templetNo + "&type=" + data.type,
                dataType: "json",
                success: function (data) {
                    layer.closeAll('loading');
                    $("#templateTab").remove();
                    var table = '<table class="td-size" id="templateTab" cellpadding="1" cellspacing="1" border="1">'
                        + '<thead>'
                        + '<tr>'
                        + '<th  style="width: 20%;" colspan="2"><p  style="text-align: center">' + data.data.itemName + '</p></th>'
                        + '<th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>'
                        + '<th  ><p  style="text-align: center">分数</p></th>'
                        + '</tr>'
                        + '</thead>';

                    for (var i = 0; i < data.data.children.length; i++) {
                        var item = data.data.children[i];
                        table += '<tbody>'
                            + '<tr>'
                            + '<td rowspan=' + item.rowspan + '>' + '&nbsp;&nbsp;' + item.itemName + '</td>';
                        for (var j = 0; j < item.children.length; j++) {
                            var item1 = item.children[j];
                            table += '<td rowspan=' + item1.children.length + '>' + '&nbsp;&nbsp;' + item1.itemName + '</td>';
                            for (var k = 0; k < item1.children.length; k++) {
                                var num = parseInt(k) + 1;
                                var item2 = item1.children[k];


                                if (k == 0) {
                                    table += '<td><input type="hidden"  value=' + item2.parentId + ' name="parentId" /><input type="hidden" name="itemName"  value=' + item2.itemName + '/><input type="hidden"  value=' + item2.standard + ' name="standard" />' + '&nbsp;&nbsp;' + num + '.&nbsp;&nbsp;' + item2.itemName + '(' + item2.standard + '分)' + '</td>'
                                        + '<td><span style="display: none">' + item2.standard + '</span> <input lay-verify="number" style="text-align: center"  onchange="changeStandard(this)" name="point" type="text"/></td> </tr>	';
                                } else {

                                    table += '<tr><td><input type="hidden"  value=' + item2.parentId + ' name="parentId" /><input type="hidden" name="itemName"  value=' + item2.itemName + '/><input type="hidden" value=' + item2.standard + ' name="standard" /> ' + '&nbsp;&nbsp;' + num + '.&nbsp;&nbsp;' + item2.itemName + '(' + item2.standard + '分)' + '</td>'
                                        + '<td><span style="display: none">' + item2.standard + '</span><input  lay-verify="number"   style="text-align: center" onchange="changeStandard(this)" name="point" type="text"/></td> </tr>';

                                }
                            }
                        }
                        table += '</tbody>';


                    }
                    table += '<tbody>'
                        + '<tr>'
                        + '<td  style="text-align: right"; colspan="3">' + '总分' + '</td>'
                        + '<td  style="text-align: center"; colspan="1"><span id="alltotal">' + '0' + '</span></td>'
                        + '</tr>'
                        + '</tbody>';
                    $("#template").after(table);


                }
            });

        }


    }

    function changeStandard(ob) {
        if (isNaN($(ob).val())) {
            alert("请输入数字");
            $(ob).val("");
            return;
        }
        var standard = parseInt($(ob).val());
        var text = parseInt($(ob).siblings("span").text());
        // debugger;
        if (standard > text) {
            alert("请输入小于或等于标准分的数字");
            $(ob).val("0");
            return;
        }
        if (standard < 0) {
            alert("请输入大于或等于0的数字");
            $(ob).val("0");
            return;
        }

        //计算总分
        var alltotal = 0.0;
        $("input[name='point']").each(function () {

            if ($(this).val() != "") {
                alltotal = (parseFloat($(this).val()) + alltotal);
            }

        });
        $("#alltotal").text(alltotal.toFixed(2));
        $("input[name='points']").val(alltotal);

    }

</script>
