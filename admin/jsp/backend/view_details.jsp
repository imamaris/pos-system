<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>


<html>
<head>
 <%@ include file="/lib/header.jsp"%>
</head>
 <body>
<%
	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BackendTaskConfigBean conf = (BackendTaskConfigBean) returnBean.getReturnObject("config");
	BackendTaskBean btb = (BackendTaskBean) returnBean.getReturnObject("details");
	boolean canView = conf != null && btb != null;
%> 
 <div class="functionhead"><i18n:label code="TASK_EXECUTION_SUMM_RPT"/></div>
 <br>
<%
	if (canView)
	{
%>


	<table  class="listbox">
		 <tr>
		     <td class="odd"><i18n:label code="TASK_ID"/></td>
		     <td><%=conf.getTaskID()%></td>
		 </tr>
		 <tr>
		     <td class="odd"><i18n:label code="TASK_NAME"/></td>
		     <td><%=conf.getName()%></td>
		 </tr>
		 <tr>
		     <td class="odd"><i18n:label code="TASK_PARAMS"/></td>
		     <td><std:text value="<%=btb.getParamvalues()%>" defaultvalue="-"/></td>
		 </tr>
		 <tr>
			  <td  class="odd"><i18n:label code="GENERAL_START_TIME"/></td>
			  <td><%=btb.getStartTime()%></td>
		 </tr>
		 <tr>
			  <td  class="odd"><i18n:label code="GENERAL_END_TIME"/></td>
			  <td><%=btb.getEndTime()%></td>
		 </tr>
		 <tr>
			  <td  class="odd"><i18n:label code="GENERAL_PROCESSED_BY"/></td>
			  <td><%=btb.getDoneBy()%></td>
		 </tr>
		 <tr>
		   	<td  class="odd"><i18n:label code="TASK_PROCESS_LOG"/></td>
		  	<td>&nbsp;&nbsp;<std:link text="<%= lang.display("GENERAL_BUTTON_READ") %>" taskid="<%=BackendTaskManager.TASKID_BACKEND_GET_FILE%>" params="<%="TaskID="+btb.getTrxcode()+"&FileType=LOG"%>" /></td>
		 </tr> 
		 <tr>
		   	<td  class="odd"><i18n:label code="TASK_DEBUG_LOG"/></td>
		  	<td>&nbsp;&nbsp;<std:link text="<%= lang.display("GENERAL_BUTTON_READ") %>" taskid="<%=BackendTaskManager.TASKID_BACKEND_GET_FILE%>" params="<%="TaskID="+btb.getTrxcode()+"&FileType=DEBUG"%>" /></td>
		 </tr>
		 <tr>
			  <td  class="odd"><i18n:label code="GENERAL_STATUS"/></td>
			  <% if (btb.getStatus() == BackendTask.ERROR) { %>
			  <td><font size="4" color="red"><%=BackendTask.definteTaskStatus(btb.getStatus())%></font></td>
			  <% } else { %>
			  <td><font size="4" color="blue"><%=BackendTask.definteTaskStatus(btb.getStatus())%></font></td>
			  <% } %>
		 </tr>  
	</table>

	<% if (btb.getStatus() == BackendTask.ERROR) { %>
	<br>
	<br>
 	<table>
 	<tr>
 	<td>
 	<u><i18n:label code="TASK_ERROR_INFO"/></u>
 	<br><%=btb.getError()%>
 	</td>
 	</tr>
 	</table>
	<% } // end error %>
	
	
	<% if (btb.getStatus() == BackendTask.SUCCESS) { %>
	<br>
	<br>
 	<table>
 	<tr>
 	<td>
 	<u><i18n:label code="TASK_SUMM_RPT"/></u>
 	<br><std:text value="<%=btb.getReport()%>" defaultvalue="-"/>
 	</td>
 	</tr>
 	</table>
	<% } // end error %>
	
	
	
	
	
	 
<%	}   // end canView %>

 </body>
</html>
