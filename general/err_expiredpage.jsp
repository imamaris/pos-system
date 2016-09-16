<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%
   String group  = (String)request.getParameter("gp");
   String URL = null;
   
   if (group != null)
   {
	   try 
	   {
			int type = Integer.parseInt(group);
			if (type >= SystemConstant.OUTLET_USER)	
				URL = "http://" + request.getHeader("host")+ request.getContextPath() + "/admin/";
			else if (type >= SystemConstant.STOCKIST_USER)
				URL = "http://" + request.getHeader("host")+ request.getContextPath() + "/stockist/";
			else if (type >= SystemConstant.COURIER_USER)
				URL = "http://" + request.getHeader("host")+ request.getContextPath() + "/courier/";
			else if (type >= SystemConstant.NORMAL_USER)
				URL = "http://" + request.getHeader("host")+ request.getContextPath() + "/member/";
   		}
   		catch (Exception e) {}
   }   
%>

<%@ include file="/lib/header_no_auth.jsp"%>

<% if (URL != null) { %>
<META HTTP-EQUIV="refresh" CONTENT="5;URL=<%=URL%>"> 	
<% } %>

<html>
	<head>
	<title>Session Expired</title>

	</head>

<body>

	<br>
	<table width="471" border="0" cellspacing="0" cellpadding="1" align="center">
	  <tr>
	    <td>
	      <table width="100%" border="0" cellspacing="0" cellpadding="3" bgcolor="#FFFFFF">
	        <tr class=head>
	          <td>
	            <p><font face="Arial" size="2"><b><font color="#FFFFFF">
	            Session Expired
	              </font></b></font></p>
	            </td>
	        </tr>
					<tr><td>&nbsp;</td></tr>
	        <tr>
	          <td align="left">
	          <font face="Arial" size="2">
	             Your Access is denied due to one of the following reasons:
	            <br>1) Your session has been idled for more than 30 minutes.
	            <br>2) You have not loginned into the system.
	            <br>3) You have not been granted ACCESS RIGHT to use the system.
	          </td>
	        </tr>
	        <br>
	        <tr>
	          <td align="left">
	            <font face="Arial" size="2">
	            <% if (URL != null) { %>
	          	You will be redirected to the <a class="extra" href='<%=URL%>'>Login Page</a> in 5s.
	          	<% } %>
	          	</font>
	          </td>
	        </tr>
	        
	      </table>
	    </td>
	  </tr>
	</table>
	</body>
</html>
