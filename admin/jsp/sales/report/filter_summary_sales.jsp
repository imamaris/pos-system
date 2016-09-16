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
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
  MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
  
	Map trxTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXTYPELIST_CODE);
	
	Map sellerMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SELLERLIST_CODE);
	
	Map bonusPeriodMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_BNSPERIODLIST_CODE);
	
	Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);
	
	Map trxStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STATUS_CODE);

	Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);
	
	Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);
	
	ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);
	
        CounterSalesItemBean[] beans = (CounterSalesItemBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARYREPORT_CODE);
        
        CounterSalesItemBean[] bean = (CounterSalesItemBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARYREPORT_DETAIL);

   
  boolean canView = beans != null;
%>

<html>
<head>
<title>
    </title>

	<%@ include file="/lib/header.jsp"%>	             

	<script language="javascript">
                        

  	function doSubmit(thisform) {
			
    	thisform.submit();
  	}   
        
         function gotoExcel(elemId, frmFldId)
              {  
                  var obj = document.getElementById(elemId);  
                  var oFld = document.getElementById(frmFldId);
                  
                  oFld.value = obj.innerHTML;
                  
                  document.forms["by_brand_excel_form"].submit();
              }
              
         function gotoPdf(elemId, frmFldId)
              {  
                  var obj = document.getElementById(elemId);  
                  var oFld = document.getElementById(frmFldId);
                  
                  oFld.value = obj.innerHTML;
                  
                  document.forms["by_brand_pdf_form"].submit();
              }
              
function printpage()
  {
  window.print();
  }

	</script>               
		
</head>

<body>

<div class="functionhead"><i18n:label code="SALES REPORT BY BRAND"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.SUMMARY_SALES_REPORT_ID,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	
    
        <table border="0">
          <tr>
            <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	  <tr>
              <td>Selection By:</td>
              <td><std:input type="radio" name="selection" value="1" status="checked"/><i18n:label code="Summary"/></td>
              <td><std:input type="radio" name="selection" value="2" status="unchecked"/><i18n:label code="Detail"/></td>
          </tr>
	</table>
        
        
	
	<br>
	
	<std:input type="" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
    <input class="textbutton" type="submit" value="REPORT PREVIEW">
</form>
        
        <div>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="printpage()" >
         </div>
        
<hr>

