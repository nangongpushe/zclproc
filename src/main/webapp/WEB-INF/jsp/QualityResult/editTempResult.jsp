<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@include file="../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/combo.select.css">

<style>
    <!--

    -->
    .buttonArea{
        padding:5px 15px;
        background:RGB(25,174,136);
        border:none;
        border-radius:5px;
        color:#fff;
        cursor:pointer;
        display:inline;
    }
</style>
<div class="row clear-m">
    <ol class="breadcrumb">
            <li>质量管理</li>
            <li>结果导入</li>
        <li class="active"><c:if test="${auvp=='a'}">
            新增
        </c:if>
            <c:if test="${auvp=='u'}">
                编辑
            </c:if>
            <c:if test="${auvp=='v'}">
                查看
            </c:if>
            </li>
    </ol>
    <div class="container-box clearfix" style="padding: 10px">
        <!--检验结果表-->
        <form class="form_input layui-form" id="form_input"  action="saveTempResult.shtml" method="post"  lay-filter="form1">
            <input type="hidden" name="auvp" value="${auvp}">
            <input type="hidden" name="id"  value="${entity.id }"/>
            <%--<input type="hidden" name="checkType"  value="1"/>--%>
            <table class="table table-bordered">
                <!-- 表格内容 start -->
                <tbody>
                <tr>
                    <td class="text-right"><b>样品编号:</b></td>
                    <td>
                        <input maxlength="64" lay-verify="required" type="text" name="sampleNo" id="sampleNo" value='${entity.sampleNo }' class="form-control validate[required]"  placeholder=""/>
                        <%--<input type="hidden" name="varietyType" id="varietyType" value='${entity.varietyType }' class="form-control"  placeholder=""/>--%>
                    </td>
                    <td class="text-right"><b>模板编号:</b></td>
                    <td>
                        <input maxlength="64" lay-verify="required" type="text" id="templateNo" name="templateNo" value='${entity.templateNo }' class="form-control validate[required]" readonly  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>样品名称:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="sampleName" value='${entity.sampleName }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>抽样地点:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="samplePlace" value='${entity.samplePlace }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>抽样基数(吨):</b></td>
                    <td>
                        <input maxlength="10" lay-verify="required" type="text" name="basicNumber" value='${entity.basicNumber }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>收获年份(示例:2019):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="harvestYear" value='${entity.harvestYear }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>承检单位:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="acceptedUnit" value='${entity.acceptedUnit }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>受检单位:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="enterpriseName" value='${entity.enterpriseName }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>库点简称:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="inspectedUnit" value='${entity.inspectedUnit }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>检验开始时间(示例:2019-03-01):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="testDate" value='${entity.testDate }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>检验结束时间(示例:2019-03-01):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="testEndDate" value='${entity.testEndDate }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>产品等级:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="grade" value='${entity.grade }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>储存方式(示例:包装、散装):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="storeType" id="storeType" value='${entity.storeType }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>产地:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="origin" value='${entity.origin }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>入库年月(示例:2019-03):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="inStoreDate" value='${entity.inStoreDate }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>质量指标判定:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="qualityJudge" value='${entity.qualityJudge }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>储存品质指标判定:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="storeJudge" value='${entity.storeJudge }' class="form-control"  placeholder=""/>
                    </td>
                </tr>
                <tr>
                    <td class="text-right"><b>卫生指标判定:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="hygieneJudge" value='${entity.hygieneJudge }' class="form-control"  placeholder=""/>
                    </td>
                    <td class="text-right"><b>扦样日期(示例:2019-03-01):</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="samplingDate" value='${entity.samplingDate }' class="form-control"  placeholder=""/>
                    </td>

                </tr>
                <%--<tr>
                    <td class="text-right"><span class="red">*</span><b>收获年份:</b></td>
                    <td>
                        <input maxlength="50" lay-verify="required" type="text" name="harvestYear" value='${entity.harvestYear }' class="form-control"  placeholder=""/>
                    </td>
                </tr>--%>

                <%--检测项--%>
                <c:forEach items="${itemMap }" var="item" varStatus="status">
                    <%--<tr>
                        <td class="text-right"><span class="red">*</span><b>${item.key }:</b></td>
                        <td>
                            <input maxlength="50" lay-verify="required" type="text" name="column${status.count}" value='${item.value }' class="form-control"  placeholder=""/>
                        </td>
                    </tr>--%>
                    <c:choose>
                        <c:when test="${(status.index)%2==0}">
                            <tr><td class="text-right"><b>${item.key }:</b></td>
                                <td>
                                    <input maxlength="50" lay-verify="required" type="text" name="column${status.count}" value='${item.value }' class="form-control"  placeholder=""/>
                                </td>
                        </c:when>
                        <c:otherwise>
                                <td class="text-right"><b>${item.key }:</b></td>
                                <td>
                                    <input maxlength="50" lay-verify="required" type="text" name="column${status.count}" value='${item.value }' class="form-control"  placeholder=""/>
                                </td></tr>
                         </c:otherwise>

                    </c:choose>
                </c:forEach>
                <!-- 表格内容 end -->
                </tbody>
            </table>
            <p class="btn-box text-center">
                <button type="button" id="cancel" class="layui-btn layui-btn-primary layui-btn-small">返回</button>
                <button type="button" id="btnSave" class="layui-btn layui-btn-primary layui-btn-small">保存</button>
            </p>
        </form>

    </div>
