/*
 * DSRReport.java
 *
 * Created on Mar 9, 2015, 04:34 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales.xclreport;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.orca.counter.sales.DSRReportManager;
import com.ecosmosis.orca.counter.sales.DSRReportBean;
import java.io.*;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRCollection {
    
    /** Creates a new instance of DSRReport */
    public DSRCollection() {
    }
    
    public void getDSRCollectionXCL(String filename,String outletID,int DSRCatStat,String outletName,String docDtFromStr, String docDtToStr, ArrayList arrPayment, String path, OutputStream out) {
        DSRReportManager mgr = new DSRReportManager();
        try 
        {
            path = getTemplatePath();
            String FILE = path+"DSRCollection.xls";
            DSRReportBean[] DSRdocDate = mgr.getDSRDocDate(outletID, docDtFromStr, docDtToStr);
            DSRReportManager dsrMgr = new DSRReportManager();
            getContent(DSRdocDate,dsrMgr,FILE,out,outletID,docDtFromStr,docDtToStr,arrPayment,DSRCatStat);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void getContent(DSRReportBean[] DSRdocDate, DSRReportManager dsrMgr, String FILE, OutputStream out, String outletID, String docDtFromStr, String docDtToStr, ArrayList arrPayment, int DSRCatStat) 
        throws MvcException, ParseException
    {
        try {
            FileInputStream input_document = new FileInputStream(new File(FILE));
            
            HSSFWorkbook workbook = new HSSFWorkbook(input_document);
            workbook.setForceFormulaRecalculation(true);
            workbook.setSheetName(0, "Sales - " + outletID);
            
            DataFormat format = workbook.createDataFormat();
            
            Font font_b = workbook.createFont();
            font_b.setFontHeightInPoints((short)10);
            font_b.setFontName("Verdana");
            font_b.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            
            Font font_title = workbook.createFont();
            font_title.setFontHeightInPoints((short)16);
            font_title.setFontName("Arial");
            font_title.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            
            CellStyle style_title = workbook.createCellStyle();
            style_title.setFont(font_title);
            
            CellStyle style_b = workbook.createCellStyle();
            style_b.setFont(font_b);
            style_b.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
            style_b.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style_b.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style_b.setBorderBottom(HSSFCellStyle.BORDER_THICK);
            
            Sheet sales = workbook.getSheetAt(0);
            Cell cell = null;
            int row = 0;
            int col = 0;

            cell = sales.getRow(row).getCell(col);
            cell.setCellValue(outletID + " " + docDtFromStr + " s/d " + docDtToStr);
            cell.setCellStyle(style_title);
                
            if(DSRdocDate.length > 0)
            {
                Date trxDate;
                Map arrSummary = new HashMap();
                Map arrPayType = new HashMap();
                Map arrPayAmt = new HashMap();
                Map arrInvoice = new HashMap();
                Map arrMonth = new HashMap();
                
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat formatBln = new SimpleDateFormat("MM");

                int salesStat = 30;
                int voidStat = 50;
                int returnStat = 60;
                
                row = 8;
                int firstRow = row + 1;
                
                for(int j = 0;j < DSRdocDate.length;j++)
                {
                    String docDate = DSRdocDate[j].getDSRDocDate().toString();
                    DSRReportManager rptMgr = new DSRReportManager();
                    DSRReportBean[] rptBean = rptMgr.getDSRReport(outletID,DSRCatStat,docDate,docDate);
                    String invoiceNo = "";
                    String srlNmbr = "";
                    String month = formatBln.format(DSRdocDate[j].getDSRDocDate());
                    
                    arrMonth.put(month,month);
                    
                    for(int i=1;i < rptBean.length;i++)
                    {
                        trxDate = rptBean[i].getTrxDate();
                        invoiceNo = rptBean[i].getTrxDocno();
                        String brandCode = rptBean[i].getBrandCode();
                        String productCode = rptBean[i].getItemCode();
                        String productDesc = rptBean[i].getItemDesc();
                        srlNmbr = rptBean[i].getSerialNumber();
                        int qty = rptBean[i].getQtyOrder();
                        float discount = rptBean[i].getDiscount();
                        double discPayAmt = rptBean[i].getDiscPayAmt();
                        double netPrice = rptBean[i].getNetPrice();
                        double rate = rptBean[i].getRate();
                        String salesPerson = rptBean[i].getSalesName();
                        String customer = rptBean[i].getCustName();
                        String remark = rptBean[i].getRemark();
                        double idrRetailPrice = rptBean[i].getIDRRetailPrice();
                        double totQtyRtlPrice = idrRetailPrice * qty;
                        float prodDisc = (float) (discPayAmt/(netPrice + discPayAmt))*100;
                        double formatProdDisc = Math.round(prodDisc*100.0)/100.0;
                        int docStat = rptBean[i].getDocStat();
                        String itemSeq = rptBean[i].getItemSeq();
                        String paySeq = rptBean[i].getPaySeq();
                        String payMode = rptBean[i].getPayMode();
                        String payCurr = rptBean[i].getPayCurr();
                        String payAmt = String.valueOf(rptBean[i].getPayAmt()); 
                        String payRate = String.valueOf(rptBean[i].getPayRate());
                        String payIDarr = "";
                        
                        if(docStat != voidStat) //Not Showing Void Status
                        {
                            //Transaction Value Array
                            if(docStat != salesStat && docStat != returnStat)
                            {
                                totQtyRtlPrice = totQtyRtlPrice * -1;
                                discPayAmt = discPayAmt * -1;
                                netPrice = netPrice * -1;
                                qty = qty * -1;
                            }

                            double discPercent = prodDisc * 0.01;

                            arrInvoice.put(docDate + "-" + invoiceNo,invoiceNo + "|" + docDate + "|" + remark + "|" + salesPerson + "|");
                            arrSummary.put(invoiceNo + "-" + itemSeq,invoiceNo + "|" + itemSeq + "|" + netPrice + "|");

                            //Payment Type Array
                            if(rptBean[i].getDocType().trim().equalsIgnoreCase("SR"))
                            {
                                DSRReportBean[] payBean = rptMgr.getPaymentByDocNo(rptBean[i].getTrxRefNo());

                                for(int k=0;k<payBean.length;k++)
                                {
                                    paySeq = payBean[k].getPaySeq();
                                    payMode = payBean[k].getPayMode();
                                    payCurr = payBean[k].getPayCurr();
                                    payAmt = String.valueOf(payBean[k].getPayAmt() * -1);
                                    payRate = String.valueOf(payBean[k].getPayRate());

                                    payIDarr = invoiceNo + "-" + paySeq + "-" + payMode + " - " + payCurr;
                                    arrPayType.put(payIDarr,payMode + " - " + payCurr);
                                    arrPayAmt.put(payIDarr,payAmt + ";" + payRate);
                                }
                            }
                            else
                            {
                                payIDarr = invoiceNo + "-" + paySeq + "-" + payMode + " - " + payCurr;
                                arrPayType.put(payIDarr,payMode + " - " + payCurr);
                                arrPayAmt.put(payIDarr,payAmt + ";" + payRate);
                            }
                        }
                    }
                }
                
                Map arrInvSort = new TreeMap(arrInvoice); //Sort Array
                
                //Show DSR Collection
                for(Iterator itMonth = arrMonth.keySet().iterator(); itMonth.hasNext();)
                {   
                    String keyMonth = (String)itMonth.next();
                    String cellInitial = "";
                    
                    for(Iterator it1 = arrInvSort.keySet().iterator(); it1.hasNext();)
                    {
                        String key1 = (String)it1.next();
                        String[] dt1 = arrInvoice.get(key1).toString().split("\\|",-1);
                        Date dtDocDate = formatter.parse(dt1[1].toString());
                        String dtDocMonth = formatBln.format(dtDocDate);
                        
                        if(keyMonth.equalsIgnoreCase(dtDocMonth))
                        {
                            String invoiceNo = dt1[0].toString();
                            String dtRemark = dt1[2].toString();
                            String dtSalesPerson = dt1[3].toString();
                            double dtTotNetPrice = 0d;
                            double dtTotPayAmt = 0d;
                            double dtNetPrice = 0d;
                            String itemSeq = "";
                            Map arrPaymentType = new HashMap();
                            
                            //Nett Price
                            for(Iterator itSumm = arrSummary.keySet().iterator(); itSumm.hasNext();)
                            {
                                String keySumm = (String)itSumm.next();
                                String[] dt = arrSummary.get(keySumm).toString().split("\\|",-1);

                                String dtInvoiceNo = dt[0];
                                
                                if(invoiceNo.equalsIgnoreCase(dtInvoiceNo))
                                {
                                    dtNetPrice = Double.parseDouble(dt[2]);
                                    
                                    dtTotNetPrice += dtNetPrice;
                                }
                            }
                            //End Net Price

                            col = 0;

                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(dtDocDate);

                            col++;
                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(invoiceNo);

                            col++;
                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(dtTotNetPrice);

                            //Payment Type
                            for(Iterator it = arrPayType.keySet().iterator(); it.hasNext();)
                            {
                                String key = (String)it.next();

                                if(key.indexOf(invoiceNo) >= 0)
                                {
                                    arrPaymentType.put(key, arrPayType.get(key).toString());
                                }
                            }
                            //
                            
                            //Payment Amount
                            for(int i=0;i<arrPayment.size();i++)
                            {
                                String payHeader = (String) arrPayment.get(i);
                                String[] dtPay = payHeader.split(";",-1);
                                double dtPayAmt = 0d;
                                double payAmt = 0d;
                                double payRate = 0d;
                                
                                for(int j=0;j<dtPay.length;j++)
                                {
                                    String dtPayType = dtPay[j].replace(" TO IDR","");
                                    
                                    for(Iterator itPayType = arrPaymentType.keySet().iterator(); itPayType.hasNext();)
                                    {
                                        String keyPayType = (String)itPayType.next();
                                        String paymentType = arrPaymentType.get(keyPayType).toString();
                                        
                                        if(dtPayType.equalsIgnoreCase(paymentType))
                                        {
                                            String[] pA = arrPayAmt.get(keyPayType).toString().split(";",-1);
                                            payAmt = Double.parseDouble(pA[0]);
                                            payRate = Double.parseDouble(pA[1]);
                                            
                                            dtPayAmt += payAmt;
                                        }
                                    }
                                }
                                
                                //Conversi Rate
                                if(payHeader.indexOf("TO IDR") >= 0) dtPayAmt *= payRate;
                                if(payHeader.indexOf("IDR") >= 0) dtTotPayAmt += dtPayAmt;
                                
                                col++;
                                cell = null;
                                cell = sales.getRow(row).getCell(col);
                                cell.setCellValue(dtPayAmt);
                            }
                            //End Payment Amount

                            col++;
                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(dtTotPayAmt);

                            col++;
                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(dtRemark);

                            col++;
                            cell = null;
                            cell = sales.getRow(row).getCell(col);
                            cell.setCellValue(dtSalesPerson);
                            
                            row++;
                        }
                    }
                    
                    //TOTAL
                    col=0;                
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style_b);
                    
                    col++;
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style_b);
                            
                    col++;
                    cellInitial = CellReference.convertNumToColString(col);
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellType(Cell.CELL_TYPE_FORMULA);
                    cell.setCellFormula("SUM(" + cellInitial + firstRow + ":" + cellInitial + row + ")");
                    cell.setCellStyle(style_b);
                    
                    for(int i=0;i<arrPayment.size();i++)
                    {
                        col++;
                        cellInitial = CellReference.convertNumToColString(col);
                        cell = null;
                        cell = sales.getRow(row).getCell(col);
                        cell.setCellType(Cell.CELL_TYPE_FORMULA);
                        cell.setCellFormula("SUM(" + cellInitial + firstRow + ":" + cellInitial + row + ")");
                        cell.setCellStyle(style_b);
                    }
                    
                    col++;
                    cellInitial = CellReference.convertNumToColString(col);
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellType(Cell.CELL_TYPE_FORMULA);
                    cell.setCellFormula("SUM(" + cellInitial + firstRow + ":" + cellInitial + row + ")");
                    cell.setCellStyle(style_b);

                    col++;
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style_b);

                    col++;
                    cell = null;
                    cell = sales.getRow(row).getCell(col);
                    cell.setCellValue("");
                    cell.setCellStyle(style_b);

                    row++;
                    firstRow = row + 1;
                    //END TOTAL
                }
                //
            }
            
            input_document.close();
            
            workbook.write(out);

            out.flush();
            out.close();
            
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public String getTemplatePath()
        throws UnsupportedEncodingException 
    {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/WEB-INF/classes/");
        fullPath = pathArr[0];

        String reponsePath = "";

        reponsePath = new File(fullPath).getPath() + File.separatorChar + "template" + File.separatorChar + "DSR" + File.separatorChar;

        return reponsePath;
    }
}
