// Decompiled by Yody
// File : InventoryBroker.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.orca.outlet.OutletBean;
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
//            InventoryBean

public class InventoryBroker_1 extends DBTransactionBroker
{

    protected InventoryBroker_1(Connection con)
    {
        super(con);
    }

    protected InventoryBean viewStoreInventory(int productId, String ownerid, String storeCode)
        throws MvcException, SQLException
    {
        String SQL_getRecord;
        InventoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        SQL_getRecord = (new StringBuilder("select sum(piv_in) as StockIn, sum(piv_out) as StockOut  from product_inventory  where piv_status = ?  and  piv_productid = ? ")).append(ownerid == null ? "" : " and piv_owner = ? ").append(storeCode == null ? "" : " and piv_storecode = ? ").toString();
        bean = new InventoryBean();
        stmt = null;
        rs = null;
        try
        {
            int counter = 0;
            stmt = getConnection().prepareStatement(SQL_getRecord);
            stmt.setInt(++counter, 100);
            stmt.setInt(++counter, productId);
            if(ownerid != null)
                stmt.setString(++counter, ownerid);
            if(storeCode != null)
                stmt.setString(++counter, storeCode);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean.setTotalIn(rs.getInt("StockIn"));
                bean.setTotalOut(rs.getInt("StockOut"));
                bean.setTotal(bean.getTotalIn() - bean.getTotalOut());
            }
            
            System.out.println("SQL : "+rs.getStatement().toString());
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while getting Inventory balance --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    protected boolean addRecord(InventoryBean inventoryBean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "(piv_trxdate, piv_trxtime, piv_owner, piv_owner_type, piv_owner_remark, piv_storecode, piv_productid, piv_skucode, piv_productcode, piv_producttype, piv_trxdocno, piv_trxdoctype, piv_trxtype, piv_in,piv_out, piv_batchno, piv_salesid, piv_deliveryid, piv_target, piv_target_type, piv_target_remark, piv_remark,piv_process_status, piv_status,  std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  )";
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
        
        stmt.setString(++counter, inventoryBean.getProductSerial());
        stmt.setString(++counter, inventoryBean.getProductCode());
        
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
        
        // System.out.println("update "+rs.getStatement());
        
        if(rs != null && rs.next())
            inventoryBean.setInventoryID(rs.getInt(1));

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
    }

    protected boolean updateDocRecord(InventoryBean inventoryBean)
        throws MvcException, SQLException
    {
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

        if(stmt != null)
            stmt.close();
        return status;
    }
    

    protected boolean updateDocRecordTW(InventoryBean inventoryBean, String kode)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        String[] awal = null;
        String ganti = null;
        String nomor = null;
        status = false;
        stmt = null;
        awal = inventoryBean.getTrnxDocNo().split("/");
        ganti = kode.concat("/TW-MCH/");
        nomor = ganti.concat(awal[2]).concat("/").concat(awal[3]);
        
        // System.out.println("nomor pengganti :"+nomor);
                
        SQL = "update product_inventory  set piv_trxdocno = ?,  piv_trxdoctype = ?   where piv_inventoryid = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        // stmt.setString(++counter, inventoryBean.getTrnxDocNo());
        stmt.setString(++counter, nomor);
        stmt.setString(++counter, inventoryBean.getTrnxDocType());
        stmt.setInt(++counter, inventoryBean.getInventoryID());
        status = stmt.executeUpdate() > 0;
        /*
        break MISSING_BLOCK_LABEL_101;
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
        
    protected boolean updateDocRecordTW2(String refNo, String docType, OutletBean outletBean)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        String[] awal = null;
        String ganti = null;
        String nomor = null;
        String kode = null;
        int panjang = 0;
        status = false;
        stmt = null;

        awal = refNo.split("/");        
        kode = Integer.toString(outletBean.getSeqID());
        panjang = kode.length();                
        
        if(panjang==1)
          kode = "0".concat(kode);
                
        ganti = kode.concat("/TW-MCH/");
        nomor = ganti.concat(awal[2]).concat("/").concat(awal[3]);
        
        System.out.println("nomor pengganti :"+nomor);
                
        SQL = "update product_inventory  set piv_trxdocno = ?,  piv_trxdoctype = ?   where piv_trxdocno = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        // stmt.setString(++counter, inventoryBean.getTrnxDocNo());
        stmt.setString(++counter, nomor);
        stmt.setString(++counter, docType);
        stmt.setString(++counter, refNo);
        status = stmt.executeUpdate() > 0;

        if(stmt != null)
            stmt.close();
        return status;
    }
    
    protected boolean updateTW(String DocNo, int statusDoc, String trxType, String user)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        String SQL;
        String SQL2;
        String trxType2;
        status = false;
        stmt = null;
        stmt2 = null;
        
        System.out.println("Masuk 1 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType);
               
        if(statusDoc == 90)        
        {
        SQL = "update product_inventory  set piv_status = ? , std_modifyby = ? where piv_trxdocno = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setInt(++counter, 100);
        stmt.setString(++counter, user);
        stmt.setString(++counter, DocNo);
        status = stmt.executeUpdate() > 0;            
        
        System.out.println("Masuk 2 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType+" SQL"+ stmt.toString());
        
        }else{            
        SQL = "update product_inventory  set  piv_trxtype = ? , std_modifyby = ? where piv_trxdocno = ?  and piv_trxtype = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, trxType.equalsIgnoreCase("STAI")? "STEI" : "STEO");
        stmt.setString(++counter, user);
        stmt.setString(++counter, DocNo);
        stmt.setString(++counter, trxType);
        status = stmt.executeUpdate() > 0;
        
        System.out.println("Masuk 3 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType+" SQL"+ stmt.toString());
        
        if(trxType.equalsIgnoreCase("STAO"))
        {
            trxType2 = "STAI";
        }else{
            trxType2 = "STAO";
        } 
        
        int counter2 = 0;
        SQL2 = "update product_inventory  set  piv_trxtype = ? , std_modifyby = ? where piv_trxdocno = ?  and piv_trxtype = ? ";
        stmt2 = getConnection().prepareStatement(SQL2);
        stmt2.setString(++counter2, trxType2.equalsIgnoreCase("STAI")? "STEI" : "STEO");
        stmt2.setString(++counter2, user);
        stmt2.setString(++counter2, DocNo);
        stmt2.setString(++counter2, trxType2);
        status = stmt2.executeUpdate() > 0;
        
        System.out.println("Masuk 4 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType2 "+trxType2+" SQL2 "+ stmt2.toString());
        
        }
        
        if(stmt != null)
            stmt.close();
        if(stmt2 != null)
            stmt2.close();        
        
        return status;
    }    


    protected boolean updateLOAN(String DocNo, int statusDoc, String trxType, String user)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        String trxType2;
        status = false;
        stmt = null;
        
        System.out.println("Masuk 1 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType);
               
        if(statusDoc == 90)        
        {
        SQL = "update product_inventory  set piv_status = ? , std_modifyby = ? where piv_trxdocno = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setInt(++counter, 100);
        stmt.setString(++counter, user);
        stmt.setString(++counter, DocNo);
        status = stmt.executeUpdate() > 0;            
        
        System.out.println("Masuk 2 DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType+" SQL"+ stmt.toString());
        
        }
        
        if(stmt != null)
            stmt.close();   
        
        return status;
    }    
    
    protected boolean voidTW(String DocNo, int statusDoc, String trxType, String user )
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        
        SQL = "update product_inventory  set piv_status = ? , piv_target_remark = ? , std_modifyby = ? where piv_trxdocno = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);        
        stmt.setInt(++counter, (statusDoc==90) ? 40 : 50);
        stmt.setString(++counter, (statusDoc==90) ? "Document has been VOIDED, after created document" : "Document has been VOIDED, after verified document");
        stmt.setString(++counter, user);
        stmt.setString(++counter, DocNo);
        status = stmt.executeUpdate() > 0;            
        
        System.out.println("Masuk Void DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType+" SQL"+ stmt.toString());
        
        
        if(stmt != null)
            stmt.close();
        
        return status;
    }    

    protected boolean voidLoan(String DocNo, int statusDoc, String trxType, String user )
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        
        SQL = "update product_inventory  set piv_status = ? , std_modifyby = ? where piv_trxdocno = ? ";
        int counter = 0;
        stmt = getConnection().prepareStatement(SQL);        
        stmt.setInt(++counter, (statusDoc==90) ? 40 : 50);
        stmt.setString(++counter, user);
        stmt.setString(++counter, DocNo);
        status = stmt.executeUpdate() > 0;            
        
        System.out.println("Masuk Void Loan DocNo " + DocNo +" statusDoc "+ statusDoc+ "trxType "+trxType+" SQL"+ stmt.toString());
        
        
        if(stmt != null)
            stmt.close();
        
        return status;
    }    
    
    protected ArrayList getRecordsByDocNum(String refNo, String docType, String ownerId, String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder(" select * from product_inventory  where  piv_trxdocno = ? ")).append(ownerId == null ? "" : " and piv_owner = ? ").append(docType == null ? "" : " and piv_trxtype = ? ").toString();
        int counter = 0;
        ProductManager productManager = new ProductManager();
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, refNo);
        if(ownerId != null)
            stmt.setString(++counter, ownerId);
        if(docType != null)
            stmt.setString(++counter, docType);
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
        {
            bean = new InventoryBean();
            bean.parseInventoryBean(rs, "");
            bean.setProductBean(productManager.getProduct(bean.getProductID(), locale));
        }

        System.out.println("SQL getRecordsByDocNum :"+rs.getStatement().toString());
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
      
    protected ArrayList getRecordsByDocNumTW(String refNo, String docType1, String docType2, String ownerId, String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder(" select * from product_inventory  where  piv_trxdocno = ? ")).append(ownerId == null ? "" : " and piv_owner = ? ").append(docType1 == null ? "" : " and ( piv_trxtype = ? or piv_trxtype = ? ) ").toString();
        int counter = 0;
        ProductManager productManager = new ProductManager();
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(++counter, refNo);
        if(ownerId != null)
            stmt.setString(++counter, ownerId);
        if(docType1 != null)
            stmt.setString(++counter, docType1);
        if(docType2 != null)
            stmt.setString(++counter, docType2);
        
        InventoryBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
        {
            bean = new InventoryBean();
            bean.parseInventoryBean(rs, "");
            bean.setProductBean(productManager.getProduct(bean.getProductID(), locale));
        }

        System.out.println("SQL getRecordsByDocNum :"+rs.getStatement().toString());
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    

    InventoryBean viewStoreInventory2(String docno, int i, Object object, String storeCode) {
        return null;
    }

    ArrayList getInventoryListingByDoc(String param) {
        return null;
    }

    InventoryBean getRecord(String id) {
        return null;
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
        SQL = "select distinct(otl_outletid) from outlet where otl_outletid <> 'PT' order by otl_outletid";
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

        System.out.println(" Sampai di getSales " +rs.getStatement());
         
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

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    ArrayList list = new ArrayList();
    ResultSet rs;
    PreparedStatement stmt;
    protected boolean getValidateVerifyInAndVoidApprove(String sku_kode, String lokasi){        
        boolean hasil, res = false;
        try {
                hasil = getValidateSerialNo(sku_kode, lokasi);
                if(hasil){
                    //String qVerifyInVoid = "SELECT * from product_inventory where piv_owner='" + lokasi + "' and (piv_trxtype not in('STAO','STAI') or piv_status not in (100, 90)) and piv_skucode='" + sku_kode + "'";
                    String qVerifyInVoid = "SELECT * from product_inventory where piv_owner='" + lokasi + "' and (piv_trxtype in('STAO','STAI') AND piv_status in (100, 90)) and piv_skucode='" + sku_kode + "'";
                    stmt = getConnection().prepareStatement(qVerifyInVoid);
                    ResultSet rs2 = stmt.executeQuery();
                    if(rs2.last()){                        
                        res = true;
                    }
                }                       
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return res;
    }

    protected boolean getValidateVerifyOut(String sku_kode, String lokasi){        
        boolean hasil, res = false;
        try {
                hasil = getValidateSerialNo(sku_kode, lokasi);
                if(hasil){
                    String qVerifyOut = "SELECT * from product_inventory where piv_owner='" + lokasi + "' and (piv_trxtype in('STAO', 'STAI') and piv_status = 100) and piv_skucode='" + sku_kode + "'";
                    stmt = getConnection().prepareStatement(qVerifyOut);
                    ResultSet rs2 = stmt.executeQuery();
                    if(rs2.last()){                        
                        res = true;
                    }else{
                        res = false;
                    }
                }                       
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return res;
    }
    protected boolean getValidateSerialNo(String sku_kode, String lokasi){
        boolean hasil = false;
        
        try {
            String query =  " SELECT * FROM product_inventory LEFT JOIN product_master ON piv_productid = pmp_productid WHERE piv_owner='" + lokasi + "'" +
                           " AND pmp_productcode != pmp_skucode AND piv_skucode = '" + sku_kode + "'";

            stmt = getConnection().prepareStatement(query);
            rs = stmt.executeQuery();
            if(rs.last()){
                hasil = true;
            }else{
                hasil = false;
            }
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return hasil;
    }
    
    //Updated By Mila 2016-29-02
    protected int getBalanceByProductID(String ownerID, java.util.Date trxDate, int productID){
        int balance = 0;
        try{
            String query = "select piv_productid, sum(piv_in) as StockIn ,sum(piv_out) as StockOut, " +
                    " (sum(piv_in) - sum(piv_out)) as balance from product_inventory  " +
                    " where piv_status = ? and piv_owner = ? and piv_trxdate >= ? " +
                    " and piv_productid = ? and piv_trxtype <> 'STAI' group by piv_productid";
            stmt = getConnection().prepareStatement(query);
            stmt.setString(1, "100");
            stmt.setString(2, ownerID);
            stmt.setDate(3, new Date(trxDate.getTime()));
            stmt.setInt(4, productID);
            
            System.out.println("SQL getBalanceByProductID : " + stmt.toString());
            
            for(rs = stmt.executeQuery(); rs.next();)
            {
                balance = rs.getInt("balance");
            }
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return balance;
    }
}