</div>
<script src="${ctx}/js/knockout-3.4.0.js"></script>
<%--<script src="${ctx}/js/app/jsmodel/add.js"></script>--%>
<script>

    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#testEndDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#storeDate'
            ,format: 'yyyy-MM-dd' //可任意组合
        });
    });

    //日期选择器
    var laydate=layui.laydate;
    laydate.render({
        elem:"#harvestYear",
        type:"year",
        format:"yyyy",
    });

    $(function(){
        var auvp = '${auvp}';

        if(auvp=='v'){$("#cancel").text("返回");}else{$("#cancel").text("取消");}
        if(auvp=='v'){

            //下拉框禁用
            $("select").each(function () {$("#" + this.id).attr("disabled", true);});
            $("form").find("input,textarea,select").prop("readonly", true);
            $('#btnSave').hide();
            $('form select').show();
        }else if(auvp=='u'){
            $('#id').prop("readonly", true);
            layui.form.render("select","form1");

        }else if(auvp=='a'){
            layui.form.render('select','form1');
        }
        /* $('#origin').comboSelect(); */
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




    var lastClickTime = 0;
    var DELAY = 20000;
    $("#btnSave").click(function(){
        var templetNo=$('#templetNo').val();
        var str="";
        var sampleNo=$('#sampleNo').val();
        if(sampleNo==""){
            str+="样品编号不能为空";
        }else{

        }

        if(templetNo==""){
            if(str==""){
                str+="模板编号不能为空";
            }else{
                str+=",模板编号不能为空";
            }
        }

        var storeType=$('#storeType').val();
        if(storeType==null||storeType==""){
            if(str==""){
                str+="储存方式不能为空";
            }else{
                str+=",储存方式不能为空"
            }
        }
        // }


        if(str==""){
            if($(".form_input").validationEngine('validate')==true){
                layer.load();
                var currentTime = Date.parse(new Date());
                if (currentTime - lastClickTime > DELAY) {
                    lastClickTime = currentTime;
                    $("#btnSave").attr("disabled", true);
                    $(".form_input").ajaxSubmit({
                        type:"post",
                        success:function(data){
                            if(data.success){
                                layerMsgSuccess("保存成功",function(){location.href="${ctx}/QualityResult/ImportQualityResult.shtml?id=${qualityResultFile.id}&fileName=${qualityResultFile.fileName}&templateId=${qualityResultFile.templateId}"});
                            }else{
                                layerMsgError("保存失败");
                                $("#btnSave").attr("disabled", false);
                            }
                        },
                        error:function(xhr){
                            layerMsgError("数据接口异常");
                        },
                        complete:function(){
                            layer.closeAll('loading');
                        }
                    });
                }
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

    function toAddSelect(){
        $.colorbox({
            title : '选择粮油数据',
            iframe : true,
            opacity	: 0.2,
            href : "${ctx}/QualityThird/listChoice.shtml?",
            innerWidth : '1100px',
            innerHeight : '80%',
            close : '×15151',
            fixed : true
        });
    }

</script>
<script src="${ctx}/js/select/jquery.combo.select.js"></script>