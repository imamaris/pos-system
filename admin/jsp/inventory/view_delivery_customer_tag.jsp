
<!-- Document related -->
	
<table border="0">

        <tr class=baru valign=top>		
		<td colspan="2" valign="top" align="left"  ><b>CUSTOMER ID <B> </TD>
                <td colspan="3" valign="top" align="center"  ><b>CUSTOMER SIGNATURE <B> </TD>               
	</tr>
        
        <tr class=baru valign=top>
            <td colspan="3" valign="top" align="left"  ><std:text value="<%= doBean.getCustomerID() %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT"  > </TD>               
        </TR>
        
        <tr class=baru valign=top>
            <td colspan="3" valign="top" align="left"  ><std:text value="<%= bean.getCustomerName() %>"/></TD>
            <td colspan="2" valign="top" align="center"  > </TD>               
        </TR>
        
        
        <tr class=baru valign=top>
            <td colspan="3" valign="top" align="left" width="600"><std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine1()%>"/> <br> 
            <std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine2()%>"/>
            </TD>
            <td colspan="2" valign="top" align="RIGHT"> </TD>               
        </TR>

        <tr class=baru valign=top>
            <td colspan="3" valign="top" align="left"  ><std:text value="<%= doBean.getCustomerContact() != null ? doBean.getCustomerContact().replaceAll("\n", "<br>") : "-" %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT"  > </TD>               
        </TR>

        <tr class=baru valign=top>
            <td colspan="3" valign="top" align="left"  ></TD>
            <td colspan="2" valign="top" align="RIGHT"  > </TD>               
        </TR>   

        <tr class=baru valign=top>		
		<td colspan="2" valign="top" align="left"  ></TD>
                <td colspan="3" valign="top" align="center">_________________________</TD>               
	</tr>      
        
        <tr class=baru valign=top>		
		<td colspan="2" valign="top" align="left"  ></TD>
                <td colspan="3" valign="top" align="center"  ><std:text value="<%= bean.getCustomerName() %>"/></TD>               
	</tr>
        
        
</table>
