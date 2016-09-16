// Decompiled by Yody
// File : CurrencyBean.class

package com.ecosmosis.common.currency;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Date;

public class CurrencyRateBean extends MvcBean {
    
    private String code;
    private double symbol;
    private String name;
    private double inRate;
    private double outRate;
    private Date date;
    private String description;
    private String displayformat;
    private String status;
    
    private Date startdate;
    private Date enddate;
    private Time starttime;
    private Time endtime;
    
    
    public CurrencyRateBean() {
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getDisplayformat() {
        return displayformat;
    }
    
    public void setDisplayformat(String displayformat) {
        this.displayformat = displayformat;
    }
    
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public double getInRate() {
        return inRate;
    }
    
    public void setInRate(double inRate) {
        this.inRate = inRate;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public double getOutRate() {
        return outRate;
    }
    
    public void setOutRate(double outRate) {
        this.outRate = outRate;
    }
    
    public double getSymbol() {
        return symbol;
    }
    
    public void setSymbol(double symbol) {
        this.symbol = symbol;
    }
    
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public Date getStartdate() {
        return startdate;
    }
    
    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }
    
    public Date getEnddate() {
        return enddate;
    }
    
    public void setEnddate(Date enddate) {
        this.enddate = enddate;
    }
    
    public Time getStarttime() {
        return starttime;
    }
    
    public void setStarttime(Time starttime) {
        this.starttime = starttime;
    }
    
    public Time getEndtime() {
        return endtime;
    }
    
    public void setEndtime(Time endtime) {
        this.endtime = endtime;
    }    
    
    public void parseBean(CurrencyRateBean bean, ResultSet rs)
    throws SQLException {
        parseBean(bean, rs, "");
    }
    

    
    public void parseBean(CurrencyRateBean bean, ResultSet rs, String prefix)
    throws SQLException {
        if(prefix == null)
            prefix = "";
          
        bean.setCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cer_exchange").toString()));
        bean.setSymbol(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cer_rate").toString()));
        bean.setStartdate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cer_startdate").toString()));
        bean.setEnddate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cer_enddate").toString()));
        bean.setStarttime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("cer_starttime").toString()));
        bean.setEndtime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("cer_endtime").toString()));        
        bean.setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cer_status").toString()));
    }
  

    public void parseBeanDetails(CurrencyRateBean bean, ResultSet rs)
    throws SQLException {
        parseBeanDetails(bean, rs, "");
    }
    
    
    public void parseBeanDetails(CurrencyRateBean bean, ResultSet rs, String prefix)
    throws SQLException {
        if(prefix == null)
            prefix = "";
        bean.setInRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cpc_in").toString()));
        bean.setOutRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cpc_out").toString()));
        bean.setDescription(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cpc_desc").toString()));
        bean.setDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cpc_date").toString()));
    }

    public void parseBean2(ResultSet rs) throws SQLException {
        String prefix = null;
        if(prefix == null)
            prefix = "";        
        
        setCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cer_exchange").toString()));
        setSymbol(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cer_rate").toString()));
        setStartdate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cer_startdate").toString()));
        setEnddate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cer_enddate").toString()));
        setStarttime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("cer_starttime").toString()));
        setEndtime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("cer_endtime").toString()));        
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cer_status").toString()));   
    }
 
    
}
