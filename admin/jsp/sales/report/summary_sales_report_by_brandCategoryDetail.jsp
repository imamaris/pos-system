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
                        int quantity = 0;
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
                        if(!beans[i].getUnitSales().equals(namaBrand)){
                    %>
                    <%
                        if(qty != 0){
                    %>
                <tr>
                    <td nowrap colspan="2" align="right"><b>Sub Total Type <%= brandName %> : </b></td>
                    <td align="center"><%= qty - qty2 %></td>
                    <td align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                </tr>
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
                        <tr >
                            <td nowrap colspan="7"><b>Type : <%= beans[i].getUnitSales() %></b></td>
                        </tr>
                    <%
                        if(!(beans[i].getInventory()+(beans[i].getUnitSales())).equals(brandName+namaBrand)){
                    %>
                        <%
                            String type = "";
                            String paymentType = "";
                            String currency = "";
                            for(int j=0;j<bean.length;j++){
                        %>
                        <%
                            String rowCss2 = "";
                            if((j+1) % 2 == 0)
                                rowCss = "even";
                            else
                                rowCss = "odd";
                    %>
                    <%
                        if(beans[i].getInventory().equals(bean[j].getShipExpedition())){
                    %>
                            <tr class="<%= rowCss %>"> 
                                <td align="center"><%= j+1 %></td>
                                <td><%= bean[j].getTrxDocNo() %></td>
                                <td align="center"><std:currencyformater code="" value="<%= bean[j].getOtherAmount2() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount3()%>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount4() + bean[j].getOtherAmount5() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount4() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount5() %>" /></td>
                            </tr>
                    <% 
                             } //end if
                             } //end for(int j=0;j<bean.length;j++)
               
                    %>
                    <%
                    }                          
                    %>
                    </tr>
                    <%
                    }                          
                    %>
                    <% 
                        namaBrand = beans[i].getInventory();
                        brandName = beans[i].getUnitSales();
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
                    <td nowrap colspan="2" align="right"><b>Sub Total Type <%= brandName %> : </b></td>
                    <td align="center"><%= qty - qty2 %></td>
                    <td align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                    <td align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                </tr>
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