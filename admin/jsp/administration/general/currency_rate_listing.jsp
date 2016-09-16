<%@ page import="com.ecosmosis.common.currency.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	CurrencyRateBean[] beans = (CurrencyRateBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Currency Rate Listing</div>
	<br>

<% if (canView) { %>    
	<table class="listbox" width="600">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td>Rate ID</td>
                        <td>Exchange Rate</td>
			<td>Start Date</td>
			<td>End Date</td>
		  </tr>

		   <% for (int i=0;i<beans.length;i++) { 
			    String rowCss = "";
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
		  %>
			   <tr class="<%=rowCss%>" valign=top>
					<td align="center"><%=i+1%></td>
                                        <td align ="center"><%=beans[i].getCode()%></td>
					<td align ="center"><%=beans[i].getSymbol()%></td>
					<td align ="center"><%=beans[i].getStartdate()%></td>
                                        <td align ="center"><%=beans[i].getEnddate()%></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
