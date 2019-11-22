<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
<style type="text/css">
td{
text-align: center;
}
</style>
<head>
<meta http-equiv="Content-Type"
		content="application/ms-excel; charset=utf-8">
</head>

	<!-- layui静态表格 -->
	<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="80%" align="center" class="table_border01">
		<thead>
		    <tr>
           
              <td style="border-style:none; text-align: center" colspan="5">检查发现问题反馈表</td>
            </tr>
            <tr>
            <c:if test="${ empty storeFeedBack.enterpriseName }">
			
			  <td style="border-style:none" colspan="3">被检查库点(盖章):${storeFeedBack.storehouse}</td>
			</c:if>
			<c:if test="${not empty storeFeedBack.enterpriseName }">
			   <td style="border-style:none" colspan="3">被检查库点(盖章):${storeFeedBack.enterpriseName}</td>		
			</c:if>		
          
            <td style="border-style:none" colspan="2">填表时间：${storeFeedBack.reportDate}</td>


            </tr>
		     
			<tr>
				<td style=" text-align: center">序号</td>
				<td style=" text-align: center">问题类别</td>
				<td style=" text-align: center">检查发现问题及详细情况描述</td>
				<td style=" text-align: center" >整改建议</td>
				<td style=" text-align: center">整改情况</td>
				
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${storeFeedBackDeatils}" var="item" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${item.type}</td>
					<td>${item.description}</td>
					<td>${item.advise}</td>
					<td>${item.rectification}</td>
					
				</tr>
			</c:forEach>
		</tbody>
		       <tr>
                <td style="border-style:none" colspan="2">被检查库点:</td>
                <td style="border-style:none; text-align: center" colspan="2">检查人员:</td>
                <td style="border-style:none" colspan="2">检查组负责人检查:</td>
               
                </tr>
                 <tr>
                <td style="border-style:none" colspan="2">负责人（签字）:</td>
                <td style="border-style:none; text-align: center" colspan="2">（签字）:</td>
                <td style="border-style:none" colspan="2">确认（签字）:</td>
               
            </tr>
	</table>
	
	

</HTML>