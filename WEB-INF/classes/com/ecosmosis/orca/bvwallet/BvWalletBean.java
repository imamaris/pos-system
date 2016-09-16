// Decompiled by Yody
// File : BvWalletBean.class

package com.ecosmosis.orca.bvwallet;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.*;
import java.util.Date;

public class BvWalletBean extends MvcBean
{

    private long seqID;
    private Date trxDate;
    private Time trxTime;
    private int beanType;
    private Date bonusDate;
    private String trxType;
    private String periodID;
    private String sellerID;
    private String sellerType;
    private String sellerTypeStatus;
    private String ownerID;
    private String ownerName;
    private String ownerCRM;
    private String ownerSegmentation;
    private String ownerType;
    private String fromID;
    private String fromType;
    private int walletType;
    private int status;
    private String referenceType;
    private String referenceNo;
    private double bvIn;
    private double bvOut;
    private double bvIn1;
    private double bvOut1;
    private double bvIn2;
    private double bvOut2;
    private double bvIn3;
    private double bvOut3;
    private double bvIn4;
    private double bvOut4;
    private double fullAmountIn;
    private double fullAmountOut;
    private double bvAmountIn;
    private double bvAmountOut;
    private String currencyCode;
    private String universalCurrencyCode;
    private double universalCurrencyRate;
    private String remark;
    private double bvBalance;
    private double bv1Balance;
    private double bv2Balance;
    private double bv3Balance;
    private double bv4Balance;
    private double fullamountBalance;
    private double bvamountBalance;
    private Date fromDate;
    private Date toDate;

    public BvWalletBean()
    {
    }

    public boolean isTrxIN()
    {
        boolean res = false;
        if(trxType != null && trxType.length() > 0 && trxType.substring(0, 1).equalsIgnoreCase("I"))
            res = true;
        return res;
    }

    public Date getBonusDate()
    {
        return bonusDate;
    }

    public void setBonusDate(Date bonusDate)
    {
        this.bonusDate = bonusDate;
    }

    public String getOwnerName()
    {
        return ownerName;
    }

    public void setOwnerName(String ownerName)
    {
        this.ownerName = ownerName;
    }

    public int getBeanType()
    {
        return beanType;
    }

    public void setBeanType(int beanType)
    {
        this.beanType = beanType;
    }

    public Date getFromDate()
    {
        return fromDate;
    }

    public void setFromDate(Date fromDate)
    {
        this.fromDate = fromDate;
    }

    public Date getToDate()
    {
        return toDate;
    }

    public void setToDate(Date toDate)
    {
        this.toDate = toDate;
    }

    public double getBvamountBalance()
    {
        return bvamountBalance;
    }

    public void setBvamountBalance(double bvamountBalance)
    {
        this.bvamountBalance = bvamountBalance;
    }

    public double getFullamountBalance()
    {
        return fullamountBalance;
    }

    public void setFullamountBalance(double fullamountBalance)
    {
        this.fullamountBalance = fullamountBalance;
    }

    public double getBv1Balance()
    {
        return bv1Balance;
    }

    public void setBv1Balance(double bv1Balance)
    {
        this.bv1Balance = bv1Balance;
    }

    public double getBv2Balance()
    {
        return bv2Balance;
    }

    public void setBv2Balance(double bv2Balance)
    {
        this.bv2Balance = bv2Balance;
    }

    public double getBv3Balance()
    {
        return bv3Balance;
    }

    public void setBv3Balance(double bv3Balance)
    {
        this.bv3Balance = bv3Balance;
    }

    public double getBv4Balance()
    {
        return bv4Balance;
    }

    public void setBv4Balance(double bv4Balance)
    {
        this.bv4Balance = bv4Balance;
    }

    public double getBvBalance()
    {
        return bvBalance;
    }

    public void setBvBalance(double bvBalance)
    {
        this.bvBalance = bvBalance;
    }

    public double getBvAmountIn()
    {
        return bvAmountIn;
    }

