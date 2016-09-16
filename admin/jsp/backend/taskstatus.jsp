<%@ page import="com.ecosmosis.mvc.backend.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>

<html>
<head>
 <%@ include file="/lib/header.jsp"%>
</head>
<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	String msg = (String) returnBean.getReturnObject("msg");
	String trxcode = (String) returnBean.getReturnObject("TaskCode");
%>
 <body>
 
<SCRIPT LANGUAGE=JavaScript>

<%
	if (msg == null || msg.length() == 0)
	{
%>
	document.location.href='<%=Sys.getControllerURL(BackendTaskManager.TASKID_BACKEND_GET_TASK_DETAILS,request)%>&TaskID=<%=trxcode%>';
<%
	} else {
%>

function RefreshPage()
{
	document.location.href='<%=Sys.getControllerURL(BackendTaskManager.TASKID_BACKEND_GET_STAGE_MESSAGE,request)%>&TaskCode=<%=trxcode%>';
}

window.setInterval("RefreshPage()",5000)

<% } %>

</SCRIPT> 
<h5>Stage</h5>
<b><%=msg%></b>
</body>
</html>
