<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>

<%@ include file="/lib/header_no_auth.jsp"%>

<html>
<head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
%>

<table>
 <tr class="head">
  <td><b>Message</b></td>
 </tr>
 
<tr>
  <td>&nbsp;</td>
</tr>
  
 
<% if (returnBean != null) { 

	String displayMsg = returnBean.getSysMessage();	
	
%>

<tr>
  <td><%=displayMsg%></td>
</tr>

<% } else { %>
 
<tr>
  <td>Error Occured. System Msg Code NOT DEFINED !!!</td>
</tr>

<% } %>
 
</table>
</body>
</html>
