<%@page import="com.ecosmosis.orca.stockist.StockistBean"%>
<%@page import="com.ecosmosis.orca.stockist.StockistManager"%>
<%@page import="com.ecosmosis.orca.member.*"%>
<html>
<head>
  <title></title>

<%@ include file="/lib/header.jsp"%>
<%@ include file="/lib/select_locations.jsp"%>

<%
	int size = 40;
	int memberIDLength = 12;
	
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
	StockistBean bean = (StockistBean) returnBean.getReturnObject(StockistManager.RETURN_STKBEAN_CODE);
	boolean canView = bean != null;
%>
	  
  <script language="javascript">
  </script>	
  
</head>

<body>
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<div class="functionhead"><i18n:label code="GENERAL_REGISTER_SUCCESS"/></div>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
	if (canView) {
%>

<form name="frmEdit" action="<%=Sys.getControllerURL(StockistManager.TASKID_REG_FORM,request)%>" method="post">
	<table class="tbldata" width="100%">
		
		<tr>
			<td colspan="2" class="sectionhead"><i18n:label code="STOCKIST_INFO"/></td>
  		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="STOCKIST_ID"/>:</td>
	    	<td><b><%= bean.getStockistCode() %></b></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="GENERAL_USERID"/> (<i18n:label code="GENERAL_LOGIN"/>):</td>
	    	<td><b><%= bean.getStockistRunningID() %></b></td>
		</tr>
		<tr>
			<td align="right" width="180"><i18n:label code="GENERAL_PASSWORD"/> (<i18n:label code="GENERAL_LOGIN"/>):</td>
	    	<td><b> <%= bean.getUser().getPassword() %></b> </td>
		</tr>
		<tr>
			<td align="right"><i18n:label code="STOCKIST_TYPE"/>:</td>
			<td><%= StockistManager.defineStockistType(bean.getType()) %></td>
		</tr>
		<tr valign="top">
			<td align="right" width="180"><i18n:label code="GENERAL_NAME"/>:</td>
			<td><std:text value="<%= bean.getName() %>" defaultvalue="-"/></td>
		</tr>
		<tr valign="top">
			<td align="right"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.IC%>"/> / <i18n:label localeRef="mylocale" code="<%=MemberMessageTag.INCORPORATION_NO%>"/>.:</td>
			<td><std:text value="<%= bean.getRegistrationInfo()%>" defaultvalue="-"/></td>
		</tr>		
		<tr>
			<td align="right" width="180"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>"/>:</td>
	    	<td><%= bean.getMemberID() %></td>
		</tr>
	</table>
  
	<br>
  
	<input class="textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();"> 
	<a name="btn">
</form>

<% 
	} // end canView
%>

</body>
</html>		