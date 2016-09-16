// Decompiled by Yody
// File : DeliveryItemBean

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.product.ProductBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            DeliveryProductBean, CounterSalesManager, DeliveryOrderBean

public class DeliveryItemBean
{

    private Long seq;
    private int deliveryID;
    private int productID;
    private int productType;
    private String inventory;
   /* penyesuaian kemudahan proses Synch */
    private String productCode;
    private String serialCode;
    private int qty;
    private Set productSet;
    private DeliveryOrderBean master;
    private DeliveryProductBean productArray[];
    private ProductBean productBean;

    public DeliveryItemBean()
    {
    }

    public int getDeliveryID()
    {
        return deliveryID;
    }

    public void setDeliveryID(int deliveryID)
    {
        this.deliveryID = deliveryID;
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

    public Long getSeq()
    {
        return seq;
    }

    public void setSeq(Long seq)
    {
        this.seq = seq;
    }

    public DeliveryOrderBean getMaster()
    {
        return master;
    }

    public void setMaster(DeliveryOrderBean master)
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

    public Set getProductSet()
    {
        return productSet;
    }

    public void addProduct(DeliveryProductBean product)
    {
        if(productSet == null)
            productSet = new HashSet();
        productSet.add(product);
        product.setMaster(this);
    }

    public DeliveryProductBean[] getProductArray()
    {
        if(productArray == null)
            productArray = CounterSalesManager.EMPTY_DELIVERY_PRODUCT_ARRAY;
        if(productSet != null && !productSet.isEmpty())
            productArray = (DeliveryProductBean[])productSet.toArray(CounterSalesManager.EMPTY_DELIVERY_PRODUCT_ARRAY);
        return productArray;
    }

    public void setProductArray(DeliveryProductBean productArray[])
    {
        this.productArray = productArray;
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
        setSeq(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("doi_seq").toString())));
        setDeliveryID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("doi_deliveryid").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("doi_productid").toString()));
        //setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("doi_productcode").toString()));        
       // setSerialCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("doi_serialcode").toString()));        
        setProductType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("doi_producttype").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("doi_inventory").toString()));
        setQty(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("doi_qty").toString()));
    }

/*    public String getProductCode() {
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
    }*/
}
