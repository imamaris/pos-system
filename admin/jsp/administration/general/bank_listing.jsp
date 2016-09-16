<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BankBean[] beans = (BankBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class=functionhead><i18n:label localeRef="mylocale" code="<%=BankMessageTag.BANK_LISTING%>"/></div><br>

<% if (canView) { %>    
	<table class="listbox" width="70%">
	
		  <tr class="boxhead" valign=top>
			<td width="20"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=BankMessageTag.BANK_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.COUNTRY%>"/></td>
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
					<td><%=beans[i].getCountryID()%></td>
			  </tr>
		  <% } %>		  
	</table>
	<div><br><input type=button name="btnPrint" onClick="window.print();" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>"></div>
<% } // end if canView %>	
	
	</body>
</html>
