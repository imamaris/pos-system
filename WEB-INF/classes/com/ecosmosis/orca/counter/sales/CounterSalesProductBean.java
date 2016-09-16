// Decompiled by Yody
// File : CounterSalesProductBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.product.ProductBean;
import java.sql.ResultSet;
import java.sql.SQLException;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesItemBean

public class CounterSalesProductBean
{

    private Long seq;
    private int salesItemID;
    private int productID;
    private int productType;
    private String inventory;
    private String productCode;
    private String skuCode;
    private int qtyUnit;
    private int qtyOrder;
    private int qtyKiv;
    private int qtyOnHand;
    private CounterSalesItemBean master;
    private ProductBean productBean;

    public CounterSalesProductBean()
    {
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

    public int getQtyKiv()
    {
        return qtyKiv;
    }

    public void setQtyKiv(int qtyKiv)
    {
        this.qtyKiv = qtyKiv;
    }

    public int getQtyOrder()
    {
        return qtyOrder;
    }

    public void setQtyOrder(int qtyOrder)
    {
        this.qtyOrder = qtyOrder;
    }

    public int getQtyUnit()
    {
        return qtyUnit;
    }

    public void setQtyUnit(int qtyUnit)
    {
        this.qtyUnit = qtyUnit;
    }

    public int getQtyOnHand()
    {
        return qtyOnHand;
    }

    public void setQtyOnHand(int qtyOnHand)
    {
        this.qtyOnHand = qtyOnHand;
    }

    public int getSalesItemID()
    {
        return salesItemID;
    }

    public void setSalesItemID(int salesItemID)
    {
        this.salesItemID = salesItemID;
    }

    public Long getSeq()
    {
        return seq;
    }

    public void setSeq(Long seq)
    {
        this.seq = seq;
    }

    public CounterSalesItemBean getMaster()
    {
        return master;
    }

    public void setMaster(CounterSalesItemBean master)
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
        setSeq(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("csp_seq").toString())));
        setSalesItemID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_csiseq").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_productid").toString()));
        // for adjust synch ..
      //  setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csp_productcode").toString()));
    //    setSkuCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csp_skucode").toString()));
        
        setProductType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_producttype").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csp_inventory").toString()));
        setQtyUnit(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_qty_unit").toString()));
        setQtyOrder(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_qty_order").toString()));
        setQtyKiv(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csp_qty_kiv").toString()));
    }

    /*public String getProductCode() {
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
