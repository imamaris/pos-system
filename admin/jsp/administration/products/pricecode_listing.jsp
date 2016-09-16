<%@ page import="com.ecosmosis.orca.pricing.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	PriceCodeBean[] beans = (PriceCodeBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE_LISTING%>"/></div>

<table><tr><td height="10"></td></tr></table>

<% if (canView) { %>    
	<table class="listbox" width="500">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.PRICE_CODE%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.CURRENCY%>"/></td>
			<!--
			<td><i18n:label localeRef="mylocale" code="<%=PricingMessageTag.CONTROL_LOCATION%>"/></td>
			-->
			<td><i18n:label code="GENERAL_TYPE"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.STATUS%>"/></td>
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
					<td><%=beans[i].getPriceCodeID()%></td>
					<td><%=beans[i].getName()%></td>
					<td align="center"><%=beans[i].getCurrency()%></td>
					<!--
					<td align="center"><%=beans[i].getLocationID()%></td>
					-->
					<td align="center"><%=beans[i].getType()%></td>
					<td align="center"><%=beans[i].getStatus()%></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
