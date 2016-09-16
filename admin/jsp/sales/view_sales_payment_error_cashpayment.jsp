<table border="0">
        <tr>		
		<td class="td1" width="300" valign="top" align="right">Payment Type :</td>                
		<td colspan="3" valign="top" align="right"></td>
	</tr>	
        
	<% 
		CounterSalesPaymentBean[] paymentList = bean.getPaymentArray();
		
                int panjang = 0;
                
		for (int m = 0; m < paymentList.length; m++) { 
			
			CounterSalesPaymentBean payment = paymentList[m];	
	%>
        
        <tr>		
		<td class="td1" colspan="4" width="300" valign="top" align="right"><%= payment.getPaymodeDesc() %> - <%= payment.getPaymodeEdc()%> - <%= payment.getPaymodeTime()%> </td>                
		<td valign="top" align="right"><std:currencyformater code="" value="<%= payment.getAmount() %>"/></td>
	</tr>	
              
	<% 
            panjang = payment.getRefNo().trim().length();
            
            if (payment.getRefNo().trim() != null && payment.getRefNo().length() > 0) 
            {
            %>
                        
            <% if (panjang > 16) {
                
                 System.out.println("masuk IF 16 " + panjang);
            %>    
                     
        <tr>		
		<td class="td1" colspan="4" width="300" valign="top" align="right" class="td1">Ref No. </td>
		<td valign="top" align="right">XXXX-XXXX-XXXX-<%=payment.getRefNo().substring(12,16).toString()%></td>
	</tr>
          
             <% } else { 
                
                System.out.println("masuk else " + panjang);                
                
                %>
             
            <% if (panjang > 0) {
                
                 System.out.println("masuk bukan paymentcash " + panjang);
            %>   
                
                <tr>		
		<td colspan="4" width="300" valign="top" align="right" class="td1">Ref No. </td>
		<td valign="top" align="right">XXXX-XXXX-XXXX-<%=payment.getRefNo().substring(12,panjang).toString()%></td>
	        </tr>
                
             
	<% 	
			} // end if
	%>    
                
	<% 	
			} // end if
	%>             
             
             
        
	<% 	
			} // end if
	%> 
        
	<% 	
			} // end for
	%>
        

        
</table>

	