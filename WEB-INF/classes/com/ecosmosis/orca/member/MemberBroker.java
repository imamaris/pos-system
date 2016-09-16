package com.ecosmosis.orca.member;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.orca.bean.AddressBean;
import com.ecosmosis.orca.bean.BeneficiaryBean;
import com.ecosmosis.orca.bean.PayeeBankBean;
import com.ecosmosis.orca.bean.SpouseBean;
import com.ecosmosis.orca.bean.SupervisorBean;
import com.ecosmosis.orca.counter.sales.CounterSalesOrderBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.member:
//            MemberBean, MemberChecklist

public class MemberBroker extends DBTransactionBroker
{

    protected static final String SQL_FILTER_HIDDEN_MEMBER = " and mbr_hidden = 'N' ";
    protected static final String SQL_LOCATION_FIELD = " n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ";
    protected static final String SQL_LOCATION_JOIN = " left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id ";
    protected static final String SQL_BANK_FIELD = " b.*";
    protected static final String SQL_BANK_JOIN = " left join bank b on m.mbr_bankid = b.bnk_bankid ";
    protected static final String SQL_INTR_FIELD = " t.* ";
    protected static final String SQL_INTR_JOIN = " left join member t on m.mbr_intrid = t.mbr_mbrid ";
    protected static final String SQL_MEMBER_PROFILE = "select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.*  from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  left join member t on m.mbr_intrid = t.mbr_mbrid ";
    protected static ArrayList likeFields;

/*
    protected MemberBroker(Connection con)
    {
        super(con);
    }
*/
    
    public MemberBroker(Connection con)
    {
        super(con);
    }
    
