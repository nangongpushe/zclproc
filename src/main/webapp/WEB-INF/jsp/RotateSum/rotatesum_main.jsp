<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
    #mainTable + .layui-form .layui-table-body td[data-field="dealSerial"]{
        text-align: left;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
        text-align: left;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="inviteType"]{
        text-align: left;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="dealDate"]{
        text-align: center;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="gather"]{
        text-align: left;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="gatherDate"]{
        text-align: center;
    }
    #mainTable + .layui-form .layui-table-body td[data-field="status"]{
        text-align: left;
    }

</style>
<div class="row clear-m">
    <ol class="breadcrumb">
        <li>轮换业务</li>
        <li>货款管理</li>
        <li class="active">货款汇总</li>
    </ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

    <div class="layui-form" id="search" lay-filter="search">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">粮食品种:</label>
                <div class="layui-input-inline">
                    <select name="grainType">
                        <option value="">--请选择--</option>
                        <c:forEach var="item" items="${grainTypes}">
                            <option value="${item.value}">${item.value}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">招标类别:</label>
                <div class="layui-input-inline">
                    <select class="layui-input" name="inviteType" lay-filter="inviteType"
                            id="inviteType">
                        <option value="">--请选择--</option>
                        <option value="竞价销售">竞价销售</option>
                        <option value="协议销售">协议销售</option>
                        <option value="内部招标">内部招标</option>
                        <option value="内部销售">内部销售</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">竞价交易时间:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="dealDate" id="dealDate"
                           autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.queryPageList();}">查询</button>
            </div>
            <div class="layui-inline">
                <button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.clear();}">清空</button>
            </div>
        </div>
    </div>

    <table class="layui-table" id="mainTable" lay-filter="table" ></table>

    <script type="text/html" id="barDemo">
        <a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
    </script>
</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/RotateSum/main.js"></script>
<script type="text/html" id="dealDateFormat">
    {{Date_format(d.dealDate,true)}}
</script>

<script>
    var vm = new Main();
    ko.applyBindings(vm,$(".container-box")[0]);
    vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>