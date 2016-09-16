<!-- Document related -->
	
<table border="0">
	<tr valign="top">
		<td class="td1" width="110" nowrap><span class="docNameSmall"><std:text value="<%= bean.getTrxDocName() %>"/>:</span></td>
		<td><std:text value="<%= bean.getTrxDocNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td class="td1"><i18n:label code="SALES_TRX_DATE"/> :</td>
		<td><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate() %>" /></td>
	</tr>
	
	<%
		if (bean.getBonusPeriodID() != null && bean.getBonusPeriodID().length() > 0) {
	%>
	
	<tr>
		<td class="td1"></td>
		<td></td>
	</tr>
	
	<%
		}
	%>
	
	<%
		if (bean.getAdjstRefNo() != null && bean.getAdjstRefNo().length() > 0) {
	%>
	
	<tr>
		<td class="td1">Ref. Document :</td>
		<td><%= bean.getAdjstRefNo() %></td>
	</tr>
	
	<%
		}
	%>	
        
        
    <tr>
        <td colspan="2">  </td>            
    </tr>
    
    <tr>
        <td class="td1" >Sales Name :</td>
        <td><%= bean.getBonusEarnerName() %></td>      
    </tr>        
	
</table>