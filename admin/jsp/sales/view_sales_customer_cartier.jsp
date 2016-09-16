<!-- Document related -->
	
<table width="650" border="0" cellpadding="0" cellspacing="0">

        <tr class="baru" valign=top >		
		<td valign="top" align="left" width="30%" colspan="2"  ><b>CUSTOMER ID <B> </TD>
                <td valign="top" align="left" width="40%" ></TD>
                <td valign="top" align="center" width="30%" colspan="2" ><b>CUSTOMER SIGNATURE <B> </TD>               
	</tr>
        
        <tr class="baru" valign=top>
            <td valign="top" align="left" width="5%"  ></TD>
            <td valign="top" align="left" width="25%" ><std:text value="<%= bean.getCustomerID() %>"/></TD>
            <td valign="top" align="center" width="70%" colspan="2" ></TD>             
        </TR>
        
        <tr class="baru" valign=top>
            <td valign="top" align="left" width="5%"  ></TD>
            <td valign="top" align="left" width="25%" ><std:text value="<%= bean.getCustomerName() %>"/></TD>
            <td valign="top" align="center" width="70%" colspan="2" ></TD>               
        </TR>
        
        <tr class="baru" valign=top>
            <td valign="top" align="left" width="5%"  ></TD>
            <td colspan="2" valign="top" align="left" width="65%"><std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine1()%>"/> <br> 
            <std:text value="<%= bean.getCustomerAddressBean().getMailAddressLine2()%>"/>
            </TD>
            <td  valign="top" align="RIGHT" width="30%"> </TD>               
        </TR>

        <tr class="baru" valign=top>
            <td valign="top" align="left" width="5%"  ></TD>
            <td colspan="2" valign="top" align="left" width="65%" ><std:text value="<%= bean.getCustomerContact() != null ? bean.getCustomerContact().replaceAll("\n", "<br>") : "-" %>"/></TD>
            <td colspan="2" valign="top" align="RIGHT" width="30%" > </TD>               
        </TR>

        <tr class="baru" valign=top>
            <td colspan="3" valign="top" align="left"  ></TD>
            <td colspan="2" valign="top" align="RIGHT"  > </TD>               
        </TR>   

        <tr class="baru" valign=top >		
		<td valign="top" align="left" width="30%" colspan="2"  ></TD>
                <td valign="top" align="left" width="40%" ></TD>
                <td valign="top" align="center" width="30%" colspan="2" >____________________________</TD>               
	</tr>
       
        <tr class="baru" valign=top>		
		<td valign="top" align="left" width="30%"  colspan="2" ></TD>
                <td valign="top" align="left" width="40%" ></TD>
                <td valign="top" align="center" width="30%" colspan="2"   ><B><std:text value="<%= bean.getCustomerName() %>"/></B></TD>               
	</tr>
        
        
</table>