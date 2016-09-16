	<table width="100%">
	      <tr>
	      	<td>&nbsp;</td>
	
	        <td valign=top >
	      	  <table width="100%">
	      	    <tr>
	      	      <td colspan=3 align=left><b><font size=4 face="Arial">INTER WAREHOUSE TRANSFER </font></b></td>
	      	    </tr>
	      	    <tr>
	      	      <td width=15%  align=left><b>Document No.</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%=invenBean.getTrnxDocNo()%></td>
	      	    </tr>
	      	    <tr>
	      	      <td width=15%  align=left><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= invenBean.getTrnxDate()%>" /></td>
	      	    </tr>
	      	    <tr>
	      	      <td width="25%"  align=left><b>Brand</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%= invenBean.getProductBean().getProductCategory().getName()%></td>
	      	    </tr>                     
	      	    <tr>
	      	      <td align=left><b>From Warehouse</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%=outletTo.getName()%> (<%=outletTo.getOutletID()%>)</td>
	      	    </tr>
	      	    <tr>
	      	      <td align=left><b>To Warehouse</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%=outlet.getName()%> (<%=outlet.getOutletID()%>)</td>
	      	    </tr>                    
	      	    <tr>
	      	      <td align=left><b>Print Date</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><fmt:formatDate pattern="dd MMMM yyyy" type="both" value="<%= invenBean.getStd_createDate()%>" /> </td>
	      	    </tr>                   
	      	    <tr>
	      	      <td align=left><b>Created By</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%=invenBean.getStd_createBy()%> </td>
	      	    </tr>                    
                    
	            <tr>
	      	      <td colspan=3>&nbsp;</td>
	      	    </tr>
	      	  </table>
	      	</td>
	      </tr>
	</table>

