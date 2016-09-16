// Decompiled by Yody
// File : BankBroker.class

package com.ecosmosis.common.staff;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.common.bank:
//            BankBean

public class StaffBroker extends DBTransactionBroker
{

    protected StaffBroker(Connection con)
    {
        super(con);
    }

    public ArrayList getFullList()
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL = "select * from salesman order by mbr_mbrid";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            rs = stmt.executeQuery();
            int count = 0;
            StaffBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new StaffBean();
                bean.parseBean(bean, rs);
            }

        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while Loading Banking Info --> ")).append(e.toString()).toString());
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

    public StaffBean getBank(String bankId)
        throws MvcException, SQLException
    {
        StaffBean bank;
        String SQL;
        PreparedStatement stmt;
        ResultSet rs;
        bank = null;
        SQL = "select * from bank where bnk_bankid = ? ";
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, bankId);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bank = new StaffBean();
                bank.parseBean(bank, rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while Loading Banking Info --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bank;
        }
    }

    public boolean insert(StaffBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        String fields = " (bnk_bankid,bnk_countryid,bnk_name,bnk_othername,bnk_swiftcode) ";
        sql1 = (new StringBuilder(" insert into bank ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        stmt1.setString(++cnt, bean.getBankID());
        stmt1.setString(++cnt, bean.getCountryID());
        stmt1.setString(++cnt, bean.getName());
        stmt1.setString(++cnt, bean.getOtherName());
        stmt1.setString(++cnt, bean.getSwiftCode());
        status = stmt1.executeUpdate() == 1;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        return status;
    }

    public boolean update(StaffBean bean, String oldBankId)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        sql1 = " update  bank  set bnk_bankid=?, bnk_countryid = ?,  bnk_name = ?,bnk_othername = ?,bnk_swiftcode = ?  where bnk_bankid = ?";
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        stmt1.setString(++cnt, bean.getBankID());
        stmt1.setString(++cnt, bean.getCountryID());
        stmt1.setString(++cnt, bean.getName());
        stmt1.setString(++cnt, bean.getOtherName());
        stmt1.setString(++cnt, bean.getSwiftCode());
        stmt1.setString(++cnt, oldBankId);
        status = stmt1.executeUpdate() == 1;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        return status;
    }
}
