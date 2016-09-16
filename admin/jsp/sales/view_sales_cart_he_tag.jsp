<table class="listbox">

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	int j = 0;
        String skuCode = "";
        String productCode = "";
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {

        if(itemSales[i].getUnitNetPrice() > 0)
           {               
%>	

          
	  <tr class=baru valign=top> 
		<td width="5%" nowrap align="center"><%= itemSales[i].getQtyOrder()%> </td>
		<td width="15%" nowrap ><%= itemSales[i].getProductCode()%> <br>SN : <%= itemSales[i].getProductSKU() %></td>
		<td ><%= itemSales[i].getProductDesc() %></td>
		<td width="16%" align="right" nowrap><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice() %>"/></td>
	 </tr>	
<% 
        j++; 
        } // end if
	} // end for itemSales
%>

	  <tr class=baru valign=top> 
                <td height="15" colspan="4" ></td>
	 </tr>
         
     
<%      // for item Non selling
    
    int no = 0;    
    int nomor = 0;
    String code_a = "";
    
    String code = "";
    String name = "";
    
    int qty  = 0;
    int qty1 = 0;
    String code1 = "";
    String name1 = "";
    
    CounterSalesItemBean[] itemSales2 = bean.getItemArray();
    
    for (int y = 0; y < itemSales2.length; y++) {
        
        if(itemSales2[y].getUnitNetPrice() == 0)
          {  
        
        code_a = itemSales2[y].getProductCode().trim();
        no++; 
        
        // System.out.println("Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1); 
        
        if(itemSales2[y].getDeliveryStatus() == 20) {
            qty = itemSales2[y].getQtyOrder();
        } else{
            qty = 0;
        }
        
        // kondisi beda
        if(!code_a.equalsIgnoreCase(code)) {
                        
            
            if(!code.equalsIgnoreCase("")) {
                if(y > 1)
                  {                                       
                   nomor++;
                   // System.out.println("Masuk Beda 1, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1); 
     %>
    
                        <tr  class=baru valign=top>
                        <td width="5%" align="center"><%= qty1 %></td>
                        <td width="15%" nowrap ><%= code1 %></td>
                        <td><%= name1 %></td>
                        <td width="16%" align="right"></td>
                        </tr>            
    
    <%   
            }else{
                    nomor++; 
                    // System.out.println("Masuk Beda 2, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1); 
     %>      
     
                        <tr  class=baru valign=top>
                        <td width="5%" align="center"><%= qty1 %></td>
                        <td width="15%" nowrap ><%= code1 %></td>
                        <td><%= name1 %></td>
                        <td width="16%" align="right"></td>
                        </tr>                          
                 
     
     <%               
            }
            }
            
            // no++; 
            code = itemSales2[y].getProductCode().trim();

            qty1  = qty;
            code1 = itemSales2[y].getProductCode().trim();
            name1 = itemSales2[y].getProductDesc().trim();

        }
        // kondisi sama
        else{
            // chek nilai code1                        
            
            if(!code1.equalsIgnoreCase(itemSales2[y].getProductCode().trim())) 
            {    
                qty1  = qty1 + qty;
                code = itemSales2[y].getProductCode().trim();
                name = itemSales2[y].getProductDesc().trim();                
            }else{                        
            
            qty1  = qty1 + qty;
            code1 = itemSales2[y].getProductCode().trim();
            name1 = itemSales2[y].getProductDesc().trim();
            
            }
            
       } // end if
        
       }  // end if itemSales2[y].getUnitNetPrice() == 0 
        
    } // end for itemSales
    %>
    
    <% 
     nomor++;
     // System.out.println("Masuk Akhir, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);                    
    %>
    
                        <tr  class=baru valign=top>
                        <td width="5%" align="center"><%= qty1 %></td>
                        <td width="15%" nowrap ><%= code1 %></td>
                        <td><%= name1 %></td>
                        <td width="16%" align="right"></td>
                        </tr>      
   
	  
         <tr class=baru valign=top> 
                <td height="15" colspan="4" ></td>
	 </tr>
        
	  <tr class=baru valign=top> 
		<td align="right" colspan="3"><b>Total :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
          <tr class=baru valign=top> 
		<td align="right" colspan="3"><b>Deposit :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
          <tr class=baru valign=top> 
		<td align="right" colspan="3"><b>Voucher :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>

	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	  <tr class=baru valign=top> 
		<td align="right"  colspan="3"><b><i18n:label code="SALES_MGMT_FEE"/> :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	
        
        
	  <tr class=baru valign=top> 
		<td align="right"  colspan="3"><b>Payment :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
	</tr>                
          <tr class=baru valign=top> 
		<td align="right"  colspan="3"><b>Balance :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
	</tr>        
        
</table>



