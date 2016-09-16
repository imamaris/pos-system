<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.bank.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.member.printings.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	int totalMemberRecord = (Integer) returnBean.getReturnObject("TotalMemberRecord");
%>

<html>
<head>
	<title></title>
	
	<%@ include file="/lib/header.jsp"%>
</head>

<body>
  
<div class="functionhead">Export Member</div>	

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<form name="exp_mbr_data" action="<%=Sys.getControllerURL(MemberReportManager.TASKID_EXPORT_MEMBER_SUBMIT, request)%>" method="post" onsubmit="">
<table>
	<tr>
		<td>
			<table class="listbox" width="250">
				<tr>
					<td class="totalhead" width="200"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.TOTAL%>"/> Records Found</td>
					<td width="50"><%= totalMemberRecord %></td>
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