    protected ArrayList getMemberList(SQLConditionsBean conditions)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = (new StringBuilder("select * from member")).append(conditions.getConditions()).append(conditions.getOrderby()).append(conditions.getLimitConditions()).toString();
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            MemberBean bean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberList --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();    
        return list;
        }
    }

    protected ArrayList searchMemberSelectionForStockist(String memberID, String name, String identityNo, String mobileNo, java.util.Date joinDateFrom, java.util.Date joinDateTo)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        boolean hasMemberID = memberID != null && memberID.length() > 0;
        boolean hasName = name != null && name.length() > 0;
        boolean hasIdentity = identityNo != null && identityNo.length() > 0;
        boolean hasMobileNo = mobileNo != null && mobileNo.length() > 0;
        SQL = "select * from member where mbr_hidden = 'N' ";
        if(hasMemberID)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_mbrid = '").append(memberID).append("'").toString();
        if(hasName)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_name like '%").append(name).append("%'").toString();
        if(hasIdentity)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_identityno like '").append(identityNo).append("%'").toString();
        if(hasMobileNo)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_mobileno = '").append(mobileNo).append("'").toString();
        if(joinDateFrom != null)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_joindate >= ? ").toString();
        if(joinDateTo != null)
            SQL = (new StringBuilder(String.valueOf(SQL))).append(" and mbr_joindate <= ? ").toString();
        SQL = (new StringBuilder(String.valueOf(SQL))).append(" order by mbr_seq limit 50").toString();
        try
        {
            int cnt = 0;
            stmt = getConnection().prepareStatement(SQL);
            if(joinDateFrom != null)
                stmt.setDate(++cnt, new Date(joinDateFrom.getTime()));
            if(joinDateTo != null)
                stmt.setDate(++cnt, new Date(joinDateTo.getTime()));
            MemberBean bean;
            for(rs = stmt.executeQuery(); rs.next(); list.add(bean))
            {
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform searchMemberSelectionForStockist --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();       
        return list;
        }
    }

    protected ArrayList getMemberListByID(String memberID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        list = new ArrayList();
        stmt = null;
        rs = null;
        SQL = "select * from member where mbr_mbrid=? order by mbr_seq";
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(i, memberID);
            rs = stmt.executeQuery();
            int count = 0;
            MemberBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new MemberBean();
                bean.parseAllBean(rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberListByID --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
        }
    }

    protected MemberBean getMemberByID(String memberID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        return getMemberByID(memberID, null, parseFullInfo);
    }

    protected MemberBean getMemberByID(String memberID, String branchID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String SQL_where = (new StringBuilder(" where m.mbr_mbrid=? ")).append(branchID == null ? "" : " and m.mbr_home_branchid = ? ").append(" and m.mbr_status not in (").append(50).append(") order by m.mbr_seq").toString();
        SQL = (new StringBuilder("select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.* from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  " +
                "Left Join member AS t ON m.mbr_intrid = t.mbr_mbrid")).append(SQL_where).toString();
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(i++, memberID);
            if(branchID != null)
                stmt.setString(i++, branchID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                if(parseFullInfo)
                    bean.parseAllBean(rs, "m.");
                else
                    bean.parseSimpleBean(rs, "m.");
                try
                {
                    MemberBean intr = new MemberBean();
                    bean.setIntroducer(intr);
                    intr.parseSimpleBean(rs, "t.");
                    bean.parseLocation(rs);
                    bean.parseBank(rs);
                }
                catch(Exception e)
                {
                    Log.error((new StringBuilder()).append(e).append(" -> Fail to parse joining table info while loading member by Seq").toString());
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberByID --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }

    protected MemberBean getMemberByIdCRM(String memberID, String branchID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String SQL_where = (new StringBuilder(" where m.mbr_idcrm=? ")).append(branchID == null ? "" : " and m.mbr_home_branchid = ? ").append(" and m.mbr_status not in (").append(50).append(") order by m.mbr_seq").toString();
        SQL = (new StringBuilder("select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.* from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  " +
                "Left Join member AS t ON m.mbr_intrid = t.mbr_mbrid")).append(SQL_where).toString();
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(i++, memberID);
            if(branchID != null)
                stmt.setString(i++, branchID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                if(parseFullInfo)
                    bean.parseAllBean(rs, "m.");
                else
                    bean.parseSimpleBean(rs, "m.");
                try
                {
                    MemberBean intr = new MemberBean();
                    bean.setIntroducer(intr);
                    intr.parseSimpleBean(rs, "t.");
                    bean.parseLocation(rs);
                    bean.parseBank(rs);
                }
                catch(Exception e)
                {
                    Log.error((new StringBuilder()).append(e).append(" -> Fail to parse joining table info while loading member by Seq").toString());
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberByID --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }
    
    protected MemberBean getMemberByMobile(String MobileNo, String branchID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String SQL_where = (new StringBuilder(" where m.mbr_mobileno=? ")).append(branchID == null ? "" : " and m.mbr_home_branchid = ? ").append(" and m.mbr_status not in (").append(50).append(") order by m.mbr_seq").toString();
        SQL = (new StringBuilder("select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.* from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  " +
                "Left Join member AS t ON m.mbr_intrid = t.mbr_mbrid")).append(SQL_where).toString();
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(i++, MobileNo);
            if(branchID != null)
                stmt.setString(i++, branchID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                if(parseFullInfo)
                    bean.parseAllBean(rs, "m.");
                else
                    bean.parseSimpleBean(rs, "m.");
                try
                {
                    MemberBean intr = new MemberBean();
                    bean.setIntroducer(intr);
                    intr.parseSimpleBean(rs, "t.");
                    bean.parseLocation(rs);
                    bean.parseBank(rs);
                }
                catch(Exception e)
                {
                    Log.error((new StringBuilder()).append(e).append(" -> Fail to parse joining table info while loading member by Seq").toString());
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberByMobile --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }

    protected MemberBean getMemberByOriginalID(String originalID, String branchID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String SQL_where = (new StringBuilder(" where m.mbr_id_original=? ")).append(branchID == null ? "" : " and m.mbr_home_branchid = ? ").append(" and m.mbr_status not in (").append(50).append(") order by m.mbr_seq").toString();
        SQL = (new StringBuilder("select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.*  from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  left join member t on m.mbr_intrid = t.mbr_mbrid ")).append(SQL_where).toString();
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(i++, originalID);
            if(branchID != null)
                stmt.setString(i++, branchID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                if(parseFullInfo)
                    bean.parseAllBean(rs, "m.");
                else
                    bean.parseSimpleBean(rs, "m.");
                try
                {
                    MemberBean intr = new MemberBean();
                    bean.setIntroducer(intr);
                    intr.parseSimpleBean(rs, "t.");
                    bean.parseLocation(rs);
                    bean.parseBank(rs);
                }
                catch(Exception e)
                {
                    Log.error((new StringBuilder()).append(e).append(" -> Fail to parse joining table info while loading member by Seq").toString());
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberByID --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }

    protected MemberBean getMemberBySeq(int memberSeq, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String SQL_where = " where m.mbr_seq=? and m.mbr_status not in (50) order by m.mbr_seq";
        SQL = (new StringBuilder("select m.*,  n.loc_name as selfnat_loc_name, sp.loc_name as spnat_loc_name, bf.loc_name as bfnat_loc_name, c.loc_name as ctry_loc_name, s.loc_name as state_loc_name, i.loc_name as city_loc_name, mc.loc_name as mail_ctry_loc_name, ms.loc_name as mail_state_loc_name, mi.loc_name as mail_city_loc_name ,  b.*,  t.*  from member m  left join locations n on m.mbr_nationalityid = n.loc_id left join locations sp on m.mbr_spouse_nationalityid = sp.loc_id left join locations bf on m.mbr_bf_nationalityid = bf.loc_id left join locations c on m.mbr_countryid = c.loc_id left join locations s on m.mbr_stateid = s.loc_id left join locations i on m.mbr_cityid = i.loc_id left join locations mc on m.mbr_mailing_countryid = mc.loc_id left join locations ms on m.mbr_mailing_stateid = ms.loc_id left join locations mi on m.mbr_mailing_cityid = mi.loc_id  left join bank b on m.mbr_bankid = b.bnk_bankid  left join member t on m.mbr_intrid = t.mbr_mbrid ")).append(SQL_where).toString();
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(i, memberSeq);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                if(parseFullInfo)
                    bean.parseAllBean(rs, "m.");
                else
                    bean.parseSimpleBean(rs, "m.");
                try
                {
                    MemberBean intr = new MemberBean();
                    intr.setIntroducer(intr);
                    intr.parseSimpleBean(rs, "t.");
                    bean.parseLocation(rs);
                    bean.parseBank(rs);
                }
                catch(Exception e)
                {
                    Log.error((new StringBuilder()).append(e).append(" -> Fail to parse joining table info while loading member by Seq").toString());
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberBySeq --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }

    protected MemberBean getMember(int memberSeq, String memberID, boolean parseFullInfo)
        throws MvcException, SQLException
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        SQL = "select * from member where mbr_seq=? and mbr_mbrid=?";
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(i++, memberSeq);
            stmt.setString(i++, memberID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new MemberBean();
                bean.parseAllBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberBy Seq & MemberID --> ")).append(e.toString()).toString());
        }
       finally
       {
         if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
        }
    }

    protected String getMemberIDBySeq(int memberSeq)
        throws MvcException, SQLException
    {
        String memberID;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        memberID = null;
        stmt = null;
        rs = null;
        SQL = "select mbr_mbrid from member where mbr_seq=?";
        try
        {
            int i = 1;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(i, memberSeq);
            rs = stmt.executeQuery();
            if(rs.next())
                memberID = rs.getString("mbr_mbrid");
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberIDBySeq --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return memberID;
        }
    }

   protected MemberChecklist checkRegisterChecklist(MemberBean member)
        throws MvcException, SQLException
    {
        MemberChecklist chkList = new MemberChecklist();
        try
        {
            // sementara 
            checkDupMember(chkList, member.getIdentityNo(), member.getMemberID());
            
            System.out.println("masuk checkRegisterChecklist " + member.getIdentityNo() + "member : "+ member.getMemberID());  
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkRegisterChecklist --> ")).append(e.toString()).toString());
        }
        return chkList;
    }

    protected MemberChecklist checkDupIdentity(MemberBean member)
        throws MvcException, SQLException
    {
        MemberChecklist chkList = new MemberChecklist();
        try
        {
            checkDupIdentity(chkList, member.getIdentityNo());
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkDupIdentity --> ")).append(e.toString()).toString());
        }
        return chkList;
    }

    protected void checkDupRegFormNo(MemberChecklist chkList, String formNo)
        throws MvcException, SQLException
    {
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_sameFormNo;
        stmt = null;
        rs = null;
        SQL_sameFormNo = "select * from member where mbr_register_formno=? and mbr_status not in (50) order by mbr_register_formno, mbr_seq";
        try
        {
            int count = 0;
            int i = 1;
            stmt = getConnection().prepareStatement(SQL_sameFormNo);
            stmt.setString(i++, formNo);
            MemberBean bean;
            for(rs = stmt.executeQuery(); rs.next(); chkList.addDupRegForm(bean))
            {
                count++;
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }

            Log.debug((new StringBuilder()).append(this).append(" -> checkRegisterChecklist ConflictRegFormNo: ").append(count).toString());
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkDupRegFormNo --> ")).append(e.toString()).toString());
        }
        finally
        {
         if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return;
        }
    }

    protected void checkDupMember(MemberChecklist chkList, String identityNo, String memberID)
        throws MvcException, SQLException
    {
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_dup;
        stmt = null;
        rs = null;
        // sementara hanya NoID
        // SQL_dup = "select * from member where mbr_identityno=? or mbr_company_registerno=? or mbr_nric=? or mbr_oldnric=? or mbr_passport=? or mbr_mbrid=?  and mbr_status not in (50) order by mbr_status, mbr_seq";
        SQL_dup = "select * from member where mbr_mbrid=?  and mbr_status not in (50) order by mbr_status, mbr_seq";
        try
        {
            int count = 0;
            int i = 1;
            stmt = getConnection().prepareStatement(SQL_dup);
            // stmt.setString(i++, identityNo);
            // stmt.setString(i++, identityNo);
            // stmt.setString(i++, identityNo);
            // stmt.setString(i++, identityNo);
            // stmt.setString(i++, identityNo);
            stmt.setString(i++, memberID);
            MemberBean bean;
            for(rs = stmt.executeQuery(); rs.next(); chkList.addIdentityStatus(String.valueOf(bean.getStatus()), bean))
            {
                count++;
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }

            Log.debug((new StringBuilder()).append(this).append(" -> checkRegisterChecklist AcctHistory: ").append(count).toString());
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkDupMember --> ")).append(e.toString()).toString());
        }
        finally
        {
         if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return;
        }
    }

    protected void checkDupIdentity(MemberChecklist chkList, String identityNo)
        throws MvcException, SQLException
    {
        PreparedStatement stmt;
        ResultSet rs;
        String SQL_dup;
        stmt = null;
        rs = null;
        SQL_dup = "select * from member where mbr_identityno=? or mbr_company_registerno=? or mbr_nric=? or mbr_oldnric=? or mbr_passport=?  and mbr_status not in (50) order by mbr_status, mbr_seq";
        try
        {
            int count = 0;
            int i = 1;
            stmt = getConnection().prepareStatement(SQL_dup);
            stmt.setString(i++, identityNo);
            stmt.setString(i++, identityNo);
            stmt.setString(i++, identityNo);
            stmt.setString(i++, identityNo);
            stmt.setString(i++, identityNo);
            MemberBean bean;
            for(rs = stmt.executeQuery(); rs.next(); chkList.addIdentityStatus(String.valueOf(bean.getStatus()), bean))
            {
                count++;
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }

            Log.debug((new StringBuilder()).append(this).append(" -> checkDupIdentity : ").append(count).toString());
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkDupIdentity --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return;
        }
    }

    protected boolean addMemberBonusStatus(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "insert into member_bonus_status (mbs_memberid) values (?)";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, member.getMemberID());
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform addMemberBonusStatus --> ")).append(e.toString()).toString());
        }         
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }


    protected boolean quickRegisterMember(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "mbr_mbrid, mbr_passwd, mbr_epin, mbr_home_branchid, mbr_bonus_rank, mbr_bonus_tree, mbr_payout_currency, mbr_type, mbr_register, mbr_joindate, mbr_jointime, mbr_title, mbr_name, mbr_firstname, mbr_lastname, mbr_displayname, mbr_identityno, mbr_identitytype, mbr_company_name, mbr_company_registerno, mbr_nric, mbr_oldnric, mbr_passport, mbr_dob, mbr_intrid, mbr_intr_name, mbr_intr_identityno, mbr_intr_contact, mbr_intr_missing, mbr_placementid, mbr_placement_name, mbr_placement_identityno, mbr_placement_contact, mbr_id_original, mbr_placement_missing, mbr_remark, mbr_register_formno, mbr_register_prefix, mbr_register_status, mbr_status, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark ";
        SQL = (new StringBuilder("insert into member (")).append(fields).append(") values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++i, member.getMemberID());
            stmt.setString(++i, member.getPassword());
            stmt.setString(++i, member.getEpin());
            stmt.setString(++i, member.getHomeBranchID());
            stmt.setInt(++i, member.getBonusRank());
            stmt.setInt(++i, member.getBonusTree());
            stmt.setString(++i, member.getPayoutCurrency());
            stmt.setString(++i, member.getType());
            stmt.setInt(++i, member.getRegister());        
            stmt.setDate(++i, new Date(member.getJoinDate().getTime()));
            if(member.getJoinTime() == null)
                member.setJoinTime(new Time((new java.util.Date()).getTime()));
            stmt.setTime(++i, new Time(member.getJoinTime().getTime()));
            stmt.setString(++i, member.getTitle());
            stmt.setString(++i, member.getName());
            stmt.setString(++i, member.getFirstName());
            stmt.setString(++i, member.getLastName());
            stmt.setString(++i, member.getDisplayName());
            stmt.setString(++i, member.getIdentityNo());
            stmt.setString(++i, member.getIdentityType());
            stmt.setString(++i, member.getCompanyName());
            stmt.setString(++i, member.getCompanyRegNo());
            stmt.setString(++i, member.getNric());
            stmt.setString(++i, member.getOldNric());
            stmt.setString(++i, member.getPassport());
            stmt.setDate(++i, member.getDob() == null ? null : new Date(member.getDob().getTime()));
            stmt.setString(++i, member.getIntroducerID());
            stmt.setString(++i, member.getIntroducerName());
            stmt.setString(++i, member.getIntroducerIdentityNo());
            stmt.setString(++i, member.getIntroducerContact());
            stmt.setString(++i, member.getIntroducerMissing());
            stmt.setString(++i, member.getPlacementID());
            stmt.setString(++i, member.getPlacementName());
            stmt.setString(++i, member.getPlacementIdentityNo());
            stmt.setString(++i, member.getPlacementContact());
            stmt.setString(++i, member.getOriginalID());
            stmt.setString(++i, member.getPlacementMissing());
            stmt.setString(++i, member.getRemark());
            stmt.setString(++i, member.getRegFormNo());
            stmt.setString(++i, member.getRegPrefix());
            stmt.setInt(++i, member.getRegStatus());
            stmt.setInt(++i, member.getStatus());
            member.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                member.setMemberSeq(rs.getInt(1));
          
            
          //  System.out.println("Epin " + member.getEpin() + " E Type " + member.getType() + " E Register " + member.getRegister());   
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform quickRegisterMember --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
        }
    }
   
    protected boolean fullRegisterMember(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null;
        String fields = "mbr_mbrid, mbr_passwd, mbr_epin, mbr_home_branchid, mbr_bonus_rank, mbr_bonus_tree, mbr_payout_currency, mbr_type, mbr_register, mbr_joindate, mbr_jointime, mbr_title, mbr_name, mbr_firstname, mbr_lastname, mbr_displayname, mbr_identityno, mbr_identitytype, mbr_company_name, mbr_company_registerno, mbr_company_registerdate, mbr_nric, mbr_oldnric, mbr_passport, mbr_income_taxno, mbr_dob, mbr_gender, mbr_nationalityid, mbr_race, mbr_marital, mbr_children, mbr_occupation, mbr_occupation_position, mbr_language, mbr_address_line1, mbr_address_line2, mbr_zipcode, mbr_countryid, mbr_regioinid, mbr_stateid, mbr_cityid, mbr_mailing_address_line1, mbr_mailing_address_line2, mbr_mailing_zipcode, mbr_mailing_countryid, mbr_mailing_regioinid, mbr_mailing_stateid, mbr_mailing_cityid, mbr_officeno, mbr_faxno, mbr_homeno, mbr_mobileno, mbr_email, mbr_supervisor_title, mbr_supervisor_name, mbr_supervisor_firstname, mbr_supervisor_lastname, mbr_supervisor_nric, mbr_supervisor_position, mbr_supervisor_officeno, mbr_supervisor_faxno, mbr_supervisor_homeno, mbr_supervisor_mobileno, mbr_bankid, mbr_bank_acctno, mbr_bank_accttype, mbr_bank_branch, mbr_payee_name, mbr_payee_nric, mbr_spouse_name, mbr_spouse_firstname, mbr_spouse_lastname, mbr_spouse_nric, mbr_spouse_oldnric, mbr_spouse_dob, mbr_spouse_nationalityid, mbr_spouse_race, mbr_spouse_occupation, mbr_spouse_contact, mbr_bf_name, mbr_bf_firstname, mbr_bf_lastname, mbr_bf_nric, mbr_bf_oldnric, mbr_bf_dob, mbr_bf_gender, mbr_bf_nationalityid, mbr_bf_race, mbr_bf_occupation, mbr_bf_contact, mbr_bf_relship, mbr_intrid, mbr_intr_name, mbr_intr_identityno, mbr_intr_contact, mbr_intr_missing, mbr_placementid, mbr_placement_name, mbr_placement_identityno, mbr_placement_contact, mbr_id_original, mbr_placement_missing, mbr_remark, mbr_register_formno, mbr_register_prefix, mbr_register_status, mbr_status, mbr_ethnic, std_createby, std_createdate, std_createtime, std_modifyby, std_modifydate, std_modifytime, std_deleteby, std_deletedate, std_deletetime, std_deleteremark "; //Updated By Ferdi 2015-01-23
        SQL = (new StringBuilder("insert into member (")).append(fields).append(") values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++i, member.getMemberID());
            stmt.setString(++i, member.getPassword());
            stmt.setString(++i, member.getEpin());
            stmt.setString(++i, member.getHomeBranchID());
            stmt.setInt(++i, member.getBonusRank());
            stmt.setInt(++i, member.getBonusTree());
            stmt.setString(++i, member.getPayoutCurrency());
            stmt.setString(++i, member.getType());
            stmt.setInt(++i, member.getRegister());
            stmt.setDate(++i, new Date(member.getJoinDate().getTime()));
            if(member.getJoinTime() == null)
                member.setJoinTime(new Time((new java.util.Date()).getTime()));
            stmt.setTime(++i, new Time(member.getJoinTime().getTime()));
            stmt.setString(++i, member.getTitle());
            stmt.setString(++i, member.getName());
            stmt.setString(++i, member.getFirstName());
            stmt.setString(++i, member.getLastName());
            stmt.setString(++i, member.getDisplayName());
            stmt.setString(++i, member.getIdentityNo());
            stmt.setString(++i, member.getIdentityType());
            stmt.setString(++i, member.getCompanyName());
            stmt.setString(++i, member.getCompanyRegNo());
            stmt.setDate(++i, member.getCompanyRegDate() == null ? null : new Date(member.getCompanyRegDate().getTime()));
            stmt.setString(++i, member.getNric());
            stmt.setString(++i, member.getOldNric());
            stmt.setString(++i, member.getPassport());
            stmt.setString(++i, member.getIncomeTaxNo());
            stmt.setDate(++i, member.getDob() == null ? null : new Date(member.getDob().getTime()));
            stmt.setString(++i, member.getGender());
            stmt.setString(++i, member.getNationalityID());
            stmt.setString(++i, member.getRace());
            stmt.setString(++i, member.getMarital());
            stmt.setInt(++i, member.getChildren());
            stmt.setString(++i, member.getOccupation());
            stmt.setString(++i, member.getOccupationPosition());
            stmt.setString(++i, member.getLanguage());
            AddressBean address = member.getAddress();
            stmt.setString(++i, address.getAddressLine1());
            stmt.setString(++i, address.getAddressLine2());
            stmt.setString(++i, address.getZipCode());
            stmt.setString(++i, address.getCountryID());
            stmt.setString(++i, address.getRegionID());
            stmt.setString(++i, address.getStateID());
            stmt.setString(++i, address.getCityID());
            stmt.setString(++i, address.getMailAddressLine1());
            stmt.setString(++i, address.getMailAddressLine2());
            stmt.setString(++i, address.getMailZipCode());
            stmt.setString(++i, address.getMailCountryID());
            stmt.setString(++i, address.getMailRegionID());
            stmt.setString(++i, address.getMailStateID());
            stmt.setString(++i, address.getMailCityID());
            stmt.setString(++i, member.getOfficeNo());
            stmt.setString(++i, member.getFaxNo());
            stmt.setString(++i, member.getHomeNo());
            stmt.setString(++i, member.getMobileNo());
            stmt.setString(++i, member.getEmail());
            SupervisorBean supervisor = member.getSupervisor();
            stmt.setString(++i, supervisor.getSuperTitle());
            stmt.setString(++i, supervisor.getSuperName());
            stmt.setString(++i, supervisor.getSuperFirstName());
            stmt.setString(++i, supervisor.getSuperLastName());
            stmt.setString(++i, supervisor.getSuperNric());
            stmt.setString(++i, supervisor.getSuperOccupationPosition());
            stmt.setString(++i, supervisor.getSuperOfficeNo());
            stmt.setString(++i, supervisor.getSuperFaxNo());
            stmt.setString(++i, supervisor.getSuperHomeNo());
            stmt.setString(++i, supervisor.getSuperMobileNo());
            PayeeBankBean bank = member.getPayeeBank();
            stmt.setString(++i, bank.getBankID());
            stmt.setString(++i, bank.getBankAcctNo());
            stmt.setString(++i, bank.getBankAcctType());
            stmt.setString(++i, bank.getBankBranch());
            stmt.setString(++i, bank.getBankPayeeName());
            stmt.setString(++i, bank.getBankPayeeNric());
            SpouseBean spouse = member.getSpouse();
            stmt.setString(++i, spouse.getSpouseName());
            stmt.setString(++i, spouse.getSpouseFirstName());
            stmt.setString(++i, spouse.getSpouseLastName());
            stmt.setString(++i, spouse.getSpouseNric());
            stmt.setString(++i, spouse.getSpouseOldNric());
            stmt.setDate(++i, spouse.getSpouseDob() == null ? null : new Date(spouse.getSpouseDob().getTime()));
            stmt.setString(++i, spouse.getSpouseNationalityID());
            stmt.setString(++i, spouse.getSpouseRace());
            stmt.setString(++i, spouse.getSpouseOccupation());
            stmt.setString(++i, spouse.getSpouseContact());
            BeneficiaryBean bf = member.getBeneficiary();
            stmt.setString(++i, bf.getBfName());
            stmt.setString(++i, bf.getBfFirstName());
            stmt.setString(++i, bf.getBfLastName());
            stmt.setString(++i, bf.getBfNric());
            stmt.setString(++i, bf.getBfOldNric());
            stmt.setDate(++i, bf.getBfDob() == null ? null : new Date(bf.getBfDob().getTime()));
            stmt.setString(++i, bf.getBfGender());
            stmt.setString(++i, bf.getBfNationalityID());
            stmt.setString(++i, bf.getBfRace());
            stmt.setString(++i, bf.getBfOccupation());
            stmt.setString(++i, bf.getBfContact());
            stmt.setString(++i, bf.getBfRelationship());
            stmt.setString(++i, member.getIntroducerID());
            stmt.setString(++i, member.getIntroducerName());
            stmt.setString(++i, member.getIntroducerIdentityNo());
            stmt.setString(++i, member.getIntroducerContact());
            stmt.setString(++i, member.getIntroducerMissing());
            stmt.setString(++i, member.getPlacementID());
            stmt.setString(++i, member.getPlacementName());
            stmt.setString(++i, member.getPlacementIdentityNo());
            stmt.setString(++i, member.getPlacementContact());
            stmt.setString(++i, member.getOriginalID());
            stmt.setString(++i, member.getPlacementMissing());
            stmt.setString(++i, member.getRemark());
            stmt.setString(++i, member.getRegFormNo());
            stmt.setString(++i, member.getRegPrefix());
            stmt.setInt(++i, member.getRegStatus());
            stmt.setInt(++i, member.getStatus());
            stmt.setString(++i, member.getEthnic()); //Updated By Ferdi 2015-01-23
            member.setRecordStmt(stmt, i);
            status = stmt.executeUpdate() > 0;
            rs = stmt.getGeneratedKeys();
            if(rs != null && rs.next())
                member.setMemberSeq(rs.getInt(1));
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform fullRegisterMember --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
        }
    }

    protected boolean updateMember(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        String fields = "mbr_passwd=?, mbr_epin=?, mbr_payout_currency=?,  mbr_title=?, mbr_name=?, mbr_firstname=?, mbr_lastname=?, mbr_displayname=?, mbr_identityno=?, mbr_identitytype=?, mbr_company_name=?, mbr_company_registerno=?, mbr_company_registerdate=?, mbr_nric=?, mbr_oldnric=?, mbr_passport=?, mbr_income_taxno=?, mbr_bonus_rank=?,mbr_dob=?, mbr_gender=?, mbr_nationalityid=?, mbr_race=?, mbr_marital=?, mbr_children=?, mbr_occupation=?, mbr_occupation_position=?, mbr_language=?, mbr_address_line1=?, mbr_address_line2=?, mbr_zipcode=?, mbr_countryid=?, mbr_regioinid=?, mbr_stateid=?, mbr_cityid=?, mbr_mailing_address_line1=?, mbr_mailing_address_line2=?, mbr_mailing_zipcode=?, mbr_mailing_countryid=?, mbr_mailing_regioinid=?, mbr_mailing_stateid=?, mbr_mailing_cityid=?, mbr_officeno=?, mbr_faxno=?, mbr_homeno=?, mbr_mobileno=?, mbr_email=?, mbr_supervisor_title=?, mbr_supervisor_name=?, mbr_supervisor_firstname=?, mbr_supervisor_lastname=?, mbr_supervisor_nric=?, mbr_supervisor_position=?, mbr_supervisor_officeno=?, mbr_supervisor_faxno=?, mbr_supervisor_homeno=?, mbr_supervisor_mobileno=?, mbr_bankid=?, mbr_bank_acctno=?, mbr_bank_accttype=?, mbr_bank_branch=?, mbr_payee_name=?, mbr_payee_nric=?, mbr_spouse_name=?, mbr_spouse_firstname=?, mbr_spouse_lastname=?, mbr_spouse_nric=?, mbr_spouse_oldnric=?, mbr_spouse_dob=?, mbr_spouse_nationalityid=?, mbr_spouse_race=?, mbr_spouse_occupation=?, mbr_spouse_contact=?, mbr_bf_name=?, mbr_bf_firstname=?, mbr_bf_lastname=?, mbr_bf_nric=?, mbr_bf_oldnric=?, mbr_bf_dob=?, mbr_bf_gender=?, mbr_bf_nationalityid=?, mbr_bf_race=?, mbr_bf_occupation=?, mbr_bf_contact=?, mbr_bf_relship=?, mbr_intrid=?, mbr_intr_name=?, mbr_intr_identityno=?, mbr_intr_contact=?, mbr_intr_missing=?, mbr_placementid=?, mbr_placement_name=?, mbr_placement_identityno=?, mbr_placement_contact=?, mbr_id_original=?, mbr_placement_missing=?, mbr_remark=?, mbr_register_status=?, mbr_login_status=?, mbr_status=?, mbr_ethnic=?, std_modifyby=?, std_modifydate=?, std_modifytime=?"; //Updated By Ferdi 2015-01-23
        SQL = (new StringBuilder("update member set ")).append(fields).append(" where mbr_seq=?").toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++i, member.getPassword());
            stmt.setString(++i, member.getEpin());
            stmt.setString(++i, member.getPayoutCurrency());
            stmt.setString(++i, member.getTitle());
            stmt.setString(++i, member.getName());
            stmt.setString(++i, member.getFirstName());
            stmt.setString(++i, member.getLastName());
            stmt.setString(++i, member.getDisplayName());
            stmt.setString(++i, member.getIdentityNo());
            stmt.setString(++i, member.getIdentityType());
            stmt.setString(++i, member.getCompanyName());
            stmt.setString(++i, member.getCompanyRegNo());
            stmt.setDate(++i, member.getCompanyRegDate() == null ? null : new Date(member.getCompanyRegDate().getTime()));
            stmt.setString(++i, member.getNric());
            stmt.setString(++i, member.getOldNric());
            stmt.setString(++i, member.getPassport());
            stmt.setString(++i, member.getIncomeTaxNo());
            stmt.setInt(++i, member.getBonusRank());
            stmt.setDate(++i, member.getDob() == null ? null : new Date(member.getDob().getTime()));
            stmt.setString(++i, member.getGender());
            stmt.setString(++i, member.getNationalityID());
            stmt.setString(++i, member.getRace());
            stmt.setString(++i, member.getMarital());
            stmt.setInt(++i, member.getChildren());
            stmt.setString(++i, member.getOccupation());
            stmt.setString(++i, member.getOccupationPosition());
            stmt.setString(++i, member.getLanguage());
            AddressBean address = member.getAddress();
            stmt.setString(++i, address.getAddressLine1());
            stmt.setString(++i, address.getAddressLine2());
            stmt.setString(++i, address.getZipCode());
            stmt.setString(++i, address.getCountryID());
            stmt.setString(++i, address.getRegionID());
            stmt.setString(++i, address.getStateID());
            stmt.setString(++i, address.getCityID());
            stmt.setString(++i, address.getMailAddressLine1());
            stmt.setString(++i, address.getMailAddressLine2());
            stmt.setString(++i, address.getMailZipCode());
            stmt.setString(++i, address.getMailCountryID());
            stmt.setString(++i, address.getMailRegionID());
            stmt.setString(++i, address.getMailStateID());
            stmt.setString(++i, address.getMailCityID());
            stmt.setString(++i, member.getOfficeNo());
            stmt.setString(++i, member.getFaxNo());
            stmt.setString(++i, member.getHomeNo());
            stmt.setString(++i, member.getMobileNo());
            stmt.setString(++i, member.getEmail());
            SupervisorBean supervisor = member.getSupervisor();
            stmt.setString(++i, supervisor.getSuperTitle());
            stmt.setString(++i, supervisor.getSuperName());
            stmt.setString(++i, supervisor.getSuperFirstName());
            stmt.setString(++i, supervisor.getSuperLastName());
            stmt.setString(++i, supervisor.getSuperNric());
            stmt.setString(++i, supervisor.getSuperOccupationPosition());
            stmt.setString(++i, supervisor.getSuperOfficeNo());
            stmt.setString(++i, supervisor.getSuperFaxNo());
            stmt.setString(++i, supervisor.getSuperHomeNo());
            stmt.setString(++i, supervisor.getSuperMobileNo());
            PayeeBankBean bank = member.getPayeeBank();
            stmt.setString(++i, bank.getBankID());
            stmt.setString(++i, bank.getBankAcctNo());
            stmt.setString(++i, bank.getBankAcctType());
            stmt.setString(++i, bank.getBankBranch());
            stmt.setString(++i, bank.getBankPayeeName());
            stmt.setString(++i, bank.getBankPayeeNric());
            SpouseBean spouse = member.getSpouse();
            stmt.setString(++i, spouse.getSpouseName());
            stmt.setString(++i, spouse.getSpouseFirstName());
            stmt.setString(++i, spouse.getSpouseLastName());
            stmt.setString(++i, spouse.getSpouseNric());
            stmt.setString(++i, spouse.getSpouseOldNric());
            stmt.setDate(++i, spouse.getSpouseDob() == null ? null : new Date(spouse.getSpouseDob().getTime()));
            stmt.setString(++i, spouse.getSpouseNationalityID());
            stmt.setString(++i, spouse.getSpouseRace());
            stmt.setString(++i, spouse.getSpouseOccupation());
            stmt.setString(++i, spouse.getSpouseContact());
            BeneficiaryBean bf = member.getBeneficiary();
            stmt.setString(++i, bf.getBfName());
            stmt.setString(++i, bf.getBfFirstName());
            stmt.setString(++i, bf.getBfLastName());
            stmt.setString(++i, bf.getBfNric());
            stmt.setString(++i, bf.getBfOldNric());
            stmt.setDate(++i, bf.getBfDob() == null ? null : new Date(bf.getBfDob().getTime()));
            stmt.setString(++i, bf.getBfGender());
            stmt.setString(++i, bf.getBfNationalityID());
            stmt.setString(++i, bf.getBfRace());
            stmt.setString(++i, bf.getBfOccupation());
            stmt.setString(++i, bf.getBfContact());
            stmt.setString(++i, bf.getBfRelationship());
            stmt.setString(++i, member.getIntroducerID());
            stmt.setString(++i, member.getIntroducerName());
            stmt.setString(++i, member.getIntroducerIdentityNo());
            stmt.setString(++i, member.getIntroducerContact());
            stmt.setString(++i, member.getIntroducerMissing());
            stmt.setString(++i, member.getPlacementID());
            stmt.setString(++i, member.getPlacementName());
            stmt.setString(++i, member.getPlacementIdentityNo());
            stmt.setString(++i, member.getPlacementContact());
            stmt.setString(++i, member.getOriginalID());
            stmt.setString(++i, member.getPlacementMissing());
            stmt.setString(++i, member.getRemark());
            stmt.setInt(++i, member.getRegStatus());
            stmt.setInt(++i, member.getLoginStatus());
            stmt.setInt(++i, member.getStatus());
            stmt.setString(++i,member.getEthnic()); // Updated By Ferdi 2015-11-23
            stmt.setString(++i, member.getStd_modifyBy());
            stmt.setDate(++i, member.getStd_modifyDate() == null ? null : new Date(member.getStd_modifyDate().getTime()));
            stmt.setTime(++i, member.getStd_modifyTime() == null ? null : new Time(member.getStd_modifyTime().getTime()));
            stmt.setInt(++i, member.getMemberSeq());
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateMember --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }

    protected boolean updateMemberBonusStatus(int rank, double pbv_maintenance, double pgbv_maintenance, String memberid)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = " update member_bonus_status set  mbs_fixedrank = ?,  mbs_pbv_maintenance = ?,  mbs_pgbv_maintenance = ?  where mbs_memberid = ? ";
        try
        {
            int counter = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(++counter, rank);
            stmt.setDouble(++counter, pbv_maintenance);
            stmt.setDouble(++counter, pgbv_maintenance);
            stmt.setString(++counter, memberid);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateMemberBonusStatus --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }
    
    protected CounterSalesOrderBean getSalesOrder(String salesID)
        throws MvcException, SQLException
    {
        CounterSalesOrderBean sales;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        sales = null;
        stmt = null;
        rs = null;
        System.out.println("Tangkap 4 getSalesID " + salesID); 
        SQL = "select * from counter_sales_order where cso_trxdocno = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, salesID.toString());
            rs = stmt.executeQuery();
            if(rs.next())
            {
                sales = new CounterSalesOrderBean();
                sales.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getSalesOrder --> ")).append(e.toString()).toString());
        }

        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return sales;
    }
    
    protected boolean updateMemberPaket1100(String paket)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = " update member set mbr_status = ? where mbr_register = 7 ";
        try
        {
            int counter = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++counter, paket);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateMemberBonusStatus --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }

    protected double[] getMemberBonusStatus(String memberid)
        throws MvcException, SQLException
    {
        double values[];
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        values = (double[])null;
        stmt = null;
        rs = null;
        SQL = " select * from member_bonus_status where mbs_memberid = ? ";
        try
        {
            int counter = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++counter, memberid);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                values = new double[2];
                values[0] = rs.getDouble("mbs_pbv_maintenance");
                values[1] = rs.getDouble("mbs_pgbv_maintenance");
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getMemberBonusStatus --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return values;
        }
    }

    public boolean addMemberPIN(MemberBean member)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = false;
        stmt = null;
        rs = null; 
        
        String fields = "mbr_mbrid, mbr_name, mbr_epin, mbr_idcrm, mbr_idcrm_valid, mbr_segmentation ";
        SQL = (new StringBuilder("insert into member_pin (")).append(fields).append(") values ").append(getSQLInsertParams(fields)).toString();
        try
        {
            int i = 0;
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(++i, member.getMemberID());
            stmt.setString(++i, member.getName());
            stmt.setString(++i, member.getEpin());
            stmt.setString(++i, member.getIdCRM());
            stmt.setDate(++i, new Date(member.getValidCRM().getTime()));
            stmt.setString(++i, member.getSegmentationCRM());
            // System.out.println(" before Member ID " + member.getMemberID() + "Nama  " + member.getName() + " Epin " + member.getEpin() + " getIdCRM " + member.getIdCRM() + "Valid " + member.getValidCRM().getTime() + " Segmentation :"+ member.getSegmentationCRM() );                           
            status = stmt.executeUpdate() > 0;            
            System.out.println("Query : "+ stmt.toString());            
            // System.out.println(" After Member ID " + member.getMemberID() + "Nama  " + member.getName() + " Epin " + member.getEpin() + " getIdCRM " + member.getIdCRM() + "Valid " + member.getValidCRM().getTime() + " Segmentation :"+ member.getSegmentationCRM() );   
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform addMemberPIN --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return status;
        }
    }
     
    static 
    {
        likeFields = new ArrayList(10);
        likeFields.add(MemberBean.FIELD_ID);
        likeFields.add(MemberBean.FIELD_NAME);
        likeFields.add(MemberBean.FIELD_IDENTITY_NO);
        likeFields.add(MemberBean.FIELD_OFFICE);
        likeFields.add(MemberBean.FIELD_FAX);
        likeFields.add(MemberBean.FIELD_HOME);
        likeFields.add(MemberBean.FIELD_MOBILE);
    }
    
    //Updated By Ferdi 2015-08-12
    protected ArrayList getCustomerByID(String customerID)
        throws Exception
    {
        MemberBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select * from member where mbr_mbrid = ? ";

        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, customerID);
            
            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(bean))
            {
                bean = new MemberBean();
                bean.parseSimpleBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCustomerByID --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    //End Updated
}
