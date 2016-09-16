// Decompiled by Yody
// File : BonusPeriodBean.class

package com.ecosmosis.orca.bonus.bonusperiod;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.*;

public class BonusPeriodBean extends MvcBean
{

    private int seqID;
    private String periodID;
    private Date startDate;
    private Date endDate;
    private int periodstatus;
    private int calculationstatus;
    private String status;
    private Date createDate;
    private Date openDate;
    private Date step1rundate;
    private Date step2rundate;
    private Date confirmDate;
    private Date payoutDate;
    private int totalMembers;
    private int totalActiveMembers;
    private double totalSales;
    private double totalBvSales;
    private double totalBv;
    private double totalBv1;
    private double totalBv2;
    private double totalBv3;
    private double totalBv4;
    private double totalBonus;
    private double totalCarryForwardBonus1;
    private double totalCarryForwardBonus2;
    private double totalMonthlyBonus;
    private double totalYearlyBonus;
    private double totalPeriodicalBonus;
    private double totalAdminFees;
    private double totalOthersFee;
    private double totalTax;
    private double totalAdjustment;
    private double totalStockistBonus;
    private String processMsg;
    private int bonusMonth;
    private int bonusYear;
    private int type;

    public BonusPeriodBean()
    {
    }

    public int getType()
    {
        return type;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    public int getBonusMonth()
    {
        return bonusMonth;
    }

    public void setBonusMonth(int bonusMonth)
    {
        this.bonusMonth = bonusMonth;
    }

    public int getBonusYear()
    {
        return bonusYear;
    }

    public void setBonusYear(int bonusYear)
    {
        this.bonusYear = bonusYear;
    }

    public int getCalculationstatus()
    {
        return calculationstatus;
    }

    public void setCalculationstatus(int calculationstatus)
    {
        this.calculationstatus = calculationstatus;
    }

    public String getProcessMsg()
    {
        return processMsg;
    }

    public void setProcessMsg(String processMsg)
    {
        this.processMsg = processMsg;
    }

    public double getTotalBv()
    {
        return totalBv;
    }

    public void setTotalBv(double totalBv)
    {
        this.totalBv = totalBv;
    }

    public Date getEndDate()
    {
        return endDate;
    }

    public void setEndDate(Date endDate)
    {
        this.endDate = endDate;
    }

    public String getPeriodID()
    {
        return periodID;
    }

    public void setPeriodID(String periodID)
    {
        this.periodID = periodID;
    }

    public int getSeqID()
    {
        return seqID;
    }

    public void setSeqID(int seqID)
    {
        this.seqID = seqID;
    }

    public Date getStartDate()
    {
        return startDate;
    }

    public Date getConfirmDate()
    {
        return confirmDate;
    }

    public void setConfirmDate(Date confirmDate)
    {
        this.confirmDate = confirmDate;
    }

    public Date getCreateDate()
    {
        return createDate;
    }

    public void setCreateDate(Date createDate)
    {
        this.createDate = createDate;
    }

    public Date getOpenDate()
    {
        return openDate;
    }

    public void setOpenDate(Date openDate)
    {
        this.openDate = openDate;
    }

    public Date getPayoutDate()
    {
        return payoutDate;
    }

    public void setPayoutDate(Date payoutDate)
    {
        this.payoutDate = payoutDate;
    }

    public Date getStep1rundate()
    {
        return step1rundate;
    }

    public void setStep1rundate(Date step1rundate)
    {
        this.step1rundate = step1rundate;
    }

    public Date getStep2rundate()
    {
        return step2rundate;
    }

    public void setStep2rundate(Date step2rundate)
    {
        this.step2rundate = step2rundate;
    }

    public void setStartDate(Date startDate)
    {
        this.startDate = startDate;
    }

    public int getTotalActiveMembers()
    {
        return totalActiveMembers;
    }

    public void setTotalActiveMembers(int totalActiveMembers)
    {
        this.totalActiveMembers = totalActiveMembers;
    }

    public double getTotalAdjustment()
    {
        return totalAdjustment;
    }

    public void setTotalAdjustment(double totalAdjustment)
    {
        this.totalAdjustment = totalAdjustment;
    }

    public double getTotalAdminFees()
    {
        return totalAdminFees;
    }

    public void setTotalAdminFees(double totalAdminFees)
    {
        this.totalAdminFees = totalAdminFees;
    }

    public double getTotalOthersFee()
    {
        return totalOthersFee;
    }

    public void setTotalOthersFee(double totalOthersFee)
    {
        this.totalOthersFee = totalOthersFee;
    }

    public double getTotalBonus()
    {
        return totalBonus;
    }

    public void setTotalBonus(double totalBonus)
    {
        this.totalBonus = totalBonus;
    }

    public double getTotalCarryForwardBonus1()
    {
        return totalCarryForwardBonus1;
    }

    public void setTotalCarryForwardBonus1(double totalCarryForwardBonus1)
    {
        this.totalCarryForwardBonus1 = totalCarryForwardBonus1;
    }

    public double getTotalCarryForwardBonus2()
    {
        return totalCarryForwardBonus2;
    }

    public void setTotalCarryForwardBonus2(double totalCarryForwardBonus2)
    {
        this.totalCarryForwardBonus2 = totalCarryForwardBonus2;
    }

    public double getTotalBv1()
    {
        return totalBv1;
    }

    public void setTotalBv1(double totalBv1)
    {
        this.totalBv1 = totalBv1;
    }

    public double getTotalBv2()
    {
        return totalBv2;
    }

    public void setTotalBv2(double totalBv2)
    {
        this.totalBv2 = totalBv2;
    }

    public double getTotalBv3()
    {
        return totalBv3;
    }

    public void setTotalBv3(double totalBv3)
    {
        this.totalBv3 = totalBv3;
    }

    public double getTotalBv4()
    {
        return totalBv4;
    }

    public void setTotalBv4(double totalBv4)
    {
        this.totalBv4 = totalBv4;
    }

    public double getTotalBvSales()
    {
        return totalBvSales;
    }

    public void setTotalBvSales(double totalBvSales)
    {
        this.totalBvSales = totalBvSales;
    }

    public int getTotalMembers()
    {
        return totalMembers;
    }

    public void setTotalMembers(int totalMembers)
    {
        this.totalMembers = totalMembers;
    }

    public double getTotalMonthlyBonus()
    {
        return totalMonthlyBonus;
    }

    public void setTotalMonthlyBonus(double totalMonthlyBonus)
    {
        this.totalMonthlyBonus = totalMonthlyBonus;
    }

    public double getTotalYearlyBonus()
    {
        return totalYearlyBonus;
    }

    public void setTotalYearlyBonus(double totalYearlyBonus)
    {
        this.totalYearlyBonus = totalYearlyBonus;
    }

    public double getTotalPeriodicalBonus()
    {
        return totalPeriodicalBonus;
    }

    public void setTotalPeriodicalBonus(double totalPeriodicalBonus)
    {
        this.totalPeriodicalBonus = totalPeriodicalBonus;
    }

    public double getTotalSales()
    {
        return totalSales;
    }

    public void setTotalSales(double totalSales)
    {
        this.totalSales = totalSales;
    }

    public double getTotalStockistBonus()
    {
        return totalStockistBonus;
    }

    public void setTotalStockistBonus(double totalStockistBonus)
    {
        this.totalStockistBonus = totalStockistBonus;
    }

    public double getTotalTax()
    {
        return totalTax;
    }

    public void setTotalTax(double totalTax)
    {
        this.totalTax = totalTax;
    }

    public int getPeriodstatus()
    {
        return periodstatus;
    }

    public void setPeriodstatus(int periodstatus)
    {
        this.periodstatus = periodstatus;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public void parseBean(BonusPeriodBean bean, ResultSet rs)
        throws SQLException
    {
        parseBean(bean, rs, "");
    }

    public void parseBean(BonusPeriodBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        bean.setSeqID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_seqid").toString()));
        bean.setPeriodID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bpm_periodid").toString()));
        bean.setStartDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_startdate").toString()));
        bean.setEndDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_enddate").toString()));
        bean.setPeriodstatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_periodstatus").toString()));
        bean.setCalculationstatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_calculationstatus").toString()));
        bean.setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("bpm_status").toString()));
        bean.setCreateDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_createdate").toString()));
        bean.setOpenDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_opendate").toString()));
        bean.setStep1rundate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_step1rundate").toString()));
        bean.setStep2rundate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_step2rundate").toString()));
        bean.setConfirmDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_confirmdate").toString()));
        bean.setPayoutDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("bpm_payoutdate").toString()));
        bean.setTotalMembers(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_totalmembers").toString()));
        bean.setTotalActiveMembers(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_totalactivemembers").toString()));
        bean.setTotalSales(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalsales").toString()));
        bean.setTotalBvSales(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbvsales").toString()));
        bean.setTotalBv(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbv").toString()));
        bean.setTotalBv1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbv1").toString()));
        bean.setTotalBv2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbv2").toString()));
        bean.setTotalBv3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbv3").toString()));
        bean.setTotalBv4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbv4").toString()));
        bean.setTotalBonus(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalbonus").toString()));
        bean.setTotalCarryForwardBonus1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalcarryforwardbonus1").toString()));
        bean.setTotalCarryForwardBonus2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalcarryforwardbonus2").toString()));
        bean.setTotalMonthlyBonus(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalmonthlybonus").toString()));
        bean.setTotalYearlyBonus(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalyearlybonus").toString()));
        bean.setTotalPeriodicalBonus(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalperiodicalbonus").toString()));
        bean.setTotalAdminFees(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totaladminfees").toString()));
        bean.setTotalOthersFee(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalothersfee").toString()));
        bean.setTotalAdjustment(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totaladjustment").toString()));
        bean.setTotalTax(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totaltax").toString()));
        bean.setTotalStockistBonus(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("bpm_totalstockistbonus").toString()));
        bean.setBonusMonth(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_bonusmonth").toString()));
        bean.setBonusYear(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_bonusyear").toString()));
        bean.setType(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("bpm_type").toString()));
    }
}
