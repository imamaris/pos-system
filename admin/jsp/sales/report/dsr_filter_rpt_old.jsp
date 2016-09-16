<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 19 Sept 2013
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
<%@ page import="java.text.SimpleDateFormat"%>

<%
MvcReturnBean returnBean = (MvcReturnBean)  request.getAttribute(MvcReturnBean.RETURNBEANCODE);

String taskTitle = (String) returnBean.getReturnObject("TaskTitle");
String task = (String) returnBean.getReturnObject(AppConstant.RETURN_TASKID_CODE);
int taskID = 0;
if (task != null)
    taskID = Integer.parseInt(task);
    
DSRReportBean[] DSRdocDate = (DSRReportBean[]) returnBean.getReturnObject("DSRReport");
DSRReportManager dsrMgr = new DSRReportManager();
OutletManager otlMgr = new OutletManager();

boolean canView = DSRdocDate != null;

%>
<html>
    <head>
        <title></title>
        
        <%@ include file="/lib/header.jsp"%>
        
        <script type="text/javascript">  
            function gotoPDF(elemId, frmFldId)
            {
                $("#dsr_pdf_form").attr("action","admin/jsp/sales/report/export_pdf.jsp?"+$("#frmSearch").serialize());
                $("#dsr_pdf_form").submit();
            }  
            
            function gotoXCL()
            {
                $("#dsr_pdf_form").attr("action","admin/jsp/sales/report/export_excel.jsp?"+$("#frmSearch").serialize());
                $("#dsr_pdf_form").submit();
            }  
        </script>
        <style>
            .sir{background:#66FF66}
            .smry td {
                    border: 0px;
                    padding: 3px 3px 3px 3px
            }
        </style>
        
    </head>
    
    <body>
        <div class="functionhead"><%= taskTitle %></div>
        
        <br>
        
        <%@ include file="/lib/return_error_msg.jsp"%>
        
        <form name="frmSearch" id="frmSearch" action="<%=Sys.getControllerURL(taskID,request)%>" method="post">
            
            <table border="0">
                <tr>
                    <td class="td1">Boutique:</td>
                    <td><std:text value="<%= loginUser.getOutletID() %>" defaultvalue="-"/></td>
                    <td>&nbsp;</td>
                    <td class="td1"><i18n:label code="GENERAL_USERID"/>:</td>
                    
                    <td>
                        <% 
                        if (taskID == DSRReportManager.TASKID_ADMIN_DSR_FILTER_RPT) {
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
                    <td class="td1">Doc Date From :</td>
                    <td><std:input type="date" name="DocDateFrom" value="now"/></td>
                    <td>&nbsp;</td>
                    <td class="td1">Doc Date To :</td>
                    <td><std:input type="date" name="DocDateTo" value="now"/></td>
                </tr>
            </table>
            
            <br>
            
            <std:input type="hidden" name="<%= AppConstant.RETURN_SUBMIT_CODE %>"/>
            
            <input class="textbutton" type="submit" value="<i18n:label code="GENERAL_BUTTON_SUBMIT"/>">
        </form>
        <%
             if(canView) {
                if(DSRdocDate.length > 0)
                {   
                    SimpleDateFormat format1 = new SimpleDateFormat("dd-MMM-yyyy");
                    SimpleDateFormat format2 = new SimpleDateFormat("EEEE");
                    SimpleDateFormat format3 = new SimpleDateFormat("dd-MM-yyyy");
                    SimpleDateFormat format4 = new SimpleDateFormat("MMM yyyy");
                    String outletID = loginUser.getOutletID();
                    String[] dateSplit,dateFromSplit,dateToSplit;
                    String trxDateFormat;
                    String docDateFormat,docDateFormatFrom,docDateFormatTo;
                    String docDateFormatFrom1,docDateFormatTo1;
                    Date DsrDateFrom = DSRdocDate[0].getDSRDocDate();
                    Date DsrDateTo = DSRdocDate[DSRdocDate.length - 1].getDSRDocDate();
                    docDateFormatFrom1 = format1.format(DsrDateFrom);
                    docDateFormatFrom = format3.format(DsrDateFrom);
                    docDateFormatTo1 = format1.format(DsrDateTo);
                    docDateFormatTo = format3.format(DsrDateTo);
                    String exportFileName = "DSR_"+ loginUser.getOutletID().toUpperCase() +"_"+docDateFormatFrom.replaceAll("-","")+"-"+docDateFormatTo.replaceAll("-","");
                    int salesStat = 30;
                    int voidStat = 50;
                    int returnStat = 60;
                    
                    OutletBean outlet = otlMgr.getRecord(outletID);
                    int DSRCatStat = outlet.getDSRCatStat();
                %>
                <div style="float:left">
                    <form name="dsr_pdf_form" id="dsr_pdf_form" action="admin/jsp/sales/report/export_pdf.jsp" method="post">
                        <input type="hidden" id="fileName" name="fileName" value="<%=exportFileName%>" />
                        <input type="hidden" id="outletID" name="outletID" value="<%=loginUser.getOutletID()%>" />
                        <input type="hidden" id="DSRCatStat" name="DSRCatStat" value="<%=DSRCatStat%>" />
                        <input type="hidden" id="outletName" name="outletName" value="<%=loginUser.getUserName()%>" />
                        <!-- <button id="btn_export_pdf" title="Export to PDF" onclick="gotoPDF('tableData', 'tableHTML');" style="cursor:hand"><img src="<%=request.getContextPath()%>/img/pdf_icon.gif" border="0" width="36"/></button> -->
                        <img id="img_load_pdf" src="<%=request.getContextPath()%>/img/indicator.gif" style="display:none" />
                        <% 
                        /*if(loginUser.getUserGroupType() == 100) 
                        {*/
                        %>
                            <button id="btn_export_xcl" title="Export to Excel" onclick="gotoXCL()" style="cursor:hand"><img src="<%=request.getContextPath()%>/img/excel_icon.gif" border="0" width="36" /></button>
                            <img id="img_load_xcl" src="<%=request.getContextPath()%>/img/indicator.gif" style="display:none" />
                        <%
                        /*}*/
                        %>
                    </form>
                </div>
                <!-- <div>
                    <button title="Print" class="noprint textbutton" onclick="window.print()" style="cursor:hand"><img src="<%=request.getContextPath()%>/img/printer_icon.gif" border="0" width="36"/></button>
                </div> -->
                <div id="tableData">
                    <p>
                        <div style="clear:both" height="50"><b>Daily Sales - <%= loginUser.getUserName()%> <%=docDateFormatFrom1%> s/d <%=docDateFormatTo1%></b></div>
                    </p>
                    <table width="100%" class="listbox" border="1" cellspacing="0">
                        <% 
                        for(int j = 0;j < DSRdocDate.length;j++)
                        {
                            String docDate = DSRdocDate[j].getDSRDocDate().toString();
                            DSRReportManager rptMgr = new DSRReportManager();
                            DSRReportBean[] rptBean = rptMgr.getDSRReport(outletID,DSRCatStat,docDate,docDate);
                            DSRReportBean[] curRate = rptMgr.getCurRate(docDate);
                            String DSRDateFormat = format1.format(DSRdocDate[j].getDSRDocDate());
                            String dateYtd = format1.format(rptBean[0].getDocDate());
                            String dayName = format2.format(DSRdocDate[j].getDSRDocDate());
                            Map<String, String> arrRemark = new HashMap<String, String>();
                            Map<String, String> arrPayType = new HashMap<String, String>();
                            Map<String, String> arrRowspan = new HashMap<String, String>();
                            int totQty = 0;
                            double sumTotQtyRtlPrice = 0;
                            double totDiscPayAmt = 0;
                            double totNetPrice = 0;
                            int bf_qty = rptBean[0].getQtyOrder();
                            double bf_idrRetailPrice = rptBean[0].getIDRRetailPrice();
                            double bf_discPayAmt = rptBean[0].getDiscPayAmt();
                            double bf_netPrice = rptBean[0].getNetPrice();
                            int tot_bf_qty = 0;
                            double tot_bf_idrRetailPrice = 0;
                            double tot_bf_discPayAmt = 0;
                            double tot_bf_netPrice = 0;
                            String note = "Note";
                            int rows = 0;
                            String invoiceNo = "";
                            String srlNmbr = "";
                            String SummDateFormat = format4.format(DSRdocDate[j].getDSRDocDate());
                        %>
                        <tr class="boxhead" align="center">
                            <td align="center" nowrap><b>Sort<br>Ref<br>Code</b></td>
                            <td width="100" align="center"><b>Date</b></td>
                            <td align="center" nowrap><b>Invoice<br>No</b></td>
                            <td align="center" nowrap><b>Product<br>Ref No</b></td>
                            <td width="200" align="center"><b>Description</b></td>
                            <td align="center" nowrap><b>Serial Number</td>
                            <td width="25" align="center"><b>QTY</b></td>
                            <td align="center" nowrap><b>(In S $)<br>(Per Unit)<br>Retail Price</b></td>
                            <td align="center" nowrap><b>Ttl Qty<br>Rtl Prc</b></td>
                            <td align="center" nowrap><b>Disc<br>Rate</b></td>
                            <td align="center" nowrap><b>In(Rp.)<br>Disc</b></td>
                            <td align="center" nowrap><b>(In Rp)<br>Net Sales<br>Total</b></td>
                            <td align="center" nowrap><b>Total<br>Daily</b></td>
                            <td align="center" nowrap><b>Accumulation<br>Total Net Sales</b></td>
                            <td align="center" nowrap><b>Mode<br>Of<br>Payment</b></td>
                            <td width="100" align="center"><b>Sales Person</b></td>
                            <td align="center"><b>Customer</b></td>
                        </tr>
                        <tr>
                            <td height="50"></td>
                            <td colspan="2"><b>Sales for : <%=DSRDateFormat%> <br> <%=dateYtd%></b></td>
                            <td nowrap><b><%=dayName%><br>BALANCE B/F TIME</b></td>
                            <td colspan="2"></td>
                            <td align="center"><b><br><%=bf_qty%></b></td>
                            <td></td>
                            <td align="right"><b><br><std:currencyformater code="" value="<%=bf_idrRetailPrice%>"/></b></td>
                            <td></td>
                            <td align="right"><b><br><std:currencyformater code="" value="<%=bf_discPayAmt%>"/></b></td>
                            <td colspan="2"></td>
                            <td align="right"><b><br><std:currencyformater code="" value="<%=bf_netPrice%>"/></b></td>
                            <td colspan="3"></td>
                        </tr>
                        <%
                        for(int i=1;i < rptBean.length;i++)
                        {
                            invoiceNo = rptBean[i].getTrxDocno();
                            
                            if(srlNmbr.equals("")){srlNmbr = rptBean[i].getItemCode();}else{srlNmbr = rptBean[i].getSerialNumber();}
                            
                            if((i != 0) && (rptBean[i].getTrxDocno().equals(rptBean[i-1].getTrxDocno()))) invoiceNo = ""; //Show InvoiceNo
                            if((i != 0) && (rptBean[i].getSerialNumber().equals(rptBean[i-1].getSerialNumber())) && (rptBean[i].getItemCode().equals(rptBean[i-1].getItemCode())) && (invoiceNo == "")) srlNmbr = ""; //Show ProductCode
                            
                            if(srlNmbr != "" && invoiceNo == "") rows += 1;
                            if(invoiceNo != "") rows = 1;
                            
                            //out.print("invoice : " + invoiceNo + ", srlnmbr : " + srlNmbr + ", rows : " + rows + "<br>");
                            
                            if(rptBean[i].getTrxDocno().length() > 0) arrRowspan.put(rptBean[i].getTrxDocno(),"rowspan="+rows);
                            if(rptBean[i].getPayMode().length() > 0) arrPayType.put(rptBean[i].getTrxDocno() + "-" + rptBean[i].getPayMode(),rptBean[i].getPayMode());
                        }
                            
                        for(int i=1;i < rptBean.length;i++)
                        {
                            trxDateFormat = format1.format(rptBean[i].getTrxDate());
                            invoiceNo = rptBean[i].getTrxDocno();
                            String brandCode = rptBean[i].getBrandCode();
                            String productCode = rptBean[i].getItemCode();
                            String productDesc = rptBean[i].getItemDesc();
                            srlNmbr = rptBean[i].getSerialNumber();
                            int qty = rptBean[i].getQtyOrder();
                            String qty2 = String.valueOf(qty);
                            double sgdRetailPrice = rptBean[i].getRetailPrice();
                            float discount = rptBean[i].getDiscount();
                            double discPayAmt = rptBean[i].getDiscPayAmt();
                            double netPrice = rptBean[i].getNetPrice();
                            double rate = rptBean[i].getRate();
                            String payMode = rptBean[i].getPayMode();
                            String salesPerson = rptBean[i].getSalesName();
                            String customer = rptBean[i].getCustName();
                            double idrRetailPrice = rptBean[i].getIDRRetailPrice();
                            double totQtyRtlPrice = idrRetailPrice * qty;
                            float prodDisc = (float) (discPayAmt/(netPrice + discPayAmt))*100;
                            double formatProdDisc = Math.round(prodDisc*100.0)/100.0;
                            String remarks = rptBean[i].getRemark();
                            int docStat = rptBean[i].getDocStat();
                            String getRowspan = "";
                            String css = "";
                            String docNo = "";
                            
                            if((remarks.length() > 0) && (invoiceNo != ""))
                            {
                                arrRemark.put(invoiceNo,remarks);
                            }
                            
                            if((i != 0) && (rptBean[i].getTrxDocno().equals(rptBean[i-1].getTrxDocno()))) invoiceNo = ""; //Show InvoiceNo
                            if((i != 0) && (rptBean[i].getSerialNumber().equals(rptBean[i-1].getSerialNumber())) && (rptBean[i].getItemCode().equals(rptBean[i-1].getItemCode())) && (invoiceNo == "")) srlNmbr = ""; //Show ProductCode
                            
                            for(Map.Entry<String, String> rowspan : arrRowspan.entrySet()) if(rowspan.getKey().equals(invoiceNo)) getRowspan = rowspan.getValue();
                            
                            if(srlNmbr != "") 
                            {
                                if(docStat != salesStat && docStat != returnStat && docStat != voidStat)
                                {
                                    totQtyRtlPrice = totQtyRtlPrice * -1;
                                    discPayAmt = discPayAmt * -1;
                                    netPrice = netPrice * -1;
                                    qty = qty * -1;
                                    
                                    qty2 = "(" + qty2 + ")";
                                }
                                
                                if(docStat == voidStat) 
                                {
                                    css = "class=alert";
                                    docNo = "(VOIDED)" + invoiceNo;
                                }
                                else
                                {
                                    docNo = invoiceNo;
                                    
                                    totQty += qty;
                                    sumTotQtyRtlPrice += totQtyRtlPrice;
                                    totDiscPayAmt += discPayAmt; 
                                    totNetPrice += netPrice;
                                }
                                
                        %>
                            <tr <%=css%>>
                                <td align="center" valign="top" nowrap><%=brandCode%></td>
                                <td valign="top" nowrap><%=trxDateFormat%></td>
                                <td align="center" valign="top" nowrap><std:link text="<%=docNo%>" taskid="<%=CounterSalesManager.TASKID_VIEW_SALES%>" params="<%= ("SalesID="+rptBean[i].getSalesID()) %>" /></td>
                                <td valign="top" nowrap><%=(srlNmbr == "") ? "" : productCode%></td>
                                <td valign="top" nowrap><%=(srlNmbr == "") ? "" : productDesc%></td>
                                <td valign="top" nowrap><%=srlNmbr%></td>
                                <td align="center" valign="top" nowrap><%=(srlNmbr == "") ? "" : qty2%></td>
                                <% if(docStat == salesStat || docStat == returnStat || docStat == voidStat) {%>
                                    <td align="right" valign="top" nowrap><% if(srlNmbr != "") { %><std:currencyformater code="" value="<%=sgdRetailPrice%>"/><%}%></td>
                                <%}else{%>
                                    <td align="right" valign="top" nowrap><% if(srlNmbr != "") { %>(<std:currencyformater code="" value="<%=sgdRetailPrice%>"/>)<%}%></td>
                                <%}%>
                                <td align="right" valign="top"><%if(srlNmbr != "") { %><std:currencyformater code="" value="<%=totQtyRtlPrice%>"/><%}%></td>
                                <td align="center" valign="top" nowrap><% if(srlNmbr != "") { %><%=formatProdDisc%> %<%}%></td>
                                <td align="right" valign="top" nowrap><% if(srlNmbr != "") { %><std:currencyformater code="" value="<%=discPayAmt%>"/><%}%></td>
                                <td align="right" valign="top" nowrap><% if(srlNmbr != "") { %><std:currencyformater code="" value="<%=netPrice%>"/><%}%></td>
                                <td></td>
                                <td></td>
                                <% if(invoiceNo != "") {%>
                                <td nowrap valign="top" <%=getRowspan%>>
                                <%
                                    for(Map.Entry<String, String> payType : arrPayType.entrySet())
                                    {
                                        if(payType.getKey().indexOf(invoiceNo) >= 0)
                                        {
                                           out.print(payType.getValue().toString()+"</br>");
                                        }
                                    }
                                %>
                                </td>
                                <td nowrap valign="top" <%=getRowspan%>><%=(invoiceNo == "") ? "" : salesPerson%></td>
                                <td nowrap valign="top" <%=getRowspan%>><%=(invoiceNo == "") ? "" : customer%></td>
                                <%}%>
                            </tr>
                        <%
                                }
                            }
                            
                            tot_bf_qty = bf_qty + totQty;
                            tot_bf_idrRetailPrice = bf_idrRetailPrice + sumTotQtyRtlPrice;
                            tot_bf_discPayAmt = bf_discPayAmt + totDiscPayAmt;
                            tot_bf_netPrice = bf_netPrice + totNetPrice;
                            
                            SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
                            Date tf1 = df1.parse(curRate[0].getSGDStartTime());
                            SimpleDateFormat df2 = new SimpleDateFormat("hh:mm aa");
                            String timeRate = df2.format(tf1);
                        %>
                            <tr>
                                <td height="50"></td>
                                <td nowrap><b><br><%=DSRDateFormat%></b></td>
                                <td></td>
                                <td nowrap><b><br>BALANCE B/F TIME</b></td>
                                <td colspan="2"></td>
                                <td align="center"><%=totQty%><br><b><%=tot_bf_qty%></b></td>
                                <td></td>
                                <td align="right"><std:currencyformater code="" value="<%=sumTotQtyRtlPrice%>"/><b><br><std:currencyformater code="" value="<%=tot_bf_idrRetailPrice%>"/></b></td>
                                <td></td>
                                <td align="right"><std:currencyformater code="" value="<%=totDiscPayAmt%>"/><b><br><std:currencyformater code="" value="<%=tot_bf_discPayAmt%>"/></b></td>
                                <td></td>
                                <td align="right"><std:currencyformater code="" value="<%=totNetPrice%>"/><br>&nbsp;</td>
                                <td align="right"><br><b><std:currencyformater code="" value="<%=tot_bf_netPrice%>"/></b></td>
                                <td colspan="3"></td>
                            </tr>
                            <tr>
                                <td colspan="2">Exchange rate</td>
                                <td colspan="15">
                                    <%=timeRate%>
                                    &nbsp;
                                    SGD <std:currencyformater code="" value="<%=curRate[0].getSGDRate()%>"/>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    USD <std:currencyformater code="" value="<%=curRate[0].getUSDRate()%>"/>
                                </td>
                            </tr>
                            <%
                            for(Map.Entry<String, String> remark : arrRemark.entrySet())
                            {
                            %>
                            <tr>
                                <td></td>
                                <td><b><%=note%></b></td>
                                <td><b><%=remark.getKey()%></b></td>
                                <td colspan="14"><b><%=remark.getValue()%></b></td>
                            </tr>
                            <%
                                note = "";
                            }
                            %>
                            <tr>
                                <td colspan="17">
                                    <!-- TARGET SUMMARY -->
                                    <%
                                    int urut = 0;
                                    int max_urut = 8; //Maksimal Urutan Kolom Target ke Kanan
                                    int colspan2 = max_urut + 3;
                                    double totTarget = 0;
                                    double totSales = 0;
                                    float totPercent = 0f;
                                    int totSmryQty = 0;
                                    double tgtToGo = 0;
                                    float percentToGo = 0f;
                                    
                                    DSRReportBean[] Summary = dsrMgr.getSummary(loginUser.getOutletID(),DSRCatStat,DsrDateFrom.toString(),docDate);
                                    
                                    for(int i=0;i<Summary.length;i++)
                                    {
                                        totTarget += Summary[i].getSmryTarget();
                                        totSales += Summary[i].getSmrySales();
                                        totSmryQty += Summary[i].getSmryQty();
                                    }
                                    
                                    totPercent = (float) (totSales/totTarget)*100;
                                    tgtToGo = totTarget - totSales;
                                    percentToGo = (float) (totSales/totTarget)*100;
                                    
                                    if(Float.isNaN(percentToGo)) percentToGo = 0f;
                                    %>
                                    <table width="100%" border="0" cellspacing="0" class="smry">
                                    <tr>
                                        <td colspan="3" height="20">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="120" valign="top">
                                            BUDGET<br>
                                            %ACTUAL/BUDGET<br>
                                            MONTH TO GO
                                        </td>
                                        <td width="100" valign="top"><%=SummDateFormat%></td>
                                        <td align="right" valign="top">
                                            <std:currencyformater code="" value="<%=totTarget%>"/><br>
                                            <%=String.format("%.2f", percentToGo)%>%<br>
                                            (<std:currencyformater code="" value="<%=tgtToGo%>"/>)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="120" valign="top">
                                            ACCUMULATED<br>
                                            UP TO DATE
                                        </td>
                                        <td width="100" valign="top"><br><%=DSRDateFormat%></td>
                                        <td align="right" valign="top"><b><std:currencyformater code="" value="<%=totNetPrice%>"/></b></td>
                                    </tr>
                                </table>
                                <br>
                                <table width="100%" border="0" cellspacing="0" class="smry">
                                <%
                                for(int k=0;k<Summary.length;k++)
                                {
                                    urut++;

                                    if(urut == 1)
                                    {
                                        %>
                                        <tr>
                                            <td width="120" valign="top">
                                                <br>
                                                BUDGET<br>
                                                %ACTUAL/BUDGET<br>
                                                ACTUAL PIECES<br>
                                                MONTH ACHIEVED
                                            </td>
                                            <td align="left" valign="top" width="100"><br><%=SummDateFormat%></td>
                                        <%
                                    }

                                    %>
                                    <td align="right" valign="top" width="120">
                                        <b>
                                            <%=Summary[k].getSmryBrand().toUpperCase()%><br>
                                            <std:currencyformater code="" value="<%=Summary[k].getSmryTarget()%>"/><br>
                                            <%=String.format("%.2f",Summary[k].getSmryPercent())%>%<br>
                                            <%=Summary[k].getSmryQty()%><br>
                                            <std:currencyformater code="" value="<%=Summary[k].getSmrySales()%>"/>
                                        </b>
                                    </td>
                                    <%

                                    if((urut == max_urut) || ((k+1) == Summary.length))
                                    {   
                                        int colspan = (max_urut - urut) + 1;

                                        %>
                                            <td align="right" valign="top" colspan="<%=colspan%>">
                                                <%if((k+1) == Summary.length){%>
                                                <b>
                                                    <br>
                                                    <std:currencyformater code="" value="<%=totTarget%>"/><br>
                                                    <%=String.format("%.2f", totPercent)%>%<br>
                                                    <%=totSmryQty%><br>
                                                    <std:currencyformater code="" value="<%=totSales%>"/>
                                                </b>
                                                <%}
                                                %>
                                            </td>
                                        <%

                                        if(urut == max_urut)
                                        {
                                            %>
                                            </tr>
                                            <tr>
                                                <td height="5" colspan="<%=colspan2%>"></td>
                                            </tr>
                                            <%

                                            urut = 0;
                                        }
                                    }
                                }
                                %>
                                <tr>
                                    <td height="20" colspan="<%=colspan2%>"></td>
                                </tr>
                                </table>
                                <!-- END TARGET SUMMARY -->
                                </td>
                            </tr>
                        <%
                        }
                        %>
                    </table>
                    <br><br>
                    
                </div>
                <%
                }
                else
                {
                %>
                    No Records Found
                <%
                }
             }
        %>
</body>	
</html>