// Decompiled by Yody
// File : ProductBroker.class

package com.ecosmosis.orca.product;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.product:
//            ProductBean, ProductDescriptionBean, ProductItemBean

public class ProductBroker extends DBTransactionBroker
{

    protected ProductBroker(Connection con)
    {
        super(con);
    }

    public ArrayList getProductCategoryList(String locale)
        throws MvcException, SQLException
    {
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
        try
        {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Order).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            stmt.setString(2, type);
            rs = stmt.executeQuery();
            int count = 0;
            ProductCategoryBean catBean;
            for(; rs.next(); list.add(catBean))
            {
                count++;
                catBean = new ProductCategoryBean();
                catBean.setLocale(locale);
                catBean.parseBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
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

    public ArrayList getProductList(String locale, String type, String status, String catid, String inventory, String priority, String safe, 
            int taskId)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        String Cond;
        String Order;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_master  left join product_category on pmp_catid=pcp_catid  left join product_category_desc on pmp_catid=pcd_catid and pcd_locale = ? ";
        Cond = " where pmp_type like ? and pmp_status like ? and pmp_catid like ? and pmp_inventory like ? and pmp_priority_level like ? and pmp_safe_level like ? ";
        // Order = " order by pmp_catid Asc, pmp_skucode Asc";
        Order = " order by pmp_productcode ";
        stmt = null;
        rs = null;
        try
        {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Cond).append(Order).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            stmt.setString(2, (new StringBuilder("%")).append(type).append("%").toString());
            stmt.setString(3, (new StringBuilder("%")).append(status).append("%").toString());
            stmt.setString(4, (new StringBuilder("%")).append(catid).append("%").toString());
            stmt.setString(5, (new StringBuilder("%")).append(inventory).append("%").toString());
            stmt.setString(6, (new StringBuilder("%")).append(priority).append("%").toString());
            stmt.setString(7, (new StringBuilder("%")).append(safe).append("%").toString());
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean pBean;
            for(; rs.next(); list.add(pBean))
            {
                count++;
                pBean = new ProductBean();
                pBean.setLocale(locale);
                pBean.parseSingleProductBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Single Product Listing Info --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_380;
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

    public ArrayList getProductById(String locale, String productid)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        String Cond;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_master  left join product_desc on pmp_productid=pdp_productid and pdp_locale = ?  left join product_item on  pmp_productid=pip_productid ";
        Cond = " where pmp_productid = ? ";
        stmt = null;
        rs = null;
        try
        {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Cond).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            if(productid != null && productid.length() > 0)
                stmt.setString(2, productid);
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean pBean;
            for(; rs.next(); list.add(pBean))
            {
                count++;
                pBean = new ProductBean();
                pBean.setLocale(locale);
                pBean.parseProductBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Category By Id --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_209;
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

    public ArrayList getComboProductById(String locale, String productid)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        String Cond;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_master  left join product_desc on pmp_productid=pdp_productid and pdp_locale = ? ";
        Cond = " where pmp_productid = ? ";
        stmt = null;
        rs = null;
        try
        {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Cond).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            if(productid != null && productid.length() > 0)
                stmt.setString(2, productid);
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean pBean;
            for(; rs.next(); list.add(pBean))
            {
                count++;
                pBean = new ProductBean();
                pBean.setLocale(locale);
                pBean.parseComboProductBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Category By Id --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_209;
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

    public ArrayList getComboProduct(String locale, String productid)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        String Cond;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = " select * from product_item  left join product_desc on pip_subproductid=pdp_productid and pdp_locale = ?  left join product_master on  pip_subproductid=pmp_productid ";
        Cond = " where pip_productid = ? ";
        stmt = null;
        rs = null;
        try
        {
            SQL = (new StringBuilder(String.valueOf(SQL))).append(Cond).toString();
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, locale);
            if(productid != null && productid.length() > 0)
                stmt.setString(2, productid);
            rs = stmt.executeQuery();
            int count = 0;
            ProductBean pBean;
            for(; rs.next(); list.add(pBean))
            {
                count++;
                pBean = new ProductBean();
                pBean.setLocale(locale);
                pBean.parseProductBean(rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Category By Id --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_209;
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

    public boolean InsertProduct(ProductBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        String sql2;
        String sql3;
        status = false;
        stmt1 = null;
        String fields1 = " (pmp_productid,pmp_catid,pmp_productcode,pmp_skucode,pmp_default_name,pmp_default_desc,pmp_type,pmp_uom,pmp_inventory,pmp_safe_level,pmp_priority_level,pmp_basevalue,pmp_status,pmp_register) ";
        sql1 = (new StringBuilder("insert into product_master ")).append(fields1).append(" values ").append(getSQLInsertParams(fields1)).toString();
        String fields2 = " (pdp_productid,pdp_locale,pdp_name,pdp_desc) ";
        sql2 = (new StringBuilder("insert into product_desc ")).append(fields2).append(" values ").append(getSQLInsertParams(fields2)).toString();
        String fields3 = " (pip_productid,pip_subproductid,pip_qty_sales) ";
        sql3 = (new StringBuilder("insert into product_item ")).append(fields3).append(" values ").append(getSQLInsertParams(fields3)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        int cnt1 = 0;
        stmt1.setInt(++cnt, bean.getProductID());
        stmt1.setInt(++cnt, bean.getCatID());
        stmt1.setString(++cnt, bean.getProductCode());
        stmt1.setString(++cnt, bean.getSkuCode());
        stmt1.setString(++cnt, bean.getDefaultName());
        stmt1.setString(++cnt, bean.getDefaultDesc());
        stmt1.setString(++cnt, bean.getType());
        stmt1.setString(++cnt, bean.getUom());
        stmt1.setString(++cnt, bean.getInventory());
        stmt1.setInt(++cnt, bean.getSafeLevel());
        stmt1.setInt(++cnt, bean.getPriorityLevel());
        stmt1.setDouble(++cnt, bean.getBaseValue());
        stmt1.setString(++cnt, bean.getStatus());
        stmt1.setString(++cnt, bean.getRegister());
        status = stmt1.executeUpdate() == 1;
        if(status)
        {
            for(int i = 0; i < bean.getProductDescList().size(); i++)
            {
                cnt1 = 0;
                stmt1 = getConnection().prepareStatement(sql2);
                ProductBean pBean = (ProductBean)bean.getProductDescList().get(i);
                stmt1.setInt(++cnt1, bean.getProductID());
                stmt1.setString(++cnt1, pBean.getLocale());
                stmt1.setString(++cnt1, pBean.getName());
                stmt1.setString(++cnt1, pBean.getDescription());
                status = stmt1.executeUpdate() == 1;
            }

        }
        if(status)
        {
            stmt1 = getConnection().prepareStatement(sql3);
            int count = 0;
            stmt1.setInt(++count, bean.getProductID());
            stmt1.setInt(++count, bean.getProductID());
            stmt1.setInt(++count, bean.getQtySale());
            status = stmt1.executeUpdate() == 1;
        }
        /*
        break MISSING_BLOCK_LABEL_595;
        Exception exception;
        exception;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        throw exception;
        */
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    public boolean InsertComboProduct(ProductBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        String sql2;
        String sql3;
        status = false;
        stmt1 = null;
        String fields1 = " (pmp_productid,pmp_catid,pmp_skucode,pmp_default_name,pmp_default_desc,pmp_type,pmp_uom,pmp_inventory,pmp_safe_level,pmp_priority_level,pmp_status,pmp_register) ";
        sql1 = (new StringBuilder("insert into product_master ")).append(fields1).append(" values ").append(getSQLInsertParams(fields1)).toString();
        String fields2 = " (pdp_productid,pdp_locale,pdp_name,pdp_desc) ";
        sql2 = (new StringBuilder("insert into product_desc ")).append(fields2).append(" values ").append(getSQLInsertParams(fields2)).toString();
        String fields3 = " (pip_productid,pip_subproductid,pip_order_seq,pip_qty_sales) ";
        sql3 = (new StringBuilder("insert into product_item ")).append(fields3).append(" values ").append(getSQLInsertParams(fields3)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        int cnt1 = 0;
        stmt1.setInt(++cnt, bean.getProductID());
        stmt1.setInt(++cnt, bean.getCatID());
        stmt1.setString(++cnt, bean.getSkuCode());
        stmt1.setString(++cnt, bean.getDefaultName());
        stmt1.setString(++cnt, bean.getDefaultDesc());
        stmt1.setString(++cnt, bean.getType());
        stmt1.setString(++cnt, bean.getUom());
        stmt1.setString(++cnt, bean.getInventory());
        stmt1.setInt(++cnt, bean.getSafeLevel());
        stmt1.setInt(++cnt, bean.getPriorityLevel());
        stmt1.setString(++cnt, bean.getStatus());
        stmt1.setString(++cnt, bean.getRegister());
        status = stmt1.executeUpdate() == 1;
        if(status)
        {
            for(int i = 0; i < bean.getProductDescList().size(); i++)
            {
                cnt1 = 0;
                stmt1 = getConnection().prepareStatement(sql2);
                ProductBean pBean = (ProductBean)bean.getProductDescList().get(i);
                stmt1.setInt(++cnt1, bean.getProductID());
                stmt1.setString(++cnt1, pBean.getLocale());
                stmt1.setString(++cnt1, pBean.getName());
                stmt1.setString(++cnt1, pBean.getDescription());
                status = stmt1.executeUpdate() == 1;
            }

        }
        if(status)
        {
            for(int i = 0; i < bean.getProductItemList().size(); i++)
            {
                cnt1 = 0;
                stmt1 = getConnection().prepareStatement(sql3);
                ProductBean pBean = (ProductBean)bean.getProductItemList().get(i);
                stmt1.setInt(++cnt1, bean.getProductID());
                stmt1.setInt(++cnt1, pBean.getSubProductID());
                stmt1.setInt(++cnt1, pBean.getOrderSeq());
                stmt1.setInt(++cnt1, pBean.getQtySale());
                status = stmt1.executeUpdate() == 1;
            }

        }
        /*
        break MISSING_BLOCK_LABEL_620;
        Exception exception;
        exception;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        throw exception;
        */
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    public boolean UpdateProduct(ProductBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String SQL1;
        String SQL2;
        String SQL3;
        status = false;
        stmt1 = null;
        SQL1 = " update product_master set  pmp_catid=?,  pmp_productcode=?,  pmp_skucode=?,  pmp_default_name=?,  pmp_default_desc=?,  pmp_type=?,  pmp_uom=?,  pmp_inventory=?,  pmp_safe_level=?,  pmp_priority_level=?,  pmp_status=?,  pmp_register=?,  pmp_basevalue=?  where pmp_productid=? ";
        SQL2 = " update product_item set  pip_qty_sales=?  where pip_productid=?";
        SQL3 = " update product_desc set  pdp_locale=?,  pdp_name=?,  pdp_desc=?  where pdp_productid=? and pdp_locale=?";
        stmt1 = getConnection().prepareStatement(SQL1);
        int cnt = 0;
        stmt1.setInt(++cnt, bean.getCatID());
        stmt1.setString(++cnt, bean.getProductCode());
        stmt1.setString(++cnt, bean.getSkuCode());
        stmt1.setString(++cnt, bean.getDefaultName());
        stmt1.setString(++cnt, bean.getDefaultDesc());
        stmt1.setString(++cnt, bean.getType());
        stmt1.setString(++cnt, bean.getUom());
        stmt1.setString(++cnt, bean.getInventory());
        stmt1.setInt(++cnt, bean.getSafeLevel());
        stmt1.setInt(++cnt, bean.getPriorityLevel());
        stmt1.setString(++cnt, bean.getStatus());
        stmt1.setString(++cnt, bean.getRegister());
        stmt1.setDouble(++cnt, bean.getBaseValue());
        stmt1.setInt(++cnt, bean.getProductID());
        status = stmt1.executeUpdate() == 1;
        if(status)
        {
            stmt1 = getConnection().prepareStatement(SQL2);
            int count = 0;
            stmt1.setInt(++count, bean.getQtySale());
            stmt1.setInt(++count, bean.getProductID());
            status = stmt1.executeUpdate() == 1;
        }
        if(status)
        {
            for(int i = 0; i < bean.getProductDescList().size(); i++)
            {
                int cnt1 = 0;
                stmt1 = getConnection().prepareStatement(SQL3);
                ProductBean pBean = (ProductBean)bean.getProductDescList().get(i);
                stmt1.setString(++cnt1, pBean.getLocale());
                stmt1.setString(++cnt1, pBean.getName());
                stmt1.setString(++cnt1, pBean.getDescription());
                stmt1.setInt(++cnt1, bean.getProductID());
                stmt1.setString(++cnt1, pBean.getLocale());
                status = stmt1.executeUpdate() == 1;
            }

        }
        /*
        break MISSING_BLOCK_LABEL_497;
        Exception exception;
        exception;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        throw exception;
        */
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    public boolean UpdateComboProduct(ProductBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String SQL1;
        String SQL2;
        status = false;
        stmt1 = null;
        SQL1 = " update product_master set  pmp_catid=?,  pmp_skucode=?,  pmp_default_name=?,  pmp_default_desc=?,  pmp_type=?,  pmp_uom=?,  pmp_inventory=?,  pmp_safe_level=?,  pmp_priority_level=?,  pmp_status=?,  pmp_register=?  where pmp_productid=? ";
        SQL2 = " update product_desc set  pdp_locale=?,  pdp_name=?,  pdp_desc=?  where pdp_productid=? and pdp_locale=?";
        stmt1 = getConnection().prepareStatement(SQL1);
        int cnt = 0;
        stmt1.setInt(++cnt, bean.getCatID());
        stmt1.setString(++cnt, bean.getSkuCode());
        stmt1.setString(++cnt, bean.getDefaultName());
        stmt1.setString(++cnt, bean.getDefaultDesc());
        stmt1.setString(++cnt, bean.getType());
        stmt1.setString(++cnt, bean.getUom());
        stmt1.setString(++cnt, bean.getInventory());
        stmt1.setInt(++cnt, bean.getSafeLevel());
        stmt1.setInt(++cnt, bean.getPriorityLevel());
        stmt1.setString(++cnt, bean.getStatus());
        stmt1.setString(++cnt, bean.getRegister());
        stmt1.setInt(++cnt, bean.getProductID());
        status = stmt1.executeUpdate() == 1;
        if(status)
        {
            for(int i = 0; i < bean.getProductDescList().size(); i++)
            {
                int cnt1 = 0;
                stmt1 = getConnection().prepareStatement(SQL2);
                ProductBean pBean = (ProductBean)bean.getProductDescList().get(i);
                stmt1.setString(++cnt1, pBean.getLocale());
                stmt1.setString(++cnt1, pBean.getName());
                stmt1.setString(++cnt1, pBean.getDescription());
                stmt1.setInt(++cnt1, bean.getProductID());
                stmt1.setString(++cnt1, pBean.getLocale());
                status = stmt1.executeUpdate() == 1;
            }

        }
        /*
        break MISSING_BLOCK_LABEL_397;
        Exception exception;
        exception;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        throw exception;
        */
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

    protected int GetCatId()
        throws MvcException, SQLException
    {
        PreparedStatement stmt;
        ResultSet rs;
        int catId;
        String SQL;
        stmt = null;
        rs = null;
        catId = 0;
        SQL = "select max(pmp_productid) from product_master";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                catId = rs.getInt("max(pmp_productid)");
                if(catId != 0)
                    catId++;
                else
                    catId = 1;
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while getting product id --> ")).append(e.toString()).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_125;
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
        return catId;
    }

    protected ArrayList getComboSubProduct(int productid)
        throws SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        stmt = null;
        rs = null;
        String sql = " select * from product_master  left join product_desc on pmp_productid=pdp_productid  left join product_item on pmp_productid=pip_productid  where pmp_productid=?  order by pip_subproductid ";
        stmt = getConnection().prepareStatement(" select * from product_master  left join product_desc on pmp_productid=pdp_productid  left join product_item on pmp_productid=pip_productid  where pmp_productid=?  order by pip_subproductid ");
        stmt.setInt(1, productid);
        ProductBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
        {
            bean = new ProductBean();
            bean.parseComboSubProductBean(rs, "");
        }
        /*
        break MISSING_BLOCK_LABEL_115;
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

    public ProductBean getProduct(int productID)
        throws MvcException, SQLException
    {
        ProductBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = " select * from product_master where pmp_productid=?";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, productID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_130;
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
        return bean;
    }

    public ProductBean getProduct(String skuCode)
        throws MvcException, SQLException
    {
        ProductBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = " select * from product_master where pmp_skucode=?";
        try
        {
            int cnt = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++cnt, skuCode);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Product --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_134;
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
        return bean;
    }


    public ProductBean getIdProduct(String skuCode)
        throws MvcException, SQLException
    {
        ProductBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = " select * from product_master where pmp_skucode=? ";
        try
        {
            int cnt = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++cnt, skuCode);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading ID Product --> ")).append(sqlex).toString());
        }
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    
    public ProductBean getProduct(int productID, String locale)
        throws MvcException, SQLException
    {
        ProductBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=? left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? where pmp_productid=?";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setInt(cnt++, productID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_214;
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
        return bean;
    }

    public ProductBean getProductBySkuCode(String skuCode, String locale)
        throws MvcException, SQLException
    {
        ProductBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=? left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? where pmp_skucode=?";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, skuCode);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale getProductByCode --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_214;
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
        return bean;
    }

    public ArrayList getProductItemList(int productID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_item left join product_master on pip_subproductid = pmp_productid where pip_productid=? order by pip_order_seq";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(cnt++, productID);
            ProductItemBean itemBean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(itemBean))
            {
                itemBean = new ProductItemBean();
                itemBean.parseBean(rs);
                ProductBean itemProductBean = new ProductBean();
                itemBean.setItemProductBean(itemProductBean);
                itemProductBean.parseBean(rs);
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_175;
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

    public ArrayList getProductItemList(int productID, String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_item left join product_master on pip_subproductid = pmp_productid left join product_desc on pip_subproductid = pdp_productid and pdp_locale=? left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? where pip_productid=? order by pip_order_seq";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setInt(cnt++, productID);
            ProductItemBean itemBean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(itemBean))
            {
                itemBean = new ProductItemBean();
                itemBean.parseBean(rs);
                ProductBean itemProductBean = new ProductBean();
                itemBean.setItemProductBean(itemProductBean);
                itemProductBean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                itemProductBean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                itemProductBean.setProductDescription(desc);
                itemProductBean.chkProductInfo();
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_258;
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

    public ArrayList getProductFullList(String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=?  order by pcp_catid, pmp_skucode";

        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            ProductBean bean;
     
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
                // 2010-01-27
                // System.out.println("Chek-1, chek new ProductBean() " + bean.getCatID()+ " (" + bean.getProductID()+")");

            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }

        System.out.println("2. Selesai getProductFullList ");

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    // public ArrayList getProductFullListUpdate(String locale, String brand, String product, String prodStatus)
    public ArrayList getProductFullListUpdate(String locale, String brand, String product, String productDesc, String productType, String prodStatus)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;

        SQLConditionsBean cond = new SQLConditionsBean();
        String conditions = "";              	
        String orderby = "";
        
        // System.out.println(" 3. product "+ product+ " brand "+brand + " product Desc "+ productDesc + " Prod Status "+prodStatus);
        
        if(product != null && product.length() > 0)
        {
            orderby = " order by pmp_skucode ASC";        
        }
        else
        {
            orderby = " order by pcp_catid, pmp_producttype, pmp_productseries, pmp_default_name, pmp_productcode, pmp_skucode "; 
        }
        cond.setOrderby(orderby);

        if(brand != null && brand.length() > 0)
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" where pcd_name = '").append(brand.trim()).append("' ").toString();

        if(product != null && product.length() > 0)
           if(brand.length() > 0){
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" and (UPPER(pmp_productcode) like '%").append(product.trim()).append("%' ").append(" or UPPER(pmp_skucode) like '%").append(product.trim().toUpperCase()).append("%') ").toString();
           }else{
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" where (UPPER(pmp_productcode) like '%").append(product.trim()).append("%' ").append(" or UPPER(pmp_skucode) like '%").append(product.trim().toUpperCase()).append("%') ").toString();               
           }
        
        if(productDesc != null && productDesc.length() > 0)
           if(brand.length() > 0 || product.length() > 0){
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" and UPPER(pmp_default_desc) like '%").append(productDesc.trim().toUpperCase()).append("%' ").toString();
           }else{
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" where UPPER(pmp_default_desc) like '%").append(productDesc.trim().toUpperCase()).append("%' ").toString();               
           }

        if(productType != null && productType.length() > 0)
           if(brand.length() > 0 || product.length() > 0 || productDesc.length() > 0){
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" and UPPER(pmp_producttype) like '%").append(productType.trim().toUpperCase()).append("%' ").toString();
           }else{
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" where UPPER(pmp_producttype) like '%").append(productType.trim().toUpperCase()).append("%' ").toString();               
           }
        
        if(prodStatus != null && prodStatus.length() > 0)
           if(brand.length() > 0 || product.length() > 0 || productDesc.length() > 0 || productType.length() > 0 ){              
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" and pmp_selling = '").append(prodStatus.trim()).append("' ").toString();
           }else{
           conditions = (new StringBuilder(String.valueOf(conditions))).append(" where pmp_selling = '").append(prodStatus.trim()).append("' ").toString(); 
           }  

        
        
        cond.setConditions(conditions);        
        
        SQL = (new StringBuilder("select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale= ?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale= ? ")).append(cond.getConditions()).append(cond.getOrderby()).toString();        
   
        try
        {
         
        int cnt = 1;
        stmt = getConnection().prepareStatement(SQL);
        stmt.setString(cnt++, locale);
        stmt.setString(cnt++, locale);   
       
        System.out.println(" getProductFullListUpdate "+ SQL);
                    
        ProductBean bean;
     
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
                // 2010-01-27
                // System.out.println("Chek-1, chek new ProductBean() " + rs.getStatement());

            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }

        System.out.println("2. Selesai getProductFullList " + rs.getStatement());

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    public ArrayList getProductFullListNewAsal(String locale, String lokasi)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=?  order by pcp_catid, pmp_skucode";
        
        SQL = " SELECT * FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  " +
              "left join product_category on pmp_catid = pcp_catid " +
              "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? " +
              "left join product_pricing on pmp_productid = ppi_productid " +
              "where pmp_status='A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and LOCATNID=?  order by pcp_catid, pmp_skucode  ";      
        
        
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, lokasi);
            
            ProductBean bean;
     
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
                // 2010-01-27
                // System.out.println("Chek-1, chek new ProductBean() " + bean.getCatID()+ " (" + bean.getProductID()+")");

            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }

        System.out.println("2. Selesai getProductFullListNew ");

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public ArrayList getProductFullListNew(String locale, String lokasi)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=?  order by pcp_catid, pmp_skucode";
        
        SQL = " SELECT * FROM product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  " +
              "left join product_category on pmp_catid = pcp_catid " +
              "left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? " +
              "left join product_pricing on pmp_productid = ppi_productid " +
              "where pmp_status='A' and ppi_pricecode='RTL' and ppi_enddate >= date(now()) and LOCATNID=?  order by pcp_catid, pmp_skucode  ";      
         
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, lokasi);
            
            ProductBean bean;
     
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
                // 2010-01-27
                // System.out.println("Chek-1, chek new ProductBean() " + bean.getCatID()+ " (" + bean.getProductID()+")");

            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }

        System.out.println("2. Selesai getProductFullListNew ");

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    public ArrayList getProductFullList2(String locale, String catid)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=?  where pcp_default_msg = ? order by pcp_order_seq, pmp_skucode";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, catid);
            
            ProductBean bean;
     
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
                // 2010-01-27
                System.out.println("Chek-1, chek new ProductBean() " + bean.getCatID()+ " (" + bean.getProductID()+")");

            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_215;
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
    
    public ArrayList getActiveProductList(String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=? left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? where pmp_status=? order by pcp_order_seq";
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, "A");
            ProductBean bean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product Full List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_228;
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

    public ArrayList getProductList(String productIDList[], String locale)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = " select * from product_master left join product_desc on pmp_productid = pdp_productid and pdp_locale=?  left join product_category on pmp_catid = pcp_catid  left join product_category_desc on pmp_catid = pcd_catid and pcd_locale=? ";
        SQL = (new StringBuilder(String.valueOf(SQL))).append(productIDList == null || productIDList.length <= 0 ? "" : (new StringBuilder(" where pmp_productid in ")).append(getSQLInParamsAsInteger(productIDList)).toString()).toString();
        SQL = (new StringBuilder(String.valueOf(SQL))).append(" order by pcp_order_seq, pmp_skucode").toString();
        try
        {
            int cnt = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(cnt++, locale);
            stmt.setString(cnt++, locale);
            ProductBean bean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new ProductBean();
                bean.parseBean(rs);
                ProductCategoryBean cat = new ProductCategoryBean();
                cat.parseBean(rs);
                bean.setProductCategory(cat);
                ProductDescriptionBean desc = new ProductDescriptionBean();
                desc.parseBean(rs);
                bean.setProductDescription(desc);
                bean.chkProductInfo();
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Locale Product List --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_300;
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

    public ProductBean getProductSet(int productID)
        throws MvcException, SQLException
    {
        ProductBean bean = getProduct(productID);
        if(bean != null)
        {
            ArrayList list = getProductItemList(productID);
            bean.setProductItemBeanList(list);
        }
        return bean;
    }

    public ProductBean getProductSet(int productID, String locale)
        throws MvcException, SQLException
    {
        ProductBean bean = getProduct(productID, locale);
        if(bean != null)
        {
            ArrayList list = getProductItemList(productID, locale);
            bean.setProductItemBeanList(list);
        }
        return bean;
    }

    public ProductBean getProductSetBySkuCode(String skuCode, String locale)
        throws MvcException, SQLException
    {
        ProductBean bean = getProductBySkuCode(skuCode, locale);
        if(bean != null)
        {
            ArrayList list = getProductItemList(bean.getProductID(), locale);
            bean.setProductItemBeanList(list);
        }
        return bean;
    }


    public ArrayList getProductSetFullList(String locale)
        throws MvcException, SQLException
    {
        ArrayList list = new ArrayList();
        ArrayList productList = getProductFullList(locale);
        if(productList != null && productList.size() > 0)
        {
            for(int i = 0; i < productList.size(); i++)
            {
                ProductBean bean = (ProductBean)productList.get(i);
                bean.setProductItemBeanList(getProductItemList(bean.getProductID(), locale));
                list.add(bean);
            }

        }
        return list;
    }
    
    // public ArrayList getProductSetFullListUpdate(String locale, String brand, String product, String prodStatus)
    public ArrayList getProductSetFullListUpdate(String locale, String brand, String product, String prodDesc, String prodType, String prodStatus)
        throws MvcException, SQLException
    {
        ArrayList list = new ArrayList();
        // ArrayList productList = getProductFullList(locale);
        // ArrayList productList = getProductFullListUpdate(locale, brand, product, prodStatus);
        ArrayList productList = getProductFullListUpdate(locale, brand, product, prodDesc, prodType, prodStatus);
        if(productList != null && productList.size() > 0)
        {
            for(int i = 0; i < productList.size(); i++)
            {
                ProductBean bean = (ProductBean)productList.get(i);
                bean.setProductItemBeanList(getProductItemList(bean.getProductID(), locale));
                list.add(bean);
            }

        }
        return list;
    }
    
    public ArrayList getActiveProductSetList(String locale)
        throws MvcException, SQLException
    {
        ArrayList list = new ArrayList();
        ArrayList productList = getActiveProductList(locale);
        if(productList != null && productList.size() > 0)
        {
            for(int i = 0; i < productList.size(); i++)
            {
                ProductBean bean = (ProductBean)productList.get(i);
                bean.setProductItemBeanList(getProductItemList(bean.getProductID(), locale));
                list.add(bean);
            }

        }
        return list;
    }

}
