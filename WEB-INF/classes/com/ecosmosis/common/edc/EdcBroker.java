// Decompiled by Yody
// File : CurrencyBroker.class

package com.ecosmosis.common.edc;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.ArrayList;


public class EdcBroker extends DBTransactionBroker
{

    protected EdcBroker(Connection con)
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
        SQL = "select * from edc where edc_status = 'A'";
        SQL2 = "select * from currency_period  where cpc_currency = ?  order by cpc_date desc   limit 1 ";
        // System.out.println("Masuk EDC Broker ");
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
            EdcBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new EdcBean();
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
            throw new MvcException((new StringBuilder("Error while Loading EDC Info --> ")).append(sqlex).toString());
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

    public EdcBean getCurrency(String currencyCode)
        throws MvcException, SQLException
    {
        EdcBean bean;
        String SQL;
        String SQL2;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        ResultSet rs;
        ResultSet rs2;
        bean = null;
        SQL = "select * from edc where cur_status = 'A' and edc_id = ? ";
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
                bean = new EdcBean();
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
            throw new MvcException((new StringBuilder("Error while Loading EDC Info --> ")).append(sqlex).toString());
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

    public boolean insert(EdcBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        String fields = "(edc_id,edc_code,edc_name,edc_format) ";
        sql1 = (new StringBuilder(" insert into edc ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
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
