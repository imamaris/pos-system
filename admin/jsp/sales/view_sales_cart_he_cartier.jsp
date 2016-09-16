<table class="listbox">

<%
	int qtyOrder = 0;
	int qtyFoc = 0;
	int j = 0;
        String skuCode = "";
        String productCode = "";
        WarrantyManager wrtyMgr = new WarrantyManager();
	
	CounterSalesItemBean[] itemSales = bean.getItemArray();
	
	for (int i = 0; i < itemSales.length; i++) {

        if(itemSales[i].getUnitNetPrice() > 0)
           {              
                String eWarranty = wrtyMgr.getWarranty(itemSales[i].getProductCat(), itemSales[i].getProductID()) != null ? wrtyMgr.getWarranty(itemSales[i].getProductCat(), itemSales[i].getProductID()) : "0";
            
                String yyyy = itemSales[0].getMaster().getTrxDate().toString().substring(0,4);
                int yearyy = Integer.parseInt(yyyy) + Integer.parseInt(eWarranty);
                String month = String.valueOf(itemSales[i].getMaster().getTrxDate()).substring(5,7);
                String dd = String.valueOf(itemSales[i].getMaster().getTrxDate()).substring(8,10);
%>	

	  <tr class="baru" valign=top> 
		<td width="5%" nowrap align="center"><%= itemSales[i].getQtyOrder()%> </td>
		<td width="15%" nowrap ><%= itemSales[i].getProductCode()%></td>
        <td width="15%" nowrap ><%= itemSales[i].getProductCode().equalsIgnoreCase(itemSales[i].getProductSKU()) ? " - " : itemSales[i].getProductSKU() %></td>       
        <td width="20%"><%= itemSales[i].getProductDesc() %></td>
		<td width="16%" align="right" nowrap><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice() %>"/></td>
	</tr>
    <% if(eWarranty !=null && !eWarranty.equalsIgnoreCase("") && !eWarranty.equalsIgnoreCase("0")){
    %>
        <tr class=baru valign="top">
            <td width="5%" nowrap align="center"></td>
            <td width="15%" nowrap ></td>
            <td colspan="2" valign="top" align="left"><strong>Warranty for this timepiece is valid until <%= dd %>/<%= month %>/<%= yearyy %></strong></td>
        </tr>
        <tr class=baru valign=top> 
            <td height="5" colspan="4" ></td>
        </tr>
    <% } 
           else {
    %>
        <tr class=baru valign="top">
            <td width="5%" nowrap align="center"></td>
            <td width="15%" nowrap ></td>
            <td colspan="2" valign="top" align="left"></td>
        </tr>
        <tr class=baru valign=top> 
            <td height="5" colspan="4" ></td>
         </tr>
     <%
     }
     %>
        
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
	String code2 = "";
	String code3 = "";
    String name1 = "";
    
    CounterSalesItemBean[] itemSales2 = bean.getItemArray();
    
    for (int y = 0; y < itemSales2.length; y++) {
        
        if(itemSales2[y].getUnitNetPrice() == 0)
          {  
        
        code_a = itemSales2[y].getProductSKU().trim();
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
    
	  <tr class="baru" valign=top> 
		<td width="5%" nowrap align="center"><%= qty1 %></td>
		<td width="15%" nowrap ><%= code2 %></td>
        <td width="15%" nowrap ><%= code2.equalsIgnoreCase(code1) ? " - " : code1 %></td>       
        <td width="20%"><%= name1 %></td>
		<td width="16%" align="right" nowrap></td>
	</tr>	         
    
    <%   
            }else{
                    nomor++; 
                    // System.out.println("Masuk Beda 2, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1); 
     %>      
     
	  <tr class="baru" valign=top> 
		<td width="5%" nowrap align="center"><%= qty1 %></td>
		<td width="15%" nowrap ><%= code2 %></td>
        <td width="15%" nowrap ><%= code2.equalsIgnoreCase(code1) ? " - " : code1 %></td>       
        <td width="20%"><%= name1 %></td>
		<td width="16%" align="right" nowrap></td>
	</tr>	                     
                 
     
     <%               
            }
            }
            
            // no++; 
            code = itemSales2[y].getProductSKU().trim();

            qty1  = qty;
            code1 = itemSales2[y].getProductSKU().trim();
			code2 = itemSales2[y].getProductCode().trim();
            name1 = itemSales2[y].getProductDesc().trim();

        }
        // kondisi sama
        else{
            // chek nilai code1                        
            
            if(!code1.equalsIgnoreCase(itemSales2[y].getProductCode().trim())) 
            {    
                qty1  = qty1 + qty;
                code = itemSales2[y].getProductSKU().trim();
				code3= itemSales2[y].getProductCode().trim();
                name = itemSales2[y].getProductDesc().trim();                
            }else{                        
            
            qty1  = qty1 + qty;
            code1 = itemSales2[y].getProductSKU().trim();
			code2 = itemSales2[y].getProductCode().trim();
            name1 = itemSales2[y].getProductDesc().trim();
            
            }
            
       } // end if
        
       }  // end if itemSales2[y].getUnitNetPrice() == 0 
        
    } // end for itemSales
    %>
    
    <% 
     nomor++;
     // System.out.println("Masuk Akhir, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);                    
     if(!code1.equalsIgnoreCase("")){
    %>
    
	  <tr class="baru" valign=top> 
		<td width="5%" nowrap align="center"><%= qty1 %></td>
		<td width="15%" nowrap ><%= code2 %></td>
        <td width="15%" nowrap ><%= code2.equalsIgnoreCase(code1) ? " - " : code1 %></td>       
        <td width="20%"><%= name1 %></td>
		<td width="16%" align="right" nowrap></td>
	</tr>	
        
    <%
    }
    %>    
   
 <tr>
      <td width="650" height="30" colspan="5"></td>
   </tr> 
        
	  <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>TOTAL </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
	</tr>

	<%
		if (bean.getDeliveryAmount() != 0) {
	%>   	
          <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>DEPOSIT </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
	</tr>
        
	<%
		}
	%>
        
	<%
		if (bean.getDiscountAmount() != 0) {
	%>               
          <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b>VOUCHER </b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
	</tr>

	<%
		}
	%>
        
        <%
		if (bean.getMgmtAmount() != 0) {
	%>	
	  <tr class="baru" valign=top> 
		<td align="right" colspan="4"><b><i18n:label code="SALES_MGMT_FEE"/> :</b>
		<td align="right" ><b><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
	</tr>
	
	<%
		}
	%>	 
        
</table>



