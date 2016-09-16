<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.common.locations.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@page import="com.ecosmosis.orca.stockist.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
	String editURL = "";//Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	StockistBean[] beans = (StockistBean[]) returnBean.getReturnObject(StockistManager.RETURN_STKLIST_CODE);
	
	Map types = (Map) returnBean.getReturnObject(StockistManager.RETURN_STKTYPES_CODE);
	
	Map status = (Map) returnBean.getReturnObject(StockistManager.RETURN_STKSTATUS_CODE);

	Map records = (Map) returnBean.getReturnObject(StockistManager.RETURN_SHOWRECS_CODE);
	
	Map orderBys = (Map) returnBean.getReturnObject(StockistManager.RETURN_ORDERBY_CODE);
	
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

<div class="functionhead"><i18n:label code="STOCKIST_SEARCH"/></div>

<form name="frmSearch" method="post" action="<%=Sys.getControllerURL(StockistManager.TASKID_SEARCH_STOCKISTS_LIST,request)%>"	onSubmit="return doSubmit(document.frmSearch);">
<table border="0" class="noprint">
	<tr>
		<td class="td1"><i18n:label code="STOCKIST_ID"/>:</td>
		<td><std:input type="text" name="StockistID" size="30" maxlength="6"/></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
		<td><std:input type="text" name="Name" size="30" maxlength="50" /></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>" /> / <br> Incorporation No.:</td>
		<td><std:input type="text" name="RegistrationInfo" size="30" maxlength="30" /></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_NO_MOBILE"/>:</td>
		<td><std:input type="text" name="MobileTel" size="30" maxlength="30" /></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_TYPE"/>:</td>
		<td><std:input type="select" name="Type" options="<%=types %>"/></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
		<td><std:input type="select" name="Status" options="<%=status %>"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="GENERAL_DISPLAY"/>:</td>
		<td><std:input type="select" name="Limits" options="<%=records %>" /></td>
		<td>&nbsp;</td>
		<td class="td1"><i18n:label code="GENERAL_ORDERBY"/>:</td>
		<td><std:input type="select" name="OrderBy" options="<%=orderBys %>"/></td>
	</tr>
</table>

<br>

<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>" />

<input class="noprint" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
</form>

<hr>

<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%= showResult %>">
	<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
	<br>
	<br>	
</c:if>
	

<c:if test="<%= canView %>">
<table class="listbox" width="100%">
	
	<tr class="boxhead" valign=top>
		<td width="5%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>" /></td>
		<td width="10%"><i18n:label code="STOCKIST_ID"/></td>
		<td><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NAME%>" /></td>		
		<td width="10%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.IC_NO%>" /> / <br> Incorporation No.</td>
		<td width="10%"><i18n:label code="GENERAL_TYPE"/></td>
		<td width="10%"><i18n:label code="GENERAL_NO_MOBILE"/></td>
		<td width="10%"><i18n:label localeRef="mylocale" code="<%=MemberMessageTag.DISTRIBUTOR_ID%>" /></td>
		<td width="10%"><i18n:label code="GENERAL_STATUS"/></td>
		<td width="3%"></td>
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

			if (!beans[i].isActive())
				rowCss = "alert";
	%>
	
	<tr class="<%= rowCss %>" valign=top>
		<td width="5%" align=right><%= (i+1) %>.</td>
		<td nowrap><%= beans[i].getStockistCode() %></td>
		<td><%= beans[i].getName() %></td>
		<td nowrap><%= beans[i].getRegistrationInfo() %></td>
		<td nowrap><%= StockistManager.defineStockistType(beans[i].getType()) %></td>
		<td nowrap><std:text value="<%= beans[i].getMobileTel() %>"/></td>
		<td nowrap><%= beans[i].getMemberID() %></td>
		<td align="center" nowrap><%= StockistManager.defineStockistStatus(beans[i].getStatus()) %></td>		
		<td><std:link text="edit" taskid="<%=StockistManager.TASKID_EDIT_STOCKIST%>" params="<%=("StockistID=" + beans[i].getStockistRunningID())%>" /></td>
	</tr>
	<%
		}//end for
	%>	

</c:when>	
<c:otherwise>
	<tr>
		<td colspan=9 align="center"><b><i18n:label code="MSG_NO_RECORDFOUND"/></b></td>	  
	</tr>

</c:otherwise>
</c:choose>
</table>

	<c:if test="<%= showResult %>">
		
		<br>
		<br>
		<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
	</c:if>
	
</c:if>



</body>
</html>
