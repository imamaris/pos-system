<table width="650" border="0" cellpadding="0" cellspacing="0">	

        <tr class="baru" valign=top>
            <td valign="top" align="left" width="30%" colspan="2" ><b>PAYMENT TYPE :<B></TD>
            <td valign="top" align="center" width="70%" colspan="6" ></TD>               
        </TR>        
        
	<% 
		CounterSalesPaymentBean[] paymentList = bean.getPaymentArray();
		
                int panjang = 0;
                String bayar = "";
                
		for (int m = 0; m < paymentList.length; m++) { 
			
			CounterSalesPaymentBean payment = paymentList[m];
                        panjang = payment.getRefNo().trim().length();
                        
                        
	%>         
        
         <tr class="baru" valign=top>        
                 <td valign="top" align="left" width="5%"  ></TD>
		<td colspan="2" align="LEFT" width="10%" >   <%= ( payment.getPaymodeDesc().equalsIgnoreCase("CASH") ? payment.getPaymodeDesc() : payment.getPaymodeTime() ) %> </td>                
		<td valign="top" align="right" nowrap width="2%">  <%= payment.getCurrency()%> </td>
                <td valign="top" align="right" width="1%" ></td>
                <td valign="top" align="right" nowrap width="5%"> <%= payment.getCurrency().equalsIgnoreCase("IDR") ? "": payment.getAmount()%> </td>
                <td valign="top" align="right" width="2%" ></td>
                <%                  
                 if (payment.getRefNo().trim() != null && payment.getRefNo().length() > 0  && panjang > 15)
                 {    
                    // bayar = "test"; 
                    bayar = payment.getRefNo().substring(0,4).concat("-").concat(payment.getRefNo().substring(4,8)).concat("-").concat(payment.getRefNo().substring(8,12)).concat("-").concat(payment.getRefNo().substring(12,16));  
                %>
                      <td valign="top" align="left" width="40%" >  <%= bayar %> </td>                
                <%
                } else {
                %>
                
                <td valign="top" align="left" width="40%" > </td>

                <%
                }   // end if
                %>                
                
                <td valign="top" align="right" width="30%" ><std:currencyformater code="" value="<%= payment.getAmount() * payment.getRate() %>"/></td>
	</tr>	    
 
	<% 	
			} // end for
	%>
        

        
</table>

	