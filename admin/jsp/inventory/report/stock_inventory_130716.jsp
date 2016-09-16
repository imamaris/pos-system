<%@ page import="com.ecosmosis.orca.inventory.*"%>
<%@ page import="com.ecosmosis.orca.outlet.OutletBean"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
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
    InventoryBean[] invenBeans  =  (InventoryBean[]) returnBean.getReturnObject("InventoryBeans");
    ProductCategoryBean[] beans = (ProductCategoryBean[]) returnBean.getReturnObject("CatList");
    int totBF = 0;
    int totQty = 0;
    int totIn = 0;
    int totOut = 0;
    
    // int totAllocate = 0;
    
    double totPrice = 0;
    
    Map sellerMap = (Map) returnBean.getReturnObject(InventoryReportManager.RETURN_SELLERLIST_CODE);
    
    Map prodStatusMap = (Map) returnBean.getReturnObject(InventoryReportManager.RETURN_STATUS_PRODUCT);    

    %>
    <body onLoad="self.focus();document.com_inventory.id.focus();">
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <div class=functionhead>
        Stock Position Report</div>
        <form name="com_inventory" class=noprint action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_VIEW_INVENTORY,request)%>" method="post">
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
            <form name="store_inventory" action="<%=Sys.getControllerURL(InventoryReportManager.TASKID_VIEW_INVENTORY,request)%>" method="post">
                <std:input type="hidden" name="outletid" value="<%= outlet.getOutletID() %>"/>
                <std:input type="hidden" name="fromDate"/>
                <std:input type="hidden" name="toDate"/>
                <std:input type="hidden" name="product"/>
               <std:input type="hidden" name="brand"/>
                
                <br>
                <table class="listbox" width="80%">
                    <tr class="boxhead" valign=top>
                        
                        <td align="center" width="3%"><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
                        <td align="center" >Reference Number</td>
                        <td align="center" >Serial Number</td>
                        <td align="center" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_NAME%>"/></td>
                        <td align="center" >Brand</td>
                        <td align="center" >Product Type</td>
                        <td align="center" >Product Series</td>
                        <td align="center" >Price (SGD) </td>
                        <td align="center" ><i18n:label code="GENERAL_BRING_FORWARD"/></td>
                        <td align="center" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.IN%>"/></td>
                        
                        <!--  <td align="center"></td> -->
                        
                        <td align="center"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.OUT%>"/></td>
                        <td align="center" ><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.BALANCE%>"/></td>
                        <!-- td align="center" width="5%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.ACTION%>"/></td -->
                        <!-- <td align="center" width="8%"><i18n:label localeRef="mylocale" code="<%=InventoryMessageTag.PRODUCT_STATUS%>"/> *</td> -->
                    </tr>
                    
                    <% 
                    int j = 0;
                    int awal = 0;
                    int akhir = 0;
                    
                    for(int i=0; i<invenBeans.length;i++){
                    %> 
                    <%
                    
                    // int total_balance = (invenBeans[i].getTotalBringForward() + invenBeans[i].getTotalAllocate() + invenBeans[i].getTotal());
                    int total_balance = (invenBeans[i].getTotalBringForward() + invenBeans[i].getTotal());
                    String css_class = "";
                    totBF += invenBeans[i].getTotalBringForward();
                    totIn += invenBeans[i].getTotalIn();
                    totOut += invenBeans[i].getTotalOut();
                    
                    // totAllocate += invenBeans[i].getTotalAllocate();
                    
                    totPrice += invenBeans[i].getPrice();
                    totQty += total_balance; 
                    /* diremark sementara, krn HE quantity = 1
                    if(invenBeans[i].getProductBean().getSafeLevel() >= total_balance)
                        css_class = "alert";
                    */
                    %>            
                    
                    <% if (invenBeans[i].getTotalBringForward() != 0 || invenBeans[i].getTotalIn() != 0 || invenBeans[i].getTotalOut() != 0 ) 
                    {
                    
                        awal  = invenBeans[i].getProductBean().getSkuCode().length();
                        akhir = invenBeans[i].getProductBean().getSkuCode().trim().length();
                        
                    %>
                    
                    
                    <tr class="<%=(css_class.length()>0)?css_class:((j%2==0)?"odd":"even")%>" valign=top>
                        <td align="right" nowrap ><%=j+1%>.</td>
                        <td align="left" nowrap ><%=invenBeans[i].getProductBean().getProductCode() %></td>
                        
                           <% if(awal > akhir)
                           { %>
                           <td align="left" nowrap ><font color="blue">  <%=invenBeans[i].getProductBean().getSkuCode() %> </font> </td>
                           <% } else { %>
                           <td align="left" nowrap ><%=invenBeans[i].getProductBean().getSkuCode() %></td>
                           <% } %>
                           
                        <td align="left"><%=invenBeans[i].getProductBean().getDefaultName() %></td>
                        <td align="left" nowrap><%=invenBeans[i].getProductBean().getProductCategory().getName()%></td>
                        
                        <td align="left" nowrap><%=invenBeans[i].getProductBean().getProducttype() %></td>
                        
                        <td align="left" nowrap><%=invenBeans[i].getProductBean().getProductseries() %></td>                        
                        
                        <td align=right nowrap> <std:currencyformater code="" value="<%= invenBeans[i].getPrice()%>"/> </td>
                        <td align=right nowrap><%=invenBeans[i].getTotalBringForward()%></td>
                        <td align=right nowrap><%=invenBeans[i].getTotalIn()%></td>
                        <td align=right nowrap><%=invenBeans[i].getTotalOut()%></td>
                        
                        <!--  <td align=right nowrap></td> -->
                        
                        <td align=right nowrap><b><%=total_balance%></b></td>

                    </tr>
                    
                    <% 
                    j = j + 1;
                    } %>
                    
                    <%   
                    }//end for 
                    %> 
                    <tr>
                        <td colspan="7" align="center"><b>TOTAL</b></td>
                        <td align=right nowrap><b><std:currencyformater code="" value="<%=totPrice%>"/></b></td>
                        <td align=right nowrap><b><%=totBF%></b></td>
                        <td align=right nowrap><b><%=totIn%></b></td>
                        <td align=right nowrap><b><%=totOut%></b></td>
                        <!--  <td align=right nowrap><b></b></td> -->
                        <td align=right nowrap><b><%=totQty%></b></td>
                    </tr>
                    
                </table>
            </form>
            
        </c:if>
        
    </body>
</html>
