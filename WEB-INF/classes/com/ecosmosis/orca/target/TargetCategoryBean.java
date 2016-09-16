/*
 * TargetCategoryBean.java
 *
 * Created on October 29, 2014, 4:15 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.target;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;
//import java.util.Date;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class TargetCategoryBean extends MvcBean {
    
   private int targetID;
   private String outletID;
   private String month;
   private String year;
   private String periode;
   private String brand;
   private String Currency;
   private double targetAmount;
   
   private String categoryID;
   private String category;
   private double categoryTarget;

    public int getTargetID() {
        return targetID;
    }

    public void setTargetID(int targetID) {
        this.targetID = targetID;
    }

    public String getOutletID() {
        return outletID;
    }

    public void setOutletID(String outletID) {
        this.outletID = outletID;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }
    
    public String getPeriode() {
        return periode;
    }

    public void setPeriode(String periode) {
        this.periode = periode;
    }
    
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCurrency() {
        return Currency;
    }

    public void setCurrency(String Currency) {
        this.Currency = Currency;
    }

    public double getTargetAmount() {
        return targetAmount;
    }

    public void setTargetAmount(double targetAmount) {
        this.targetAmount = targetAmount;
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
        setTargetID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("tgt_id").toString()));
        setOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("tgt_outletid").toString()));
        setMonth(rs.getString((new StringBuilder(String.valueOf(prefix))).append("tgt_month").toString()));
        setYear(rs.getString((new StringBuilder(String.valueOf(prefix))).append("tgt_year").toString()));
        setPeriode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("periode").toString()));
        setBrand(rs.getString((new StringBuilder(String.valueOf(prefix))).append("tgt_brand").toString()));
        setCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("tgt_currency").toString()));
        setTargetAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("tgt_amt").toString()));
    }
    
    public String getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(String categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getCategoryTarget() {
        return categoryTarget;
    }

    public void setCategoryTarget(double categoryTarget) {
        this.categoryTarget = categoryTarget;
    }
    
    protected void parseCategoryBean(ResultSet rs)
        throws SQLException
    {
        parseCategoryBean(rs, "");
    }
    
     public void parseCategoryBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setCategoryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_producttype").toString()));
        setCategory(rs.getString((new StringBuilder(String.valueOf(prefix))).append("name").toString()));
        setCategoryTarget(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("target_amt").toString()));
    }

}
