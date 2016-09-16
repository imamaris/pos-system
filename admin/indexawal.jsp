<%@ page import="com.ecosmosis.mvc.constant.SupportedLocale"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.authentication.*"%>
<%@ page import="java.util.*"%>

<%@ include file="/lib/header_no_auth.jsp"%>

<%
	String mesg = (String) request.getAttribute("Error");
	boolean hasMesg = mesg!=null;
%>

<html>
<head>
	<title><%= Sys.getAPP_NAME() %></title>

	<script language="JavaScript">
	<!--
	
		function warning() {
			var thisform = window.document.login;
		}
	
	//-->
	</script>
        
<style type="text/css">
<!--
body {
	background-color: #e0feb7;
}
-->
</style>       
</head>

<body onLoad="self.focus();document.login.Aid.focus();">

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
  
<center>
	<form name="login" action="<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_LOGIN,request)%>" method="post">
	<table cellSpacing=0 cellPadding=0 align=center border=1 background="<%=Sys.getWebapp()%>/img/login_bg.jpg">
		<tr>
	    <td align="center">
	    	<img height="65" src="<%=Sys.getWebapp()%>/img/logo_chi.jpg">
	    </td>
	  </tr>
	  <tr>
		  <td valign="top" align="center">
		    <table cellSpacing="0" cellPadding="5" width="280" border="0">
	        <tr>
						<td class="loginhead" colSpan="2" height="25" align="center"><b><%= Sys.getAPP_NAME() %><br>Administrator Login</b></td>
					</tr>
	        
<!-- 
	        <tr>
	          <td height="25" align="right" nowrap>Language Preference:</td>
	          <td>
						  <select name="locale">
						  <%						  
						  		Locale[] locales = SupportedLocale.getLocales();
								for (int i=0; i < locales.length; i++) {
							%>
						  <option value="<%=locales[i].toString()%>" <%=(locales[i] == Locale.CHINA)? "" : "selected" %> > <%= locales[i].getDisplayLanguage(locales[i]) %></option>
							<% } %>
						  </select>
					 	</td>
				 	</tr>
//-->				 	
	        <tr>
	          <td height="25" align="right">User ID:</td>
	          <td><std:input type="text" name="Aid" maxlength="15" value="" /></td> 
	        <tr>
	          <td height="25" align="right">Password:</td>
	          <td><input type="password" name="Password" value=""></td>
	        </tr>
	        <tr>
					  <td align=right colspan="1">&nbsp;</td>
					  <td align=left>
					    <input type="submit" value="Login" onclick="return warning()">
					    <input type="reset" value="Reset">
					  </td>
					</tr>
					<tr>
				    <td colspan="2">&nbsp;</td>
				  </tr>    
		  	</table>
		  </td>
	  </tr>
	</table>
	<br>
	<br>
	<%@ include file="/general/mvc_return_msg.jsp"%>
	</form>
	
</center>

</body>
</html>


