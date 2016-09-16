<%@ page import="java.io.*"%>
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
	BufferedReader reader = (BufferedReader) returnBean.getReturnObject("reader");
	boolean canView = conf != null && btb != null && reader != null;
%> 
 <div class="functionhead"><i18n:label code="TASK_EXECUTION_LOG"/></div>
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
  <td class="odd"><i18n:label code="GENERAL_START_TIME"/></td>
  <td><%=btb.getStartTime()%></td>
 </tr>
 <tr>
  <td class="odd"><i18n:label code="GENERAL_END_TIME"/></td>
  <td><%=btb.getEndTime()%></td>
 </tr>
 <tr>
  <td class="odd"><i18n:label code="GENERAL_PROCESSED_BY"/></td>
  <td><%=btb.getDoneBy()%></td>
 </tr>
  <tr>
	  <td  class="odd"><i18n:label code="GENERAL_STATUS"/></td>
	  <% if (btb.getStatus() == BackendTask.ERROR) { %>
	  <td><font color="red"><%=BackendTask.definteTaskStatus(btb.getStatus())%></font></td>
	  <% } else { %>
	  <td><font color="blue"><%=BackendTask.definteTaskStatus(btb.getStatus())%></font></td>
	  <% } %>
  </tr> 
</table>

<hr>
<%
	if (reader!=null)
	{
		try
		{
			String line = null;
			while((line = reader.readLine())!=null)		
			{
%>
	<%=line%><br>
<%			
			}
		}
		finally
		{
			try
			{
				if (reader!= null) reader.close();
			}
			catch (Exception ignore) {}
		}
	}
%>
<hr>
 
<%	
	}
%>

 </body>
</html>
