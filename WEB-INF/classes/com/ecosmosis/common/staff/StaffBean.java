// Decompiled by Yody
// File : BankBean.class

package com.ecosmosis.common.staff;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffBean extends MvcBean
{

    private String bankID;
    private String countryID;
    private String name;
    private String otherName;
    private String swiftCode;
    private String status;

    public StaffBean()
    {
    }

    public String getBankID()
    {
        return bankID;
    }

    public void setBankID(String bankID)
    {
        this.bankID = bankID;
    }

    public String getCountryID()
    {
        return countryID;
    }

    public void setCountryID(String countryID)
    {
        this.countryID = countryID;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getOtherName()
    {
        return otherName;
    }

    public void setOtherName(String otherName)
    {
        this.otherName = otherName;
    }

    public String getSwiftCode()
    {
        return swiftCode;
    }

    public void setSwiftCode(String swiftCode)
    {
        this.swiftCode = swiftCode;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public void parseBean(StaffBean bean, ResultSet rs)
        throws SQLException
    {
        parseBean(bean, rs, "");
    }

    public void parseBean(StaffBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        bean.setBankID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mbrid").toString()));
        bean.setCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_home_branchid").toString()));
        bean.setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_name").toString()));
        bean.setOtherName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_address_line1").toString()));
        bean.setSwiftCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_mobileno").toString()));
        bean.setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("mbr_status").toString()));
    }
}
