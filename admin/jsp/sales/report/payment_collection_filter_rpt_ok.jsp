<%@ page import="com.ecosmosis.mvc.manager.*"%>
<%@ page import="com.ecosmosis.orca.bean.*"%>
<%@ page import="com.ecosmosis.orca.constants.*"%>
<%@ page import="com.ecosmosis.orca.counter.sales.*"%>
<%@ page import="com.ecosmosis.orca.outlet.*"%>
<%@ page import="com.ecosmosis.orca.outlet.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.paymentmode.*"%>
<%@ page import="com.ecosmosis.orca.document.*"%>
<%@ page import="com.ecosmosis.orca.product.*"%>
<%@ page import="com.ecosmosis.orca.msgcode.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Time"%>


<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
Map trxStatus = (Map) returnBean.getReturnObject("TrnxStatus");
int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);

CounterCollectionReportBean rptBean = (CounterCollectionReportBean) returnBean.getReturnObject("CollectionReport");

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
        
        <div class="functionhead"><%= taskTitle %></div>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <form name="frmSearch" action="<%=Sys.getControllerURL(taskID,request)%>" method="post">
            
            <table border="0">
                <tr>
                    <td class="td1">Boutique:</td>
                    <td><std:text value="<%= loginUser.getOutletID() %>" defaultvalue="-"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="GENERAL_USERID"/>:</td>
                    
                    <td>
                        
                        <% 
                        if (taskID == CounterSalesReportManager.TASKID_ADMIN_COLLECTION_FILTER_RPT) {
                        %>
                        
                        <std:text value="<%= loginUser.getUserId() %>" defaultvalue="-"/>
                        
                        <% 
                        } else {
                        %>
                        
                        <std:input type="text" name="UserID" size="30" maxlength="20"/>
                        
                        <% 
                        }
                        %>
                        
                    </td>
                    
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_FROM"/>:</td>
                    <td><std:input type="date" name="TrxDateFrom" value="now"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="SALES_TRX_DATE"/> <i18n:label code="GENERAL_TO"/>:</td>
                    <td><std:input type="date" name="TrxDateTo" value="now"/></td>
                </tr>
                <tr>
                    <td class="td1"><i18n:label code="GENERAL_DISPLAY"/>:</td>
                    <td><std:input type="select" name="Status" options="<%=trxStatus%>"/></td>
                    <td>&nbsp;</td>
                    <td class="td1">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
                       
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
        </form>
        
        <% 
        if (canView) {
        %>
        
        <div>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
        </div>
        
        <br>
        
        <!-- Sales trx -->
        
        <%
        Date[] trxDateList = rptBean.getTrxColletionDateList();
        String[] documentList = rptBean.getDocumentList();
        OutletPaymentModeBean[] paymodeList = rptBean.getPaymentModeList();
        //CounterSalesPaymentBean[] paymodeList = rptBean.getPaymentModeList2();
        
        %>
        
        
        <!-- Collection summary -->

        
        <table>
            
            <% 
            if (trxDateList.length > 0) {
            %>
            
            <tr class="boxhead" valign="top">
                <td><i18n:label code="SALES_PAYMENT_COLLECTION_SUMM"/></td>
            </tr>
            
            <% 
            }
            %>
            
            <% 
            for (int z=0; z<trxDateList.length; z++) {
            
            double totalPayment = 0.0d;
            
            CounterCollectionReportBean.SalesTrxBean trxBean = rptBean.getTrxCollection(trxDateList[z]);
            %>
            
            <% 
            if (z != 0) {
            %>
            
            <tr>
                <td>&nbsp;</td>
            </tr>	
            
            <% 
            }
            %>

            
            <tr>
                <td>
                    <table class="outerbox">
                        <tr valign="top">
                            <td class="boxhead"><fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= trxDateList[z] %>" /></td>
                            <td>
                                <table class="listbox" width="500">
                                    
                                    <% 
                                    for (int y=0; y<paymodeList.length; y++) {
                
                String rowCss = "";
                
                if((y+1) % 2 == 0)
                    rowCss = "even";
                else
                    rowCss = "odd";
                
                CounterCollectionReportBean.PaymentOrderBean payBean = trxBean.getPayGrpDetail(paymodeList[y].getPaymodeCode()) ;
                
                // CounterCollectionReportBean.PaymentOrderBean payBean = trxBean.getPayGrpDetail2("CASHCASHCASH") ;
                
                if (payBean != null) {
                    totalPayment += (payBean.getPaymentIn() - payBean.getPaymentOut());
                }
                                    %>
                                    
                                    <tr class="<%= rowCss %>" valign="top">
                                        <td width="300">
                                            <%= paymodeList[y].getPaymodeDesc() %> - <%= paymodeList[y].getOutletEdc() %> - <%= paymodeList[y].getOutletTime() %>
                                        </td>
                                        <!--
								<td>
                                        <%= (payBean != null) ? payBean.getPayCount() : 0 %>
								</td>
								-->
                                                                                                      
                                        <td class="td1" width="100">
                                            <std:currencyformater code="" value="<%= (payBean != null) ? (payBean.getPaymentIn() - payBean.getPaymentOut() ) : 0 %>"/>
                                        </td>
                                    </tr>
                                                                       
                                    <% 
                                    } // end for paymodeList
                                    %>
                                    
                                    <tr class="totalhead" valign="top">
                                        <td width="150" nowrap><i18n:label code="GENERAL_TOTAL"/> <i18n:label code="SALES_CHANGE_DUE"/> (-)</td>
                                        <td class="td1" width="100">
                                            <std:currencyformater code="" value="<%= trxBean.getTotalChangeDue() %>"/>
                                        </td>
                                    </tr>
                                    <tr class="totalhead" valign="top">
                                        <td width="150" nowrap><i18n:label code="GENERAL_TOTAL"/></td>
                                        <td class="td1" width="100">
                                            <std:currencyformater code="" value="<%= totalPayment - trxBean.getTotalChangeDue() %>"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <table class="listbox" width="350">
                                    
                                    <% 
                                    for (int k=0; k<documentList.length; k++) {
                
                String rowCss = "";
                
                if((k+1) % 2 == 0)
                    rowCss = "even";
                else
                    rowCss = "odd";
                
                double totalAmt = 0.0d;
                
                ArrayList list = trxBean.getDocGrpDetail(documentList[k]);
                
                for (int u=0; u<list.size(); u++) {
                    CounterSalesOrderBean bean = (CounterSalesOrderBean) list.get(u);
                    // CounterSalesOrderBeanDetail bean = (CounterSalesOrderBeanDetail) list.get(u);
                    totalAmt += bean.getNetSalesAmount();
                }
                                    %>
                                    
                                    <tr class="<%= rowCss %>" valign="top">
                                        <td width="350">
                                            
                                            <%= ( (documentList[k].equalsIgnoreCase("IN") || documentList[k].equalsIgnoreCase("CB"))  ? "SALES INVOICE" : "SALES VOID / SALES RETURN ") %>
                                        </td>
                                        
                                        <td class="td1" width="50">
                                            <%= list.size() %>
                                        </td>
                                        
                                        <td class="td1" width="100">
                                            <std:currencyformater code="" value="<%= totalAmt %>"/>
                                        </td>
                                    </tr>
                                    
                                    <% 
                                    } // end for paymodeList
                                    %>
                                    
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
               
            
            <%
            }
            %>
            
            
        </table>
        
        
        <!-- End Collection summary -->

        
        <br>
        
        <hr>
        
        <br>
        
        <% 
        if (trxDateList != null && trxDateList.length > 0) {	
        %>
        
        <table width="100%">
            <% 
            for (int i=0; i<trxDateList.length; i++) {
            
            CounterCollectionReportBean.SalesTrxBean trxBean = rptBean.getTrxCollection(trxDateList[i]);
            %>
            
            <% 
            if (i != 0) {
            %>
            
            <tr>
                <td>&nbsp;</td>
            </tr>	
            
            <% 
            }
            %>
            
            <tr>
                <td>
                    <table class="outerbox" width="80%">
                        <tr class="boxhead" valign="top">
                            <td>
                                <b><i18n:label code="SALES_TRX"/> <i18n:label code="GENERAL_ON"/> <fmt:formatDate pattern="<%= loginUser.getDateformat() %>" value="<%= trxDateList[i] %>" /></b>
                            </td>	
                        </tr>
                        
                        <% 
                        ArrayList dtlList = null;
                        
                        for (int j=0; j<documentList.length; j++) {
                        
                        dtlList = trxBean.getDocGrpDetail(documentList[j]);
                        %>
                        
                        <% 
                        if (j != 0) {
                        %>
                        
                        <tr>
                            <td>&nbsp;</td>
                        </tr>	
                        
                        <% 
                        }
                        %>
                        
                        <tr>

                            <td><b><u><%= (documentList[j].equalsIgnoreCase("IN") || documentList[j].equalsIgnoreCase("CB")) ?  "SALES INVOICE " :  "SALES VOID / SALES RETURN " %> : <%= dtlList.size() %></u></b></td>

                        </tr>				
                        
                        <% 
                        if (dtlList.size() > 0) {
                        %>
                        
                        <tr>
                            <td>
                                <table class="listbox">
                                    <tr class="boxhead" valign="top">
                                        <td>No.</td>
                                        <td width="13%"><i18n:label code="SALES_REFERENCE"/></td>
                                        
                                        <td nowrap>Sales Type</td>
                                        <td nowrap>Brand Name</td>
                                        <td nowrap>Item Number</td>
                                        <td nowrap>Qty</td>
                                        <td nowrap>Retail Price <br>(IDR)</td>                                        
                                        <td nowrap>Disc (%)</td>  
                                        <td nowrap>Net Price <br>(IDR)</td>    
                                        <td>Sales Person</td>   
                                        <td width="15%"><i18n:label code="GENERAL_CUSTOMER"/></td>                                        
                                        <td nowrap>Payment Type</td>    
                                        <td nowrap>Card Type  </td> 
                                        <td nowrap>Payment <br>  Checkbook </td> 
                                        <td nowrap>Payment Amount </td>
                                        <td nowrap>Currency</td>
                                        <td nowrap>Rate</td>
                                        <td nowrap>Deposit</td>                                        
                                        <td nowrap>Total Payment <br>(IDR) </td>
                                        <td>Remarks  </td>
                                        
                                        <td width="10%"><i18n:label code="GENERAL_STATUS"/></td>
                                        <td width="8%"><i18n:label code="GENERAL_CREATEDBY"/></td>
                                    </tr>
                                    
                                    <% 
                                    for (int h=0; h < dtlList.size();	h++) {
                                    
                                    String rowCss = "";
                                    
                                    if((h+1) % 2 == 0)
                                    rowCss = "even";
                                    else
                                    rowCss = "odd";
                                    
                                    CounterSalesOrderBean bean = (CounterSalesOrderBean) dtlList.get(h);
                                    // CounterSalesOrderBeanDetail bean = (CounterSalesOrderBeanDetail) dtlList.get(h);
                                    
                                    if (bean.getStatus() != CounterSalesManager.STATUS_ACTIVE && bean.getStatus() != CounterSalesManager.STATUS_ADJST)
                                    rowCss = "alert";
                                    %>
                                    
                                    <tr class="<%= rowCss %>" valign="top">
                                        <td nowrap><%= h+1 %>.</td>
                                        <td nowrap>
                                            <small><std:link text="<%= bean.getTrxDocNo() %>" taskid="<%= CounterSalesManager.TASKID_VIEW_SALES %>" params="<%= ("SalesID="+bean.getSalesID()) %>" /></small>
                                            
                                            <%
                                            if (bean.getStatus() == CounterSalesManager.STATUS_ADJST) {
                                            %>
                                            <br>
                                            <%= bean.getAdjstRefNo() %>
                                            <% 
                                            }
                                            %>
                                            
                                        </td>
                                        
                                         <%        String hasil = "";      
                                                    if(bean.getTrxDocName().equalsIgnoreCase("Sales Return"))
                                                    {
                                                       hasil= "Sales Return";                    
                                                    }else if
                                                    (bean.getTrxDocName().equalsIgnoreCase("Sales Void"))
                                                    {
                                                      hasil= "Sales Void";                          
                                                    }else
                                                      {  
                                                       hasil= "Sales Invoice";   
                                                      } 
                                        %> 
                                                    
                                        <td nowrap><%=hasil%></td>            
                                        <td><%=  bean.getShipReceiver() != null &&  bean.getShipReceiver().length() > 0 ?  bean.getShipReceiver().replaceAll("\n","<br>") : "-" %> </td>                                        
                                        <td><%=  bean.getShipAddress1() != null &&  bean.getShipAddress1().length() > 0 ?  bean.getShipAddress1().replaceAll("\n","<br>") : "-" %> </td>                                        
                                        <td align="center"><%=  bean.getShipCountry() != null &&  bean.getShipCountry().length() > 0 ?  bean.getShipCountry().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td align="right" nowrap><std:currencyformater code="" value="<%= bean.getNetSalesAmount() + bean.getTotalBv3() %>"/></td>
                                        <td align="right" nowrap><std:currencyformater code="" value="<%= bean.getTotalBv3() %>"/></td>
                                        <td align="right" nowrap><std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/></td>
  
                                        <td nowrap>
                                            <std:text value="<%= bean.getBonusEarnerID() %>"/>
                                            <% if (bean.getBonusEarnerID() != null) { %>
                                            <br>
                                            <% } %>
                                            <std:text value="<%= bean.getBonusEarnerName() %>"/>                                            
                                        </td>
                                                                                
                                        <td nowrap>
                                            <std:text value="<%= bean.getCustomerID() %>"/>
                                            <% if (bean.getCustomerID() != null) { %>
                                            <br>
                                            <% } %>
                                            <std:text value="<%= bean.getCustomerName() %>"/>
                                        </td>
                                        
                                        <td nowrap><%=  bean.getShipZipcode() != null &&  bean.getShipZipcode().length() > 0 ?  bean.getShipZipcode().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td nowrap><%=  bean.getShipAddress2() != null &&  bean.getShipAddress2().length() > 0 ?  bean.getShipAddress2().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td nowrap><%=  bean.getShipContact() != null &&  bean.getShipContact().length() > 0 ?  bean.getShipContact().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td align="right" nowrap><%=  bean.getShipCity() != null &&  bean.getShipCity().length() > 0 ?  bean.getShipCity().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td align="right" nowrap><%=  bean.getShipExpedition() != null &&  bean.getShipExpedition().length() > 0 ?  bean.getShipExpedition().replaceAll("\n","<br>") : "-" %> </td>  
                                        <td align="right" nowrap><%=  bean.getPaymentRemark() != null &&  bean.getPaymentRemark().length() > 0 ?  bean.getPaymentRemark().replaceAll("\n","<br>") : "-" %> </td>  
                                        
                                        <td align="right" nowrap><std:currencyformater code="" value="<%= (bean.getDeliveryAmount() )%>"/></td>                                        
   				        <td align="right" nowrap ><std:currencyformater code="" value="<%= bean.getPaymentTender() %>"/></td>

                                        <td><std:text value="<%= bean.getRemark() %>" defaultvalue="-"/></td>
                                        
                                        <td align="center" nowrap>
                                            <%= CounterSalesManager.defineTrxStatusName(bean.getStatus()) %>
                                            </td>
                                        <td><std:text value="<%= bean.getStd_createBy() %>" defaultvalue="-"/></td>
                                    </tr>
                                    
                                    <% 
                                    } // end dtlList
                                    %>
                                    
                                </table>
                            </td>
                        </tr>
                        
                        <% 
                        } // end dtlList.size
                        %>
                        
                        <% 
                        } // end documentList
                        %>
                        
                    </table>
                </td>
            </tr>
            
            <% 
            } // end for trxDateList
            %>
            
        </table>
        
        <% 
        } // end for trxDateList != null
        %>
        
        <!-- End Sales trx -->
        
        <% 
        if (trxDateList.length <= 0) {
        %>
        
        <p>No record found</p>
        
        <%
        } 
        %>
        
        <%
        } // end canView
        %>
        
    </body>	
</html>



