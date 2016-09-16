<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.accesscontrol.user.LoginUserBean"%>
<%@ page import="com.ecosmosis.mvc.authentication.HttpAuthenticationManager"%>
<%@ page import="java.util.*"%>

<%@ include file="/lib/header.jsp"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	String userid = "";
	if (loginUser != null)
		userid = loginUser.getUserId();
		
	TreeMap yesNoType = (TreeMap) returnBean.getReturnObject("YesNoList");
	
%>

<html>
<head>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("Are you SURE about this ?");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script>

 

</head>
 <body>

<form name="addtask" action="<%=Sys.getControllerURL(SystemConstantManager.TASKID_ADMIN_CONTORL_RESETPARAMETERS,request)%>" method="post">
<input type="hidden" name="userid" value="<%=userid%>" %>

<div class="functionhead">RESET SYSTEM DATA</div>
</table>
<br>
<%@ include file="/general/mvc_return_msg.jsp"%>
<br>	

<table class="listbox" width="50%">
	 <tr>
	 	<td width="300" class="odd">Bank Info</td>
	 	<td><std:input type="select" name="resetbank" options="<%=yesNoType%>" /></td>
	 </tr>

<% if (loginUser.getUserGroupType() >= SystemConstant.ADMIN_USER) { %>	 	 	 	 
	 <tr>
	 	<td width="300" class="odd">Language</td>
	 	<td><std:input type="select" name="resetlang" options="<%=yesNoType%>" /></td>
	 </tr>
	 <tr>
	 	<td width="300" class="odd">Currency</td>
	 	<td><std:input type="select" name="resetcurrency" options="<%=yesNoType%>" /></td>
	 </tr>
<% }  %>
	 
	 <tr>
	 	<td width="300" class="odd">Location</td>
	 	<td><std:input type="select" name="resetlocation" options="<%=yesNoType%>" /></td>
	 </tr>
	 <tr>
	 	<td width="300" class="odd">Locale Messages</td>
	 	<td><std:input type="select" name="resetlocale" options="<%=yesNoType%>" /></td>
	 </tr>

	 
<% if (loginUser.getUserGroupType() >= SystemConstant.ADMIN_USER) { %>	 
	 <tr>
	 	<td width="300" class="odd">System Parameters</td>
	 	<td><std:input type="select" name="resetsysparam" options="<%=yesNoType%>" /></td>
	 </tr>
	 <tr>
	 	<td width="300" class="odd">Action Task</td>
	 	<td><std:input type="select" name="resettask" options="<%=yesNoType%>" /></td>
	 </tr>
<% }  %>

</table>

 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="RESET" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>