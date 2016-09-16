// Decompiled by Yody
// File : OutletPaymentModeBean.class

package com.ecosmosis.orca.outlet.paymentmode;

import com.ecosmosis.orca.paymentmode.PaymentModeBean;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OutletPaymentModeBean_1 extends PaymentModeBean
{

    private String outletID;
    
    private int orderSeq;
    private int count;
    private int group;
    
    private String outletEdc;
    private String outletTime;

    public OutletPaymentModeBean_1()
    {
    }

    public int getCount()
    {
        return count;
    }

    public void setCount(int count)
    {
        this.count = count;
    }

    public int getOrderSeq()
    {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq)
    {
        this.orderSeq = orderSeq;
    }

    public String getOutletID()
    {
        return outletID;
    }

    public void setOutletID(String outletID)
    {
        this.outletID = outletID;
    }

    public void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }
    
    public String getOutletEdc() {
        return outletEdc;
    }

    public void setOutletEdc(String outletEdc) {
        this.outletEdc = outletEdc;
    }

    public String getOutletTime() {
        return outletTime;
    }

    public void setOutletTime(String outletTime) {
        this.outletTime = outletTime;
    }

    public int getGroup() {
        return group;
    }

    public void setGroup(int group) {
        this.group = group;
    }    

    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        super.parseBean(rs, prefix);
        setOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("opm_outletid").toString()));
        setOutletEdc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("opm_edc").toString()));
        setOutletTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("opm_time").toString()));
        setOrderSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("opm_order_seq").toString()));
        setCount(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("opm_count").toString()));
        setGroup(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("opm_group").toString()));
    }


}
