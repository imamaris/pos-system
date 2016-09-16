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
		
	TreeMap viewtype = (TreeMap) returnBean.getReturnObject("ViewTypeList");
	TreeMap onOffType = (TreeMap) returnBean.getReturnObject("TurnOnOffList");
	
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

<form name="addtask" action="<%=Sys.getControllerURL(SystemConstantManager.TASKID_ADMIN_CONTORL_LOGLEVEL ,request)%>" method="post">
<input type="hidden" name="userid" value="<%=userid%>" %>

<div class="functionhead">SET SYSTEM MESSAGE LOG</div>
</table>
<br>
<%@ include file="/general/mvc_return_msg.jsp"%>
<br>	

<table class="listbox" width="75%">
	 <tr>
	 	<td width="200" class="odd">Log LEVEL </td>
	 	<td><std:input type="select" name="setloglevel" options="<%=viewtype%>" value="<%=SystemConstant.LOGLEVEL_SYSTEMLEVEL%>"/></td>
	 </tr>
	 
	 <tr>
	 	<td width="200" class="odd">Speed Text Log</td>
	 	<td><std:input type="select" name="logadmin" options="<%=onOffType%>" /></td>
	 		 </tr>
	 
	 <tr>
	 	<td colspan="2"><I><font size="1">
	 	** Please take note that system performance will be substantially affected with High Level of Log Level.
	 	<br>** Please use this function carefully. 
	 	</font></I></td>
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