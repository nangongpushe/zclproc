<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<div class="container clearfix" style="padding: 10px">
    <div class="layui-row">
        <div class="layui-col-md2">
            <span>库点名称:</span>
            <input name ="sid" hidden value="${sid}"/>
            <span><input name ="warehouseShort" value="${deliveryPlace}"/></span>
        </div>
        <div class="layui-col-md2">
            <span>仓号:</span>
            <span>
                <input name = "encode" value="${encode}"/>
            </span>
        </div>
        <div class="layui-col-md2">
            <span>粮食品种:</span>
            <span>
                <select name="grainTypeModel">
                    <option value="">--请选择--</option>
                    <c:forEach var="item" items="${grainTypes}">
                    <option <c:if test="${item.value == grainType}">selected</c:if> value="${item.value}">${item.value}</option>
                    </c:forEach>
                </select>
            </span>
        </div>
        <div class="layui-col-md2">
            <span>成交单位:</span>
            <span><input name = "receiverPlace" value="${receiverPlace}"/></span>
        </div>
        <div class="layui-col-md3">
            <span>
                <div class="layui-inline"><button class="layui-btn layui-btn-primary layui-btn-small" style="text-align:center" id="search_deail" onclick="search_deail()">查询</button></div>
            </span>
        </div>
    </div>
    <!-- layui静态表格 -->
    <table class="layui-table">
        <thead class="top-head">
        <tr>
            <td align="center">成交子明细号</td>
            <td align="center">成交单位</td>
            <td align="center">仓房编号</td>
            <td align="center">交货所属库点</td>
            <td align="center">粮食品种</td>
            <td align="center">数量(吨)</td>
            <td align="center">产地</td>
            <td align="center">入库年度</td>
            <td align="center">储存方式</td>
            <td align="center">成交价格(元/吨)</td>
            <td align="center">成交金额(元)</td>
            <td align="center">提货截止时间</td>
            <td align="center">已付金额(货款)</td>
            <td align="center">未付金额(货款)</td>
            <td align="center">已开提货单数量</td>
            <td align="center">剩余未开数量</td>
            <td align="center">占用保证金</td>
            <td align="center">保证金余额</td>
            <c:forEach items="${processTypes}" var="item" varStatus="status">
                <td align="center">认领${item.value}</td>
                <td align="center">未认领${item.value}</td>
            </c:forEach>
        </tr>
    </thead>
        <tbody>
        <c:forEach items="${detailList}" var="item" varStatus="status">
            <tr>
                <td align="left">${item.dealSerial}</td>
                <td align="left">${item.dealUnit}</td>
                <td align="left">${item.storehouse}</td>
                <td align="left">${item.deliveryPlace}</td>
                <td align="left">${item.grainType}</td>
                <td align="right">${item.quantity}</td>
                <td align="left">${item.produceArea}</td>
                <td align="center">${item.warehoueYear}</td>
                <td align="left">${item.storageType}</td>
                <td align="right">${item.dealPrice}</td>
                <td align="right">${item.dealAmount}</td>
                <td align="center">${item.takeEnd}</td>
                <td align="right">${item.payedMoney}</td>
                <td align="right">${item.dealAmount-item.payedMoney}</td>
                <td align="right">${item.takedOrderNum}</td>
                <td align="right">${item.quantity-item.takedOrderNum}</td>
                <td align="right">${item.totalBail}</td>
                <td align="right">${item.totalBail-item.reTotalBail}</td>
                <c:forEach items="${processTypes}" var="processType" varStatus="status">
                    <c:set var = 'payedType' value="type${status.count-1}0"/>
                    <c:set var = 'allPayedType' value="type${status.count-1}1"/>
                    <td align="right">${item[payedType]}</td>
                    <td align="right">${item[allPayedType]-item[payedType]}</td>
                </c:forEach>
            </tr>
        </c:forEach>
    </tbody>
    </table>
    <div class="layui-row text-center">
        <div class="layui-col-md3"><span>总成交金额：${allDealAmount}元</span></div>
        <div class="layui-col-md3"><span>总成交吨数：${allQuantity}吨</span></div>
        <div class="layui-col-md3"><span>已付总金额：${allPayedMoney}元</span></div>
        <div class="layui-col-md3"><span>未付总金额：${allUnpayedMoney}元</span></div>
    </div>
    <div class="layui-row text-center">
        <a type="button" class="layui-btn layui-btn-small" id="exportRotateSum" onclick="exportE()">导出</a>
        <a type="button" class="layui-btn layui-btn-small" onclick="layer.closeAll();">关闭</a>
    </div>
</div>
<script>
    function showClientInfo(clientName) {
        var url = "../CustomerInformation/clientInfo.shtml?";
        $.post(url, {clientName:clientName}, function(str) {
            layer.open({
                closeBtn:1,
                type : 1,
                content : str,
                area:['800px','400px']
            });
        });
    }

    function search_deail(){
        layer.close(layer.index);
        var sid =$("input[name = 'sid']").val();
        var deliveryPlace = $("input[name = 'warehouseShort']").val();
        var encode = $("input[name='encode']").val();
        var receiverPlace = $("input[name = receiverPlace]").val();
        let grainType = $("select[name='grainTypeModel']").val();
        let width = $("#page-wrapper").innerWidth();
        let height = $("#page-wrapper").innerHeight();
        var url = "../rotateSum/view.shtml?";
        $.post(url, {sid:sid,deliveryPlace:deliveryPlace,encode:encode,receiverPlace:receiverPlace,grainType:grainType},
            function(str) {
            layer.open({
                type : 1,
                content : str,
                area:[width,height]
            });
        });
    }

    function exportE() {
        var sid = $("input[name = 'sid']").val();
        var deliveryPlace = $("input[name = 'warehouseShort']").val();
        var encode = $("input[name='encode']").val();
        var receiverPlace = $("input[name = receiverPlace]").val();
        window.location.href = "../rotateSum/exportRotateSum.shtml?sid=" + sid +
            "&deliveryPlace=" + deliveryPlace + "&encode=" + encode + "&receiverPlace=" + receiverPlace
    }

</script>
