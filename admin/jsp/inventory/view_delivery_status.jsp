<!-- Status related -->

<table>
	<tr class="<%= (doBean.getStatus() != CounterSalesManager.STATUS_ACTIVE) ? "wordalert" : "" %>">
		<td class="td1" width="110"><i18n:label code="GENERAL_STATUS"/>:</td>
		<td><%= CounterSalesManager.defineTrxStatusName(doBean.getStatus()) %></td>
	</tr>
	
	<%
		if (adjstBean != null) {
	%>

	<tr class="wordalert" valign="top">
		<td class="td1" width="110" nowrap><%= adjstBean.getTrxDocName() %>:</td>
		<td valign="top"><%= adjstBean.getTrxDocNo() %></td>
	</tr>
	<tr class="wordalert" valign="top">
		<td class="td1" width="110" nowrap><i18n:label code="GENERAL_ADJ_REMARK"/>:</td>
		<td valign="top"><%= adjstBean.getAdjstRemark() != null ? adjstBean.getAdjstRemark().replaceAll("\n","<br>") : "-" %></td>
	</tr>
	
	<% 
		}
	%>
	
</table>

