<table class="listbox">
    <tr class="boxhead" valign="top">
        <td width="5%" nowrap><i18n:label code="GENERAL_NUMBER"/></td>
        <td width="15%" nowrap>Item Number</td>
        <td nowrap>Description</td>
        <td width="16%" align="right">Charge (<%= bean.getLocalCurrencySymbol() %>)</td>
    </tr>
    
    <%      // for item selling
    
    int j = 0;
    
    CounterSalesItemBean[] itemSales = bean.getItemArray();
    
    for (int i = 0; i < itemSales.length; i++) {
        
        if(itemSales[i].getUnitNetPrice() > 0) {              
    %> 	
    <tr class="<%= ((j+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= j+1 %>.</td>
        <td nowrap ><%= itemSales[i].getProductCode()%> <br>SN : <%= itemSales[i].getProductSKU() %></td>
        <td><%= itemSales[i].getProductDesc() %></td>
        <td align="right"><std:currencyformater code="" value="<%= itemSales[i].getUnitNetPrice() %>"/></td>
    </tr>	
    <% 
    j++;
        }  // end if
    } // end for itemSales
    %>
    
    <tr class="boxhead" valign="top">
        <td align="Left" width="5%" nowrap colspan="4 ">KIT Detail</td>
    </tr>
    
    <%      // for item Non selling
    
    int no = 0;    
    String code_a = "";
    
    String code = "";
    String name = "";
    
    int qty  = 0;
    int qty1 = 0;
    String code1 = "";
    String name1 = "";
    
    CounterSalesItemBean[] itemSales2 = bean.getItemArray();
    
    for (int y = 0; y < itemSales2.length && itemSales2[y].getUnitNetPrice() == 0 ; y++) {
        
        code_a = itemSales2[y].getProductCode().trim();
        
        if(itemSales2[y].getDeliveryStatus() == 20) {
            qty = itemSales2[y].getQtyOrder();
        } else{
            qty = 0;
        }
        
        if(!code_a.equalsIgnoreCase(code)) {
            
            if(!code.equalsIgnoreCase("")) {
                if(y > 1)
                  {  
    %>
    
    <tr class="<%= ((no) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= no %>.</td>
        <td nowrap ><%= code1 %></td>
        <td><%= name1 %> (<%= qty1 %>)</td>
        <td align="right"></td>
    </tr>            
    
    <%   
            }else{                    
     %>      
     
    <tr class="<%= ((no+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= no %>.</td>
        <td nowrap ><%= code %></td>
        <td><%= name %> (<%= qty1 %>)</td>
        <td align="right"></td>
    </tr>                        
                 
     
     <%               
            }
            }
            
            no++; 
            qty1  = qty;
            code = itemSales2[y].getProductCode().trim();
            name = itemSales2[y].getProductDesc().trim();
            
            
        }else{
            
            qty1  = qty1 + qty;
            code1 = itemSales2[y].getProductCode().trim();
            name1 = itemSales2[y].getProductDesc().trim();
     
       } // end if
    } // end for itemSales
    %>
    
    <% if(!code1.trim().equalsIgnoreCase(""))
       { 
    %>
    <tr class="<%= ((no) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= no %>.</td>
        <td nowrap ><%= code1 %></td>
        <td><%= name1 %> (<%= qty1 %>)</td>
        <td align="right"></td>
    </tr>          
    <% }else{       
    %>
    <tr class="<%= ((no+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= no %>.</td>
        <td nowrap ><%= code %></td>
        <td><%= name %> (<%= qty1 %>)</td>
        <td align="right"></td>
    </tr>    
    
    <% }      
    %>    
    <br><br>
    
    <tr>
        <td align="right" colspan="3"><b>Total :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getBvSalesAmount() %>"/></td>
    </tr>
    
    <%
    if (bean.getDeliveryAmount() != 0) {
    %>   	
    <tr>
        <td align="right" colspan="3"><b>Deposit :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getDeliveryAmount() %>"/></td>
    </tr>
    
    <%
    }
    %>
    
    <%
    if (bean.getDiscountAmount() != 0) {
    %>               
    <tr>
        <td align="right" colspan="3"><b>Voucher :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getDiscountAmount() %>"/></td>
    </tr>
    
    <%
    }
    %>
    
    <%
    if (bean.getMgmtAmount() != 0) {
    %>	
    <tr>
        <td align="right"  colspan="3"><b><i18n:label code="SALES_MGMT_FEE"/> :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getMgmtAmount() %>"/></td>
    </tr>
    
    <%
    }
    %>	        
    
    <tr>
        <td align="right"  colspan="3"><b>Payment :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>
    </tr>                
    <tr>
        <td align="right"  colspan="3"><b>Balance :</b>
        <td align="right" ><b><std:currencyformater code="" value="<%= bean.getPaymentChange() %>"/></td>
    </tr>        
    
    
</table>



