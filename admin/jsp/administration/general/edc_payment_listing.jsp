<%@ page import="com.ecosmosis.common.cardpayment.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	CardPaymentBean[] beans = (CardPaymentBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Credit Card Payment Type</div>
	<br>

<% if (canView) { %>    
	<table class="listbox" width="60%">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td>Code</td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
		  </tr>

		   <% for (int i=0;i<beans.length;i++) { 
			    String rowCss = "";
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
		  %>
			   <tr class="<%=rowCss%>" valign=top>
					<td><%=i+1%></td>
					<td align ="center"><%=beans[i].getSymbol()%></td>
					<td align ="center"><%=beans[i].getName()%></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
