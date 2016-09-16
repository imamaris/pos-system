<%@ page import="com.ecosmosis.common.sysparameters.*"%>
<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>


<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	SystemParametersBean[] beans = (SystemParametersBean[]) returnBean.getReturnObject("ParamsList");
	boolean canView = false;
	if (beans != null && beans.length > 0)
	 	canView = true;
	 	
	String subtitle = "";
	if (request.getParameter("category") != null)
		subtitle = " - "+request.getParameter("category");

%> 

<html>
<head>
		<%@ include file="/lib/header.jsp"%>
</head>

	<body>
	<div class=functionhead><i18n:label code="ADMIN_PARAM_LIST"/> <%=subtitle%></div><br>

<% if (canView) { %>    
	<table class="listbox" width="80%">
	
		  <tr class="boxhead" align='center'>
			<td width="30"><i18n:label code="GENERAL_NUMBER"/></td>
			<td width="150"><i18n:label code="ADMIN_PARAM_ID"/></td>
			<td width="50"><i18n:label code="GENERAL_TYPE"/></td>
			<td width="120"><i18n:label code="ADMIN_PARAM_VALUE"/></td>
			<td><i18n:label code="GENERAL_DESC"/></td>
			<td>&nbsp;</td>
		  </tr>

		   <% for (int i=0;i<beans.length;i++) {  %>
			   <tr class="<%=((i%2==1)?"odd":"even")%>" align='center'>
					<td ><%=i+1%></td>
					<td><%=beans[i].getParamID()%></td>
					<td align="center"><%=beans[i].getType()%></td>
					<td><%=beans[i].getValue()%></td>
					<td align='left'><%=beans[i].getDescription()%></td>
					<td align="center"><small><std:link text="edit" taskid="<%=SystemParametersManager.TASKID_UPDATE_SYSPARAM%>" params="<%=("paramid=" + beans[i].getParamID())%>" /></small></td>	
			  </tr>
		  <% } %>
		  
	</table>
<% } // end if canView %>	
	
	</body>
</html>
