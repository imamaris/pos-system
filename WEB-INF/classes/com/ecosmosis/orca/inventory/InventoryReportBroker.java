// Decompiled by Yody
// File : InventoryReportBroker.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.inventory:
//            InventoryBean, StockMovementRptBean

public class InventoryReportBroker extends DBTransactionBroker {
    
    protected InventoryReportBroker(Connection con) {
        super(con);
    }
    
    protected InventoryBean viewStoreInventoryAwal(int productId, String ownerid, String storeCode, java.util.Date dateFrom, java.util.Date dateTo)
    throws MvcException, SQLException {
        String SQL_getRecord;
        String SQL_getBringForward;
        InventoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        PreparedStatement stmt2;
        ResultSet rs2;
        SQL_getRecord = (new StringBuilder("select sum(piv_in) as StockIn, sum(piv_out) as StockOut  from product_inventory  where piv_status = ?  and  piv_productid = ? ")).append(dateFrom == null ? "" : " and piv_trxdate >= ? ").append(dateTo == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        SQL_getBringForward = (new StringBuilder("select sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_productid = ?  and piv_status = ?  and piv_trxdate < ? ")).append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        
        
        bean = new InventoryBean();
        stmt = null;
        rs = null;
        stmt2 = null;
        rs2 = null;
        try {
            int counter = 0;
            int _counter = 0;
            stmt = getConnection().prepareStatement(SQL_getRecord);
            stmt.setInt(++counter, 100);
            stmt.setInt(++counter, productId);
            if(dateFrom != null) {
                stmt2 = getConnection().prepareStatement(SQL_getBringForward);
                stmt2.setInt(++_counter, productId);
                stmt2.setInt(++_counter, 100);
                stmt2.setDate(++_counter, new Date(dateFrom.getTime()));
                if(ownerid != null)
                    stmt2.setString(++_counter, ownerid);
                if(storeCode != null)
                    stmt2.setString(++_counter, storeCode);
            }
            if(dateFrom != null)
                stmt.setDate(++counter, new Date(dateFrom.getTime()));
            if(dateTo != null)
                stmt.setDate(++counter, new Date(dateTo.getTime()));
            if(ownerid != null)
                stmt.setString(++counter, ownerid);
            if(storeCode != null)
                stmt.setString(++counter, storeCode);
            rs = stmt.executeQuery();
            if(rs.next()) {
                bean.setTotalIn(rs.getInt("StockIn"));
                bean.setTotalOut(rs.getInt("StockOut"));
                bean.setTotal(bean.getTotalIn() - bean.getTotalOut());
                
                if(dateFrom != null) {
                    rs2 = stmt2.executeQuery();
                    if(rs2.next())
                        bean.setTotalBringForward(rs2.getInt(1));
                }
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while getting Inventory balance --> ")).append(e.toString()).toString());
        }
        
        // System.out.println("2a. Chek viewStoreInventory 1 " + stmt.toString());
        // System.out.println("2a. Chek viewStoreInventory 2 " + SQL_getBringForward);
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs2 != null)
            rs2.close();
        return bean;
    }
    
    // Add price
    protected InventoryBean viewStoreInventory(int productId, String productCode, String ownerid, String storeCode, java.util.Date dateFrom, java.util.Date dateTo, String fromTime, String toTime)
    throws MvcException, SQLException {
        String SQL_getRecord;
        String SQL_getBringForward;
        String SQL_getPrice;
        
        InventoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        PreparedStatement stmt2;
        ResultSet rs2;
        
        PreparedStatement stmt3;
        ResultSet rs3;
        
        SQL_getRecord = (new StringBuilder("select sum(piv_in) as StockIn, sum(piv_out) as StockOut  from product_inventory  where piv_trxtype <> 'STAI'  and piv_status = ?  and  piv_productid = ? ")).append(dateFrom == null ? "" : " and piv_trxdate >= ? ").append(dateTo == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        // SQL_getRecord = (new StringBuilder("select sum(piv_in) as StockIn, sum(piv_out) as StockOut  from product_inventory  where piv_status = ?  and  piv_productid = ? ")).append(dateFrom == null ? "" : " and piv_trxdate >= ? ").append(dateTo == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        // ada allocate  STAI
        SQL_getBringForward = (new StringBuilder("select sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_trxtype <> 'STAI' and piv_productid = ?  and piv_status = ?  and piv_trxdate < ? ")).append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        // private butiq
        // SQL_getPrice = (new StringBuilder("select ppi_price as price from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=? and ppi_startdate <= now() and ppi_enddate >= now() and LOCATNID = ?  order by product_pricing.std_createdate DESC limit 1 ")).toString();
        // lintas butiq
        // SQL_getPrice = (new StringBuilder(" select ppi_price as price from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=? and ppi_startdate <= now() and ppi_enddate >= now() order by product_pricing.std_createdate DESC limit 1 ")).toString();
        // add time
        // SQL_getPrice = (new StringBuilder(" select ppi_price as price from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_status=? and if(ppi_startdate = ? and  ppi_enddate = ?,  (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?), if(ppi_startdate = ? and ppi_enddate > ? , (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? ), if(ppi_startdate < ? and ppi_enddate  = ? , (ppi_startdate <= ? and ppi_enddate = ? and ppi_endtime >= ? ), (ppi_startdate <= ? and ppi_enddate >= ? )))) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1  ")).toString();                
        
        //SQL_getPrice = (new StringBuilder(" select ppi_price as price from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_status=? and (ppi_startdate <= ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1  ")).toString(); //Updated By Ferdi 2015-04-07
        //Updated By Ferdi 2015-06-18
        //SQL_getPrice = (new StringBuilder(" select ppi_price as price from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_status=? and (concat(ppi_startdate,?,ppi_starttime) <= ? and concat(ppi_enddate,?,ppi_endtime) >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1  ")).toString(); //Updated By Ferdi 2015-04-07
        SQL_getPrice = (new StringBuilder(" select " +
                                                    "ppi_currency as ccy, ppi_price as price, " +
                                                    "(SELECT " + 
                                                                "cer_rate " +
                                                    "FROM " + 
                                                                    "currency_exchange_rate " +
                                                    "WHERE " + 
                                                                    "date(NOW()) BETWEEN cer_startdate AND cer_enddate AND " + 
                                                                    "cer_currencyid = ccy " +    
                                                    "ORDER BY " +
                                                                    "cer_startdate DESC, cer_endtime DESC " +
                                                    "LIMIT 1) as rate " +
                                          " from " +
                                                    "product_pricing " +
                                          " where " +
                                                    "ppi_productcode=? and " +
                                                    "ppi_pricecode=? and " +
                                                    "ppi_status=? and " +
                                                    "date(now()) between ppi_startdate and ppi_enddate and date(now()) >= ppi_startdate " +
                                          " order by " +
                                                    "product_pricing.ppi_promotional DESC, " +
                                                    "product_pricing.ppi_startdate DESC, product_pricing.ppi_pricingid DESC" +
                                          " limit 1  ")).toString();
        //End Updated
        
        bean = new InventoryBean();
        stmt = null;
        rs = null;
        stmt2 = null;
        rs2 = null;
        stmt3 = null;
        rs3 = null;
        
        try {
            int counter = 0;
            int _counter = 0;
            int _count = 0;
            
            stmt = getConnection().prepareStatement(SQL_getRecord);
            stmt.setInt(++counter, 100);
            stmt.setInt(++counter, productId);
            
            if(dateFrom != null) {
                stmt2 = getConnection().prepareStatement(SQL_getBringForward);
                stmt2.setInt(++_counter, productId);
                stmt2.setInt(++_counter, 100);
                stmt2.setDate(++_counter, new Date(dateFrom.getTime()));
                if(ownerid != null)
                    stmt2.setString(++_counter, ownerid);
                if(storeCode != null)
                    stmt2.setString(++_counter, storeCode);
                
            }
            
            if(dateFrom != null)
                stmt.setDate(++counter, new Date(dateFrom.getTime()));
            if(dateTo != null)
                stmt.setDate(++counter, new Date(dateTo.getTime()));
            
            
            if(ownerid != null)
                stmt.setString(++counter, ownerid);
            if(storeCode != null)
                stmt.setString(++counter, storeCode);
            
            rs = stmt.executeQuery();
            
            if(rs.next()) {
                bean.setTotalIn(rs.getInt("StockIn"));
                bean.setTotalOut(rs.getInt("StockOut"));
                bean.setTotal(bean.getTotalIn() - bean.getTotalOut());
                
                if(dateFrom != null) {
                    rs2 = stmt2.executeQuery();
                    if(rs2.next())
                        bean.setTotalBringForward(rs2.getInt(1));
                }
                
                // filter qty jika ingin
                if (bean.getTotalBringForward() != 0 || bean.getTotalIn() != 0 || bean.getTotalOut() != 0) {
                    // if( bean.getTotalBringForward() + (bean.getTotalIn() - bean.getTotalOut()) > 0) {                    

                    stmt3 = getConnection().prepareStatement(SQL_getPrice);
                    //Updated By Ferdi 2015-06-18
                    /*stmt3.setString(++_count, new Date(dateFrom.getTime()).toString());
                    stmt3.setString(++_count, new Date(dateFrom.getTime()).toString());*/
                    //End Updated
                    stmt3.setString(++_count, productCode);
                    stmt3.setString(++_count, "RTL");
                    // stmt3.setString(++_count, "N");
                    stmt3.setString(++_count, "A");
                    
                    //Updated By Ferdi 2015-04-07
                    /*stmt3.setString(++_count, " ");//Updated By Mila 2016-04-20
                    stmt3.setString(++_count, new Date(dateFrom.getTime()).toString() + " " + fromTime);
                    stmt3.setString(++_count, " "); 
                    stmt3.setString(++_count, new Date(dateTo.getTime()).toString() + " " + toTime);*/
                    //End Updated
                    
                    /*
                    // if 1
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setString(++_count, fromTime);
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    stmt3.setString(++_count, toTime);
                    
                    // if 2
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setString(++_count, fromTime);
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    
                    // if 3
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    stmt3.setString(++_count, toTime);

                    // else
                    stmt3.setDate(++_count, new Date(dateFrom.getTime()));
                    stmt3.setDate(++_count, new Date(dateTo.getTime())); 
                    */
                    
                    
                    rs3 = stmt3.executeQuery();
                    // System.out.println("SQL_getPrice : "+stmt3);
                    System.out.println("Query Process "+ productCode);
                    
                    if(rs3.next()) {
                        // System.out.println(" Masuk execute - next baru sini !! ");
                        double harga = rs3.getDouble(2);
                        //Updated By Ferdi 2015-06-18
                        double rate = rs3.getDouble(3); 
                        double hargaRp = harga * rate;
                        bean.setPrice(hargaRp);
                        //bean.setPrice(harga);
                        //End Updated
                        // System.out.println(" ProductCode: "+productCode+" Price: " +harga );
                    }
                    
                }
                
            }
            
            // System.out.println(" ProductCode: "+productCode+" Price: " +rs3.getDouble(1) );
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while getting Inventory balance --> ")).append(e.toString()).toString());
        }
        
        // System.out.println("2a. Chek viewStoreInventory 1 " + stmt.toString());
        // System.out.println("2a. Chek viewStoreInventory 2 " + SQL_getBringForward);
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs2 != null)
            rs2.close();
        return bean;
    }
    
    protected boolean addRecord(InventoryBean inventoryBean)
    throws MvcException, SQLException {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "(piv_trxdate, piv_trxtime, piv_owner, piv_owner_type, piv_owner_remark, piv_storecode, piv_productid, piv_producttype, piv_trxdocno, piv_trxdoctype, piv_trxtype, piv_in,piv_out, piv_batchno, piv_salesid, piv_deliveryid, piv_target, piv_target_type, piv_target_remark, piv_remark,piv_process_status, piv_status,  std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
        SQL = (new StringBuilder("insert into product_inventory ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setDate(++counter, new Date(inventoryBean.getTrnxDate().getTime()));
        stmt.setTime(++counter, new Time(inventoryBean.getTrnxDate().getTime()));
        stmt.setString(++counter, inventoryBean.getOwnerID());
        stmt.setString(++counter, inventoryBean.getOwnerType());
        stmt.setString(++counter, inventoryBean.getOwnerRemark());
        stmt.setString(++counter, inventoryBean.getStoreCode());
        stmt.setInt(++counter, inventoryBean.getProductID());
        stmt.setInt(++counter, inventoryBean.getProductType());
        stmt.setString(++counter, inventoryBean.getTrnxDocNo());
        stmt.setString(++counter, inventoryBean.getTrnxDocType());
        stmt.setString(++counter, inventoryBean.getTrnxType());
        stmt.setInt(++counter, inventoryBean.getTotalIn());
        stmt.setInt(++counter, inventoryBean.getTotalOut());
        stmt.setString(++counter, inventoryBean.getBatchNo());
        stmt.setInt(++counter, inventoryBean.getSalesID());
        stmt.setInt(++counter, inventoryBean.getDeliveryID());
        stmt.setString(++counter, inventoryBean.getTarget());
        stmt.setString(++counter, inventoryBean.getTargetType());
        stmt.setString(++counter, inventoryBean.getTargetRemark());
        stmt.setString(++counter, inventoryBean.getRemark());
        stmt.setInt(++counter, inventoryBean.getProcessStatus());
        stmt.setInt(++counter, inventoryBean.getStatus());
        inventoryBean.setRecordStmt(stmt, counter);
        status = stmt.executeUpdate() > 0;
        rs = stmt.getGeneratedKeys();
        if(rs != null && rs.next())
            inventoryBean.setInventoryID(rs.getInt(1));
        /*
        break MISSING_BLOCK_LABEL_497;
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
        return status;
    }
    
    protected boolean updateDocRecord(InventoryBean inventoryBean)
    throws MvcException, SQLException {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update product_inventory  set piv_trxdocno = ?,  piv_trxdoctype = ?   where piv_inventoryid = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, inventoryBean.getTrnxDocNo());
        stmt.setString(++counter, inventoryBean.getTrnxDocType());
        stmt.setInt(++counter, inventoryBean.getInventoryID());
        status = stmt.executeUpdate() > 0;
        /*
        break MISSING_BLOCK_LABEL_102;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        throw exception;
         */
        if(stmt != null)
            stmt.close();
        return status;
    }
    
    protected ArrayList getRecordsByDocNum(String refNo, String ownerId, String locale)
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder(" select * from product_inventory  where  piv_trxdocno = ? ")).append(ownerId == null ? "" : " and piv_owner = ? ").toString();
        int counter = 0;
        ProductManager productManager = new ProductManager();
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, refNo);
        if(ownerId != null)
            stmt.setString(++counter, ownerId);
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new InventoryBean();
            bean.parseInventoryBean(rs, "");
            bean.setProductBean(productManager.getProduct(bean.getProductID(), locale));
        }
        /*
        break MISSING_BLOCK_LABEL_195;
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
        return list;
    }
    
    
    protected ArrayList viewInventoryTrx(String ownerid, String storeCode, java.util.Date from, java.util.Date to)
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = (new StringBuilder(" select distinct piv_trxdocno,  piv_trxtype, piv_trxdate,   piv_owner, piv_owner_type, piv_storecode, std_createby  from product_inventory   where  piv_status = ?  and piv_trxtype <> ?  ")).append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").append(" order by piv_trxtype ").toString();
        SQL = (new StringBuilder(" select distinct piv_trxdocno,  piv_trxtype, piv_trxdate,   piv_owner, piv_owner_type, piv_storecode, std_createby  from product_inventory   where  piv_status = ?  ")).append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").append(" order by piv_trxtype ").toString();
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setInt(++counter, 100);
        // stmt.setString(++counter, "STEI");
        if(from != null)
            stmt.setDate(++counter, new Date(from.getTime()));
        if(to != null)
            stmt.setDate(++counter, new Date(to.getTime()));
        if(ownerid != null)
            stmt.setString(++counter, ownerid);
        if(storeCode != null)
            stmt.setString(++counter, storeCode);
        
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new InventoryBean();
            bean.setTrnxDocNo(rs.getString("piv_trxdocno"));
            bean.setTrnxType(rs.getString("piv_trxtype"));
            bean.setTrnxDate(rs.getDate("piv_trxdate"));
            bean.setOwnerID(rs.getString("piv_owner"));
            bean.setOwnerType(rs.getString("piv_owner_type"));
            bean.setStoreCode(rs.getString("piv_storecode"));
            bean.setStd_createBy(rs.getString("std_createby"));
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    
    protected ArrayList viewInventoryTrxAllocate(String ownerid, String storeCode, java.util.Date from, java.util.Date to, String transStatus)
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = null;
        String tipe1 = "";
        String tipe2 = "";
        String tipe3 = "";
        
           if(transStatus.equalsIgnoreCase("TW"))
           {    
             tipe1 = "STAI";
             tipe2 = "STAO";
           }else{
             tipe3 = "SKLO";
           }  
        
        // SQL = (new StringBuilder(" select distinct piv_trxdocno,  piv_trxtype, piv_trxdate,   piv_owner, piv_owner_type, piv_storecode, std_createby  from product_inventory   where  piv_status = ?  and piv_trxtype in (?,?)  ")).append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").append(" order by piv_trxtype ").toString();
        SQL = (new StringBuilder(" select distinct piv_trxdocno,  piv_trxtype, piv_trxdate,   piv_owner, piv_owner_type, piv_storecode, piv_target, std_createby, piv_status  from product_inventory   where piv_trxtype in (?,?,?)  ")).append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").append(" order by piv_trxtype ").toString();
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, (transStatus.equalsIgnoreCase("")) ? "STAI" : tipe1);
        stmt.setString(++counter, (transStatus.equalsIgnoreCase("")) ? "STAO" : tipe2);
        stmt.setString(++counter, (transStatus.equalsIgnoreCase("")) ? "SKLO" : tipe3);        
        
        if(from != null)
            stmt.setDate(++counter, new Date(from.getTime()));
        if(to != null)
            stmt.setDate(++counter, new Date(to.getTime()));
        if(ownerid != null)
            stmt.setString(++counter, ownerid);
        if(storeCode != null)
            stmt.setString(++counter, storeCode);
        
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new InventoryBean();
            bean.setTrnxDocNo(rs.getString("piv_trxdocno"));
            bean.setTrnxType(rs.getString("piv_trxtype"));
            bean.setTrnxDate(rs.getDate("piv_trxdate"));
            bean.setOwnerID(rs.getString("piv_owner"));
            bean.setOwnerType(rs.getString("piv_owner_type"));
            bean.setStoreCode(rs.getString("piv_storecode"));
            bean.setTarget(rs.getString("piv_target"));
            bean.setStd_createBy(rs.getString("std_createby"));
            bean.setStatus(rs.getInt("piv_status"));
        }
        
        System.out.println(" Query :"+rs.getStatement().toString());
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    protected ArrayList viewInventoryTrxVerifyIN(String ownerid, String storeCode, java.util.Date from, java.util.Date to)
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder(" select distinct piv_trxdocno,  piv_trxtype, piv_trxdate,   piv_owner, piv_owner_type, piv_storecode, piv_target, std_createby, piv_status  from product_inventory   where piv_status = ? and piv_trxtype in (?)  ")).append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").append(" order by piv_trxtype ").toString();
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setInt(++counter, 100);
        stmt.setString(++counter, "STAI");
        
        if(from != null)
            stmt.setDate(++counter, new Date(from.getTime()));
        if(to != null)
            stmt.setDate(++counter, new Date(to.getTime()));
        if(ownerid != null)
            stmt.setString(++counter, ownerid);
        if(storeCode != null)
            stmt.setString(++counter, storeCode);
        
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new InventoryBean();
            bean.setTrnxDocNo(rs.getString("piv_trxdocno"));
            bean.setTrnxType(rs.getString("piv_trxtype"));
            bean.setTrnxDate(rs.getDate("piv_trxdate"));
            bean.setOwnerID(rs.getString("piv_owner"));
            bean.setOwnerType(rs.getString("piv_owner_type"));
            bean.setStoreCode(rs.getString("piv_storecode"));
            bean.setTarget(rs.getString("piv_target"));
            bean.setStd_createBy(rs.getString("std_createby"));
            bean.setStatus(rs.getInt("piv_status"));
        }
        
        // System.out.println(" Query :"+rs.getStatement().toString());
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    
    protected StockMovementRptBean getStockMovementByProduct(String ownerId, String storeCode, java.util.Date from, java.util.Date to, ProductBean productList[])
    throws Exception {
        StockMovementRptBean report;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        ResultSet rs;
        String SQL_MOVEMENT_BAL;
        String SQL_MOVEMENT_RPT;
        // 4. Connection conn = null;
        stmt = null;
        stmt2 = null;
        rs = null;
        
        report = new StockMovementRptBean();
        boolean hasOwner = ownerId != null && ownerId.length() > 0;
        boolean hasStore = storeCode != null && storeCode.length() > 0;
        boolean hasdate = from != null && to != null;
        SQL_MOVEMENT_BAL = (new StringBuilder("select sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_productid = ?  and piv_trxdate < ?  and piv_owner in ('")).append(ownerId).append("') ").append(hasStore ? (new StringBuilder(" and piv_storecode in ('")).append(storeCode).append("') ").toString() : "").append(" and piv_status = ? ").toString();
        SQL_MOVEMENT_RPT = (new StringBuilder("select piv_owner, piv_productid, piv_trxtype, piv_trxdate, sum(piv_in) as qtyin, sum(piv_out) as qtyout  from product_inventory where  piv_owner in ('")).append(ownerId).append("') ").append(hasStore ? (new StringBuilder(" and piv_storecode in ('")).append(storeCode).append("') ").toString() : "").append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(" and piv_productid = ? and piv_status = ? ").append("group by piv_trxtype order by piv_trxdate, piv_trxtime").toString();
        // 2010-01-27
        // SQL_MOVEMENT_RPT = (new StringBuilder("select piv_owner, piv_productid, piv_trxtype, piv_trxdate, sum(piv_in) as qtyin, sum(piv_out) as qtyout  from product_inventory Left Join product_master ON product_inventory.piv_productid = product_master.pmp_productid  where  piv_owner in ('")).append(ownerId).append("') ").append(hasStore ? (new StringBuilder(" and piv_storecode in ('")).append(storeCode).append("') ").toString() : "").append(from == null ? "" : " and piv_trxdate >= ? ").append(to == null ? "" : " and piv_trxdate <= ? ").append(" and piv_productid = ? and piv_status = ? ").append("group by piv_trxtype order by product_master.pmp_catid ").toString();
        Connection conn = getConnection();
        
        
        if(from != null) {
            stmt2 = conn.prepareStatement(SQL_MOVEMENT_BAL);
            stmt2.setDate(2, new Date(from.getTime()));
            stmt2.setInt(3, 100);
        }
        
        
        stmt = conn.prepareStatement(SQL_MOVEMENT_RPT);
        
        
        for(int i = 0; i < productList.length; i++) {
            
            int counter = 0;
            int In = 0;
            int Out = 0;
            
            // System.out.println(" 4. product "+ productList[i].getSkuCode() + " brand "+productList[i].getCatID() + " product Desc "+ productList[i].getName()+ " Prod Status "+ productList[i].getProductSelling());
            
            if(from != null)
                stmt.setDate(++counter, new Date(from.getTime()));
            if(to != null)
                
                stmt.setDate(++counter, new Date(to.getTime()));
            stmt.setInt(++counter, productList[i].getProductID());
            stmt.setInt(++counter, 100);
            rs = stmt.executeQuery();
            
            // System.out.println(" masuk sini fren 3 "+rs.getStatement().toString());
            
            StockMovementRptBean.StockInfo stockInfo = report.new StockInfo();
            stockInfo.setProduct(productList[i]);
            report.addStock(String.valueOf(productList[i].getProductID()), stockInfo);
            // report.addStock(String.valueOf(productList[i].getProductCode()), stockInfo);
            // System.out.println("Chek-2, chek SQL_MOVEMENT_RPT " + stockInfo.getItemId().toString());
            
            while(rs.next()) {
                String trxtype = rs.getString("piv_trxtype");
                
                // filter
                In = rs.getInt("qtyin");
                Out = rs.getInt("qtyout");
                if( In != 0 || Out != 0) {
                    
                    if(trxtype.equals("SKI"))
                        // stockInfo.setSalesIn(rs.getInt("qtyin"));
                        stockInfo.setSalesIn(In);
                    else
                        if(trxtype.equals("SKO"))
                            // stockInfo.setSalesOut(rs.getInt("qtyout"));
                            stockInfo.setSalesOut(Out);
                        else
                            
                            if(trxtype.equals("SKLI"))
                                // stockInfo.setLoanIn(rs.getInt("qtyin"));
                                stockInfo.setLoanIn(In);
                            else
                                if(trxtype.equals("SKLO"))
                                    // stockInfo.setLoanOut(rs.getInt("qtyout"));
                                    stockInfo.setLoanOut(Out);
                                else
                                    
                                    if(trxtype.equals("SKBO"))
                                        // stockInfo.setDisposeOut(rs.getInt("qtyout"));
                                        stockInfo.setDisposeOut(Out);
                                    else
                                        if(trxtype.equals("STEI"))
                                            //stockInfo.setTransferIn(rs.getInt("qtyin"));
                                            stockInfo.setTransferIn(In);
                                        else
                                            if(trxtype.equals("STEO"))
                                                // stockInfo.setTransferOut(rs.getInt("qtyout"));
                                                stockInfo.setTransferOut(Out);
                                            else
                                                
                                                // Update Allocate
                                                if(trxtype.equals("STAI"))
                                                    // stockInfo.setAllocateIn(rs.getInt("qtyin"));
                                                    stockInfo.setAllocateIn(In);
                                                else
                                                    if(trxtype.equals("STAO"))
                                                        // stockInfo.setAllocateOut(rs.getInt("qtyout"));
                                                        stockInfo.setAllocateOut(Out);
                                                    else
                                                        
                                                        if(trxtype.equals("STII"))
                                                            // stockInfo.setTransferIn(stockInfo.getTransferIn() + rs.getInt("qtyin"));
                                                            stockInfo.setTransferIn(stockInfo.getTransferIn() + In);
                                                        else
                                                            if(trxtype.equals("STIO"))
                                                                //stockInfo.setTransferOut(stockInfo.getTransferOut() + rs.getInt("qtyout"));
                                                                stockInfo.setTransferOut(stockInfo.getTransferOut() + Out);
                                                            else
                                                                if(trxtype.equals("SKLO"))
                                                                    // stockInfo.setLoanOut(rs.getInt("qtyout"));
                                                                    stockInfo.setLoanOut(Out);
                                                                else
                                                                    if(trxtype.equals("SKPO"))
                                                                        // stockInfo.setPurchaseOut(rs.getInt("qtyout"));
                                                                        stockInfo.setPurchaseOut(Out);
                                                                    else
                                                                        if(trxtype.equals("SKPI"))
                                                                            // stockInfo.setPurchaseIn(rs.getInt("qtyin"));
                                                                            stockInfo.setPurchaseIn(In);
                                                                        else
                                                                            if(trxtype.equals("SKDO"))
                                                                                // stockInfo.setDiscrOut(rs.getInt("qtyout"));
                                                                                stockInfo.setDiscrOut(Out);
                                                                            else
                                                                                if(trxtype.equals("SKDI"))
                                                                                    //stockInfo.setDiscrIn(rs.getInt("qtyin"));
                                                                                    stockInfo.setDiscrIn(In);
                                                                                else
                                                                                    if(trxtype.equals("SKCO"))
                                                                                        // stockInfo.setFreeOut(rs.getInt("qtyout"));
                                                                                        stockInfo.setFreeOut(Out);
                    
                    
                } // filter
                
            }
            
            if(from != null) {
                stmt2.setString(1, stockInfo.getItemId());
                ResultSet rs2 = stmt2.executeQuery();
                int forwardBalance = 0;
                
                // System.out.println(" Check query stmt2 : "+rs2.getStatement().toString());
                if(rs2.next())
                    // filter
                    forwardBalance = rs2.getInt(1);
                if(rs2.getInt(1) != 0) {
                    // stockInfo.setBringForwardBalance(rs2.getInt(1));
                    stockInfo.setBringForwardBalance(forwardBalance);
                    // System.out.println(" masuk sini fren 4 "+rs2.getStatement().toString());
                }
            }
        }
        
        // try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        // catch(Exception exception2) { }
        return report;
    }
    
    // 2010-02-12
    protected ArrayList getCatList()
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "SELECT  pcp_default_msg FROM product_category order by pcp_catid";
        
        try {
            stmt = getConnection().prepareStatement(SQL);
            for(rs = stmt.executeQuery(); rs.next();) {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCatList --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    public ArrayList getProductCategoryList(String locale)
    throws MvcException, SQLException {
        ArrayList list;
        String SQL;
        String Order;
        PreparedStatement stmt;
        ResultSet rs;
        String type;
        list = new ArrayList();
        String fields = "pcp_catid, pcp_default_msg, pcp_order_seq, pcp_status, pcd_catid, pcd_name";
        SQL = (new StringBuilder(" select ")).append(fields).append(" from product_category left join product_category_desc on ").append(" pcp_catid=pcd_catid and pcd_locale=? where pcp_status=? ").toString();
        Order = " order by pcp_order_seq ";
        stmt = null;
        rs = null;
        type = "A";
        try {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Order).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            stmt.setString(2, type);
            rs = stmt.executeQuery();
            int count = 0;
            ProductCategoryBean catBean;
            for(; rs.next(); list.add(catBean)) {
                count++;
                catBean = new ProductCategoryBean();
                catBean.setLocale(locale);
                catBean.parseBean(rs, "");
            }
            
            System.out.println(" Sampai disini " +rs.getStatement());
            
        } catch(SQLException sqlex) {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Category List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_230;
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
        return list;
    }
    
    protected ArrayList getSalesOutletList()
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select distinct(otl_outletid) from outlet where otl_outletid <> 'PT' order by otl_outletid";
        try {
            stmt = getConnection().prepareStatement(SQL);
            for(rs = stmt.executeQuery(); rs.next();) {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }
            
        }
        
        
        catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesOutletList --> ")).append(e.toString()).toString());
        }
        
        System.out.println(" Sampai di getSales " +rs.getStatement());
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    
}
