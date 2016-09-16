<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
</head>

 <%
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BackendTaskConfigBean conf = (BackendTaskConfigBean) returnBean.getReturnObject("task");
	ParameterBean[] params = conf.getParameters();
	boolean canRun = conf != null;
	boolean haveParameters = params != null;
%>

<body>
<form action="<%=Sys.getControllerURL(BackendTaskManager.TASKID_BACKEND_LAUNCH_NEW_TASK,request)%>" method="post">
<input type="hidden" name="TaskID" value="<%=conf.getTaskID()%>"></td>
<div class="functionhead"><i18n:label code="GENERAL_STEP_2"/> <i18n:label code="GENERAL_OF"/> 2 - <i18n:label code="TASK_ENTER_AND_LAUNCH"/></div>
<br>
<%
	if (canRun)
	{
%>

<table class="listbox">
 <tr>
  <td class="odd"><i18n:label code="TASK_ID"/></td>
  <td><%=conf.getTaskID()%></td>
 </tr>
 <tr>
  <td class="odd"><i18n:label code="TASK_NAME"/></td>
  <td><%=conf.getName()%></td>
 </tr>
</table>

<br>

<% if (haveParameters) { %>

<table class="listbox">
 <tr class="head">
      <td colspan="3"><i18n:label code="TASK_PARAMS"/></td>
 </tr>
 
<% for (int i = 0; i < params.length; i ++) { %>

	 <tr class="<%=((i%2==1)?"odd":"even")%>" >
	  	<td class="odd"><%=params[i].getName()%></td>
	  	
		  <% if (params[i].getSpecialparam() == 0) { %>
		 	 <td><Input type="text" name="<%=params[i].getValue()%>"></td>
		  <% } else { %>
		  	<td><std:input type="select" name="<%=params[i].getValue()%>" options="<%=BackendTaskSpecialParamManager.getSpecialParam(params[i].getSpecialparam())%>" /></td>
		  <% } %>
	  </tr>	
	  
<%	} %>
	

</table>
<br>
<% } // end if have parameters %>

<input type="submit" value="<i18n:label code="GENERAL_BUTTON_LAUNCH"/>">

<% } // end if canRun %>

</form>
</body>
</html>
