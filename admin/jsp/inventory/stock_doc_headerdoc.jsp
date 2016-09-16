	<table width="100%">
	      <tr>
	      	<td width=50%>&nbsp;</td>
	
	        <td valign=top width=50%>
	      	  <table width="100%">
	      	    <tr>
	      	      <td colspan=3 align=right><b><font size=4 face="Arial">INTER WAREHOUSE TRANSFER </font></b></td>
	      	    </tr>
	      	    <tr>
	      	      <td align=right><b>Document No.</b></td>
	      	      <td>:</td>
	      	      <td width=15% nowrap align=right><%=invenBean.getTrnxDocNo()%></td>
	      	    </tr>
	      	    <tr>
	      	      <td align=right><b><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.DATE%>"/></b></td>
	      	      <td>:</td>
	      	      <td nowrap align=right><fmt:formatDate  pattern="dd MMMM yyyy" type="both" value="<%= invenBean.getTrnxDate()%>" /></td>
	      	    </tr>
                   
	            <tr>
	      	      <td colspan=3>&nbsp;</td>
	      	    </tr>
	      	  </table>
	      	</td>
	      </tr>
	</table>