<br>
<% 
	if (canView && beans.length != 0) {
        String selection = request.getParameter("selection");
        String date1 = request.getParameter("TrxDateFrom");
        String date2 = request.getParameter("TrxDateTo");
        String exportName = null;
        if(selection.equals("1")){
            exportName = "SUMMARY_SALES_REPORT_BY_BRAND_TYPE_"+date1.replaceAll("-","")+"-"+date2.replaceAll("-","")+".xls";
        }else if(selection.equals("2")){
            exportName = "DETAIL_SALES_REPORT_BY_BRAND_TYPE_"+date1.replaceAll("-","")+"-"+date2.replaceAll("-","")+".xls";
        }
        
        // cek ke Pdf
        String exportNamePdf = "test.pdf";
        
        
        
%>

        <div>
            <form name="by_brand_excel_form" action="admin/jsp/sales/report/summary_report_excel.jsp" method="post">
                <input type="hidden" id="tableHTML" name="tableHTML" value="" />
                <input type="hidden" id="fileName" name="fileName" value="<%= exportName %>" />
                <input type="button" onclick="gotoExcel('tableData', 'tableHTML');" value="Export to Excel" />  
            </form>
        </div>

        <div>
            <form name="by_brand_pdf_form" action="admin/jsp/sales/report/summary_report_pdf.jsp" method="post">
                <input type="hidden" id="tableHTML2" name="tableHTML2" value="" />
                <input type="hidden" id="fileName2" name="fileName2" value="<%= exportNamePdf %>" />
                <input type="button" onclick="gotoPdf('tableData2', 'tableHTML2');" value="Export to Pdf" />  
            </form>
        </div>
        
                        
<form name="frmList" action="" method="post">
    
    <div id="tableData2">  
        <table class="outerbox" width="20%">
            <tr> <td>test</td> </tr>
        </table>
    </div>    
    
    <div id="tableData">     
        <table class="outerbox" width="80%">
            <tr class="boxhead" valign="top">
                <td>
                    <b><i18n:label code="SUMMARY SALES REPORT"/><br /> 
                  
                    <i18n:label code="From "/><%= date1 %>
                    <i18n:label code="To "/><%= date2 %>
                    
                </td> 
            </tr>
            <tr>
                <td><b><i18n:label code="Format : By Person, Brand"/></b></td>
            </tr>
            <tr>
                <td>
                    <table class="listbox" width="100%">
                        <tr class="boxhead" valign=top>
                            <td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
                            <td>Brand</td>
                            <td>Qty</td>
                            <td align="center">Gross Total (SGD)</td>
                            <td align="center">Gross Total</td>
                            <td align="center">Disc Total</td>
                            <td align="center"><i18n:label code="GENERAL_NET_TOTAL"/></td>
                        </tr>
                        <%
                        int salesId = 0 ;
                        String brandName = "";
                        String salesName = "";
                        int qty = 0; int qty2 = 0;
                        double grossUsd = 0; double grossUsd2 = 0;
                        double gross = 0; double gross2 = 0;
                        double disc = 0; double disc2 = 0;
                        double netTotal = 0; double netTotal2 = 0;
                        for(int i=0;i < beans.length;i++){
                        int status = 0;
                        %>
                        <%
                        String rowCss = "";
                        if((i+1) % 2 == 0)
                        rowCss = "even";
                        else
                        rowCss = "odd";
                        %>
                        
                        <%
                        if(!beans[i].getUnitSales().equals(salesName)){
                        %>
                        <%
                        if(qty != 0){
                        
                        %>
                        <tr>
                            <td nowrap colspan="2" align="right"><b>Sub Total Person 
                                    <%= salesName %>
                                    : 
                            </b></td>
                            <td align="center"><%= qty - qty2 %></td>
                            <td align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                            <td align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                            <td align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                            <td align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                        </tr> 
                        <%
                        }
                        qty2 = qty;
                        grossUsd2 = grossUsd;
                        gross2 = gross;
                        disc2 = disc;
                        netTotal2 = netTotal;
                        %>
                        <tr>
                            <td nowrap colspan="7"><b>Person : <%= beans[i].getUnitSales() %>
                            </b></td>
                        </tr>
                        <%
                        }
                        %>
                        
                        <%
                        if(!(beans[i].getInventory()+(beans[i].getUnitSales())).equals(brandName+salesName)){
                        %>
                        
                        <tr>
                            <tr class="<%= rowCss %>">
                                <td><%= i+1 %></td>
                                <td nowrap><%= beans[i].getInventory() %></td>
                                <td nowrap align="center" valign="top"><%= beans[i].getQtyOrder() %></td>
                                <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitPrice() %>" /></td>
                                <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitDiscount() + beans[i].getUnitNetPrice() %>" /></td>
                                <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitDiscount() %>" /></td>
                                <td nowrap align="right" valign="top"><std:currencyformater code="" value="<%= beans[i].getUnitNetPrice() %>" /></td>
                            </tr>
                            <%
                            // view detail
                            if(selection.equals("2")){
                            %>
                            <%  
                            // item
                            if(status == 0){
                            String brand = "";
                            String brand2 = "";
                            int qtyBrand = 0;int qtyBrand2 = 0;
                            double grossBrand = 0;double grossBrand2 = 0;
                            double grossBrandUsd = 0;double grossBrandUsd2 = 0;
                            double discBrand = 0;double discBrand2 = 0;
                            double netBrand = 0;double netBrand2 = 0;
                            if(qty == 0){
                            for(int item = 0; item < beans[i].getQtyOrder(); item++){
                            if(!bean[item].getUnitSales().equals(brand)){
                            String rowCss2 = "";
                            if(item % 2 == 0)
                            rowCss2 = "odd";
                            else
                            rowCss2 = "even";
                            %>
                            <tr class="<%= rowCss2 %>">
                                <td></td>
                                <td><%= bean[item].getUnitSales() %></td>
                                <td align="center"><%= bean[item].getQtyOrder() %></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[item].getUnitPrice() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[item].getUnitDiscount() + bean[item].getUnitNetPrice() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[item].getUnitDiscount() %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= bean[item].getUnitNetPrice() %>" /></td>
                            </tr>
                            <%
                            
                            }
                            brand = bean[item].getUnitSales();
                            }
                            }
                            else{
                            int jml = qty;
                            for(int item = 0 ; item < beans[i].getQtyOrder(); item++){
                            if(!bean[jml].getUnitSales().equals(brand2)){
                            if(qtyBrand != 0){
                            
                            String rowCss2 = "";
                            if((item+1) % 2 == 0)
                            rowCss2 = "odd";
                            else
                            rowCss2 = "even";
                            %>
                            <tr class="<%= rowCss2 %>">
                                <td></td>
                                <td><%= brand2 %></td>
                                <td align="center"><%= qtyBrand - qtyBrand2 %></td>
                                <td align="right"><std:currencyformater code="" value="<%= grossBrandUsd - grossBrandUsd2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= grossBrand - grossBrand2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= discBrand - discBrand2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= netBrand - netBrand2 %>" /></td>
                            </tr>
                            <%
                            }
                            brand2 = bean[jml].getUnitSales();
                            qtyBrand2 = qtyBrand;
                            grossBrandUsd2 = grossBrandUsd;
                            grossBrand2 = grossBrand;
                            discBrand2 = discBrand;
                            netBrand2 = netBrand;
                            }
                            qtyBrand = qtyBrand + bean[jml].getQtyOrder();
                            grossBrandUsd = grossBrandUsd + bean[jml].getUnitPrice();
                            grossBrand = grossBrand + (bean[jml].getUnitDiscount() + bean[jml].getUnitNetPrice());
                            discBrand = discBrand + bean[jml].getUnitDiscount();
                            netBrand = netBrand + bean[jml].getUnitNetPrice();
                            jml++;
                            }
                            %>
                            
                            <%
                            
                            }
                            status = 1;
                            if((qtyBrand - qtyBrand2) != 0){
                            %>
                            <tr class="<%= rowCss %>">
                                <td></td>
                                <td><%= brand2 %></td>
                                <td align="center"><%= qtyBrand - qtyBrand2 %></td>
                                <td align="right"><std:currencyformater code="" value="<%= grossBrandUsd - grossBrandUsd2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= grossBrand - grossBrand2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= discBrand - discBrand2 %>" /></td>
                                <td align="right"><std:currencyformater code="" value="<%= netBrand - netBrand2 %>" /></td>
                            </tr>
                            <%
                            }
                            }
                            
                            // end item
                            %>
                            
                            <% 
                            
                            // end view detail
                            }
                            
                            %>
                        </tr>
                        
                        <%
                        }                          
                        %>
                        <% 
                        salesName = beans[i].getUnitSales();
                        qty = qty + beans[i].getQtyOrder();
                        grossUsd = grossUsd + beans[i].getUnitPrice();
                        gross = gross + (beans[i].getUnitDiscount() + beans[i].getUnitNetPrice());
                        disc = disc + beans[i].getUnitDiscount();
                        netTotal = netTotal + beans[i].getUnitNetPrice();
                        %>
                        <% 
                        
                        } 
                        %>
                        <tr>
                            <td colspan="2" align="right"><b>Sub Total Person <%= salesName %> : </b></td>
                            <td align="center"><%= qty - qty2 %></td>
                            <td  align="right"><std:currencyformater code="" value="<%= grossUsd - grossUsd2 %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= gross - gross2 %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= disc - disc2 %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></td>
                        </tr>    
                        <tr>
                            <td nowrap colspan="2" align="right"><b>Grand Total : </b></td>
                            <td align="center"><%= qty%></td>
                            <td  align="right"><std:currencyformater code="" value="<%= grossUsd %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= gross %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= disc %>" /></td>
                            <td  align="right"><std:currencyformater code="" value="<%= netTotal %>" /></td>
                        </tr>
                    </table>  
                </td>
            </tr>
        </table>
    </div>
</form>  
<% 
	} // end canView
        if(beans.length == 0){
%>
No Records Found
<% } %>
</body>
</html>
