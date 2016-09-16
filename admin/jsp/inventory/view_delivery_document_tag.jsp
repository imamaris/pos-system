<!-- Document related -->

<table border="0">
 
	  <tr class=baru valign=top> 
		<td align="left"><b> Delivery Doc. </td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><std:text value="<%= doBean.getTrxDocNo() %>" defaultvalue="-"/></td> 
                <td align="left" width="60" nowrap></td>
                
		<td align="left"><b> Date</td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b> <fmt:formatDate pattern="dd MMMM yyyy" type="both" value="<%= doBean.getTrxDate()%>" /> Time  <%= doBean.getTrxTime()%> </td>           
	</tr>                
                
	  <tr class=baru valign=top> 
		<td align="left"><b> Ref. Document </td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><%= doBean.getSalesRefNo() %></td>
                 <td align="left" width="60" nowrap></td>
		<td align="left"><b> Location </td>
                <td class="td1" nowrap align="left"><b>:</td>
		<td align="left"><b><std:text value="<%= outlet.getName() %>"/></td>
	</tr>          
	
	<%
		if (doBean.getAdjstRefNo() != null && doBean.getAdjstRefNo().length() > 0) {
	%>
	
	  <tr class=baru valign=top> 
		<td class="td1"><b>Ref. Document :</td>
                <td></td>
		<td colspan="2"><b><%= doBean.getAdjstRefNo() %></td>
	</tr>
	
	<%
		}
	%>	
        
        

    <tr>
        <td colspan="4">  </td>            
    </tr>          
	
</table>
