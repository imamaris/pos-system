<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@page import="com.ecosmosis.orca.outlet.store.OutletStoreBean"%>
<%@page import="com.ecosmosis.orca.supplier.SupplierBean"%>
<%@page import="com.ecosmosis.orca.product.*"%>

<%@ page import="java.sql.*" %>

<html>
<head>
<%@ include file="/lib/header.jsp"%>
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
    <table width="100%">
     
   <% if(invenBean.getStatus()==90 && invenBean.getTrnxType().equalsIgnoreCase("STAO"))
       { %>

       <table width="100%" class=noprint >
           <tr>
               <td width="50%" align="left">
                   <table width="25%" border="1" cellspacing="1" cellpadding="1">
                       <tr>         
                           <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="TW" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process Verify OUT" type="1"/> </b> </font></td>            
                       </tr>
                   </table>
               </td>
               <td width="50%" align="right">
                   <table width="25%" border="1" cellspacing="1" cellpadding="1">
                       <tr>         
                           <td align=center height="30" > <font color="red"> <b><std:doc_invt doc="VOID" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process VOID" type="1"/> </b> </font></td>            
                       </tr>
                   </table>
               </td>               
               
           </tr>
       </table>
      
     <% 
      } else if(invenBean.getStatus()==100 && invenBean.getTrnxType().equalsIgnoreCase("STAO"))
      {      
      %> 
     
      <table width="100%" >
          <tr>       
              <td width="15%" align="left"  height="30">
                  <input class=noprint type="button" value="  PRINT  " onclick="window.print()">
              </td>                    
              <td width="50%" align=center height="30" class=noprint > <font color="blue"> <b>This document has been verified out </b> </font> </td> 

               <td width="35%" align="right">
                   <table width="50%" border="1" cellspacing="1" cellpadding="1" class=noprint >
                       <tr>         
                           <td align=center height="30" class=noprint  > <font color="red"> <b><std:doc_invt doc="VOID" value2= "<%=invenBean.getTrnxDocNo() %>" value="Process VOID" type="1"/> </b> </font></td>            
                       </tr>
                   </table>
               </td>               
          </tr>
          
          <tr>       
              <td width="15%" align="left"  height="30">                  
              </td>                    
              <td width="50%" align=center height="30" class=noprint ></td> 

               <td width="35%" align="right">
                   <table width="50%" border="1" >
                       <tr>         
                           <td align=center height="30" class=noprint > <font color="red"> <b> Attention !! Please make sure this items in this document have not been sent yet </b> </font></td>            
                       </tr>
                   </table>
               </td>               
          </tr>
          
      </table>
      
     <% 
      } else {      
      %> 
     
      <table width="100%" >
          <tr>    
              <td width="15%" align="left"  height="30">
                  <input class=noprint type="button" value="  PRINT  " onclick="window.print()">
              </td>                 
              <td width="20%" align="left"  height="30">
                  
              </td>      
              
              <td width="65%" align=right height="30" > <font color="blue"> <b>This document has been VOIDED </b> </font> </td> 
          </tr>
      </table>
      
     <% } %>            
        
    </table>    
    
<table width="100%">
<tr>
<td>
  <%@ include file="/admin/jsp/inventory/stock_doc_headerparties02.jsp"%>
</td>
</tr>

<tr>
  <td>
    <table width="100%" border="0">
        <table width="100%" border="0" style="border:1px #000000 solid pading:3">  
            <tr valign=top >
                <td align=center width="3%"><i18n:label code="<%=StandardMessageTag.NO%>"/>.</td>
                <td align=center width="15%">Reference No </td>                       
                <td align=center width="30%">Description</td>
                <td align=center width="15%">Serial No</td>
                <td align=center width="5%">Qty</td>
            </tr>
        </table>
             <table width="100%" border="0" >  
                 <% 
                 int total = 0;                 
                 ProductManager productManager = new ProductManager();
                 // item
                 for(int i=0; i<invenBeans.length;i++){
                     
                 if(!invenBeans[i].getProductBean().getProductCode().equalsIgnoreCase("Y"))
                     {
                   total += invenBeans[i].getTotalOut();
                   

                 %>             
                 <tr>
                     <td align="center" width="3%"><%=i+1%>.</td>
                     <td align="left" width="15%"><%=invenBeans[i].getProductBean().getProductCode() %></td>                        
                     <td align="left" width="30%"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
                     <td align="left" width="15%"><%=invenBeans[i].getProductBean().getSkuCode() %></td>
                     <td align="center" width="5%"><%= invenBeans[i].getTotalOut() %></td>
                 </tr>
                 <%
                 }//end if 
                 }//end for 
                 %>
             </table>             

        
             <table width="100%" border="0" >  
                 <tr>
                 <td align="right" colspan="4" width="63%" ><b>Total Qty :</b></td>
                 <td align="center" width="5%"><b><%= total%> </b></td>
                 </tr>   
             </table>
	</table>
  </td>
</tr>

<table width="100%">
    <tr>
        <td height="150"></td>
    </tr>
</table>

<table width="100%" border="0" style="border:1px #000000 solid pading:3">  
    <tr>
        <td><b><i18n:label code="GENERAL_REMARK"/> : </b><br>
            <%= ((invenBean.getRemark()!=null && invenBean.getRemark().length()>0)?invenBean.getRemark().replaceAll("\n","<br>"):"-")%>
        </td>
    </tr>
</table>

<tr>
   <td>&nbsp;</td>
</tr>

<tr>
   <td>
     <%@ include file="/admin/jsp/inventory/stock_doc_bottomsign.jsp"%>
   </td>
</tr>

</table>
 
<%@ include file="/lib/return_error_msg.jsp"%> 
    
</body>
</html>