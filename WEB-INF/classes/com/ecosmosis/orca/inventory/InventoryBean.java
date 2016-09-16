// Decompiled by Yody
// File : InventoryBean.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.mvc.bean.MvcBean;
import com.ecosmosis.orca.product.ProductBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class InventoryBean extends MvcBean
{

    private int inventoryID;
    private Date trnxDate;
    private Date trnxTime;
    private String ownerID;
    private String ownerType;
    private String ownerRemark;
    private String storeCode;
    private int productID;
    
    private String productSerial;
    private String productCode;
    
    private int productType;
    private String trnxDocNo;
    private String trnxDocType;
    private String trnxType;
    private int totalIn;
    private int totalOut;
    // private int totalAllocate;
    private int total;
    private String batchNo;
    private int salesID;
    private int deliveryID;
    private String target;
    private String targetType;
    private String targetRemark;
    private String remark;
    private int processStatus;
    private int status;
    private int totalBringForward;
    private double price;
    private ProductBean productBean;

    public InventoryBean()
    {
    }

    public String getBatchNo()
    {
        return batchNo;
    }

    public void setBatchNo(String batchNo)
    {
        this.batchNo = batchNo;
    }

    public int getDeliveryID()
    {
        return deliveryID;
    }

    public void setDeliveryID(int deliveryID)
    {
        this.deliveryID = deliveryID;
    }

    public int getInventoryID()
    {
        return inventoryID;
    }

    public void setInventoryID(int inventoryID)
    {
        this.inventoryID = inventoryID;
    }

    public String getOwnerID()
    {
        return ownerID;
    }

    public void setOwnerID(String ownerID)
    {
        this.ownerID = ownerID;
    }

    public String getOwnerRemark()
    {
        return ownerRemark;
    }

    public void setOwnerRemark(String ownerRemark)
    {
        this.ownerRemark = ownerRemark;
    }

    public String getOwnerType()
    {
        return ownerType;
    }

    public void setOwnerType(String ownerType)
    {
        this.ownerType = ownerType;
    }

    public int getProcessStatus()
    {
        return processStatus;
    }

    public void setProcessStatus(int processStatus)
    {
        this.processStatus = processStatus;
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

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public int getSalesID()
    {
        return salesID;
    }

    public void setSalesID(int salesID)
    {
        this.salesID = salesID;
    }

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    public String getStoreCode()
    {
        return storeCode;
    }

    public void setStoreCode(String storeCode)
    {
        this.storeCode = storeCode;
    }

    public String getTarget()
    {
        return target;
    }

    public void setTarget(String target)
    {
        this.target = target;
    }

    public String getTargetRemark()
    {
        return targetRemark;
    }

    public void setTargetRemark(String targetRemark)
    {
        this.targetRemark = targetRemark;
    }

    public String getTargetType()
    {
        return targetType;
    }

    public void setTargetType(String targetType)
    {
        this.targetType = targetType;
    }

    public int getTotalIn()
    {
        return totalIn;
    }

    public void setTotalIn(int totalIn)
    {
        this.totalIn = totalIn;
    }

    public int getTotalOut()
    {
        return totalOut;
    }

    public void setTotalOut(int totalOut)
    {
        this.totalOut = totalOut;
    }

    public Date getTrnxDate()
    {
        return trnxDate;
    }

    public void setTrnxDate(Date trnxDate)
    {
        this.trnxDate = trnxDate;
    }

    public String getTrnxDocNo()
    {
        return trnxDocNo;
    }

    public void setTrnxDocNo(String trnxDocNo)
    {
        this.trnxDocNo = trnxDocNo;
    }

    public String getTrnxDocType()
    {
        return trnxDocType;
    }

    public void setTrnxDocType(String trnxDocType)
    {
        this.trnxDocType = trnxDocType;
    }

    public Date getTrnxTime()
    {
        return trnxTime;
    }

    public void setTrnxTime(Date trnxTime)
    {
        this.trnxTime = trnxTime;
    }

    public String getTrnxType()
    {
        return trnxType;
    }

    public void setTrnxType(String trnxType)
    {
        this.trnxType = trnxType;
    }

    public int getTotal()
    {
        return total;
    }

    public void setTotal(int total)
    {
        this.total = total;
    }

    public ProductBean getProductBean()
    {
        return productBean;
    }

    public void setProductBean(ProductBean productBean)
    {
        this.productBean = productBean;
    }
    
    
    public int getTotalBringForward()
    {
        return totalBringForward;
    }

    public void setTotalBringForward(int totalBringForward)
    {
        this.totalBringForward = totalBringForward;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    

    protected void parseInventoryBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setInventoryID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_inventoryid").toString()));
        setTrnxDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("piv_trxdate").toString()));
        setTrnxTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("piv_trxtime").toString()));
        setOwnerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_owner").toString()));
        setOwnerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_owner_type").toString()));
        setOwnerRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_owner_remark").toString()));
        setStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_storecode").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_productid").toString()));
        
        setProductSerial(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_skucode").toString()));
        setProductCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_productcode").toString()));
        
        setProductType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_producttype").toString()));
        setTrnxDocNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_trxdocno").toString()));
        setTrnxDocType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_trxdoctype").toString()));
        setTrnxType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_trxtype").toString()));
        setTotalIn(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_in").toString()));
        setTotalOut(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_out").toString()));
        setBatchNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_batchno").toString()));
        setSalesID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_salesid").toString()));
        setDeliveryID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_deliveryid").toString()));
        setTarget(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_target").toString()));
        setTargetType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_target_type").toString()));
        setTargetRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_target_remark").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_remark").toString()));
        setProcessStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_process_status").toString()));
        setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("piv_status").toString()));
        parseInfo(rs, "");
    }

    public String getProductSerial() {
        return productSerial;
    }

    public void setProductSerial(String productSerial) {
        this.productSerial = productSerial;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }
}
