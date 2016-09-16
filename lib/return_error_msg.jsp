<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>

<%
	if (returnBean != null && returnBean.hasErrorMessages()) {
%>

<table width="500">
  <tr>
		<td><img border="0" src="<%= Sys.getWebapp() %>/img/problem.gif"</td>
	<tr>	
	
	<%
		MvcMessage[] errors = returnBean.getErrorMessages();
		
		for (int i=0; i<errors.length; i++) {
			
		  MvcMessage error = errors[i];	
	%>	
	<tr class="error note">
		<td>!!! <%= error.getMessage() %></td>
	</tr>
	<%
		} // end for
	%>
</table>

<br>

<hr>

<br>

<%
	} // end hasErrorMessages
%>

