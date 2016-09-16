// Decompiled by Yody
// File : BvWalletBroker.class

package com.ecosmosis.orca.bvwallet;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.bvwallet:
//            BvWalletBean

public class BvWalletBroker extends DBTransactionBroker {
    
    protected BvWalletBroker(Connection con) {
        super(con);
    }
    
    protected long insert(BvWalletBean bean)
    throws Exception {
        long seqID;
        PreparedStatement st;
        PreparedStatement st2;
        ResultSet rs;
        String sql1;
        String sql2;
        seqID = -1L;
        st = null;
        st2 = null;
        rs = null;
        String fields = "   (bvw_trxdate,bvw_trxtime ,bvw_trxtype, bvw_bonusdate, bvw_periodid ,bvw_sellerid ,bvw_sellertype, bvw_seller_typestatus, bvw_ownerid ,bvw_ownertype ,bvw_fromid  ,bvw_fromtype ,bvw_wallettype ,bvw_refno ,bvw_reftype ,bvw_bv_in ,bvw_bv_out ,bvw_bv1_in ,bvw_bv1_out  ,bvw_bv2_in,bvw_bv2_out,bvw_bv3_in ,bvw_bv3_out ,bvw_bv4_in ,bvw_bv4_out ,bvw_fullamount_in   ,bvw_fullamount_out ,bvw_bvamount_in ,bvw_bvamount_out,bvw_currency_code  ,bvw_universal_currency_code ,bvw_universal_currency_rate,bvw_remark, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark  ) ";
        sql1 = (new StringBuilder(" insert into bvwallet ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        sql2 = " select max(bvw_seqID) from bvwallet";
        System.out.println(" query : "+sql1);
        st = getConnection().prepareStatement(sql1);
        st2 = getConnection().prepareStatement(sql2);
        int cnt = 0;
        st.setDate(++cnt, new Date(bean.getTrxDate().getTime()));
        st.setTime(++cnt, bean.getTrxTime());
        st.setString(++cnt, bean.getTrxType());
        st.setDate(++cnt, bean.getBonusDate() == null ? null : new Date(bean.getBonusDate().getTime()));
        st.setString(++cnt, bean.getPeriodID());
        st.setString(++cnt, bean.getSellerID());
        st.setString(++cnt, bean.getSellerType());
        st.setString(++cnt, bean.getSellerTypeStatus());
        st.setString(++cnt, bean.getOwnerID());
        st.setString(++cnt, bean.getOwnerType());
        st.setString(++cnt, bean.getFromID());
        st.setString(++cnt, bean.getFromType());
        st.setInt(++cnt, bean.getWalletType());
        st.setString(++cnt, bean.getReferenceNo());
        st.setString(++cnt, bean.getReferenceType());
        st.setDouble(++cnt, bean.getBvIn());
        st.setDouble(++cnt, bean.getBvOut());
        st.setDouble(++cnt, bean.getBvIn1());
        st.setDouble(++cnt, bean.getBvOut1());
        st.setDouble(++cnt, bean.getBvIn2());
        st.setDouble(++cnt, bean.getBvOut2());
        st.setDouble(++cnt, bean.getBvIn3());
        st.setDouble(++cnt, bean.getBvOut3());
        st.setDouble(++cnt, bean.getBvIn4());
        st.setDouble(++cnt, bean.getBvOut4());
        st.setDouble(++cnt, bean.getFullAmountIn());
        st.setDouble(++cnt, bean.getFullAmountOut());
        st.setDouble(++cnt, bean.getBvAmountIn());
        st.setDouble(++cnt, bean.getBvAmountOut());
        st.setString(++cnt, bean.getCurrencyCode());
        st.setString(++cnt, bean.getUniversalCurrencyCode());
        st.setDouble(++cnt, bean.getUniversalCurrencyRate());
        st.setString(++cnt, bean.getRemark());
        bean.setRecordStmt(st, cnt);
        boolean res = st.executeUpdate() == 1;
        if(res) {
            rs = st2.executeQuery();
            if(rs.next())
                seqID = rs.getLong(1);
            if(seqID < 0L)
                throw new MvcException("Error SeqID while Inserting New BV Wallet Item");
        } else {
            throw new MvcException("Error while Inserting New BV Wallet Item");
        }
        
        try {
            if(st != null)
                st.close();
            if(st2 != null)
                st2.close();
            if(rs != null)
                rs.close();
        } catch(SQLException sqlexception) { }
        return seqID;
    }
    
    protected ArrayList getList(String ownerid, String ownertype, Date from, Date to)
    throws Exception {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL1 = " select * from bvwallet ";
        SQL2 = " left join member on bvw_ownerid = mbr_mbrid ";
        if(ownerid != null && ownerid.length() > 0)
            SQL3 = " where bvw_ownerid=? and bvw_ownertype=?  and bvw_bonusdate between ? and ?  order by bvw_trxdate,bvw_trxtime ";
        else
            SQL3 = " where bvw_ownertype=?  and bvw_bonusdate between ? and ?  and  bvwallet.bvw_trxtype IN  ('IADM', 'OADM') order by bvw_trxdate, bvw_trxtime ";
        
        if(ownertype.equalsIgnoreCase("D"))
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
        else
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL3).toString());
        
        if(ownerid != null && ownerid.length() > 0) {
            stmt.setString(1, ownerid);
            stmt.setString(2, ownertype);
            stmt.setDate(3, from);
            stmt.setDate(4, to);
        }else{
            stmt.setString(1, ownertype);
            stmt.setDate(2, from);
            stmt.setDate(3, to);
        }
        /*
        stmt.setString(1, ownerid);
        stmt.setString(2, ownertype);
        stmt.setDate(3, from);
        stmt.setDate(4, to);
         */
        
        BvWalletBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new BvWalletBean();
            bean.parseBean(bean, rs);
            if(bean.getOwnerType().equalsIgnoreCase("D"))
            {
                bean.setOwnerName(rs.getString("mbr_name"));
                bean.setOwnerCRM(rs.getString("mbr_idcrm"));
                bean.setOwnerSegmentation(rs.getString("mbr_segmentation"));
            } 
            
            bean.setBeanType(10);
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return list;
    }
    
