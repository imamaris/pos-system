/*
 * DSRReport.java
 *
 * Created on June 17, 2013, 3:04 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales.pdfreport;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.orca.counter.sales.DSRReportManager;
import com.ecosmosis.orca.counter.sales.DSRReportBean;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.awt.Desktop;
import java.io.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRReportPDF{
    
    private static Font titleFont = new Font(Font.FontFamily.HELVETICA, 12,Font.BOLD);
    private static Font boldFont = new Font(Font.FontFamily.HELVETICA, 10,Font.BOLD);
    private static Font normalFont = new Font(Font.FontFamily.HELVETICA, 10,Font.NORMAL);
    private static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 8,Font.BOLD);
  
    /** Creates a new instance of DSRReport */
    public DSRReportPDF() {
    }
    
    public void getDSRReportPDF(String filename,String outletID,int DSRCatStat,String outletName,String docDtFromStr, String docDtToStr, String path, OutputStream out) {
    //String FILE = path+filename+".pdf";
    DSRReportManager mgr = new DSRReportManager();
    try {
      DSRReportBean[] DSRdocDate = mgr.getDSRDocDate(outletID, docDtFromStr, docDtToStr);
      Document document = new Document(PageSize.A2.rotate(),3,3,3,3);
      DSRReportManager dsrMgr = new DSRReportManager();
      //PdfWriter.getInstance(document, new FileOutputStream(FILE));
      PdfWriter.getInstance(document, out);
      document.open();
      getTitle(document, outletName, DSRdocDate);
      getContent(document, dsrMgr, outletID, DSRCatStat, DSRdocDate);
      document.close();
      //this.openFile(FILE);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
    
  private void openFile(String filePDF)
  {
    if (Desktop.isDesktopSupported()) {
        try {
            File myFile = new File(filePDF);
            Desktop.getDesktop().open(myFile);
        } catch (IOException ex) {
            // no application registered for PDFs
        }
    }
  }
  
  private static void getTitle(Document document, String outletName, DSRReportBean[] DSRdocDate)
    throws DocumentException
  {
    SimpleDateFormat format1 = new SimpleDateFormat("dd-MMM-yyyy");
    Date DsrDateFrom = DSRdocDate[0].getDSRDocDate(); 
    Date DsrDateTo = DSRdocDate[DSRdocDate.length - 1].getDSRDocDate();
    String docDateFormatFrom = format1.format(DsrDateFrom);
    String docDateFormatTo = format1.format(DsrDateTo);
                     
    String title = "Daily Sales - " + outletName + "\n" + docDateFormatFrom + " s/d " + docDateFormatTo;
    
    Paragraph preface = new Paragraph(title,titleFont); 
    preface.setAlignment(Element.ALIGN_CENTER);
    
    document.add(preface);
    document.add(new Paragraph(" "));
    //document.add(Chunk.NEWLINE);
  }
  
  private static void getContent(Document document, DSRReportManager dsrMgr, String outletID, int DSRCatStat, DSRReportBean[] DSRdocDate)
    throws DocumentException, MvcException, ParseException
  {  
    if(DSRdocDate.length > 0)
    { 
        SimpleDateFormat format1 = new SimpleDateFormat("dd-MMM-yyyy");
        SimpleDateFormat format2 = new SimpleDateFormat("EEEE");
        SimpleDateFormat format3 = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat format4 = new SimpleDateFormat("MMM yyyy");
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
        String SummDateFormat = "";
        
        int salesStat = 30;
        int voidStat = 50;
        int returnStat = 60;

        for(int j = 0;j < DSRdocDate.length;j++)
        {
            int totWidth = 1680;
            int[] col_w = new int[17];
            String[] header = new String[17];

            header[0] = "Sort\nRef\nCode";
            header[1] = "Date";
            header[2] = "Invoice\nNo";
            header[3] = "Product\nRef No";
            header[4] = "Description";
            header[5] = "Serial Number";
            header[6] = "QTY";
            header[7] = "(In S $)\n(Per Unit)\nRetail Price";
            header[8] = "Ttl Qty\nRtl Prc";
            header[9] = "Disc\nRate";
            header[10] = "In(Rp.)\nDisc";
            header[11] = "(In Rp)\nNet Sales\nTotal";
            header[12] = "Total\nDaily";
            header[13] = "Accumulation\nTotal Net Sales";
            header[14] = "Mode\nOf\nPayment";
            header[15] = "Sales Person";
            header[16] = "Customer";

            col_w[0] = 50;
            col_w[1] = 80;
            col_w[2] = 120;
            col_w[3] = 130;
            col_w[4] = 220;
            col_w[5] = 120;
            col_w[6] = 30;
            col_w[7] = 70;
            col_w[8] = 80;
            col_w[9] = 60;
            col_w[10] = 80;
            col_w[11] = 80;
            col_w[12] = 80;
            col_w[13] = 90;
            col_w[14] = 250;
            col_w[15] = 100;
            col_w[16] = 150;

            PdfPTable table = new PdfPTable(17);
            table.setTotalWidth(totWidth);
            table.setLockedWidth(true);
            table.setWidths(col_w);
    
            String docDate = DSRdocDate[j].getDSRDocDate().toString();
            DSRReportManager rptMgr = new DSRReportManager();
            DSRReportBean[] rptBean = rptMgr.getDSRReport(outletID,DSRCatStat,docDate,docDate);
            DSRReportBean[] curRate = rptMgr.getCurRate(docDate);
            String DSRDateFormat = format1.format(DSRdocDate[j].getDSRDocDate());
            String dateYtd = format1.format(rptBean[0].getDocDate());
            String dayName = format2.format(DSRdocDate[j].getDSRDocDate());
            Map arrRemark = new HashMap();
            Map arrPayType = new HashMap();
            Map arrRowspan = new HashMap();
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
            SummDateFormat = format4.format(DSRdocDate[j].getDSRDocDate());
                
            //HEADER
            for(int i=0;i<header.length;i++)
            {
                PdfPCell c1 = new PdfPCell(new Phrase(header[i],boldFont));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(c1);
            }
            //END HEADER
            
            PdfPCell c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c1.setFixedHeight(40);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Sales for : " + DSRDateFormat + "\n" + dateYtd,boldFont));
            c1.setColspan(2);
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);

            c1 = new PdfPCell(new Phrase(dayName + "\nBALANCE B/F TIME",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setColspan(2);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(" \n" + String.valueOf(bf_qty),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(" \n" + getCurFormat(bf_idrRetailPrice),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(" \n" + getCurFormat(bf_discPayAmt),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setColspan(2);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(" \n" + getCurFormat(bf_netPrice),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setColspan(3);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);

            //DETAIL
            for(int i=1;i < rptBean.length;i++)
            {
                invoiceNo = rptBean[i].getTrxDocno();

                if(srlNmbr.equals("")){srlNmbr = rptBean[i].getItemCode();}else{srlNmbr = rptBean[i].getSerialNumber();}

                if((i != 0) && (rptBean[i].getTrxDocno().equals(rptBean[i-1].getTrxDocno()))) invoiceNo = ""; //Show InvoiceNo
                if((i != 0) && (rptBean[i].getSerialNumber().equals(rptBean[i-1].getSerialNumber())) && (rptBean[i].getItemCode().equals(rptBean[i-1].getItemCode())) && (invoiceNo == "")) srlNmbr = ""; //Show ProductCode

                if(srlNmbr != "" && invoiceNo == "") rows += 1;
                if(invoiceNo != "") rows = 1;

                if(rptBean[i].getTrxDocno().length() > 0) arrRowspan.put(rptBean[i].getTrxDocno(),String.valueOf(rows));
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
                int getRowspan = 0;

                if((remarks.length() > 0) && (invoiceNo != ""))
                {
                    arrRemark.put(invoiceNo,remarks);
                }

                if((i != 0) && (rptBean[i].getTrxDocno().equals(rptBean[i-1].getTrxDocno()))) invoiceNo = ""; //Show InvoiceNo
                if((i != 0) && (rptBean[i].getSerialNumber().equals(rptBean[i-1].getSerialNumber())) && (rptBean[i].getItemCode().equals(rptBean[i-1].getItemCode())) && (invoiceNo == "")) srlNmbr = ""; //Show ProductCode
                
                for(Iterator it = arrRowspan.keySet().iterator(); it.hasNext();)
                {
                    String key = (String)it.next();
                    if(key.equals(invoiceNo)) getRowspan = Integer.parseInt(arrRowspan.get(key).toString());
                }
                
                if(srlNmbr != "") 
                {
                    if(docStat != salesStat && docStat != returnStat)
                    {
                        totQtyRtlPrice = totQtyRtlPrice * -1;
                        discPayAmt = discPayAmt * -1;
                        netPrice = netPrice * -1;
                        qty = qty * -1;

                        qty2 = "(" + qty2 + ")";
                    }

                    totQty += qty;
                    sumTotQtyRtlPrice += totQtyRtlPrice;
                    totDiscPayAmt += discPayAmt; 
                    totNetPrice += netPrice;
                
                    c1 = new PdfPCell(new Phrase(brandCode,normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    c1 = new PdfPCell(new Phrase(trxDateFormat,normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    c1 = new PdfPCell(new Phrase(invoiceNo,normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(productCode,normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(productDesc,normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    c1 = new PdfPCell(new Phrase(srlNmbr,normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(qty2.toString(),normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr != "")
                    {
                        if(docStat == salesStat || docStat == returnStat)
                        {
                            c1 = new PdfPCell(new Phrase(getCurFormat(sgdRetailPrice),normalFont));
                        }
                        else
                        {
                            c1 = new PdfPCell(new Phrase("(" + getCurFormat(sgdRetailPrice) + ")",normalFont));
                        }
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(getCurFormat(totQtyRtlPrice),normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(String.valueOf(formatProdDisc) + " %",normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(getCurFormat(discPayAmt),normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    if(srlNmbr == "")
                    {
                        c1 = new PdfPCell(new Phrase("",normalFont));
                    }
                    else
                    {
                        c1 = new PdfPCell(new Phrase(getCurFormat(netPrice),normalFont));
                    }
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    c1 = new PdfPCell(new Phrase("",normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);

                    c1 = new PdfPCell(new Phrase("",normalFont));
                    c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c1.setVerticalAlignment(Element.ALIGN_TOP);
                    table.addCell(c1);
                    
                    if(invoiceNo != "")
                    {
                        String payType = "";
                            
                        for(Iterator it = arrPayType.keySet().iterator(); it.hasNext();)
                        {
                            String key = (String)it.next();

                            if(key.indexOf(invoiceNo) >= 0)
                            {
                                payType += arrPayType.get(key).toString() + "\n";
                            }
                        }
                        
                        c1 = new PdfPCell(new Phrase(payType,normalFont));
                        c1.setRowspan(getRowspan);
                        c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                        c1.setVerticalAlignment(Element.ALIGN_TOP);
                        table.addCell(c1);

                        if(invoiceNo == "")
                        {
                            c1 = new PdfPCell(new Phrase("",normalFont));
                        }
                        else
                        {
                            c1 = new PdfPCell(new Phrase(salesPerson,normalFont));
                        }
                        c1.setRowspan(getRowspan);
                        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                        c1.setVerticalAlignment(Element.ALIGN_TOP);
                        table.addCell(c1);

                        if(invoiceNo == "")
                        {
                            c1 = new PdfPCell(new Phrase("",normalFont));
                        }
                        else
                        {
                            c1 = new PdfPCell(new Phrase(customer,normalFont));
                        }
                        c1.setRowspan(getRowspan);
                        c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                        c1.setVerticalAlignment(Element.ALIGN_TOP);
                        table.addCell(c1);
                    }
                }
            }
            //END DETAIL
            
            tot_bf_qty = bf_qty + totQty;
            tot_bf_idrRetailPrice = bf_idrRetailPrice + sumTotQtyRtlPrice;
            tot_bf_discPayAmt = bf_discPayAmt + totDiscPayAmt;
            tot_bf_netPrice = bf_netPrice + totNetPrice;

            SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
            Date tf1 = df1.parse(curRate[0].getSGDStartTime());
            SimpleDateFormat df2 = new SimpleDateFormat("hh:mm aa");
            String timeRate = df2.format(tf1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setFixedHeight(40);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("\n" + DSRDateFormat,boldFont));
            c1.setFixedHeight(40);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("\nBALANCE B/F TIME",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setColspan(2);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(totQty + "\n" + tot_bf_qty,boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(getCurFormat(sumTotQtyRtlPrice) + "\n" + getCurFormat(tot_bf_idrRetailPrice),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(getCurFormat(totDiscPayAmt) + "\n" + getCurFormat(tot_bf_discPayAmt),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(getCurFormat(totNetPrice) + "\n ",boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("\n" + getCurFormat(tot_bf_netPrice),boldFont));
            c1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("",boldFont));
            c1.setColspan(3);
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Exchange rate",normalFont));
            c1.setColspan(2);
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            c1 = new PdfPCell(new Phrase(timeRate + "  SGD " + getCurFormat(curRate[0].getSGDRate()) + "        USD " + getCurFormat(curRate[0].getUSDRate()),normalFont));
            c1.setColspan(15);
            c1.setHorizontalAlignment(Element.ALIGN_LEFT);
            c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
            table.addCell(c1);
            
            for(Iterator it = arrRemark.keySet().iterator(); it.hasNext();)
            {
                String key = (String)it.next();
                
                c1 = new PdfPCell(new Phrase("",boldFont));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(c1);
                
                c1 = new PdfPCell(new Phrase(note,boldFont));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(c1);
            
                c1 = new PdfPCell(new Phrase(key,boldFont));
                c1.setHorizontalAlignment(Element.ALIGN_CENTER);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(c1);
                
                c1 = new PdfPCell(new Phrase((String) arrRemark.get(key), boldFont));
                c1.setColspan(14);
                c1.setHorizontalAlignment(Element.ALIGN_LEFT);
                c1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                table.addCell(c1);
                
                note = "";
            }
            
            /** TARGET SUMMARY **/
            int urut = 0;
            int max_urut = 8; //Maksimal Urutan Kolom Target ke Kanan
            int colspan2 = max_urut + 3;
            double totTarget = 0;
            double totSales = 0;
            float totPercent = 0f;
            int totSmryQty = 0;
            double tgtToGo = 0;
            float percentToGo = 0f;
            
            DSRReportBean[] Summary = dsrMgr.getSummary(outletID,DSRCatStat,DsrDateFrom.toString(),docDate);
            
            int loopLength = (int) Math.ceil(Summary.length/(float)max_urut);
                                    
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
            
            int col_num = 11;
            int totCol_w = 0;
            col_w = new int[col_num];

            col_w[0] = 100;
            col_w[1] = 100;
            col_w[2] = 100;
            col_w[3] = 100;
            col_w[4] = 100;
            col_w[5] = 100;
            col_w[6] = 100;
            col_w[7] = 100;
            col_w[8] = 100;
            col_w[9] = 100;
            col_w[10] = 200;
            
            for(int i=0;i<col_w.length;i++) totCol_w += col_w[i];
            
            document.add(table);

            table = new PdfPTable(col_num);
            table.setTotalWidth(totCol_w);
            table.setLockedWidth(true);
            table.setWidths(col_w);
            table.setHorizontalAlignment(Element.ALIGN_LEFT);
            
            PdfPCell c2 = new PdfPCell(new Phrase("BUDGET\n%ACTUAL/BUDGET\nMONTH TO GO",normalFont));
            c2.setHorizontalAlignment(Element.ALIGN_LEFT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            c2 = new PdfPCell(new Phrase(SummDateFormat + "\n\n",normalFont));
            c2.setHorizontalAlignment(Element.ALIGN_LEFT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            for(int i=3;i<col_num;i++)
            {
                c2 = new PdfPCell(new Phrase(" ",boldFont));
                c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                c2.setBorder(0);
                table.addCell(c2);
            }
            
            c2 = new PdfPCell(new Phrase(getCurFormat(totTarget) + "\n" + String.valueOf(Math.round(percentToGo*100.0)/100.0) + "%\n(" + getCurFormat(tgtToGo) + ")",normalFont));
            c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            c2 = new PdfPCell(new Phrase(" "));
            c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setColspan(col_num);
            c2.setBorder(0);
            table.addCell(c2);
            
            c2 = new PdfPCell(new Phrase("ACCUMULATED\nUP TO DATE",normalFont));
            c2.setHorizontalAlignment(Element.ALIGN_LEFT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            c2 = new PdfPCell(new Phrase("\n" + DSRDateFormat,normalFont));
            c2.setHorizontalAlignment(Element.ALIGN_LEFT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            for(int i=3;i<col_num;i++)
            {
                c2 = new PdfPCell(new Phrase(" ",boldFont));
                c2.setHorizontalAlignment(Element.ALIGN_CENTER);
                c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                c2.setBorder(0);
                table.addCell(c2);
            }
            
            c2 = new PdfPCell(new Phrase(getCurFormat(totNetPrice) + "\n",boldFont));
            c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
            c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
            c2.setBorder(0);
            table.addCell(c2);
            
            int fromRec = 0;
            int toRec = 0;
            int endRec = Summary.length;
            
            for(int loop=0;loop<loopLength;loop++)
            { 
                //Initial Last Record
                toRec = fromRec + max_urut;
                endRec -= max_urut;
                if(endRec < 0) toRec = toRec + endRec;
                //End Initial
                
                if(urut == 0)
                {
                    urut++;
                    c2 = new PdfPCell(new Phrase("\nBUDGET\n%ACTUAL/BUDGET\nACTUAL PIECES\nMONTH ACHIEVED",normalFont));
                    c2.setHorizontalAlignment(Element.ALIGN_LEFT);
                    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c2.setBorder(0);
                    table.addCell(c2);
                    
                    urut++;
                    c2 = new PdfPCell(new Phrase(SummDateFormat,normalFont));
                    c2.setHorizontalAlignment(Element.ALIGN_LEFT);
                    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c2.setBorder(0);
                    table.addCell(c2);
                }
                
                for(int k=fromRec;k<toRec;k++)
                {
                    urut++;
                    c2 = new PdfPCell(new Phrase(Summary[k].getSmryBrand().toUpperCase() + "\n" + getCurFormat(Summary[k].getSmryTarget()) + "\n" + String.valueOf(Math.round(Summary[k].getSmryPercent()*100.0)/100.0) + "%\n" + Summary[k].getSmryQty() + "\n" + getCurFormat(Summary[k].getSmrySales()),boldFont));
                    c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
                    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c2.setBorder(0);
                    table.addCell(c2);
                }
                
                for(int k=1;k<(col_num-urut);k++)
                {
                    c2 = new PdfPCell(new Phrase(" ",normalFont));
                    c2.setHorizontalAlignment(Element.ALIGN_LEFT);
                    c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                    c2.setBorder(0);
                    table.addCell(c2);
                }
                
                if(toRec == Summary.length){
                    c2 = new PdfPCell(new Phrase("\n" + getCurFormat(totTarget) + "\n" + String.valueOf(Math.round(totPercent*100.0)/100.0) + "%\n" + totSmryQty + "\n" + getCurFormat(totSales),boldFont));
                }
                else
                {
                    c2 = new PdfPCell(new Phrase(" ",normalFont));
                }
                
                c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
                c2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                c2.setBorder(0);
                table.addCell(c2);
                    
                urut = 0;
                fromRec += max_urut;
            }
            
            document.add(new Paragraph(" "));
            
            /** END TARGET SUMMARY **/
            
            document.add(table);
            document.add(new Paragraph(" "));
        }
    }
  }
    
    private static String getCurFormat(double number)
    {
        String formatNumber = new DecimalFormat("###,###,###").format(number);

        return formatNumber;
    }
}
