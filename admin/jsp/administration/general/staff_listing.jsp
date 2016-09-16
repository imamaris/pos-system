<%@ page import="com.ecosmosis.common.staff.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StaffBean[] beans = (StaffBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class=functionhead>Salesman Listing</div><br>

<% if (canView) { %>    
	<table class="listbox" width="70%">
	
		  <tr class="boxhead" valign=top>
			<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td width="15%">Salesman ID</td>
			<td width="15%">Name</td>
			<td width="15%">Mobile No.</td>
                        <td width="30%">Address</td>
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
					<td><%=beans[i].getBankID()%></td>
					<td><%=beans[i].getName()%></td>
					<td><%=beans[i].getSwiftCode()%></td>
                                        <td><%=beans[i].getOtherName()%></td>
			  </tr>
		  <% } %>		  
	</table>
	<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
