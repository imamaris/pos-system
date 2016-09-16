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
<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Timestamp"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

Map trxTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXTYPELIST_CODE);

Map trxSellerTypeMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_TRXSELLERTYPELIST_CODE);

Map sellerMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SELLERLIST_CODE);

Map bonusPeriodMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_BNSPERIODLIST_CODE);

Map deliveryStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_DELIVERYSTATUS_CODE);

Map trxStatusMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_STATUS_CODE);

Map orderByMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_ORDERBY_CODE);

Map recordsMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_SHOWRECS_CODE);

ArrayList confirmBonusPeriodList = (ArrayList) returnBean.getReturnObject(CounterSalesManager.RETURN_CFIMBNSPERIODLIST_CODE);

CounterSalesOrderBeanDetail[] beans = (CounterSalesOrderBeanDetail[]) returnBean.getReturnObject(CounterSalesManager.RETURN_SALESLIST_CODE_DETAIL);

// 2010-02-12
Map catMap = (Map) returnBean.getReturnObject(CounterSalesManager.RETURN_CATLIST_CODE);

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
        </script>
        
    </head>
    
    <body>
        
        <div class="functionhead"><i18n:label code="Sales Listing Summary"/></div>
        
        <form name="frmSearch" action="<%=Sys.getControllerURL(CounterSalesManager.TASKID_SALES_LIST_SUMMARY,request)%>" method="post" onSubmit="return doSubmit(document.frmSearch);">
            <table border="0">
                <tr>
                    <td class="td1"><i18n:label code="SALES_COUNTER"/>:</td>
                    <td><std:input type="select" name="SellerID" options="<%= sellerMap %>" /></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="BONUS_PERIOD"/>:</td>
                    <td><std:input type="select" name="BonusPeriodID" options="<%= bonusPeriodMap %>" /></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="SALES_REFERENCE"/>:</td>
                    <td><std:input type="text" name="TrxDocNo" size="30" maxlength="20"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="SALES_TRX_TYPE"/>:</td>
                    <td><std:input type="select" name="TrxType" options="<%= trxTypeMap %>" /></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="GENERAL_ID"/>:</td>
                    <td><std:memberid name="CustomerID" form="frmSearch"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="GENERAL_NAME"/>:</td>
                    <td><std:input type="text" name="CustomerName" size="30" maxlength="50"/></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
                    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
                    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="GENERAL_STATUS"/>:</td>
                    <td><std:input type="select" name="Status" options="<%= trxStatusMap %>" /></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="DELIVERY_STATUS"/>:</td>
                    <td><std:input type="select" name="DeliveryStatus" options="<%= deliveryStatusMap %>" /></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="GENERAL_DISPLAY"/>:</td>
                    <td>
                        <!-- <std:input type="select" name="Limits" options="<%= recordsMap %>"/>  -->
                        <i18n:label code="GENERAL_ALL"/>
                    </td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="GENERAL_ORDERBY"/>:</td>
                    <td><std:input type="select" name="OrderBy" options="<%= orderByMap %>"/></td>
                </tr>
                <tr>
                    <td><b>Category : </b></td>
                    <td align="left"><std:input type="select" name="CatID" options="<%= catMap %>" /></td>     
                    <td>&nbsp;</td>
                    <td class="td1">Seller Type:</td>
                    <td><std:input type="select" name="TrxSellerType" options="<%= trxSellerTypeMap %>" /></td>
                </tr>
                
                
                
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
        </form>
        
        <hr>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <% 
        if (canView) {
        %>
        
        <form name="frmList" action="" method="post">
            
            <table class="listbox" width="100%">
                <tr class="boxhead" valign=top>
                    <td><i18n:label code="GENERAL_NUMBER"/></td>
                    <td width="10%" nowrap><i18n:label code="PRODUCT_SKU_CODE"/></td>
                    <td nowrap><i18n:label code="PRODUCT_NAME"/></td>
                    <td align="center" nowrap><i18n:label code="Price"/></td>
                    <td align="center" nowrap><i18n:label code="Qty"/></td>
                    <td align="center" nowrap><i18n:label code="Total Sales"/></td>
                    <td align="center" nowrap><i18n:label code="Discount"/></td>
                    <td align="center" nowrap><i18n:label code="Receivable"/></td>
                    <td align="center" nowrap><i18n:label code="Net Sales"/></td>
                    <td align="center" nowrap><i18n:label code="VAT Out"/></td>
                    <td align="center" nowrap><i18n:label code="Gross Sales"/></td>
                    
                </tr>
                
                
                <%                
                
                double grdTotalBV = 0.0d;                
                String productCode = "";
                String productName = "";
                double BvSale = 0.0d;
                double PriceSale = 0.0d;
                
                int grdQtySale = 0;
                double grdBvSale = 0.0d;
                double grdPriceSale = 0.0d;
                double grdDiscount = 0.0d;
                double grdReceivable = 0.0d;
                double grdNetSales = 0.0d;
                double grdVAT = 0.0d;
                double grdGrossSales = 0.0d;
                
                boolean isOutletSales = false;
                boolean isStockistSales = false;
                boolean isActive = false;
                boolean isNew = false;
                boolean isBonusConfirmed = false;
                int j = 0;
                
                for (int i=0; i<beans.length; i++) {
                    
                    String rowCss = "";
                    String rowCss2 = "";
                    
                    if((i+1) % 2 == 0)
                        rowCss = "even";
                    else
                        rowCss = "odd";
                        
                                            
                    if((j+1) % 2 == 0)
                        rowCss2 = "even";
                    else
                        rowCss2 = "odd";
                        
                    isBonusConfirmed = false;
                    
                    if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_OUTLET)) {
                        isOutletSales = true;
                    } else {
                        isOutletSales = false;
                    }
                    
                    if (beans[i].getSellerTypeStatus().equalsIgnoreCase(CounterSalesManager.TYPE_STOCKIST)) {
                        isStockistSales = true;
                    } else {
                        isStockistSales = false;
                    }
                    isActive = beans[i].getStatus() == CounterSalesManager.STATUS_ACTIVE;
                    isNew = beans[i].isTodayTrx();
                    
                    if (isActive) {
                        // grdTotalBV += beans[i].getTotalBv1();
                        
                        // grdNetSales += beans[i].getNetSalesAmount();
                        
                        if (beans[i].getBonusPeriodID() != null && confirmBonusPeriodList.contains(beans[i].getBonusPeriodID())) {
                            isBonusConfirmed = true;
                        }
                        
                    } else {
                        rowCss = "alert";
                    }
                    
               
                if (!beans[i].getProductCode().equalsIgnoreCase(productCode) && i > 1){
                %>
                
                
                <tr class="<%= rowCss2 %>" valign=top>
                    <td nowrap><%= j+1 %>.</td>
                    <td align="center" nowrap><std:text value="<%= productCode %>" defaultvalue="-"/></td>
                    <td align="left" nowrap><std:text value="<%= productName %>" defaultvalue="-"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= PriceSale %>"/></td>
                    <td align="right" nowrap><std:bvformater value="<%= grdQtySale %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdPriceSale %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdDiscount %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdReceivable %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdNetSales %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdVAT %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdGrossSales %>"/></td>
                    
                </tr>     
                    
                <%
                
                j++ ;
                
                }
                    
                    if (!beans[i].getProductCode().equalsIgnoreCase(productCode)) {
                        grdQtySale = beans[i].getQtySale();
                        grdBvSale = beans[i].getBvSale();
                        grdPriceSale = beans[i].getPriceSale();
                        grdDiscount = beans[i].getPriceSale() * beans[i].getDiscountRate() * 0.01D;
                        grdReceivable = beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D);
                        grdNetSales = (beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (100D/110D);
                        grdVAT = (beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (10D/110D);
                        grdGrossSales = ((beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (100D/110D)) + (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D);

                    } else {
                        grdQtySale = grdQtySale + beans[i].getQtySale();
                        grdBvSale = grdBvSale + beans[i].getBvSale();
                        grdPriceSale = grdPriceSale + beans[i].getPriceSale();
                        grdDiscount = grdDiscount + (beans[i].getPriceSale() * beans[i].getDiscountRate() * 0.01D);
                        grdReceivable = grdReceivable + (beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D));
                        grdNetSales = grdNetSales + ((beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (100D/110D));
                        grdVAT = grdVAT + ((beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (10D/110D));
                        grdGrossSales = grdGrossSales + (((beans[i].getPriceSale() - (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D)) * (100D/110D)) + (beans[i].getPriceSale()* beans[i].getDiscountRate() * 0.01D));
                    }
                    
                %>                                 
                                
                <%    
                productCode = beans[i].getProductCode();
                productName = beans[i].getDefaultName(); 
                BvSale = beans[i].getBv();
                PriceSale = beans[i].getPrice();
                
                
                %>
                
                <% 
                } // end for
                %>

                <tr valign=top>
                    <td nowrap><%= j+1 %>.</td>
                    <td align="center" nowrap><std:text value="<%= productCode %>" defaultvalue="-"/></td>
                    <td align="left" nowrap><std:text value="<%= productName %>" defaultvalue="-"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= PriceSale %>"/></td>
                    <td align="right" nowrap><std:bvformater value="<%= grdQtySale %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdPriceSale %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdDiscount %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdReceivable %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdNetSales %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdVAT %>"/></td>
                    <td align="right" nowrap><std:currencyformater code="" value="<%= grdGrossSales %>"/></td>
                </tr>     
                
                
            </table>  
            
        </form>
        
        <% 
        } // end canView
        %>
        
    </body>
</html>
