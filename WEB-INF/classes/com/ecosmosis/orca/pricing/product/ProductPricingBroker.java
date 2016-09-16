// Decompiled by Yody
// File : ProductPricingBroker.class

package com.ecosmosis.orca.pricing.product;

import com.ecosmosis.common.currency.CurrencyRateBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductDescriptionBean;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.pricing.product:
//            ProductPricingBean

public class ProductPricingBroker extends DBTransactionBroker
{

    protected ProductPricingBroker(Connection con)
    {
        super(con);
    }

    //public ArrayList getProductPricingList(String pricecode, java.util.Date date, String locale)
    public ArrayList getProductPricingList(String pricecode, java.util.Date date, String locale, int jumlah)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        // tambah group by pmp_productcode order by pmp_productcode, krn 1 price 1 productcode
        // SQL = " select * from product_master left join product_category on pmp_catid=pcp_catid  left join product_category_desc on pmp_catid=pcd_catid and pcd_locale=?  where pmp_status=? group by pmp_productcode order by pmp_productcode ";
        // filter yg ada Qty
        SQL = " select * from product_master left join product_category on pmp_catid=pcp_catid  left join product_category_desc on pmp_catid=pcd_catid and pcd_locale=? "+
              " left join (select piv_productid, sum(piv_in) - sum(piv_out) as balance from product_inventory  where piv_status = 100   group by piv_productid ) as inventory  "+
              " on inventory.piv_productid = product_master.pmp_productid where pmp_status=?  and inventory.balance > 0 group by pmp_productcode order by pmp_productcode limit ? ";
              
        stmt = null;
        rs = null;
        // java.util.Date waktu =  null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            stmt.setString(2, "A");
            stmt.setInt(3, jumlah);
            // stmt.setQueryTimeout(600);
            
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean productBean;
            //chek waktu proses
            //System.out.println("Proses getProductPricingList : ");                            
            //System.out.println("Mulai : "+date.getTime());
            
