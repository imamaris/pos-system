<!-- Status related -->

<table>
	<tr>
		<td class="td1" width="110"><i18n:label code="DELIVERY_STATUS"/>:</td>
		<td><%= CounterSalesManager.defineDeliveryStatusName(bean.getDeliveryStatus()) %></td>
	</tr>
	<tr class="<%= (bean.getStatus() != CounterSalesManager.STATUS_ACTIVE) ? "wordalert" : "" %>">
		<td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
		<td><%= CounterSalesManager.defineTrxStatusName(bean.getStatus()) %></td>
	</tr>
	
	<%
		if (adjstBean != null) {
	%>

	<tr class="wordalert" valign="top">
		<td class="td1" width="110" nowrap><%= adjstBean.getTrxDocName() %>:</td>
		<td><%= adjstBean.getTrxDocNo() %></td>
	</tr>
	<tr class="wordalert" valign="top">
		<td class="td1" width="110" nowrap><i18n:label code="GENERAL_ADJ_REMARK"/>:</td>
		<td><%= adjstBean.getAdjstRemark() != null ? adjstBean.getAdjstRemark().replaceAll("\n","<br>") : "-" %></td>
	</tr>
	
	<% 
		}
	%>

</table>


	