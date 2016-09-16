// Decompiled by Yody
// File : CounterSalesBroker.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.orca.bean.AddressBean;
import com.ecosmosis.orca.member.MemberBean;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesOrderBean, CounterSalesManager, CounterSalesItemBean, CounterSalesProductBean, 
//            CounterSalesFormBean, CounterSalesPaymentBean, DeliveryOrderBean, DeliveryItemBean, 
//            DeliveryProductBean

public class CounterSalesBroker extends DBTransactionBroker
{

    protected CounterSalesBroker(Connection con)
    {
        super(con);
    }

    //summary sales report 1 Agustus 2012
    protected ArrayList getSummarySalesReport(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        String SQL2;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select cso.cso_bonus_earnername as csi_unit_sales, pcd.pcd_desc as csi_inventory, count(csi.csi_qty_order)as csi_qty_order, " +
                " SUM(csi.csi_unit_price) as csi_unit_price,  SUM(csi.csi_unit_discount) as csi_unit_discount, " +
                "SUM(csi.csi_unit_netprice) as csi_unit_netprice, csi.* " +
                "from counter_sales_item csi, counter_sales_order cso, product_category_desc pcd, product_master pm" +
                " where cso.cso_salesid = csi.csi_salesid AND " +
                "csi.csi_productid = pm.pmp_productid AND " +
                "pm.pmp_catid = pcd.pcd_catid ")).append(conditions.getConditions()).append(" group by cso.cso_bonus_earnername, pcd.pcd_desc ").append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesItemBean item;
            for(rs = stmt.executeQuery();rs.next();list.add(item)){
                item = new CounterSalesItemBean();
                item.parseBean(rs);
            }
            
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    protected ArrayList getSummarySalesReportDetail(SQLConditionsBean conditions)
    throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT pm.pmp_productcode as csi_unit_sales, cso.cso_bonus_earnername,pc.pcp_default_msg as csi_inventory,cso.cso_trxdate, csi.* " +
                                 "from product_master pm, counter_sales_item csi, counter_sales_order cso, product_category pc  " +
                                 "WHERE cso.cso_salesid = csi.csi_salesid  " +
                                 "AND pm.pmp_productid = csi.csi_productid " +
                                 "AND pm.pmp_catid = pc.pcp_catid")).append(conditions.getConditions()).append(" order by cso.cso_bonus_earnername, pc.pcp_default_msg, pm.pmp_productcode").append(conditions.getLimitConditions()).toString(); 
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesItemBean item;
            for(rs = stmt.executeQuery();rs.next();list.add(item)){
                item = new CounterSalesItemBean();
                item.parseBean(rs);
            }
            
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSummarySalesReturnReportByBrandDetail(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT  pcd.pcd_desc as cso_ship_by_expedition, pm.pmp_producttype as cso_ship_receiver, pm.pmp_productseries as cso_ship_cityid ," +
                " csi.csi_skuname as cso_ship_by_storecode,cso.cso_trxdocno as cso_trxdocno, csi.csi_skucode as cso_ship_stateid, " +
                " SUM(csi.csi_qty_order) as cso_ship_option, SUM(csi.csi_unit_price) as cso_oth_amt3," +
                " SUM(csi.csi_unit_discount) as cso_oth_amt4, SUM(csi.csi_unit_netprice) as cso_oth_amt5, cso.* " +
                " FROM product_category_desc pcd, product_master pm, counter_sales_order cso, counter_sales_item csi" +
                " WHERE cso.cso_salesid = csi.csi_salesid AND csi.csi_catid = pcd.pcd_catid AND " +
                " csi.csi_productid = pm.pmp_productid AND " +
                " pm.pmp_catid = csi.csi_catid ")).append(conditions.getConditions()).append(" group by pcd.pcd_desc, pm.pmp_producttype,pm.pmp_productseries, csi.csi_skuname, cso.cso_trxdocno ").append( "order by pcd.pcd_desc, pm.pmp_producttype,pm.pmp_productseries, csi.csi_skuname, cso.cso_trxdocno" ).append(conditions.getLimitConditions()).toString();
																									
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesOrderBean order;
            for(rs = stmt.executeQuery();rs.next();list.add(order)){
                order = new CounterSalesOrderBean();
                order.parseBean(rs);
            }
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSummarySalesReturnReportByBrand(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT  pcd.pcd_desc as csi_inventory, pm.pmp_producttype as csi_unit_sales,cso.cso_trxdocno as csi_skucode,  pm.pmp_productseries as csi_skuname," +
                " SUM(csi.csi_qty_order) as csi_qty_order, SUM(csi.csi_unit_price) as csi_unit_price," +
                " SUM(csi.csi_unit_discount) as csi_unit_discount, SUM(csi.csi_unit_netprice) as csi_unit_netprice, csi.* " +
                " FROM product_category_desc pcd, product_master pm, counter_sales_order cso, counter_sales_item csi " +
                " WHERE cso.cso_salesid = csi.csi_salesid AND csi.csi_catid = pcd.pcd_catid AND " +
                " csi.csi_productid = pm.pmp_productid AND " +
                " pm.pmp_catid = csi.csi_catid ")).append(conditions.getConditions()).append(conditions.getGroupby()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
																									
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesItemBean payment;
            for(rs = stmt.executeQuery();rs.next();list.add(payment)){
                payment = new CounterSalesItemBean();
                payment.parseBean(rs);
            }
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSummarySalesReportBrandCategoryDetail(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT  pcd.pcd_desc as cso_ship_by_expedition, pm.pmp_producttype as cso_ship_receiver, pm.pmp_productseries as cso_ship_cityid ," +
                " csi.csi_skuname as cso_ship_by_storecode,cso.cso_trxdocno as cso_trxdocno, csi.csi_skucode as cso_ship_stateid, " +
                " SUM(csi.csi_qty_order) as cso_ship_option, SUM(csi.csi_unit_price) as cso_oth_amt3," +
                " SUM(csi.csi_unit_discount) as cso_oth_amt4, SUM(csi.csi_unit_netprice) as cso_oth_amt5, cso.* " +
                " FROM product_category_desc pcd, product_master pm, counter_sales_order cso, counter_sales_item csi" +
                " WHERE cso.cso_salesid = csi.csi_salesid AND csi.csi_catid = pcd.pcd_catid AND " +
                " csi.csi_productid = pm.pmp_productid AND " +
                " pm.pmp_catid = csi.csi_catid ")).append(conditions.getConditions()).append(" group by pcd.pcd_desc, pm.pmp_producttype,pm.pmp_productseries, csi.csi_skuname, cso.cso_trxdocno ").append( "order by pcd.pcd_desc, pm.pmp_producttype,pm.pmp_productseries, csi.csi_skuname, cso.cso_trxdocno" ).append(conditions.getLimitConditions()).toString();
	
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesOrderBean payment;
            for(rs = stmt.executeQuery();rs.next();list.add(payment)){
                payment = new  CounterSalesOrderBean();
                payment.parseBean(rs);
            }
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSummarySalesReportBrandCategory(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT  pcd.pcd_desc as csi_inventory, pm.pmp_producttype as csi_unit_sales,cso.cso_trxdocno as csi_skucode," +
                " SUM(csi.csi_qty_order) as csi_qty_order, SUM(csi.csi_unit_price) as csi_unit_price," +
                " SUM(csi.csi_unit_discount) as csi_unit_discount, SUM(csi.csi_unit_netprice) as csi_unit_netprice, csi.* " +
                " FROM product_category_desc pcd, product_master pm, counter_sales_order cso, counter_sales_item csi " +
                " WHERE cso.cso_salesid = csi.csi_salesid AND csi.csi_catid = pcd.pcd_catid AND " +
                " csi.csi_productid = pm.pmp_productid AND " +
                " pm.pmp_catid = csi.csi_catid ")).append(conditions.getConditions()).append(conditions.getGroupby()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
																									
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesItemBean item;
            for(rs = stmt.executeQuery();rs.next();list.add(item)){
                item = new CounterSalesItemBean();
                item.parseBean(rs);
                System.out.print("summarySalesBroker" + SQL);
            }
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSummarySalesReportPayment(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select  sum(csm_amt*csm_rate) as csm_amt, csp.csm_paymodetime,  " +
                "cso.cso_trxdate as csm_expired, count(csp.csm_amt) as XCHGRATE,csp.* " +
                " FROM counter_sales_payment csp, counter_sales_order cso " +
                " WHERE csp.csm_salesid = cso_salesid "))
                                .append(conditions.getConditions()).append(conditions.getGroupby()).append(conditions.getOrderby()).append(conditions.getLimitClause()).toString();
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesPaymentBean payment;
            for(rs = stmt.executeQuery();rs.next();list.add(payment)){
                payment = new CounterSalesPaymentBean();
                payment.parseBean(rs);
            }
        }catch(Exception e){
            Log.error(e);
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    protected ArrayList getSummarySalesReportPaymentDetail(SQLConditionsBean conditions)
        throws MvcException, SQLException{
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("SELECT  csp.csm_paymodetime, cso.cso_local_currency as csm_paymodecode, cso.cso_trxdate as csm_expired, cso.cso_trxdocno as csm_paymodedesc,  sum(csp.csm_amt*csp.csm_rate) as csm_amt, csp.*  " +
                                 " FROM counter_sales_payment csp, counter_sales_order cso " +
                                 " WHERE csp.csm_salesid = cso_salesid  ")
                                ).append(conditions.getConditions()).append(conditions.getGroupby()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        try{
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesPaymentBean payment;
            for(rs = stmt.executeQuery();rs.next();list.add(payment)){
                payment = new CounterSalesPaymentBean();
                payment.parseBean(rs);
            }
            
        }catch(Exception e){
            Log.error(e);
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    // end Summary Sales Report Detail    
    
    protected ArrayList getSalesList(SQLConditionsBean conditions)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select * from counter_sales_order")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        System.out.println("SQL : "+ SQL);
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesOrderBean sales;
            for(rs = stmt.executeQuery(); rs.next(); list.add(sales))
            {
                sales = new CounterSalesOrderBean();
                sales.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getFullSalesList(SQLConditionsBean conditions)
        throws MvcException, SQLException
    {
        ArrayList list;
        CounterSalesManager manager;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        manager = new CounterSalesManager();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select * from counter_sales_order")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        System.out.println(" getFullSalesList "+ SQL);
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesOrderBean sales;
            for(rs = stmt.executeQuery(); rs.next(); list.add(sales))
            {
                sales = new CounterSalesOrderBean();
                sales.parseBean(rs);
                manager.parseSalesChildsFromDB(sales, "en_US");
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getFullSalesList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getSalesOutletList()
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select distinct(cso_sellerid) from counter_sales_order order by cso_seller_typestatus";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            for(rs = stmt.executeQuery(); rs.next();)
            {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesOutletList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getSalesBonusPeriodList()
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = "select distinct(cso_bonusperiodid) from counter_sales_order ";
        SQL = "select distinct(bpm_periodid) from bonus_period_master where bpm_type = 2 order by bpm_seqid ";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            for(rs = stmt.executeQuery(); rs.next();)
            {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesBonusPeriodList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected CounterSalesOrderBean getSalesOrder(Long salesID)
        throws MvcException, SQLException
    {
        CounterSalesOrderBean sales;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        sales = null;
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_order where cso_salesid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesID.longValue());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                sales = new CounterSalesOrderBean();
                sales.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesOrder --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return sales;
    }

    protected CounterSalesOrderBean getAdjstSalesOrder(Long adjSalesID)
        throws MvcException, SQLException
    {
        CounterSalesOrderBean sales;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        sales = null;
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_order where cso_adj_salesid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, adjSalesID.longValue());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                sales = new CounterSalesOrderBean();
                sales.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getAdjstSalesOrder --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return sales;
    }

    protected ArrayList getSalesItemList(Long salesID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_item left join counter_sales_order on csi_salesid = cso_salesid where csi_salesid = ? order by csi_seq";
        // SQL = "select * from counter_sales_item left join counter_sales_order on csi_salesid = cso_salesid where csi_salesid = ? order by csi_unit_price desc";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesID.longValue());
            CounterSalesItemBean item;
            for(rs = stmt.executeQuery(); rs.next(); list.add(item))
            {
                item = new CounterSalesItemBean();
                item.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesItemList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getSalesProductList(Long salesItemSeqID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_product left join counter_sales_item on csp_csiseq = csi_seq where csp_csiseq = ? order by csp_seq";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesItemSeqID.longValue());
            CounterSalesProductBean product;
            for(rs = stmt.executeQuery(); rs.next(); list.add(product))
            {
                product = new CounterSalesProductBean();
                product.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesProductList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getSalesFormList(Long salesID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_form left join counter_sales_order on csf_salesid = cso_salesid where csf_salesid = ? order by csf_seq";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesID.longValue());
            CounterSalesFormBean form;
            for(rs = stmt.executeQuery(); rs.next(); list.add(form))
            {
                form = new CounterSalesFormBean();
                form.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesFormList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getSalesPaymentList(Long salesID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from counter_sales_payment left join counter_sales_order on csm_salesid = cso_salesid where csm_salesid = ? order by csm_seq";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesID.longValue());
            CounterSalesPaymentBean payment;
            for(rs = stmt.executeQuery(); rs.next(); list.add(payment))
            {
                payment = new CounterSalesPaymentBean();
                payment.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesPaymentList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected boolean insertSalesRecord(CounterSalesOrderBean bean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        // String fields = "(cso_trxdate, cso_trxtime, cso_bonusdate, cso_bonusperiodid, cso_trxdoccode, cso_trxdoctype, cso_trxdocname, cso_batchcode, cso_trxtype, cso_trxgroup, cso_adj_refno, cso_adj_salesid, cso_adj_remark, cso_pricecode, cso_local_currency, cso_local_currency_name, cso_local_currency_symbol, cso_base_currency, cso_base_currency_name, cso_base_currency_symbol, cso_base_currency_rate, cso_sellerseq, cso_sellerid, cso_sellertype, cso_seller_typestatus, cso_seller_home_branchid, cso_service_agentseq, cso_service_agentid, cso_service_agenttype, cso_bonus_earnerseq, cso_bonus_earnerid, cso_bonus_earnertype, cso_bonus_earnername, cso_custseq, cso_custid, cso_custtype, cso_cust_typestatus, cso_cust_name, cso_cust_identityno, cso_cust_address_line1, cso_cust_address_line2, cso_cust_zipcode, cso_cust_countryid, cso_cust_regionid, cso_cust_stateid, cso_cust_cityid, cso_cust_contact, cso_cust_remark, cso_ship_option, cso_ship_from_outletid, cso_ship_from_storecode, cso_ship_by_outletid, cso_ship_by_storecode, cso_ship_receiver, cso_ship_address_line1, cso_ship_address_line2, cso_ship_zipcode, cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid, cso_ship_contact, cso_ship_remark, cso_total_bv1, cso_total_bv2, cso_total_bv3, cso_total_bv4, cso_total_bv5, cso_bvsales_amt, cso_nonbvsales_amt, cso_netsales_amt, cso_sales_chi_amt, cso_sales_corp_amt, cso_adjust_payment_amt, cso_discount_rate, cso_discount_amt, cso_delivery_rate, cso_delivery_amt, cso_mgmt_rate, cso_mgmt_amt, cso_creditcard_rate, cso_creditcard_amt, cso_bonus_rate, cso_bonus_amt, cso_oth_amt1, cso_oth_amt2, cso_oth_amt3, cso_oth_amt4, cso_oth_amt5, cso_payment_tender, cso_payment_change, cso_payment_remark, cso_remark, cso_process_status, cso_delivery_status, cso_status, cso_immediate_delivery, cso_display_delivery, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
           String fields = "(cso_balance_fee, cso_trxdate, cso_trxtime, cso_bonusdate, cso_bonusperiodid, cso_trxdoccode, cso_trxdoctype, cso_trxdocname, cso_batchcode, cso_trxtype, cso_trxgroup, cso_adj_refno, cso_adj_salesid, cso_adj_remark, cso_pricecode, cso_local_currency, cso_local_currency_name, cso_local_currency_symbol, cso_base_currency, cso_base_currency_name, cso_base_currency_symbol, cso_base_currency_rate, cso_sellerseq, cso_sellerid, cso_sellertype, cso_seller_typestatus, cso_seller_home_branchid, cso_service_agentseq, cso_service_agentid, cso_service_agenttype, cso_bonus_earnerseq, cso_bonus_earnerid, cso_bonus_earnertype, cso_bonus_earnername, cso_custseq, cso_custid, cso_custtype, cso_cust_typestatus, cso_cust_name, cso_cust_identityno, cso_cust_address_line1, cso_cust_address_line2, cso_cust_zipcode, cso_cust_countryid, cso_cust_regionid, cso_cust_stateid, cso_cust_cityid, cso_cust_contact, cso_cust_remark, cso_ship_option, cso_ship_from_outletid, cso_ship_from_storecode, cso_ship_by_outletid, cso_ship_by_storecode, cso_ship_receiver, cso_ship_address_line1, cso_ship_address_line2, cso_ship_zipcode, cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid, cso_ship_by_expedition, cso_ship_contact, cso_ship_remark, cso_total_bv1, cso_total_bv2, cso_total_bv3, cso_total_bv4, cso_total_bv5, cso_bvsales_amt, cso_nonbvsales_amt, cso_netsales_amt, cso_sales_chi_amt, cso_sales_corp_amt, cso_adjust_payment_amt, cso_discount_rate, cso_discount_amt, cso_delivery_rate, cso_delivery_amt, cso_mgmt_rate, cso_mgmt_amt, cso_creditcard_rate, cso_creditcard_amt, cso_bonus_rate, cso_bonus_amt, cso_oth_amt1, cso_oth_amt2, cso_oth_amt3, cso_oth_amt4, cso_oth_amt5, cso_payment_tender, cso_payment_change, cso_payment_remark, cso_remark, cso_process_status, cso_delivery_status, cso_status, cso_immediate_delivery, cso_display_delivery, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
        SQL = (new StringBuilder("insert into counter_sales_order ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setDouble(++i, bean.getNetSalesAmount() < 0.0D ? bean.getNetSalesAmount() * -1.0D : 0.0D); //Updated By Mila 2016-03-30
            stmt.setDate(++i, new Date(bean.getTrxDate().getTime()));
            if(bean.getTrxTime() == null)
                bean.setTrxTime(new Time((new java.util.Date()).getTime()));
            stmt.setTime(++i, new Time(bean.getTrxTime().getTime()));
            stmt.setDate(++i, bean.getBonusDate() == null ? null : new Date(bean.getBonusDate().getTime()));
            stmt.setString(++i, bean.getBonusPeriodID());
            stmt.setString(++i, bean.getTrxDocCode());
            stmt.setString(++i, bean.getTrxDocType());
            stmt.setString(++i, bean.getTrxDocName());
            stmt.setString(++i, bean.getImportBatchCode());
            stmt.setString(++i, bean.getTrxType());
            stmt.setInt(++i, bean.getTrxGroup());
            stmt.setString(++i, bean.getAdjstRefNo());
            stmt.setInt(++i, bean.getAdjstSalesID());
            stmt.setString(++i, bean.getAdjstRemark());
            stmt.setString(++i, bean.getPriceCode());
            stmt.setString(++i, bean.getLocalCurrency());
            stmt.setString(++i, bean.getLocalCurrencyName());
            stmt.setString(++i, bean.getLocalCurrencySymbol());
            stmt.setString(++i, bean.getBaseCurrency());
            stmt.setString(++i, bean.getBaseCurrencyName());
            stmt.setString(++i, bean.getBaseCurrencySymbol());
            stmt.setDouble(++i, bean.getBaseCurrencyRate());
            stmt.setInt(++i, bean.getSellerSeq());
            stmt.setString(++i, bean.getSellerID());
            stmt.setString(++i, bean.getSellerType());
            stmt.setString(++i, bean.getSellerTypeStatus());
            stmt.setString(++i, bean.getSellerHomeBranchID());
            stmt.setInt(++i, bean.getServiceAgentSeq());
            stmt.setString(++i, bean.getServiceAgentID());
            stmt.setString(++i, bean.getServiceAgentType() != null ? bean.getServiceAgentType() : ""); //Updated By Mila 2016-03-30
            stmt.setInt(++i, bean.getBonusEarnerSeq());
            stmt.setString(++i, bean.getBonusEarnerID());
            stmt.setString(++i, bean.getBonusEarnerType());
            stmt.setString(++i, bean.getBonusEarnerName());
            stmt.setInt(++i, bean.getCustomerSeq());
            stmt.setString(++i, bean.getCustomerID());
            stmt.setString(++i, bean.getCustomerType());
            stmt.setString(++i, bean.getCustomerTypeStatus());
            stmt.setString(++i, bean.getCustomerName());
            stmt.setString(++i, bean.getCustomerIdentityNo()== null ? "" : bean.getCustomerIdentityNo());
            AddressBean address = bean.getCustomerAddressBean();
            stmt.setString(++i, address.getMailAddressLine1());
            stmt.setString(++i, address.getMailAddressLine2());
            stmt.setString(++i, address.getMailZipCode());
            stmt.setString(++i, address.getMailCountryID());
            stmt.setString(++i, address.getMailRegionID());
            stmt.setString(++i, address.getMailStateID());
            stmt.setString(++i, address.getMailCityID());
            stmt.setString(++i, bean.getCustomerContact());
            stmt.setString(++i, bean.getCustomerRemark());
            stmt.setInt(++i, bean.getShipOption());
            stmt.setString(++i, bean.getShipFromOutletID());
            stmt.setString(++i, bean.getShipFromStoreCode() == null ? "" : bean.getShipFromStoreCode());
            stmt.setString(++i, bean.getShipByOutletID());
            stmt.setString(++i, bean.getShipByStoreCode());
            stmt.setString(++i, bean.getShipReceiver());
            
            // tambahan temporary admin collection
            
            stmt.setString(++i, bean.getShipAddress1());
            stmt.setString(++i, bean.getShipAddress2());
            stmt.setString(++i, bean.getShipZipcode());

            stmt.setString(++i, bean.getShipCountry());
            stmt.setString(++i, bean.getShipRegion());
            stmt.setString(++i, bean.getShipState());            
            stmt.setString(++i, bean.getShipCity());   
            stmt.setString(++i, bean.getShipExpedition() == null ? "" : bean.getShipExpedition());   

            // System.out.println("chek 2 : nilai ibrand_1 " + bean.getShipReceiver() + " produkItem : "+ bean.getShipAddress1() + " Edc : "+ bean.getShipAddress2() + " CreditCard : "+ bean.getShipZipcode() );
            
            AddressBean addressShip = bean.getShippingAddressBean();
            // stmt.setString(++i, addressShip.getMailAddressLine1());
            // stmt.setString(++i, addressShip.getMailAddressLine2());
            // stmt.setString(++i, addressShip.getMailZipCode());
            // stmt.setString(++i, addressShip.getMailCountryID());
            // stmt.setString(++i, addressShip.getMailRegionID());
            // stmt.setString(++i, addressShip.getMailStateID());
            // stmt.setString(++i, addressShip.getMailCityID());
            
            stmt.setString(++i, bean.getShipContact());
            stmt.setString(++i, bean.getShipRemark());
            stmt.setDouble(++i, bean.getTotalBv1());
            stmt.setDouble(++i, bean.getTotalBv2());
            stmt.setDouble(++i, bean.getTotalBv3());
            stmt.setDouble(++i, bean.getTotalBv4());
            stmt.setDouble(++i, bean.getTotalBv5());
            stmt.setDouble(++i, bean.getBvSalesAmount());
            stmt.setDouble(++i, bean.getNonBvSalesAmount());
            stmt.setDouble(++i, bean.getNetSalesAmount());
            stmt.setDouble(++i, bean.getChiSalesAmount());
            stmt.setDouble(++i, bean.getCorpSalesAmount());
            stmt.setDouble(++i, bean.getAdjstPaymentAmount());
            stmt.setDouble(++i, bean.getDiscountRate());
            stmt.setDouble(++i, bean.getDiscountAmount());
            stmt.setDouble(++i, bean.getDeliveryRate());
            stmt.setDouble(++i, bean.getDeliveryAmount());
            stmt.setDouble(++i, bean.getMgmtRate());
            stmt.setDouble(++i, bean.getMgmtAmount());
            stmt.setDouble(++i, bean.getCreditCardRate());
            stmt.setDouble(++i, bean.getCreditCardAmount());
            stmt.setDouble(++i, bean.getBonusRate());
            stmt.setDouble(++i, bean.getBonusAmount());
            stmt.setDouble(++i, bean.getOtherAmount1());
            stmt.setDouble(++i, bean.getOtherAmount2());
            stmt.setDouble(++i, bean.getOtherAmount3());
            stmt.setDouble(++i, bean.getOtherAmount4());
            stmt.setDouble(++i, bean.getOtherAmount5());
            stmt.setDouble(++i, bean.getPaymentTender());
            stmt.setDouble(++i, bean.getPaymentChange());
            
            stmt.setString(++i, bean.getPaymentRemark());
            
            stmt.setString(++i, bean.getRemark());
            stmt.setInt(++i, bean.getProcessStatus());
            stmt.setInt(++i, bean.getDeliveryStatus());
            stmt.setInt(++i, bean.getStatus());
            stmt.setString(++i, bean.getImmediateDelivery());
            stmt.setString(++i, bean.getDisplayDelivery());
            bean.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                bean.setSalesID(Long.valueOf(rs.getLong(1)));

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesRecord --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
    }

    
    protected boolean insertSalesRecordForceReturn(CounterSalesOrderBean bean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        // String fields = "(cso_trxdate, cso_trxtime, cso_bonusdate, cso_bonusperiodid, cso_trxdoccode, cso_trxdoctype, cso_trxdocname, cso_batchcode, cso_trxtype, cso_trxgroup, cso_adj_refno, cso_adj_salesid, cso_adj_remark, cso_pricecode, cso_local_currency, cso_local_currency_name, cso_local_currency_symbol, cso_base_currency, cso_base_currency_name, cso_base_currency_symbol, cso_base_currency_rate, cso_sellerseq, cso_sellerid, cso_sellertype, cso_seller_typestatus, cso_seller_home_branchid, cso_service_agentseq, cso_service_agentid, cso_service_agenttype, cso_bonus_earnerseq, cso_bonus_earnerid, cso_bonus_earnertype, cso_bonus_earnername, cso_custseq, cso_custid, cso_custtype, cso_cust_typestatus, cso_cust_name, cso_cust_identityno, cso_cust_address_line1, cso_cust_address_line2, cso_cust_zipcode, cso_cust_countryid, cso_cust_regionid, cso_cust_stateid, cso_cust_cityid, cso_cust_contact, cso_cust_remark, cso_ship_option, cso_ship_from_outletid, cso_ship_from_storecode, cso_ship_by_outletid, cso_ship_by_storecode, cso_ship_receiver, cso_ship_address_line1, cso_ship_address_line2, cso_ship_zipcode, cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid, cso_ship_contact, cso_ship_remark, cso_total_bv1, cso_total_bv2, cso_total_bv3, cso_total_bv4, cso_total_bv5, cso_bvsales_amt, cso_nonbvsales_amt, cso_netsales_amt, cso_sales_chi_amt, cso_sales_corp_amt, cso_adjust_payment_amt, cso_discount_rate, cso_discount_amt, cso_delivery_rate, cso_delivery_amt, cso_mgmt_rate, cso_mgmt_amt, cso_creditcard_rate, cso_creditcard_amt, cso_bonus_rate, cso_bonus_amt, cso_oth_amt1, cso_oth_amt2, cso_oth_amt3, cso_oth_amt4, cso_oth_amt5, cso_payment_tender, cso_payment_change, cso_payment_remark, cso_remark, cso_process_status, cso_delivery_status, cso_status, cso_immediate_delivery, cso_display_delivery, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
        String fields = "(cso_trxdate, cso_trxtime, cso_bonusdate, cso_bonusperiodid, cso_trxdoccode, cso_trxdoctype, cso_trxdocname, cso_batchcode, cso_trxtype, cso_trxgroup, cso_adj_refno, cso_adj_salesid, cso_adj_remark, cso_pricecode, cso_local_currency, cso_local_currency_name, cso_local_currency_symbol, cso_base_currency, cso_base_currency_name, cso_base_currency_symbol, cso_base_currency_rate, cso_sellerseq, cso_sellerid, cso_sellertype, cso_seller_typestatus, cso_seller_home_branchid, cso_service_agentseq, cso_service_agentid, cso_service_agenttype, cso_bonus_earnerseq, cso_bonus_earnerid, cso_bonus_earnertype, cso_bonus_earnername, cso_custseq, cso_custid, cso_custtype, cso_cust_typestatus, cso_cust_name, cso_cust_identityno, cso_cust_address_line1, cso_cust_address_line2, cso_cust_zipcode, cso_cust_countryid, cso_cust_regionid, cso_cust_stateid, cso_cust_cityid, cso_cust_contact, cso_cust_remark, cso_ship_option, cso_ship_from_outletid, cso_ship_from_storecode, cso_ship_by_outletid, cso_ship_by_storecode, cso_ship_receiver, cso_ship_address_line1, cso_ship_address_line2, cso_ship_zipcode, cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid, cso_ship_by_expedition, cso_ship_contact, cso_ship_remark, cso_total_bv1, cso_total_bv2, cso_total_bv3, cso_total_bv4, cso_total_bv5, cso_bvsales_amt, cso_nonbvsales_amt, cso_netsales_amt, cso_sales_chi_amt, cso_sales_corp_amt, cso_adjust_payment_amt, cso_discount_rate, cso_discount_amt, cso_delivery_rate, cso_delivery_amt, cso_mgmt_rate, cso_mgmt_amt, cso_creditcard_rate, cso_creditcard_amt, cso_bonus_rate, cso_bonus_amt, cso_oth_amt1, cso_oth_amt2, cso_oth_amt3, cso_oth_amt4, cso_oth_amt5, cso_payment_tender, cso_payment_change, cso_payment_remark, cso_remark, cso_process_status, cso_delivery_status, cso_status, cso_immediate_delivery, cso_display_delivery, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
        SQL = (new StringBuilder("insert into counter_sales_order ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setDate(++i, new Date(bean.getTrxDate().getTime()));
            if(bean.getTrxTime() == null)
                bean.setTrxTime(new Time((new java.util.Date()).getTime()));
            stmt.setTime(++i, new Time(bean.getTrxTime().getTime()));
            stmt.setDate(++i, bean.getBonusDate() == null ? null : new Date(bean.getBonusDate().getTime()));
            stmt.setString(++i, bean.getBonusPeriodID());
            stmt.setString(++i, bean.getTrxDocCode());
            stmt.setString(++i, bean.getTrxDocType());
            stmt.setString(++i, bean.getTrxDocName());
            stmt.setString(++i, bean.getImportBatchCode());
            stmt.setString(++i, bean.getTrxType());
            stmt.setInt(++i, bean.getTrxGroup());
            stmt.setString(++i, bean.getAdjstRefNo());
            stmt.setInt(++i, bean.getAdjstSalesID());
            stmt.setString(++i, bean.getAdjstRemark());
            stmt.setString(++i, bean.getPriceCode());
            stmt.setString(++i, bean.getLocalCurrency());
            stmt.setString(++i, bean.getLocalCurrencyName());
            stmt.setString(++i, bean.getLocalCurrencySymbol());
            stmt.setString(++i, bean.getBaseCurrency());
            stmt.setString(++i, bean.getBaseCurrencyName());
            stmt.setString(++i, bean.getBaseCurrencySymbol());
            stmt.setDouble(++i, bean.getBaseCurrencyRate());
            stmt.setInt(++i, bean.getSellerSeq());
            stmt.setString(++i, bean.getSellerID());
            stmt.setString(++i, bean.getSellerType());
            stmt.setString(++i, bean.getSellerTypeStatus());
            stmt.setString(++i, bean.getSellerHomeBranchID());
            stmt.setInt(++i, bean.getServiceAgentSeq());
            stmt.setString(++i, bean.getServiceAgentID());
            stmt.setString(++i, bean.getServiceAgentType());
            stmt.setInt(++i, bean.getBonusEarnerSeq());
            stmt.setString(++i, bean.getBonusEarnerID());
            stmt.setString(++i, bean.getBonusEarnerType());
            stmt.setString(++i, bean.getBonusEarnerName());
            stmt.setInt(++i, bean.getCustomerSeq());
            stmt.setString(++i, bean.getCustomerID());
            stmt.setString(++i, bean.getCustomerType());
            stmt.setString(++i, bean.getCustomerTypeStatus());
            stmt.setString(++i, bean.getCustomerName());
            stmt.setString(++i, bean.getCustomerIdentityNo());
            AddressBean address = bean.getCustomerAddressBean();
            stmt.setString(++i, address.getMailAddressLine1());
            stmt.setString(++i, address.getMailAddressLine2());
            stmt.setString(++i, address.getMailZipCode());
            stmt.setString(++i, address.getMailCountryID());
            stmt.setString(++i, address.getMailRegionID());
            stmt.setString(++i, address.getMailStateID());
            stmt.setString(++i, address.getMailCityID());
            stmt.setString(++i, bean.getCustomerContact());
            stmt.setString(++i, bean.getCustomerRemark());
            stmt.setInt(++i, bean.getShipOption());
            stmt.setString(++i, bean.getShipFromOutletID());
            stmt.setString(++i, bean.getShipFromStoreCode());
            stmt.setString(++i, bean.getShipByOutletID());
            stmt.setString(++i, bean.getShipByStoreCode());
            stmt.setString(++i, bean.getShipReceiver());
            
            // tambahan temporary admin collection
            
            stmt.setString(++i, bean.getShipAddress1());
            stmt.setString(++i, bean.getShipAddress2());
            stmt.setString(++i, bean.getShipZipcode());

            stmt.setString(++i, bean.getShipCountry());
            stmt.setString(++i, bean.getShipRegion());
            stmt.setString(++i, bean.getShipState());            
            stmt.setString(++i, bean.getShipCity());   
            stmt.setString(++i, bean.getShipExpedition());   

            // System.out.println("chek 2 : nilai ibrand_1 " + bean.getShipReceiver() + " produkItem : "+ bean.getShipAddress1() + " Edc : "+ bean.getShipAddress2() + " CreditCard : "+ bean.getShipZipcode() );
            
            AddressBean addressShip = bean.getShippingAddressBean();
            // stmt.setString(++i, addressShip.getMailAddressLine1());
            // stmt.setString(++i, addressShip.getMailAddressLine2());
            // stmt.setString(++i, addressShip.getMailZipCode());
            // stmt.setString(++i, addressShip.getMailCountryID());
            // stmt.setString(++i, addressShip.getMailRegionID());
            // stmt.setString(++i, addressShip.getMailStateID());
            // stmt.setString(++i, addressShip.getMailCityID());
            
            stmt.setString(++i, bean.getShipContact());
            stmt.setString(++i, bean.getShipRemark());
            stmt.setDouble(++i, bean.getTotalBv1());
            stmt.setDouble(++i, bean.getTotalBv2());
            stmt.setDouble(++i, bean.getTotalBv3());
            stmt.setDouble(++i, bean.getTotalBv4());
            stmt.setDouble(++i, bean.getTotalBv5());
            stmt.setDouble(++i, bean.getBvSalesAmount());
            stmt.setDouble(++i, bean.getNonBvSalesAmount());
            stmt.setDouble(++i, bean.getNetSalesAmount());
            stmt.setDouble(++i, bean.getChiSalesAmount());
            stmt.setDouble(++i, bean.getCorpSalesAmount());
            stmt.setDouble(++i, bean.getAdjstPaymentAmount());
            stmt.setDouble(++i, bean.getDiscountRate());
            stmt.setDouble(++i, bean.getDiscountAmount());
            stmt.setDouble(++i, bean.getDeliveryRate());
            stmt.setDouble(++i, bean.getDeliveryAmount());
            stmt.setDouble(++i, bean.getMgmtRate());
            stmt.setDouble(++i, bean.getMgmtAmount());
            stmt.setDouble(++i, bean.getCreditCardRate());
            stmt.setDouble(++i, bean.getCreditCardAmount());
            stmt.setDouble(++i, bean.getBonusRate());
            stmt.setDouble(++i, bean.getBonusAmount());
            stmt.setDouble(++i, bean.getOtherAmount1());
            stmt.setDouble(++i, bean.getOtherAmount2());
            stmt.setDouble(++i, bean.getOtherAmount3());
            stmt.setDouble(++i, bean.getOtherAmount4());
            stmt.setDouble(++i, bean.getOtherAmount5());
            stmt.setDouble(++i, bean.getPaymentTender());
            stmt.setDouble(++i, bean.getPaymentChange());
            
            stmt.setString(++i, bean.getPaymentRemark());
            
            stmt.setString(++i, bean.getRemark());
            stmt.setInt(++i, bean.getProcessStatus());
            stmt.setInt(++i, bean.getDeliveryStatus());
            stmt.setInt(++i, bean.getStatus());
            stmt.setString(++i, bean.getImmediateDelivery());
            stmt.setString(++i, bean.getDisplayDelivery());
            bean.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                bean.setSalesID(Long.valueOf(rs.getLong(1)));
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesRecord --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
    }

    
    protected boolean insertSalesItem(CounterSalesItemBean beans[], Long salesID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        boolean statusProduct = false;
        stmt = null;
        rs = null;
        // mulai insert 05
        // String fields = "(csi_salesid, csi_pricingid, csi_productid, csi_producttype, csi_inventory, csi_qty_order, csi_unit_price, csi_unit_price_chi, csi_unit_price_corp, csi_bv1, csi_bv2, csi_bv3, csi_bv4, csi_bv5, csi_delivery_status)";
        String fields = "(csi_salesid, csi_pricingid, csi_ign, csi_catid, csi_productcode, csi_skucode, csi_skuname, csi_productid, csi_producttype, csi_inventory, csi_qty_order, csi_unit_price, csi_unit_netprice, csi_unit_discount, csi_unit_sales, csi_unit_price_chi, csi_unit_price_corp, csi_bv1, csi_bv2, csi_bv3, csi_bv4, csi_bv5, csi_delivery_status)";
        
        SQL = (new StringBuilder("insert into counter_sales_item ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, salesID.intValue());
            for(int j = 0; j < beans.length; j++)
            {                
                int cnt = 1;
                stmt.setLong(++cnt, beans[j].getPricingID());
                
                stmt.setLong(++cnt, beans[j].getProductIGN());
                stmt.setLong(++cnt, beans[j].getProductCat());
                stmt.setString(++cnt, beans[j].getProductCode());
                stmt.setString(++cnt, beans[j].getProductSKU());
                stmt.setString(++cnt, beans[j].getProductDesc());
                
                stmt.setLong(++cnt, beans[j].getProductID());
                stmt.setInt(++cnt, beans[j].getProductType());
                stmt.setString(++cnt, beans[j].getInventory());
                stmt.setInt(++cnt, beans[j].getQtyOrder());
                stmt.setDouble(++cnt, beans[j].getUnitPrice());
                stmt.setDouble(++cnt, beans[j].getUnitNetPrice());
                
                stmt.setDouble(++cnt, beans[j].getUnitDiscount());
                stmt.setString(++cnt, beans[j].getUnitSales());
                
                stmt.setDouble(++cnt, beans[j].getChiUnitPrice());
                stmt.setDouble(++cnt, beans[j].getCorpUnitPrice());
                stmt.setDouble(++cnt, beans[j].getBv1());
                stmt.setDouble(++cnt, beans[j].getBv2());
                stmt.setDouble(++cnt, beans[j].getBv3());
                stmt.setDouble(++cnt, beans[j].getBv4());
                stmt.setDouble(++cnt, beans[j].getBv5());
                stmt.setInt(++cnt, beans[j].getDeliveryStatus());
                status = stmt.executeUpdate() > 0;
                rs = stmt.getGeneratedKeys();
                if(rs != null && rs.next())
                    beans[j].setSeq(Long.valueOf(rs.getLong(1)));
               
                // boolean statusProduct;
                if(beans[j].getProductArray().length > 0)
                    statusProduct = insertSalesProduct(beans[j].getProductArray(), beans[j].getSeq());
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesItem --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
        
    }

    protected boolean insertSalesProduct(CounterSalesProductBean beans[], Long seqID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        String fields = "(csp_csiseq, csp_productid, csp_producttype, csp_inventory, csp_qty_unit, csp_qty_order, csp_qty_kiv)";
        SQL = (new StringBuilder("insert into counter_sales_product ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, seqID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                stmt.setLong(2, beans[j].getProductID());
                stmt.setInt(3, beans[j].getProductType());
                stmt.setString(4, beans[j].getInventory());
                stmt.setInt(5, beans[j].getQtyUnit());
                stmt.setInt(6, beans[j].getQtyOrder());
                stmt.setInt(7, beans[j].getQtyKiv());
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesProduct --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean insertSalesForm(CounterSalesFormBean beans[], Long salesID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        String fields = "(csf_salesid, csf_formno, csf_status)";
        SQL = (new StringBuilder("insert into counter_sales_form ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, salesID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                stmt.setString(2, beans[j].getFormNo());
                stmt.setInt(3, beans[j].getStatus());
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesForm --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean insertSalesPaymentAwal(CounterSalesPaymentBean beans[], Long salesID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        
        // mulai insert 06
        // String fields = "(csm_salesid, csm_paymodecode, csm_paymodedesc, csm_paymodegroup,csm_refno, csm_amt, csm_status, csm_paymodeedc, csm_paymodetime)";
        // SQL = (new StringBuilder("insert into counter_sales_payment ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        
        String fields = "(csm_salesid, csm_paymodecode, csm_paymodedesc, csm_paymodegroup,csm_refno, csm_amt, csm_status, csm_paymodeedc, csm_paymodetime)";
        SQL = (new StringBuilder("insert into counter_sales_payment ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();

        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, salesID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                stmt.setString(2, beans[j].getPaymodeCode());
                stmt.setString(3, beans[j].getPaymodeDesc());
                stmt.setInt(4, beans[j].getPaymodeGroup());
                stmt.setString(5, beans[j].getRefNo());
                stmt.setDouble(6, beans[j].getAmount());
                stmt.setInt(7, beans[j].getStatus());
                stmt.setString(8, beans[j].getPaymodeEdc());
                stmt.setString(9, beans[j].getPaymodeTime());                
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesPayment --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean insertSalesPayment(CounterSalesPaymentBean beans[], Long salesID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        
        // mulai insert 06
        // String fields = "(csm_salesid, csm_paymodecode, csm_paymodedesc, csm_paymodegroup,csm_refno, csm_amt, csm_status, csm_paymodeedc, csm_paymodetime)";
        // SQL = (new StringBuilder("insert into counter_sales_payment ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        
        String fields = "(csm_salesid, csm_paymodecode, csm_paymodedesc, csm_paymodegroup,csm_refno, csm_amt, csm_currency, csm_rate, csm_status, csm_paymodeedc, csm_paymodetime, csm_expired, csm_owner)";
        SQL = (new StringBuilder("insert into counter_sales_payment ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();

        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, salesID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                stmt.setString(2, beans[j].getPaymodeCode());
                stmt.setString(3, beans[j].getPaymodeDesc());
                stmt.setInt(4, beans[j].getPaymodeGroup());
                stmt.setString(5, beans[j].getRefNo());
                stmt.setDouble(6, beans[j].getAmount());

                stmt.setString(7, beans[j].getCurrency());
                stmt.setDouble(8, beans[j].getRate());
                
                stmt.setInt(9, beans[j].getStatus());
                stmt.setString(10, beans[j].getPaymodeEdc());
                stmt.setString(11, beans[j].getPaymodeTime()); 
                stmt.setString(12, beans[j].getPaymodeExpired());
                // stmt.setDate(10, new Date( beans[j].getPaymodeExpired()));
                // stmt.setDate(++i, new Date(member.getJoinDate().getTime()));
                stmt.setString(13, beans[j].getPaymodeOwner());                 
                
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesPayment --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    //Updated By Mila 2016-04-06 SIR
    protected boolean insertSalesPaymentSIR(CounterSalesPaymentBean beans[], Long salesID, double netSalesAmt, boolean flagGrater)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        
        String fields = "(csm_salesid, csm_paymodecode, csm_paymodedesc, csm_paymodegroup,csm_refno, csm_amt, csm_currency, csm_rate, csm_status, csm_paymodeedc, csm_paymodetime, csm_expired, csm_owner)";
        SQL = (new StringBuilder("insert into counter_sales_payment ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();

        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, salesID.intValue());
            
            if(flagGrater){
                stmt.setString(2, "DPST1");
                stmt.setString(3, "DEPOSIT");
                stmt.setInt(4, 40);
                stmt.setString(5, "");
                stmt.setDouble(6, 0);

                stmt.setString(7, "IDR");
                stmt.setDouble(8, 1);
                
                stmt.setInt(9, 30);
                stmt.setString(10, "DEPOSIT");
                stmt.setString(11, "DEPOSIT"); 
                stmt.setString(12, "");
                stmt.setString(13, "");                 
            }else{
                stmt.setString(2, "DPST1");
                stmt.setString(3, "DEPOSIT");
                stmt.setInt(4, 40);
                stmt.setString(5, "");
                stmt.setDouble(6, netSalesAmt);

                stmt.setString(7, "IDR");
                stmt.setDouble(8, 1);
                
                stmt.setInt(9, 30);
                stmt.setString(10, "DEPOSIT");
                stmt.setString(11, "DEPOSIT"); 
                stmt.setString(12, "");
                stmt.setString(13, "");
            }
            status = stmt.executeUpdate() > 0;
            
            for(int j = 0; j < beans.length; j++)
            {
                stmt.setString(2, beans[j].getPaymodeCode());
                stmt.setString(3, beans[j].getPaymodeDesc());
                stmt.setInt(4, beans[j].getPaymodeGroup());
                stmt.setString(5, beans[j].getRefNo());
                
                stmt.setDouble(6, beans[j].getAmount());                

                stmt.setString(7, beans[j].getCurrency());
                stmt.setDouble(8, beans[j].getRate());
                
                stmt.setInt(9, beans[j].getStatus());
                stmt.setString(10, beans[j].getPaymodeEdc());
                stmt.setString(11, beans[j].getPaymodeTime()); 
                stmt.setString(12, beans[j].getPaymodeExpired());
                stmt.setString(13, beans[j].getPaymodeOwner());                 
                
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertSalesPayment --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }
    
    protected boolean voidSalesRecord(Long salesID, String doneBy, int voidStatus)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        PreparedStatement stmt2;
        PreparedStatement stmt3;
        String SQL_voidMaster;
        String SQL_voidForm;
        String SQL_voidPayment;
        status = false;
        stmt1 = null;
        stmt2 = null;
        stmt3 = null;
        SQL_voidMaster = "update counter_sales_order set cso_status = ?, std_modifyby = ?, std_modifydate = ?, std_modifytime = ? where cso_salesid = ?";
        SQL_voidForm = "update counter_sales_form  set csf_status = ? where csf_salesid = ?";
        SQL_voidPayment = "update counter_sales_payment  set csm_status = ? where csm_salesid = ?";
        try
        {
            int i = 0;
            stmt1 = getConnection().prepareStatement(SQL_voidMaster);
            stmt1.setInt(++i, voidStatus);
            stmt1.setString(++i, doneBy);
            stmt1.setDate(++i, new Date((new java.util.Date()).getTime()));
            stmt1.setTime(++i, new Time((new java.util.Date()).getTime()));
            stmt1.setLong(++i, salesID.longValue());
            status = stmt1.executeUpdate() > 0;
            stmt2 = getConnection().prepareStatement(SQL_voidForm);
            stmt2.setInt(1, voidStatus);
            stmt2.setLong(2, salesID.longValue());
            status = stmt2.executeUpdate() > 0;
            stmt3 = getConnection().prepareStatement(SQL_voidPayment);
            stmt3.setInt(1, voidStatus);
            stmt3.setLong(2, salesID.longValue());
            status = stmt3.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform voidSalesRecord --> ")).append(e.toString()).toString());
        }
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        return status;
    }

    protected boolean updateSalesDeliveryStatus(CounterSalesOrderBean bean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        PreparedStatement stmt2;
        PreparedStatement stmt3;
        String SQL_upd1;
        String SQL_upd2;
        String SQL_upd3;
        status = false;
        stmt1 = null;
        stmt2 = null;
        stmt3 = null;
        SQL_upd1 = "update counter_sales_order  set cso_delivery_status = ?, std_modifyby = ?, std_modifydate = ?, std_modifytime = ? where cso_salesid = ?";
        SQL_upd2 = "update counter_sales_item  set csi_delivery_status = ? where csi_seq = ?";
        SQL_upd3 = "update counter_sales_product  set csp_qty_kiv = ? where csp_seq = ?";
        try
        {
            stmt1 = getConnection().prepareStatement(SQL_upd1);
            stmt2 = getConnection().prepareStatement(SQL_upd2);
            stmt3 = getConnection().prepareStatement(SQL_upd3);
            stmt1.setInt(1, bean.getDeliveryStatus());
            stmt1.setString(2, bean.getStd_modifyBy());
            stmt1.setDate(3, new Date((new java.util.Date()).getTime()));
            stmt1.setTime(4, new Time((new java.util.Date()).getTime()));
            stmt1.setLong(5, bean.getSalesID().longValue());
            status = stmt1.executeUpdate() > 0;
            CounterSalesItemBean itemSales[] = bean.getItemArray();
            for(int i = 0; i < itemSales.length; i++)
            {
                stmt2.setInt(1, itemSales[i].getDeliveryStatus());
                stmt2.setLong(2, itemSales[i].getSeq().longValue());
                status = stmt2.executeUpdate() > 0;
                CounterSalesProductBean beans[] = itemSales[i].getProductArray();
                for(int j = 0; j < beans.length; j++)
                {
                    stmt3.setInt(1, beans[j].getQtyKiv());
                    stmt3.setLong(2, beans[j].getSeq().longValue());
                    status = stmt3.executeUpdate() > 0;
                }

            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateSalesDeliveryStatus --> ")).append(e.toString()).toString());
        }
        if(stmt1 != null)
            stmt1.close();
        if(stmt2 != null)
            stmt2.close();
        if(stmt3 != null)
            stmt3.close();
        return status;
    }

    protected boolean updateSalesTrxDocNo(String trxDocNo, Long salesID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update counter_sales_order set cso_trxdocno = ? where cso_salesid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, trxDocNo);
            stmt.setLong(2, salesID.longValue());
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateSalesTrxDocNo --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    
    protected boolean updateSalesTrxGroup(String trxDocNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update counter_sales_order set cso_trxgroup = ? where cso_trxdocno = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, 50);
            stmt.setString(2, trxDocNo);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateSalesTrxDocNo --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }
    

    protected boolean updateOutletVoucherOld(String voucherNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update outlet_voucher set ovc_status = ? where ovc_code = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "I");
            stmt.setString(2, voucherNo);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateOutletVoucher --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean updateOutletVoucher(String voucherNo, String customerNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        String SQL2;
        status = false;
        stmt = null;
        
        SQL = "update outlet_voucher set ovc_status = ? where ovc_code = ?";
        // SQL2 = "update member_pin set mbr_status = ? where mbr_mbrid = ?";
        SQL2 = "delete from member_pin where mbr_mbrid = ?";
        
        try
        {
           /* dipindah di proses create document
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "I");
            stmt.setString(2, voucherNo);
            status = stmt.executeUpdate() > 0;
           */ 
            stmt = getConnection().prepareStatement(SQL2);
            // stmt.setString(1, "I");
            // stmt.setString(2, customerNo);
            stmt.setString(1, customerNo);
            status = stmt.executeUpdate() > 0;            
            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform update OutletVoucher & PIN --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    
    protected boolean updateVoidOutletVoucher(String voucherNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update outlet_voucher set ovc_status = ? where ovc_code = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "A");
            stmt.setString(2, voucherNo);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateOutletVoucher --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }
       
    protected ArrayList getDeliveryList(SQLConditionsBean conditions)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select * from delivery_order")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            DeliveryOrderBean bean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new DeliveryOrderBean();
                bean.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDeliveryList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected DeliveryOrderBean getDeliveryByDocNo(String trxDocNo)
        throws MvcException, SQLException
    {
        DeliveryOrderBean doBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        doBean = null;
        stmt = null;
        rs = null;
        SQL = "select * from delivery_order where dod_trxdocno = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, trxDocNo);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                doBean = new DeliveryOrderBean();
                doBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDeliveryByDocNo --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return doBean;
    }

    protected DeliveryOrderBean getDelivery(Long deliveryID)
        throws MvcException, SQLException
    {
        DeliveryOrderBean doBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        doBean = null;
        stmt = null;
        rs = null;
        SQL = "select * from delivery_order where dod_deliveryid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, deliveryID.longValue());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                doBean = new DeliveryOrderBean();
                doBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDelivery --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return doBean;
    }

    protected ArrayList getDeliveryItemList(Long deliveryID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from delivery_item left join delivery_order on doi_deliveryid = dod_deliveryid where doi_deliveryid = ? order by doi_seq";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, deliveryID.longValue());
            DeliveryItemBean item;
            for(rs = stmt.executeQuery(); rs.next(); list.add(item))
            {
                item = new DeliveryItemBean();
                item.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDeliveryItemList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected ArrayList getDeliveryProductList(Long doItemSeqID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from delivery_product left join delivery_item on dop_doiseq = doi_seq where dop_doiseq = ? order by dop_seq";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, doItemSeqID.longValue());
            DeliveryProductBean product;
            for(rs = stmt.executeQuery(); rs.next(); list.add(product))
            {
                product = new DeliveryProductBean();
                product.parseBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDeliveryProductList --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected DeliveryOrderBean getDeliveryByAdjstDeliveryID(Long adjDeliveryID)
        throws MvcException, SQLException
    {
        DeliveryOrderBean doBean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        doBean = null;
        stmt = null;
        rs = null;
        SQL = "select * from delivery_order where dod_adj_deliveryid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, adjDeliveryID.longValue());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                doBean = new DeliveryOrderBean();
                doBean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getDeliveryByAdjstDeliveryID --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return doBean;
    }

    protected boolean insertDeliveryRecord(DeliveryOrderBean bean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "(dod_salesid, dod_salesrefno, dod_trxdate, dod_trxtime, dod_trxdoccode, dod_trxdocno, dod_trxdoctype, dod_trxdocname, dod_trxgroup, dod_adj_refno, dod_adj_deliveryid, dod_adj_remark, dod_custseq, dod_custid, dod_custtype, dod_cust_name, dod_cust_identityno, dod_cust_contact, dod_ship_option, dod_ship_from_outletid, dod_ship_from_storecode, dod_ship_by_outletid, dod_ship_by_storecode, dod_ship_receiver, dod_ship_address_line1, dod_ship_address_line2, dod_ship_zipcode, dod_ship_countryid, dod_ship_regionid, dod_ship_stateid, dod_ship_cityid, dod_ship_contact, dod_ship_remark, dod_remark, dod_status, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
        SQL = (new StringBuilder("insert into delivery_order ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(++i, bean.getSalesID());
            stmt.setString(++i, bean.getSalesRefNo());
            stmt.setDate(++i, new Date(bean.getTrxDate().getTime()));
            if(bean.getTrxTime() == null)
                bean.setTrxTime(new Time((new java.util.Date()).getTime()));
            stmt.setTime(++i, new Time(bean.getTrxTime().getTime()));
            stmt.setString(++i, bean.getTrxDocCode());
            stmt.setString(++i, bean.getTrxDocNo());
            stmt.setString(++i, bean.getTrxDocType());
            stmt.setString(++i, bean.getTrxDocName());
            stmt.setInt(++i, bean.getTrxGroup());
            stmt.setString(++i, bean.getAdjstRefNo());
            stmt.setInt(++i, bean.getAdjstDeliveryID());
            stmt.setString(++i, bean.getAdjstRemark());
            stmt.setInt(++i, bean.getCustomerSeq());
            stmt.setString(++i, bean.getCustomerID());
            stmt.setString(++i, bean.getCustomerType());
            stmt.setString(++i, bean.getCustomerName());
            stmt.setString(++i, bean.getCustomerIdentityNo());
            stmt.setString(++i, bean.getCustomerContact());
            stmt.setInt(++i, bean.getShipOption());
            stmt.setString(++i, bean.getShipFromOutletID());
            stmt.setString(++i, bean.getShipFromStoreCode());
            stmt.setString(++i, bean.getShipByOutletID());
            stmt.setString(++i, bean.getShipByStoreCode());
            stmt.setString(++i, bean.getShipReceiver());
            AddressBean addressShip = bean.getShippingAddressBean();
            stmt.setString(++i, addressShip.getMailAddressLine1());
            stmt.setString(++i, addressShip.getMailAddressLine2());
            stmt.setString(++i, addressShip.getMailZipCode());
            stmt.setString(++i, addressShip.getMailCountryID());
            stmt.setString(++i, addressShip.getMailRegionID());
            stmt.setString(++i, addressShip.getMailStateID());
            stmt.setString(++i, addressShip.getMailCityID());
            stmt.setString(++i, bean.getShipContact());
            stmt.setString(++i, bean.getShipRemark());
            stmt.setString(++i, bean.getRemark());
            stmt.setInt(++i, bean.getStatus());
            bean.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                bean.setDeliveryID(Long.valueOf(rs.getLong(1)));
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertDeliveryRecord --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
    }

    protected boolean insertDeliveryItem(DeliveryItemBean beans[], Long deliveryID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        boolean statusProduct = false;
        stmt = null;
        rs = null;
        String fields = "(doi_deliveryid, doi_productid, doi_producttype, doi_inventory, doi_qty)";
        SQL = (new StringBuilder("insert into delivery_item ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, deliveryID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                System.out.println("3. masuk insertDeliveryItem " +  beans[j].getInventory());
                
                stmt.setInt(2, beans[j].getProductID());
                stmt.setInt(3, beans[j].getProductType());
                stmt.setString(4, beans[j].getInventory());
                stmt.setInt(5, beans[j].getQty());
                status = stmt.executeUpdate() > 0;
                rs = stmt.getGeneratedKeys();
                if(rs != null && rs.next())
                    beans[j].setSeq(Long.valueOf(rs.getLong(1)));
                // boolean statusProduct;
                if(beans[j].getProductArray().length > 0)
                    statusProduct = insertDeliveryProduct(beans[j].getProductArray(), beans[j].getSeq());
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertDeliveryItem --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
    }

    protected boolean insertDeliveryProduct(DeliveryProductBean beans[], Long seqID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        String fields = "(dop_doiseq, dop_productid, dop_producttype, dop_inventory, dop_qty, dop_qty_kiv)";
        SQL = (new StringBuilder("insert into delivery_product ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, seqID.intValue());
            for(int j = 0; j < beans.length; j++)
            {
                System.out.println("3. masuk insertDeliveryProduct " +  beans[j].getInventory());
                
                stmt.setInt(2, beans[j].getProductID());
                stmt.setInt(3, beans[j].getProductType());
                stmt.setString(4, beans[j].getInventory());
                stmt.setInt(5, beans[j].getQty());
                stmt.setInt(6, beans[j].getQtyKiv());
                status = stmt.executeUpdate() > 0;
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform insertDeliveryProduct --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean voidDeliveryRecord(Long deliveryID, String doneBy)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String SQL_voidDo;
        status = false;
        stmt1 = null;
        SQL_voidDo = "update delivery_order  set dod_status = ?, std_modifyby = ?, std_modifydate = ?, std_modifytime = ? where dod_deliveryid = ?";
        try
        {
            int i = 0;
            stmt1 = getConnection().prepareStatement(SQL_voidDo);
            stmt1.setInt(++i, 50);
            stmt1.setString(++i, doneBy);
            stmt1.setDate(++i, new Date((new java.util.Date()).getTime()));
            stmt1.setTime(++i, new Time((new java.util.Date()).getTime()));
            stmt1.setLong(++i, deliveryID.longValue());
            status = stmt1.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform voidDeliveryRecord --> ")).append(e.toString()).toString());
        }
        if(stmt1 != null)
            stmt1.close();
        return status;
    }

    protected boolean updateDeliveryTrxDocNo(String trxDocNo, Long deliveryID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update delivery_order set dod_trxdocno = ? where dod_deliveryid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, trxDocNo);
            stmt.setLong(2, deliveryID.longValue());
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateDeliveryTrxDocNo --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean updateDeliveryCombineSales(CounterSalesOrderBean sales, Long deliveryID)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update delivery_order set dod_salesid=?, dod_salesrefno=?, dod_trxdate=?, dod_trxtime=?, dod_trxdoccode=?, dod_trxdocno=?, dod_trxdoctype=?, dod_trxdocname=? where dod_deliveryid = ?";
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(++i, sales.getSalesID().longValue());
            stmt.setString(++i, sales.getTrxDocNo());
            stmt.setDate(++i, new Date(sales.getTrxDate().getTime()));
            stmt.setTime(++i, new Time(sales.getTrxTime().getTime()));
            stmt.setString(++i, sales.getTrxDocCode());
            stmt.setString(++i, sales.getTrxDocNo());
            stmt.setString(++i, sales.getTrxDocType());
            stmt.setString(++i, sales.getTrxDocName());
            stmt.setLong(++i, deliveryID.longValue());
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateDeliveryCombineSales --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }

    protected boolean quickRegisterMember(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "mbr_mbrid, mbr_mobileno, mbr_passwd, mbr_epin, mbr_home_branchid, mbr_bonus_rank, mbr_bonus_tree, mbr_payout_currency, mbr_type, mbr_register, mbr_joindate, mbr_jointime, mbr_title, mbr_name, mbr_firstname, mbr_lastname, mbr_displayname, mbr_identityno, mbr_identitytype, mbr_company_name, mbr_company_registerno, mbr_nric, mbr_oldnric, mbr_passport, mbr_dob, mbr_intrid, mbr_intr_name, mbr_intr_identityno, mbr_intr_contact, mbr_intr_missing, mbr_placementid, mbr_placement_name, mbr_placement_identityno, mbr_placement_contact, mbr_id_original, mbr_placement_missing, mbr_remark, mbr_register_formno, mbr_register_prefix, mbr_register_status, mbr_status, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark ";
        SQL = (new StringBuilder("insert into member (")).append(fields).append(") values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++i, member.getMemberID());
            stmt.setString(++i, member.getMobileNo());
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, member.getHomeBranchID());
            stmt.setInt(++i, 10);
            stmt.setInt(++i, 10);
            stmt.setString(++i, "IDR");
            stmt.setString(++i, "I");
            stmt.setInt(++i, 0);        
            stmt.setDate(++i, new Date(member.getJoinDate().getTime()));
            if(member.getJoinTime() == null)
                member.setJoinTime(new Time((new java.util.Date()).getTime()));
            
            stmt.setTime(++i, new Time(member.getJoinTime().getTime()));
            stmt.setString(++i, "");
            stmt.setString(++i, member.getName());
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setDate(++i, member.getDob() == null ? null : new Date(member.getDob().getTime()));
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "N");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setString(++i, "");
            stmt.setInt(++i, 10);
            stmt.setInt(++i, 10);
            member.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                member.setMemberSeq(rs.getInt(1));
          
            
            System.out.println("Masuk Insert Custumer 3");
            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform quickRegisterMember --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
        }
    }

    protected ArrayList getStaffList(String branch)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = "select distinct(cso_bonusperiodid) from counter_sales_order ";
        SQL = " select concat(mbr_mbrid,' - ', concat(mbr_firstname, ' ',mbr_name, ' ',mbr_lastname)) as nama from salesman where mbr_status = 10 and mbr_home_branchid = ?  ";
        // sales.setBonusEarnerName(bonusEarner.getFirstName().trim().concat(" ").concat(bonusEarner.getName()).trim().concat(" ").concat(bonusEarner.getLastName()).trim());
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, branch);
            
            for(rs = stmt.executeQuery(); rs.next();)
            {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getStaffList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList getSalesList(String branch)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = "select distinct(cso_bonusperiodid) from counter_sales_order ";
        SQL = "select mbr_name from salesman where mbr_home_branchid = ? and mbr_status = 10 order by mbr_name  ";
        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, branch);
            
            for(rs = stmt.executeQuery(); rs.next();)
            {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesmanList --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    
    
    protected ArrayList getFullSalesListDetail(SQLConditionsBean conditions)
        throws MvcException, SQLException
    {
        ArrayList list;
        CounterSalesManager manager;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        manager = new CounterSalesManager();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select counter_sales_order.*, product_master.pmp_productcode, product_master.pmp_default_name, counter_sales_item.csi_bv1 AS bv, counter_sales_item.csi_unit_price AS price, counter_sales_item.csi_qty_order AS qty, (counter_sales_item.csi_qty_order * counter_sales_item.csi_bv1) AS bv_amount, (counter_sales_item.csi_qty_order * counter_sales_item.csi_unit_price ) AS price_amount, product_master.pmp_catid   from counter_sales_order Inner Join counter_sales_item ON counter_sales_order.cso_salesid = counter_sales_item.csi_salesid Inner Join counter_sales_product ON counter_sales_item.csi_seq = counter_sales_product.csp_csiseq Inner Join product_master ON counter_sales_product.csp_productid = product_master.pmp_productid")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        // counter_sales_item.csi_bv1 AS bv, counter_sales_item.csi_unit_price AS price, counter_sales_item.csi_qty_order AS qty, (counter_sales_item.csi_qty_order * counter_sales_item.csi_bv1) AS bv_amount, (counter_sales_item.csi_qty_order * counter_sales_item.csi_unit_price ) AS price_amount  
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            CounterSalesOrderBeanDetail sales;            
            for(rs = stmt.executeQuery(); rs.next(); list.add(sales))
            {
                sales = new CounterSalesOrderBeanDetail();
                sales.parseBean(rs);
                // manager.parseSalesChildsFromDB(sales, "en_US");
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getFullSalesListDetail --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public ArrayList getPaymentModeList2()
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        stmt = null;
        rs = null;
        try
        {
            // stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_outletid = ? order by opm_paymodecode, opm_edc, opm_time");       
            stmt = getConnection().prepareStatement(" select *  FROM counter_sales_payment Left Join counter_sales_order ON counter_sales_payment.csm_salesid = counter_sales_order.cso_salesid where counter_sales_order.cso_trxdate = date(now())  group by csm_paymodecode,  csm_paymodedesc, csm_paymodeedc, csm_paymodetime, csm_currency order by csm_paymodegroup, csm_paymodedesc,  csm_paymodeedc, csm_paymodetime, csm_currency ");
            
            // stmt.setString(1, outletID);
            rs = stmt.executeQuery();
            int count = 0;
            CounterSalesPaymentBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new CounterSalesPaymentBean();
                bean.parseBean(rs);
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Counter Sales Payment Bean Info  --> ")).append(sqlex).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    public OutletBean getRecord(String id)
        throws MvcException, SQLException
    {
        OutletBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        bean = null;
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(" select * from outlet  left join locations on otl_control_locationid = loc_id   where otl_outletid = ? ");
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean = new OutletBean();
                bean.parseBean(bean, rs, "");
                
                System.out.println("Masuk getRecord "+ bean.getName());
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Record --> ")).append(sqlex).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    protected boolean deleteTablePIN(String customerNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update member_pin set mbr_status = 'I' where mbr_mbrid = ? ";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, customerNo);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateTablePIN --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }    

    protected boolean updateVoucherSerial(CounterSalesOrderBean bean, String query, String keterangan)
    throws MvcException, SQLException {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        String SQL2;
        String Trx01 = "";
        String Trx02 = "";
        status = false;
        stmt = null;
        // SQL  = "Update outlet_voucher Set ovc_status = ?, ovc_startdate = ?, ovc_enddate = ?, ovc_trxdocno = ? where ovc_status = ? and ovc_code IN".concat(query);        
        SQL  = "Update outlet_voucher Set ovc_status = ?, ovc_trxdocno = ?, ovc_issuedate = ? where ovc_status = ? and ovc_code = ? " ;
        // SQL2 = "Update outlet_voucher Set ovc_status = ?, ovc_trxdocno = ?, ovc_issuedate = ? where ovc_status = ? and ovc_code IN".concat(query);
        
        try {

        if(keterangan.equalsIgnoreCase("U"))
        { 

        // Find Expired, change java.util.Date to java.sql.Date
        java.util.Date toDate = new java.util.Date();    
        Calendar cal = Calendar.getInstance();
        cal.setTime(toDate);
        cal.add(Calendar.DATE, 365);
        toDate = cal.getTime();
        java.sql.Date toDateSql = new java.sql.Date(toDate.getTime());   

            Trx01 = bean.getTrxDocNo();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "U");
            stmt.setString(2, Trx01);
            java.util.Date date= new java.util.Date();
            stmt.setTimestamp(3, new Timestamp(date.getTime()));            
            // status
            stmt.setString(4, "A");
            stmt.setString(5, query);
            
        }else if(keterangan.equalsIgnoreCase("A")){  

            Trx02 = bean.getTrxDocNo();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "A");
            stmt.setString(2, Trx02);
            java.util.Date date= new java.util.Date();
            stmt.setTimestamp(3, new Timestamp(date.getTime()));            
            // status
            stmt.setString(4, "U");
            stmt.setString(5, query);
            
        }else
        {
            Trx02 = bean.getTrxDocNo();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "A");
            stmt.setString(2, Trx02);
            java.util.Date date= new java.util.Date();
            stmt.setTimestamp(3, new Timestamp(date.getTime()));            
            stmt.setString(4, "U");
            stmt.setString(5, query);
        }
            
            status = stmt.executeUpdate() > 0;
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateVoucherSerial --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }
   
     protected boolean updateRemark(String salesID, String remark)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update counter_sales_order set cso_remark = ? where cso_salesid = ? ";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, remark);
            stmt.setString(2, salesID);
                               
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateRemark --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }    
    protected String getEreceiptStatus(Long salesID)
        throws MvcException, SQLException
    {
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        String result;
        result = null;
        stmt = null;
        rs = null;
        SQL = "select ereceipt_status from counter_sales_order where cso_salesid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setLong(1, salesID.longValue());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                result = rs.getString("ereceipt_status");
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getEreceiptStatus --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return result;
    } 
}
