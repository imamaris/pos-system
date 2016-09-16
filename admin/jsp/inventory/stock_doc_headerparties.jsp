	<table width="100%">    
	     <tr>
	      	<td valign=top width=50%>
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
	      	      <td width=15%><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.STORE%>"/></td>
	      	      <td width=5%>:</td>
	      	      <td align=left>
	      	      	<%=invenBean.getStoreCode()%>
	      	      </td>
	      	    </tr>
	          </table>
	        </td>
	        
	        <td valign=top width=50%>
     	      <c:choose>
     	      	<c:when test="<%=(supplier!=null)%>">	 
			          <table width="100%">
				            <tr>
				      	      <td colspan=3><b><font size=2 face="Arial"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.SUPPLIER%>"/></font></b></td>
				      	    </tr>
				            <tr>
				      	      <td width=15%><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.NAME%>"/></td>
				      	      <td width=5%>:</td>
				      	      <td align=left><%=supplier.getName()%> (<%=supplier.getSupplierCode() %>)</td>
				      	    </tr>	      	    
				          </table>
				   </c:when>
				 </c:choose>				   
		      	</td>
	       </tr>
	 </table>   