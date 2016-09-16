<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

ProductKivReportBean rptBean = (ProductKivReportBean) returnBean.getReturnObject("ProductKivList");

boolean canView = rptBean != null;
%>

<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script language="javascript">
        </script>
        
    </head>
    
    <body>
        
        <div class="functionhead"><i18n:label code="DELIVERY_KIV_REPORT"/> <%= loginUser.getOutletID() %></div>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <% 
        if (canView) {
        %>
        
        <table class="listbox" width="100%">
            <tr class="boxhead" valign=top>
                <td ><i18n:label localeRef="mylocale" code="<%=StandardMessageTag.NO%>"/>.</td>
                <td width="35%"><i18n:label code="PRODUCT_NAME"/></td>
                <td >Stock <br> Balance</td>
                <td >Total <br>Back Order</td>
                <td ><i18n:label code="SALES_TRX_DATE"/></td>
                <td ><i18n:label code="GENERAL_CUSTOMER"/></td>
                <td ><i18n:label code="GENERAL_DOCUMENT"/></td>
                <td align="center">Qty <br> Back Order</td>
            </tr>
            
            <%
            ArrayList kivList = rptBean.getProductKivList();
            int no = 0;
            int total = 0;
            String sn = "(SN:";
            
            for (int i = 0; i < kivList.size(); i++) {
                
                int totalBoKiv = 0;
                ProductKivReportBean.ProductKivBean kivBean = (ProductKivReportBean.ProductKivBean) kivList.get(i);
                
                ArrayList boList = rptBean.getBackOrderListByProduct(kivBean.getProductID());	

               if(kivBean.getQtyKiv() > 0)
                {   
                no++; 
                total = total + kivBean.getQtyKiv();
            %>  
            <tr valign="top">
            <td nowrap align="center" rowspan="<%= boList.size() %>"><%= no %></td>
            <td rowspan="<%= boList.size() %>">
                <std:text value="<%= kivBean.getProductName() %>"/>
                <br>
                Ref. Number: <std:text value="<%= kivBean.getProductCode() %>"/>  <b><std:text value="<%= kivBean.getProductType().equalsIgnoreCase("Y") ? sn.concat(" ").concat(kivBean.getSkuCode()).concat(")") : " " %>"/> </b>
            </td>
            <td rowspan="<%= boList.size() %>" align="right"><%= kivBean.getQtyOnHand() %></td>
            <td nowrap rowspan="<%= boList.size() %>" align="right"><b><%= kivBean.getQtyKiv() %></b></td>
            
            <% 
            for (int j = 0; j < boList.size(); j++) {
                    
                    ProductKivReportBean.BackOrderBean boBean = (ProductKivReportBean.BackOrderBean) boList.get(j);
                    
                    CounterSalesOrderBean sales = boBean.getCounterSalesOrderBean();
                    
                    totalBoKiv += boBean.getQtyKiv();
                     
                    
            %>	
            
            <% if ((j > 0) )            
            { %>	
            <tr valign="top">
            <% }
                    
              if(boBean.getQtyKiv() > 0)
               {   
                        
             %>
                
                <td nowrap align="center"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= sales.getTrxDate() %>"/></td>
                <td nowrap>                    
                    <%= sales.getCustomerID() %>
                    <% if (sales.getCustomerID() != null) { %>                    
                    <% } %> -                     
                    <std:text value="<%= sales.getCustomerName() %>"/>
                </td>
                <td nowrap>
                    <a href="<%= Sys.getControllerURL(102001,request) %>&TrxDocNo=<%= sales.getTrxDocNo() %>&CustomerID=<%= sales.getCustomerID() %>&CustomerName=<%= sales.getCustomerName() %>&TrxDateFrom=<%= sales.getTrxDate() %>&TrxDateTo=<%= sales.getTrxDate() %>">  <%= sales.getTrxDocNo() %> </a>                      
                </td>
                <td nowrap align="right"><%= boBean.getQtyKiv() %></td>
                
            <%
            } // end if 0                      
            %>        
            
            </tr>	
            
            <%
            // } // end if 0
            
            } // end for boList
            %>
            
            <% 
            } // end if 0   
            
            } // end for kivList
            %>
            
            
            <tr class="boxhead" valign=top>
                <td colspan="3"> Total </td>
                <td align="right" > <%=total%> </td>
                <td colspan="4" ></td>
            </tr>
            
            <tr valign=top>
                <td align="left" colspan="8"><marquee> <font color="blue">  Please click on the Document Number for processing Delivery Note </font></marquee></td>
            </tr>
            
            <c:if test="<%=kivList.size() == 0%>">
                <tr><td colspan=8 align=center><i18n:label code="MSG_NO_RECORDFOUND"/></td></tr>
            </c:if>
        </table>
        
        <%
        } else {
        %>
        
        <p>
            <b>No records found.</b>
        </p>
        
        <% 
        }
        %>
        
    </body>	
</html>



