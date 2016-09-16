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
<form name="frmSalesOrder" method="post" action="">
    <table>      
        <% if (remark.length() > 0) { %>
        <tr valign="top">
            <td class="td1" ><%= lang.display(remarkTitle) %>:</td>
            <td colspan="3" ><textarea name="Remark" id="Remark" cols="40" rows="5"><%= remark != null && remark.length() > 0 ? remark.replaceAll("\n","<br>") : "-" %></textarea>
                <input type="button" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>" onClick="updateRemark()">
            </td>
        </tr>
        <% } %>
        
    </table>
</form>