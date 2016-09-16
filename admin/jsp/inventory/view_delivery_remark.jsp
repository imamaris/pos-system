<!-- Trx related -->

<%
	String remarkTitle = "";
	String remark = "";
	
	if (doBean.getStatus() <= CounterSalesManager.STATUS_ADJST) {
		remarkTitle = "GENERAL_ADJ_REMARK";
		remark = doBean.getAdjstRemark();
	} else {
		remarkTitle = "GENERAL_REMARK";
		remark = doBean.getRemark();		
	}
%>

<table>
	<tr valign="top">
		<td class="td1" width="110"><%= lang.display(remarkTitle) %>:</td>
		<td><%= remark != null ? remark.replaceAll("\n","<br>") : "-" %></td>
	</tr>
</table>
