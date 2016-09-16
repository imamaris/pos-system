/*
 * DSRReportBean.java
 *
 * Created on June 11, 2013, 4:47 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRReportBean extends MvcBean{
    
    private Date DSRTrxDate;
    private String brandCode;
    private Date trxDate;
    private String trxDocno;
    private String trxRefNo;
    private String docType;
    private String itemCode;
    private String itemDesc;
    private String serialNumber;
    private int qtyOrder;
    private double retailPrice;
    private double IDRRetailPrice;
    private double netPrice;
    private float discount;
    private double rate;
    private double discPayAmt;
    private String payMode;
    private double payAmt;
    private String payCurr;
    private String salesName;
    private String custName;
    private int docStat;
    private String remark;
    private String salesID;
    private String itemSeq;
    private String paySeq;
    private double payRate;
    private Date DSRDocDate;
    private Date docDate;
    
    private String USDCurID;
    private String USDExchange;
    private double USDRate;
    private Date USDStartDate;
    private String USDStartTime;
    private Date USDEndDate;
    private String USDEndTime;
    private String SGDCurID;
    private String SGDExchange;
    private double SGDRate;
    private Date SGDStartDate;
    private String SGDStartTime;
    private Date SGDEndDate;
    private String SGDEndTime;
    
    private String smryBrand;
    private double smryTarget;
    private double smrySales;
    private float smryPercent;
    private int smryQty;
    private int smryTgtQty;
    
    private String outletInitial;
    private String outletInitialName;

    public Date getDSRTrxDate() {
        return DSRTrxDate;
    }

    public void setDSRTrxDate(Date DSRTrxDate) {
        this.DSRTrxDate = DSRTrxDate;
    }
    
    protected void parseTrxDateBean(ResultSet rs)
        throws SQLException
    {
        parseTrxDateBean(rs, "");
    }
    
    public void parseTrxDateBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setDSRTrxDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_trxdate").toString()));
    }
    
    public Date getDSRDocDate() {
        return DSRDocDate;
    }

    public void setDSRDocDate(Date DSRDocDate) {
        this.DSRDocDate = DSRDocDate;
    }
    
    protected void parseDocDateBean(ResultSet rs)
        throws SQLException
    {
        parseDocDateBean(rs, "");
    }
    
    public void parseDocDateBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setDSRDocDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_bonusdate").toString()));
    }
    
    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public Date getTrxDate() {
        return trxDate;
    }

    public void setTrxDate(Date trxDate) {
        this.trxDate = trxDate;
    }
    
    public Date getDocDate() {
        return docDate;
    }

    public void setDocDate(Date docDate) {
        this.docDate = docDate;
    }

    public String getTrxDocno() {
        return trxDocno;
    }

    public void setTrxDocno(String trxDocno) {
        this.trxDocno = trxDocno;
    }
    
    public String getTrxRefNo() {
        return trxRefNo;
    }

    public void setTrxRefNo(String trxRefNo) {
        this.trxRefNo = trxRefNo;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }
    
    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getItemDesc() {
        return itemDesc;
    }

    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public int getQtyOrder() {
        return qtyOrder;
    }

    public void setQtyOrder(int qtyOrder) {
        this.qtyOrder = qtyOrder;
    }

    public double getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(double retailPrice) {
        this.retailPrice = retailPrice;
    }
    
    public double getIDRRetailPrice() {
        return IDRRetailPrice;
    }

    public void setIDRRetailPrice(double IDRRetailPrice) {
        this.IDRRetailPrice = IDRRetailPrice;
    }

    public double getNetPrice() {
        return netPrice;
    }

    public void setNetPrice(double netPrice) {
        this.netPrice = netPrice;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }
    
    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public double getDiscPayAmt() {
        return discPayAmt;
    }

    public void setDiscPayAmt(double discPayAmt) {
        this.discPayAmt = discPayAmt;
    }

    public String getPayMode() {
        return payMode;
    }

    public void setPayMode(String payMode) {
        this.payMode = payMode;
    }

    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }
    
    public int getDocStat() {
        return docStat;
    }

    public void setDocStat(int docStat) {
        this.docStat = docStat;
    }
    
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
    
    public String getSalesID() {
        return salesID;
    }

    public void setSalesID(String salesID) {
        this.salesID = salesID;
    }
    
    public String getItemSeq() {
        return itemSeq;
    }

    public void setItemSeq(String itemSeq) {
        this.itemSeq = itemSeq;
    }

    public String getPaySeq() {
        return paySeq;
    }

    public void setPaySeq(String paySeq) {
        this.paySeq = paySeq;
    }

    public double getPayRate() {
        return payRate;
    }

    public void setPayRate(double payRate) {
        this.payRate = payRate;
    }
    
    public double getPayAmt() {
        return payAmt;
    }

    public void setPayAmt(double payAmt) {
        this.payAmt = payAmt;
    }

    public String getPayCurr() {
        return payCurr;
    }

    public void setPayCurr(String payCurr) {
        this.payCurr = payCurr;
    }
    
    protected void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }
    
    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setBrandCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("brand_code").toString()));
        setTrxDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_trxdate").toString()));
        setDocDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_bonusdate").toString()));
        setTrxDocno(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdocno").toString()));
        setTrxRefNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("refno").toString()));
        setDocType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdoctype").toString()));
        setItemCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_productcode").toString()));
        setItemDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_skuname").toString()));
        setSerialNumber(rs.getString((new StringBuilder(String.valueOf(prefix))).append("serial_number").toString()));
        setQtyOrder(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csi_qty_order").toString()));
        setRetailPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_price").toString()));
        setIDRRetailPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("idr_unit_price").toString()));
        setNetPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_netprice").toString()));
        setDiscount(rs.getFloat((new StringBuilder(String.valueOf(prefix))).append("discount").toString()));
        setRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_bv1").toString()));
        setDiscPayAmt(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csi_unit_discount").toString()));
        setPayMode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("payment_mode").toString()));
        setPayAmt(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("payment_amt").toString()));
        setPayCurr(rs.getString((new StringBuilder(String.valueOf(prefix))).append("payment_curr").toString()));
        setSalesName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_earnername").toString()));
        setCustName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_name").toString()));
        setDocStat(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_status").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("remark").toString()));
        setSalesID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_salesid").toString()));
        setItemSeq(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csi_seq").toString()));
        setPaySeq(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_seq").toString()));
        setPayRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csm_rate").toString()));
    }

    public String getUSDCurID() {
        return USDCurID;
    }

    public void setUSDCurID(String USDCurID) {
        this.USDCurID = USDCurID;
    }

    public String getUSDExchange() {
        return USDExchange;
    }

    public void setUSDExchange(String USDExchange) {
        this.USDExchange = USDExchange;
    }

    public double getUSDRate() {
        return USDRate;
    }

    public void setUSDRate(double USDRate) {
        this.USDRate = USDRate;
    }

    public Date getUSDStartDate() {
        return USDStartDate;
    }

    public void setUSDStartDate(Date USDStartDate) {
        this.USDStartDate = USDStartDate;
    }

    public String getUSDStartTime() {
        return USDStartTime;
    }

    public void setUSDStartTime(String USDStartTime) {
        this.USDStartTime = USDStartTime;
    }

    public Date getUSDEndDate() {
        return USDEndDate;
    }

    public void setUSDEndDate(Date USDEndDate) {
        this.USDEndDate = USDEndDate;
    }

    public String getUSDEndTime() {
        return USDEndTime;
    }

    public void setUSDEndTime(String USDEndTime) {
        this.USDEndTime = USDEndTime;
    }

    public String getSGDCurID() {
        return SGDCurID;
    }

    public void setSGDCurID(String SGDCurID) {
        this.SGDCurID = SGDCurID;
    }

    public String getSGDExchange() {
        return SGDExchange;
    }

    public void setSGDExchange(String SGDExchange) {
        this.SGDExchange = SGDExchange;
    }

    public double getSGDRate() {
        return SGDRate;
    }

    public void setSGDRate(double SGDRate) {
        this.SGDRate = SGDRate;
    }

    public Date getSGDStartDate() {
        return SGDStartDate;
    }

    public void setSGDStartDate(Date SGDStartDate) {
        this.SGDStartDate = SGDStartDate;
    }

    public String getSGDStartTime() {
        return SGDStartTime;
    }

    public void setSGDStartTime(String SGDStartTime) {
        this.SGDStartTime = SGDStartTime;
    }

    public Date getSGDEndDate() {
        return SGDEndDate;
    }

    public void setSGDEndDate(Date SGDEndDate) {
        this.SGDEndDate = SGDEndDate;
    }

    public String getSGDEndTime() {
        return SGDEndTime;
    }

    public void setSGDEndTime(String SGDEndTime) {
        this.SGDEndTime = SGDEndTime;
    }
    
    protected void parseCurRateBean(ResultSet rs)
        throws SQLException
    {
        parseCurRateBean(rs, "");
    }
    
    public void parseCurRateBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setUSDCurID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("usd_currencyid").toString()));
        setUSDExchange(rs.getString((new StringBuilder(String.valueOf(prefix))).append("usd_exchange").toString()));
        setUSDRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("usd_rate").toString()));
        setUSDStartDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("usd_startdate").toString()));
        setUSDStartTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("usd_starttime").toString()));
        setUSDEndDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("usd_enddate").toString()));
        setUSDEndTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("usd_endtime").toString()));
        setSGDCurID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("sgd_currencyid").toString()));
        setSGDExchange(rs.getString((new StringBuilder(String.valueOf(prefix))).append("sgd_exchange").toString()));
        setSGDRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("sgd_rate").toString()));
        setSGDStartDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("sgd_startdate").toString()));
        setSGDStartTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("sgd_starttime").toString()));
        setSGDEndDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("sgd_enddate").toString()));
        setSGDEndTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("sgd_endtime").toString()));
    }
    
    public String getSmryBrand() {
        return smryBrand;
    }

    public void setSmryBrand(String smryBrand) {
        this.smryBrand = smryBrand;
    }

    public double getSmryTarget() {
        return smryTarget;
    }

    public void setSmryTarget(double smryTarget) {
        this.smryTarget = smryTarget;
    }

    public double getSmrySales() {
        return smrySales;
    }

    public void setSmrySales(double smrySales) {
        this.smrySales = smrySales;
    }

    public float getSmryPercent() {
        return smryPercent;
    }

    public void setSmryPercent(float smryPercent) {
        this.smryPercent = smryPercent;
    }

    public int getSmryQty() {
        return smryQty;
    }

    public void setSmryQty(int smryQty) {
        this.smryQty = smryQty;
    }
    public int getSmryTgtQty() {
        return smryTgtQty;
    }

    public void setSmryTgtQty(int smryTgtQty) {
        this.smryTgtQty = smryTgtQty;
    }    
    protected void parseSummaryBean(ResultSet rs)
        throws SQLException
    {
        parseSummaryBean(rs, "");
    }
    
    public void parseSummaryBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setSmryBrand(rs.getString((new StringBuilder(String.valueOf(prefix))).append("brand").toString()));
        setSmryTarget(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("tgt_amt").toString()));
        setSmrySales(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("netsales").toString()));
        setSmryPercent(rs.getFloat((new StringBuilder(String.valueOf(prefix))).append("percent").toString()));
        setSmryQty(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("qty").toString()));
        setSmryTgtQty(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("tgt_qty").toString()));
    }
    
    protected void parsePaymentBean(ResultSet rs)
        throws SQLException
    {
        parsePaymentBean(rs, "");
    }
    
    public void parsePaymentBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setPaySeq(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_seq").toString()));
        setPayMode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("payment_mode").toString()));
        setPayAmt(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("payment_amt").toString()));
        setPayCurr(rs.getString((new StringBuilder(String.valueOf(prefix))).append("payment_curr").toString()));
    }
    
    public String getOutletInitial() {
        return outletInitial;
    }

    public void setOutletInitial(String outletInitial) {
        this.outletInitial = outletInitial;
    }

    public String getOutletInitialName() {
        return outletInitialName;
    }

    public void setOutletInitialName(String outletInitialName) {
        this.outletInitialName = outletInitialName;
    }
    
    protected void parseOutletBean(ResultSet rs)
        throws SQLException
    {
        parseOutletBean(rs, "");
    }
    
    public void parseOutletBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setOutletInitial(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_outletid").toString()));
        setOutletInitialName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_name").toString()));
    }
}
