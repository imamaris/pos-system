
<table width="100%">
    <tr>              
        <td width="50%"  valign=top>                    
            <table border="0">
                <tr>
                    <td width="50%"  align=left colspan="3" ></td>
                </tr>
                <tr>
                    <td align=left colspan="3"></td>
                </tr>
                
            </table>
        </td>
        
        <td width="50%"  valign=top>                    
            <table border="0">
                <tr>
                    <td width="50%" valign="top" align=left><b>Purpose of Loan</b></td>
                    <td valign="top" align=left>:</td>
                    <td valign="top" align=left><b><%= ((invenBean.getRemark()!=null && invenBean.getRemark().length()>0)?invenBean.getRemark().replaceAll("\n","<br>"):"-")%> </b> </td>
                </tr>
                
                <tr>
                    <td align=left colspan="3"></td>
                </tr>
                <tr>
                    <td align=left colspan="3"></td>
                </tr>
            </table>
        </td>        
    </tr>
</table>

<table width="100%" border="0">
    
    <tr valign="top">
        <td colspan="4" height="10"></TD>
    </TR>              
    <tr>		
        <td colspan="2" valign="top" align="center" width="50%"><b>APPROVED BY <B> </TD>
        <td colspan="2" valign="top" align="center" width="50%"><b>RECEIPT BY <B> </TD>               
    </tr>        
    
    <tr valign="top">
        <td colspan="4" height="50"></TD>
    </TR>
    
    <tr valign="top">
        <td colspan="2" valign="top" align="center" >===============</TD>
        <td colspan="2" valign="top" align="center" >===============</TD>               
    </TR>   
    
    <tr valign="top">
        <td colspan="4" height="10"></TD>
    </TR>
    
    <tr>		
        <td colspan="2" valign="top" align="left" width="50%"><b>CUSTOMER ID <B> </TD>
        <td colspan="2" valign="top" align="RIGHT" width="50%"></TD>               
    </tr>
    
    <tr valign="top">
        <td colspan="2" valign="top" align="left" width="60%"><%= invenBean.getTarget() %></TD>
        <td colspan="2" valign="top" align="RIGHT"> </TD>               
    </TR>
    
    <tr valign="top">
        <td colspan="2" valign="top" align="left" width="60%"><%= invenBean.getTargetRemark() %></TD>
        <td colspan="2" valign="top" align="RIGHT"> </TD>               
    </TR>
    
    <tr valign="center">
        <td align="center" colspan="4" height="25"><b>Thank you for your patronage </b></td>   
    </tr>  
    
    <tr>
        <td align="left" width="15%">Validation No. </td>
        <td colspan="3" align="left">: <%= invenBean.getTrnxDocNo().getBytes()%> </td>                
    </tr>    
    
    <tr>
        <td align="left" width="15%">Printed By</td>
        
        <%if(invenBean.getTrnxType().equalsIgnoreCase("SKLI") || (invenBean.getTrnxType().equalsIgnoreCase("SKLO") && invenBean.getStatus() < 100)  )
        { %>
        
        <td colspan="3" align="left">: <%= invenBean.getStd_createBy() %></td>
        
        <% 
        }else{     
        %>                     
        
        <td colspan="3" align="left">: <%= invenBean.getStd_modifyBy() %></td>
        
        <% 
        }
        %>                     
    </tr>                          
    
    
</table>