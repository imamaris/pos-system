<%@page import="com.ecosmosis.orca.stockist.*"%>
<%
	String editURL = "";//Sys.getControllerURL(MemberManager.TASKID_BASIC_EDIT_MEMBER, request);

	MvcReturnBean returnBean = (MvcReturnBean) request.getAttribute(MvcReturnBean.RETURNBEANCODE);

	StockistBean[] beans = (StockistBean[]) returnBean.getReturnObject(StockistManager.RETURN_STKLIST_CODE);
	
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

<div class="functionhead"><i18n:label code="STOCKIST_LIST"/></div>
<br>

<%@ include file="/lib/return_error_msg.jsp"%>

<c:if test="<%= showResult %>">
	<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">&nbsp;
	<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
	<br>
	<br>	
</c:if>
	

<c:if test="<%= showResult %>">
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
		<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">&nbsp;
		<input class="noprint" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
	</c:if>
	
</c:if>



</body>
</html>
