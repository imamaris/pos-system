// Decompiled by Yody
// File : DeliveryProductBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.product.ProductBean;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            DeliveryItemBean

public class DeliveryProductBean
{

    private Long seq;
    private int deliveryItemID;
    private int productID;
    private int productType;
    private String productCode;
    private String serialCode;
    private String inventory;
    private int qty;
    private int qtyKiv;
    private DeliveryItemBean master;
    private ProductBean productBean;

    public DeliveryProductBean()
    {
    }

    public int getDeliveryItemID()
    {
        return deliveryItemID;
    }

    public void setDeliveryItemID(int deliveryItemID)
    {
        this.deliveryItemID = deliveryItemID;
    }

    public String getInventory()
    {
        return inventory;
    }

    public void setInventory(String inventory)
    {
        this.inventory = inventory;
    }

    public int getProductID()
    {
        return productID;
    }

    public void setProductID(int productID)
    {
        this.productID = productID;
    }

    public int getProductType()
    {
        return productType;
    }

    public void setProductType(int productType)
    {
        this.productType = productType;
    }

    public int getQty()
    {
        return qty;
    }

    public void setQty(int qty)
    {
        this.qty = qty;
    }

    public int getQtyKiv()
    {
        return qtyKiv;
    }

    public void setQtyKiv(int qtyKiv)
    {
        this.qtyKiv = qtyKiv;
    }

    public Long getSeq()
    {
        return seq;
    }

    public void setSeq(Long seq)
    {
        this.seq = seq;
    }

    public DeliveryItemBean getMaster()
    {
        return master;
    }

    public void setMaster(DeliveryItemBean master)
    {
        this.master = master;
    }

    public ProductBean getProductBean()
    {
        return productBean;
    }

    public void setProductBean(ProductBean productBean)
    {
        this.productBean = productBean;
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
        setSeq(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("dop_seq").toString())));
        setDeliveryItemID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("dop_doiseq").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("dop_productid").toString()));
        setProductType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("dop_producttype").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("dop_inventory").toString()));
        setQty(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("dop_qty").toString()));
        setQtyKiv(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("dop_qty_kiv").toString()));
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getSerialCode() {
        return serialCode;
    }

    public void setSerialCode(String serialCode) {
        this.serialCode = serialCode;
    }
}