    protected ArrayList getListMember(String ownerid, String ownertype, int bvw, Date bonusdate)
    throws Exception {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL1 = " select * from bvwallet ";
        SQL2 = " left join member on bvw_ownerid = mbr_mbrid ";
        SQL3 = " where bvw_ownerid=? and bvw_ownertype=? and bvw_bv1_in >= ? and bvw_bonusdate > ?";
        if(ownertype.equalsIgnoreCase("D"))
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
        else
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL3).toString());
        
        stmt.setString(1, ownerid);
        stmt.setString(2, ownertype);
        // stmt.setInt(3, 110);
        stmt.setInt(3, 55);
        stmt.setDate(4, bonusdate);
        BvWalletBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new BvWalletBean();
            bean.parseBean(bean, rs);
            if(ownertype.equalsIgnoreCase("D"))
                bean.setOwnerName(rs.getString("mbr_name"));
            bean.setBeanType(10);
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return list;
    }
    
    
    protected BvWalletBean getBalance(int status, String ownerid, String ownertype)
    throws Exception {
        BvWalletBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        bean = null;
        stmt = null;
        rs = null;
        SQL1 = " SELECT bvw_ownerid,bvw_ownertype,  sum(bvw_bv_in) -  sum(bvw_bv_out) as bv,  sum(bvw_bv1_in) -  sum(bvw_bv1_out) as bv1,  sum(bvw_bv2_in) -  sum(bvw_bv2_out) as bv2,  sum(bvw_bv3_in) -  sum(bvw_bv3_out) as bv3,  sum(bvw_bv4_in) -  sum(bvw_bv4_out) as bv4,  sum(bvw_fullamount_in) - sum(bvw_fullamount_out) as fullamount,  sum(bvw_bvamount_in) - sum(bvw_bvamount_out) as bvamount  from bvwallet ";
        SQL2 = " left join member on bvw_ownerid = mbr_mbrid ";
        SQL3 = " where bvw_status >= ? and bvw_ownerid=? and bvw_ownertype=?  group by bvw_ownerid,bvw_ownertype ";
        if(ownertype.equalsIgnoreCase("D"))
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
        else
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL3).toString());
        stmt.setInt(1, status);
        stmt.setString(2, ownerid);
        stmt.setString(3, ownertype);
        rs = stmt.executeQuery();
        if(rs.next()) {
            bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(rs.getString("bvw_ownertype"));
            bean.setBvBalance(rs.getDouble("bv"));
            bean.setBv1Balance(rs.getDouble("bv1"));
            bean.setBv2Balance(rs.getDouble("bv2"));
            bean.setBv3Balance(rs.getDouble("bv3"));
            bean.setBv4Balance(rs.getDouble("bv4"));
            bean.setFullamountBalance(rs.getDouble("fullamount"));
            bean.setBvamountBalance(rs.getDouble("bvamount"));
            bean.setBeanType(20);
            if(ownertype.equalsIgnoreCase("D"))
                bean.setOwnerName(rs.getString("mbr_name"));
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return bean;
    }
    
    protected BvWalletBean getDistributorBonusDate(int status, String ownerid, String ownertype)
    throws Exception {
        BvWalletBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        bean = null;
        stmt = null;
        rs = null;
        SQL1 = " SELECT bvw_ownerid, bvw_ownertype,  bvw_bonusdate, bvw_bv1_in from bvwallet ";
        SQL2 = " left join member on bvw_ownerid = mbr_mbrid ";
        // SQL3 = " where bvw_bv1_in >= 110 and bvw_status >= ? and bvw_ownerid=? and bvw_ownertype=? ";
        SQL3 = " where bvw_bv1_in >= 55 and bvw_status >= ? and bvw_ownerid=? and bvw_ownertype=? ";
        stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
        
        stmt.setInt(1, status);
        stmt.setString(2, ownerid);
        stmt.setString(3, ownertype);
        rs = stmt.executeQuery();
        if(rs.next()) {
            bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(rs.getString("bvw_ownertype"));
            bean.setBonusDate(rs.getDate("bvw_bonusdate"));
            bean.setBvIn1(rs.getDouble("bvw_bv1_in"));
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return bean;
    }
    
    protected BvWalletBean getBalanceBetweenDates(int status, String ownerid, String ownertype, Date from, Date to)
    throws Exception {
        BvWalletBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        bean = null;
        stmt = null;
        rs = null;
        SQL1 = " SELECT bvw_ownerid,bvw_ownertype,  sum(bvw_bv_in) -  sum(bvw_bv_out) as bv,  sum(bvw_bv1_in) -  sum(bvw_bv1_out) as bv1,  sum(bvw_bv2_in) -  sum(bvw_bv2_out) as bv2,  sum(bvw_bv3_in) -  sum(bvw_bv3_out) as bv3,  sum(bvw_bv4_in) -  sum(bvw_bv4_out) as bv4,  sum(bvw_fullamount_in) - sum(bvw_fullamount_out) as fullamount,  sum(bvw_bvamount_in) - sum(bvw_bvamount_out) as bvamount  from bvwallet ";
        SQL2 = " left join member on bvw_ownerid = mbr_mbrid ";
        SQL3 = " where bvw_status >= ? and bvw_ownerid=? and bvw_ownertype=?  and bvw_trxdate between ? and ?  group by bvw_ownerid,bvw_ownertype ";
        if(ownertype.equalsIgnoreCase("D"))
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
        else
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL3).toString());
        stmt.setInt(1, status);
        stmt.setString(2, ownerid);
        stmt.setString(3, ownertype);
        stmt.setDate(4, from);
        stmt.setDate(5, to);
        rs = stmt.executeQuery();
        if(rs.next()) {
            bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(rs.getString("bvw_ownertype"));
            bean.setBvBalance(rs.getDouble("bv"));
            bean.setBv1Balance(rs.getDouble("bv1"));
            bean.setBv2Balance(rs.getDouble("bv2"));
            bean.setBv3Balance(rs.getDouble("bv3"));
            bean.setBv4Balance(rs.getDouble("bv4"));
            bean.setFullamountBalance(rs.getDouble("fullamount"));
            bean.setBvamountBalance(rs.getDouble("bvamount"));
            bean.setFromDate(from);
            bean.setToDate(to);
            bean.setBeanType(20);
            if(ownertype.equalsIgnoreCase("D"))
                bean.setOwnerName(rs.getString("mbr_name"));
        }
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return bean;
    }
    
    protected ArrayList getBalanceReport(int status, String periodid, String ownertype, String orderby)
    throws Exception {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL1;
        String SQL2;
        String SQL3;
        String SQL4;
        String SQL5;
        list = new ArrayList();
        BvWalletBean bean = null;
        stmt = null;
        rs = null;
        SQL1 = " SELECT bvw_ownerid,bvw_ownertype, ";
        SQL2 = " member.*,";
        SQL3 = " sum(bvw_bv_in) -  sum(bvw_bv_out) as bv,  sum(bvw_bv1_in) -  sum(bvw_bv1_out) as bv1,  sum(bvw_bv2_in) -  sum(bvw_bv2_out) as bv2,  sum(bvw_bv3_in) -  sum(bvw_bv3_out) as bv3,  sum(bvw_bv4_in) -  sum(bvw_bv4_out) as bv4,  sum(bvw_fullamount_in) - sum(bvw_fullamount_out) as fullamount,  sum(bvw_bvamount_in) - sum(bvw_bvamount_out) as bvamount  from bvwallet ";
        SQL4 = " left join member on bvw_ownerid = mbr_mbrid ";
        SQL5 = " where bvw_status >= ? and bvw_periodid=? and bvw_ownertype=?  group by bvw_ownerid,bvw_ownertype having bv > 0 or bv1 > 0 or bv2 > 0 or bv3 > 0 or bv4 > 0";
        String SQL = null;
        if(ownertype.equalsIgnoreCase("D"))
            SQL = (new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).append(SQL4).append(SQL5).toString();
        else
            SQL = (new StringBuilder(String.valueOf(SQL1))).append(SQL3).append(SQL5).toString();
        if(orderby != null && orderby.length() > 0)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" order by ").append(orderby).toString();
        stmt = getConnection().prepareStatement(SQL);
        stmt.setInt(1, status);
        stmt.setString(2, periodid);
        stmt.setString(3, ownertype);
        // BvWalletBean bean;
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(ownertype);
            bean.setBvBalance(rs.getDouble("bv"));
            bean.setBv1Balance(rs.getDouble("bv1"));
            bean.setBv2Balance(rs.getDouble("bv2"));
            bean.setBv3Balance(rs.getDouble("bv3"));
            bean.setBv4Balance(rs.getDouble("bv4"));
            bean.setFullamountBalance(rs.getDouble("fullamount"));
            bean.setBvamountBalance(rs.getDouble("bvamount"));
            bean.setBeanType(20);
            if(ownertype.equalsIgnoreCase("D"))
                bean.setOwnerName(rs.getString("mbr_name"));
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return list;
    }
    
    protected ArrayList getBalanceReport(SQLConditionsBean cond)
    throws Exception {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        BvWalletBean bean = null;
        stmt = null;
        rs = null;
        SQL = (new StringBuilder(" SELECT bvw_ownerid,bvw_ownertype,member.*,  sum(bvw_bv_in) -  sum(bvw_bv_out) as bv,  sum(bvw_bv1_in) -  sum(bvw_bv1_out) as bv1,  sum(bvw_bv2_in) -  sum(bvw_bv2_out) as bv2,  sum(bvw_bv3_in) -  sum(bvw_bv3_out) as bv3,  sum(bvw_bv4_in) -  sum(bvw_bv4_out) as bv4,  sum(bvw_fullamount_in) - sum(bvw_fullamount_out) as fullamount,  sum(bvw_bvamount_in) - sum(bvw_bvamount_out) as bvamount  from bvwallet left join member on bvw_ownerid = mbr_mbrid  where bvw_seqid is not null ")).append(cond.getConditions()).append(cond.getGroupby()).append(cond.getHaving()).append(cond.getOrderby()).append(cond.getLimitClause()).toString();
        stmt = getConnection().prepareStatement(SQL);
        System.out.println("Query : "+SQL);
        for(rs = stmt.executeQuery(); rs.next(); list.add(bean)) {
            bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(rs.getString("bvw_ownertype"));
            bean.setBvBalance(rs.getDouble("bv"));
            bean.setBv1Balance(rs.getDouble("bv1"));
            bean.setBv2Balance(rs.getDouble("bv2"));
            bean.setBv3Balance(rs.getDouble("bv3"));
            bean.setBv4Balance(rs.getDouble("bv4"));
            bean.setFullamountBalance(rs.getDouble("fullamount"));
            bean.setBvamountBalance(rs.getDouble("bvamount"));
            bean.setBeanType(20);
            if(bean.getOwnerType().equalsIgnoreCase("D"))
            {
                bean.setOwnerName(rs.getString("mbr_name"));
                bean.setOwnerCRM(rs.getString("mbr_idcrm"));
                bean.setOwnerSegmentation(rs.getString("mbr_segmentation"));
            }    
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return list;
    }
    
    protected ArrayList getBalanceReport(int status, Date from, Date to, String ownertype)
    throws Exception {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String sql1;
        list = new ArrayList();
        BvWalletBean bean = null;
        stmt = null;
        rs = null;
        sql1 = " SELECT bvw_ownerid,  sum(bvw_bv_in) -  sum(bvw_bv_out) as bv,  sum(bvw_bv1_in) -  sum(bvw_bv1_out) as bv1,  sum(bvw_bv2_in) -  sum(bvw_bv2_out) as bv2,  sum(bvw_bv3_in) -  sum(bvw_bv3_out) as bv3,  sum(bvw_bv4_in) -  sum(bvw_bv4_out) as bv4,  sum(bvw_fullamount_in) - sum(bvw_fullamount_out) as fullamount,  sum(bvw_bvamount_in) - sum(bvw_bvamount_out) as bvamount  from bvwallet  where bvw_status >= ? and bvw_ownertype = ?  and bvw_trxdate between ? and ?  group by bvw_ownerid ";
        stmt = getConnection().prepareStatement(sql1);
        stmt.setInt(1, status);
        stmt.setString(2, ownertype);
        stmt.setDate(3, from);
        stmt.setDate(4, to);
        rs = stmt.executeQuery();
        if(rs.next()) {
            // BvWalletBean bean = new BvWalletBean();
            bean.setOwnerID(rs.getString("bvw_ownerid"));
            bean.setOwnerType(ownertype);
            bean.setBvBalance(rs.getDouble("bv"));
            bean.setBv1Balance(rs.getDouble("bv1"));
            bean.setBv2Balance(rs.getDouble("bv2"));
            bean.setBv3Balance(rs.getDouble("bv3"));
            bean.setBv4Balance(rs.getDouble("bv4"));
            bean.setFullamountBalance(rs.getDouble("fullamount"));
            bean.setBvamountBalance(rs.getDouble("bvamount"));
            bean.setFromDate(from);
            bean.setToDate(to);
            bean.setBeanType(20);
            list.add(bean);
        }
        
        try {
            if(rs != null)
                rs.close();
            if(stmt != null)
                stmt.close();
        } catch(Exception exception) { }
        return list;
    }
    
    protected boolean updateStatus(long seqID, int status, String remark)
    throws Exception {
        boolean res;
        PreparedStatement st;
        String sql1;
        res = false;
        st = null;
        sql1 = " update bvwallet set bvw_status = ?,bvw_remark=? where bvw_seqid = ? ";
        st = getConnection().prepareStatement(sql1);
        st.setInt(1, status);
        st.setString(2, remark);
        st.setLong(2, seqID);
        res = st.executeUpdate() == 1;
        try {
            if(st != null)
                st.close();
        } catch(SQLException sqlexception) { }
        return res;
    }
    
    protected boolean updateStatus(String refno, String reftype, int status, String remark)
    throws Exception {
        boolean res;
        PreparedStatement st;
        String sql1;
        res = false;
        st = null;
        sql1 = " update bvwallet set bvw_status = ?,bvw_remark=? where bvw_refno=? and bvw_reftype=?";
        st = getConnection().prepareStatement(sql1);
        st.setInt(1, status);
        st.setString(2, remark);
        st.setString(3, refno);
        st.setString(4, reftype);
        res = st.executeUpdate() == 1;
        
        try {
            if(st != null)
                st.close();
        } catch(SQLException sqlexception) { }
        return res;
    }
    protected boolean updateStatus2(String noid, String period, int status, String remark)
    throws Exception {
        boolean res;
        PreparedStatement st;
        String sql1;
        res = false;
        st = null;
        sql1 = " update bvwallet set bvw_status = ?,bvw_remark=? where bvw_ownerid=? and bvw_periodid=?";
        st = getConnection().prepareStatement(sql1);
        st.setInt(1, status);
        st.setString(2, remark);
        st.setString(3, noid);
        st.setString(4, period);
        res = st.executeUpdate() == 1;
        
        try {
            if(st != null)
                st.close();
        } catch(SQLException sqlexception) { }
        return res;
    }
    
    protected ArrayList getStaffList(String branch)
    throws MvcException, SQLException {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        // SQL = "select distinct(cso_bonusperiodid) from counter_sales_order ";
        SQL = " select concat(mbr_mbrid,' - ', concat(mbr_firstname, ' ',mbr_name, ' ',mbr_lastname)) as nama from salesman where mbr_status = 10 and mbr_home_branchid = ?  ";
        // sales.setBonusEarnerName(bonusEarner.getFirstName().trim().concat(" ").concat(bonusEarner.getName()).trim().concat(" ").concat(bonusEarner.getLastName()).trim());
        try {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, branch);
            
            for(rs = stmt.executeQuery(); rs.next();) {
                String value = rs.getString(1);
                if(value != null && value.length() > 0)
                    list.add(value);
            }
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getStaffList --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    protected boolean deletePIN(String customerNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL2;
        status = false;
        stmt = null;

        SQL2 = "delete from member_pin where mbr_mbrid = ?";
        
        try
        {            
            stmt = getConnection().prepareStatement(SQL2);
            stmt.setString(1, customerNo);
            status = stmt.executeUpdate() > 0;                        
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform delete PIN --> ")).append(e.toString()).toString());
        }
        if(stmt != null)
            stmt.close();
        return status;
    }
    
    
}
