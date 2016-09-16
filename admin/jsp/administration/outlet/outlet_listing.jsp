<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	OutletBean[] beans = (OutletBean[]) returnBean.getReturnObject("OutletList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead">Boutique Listing</div>
	
	<table><tr><td height="10"></td></tr></table>
	
<% if (canView) { %>    
	<table class="listbox" width="40%">
	
		  <tr class="boxhead" valign=top>
			<td width="20" align=right><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td >Boutique ID</td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
		  </tr>

		   <% for (int i=0;i<beans.length;i++) { 
			   String rowCss = "";
	  		  	
	  		  	if((i+1) % 2 == 0)
	  	      		rowCss = "even";
	  	      	else
	  	        	rowCss = "odd";
		  %>
			   <tr class="<%=rowCss%>" valign=top align="center">
					<td align=right><%=i+1%>.</td>
					<td><%=beans[i].getOutletID()%></td>
					<td><%=beans[i].getName()%></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
