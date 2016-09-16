// Decompiled by Yody
// File : ProductPricingBean.class

package com.ecosmosis.orca.pricing.product;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.*;
import java.util.Date;

public class ProductPricingBean extends MvcBean
{

    private int pricingID;
    private String priceCode;
    private String currencyCode;
    private int productID;
    private String promotional;
    private Date startDate;
    private Date endDate;
    private Time startTime;
    private Time endTime;
    private double price;
    private double tax;
    private String status;
    private double bv1;
    private double bv2;
    private double bv3;
    private double bv4;
    private double bv5;

    public ProductPricingBean()
    {
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

    public Date getEndDate()
    {
        return endDate;
    }

    public void setEndDate(Date endDate)
    {
        this.endDate = endDate;
    }

    public Time getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Time endTime)
    {
        this.endTime = endTime;
    }

    public double getPrice()
    {
        return price;
    }

    public void setPrice(double price)
    {
        this.price = price;
    }

    public String getPriceCode()
    {
        return priceCode;
    }

    public void setPriceCode(String priceCode)
    {
        this.priceCode = priceCode;
    }

    public int getPricingID()
    {
        return pricingID;
    }

    public void setPricingID(int pricingID)
    {
        this.pricingID = pricingID;
    }

    public int getProductID()
    {
        return productID;
    }

    public void setProductID(int productID)
    {
        this.productID = productID;
    }

    public String getPromotional()
    {
        return promotional;
    }

    public void setPromotional(String promotional)
    {
        this.promotional = promotional;
    }

    public Date getStartDate()
    {
        return startDate;
    }

    public void setStartDate(Date startDate)
    {
        this.startDate = startDate;
    }

    public Time getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Time startTime)
    {
        this.startTime = startTime;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public double getTax()
    {
        return tax;
    }

    public void setTax(double tax)
    {
        this.tax = tax;
    }

    protected void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }

    protected void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        setPricingID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("ppi_pricingid").toString()));
        setPriceCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ppi_pricecode").toString()));
        setCurrencyCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ppi_currency").toString()));
        setProductID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("ppi_productid").toString()));
        setPromotional(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ppi_promotional").toString()));
        setStartDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("ppi_startdate").toString()));
        setEndDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("ppi_enddate").toString()));
        setStartTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("ppi_starttime").toString()));
        setEndTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("ppi_endtime").toString()));
        setPrice(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_price").toString()));
        setTax(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_tax").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ppi_status").toString()));
        setBv1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_bv1").toString()));
        setBv2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_bv2").toString()));
        setBv3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_bv3").toString()));
        setBv4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_bv4").toString()));
        setBv5(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("ppi_bv5").toString()));
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

}
