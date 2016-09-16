<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 27 Mei 2012
    Project     : DSR Report
--%>

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
        
        <script type="text/javascript">  
              function gotoExcel(elemId, frmFldId)
              {  
                  var obj = document.getElementById(elemId);  
                  var oFld = document.getElementById(frmFldId);
                  
                  oFld.value = obj.innerHTML;
                  
                  document.forms["dsr_xcl_form"].submit();
              }  
        </script>
        <style>
            .sir{background:#66FF66}
        </style>
        
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
                        if (taskID == CounterSalesReportManager.TASKID_ADMIN_DSR_FILTER_RPT) {
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
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
        </form>
        
    <% 
    if (canView) {

        Date[] trxDateList = rptBean.getTrxColletionDateList();
        String[] documentList = rptBean.getDocumentList();
        OutletPaymentModeBean[] paymodeList = rptBean.getPaymentModeList();
        ArrayList docListCN = null;
        ArrayList docListCB = null;
        ArrayList docList = null;
        String[] dtQty,dtPay1,dtPay2,dtPay3,dtPayNet;
        String[] dtPayCN1,dtPayCN2,dtPayCN3,dtPayNetCN;
            
        if(trxDateList.length > 0)
        {   
            ArrayList<String> payArr = new ArrayList<String>(); 
            String payList = "";
            String payType = "";
            
            String DsrDateFrom = trxDateList[0].toString();
            String DsrDateTo = trxDateList[trxDateList.length - 1].toString();

            String exportFileName = "DSR_REPORT_"+ loginUser.getOutletID().toUpperCase() +"_"+DsrDateFrom.replaceAll("-","")+"-"+DsrDateTo.replaceAll("-","")+".xls";
            
            for(int i = 0; i<trxDateList.length; i++) 
            {   
                CounterCollectionReportBean.SalesTrxBean trxBeanPayType = rptBean.getTrxCollection(trxDateList[i]);
                
                for(int j=0;j<documentList.length;j++)
                {
                    docList = trxBeanPayType.getDocGrpDetail(documentList[j]);
                    
                    for(int k=0;k<docList.size();k++)
                    {   
                        CounterSalesOrderBean beanPayType = (CounterSalesOrderBean) docList.get(k);
                        
                        dtPay1 = beanPayType.getShipZipcode().split("\n");
                        dtPay2 = beanPayType.getShipAddress2().split("\n");
                        dtPay3 = beanPayType.getShipContact().split("\n");
                        dtPayNet = beanPayType.getShipCity().split("\n");
                        
                        for(int l=0;l<dtPay1.length;l++)
                        {
                           if(dtPay1[l].trim().length() > 0)
                           {
                               payType =  dtPay1[l].trim() + "-" + dtPay2[l].trim() + "-" + dtPay3[l].trim();

                               if(payList.indexOf(payType) == -1 && Double.parseDouble(dtPayNet[l].trim()) != 0)
                               {
                                   payArr.add(payType);
                               }

                               payList += ","+payType;
                           }
                        }
                    }
                }
            }
            %>
          <div style="float:left">
            <form name="dsr_xcl_form" action="admin/jsp/sales/report/dsr_export_excel.jsp" method="post">
                <input type="hidden" id="tableHTML" name="tableHTML" value="" />
                <input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />
                <input type="button" onclick="gotoExcel('tableData', 'tableHTML');" value="Export to Excel" />  
            </form>
        </div>
        <div>
            <input class="noprint textbutton" type="button" value="<i18n:label code="GENERAL_BUTTON_PRINT"/>" onclick="window.print()">
        </div>
            <!-- Collection summary -->
          <div id="tableData">
              <div style="clear:both"><b>DSR Report - <%= loginUser.getUserName()%> <%=DsrDateFrom%> s/d <%=DsrDateTo%></b></div>
            <br>
            <table class="listbox" width="100%" border="1">
                <tr class="boxhead" align="center">
                    <td rowspan=2><b>DATE</b></td>
                    <td rowspan=2><b>INVOICE NO</b></td>
                    <td rowspan=2><b>REFERENCE</b></td>
                    <td rowspan=2><b>QTY</b></td>
                    <td rowspan=2><b>NET SALES</b></td>
                    <td rowspan=2><b>PAYMENT METHOD</b></td>
                    <td colspan="<%=payArr.size()%>"><b>PAYMENT DETAIL</b></td>
                    <td rowspan=2><b>CUSTOMER</b></td>
                    <td rowspan=2><b>REMARKS</b></td>
                </tr>
                <tr class="boxhead">
                    <%  
                    for(String payment : payArr)
                    {
                    %>
                    <td nowrap width="100"><b><%=payment%></b></td>
                    <% 
                    }
                    %>
                </tr>
                <%
                ArrayList trxDate = new ArrayList();
                String rowCss = "";
                int next = 0;    
                int prev;
                int totQty = 0;
                double netPayType = 0;
                double totNetSales = 0;
                double totNetPayType[] = new double[payArr.size()];
                
                for(int i = 0; i<trxDateList.length; i++) 
                { 
                
                CounterCollectionReportBean.SalesTrxBean trxBean = rptBean.getTrxCollection(trxDateList[i]);
                
                docListCB = trxBean.getDocGrpDetail("IN");
                
                for(int j=0;j<docListCB.size();j++)
                {   
                CounterSalesOrderBean bean = (CounterSalesOrderBean) docListCB.get(j);
                
                if((bean.getStatus() == CounterSalesManager.STATUS_ACTIVE || bean.getStatus() == CounterSalesManager.STATUS_FULL_REFUNDED) && bean.getStatus() != CounterSalesManager.STATUS_ADJST)
                {
                    
                prev = next;
                
                if ((j+1) % 2 == 0) rowCss = "even"; else rowCss = "odd";
                
                if(bean.getStatus() == CounterSalesManager.STATUS_FULL_REFUNDED) rowCss = "alert";
                
                if(bean.getAdjstRefNo() != null) rowCss = "sir";
                
                dtQty = bean.getShipCountry().split("\n");
                dtPay1 = bean.getShipZipcode().split("\n");
                dtPay2 = bean.getShipAddress2().split("\n");
                dtPay3 = bean.getShipContact().split("\n");
                dtPayNet = bean.getShipCity().split("\n");
                
                for(int td=0;td<trxDateList.length;td++)
                {
                    CounterCollectionReportBean.SalesTrxBean trxBeanCN = rptBean.getTrxCollection(trxDateList[td]);

                    docListCN = trxBeanCN.getDocGrpDetail("CN");

                    for(int cn=0;cn<docListCN.size();cn++)
                    {
                        CounterSalesOrderBean beanCN = (CounterSalesOrderBean) docListCN.get(cn);
                        
                        if(bean.getTrxDocNo().equals(beanCN.getAdjstRefNo()) && beanCN.getTrxGroup() == CounterSalesManager.STATUS_VOIDED)
                         {
                            rowCss = "alert";
                            totNetSales += beanCN.getNetSalesAmount();
                            
                            if(next != 0) prev -= 1;
                
                            trxDate.add(trxDateList[i]);

                            dtPayCN1 = beanCN.getShipZipcode().split("\n");
                            dtPayCN2 = beanCN.getShipAddress2().split("\n");
                            dtPayCN3 = beanCN.getShipContact().split("\n");
                            dtPayNetCN = beanCN.getShipCity().split("\n");
                         %>
                            <tr class="alert">
                                <td nowrap class="boxhead" bgcolor="#FFFFFF" style="border:0px" valign="top"><b><%=(next == 0 || trxDate.get(next) != trxDate.get(prev)) ? trxDateList[i] : "" %></b></td>
                                <td nowrap valign="top"><%=beanCN.getAdjstRefNo()%><br><%=beanCN.getTrxDocNo()%></td>
                                <td nowrap><%=  beanCN.getShipAddress1() != null &&  beanCN.getShipAddress1().length() > 0 ?  beanCN.getShipAddress1().replaceAll("\n","<br>") : "-" %> </td>
                                <td align="center" nowrap><%=  beanCN.getShipCountry() != null &&  beanCN.getShipCountry().length() > 0 ?  beanCN.getShipCountry().replaceAll("\n","<br>") : "-" %> </td>
                                <td align="right" valign="middle" nowrap width="100"><std:currencyformater code="" value="<%= beanCN.getNetSalesAmount() %>"/></td>
                                <td nowrap width="300">
                                    <%
                                    for(int c=0;c<dtPayCN1.length ;c++)
                                    { 
                                        payType = "";
                                        payType = dtPayCN1[c].trim() + "-" + dtPayCN2[c].trim() + "-" + dtPayCN3[c].trim();

                                        if(dtPayCN1[c].trim().length() > 0)
                                        {
                                    %>
                                    <%=payType%><br>
                                    <%
                                        }
                                    }
                                    %>
                                </td>
                                <%

                                for(int k=0;k<payArr.size();k++)
                                {
                                    for(int c=0;c<dtPay1.length ;c++)
                                    {
                                        if(payArr.get(k).equalsIgnoreCase(dtPayCN1[c].trim() + "-" + dtPayCN2[c].trim() + "-" + dtPayCN3[c].trim()))
                                        {
                                            netPayType += Double.parseDouble(dtPayNetCN[c].trim());
                                        }
                                    }

                                    totNetPayType[k] += netPayType;
                                %>
                                <td nowrap align="right"><std:currencyformater code="" value="<%=netPayType%>"/></td>
                                <% 
                                     netPayType = 0;
                                }
                                %>
                                <td nowrap><%=beanCN.getCustomerName()%></td>
                                <td nowrap width="200"><%=beanCN.getRemark()%></td>
                            </tr>
                    <% 
                        //docListCN.
                        next += 1;
                       }
                    }
                }
                
                if(bean.getStatus() != CounterSalesManager.STATUS_FULL_REFUNDED)
                {
                    if(next != 0) prev -= 1;
                
                    trxDate.add(trxDateList[i]);
                    
                    for(int a = 0;a < dtQty.length ;a++)
                    {
                        totQty += Integer.parseInt(dtQty[a].trim());
                    }
                    totNetSales += bean.getNetSalesAmount();
                %>
                <tr class="<%= rowCss %>">
                    <td nowrap class="boxhead" bgcolor="#FFFFFF" style="border:0px" valign="top"><b><%=(next == 0 || trxDate.get(next) != trxDate.get(prev)) ? trxDateList[i] : "" %></b></td>
                    <td nowrap valign="top"><%=(bean.getAdjstRefNo() != null) ? bean.getAdjstRefNo()+"<br>" : "" %><%=bean.getTrxDocNo()%></td>
                    <td nowrap><%=  bean.getShipAddress1() != null &&  bean.getShipAddress1().length() > 0 ?  bean.getShipAddress1().replaceAll("\n","<br>") : "-" %> </td>
                    <td align="center" nowrap><%=  bean.getShipCountry() != null &&  bean.getShipCountry().length() > 0 ?  bean.getShipCountry().replaceAll("\n","<br>") : "-" %> </td>
                    <td align="right" valign="middle" nowrap width="100"><std:currencyformater code="" value="<%= bean.getNetSalesAmount() %>"/></td>
                    <td nowrap width="300">
                        <%
                        for(int c=0;c<dtPay1.length ;c++)
                        { 
                            payType = "";
                            payType = dtPay1[c].trim() + "-" + dtPay2[c].trim() + "-" + dtPay3[c].trim();

                            if(dtPay1[c].trim().length() > 0)
                            {
                        %>
                        <%=payType%><br>
                        <%
                            }
                        }
                        %>
                    </td>
                    <%
                    
                    for(int k=0;k<payArr.size();k++)
                    {
                        for(int c=0;c<dtPay1.length ;c++)
                        {
                            if(payArr.get(k).equalsIgnoreCase(dtPay1[c].trim() + "-" + dtPay2[c].trim() + "-" + dtPay3[c].trim()))
                            {
                                netPayType += Double.parseDouble(dtPayNet[c].trim());
                            }
                        }

                        totNetPayType[k] += netPayType;
                    %>
                    <td nowrap align="right"><std:currencyformater code="" value="<%=netPayType%>"/></td>
                    <% 
                         netPayType = 0;
                    }
                    %>
                    <td nowrap><%=bean.getCustomerName()%></td>
                    <td nowrap width="200"><%=bean.getRemark()%></td>
                </tr>
                <% 
                next += 1;
                }
                }
                }
                %>
                <tr class="boxhead">
                    <td><b>TOTAL</b></td>
                    <td></td>
                    <td></td>
                    <td><b><%=totQty%></b></td>
                    <td align="right"><b><std:currencyformater code="" value="<%=totNetSales%>"/></b></td>
                    <td></td>
                    <%  
                    for(int l=0;l<payArr.size();l++)
                    {
                    %>
                    <td nowrap align="right"><b><std:currencyformater code="" value="<%=totNetPayType[l]%>"/></b></td>
                    <% 
                    totNetPayType[l] = 0;
                    }
                    %>
                    <td></td>
                    <td></td>
                </tr>
                <%
                totNetSales = 0;
                totQty = 0;
                }
                %>
            </table>
        </div>
        <!-- End Collection summary -->
        <br>
    <%
        } else {%> No Records Found <%}
    } // end canView
    %>
        
    </body>	
</html>