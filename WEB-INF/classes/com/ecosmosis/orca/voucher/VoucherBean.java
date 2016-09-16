
package com.ecosmosis.orca.voucher;
import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.*;
import java.util.Date;

public class VoucherBean extends MvcBean
{
    private String OvcID;
    private String OutletID;
    private String OvcCode;
    private String OvcDescription;
    private Date OvcIssueDate;
    private Date OvcStartDate;
    private Date OvcEndDate;
    private String OvcCurrencyID;    
    private float OvcRate;
    private float OvcAmount;
    private float OvFAmount;
    private String OvcStatus;
    private String OvcTrxDocno;
    
    public VoucherBean()
    {
    }    
    public void parseBean(ResultSet rs)
    throws SQLException
    {
        parseBean(rs, "");
    }
    public void parseBean(ResultSet rs, String prefix)
     throws SQLException
    {
        if (prefix == null)
            prefix = "";
        
            setOvcID(rs.getString(prefix + "ovc_id"));
            setOutletID(rs.getString(prefix + "ovc_outletid"));
            setOvcCode(rs.getString(prefix + "ovc_code"));
            setOvcDescription(rs.getString(prefix + "ovc_desc"));
            setOvcIssueDate(rs.getDate(prefix + "ovc_issuedate"));
            setOvcStartDate(rs.getDate(prefix + "ovc_startdate"));
            setOvcEndDate(rs.getDate(prefix + "ovc_enddate"));
            setOvcCurrencyID(rs.getString(prefix + "ovc_currencyid"));
            setOvcRate(rs.getFloat(prefix + "ovc_rate"));
            setOvcAmount(rs.getFloat(prefix + "ovc_amount"));
            setOvFAmount(rs.getInt(prefix + "ovc_fmount"));
            setOvcStatus(rs.getString(prefix + "ovc_status"));
            setOvcTrxDocno(rs.getString(prefix + "ovc_trxdocno"));
    } 

    public String getOvcID() {
        return OvcID;
    }

    public void setOvcID(String OvcID) {
        this.OvcID = OvcID;
    }

    public String getOutletID() {
        return OutletID;
    }

    public void setOutletID(String OutletID) {
        this.OutletID = OutletID;
    }

    public String getOvcCode() {
        return OvcCode;
    }

    public void setOvcCode(String OvcCode) {
        this.OvcCode = OvcCode;
    }

    public String getOvcDescription() {
        return OvcDescription;
    }

    public void setOvcDescription(String OvcDescription) {
        this.OvcDescription = OvcDescription;
    }

    public Date getOvcIssueDate() {
        return OvcIssueDate;
    }

    public void setOvcIssueDate(Date OvcIssueDate) {
        this.OvcIssueDate = OvcIssueDate;
    }

    public Date getOvcStartDate() {
        return OvcStartDate;
    }

    public void setOvcStartDate(Date OvcStartDate) {
        this.OvcStartDate = OvcStartDate;
    }

    public Date getOvcEndDate() {
        return OvcEndDate;
    }

    public void setOvcEndDate(Date OvcEndDate) {
        this.OvcEndDate = OvcEndDate;
    }

    public String getOvcCurrencyID() {
        return OvcCurrencyID;
    }

    public void setOvcCurrencyID(String OvcCurrencyID) {
        this.OvcCurrencyID = OvcCurrencyID;
    }

    public float getOvcRate() {
        return OvcRate;
    }

    public void setOvcRate(float OvcRate) {
        this.OvcRate = OvcRate;
    }

    public float getOvcAmount() {
        return OvcAmount;
    }

    public void setOvcAmount(float OvcAmount) {
        this.OvcAmount = OvcAmount;
    }

    public float getOvFAmount() {
        return OvFAmount;
    }

    public void setOvFAmount(float OvFAmount) {
        this.OvFAmount = OvFAmount;
    }

    public String getOvcStatus() {
        return OvcStatus;
    }

    public void setOvcStatus(String OvcStatus) {
        this.OvcStatus = OvcStatus;
    }

    public String getOvcTrxDocno() {
        return OvcTrxDocno;
    }

    public void setOvcTrxDocno(String OvcTrxDocno) {
        this.OvcTrxDocno = OvcTrxDocno;
    }
    
    
}
