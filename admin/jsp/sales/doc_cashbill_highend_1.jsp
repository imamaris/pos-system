<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.member.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<%@ page import="com.ecosmosis.orca.pricing.product.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  CounterSalesOrderBean bean = (CounterSalesOrderBean) returnBean.getReturnObject("CounterSalesOrderBean");
  CounterSalesOrderBean adjstBean = (CounterSalesOrderBean) returnBean.getReturnObject("AdjstCounterSalesOrderBean");
  
   OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");

  boolean canView = bean != null;

%>

<html>
<head>
    <title>Cash Bill</title>
    
    <%@ include file="/lib/header_without_css.jsp"%>
    
    
    <style type="text/css">
        
  a            {text-decoration:none;color:#FF0000}
  a:hover      {text-decoration:none;color:#0000CC}
  p            {font-family:Verdana,Arial,Helvetica;font-size:8pt;color:#000000}
  p.title      {font-family:Verdana,Arial,Helvetica;font-size:13pt;color:#000000;font-weight:bold}
  p.mini       {font-family:Verdana,Arial,Helvetica;font-size:8pt;color:#FFFFFF}
  p.detail     {font-family:Arial,Helvetica,Verdana;font-size:8pt;color:#000000}
  p.header     {font-family:Arial,Helvetica,Verdana;font-size:8pt;color:#000000;font-weight:bold}
  p.header1    {font-family:Arial,Helvetica,Verdana;font-size:12pt;color:#000000;font-weight:bold}
  p.header2    {font-family:Arial,Helvetica,Verdana;font-size:9pt;color:#000000;font-weight:bold}
  input.txtlbl {font-family:Verdana,Arial,Helvetica;font-size:8pt;font-weight:bold;border-right:medium none;border-left: medium none;border-top: medium none;border-bottom:medium none;display:inline;background:none transparent scroll repeat 0% 0%;text-align:left}
  input.txtdis {background:none transparent scroll repeat 0% 0%;text-align:left}
  input.txtnbr {font-family:Verdana,Arial,Helvetica;font-size:8pt;font-weight:bold;border-right:medium none;border-left: medium none;border-top: medium none;border-bottom:medium none;display:inline;background:none transparent scroll repeat 0% 0%;text-align:right}
  input.number {text-align:right}
  
        .baru {
        font-family: Arial; 
        font-size: 8pt; 
        TEXT-DECORATION: none; 
        color: black
        }
        
        .boxheadbaru {
        font-size: 6pt; 
        font-weight: bold;
        text-align: center;
        background-color: #E7E7E7;
        color: black;
        }
        
        .listboxbaru { 
        font-family: verdana, arial, sans-serif;
        font-size: 6pt;
        border: 1px solid #c0bab6;
        border-collapse: collapse;
        
        }
        
        .listboxbaru td {
        font-family: verdana, arial, sans-serif;
        font-size: 6pt;
        border: 1px solid #c0bab6;
        padding: 3px 3px 3px 3px
        }
        .barufooter {font-family: Arial; font-size: 7pt; TEXT-DECORATION: none; color: black}
        .barufooter2 {font-family: Arial; font-size: 7pt; TEXT-DECORATION: none; color: white}        
        @media print {
        .noprint  { display: none; }
        }
        
    </style>      
 
</head>

<body>

<%@ include file="/lib/return_error_msg.jsp"%>

<% 
if (canView) {
%>

<table width="100">
    <tr>
        <td>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onClick="window.print();">
        </td>
        <td>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_CLOSE"/>" onClick="window.close();">
        </td>
    </tr>
</table>

<br>
 
    <table class="tbldatabaru" border="0" width="650">                

   <tr>
      <td width="650" height="60"></td>
   </tr>
   
   <tr>
      <td width="650">
         <table width="650" border="1" bordercolor="#000000" cellpadding="2" cellspacing="0" style="border-collapse:collapse">
         <tr>
            <td width="650">
               <table width="650" border="0" cellpadding="0" cellspacing="0">
               <tr>
                  <td width="250"></td>
                  <td width="150"><p class="title" align="center"><b>INVOICE</b></p></td>
                  <td width="250"></td>
               </tr>
               </table>            </td>
         </tr>   
         </table>      </td>
   </tr>     
   
   <tr>
      <td width="650" height="30"></td>
   </tr>   
        
        <tr valign="top">
		<td valign=top width="650">
			<%@ include file="/admin/jsp/sales/view_sales_document_cartier.jsp"%>
		</td>
	</tr>

   <tr>
      <td width="650" height="30"></td>
   </tr>
   
	<tr valign=top>
		<td colspan="2" width="650">
		  <%@ include file="/admin/jsp/sales/view_sales_cart_he_cartier.jsp"%>                  
		</td>
	</tr>        
        
	<tr valign=top>
		<td colspan="2" width="650">
		  <%@ include file="/admin/jsp/sales/view_sales_payment_cartier.jsp"%>                  
		</td>
	</tr>
                

	<tr valign=top>
		<td colspan="2" width="650">
		  <%@ include file="/admin/jsp/sales/view_sales_paid.jsp"%>                  
		</td>
	</tr>   
 

   <tr>
      <td width="650" height="30"></td>
   </tr>        
        
        <tr valign="top">
		<td valign=top width="650">
			<%@ include file="/admin/jsp/sales/view_sales_customer_cartier.jsp"%>
		</td>
	</tr>        

        
   <tr>
      <td width="650" height="30"></td>
   </tr>
  
	<tr class="baru"  align="left">
	  <td colspan="2" width="650">Goods/products have been accepted by the customer as being in good condition.</td>   
  </tr>  
	<tr class="baru" align="left">
	  <td colspan="2" width="650">Goods/products sold are non-refundable, returnable or exchangeable.</td>   
  </tr> 
  	<tr class="baru" align="center">
	  <td colspan="2" width="650"></td>   
  </tr>  
  
   <tr>
      <td width="650" height="30"></td>
   </tr>
   
  	<tr class="baru" align="center">
	  <td colspan="2" width="650"><b>Thank you for your patronage.</b></td>   
          
  </tr>  
  
   <tr>
      <td width="650" height="30"></td>
   </tr>
  
       <tr class="baru" align="center">
		<td  colspan="2" align="left">Validation No. : <%= bean.getTrxDocNo().getBytes()%> </td>
	</tr>    
  
        <tr class="baru" align="center">
		<td colspan="2" align="left">Printed By : <%= bean.getStd_createBy() %></td>
	</tr> 
        
</table>	

<%
} // end canView
%>
