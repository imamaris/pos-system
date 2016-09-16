/*
 * DSRReport.java
 *
 * Created on Mar 25, 2015, 1:42 PM
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
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSR {
    
    /** Creates a new instance of DSRReport */
    public DSR() {
    }
    
    public void getDSRReportXCL(String filename,String outletID,int DSRCatStat,String outletName,String docDtFromStr, String docDtToStr, String path, OutputStream out) {
        DSRReportManager mgr = new DSRReportManager();
        try 
        {
            path = getTemplatePath(DSRCatStat);
            String FILE = path+"DSR.xls";
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
            
            if(DSRdocDate.length > 0)
            {
                SimpleDateFormat formatDay = new SimpleDateFormat("d");
                Date trxDate;

                int salesStat = 30;
                int voidStat = 50;
                int returnStat = 60;
                int col = 0;
                int row = 0;
                
                DSRReportBean[] Summary = dsrMgr.getSummary(outletID,DSRCatStat,docDtFromStr,docDtToStr);
                
                Sheet refferences = workbook.getSheetAt(0);
                Cell cell = null;
                
                row = 3;
                col = 5;
                
                for(int j=row;j<55;j++)
                {
                    cell = refferences.getRow(j).getCell(2);
                    
                    for(int i=0;i<Summary.length;i++)
                    {   
                        String brand = Summary[i].getSmryBrand();
                        String brandCode = brand.trim();
                        double targetAmt = Summary[i].getSmryTarget();
                        int targetQty = Summary[i].getSmryTgtQty();

                        if(cell.getCellType() == Cell.CELL_TYPE_STRING && cell.getStringCellValue().equalsIgnoreCase(brandCode)){
                            cell = refferences.getRow(row).getCell(4);
                            cell.setCellValue(targetAmt);
                            refferences.getRow(row).createCell(5).setCellValue(targetQty); //Updated By Mila-2016-03-04
                            
                            break;
                            
                        }
                    }
                    
                    row++;
                }
                
                for(int j = 0;j < DSRdocDate.length;j++)
                {
                    String docDate = DSRdocDate[j].getDSRDocDate().toString();
                    DSRReportManager rptMgr = new DSRReportManager();
                    DSRReportBean[] rptBean = rptMgr.getDSRReport(outletID,DSRCatStat,docDate,docDate);
                    DSRReportBean[] curRate = rptMgr.getCurRate(docDate);
                    Date DSRDate = DSRdocDate[j].getDSRDocDate();
                    Date dateYtd = rptBean[0].getDocDate();
                    String day = formatDay.format(DSRdocDate[j].getDSRDocDate());
                    Map arrPayType = new HashMap();
                    String invoiceNo = "";
                    String srlNmbr = "";
                    String payment = "";
                    col = 0;
                    row = 0;
                    
                    int sheet = Integer.parseInt(day);
                        
                    Sheet worksheet = workbook.getSheetAt(sheet);

                    workbook.setActiveSheet(sheet);
                    worksheet.showInPane((short)0, (short)0);
                    
                    String title = "Daily Sales - " + dsrMgr.getOutletInitial()[0].getOutletInitialName().toUpperCase();
                    
                    cell = null;
                    cell = worksheet.getRow(3).getCell(1);
                    cell.setCellValue(title);

                    cell = null;
                    cell = worksheet.getRow(8).getCell(2);
                    cell.setCellValue(DSRDate);
                    
                    if(sheet > 1)
                    {
                        cell = worksheet.getRow(9).getCell(1);
                        cell.setCellValue(dateYtd);
                    }
                    
                    row = 11;
                    
                    for(int i=1;i < rptBean.length;i++)
                    {
                        payment = "";

                        if(rptBean[i].getPayAmt() > 0) payment =  " - " + rptBean[i].getPayCurr() + " " + dsrMgr.getCurFormat(rptBean[i].getPayAmt()) + " ; ";
                        if(rptBean[i].getPayMode().length() > 0) arrPayType.put(rptBean[i].getTrxDocno() + "-" + rptBean[i].getPayMode(),rptBean[i].getPayMode() + payment);
                    }
                    
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
                        double unitPrice = rptBean[i].getRetailPrice();
                        double idrRetailPrice = rptBean[i].getIDRRetailPrice();
                        double totQtyRtlPrice = idrRetailPrice * qty;
                        float prodDisc = (float) (discPayAmt/(netPrice + discPayAmt))*100;
                        double formatProdDisc = Math.round(prodDisc*100.0)/100.0;
                        int docStat = rptBean[i].getDocStat();
                        
                        col = 0;
                        
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

                            cell = worksheet.getRow(row).getCell(col);
                            cell.setCellType(Cell.CELL_TYPE_FORMULA);
                            cell.setCellFormula("VLOOKUP(\""+brandCode+"\",Refferences!$C$4:$D$55,2,FALSE)");
                            //cell.setCellValue(brandCode);

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            cell.setCellValue(trxDate);

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            cell.setCellValue(rptBean[i].getTrxDocno());

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "")
                            {
                                cell.setCellValue("");
                            }
                            else if (docStat == voidStat)
                            {
                                cell.setCellValue("(VOIDED)");
                            }
                            else
                            {
                                cell.setCellValue(productCode);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(4);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(productDesc);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(srlNmbr);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(qty);
                            }
                            
                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(unitPrice);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(totQtyRtlPrice);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                if(netPrice == 0d && discPayAmt == 0f) prodDisc = 0f;
                                
                                cell.setCellValue(prodDisc * 0.01);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(discPayAmt);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(srlNmbr == "" || docStat == voidStat)
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(netPrice);
                            }
                            
                            col++;
                            col++;
                            
                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(invoiceNo == "" || docStat == voidStat)
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
                                        payType += arrPayType.get(key).toString();
                                    }
                                }

                                cell.setCellValue(payType);
                            }
                            
                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(invoiceNo == "")
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(salesPerson);
                            }

                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(invoiceNo == "")
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(customer);
                            }
                            
                            col++;
                            cell = worksheet.getRow(row).getCell(col);
                            if(invoiceNo == "")
                            {
                                cell.setCellValue("");
                            }
                            else
                            {
                                cell.setCellValue(remark);
                            }
                            
                            row++;
                        }
                    }
                    row = 97;
                    //row = 57;
                    col = 2;
                    
                    String CurDate = curRate[0].getSGDStartDate() + " " + curRate[0].getSGDStartTime(); 
                    Date dateTime = new SimpleDateFormat("yyyy-mm-dd", Locale.ENGLISH).parse(CurDate);
                    
                    cell = worksheet.getRow(row).getCell(col);
                    cell.setCellValue(dateTime);
                    
                    col++;
                    cell = worksheet.getRow(row).getCell(col);
                    cell.setCellValue("SGD " + dsrMgr.getCurFormat(curRate[0].getSGDRate()));
                    
                    col++;
                    cell = worksheet.getRow(row).getCell(col);
                    cell.setCellValue("USD " + dsrMgr.getCurFormat(curRate[0].getUSDRate()));
                }
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
