<!-- Trx related -->

<%
	String remarkTitle = "";
	String remark = "";
	
	if (doBean.getStatus() <= CounterSalesManager.STATUS_ADJST) {
		remarkTitle = "GENERAL_ADJ_REMARK";
		remark = doBean.getAdjstRemark();
	} else {
		remarkTitle = "Address Delivery";
		remark = doBean.getRemark3();	               
	}
%>

<table>
	<tr valign="top" align="left">
                <td class="td1" width="135" align="left"><b><%= lang.display(remarkTitle) %> :</b></td>
		<td><%= remark != null ? remark.replaceAll("\n","<br>") : "-" %></td>
        </tr>
</table>
