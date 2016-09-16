      	  <table width="100%">
  
  			 <tr valign=top>
			   <td width=50%>
			     <table>
			      <tr>
			         <td ><b><i18n:label code="GENERAL_PROCESSED_BY"/></b> </td>
			         <td>:</td>
			         <td><%=invenBean.getStd_createBy()%></td>
			       </tr>			       
			       <tr>
			         <td><b><i18n:label code="GENERAL_DATE"/></b></td>
			         <td>:</td>
			         <td><fmt:formatDate pattern="<%=loginUser.getDateformat()%>" value="<%= invenBean.getStd_createDate()%>" /></td>
			       </tr>
			     </table>
			   </td>
			   
			    <td width=50%>
			      <table width="100%">
			  	    <tr>
			  	      <td width="40%"><b><i18n:label code="GENERAL_AUTHORIZED_BY"/></b></td>
			  	    </tr>
			  	    <tr>
			  	     <td>&nbsp;</td>
			  	    </tr>
			  	    <tr>
			  	      <td>&nbsp;</td>
			  	    </tr>
			  	    <tr>
			  	      <td>&nbsp;</td>
			  	    </tr>
			  	    <tr>
			  	      <td>&nbsp;</td>
			  	    </tr>
			  	    <tr>
			  	      <td>&nbsp;</td>
			  	    </tr>
			  	    <tr>
			  	      <td><hr></td>
			  	    </tr>
			  	    <tr>
			  	      <td align=left><i18n:label code="<%=InventoryMessageTag.SIGNATURE_COMP_OFF_CHOP%>"/></td>
			  	    </tr>
			  	  </table>
			    </td>
      	
			 </tr>
      	  </table>