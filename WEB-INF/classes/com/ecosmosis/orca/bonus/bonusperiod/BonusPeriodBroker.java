// Decompiled by Yody
// File : BonusPeriodBroker.class

package com.ecosmosis.orca.bonus.bonusperiod;

import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import java.sql.*;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.bonus.bonusperiod:
//            BonusPeriodBean

public class BonusPeriodBroker extends DBTransactionBroker
{

    private static final String SQL_UPD_BONUSPERIOD_INFO = " update bonus_period_master  set bpm_totalmembers=?,bpm_totalactivemembers=?,bpm_totalsales=?,bpm_totalbvsales=?,bpm_totalbv=?,bpm_totalbv1=?  ,bpm_totalbv2=?,bpm_totalbv3=?,bpm_totalbv4 =?,bpm_totalbonus=?,bpm_totalmonthlybonus=?,bpm_totalperiodicalbonus=?  ,bpm_totaladminfees=?,bpm_totaladjustment=?,bpm_totaltax=?,bpm_totalstockistbonus=?  where bpm_periodid = ? ";
    private static final String SQL_UPD_BONUSPERIOD_STATUS = " update bonus_period_master  set bpm_periodstatus=?,bpm_status=?,bpm_createdate=?,bpm_opendate=?,  bpm_step1rundate=?,bpm_step2rundate=?,bpm_confirmdate=?,bpm_payoutdate=?,  bpm_bonusmonth=?,bpm_bonusyear=?,bpm_type=? where bpm_periodid = ? ";

    protected BonusPeriodBroker(Connection con)
    {
        super(con);
    }

