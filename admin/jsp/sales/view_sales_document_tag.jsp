<!-- Document related -->
	
<table border="0">
	  <tr class=baru valign=top> 
		<td align="left"><b> Invoice No</td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><std:text value="<%= bean.getTrxDocNo() %>" defaultvalue="-"/></td> 
                <td align="left" width="60" nowrap></td>
                
		<td align="left"><b> Date</td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b> <fmt:formatDate pattern="dd MMMM yyyy" type="both" value="<%= bean.getTrxDate()%>" /> Time  <%= bean.getTrxTime()%> </td>           
	</tr>  
	  <tr class=baru valign=top> 
		<td align="left"><b> Sales</td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><%= bean.getBonusEarnerName() %></td>
                 <td align="left" width="60" nowrap></td>
		<td align="left"><b> Location </td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><std:text value="<%= outlet.getName() %>"/></td>
	</tr>                
                
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
	
	  <tr class=baru valign=top> 
		<td align="left"><b> Ref. Document</td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><%= bean.getAdjstRefNo() %></td>
                 <td align="left" width="40"></td>
		<td align="left"></td>
                <td class="td1" nowrap align="left"></td>
                <td align="left"></td>   
	</tr>
	
	<%
		}
	%>	
        
        
    <tr>
        <td colspan="4">  </td>            
    </tr>          
	
</table>