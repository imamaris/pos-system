// Decompiled by Yody
// File : CounterSalesPaymentBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.paymentmode.PaymentModeBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;


// Referenced classes of package com.ecosmosis.orca.counter.sales:
// CounterSalesOrderBean

public class CounterSalesPaymentBean
{

    private Long seq;
    private int salesID;

    private String paymodeCode;
    private String paymodeDesc;
    private String paymodeEdc;
    private String paymodeTime;        
    private int paymodeGroup;
    
    private String paymodeExpired;
    private String paymodeOwner;  
    
    private String refNo;
    private double amount;
    
    private String currency;
    private double rate;
    
    private int status;
    private String memberID;
    private CounterSalesOrderBean master;
    private PaymentModeBean paymodeBean;

    public String getMemberID()
    {
        return memberID;
    }

    public void setMemberID(String memberID)
    {
        this.memberID = memberID;
    }

    public CounterSalesPaymentBean()
    {
    }

    public double getAmount()
    {
        return amount;
    }

    public void setAmount(double amount)
    {
        this.amount = amount;
    }

    public String getPaymodeCode()
    {
        return paymodeCode;
    }

    public void setPaymodeCode(String paymodeCode)
    {
        this.paymodeCode = paymodeCode;
    }

    public String getPaymodeDesc()
    {
        return paymodeDesc;
    }

    public void setPaymodeDesc(String paymodeDesc)
    {
        this.paymodeDesc = paymodeDesc;
    }

    public int getPaymodeGroup()
    {
        return paymodeGroup;
    }

    public void setPaymodeGroup(int paymodeGroup)
    {
        this.paymodeGroup = paymodeGroup;
    }

    public String getRefNo()
    {
        return refNo;
    }

    public void setRefNo(String refNo)
    {
        this.refNo = refNo;
    }

    public int getSalesID()
    {
        return salesID;
    }

    public void setSalesID(int salesID)
    {
        this.salesID = salesID;
    }

    public Long getSeq()
    {
        return seq;
    }

    public void setSeq(Long seq)
    {
        this.seq = seq;
    }

    public String getPaymodeEdc() {
        return paymodeEdc;
    }

    public void setPaymodeEdc(String paymodeEdc) {
        this.paymodeEdc = paymodeEdc;
    }

    public String getPaymodeTime() {
        return paymodeTime;
    }

    public void setPaymodeTime(String paymodeTime) {
        this.paymodeTime = paymodeTime;
    }

    public String getPaymodeExpired() {
        return paymodeExpired;
    }

    public void setPaymodeExpired(String paymodeExpired) {
        this.paymodeExpired = paymodeExpired;
    }

    public String getPaymodeOwner() {
        return paymodeOwner;
    }

    public void setPaymodeOwner(String paymodeOwner) {
        this.paymodeOwner = paymodeOwner;
    }
    
    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    public CounterSalesOrderBean getMaster()
    {
        return master;
    }

    public void setMaster(CounterSalesOrderBean master)
    {
        this.master = master;
    }

    public PaymentModeBean getPaymodeBean()
    {
        return paymodeBean;
    }

    public void setPaymodeBean(PaymentModeBean paymodeBean)
    {
        this.paymodeBean = paymodeBean;
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
        setSeq(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("csm_seq").toString())));
        setSalesID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csm_salesid").toString()));
        setPaymodeCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_paymodecode").toString()));
        setPaymodeDesc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_paymodedesc").toString()));
        setPaymodeEdc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_paymodeedc").toString()));
        setPaymodeTime(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_paymodetime").toString()));
        
        setPaymodeExpired(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_expired").toString()));
        setPaymodeOwner(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_owner").toString()));
        
        setPaymodeGroup(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csm_paymodegroup").toString()));
        setRefNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_refno").toString()));
        setAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csm_amt").toString()));
        
        setCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("csm_currency").toString()));
        setRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("csm_rate").toString()));  
        
        setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("csm_status").toString()));
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }


}
