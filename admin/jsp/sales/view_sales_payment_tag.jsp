<table border="0">

         <tr class=baru valign=top> 		
		<td colspan="4" valign="top" align="left"><b>PAYMENT TYPE :<B>
                </td>                
	</tr>	
        
	<% 
		CounterSalesPaymentBean[] paymentList = bean.getPaymentArray();
		
                int panjang = 0;
                
		for (int m = 0; m < paymentList.length; m++) { 
			
			CounterSalesPaymentBean payment = paymentList[m];	
	%>         
        
         <tr class=baru valign=top>                                    
		<td colspan="2" align="LEFT">   <%= ( payment.getPaymodeDesc().equalsIgnoreCase("CASH") ? payment.getPaymodeDesc() : payment.getPaymodeTime() ) %>    </td>                
		<td valign="top" align="CENTER"><%= payment.getCurrency() %></td>
                <td valign="top" align="right"><std:currencyformater code="" value="<%= payment.getAmount() %>"/></td>
	</tr>	
              
	<% 
            panjang = payment.getRefNo().trim().length();
            
            if (payment.getRefNo().trim() != null && payment.getRefNo().length() > 0) 
            {
            %>
                        
            <% if (panjang > 15) {
                
                 System.out.println("masuk IF 16 " + panjang);
            %>    
                     
         <tr class=baru valign=top> 		
		<td colspan="4" align="LEFT" >Ref No. XXXX-XXXX-XXXX-<%=payment.getRefNo().substring(12,16).toString()%> </td>
	</tr>
          
             <% } else { 
                
                System.out.println("masuk else " + panjang);                
                
                %>
             
            <% if (panjang > 0) {
                
                 System.out.println("masuk bukan paymentcash " + panjang);
            %>   
                                
         <tr class=baru valign=top> 		
		<td colspan="4" align="LEFT" >Ref No. <%=payment.getRefNo().toString()%> </td>
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

	