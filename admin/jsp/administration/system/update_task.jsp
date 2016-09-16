<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ActionTaskBean bean = (ActionTaskBean) returnBean.getReturnObject("TaskBean");
	TreeMap statustype = (TreeMap) returnBean.getReturnObject("TaskStatusList");
	TreeMap usertype = (TreeMap) returnBean.getReturnObject("UserTypeList");
	TreeMap acltype = (TreeMap) returnBean.getReturnObject("CheckACLList");
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

<form name="addtask" action="<%=Sys.getControllerURL(ActionTaskManager.TASKID_UPDATE_TASK_SUBMIT,request)%>" method="post">
<input type="hidden" name="taskid" value="<%=bean.getTaskID()%>" %>

<div class="functionhead">UPDATE TASK </div>
</table>

<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width="70%">
	 <tr>
	 	<td width="300" class="odd">Task ID</td>
	 	<td><%=bean.getTaskID()%></td>
	 </tr>
	 
 	 <tr>
	 	<td width="300" class="odd">Description</td>
	 	<td><std:input type="text" name="description" value="<%=bean.getDescription()%>"  size="50" maxlength="200"/></td>
	 </tr>
	 
	  <tr>
	 	<td width="300" class="odd">Manager Class Name</td>
	 	<td><std:input type="text" name="classname" value="<%=bean.getClassName()%>"  size="80" maxlength="200"/></td>
	 </tr>
	 
	 <tr>
	 	<td width="200" class="odd">Access Group Level</td>
	 	<td><std:input type="select" name="accessgroup" options="<%=usertype%>" value="<%=bean.getAccessGroupLevel()%>"/></td>
	 </tr> 

	 <tr>
	 	<td width="200" class="odd">Check ACL</td>
	 	<td><std:input type="select" name="acl" options="<%=acltype%>" value="<%=bean.getAuthACL()%>"/></td>
	 </tr> 
	 
     <tr>
	 	<td width="300" class="odd">Task Status</td>
	 	<td><std:input type="select" name="taskstatus" options="<%=statustype%>" value="<%=bean.getStatus()%>"/></td>
	 </tr>

</table>


 
<table width=500 border="0" cellspacing="0" cellpadding="0" >
  <tr><td>&nbsp</td></tr>
 <tr><td>&nbsp</td></tr>
 <tr class="head"><td align="center"><input type="submit" value="UPDATE"></td></tr>
</table>

</form>

 </body>
</html>