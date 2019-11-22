<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<HTML>
    <head>
        <meta http-equiv="Content-Type"
              content="application/ms-excel; charset=utf-8"/>
        <style>
            #content td,th{
            text-align:center;
            }
            .title{
            font-size:42px;
            text-align:center;
            }
        </style>
    </head>
    <BODY class="body_MarginLR10px" style="margin-right:0px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" sheetName="4">

        </table>
    </BODY>

    <BODY class="body_MarginLR10px" style="margin-right:0px;">
        <TABLE width="100%" align="center" sheetName="5">
            <tr>
                <td>
                    <TABLE width="100%" align="center" sheetName="1">
                        <tr><td colspan="${fn:length(detailList)}" class="title">货款汇总</td></tr>
                        <tr></tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01" sheetName="2">
                        <tr>
                            <td class="td_white" colspan="${fn:length(detailList)}">
                                <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
                                    <thead>
                                        <tr>
                                            <th class="text-center">成交子明细号</th>
                                            <th class="text-center">成交单位</th>
                                            <th class="text-center">仓房编号</th>
                                            <th class="text-center">交货所属库点</th>
                                            <th class="text-center">粮食品种</th>
                                            <th class="text-center">数量(吨)</th>
                                            <th class="text-center">产地</th>
                                            <th class="text-center">入库年度</th>
                                            <th class="text-center">储存方式</th>
                                            <th class="text-center">成交价格(元/吨)</th>
                                            <th class="text-center">成交金额(元)</th>
                                            <th class="text-center">提货截止时间</th>
                                            <th class="text-center">已付金额(货款)</th>
                                            <th class="text-center">未付金额(货款)</th>
                                            <th class="text-center">已开提货单数量</th>
                                            <th class="text-center">剩余未开数量</th>
                                            <th class="text-center">占用保证金</th>
                                            <th class="text-center">保证金余额</th>
                                            <c:forEach items="${processTypes}" var="item" varStatus="status">
                                                <th align="center">认领${item.value}</th>
                                                <th align="center">未认领${item.value}</th>
                                            </c:forEach>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${detailList}" var="item">
                                            <tr class="text-center active">
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

                                </TABLE>
                            </td>
                        </tr>
                    </TABLE>
                </td>
            </tr>
            <%--<tr>
                <td>
                    <TABLE width="100%" align="center" sheetName="3">
                        <tr><td colspan="9">统计负责人：${reportMain.manager}</td><td colspan="6">填表人：${userInfo.name}</td><td>填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
                    </TABLE>
                </td>
            </tr>--%>
        </TABLE>
    </BODY>
</HTML>

