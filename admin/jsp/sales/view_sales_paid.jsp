<table width="650" border="0" cellpadding="0" cellspacing="0">
    
   <tr>
      <td width="650" height="30" colspan="5"></td>
   </tr> 
        
	  <tr class="baru" valign=top> 
		<td align="right" colspan="4" width="75%"><b>TOTAL PAID</b> </td>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>
           
   <tr>
      <td width="650" height="30" colspan="5"></td>
   </tr>       
   
          <tr class="baru" valign=top> 
		<td align="right" colspan="4" width="75%" ><b>BALANCE</b> </td>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr>       
                     
        
</table>



