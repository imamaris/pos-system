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

public class CurrencyRateBroker extends DBTransactionBroker
{

    protected CurrencyRateBroker(Connection con)
    {
        super(con);
    }

    // String priceCodeID, Date effectiveDate, String locale
    
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
        // SQL = "select * from currency_exchange_rate where cer_status = 'A'";
        // SQL = "select * from currency_exchange_rate where cer_startdate <= date(now()) and cer_enddate >= date(now())  and cer_status = 'A' group by cer_exchange, cer_startdate order by cer_startdate desc, cer_endtime, cer_currencyid desc  limit 20 ";
        SQL = "select * from currency_exchange_rate where cer_startdate <= date(now()) and cer_enddate >= date(now())  and cer_status = 'A' order by cer_startdate desc, cer_starttime desc, cer_currencyid desc  limit 20 ";
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
            CurrencyRateBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new CurrencyRateBean();
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
            throw new MvcException((new StringBuilder("Error while Loading Currency Rate Info --> ")).append(sqlex).toString());
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

    public ArrayList getFullList2(String priceCodeID,  Date effectiveDate, String locale)
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
        SQL = "select * from currency_exchange_rate where cer_startdate <=  effectiveDate AND cer_enddate >= effectiveDate ORDER BY cer_startdate DESC  ";
        // WHERE 

        
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
            
            stmt.setString(1, priceCodeID);
            stmt.setDate(2,  (Date) effectiveDate);
            stmt.setString(3, locale);
            
            rs = stmt.executeQuery();
            int count = 0;
            CurrencyRateBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new CurrencyRateBean();
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
            throw new MvcException((new StringBuilder("Error while Loading Currency Rate Info --> ")).append(sqlex).toString());
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
    
    
    public CurrencyRateBean getCurrency(String currencyCode)
        throws MvcException, SQLException
    {
        CurrencyRateBean bean;
        String SQL;
        String SQL2;
        PreparedStatement stmt;
        PreparedStatement stmt2;
        ResultSet rs;
        ResultSet rs2;
        bean = null;
        SQL = "select * from currency_exchange_rate where cex_status = 'A' and cer_exchange = ? ";
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
                bean = new CurrencyRateBean();
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

    public boolean insert(CurrencyRateBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        String fields = "(cer_exchange,cer_rate,cer_startdate,cer_enddate, cer_starttime, cer_endtime, cer_status) ";  
        
        sql1 = (new StringBuilder(" insert into currency_exchange_rate ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        stmt1.setString(++cnt, bean.getCode());
        stmt1.setDouble(++cnt, bean.getSymbol());
        stmt1.setDate(++cnt, (Date) bean.getStartdate());
        stmt1.setDate(++cnt, (Date) bean.getEnddate());
        stmt1.setTime(++cnt, bean.getStarttime());
        stmt1.setTime(++cnt, bean.getEndtime());
        stmt1.setString(++cnt, bean.getStatus());
        
        status = stmt1.executeUpdate() == 1;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

 boolean insertRate(CurrencyRateBean bean)
    throws SQLException
  {
      boolean status = false;
      PreparedStatement stmt = null;
      String fields = "(cer_exchange,cer_rate,cer_startdate,cer_enddate, cer_starttime, cer_endtime, cer_status) ";
      String sql = "insert into currency_exchange_rate "+ 
              "(cer_exchange,cer_rate,cer_startdate,cer_enddate, cer_starttime, cer_endtime, cer_status, cer_currencyid) " 
              + " values ( '" + bean.getCode() + "', '" + bean.getSymbol() + "', '"+ bean.getStartdate()+"','"+ bean.getEnddate()+"','00:00:00','23:59:59','"+bean.getStatus() + "','"+ bean.getDisplayformat() + "' )";
      
      stmt = getConnection().prepareStatement(sql);
      status = stmt.executeUpdate() == 1;
    try
    {
      if (stmt != null)
        stmt.close();
    } catch (SQLException sqlexception1) {
    }
      return false;
  }
 

}
