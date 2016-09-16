<%@ page import="com.ecosmosis.mvc.action.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
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
	<div class="functionhead">System Tasks Listing</div>
 	<form method="post" name=tasklist action="" action="<%=Sys.getControllerURL(ActionTaskManager.TASKID_SYSTEM_TASKS_LISTING,request)%>">
 	<table  class="listbox"  width=300>

	<tr>
	 	<td width="200" class="odd">Display Task IDs Begin With</td>
	 	<td><std:input type="text"  name="filterid"  size="10" value="<%=idstr%>" />&nbsp;<input type="submit" value="GO"></td>
	 </tr> 
    </form>


<% if (canView) { %>    
<table>	 <tr><td>&nbsp;</td></tr></table>

	<table class="listbox"  width="98%">
	
		  <tr class="boxhead" valign=top>
			<td>No.</td>
			<td>&nbsp;</td>
			<td>Task ID</td>
			<td >Description</td>
			<td>Status</td>
			<td>Manager Class Name</td>
			<td>Group Level</td>
			<td>Auth<br>User<br> Type</td>
			<td>Auth<br>ACL</td>
			<td>Sensitivity</td>
			<td>Process<br>Method</td>
			<td>Succ<br>Return<br>Method</td>
			<td>Succ<br>Return<br>Path</td>
			<td>Fail<br>Return<br>Method</td>
			<td>Fail<br>Return<br>Path</td>
			<td>Next<br>Action<br>Method</td>
			<td>Next<br>Action<br>Path</td>
			<td>Multipart</td>
			<td>Visibility</td>
			<td>Log<br>Level</td>
			<td>Status<br>Msg</td>
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
					<td align=center nowrap><small><std:link text="UPDATE" taskid="<%=ActionTaskManager.TASKID_UPDATE_TASK%>" params="<%=("taskid="+beans[i].getTaskID())%>" /></small></td>
					<td><%=beans[i].getTaskID()%></td>
					<td nowrap><%=beans[i].getDescription()%></td>
					<td align="center"><%=beans[i].getStatus()%></td>
					<td><%=beans[i].getClassName()%></td>
					<td align="center"><%=beans[i].getAccessGroupLevel()%></td>
					<td align="center"><%=beans[i].getAuthType()%></td>
					<td align="center"><%=beans[i].getAuthACL()%></td>
					<td align="center"><%=beans[i].getSensitivity()%></td>
					<td align="center"><%=beans[i].getProcessMethod()%></td>
					<td align="center"><%=beans[i].getSucccess_return_type()%></td>
					<td><%=beans[i].getSucccess_return_ref()%></td>
					<td align="center"><%=beans[i].getFail_return_type()%></td>
					<td><%=beans[i].getFail_return_ref()%></td>
					<td align="center"><%=beans[i].getNextaction_return_type()%></td>
					<td><%=beans[i].getNextaction_return_ref()%></td>
					<td align="center"><%=beans[i].getMultipart()%></td>
					<td align="center"><%=beans[i].getActionVisibility()%></td>
					<td align="center"><%=beans[i].getLoglevel()%></td>
					<td><%=beans[i].getStatusmsg()%></td>
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
