<!-- Document related -->
	
<table border="0">
    
	<tr valign="top">
		<td class="td1" nowrap align="left" width="110" >Location  </td>
                <td>: </td>
		<td colspan="2" align="left"><std:text value="<%= bean.getSellerID() %>"/></td>
	</tr>    
	<tr>
		<td class="td1" nowrap align="left"><std:text value="<%= bean.getTrxDocName() %>"/></td>
                <td>: </td>
		<td colspan="2" align="left"><std:text value="<%= bean.getTrxDocNo() %>" defaultvalue="-"/></td>
	</tr>
	<tr>
		<td class="td1" nowrap align="left"><i18n:label code="SALES_TRX_DATE"/></td>
                <td>: </td>
		<td align="left"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= bean.getTrxDate()%>" /> </td>
                <td align="left">- <%= bean.getTrxTime()%></td>
	</tr>

    <tr>
        <td class="td1"  nowrap align="left" >Salesman</td>
        <td>: </td>
        <td colspan="2" align="left" ><%= bean.getBonusEarnerID() %></td>      
    </tr>          
        
	<%
		if (bean.getBonusPeriodID() != null && bean.getBonusPeriodID().length() > 0) {
	%>
	
	<tr>
		<td class="td1"></td>
                <td></td>
		<td colspan="2"></td>
	</tr>
	
	<%
		}
	%>
	
	<%
		if (bean.getAdjstRefNo() != null && bean.getAdjstRefNo().length() > 0) {
	%>
	
	<tr>
		<td class="td1">Ref. Document :</td>
                <td></td>
		<td colspan="2"><%= bean.getAdjstRefNo() %></td>
	</tr>
	
	<%
		}
	%>	
        
        
    <tr>
        <td colspan="4">  </td>            
    </tr>          
	
</table>