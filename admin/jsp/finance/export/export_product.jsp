<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	int totalrecord = (Integer) returnBean.getReturnObject("TotalProductRecord");
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
</head>

<body>
  
<div class="functionhead">Export Product</div>	

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="exp_pdt_data" action="<%=Sys.getControllerURL(ProductReportManager.TASKID_EXPORT_PRODUCT_SUBMIT, request)%>" method="post" onsubmit="">
<table>
	<tr>
		<td>
			<table class="listbox" width="250">
				<tr>
					<td class="totalhead" width="200"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL%>"/> Records Found</td>
					<td width="50"><%= totalrecord %></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<br><input class="noprint textbutton" type="submit" value="EXPORT TEXT FILE">
		</td>
	</tr>
</table>
</form>
</body>
</html>