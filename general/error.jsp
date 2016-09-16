<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.messages.*"%>
<%@ page import="java.sql.SQLException"%>

<%@ include file="/lib/header_no_auth.jsp"%>

<html>
<head>
 <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body>

<%

	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	
	int errorcode = 0;
	String exceptionMsg = "";
	boolean hasException = false;
	
	if (returnBean != null && returnBean.getException() != null)
	{
		hasException = true;
		Exception e = returnBean.getException();
		if (e instanceof SQLException) {
			SQLException sqle = (SQLException) e;
			errorcode = sqle.getErrorCode();
		}
		
		if (errorcode == 1062)  
		{   
			exceptionMsg = "Similar Record alrady exists !!! <br>"+"Error Code is "+errorcode+"<br>"+returnBean.getException().getMessage();
		}		
		else
			exceptionMsg = returnBean.getException().getMessage();
			
	} // if returnBean not null	
	
		
%>

<table>
 <tr class="head">
  <td><b>System Error Message ORCA</b></td>
 </tr>
 
<tr>
  <td>&nbsp;</td>
</tr>
  
 
<% if (returnBean != null) { 

	String displayMsg = "";
	
	if (hasException)
	{
		displayMsg = exceptionMsg;
	}
	else if (returnBean.hasErrorMessages())
	{
		StringBuffer buf = new StringBuffer();
		MvcMessage[] msgs = (MvcMessage[]) returnBean.getErrorMessages();
		
		for (int i=0;i < msgs.length;i++)
		{
			MessageBean msg = lang.getMessageBean(msgs[i].getMessage());
			buf.append(msg.getMessage());
		}
		displayMsg += "<br>"+buf.toString();
	}	
	if (returnBean.getSysError() != null)
		displayMsg += "<br>"+returnBean.getSysError();	
	
	
%>

<tr>
  <td><%=displayMsg%></td>
</tr>

<% } else { %>
 
<tr>
  <td>Error Occured. Error Code NOT DEFINED !!!</td>
</tr>

<% } %>


</table>
</body>
</html>
