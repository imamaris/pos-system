<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="java.util.*"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ActionTaskBean bean = (ActionTaskBean) returnBean.getReturnObject("TaskBean");
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

<form name="addtask" action="<%=Sys.getControllerURL(ActionTaskManager.TASKID_TASK_AUDITLOG_UPDATE_SUBMIT,request)%>" method="post">
<input type="hidden" name="taskid" value="<%=bean.getTaskID()%>" %>

<div class="functionhead">UPDATE AUDIT LOG SETTINGS</div>
</table>

<%@ include file="/general/mvc_return_msg.jsp"%>
	
<br>
<table class="listbox" width="70%">
	 <tr>
	 	<td width="168" class="odd">Task ID</td>
	 	<td><%=bean.getTaskID()%></td>
	 </tr>
 	 <tr>
	 	<td width="168" class="odd">Description</td>
	 	<td><%=bean.getDescription()%></td>
	 </tr>
	 
     <tr>
	 	<td width="168" class="odd">Log Level</td>
	 	<td><std:input type="select" name="loglevel" options="<%=viewtype%>" value="<%=bean.getLoglevel()%>"/></td>
	 </tr>
	 
	 <tr>
	 	<td width="168" class="odd" nowrap>Log Params<br>(FULL Level Above)</td>
	 	<td><std:input type="text" name="logparams" value="<%=bean.getLogParams()%>"  size="80"/></td>
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