    public void setBvAmountIn(double bvAmountIn)
    {
        this.bvAmountIn = bvAmountIn;
    }

    public double getBvAmountOut()
    {
        return bvAmountOut;
    }

    public void setBvAmountOut(double bvAmountOut)
    {
        this.bvAmountOut = bvAmountOut;
    }

    public double getBvIn()
    {
        return bvIn;
    }

    public void setBvIn(double bvIn)
    {
        this.bvIn = bvIn;
    }

    public double getBvIn1()
    {
        return bvIn1;
    }

    public void setBvIn1(double bvIn1)
    {
        this.bvIn1 = bvIn1;
    }

    public double getBvIn2()
    {
        return bvIn2;
    }

    public void setBvIn2(double bvIn2)
    {
        this.bvIn2 = bvIn2;
    }

    public double getBvIn3()
    {
        return bvIn3;
    }

    public void setBvIn3(double bvIn3)
    {
        this.bvIn3 = bvIn3;
    }

    public double getBvIn4()
    {
        return bvIn4;
    }

    public void setBvIn4(double bvIn4)
    {
        this.bvIn4 = bvIn4;
    }

    public double getBvOut()
    {
        return bvOut;
    }

    public void setBvOut(double bvOut)
    {
        this.bvOut = bvOut;
    }

    public double getBvOut1()
    {
        return bvOut1;
    }

    public void setBvOut1(double bvOut1)
    {
        this.bvOut1 = bvOut1;
    }

    public double getBvOut2()
    {
        return bvOut2;
    }

    public void setBvOut2(double bvOut2)
    {
        this.bvOut2 = bvOut2;
    }

    public double getBvOut3()
    {
        return bvOut3;
    }

    public void setBvOut3(double bvOut3)
    {
        this.bvOut3 = bvOut3;
    }

    public double getBvOut4()
    {
        return bvOut4;
    }

    public void setBvOut4(double bvOut4)
    {
        this.bvOut4 = bvOut4;
    }

    public String getCurrencyCode()
    {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode)
    {
        this.currencyCode = currencyCode;
    }

    public String getFromID()
    {
        return fromID;
    }

    public void setFromID(String fromID)
    {
        this.fromID = fromID;
    }

    public String getFromType()
    {
        return fromType;
    }

    public void setFromType(String fromType)
    {
        this.fromType = fromType;
    }

    public double getFullAmountIn()
    {
        return fullAmountIn;
    }

    public void setFullAmountIn(double fullAmountIn)
    {
        this.fullAmountIn = fullAmountIn;
    }

    public double getFullAmountOut()
    {
        return fullAmountOut;
    }

    public void setFullAmountOut(double fullAmountOut)
    {
        this.fullAmountOut = fullAmountOut;
    }

    public String getOwnerID()
    {
        return ownerID;
    }

    public void setOwnerID(String ownerID)
    {
        this.ownerID = ownerID;
    }

    public String getOwnerType()
    {
        return ownerType;
    }

    public void setOwnerType(String ownerType)
    {
        this.ownerType = ownerType;
    }

    
    public String getPeriodID()
    {
        return periodID;
    }

    public void setPeriodID(String periodID)
    {
        this.periodID = periodID;
    }

    public String getReferenceNo()
    {
        return referenceNo;
    }

    public void setReferenceNo(String referenceNo)
    {
        this.referenceNo = referenceNo;
    }

    public String getReferenceType()
    {
        return referenceType;
    }

