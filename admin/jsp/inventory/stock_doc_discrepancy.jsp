<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  InventoryBean invenBean = (InventoryBean) returnBean.getReturnObject("InventoryBean");
  InventoryBean[] invenBeans = (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
  SupplierBean supplier = (SupplierBean) returnBean.getReturnObject("Supplier");
  
  String document_name = lang.display("STOCK_DISCREPANCY");
%>

<body onLoad="self.focus();">
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<%@ include file="/lib/return_error_msg.jsp"%>

<table width="100%">
 <tr>
   <td>
   <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
   </td>
 </tr>
</table>
 
<table width="100%">
<tr>
<td>
  <%@ include file="/admin/jsp/inventory/stock_doc_headerdoc.jsp"%>
</td>
</tr>

<tr>
<td>
  <%@ include file="/admin/jsp/inventory/stock_doc_headerparties.jsp"%>
</td>
</tr>

<tr>
  <td>
    <table class="listbox" width=100%>
	  	<tr class="boxhead" valign=top>
	
	  		<td align="right" width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
	  		<td align="left" width="15%"><i18n:label code="<%=InventoryMessageTag.PRODUCT_CODE%>"/></td>
	  		<td align="left" width="30%"><i18n:label code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
	  		<td align=right width="8%"><i18n:label code="STOCK_QTY_ADJ"/></td>
	     </tr>
	
	<% 
	    for(int i=0; i<invenBeans.length;i++){
	%>             
	     <tr valign=top>
	  		<td align="right"><%=i+1%>.</td>
	  		<td align="left"><%=invenBeans[i].getProductBean().getProductCode() %></td>
	  		<td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
	  		<td align=right>
	  		
		  	 <c:choose>
	   	      	<c:when test="<%=(invenBeans[i].getTotalOut()> 0)%>">	      	      	
	   	      	 - <%= invenBeans[i].getTotalOut() %>	
	   	      	</c:when>	   	      	
	   	      	<c:when test="<%=(invenBeans[i].getTotalIn()> 0)%>">	      	      	
	   	      	    <%= invenBeans[i].getTotalIn() %>	
	   	      	</c:when>
	   	     </c:choose> 
	  		</td>
	     </tr>
	<%   
	   }//end for 
	%>
	</table>
  </td>
</tr>

<tr>
   <td><hr></td>
</tr>

<tr>
<td><b><i18n:label code="GENERAL_REMARK"/> : </b><br>
		<%= ((invenBean.getRemark()!=null && invenBean.getRemark().length()>0)?invenBean.getRemark().replaceAll("\n","<br>"):"-")%>
</td>
</tr>

<tr>
   <td>&nbsp;</td>
</tr>

<tr>
   <td>
     <%@ include file="/admin/jsp/inventory/stock_doc_bottomsign01.jsp"%>
   </td>
</tr>


</table>

<table width="100%">
 <tr>
   <td>
   <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
   </td>
 </tr>
</table>
  	
</form>
</body>
</html>