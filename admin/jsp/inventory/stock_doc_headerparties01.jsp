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
     	      	<c:when test="<%=(invenBean!=null && invenBean.getTargetRemark()!=null)%>">	 
			          <table width="100%">
				            <tr>
				      	      <td colspan=3><b><font size=2 face="Arial"><i18n:label code="GENERAL_PERSON_INVOLVED"/></font></b></td>
				      	    </tr>
				            <tr>
				      	      <td colspan=3><%=invenBean.getTargetRemark().replaceAll("\n","<br>")%></td>
				      	    </tr>	      	    
				          </table>
				   </c:when>
				 </c:choose>				   
		      	</td>
	       </tr>
	 </table>   