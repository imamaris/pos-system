      	  <table width="100%">
      	  <%@ page import="com.ecosmosis.orca.msgcode.*"%>
  
  			 <tr valign=top>
			   <td width=50%>
			     <table>
			      <tr>
			         <td ><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PROCESSED_BY%>"/></b> </td>
			         <td>:</td>
			         <td><%=invenBean.getStd_createBy()%></td>
			       </tr>			       
			       <tr>
			         <td><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></b></td>
			         <td>:</td>
			         <td><fmt:formatDate pattern="<%=loginUser.getDateformat()%>" value="<%= invenBean.getStd_createDate()%>" /></td>
			       </tr>
			     </table>
			   </td>
			   
			    <td width=50%>
			      <table width="100%">
			  	    <tr>
			  	      <td width="40%"><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.RECEIVED_IN_GOOD_COND%>"/></b></td>
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
			  	      <td align=left><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.SIGNATURE_COMP_OFF_CHOP%>"/></td>
			  	    </tr>
			  	  </table>
			    </td>
      	
			 </tr>
      	  </table>