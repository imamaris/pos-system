<!-- Trx related -->

<%
	String remarkTitle = "";
	String remark = "";
	
	if (bean.getStatus() <= CounterSalesManager.STATUS_ADJST) {
		remarkTitle = "GENERAL_ADJ_REMARK";
		remark = bean.getAdjstRemark();
	} else {
		remarkTitle = "GENERAL_REMARK";
		remark = bean.getRemark();		
	}
%>

<table>
    
        <% if (remark.length() > 0) { %>
	<tr valign="top">
		<td class="td1" width="110"><%= lang.display(remarkTitle) %>:</td>
		<td><%= remark != null && remark.length() > 0 ? remark.replaceAll("\n","<br>") : "-" %></td>
	</tr>
         <% } %>
        
</table>
