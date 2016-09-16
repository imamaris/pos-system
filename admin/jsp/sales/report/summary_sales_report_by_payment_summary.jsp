<table class="outerbox" width="80%">
        <tr class="boxhead" valign="top">
            <td><b><i18n:label code="SUMMARY SALES REPORT"/><br />
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
                        <td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
                        <td>Payment Type</td>
                        <td width="10%">Currency</td>
                        <td>Date</td>
                        <td>Amount</td>
                        <td>Rate</td>
                        <td>Conversion</td>
                    </tr>
                    <% 
                        String curr = "";
                        String payType = "";
                        String payEdc = "";
                        double rate = 0;
                        double conversion = 0; double conversion2 = 0;
                        double sumConversion2 = 0; double sumConversion = 0;
                        double amtPayType = 0; double amtPayType2 = 0;
                        double amtCurr = 0; double amtCurr2 = 0;
                        for(int i = 0; i < beans.length; i++){
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
                            if(!(beans[i].getPaymodeEdc()+beans[i].getPaymodeTime()+beans[i].getCurrency()).equals(payEdc+payType+curr)){
                             if(!payType.equals("")){
                    %>
                    <%
                       
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Currency <%= curr %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                        <td align="center"><b></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2  %>" /></b></td>
                        
                    </tr>
                    
                    <%
                   
                    if(payType.equals("VISA/MASTER")){
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total <%= payType %> - <%= bank %></b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                    </tr>
                    <% 
                    }else{
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total <%= payType %></b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                    </tr>
                    <%
                    } 
                    %>
                    <% 
                        curr = beans[i].getCurrency();
                        payEdc = beans[i].getPaymodeEdc();
                        payType = beans[i].getPaymodeTime();
                        sumConversion2 = sumConversion;
                    %>
                    
                    <% 
                        } // end if payType != ""
                            amtPayType2 = amtPayType;
                            } // end if(paymentType)
                        curr = beans[i].getCurrency();
                        payType = beans[i].getPaymodeTime();
                        payEdc = beans[i].getPaymodeEdc();
                        amtPayType = amtPayType + beans[i].getAmount();
                        
                       // conversion = beans[i].getAmount() *  beans[i].getRate();
                        
                        sumConversion = sumConversion + conversion;
                    %>
                    <tr class="<%= rowCss %>">
                        <td align="center"><%= i+1 %></td>
                        <td align="left"><%= beans[i].getPaymodeTime() %></td>
                        <td align="left"><%= beans[i].getCurrency() %></td>
                        <td align="left"><%= beans[i].getPaymodeExpired() %></td>
                        <td align="right"><std:currencyformater code="" value="<%= beans[i].getAmount()/ beans[i].getRate() %>" /></td>
                        <td align="center"><%= beans[i].getRate() %></td>
                        <td align="right"><std:currencyformater code="" value="<%= beans[i].getAmount() %>" /></td>
                    </tr>
                    <% 
                        } // end for payment
                    %>
                    <%
                        String bank = "";
                        if(payEdc.contains("CTBK")){
                            bank = "CTBK";
                        }else if(payEdc.contains("BCA")){
                            bank = "BCA";
                        }else if(payEdc.contains("MDR")){
                            bank = "MDR";
                        }else if(payEdc.contains("DNMN")){
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
                        <td colspan="4" align="right"><b>Sub Total Currency <%= curr %> </b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                        <td align="center"><b></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                    </tr>
                    <% if(payType.equals("VISA/MASTER")){
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total <%= payType %> - <%= bank %></b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                    </tr>
                    <% 
                    }else{
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total <%= payType %> </b></td>
                        <td align="right"></td>
                        <td align="center"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType - amtPayType2 %>" /></b></td>
                    </tr>
                    <% 
                        }
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Grand Total </b></td>
                        <td></td>
                        <td></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= amtPayType %>" /></b></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>