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
  
	//Map trxTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXTYPELIST_CODE);
	
	//Map sellerMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SELLERLIST_CODE);
	
	//Map bonusPeriodMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_BNSPERIODLIST_CODE);
	
	//Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);
	
	//Map trxStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STATUS_CODE);

	//Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);
	
	//Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);
	
	//ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);
	
        CounterSalesItemBean[] beans = (CounterSalesItemBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARY_REPORT_BRAND_CATEGORY);
        
        CounterSalesOrderBean[] bean = (CounterSalesOrderBean[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SUMMARY_REPORT_BRAND_CATEGORY_DETAIL);
        
  boolean canView = beans != null;
%>

<html>
<head>
<title></title>

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
                  
                  document.forms["by_brandCat_excel_form"].submit();
              }
	</script>
		
</head>

<body>

<div class="functionhead"><i18n:label code="SALES REPORT BY BRAND, TYPE"/></div>

<form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.RETURN_SUMMARY_REPORT_BRAND_ID,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
	
    
        <table border="0">
          <tr>
            <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
	    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
	    <td>&nbsp;</td>
	    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
	    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
	  </tr>
	  <tr>
              <td>Selection By: </td>
              <td><std:input type="radio" name="selection" value="1" status="checked"/><i18n:label code="Summary"/></td>
              <td><std:input type="radio" name="selection" value="2" status="unchecked"/><i18n:label code="Detail"/></td>
          </tr>
	</table>
	
	<br>
	
	<std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
	
	<input class="textbutton" type="submit" value="REPORT PREVIEW">
</form>
        
        <div>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
         </div>
        
        
<hr>
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
%>
    <div>
            <form name="by_brandCat_excel_form" action="admin/jsp/sales/report/summary_report_excel.jsp" method="post">
                <input type="hidden" id="tableHTML" name="tableHTML" value="" />
                <input type="hidden" id="fileName" name="fileName" value="<%= exportName %>" />
                <input type="button" onclick="gotoExcel('tableData', 'tableHTML');" value="Export to Excel" />  
            </form>
        </div>
