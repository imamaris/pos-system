<!-- Document related -->

<table border="0">
	<tr>
		<td class="td1" width="110"><span class="docNameSmall"><%= doBean.getTrxDocName() %>:</span></td>
		<td><%= doBean.getTrxDocNo() %></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="SALES_TRX_DATE"/>:</td>
		<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= doBean.getTrxDate() %>" /></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="SALES_REFERENCE"/>:</td>
		<td><%= doBean.getSalesRefNo() %></td>
	</tr>
	
	<%
		if (doBean.getAdjstRefNo() != null && doBean.getAdjstRefNo().length() > 0) {
	%>
	
	<tr>
		<td class="td1"><i18n:label code="GENERAL_REFERENCE_NUM"/>:</td>
		<td><%= doBean.getAdjstRefNo() %></td>
	</tr>
	
	<%
		}
	%>
	
</table>
