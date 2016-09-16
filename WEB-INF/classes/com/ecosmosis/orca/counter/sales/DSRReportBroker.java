/*
 * DSRReportBroker.java
 *
 * Created on September 24, 2013, 10:06 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.orca.inventory.InventoryBean;
import com.ecosmosis.orca.inventory.InventoryManager_1;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.util.log.Log;
import java.sql.*;
// add cos reference to Date Ambigous ....
import java.util.Date;
import java.util.*;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRReportBroker extends DBTransactionBroker {
    
    /** Creates a new instance of DSRReportBroker */
    public DSRReportBroker(Connection con) {
        super(con);
    }
    
    protected Date getLastDocDate()
        throws MvcException, SQLException
    {
        Date lastDocDate;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        lastDocDate = null;
        stmt = null;
        rs = null;
        
        SQL = "select max(cso_bonusdate) as last_docdate from counter_sales_order ";
        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            
            rs = stmt.executeQuery();
            if(rs.next())
                lastDocDate = rs.getDate("last_docdate");
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getLastDocDate --> ")).append(e.toString()).toString());
        }
        finally
        {
            if(stmt != null)
                stmt.close();
            if(rs != null)
                rs.close();
            
            return lastDocDate;
        }
    }
    
    protected ArrayList getDSRTrxDate(String outletID, String trxDtFromStr, String trxDtToStr)
        throws Exception
    {
        DSRReportBean trxDate;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " + 
                     "cso_trxdate " + 
               "from " + 
                     "counter_sales_item " + 
               "inner join " + 
                     "counter_sales_order on csi_salesid = cso_salesid " + 
               "inner join " + 
                     "product_master on csi_skucode = pmp_skucode " + 
               "where " + 
                     "cso_trxdate between ? and ? and " + 
                     "pmp_selling = ? " + 
               "group by " + 
                     "cso_trxdate " + 
               "order by " + 
                     "cso_trxdate "; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, trxDtFromStr);
            stmt.setString(2, trxDtToStr);
            stmt.setString(3, "Y");
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(trxDate))
            {
                count++;
                trxDate = new DSRReportBean();
                trxDate.parseTrxDateBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRTrxDate --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getDSRDocDate(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean docDate;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " + 
                     "cso_bonusdate " + 
               "from " + 
                     "counter_sales_item " + 
               "inner join " + 
                     "counter_sales_order on csi_salesid = cso_salesid " + 
               "inner join " + 
                     "product_master on csi_skucode = pmp_skucode " + 
               "where " + 
                     "cso_bonusdate between ? and ? and " + 
                     "pmp_selling = ? " + 
               "group by " + 
                     "cso_bonusdate " + 
               "order by " + 
                     "cso_bonusdate "; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, docDtToStr);
            stmt.setString(3, "Y");
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(docDate))
            {
                count++;
                docDate = new DSRReportBean();
                docDate.parseDocDateBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRDocDate --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getDSRReport(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select " + 
                    "pcd_name as brand_code, " +
                    "cso_salesid, " +
                    "csi_seq, " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "cso_trxdate, " +
                    "cso_bonusdate, " +
                    "cso_trxdocno, " +
                    "if(isnull(cso_adj_refno),'',cso_adj_refno) as refno, " +
                    "cso_trxdoctype, " +
                    "csi_productcode, " +
                    "csi_skuname, " +
                    "if(trim(csi_productcode) = trim(csi_skucode),?,csi_skucode) as serial_number, " +
                    "csi_qty_order, " +
                    "csi_unit_price, " +
                    "(csi_unit_price * csi_bv1) as idr_unit_price, " +
                    "csi_unit_netprice, " +
                    "round((cso_total_bv3/(cso_netsales_amt + cso_total_bv3))*100,2) as discount, " +
                    "csi_unit_discount, " +
                    "csi_bv1, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',csm_paymodedesc),?,if(isnull(csm_paymodeedc),'',csm_paymodeedc),?,if(isnull(csm_paymodetime),'',csm_paymodetime)) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr, " +
                    "cso_bonus_earnername, " +
                    "cso_cust_name, " +
                    "cso_status, " +
                    "CONCAT(if(ISNULL(cso_adj_remark),?,CONCAT(cso_adj_remark,?)),cso_remark) as remark " +
            "from " +
                    "counter_sales_item " +
            "inner join " +
                    "product_category_desc on csi_catid = pcd_catid " +
            "inner join " +
                    "counter_sales_order on csi_salesid = cso_salesid " +
            "left join " +
                    "counter_sales_payment on cso_salesid = csm_salesid " +
            "inner join " +
                    "product_master on csi_skucode = pmp_skucode " +
            "where " +
                    "cso_bonusdate between ? and ? and " +
                    "cso_trxdoctype != ? and " +
                    "pmp_selling = ? " +
   
            "UNION " +

            "select " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "day_before, " +
                    "day_before, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "sum_qty_order - if(isnull(sum_qty_min),0,sum_qty_min), " +
                    "?, " +
                    "sum_unit_price - if(isnull(sum_unit_price_min),0,sum_unit_price_min), " +
                    "sum_net_price - if(isnull(sum_net_price_min),0,sum_net_price_min), " +
                    "?, " +
                    "sum_discount - if(isnull(sum_discount_min),0,sum_discount_min), " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "? " +
            "from  " +
                    "(select " +
                        "? - INTERVAL 1 DAY as day_before, " +
                        "sum(csi_qty_order) as sum_qty_order, " +
                        "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price, " +
                        "sum(csi_unit_netprice) as sum_net_price, " +
                        "sum(csi_unit_discount) as sum_discount " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "cso_status in(30,60) and " +
                            "pmp_selling = ? ) tot " +
            "inner join " +
                    "(select " +
                            "sum(csi_qty_order) as sum_qty_min, " +
                            "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price_min, " +
                            "sum(csi_unit_netprice) as sum_net_price_min, " +
                            "sum(csi_unit_discount) as sum_discount_min " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "pmp_selling = ? and " +
                            "cso_trxdocname = ?) min " +
            "order by " +
                    "cso_trxdate,cso_trxdocno,csi_productcode,serial_number";
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "");
            stmt.setString(2, " - ");
            stmt.setString(3, " - ");
            stmt.setString(4, "");
            stmt.setString(5, ". ");
            stmt.setString(6, docDtFromStr);
            stmt.setString(7, docDtToStr);
            stmt.setString(8, "CN");
            stmt.setString(9, "Y");
            
            stmt.setString(10, "");
            stmt.setString(11, "");
            stmt.setString(12, "");
            stmt.setString(13, "");
            stmt.setString(14, "");
            stmt.setString(15, "");
            stmt.setString(16, "");
            stmt.setString(17, "");
            stmt.setString(18, "");
            stmt.setString(19, "");
            stmt.setString(20, "");
            stmt.setString(21, "");
            stmt.setString(22, "");
            stmt.setString(23, "");
            stmt.setString(24, "");
            stmt.setString(25, "");
            stmt.setString(26, "");
            stmt.setString(27, "");
            stmt.setString(28, "");
            stmt.setString(29, "");
            stmt.setString(30, "");
            stmt.setString(31, docDtFromStr);
            stmt.setString(32, docDtFromStr);
            stmt.setString(33, "%Y-%m-01");
            stmt.setString(34, docDtFromStr);
            stmt.setString(35, "Y");
            stmt.setString(36, docDtFromStr);
            stmt.setString(37, "%Y-%m-01");
            stmt.setString(38, docDtFromStr);
            stmt.setString(39, "Y");
            stmt.setString(40, "Sales Return");
            //System.out.println("tes : "+stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                count++;
                rptBean = new DSRReportBean();
                rptBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRReport --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getDSRReport1(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select " + 
                    "if(upper(pmp_productcode) like 'SAP%', 'WINDER', " +
                            "if((locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) > 0) and ((select upper(tre_brand) from target_reff where tre_id = mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1)) is not null), " +
                                "(select upper(tre_brand) from target_reff where tre_id = mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1)), " +
                                    "if(upper(trim(pmp_productseries)) = 'ACCESORIES', 'ACCESSORIES', 'OTHER'))) as brand_code, " +
                    "cso_salesid, " +
                    "csi_seq, " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "cso_trxdate, " +
                    "cso_bonusdate, " +
                    "cso_trxdocno, " +
                    "if(isnull(cso_adj_refno),'',cso_adj_refno) as refno, " +
                    "cso_trxdoctype, " +
                    "csi_productcode, " +
                    "csi_skuname, " +
                    "if(trim(csi_productcode) = trim(csi_skucode),?,csi_skucode) as serial_number, " +
                    "csi_qty_order, " +
                    "csi_unit_price, " +
                    "(csi_unit_price * csi_bv1) as idr_unit_price, " +
                    "csi_unit_netprice, " +
                    "round((cso_total_bv3/(cso_netsales_amt + cso_total_bv3))*100,2) as discount, " +
                    "csi_unit_discount, " +
                    "csi_bv1, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',csm_paymodedesc),?,if(isnull(csm_paymodeedc),'',csm_paymodeedc),?,if(isnull(csm_paymodetime),'',csm_paymodetime)) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr, " +
                    "cso_bonus_earnername, " +
                    "cso_cust_name, " +
                    "cso_status, " +
                    "CONCAT(if(ISNULL(cso_adj_remark),?,CONCAT(cso_adj_remark,?)),cso_remark) as remark " +
            "from " +
                    "counter_sales_item " +
            "inner join " +
                    "product_category_desc on csi_catid = pcd_catid " +
            "inner join " +
                    "counter_sales_order on csi_salesid = cso_salesid " +
            "left join " +
                    "counter_sales_payment on cso_salesid = csm_salesid " +
            "inner join " +
                    "product_master on csi_skucode = pmp_skucode " +
            "where " +
                    "cso_bonusdate between ? and ? and " +
                    "cso_trxdoctype != ? and " +
                    "pmp_selling = ? " +
   
            "UNION " +

            "select " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "day_before, " +
                    "day_before, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "sum_qty_order - if(isnull(sum_qty_min),0,sum_qty_min), " +
                    "?, " +
                    "sum_unit_price - if(isnull(sum_unit_price_min),0,sum_unit_price_min), " +
                    "sum_net_price - if(isnull(sum_net_price_min),0,sum_net_price_min), " +
                    "?, " +
                    "sum_discount - if(isnull(sum_discount_min),0,sum_discount_min), " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "? " +
            "from  " +
                    "(select " +
                        "? - INTERVAL 1 DAY as day_before, " +
                        "sum(csi_qty_order) as sum_qty_order, " +
                        "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price, " +
                        "sum(csi_unit_netprice) as sum_net_price, " +
                        "sum(csi_unit_discount) as sum_discount " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "cso_status in(30,60) and " +
                            "pmp_selling = ? ) tot " +
            "inner join " +
                    "(select " +
                            "sum(csi_qty_order) as sum_qty_min, " +
                            "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price_min, " +
                            "sum(csi_unit_netprice) as sum_net_price_min, " +
                            "sum(csi_unit_discount) as sum_discount_min " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "pmp_selling = ? and " +
                            "cso_trxdocname = ?) min " +
            "order by " +
                    "cso_trxdate,cso_trxdocno,csi_productcode,serial_number";
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "");
            stmt.setString(2, " - ");
            stmt.setString(3, " - ");
            stmt.setString(4, "");
            stmt.setString(5, ". ");
            stmt.setString(6, docDtFromStr);
            stmt.setString(7, docDtToStr);
            stmt.setString(8, "CN");
            stmt.setString(9, "Y");
            
            stmt.setString(10, "");
            stmt.setString(11, "");
            stmt.setString(12, "");
            stmt.setString(13, "");
            stmt.setString(14, "");
            stmt.setString(15, "");
            stmt.setString(16, "");
            stmt.setString(17, "");
            stmt.setString(18, "");
            stmt.setString(19, "");
            stmt.setString(20, "");
            stmt.setString(21, "");
            stmt.setString(22, "");
            stmt.setString(23, "");
            stmt.setString(24, "");
            stmt.setString(25, "");
            stmt.setString(26, "");
            stmt.setString(27, "");
            stmt.setString(28, "");
            stmt.setString(29, "");
            stmt.setString(30, "");
            stmt.setString(31, docDtFromStr);
            stmt.setString(32, docDtFromStr);
            stmt.setString(33, "%Y-%m-01");
            stmt.setString(34, docDtFromStr);
            stmt.setString(35, "Y");
            stmt.setString(36, docDtFromStr);
            stmt.setString(37, "%Y-%m-01");
            stmt.setString(38, docDtFromStr);
            stmt.setString(39, "Y");
            stmt.setString(40, "Sales Return");
            //System.out.println("tes : "+stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                count++;
                rptBean = new DSRReportBean();
                rptBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRReport1 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getDSRReport2(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select " +
                "if((substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2) <> 'AR'), "+
                    "if((select tre_brand from target_reff where tre_id = substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2)) is not null,(select tre_brand from target_reff where tre_id = substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2)), " +
                        "if(IsNumeric(regex_replace('[^A-Z0-9]','',upper(pmp_productcode))) = 1, 'EYEWEAR', 'ACCESSORIES')),"+
                "(select tre_brand from target_reff where CONCAT(tre_id, tre_productseries) = CONCAT(substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2), pmp_productseries))) as brand_code, " +
                    "cso_salesid, " +
                    "csi_seq, " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "cso_trxdate, " +
                    "cso_bonusdate, " +
                    "cso_trxdocno, " +
                    "if(isnull(cso_adj_refno),'',cso_adj_refno) as refno, " +
                    "cso_trxdoctype, " +
                    "csi_productcode, " +
                    "csi_skuname, " +
                    "if(trim(csi_productcode) = trim(csi_skucode),?,csi_skucode) as serial_number, " +
                    "csi_qty_order, " +
                    "csi_unit_price, " +
                    "(csi_unit_price * csi_bv1) as idr_unit_price, " +
                    "csi_unit_netprice, " +
                    "round((cso_total_bv3/(cso_netsales_amt + cso_total_bv3))*100,2) as discount, " +
                    "csi_unit_discount, " +
                    "csi_bv1, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',csm_paymodedesc),?,if(isnull(csm_paymodeedc),'',csm_paymodeedc),?,if(isnull(csm_paymodetime),'',csm_paymodetime)) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr, " +
                    "cso_bonus_earnername, " +
                    "cso_cust_name, " +
                    "cso_status, " +
                    "CONCAT(if(ISNULL(cso_adj_remark),?,CONCAT(cso_adj_remark,?)),cso_remark) as remark " +
            "from " +
                    "counter_sales_item " +
            "inner join " +
                    "product_category_desc on csi_catid = pcd_catid " +
            "inner join " +
                    "counter_sales_order on csi_salesid = cso_salesid " +
            "left join " +
                    "counter_sales_payment on cso_salesid = csm_salesid " +
            "inner join " +
                    "product_master on csi_skucode = pmp_skucode " +
            "where " +
                    "cso_bonusdate between ? and ? and " +
                    "cso_trxdoctype != ? and " +
                    "pmp_selling = ? " +
   
            "UNION " +

            "select " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "day_before, " +
                    "day_before, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "sum_qty_order - if(isnull(sum_qty_min),0,sum_qty_min), " +
                    "?, " +
                    "sum_unit_price - if(isnull(sum_unit_price_min),0,sum_unit_price_min), " +
                    "sum_net_price - if(isnull(sum_net_price_min),0,sum_net_price_min), " +
                    "?, " +
                    "sum_discount - if(isnull(sum_discount_min),0,sum_discount_min), " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "? " +
            "from  " +
                    "(select " +
                        "? - INTERVAL 1 DAY as day_before, " +
                        "sum(csi_qty_order) as sum_qty_order, " +
                        "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price, " +
                        "sum(csi_unit_netprice) as sum_net_price, " +
                        "sum(csi_unit_discount) as sum_discount " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "cso_status in(30,60) and " +
                            "pmp_selling = ? ) tot " +
            "inner join " +
                    "(select " +
                            "sum(csi_qty_order) as sum_qty_min, " +
                            "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price_min, " +
                            "sum(csi_unit_netprice) as sum_net_price_min, " +
                            "sum(csi_unit_discount) as sum_discount_min " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "pmp_selling = ? and " +
                            "cso_trxdocname = ?) min " +
            "order by " +
                    "cso_trxdate,cso_trxdocno,csi_productcode,serial_number";
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "");
            stmt.setString(2, " - ");
            stmt.setString(3, " - ");
            stmt.setString(4, "");
            stmt.setString(5, ". ");
            stmt.setString(6, docDtFromStr);
            stmt.setString(7, docDtToStr);
            stmt.setString(8, "CN");
            stmt.setString(9, "Y");
            
            stmt.setString(10, "");
            stmt.setString(11, "");
            stmt.setString(12, "");
            stmt.setString(13, "");
            stmt.setString(14, "");
            stmt.setString(15, "");
            stmt.setString(16, "");
            stmt.setString(17, "");
            stmt.setString(18, "");
            stmt.setString(19, "");
            stmt.setString(20, "");
            stmt.setString(21, "");
            stmt.setString(22, "");
            stmt.setString(23, "");
            stmt.setString(24, "");
            stmt.setString(25, "");
            stmt.setString(26, "");
            stmt.setString(27, "");
            stmt.setString(28, "");
            stmt.setString(29, "");
            stmt.setString(30, "");
            stmt.setString(31, docDtFromStr);
            stmt.setString(32, docDtFromStr);
            stmt.setString(33, "%Y-%m-01");
            stmt.setString(34, docDtFromStr);
            stmt.setString(35, "Y");
            stmt.setString(36, docDtFromStr);
            stmt.setString(37, "%Y-%m-01");
            stmt.setString(38, docDtFromStr);
            stmt.setString(39, "Y");
            stmt.setString(40, "Sales Return");
            //System.out.println("tes : "+stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                count++;
                rptBean = new DSRReportBean();
                rptBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRReport2 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getDSRReport3(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select " + 
                    "(select tre_brand from target_reff where tre_id = pmp_producttype) as brand_code, " +
                    "cso_salesid, " +
                    "csi_seq, " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "cso_trxdate, " +
                    "cso_bonusdate, " +
                    "cso_trxdocno, " +
                    "if(isnull(cso_adj_refno),'',cso_adj_refno) as refno, " +
                    "cso_trxdoctype, " +
                    "csi_productcode, " +
                    "csi_skuname, " +
                    "if(trim(csi_productcode) = trim(csi_skucode),?,csi_skucode) as serial_number, " +
                    "csi_qty_order, " +
                    "csi_unit_price, " +
                    "(csi_unit_price * csi_bv1) as idr_unit_price, " +
                    "csi_unit_netprice, " +
                    "round((cso_total_bv3/(cso_netsales_amt + cso_total_bv3))*100,2) as discount, " +
                    "csi_unit_discount, " +
                    "csi_bv1, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',csm_paymodedesc),?,if(isnull(csm_paymodeedc),'',csm_paymodeedc),?,if(isnull(csm_paymodetime),'',csm_paymodetime)) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr, " +
                    "cso_bonus_earnername, " +
                    "cso_cust_name, " +
                    "cso_status, " +
                    "CONCAT(if(ISNULL(cso_adj_remark),?,CONCAT(cso_adj_remark,?)),cso_remark) as remark " +
            "from " +
                    "counter_sales_item " +
            "inner join " +
                    "product_category_desc on csi_catid = pcd_catid " +
            "inner join " +
                    "counter_sales_order on csi_salesid = cso_salesid " +
            "left join " +
                    "counter_sales_payment on cso_salesid = csm_salesid " +
            "inner join " +
                    "product_master on csi_skucode = pmp_skucode " +
            "where " +
                    "cso_bonusdate between ? and ? and " +
                    "cso_trxdoctype != ? and " +
                    "pmp_selling = ? " +
   
            "UNION " +

            "select " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "day_before, " +
                    "day_before, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "sum_qty_order - if(isnull(sum_qty_min),0,sum_qty_min), " +
                    "?, " +
                    "sum_unit_price - if(isnull(sum_unit_price_min),0,sum_unit_price_min), " +
                    "sum_net_price - if(isnull(sum_net_price_min),0,sum_net_price_min), " +
                    "?, " +
                    "sum_discount - if(isnull(sum_discount_min),0,sum_discount_min), " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "? " +
            "from  " +
                    "(select " +
                        "? - INTERVAL 1 DAY as day_before, " +
                        "sum(csi_qty_order) as sum_qty_order, " +
                        "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price, " +
                        "sum(csi_unit_netprice) as sum_net_price, " +
                        "sum(csi_unit_discount) as sum_discount " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "cso_status in(30,60) and " +
                            "pmp_selling = ? ) tot " +
            "inner join " +
                    "(select " +
                            "sum(csi_qty_order) as sum_qty_min, " +
                            "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price_min, " +
                            "sum(csi_unit_netprice) as sum_net_price_min, " +
                            "sum(csi_unit_discount) as sum_discount_min " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "pmp_selling = ? and " +
                            "cso_trxdocname = ?) min " +
            "order by " +
                    "cso_trxdate,cso_trxdocno,csi_productcode,serial_number";
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "");
            stmt.setString(2, " - ");
            stmt.setString(3, " - ");
            stmt.setString(4, "");
            stmt.setString(5, ". ");
            stmt.setString(6, docDtFromStr);
            stmt.setString(7, docDtToStr);
            stmt.setString(8, "CN");
            stmt.setString(9, "Y");
            
            stmt.setString(10, "");
            stmt.setString(11, "");
            stmt.setString(12, "");
            stmt.setString(13, "");
            stmt.setString(14, "");
            stmt.setString(15, "");
            stmt.setString(16, "");
            stmt.setString(17, "");
            stmt.setString(18, "");
            stmt.setString(19, "");
            stmt.setString(20, "");
            stmt.setString(21, "");
            stmt.setString(22, "");
            stmt.setString(23, "");
            stmt.setString(24, "");
            stmt.setString(25, "");
            stmt.setString(26, "");
            stmt.setString(27, "");
            stmt.setString(28, "");
            stmt.setString(29, "");
            stmt.setString(30, "");
            stmt.setString(31, docDtFromStr);
            stmt.setString(32, docDtFromStr);
            stmt.setString(33, "%Y-%m-01");
            stmt.setString(34, docDtFromStr);
            stmt.setString(35, "Y");
            stmt.setString(36, docDtFromStr);
            stmt.setString(37, "%Y-%m-01");
            stmt.setString(38, docDtFromStr);
            stmt.setString(39, "Y");
            stmt.setString(40, "Sales Return");
            //System.out.println("tes : "+stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                count++;
                rptBean = new DSRReportBean();
                rptBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRReport3 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    protected ArrayList getDSRReport4(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select " + 
                    "(select tre_brand from target_reff where tre_id = pmp_producttype) as brand_code, " +
                    "cso_salesid, " +
                    "csi_seq, " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "cso_trxdate, " +
                    "cso_bonusdate, " +
                    "cso_trxdocno, " +
                    "if(isnull(cso_adj_refno),'',cso_adj_refno) as refno, " +
                    "cso_trxdoctype, " +
                    "csi_productcode, " +
                    "csi_skuname, " +
                    "if(trim(csi_productcode) = trim(csi_skucode),?,csi_skucode) as serial_number, " +
                    "csi_qty_order, " +
                    "csi_unit_price, " +
                    "(csi_unit_price * csi_bv1) as idr_unit_price, " +
                    "csi_unit_netprice, " +
                    "round((cso_total_bv3/(cso_netsales_amt + cso_total_bv3))*100,2) as discount, " +
                    "csi_unit_discount, " +
                    "csi_bv1, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',csm_paymodedesc),?,if(isnull(csm_paymodeedc),'',csm_paymodeedc),?,if(isnull(csm_paymodetime),'',csm_paymodetime)) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr, " +
                    "cso_bonus_earnername, " +
                    "cso_cust_name, " +
                    "cso_status, " +
                    "CONCAT(if(ISNULL(cso_adj_remark),?,CONCAT(cso_adj_remark,?)),cso_remark) as remark " +
            "from " +
                    "counter_sales_item " +
            "inner join " +
                    "product_category_desc on csi_catid = pcd_catid " +
            "inner join " +
                    "counter_sales_order on csi_salesid = cso_salesid " +
            "left join " +
                    "counter_sales_payment on cso_salesid = csm_salesid " +
            "inner join " +
                    "product_master on csi_skucode = pmp_skucode " +
            "where " +
                    "cso_bonusdate between ? and ? and " +
                    "cso_trxdoctype != ? and " +
                    "pmp_selling = ? " +
   
            "UNION " +

            "select " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "day_before, " +
                    "day_before, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "sum_qty_order - if(isnull(sum_qty_min),0,sum_qty_min), " +
                    "?, " +
                    "sum_unit_price - if(isnull(sum_unit_price_min),0,sum_unit_price_min), " +
                    "sum_net_price - if(isnull(sum_net_price_min),0,sum_net_price_min), " +
                    "?, " +
                    "sum_discount - if(isnull(sum_discount_min),0,sum_discount_min), " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "?, " +
                    "? " +
            "from  " +
                    "(select " +
                        "? - INTERVAL 1 DAY as day_before, " +
                        "sum(csi_qty_order) as sum_qty_order, " +
                        "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price, " +
                        "sum(csi_unit_netprice) as sum_net_price, " +
                        "sum(csi_unit_discount) as sum_discount " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "cso_status in(30,60) and " +
                            "pmp_selling = ? ) tot " +
            "inner join " +
                    "(select " +
                            "sum(csi_qty_order) as sum_qty_min, " +
                            "sum(csi_unit_price * csi_bv1 * csi_qty_order) as sum_unit_price_min, " +
                            "sum(csi_unit_netprice) as sum_net_price_min, " +
                            "sum(csi_unit_discount) as sum_discount_min " +
                    "from " +
                            "counter_sales_item " +
                    "inner join " +
                            "counter_sales_order on csi_salesid = cso_salesid  " +
                    "inner join " + 
                            "product_master on csi_skucode = pmp_skucode " + 
                    "where " +
                            "cso_bonusdate between DATE_FORMAT(?,?) and (? - INTERVAL 1 DAY) and " +
                            "pmp_selling = ? and " +
                            "cso_trxdocname = ?) min " +
            "order by " +
                    "cso_trxdate,cso_trxdocno,csi_productcode,serial_number";
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "");
            stmt.setString(2, " - ");
            stmt.setString(3, " - ");
            stmt.setString(4, "");
            stmt.setString(5, ". ");
            stmt.setString(6, docDtFromStr);
            stmt.setString(7, docDtToStr);
            stmt.setString(8, "CN");
            stmt.setString(9, "Y");
            
            stmt.setString(10, "");
            stmt.setString(11, "");
            stmt.setString(12, "");
            stmt.setString(13, "");
            stmt.setString(14, "");
            stmt.setString(15, "");
            stmt.setString(16, "");
            stmt.setString(17, "");
            stmt.setString(18, "");
            stmt.setString(19, "");
            stmt.setString(20, "");
            stmt.setString(21, "");
            stmt.setString(22, "");
            stmt.setString(23, "");
            stmt.setString(24, "");
            stmt.setString(25, "");
            stmt.setString(26, "");
            stmt.setString(27, "");
            stmt.setString(28, "");
            stmt.setString(29, "");
            stmt.setString(30, "");
            stmt.setString(31, docDtFromStr);
            stmt.setString(32, docDtFromStr);
            stmt.setString(33, "%Y-%m-01");
            stmt.setString(34, docDtFromStr);
            stmt.setString(35, "Y");
            stmt.setString(36, docDtFromStr);
            stmt.setString(37, "%Y-%m-01");
            stmt.setString(38, docDtFromStr);
            stmt.setString(39, "Y");
            stmt.setString(40, "Sales Return");
            //System.out.println("tes : "+stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                count++;
                rptBean = new DSRReportBean();
                rptBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRReport4 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getCurRate(String docDate)
        throws Exception
    {
        DSRReportBean curRate;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "usd.cer_currencyid as usd_currencyid, " +
                    "usd.cer_exchange as usd_exchange, " +
                    "usd.cer_rate as usd_rate, " +
                    "usd.cer_startdate as usd_startdate, " +
                    "usd.cer_starttime as usd_starttime, " +
                    "usd.cer_enddate as usd_enddate, " +
                    "usd.cer_endtime as usd_endtime, " +
                    "sgd.cer_currencyid as sgd_currencyid, " +
                    "sgd.cer_exchange as sgd_exchange, " +
                    "sgd.cer_rate as sgd_rate, " +
                    "sgd.cer_startdate as sgd_startdate, " +
                    "sgd.cer_starttime as sgd_starttime, " +
                    "sgd.cer_enddate as sgd_enddate, " +
                    "sgd.cer_endtime as sgd_endtime " +
                "from " +
                    "(select * from currency_exchange_rate where cer_currencyid = 'USD' and cer_exchange='USD-SELL-HE' and cer_startdate <= ? and cer_enddate >= ? order by cer_startdate desc, cer_endtime desc  limit 1) usd, " +
                    "(select * from currency_exchange_rate where cer_currencyid = 'SGD' and cer_exchange='SGD-SELL-HE' and cer_startdate <= ? and cer_enddate >= ? order by cer_startdate desc, cer_endtime desc  limit 1) sgd";

        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDate);
            stmt.setString(2, docDate);
            stmt.setString(3, docDate);
            stmt.setString(4, docDate);
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(curRate))
            {
                count++;
                curRate = new DSRReportBean();
                curRate.parseCurRateBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCurRate --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getSummary(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean Summary;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " + 
                    "if(isnull(pcd_name),'',pcd_name) as brand, " +
                    "tgt_amt, " +
                    "if(isnull(netprice),0,netprice) as netsales, " +
                    "(if(isnull(netprice),0,netprice) / tgt_amt) * 100 as percent, " +
                    "if(isnull(csi_qty),0,csi_qty) as qty, " +
                    "if(isnull(tgt_qty),0,tgt_qty) as tgt_qty " +
                "from " +
                        "target_brand " +
                "left join " +
                  "(select " + 
                                        "pcd_desc as prod_brand, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_unit_netprice * -1,csi_unit_netprice)) as netprice, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_qty_order * -1,csi_qty_order)) as csi_qty " +
                                "from " +
                                        "counter_sales_order " +
                                "left join " +
                                        "counter_sales_item on cso_salesid = csi_salesid " +
                                "inner join " +
                                        "product_category_desc on csi_catid = pcd_catid " +
                                "where " +
                                        "cso_bonusdate between DATE_FORMAT(?,?) and ? and " +
                                        "cso_status != ? and " +
                                        "cso_trxdoctype != ? and " +
                                        "(select pmp_selling from product_master where pmp_skucode = csi_skucode) != ? " +
                                "group by " +
                                        "pcd_desc) prod on upper(trim(tgt_brand)) = upper(trim(prod_brand)) " +
                "inner join " +
                        "product_category_desc on upper(trim(tgt_brand)) = upper(trim(pcd_desc)) " +
                "where " +
                        "concat(LPAD(tgt_month,2,?),?,tgt_year) between DATE_FORMAT(?,?) and DATE_FORMAT(?,?) " +
                "group by " +
                        "pcd_name " +
                "order by " +
                        "tgt_brand"; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, "%Y-%m-01");
            stmt.setString(3, docDtToStr);
            stmt.setInt(4, 50);
            stmt.setString(5, "CN");
            stmt.setString(6, "N");
            stmt.setString(7, "0");
            stmt.setString(8, " ");
            stmt.setString(9, docDtFromStr);
            stmt.setString(10, "%m %Y");
            stmt.setString(11, docDtToStr);
            stmt.setString(12, "%m %Y");
            //System.out.println("Tes Me : " + stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(Summary))
            {
                count++;
                Summary = new DSRReportBean();
                Summary.parseSummaryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSummary --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getSummary1(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean Summary;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "if(isnull(tgt_brand),'',tgt_brand) as brand, " +
                    "tgt_amt, " +
                    "if(isnull(netprice),0,netprice) as netsales, " +
                    "(if(isnull(netprice),0,netprice) / tgt_amt) * 100 as percent, " +
                    "if(isnull(csi_qty),0,csi_qty) as qty, " +
                    "if(isnull(tgt_qty),0,tgt_qty) as tgt_qty " +
                "from " +
                        "target_brand " +
                "left join " +
                  "(select " + 
                                        /*"if(upper(pmp_productcode) like 'SAP%', 'WINDER', " +
                                        "if(locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) > 0 and mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1) = '0', 'STEEL', " +
                                                "if(locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) > 0 and mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1) in ('1','2','3','4'), 'STEEL & GOLD', " +
                                                        "if(locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) > 0 and mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1) in ('5','6','7','8','9'), 'ALL GOLD', " +
                                                                "if(upper(trim(pmp_productseries)) = 'ACCESORIES', 'ACCESSORIES', 'OTHER'))))) as prod_brand, " +*/
                                        "if(upper(pmp_productcode) like 'SAP%', 'WINDER', " +
                                            "if((locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) > 0) and ((select upper(tre_brand) from target_reff where tre_id = mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1)) is not null), " +
                                                "(select upper(tre_brand) from target_reff where tre_id = mid(regex_replace('[^0-9\\-]','',pmp_productcode),locate('-',regex_replace('[^0-9\\-]','',pmp_productcode)) - 1,1)), " +
                                                    "if(upper(trim(pmp_productseries)) = 'ACCESORIES', 'ACCESSORIES', 'OTHER'))) as prod_brand, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_unit_netprice * -1,csi_unit_netprice)) as netprice, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_qty_order * -1,csi_qty_order)) as csi_qty " +
                                "from " +
                                        "counter_sales_order " +
                                "left join " +
                                        "counter_sales_item on cso_salesid = csi_salesid " +
                                "inner join " +
                                        "product_master on csi_productcode = pmp_productcode " +
                                "where " +
                                        "cso_bonusdate between DATE_FORMAT(?,?) and ? and " +
                                        "cso_status != ? and " +
                                        "cso_trxdoctype != ? and " +
                                        "(select pmp_selling from product_master where pmp_skucode = csi_skucode) != ? " +
                                "group by " +
                                        "prod_brand) prod on upper(trim(tgt_brand)) = upper(trim(prod_brand)) " +
                "where " +
                        "concat(LPAD(tgt_month,2,?),?,tgt_year) between DATE_FORMAT(?,?) and DATE_FORMAT(?,?) " +
                "group by " +
                        "tgt_brand " +
                "order by " +
                        "tgt_brand"; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, "%Y-%m-01");
            stmt.setString(3, docDtToStr);
            stmt.setInt(4, 50);
            stmt.setString(5, "CN");
            stmt.setString(6, "N");
            stmt.setString(7, "0");
            stmt.setString(8, " ");
            stmt.setString(9, docDtFromStr);
            stmt.setString(10, "%m %Y");
            stmt.setString(11, docDtToStr);
            stmt.setString(12, "%m %Y");
            //System.out.println("Tes Me : " + stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(Summary))
            {
                count++;
                Summary = new DSRReportBean();
                Summary.parseSummaryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSummary1 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getSummary2(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean Summary;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "if(isnull(tgt_brand),'',tgt_brand) as brand, " +
                    "tgt_amt, " +
                    "if(isnull(netprice),0,netprice) as netsales, " +
                    "(if(isnull(netprice),0,netprice) / tgt_amt) * 100 as percent, " +
                    "if(isnull(csi_qty),0,csi_qty) as qty, " +
                    "if(isnull(tgt_qty),0,tgt_qty) as tgt_qty " +
                "from " +
                        "target_brand " +
                "left join " +
                  "(select " +          
                                        "if((substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2) <> 'AR'), "+
                    "if((select tre_brand from target_reff where tre_id = substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2)) is not null,(select tre_brand from target_reff where tre_id = substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2)), " +
                       "if(IsNumeric(regex_replace('[^A-Z0-9]','',upper(pmp_productcode))) = 1, 'EYEWEAR', 'ACCESSORIES')),"+
                "(select tre_brand from target_reff where CONCAT(tre_id, tre_productseries) = CONCAT(substr(regex_replace('[^A-Z\\-]','',substr(upper(pmp_productcode),1,3)),2), pmp_productseries))) as prod_brand, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_unit_netprice * -1,csi_unit_netprice)) as netprice, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_qty_order * -1,csi_qty_order)) as csi_qty " +
                                "from " +
                                        "counter_sales_order " +
                                "left join " +
                                        "counter_sales_item on cso_salesid = csi_salesid " +
                                "inner join " +
                                        "product_master on csi_productcode = pmp_productcode " +
                                "where " +
                                        "cso_bonusdate between DATE_FORMAT(?,?) and ? and " +
                                        "cso_status != ? and " +
                                        "cso_trxdoctype != ? and " +
                                        "(select pmp_selling from product_master where pmp_skucode = csi_skucode) != ? " +
                                "group by " +
                                        "prod_brand) prod on upper(trim(tgt_brand)) = upper(trim(prod_brand)) " +
                "where " +
                        "concat(LPAD(tgt_month,2,?),?,tgt_year) between DATE_FORMAT(?,?) and DATE_FORMAT(?,?) " +
                "group by " +
                        "tgt_brand " +
                "order by " +
                        "tgt_brand"; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, "%Y-%m-01");
            stmt.setString(3, docDtToStr);
            stmt.setInt(4, 50);
            stmt.setString(5, "CN");
            stmt.setString(6, "N");
            stmt.setString(7, "0");
            stmt.setString(8, " ");
            stmt.setString(9, docDtFromStr);
            stmt.setString(10, "%m %Y");
            stmt.setString(11, docDtToStr);
            stmt.setString(12, "%m %Y");
            //System.out.println("Tes Me : " + stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(Summary))
            {
                count++;
                Summary = new DSRReportBean();
                Summary.parseSummaryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSummary2 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getSummary3(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean Summary;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " + 
                    "if(isnull(tgt_brand),'',tgt_brand) as brand, " +
                    "tgt_amt, " +
                    "if(isnull(netprice),0,netprice) as netsales, " +
                    "(if(isnull(netprice),0,netprice) / tgt_amt) * 100 as percent, " +
                    "if(isnull(csi_qty),0,csi_qty) as qty, " +
                    "if(isnull(tgt_qty),0,tgt_qty) as tgt_qty " +
                "from " +
                        "target_brand " +
                "left join " +
                  "(select " + 
                                        "(select tre_brand from target_reff where tre_id = pmp_producttype) as prod_brand, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_unit_netprice * -1,csi_unit_netprice)) as netprice, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_qty_order * -1,csi_qty_order)) as csi_qty " +
                                "from " +
                                        "counter_sales_order " +
                                "left join " +
                                        "counter_sales_item on cso_salesid = csi_salesid " +
                                "inner join " +
                                        "product_master on csi_productid = pmp_productid " +
                                "where " +
                                        "cso_bonusdate between DATE_FORMAT(?,?) and ? and " +
                                        "cso_status != ? and " +
                                        "cso_trxdoctype != ? and " +
                                        "pmp_selling != ? " +
                                "group by " +
                                        "pmp_producttype) prod on upper(trim(tgt_brand)) = upper(trim(prod_brand)) " +
                "where " +
                        "concat(LPAD(tgt_month,2,?),?,tgt_year) between DATE_FORMAT(?,?) and DATE_FORMAT(?,?) " +
                "group by " +
                        "tgt_brand " +
                "order by " +
                        "tgt_brand"; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, "%Y-%m-01");
            stmt.setString(3, docDtToStr);
            stmt.setInt(4, 50);
            stmt.setString(5, "CN");
            stmt.setString(6, "N");
            stmt.setString(7, "0");
            stmt.setString(8, " ");
            stmt.setString(9, docDtFromStr);
            stmt.setString(10, "%m %Y");
            stmt.setString(11, docDtToStr);
            stmt.setString(12, "%m %Y");
            //System.out.println("Tes Me : " + stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(Summary))
            {
                count++;
                Summary = new DSRReportBean();
                Summary.parseSummaryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSummary3 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    protected ArrayList getSummary4(String outletID, String docDtFromStr, String docDtToStr)
        throws Exception
    {
        DSRReportBean Summary;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " + 
                    "if(isnull(tgt_brand),'',tgt_brand) as brand, " +
                    "tgt_amt, " +
                    "if(isnull(netprice),0,netprice) as netsales, " +
                    "(if(isnull(netprice),0,netprice) / tgt_amt) * 100 as percent, " +
                    "if(isnull(csi_qty),0,csi_qty) as qty, " +
                    "if(isnull(tgt_qty),0,tgt_qty) as tgt_qty " +
                "from " +
                        "target_brand " +
                "left join " +
                  "(select " + 
                                        "(select tre_brand from target_reff where tre_id = pmp_producttype) as prod_brand, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_unit_netprice * -1,csi_unit_netprice)) as netprice, " +
                                        "sum(if(cso_status != 30 and cso_status != 60,csi_qty_order * -1,csi_qty_order)) as csi_qty " +
                                "from " +
                                        "counter_sales_order " +
                                "left join " +
                                        "counter_sales_item on cso_salesid = csi_salesid " +
                                "inner join " +
                                        "product_master on csi_productid = pmp_productid " +
                                "where " +
                                        "cso_bonusdate between DATE_FORMAT(?,?) and ? and " +
                                        "cso_status != ? and " +
                                        "cso_trxdoctype != ? and " +
                                        "pmp_selling != ? " +
                                "group by " +
                                        "pmp_producttype) prod on upper(trim(tgt_brand)) = upper(trim(prod_brand)) " +
                "where " +
                        "concat(LPAD(tgt_month,2,?),?,tgt_year) between DATE_FORMAT(?,?) and DATE_FORMAT(?,?) " +
                "group by " +
                        "tgt_brand " +
                "order by " +
                        "tgt_brand"; 
        
        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, docDtFromStr);
            stmt.setString(2, "%Y-%m-01");
            stmt.setString(3, docDtToStr);
            stmt.setInt(4, 50);
            stmt.setString(5, "CN");
            stmt.setString(6, "N");
            stmt.setString(7, "0");
            stmt.setString(8, " ");
            stmt.setString(9, docDtFromStr);
            stmt.setString(10, "%m %Y");
            stmt.setString(11, docDtToStr);
            stmt.setString(12, "%m %Y");
            //System.out.println("Tes Me : " + stmt);
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(Summary))
            {
                count++;
                Summary = new DSRReportBean();
                Summary.parseSummaryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSummary4 --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getPaymentByDocNo(String docNo)
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "csm_seq, " +
                    "csm_rate, " +
                    "CONCAT(if(isnull(csm_paymodedesc),'',trim(csm_paymodedesc)),?,if(isnull(csm_paymodeedc),'',trim(csm_paymodeedc)),?,if(isnull(csm_paymodetime),'',trim(csm_paymodetime))) as payment_mode, " +
                    "csm_amt as payment_amt, " +
                    "csm_currency as payment_curr " +
            "from " +
                    "counter_sales_payment " +
            "left join " +
                    "counter_sales_order on csm_salesid = cso_salesid " +
            "where " +
                    "cso_trxdocno = ? ";

        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, " - ");
            stmt.setString(2, " - ");
            stmt.setString(3, docNo);
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                rptBean = new DSRReportBean();
                rptBean.parsePaymentBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getPaymentByDocNo --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getOutletInitial()
        throws Exception
    {
        DSRReportBean rptBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "otl_outletid, " +
                    "otl_name " +
            "from " +
                    "outlet " +
            "where " +
                    "otl_outletid in (select oin_outletid from outlet_initial)";

        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(rptBean))
            {
                rptBean = new DSRReportBean();
                rptBean.parseOutletBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getOutletInitial --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected int getDSRCatStat()
        throws MvcException, SQLException
    {
        int DSRCatStat;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        DSRCatStat = 0;
        stmt = null;
        rs = null;
        
        SQL = "select oin_dsr_category_stat from outlet_initial ";
        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            
            rs = stmt.executeQuery();
            if(rs.next())
                DSRCatStat = rs.getInt("oin_dsr_category_stat");
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDSRCatStat --> ")).append(e.toString()).toString());
        }
        finally
        {
            if(stmt != null)
                stmt.close();
            if(rs != null)
                rs.close();
            
            return DSRCatStat;
        }
    }
    
}
