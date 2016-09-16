<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<html>
<head>
 
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	BackendTaskConfigBean[] taskconfigbeans = (BackendTaskConfigBean[]) returnBean.getReturnObject("ConfigList");
%>

<%@ include file="/lib/header.jsp"%>
</head>
<body>
 

<div class="functionhead"><i18n:label code="GENERAL_STEP_1"/> <i18n:label code="GENERAL_OF"/> 2 - <i18n:label code="TASK_SELECT"/></div>

<br>
<%@ include file="/general/mvc_return_msg.jsp"%>	


<table  class="listbox" width="90%">
	 
	 <tr  class="boxhead">
	  <td width="20"><i18n:label code="GENERAL_NUMBER"/></td>
	 	<td width="80"><i18n:label code="TASK_ID"/></td>
	 	<td><i18n:label code="TASK_NAME"/></td>
	 	<td><i18n:label code="GENERAL_DESC"/></td>
	 	<td></td>
	 </tr> 
	 
	 
	<% for (int i=0;i<taskconfigbeans.length;i++) { 
		 String remark = "";
		 if (taskconfigbeans[i].getRemark() != null)
		 	remark = taskconfigbeans[i].getRemark();
	%>
	  <tr class="<%=((i%1 == 1)?"odd":"even")%>">
	    <td><%=(i+1)%></td>
	    <td nowrap><%=taskconfigbeans[i].getTaskID()%></td>
	    <td nowrap><%=taskconfigbeans[i].getName()%></td>
	    <td><%=remark%></td>
	 	<td align="center"><std:link text="<%= lang.display("GENERAL_BUTTON_START") %>" taskid="<%=BackendTaskManager.TASKID_BACKEND_ENTER_PARAM%>" params="<%="TaskID="+taskconfigbeans[i].getTaskID()%>" /></td>
	 </tr>
	 <% } // end for %>

</table>

 </body>
 
</html>
