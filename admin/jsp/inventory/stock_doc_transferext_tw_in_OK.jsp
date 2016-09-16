<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>

<%@ page import="java.sql.*" %>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
<script language="Javascript">
      
var echo  = 0;

function updateStatus(dokumen)
{ 

alert ("Do you want to Process ? "+dokumen); 

// if(dokumen.length() > 0)
// {
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return        
    }
 
    var url="NoVerifyout.jsp";   
    url=url+"?sku_kode="+dokumen+"&echo=" + echo;
    echo = echo + 1;       
    
 xmlHttp.onreadystatechange=function() {
    if (xmlHttp.readyState==4) {
      // alert(dokumen);
      stateChangedStatus(dokumen, xmlHttp.responseText);      
    }
  };
  
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
// }
// else
// {
   // alert("Please Fill Product Code 1 ...");
//   xmlHttp.close;
// }


}

function stateChangedStatus(dokumen, text) 
{ 
    //  document.getElementById("iprice_").value ="";	
        
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 { 
	
  // var showdata = xmlHttp.responseText; 
  // var strar = showdata.split("~");
  
  /*
  
  // alert(text);
  
	 if(strar.length==1)
	 {         
                document.getElementById("icode_").focus();   
                // alert ("a");
	 }
	 else if(strar.length>1)
	 {
            var strname = strar[1];
            document.getElementById("iprice_").value= strar[9];  
            // document.getElementsByName("DiscountAmount").value= strar[9];    
             // alert ("b");
     }

	 */
	
    alert("sampai sini");	 
	
 }
}
    
</script>
</head>
<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
  OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
  OutletBean outletTo = (OutletBean) returnBean.getReturnObject("OutletTo");
  
  InventoryBean invenBean = (InventoryBean) returnBean.getReturnObject("InventoryBean");
  InventoryBean[] invenBeans = (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
  String target = (String) returnBean.getReturnObject("Target");
	  
  String document_name = lang.display("STOCK_TRANSFER_EXTERNAL");
%>

<body onLoad="self.focus();">
<script language=Javascript src="<%= request.getContextPath()%>/lib/no_right_click.js"></script>
<%@ include file="/lib/return_error_msg.jsp"%>

<table width="100%">

     <td width="10%" align="left">
         <input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
     </td>
     
   <%if(!invenBean.getTrnxType().equalsIgnoreCase("STEI"))
        { %>
        
     <td width="35%" align=center> <font color="red"> <b><std:doc_invt doc="IN" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process Verify IN" type="1"/> </b> </font></td>      
     <td width="55%" align="Right"></td>
     
        <% 
        } else {      
        %> 
        
            <td width="80%" align="Left"> <font color="blue"> <b>This document has been Verified IN </b> </font> </td>   
        
        
        <% 
        
        } %>    
        
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
  <%@ include file="/admin/jsp/inventory/stock_doc_headerparties03.jsp"%>
</td>
</tr>

<tr>
  <td>
    <table class="listbox" width=100%>
	  	<tr class="boxhead" valign=top>
	  		<td align=center width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
	  		<td align=center width="15%">Reference Number</td>
                        <td align=center width="15%">Serial Number</td>
	  		<td align=center width="30%"><i18n:label code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
	  		<td align=center width="8%"><i18n:label code="STOCK_QTY_TRANSFERED"/></td>
	     </tr>
	
	<% 
	    for(int i=0; i<invenBeans.length;i++){
	%>             
	     <tr valign=top>
	  		<td align="right"><%=i+1%>.</td>
	  		<td align="left"><%=invenBeans[i].getProductBean().getProductCode() %></td>
                        <td align="left"><%=invenBeans[i].getProductBean().getSkuCode() %></td>
	  		<td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
                        
	  		<% if(!invenBeans[i].getTrnxType().equalsIgnoreCase("STAI"))
                            { %>
                        <td align=right><%= invenBeans[i].getTotalOut() %></td>
                        <% }else{ %>
                        <td align=right><%= invenBeans[i].getTotalIn()%></td>
                        <% }%>                        
                        
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
     <%@ include file="/admin/jsp/inventory/stock_doc_bottomsign.jsp"%>
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