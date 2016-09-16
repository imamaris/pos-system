<!-- Document related -->
	
<table border="0">

        <tr>		
		<td colspan="2" valign="top" align="left" width="400"><b>CUSTOMER ID <B> </TD>
                <td colspan="2" valign="top" align="RIGHT" width="400"><b>CUSTOMER SIGNATURE <B> </TD>               
	</tr>
        
        <tr valign="top">
            <td colspan="2" valign="top" align="left" width="400"><std:text value="<%= bean.getCustomerID() %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT" width="400"> </TD>               
        </TR>
        
        <tr valign="top">
            <td colspan="2" valign="top" align="left" width="400"><std:text value="<%= bean.getCustomerName() %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT" width="400"> </TD>               
        </TR>
        
        <tr valign="top">
            <td colspan="3" valign="top" align="left" width="600"><std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine1()%>"/> <br> 
            <std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine2()%>"/>
            </TD>
            <td colspan="1" valign="top" align="RIGHT"> </TD>               
        </TR>

        <tr valign="top">
            <td colspan="2" valign="top" align="left" width="400"><std:text value="<%= bean.getCustomerContact() != null ? bean.getCustomerContact().replaceAll("\n", "<br>") : "-" %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT" width="400"> </TD>               
        </TR>

        <tr valign="top">
            <td colspan="2" valign="top" align="left" width="400"></TD>
            <td colspan="2" valign="top" align="RIGHT" width="400"> </TD>               
        </TR>   
        
        <tr valign="top">
            <td colspan="2" valign="top" align="left" width="400"></TD>
            <td valign="top" align="RIGHT" width="200"> </TD>               
            <td valign="top" align="center" width="200"><u> <std:text value="<%= bean.getCustomerName() %>"/></u> </TD>               
        </TR>   
        
</table>