    public void setReferenceType(String referenceType)
    {
        this.referenceType = referenceType;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public long getSeqID()
    {
        return seqID;
    }

    public void setSeqID(long seqID)
    {
        this.seqID = seqID;
    }

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    public Date getTrxDate()
    {
        return trxDate;
    }

    public void setTrxDate(Date trxDate)
    {
        this.trxDate = trxDate;
    }

    public Time getTrxTime()
    {
        return trxTime;
    }

    public void setTrxTime(Time trxTime)
    {
        this.trxTime = trxTime;
    }

    public String getTrxType()
    {
        return trxType;
    }

    public void setTrxType(String trxType)
    {
        this.trxType = trxType;
    }

    public String getUniversalCurrencyCode()
    {
        return universalCurrencyCode;
    }

    public void setUniversalCurrencyCode(String universalCurrencyCode)
    {
        this.universalCurrencyCode = universalCurrencyCode;
    }

    public double getUniversalCurrencyRate()
    {
        return universalCurrencyRate;
    }

    public void setUniversalCurrencyRate(double universalCurrencyRate)
    {
        this.universalCurrencyRate = universalCurrencyRate;
    }

    public int getWalletType()
    {
        return walletType;
    }

    public void setWalletType(int walletType)
    {
        this.walletType = walletType;
    }

    public String getSellerID()
    {
        return sellerID;
    }

    public void setSellerID(String sellerID)
    {
        this.sellerID = sellerID;
    }

    public String getSellerType()
    {
        return sellerType;
    }

    public void setSellerType(String sellerType)
    {
        this.sellerType = sellerType;
    }

    public String getSellerTypeStatus()
    {
        return sellerTypeStatus;
    }

    public void setSellerTypeStatus(String sellerTypeStatus)
    {
        this.sellerTypeStatus = sellerTypeStatus;
    }

    public void parseBean(BvWalletBean bean, ResultSet rs)
        throws SQLException
    {
        parseBean(bean, rs, "");
    }

    public void parseBean(BvWalletBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        bean.setSeqID(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("bvw_seqid").toString()));
        bean.setTrxDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bvw_trxdate").toString()));
        bean.setTrxTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("bvw_trxtime").toString()));
        bean.setTrxType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_trxtype").toString()));
        bean.setBonusDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bvw_bonusdate").toString()));
        bean.setPeriodID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_periodid").toString()));
        bean.setSellerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_sellerid").toString()));
        bean.setSellerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_sellertype").toString()));
        bean.setSellerTypeStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_seller_typestatus").toString()));
        bean.setOwnerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_ownerid").toString()));
        bean.setOwnerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_ownertype").toString()));
        bean.setFromID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_fromid").toString()));
        bean.setFromType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_fromtype").toString()));
        bean.setWalletType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bvw_wallettype").toString()));
        bean.setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bvw_status").toString()));
        bean.setReferenceType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_reftype").toString()));
        bean.setReferenceNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_refno").toString()));
        bean.setBvIn(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv_in").toString()));
        bean.setBvOut(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv_out").toString()));
        bean.setBvIn1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv1_in").toString()));
        bean.setBvOut1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv1_out").toString()));
        bean.setBvIn2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv2_in").toString()));
        bean.setBvOut2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv2_out").toString()));
        bean.setBvIn3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv3_in").toString()));
        bean.setBvOut3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv3_out").toString()));
        bean.setBvIn4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv4_in").toString()));
        bean.setBvOut4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bv4_out").toString()));
        bean.setFullAmountIn(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_fullamount_in").toString()));
        bean.setFullAmountOut(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_fullamount_out").toString()));
        bean.setBvAmountIn(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bvamount_in").toString()));
        bean.setBvAmountOut(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_bvamount_out").toString()));
        bean.setCurrencyCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_currency_code").toString()));
        bean.setUniversalCurrencyCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_universal_currency_code").toString()));
        bean.setUniversalCurrencyRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bvw_universal_currency_rate").toString()));
        bean.setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bvw_remark").toString()));
        parseInfo(rs, prefix);
    }

    public String getOwnerCRM() {
        return ownerCRM;
    }

    public void setOwnerCRM(String ownerCRM) {
        this.ownerCRM = ownerCRM;
    }

    public String getOwnerSegmentation() {
        return ownerSegmentation;
    }

    public void setOwnerSegmentation(String ownerSegmentation) {
        this.ownerSegmentation = ownerSegmentation;
    }
}
