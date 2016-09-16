// Decompiled by Yody
// File : PaymentModeBean.class

package com.ecosmosis.orca.paymentmode;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentModeBean extends MvcBean
{

    private String paymodeCode;
    private String defaultDesc;
    private int group;
    private String status;

    public PaymentModeBean()
    {
    }

    public String getDefaultDesc()
    {
        return defaultDesc;
    }

    public void setDefaultDesc(String defaultDesc)
    {
        this.defaultDesc = defaultDesc;
    }

    public int getGroup()
    {
        return group;
    }

    public void setGroup(int group)
    {
        this.group = group;
    }

    public String getPaymodeCode()
    {
        return paymodeCode;
    }

    public void setPaymodeCode(String paymodeCode)
    {
        this.paymodeCode = paymodeCode;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
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
        setPaymodeCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_paymodecode").toString()));
        setDefaultDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_desc").toString()));
        setGroup(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("pmp_group").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_status").toString()));
    }
}
