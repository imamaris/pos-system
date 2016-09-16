	<table width="100%">
	      <tr>
	        <td valign=top width="70%" >
                    <table width="100%" border="0" style="border:1px #000000 solid pading:3">
                        <tr>
                            <td colspan=3 align=center height="20"><b><font size=4 face="Arial">STOCK LOAN </font></b></td>
                        </tr>
                    </table>
                    
                    <table width="100%" border="0" style="border:1px #000000 solid pading:3">
	      	    <tr>
	      	      <td width="25%"  align=left><b>Document No.</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%=invenBean.getTrnxDocNo()%></td>
	      	    </tr>
	      	    <tr>
	      	      <td width="25%"  align=left><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= invenBean.getTrnxDate()%>" /></td>
	      	    </tr>
                    
	      	    <tr>
	      	      <td align=left><b>From Personal</b></td>
	      	      <td>:</td>
	      	      <td nowrap align=left><%= invenBean.getTarget() %> (<%=invenBean.getTargetRemark()%>)</td>
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

	      	  </table>
	      	</td>
	      	<td width="30%"></td>
	                
	      </tr>
	</table>