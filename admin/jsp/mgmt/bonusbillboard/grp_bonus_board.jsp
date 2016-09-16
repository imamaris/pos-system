<%@ page import="com.syscatech.constant.SupportedLocale"%>
<%@ page import="com.syscatech.mvc.sys.*"%>
<%@ page import="com.syscatech.language.*"%>
<%@ page import="com.syscatech.mvc.authentication.*"%>
<%@ page import="java.util.*"%>
<%
	String mesg = (String) request.getAttribute("Error");
	boolean hasMesg = mesg!=null;
%>
<html>
<head>
 <title><%= Sys.getAPP_NAME() %></title>
  <%@ include file="/jsp/lib/header.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
<!--

function warning() {
    var thisform = window.document.login;
}

//-->
</SCRIPT>
  
</head>
 <body onLoad="self.focus();document.login.Aid.focus();">
 <center>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <form name="login" action="<%=Sys.getControllerURL(HttpAuthenticationManager.ADMIN_LOGIN,request)%>" method="post">
  <div align=center><img border=0 src="<%=Sys.getWebapp()%>/img/logo.gif"></div>
 <table border=1 bordercolor="#000000 " cellspacing=1 cellpadding=1 align=center >
 <tr><td>
 <table cellpadding="1">
  <tr class="head">
   <td colspan="3"><%= Sys.getAPP_NAME() %> Administrator Login</td>
  </tr>
  <tr>
   <td>Language</td>
   <td>:</td>
   <td>
    <select name="locale">
    <%
			Locale[] locales = SupportedLocale.getLocales();
			for (int i=0; i < locales.length; i++) {
			     
                             String selectedStr = "";
			     if(SupportedLocale.DEFAULT_LOCALE == locales[i])
			         selectedStr = "selected";
     %>
	  <option value="<%=locales[i].toString()%>" <%=selectedStr%> ><%= locales[i].getDisplayLanguage(locales[i]) %></option>
     <% } %>
    </select>
   </td>
  </tr>
  <tr>
   <td>User ID</td>
   <td>:</td>
   <td><input type="text" name="Aid" value="kokkean"></td>
  </tr>
  <tr>
   <td>Password</td>
   <td>:</td>
   <td><input type="password" name="Password" value="comdot"></td>
  </tr>
  <tr>
   <td align=right colspan="2">&nbsp;</td>
   <td align=left>
   	 <input type="hidden" name="agp" value="<%= HttpAuthenticationManager.ADMIN_USER %>">
	   <input type="submit" value="LOGIN" onclick="return warning()">
	   <input type="reset" value="RESET">
   </td>
  </tr>
 </table>
  </td></tr>
  </table>
 </form>
  <% if (hasMesg) { %>
                  <p>
                  <div> <font color="red" face="Verdana" size="2"><%=mesg %></font>
                  </p>
                  </div>
                  <% } %>
 </center>
 </body>
</html>