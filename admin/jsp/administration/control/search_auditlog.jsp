<%@ page import="com.ecosmosis.orca.users.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.mvc.sys.*"%>
<%@ page import="com.ecosmosis.mvc.logging.auditlog.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="com.ecosmosis.mvc.sys.SystemConstant"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	AuditLogBean[] beans = (AuditLogBean[]) returnBean.getReturnObject("AuditLogList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	
	SimpleDateFormat dateTimeFormatter =   new SimpleDateFormat("yyyy-MM-dd H:mm:ss");
	
	TreeMap orderbys = (TreeMap) returnBean.getReturnObject("OrderByList");
	TreeMap viewtype = (TreeMap) returnBean.getReturnObject("ViewTypeList");
	
	String viewstr = request.getParameter("viewtype");
	int view = 1;
	if (viewstr != null)
		view = Integer.parseInt(viewstr);
	
%> 


<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class="functionhead"><i18n:label code="ADMIN_SEARCH_LOGS"/></div>
	<br>

	<form name="searchform" action="<%=Sys.getControllerURL(AuditLogManager.TASKID_AUDITLOG_LISTING,request)%>" method="post">	
	<input type="hidden" name="submitted" value="Y" />
	<input type="hidden" name="limit" value="0,<%=AuditLogManager.MAX_LIMIT_PER_PAGE%>" />
	<table width="500">
	 <tr>
	 	<td width="150" class="odd"><i18n:label code="GENERAL_USERID"/></td>
	 	<td nowrap><std:input type="text" name="userID"  value="<%=request.getParameter("userID")%>" size="12" maxlength="15"/></td>
	 </tr> 
	 <tr>
	 	<td width="150" class="odd" nowrap><i18n:label code="GENERAL_FROMDATE"/> | <i18n:label code="GENERAL_TIME"/></td>
	 	<td nowrap><std:input type="text" name="fromdatetime"  value="<%=request.getParameter("fromdatetime")%>"  size="22" maxlength="20"/><font size='1'> (<i18n:label code="GENERAL_FORMAT"/>: YYYY-MM-DD HH:MM:SS)</font></td>
	 </tr>
	  <tr>
	 	<td width="150" class="odd"  nowrap><i18n:label code="GENERAL_TODATE"/> | <i18n:label code="GENERAL_TIME"/></td>
	 	<td nowrap><std:input type="text" name="todatetime"  value="<%=request.getParameter("todatetime")%>"  size="22" maxlength="20"/><font size='1'> (<i18n:label code="GENERAL_FORMAT"/>: YYYY-MM-DD HH:MM:SS)</font></td>
	 </tr>  
	 <tr>
	 	<td width="150" class="odd"><i18n:label code="GENERAL_TARGETID"/></td>
	 	<td nowrap><std:input type="text" name="targetID"  value="<%=request.getParameter("userID")%>" size="15" maxlength="15"/><font size='1'> (<i18n:label code="ADMIN_ID"/>, <i18n:label code="MEMBER_ID"/>, <i18n:label code="STOCKIST_ID"/> & <i18n:label code="GENERAL_ETC"/>)</font></td>
	 </tr> 
	 <tr>
	 	<td width="150" class="odd"><i18n:label code="GENERAL_VIEWTYPE"/></td>
	 	<td nowrap><std:input type="select" name="viewtype" options="<%=viewtype%>" value="<%=request.getParameter("viewtype")%>"/> </td>
	 </tr>
	 <tr>
	 	<td width="150" class="odd"><i18n:label code="GENERAL_ORDERBY"/></td>
	 	<td nowrap><std:input type="select" name="orderby" options="<%=orderbys%>" value="<%=request.getParameter("orderby")%>"/> &nbsp<input type="submit" value="<i18n:label code="GENERAL_BUTTON_ADD"/>"></td>
	 </tr>
	</table>
	</form>
	




<% if (canView) { %> 

<%  if (beans.length >= AuditLogManager.MAX_LIMIT_PER_PAGE) {  %>
  	<table><tr><td><font color="red">** There are more than <%=AuditLogManager.MAX_LIMIT_PER_PAGE%> records found. Pls refine your search criteria. **</font></td></tr></table>  
<% } %>
   
	<table class="listbox" width="100%">
	
		  <tr class="boxhead" valign=top>
			<td align=right><i18n:label code="GENERAL_NUMBER"/></td>
			<td><i18n:label code="GENERAL_USERID"/></td>
			<td><i18n:label code="GENERAL_USERTYPE"/></td>
			<td nowrap><i18n:label code="GENERAL_DATETIME"/></td>
			<td><i18n:label code="GENERAL_ACTION"/></td>
			<td><i18n:label code="GENERAL_TARGETID"/></td>
			<td><i18n:label code="GENERAL_REMOTEIP"/></td>
<% if (view >= 2) { %>	<td><i18n:label code="GENERAL_PARAMS"/></td> <% } %>
<% if (view >= 3) { %>	<td><i18n:label code="GENERAL_FULLPARAMS"/></td> <% } %>
		  </tr>
		  
		  
<%		  

		for (int i=0 ; i<beans.length; i ++) {
			
			String target = (beans[i].getTargetUserID() == null) ? "-" : beans[i].getTargetUserID();
			String params = (beans[i].getParams() == null) ? "-" : beans[i].getParams();
			String fullparams = (beans[i].getFullparams() == null) ? "-" : beans[i].getFullparams();
			String remoteIP = (beans[i].getRemoteIP() == null) ? "-" : beans[i].getRemoteIP();
%>
		   <tr class="<%=((i%2==1)?"odd":"even")%>" >
		  		<td align=right><%=(i+1)%>.</td>
		  		<td align="center" nowrap><%=beans[i].getUserID()%></td>
		  		<td align="center" nowrap><%=SystemConstant.definteUserType(beans[i].getUserGroup())%></td>
		  		<td align="center" nowrap><%=dateTimeFormatter.format(beans[i].getDate())%></td>
		  		<td align="left"><%=beans[i].getTaskName()%></td>
		  		<td align="center"><%=target%></td>
		  		<td align="center"><%=remoteIP%></td>
<% if (view >= 2) { %>	<td align="left"><%=params%></td> <% } %>
<% if (view >= 3) { %>	<td align="left"><%=fullparams%></td> <% } %>
		  </tr>	

<% } // end for %>	
		  
		  
		  
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
