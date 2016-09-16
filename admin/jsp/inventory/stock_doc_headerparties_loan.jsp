<table width="100%" border="0" style="border:1px #000000 solid pading:3">
    <tr>
        <td colspan=3 align=center height="20"><b><font size=4 face="Arial">STOCK LOAN </font></b></td>
    </tr>
</table>

<table width="100%">
    <tr>
        <td height="15"></td>     
    </tr>
</table>


<table width="100%">
    <tr>      
        
        <td width="50%"  valign=top>                    
            <table border="0">
                <tr>
                    <td width="50%"  align=left><b>Document  No.</b></td>
                    <td>:</td>
                    <td nowrap align=left><b><%=invenBean.getTrnxDocNo()%></b></td>
                </tr>
                <tr>                                                            
                    <td align=left><b>Loan Type</b></td>
                    <td>:</td>
                    
   <%if(invenBean.getTrnxType().equalsIgnoreCase("SKLI") && invenBean.getStatus() == 100)
        { %>
        
            <td nowrap align=left><b>In </b></td>     
 
        <% 
        }else{     
        %>                     
                    
            <td nowrap align=left><b>Out </b></td>            
                    
        <% 
        }
        %>                     
                </tr>
                
            </table>
        </td>
        
        <td width="50%"  valign=top>                    
            <table border="0">
                <tr>
                    <td nowrap align=left><b>Date/Time</b></td>
                    <td></td>
                    <td nowrap align=left>: <b><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= invenBean.getTrnxDate()%>" /> <%= invenBean.getTrnxTime() %> </b> </td>
                </tr>
                
                <tr>
                    <td nowrap align=left><b>Remainder Date</b></td>
                    <td></td>
                    
   <%if(invenBean.getTrnxType().equalsIgnoreCase("SKLI") && invenBean.getStatus() == 100)
        { %>
        
            <td nowrap align=left>:</td>     
 
        <% 
        }else{     
        %>                     
                    
            <td nowrap align=left>: <b><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= startCal.getTime() %>" /> </b></td>
                    
        <% 
        }
        %>                     
                    
                </tr>
                <tr>
                    <td nowrap valign="top" align=left><b>Location</b></td>
                    <td valign="top"></td>
                    <td valign="top" align=left>: <b><%=outlet.getName()%> (<%=outlet.getOutletID()%>)</b></td>
                </tr>
                
            </table>
        </td>
        
    </tr>
    
</table>

<table width="100%">
    <tr>
        <td height="5"></td>     
    </tr>
</table>

