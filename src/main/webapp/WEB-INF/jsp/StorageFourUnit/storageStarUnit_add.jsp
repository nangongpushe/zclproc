<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../common/AdminHeader.jsp" %>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>仓储管理</li>
        <li>粮库管理</li>
        <li class="active">四化粮库申报</li>
    </ol>
</div>

<style type="text/css">

    .layui-inline {
        width: 45%;
    }

    .layui-form-item .layui-form-label {
        width: 30%;
        max-width: 120px;
    }

    .layui-form-item .layui-input-inline {
        width: 65%;
    }

    .layui-form-item {
        margin-bottom: 1px;
    }

</style>


<div class="container-box clearfix" style="padding: 10px">
    <!--检验结果表-->
    <form class="layui-form form_input" action="Create.shtml" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value=""/>
        <input type="hidden" name="warehouse"  id="warehouse" value=""/>

        <div class="layui-form" id="search">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮库名称：</label>
                    <div class="layui-input-inline">
                        <select class="layui-input" lay-verify="required" name="warehouseId" lay-filter="warehouseId"
                                id="warehouseId">
                            <option  value=""></option>
                            <c:forEach var="item" items="${storageWarehouseList}">

                                <option warehouse="${item.warehouseShort }" value="${item.id}">${item.warehouseShort }</option>

                            </c:forEach>

                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>通讯地址：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" autocomplete="off" maxlength="50"
                               id="postalAddress" name="postalAddress">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>粮库主任：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" autocomplete="off" maxlength="10" id="director"
                               name="director">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>电子信箱：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required|customEmail" autocomplete="off" maxlength="25"
                               id="email" name="email">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>邮编：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required|customCode" autocomplete="off" maxlength="6"
                               id="zip" name="zip">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>电话：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required|customPhone" autocomplete="off" maxlength="13"
                               id="telphone" name="telphone">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>传真：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customfax" autocomplete="off" maxlength="14" id="fax"
                               name="fax">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>职工总人数(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" id="entireStaff" maxlength="9"
                               name="entireStaff" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>有职业资格证书人员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9" id="nvq"
                               name="nvq" onblur="checkPel('nvq');" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>大专（含）以上学历(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9"
                               id="juniorCollege" name="juniorCollege" onblur="checkPel('juniorCollege');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>中级（含）以上职称(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" id="mediumGrade" maxlength="9"
                               name="mediumGrade" onblur="checkPel('mediumGrade');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油保管员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9"
                               id="keeper" name="keeper" onblur="checkPel('keeper');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>粮油质量检验员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9"
                               id="monitor" name="monitor" onblur="checkPel('monitor');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>粮仓机械员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" id="mechanic" maxlength="9"
                               name="mechanic" onblur="checkPel('mechanic');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>中央控制室操作员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9"
                               id="controlOperator" name="controlOperator" onblur="checkPel('controlOperator');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>电工(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" maxlength="9"
                               id="electrician" name="electrician" onblur="checkPel('electrician');"
                               onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>安全生产管理员(人)：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="customNumber" autocomplete="off" id="safety" maxlength="9"
                               name="safety" onblur="checkPel('safety');" onkeyup="value=value.replace(/[^\d]/g,'')">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red"></span>原"四化"状态：</label>
                    <div class="layui-input-inline">
                        <select class="layui-input" lay-verify="required" name="oldLevel" lay-filter="aihao"
                                id="oldLevel">

                            <option value="是">是</option>
                            <option value="否">否</option>


                        </select>
                    </div>

                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>申请企业名称：</label>
                    <div class="layui-input-inline">
                        <input class="layui-input" lay-verify="required" autocomplete="off" maxlength="25"
                               id="enterprise" name="enterprise">
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right"><span class="red">*</span>'现"四化"状态'</label>
                    <div class="layui-input-inline">

                        <select class="layui-input" lay-verify="required" name="applyLevel" lay-filter="aihao"
                                id="applyLevel">

                            <option value="是">是</option>
                            <option value="否">否</option>


                        </select>
                    </div>
                </div>


                <div class="layui-inline">
                    <label class="layui-form-label" style="text-align:right">附件：</label>
                    <div class="layui-input-inline">
                        <input type="file" name="file" class="form-control " placeholder="--请输入--"/>
                    </div>
                    <input type="button" style="display: none" id="clearBtn" onclick="clearFile()" value="删除附件"/>
                </div>
            </div>

            <div class="layui-form-item">

                <label style=" width: 100px;text-align: right " class="layui-form-label"><span class="red"></span>备注:</label>
                <div style="margin-left: 111px" ; class="layui-input-block">
                    <textarea placeholder="--限450字--" maxlength="320" name="remark" class="layui-textarea"></textarea>
                </div>
            </div>

            <p>备注：带有<span class="red">*</span>为必填项！</p>
            <p class="btn-box text-center">
                <a type="button" class="layui-btn layui-btn-primary layui-btn-small cancel">取消</a>
                <input type="button" lay-submit="" lay-filter="save" class="layui-btn layui-btn-primary layui-btn-small " value="保存"/>
            </p>
        </div>
    </form>

</div>
</div>
<script>
    function checkPel(val) {
        var entireStaff = document.getElementById("entireStaff").value;
        var str=document.getElementById(val).value
        if (entireStaff != null && entireStaff != '') {
            if (str!=null&&str!=""){
                var sub=accSub(entireStaff,str);
                if (sub<0){
                    alert("数量超出职工总人数");
                    document.getElementById(val).value = "";
                }
            }

        } else {
            alert("请先填写职工总人数");
            document.getElementById("entireStaff").value =0;
            return;
        }
    }

    function accSub(arg1, arg2) {
        var r1, r2, m, n;
        try {
            r1 = arg1.toString().split(".")[1].length;
        } catch (e) {
            r1 = 0;
        }
        try {
            r2 = arg2.toString().split(".")[1].length;
        } catch (e) {
            r2 = 0;
        }
        m = Math.pow(10, Math.max(r1, r2)); //last modify by deeka //动态控制精度长度

        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m - arg2 * m) / m).toFixed(n);

    }

    $(function () {
        $("input[name='file']").change(function () {
            $("#clearBtn").css("display", "");
        });
    });

    function clearFile() {
        $("input[name='file']").val("");	// 删除
        $("#clearBtn").css("display", "none");	// 隐藏删除按键
    };

    layui.use(['form', 'laydate'], function () {
        var form = layui.form;
        form.render();
        form.on('select(warehouseId)', function(data){

            var options=$("#warehouseId option:selected"); //获取选中的项


            $("#warehouse").val(options.text());

        })
        //自定义验证规则
        form.verify({
            //非零开头的最多带两位小数的数字
            customNumber: function (value) {
                if (value.length != 0) {
                    if (!(/^\+?[1-9][0-9]*$/.test(value))) {
                        return '只能输入整数';
                    }
                }
            }
            , customEmail: function (value) {
                if (value.length != 0) {
                    if (!(/(^$)|^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value))) {
                        return '邮箱格式不正确';
                    }
                }
            }, customfax: function (value) {
                if (value.length != 0) {
                    if (!(/^(\d{3,4}-)?\d{7,8}$/.test(value))) {
                        return '传真格式不正确';
                    }
                }
            }
            , customUrl: function (value) {
                if (value.length != 0) {
                    if (!(/(^$)|(^#)|(^http(s*):\/\/[^\s]+\.[^\s]+)/.test(value))) {
                        return '链接格式不正确';
                    }
                }
            }, customCode: function (value) {

                if (!(/^[1-9][0-9]{5}$/.test(value))) {
                    return '邮政编码格式不正确';
                }

            }, customPhone: function (value) {
                if (ValidatePhone(value) == false) {

                    return '电话格式错误';
                }
            }


        });


        function ValidatePhone(val) {
            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;//手机号码
            var isMob = /^0?1[3|4|5|8][0-9]\d{8}$/;// 座机格式
            if (isMob.test(val) || isPhone.test(val)) {
                return true;
            }
            else {
                return false;
            }
        }

        //监听提交
        form.on('submit(save)', function (data) {
            $("input[lay-filter='save']").attr("disabled",true);
            var entireStaff = $('#entireStaff').val();

            $(".form_input").ajaxSubmit({
                type: "post",
                success: function (data) {
                    if(data.success){
                        layer.msg("保存成功", {icon: 1}, function () {
                            location.href = "${ctx}/StorageFourUnit.shtml";
                        });
                    }else {
                        layer.msg("信息保存失败",{icon:2})
                    }

                },
                error:function () {
                    $("input[lay-filter='save']").removeAttr("disabled");
                    layer.msg("信息保存失败",{icon:2});
                }
            });
            return false;
        });


    });


    $(".cancel").click(function () {
        layer.confirm('您是否要放弃编辑', function (index) {
            history.go(-1);
        });

    });


</script>
