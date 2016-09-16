/*
 * TargetBean.java
 *
 * Created on November 8, 2013, 4:15 PM
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
public class TargetBean extends MvcBean {
    
   private int targetID;
   private String outletID;
   private String month;
   private String year;
   private String periode;
   private String brand;
   private String Currency;
   private double targetAmount;
   
   private int sequence;
   private String salesmanID;
   private String salesman;
   private double salesmanTarget;

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
    
    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
    }
    
    public String getSalesmanID() {
        return salesmanID;
    }

    public void setSalesmanID(String salesmanID) {
        this.salesmanID = salesmanID;
    }

    public String getSalesman() {
        return salesman;
    }

    public void setSalesman(String salesman) {
        this.salesman = salesman;
    }
    
    public double getSalesmanTarget() {
        return salesmanTarget;
    }

    public void setSalesmanTarget(double salesmanTarget) {
        this.salesmanTarget = salesmanTarget;
    }
    
    protected void parseSalesmanBean(ResultSet rs)
        throws SQLException
    {
        parseSalesmanBean(rs, "");
    }
    
    public void parseSalesmanBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setSequence(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("mbr_seq").toString()));
        setSalesmanID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mbrid").toString()));
        setSalesman(rs.getString((new StringBuilder(String.valueOf(prefix))).append("nama").toString()));
        setSalesmanTarget(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("target_amt").toString()));
    }
}
