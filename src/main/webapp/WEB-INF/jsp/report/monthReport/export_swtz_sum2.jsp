<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
    <head>
        <meta http-equiv="Content-Type"
              content="application/vnd.ms-excel; charset=utf-8"/>
        <style type="text/css">
            #content td,th{
            text-align:center;
            }

            .title{
            font-size:18px;
            text-align:center;
            font-weight:bold;
            }

            .green-bold{
            font-weight:bold;
            color:green;
            }
        </style>
    </head>
    <body class="body_MarginLR10px" style="margin-right:0px;">
        <TABLE width="100%" align="center">
            <tr>
                <td>
                    <TABLE width="100%" align="center">
                        <tr>
                            <td colspan="10" class="title">浙江省储备粮管理有限公司省级储备粮台账汇总表</td>
                        </tr>
                        <tr style="color:blue">
                            <td colspan="4">统计汇总：浙江</td>
                            <td style='mso-number-format:"\@"' colspan="4">${reportMonth}</td>
                            <td colspan="2">单位：吨</td>
                        </tr>
                    </TABLE>
                </td>
            </tr>
            <tr>
                <td>
                    <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center"
                           class="table_border01">
                        <tr>
                            <td class="td_white" colspan="10">
                                <TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center"
                                       class="table_border01">
                                    <thead>
                                        <tr>
                                            <th class="text-center">序号</th>
                                            <th class="text-center">单位名称</th>
                                            <c:forEach items='${fields["粮食"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["早籼"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["粳稻谷"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["稻谷"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                            <c:forEach items='${fields["小麦"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>

                                            <c:forEach items='${fields["玉米"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>

                                            <c:forEach items='${fields["油类"] }' var="field">
                                                <th class="text-center">${field }</th>
                                            </c:forEach>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-center"></td>
                                            <td class="text-center" style="color:green;font-weight:bold">合计</td>

                                            <c:forEach items='${fields["粮食"] }' var="field">
                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>

                                            <c:forEach items='${fields["早籼"] }' var="field">
                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>
                                            <c:forEach items='${fields["粳稻谷"] }' var="field">


                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>
                                            <c:forEach items='${fields["稻谷"] }' var="field">


                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>
                                            <c:forEach items='${fields["小麦"] }' var="field">
                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>

                                            <c:forEach items='${fields["玉米"] }' var="field">
                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>

                                            <c:forEach items='${fields["油类"] }' var="field">
                                                <td class="text-center" style="color:green;font-weight:bold">${sumData[field] eq "0" ? "":sumData[field]}</td>
                                            </c:forEach>
                                        </tr>
                                        <c:forEach items="${dataList}" var="data" varStatus="status">
                                            <tr class="text-center active">
                                                <td class="text-center">${status.count }</td>
                                                <td class="text-center">${data.key }</td>

                                                <c:forEach items='${fields["粮食"] }' var="field" varStatus="stat">
                                                    <td class="text-center" style="color:green;font-weight:bold"
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>

                                                <c:forEach items='${fields["早籼"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>
                                                <c:forEach items='${fields["粳稻谷"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>
                                                <c:forEach items='${fields["稻谷"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>
                                                <c:forEach items='${fields["小麦"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>

                                                <c:forEach items='${fields["玉米"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
                                                </c:forEach>

                                                <c:forEach items='${fields["油类"] }' var="field" varStatus="stat">
                                                    <td class="text-center"
                                                            <c:if test="${stat.last}">
                                                                style="color:green;font-weight:bold"
                                                            </c:if>
                                                    >${data.value[field] eq "0" ? "":data.value[field]}</td>
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
            <tr>
                <td>
                    <TABLE width="100%" align="center">
                        <tr>
                            <td colspan="3">审核：</td>
                            <td colspan="4">统计：${reportMain.manager}</td>
                            <td>填报日期：<fmt:formatDate value="${ reportMain.createDate }" pattern="yyyy年MM月dd日"/></td>
                        </tr>
                    </TABLE>
                </td>
            </tr>
        </TABLE>
    </body>
</html>

