<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.logging.auditlog.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	ActionTaskBean[] beans = (ActionTaskBean[]) returnBean.getReturnObject("List");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	 	
	boolean filter = false;
	String idstr = request.getParameter("filterid");

	if (idstr != null && idstr.length() > 0)
		filter = true;
	
%> 

<%!
	private boolean checkSubString(String str,String checkstr)
	{
		int checklen = checkstr.length();
		String targetstr = str.substring(0,checklen);
		if (checkstr.equalsIgnoreCase(targetstr))
			return true;
		else
			return false;
	}
%>

<html>
<head>
<%@ include file="/lib/header.jsp" %>
</head>

	<body>
	<div class="functionhead">Audit Log Settings</div>
 	<form method="post" name=tasklist action="" action="<%=Sys.getControllerURL(ActionTaskManager.TASKID_TASK_AUDITLOG_SETTINGS,request)%>">
 	<table  class="listbox"  width=300>

	<tr>
	 	<td width="200" class="odd">Display Task IDs Begin With</td>
	 	<td><std:input type="text"  name="filterid"  size="10" value="<%=idstr%>" />&nbsp;<input type="submit" value="GO"></td>
	 </tr> 
    </form>


<% if (canView) { %>    
<table>	 <tr><td>&nbsp;</td></tr></table>

	<table class="listbox"  width="90%">
	
		  <tr class="boxhead" valign=top>
			<td>No.</td>
			<td>Task ID</td>
			<td>Description</td>
			<td>Access Group</td>
			<td>Status</td>
			<td>Log<br>Level</td>
			<td>Log<br>Params</td>
			<td>&nbsp;</td>
		  </tr>

	
		  <%
		  		int count = 0;
		  		for (int i=0;i<beans.length;i++) { 
			  
				if (filter)
				{
					if (!checkSubString(beans[i].getTaskID(),idstr))	
							continue;
				}
		  %>

			   <tr class="<%= ((++count)%2 == 0) ? "even" : "odd"%>" valign=top>
					<td><%=count%></td>
					<td><%=beans[i].getTaskID()%></td>
					<td nowrap><%=beans[i].getDescription()%></td>
					<td align="center"><%=SystemConstant.definteUserType(beans[i].getAccessGroupLevel())%></td>
					<td align="center"><%=beans[i].getStatus()%></td>
					<td align="center"><%=AuditLogManager.defineLogLevel(beans[i].getLoglevel())%></td>
					<td><%=((beans[i].getLogParams() != null) ? beans[i].getLogParams() : "")%></td>
					<td align=center><small><std:link text="Update" taskid="<%=ActionTaskManager.TASKID_TASK_AUDITLOG_UPDATE%>" params="<%=("taskid="+beans[i].getTaskID())%>" /></small></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
