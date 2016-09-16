// Decompiled by Yody
// File : CounterSalesReportBroker.class

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

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterCollectionReportBean, CounterSalesOrderBean, CounterSalesPaymentBean, ProductSalesReportBean,
//            ProductKivReportBean, SalesSummaryBean, CounterSalesItemBean

public class CounterSalesReportBroker extends DBTransactionBroker {
    
    protected CounterSalesReportBroker(Connection con) {
        super(con);
    }
    
    protected String[] getCounterDocumentList(String outletID)
    throws Exception {
        String fullList[];
        PreparedStatement stmt;
        ResultSet rs;
        String sql_doc;
        fullList = new String[0];
        stmt = null;
        rs = null;
        sql_doc = "select distinct(cso_trxdoctype) from counter_sales_order where cso_sellerid = ? order by cso_trxgroup, cso_trxdocno";
        try {
            Connection conn = getConnection();
            stmt = conn.prepareStatement(sql_doc);
            stmt.setString(1, outletID);
            rs = stmt.executeQuery();
            ArrayList list = new ArrayList();
            for(; rs.next(); list.add(rs.getString(1)));
            if(!list.isEmpty())
                fullList = (String[])list.toArray(new String[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCounterDocumentList --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_168;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
         */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return fullList;
    }
    
    protected CounterCollectionReportBean getCounterCollectionReport(String outletID, SQLConditionsBean conditions)
    throws Exception {
        CounterCollectionReportBean rptBean;
        PreparedStatement stmt1;
        PreparedStatement stmt2;
        PreparedStatement stmt3;
        ResultSet rs1;
        ResultSet rs2;
        ResultSet rs3;
        String SQL_trxDtl;
        String SQL_paymentDtl;
        String SQL_paymentGrp;
        rptBean = new CounterCollectionReportBean();
        stmt1 = null;
        stmt2 = null;
        stmt3 = null;
        rs1 = null;
        rs2 = null;
        rs3 = null;
        SQL_trxDtl = (new StringBuilder("select * from counter_sales_order")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        /*awal
        SQL_paymentDtl = "select * from counter_sales_payment where csm_salesid = ?  group by csm_paymodecode order by csm_paymodegroup";
        SQL_paymentGrp = (new StringBuilder("select cso_trxdate, csm_paymodecode, csm_paymodedesc, sum(if (csm_amt != 0 , 1, 0)) as PayCount, sum(if (csm_status <> -10, csm_amt , 0)) as PaymentIn, sum(if (csm_status = -10, csm_amt , 0)) as PaymentOut from counter_sales_payment inner join counter_sales_order on csm_salesid = cso_salesid")).append(conditions.getConditions()).append(" group by cso_trxdate, csm_paymodecode, csm_paymodedesc").append(" order by cso_trxdate, csm_paymodegroup").toString();
         */
        
        // SQL_paymentDtl = "select * from counter_sales_payment where csm_salesid = ? group by csm_paymodedesc, csm_paymodeedc, csm_paymodetime order by csm_paymodedesc, csm_paymodeedc, csm_paymodetime ";
        SQL_paymentDtl = "select * from counter_sales_payment where csm_salesid = ? group by CONCAT(csm_paymodecode,csm_paymodeedc,csm_paymodetime) order by csm_paymodedesc, csm_paymodeedc, csm_paymodetime ";
        // SQL_paymentGrp = (new StringBuilder("select cso_trxdate, CONCAT(csm_paymodecode,csm_paymodeedc,csm_paymodetime,csm_currency) as gabung, csm_paymodecode, csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency, csm_rate, sum(if (csm_status <> -10, (csm_amt * csm_rate)/csm_rate , 0)) as CurrCount, sum(if (csm_amt != 0 , 1, 0)) as PayCount, sum(if (csm_status <> -10, csm_amt * csm_rate , 0)) as PaymentIn, sum(if (csm_status = -10, csm_amt * csm_rate , 0)) as PaymentOut from counter_sales_payment inner join counter_sales_order on csm_salesid = cso_salesid")).append(conditions.getConditions()).append(" group by cso_trxdate, csm_paymodecode,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency ").append(" order by cso_trxdate, csm_paymodegroup,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency").toString();
        // SQL_paymentGrp = (new StringBuilder("select cso_trxdate, csm_paymodecode, csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency, csm_rate, sum(if (csm_status <> -10, (csm_amt * csm_rate)/csm_rate , 0)) as CurrCount, sum(if (csm_amt != 0 , 1, 0)) as PayCount, sum(if (csm_status <> -10, csm_amt * csm_rate , 0)) as PaymentIn, sum(if (csm_status = -10, csm_amt * csm_rate , 0)) as PaymentOut from counter_sales_payment inner join counter_sales_order on csm_salesid = cso_salesid")).append(conditions.getConditions()).append(" group by cso_trxdate, csm_paymodecode,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime ").append(" order by cso_trxdate, csm_paymodegroup,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency").toString();        
        // suka berubah - hrs di refresh
        SQL_paymentGrp = (new StringBuilder("select cso_trxdate, csm_paymodecode, csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency, csm_rate, sum(if (csm_status <> -10, ( csm_amt * csm_rate)/csm_rate , 0)) as CurrCount, sum(if (csm_amt != 0 , 1, 0)) as PayCount, sum(if (csm_status <> -10, (csm_amt * csm_rate) , 0)) as PaymentIn, sum(if (csm_status = -10, (csm_amt * csm_rate) , 0)) as PaymentOut from counter_sales_payment inner join counter_sales_order on csm_salesid = cso_salesid")).append(conditions.getConditions()).append(" group by cso_trxdate, csm_paymodecode ").append(" order by cso_trxdate, csm_paymodegroup,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency").toString();
        try {
            Connection conn = getConnection();
            stmt1 = conn.prepareStatement(SQL_trxDtl);
            CounterSalesOrderBean orderBean;
            for(rs1 = stmt1.executeQuery(); rs1.next(); rptBean.addTrxCollection(orderBean.getTrxDate(), orderBean)) {
                orderBean = new CounterSalesOrderBean();
                orderBean.parseBean(rs1);
                ArrayList paymentList = new ArrayList();
                stmt2 = conn.prepareStatement(SQL_paymentDtl);
                stmt2.setLong(1, orderBean.getSalesID().longValue());
                CounterSalesPaymentBean salesPaymentBean;
                for(rs2 = stmt2.executeQuery(); rs2.next(); paymentList.add(salesPaymentBean)) {
                    salesPaymentBean = new CounterSalesPaymentBean();
                    salesPaymentBean.parseBean(rs2);
                }
                
                if(paymentList.size() > 0)
                    orderBean.addPayment((CounterSalesPaymentBean[])paymentList.toArray(new CounterSalesPaymentBean[0]));
            }
            
            stmt3 = conn.prepareStatement(SQL_paymentGrp);
            CounterCollectionReportBean.PaymentOrderBean paymentTrxRpt;
            for(rs3 = stmt3.executeQuery(); rs3.next(); rptBean.addPaymentCollection(paymentTrxRpt.getDate(), paymentTrxRpt))
                // for(rs3 = stmt3.executeQuery(); rs3.next(); rptBean.addPaymentCollection2(paymentTrxRpt.getDate(), paymentTrxRpt))
            {
                // salesBean = new ProductSalesReportBean.ProductSalesBean(rptBean);
                // salesBean = rptBean.new ProductSalesBean();
                // paymentTrxRpt = new CounterCollectionReportBean.PaymentOrderBean(rptBean);
                paymentTrxRpt = rptBean.new PaymentOrderBean();
                paymentTrxRpt.setDate(rs3.getDate("cso_trxdate"));
                // paymentTrxRpt.setGabung(rs3.getString("gabung"));
                paymentTrxRpt.setPaymentCode(rs3.getString("csm_paymodecode"));
                paymentTrxRpt.setPaymentDesc(rs3.getString("csm_paymodedesc"));
                paymentTrxRpt.setPaymentCurrency(rs3.getString("csm_currency"));
                paymentTrxRpt.setPaymentRate(rs3.getDouble("csm_rate"));
                paymentTrxRpt.setCurrCount(rs3.getInt("CurrCount"));
                paymentTrxRpt.setPayCount(rs3.getInt("PayCount"));
                System.out.println("PaymentIn : "+ rs3.getDouble("PaymentIn") +" PaymentOut  " + rs3.getDouble("PaymentOut")+ " Currency "+ rs3.getString("csm_currency") + " Rate "+ rs3.getDouble("csm_rate") + " Currency Count "+ rs3.getString("CurrCount"));
                paymentTrxRpt.setPaymentIn(rs3.getDouble("PaymentIn"));
                paymentTrxRpt.setPaymentOut(rs3.getDouble("PaymentOut"));
            }
            
        }
        
        catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCollectionReport --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_527;
        Exception exception;
        exception;
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(rs1 != null)
            rs1.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        throw exception;
         */
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(rs1 != null)
            rs1.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        return rptBean;
    }
    
    protected ProductSalesReportBean getTrxProductSales(SQLConditionsBean conditions, String locale)
    throws Exception {
        ProductSalesReportBean rptBean;
        PreparedStatement stmt1;
        ResultSet rs1;
        String SQL_productSales;
        rptBean = new ProductSalesReportBean();
        stmt1 = null;
        rs1 = null;
        SQL_productSales = (new StringBuilder("select csi_productid, cso_trxdate, sum(if (csi_producttype = 0 and cso_status <> -10, csi_qty_order, 0)) as SAL_QTY, sum(if (csi_producttype = 1 and cso_status <> -10, csi_qty_order, 0)) as FOC_QTY, sum(if (csi_producttype = 0 and cso_status <> -10, csi_qty_order * csi_bv1, 0)) as SAL_BV, sum(if (csi_producttype = 0 and cso_status <> -10, csi_qty_order * csi_unit_price, 0)) as SAL_AMT, sum(if (csi_producttype = 0 and cso_status = -10, csi_qty_order, 0)) as VSAL_QTY, sum(if (csi_producttype = 1 and cso_status = -10, csi_qty_order, 0)) as VFOC_QTY, sum(if (csi_producttype = 0 and cso_status = -10, csi_qty_order * csi_bv1, 0)) as VSAL_BV, sum(if (csi_producttype = 0 and cso_status = -10, csi_qty_order * csi_unit_price, 0)) as VSAL_AMT from counter_sales_item inner join counter_sales_order on csi_salesid = cso_salesid inner join product_master on csi_productid = pmp_productid inner join product_category on pmp_catid = pcp_catid")).append(conditions.getConditions()).append(" group by cso_trxdate, csi_productid").append(" order by pcp_order_seq, pmp_skucode, cso_trxdate").toString();
        try {
            Connection conn = getConnection();
            stmt1 = conn.prepareStatement(SQL_productSales);
            ProductSalesReportBean.ProductSalesBean salesBean;
            String productID;
            for(rs1 = stmt1.executeQuery(); rs1.next(); rptBean.addSalesByDate(productID, salesBean.getDate(), salesBean)) {
                // StockMovementRptBean.StockInfo stockInfo = new StockMovementRptBean.StockInfo(report);
                // StockMovementRptBean.StockInfo stockInfo = report.new StockInfo();
                // Asal : salesBean = new ProductSalesReportBean.ProductSalesBean(rptBean);
                salesBean = rptBean.new ProductSalesBean();
                productID = String.valueOf(rs1.getInt("csi_productid"));
                salesBean.setProductID(productID);
                salesBean.setDate(rs1.getDate("cso_trxdate"));
                salesBean.setQtySalesIn(rs1.getInt("SAL_QTY"));
                salesBean.setQtyFocIn(rs1.getInt("FOC_QTY"));
                salesBean.setBvIn(rs1.getDouble("SAL_BV"));
                salesBean.setAmtIn(rs1.getDouble("SAL_AMT"));
                salesBean.setQtySalesOut(rs1.getInt("VSAL_QTY"));
                salesBean.setQtyFocOut(rs1.getInt("VFOC_QTY"));
                salesBean.setBvOut(rs1.getDouble("VSAL_BV"));
                salesBean.setAmtOut(rs1.getDouble("VSAL_AMT"));
            }
            
            String productIDList[] = rptBean.getSalesProductIDList();
            if(productIDList != null && productIDList.length > 0) {
                ProductManager prdtMgr = new ProductManager(conn);
                rptBean.setProductList(prdtMgr.getProductList(productIDList, locale));
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getTrxProductSales --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_379;
        Exception exception;
        exception;
        if(stmt1 != null)
            stmt1.close();
        if(rs1 != null)
            rs1.close();
        throw exception;
         */
        if(stmt1 != null)
            stmt1.close();
        if(rs1 != null)
            rs1.close();
        return rptBean;
    }
    
    protected ProductSalesReportBean getBonusProductSales(SQLConditionsBean conditions, String locale)
    throws Exception {
        ProductSalesReportBean rptBean;
        PreparedStatement stmt1;
        ResultSet rs1;
        String SQL_productSales;
        rptBean = new ProductSalesReportBean();
        stmt1 = null;
        rs1 = null;
        SQL_productSales = (new StringBuilder("select distinct piu_productid, pou_bonusperiodid, sum(piu_qty_order) as SAL_QTY, sum(piu_qty_order * piu_bv1) as SAL_BV, sum(piu_qty_order * piu_unit_price) as SAL_AMT, from purchase_item inner join purchase_order on piu_purchaseid = pou_purchaseid inner join product_master on piu_productid = pmp_productid inner join product_category on pmp_catid = pcp_catid")).append(conditions.getConditions()).append(" group by pou_bonusperiodid, piu_productid").append(" order by pcp_order_seq, pmp_skucode, pou_bonusperiodid").toString();
        try {
            Connection conn = getConnection();
            stmt1 = conn.prepareStatement(SQL_productSales);
            ProductSalesReportBean.ProductSalesBean salesBean;
            String productID;
            for(rs1 = stmt1.executeQuery(); rs1.next(); rptBean.addSalesByPeriod(productID, salesBean.getPeriodID(), salesBean)) {
                // paymentTrxRpt = rptBean.new PaymentOrderBean();
                salesBean = rptBean.new ProductSalesBean();
                productID = String.valueOf(rs1.getInt("piu_productid"));
                salesBean.setProductID(productID);
                salesBean.setPeriodID(rs1.getString("pou_bonusperiodid"));
                salesBean.setQtySalesIn(rs1.getInt("SAL_QTY"));
                salesBean.setBvIn(rs1.getDouble("SAL_BV"));
                salesBean.setAmtIn(rs1.getDouble("SAL_AMT"));
            }
            
            String productIDList[] = rptBean.getSalesProductIDList();
            if(productIDList != null && productIDList.length > 0) {
                ProductManager prdtMgr = new ProductManager(conn);
                rptBean.setProductList(prdtMgr.getProductList(productIDList, locale));
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getBonusProductSales --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_305;
        Exception exception;
        exception;
        if(stmt1 != null)
            stmt1.close();
        if(rs1 != null)
            rs1.close();
        throw exception;
         */
        if(stmt1 != null)
            stmt1.close();
        if(rs1 != null)
            rs1.close();
        return rptBean;
    }
    
    protected ProductKivReportBean getProductKivList(String shipByOutletID, String locale)
    throws Exception {
        ProductKivReportBean rptBean;
        PreparedStatement stmt1;
        PreparedStatement stmt2;
        ResultSet rs1;
        ResultSet rs2;
        String SQL_productKiv;
        String SQL_backOrder;
        rptBean = new ProductKivReportBean();
        stmt1 = null;
        stmt2 = null;
        rs1 = null;
        rs2 = null;
        SQL_productKiv = "select csp_productid, pmp_productcode, pmp_skucode, pmp_selling, pmp_default_name, pdp_name, sum(csp_qty_kiv) as kiv from counter_sales_order inner join counter_sales_item on cso_salesid = csi_salesid inner join counter_sales_product on csi_seq = csp_csiseq inner join product_master on csp_productid = pmp_productid inner join product_desc on pmp_productid = pdp_productid and pdp_locale = ? where csp_qty_kiv > 0 and cso_ship_by_outletid = ? and cso_status = ? group by csp_productid order by pmp_productcode";
        SQL_backOrder = "select counter_sales_order.*, sum(csp_qty_kiv) as kiv from counter_sales_order inner join counter_sales_item on cso_salesid = csi_salesid inner join counter_sales_product on csi_seq = csp_csiseq where csp_qty_kiv > 0 and cso_ship_by_outletid = ? and cso_status = ? and csp_productid = ? group by cso_trxdocno order by cso_trxdocno";
        try {
            Connection conn = getConnection();
            InventoryManager_1 invMgr = new InventoryManager_1(conn);
            int cnt = 0;
            stmt1 = conn.prepareStatement(SQL_productKiv);
            stmt1.setString(++cnt, locale);
            stmt1.setString(++cnt, shipByOutletID);
            stmt1.setInt(++cnt, 30);
            
            for(rs1 = stmt1.executeQuery(); rs1.next();) {
                // paymentTrxRpt = rptBean.new PaymentOrderBean();
                ProductKivReportBean.ProductKivBean kivBean = rptBean.new ProductKivBean();
                int productID = rs1.getInt("csp_productid");
                int balance = invMgr.getProductBalance(productID, shipByOutletID, null);
                String name = rs1.getString("pdp_name");
                if(name == null || name != null && name.length() <= 0)
                    name = rs1.getString("pmp_default_name");
                kivBean.setQtyOnHand(balance);
                kivBean.setProductID(String.valueOf(productID));
                kivBean.setProductName(name);
                kivBean.setProductCode(rs1.getString("pmp_productcode"));
                kivBean.setSkuCode(rs1.getString("pmp_skucode"));
                kivBean.setProductType(rs1.getString("pmp_selling"));
                
                kivBean.setQtyKiv(rs1.getInt("kiv"));
                rptBean.addProductKiv(kivBean);
                int subCnt = 0;
                stmt2 = conn.prepareStatement(SQL_backOrder);
                stmt2.setString(++subCnt, shipByOutletID);
                stmt2.setInt(++subCnt, 30);
                stmt2.setLong(++subCnt, productID);
                ProductKivReportBean.BackOrderBean boBean;
                for(rs2 = stmt2.executeQuery(); rs2.next(); rptBean.addBackOrder(String.valueOf(productID), boBean)) {
                    // paymentTrxRpt = rptBean.new PaymentOrderBean();
                    boBean = rptBean.new BackOrderBean();
                    CounterSalesOrderBean sales = new CounterSalesOrderBean();
                    sales.parseBean(rs2);
                    boBean.setCounterSalesOrderBean(sales);
                    boBean.setQtyKiv(rs2.getInt("kiv"));
                }
                
                System.out.println("Query getProductKivList 2 "+rs2.getStatement().toString());
                
            }
            
            System.out.println("Query getProductKivList 1 "+rs1.getStatement().toString());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getProductKivList --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_497;
        Exception exception;
        exception;
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs1 != null)
            rs1.close();
        if(rs2 != null)
            rs2.close();
        throw exception;
         */
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs1 != null)
            rs1.close();
        if(rs2 != null)
            rs2.close();
        return rptBean;
    }
    
    protected ProductKivReportBean getProductKivListLoan(String shipByOutletID, String locale)
    throws Exception {
        ProductKivReportBean rptBean;
        PreparedStatement stmt1;
        PreparedStatement stmt2;
        ResultSet rs1;
        ResultSet rs2;
        String SQL_productKiv;
        String SQL_backOrder;
        rptBean = new ProductKivReportBean();
        stmt1 = null;
        stmt2 = null;
        rs1 = null;
        rs2 = null;
        SQL_productKiv = " select piv_productid, pmp_productcode, pmp_skucode, pmp_selling, pmp_default_name, pdp_name, sum(piv_out)- sum(piv_in) as kiv "+
                "from product_inventory "+
                "inner join product_master on piv_productid = pmp_productid "+
                "inner join product_desc on pmp_productid = pdp_productid and pdp_locale = ? "+
                "where piv_owner = ? and piv_status = ? "+
                "and piv_trxtype IN  ('SKLI', 'SKLO') "+
                "group by piv_productid "+
                "order by pmp_productcode ";
        
        SQL_backOrder = "select product_inventory.*,  sum(piv_out)- sum(piv_in) as kiv  "+
                "from product_inventory "+
                "inner join product_master on piv_productid = pmp_productid "+
                "inner join product_desc on pmp_productid = pdp_productid and pdp_locale = ? "+
                "where piv_owner = ? and piv_status = ? and piv_productid= ? "+
                "and piv_trxtype IN  ('SKLI', 'SKLO') "+
                "group by piv_target, piv_productid "+
                "order by piv_target, piv_trxdocno, piv_productid ";
        
        try {
            Connection conn = getConnection();
            InventoryManager_1 invMgr = new InventoryManager_1(conn);
            int cnt = 0;
            stmt1 = conn.prepareStatement(SQL_productKiv);
            stmt1.setString(++cnt, locale);
            stmt1.setString(++cnt, shipByOutletID);
            stmt1.setInt(++cnt, 100);
            
            for(rs1 = stmt1.executeQuery(); rs1.next();) {
                ProductKivReportBean.ProductKivBean kivBean = rptBean.new ProductKivBean();
                int productID = rs1.getInt("piv_productid");
                int balance = invMgr.getProductBalance(productID, shipByOutletID, null);
                String name = rs1.getString("pdp_name");
                if(name == null || name != null && name.length() <= 0)
                    name = rs1.getString("pmp_default_name");
                kivBean.setQtyOnHand(balance);
                kivBean.setProductID(String.valueOf(productID));
                kivBean.setProductName(name);
                kivBean.setProductCode(rs1.getString("pmp_productcode"));
                kivBean.setSkuCode(rs1.getString("pmp_skucode"));
                kivBean.setProductType(rs1.getString("pmp_selling"));
                kivBean.setQtyKiv(rs1.getInt("kiv"));
                rptBean.addProductKiv(kivBean);
                int subCnt = 0;
                stmt2 = conn.prepareStatement(SQL_backOrder);
                stmt2.setString(++subCnt, locale);
                stmt2.setString(++subCnt, shipByOutletID);
                stmt2.setInt(++subCnt, 100);
                stmt2.setLong(++subCnt, productID);
                
                ProductKivReportBean.BackOrderBean boBean;
                for(rs2 = stmt2.executeQuery(); rs2.next(); rptBean.addBackOrder(String.valueOf(productID), boBean)) {
                    boBean = rptBean.new BackOrderBean();
                    CounterSalesOrderBean bean = new CounterSalesOrderBean();
                    bean.setTrxDate(rs2.getDate("piv_trxdate"));
                    bean.setTrxDocNo(rs2.getString("piv_trxdocno"));
                    bean.setCustomerID(rs2.getString("piv_target"));
                    bean.setCustomerName(rs2.getString("piv_target_remark"));
                    
                    boBean.setCounterSalesOrderBean(bean);
                    boBean.setQtyKiv(rs2.getInt("kiv"));
                }
                
                // System.out.println("Query getProductKivList Loan 2 "+rs2.getStatement().toString());
                
            }
            
            // System.out.println("Query getProductKivList Loan 1 "+rs1.getStatement().toString());
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getProductKivList Loan --> ")).append(e.toString()).toString());
        }
        
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs1 != null)
            rs1.close();
        if(rs2 != null)
            rs2.close();
        return rptBean;
    }
    
    
    protected ArrayList getMemberProductSalesList(String month, String year, Date trxDate, int salesType)
    throws MvcException, SQLException {
        ArrayList list;
        HashMap salesMap;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        PreparedStatement stmt3;
        PreparedStatement stmt4;
        ResultSet rs;
        ResultSet rs2;
        ResultSet rs3;
        ResultSet rs4;
        String SQL_payment;
        String SQL_changeDue;
        String SQL_discountAmt;
        String SQL_deliveryAmt;
        String SQL_sales;
        list = new ArrayList();
        salesMap = new HashMap();
        stmt = null;
        stmt2 = null;
        stmt3 = null;
        stmt4 = null;
        // PreparedStatement stmt5 = null;
        // stmt5 = null;
        rs = null;
        rs2 = null;
        rs3 = null;
        rs4 = null;
        // ResultSet rs5 = null;
        SQL_payment = "";
        String SQL_payment_typeI = " select cso_custid, csm_paymodecode,  sum(if (csm_amt != 0, 1, 0)) as PayCount,  sum(if (csm_status <> -10, csm_amt, 0)) as PaymentIn,  sum(if (csm_status = -10, csm_amt, 0)) as PaymentOut  from counter_sales_payment  inner join counter_sales_order on csm_salesid = cso_salesid  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null  group by cso_custid, csm_paymodecode order by cso_custid, csm_paymodecode ";
        String SQL_payment_typeII = " select cso_custid, 'CSH' as csm_paymodecode,  sum(if (cso_trxgroup = 10, cso_sales_chi_amt, 0)) as PaymentIn,  sum(if (cso_trxgroup <> 10, cso_sales_chi_amt, 0)) as PaymentOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null  group by cso_custid order by cso_custid";
        String SQL_payment_typeIII = " select cso_custid, 'CSH' as csm_paymodecode,  sum(if (cso_trxgroup = 10, cso_sales_corp_amt , 0)) as PaymentIn,  sum(if (cso_trxgroup <> 10, cso_sales_corp_amt , 0)) as PaymentOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null  group by cso_custid order by cso_custid";
        SQL_changeDue = "select cso_custid,  sum(if (cso_trxgroup = 10, cso_payment_change, 0)) as PaymentChangeIn,  sum(if (cso_trxgroup <> 10, cso_payment_change, 0)) as PaymentChangeOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null group by cso_custid having (PaymentChangeIn - PaymentChangeOut) > 0";
        SQL_discountAmt = "select cso_custid,  sum(if (cso_trxgroup = 10, cso_discount_amt, 0)) as DiscountIn,  sum(if (cso_trxgroup <> 10, cso_discount_amt, 0)) as DiscountOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null group by cso_custid having (DiscountIn - DiscountOut) <> 0";
        SQL_deliveryAmt = "select cso_custid,  sum(if (cso_trxgroup = 10, cso_delivery_amt, 0)) as DeliveryIn,  sum(if (cso_trxgroup <> 10, cso_delivery_amt, 0)) as DeliveryOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is not null group by cso_custid having (DeliveryIn - DeliveryOut) > 0";
        String unitPriceColName = "";
        if(salesType == 1) {
            unitPriceColName = "csi_unit_price";
            SQL_payment = SQL_payment_typeI;
        } else
            if(salesType == 2) {
            unitPriceColName = "csi_unit_price_chi";
            SQL_payment = SQL_payment_typeII;
            } else
                if(salesType == 3) {
            unitPriceColName = "csi_unit_price_corp";
            SQL_payment = SQL_payment_typeIII;
                }
        SQL_sales = (new StringBuilder(" select cso_custid, csi_productid, pmp_productid, pmp_skucode, ")).append(unitPriceColName).append(" as UnitPrice, ").append(" sum(if (cso_trxgroup = 10, csi_qty_order, 0)) as QtyIn, ").append(" sum(if (cso_trxgroup <> 10, csi_qty_order, 0)) as QtyOut ").append(" from counter_sales_item ").append(" inner join counter_sales_order on csi_salesid = cso_salesid ").append(" inner join product_master on csi_productid = pmp_productid ").append(" where month(cso_trxdate) = ? and year(cso_trxdate) = ? ").append(" and cso_seller_typestatus = 'O' and cso_custid is not null ").append(" group by cso_custid, csi_productid, ").append(unitPriceColName).append(" order by cso_custid, csi_productid, ").append(unitPriceColName).toString();
        try {
            stmt = getConnection().prepareStatement(SQL_sales);
            stmt.setString(1, month);
            stmt.setString(2, year);
            for(rs = stmt.executeQuery(); rs.next();) {
                int qty = rs.getInt("QtyIn") - rs.getInt("QtyOut");
                double unitPrice = rs.getDouble("UnitPrice");
                if(qty > 0 && unitPrice > 0.0D) {
                    String custID = rs.getString("cso_custid");
                    SalesSummaryBean salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                        salesMap.put(custID, salesBean);
                    }
                    CounterSalesItemBean itemBean = new CounterSalesItemBean();
                    itemBean.setSkucode(rs.getString("pmp_skucode"));
                    itemBean.setQtyOrder(qty);
                    itemBean.setUnitPrice(unitPrice);
                    salesBean.addItem(itemBean);
                }
            }
            
            stmt2 = getConnection().prepareStatement(SQL_payment);
            stmt2.setString(1, month);
            stmt2.setString(2, year);
            for(rs2 = stmt2.executeQuery(); rs2.next();) {
                double payment = rs2.getDouble("PaymentIn") - rs2.getDouble("PaymentOut");
                if(payment > 0.0D) {
                    String custID = rs2.getString("cso_custid");
                    String paymodeCode = rs2.getString("csm_paymodecode");
                    SalesSummaryBean salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    double paymode[] = salesBean.getPaymentList();
                    if(paymodeCode.equals("CSH"))
                        paymode[0] = payment;
                    else
                        if(paymodeCode.equals("CHQ"))
                            paymode[1] = payment;
                        else
                            if(paymodeCode.equals("OTH"))
                                paymode[2] = payment;
                            else
                                if(paymodeCode.equals("MCR"))
                                    paymode[3] = payment;
                                else
                                    if(paymodeCode.equals("VCR"))
                                        paymode[4] = payment;
                                    else
                                        paymode[5] = payment;
                    salesBean.setPaymentList(paymode);
                    salesMap.put(salesBean.getMemberID(), salesBean);
                }
            }
            
            if(salesType == 1) {
                stmt3 = getConnection().prepareStatement(SQL_changeDue);
                stmt3.setString(1, month);
                stmt3.setString(2, year);
                double changeDueAmt;
                SalesSummaryBean salesBean;
                for(rs3 = stmt3.executeQuery(); rs3.next(); salesBean.setChangeDueAmt(changeDueAmt)) {
                    String custID = rs3.getString("cso_custid");
                    changeDueAmt = rs3.getDouble("PaymentChangeIn") - rs3.getDouble("PaymentChangeOut");
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                }
                
            }
            if(salesType != 3) {
                stmt4 = getConnection().prepareStatement(SQL_discountAmt);
                stmt4.setString(1, month);
                stmt4.setString(2, year);
                SalesSummaryBean salesBean;
                for(rs4 = stmt4.executeQuery(); rs4.next(); salesMap.put(salesBean.getMemberID(), salesBean)) {
                    String custID = rs4.getString("cso_custid");
                    double discount = rs4.getDouble("DiscountIn") - rs4.getDouble("DiscountOut");
                    double discountAmt = -discount;
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    salesBean.setDiscountAmt(discountAmt);
                }
                
                PreparedStatement stmt5 = getConnection().prepareStatement(SQL_deliveryAmt);
                stmt5.setString(1, month);
                stmt5.setString(2, year);
                // SalesSummaryBean salesBean;
                for(ResultSet rs5 = stmt5.executeQuery(); rs5.next(); salesMap.put(salesBean.getMemberID(), salesBean)) {
                    String custID = rs5.getString("cso_custid");
                    double deliveryAmt = rs5.getDouble("DeliveryIn") - rs5.getDouble("DeliveryOut");
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    salesBean.setDeliveryAmt(deliveryAmt);
                }
                
            }
            Set mapSize = salesMap.keySet();
            SalesSummaryBean bean;
            for(Iterator i = mapSize.iterator(); i.hasNext(); list.add(bean)) {
                String key = (String)i.next();
                bean = (SalesSummaryBean)salesMap.get(key);
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in performing getMemberProductSalesList --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_1418;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(stmt4 != null)
            stmt4.close();
        if(rs != null)
            rs.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        if(rs4 != null)
            rs4.close();
        throw exception;
         */
        if(stmt != null)
            stmt.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(stmt4 != null)
            stmt4.close();
        if(rs != null)
            rs.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        if(rs4 != null)
            rs4.close();
        return list;
    }
    
    protected ArrayList getNonMemberProductSalesList(String month, String year, Date trxDate, int salesType)
    throws MvcException, SQLException {
        ArrayList list;
        HashMap salesMap;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        PreparedStatement stmt3;
        ResultSet rs;
        ResultSet rs2;
        ResultSet rs3;
        String SQL_payment;
        String SQL_changeDue;
        String SQL_discountAmt;
        String SQL_deliveryAmt;
        String SQL_sales;
        list = new ArrayList();
        salesMap = new HashMap();
        stmt = null;
        stmt2 = null;
        stmt3 = null;
        // PreparedStatement stmt4 = null;
        // PreparedStatement stmt5 = null;
        rs = null;
        rs2 = null;
        rs3 = null;
        // ResultSet rs4 = null;
        // ResultSet rs5 = null;
        SQL_payment = "";
        String SQL_payment_typeI = " select cso_trxtype, csm_paymodecode,  sum(if (csm_amt != 0, 1, 0)) as PayCount,  sum(if (csm_status <> -10, csm_amt, 0)) as PaymentIn,  sum(if (csm_status = -10, csm_amt, 0)) as PaymentOut,  sum(if (cso_trxgroup = 10, cso_payment_change, 0)) as PaymentChangeIn,  sum(if (cso_trxgroup <> 10, cso_payment_change, 0)) as PaymentChangeOut  from counter_sales_payment  inner join counter_sales_order on csm_salesid = cso_salesid  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype, csm_paymodecode order by cso_trxtype ";
        String SQL_payment_typeII = " select cso_trxtype, 'CSH' as csm_paymodecode,  sum(if (cso_trxgroup = 10, cso_sales_chi_amt, 0)) as PaymentIn,  sum(if (cso_trxgroup <> 10, cso_sales_chi_amt, 0)) as PaymentOut,  0 as PaymentChangeIn, 0 as PaymentChangeOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype, csm_paymodecode order by cso_trxtype";
        String SQL_payment_typeIII = " select cso_trxtype, 'CSH' as csm_paymodecode,  sum(if (cso_trxgroup = 10, cso_sales_corp_amt , 0)) as PaymentIn,  sum(if (cso_trxgroup <> 10, cso_sales_corp_amt , 0)) as PaymentOut,  0 as PaymentChangeIn, 0 as PaymentChangeOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype, csm_paymodecode order by cso_trxtype";
        SQL_changeDue = "select cso_trxtype,  sum(if (cso_trxgroup = 10, cso_payment_change, 0)) as PaymentChangeIn,  sum(if (cso_trxgroup <> 10, cso_payment_change, 0)) as PaymentChangeOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype having (PaymentChangeIn - PaymentChangeOut) > 0";
        SQL_discountAmt = "select cso_custid,  sum(if (cso_trxgroup = 10, cso_discount_amt, 0)) as DiscountIn,  sum(if (cso_trxgroup <> 10, cso_discount_amt, 0)) as DiscountOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype having (DiscountIn - DiscountOut) <> 0";
        SQL_deliveryAmt = "select cso_custid,  sum(if (cso_trxgroup = 10, cso_delivery_amt, 0)) as DeliveryIn,  sum(if (cso_trxgroup <> 10, cso_delivery_amt, 0)) as DeliveryOut  from counter_sales_order  where month(cso_trxdate) = ? and year(cso_trxdate) = ?  and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS')  group by cso_trxtype having (DeliveryIn - DeliveryOut) > 0";
        String unitPriceColName = "";
        if(salesType == 1) {
            unitPriceColName = "csi_unit_price";
            SQL_payment = SQL_payment_typeI;
        } else
            if(salesType == 2) {
            unitPriceColName = "csi_unit_price_chi";
            SQL_payment = SQL_payment_typeII;
            } else
                if(salesType == 3) {
            unitPriceColName = "csi_unit_price_corp";
            SQL_payment = SQL_payment_typeIII;
                }
        SQL_sales = (new StringBuilder(" select cso_trxtype, csi_productid, pmp_skucode, ")).append(unitPriceColName).append(" as UnitPrice, ").append(" sum(if (cso_trxgroup = 10, csi_qty_order, 0)) as QtyIn, ").append(" sum(if (cso_trxgroup <> 10, csi_qty_order, 0)) as QtyOut ").append(" from counter_sales_item ").append(" inner join counter_sales_order on csi_salesid = cso_salesid ").append(" inner join product_master on csi_productid = pmp_productid ").append(" where month(cso_trxdate) = ? and year(cso_trxdate) = ? ").append(" and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS') ").append(" group by cso_trxtype, csi_productid, ").append(unitPriceColName).append(" order by cso_trxtype, csi_productid, ").append(unitPriceColName).toString();
        try {
            stmt = getConnection().prepareStatement(SQL_sales);
            stmt.setString(1, month);
            stmt.setString(2, year);
            for(rs = stmt.executeQuery(); rs.next();) {
                int qty = rs.getInt("QtyIn") - rs.getInt("QtyOut");
                double unitPrice = rs.getDouble("UnitPrice");
                if(qty > 0 && unitPrice > 0.0D) {
                    String custID = null;
                    String trxType = rs.getString("cso_trxtype");
                    if(trxType.equals("WS"))
                        custID = "SFP";
                    else
                        custID = "WIC";
                    SalesSummaryBean salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                        salesMap.put(custID, salesBean);
                    }
                    CounterSalesItemBean itemBean = new CounterSalesItemBean();
                    itemBean.setSkucode(rs.getString("pmp_skucode"));
                    itemBean.setQtyOrder(qty);
                    itemBean.setUnitPrice(unitPrice);
                    salesBean.addItem(itemBean);
                }
            }
            
            stmt2 = getConnection().prepareStatement(SQL_payment);
            stmt2.setString(1, month);
            stmt2.setString(2, year);
            for(rs2 = stmt2.executeQuery(); rs2.next();) {
                double payment = rs2.getDouble("PaymentIn") - rs2.getDouble("PaymentOut");
                if(payment > 0.0D) {
                    String custID = null;
                    String trxType = rs2.getString("cso_trxtype");
                    if(trxType.equals("WS"))
                        custID = "SFP";
                    else
                        custID = "WIC";
                    String paymodeCode = rs2.getString("csm_paymodecode");
                    SalesSummaryBean salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    double paymode[] = salesBean.getPaymentList();
                    if(paymodeCode.equals("CSH"))
                        paymode[0] = payment;
                    else
                        if(paymodeCode.equals("CHQ"))
                            paymode[1] = payment;
                        else
                            if(paymodeCode.equals("OTH"))
                                paymode[2] = payment;
                            else
                                if(paymodeCode.equals("MCR"))
                                    paymode[3] = payment;
                                else
                                    if(paymodeCode.equals("VCR"))
                                        paymode[4] = payment;
                                    else
                                        paymode[5] = payment;
                    salesBean.setPaymentList(paymode);
                    salesMap.put(salesBean.getMemberID(), salesBean);
                }
            }
            
            if(salesType == 1) {
                stmt3 = getConnection().prepareStatement(SQL_changeDue);
                stmt3.setString(1, month);
                stmt3.setString(2, year);
                double changeDueAmt;
                SalesSummaryBean salesBean;
                for(rs3 = stmt3.executeQuery(); rs3.next(); salesBean.setChangeDueAmt(changeDueAmt)) {
                    String custID = null;
                    String trxType = rs3.getString("cso_trxtype");
                    if(trxType.equals("WS"))
                        custID = "SFP";
                    else
                        custID = "WIC";
                    changeDueAmt = rs3.getDouble("PaymentChangeIn") - rs3.getDouble("PaymentChangeOut");
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                }
                
            }
            if(salesType != 3) {
                PreparedStatement stmt4 = getConnection().prepareStatement(SQL_discountAmt);
                stmt4.setString(1, month);
                stmt4.setString(2, year);
                SalesSummaryBean salesBean;
                for(ResultSet rs4 = stmt4.executeQuery(); rs4.next(); salesMap.put(salesBean.getMemberID(), salesBean)) {
                    String custID = rs4.getString("cso_custid");
                    double discount = rs4.getDouble("DiscountIn") - rs4.getDouble("DiscountOut");
                    double discountAmt = -discount;
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    salesBean.setDiscountAmt(discountAmt);
                }
                
                PreparedStatement stmt5 = getConnection().prepareStatement(SQL_deliveryAmt);
                stmt5.setString(1, month);
                stmt5.setString(2, year);
                // SalesSummaryBean salesBean;
                for(ResultSet rs5 = stmt5.executeQuery(); rs5.next(); salesMap.put(salesBean.getMemberID(), salesBean)) {
                    String custID = rs5.getString("cso_custid");
                    double deliveryAmt = rs5.getDouble("DeliveryIn") - rs5.getDouble("DeliveryOut");
                    salesBean = null;
                    if(salesMap.containsKey(custID)) {
                        salesBean = (SalesSummaryBean)salesMap.get(custID);
                    } else {
                        salesBean = new SalesSummaryBean();
                        salesBean.setTrxDate(trxDate);
                        salesBean.setMemberID(custID);
                    }
                    salesBean.setDeliveryAmt(deliveryAmt);
                }
                
            }
            Set mapSize = salesMap.keySet();
            SalesSummaryBean bean;
            for(Iterator i = mapSize.iterator(); i.hasNext(); list.add(bean)) {
                String key = (String)i.next();
                bean = (SalesSummaryBean)salesMap.get(key);
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in performing getNonMemberProductSalesList --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_1475;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(rs != null)
            rs.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        throw exception;
         */
        if(stmt != null)
            stmt.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        if(rs != null)
            rs.close();
        if(rs2 != null)
            rs2.close();
        if(rs3 != null)
            rs3.close();
        return list;
    }
    
    protected int getTotalMemberProductSales(String month, String year, int salesType)
    throws MvcException, SQLException {
        int result;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        result = 0;
        stmt = null;
        rs = null;
        String unitPriceColName = "";
        if(salesType == 1)
            unitPriceColName = "csi_unit_price";
        else
            if(salesType == 2)
                unitPriceColName = "csi_unit_price_chi";
            else
                if(salesType == 3)
                    unitPriceColName = "csi_unit_price_corp";
        SQL = (new StringBuilder(" select ")).append(unitPriceColName).append(" as UnitPrice, ").append(" sum(if (cso_trxgroup = 10, csi_qty_order, 0)) as QtyIn, ").append(" sum(if (cso_trxgroup <> 10, csi_qty_order, 0)) as QtyOut ").append(" from counter_sales_item ").append(" inner join counter_sales_order on csi_salesid = cso_salesid ").append(" inner join product_master on csi_productid = pmp_productid ").append(" where month(cso_trxdate) = ? and year(cso_trxdate) = ? ").append(" and cso_seller_typestatus = 'O' and cso_custid is not null ").append(" group by cso_custid, csi_productid, csi_unit_price ").append(" having (QtyIn - QtyOut) > 0").toString();
        try {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, month);
            stmt.setString(2, year);
            rs = stmt.executeQuery();
            int count = 0;
            while(rs.next()) {
                double unitPrice = rs.getDouble("UnitPrice");
                if(unitPrice > 0.0D)
                    result++;
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in getTotalMemberProductSales --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_276;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
         */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return result;
    }
    
    protected int getTotalNonMemberProductSales(String month, String year, int salesType)
    throws MvcException, SQLException {
        int result;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        result = 0;
        stmt = null;
        rs = null;
        String unitPriceColName = "";
        if(salesType == 1)
            unitPriceColName = "csi_unit_price";
        else
            if(salesType == 2)
                unitPriceColName = "csi_unit_price_chi";
            else
                if(salesType == 3)
                    unitPriceColName = "csi_unit_price_corp";
        SQL = (new StringBuilder(" select ")).append(unitPriceColName).append(" as UnitPrice, ").append(" sum(if (cso_trxgroup = 10, csi_qty_order, 0)) as QtyIn, ").append(" sum(if (cso_trxgroup <> 10, csi_qty_order, 0)) as QtyOut ").append(" from counter_sales_item ").append(" inner join counter_sales_order on csi_salesid = cso_salesid ").append(" inner join product_master on csi_productid = pmp_productid ").append(" where month(cso_trxdate) = ? and year(cso_trxdate) = ? ").append(" and cso_seller_typestatus = 'O' and cso_custid is null and cso_trxtype in ('NS', 'WS') ").append(" group by cso_trxtype, csi_productid, csi_unit_price ").append(" having (QtyIn - QtyOut) > 0").toString();
        try {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, month);
            stmt.setString(2, year);
            rs = stmt.executeQuery();
            int count = 0;
            while(rs.next()) {
                double unitPrice = rs.getDouble("UnitPrice");
                if(unitPrice > 0.0D)
                    result++;
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in getTotalNonMemberProductSales --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return result;
    }

}
