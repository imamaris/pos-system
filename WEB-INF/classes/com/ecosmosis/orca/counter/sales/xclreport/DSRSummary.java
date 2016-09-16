/*
 * DSRReport.java
 *
 * Created on Mar 24, 2015, 11:45 AM
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
public class DSRSummary {
    
    /** Creates a new instance of DSRReport */
    public DSRSummary() {
    }
    
    public void getDSRSummaryXCL(String filename,String outletID,int DSRCatStat,String outletName,String docDtFromStr, String docDtToStr, String path, OutputStream out) {
        DSRReportManager mgr = new DSRReportManager();
        try 
        {
            path = getTemplatePath(DSRCatStat);
            String FILE = path+"DSRSummary.xls";
            DSRReportBean[] DSRdocDate = mgr.getDSRDocDate(outletID, docDtFromStr, docDtToStr);
            DSRReportManager dsrMgr = new DSRReportManager();
            getContent(DSRdocDate,dsrMgr,FILE,out,outletID,docDtFromStr,docDtToStr,DSRCatStat);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void getContent(DSRReportBean[] DSRdocDate, DSRReportManager dsrMgr, String FILE, OutputStream out, String outletID, String docDtFromStr, String docDtToStr, int DSRCatStat) 
        throws MvcException, ParseException
    {
        try {
            FileInputStream input_document = new FileInputStream(new File(FILE));
            
            HSSFWorkbook workbook = new HSSFWorkbook(input_document);
            workbook.setForceFormulaRecalculation(true);
            
            DataFormat format = workbook.createDataFormat();
            
            Font font_b = workbook.createFont();
            font_b.setFontHeightInPoints((short)10);
            font_b.setFontName("Verdana");
            font_b.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            
            CellStyle style_b = workbook.createCellStyle();
            style_b.setFont(font_b);
            style_b.setDataFormat(format.getFormat("###,###,##0;(###,###,##0)"));
            style_b.setFillForegroundColor(IndexedColors.CORNFLOWER_BLUE.getIndex());
            style_b.setFillPattern(CellStyle.SOLID_FOREGROUND);
            style_b.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style_b.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            
            CellStyle style_b_mid = workbook.createCellStyle();
            style_b_mid.setAlignment(CellStyle.ALIGN_CENTER);
            style_b_mid.setFont(font_b);
            style_b_mid.setFillForegroundColor(IndexedColors.CORNFLOWER_BLUE.getIndex());
            style_b_mid.setFillPattern(CellStyle.SOLID_FOREGROUND);
            style_b_mid.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style_b_mid.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            
            CellStyle style_b_percent = workbook.createCellStyle();
            style_b_percent.setFont(font_b);
            style_b_percent.setDataFormat(format.getFormat("##0.00%"));
            style_b_percent.setFillForegroundColor(IndexedColors.CORNFLOWER_BLUE.getIndex());
            style_b_percent.setFillPattern(CellStyle.SOLID_FOREGROUND);
            style_b_percent.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style_b_percent.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            
            if(DSRdocDate.length > 0)
            {
                Date DSRDate = null;
                ArrayList arrSummary = new ArrayList();
                Map arrPayType = new HashMap();
                String dtBrandCode = "";
                int dtQty = 0;
                double dtRetailPrice = 0d;
                double dtDisc = 0d;
                double dtNetPrice = 0d;
                
                int salesStat = 30;
                int voidStat = 50;
                int returnStat = 60;
                
                int col = 0;
                int row = 0;
                int refMaxRow = 0;
                int rowSum = 0;
                int colSum = 0;
                
                DSRReportBean[] Summary = dsrMgr.getSummary(outletID,DSRCatStat,docDtFromStr,docDtToStr);
                
                Sheet refferences = workbook.getSheetAt(0);
                Sheet salesSummary = workbook.getSheetAt(1);
                Sheet DSRSummary = workbook.getSheetAt(2);
                Cell cell = null;
                
                //Sales Summary 
                for(int j = 0;j < DSRdocDate.length;j++)
                {
                    String docDate = DSRdocDate[j].getDSRDocDate().toString();
                    DSRReportManager rptMgr = new DSRReportManager();
                    DSRReportBean[] rptBean = rptMgr.getDSRReport(outletID,DSRCatStat,docDate,docDate);
                    DSRReportBean[] curRate = rptMgr.getCurRate(docDate);
                    DSRDate = DSRdocDate[j].getDSRDocDate();
                    Date dateYtd = rptBean[0].getDocDate();
                    String invoiceNo = "";
                    String srlNmbr = "";
                    String payment = "";

                    for(int i=1;i < rptBean.length;i++)
                    {
                        payment = "";
                        if(rptBean[i].getDocStat() != voidStat)
                        {
                            if(rptBean[i].getPayAmt() > 0) payment =  " - " + rptBean[i].getPayCurr() + " " + dsrMgr.getCurFormat(rptBean[i].getPayAmt()) + " ; ";
                            if(rptBean[i].getPayMode().length() > 0) arrPayType.put(rptBean[i].getTrxDocno() + "-" + rptBean[i].getPayMode(),rptBean[i].getPayMode() + payment);
                        }
                    }

                    for(int i=1;i < rptBean.length;i++)
                    {
                        Date trxDate = rptBean[i].getTrxDate();
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
                        
                        if((i != 0) && (rptBean[i].getTrxDocno().equals(rptBean[i-1].getTrxDocno()))) invoiceNo = ""; //Show InvoiceNo
                        if((i != 0) && (rptBean[i].getSerialNumber().equals(rptBean[i-1].getSerialNumber())) && (rptBean[i].getItemCode().equals(rptBean[i-1].getItemCode())) && (invoiceNo == "")) srlNmbr = ""; //Show ProductCode

                        if(srlNmbr != "") 
                        {
                            if(docStat != salesStat && docStat != returnStat && docStat != voidStat)
                            {
                                totQtyRtlPrice = totQtyRtlPrice * -1;
                                discPayAmt = discPayAmt * -1;
                                netPrice = netPrice * -1;
                                qty = qty * -1;
                            }
                            
                            if(docStat == voidStat)
                            {
                                arrSummary.add(brandCode + "|" + 0 + "|" + 0 + "|" + 0d + "|" + 0d + "|" + 0d + "|" + trxDate + "|" + rptBean[i].getTrxDocno() + "|(VOIDED)|||");
                            }
                            else
                            {
                                if(netPrice == 0d && discPayAmt == 0f) prodDisc = 0f;

                                double discPercent = prodDisc * 0.01;
                                
                                arrSummary.add(brandCode + "|" + qty + "|" + totQtyRtlPrice + "|" + discPayAmt + "|" + netPrice + "|" + discPercent + "|" + trxDate + "|" + rptBean[i].getTrxDocno() + "|" + productCode + "|" + productDesc + "|" + srlNmbr + "|");
                            }

                        }
                    }
                }
                
                //Refferences
                row = 3;
                refMaxRow = 55;
                rowSum = 3;
                colSum = 0;
                
                for(int h=row;h<refMaxRow;h++)
                {
                    cell = refferences.getRow(h).getCell(2);
                    
                    for(int i=0;i<Summary.length;i++)
                    {   
                        String brand = Summary[i].getSmryBrand();
                        String brandCode = brand.trim();
                        String brandCodePrev = "";
                        double targetAmt = Summary[i].getSmryTarget();
                        int totQty = 0;
                        int totShow = 0;
                        double totRetailPrice = 0d;
                        double totDisc = 0d;
                        double totNetPrice = 0d;
                        col = 4;
                        
                        if(cell.getCellType() == Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(brandCode)){
                            
                            for(int n=0;n<arrSummary.size();n++)
                            {
                                String[] dt = arrSummary.get(n).toString().split("\\|",-1);
                                
                                dtBrandCode = dt[0];
                                dtQty = Integer.parseInt(dt[1]);
                                dtRetailPrice = Double.parseDouble(dt[2]);
                                dtDisc = Double.parseDouble(dt[3]);
                                dtNetPrice = Double.parseDouble(dt[4]);
                                
                                if(dtBrandCode.equalsIgnoreCase(brandCode))
                                {
                                    totQty += dtQty;
                                    totRetailPrice += dtRetailPrice;
                                    totDisc += dtDisc;
                                    totNetPrice += dtNetPrice;
                                    totShow++;
                                    
                                    //DSR Summary
                                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                    double dtDiscPercent = Double.parseDouble(dt[5]);
                                    Date dtTrxDate = formatter.parse(dt[6]);
                                    String dtInvoiceNo = dt[7];
                                    String dtProductCode = dt[8];
                                    String dtProductDesc = dt[9];
                                    String dtSrlNmbr = dt[10];
                                    String payType = "";

                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellType(Cell.CELL_TYPE_FORMULA);
                                    cell.setCellFormula("VLOOKUP(\""+dtBrandCode+"\",Refferences!$C$4:$D$55,2,FALSE)");
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtTrxDate);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtInvoiceNo);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtProductCode);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtProductDesc);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtSrlNmbr);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtQty);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtRetailPrice);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtDiscPercent);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtDisc);
                                    
                                    colSum++;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    cell.setCellValue(dtNetPrice);

                                    colSum += 3;
                                    cell = null;
                                    cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                    
                                    for(Iterator it = arrPayType.keySet().iterator(); it.hasNext();)
                                    {
                                        String key = (String)it.next();

                                        if(key.indexOf(dtInvoiceNo) >= 0)
                                        {
                                            payType += arrPayType.get(key).toString();
                                        }
                                    }
                                    
                                    cell.setCellValue(payType);
                                    
                                    colSum = 0;
                                    rowSum++;
                                    //
                                }
                            }
                            
                            //Total DSR Summary
                            if(totShow > 0)
                            {
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("TOTAL");
                                cell.setCellStyle(style_b_mid);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);
                                
                                //Total Qty
                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue(totQty);
                                cell.setCellStyle(style_b_mid);
                                
                                //Total Retail Price
                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue(totRetailPrice);
                                cell.setCellStyle(style_b);

                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                int rowIndex = cell.getRowIndex() + 1;
                                cell.setCellType(Cell.CELL_TYPE_FORMULA);
                                cell.setCellFormula("IF(ISERROR(J" + rowIndex + "/H" + rowIndex + "),\"\",J" + rowIndex + "/H" + rowIndex +")");
                                cell.setCellStyle(style_b_percent);
                                
                                //Total Discount
                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue(totDisc);
                                cell.setCellStyle(style_b);
                                
                                //Total Net Price
                                colSum++;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue(totNetPrice);
                                cell.setCellStyle(style_b);
                                
                                colSum += 3;
                                cell = null;
                                cell = DSRSummary.getRow(rowSum).getCell(colSum);
                                cell.setCellValue("");
                                cell.setCellStyle(style_b);

                                colSum = 0;
                                rowSum++;
                            }
                            //
                            
                            //Target Amount
                            cell = null;
                            cell = refferences.getRow(row).getCell(col);
                            cell.setCellValue(targetAmt);
                            
                            //Qty
                            col++;
                            cell = null;
                            cell = refferences.getRow(row).getCell(col);
                            cell.setCellValue(totQty);
                            
                            //Retail Price
                            col++;
                            cell = null;
                            cell = refferences.getRow(row).getCell(col);
                            cell.setCellValue(totRetailPrice);
                            
                            //Discount
                            col++;
                            cell = null;
                            cell = refferences.getRow(row).getCell(col);
                            cell.setCellValue(totDisc);
                            
                            //Net Price
                            col++;
                            cell = null;
                            cell = refferences.getRow(row).getCell(col);
                            cell.setCellValue(totNetPrice);
                            
                            break;
                        }
                    }
                    
                    row++;
                }
                
                SimpleDateFormat formatYear = new SimpleDateFormat("yyyy");
                String year = formatYear.format(DSRDate);
                String title = outletID + " SALES SUMMARY " + year;

                cell = null;
                cell = salesSummary.getRow(0).getCell(0);
                cell.setCellValue(title);
                
                cell = null;
                cell = DSRSummary.getRow(0).getCell(0);
                cell.setCellValue(title);
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
    
    public String getTemplatePath(int DSRCatStat)
        throws UnsupportedEncodingException 
    {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/WEB-INF/classes/");
        fullPath = pathArr[0];

        String reponsePath = "";

        reponsePath = new File(fullPath).getPath() + File.separatorChar + "template" + File.separatorChar + "DSR" + File.separatorChar + DSRCatStat + File.separatorChar;

        return reponsePath;
    }
}
