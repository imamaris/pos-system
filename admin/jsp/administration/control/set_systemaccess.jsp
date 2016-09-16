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
		
	TreeMap onOffType = (TreeMap) returnBean.getReturnObject("OnOffList");
	
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

<form name="addtask" action="<%=Sys.getControllerURL(SystemConstantManager.TASKID_ADMIN_CONTORL_SYSTEMACCESS,request)%>" method="post">
<input type="hidden" name="userid" value="<%=userid%>" %>

<div class="functionhead">SYSTEM ACCESS CONTROL CENTER</div>
</table>
<br>
<%@ include file="/general/mvc_return_msg.jsp"%>
<br>	

<table class="listbox" width="75%">
	 <tr>
	 	<td width="200" class="odd">Admin Area Access</td>
	 	<td><std:input type="select" name="adminaccess" options="<%=onOffType%>" value="<%=Integer.toString(SystemConstant.ACCESS_ADMINISTRATION_SYSTEM)%>" /></td>
	 	<td><textarea name="adminaccessmsg" rows="2" cols="50"><%=SystemConstant.ACCESS_ADMINISTRATION_SYSTEM_MESSAGE%></textarea></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Stockist Area Access</td>
	 	<td><std:input type="select" name="stockistaccess" options="<%=onOffType%>" value="<%=Integer.toString(SystemConstant.ACCESS_STOCKIST_SYSTEM)%>" /></td>
	 	<td><textarea name="stockistaccessmsg" rows="2" cols="50"><%=SystemConstant.ACCESS_STOCKIST_SYSTEM_MESSAGE%></textarea></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">Distributor Area Access</td>
	 	<td><std:input type="select" name="memberaccess" options="<%=onOffType%>" value="<%=Integer.toString(SystemConstant.ACCESS_MEMBER_SYSTEM)%>" /></td>
	 	<td><textarea name="memberaccessmsg" rows="2" cols="50"><%=SystemConstant.ACCESS_MEMBER_SYSTEM_MESSAGE%></textarea></td>
	 </tr>
	 <tr>
	 	<td width="200" class="odd">System Annoucement</td>
	 	<td colspan="2"><textarea name="annoucement" rows="8" cols="50"><%=SystemConstant.ACCESS_SYSTEM_ANNOUCEMENT_CONTENT%></textarea></td>
	 </tr>
</table>

 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="SET" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>