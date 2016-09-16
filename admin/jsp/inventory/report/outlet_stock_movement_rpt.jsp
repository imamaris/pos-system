<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@page import="com.ecosmosis.orca.inventory.StockMovementRptBean.StockInfo"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.product.category.*"%>
<html>
    <head>
        <%@ include file="/lib/header.jsp"%>
        <script language="Javascript">

function searchInventory(){

  var upperform = document.com_inventory;
  var myform = document.store_inventory;
  if(myform.id.value == ""){
     
     myform.id.options[myform.id.selectedIndex].value = myform.outletid.value;
  }
  
  myform.fromDate.value = upperform.fromDate.value;
  myform.toDate.value = upperform.toDate.value;
  myform.submit();
}
        </script>
    </head>
    <%
    MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);
    String id = (String) returnBean.getReturnObject("ID");
    boolean hasInventory = (returnBean.getReturnObject("hasInventory")!=null)?(Boolean) returnBean.getReturnObject("hasInventory"):false;
    OutletBean outlet = (OutletBean) returnBean.getReturnObject("Outlet");
    TreeMap stores = (TreeMap) returnBean.getReturnObject("Stores");
    
    StockMovementRptBean report  =  (StockMovementRptBean) returnBean.getReturnObject("MovementReport");
    
    ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
    
    Map sellerMap = (Map) returnBean.getReturnObject(InventoryReportManager.RETURN_SELLERLIST_CODE);
    
    Map prodStatusMap = (Map) returnBean.getReturnObject(InventoryReportManager.RETURN_STATUS_PRODUCT);        
        
    %>
    <body onLoad="self.focus();document.com_inventory.id.focus();">
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <div class=functionhead><i18n:label code="STOCK_MOVEMENT_REPORT"/></div>
        <form name="com_inventory" class=noprint action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_MOVEMENT,request)%>" method="post">
            <table class=noprint>
                <tr>
                <td>Boutique ID</td>                
                <td>: <std:input type="select" name="id" options="<%= sellerMap %>" /></td>
                
                <td>Product Brand</td>
                <td>:
                    <select name="brand">
                        <option value=""><i18n:label code="GENERAL_ALL"/></option>
                        <%
                        for (int i=0;i<beans.length;i++) { 
                        %>
                        <option value="<%=beans[i].getName()%>"><%=beans[i].getName()%></option>
                        <%
                        } // end for
                        %>
                    </select>
                </td>  
                <td align="right">Reference Number / Serial Number</td>
                <td>: <std:input type="text" name="product" value=""/></td>
                   
                
                <tr>
                    <td align="left" colspan="4"><b><i18n:label code="STOCK_TRX_DATE"/></b></td>
                    <td align="right">Product Description</td>
                    <td>: <std:input type="text" name="productDesc" value=""/></td>                   
                </tr>
                <tr>
                    <td align="center"><i18n:label code="GENERAL_FROM"/></td>
                    <td>: <std:input type="date" name="fromDate" value="now"/></td>
                    <td align="center"><i18n:label code="GENERAL_TO"/></td>
                    <td>: <std:input type="date" name="toDate" value="now"/></td>
                    <td align="right">Product Status</td>
                    <td>: <std:input type="select" name="prodStatus" options="<%= prodStatusMap %>" /></td>
                    <td></td>
                </tr>
            </table>
            <br>
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
        </form>
              
        <hr>
        
        <c:if test="<%= hasInventory %>">
            <form name="store_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_RPT_MOVEMENT,request)%>" method="post">
                <std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
                <std:input type="hidden" name="fromDate"/>
                <std:input type="hidden" name="toDate"/>
                <std:input type="hidden" name="product"/>
                <std:input type="hidden" name="productDesc"/>
                <std:input type="hidden" name="prodStatus"/>
               <std:input type="hidden" name="brand"/>
               
                <div align=left><input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()"></div>
                <br>

                <table class=listbox width=100%>
                    <tr class="boxhead" valign=top>
                        <td rowspan=2 align="center" width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
                        <td rowspan=2 align="center" >Reference <br> Number</td>
                        <td rowspan=2 align="center" >Serial <br> Number</td>
                        <td rowspan=2 align="center" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
                        <td rowspan=2 align="center" >Brand</td>
                        <td rowspan=2 align="center"><i18n:label code="GENERAL_BRING_FORWARD"/></td>                        
                        <td colspan=2  align="center"><i18n:label code="STOCK_LOAN"/></td>	  
                        <td colspan=2  align="center"><i18n:label code="STOCK_SALES"/></td>
                        <td colspan=2 align="center"><i18n:label code="STOCK_TRANSFER"/></td>
                        <td colspan=2  align="center">Allocate</td>          
                        <td rowspan=2 align="center">Stock <br> Balance</td>
                        
                    </tr>
                    
                    <tr class="boxhead">
                        <td align="right" ><i18n:label code="STOCK_IN"/></td>
                        <td align="right" ><i18n:label code="STOCK_OUT"/></td>
                        <td align="right" ><i18n:label code="STOCK_IN"/></td>
                        <td align="right" ><i18n:label code="STOCK_OUT"/></td>
                        <td align="right" ><i18n:label code="STOCK_IN"/></td>
                        <td align="right" ><i18n:label code="STOCK_OUT"/></td>  	
                        <td align="right" ><i18n:label code="STOCK_IN"/></td>
                        <td align="right" ><i18n:label code="STOCK_OUT"/></td>          
                    </tr>
                    
                    <%
                    int[] qty = new int[18];
                    ProductBean[] items = report.getProductItems();
                    int prevCategory = -1;
                    boolean isHeader = false;
                    int total_fields = 0;
                    int no = 0;
                    
                    if(items.length > 0){
                        
                        for (int i=0; i < items.length; i++) {
                            
                            isHeader = items[i].getProductCategory().getCatID() != prevCategory;
                            prevCategory = items[i].getProductCategory().getCatID();
                            // int counter = 0;
                            StockMovementRptBean.StockInfo stock = report.getStockInfo(String.valueOf(items[i].getProductID()));
                            
                            // filter
                            if(stock.getLoanIn() != 0 || stock.getLoanOut() != 0 || stock.getSalesIn() != 0 || stock.getSalesOut() != 0 || stock.getTransferIn() != 0 || stock.getTransferOut() != 0  || stock.getAllocateIn() != 0  || stock.getAllocateOut() != 0  || stock.getBalance() != 0  ) {
                                no = no + 1;
                                int counter = 0;
                                
                                qty[counter++] += stock.getBringForwardBalance();
                                qty[counter++] += stock.getLoanIn();
                                qty[counter++] += stock.getLoanOut();
                                qty[counter++] += stock.getSalesIn();
                                qty[counter++] += stock.getSalesOut();
                                qty[counter++] += stock.getTransferIn();
                                qty[counter++] += stock.getTransferOut();
                                qty[counter++] += stock.getAllocateIn();
                                qty[counter++] += stock.getAllocateOut();
                                qty[counter++] += stock.getBalance();
                                
                                total_fields = counter;
                    %>
                    <%if (isHeader){%>
                    <!--<tr class="head" valign=top>
	  	  <td colspan=21 align=left>--><!--%=items[i].getCategoryBean().getPct_name()%--><!--</td>
	  	</tr>-->
                    <%}%>
                    
                    <%	
                    String css_class = "";
                    if(items[i].getSafeLevel() >= stock.getBalance())
                    // css_class = "alert";
                    %>
                    
                    
                    <tr align=right class="<%=css_class%>" >
                        
                        <td align="center" width="3%"><%= no%></td>
                        <td align="left" nowrap ><%= items[i].getProductCode() %></td>
                        <td align="left" nowrap><%= items[i].getSkuCode() %></td>
                        <td align="left" ><%= items[i].getDefaultName() %></td>
                        <td align="center" ><%= items[i].getProductCategory().getName()%></td>
                        <td align="right" ><%= stock.getBringForwardBalance() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getLoanIn() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getLoanOut() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"odd"%>"><%= stock.getSalesIn() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"even"%>"><%= stock.getSalesOut() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"odd"%>" colspan=1><%= stock.getTransferIn() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"even"%>" colspan=1><%= stock.getTransferOut() %></td>	  
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"odd"%>" colspan=1><%= stock.getAllocateIn() %></td>
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"even"%>" colspan=1><%= stock.getAllocateOut() %></td>             
                        <td align="right"  nowrap class="<%=(css_class.length()>0)?css_class:"odd"%>"><b><%= stock.getBalance() %></b></td>                 
                        
                    </tr>
                    
                    <%                        
                    } // end for  != 0
                    
                    } // end for	
                    %>
                    <tr class="head">
                        <td colspan=5 align=right><b><i18n:label code="GENERAL_TOTAL"/></b></td>
                        
                        <%
                        for (int i=0; i< total_fields - 2 ; i++) {
                        %>
                        <td align=right><%= qty[i] %></td>
                        <%
                        }
                        %>
                        <td align=right ><%= qty[total_fields - 2] %></td>
                        <td align=right ><%= qty[total_fields - 1] %></td>
                        
                    </tr>
                </table>
                <br>
                <div align=left><input class=noprint type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()"></div>
                <br>
            </form>
            <%}%>
        </c:if>
    </body>
</html>
