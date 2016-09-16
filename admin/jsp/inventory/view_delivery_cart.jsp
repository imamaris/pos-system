<table class="listbox">
    <tr class="boxhead" valign="top">
        <td width="5%" nowrap align="center"><i18n:label code="GENERAL_NUMBER"/></td>
        <td nowrap align="center"><i18n:label code="PRODUCT_SKU_CODE"/></td>
        <td nowrap align="center"><i18n:label code="PRODUCT_NAME"/></td>
        <td width="12%" align="center">Qty</td>
    </tr>
    
    <%
    String skuCode = "";
    
    DeliveryItemBean[] itemDo = doBean.getItemArray();
    
    for (int i = 0; i < itemDo.length; i++) {
        
        ProductBean product = itemDo[i].getProductBean();
        
        skuCode = product.getSkuCode() + " - " + product.getProductDescription().getName();
        
        if (itemDo[i].getProductType() == ProductManager.TYPE_FOCPRODUCT)
            skuCode += " [FOC]";
    %>
    
    
    <%
    DeliveryProductBean[] dpb = itemDo[i].getProductArray();
    
    for (int j=0; j <dpb.length; j++) {
        
        ProductBean component = dpb[j].getProductBean();
        
        if(component.getProductSelling().equalsIgnoreCase("Y")) { 
    %>
    
    <tr class="<%= ((i+1) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="center" ><%= i+1 %></td>
        <td nowrap><%= component.getProductCode() %></td>
        <td><%= component.getProductDescription().getName() %></td>
        <td align="center"><%= dpb[j].getQty() %></td>
    </tr>	
    
    <% 		
        } // end getProductSelling
    } // end for dpb
    %>
    
    <% 		
    } // end for itemDo
    %>
    
    <tr class="boxhead" valign="top">
        <td align="left" colspan="4" >KIT Detail</td>
    </tr>
    
    <%
    String skuCode1 = "";
    int no = 0;
    int nomor = 0;
    String code_a = "";
    
    String code = "";
    String name = "";
    
    int qty  = 0;
    int qty1 = 0;
    String code1 = "";
    String name1 = "";
    
    DeliveryItemBean[] itemDo1 = doBean.getItemArray();
    
    for (int i = 0; i < itemDo1.length; i++) {
        
        ProductBean product1 = itemDo1[i].getProductBean();
        
        skuCode1 = product1.getSkuCode() + " - " + product1.getProductDescription().getName();
        
        if (itemDo1[i].getProductType() == ProductManager.TYPE_FOCPRODUCT)
            skuCode1 += " [FOC]";
    %>        
    
    <%    
    
    DeliveryProductBean[] dpb_k = itemDo1[i].getProductArray();
    
    for (int m=0; m <dpb_k.length; m++) {
        
        ProductBean component_k = dpb_k[m].getProductBean();
        
        if(component_k.getProductSelling().equalsIgnoreCase("N")) {
            
            code_a = component_k.getProductCode().trim();
            qty = dpb_k[m].getQty();
            no++;
            
            //System.out.println("Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
            
            // kondisi beda
            if(!code_a.equalsIgnoreCase(code)) {                
                
                if(!code.equalsIgnoreCase("")) {
                    if(m > 1) {
                        nomor++;
                       // System.out.println("Masuk Beda 1, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
    %>
    
    <tr class="<%= ((nomor) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= nomor %>.</td>
        <td nowrap ><%= code1 %></td>
        <td><%= name1 %></td>
        <td align="center"><%= qty1 %></td>
    </tr>            
    
    <%   
                    }else{
                        nomor++;
                        //System.out.println("Masuk Beda 2, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);
    %>      
    
    <tr class="<%= ((nomor) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= nomor %>.</td>
        <td nowrap ><%= code1 %></td>
        <td><%= name1 %> </td>
        <td align="center"><%= qty1 %></td>
    </tr>        
    
    <%               
                    }
                    
                }
                
                // no++;
                code = component_k.getProductCode().trim();
                
                qty1  = qty;
                code1 = component_k.getProductCode().trim();
                name1 = component_k.getProductDescription().getName();
                
            }
            
            // kondisi sama
            else{
                // chek nilai code1
                
                if(!code1.equalsIgnoreCase(component_k.getProductCode().trim())) {
                    qty1  = qty1 + qty;
                    code = component_k.getProductCode().trim();
                    name = component_k.getProductDescription().getName();
                }else{
                    
                    qty1  = qty1 + qty;
                    code1 = component_k.getProductCode().trim();
                    name1 = component_k.getProductDescription().getName();
                    
                }
                
            } // end if
            
        } // end getProductSelling
        
    } // end for dpb_k
       
    %>
                  
    
    <% 		
    } // end for itemDo
    
    nomor++;
    //System.out.println("Masuk Akhir, Looping="+no+ " code="+code+" code_a "+code_a+ " code1="+code1+" name1="+name1+" qty1= "+qty1);    
    %>
    
    <tr class="<%= ((nomor) % 2 == 0) ? "even" : "odd" %>" valign=top>
        <td align="right"><%= nomor %>.</td>
        <td nowrap ><%= code1 %></td>
        <td><%= name1 %> </td>
        <td align="center"><%= qty1 %></td>
    </tr> 
    
    
</table>		