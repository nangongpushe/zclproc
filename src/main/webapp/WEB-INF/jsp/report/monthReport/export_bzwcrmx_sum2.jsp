<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
    <head>
        <meta http-equiv="Content-Type"
              content="application/ms-excel; charset=utf-8"/>
        <style>
            #content td,th{
            text-align:center;
            }
            .title{
            font-size:18px;
            text-align:center;
            font-weight:bold;
            }
        </style>
    </head>
    <BODY class="body_MarginLR10px" style="margin-right:0px;">
        <TABLE width="100%" align="center">
            <tr>
                <td>
                    <TABLE width="100%" align="center">
                        <tr><td colspan="18" class="title">库存包装物出入库明细汇总表</td></tr>
                        <tr style="color:blue"><td colspan="9">统计汇总：浙江</td><td style='mso-number-format:"\@"' colspan="6">${reportMonth}</td><td colspan="3">单位：条</td></tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
                        <tr>
                            <td class="td_white" colspan="17">
                                <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
                                    <thead>
                                        <%--<tr>
                                            <th  class="text-center">序号</th>
                                            <th  class="text-center">单位名称</th>
                                            <c:forEach items='${fields["稻谷"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["小麦"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["油类"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                        </tr>--%>
                                            <tr>
                                                <th rowspan="2" class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">库点名称</th>
                                                <th rowspan="2" class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">日期</th>
                                                <th colspan="4" class="text-center">上期库存</th>
                                                <th colspan="4" class="text-center">收入</th>
                                                <th colspan="4" class="text-center">支出</th>
                                                <th colspan="4" class="text-center">结余库存</th>
                                                <th rowspan="2" class="text-center">备注</th>
                                            </tr>
                                            <tr>
                                                <th class="text-center">标新</th>
                                                <th class="text-center">标旧</th>
                                                <th class="text-center">杂袋</th>
                                                <th class="text-center">废袋</th>
                                                <th class="text-center">标新</th>
                                                <th class="text-center">标旧</th>
                                                <th class="text-center">杂袋</th>
                                                <th class="text-center">废袋</th>
                                                <th class="text-center">标新</th>
                                                <th class="text-center">标旧</th>
                                                <th class="text-center">杂袋</th>
                                                <th class="text-center">废袋</th>
                                                <th class="text-center">标新</th>
                                                <th class="text-center">标旧</th>
                                                <th class="text-center">杂袋</th>
                                                <th class="text-center">废袋</th>
                                            </tr>
                                    </thead>
                                    <tbody>
                                            <c:forEach items="${bzwcrmxList}" var="bzwcrmx">
                                                <tr class="text-center active">
                                                    <td>${bzwcrmx.reportWarehouse}</td><td>${bzwcrmx.reportWarehouse}</td>
                                                    <td>${bzwcrmx.detailDate}</td><td>${bzwcrmx.priorNew}</td>
                                                    <td>${bzwcrmx.priorOld}</td><td>${bzwcrmx.priorMixed}</td>
                                                    <td>${bzwcrmx.priorWaste}</td><td>${bzwcrmx.incomeNew}</td>
                                                    <td>${bzwcrmx.incomeOld}</td><td>${bzwcrmx.incomeMixed}</td>
                                                    <td>${bzwcrmx.incomeWaste}</td><td>${bzwcrmx.expendNew}</td>
                                                    <td>${bzwcrmx.expendOld}</td><td>${bzwcrmx.expendMixed}</td>
                                                    <td>${bzwcrmx.expendWaste}</td><td>${bzwcrmx.balanceNew}</td>
                                                    <td>${bzwcrmx.balanceOld}</td><td>${bzwcrmx.balanceMixed}</td>
                                                    <td>${bzwcrmx.balanceWaste}</td><td>${bzwcrmx.remark}</td>
                                                </tr>
                                            </c:forEach>
                                    </tbody>
                                </TABLE>
                            </td>
                        </tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE width="100%" align="center">
                        <tr><td colspan="9">审核：</td><td colspan="6">统计：${reportMain.manager}</td><td colspan="3">填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
                    </TABLE>
                </td>
            </tr>
        </TABLE>
    </BODY>
</HTML>


