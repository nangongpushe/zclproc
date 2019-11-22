<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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


			<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="80%" align="center" class="table_border01">
			
			  
            
				<thead>
					 <tr>
		              <td style="border-style:none; text-align: center" colspan="4">考核评分表</td>
		            </tr>
		             <tr>
		            </tr>
		            <tr>
		            <td style="border-style:none" colspan="2">考评编号:${StoreExamine.examineSerial }</td>
		             <td style="border-style:none" colspan="2">考评名称:${StoreExamine.examineName }</td>
		            </tr>
		          
		            <tr>
		            </tr>
		             <c:if test="${StoreExamine.examineTempletType =='星级粮库'}"> 
				     <tr>
				         <th   colspan="2" style="width: 20%;"><p  style="text-align: center">${data.data.itemName}</p></th>
				         <th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>
				         <th  ><p  style="text-align: center">分数</p></th>
				     </tr>
				    </c:if>
            		 <c:if test="${StoreExamine.examineTempletType !='星级粮库'}"> 
				     <tr>
				         <th   ><p  style="text-align: center">${data.data.itemName}</p></th>
				           <th  ><p  style="text-align: center">分值</p></th>
				         <th  style="width: 70%;"  ><p  style="text-align: center">考核内容</p></th>
				         <th  ><p  style="text-align: center">分数</p></th>
				     </tr>
				    </c:if>
				</thead>
				  <c:if test="${StoreExamine.examineTempletType =='星级粮库'}">      
				  	 <c:forEach var="item" items="${data.data.children}" varStatus="status">
					
		    		<tbody>	 
				 	  <tr>
				 	  <td style="width: 20%;" rowspan="${item.rowspan}">&nbsp;&nbsp;${item.itemName}</td>
				 	  
				 	    <c:forEach var="item1" items="${item.children}" varStatus="status1">
				 	   	    <td rowspan="${fn:length(item1.children)}">&nbsp;&nbsp;${item1.itemName}</td>
				 	   	    
				 	   	       <c:forEach var="item2" items="${item1.children}" varStatus="status2">
				 	   	     
				 	   	       
				 	   	        <c:if test="${status2.index ==0}">
				 	   	       		<td>
										<input type="hidden"  value="${item2.parentId}" />
					 	   	       		<input type="hidden"  value="${item2.itemName}" />
					 	   	       		<input type="hidden"  value="${item2.standard}" />
					 	   	       		&nbsp;&nbsp;${status2.count}&nbsp;&nbsp;${item2.itemName}(${item2.standard}分)
				 	   	       		</td>
		     			  			   <td style="text-align: center";>${item2.point}</td>
		     			  			 
		     			  			  </td>
		     			  			  </tr>
				 	   	         </c:if>
				 	   	         
				 	   	         <c:if test="${status2.index !=0}">
									<tr>
									<td>
										<input type="hidden"  value="${item2.parentId}" />
					 	   	       		<input type="hidden"  value="${item2.itemName}" />
					 	   	       		<input type="hidden"  value="${item2.standard}" />
					 	   	       		&nbsp;&nbsp;${status2.count}&nbsp;&nbsp;${item2.itemName}(${item2.standard}分)
				 	   	       		</td>
		     			  			  <td style="text-align: center";>${item2.point}</td>
		     			  			  </tr>

		   						 </c:if>
				 	   	      </c:forEach>
				 	   
				 	   </c:forEach>
				 	   </tbody>
				 	   </c:forEach>
				 	
				 	   <tbody>	 
				 	  <tr>
				 	  <td  style="text-align: right"; colspan="3">总分</td>
				 	  <td  style="text-align: center"; colspan="1"><span id="alltotal">${StoreExamine.points }</span></td>
				 	  </tr>
				 	  </tbody>
				 	    </table>
				   </c:if>
				   
				   <c:if test="${StoreExamine.examineTempletType !='星级粮库'}">      
				  	 <c:forEach var="item" items="${data.data.children}" varStatus="status">
					
		    		<tbody>	 
				 	  <tr>
				 	  <td style="width: 20%;" rowspan="${item.rowspan}">&nbsp;&nbsp;${item.itemName}</td>
				 	  
				 	    <c:forEach var="item1" items="${item.children}" varStatus="status1">
				 	   	  <%--   <td rowspan="${fn:length(item1.children)}">&nbsp;&nbsp;${item1.itemName}</td> --%>
				 	   	    
				 	   	       <c:forEach var="item2" items="${item1.children}" varStatus="status2">
				 	   	     
				 	   	       
				 	   	        <c:if test="${status2.index ==0}">
				 	   	        <td style="text-align: center">${item2.standard}</td>
				 	   	       		<td>
										<input type="hidden"  value="${item2.parentId}" />
					 	   	       		<input type="hidden"  value="${item2.itemName}" />
					 	   	       		<input type="hidden"  value="${item2.standard}" />
					 	   	       		&nbsp;&nbsp;${status2.count}&nbsp;&nbsp;${item2.itemName}
				 	   	       		</td>
		     			  			   <td style="text-align: center";>${item2.point}</td>
		     			  			 
		     			  			  </td>
		     			  			  </tr>
				 	   	         </c:if>
				 	   	         
				 	   	         <c:if test="${status2.index !=0}">
									<tr>
									  <td style="text-align: center">${item2.standard}</td>
									<td>
										<input type="hidden"  value="${item2.parentId}" />
					 	   	       		<input type="hidden"  value="${item2.itemName}" />
					 	   	       		<input type="hidden"  value="${item2.standard}" />
					 	   	       		&nbsp;&nbsp;${status2.count}&nbsp;&nbsp;${item2.itemName}
				 	   	       		</td>
		     			  			  <td style="text-align: center";>${item2.point}</td>
		     			  			  </tr>

		   						 </c:if>
				 	   	      </c:forEach>
				 	   
				 	   </c:forEach>
				 	   </tbody>
				 	   </c:forEach>
				 	
				 	   <tbody>	 
				 	  <tr>
				 	  <td  style="text-align: right"; colspan="3">总分</td>
				 	  <td  style="text-align: center"; colspan="1"><span id="alltotal">${StoreExamine.points }</span></td>
				 	  </tr>
				 	  </tbody>
				 	    </table>
				   </c:if>
			 
				 	  


<script>




 
	
	
</script>



