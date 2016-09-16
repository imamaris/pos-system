// Decompiled by Yody
// File : CurrencyBroker.class

package com.ecosmosis.common.currency;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.common.currency:
//            CurrencyBean

public class CurrencyExchangeBroker extends DBTransactionBroker
{

    protected CurrencyExchangeBroker(Connection con)
    {
        super(con);
    }

    public ArrayList getFullList()
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL;
        String SQL2;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        ResultSet rs;
        ResultSet rs2;
        list = null;
        SQL = "select * from currency_exchange where cex_status = 'A'";
        // table dibawah salah
        SQL2 = "select * from currency_period  where cpc_currency = ?  order by cpc_date desc   limit 1 ";
        stmt = null;
        stmt2 = null;
        rs = null;
        rs2 = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt2 = getConnection().prepareStatement(SQL2);
            rs = stmt.executeQuery();
            int count = 0;
            CurrencyExchangeBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new CurrencyExchangeBean();
                bean.parseBean(bean, rs);
                stmt2.setString(1, bean.getCode());
                rs2 = stmt2.executeQuery();
                if(rs2.next())
                    bean.parseBeanDetails(bean, rs2);
                if(list == null)
                    list = new ArrayList();
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Currency Info --> ")).append(sqlex).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs2 != null)
            rs2.close();
        return list;
        }
    }

    public CurrencyExchangeBean getCurrency(String currencyCode)
        throws MvcException, SQLException
    {
        CurrencyExchangeBean bean;
        String SQL;
        String SQL2;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        ResultSet rs;
        ResultSet rs2;
        bean = null;
        SQL = "select * from currency_exchange where cex_status = 'A' and cex_exchange = ? ";
        SQL2 = "select * from currency_period  where cpc_currency = ?  order by cpc_date desc   limit 1 ";
        stmt = null;
        stmt2 = null;
        rs = null;
        rs2 = null;
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt2 = getConnection().prepareStatement(SQL2);
            stmt.setString(1, currencyCode);
            rs = stmt.executeQuery();
            int count = 0;
            while(rs.next()) 
            {
                count++;
                bean = new CurrencyExchangeBean();
                bean.parseBean(bean, rs);
                stmt2.setString(1, bean.getCode());
                rs2 = stmt2.executeQuery();
                if(rs2.next())
                    bean.parseBeanDetails(bean, rs2);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading currency_exchange Info --> ")).append(sqlex).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        if(stmt2 != null)
            stmt2.close();
        if(rs2 != null)
            rs2.close();
        return bean;
        }
    }

    public boolean insert(CurrencyExchangeBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        String fields = "(cex_exchange,cex_symbol,cex_name,cex_currencyid) ";        
     
        sql1 = (new StringBuilder(" insert into currency_exchange ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        stmt1.setString(++cnt, bean.getCode());
        stmt1.setString(++cnt, bean.getSymbol());
        stmt1.setString(++cnt, bean.getName());
        stmt1.setString(++cnt, bean.getDisplayformat());
        status = stmt1.executeUpdate() == 1;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }
    
    
    
}
