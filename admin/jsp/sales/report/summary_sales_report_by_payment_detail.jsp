<table class="outbox" width="80%">
    <tr class="boxhead" valign="top">
            <td><b><i18n:label code="DETAIL SALES REPORT"/><br />
                   <i18n:label code="From "/><%= date1 %>
                   <i18n:label code="until "/><%= date2 %>
            </td>
        </tr>
        <tr>
            <td><b><i18n:label code="Format : By Payment Type, Currency, Date"/></b></td>
        </tr>
        <tr>
            <td>
                <table class="listbox" width="100%">
                    <tr class="boxhead" valign="top">
                        <td><i18n:label code="GENERAL_NUMBER"/></td>
                        <td>Date</td>
                        <td>Invoice</td>
                        <td>Amount</td>
                        <td>Rate</td>
                        <td>Conversion</td>
                        <td>Card Number</td>
                    </tr>
                    <%
                        String payType = "";String payType2 = "";
                        String curr = "";
                        String payEdc = "";
                        String payEdcS = "";
                        String payTypeSub = "";
                        double rate = bean[0].getRate();
                        double sumConversion = 0; double sumConversion2 = 0;
                        double conversion = 0;
                        int index = 0;
                        double amtCurr = 0; double amtCurr2 = 0;
                        for(int i = 0; i < bean.length; i++ ){
                            String rowCss = "";
                        if((i % 2) == 0 )
                            rowCss="even";
                        else
                            rowCss="odd";
                    %>
                    <%
                        String bank = "";
                        if(payEdc.contains("CTBK")){
                            bank = "CTBK";
                        }else if(payEdc.contains("BCA")){
                            bank = "BCA";
                        }else if(payEdc.contains("MDR")){
                            bank = "Bank Mandiri";
                        }else if(payEdc.contains("DNMN") || payEdc.contains("DNM")){
                            bank = "Bank Danamon";
                        }else if(payEdc.contains("BRI")){
                            bank = "BRI";
                        }else if(payEdc.contains("MEGA")){
                            bank = "Bank MEGA";
                        }else if(payEdc.contains("BNI")){
                            bank = "BANK BNI";
                        }
                        
                    %>
                    <%
                        if(!(bean[i].getPaymodeTime()+bean[i].getPaymodeEdc()+bean[i].getCurrency()).equals(payType+payEdcS+curr)){ 
                                if(!payType.equals("")){
                    %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total Currency <%= curr %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtCurr - amtCurr2 %>" /></b></td>
                        <td align="center"><b><%= rate %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= sumConversion - sumConversion2 %>" /></b></td>
                        <td></td>
                    </tr>
                    
                    <% if((payType).equals("VISA/MASTER")){ 
                        if(bean[i].getCurrency().equals("IDR")){
                        %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total <%= payType %> Payment - <%= bank %> </b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= sumConversion - sumConversion2 %>" /></b></td>
                        <td></td>
                    </tr>
                    <% 
                        }
                        }else{
                        if(bean[i].getCurrency().equals("IDR")){
                            if(curr.equals("USD")){
                    %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total <%= payType %> Payment </b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%=  sumConversion %>" /></b></td>
                        <td></td>
                    </tr>
                    <% }else{ %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total <%= payType %> Payment </b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= sumConversion - sumConversion2 %>" /></b></td>
                        <td></td>
                    </tr>
                    <%
                        }
                        }
                        }
                    %>
                    <% 
                                } 
                          amtCurr2 = amtCurr;  
                          sumConversion2 = sumConversion;
                          payType2 = payType;
                    %>
                    <% if(bean[i].getPaymodeTime().equals("VISA/MASTER")){ 
                    %>
                    <%
                               bank = "";
                               payEdc = bean[i].getPaymodeEdc();
                        if(payEdc.contains("CTBK")){
                            bank = "CTBK";
                        }else if(payEdc.contains("BCA")){
                            bank = "BCA";
                        }else if(payEdc.contains("MDR")){
                            bank = "Bank Mandiri";
                        }else if(payEdc.contains("DNMN") || payEdc.contains("DNM")){
                            bank = "Bank Danamon";
                        }else if(payEdc.contains("BRI")){
                            bank = "BRI";
                        }else if(payEdc.contains("MEGA")){
                            bank = "Bank MEGA";
                        }else if(payEdc.contains("BNI")){
                            bank = "BANK BNI";
                        }
                               if(bean[i].getCurrency().equals("IDR")){
                              %>
                    <tr valign="top">
                        <td colspan="7" align="left"><b>Payment Type <%= bean[i].getPaymodeTime() %></b></td>
                    </tr>
                    <% 
                        }
                        }else{
                              if(bean[i].getCurrency().equals("IDR")){
                    %>
                    <tr valign="top">
                        <td colspan="7" align="left"><b>Payment Type <%= bean[i].getPaymodeTime() %></b></td>
                    </tr>
                    <% 
                        }
                        }
                    %>
                    <tr>
                        <td colspan="7" align="left"><b>Currency <%= bean[i].getCurrency() %></b></td>
                    </tr>
                    <%
                        }
                            payType = bean[i].getPaymodeTime();
                            payEdc = bean[i].getPaymodeEdc();
                            curr = bean[i].getCurrency();
                            amtCurr = amtCurr + bean[i].getAmount();
                            conversion = bean[i].getAmount() * bean[i].getRate();
                            sumConversion = sumConversion + conversion;
                            payEdcS = bean[i].getPaymodeEdc();
                            rate = bean[i].getRate();
                            for(int j = 0; j < 1; j++ ){
                    %>
                    <tr class="<%= rowCss %>">
                        <td align="center"><%= i+1 %></td>
                        <td><%= bean[i].getPaymodeExpired() %></td>
                        <td><%= bean[i].getPaymodeDesc() %></td>
                        <td align="right"><std:currencyformater code="" value="<%= bean[i].getAmount() %>" /></td>
                        <td align="center"><%= bean[i].getRate() %></td>
                        <td align="right"><std:currencyformater code="" value="<%= conversion %>" /></td>
                        <td align="left"><%= bean[i].getRefNo() %></td>
                    </tr>
                    
                    <%
                    }
                            payEdc = bean[i].getPaymodeEdc();
                    }
                    %>
                    
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total Currency <%= curr %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtCurr - amtCurr2 %>" /></b></td>
                        <td align="center"><b><%= rate %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= sumConversion - sumConversion2 %>" /></b></td>
                        <td></td>
                    </tr>
                    <% 
                    if(payType.contains("VISA/MASTER")){
                            
                        String bank = "";
                        if(payEdc.contains("CTBK")){
                            bank = "CTBK";
                        }else if(payEdc.contains("BCA")){
                            bank = "BCA";
                        }else if(payEdc.contains("MDR")){
                            bank = "Bank Mandiri";
                        }else if(payEdc.contains("DNMN") || payEdc.contains("DNM")){
                            bank = "Bank Danamon";
                        }else if(payEdc.contains("BRI")){
                            bank = "BRI";
                        }else if(payEdc.contains("MEGA")){
                            bank = "Bank MEGA";
                        }else if(payEdc.contains("BNI")){
                            bank = "BANK BNI";
                        }
                        
                    
                    %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total <%= payType %> Payment - <%= bank %></b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtCurr - amtCurr2 %>" /></b></td>
                        <td></td>
                    </tr>
                    <% 
                    }else{ 
                    %>
                    <tr>
                        <td colspan="3" align="right"><b>Sub Total <%= payType %> Payment</b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtCurr - amtCurr2 %>" /></b></td>
                        <td></td>
                    </tr>
                    <% 
                        }
                    %>
                    <tr>
                        <td colspan="3" align="right"><b>Grand Total</b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtCurr %>" /></b></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
</table>