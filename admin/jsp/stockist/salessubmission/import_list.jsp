<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@page import="com.ecosmosis.orca.stockist.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.counter.salessubmission.SubmissionLogBean"%>
<%@page import="com.ecosmosis.orca.counter.salessubmission.ExcelUploadManager"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	String editURL = "";//Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	SubmissionLogBean[] beans = (SubmissionLogBean[]) returnBean.getReturnObject(ExcelUploadManager.RETURN_SUBMISSION_LIST_CODE);

	Map records = (Map) returnBean.getReturnObject(StockistManager.RETURN_SHOWRECS_CODE);
	
	boolean canView = (beans != null);
	
	boolean showResult = (beans != null && beans.length>0);
%>

<html>
<head>
<title></title>

<%@ include file="/lib/header.jsp"%>

	<script language="javascript">
 	 
	</script>
</head>

<body>

<div class="functionhead">Submission Logs</div>

<form name="frmSearch" method="post" action="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_IMPORT_LISTING, request)%>" >
<table border="0" class="noprint">
	<tr>
		<td class="td1">Stockist ID:</td>
		<td><std:stockistid name="StockistID" form="frmSearch"/></td>
		<td>&nbsp;</td>
		<td class="td1">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="td1">Submitted Date From:</td>
		<td><std:input type="date" name="DateFrom" value="now"/></td>
		<td>&nbsp;</td>
		<td class="td1">Submitted Date To:</td>
		<td><std:input type="date" name="DateTo" value="now"/></td>
	</tr>
	<tr>
		<td class="td1">Display:</td>
		<td><std:input type="select" name="Limits" options="<%=records %>" /></td>
		<td>&nbsp;</td>
		<td class="td1">&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>

<br>
<input class="noprint" type="submit" value="Submit">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%= showResult %>">
	<input class="noprint" type="button" value="Print" onClick="window.print();">
	<br>
	<br>	
</c:if>
	

<c:if test="<%= canView %>">
<table class="listbox" width="60%">
	
	<tr class="boxhead" valign=top>
		<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>" /></td>
		<td>Batch No.</td>
		<td width="15%">Stockist ID</td>		
		<td align=right width="6%">Records</td>		
		<td  width="8%">Submitted By</td>
		<td>Submitted Date</td>
		<td width="10%">Status</td>
	</tr>
<c:choose>
<c:when test="<%= showResult %>">

	<%
		String rowCss = "";
		for (int i = 0; i < beans.length; i++) {
			
			if (i % 2 == 0)
				rowCss = "even";
			else
				rowCss = "odd";
	%>
	
	<tr class="<%= rowCss %>" valign=top>
		<td width="5%" align=right><%= (i+1) %>.</td>
		<td nowrap>
		<%if(beans[i].getStatus() == ExcelUploadManager.LOG_SUCCESS){%>
			<a href="<%=Sys.getControllerURL(ExcelUploadManager.TASKID_EXCEL_SUBMITTED_SALES_LISTING, request)%>&BatchNo=<%= beans[i].getBatchCode() %>">
		<%}%>
		<%= beans[i].getBatchCode() %>
		<%if(beans[i].getStatus() == ExcelUploadManager.LOG_SUCCESS){%>
			</a>
		<%} %>	
		</td>
		<td nowrap><%= beans[i].getTargetID() %></td>
		<td align=right><%= beans[i].getRecords() %></td>		
		<td nowrap><%= beans[i].getStd_createBy() %></td>
		<td align=center><%= beans[i].getStd_createDate() %> <%= beans[i].getStd_createTime() %></td>
		<td nowrap>
		<%if(beans[i].getStatus() == ExcelUploadManager.LOG_SUCCESS){%>
		  	<font color="blue">Success</font>
		<%}else{ %>
		  	<font color="red">Failed</font>
		<%}%>
		</td>
	</tr>
	<%
		}//end for
	%>	

</c:when>	
<c:otherwise>
	<tr>
		<td colspan=9 align="center"><b>No records found.</b></td>	  
	</tr>

</c:otherwise>
</c:choose>
</table>

	<c:if test="<%= showResult %>">
		
		<br>
		<br>
		<input class="noprint" type="button" value="Print" onClick="window.print();">
	</c:if>
	
</c:if>



</body>
</html>
