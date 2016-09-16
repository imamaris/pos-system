// Decompiled by Yody
// File : CurrencyBean.class

package com.ecosmosis.common.edc;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class EdcBean extends MvcBean
{

    private String code;
    private String symbol;
    private String name;
    private double inRate;
    private double outRate;
    private Date date;
    private String description;
    private String displayformat;
    private String status;

    public EdcBean()
    {
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getDisplayformat()
    {
        return displayformat;
    }

    public void setDisplayformat(String displayformat)
    {
        this.displayformat = displayformat;
    }

    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public double getInRate()
    {
        return inRate;
    }

    public void setInRate(double inRate)
    {
        this.inRate = inRate;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public double getOutRate()
    {
        return outRate;
    }

    public void setOutRate(double outRate)
    {
        this.outRate = outRate;
    }

    public String getSymbol()
    {
        return symbol;
    }

    public void setSymbol(String symbol)
    {
        this.symbol = symbol;
    }

    public Date getDate()
    {
        return date;
    }

    public void setDate(Date date)
    {
        this.date = date;
    }

    public void parseBean(EdcBean bean, ResultSet rs)
        throws SQLException
    {
        parseBean(bean, rs, "");
    }

    public void parseBeanDetails(EdcBean bean, ResultSet rs)
        throws SQLException
    {
        parseBeanDetails(bean, rs, "");
    }

    public void parseBean(EdcBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        bean.setCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("edc_id").toString()));
        bean.setSymbol(rs.getString((new StringBuilder(String.valueOf(prefix))).append("edc_code").toString()));
        bean.setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("edc_name").toString()));
        bean.setDisplayformat(rs.getString((new StringBuilder(String.valueOf(prefix))).append("edc_format").toString()));
        bean.setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("edc_status").toString()));
    }

    public void parseBeanDetails(EdcBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        bean.setInRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cpc_in").toString()));
        bean.setOutRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cpc_out").toString()));
        bean.setDescription(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cpc_desc").toString()));
        bean.setDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cpc_date").toString()));
    }
}
