/*
 * VoucherBroker.java
 *
 * Created on February 20, 2013, 3:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.voucher;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author mila.yuliani
 */
public class VoucherBroker extends com.ecosmosis.mvc.manager.DBTransactionBroker
{
    /** Creates a new instance of VoucherBroker */
    public VoucherBroker(Connection con) {
        super(con);
    }
    
    public String getVoucher(String skuVoucher)
    throws MvcException, SQLException, Exception
    {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String voucher = "";
        String SQL = "select * from outlet_voucher where ovc_code = ? ";

        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, skuVoucher);

            rs = stmt.executeQuery();

            if (rs.next())
            {
                    voucher = rs.getString("ovc_id") + ";" 
                            + rs.getString("ovc_code") + ";" 
                            + rs.getString("ovc_desc") + ";" 
                            + rs.getString("ovc_issuedate") + ";" 
                            + rs.getString("ovc_startdate") + ";" 
                            + rs.getString("ovc_enddate") + ";"
                            + rs.getString("ovc_currencyid") + ";" 
                            + rs.getString("ovc_rate") + ";" 
                            + rs.getString("ovc_amount") + ";" 
                            + rs.getString("ovc_status") + ";" 
                            + rs.getString("ovc_trxdocno") + ";" ;               

            }
        }
        catch (SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException("Error while perform getVoucher  --> " + sqlex);
        }    
        if (stmt != null)
            stmt.close();
        if (rs != null) {
            rs.close();
        }
        return voucher;
    }
    
}
