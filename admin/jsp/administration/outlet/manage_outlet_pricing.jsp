<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.pricing.*"%>
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
	<div class=functionhead>Outlet Listing</div><br>

<% if (canView) { %>    
	<table class="listbox" width="600">
	
		  <tr class="boxhead" valign=top>
			<td width="20">No.</td>
			<td>Outlet ID</td>
			<td>Price Code</td>
			<td>Type</td>
			<td>Name</td>
			<td>Currency</td>			
		  </tr>

		   <% 
		   	for (int i=0;i<beans.length;i++) { 
			   	PriceCodeBean[] pbeans = 	beans[i].getPriceCodes();	  
			   	for (int j=0;j<pbeans.length;j++) { 	
				   	String count = "";
				   	String outletid = "";
				   	if (j == 0)
				   	{
					   	count = Integer.toString(i+1);
					   	outletid = beans[i].getOutletID();
				    }
			   	
		  %>
			   <tr class="<%= (j%2 == 0) ? "even" : "odd"%>" valign=top>
					<td><%=count%></td>
					<td><%=outletid%></td>
					<td align="center"><%=pbeans[j].getPriceCodeID()%></td>
					<td align="center"><%=pbeans[j].getTypeName()%></td>
					<td align="center"><%=pbeans[j].getName()%></td>
					<td align="center"><%=pbeans[j].getCurrency()%></td>
			  </tr>
			   <% } %>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
