/*
 * DSRReport.java
 *
 * Created on Oct 3, 2013, 1:42 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales.xclreport;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.orca.counter.sales.DSRReportManager;
import com.ecosmosis.orca.counter.sales.DSRReportBean;
import java.awt.Desktop;
import java.io.*;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRReportXCL {
    
    /** Creates a new instance of DSRReport */
    public DSRReportXCL() {
    }
    
    public void getDSRReportXCL(String filename,String outletID,int DSRCatStat,String outletName,String docDtFromStr, String docDtToStr, String path, OutputStream out) {
        String FILE = path+filename+".xls";
        DSRReportManager mgr = new DSRReportManager();
        try 
        {
          DSRReportBean[] DSRdocDate = mgr.getDSRDocDate(outletID, docDtFromStr, docDtToStr);
          DSRReportManager dsrMgr = new DSRReportManager();
          getContent(DSRdocDate,dsrMgr,FILE,out,outletID,DSRCatStat);
          //this.openFile(FILE);
        } catch (Exception e) {
          e.printStackTrace();
        }
    }
    
    private static void getContent(DSRReportBean[] DSRdocDate, DSRReportManager dsrMgr, String FILE, OutputStream out, String outletID, int DSRCatStat) 
        throws MvcException, ParseException
    {
        HSSFWorkbook workbook = new HSSFWorkbook();
        
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
                int col = 0;
                int row_hdr = 0;
                int rows = 0;
                String invoiceNo = "";
                String srlNmbr = "";
                SummDateFormat = format4.format(DSRdocDate[j].getDSRDocDate());
                
                HSSFSheet sheet = workbook.createSheet(DSRDateFormat);
                DataFormat format = workbook.createDataFormat();
                
                //sheet.createFreezePane(0,1);
        
                // Create a new font and alter it.
                Font font = workbook.createFont();
                font.setFontHeightInPoints((short)10);
                font.setFontName("Helvetica");
                font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

                Font font_b = workbook.createFont();
                font_b.setFontHeightInPoints((short)10);
                font_b.setFontName("Helvetica");
                font_b.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

                CellStyle style = workbook.createCellStyle();
                //setBorder(style);
                style.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style.setFont(font);
                style.setWrapText(false);
                
                CellStyle style_right = workbook.createCellStyle();
                style_right.setAlignment(CellStyle.ALIGN_RIGHT);
                style_right.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_right.setFont(font);
                style_right.setWrapText(true);
                
                CellStyle style_bottom = workbook.createCellStyle();
                style_bottom.setVerticalAlignment(CellStyle.VERTICAL_BOTTOM);
                style_bottom.setFont(font);
                style_bottom.setWrapText(true);

                CellStyle style_mid = workbook.createCellStyle();
                style_mid.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_mid.setFont(font);
                style_mid.setWrapText(true);
                style_mid.setDataFormat(format.getFormat("#;(#)"));
                
                CellStyle style_mid_top = workbook.createCellStyle();
                style_mid_top.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_top.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_mid_top.setFont(font);
                style_mid_top.setWrapText(true);
                
                CellStyle style_mid_bottom = workbook.createCellStyle();
                style_mid_bottom.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_bottom.setVerticalAlignment(CellStyle.VERTICAL_BOTTOM);
                style_mid_bottom.setFont(font);
                style_mid_bottom.setWrapText(true);

                CellStyle style_b_mid = workbook.createCellStyle();
                style_b_mid.setAlignment(CellStyle.ALIGN_CENTER);
                style_b_mid.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_b_mid.setFont(font_b);
                style_b_mid.setWrapText(true);

                CellStyle style_h = workbook.createCellStyle();
                style_h.setAlignment(CellStyle.ALIGN_CENTER);
                style_h.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                setBorder(style_h);
                style_h.setFont(font_b);
                style_h.setWrapText(true);

                CellStyle style_b = workbook.createCellStyle();
                style_b.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                //setBorder(style_b);
                style_b.setFont(font_b);
                style_b.setWrapText(true);
                
                CellStyle style_b_right = workbook.createCellStyle();
                style_b_right.setAlignment(CellStyle.ALIGN_RIGHT);
                style_b_right.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_b_right.setFont(font_b);
                style_b_right.setWrapText(true);
                
                CellStyle style_cur = workbook.createCellStyle();
                style_cur.setAlignment(CellStyle.ALIGN_RIGHT);
                style_cur.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_cur.setFont(font);
                style_cur.setWrapText(true);
                style_cur.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_b_cur = workbook.createCellStyle();
                style_b_cur.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_b_cur.setFont(font_b);
                style_b_cur.setWrapText(true);
                style_b_cur.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_bottom_cur = workbook.createCellStyle();
                style_bottom_cur.setVerticalAlignment(CellStyle.VERTICAL_BOTTOM);
                style_bottom_cur.setFont(font);
                style_bottom_cur.setWrapText(true);
                style_bottom_cur.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_right_cur = workbook.createCellStyle();
                style_right_cur.setAlignment(CellStyle.ALIGN_RIGHT);
                style_right_cur.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_right_cur.setFont(font);
                style_right_cur.setWrapText(true);
                style_right_cur.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_b_right_cur = workbook.createCellStyle();
                style_b_right_cur.setAlignment(CellStyle.ALIGN_RIGHT);
                style_b_right_cur.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_b_right_cur.setFont(font_b);
                style_b_right_cur.setWrapText(true);
                style_b_right_cur.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_right_kurung_cur = workbook.createCellStyle();
                style_right_kurung_cur.setAlignment(CellStyle.ALIGN_RIGHT);
                style_right_kurung_cur.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_right_kurung_cur.setFont(font);
                style_right_kurung_cur.setWrapText(true);
                style_right_kurung_cur.setDataFormat(format.getFormat("(###,###,##0);(###,###,##0)"));
                
                CellStyle style_persen = workbook.createCellStyle();
                style_persen.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_persen.setFont(font);
                style_persen.setWrapText(true);
                style_persen.setDataFormat(format.getFormat("##0.#0"));
                
                CellStyle style_mid_persen = workbook.createCellStyle();
                style_mid_persen.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_persen.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_mid_persen.setFont(font);
                style_mid_persen.setWrapText(true);
                style_mid_persen.setDataFormat(format.getFormat("##0.#0"));
                
                CellStyle style_right_persen = workbook.createCellStyle();
                style_right_persen.setAlignment(CellStyle.ALIGN_RIGHT);
                style_right_persen.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_right_persen.setFont(font);
                style_right_persen.setWrapText(true);
                style_right_persen.setDataFormat(format.getFormat("##0.#0"));
                
                CellStyle style_b_right_persen = workbook.createCellStyle();
                style_b_right_persen.setAlignment(CellStyle.ALIGN_RIGHT);
                style_b_right_persen.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_b_right_persen.setFont(font_b);
                style_b_right_persen.setWrapText(true);
                style_b_right_persen.setDataFormat(format.getFormat("##0.#0"));
                
                //Alert Style
                CellStyle style_alert = workbook.createCellStyle();
                style_alert.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_alert.setFillForegroundColor(IndexedColors.ROSE.getIndex());
                style_alert.setFillPattern(CellStyle.SOLID_FOREGROUND);
                style_alert.setFont(font);
                style_alert.setWrapText(false);
                
                CellStyle style_mid_alert = workbook.createCellStyle();
                style_mid_alert.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_alert.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_mid_alert.setFillForegroundColor(IndexedColors.ROSE.getIndex());
                style_mid_alert.setFillPattern(CellStyle.SOLID_FOREGROUND);
                style_mid_alert.setFont(font);
                style_mid_alert.setWrapText(true);
                style_mid_alert.setDataFormat(format.getFormat("#;(#)"));
                
                CellStyle style_mid_top_alert = workbook.createCellStyle();
                style_mid_top_alert.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_top_alert.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_mid_top_alert.setFillForegroundColor(IndexedColors.ROSE.getIndex());
                style_mid_top_alert.setFillPattern(CellStyle.SOLID_FOREGROUND);
                style_mid_top_alert.setFont(font);
                style_mid_top_alert.setWrapText(true);
                
                CellStyle style_cur_alert = workbook.createCellStyle();
                style_cur_alert.setAlignment(CellStyle.ALIGN_RIGHT);
                style_cur_alert.setVerticalAlignment(CellStyle.VERTICAL_TOP);
                style_cur_alert.setFillForegroundColor(IndexedColors.ROSE.getIndex());
                style_cur_alert.setFillPattern(CellStyle.SOLID_FOREGROUND);
                style_cur_alert.setFont(font);
                style_cur_alert.setWrapText(true);
                style_cur_alert.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
                
                CellStyle style_mid_persen_alert = workbook.createCellStyle();
                style_mid_persen_alert.setAlignment(CellStyle.ALIGN_CENTER);
                style_mid_persen_alert.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
                style_mid_persen_alert.setFillForegroundColor(IndexedColors.ROSE.getIndex());
                style_mid_persen_alert.setFillPattern(CellStyle.SOLID_FOREGROUND);
                style_mid_persen_alert.setFont(font);
                style_mid_persen_alert.setWrapText(true);
                style_mid_persen_alert.setDataFormat(format.getFormat("##0.#0"));
                
                CellStyle styleNormal = null;
                CellStyle styleMid = null;
                CellStyle styleMidTop = null;
                CellStyle styleCur = null;
                CellStyle styleMidPersen = null;
                //

                int[] col_w = new int[17];
                String[] hdr = new String[17];

                hdr[0] = "Sort\nRef\nCode";
                hdr[1] = "Date";
                hdr[2] = "Invoice\nNo";
                hdr[3] = "Product\nRef No";
                hdr[4] = "Description";
                hdr[5] = "Serial Number";
                hdr[6] = "QTY";
                hdr[7] = "(In S $)\n(Per Unit)\nRetail Price";
                hdr[8] = "Ttl Qty\nRtl Prc";
                hdr[9] = "Disc\nRate";
                hdr[10] = "In(Rp.)\nDisc";
                hdr[11] = "(In Rp)\nNet Sales\nTotal";
                hdr[12] = "Total\nDaily";
                hdr[13] = "Accumulation\nTotal Net Sales";
                hdr[14] = "Mode\nOf\nPayment";
                hdr[15] = "Sales Person";
                hdr[16] = "Customer";

                col_w[0] = 3000;
                col_w[1] = 3000;
                col_w[2] = 6000;
                col_w[3] = 5000;
                col_w[4] = 5000;
                col_w[5] = 5000;
                col_w[6] = 4000;
                col_w[7] = 4000;
                col_w[8] = 4000;
                col_w[9] = 4000;
                col_w[10] = 4000;
                col_w[11] = 4000;
                col_w[12] = 4000;
                col_w[13] = 4000;
                col_w[14] = 12000;
                col_w[15] = 5000;
                col_w[16] = 7000;
                
                //HEADER
                Row header = sheet.createRow(row_hdr);
                for(int i=0;i<hdr.length;i++)
                {
                    Cell cell = header.createCell(i);
                    cell.setCellValue(hdr[i]);
                    cell.setCellStyle(style_h);
                    sheet.setColumnWidth(i,col_w[i]);
                }
                //END HEADER
                
                col = 1;
                row_hdr++;
                
                header = sheet.createRow(row_hdr);
                header.setHeightInPoints(20);
                Cell cell = header.createCell(col);
                cell.setCellValue("Sales for : " + DSRDateFormat);
                cell.setCellStyle(style_b);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col = 3;
                cell = header.createCell(col);
                cell.setCellValue(dayName);
                cell.setCellStyle(style_b);
                
                col = 4;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style_b);
                
                col = 1;
                row_hdr++;
                
                header = sheet.createRow(row_hdr);
                header.setHeightInPoints(20);
                cell = header.createCell(col);
                cell.setCellValue(dateYtd);
                cell.setCellStyle(style_b);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col = 3;
                cell = header.createCell(col);
                cell.setCellValue("BALANCE B/F TIME");
                cell.setCellStyle(style_b);
                
                col = 4;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style_b);
                        
                col = 6;
                cell = header.createCell(col);
                cell.setCellValue(bf_qty);
                cell.setCellStyle(style_b_mid);
                
                col = 8;
                cell = header.createCell(col);
                cell.setCellValue(bf_idrRetailPrice);
                cell.setCellStyle(style_b_cur);
                
                col = 10;
                cell = header.createCell(col);
                cell.setCellValue(bf_discPayAmt);
                cell.setCellStyle(style_b_cur);
                
                col = 13;
                cell = header.createCell(col);
                cell.setCellValue(bf_netPrice);
                cell.setCellStyle(style_b_cur);
                
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
                    int qty2 = qty * -1;
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
                    col = 0;
                    String docNo = "";

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
                        row_hdr++;
                        
                        int rowspan = (row_hdr + getRowspan) - 1;
                        
                        if(docStat != salesStat && docStat != returnStat && docStat != voidStat)
                        {
                            totQtyRtlPrice = totQtyRtlPrice * -1;
                            discPayAmt = discPayAmt * -1;
                            netPrice = netPrice * -1;
                            qty = qty * -1;

                            //qty2 = "(" + qty2 + ")";
                        }
                        
                        if(docStat == voidStat)
                        {
                            styleNormal = style_alert;
                            styleMid = style_mid_alert;
                            styleMidTop = style_mid_top_alert;
                            styleCur = style_cur_alert;
                            styleMidPersen = style_mid_persen_alert;
                            docNo = "(VOIDED)" + invoiceNo;
                        }
                        else
                        {
                            totQty += qty;
                            sumTotQtyRtlPrice += totQtyRtlPrice;
                            totDiscPayAmt += discPayAmt; 
                            totNetPrice += netPrice;
                            
                            styleNormal = style;
                            styleMid = style_mid;
                            styleMidTop = style_mid_top;
                            styleCur = style_cur;
                            styleMidPersen = style_mid_persen;
                            docNo = invoiceNo;
                        }
                    
                        header = sheet.createRow(row_hdr);
                        cell = header.createCell(col);
                        cell.setCellValue(brandCode);
                        cell.setCellStyle(styleMidTop);

                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue(trxDateFormat);
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue(docNo);
                        cell.setCellStyle(styleMidTop);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(productCode);
                        }
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(productDesc);
                        }
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue(srlNmbr);
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            if(docStat == salesStat || docStat == returnStat || docStat == voidStat)
                            {
                                cell.setCellValue(qty);
                            }
                            else
                            {
                                cell.setCellValue(qty2);
                            }
                        }
                        cell.setCellStyle(styleMid);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr != "")
                        {
                            if(docStat == salesStat || docStat == returnStat || docStat == voidStat)
                            {
                                cell.setCellValue(sgdRetailPrice);
                            }
                            else
                            {
                                cell.setCellValue(sgdRetailPrice * -1);
                            }
                        }
                        else
                        {
                            cell.setCellValue("");
                        }
                        cell.setCellStyle(styleCur);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(totQtyRtlPrice);
                        }
                        cell.setCellStyle(styleCur);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(formatProdDisc);
                        }
                        cell.setCellStyle(styleMidPersen);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(discPayAmt);
                        }
                        cell.setCellStyle(styleCur);

                        col+=1;
                        cell = header.createCell(col);
                        if(srlNmbr == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(netPrice);
                        }
                        cell.setCellStyle(styleCur);

                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue("");
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue("");
                        cell.setCellStyle(styleNormal);

                        col+=1;
                        cell = header.createCell(col);
                        if(invoiceNo == "")
                        {
                            cell.setCellValue(""); 
                        }
                        else
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
                            
                            cell.setCellValue(payType);
                        }
                        cell.setCellStyle(styleNormal);
                        if(getRowspan > 1) sheet.addMergedRegion(new CellRangeAddress(row_hdr,rowspan,col,col));

                        col+=1;
                        cell = header.createCell(col);
                        if(invoiceNo == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(salesPerson);
                        }
                        cell.setCellStyle(styleNormal);
                        if(getRowspan > 1) sheet.addMergedRegion(new CellRangeAddress(row_hdr,rowspan,col,col));

                        col+=1;
                        cell = header.createCell(col);
                        if(invoiceNo == "")
                        {
                            cell.setCellValue("");
                        }
                        else
                        {
                            cell.setCellValue(customer);
                        }
                        cell.setCellStyle(styleNormal);
                        if(getRowspan > 1) sheet.addMergedRegion(new CellRangeAddress(row_hdr,rowspan,col,col));
                    }
                }
                //END DETAIL
                
                //col = 0;
                //row_hdr++;
                
                tot_bf_qty = bf_qty + totQty;
                tot_bf_idrRetailPrice = bf_idrRetailPrice + sumTotQtyRtlPrice;
                tot_bf_discPayAmt = bf_discPayAmt + totDiscPayAmt;
                tot_bf_netPrice = bf_netPrice + totNetPrice;

                SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
                Date tf1 = df1.parse(curRate[0].getSGDStartTime());
                SimpleDateFormat df2 = new SimpleDateFormat("hh:mm aa");
                String timeRate = df2.format(tf1);
                
                
                //row_hdr++;
                row_hdr = 29;

                header = sheet.createRow(row_hdr);
                header.setHeightInPoints(20);
                
                col = 3;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 4;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 6;
                cell = header.createCell(col);
                cell.setCellValue(totQty);
                cell.setCellStyle(style_mid_bottom);
                
                col = 8;
                cell = header.createCell(col);
                cell.setCellValue(sumTotQtyRtlPrice);
                cell.setCellStyle(style_bottom_cur);
                
                col = 10;
                cell = header.createCell(col);
                cell.setCellValue(totDiscPayAmt);
                cell.setCellStyle(style_bottom_cur);
                
                col = 12;
                cell = header.createCell(col);
                cell.setCellValue(totNetPrice);
                cell.setCellStyle(style_bottom_cur);
                
                col = 1;
                row_hdr++;
                
                header = sheet.createRow(row_hdr);
                header.setHeightInPoints(20);
                cell = header.createCell(col);
                cell.setCellValue(DSRDateFormat);
                cell.setCellStyle(style_b);
                
                col = 3;
                cell = header.createCell(col);
                cell.setCellValue("BALANCE B/F TIME");
                cell.setCellStyle(style_b);
                
                col = 4;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style_b);
                        
                col = 6;
                cell = header.createCell(col);
                cell.setCellValue(tot_bf_qty);
                cell.setCellStyle(style_b_mid);
                
                col = 8;
                cell = header.createCell(col);
                cell.setCellValue(tot_bf_idrRetailPrice);
                cell.setCellStyle(style_b_cur);
                
                col = 10;
                cell = header.createCell(col);
                cell.setCellValue(tot_bf_discPayAmt);
                cell.setCellStyle(style_b_cur);
                
                col = 13;
                cell = header.createCell(col);
                cell.setCellValue(tot_bf_netPrice);
                cell.setCellStyle(style_b_cur);
                
                col = 0;
                row_hdr++;
                
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("Exchange rate");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col+=1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col+=1;
                cell = header.createCell(col);
                cell.setCellValue(timeRate + "  SGD " + getCurFormat(curRate[0].getSGDRate()) + "        USD " + getCurFormat(curRate[0].getUSDRate()));
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 14));
                
                for(int i=0;i<14;i++)
                {
                    col+=1;
                    cell = header.createCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style);
                }
                
                
                for(Iterator it = arrRemark.keySet().iterator(); it.hasNext();)
                {
                    String key = (String)it.next();
                    
                    col = 0;
                    row_hdr++;

                    header = sheet.createRow(row_hdr);
                    cell = header.createCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style_b);
                    
                    col+=1;
                    cell = header.createCell(col);
                    cell.setCellValue(note);
                    cell.setCellStyle(style_b);
                    
                    col+=1;
                    cell = header.createCell(col);
                    cell.setCellValue(key);
                    cell.setCellStyle(style_b);

                    col+=1;
                    cell = header.createCell(col);
                    cell.setCellValue(arrRemark.get(key).toString());
                    cell.setCellStyle(style_b);
                    sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 13));
                    
                    for(int i=0;i<13;i++)
                    {
                        col+=1;
                        cell = header.createCell(col);
                        cell.setCellValue("");
                        cell.setCellStyle(style_b);
                    }
                    
                    note = "";
                }
                
                /** TARGET SUMMARY **/
                int urut = 0;
                int max_urut = 8; //Maksimal Urutan Kolom Target ke Kanan
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
                                    
                col = 0;
                row_hdr += 3;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("BUDGET");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue(SummDateFormat);
                cell.setCellStyle(style);
                
                col = 16;
                cell = header.createCell(col);
                cell.setCellValue(totTarget);
                cell.setCellStyle(style_right_cur);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("%ACTUAL/BUDGET");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 16;
                cell = header.createCell(col);
                cell.setCellValue(percentToGo);
                cell.setCellStyle(style_right_persen);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("MONTH TO GO");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 16;
                cell = header.createCell(col);
                cell.setCellValue(tgtToGo);
                cell.setCellStyle(style_right_kurung_cur);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("ACCUMULATED");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col = 16;
                cell = header.createCell(col);
                cell.setCellValue(totNetPrice);
                cell.setCellStyle(style_b_cur);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("UP TO DATE");
                cell.setCellStyle(style);
                sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                
                col += 1;
                cell = header.createCell(col);
                cell.setCellValue(DSRDateFormat);
                cell.setCellStyle(style);
                
                col = 0;
                row_hdr++;
                header = sheet.createRow(row_hdr);
                cell = header.createCell(col);
                cell.setCellValue("");
                cell.setCellStyle(style);
                 
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
                    
                    urut = 0;
                    for(int k=fromRec;k<toRec;k++)
                    {
                        urut++;

                        if(urut == 1)
                        {
                            col = 0;
                            row_hdr++;
                            header = sheet.createRow(row_hdr);
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);
                        }

                        col += 1;
                        cell = header.createCell(col);
                        cell.setCellValue(Summary[k].getSmryBrand().toUpperCase());
                        cell.setCellStyle(style_b_right);
                    }
                    
                    urut = 0;
                    for(int k=fromRec;k<toRec;k++)
                    {
                        urut++;

                        if(urut == 1)
                        {
                            col = 0;
                            row_hdr++;
                            header = sheet.createRow(row_hdr);
                            cell = header.createCell(col);
                            cell.setCellValue("BUDGET");
                            cell.setCellStyle(style);
                            sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue(SummDateFormat);
                            cell.setCellStyle(style);
                        }

                        col += 1;
                        cell = header.createCell(col);
                        cell.setCellValue(Summary[k].getSmryTarget());
                        cell.setCellStyle(style_b_right_cur);
                    }
                    
                    if(toRec == Summary.length){
                        col = 16;
                        cell = header.createCell(col);
                        cell.setCellValue(totTarget);
                        cell.setCellStyle(style_b_right_cur);
                    }

                    urut = 0;
                    for(int k=fromRec;k<toRec;k++)
                    {  
                        urut++;

                        if(urut == 1)
                        {
                            col = 0;
                            row_hdr++;
                            header = sheet.createRow(row_hdr);
                            cell = header.createCell(col);
                            cell.setCellValue("%ACTUAL/BUDGET");
                            cell.setCellStyle(style);
                            sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);
                        }

                        col += 1;
                        cell = header.createCell(col);
                        cell.setCellValue(Summary[k].getSmryPercent());
                        cell.setCellStyle(style_b_right_persen);
                    }
                    
                    if(toRec == Summary.length){
                        col = 16;
                        cell = header.createCell(col);
                        cell.setCellValue(totPercent);
                        cell.setCellStyle(style_b_right_persen);
                    }

                    urut = 0;
                    for(int k=fromRec;k<toRec;k++)
                    {
                        urut++;

                        if(urut == 1)
                        {
                            col = 0;
                            row_hdr++;
                            header = sheet.createRow(row_hdr);
                            cell = header.createCell(col);
                            cell.setCellValue("ACTUAL PIECES");
                            cell.setCellStyle(style);
                            sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);
                        }

                        col += 1;
                        cell = header.createCell(col);
                        cell.setCellValue(Summary[k].getSmryQty());
                        cell.setCellStyle(style_b_right);
                    }
                    
                    if(toRec == Summary.length){
                        col = 16;
                        cell = header.createCell(col);
                        cell.setCellValue(totSmryQty);
                        cell.setCellStyle(style_b_right);
                    }

                    urut = 0;
                    for(int k=fromRec;k<toRec;k++)
                    {
                        urut++;

                        if(urut == 1)
                        {
                            col = 0;
                            row_hdr++;
                            header = sheet.createRow(row_hdr);
                            cell = header.createCell(col);
                            cell.setCellValue("MONTH ACHIEVED");
                            cell.setCellStyle(style);
                            sheet.addMergedRegion(new CellRangeAddress(row_hdr,row_hdr,col,col + 1));

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);

                            col += 1;
                            cell = header.createCell(col);
                            cell.setCellValue("");
                            cell.setCellStyle(style);
                        }

                        col += 1;
                        cell = header.createCell(col);
                        cell.setCellValue(Summary[k].getSmrySales());
                        cell.setCellStyle(style_b_right_cur);
                    }
                    
                    if(toRec == Summary.length){
                        col = 16;
                        cell = header.createCell(col);
                        cell.setCellValue(totSales);
                        cell.setCellStyle(style_b_right_cur);
                    }
                    
                    col = 0;
                    row_hdr++;
                    header = sheet.createRow(row_hdr);
                    cell = header.createCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style);
                    
                    fromRec += max_urut;
                }
                /** END TARGET SUMMARY **/
                
                row_hdr++;
            } 
        }
        
        try {
            //FileOutputStream out = new FileOutputStream(new File(FILE));
            workbook.write(out);
            out.flush();
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    private static void setBorder(CellStyle style)
    {
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setRightBorderColor(IndexedColors.BLACK.getIndex());
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setTopBorderColor(IndexedColors.BLACK.getIndex());
        
        //return style;
    }
    
    private void openFile(String fileXCL)
    {
        if (Desktop.isDesktopSupported()) {
            try {
                File myFile = new File(fileXCL);
                Desktop.getDesktop().open(myFile);
            } catch (IOException ex) {
                // no application registered for XCLs
            }
        }
    }
    
    private static String getCurFormat(double number)
    {
        String formatNumber = new DecimalFormat("###,###,###").format(number);
        
        return formatNumber;
    }
}
