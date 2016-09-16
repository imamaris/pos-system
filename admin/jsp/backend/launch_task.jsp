<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>

<% MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE); %>

<html>
<head>

<%@ include file="/lib/header.jsp"%>
</head>
<body>
 
<form name="selecttask" action="<%=Sys.getControllerURL(BackendTaskManager.TASKID_BACKEND_SELECTTASK,request)%>" method="post">

<div class="functionhead"><i18n:label code="TASK_LAUNCH"/></div>

<br>
	
<%@ include file="/general/mvc_return_msg.jsp"%>

<table class="listbox" width=400>
	<tr>
	 	<td width="100" class="odd"><i18n:label code="TASK_SELECT"/></td>
	 	<td>
	 		<select name="countryid">
	 			 <%@ include file="/common/select_backendtasks.jsp"%>
	   		</select>
	 	</td>
	 </tr> 
</table>


 
<table width=400 border="0" cellspacing="0" cellpadding="0" >
 <tr><td>&nbsp</td></tr>
 <tr><td align="center"><input type="submit" value="<i18n:label code="GENERAL_BUTTON_LAUNCH"/>" onclick="return confirmSubmit()"></td></tr>
</table>

</form>

 </body>
 
</html>