            for(; rs.next(); list.add(productBean))
            {
                count++;
                productBean = new ProductBean();
                ProductCategoryBean categoryBean = new ProductCategoryBean();
                productBean.parseBean(rs, "");
                productBean.setProductCategory(categoryBean);
                productBean.getProductCategory().parseBean(rs, "");
            }
           // System.out.println("Akhir : "+date.getTime());

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Price Code --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }      
    

    public ProductPricingBean getActivePermanentPricing(String productcode, String pricecode)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bean = new ProductPricingBean();
        // SQL = " select * from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=? and ppi_startdate <= now() and ppi_enddate >= now() order by product_pricing.ppi_promotional desc, product_pricing.std_createdate DESC, std_createtime DESC  limit 1  ";
        SQL = " select * from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_status=? and ppi_startdate <= now() and ppi_enddate >= now() order by product_pricing.ppi_promotional desc, product_pricing.std_createdate DESC, std_createtime DESC  limit 1  ";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, productcode);
            stmt.setString(2, pricecode);
            // stmt.setString(3, "N");
            stmt.setString(3, "A");
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean.parseBean(rs, "");
                
                // System.out.println("No. "+count+ "     Product Code :"+ productcode );

            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
   
    public ProductPricingBean getActivePermanentPricingDodi(String productID, String tanggal, String lokasi)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        // SQL_get = "select * from product_pricing where ppi_status = 'A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and ppi_productid=?  ";
        SQL_get = " SELECT product_pricing.* " +
            "FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= 'en_US'  " +
            "left join product_category on pmp_catid = pcp_catid " +
            "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= 'en_US' " +
            "left join product_pricing on pmp_productcode = ppi_productcode " +
            "where pmp_status='A' and ppi_pricecode='RTL' and ppi_startdate <= ? and ppi_enddate >= ? and LOCATNID= ? and ppi_productcode= ?  order by product_pricing.std_createdate DESC limit 1 ";        
        
        
        try
        {
            System.out.println("Masuk Pricing HE, Product ID : " + productID + " tanggal : " + tanggal + " lokasi : " + lokasi );
            
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, tanggal);
            stmt.setString(2, tanggal);
            stmt.setString(3, lokasi);
            stmt.setString(4, productID);
            
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }    
     
    
    public ProductPricingBean getActivePermanentPricingUpdate(String productcode, String pricecode, String lokasi)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bean = new ProductPricingBean();
        SQL = " select * from product_pricing  where ppi_productcode=?  and ppi_pricecode=? and ppi_promotional=? and ppi_status=? and LOCATNID = ?  ";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, productcode);
            stmt.setString(2, pricecode);
            stmt.setString(3, "N");
            stmt.setString(4, "A");
            stmt.setString(5, lokasi);
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean.parseBean(rs, "");
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing + lokasi Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    
    public ProductPricingBean getActivePermanentPricingUpdateDua(String productcode, String pricecode, String lokasi, java.util.Date effectiveDate)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bean = new ProductPricingBean();
        SQL = " select * from product_pricing  where ppi_productcode=?  and ppi_pricecode=? and ppi_promotional=? and ppi_status=? and LOCATNID = ? and ppi_startdate <= ? and ppi_enddate >=  ?  ";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, productcode);
            stmt.setString(2, pricecode);
            stmt.setString(3, "N");
            stmt.setString(4, "A");
            stmt.setString(5, lokasi);
            stmt.setDate(6, new Date(effectiveDate.getTime()));
            stmt.setDate(7, new Date(effectiveDate.getTime()));
            
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean.parseBean(rs, "");
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Update Dua ... Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public ProductPricingBean getLatestPromotionalPricing(String productid, String pricecode)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bean = new ProductPricingBean();
        // awal SQL = " select * from product_pricing  where ppi_productid=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=?  order by ppi_startdate desc limit 1 ";
        SQL = " select * from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=?  order by ppi_startdate desc limit 1 ";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, productid);
            stmt.setString(2, pricecode);
            stmt.setString(3, "Y");
            stmt.setString(4, "A");
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean.parseBean(rs, "");
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public ProductPricingBean getCurrentPricing(String productCode, String priceCodeID, java.util.Date effectiveDate)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_current;
        bean = null;
        stmt = null;
        rs = null;
        // awal
        // SQL_current = "select * from product_pricing where ppi_productid=? and ppi_pricecode=? and ppi_status=? and ppi_startdate <= ? and ppi_enddate >= ? and ppi_promotional=?";
        SQL_current = "select * from product_pricing where ppi_productcode=? and ppi_pricecode=? and ppi_status=? and ppi_startdate <= ? and ppi_enddate >= ? and ppi_promotional=?";
        try
        {
            boolean found = false;
            stmt = getConnection().prepareStatement(SQL_current);
            stmt.setString(1, productCode);
            stmt.setString(2, priceCodeID);
            stmt.setString(3, "A");
            stmt.setDate(4, new Date(effectiveDate.getTime()));
            stmt.setDate(5, new Date(effectiveDate.getTime()));
            stmt.setString(6, "Y");
            rs = stmt.executeQuery();
            if(rs.next())
                found = true;
            if(!found)
            {
                stmt.setString(6, "N");
                rs = stmt.executeQuery();
                if(rs.next())
                    found = true;
            }
            if(found)
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public int getPromotionalPricingCount(String productid, String pricecode)
        throws MvcException, SQLException
    {
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        int promotionalCount;
        // awal SQL = " select count(*) from product_pricing  where ppi_productid=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=? ";
        SQL = " select count(*) from product_pricing  where ppi_productcode=? and ppi_pricecode=? and ppi_promotional=? and ppi_status=? ";
        stmt = null;
        rs = null;
        promotionalCount = 0;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, productid);
            stmt.setString(2, pricecode);
            stmt.setString(3, "Y");
            stmt.setString(4, "A");
            rs = stmt.executeQuery();
            if(rs.next())
                promotionalCount = rs.getInt(1);
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return promotionalCount;
    }

    public ArrayList getPricingHistory(String pricecode, int productID, String type)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_pricing   left join product_master on ppi_productid=pmp_productid  where ppi_pricecode = ? and ppi_productid = ? and ppi_promotional=?";
        stmt = null;
        rs = null;
        try
        {
            int cnt = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++cnt, pricecode);
            stmt.setInt(++cnt, productID);
            stmt.setString(++cnt, type);
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean productBean;
            for(; rs.next(); list.add(productBean))
            {
                count++;
                productBean = new ProductBean();
                ProductPricingBean pricingBean = new ProductPricingBean();
                productBean.parseBean(rs, "");
                productBean.setCurrentPricing(pricingBean);
                productBean.getCurrentPricing().parseBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing List --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public ArrayList getPricingHistory(String pricecode, String type)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_pricing   left join product_master on ppi_productid=pmp_productid  where ppi_pricecode = ? and ppi_promotional=? ";
        stmt = null;
        rs = null;
        try
        {
            int cnt = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++cnt, pricecode);
            stmt.setString(++cnt, type);
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean productBean;
            for(; rs.next(); list.add(productBean))
            {
                count++;
                productBean = new ProductBean();
                ProductPricingBean pricingBean = new ProductPricingBean();
                productBean.parseBean(rs, "");
                productBean.setCurrentPricing(pricingBean);
                productBean.getCurrentPricing().parseBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing List --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public ProductPricingBean getProductPricing(int productID, int pricingID)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from product_pricing where ppi_productid=? and ppi_pricingid=?";
        try
        {
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setInt(1, productID);
            stmt.setInt(2, pricingID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
    
    public ProductPricingBean getProductPricingHE(String productID, int pricingID)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from product_pricing where ppi_productcode=? and ppi_pricingid=?";
        try
        {
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, productID);
            stmt.setInt(2, pricingID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing HE --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
        

    public ProductPricingBean getIdProductPricing(int productID)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from product_pricing where ppi_status = 'A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and ppi_productid=?  ";
        
        try
        {
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setInt(1, productID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
    
    public ProductPricingBean getIdProductPricingUpdate(int productID, String tanggal, String lokasi)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        // SQL_get = "select * from product_pricing where ppi_status = 'A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and ppi_productid=?  ";
        SQL_get = " SELECT product_pricing.* " +
            "FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= 'en_US'  " +
            "left join product_category on pmp_catid = pcp_catid " +
            "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= 'en_US' " +
            "left join product_pricing on pmp_productid = ppi_productid " +
            "where pmp_status='A' and ppi_pricecode='RTL' and ppi_startdate <= ? and ppi_enddate >= ? and LOCATNID= ? and ppi_productid= ?  order by product_pricing.std_createdate DESC limit 1 ";        
        
        
        try
        {
            System.out.println("Masuk Pricing, ID : " + productID + " tanggal : " + tanggal + " lokasi : " + lokasi );
            
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, tanggal);
            stmt.setString(2, tanggal);
            stmt.setString(3, lokasi);
            stmt.setInt(4, productID);
            
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public ProductPricingBean getIdProductPricingUpdateHE(String productID, String tanggal, java.util.Date waktu, String lokasi)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        // gunakan National Price
        SQL_get = " SELECT product_pricing.* " +
            "FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= 'en_US'  " +
            "left join product_category on pmp_catid = pcp_catid " +
            "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= 'en_US' " +
            "left join product_pricing on pmp_productcode = ppi_productcode " +
            "where pmp_status='A' and ppi_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and (concat(ppi_startdate,?,ppi_starttime) <= ? and concat(ppi_enddate,?,ppi_endtime) >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 "; //Updated By Ferdi 2015-04-23
            //"where pmp_status='A' and ppi_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and (ppi_startdate <= ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 "; //Updated By Ferdi 2015-04-23
            // "where pmp_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and if(ppi_startdate = ? and  ppi_enddate = ?,  (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?), if(ppi_startdate = ? and ppi_enddate > ? , (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? ), if(ppi_startdate < ? and ppi_enddate  = ? , (ppi_startdate <= ? and ppi_enddate = ? and ppi_endtime >= ? ), (ppi_startdate <= ? and ppi_enddate >= ? )))) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 ";                         
        
        try
        {
            // System.out.println("Masuk Pricing HE, Product ID : " + productID + " tanggal : " + tanggal + " waktu : " + waktu + " lokasi : " + lokasi );
            
            stmt = getConnection().prepareStatement(SQL_get);            
            stmt.setString(1, productID);

            //Updated By Ferdi 2015-04-23
            stmt.setString(2, " ");
            stmt.setString(3, tanggal + " " + waktu);
            stmt.setString(4, " ");
            stmt.setString(5, tanggal + " " + waktu);
            //End Updated
            
            /*
            // if 1
            stmt.setString(2, tanggal);
            stmt.setString(3, tanggal);
            
            stmt.setString(4, tanggal);
            stmt.setTime(5, (Time) waktu);
            stmt.setString(6, tanggal);
            stmt.setTime(7, (Time) waktu);

            // if 2
            stmt.setString(8, tanggal);
            stmt.setString(9, tanggal);
            
            stmt.setString(10, tanggal);  
            stmt.setTime(11, (Time) waktu);
            stmt.setString(12, tanggal);  
            
            // if 3
            stmt.setString(13, tanggal);
            stmt.setString(14, tanggal);
            
            stmt.setString(15, tanggal);              
            stmt.setString(16, tanggal); 
            stmt.setTime(17, (Time) waktu);

            // else
            stmt.setString(18, tanggal);
            stmt.setString(19, tanggal);            
            */
            
            rs = stmt.executeQuery();
            System.out.println("Query Price : "+ stmt);
            // System.out.println("Query Process "+productID);
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }    
    

    public ProductPricingBean getIdProductPricingUpdateHEForce(String productID, String tanggal, java.util.Date waktu, String lokasi)
        throws MvcException, SQLException
    {
        ProductPricingBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        // SQL_get = "select * from product_pricing where ppi_status = 'A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and ppi_productid=?  ";
        SQL_get = " SELECT product_pricing.* " +
            "FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= 'en_US'  " +
            "left join product_category on pmp_catid = pcp_catid " +
            "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= 'en_US' " +
            "left join product_pricing on pmp_productcode = ppi_productcode " +
            "where pmp_status='A' and ppi_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and (concat(ppi_startdate,?,ppi_starttime) <= ? and concat(ppi_enddate,?,ppi_endtime) >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 "; //Updated By Ferdi 2015-04-23
            //"where pmp_status='A' and ppi_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and (ppi_startdate <= ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 "; //Updated By Ferdi 2015-04-23                                 
        
            // "where pmp_status='A' and ppi_pricecode='RTL' and ppi_productcode= ?  and if(ppi_startdate = ? and  ppi_enddate = ?,  (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? and  ppi_endtime >= ?), if(ppi_startdate = ? and ppi_enddate > ? , (ppi_startdate = ? and ppi_starttime <= ? and ppi_enddate >= ? ), if(ppi_startdate < ? and ppi_enddate  = ? , (ppi_startdate <= ? and ppi_enddate = ? and ppi_endtime >= ? ), (ppi_startdate <= ? and ppi_enddate >= ? )))) order by product_pricing.ppi_promotional DESC, product_pricing.std_createdate DESC, std_createtime DESC limit 1 ";                         
        
        
        try
        {
            // System.out.println("Masuk Pricing HE Force, Product ID : " + productID + " tanggal : " + tanggal + " lokasi : " + lokasi );
            
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, productID);
            
            //Updated By Ferdi 2015-04-23
            stmt.setString(2, " ");
            stmt.setString(3, tanggal + " " + waktu);
            stmt.setString(4, " ");
            stmt.setString(5, tanggal + " " + waktu);
            //End Updated
            
            /*
            // if 1
            stmt.setString(2, tanggal);
            stmt.setString(3, tanggal);
            
            stmt.setString(4, tanggal);
            stmt.setTime(5, (Time) waktu);
            stmt.setString(6, tanggal);
            stmt.setTime(7, (Time) waktu);

            // if 2
            stmt.setString(8, tanggal);
            stmt.setString(9, tanggal);
            
            stmt.setString(10, tanggal);  
            stmt.setTime(11, (Time) waktu);
            stmt.setString(12, tanggal);  
            
            // if 3
            stmt.setString(13, tanggal);
            stmt.setString(14, tanggal);
            
            stmt.setString(15, tanggal);              
            stmt.setString(16, tanggal); 
            stmt.setTime(17, (Time) waktu);

            // else
            stmt.setString(18, tanggal);
            stmt.setString(19, tanggal);            
            */
            
            rs = stmt.executeQuery();
            // System.out.println("Query Force "+stmt);
            System.out.println("Query Process "+productID);
            
            if(rs.next())
            {
                bean = new ProductPricingBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Current Product Pricing --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }    
        
    public CurrencyRateBean getRateUpdate(String tanggal)
        throws MvcException, SQLException
    {
        CurrencyRateBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from currency_exchange_rate where cer_currencyid = 'SGD' and cer_exchange='SGD-SELL-HE' and cer_startdate <= ? and cer_enddate >= ? order by cer_startdate desc, cer_endtime desc  limit 1 ";
        
        try
        {
            System.out.println("Masuk getRateUpdate, tanggal : " + tanggal );
            
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, tanggal);
            stmt.setString(2, tanggal);
            
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new CurrencyRateBean();
                bean.parseBean2(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading getRateUpdate --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
    
    public CurrencyRateBean getRateUpdate2(String tanggal)
        throws MvcException, SQLException
    {
        CurrencyRateBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from currency_exchange_rate where cer_currencyid = 'USD' and cer_exchange='USD-SELL-HE' and cer_startdate <= ? and cer_enddate >= ? order by cer_startdate desc, cer_endtime desc  limit 1 ";
        
        try
        {
            System.out.println("Masuk getRateUpdate2, tanggal : " + tanggal );
            
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, tanggal);
            stmt.setString(2, tanggal);
            
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new CurrencyRateBean();
                bean.parseBean2(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading getRateUpdate --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
    
    
    public ProductBean getProduct(String productid, String locale)
        throws MvcException, SQLException
    {
        ProductBean bean;
        ProductDescriptionBean descBean;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bean = new ProductBean();
        descBean = new ProductDescriptionBean();
        SQL = " select * from product_master  left join product_desc on pmp_productid=pdp_productid and pdp_locale=?  where pmp_productid=? ";
        stmt = null;
        rs = null;
        try
        {
            int count = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++count, locale);
            stmt.setString(++count, productid);
            rs = stmt.executeQuery();
            int icount = 0;
            if(rs.next())
            {
                icount++;
                bean.parseBean(rs, "");
                bean.setProductDescription(descBean);
                bean.getProductDescription().parseBean(rs, "");
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public boolean updateProductPricing(ProductPricingBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String SQL;
        status = false;
        stmt1 = null;
        SQL = " update product_pricing set  ppi_status = ?  where ppi_pricingid = ? and ppi_promotional = ? ";
        int count = 0;
        stmt1 = getConnection().prepareStatement(SQL);
        stmt1.setString(++count, bean.getStatus());
        stmt1.setInt(++count, bean.getPricingID());
        stmt1.setString(++count, bean.getPromotional());
        status = stmt1.executeUpdate() == 1;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    public int checkExistPromotional(int productid, String pricecode, java.util.Date startDate)
        throws MvcException, SQLException
    {
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        int promotionalCount;
        SQL = " select count(*) from product_pricing  where ppi_productid=? and ppi_pricecode=? and ppi_status=? and ppi_promotional=? and ppi_startdate <= ? and ppi_enddate >= ?  ";
        stmt = null;
        rs = null;
        promotionalCount = 0;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, productid);
            stmt.setString(2, pricecode);
            stmt.setString(3, "A");
            stmt.setString(4, "Y");
            stmt.setDate(5, new Date(startDate.getTime()));
            stmt.setDate(6, new Date(startDate.getTime()));
            rs = stmt.executeQuery();
            if(rs.next())
                promotionalCount = rs.getInt(1);
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Pricing Info --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return promotionalCount;
    }

    public boolean addProductPricing(ProductPricingBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String SQL;
        status = false;
        stmt1 = null;
        String fields = "(ppi_pricecode,ppi_productid,ppi_promotional,ppi_status,ppi_startdate,ppi_enddate,ppi_price,ppi_tax,ppi_bv1,ppi_bv2,ppi_bv3,ppi_bv4,ppi_bv5) ";
        SQL = (new StringBuilder(" insert into product_pricing ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        int cnt = 0;
        stmt1 = getConnection().prepareStatement(SQL);
        stmt1.setString(++cnt, bean.getPriceCode());
        stmt1.setInt(++cnt, bean.getProductID());
        stmt1.setString(++cnt, bean.getPromotional());
        stmt1.setString(++cnt, bean.getStatus());
        stmt1.setDate(++cnt, new Date(bean.getStartDate().getTime()));
        stmt1.setDate(++cnt, new Date(bean.getEndDate().getTime()));
        stmt1.setDouble(++cnt, bean.getPrice());
        stmt1.setDouble(++cnt, bean.getTax());
        stmt1.setDouble(++cnt, bean.getBv1());
        stmt1.setDouble(++cnt, bean.getBv2());
        stmt1.setDouble(++cnt, bean.getBv3());
        stmt1.setDouble(++cnt, bean.getBv4());
        stmt1.setDouble(++cnt, bean.getBv5());
        status = stmt1.executeUpdate() == 1;

        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    //Updated By Ferdi 2015-06-18
    public double getCurrentSGDRate()
        throws MvcException, SQLException
    {
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        double rate;
        SQL = "SELECT " + 
                        "cer_rate " +
            "FROM " + 
                        "currency_exchange_rate " +
            "WHERE " + 
                        "cer_startdate <= CURRENT_DATE() AND " + 
                        "cer_enddate >= CURRENT_DATE() AND " +
                        "cer_currencyid = 'SGD' AND " +
                        "cer_exchange = 'SGD-SELL-HE' " +
            "ORDER BY " +
                        "cer_startdate DESC, cer_endtime DESC " +
            "LIMIT 1 ";
        stmt = null;
        rs = null;
        rate = 0d;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            rs = stmt.executeQuery();
            if(rs.next())
                rate = rs.getDouble(1);
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading getCurrentSGDRate --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return rate;
    }
    //End Updated

   public CurrencyRateBean getRateMultiCurrency(String currencyid)
        throws MvcException, SQLException
    {
        CurrencyRateBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_get;
        bean = null;
        stmt = null;
        rs = null;
        SQL_get = "select * from currency_exchange_rate where cer_currencyid = ? and now() between cer_startdate and cer_enddate order by cer_startdate desc, cer_endtime desc  limit 1 ";
        
        try
        {                        
            stmt = getConnection().prepareStatement(SQL_get);
            stmt.setString(1, currencyid);
            
            // System.out.println("Masuk getRateMultiCurrency, tanggal : " + tanggal + " currency : " +currencyid );
            System.out.println("Masuk getRateMultiCurrency : " + stmt.toString() );              
            
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new CurrencyRateBean();
                bean.parseBean2(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading getRateUpdate --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }
   
}
