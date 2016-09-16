// Decompiled by Yody
// File : CounterSalesItemBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.pricing.product.ProductPricingBean;
import com.ecosmosis.orca.product.ProductBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesProductBean, CounterSalesManager, CounterSalesOrderBean

public class CounterSalesItemBean
{

    private Long seq;
    private int salesID;
    private int pricingID;
    private int productID;
    private int productType;
    private String inventory;
    private int qtyOrder;
    
    private int productIGN;
    private int productCat;
    
    private String productCode;
    private String productSKU;
    private String productDesc;
    
    private double unitDiscount;
    private String unitSales;
    
    private double unitPrice;
    private double unitNetPrice;
    private double chiUnitPrice;
    private double corpUnitPrice;
    private double bv1;
    private double bv2;
    private double bv3;
    private double bv4;
    private double bv5;
    private int deliveryStatus;
    private String skucode;
    private Set productSet;
    private CounterSalesOrderBean master;
    private CounterSalesProductBean productArray[];
    private ProductPricingBean pricingBean;
    private ProductBean productBean;

    public CounterSalesItemBean()
    {
    }

    public String getSkucode()
    {
        return skucode;
    }

    public void setSkucode(String skucode)
    {
        this.skucode = skucode;
    }

    public double getBv1()
    {
        return bv1;
    }

    public void setBv1(double bv1)
    {
        this.bv1 = bv1;
    }

    public double getBv2()
    {
        return bv2;
    }

    public void setBv2(double bv2)
    {
        this.bv2 = bv2;
    }

    public double getBv3()
    {
        return bv3;
    }

    public void setBv3(double bv3)
    {
        this.bv3 = bv3;
    }

    public double getBv4()
    {
        return bv4;
    }

    public void setBv4(double bv4)
    {
        this.bv4 = bv4;
    }

    public double getBv5()
    {
        return bv5;
    }

    public void setBv5(double bv5)
    {
        this.bv5 = bv5;
    }

    public String getInventory()
    {
        return inventory;
    }

    public void setInventory(String inventory)
    {
        this.inventory = inventory;
    }

    public int getProductCat()
    {
        return productCat;
    }

    public void setProductCat(int productCat)
    {
        this.productCat = productCat;
    }
    
    public String getProductSKU()
    {
        return productSKU;
    }

    public void setProductSKU(String productSKU)
    {
        this.productSKU = productSKU;
    }

    public String getProductDesc()
    {
        return productDesc;
    }

    public void setProductDesc(String productDesc)
    {
        this.productDesc = productDesc;
    }
    
    public int getPricingID()
    {
        return pricingID;
    }

    public void setPricingID(int pricingID)
    {
        this.pricingID = pricingID;
    }

    public int getProductIGN()
    {
        return productIGN;
    }

    public void setProductIGN(int productIGN)
    {
        this.productIGN = productIGN;
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

    public int getQtyOrder()
    {
        return qtyOrder;
    }

    public void setQtyOrder(int qtyOrder)
    {
        this.qtyOrder = qtyOrder;
    }

    public int getSalesID()
    {
        return salesID;
    }

    public void setSalesID(int salesID)
    {
        this.salesID = salesID;
    }

    public Long getSeq()
    {
        return seq;
    }

    public void setSeq(Long seq)
    {
        this.seq = seq;
    }

    public double getUnitPrice()
    {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice)
    {
        this.unitPrice = unitPrice;
    }

    public double getChiUnitPrice()
    {
        return chiUnitPrice;
    }

    public void setChiUnitPrice(double chiUnitPrice)
    {
        this.chiUnitPrice = chiUnitPrice;
    }

    public double getCorpUnitPrice()
    {
        return corpUnitPrice;
    }

    public void setCorpUnitPrice(double corpUnitPrice)
    {
        this.corpUnitPrice = corpUnitPrice;
    }

    public int getDeliveryStatus()
    {
        return deliveryStatus;
    }

    public void setDeliveryStatus(int deliveryStatus)
    {
        this.deliveryStatus = deliveryStatus;
    }

    public CounterSalesOrderBean getMaster()
    {
        return master;
    }

    public void setMaster(CounterSalesOrderBean master)
    {
        this.master = master;
    }

    public ProductPricingBean getPricingBean()
    {
        return pricingBean;
    }

    public void setPricingBean(ProductPricingBean pricingBean)
    {
        this.pricingBean = pricingBean;
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

    public void addProduct(CounterSalesProductBean product)
    {
        if(productSet == null)
            productSet = new HashSet();
        productSet.add(product);
        product.setMaster(this);
    }

    public CounterSalesProductBean[] getProductArray()
    {
        if(productArray == null)
            productArray = CounterSalesManager.EMPTY_SALES_PRODUCT_ARRAY;
        if(productSet != null && !productSet.isEmpty())
            productArray = (CounterSalesProductBean[])productSet.toArray(CounterSalesManager.EMPTY_SALES_PRODUCT_ARRAY);
        return productArray;
    }

    public void setProductArray(CounterSalesProductBean productArray[])
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
        setSeq(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("csi_seq").toString())));
        setSalesID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_salesid").toString()));
        setPricingID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_pricingid").toString()));
        
        setProductIGN(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_ign").toString()));
        setProductCat(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_catid").toString()));
        setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_productcode").toString()));
        setProductSKU(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_skucode").toString()));
        setProductDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_skuname").toString()));        
        
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_productid").toString()));
        setProductType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_producttype").toString()));
        setInventory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_inventory").toString()));        
        
        setQtyOrder(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_qty_order").toString()));
        
        setUnitDiscount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_discount").toString()));
        setUnitSales(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_unit_sales").toString()));
        
        setUnitNetPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_netprice").toString()));
        setUnitPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_price").toString()));
        setChiUnitPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_price_chi").toString()));
        setCorpUnitPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_price_corp").toString()));
        setBv1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv1").toString()));
        setBv2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv2").toString()));
        setBv3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv3").toString()));
        setBv4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv4").toString()));
        // pengganti discount
        setBv5(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv5").toString()));
        setDeliveryStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_delivery_status").toString()));
    }


    public double getUnitDiscount() {
        return unitDiscount;
    }

    public void setUnitDiscount(double unitDiscount) {
        this.unitDiscount = unitDiscount;
    }

    public String getUnitSales() {
        return unitSales;
    }

    public void setUnitSales(String unitSales) {
        this.unitSales = unitSales;
    }

    public double getUnitNetPrice() {
        return unitNetPrice;
    }

    public void setUnitNetPrice(double unitNetPrice) {
        this.unitNetPrice = unitNetPrice;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    
}