<form name="frmList" action="" method="post">  
<div id="tableData">    
    <table class="outerbox" width="80%">
        
        <tr class="boxhead" valign="top">
            <td>
                <b><i18n:label code="SUMMARY SALES REPORT BY BRAND, TYPE"/><br />
                <i18n:label code="From "/><%= date1 %>
                <i18n:label code="To "/><%= date2 %>
                
            </td> 
        </tr>
    <% if(selection.equals("1")){ %>
        <%@ include file="/admin/jsp/sales/report/summary_sales_report_by_brandCategorySum.jsp" %>
        <% }else { %>
        <tr>
            <td><b><i18n:label code="Format : By Brand, Type, Series, Item"/></b></td>
        </tr>
        <tr>
            <td>
                <table class="listbox" width="100%">
                    <tr class="boxhead" valign=top>
                        <td width="5%"><i18n:label code="GENERAL_NUMBER"/></td>
                        <td>Invoice</td>
                        <td align="center">Date</td>
                        <td align="center">Serial Number</td>
                        <td align="center">Qty</td>    
                        <td align="center">Unit Price (SGD)</td>
                        <td align="center">Unit Price</td>
                        <td align="center">Discount</td>
                        <td align="center">Amount</td>
                    </tr>
                    <% 
                    String item = ""; String item2 = "";
                    String series = "";
                    String brandName = "";
                    String namaBrand = ""; String namaBrand2 = "";
                    int qty = 0; int qty2 = 0; 
                    String docNo = "";
                    int quantity = 0; int quantity2 = 0;
                    double grossSgd = 0; double grossSgd2 = 0;
                    double gross = 0; double gross2 = 0;
                    double disc = 0; double disc2 = 0;
                    double netTotal = 0; double netTotal2 = 0;
                    double netTotalSeries = 0; 
                    for(int i=0; i < beans.length; i++){ 
                    %>
                    <%
                    if(!beans[i].getUnitSales().equals(namaBrand)){
                    if(!item.equals("")){
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Item <%= item %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= grossSgd - grossSgd2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= gross - gross2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <% }
                    if(!series.equals("")){
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Series <%= series %></b></td>
                        <td align="center"><b><%= quantity - quantity2 %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotalSeries %>" /></b></td>
                    </tr>
                    <%  
                    netTotalSeries = netTotal;
                    quantity2 = quantity;
                    disc2 = disc;
                    grossSgd2 = grossSgd;
                    gross2 = gross;
                    qty2 = qty;    
                    }
                    
                    if(!brandName.equals("")){
                    
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Type <%= brandName %></b></td>
                        <td align="center"><b><%= beans[i-1].getQtyOrder() %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= beans[i-1].getUnitDiscount() %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%=  beans[i-1].getUnitNetPrice() %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Brand <%= namaBrand %></b></td>
                        <td align="center"><b><%= beans[i-1].getQtyOrder() %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= beans[i-1].getUnitDiscount() %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= beans[i-1].getUnitNetPrice() %>" /></b></td>
                    </tr>
                    <%
                    }
                    %>
                    <tr>
                        <td colspan="9"><b>Brand : <%= beans[i].getInventory() %></b></td>
                    </tr>
                    <%
                    } 
                    
                    if(!(beans[i].getInventory()+(beans[i].getUnitSales())).equals(brandName+namaBrand)){
                    %>
                    
                    <tr>
                        <td colspan="9"><b>Type : <%= beans[i].getUnitSales() %></b></td>
                    </tr>
                    <% 
                    
                    }    
                    for(int j=0;j < bean.length; j++){ 
                    String rowCss = "";
                    if((j+1) % 2 == 0)
                    rowCss = "even";
                    else
                    rowCss = "odd";
                    %>
                    <%
                    if(beans[i].getInventory().equals(bean[j].getShipExpedition())){
                    if(!bean[j].getShipCity().equals(series)){
                    
                    %>
                    
                    <%           namaBrand = beans[i].getInventory();
                    
                    if(namaBrand2.equals(beans[i].getInventory())){
                    %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Item <%= item %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= grossSgd - grossSgd2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= gross - gross2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Series <%= series %></b></td>
                        <td align="center"><b><%= quantity - quantity2 %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%=  netTotal - netTotalSeries %>" /></b></td>
                    </tr>
                    <%
                    netTotalSeries = netTotal;
                    quantity = qty;
                    quantity2 = quantity;
                    disc2 = disc;
                    grossSgd2 = grossSgd;
                    gross2 = gross;
                    qty2 = qty;
                    }
                    
                    %>
                    
                    <tr>
                        <td colspan="9"><b>Series : <%= bean[j].getShipCity() %></b></td>
                    </tr>
                    <%
                    
                    }
                    
                    if(!bean[j].getShipByStoreCode().equals(item)){
                    
                    %>
                    <% if(series.equals(bean[j].getShipCity())){ %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Item <%= item %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= grossSgd - grossSgd2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= gross - gross2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <% } 
                    
                    %>
                    <tr>
                        <td colspan="9"><b>Item : <%= bean[j].getShipByStoreCode() %></b></td>
                    </tr>
                    <% 
                    namaBrand2 = beans[i].getInventory();
                    netTotal2 = netTotal;
                    disc2 = disc;
                    grossSgd2 = grossSgd;
                    gross2 = gross;
                    qty2 = qty;
                    }
                    %>
                    <tr class="<%= rowCss %>">
                        <td align="center"><%= j+1 %></td>
                        <td align="left"><%= bean[j].getTrxDocNo() %></td>
                        <td align="center"><%= bean[j].getTrxDate() %></td>
                        <td align="left"><%= bean[j].getShipState() %></td>
                        <td align="center"><%= bean[j].getShipOption() %></td>
                        <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount3() %>" /></td>
                        <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount4() + bean[j].getOtherAmount5() %>" /></td>
                        <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount4() %>" /></td>
                        <td align="right"><std:currencyformater code="" value="<%= bean[j].getOtherAmount5() %>" /></td>
                    </tr>  
                    
                    
                    <%
                    qty = qty + bean[j].getShipOption();
                    quantity = quantity + bean[j].getShipOption();
                    disc = disc + bean[j].getOtherAmount4();
                    grossSgd = grossSgd + bean[j].getOtherAmount3();
                    gross = gross + (bean[j].getOtherAmount4()+ bean[j].getOtherAmount5());
                    netTotal = netTotal + bean[j].getOtherAmount5();
                    series = bean[j].getShipCity();
                    item = bean[j].getShipByStoreCode();
                    docNo = bean[j].getTrxDocNo();
                    }
                    
                    } // end j
                    namaBrand = beans[i].getInventory();
                    brandName = beans[i].getUnitSales();
                    %>
                    
                    
                    
                    <% } %>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Item <%= item %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= grossSgd - grossSgd2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= gross - gross2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Series <%= series %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Type <%= brandName %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Sub Total Brand <%= namaBrand %></b></td>
                        <td align="center"><b><%= qty - qty2 %></b></td>
                        <td align="right"></td>
                        <td align="right"></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc - disc2 %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal - netTotal2 %>" /></b></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><b>Grand Total </b></td>
                        <td align="center"><b><%= qty %></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= grossSgd %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= gross%>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= disc %>" /></b></td>
                        <td align="right"><b><std:currencyformater code="" value="<%= netTotal %>" /></b></td>
                    </tr>
                </table>
            </td>
        </tr>
        <% } %>
    </table>
    </td>
    </tr>
    
    </table>
</div>
</form>  
<% 
	}
%>
<br>
</body>
        <script type="text/javascript">  
              function gotoExcel(elemId, frmFldId)
              {  
                  var obj = document.getElementById(elemId);  
                  var oFld = document.getElementById(frmFldId);
                  
                  oFld.value = obj.innerHTML;
                  
                  document.forms["by_brandCat_excel_form"].submit();
              }  
        </script>
</html>