    protected boolean insert(BonusPeriodBean bean, String tanggal)
        throws SQLException
    {
        boolean status;
        PreparedStatement st;
        PreparedStatement st1;
        
        int cek = 0;
        String sql;
        String sql1;
        
        status = false;
        st = null;
        st1 = null;
        
        String fields = " (bpm_periodid,bpm_startdate,bpm_enddate,bpm_periodstatus,bpm_bonusmonth,bpm_bonusyear,bpm_type,bpm_calculationstatus) ";
        sql = (new StringBuilder(" insert into bonus_period_master ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();        
        
        if (tanggal.equalsIgnoreCase("1"))   
            cek = 10;
            
        st = getConnection().prepareStatement(sql);
        int cnt = 0;
        st.setString(++cnt, bean.getPeriodID());
        st.setDate(++cnt, bean.getStartDate());
        st.setDate(++cnt, bean.getEndDate());
        st.setInt(++cnt, bean.getPeriodstatus());
        st.setInt(++cnt, bean.getBonusMonth());
        st.setInt(++cnt, bean.getBonusYear());
        st.setInt(++cnt, bean.getType());
        st.setInt(++cnt, cek);
        status = st.executeUpdate() == 1;
       
        int bulan = bean.getCalculationstatus();
        System.out.println(" bulan 1 : "+ bulan + " Status "+status+ "cek "+cek );   
        
        // if(bulan == 10)
        //Updated By Ferdi 2015-01-22
        /*if (cek == 10)    
        {        
        st1 = getConnection().prepareStatement(" update document set doc_lastindex = 0 ");       
        status = st1.executeUpdate() == 1;    
        System.out.println(" bulan 2 : "+ bulan + " Status "+status + "cek "+cek);    
        }*/
        //End Updated
        
        
        try
        {
            if(st != null)
                st.close();
            if(st1 != null)
                st1.close();            
        }
        
        catch(SQLException sqlexception) { }
        return status;
    }

    
    protected BonusPeriodBean getBonusPeriod(int seqid)
        throws Exception
    {
        BonusPeriodBean period;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        period = null;
        stmt = null;
        rs = null;
        SQL1 = " select * from bonus_period_master  where bpm_seqid =  ? ";
        stmt = getConnection().prepareStatement(SQL1);
        stmt.setInt(1, seqid);
        rs = stmt.executeQuery();
        if(rs.next())
        {
            period = new BonusPeriodBean();
            period.parseBean(period, rs, null);
        }

        try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        catch(Exception e) { }
        return period;
    }

    protected BonusPeriodBean getBonusPeriod(String periodid)
        throws Exception
    {
        BonusPeriodBean period;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        period = null;
        stmt = null;
        rs = null;
        SQL1 = " select * from bonus_period_master  where bpm_periodid =  ? ";
        stmt = getConnection().prepareStatement(SQL1);
        stmt.setString(1, periodid);
        rs = stmt.executeQuery();
        if(rs.next())
        {
            period = new BonusPeriodBean();
            period.parseBean(period, rs, null);
        }

        try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        catch(Exception e) { }
        return period;
    }

    protected int updateBonusPeriodInfo(BonusPeriodBean bonusperiod)
        throws Exception
    {
        PreparedStatement st;
        int count;
        st = null;
        count = 0;
        st = getConnection().prepareStatement(" update bonus_period_master  set bpm_totalmembers=?,bpm_totalactivemembers=?,bpm_totalsales=?,bpm_totalbvsales=?,bpm_totalbv=?,bpm_totalbv1=?  ,bpm_totalbv2=?,bpm_totalbv3=?,bpm_totalbv4 =?,bpm_totalbonus=?,bpm_totalcarryforwardbonus1=?,bpm_totalcarryforwardbonus2=?,bpm_totalmonthlybonus=?,bpm_totalperiodicalbonus=?  ,bpm_totaladminfees=?,bpm_totalothersfee=?,bpm_totaladjustment=?,bpm_totaltax=?,bpm_totalstockistbonus=?  where bpm_periodid = ? ");
        int cnt = 0;
        st.setInt(++cnt, bonusperiod.getTotalMembers());
        st.setInt(++cnt, bonusperiod.getTotalActiveMembers());
        st.setDouble(++cnt, bonusperiod.getTotalSales());
        st.setDouble(++cnt, bonusperiod.getTotalBvSales());
        st.setDouble(++cnt, bonusperiod.getTotalBv());
        st.setDouble(++cnt, bonusperiod.getTotalBv1());
        st.setDouble(++cnt, bonusperiod.getTotalBv2());
        st.setDouble(++cnt, bonusperiod.getTotalBv3());
        st.setDouble(++cnt, bonusperiod.getTotalBv4());
        st.setDouble(++cnt, bonusperiod.getTotalBonus());
        st.setDouble(++cnt, bonusperiod.getTotalCarryForwardBonus1());
        st.setDouble(++cnt, bonusperiod.getTotalCarryForwardBonus2());
        st.setDouble(++cnt, bonusperiod.getTotalMonthlyBonus());
        st.setDouble(++cnt, bonusperiod.getTotalPeriodicalBonus());
        st.setDouble(++cnt, bonusperiod.getTotalAdminFees());
        st.setDouble(++cnt, bonusperiod.getTotalOthersFee());
        st.setDouble(++cnt, bonusperiod.getTotalAdjustment());
        st.setDouble(++cnt, bonusperiod.getTotalTax());
        st.setDouble(++cnt, bonusperiod.getTotalStockistBonus());
        st.setString(++cnt, bonusperiod.getPeriodID());
        count = st.executeUpdate();

        try
        {
            if(st != null)
                st.close();
        }
        catch(Exception e) { }
        return count;
    }

    protected int updateBonusPeriodStatus(BonusPeriodBean bonusperiod)
        throws Exception
    {
        // berikan nilai awal u/ PreparedStatement, count
        PreparedStatement st;
        int count;
        st = null;
        count = 0;
        
        // berikan nilai st dng proc getConnection().prepareStatement(" ...."), kemudian
        // jalankan proc executeUpdate()
        
        st = getConnection().prepareStatement(" update bonus_period_master  set bpm_periodstatus=?,bpm_status=?,bpm_createdate=?,bpm_opendate=?,  bpm_step1rundate=?,bpm_step2rundate=?,bpm_confirmdate=?,bpm_payoutdate=?,  bpm_bonusmonth=?,bpm_bonusyear=?,bpm_type=? where bpm_periodid = ? ");        
        int cnt = 0;        
        st.setInt(++cnt, bonusperiod.getPeriodstatus());
        st.setString(++cnt, bonusperiod.getStatus());
        st.setDate(++cnt, bonusperiod.getCreateDate());
        st.setDate(++cnt, bonusperiod.getOpenDate());
        st.setDate(++cnt, bonusperiod.getStep1rundate());
        st.setDate(++cnt, bonusperiod.getStep2rundate());
        st.setDate(++cnt, bonusperiod.getConfirmDate());
        st.setDate(++cnt, bonusperiod.getPayoutDate());
        st.setInt(++cnt, bonusperiod.getBonusMonth());
        st.setInt(++cnt, bonusperiod.getBonusYear());
        st.setInt(++cnt, bonusperiod.getType());
        st.setString(++cnt, bonusperiod.getPeriodID());                
        count = st.executeUpdate();

        try
        {
            if(st != null)
                st.close();
        }
        catch(Exception e) { }
        return count;
    }

    protected int updateBonusPeriodStatus2(BonusPeriodBean bonusperiod)
        throws Exception
    {
        // berikan nilai awal u/ PreparedStatement, count
        PreparedStatement st;
        int count;
        st = null;
        count = 0;
        
        // berikan nilai st dng proc getConnection().prepareStatement(" ...."), kemudian
        // jalankan proc executeUpdate()
        
        st = getConnection().prepareStatement(" update bonus_period_master Set  bpm_periodstatus=? where bpm_periodid <= ? ");        
        int cnt = 0;        
        st.setInt(++cnt, bonusperiod.getPeriodstatus());
        st.setString(++cnt, bonusperiod.getPeriodID());                
        count = st.executeUpdate();

        try
        {
            if(st != null)
                st.close();
        }
        catch(Exception e) { }
        return count;
    }
   

    protected int deleteDocument(BonusPeriodBean bonusperiod)
        throws Exception
    {
        // berikan nilai awal u/ PreparedStatement, count
        PreparedStatement st;
        int count;
        st = null;
        count = 0;
        
        // berikan nilai st dng proc getConnection().prepareStatement(" ...."), kemudian
        // jalankan proc executeUpdate()
        
        st = getConnection().prepareStatement(" update bonus_period_master Set  bpm_periodstatus=? where bpm_periodid <= ? ");        
        int cnt = 0;        
        st.setInt(++cnt, bonusperiod.getPeriodstatus());
        st.setString(++cnt, bonusperiod.getPeriodID());                
        count = st.executeUpdate();

        try
        {
            if(st != null)
                st.close();
        }
        catch(Exception e) { }
        return count;
    }
 
    
    protected ArrayList getList(SQLConditionsBean cond)
        throws Exception
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL1 = (new StringBuilder(" select * from bonus_period_master  where bpm_seqid is not null ")).append(cond.getConditions()).append(cond.getOrderby()).append(cond.getLimitClause()).toString();
        stmt = getConnection().prepareStatement(SQL1);
        BonusPeriodBean period;
        for(rs = stmt.executeQuery(); rs.next(); list.add(period))
        {
            period = new BonusPeriodBean();
            period.parseBean(period, rs, null);
        }

        try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        catch(Exception e) { }
        return list;
    }

    protected ArrayList getBonusPeriodListForBonus(String compare, int status)
        throws Exception
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL1 = (new StringBuilder(" select distinct bsm_periodid from bonus_master left join bonus_period_master on bsm_periodid = bpm_periodid  where bsm_status ")).append(compare).append("? and bpm_type = '2' ").append(" order by bpm_seqid desc ").toString();
        stmt = getConnection().prepareStatement(SQL1);
        stmt.setInt(1, status);
        BonusPeriodBean period;
        for(rs = stmt.executeQuery(); rs.next(); list.add(period))
        {
            String id = rs.getString(1);
            period = getBonusPeriod(id);
        }

        try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        catch(Exception e) { }
        return list;
    }

    protected ArrayList getWeeklyBonusPeriodListForBonus(String compare, int status)
        throws Exception
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL1 = (new StringBuilder(" select distinct bsm_periodid from bonus_master left join bonus_period_master on bsm_periodid = bpm_periodid  where bsm_status ")).append(compare).append("? and bpm_type = '1'").append(" order by bpm_seqid desc ").toString();
        stmt = getConnection().prepareStatement(SQL1);
        stmt.setInt(1, status);
        BonusPeriodBean period;
        for(rs = stmt.executeQuery(); rs.next(); list.add(period))
        {
            String id = rs.getString(1);
            period = getBonusPeriod(id);
        }

        try
        {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        }
        catch(Exception e) { }
        return list;
    }
}
