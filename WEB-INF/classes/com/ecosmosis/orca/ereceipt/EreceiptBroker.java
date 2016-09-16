/*
 * EreceiptBroker.java
 *
 * Created on July 22, 2015, 3:02 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.ereceipt;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.Date;
import java.util.*;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class EreceiptBroker extends DBTransactionBroker {
    
    /** Creates a new instance of EreceiptBroker */
    public EreceiptBroker(Connection con) {
        super(con);
    }
    
    protected boolean updateEmailCustomerByID(String customerID, String email)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update member set mbr_email = ? where mbr_mbrid = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, email);
            stmt.setString(2, customerID);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateEmailCustomerByID --> ")).append(e.toString()).toString());
        }         
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }
    
    protected ArrayList getEreceiptConfig()
        throws Exception
    {
        EreceiptBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select * from ereceipt";

        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());

            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new EreceiptBean();
                bean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getEreceiptConfig --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected String getEreceiptStatus(String invoiceNo)
        throws MvcException, SQLException
    {
        String status;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        status = "";
        stmt = null;
        rs = null;
        SQL = "select ereceipt_status from counter_sales_order where cso_trxdocno=?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, invoiceNo);
            rs = stmt.executeQuery();
            if(rs.next())
                status = rs.getString("ereceipt_status");
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getEreceiptStatus --> ")).append(e.toString()).toString());
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
    
    protected boolean updateEreceiptStatus(String invoiceNo)
        throws MvcException, SQLException
    {
        boolean status;
        PreparedStatement stmt;
        String SQL;
        status = false;
        stmt = null;
        SQL = "update counter_sales_order set ereceipt_status = ? where cso_trxdocno=?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, "Sent");
            stmt.setString(2, invoiceNo);
            status = stmt.executeUpdate() > 0;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateEreceiptStatus --> ")).append(e.toString()).toString());
        }         
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }
}
