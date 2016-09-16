<%@ page import="com.ecosmosis.common.language.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	LanguageBean[] beans = (LanguageBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label localeRef="mylocale" code="<%=LanguageMessageTag.SUPPORTED_LOCALE_LISTING%>"/></div>
 	<form method="post" name=tasklist action="">
    </form>

<% if (canView) { %>    
	<table class="listbox" width="50%">
	
		  <tr class="boxhead" valign=top>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
			<td><i18n:label localeRef="mylocale" code="<%=LanguageMessageTag.LOCALE_ID%>"/></td>
			<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.DESCRIPTION%>"/></td>
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
					<td><%=beans[i].getLocaleStr()%></td>
					<td align="center" nowrap><%=beans[i].getDesc()%></td>
					<td align="center"><%=beans[i].getStatus()%></td>

			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
