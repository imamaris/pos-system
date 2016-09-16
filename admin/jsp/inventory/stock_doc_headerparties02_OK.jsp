	<table width="100%">    
	     <tr>
	      	<td valign=top width=46%>
	          <table width="100%">
	            <tr>
	      	      <td colspan=3><b><font size=2 face="Arial"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/></font></b></td>
	      	    </tr>	      	    
	      	    <tr>
	      	      <td width=15%><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.NAME%>"/></td>
	      	      <td width=5%>:</td>
	      	      <td align=left>
	      	      	<%=outlet.getName()%> (<%=outlet.getOutletID()%>)	    
	      	      </td>
	      	    </tr>
	      	    <tr>
	      	      <td width=15%></td>
	      	      <td width=5%></td>
	      	      <td align=left></td>
	      	    </tr>
	          </table>
	        </td>
	        <td valign=center width=4% align=left>
	        <b><font size=2 face="Arial"> <i18n:label code="GENERAL_TO"/> </font></b>
	        </td>
	        <td valign=top width=46%>
	          <table width="100%">
     	      <c:choose>
     	      	<c:when test="<%=(outletTo!=null)%>">	 
				<tr>
	      	      <td colspan=3><b><font size=2 face="Arial"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUTLET%>"/></font></b></td>
	      	    </tr>	      	    
	      	    <tr>
	      	      <td width=15%><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.NAME%>"/></td>
	      	      <td width=5%>:</td>
	      	      <td align=left>
	      	      	<%=outletTo.getName()%> (<%=outletTo.getOutletID()%>)	    
	      	      </td>
	      	    </tr>
				</c:when>
			  </c:choose>	          
	            
	      	    <tr>
	      	      <td width=15%></td>
	      	      <td width=5%></td>
	      	      <td align=left></td>
	      	    </tr>
	          </table>				   
		     </td>
	       </tr>
	 </table>   