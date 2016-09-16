    <tr>
        <td><b><i18n:label code="Format : By Brand, Type"/></b></td>
    </tr>
    <tr>
        <td>
            <table class="listbox" width="100%">
                <tr class="boxhead" valign=top>
                    <td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
                    <td>Type</td>
                    <td>Qty</td>
                    <td align="center">Gross Total (SGD)</td>
                    <td align="center">Gross Total</td>
                    <td align="center">Disc Total</td>    
                    <td align="center"><i18n:label code="GENERAL_NET_TOTAL"/></td>
                </tr>
                    <%
                        String brandName = "";
                        String namaBrand = "";
                        int qty = 0; int qty2 = 0; 
                        double grossUsd = 0; double grossUsd2 = 0;
                        double gross = 0; double gross2 = 0;
                        double disc = 0; double disc2 = 0;
                        double netTotal = 0; double netTotal2 = 0;
                        for(int i=0;i < beans.length;i++){
                            int status = 0;
                     %>
                     <%
                            String rowCss = "";
                            if((i+1) % 2 == 0)
                                rowCss = "even";
                            else
                                rowCss = "odd";
                    %>
                    <% 
                            // start
                    %>
                    
                    <%
                        if(!beans[i].getUnitSales().equals(namaBrand)){
                    %>
                    <%
                        if(qty != 0){
                    %>
                <tr>
                    <td nowrap colspan="2" align="right"><b>Sub Total Brand <%= namaBrand %> : </b></td>
                    <td align="center"><%= qty - qty2 %></td>
                    <td align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                </tr> 
                    <%
                        }
                        qty2 = qty;
                        grossUsd2 = grossUsd;
                        gross2 = gross;
                        disc2 = disc;
                        netTotal2 = netTotal;
                    %>
                <tr>
                    <td nowrap colspan="7"><b>Brand : <%= beans[i].getInventory() %></b></td>
                </tr>
                    <%
                        }
                    %>
                    <%
                        if(!(beans[i].getInventory()+(beans[i].getUnitSales())).equals(brandName+namaBrand)){
                    %>
                    
                    <tr >
                        <tr class="<%= rowCss %>">
                            <td><%= i+1 %></td>
                            <td nowrap><%= beans[i].getUnitSales() %></td>
                            <td nowrap align="center" valign="top"><%= beans[i].getQtyOrder() %></td>
                            <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitPrice() %>" /></td>
                            <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitDiscount() + beans[i].getUnitNetPrice() %>" /></td>
                            <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitDiscount() %>" /></td>
                            <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitNetPrice() %>" /></td>
                        </tr> 
                       
                    </tr>
                    <%
                    }                          
                    %>
                    <% 
                        namaBrand = beans[i].getInventory();
                        qty = qty + beans[i].getQtyOrder();
                        grossUsd = grossUsd + beans[i].getUnitPrice();
                        gross = gross + (beans[i].getUnitDiscount() + beans[i].getUnitNetPrice());
                        disc = disc + beans[i].getUnitDiscount();
                        netTotal = netTotal + beans[i].getUnitNetPrice();
                    %>
                    <% 
                       
                        } 
                        %>
                <tr>
                    <td colspan="2" align="right"><b>Sub Total Brand <%= namaBrand %> : </b></td>
                    <td align="center"><%= qty - qty2 %></td>
                    <td  align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                </tr>    
                <tr>
                    <td nowrap colspan="2" align="right"><b>Grand Total : </b></td>
                    <td align="center"><%= qty%></td>
                    <td  align="right"><std:currencyformater code="" value="<%= grossUsd %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= gross %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= disc %>" /></td>
                    <td  align="right"><std:currencyformater code="" value="<%= netTotal %>" /></td>
                </tr>
            </table>  
        </td>
    </tr>