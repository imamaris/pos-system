// Decompiled by Yody
// File : ProductItemBean.class

package com.ecosmosis.orca.product;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.ecosmosis.orca.product:
//            ProductBean

public class ProductItemBean extends MvcBean
{

    private int seq;
    private int productID;
    private String productCode;
    private String skuCode;
    private int subProductID;
    private int orderSeq;
    private int qtySale;
    private int qtyFoc;
    private ProductBean itemProductBean;

    public ProductItemBean()
    {
    }

    public int getOrderSeq()
    {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq)
    {
        this.orderSeq = orderSeq;
    }

    public int getProductID()
    {
        return productID;
    }

    public void setProductID(int productID)
    {
        this.productID = productID;
    }

    public int getQtyFoc()
    {
        return qtyFoc;
    }

    public void setQtyFoc(int qtyFoc)
    {
        this.qtyFoc = qtyFoc;
    }

    public int getQtySale()
    {
        return qtySale;
    }

    public void setQtySale(int qtySale)
    {
        this.qtySale = qtySale;
    }

    public int getSeq()
    {
        return seq;
    }

    public void setSeq(int seq)
    {
        this.seq = seq;
    }

    public int getSubProductID()
    {
        return subProductID;
    }

    public void setSubProductID(int subProductID)
    {
        this.subProductID = subProductID;
    }

    public ProductBean getItemProductBean()
    {
        return itemProductBean;
    }

    public void setItemProductBean(ProductBean itemProductBean)
    {
        this.itemProductBean = itemProductBean;
    }

    public void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }

    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_seq").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_productid").toString()));
        
        // for adjust synch ..
      //  setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pip_productcode").toString()));
      //  setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pip_skucode").toString()));
        
        setSubProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_subproductid").toString()));
        setOrderSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_order_seq").toString()));
        setQtySale(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_qty_sales").toString()));
        setQtyFoc(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pip_qty_foc").toString()));
    }

/*    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }*/
}
