<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">

function validateQty(idx, qty) {

  var thisform = document.ops_inventory;
  var unit = qty.value;
  if (unit.length > 0){ 
     
     if (isNaN(unit) || unit<=0) {
	     alert("<i18n:label code="MSG_QTY_POSITIVE_INTEGER"/>");
	     qty.value = "";
	     qty.focus();     
	 }
	 
	 var bal = 0 ;
	 if(thisform.balance[idx]!=null){	 
	    bal = thisform.balance[idx].value;
	 }else{
	    bal = thisform.balance.value;
	 }

	 //To convert strings to numbers	 
	 unit = unit - 0;
	 bal = bal - 0;
	 	 
	 if (unit > bal){
	    
	     alert("<i18n:label code="STOCK_NOT_ENOUGH"/>");
	     qty.value = "";
	     qty.focus();  
	 }
  }  
  sumTotalQuantity();  
}

 function sumTotalQuantity(){
 
   var thisform = document.ops_inventory;
   var counter = 0;
   if(thisform.qty_out.length !=  null){

       for(var i=0; i<thisform.qty_out.length; i++){

          if(thisform.qty_out[i].value > 0)
              counter++;           
       }
    }else{
    
       if(thisform.qty_out.value > 0)
              counter++;
    }

    if(counter > 0)
       offButton(false);
    else
       offButton(true);      
 }
 
 function offButton(isFag){

     var thisform = document.ops_inventory;
     thisform.btnSubmit.disabled = isFag;
 }
 
 function searchInventory(){

  var myform = document.ops_inventory;
  
  if(confirm('<i18n:label code="MSG_CONFIRM"/>'))  {
     myform.action = '<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_PRE_ABOLISH, request)%>%>';
     myform.submit();
  }else{
     myform.id.value = myform._id.value;
  }
 } 
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  String id = (String) returnBean.getReturnObject("ID");

  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  OutletStoreBean store = (OutletStoreBean) returnBean.getReturnObject("Store");
  TreeMap stores = (TreeMap) returnBean.getReturnObject("Stores");
  TreeMap suppliers = (TreeMap) returnBean.getReturnObject("Suppliers");
  
  InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
%>
<body onLoad="self.focus();document.ops_inventory.id.focus();sumTotalQuantity();">

<%@ include file="/lib/return_error_msg.jsp"%>
<div class=functionhead><i18n:label code="STOCK_ABOLISH"/></div>

<form name="ops_inventory" action="<%=Sys.getControllerURL(InventoryManager.TASKID_STOCK_ABOLISH, request)%>" method="post">
<std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
<table>
	<tr>
		<td><b><i18n:label code="<%=InventoryMessageTag.OUTLET%>"/></b></td>
		<td>: <%= outlet.getOutletID() %> (<%= outlet.getName() %>)</td>
	</tr>
	<tr>
		<td><b><i18n:label code="<%=InventoryMessageTag.STORE%>"/></b></td>
		<td>: 
        	<std:input type="select" name="id" options="<%=stores%>" value="<%=store.getStoreID()%>" status="onChange=searchInventory();"/>
        	<b><%=store.getStoreID()%></b><input type=hidden name="_id" value="<%=store.getStoreID()%>">
        </td>
	</tr>	
	
</table>
<br>
<table class="listbox" width="70%">
  	<tr class="boxhead" valign=top>

  		<td align="right" width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
  		<td align="left" width="15%"><i18n:label code="<%=InventoryMessageTag.PRODUCT_CODE%>"/></td>
  		<td align="left" width="30%"><i18n:label code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
  		<td align=right width="8%"><i18n:label code="STOCK_QTY_ABOLISH"/></td>
  		<td align=right width="8%"><i18n:label code="STOCK_BALANCE"/></td>
     </tr>

<% 
    for(int i=0; i<invenBeans.length;i++){
%>             
     <tr class=<%=((i%2==0)?"odd":"even")%> valign=top>
  		<td align="right"><%=i+1%>.</td>
  		<td align="left"><%=invenBeans[i].getProductBean().getProductCode() %></td>
  		<td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
  		<td align=right><input type=text name="qty_out" maxlength=8 size=5 style="text-align:right" onKeyUp="validateQty( <%=i%>, this)"></td>
  		<td align=right><%=invenBeans[i].getTotal()%></td>
  		<input type=hidden name="product_id" value="<%=invenBeans[i].getProductBean().getProductID()%>">
  		<input type=hidden name="balance" value="<%=invenBeans[i].getTotal()%>">
     </tr>
<%   
    }//end for 
%>
</table>
</p>
<table width="70%">
  	<tr valign=top>
     <td align=left>
     <b><i18n:label code="GENERAL_REMARK"/> :</b>
      </td>
  	</tr>
  	<tr valign=top>
     <td align=left>
      <textarea name="Remark" rows="5" cols="50"></textarea>
      </td>
  	</tr>
  	<tr valign=top>
     <td align=right>
      <input type=submit name=btnSubmit value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">      	
      </td>
  	</tr>
</table>
  	
</form>
</body>
</html>