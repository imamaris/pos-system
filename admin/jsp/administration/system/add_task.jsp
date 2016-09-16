<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	TreeMap viewtype = (TreeMap) returnBean.getReturnObject("ViewTypeList");
%>

<html>
<head>
<script LANGUAGE="JavaScript">
<!--
function confirmSubmit()
{
	var agree=confirm("Confirm ?");
	if (agree)
		return true ;
	else
		return false ;
}
// -->
</script>

 
<%@ include file="/lib/header.jsp"%>

</head>
 <body>

<form name="addtask" action="<%=Sys.getControllerURL(ActionTaskManager.TASKID_ADD_NEW_TASK,request)%>" method="post">
 
<div class="functionhead">ADD NEW TASK</div>
</table>

<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width="80%">
	 <tr>
	 	<td width="168" class="odd">Task ID</td>
	 	<td><input type="text" name="taskid" value="" size="6" maxlength="6"></td>
	 </tr>
 	 <tr>
	 	<td width="168" class="odd">Description</td>
	 	<td><input type="text" name="description" value="" size="70" maxlength="200"></td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Manager Class Name</td>
	 	<td><input type="text" name="classname" value="" size="70" maxlength="200"></td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Access Group</td>
	 	<td>
	 		<select name="accessgroup">
	 		
				<option value="80">Admin</option>
				<option value="100">Super Admin</option>
				<option value="0">Open</option>
				<option value="10">Member</option>
	   		</select>
	 	</td>
	 </tr> 
     <tr>
	 	<td width="168" class="odd">Check ACL</td>
	 	<td>
	 		<select name="acl">
				<option value="1">YES</option>
				<option value="0">NO</option>
	   		</select>
	 	</td>
	 </tr> 
	 <tr>
	 	<td width="168" class="odd">Sensitivity</td>
	 	<td>
	 		<select name="sensitivity">
	 			<option value="0">NO</option>
				<option value="1">YES</option>
	   		</select>
	 	</td>
	 </tr> 
 	<tr>
	 	<td width="168" class="odd">Process Method</td>
	 	<td>
	 		<select name="processmethod">
	 			<option value="1">MVC Manager</option>
	   		</select>
	 	</td>
	 </tr> 
     <tr>
	 	<td width="168" class="odd">Log Level</td>
	 	<td><std:input type="select" name="loglevel" options="<%=viewtype%>"/></td>
	 </tr>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Succ Ret Method</td>
	 	<td>
	 		<select name="succmethod">
	 			<option value="1">JSP Forward</option>
				<option value="2">Send Redirect</option>
				<option value="3">Send Redirect to Another Task</option>
				<option value="6">JSP Forward to Another Task</option>
				<option value="4">Default Msg Page - Forward</option>
				<option value="5">Default Msg Page - Redirect</option>
	   		</select>
	 	</td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Succ Ret Path</td>
	 	<td><input type="text" name="succpath" value="" size="70" maxlength="200"></td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Fail Ret Method</td>
	 	<td>
	 		<select name="failmethod">
	 			<option value="1">JSP Forward</option>
				<option value="2">Send Redirect</option>
				<option value="3">Send Redirect to Another Task</option>
				<option value="6">JSP Forward to Another Task</option>
				<option value="4">Default Msg Page - Forward</option>
				<option value="5">Default Msg Page - Redirect</option>
	   		</select>
	 	</td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Fail Ret Path</td>
	 	<td><input type="text" name="failpath" value="" size="70" maxlength="200"></td>
	 </tr>
		
	  <tr>
	 	<td width="168" class="odd">Next Action Method</td>
	 	<td>
	 		<select name="nextmethod">
	 			<option value="1">JSP Forward</option>
				<option value="2">Send Redirect</option>
				<option value="3">Send Redirect to Another Task</option>
				<option value="6">JSP Forward to Another Task</option>
				<option value="4">Default Msg Page - Forward</option>
				<option value="5">Default Msg Page - Redirect</option>
	   		</select>
	 	</td>
	 </tr>
	 <tr>
	 	<td width="168" class="odd">Next Action Path</td>
	 	<td><input type="text" name="nextpath" value="" size="70" maxlength="200"></td>
	 </tr>
	 	
</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="ADD" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
</html>