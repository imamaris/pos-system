/*
 * WarrantyBroker.java
 *
 * Created on February 20, 2013, 3:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.warranty;

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
public class WarrantyBroker extends com.ecosmosis.mvc.manager.DBTransactionBroker
{
    /**
     * Creates a new instance of WarrantyBroker
     */
    public WarrantyBroker(Connection con) {
        super(con);
    }
    
    public String getWarranty(int catID, int productID)
    throws MvcException, SQLException, Exception
    {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String warranty = "";
        //String SQL = "select * from product_warranty where pwy_catid = ? ";
        String SQL = "select pwy_year, pmp_productid, pmp_producttype from product_warranty LEFT JOIN product_master ON product_master.pmp_catid = product_warranty.pwy_catid WHERE pwy_catid = ? AND pmp_productid = ?";
        
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setInt(1, catID);
            stmt.setInt(2, productID);

            rs = stmt.executeQuery();

            if (rs.next())
            {
                if(rs.getString("pmp_producttype").contains("WATCH")){
                    warranty = rs.getString("pwy_year");               
                }else{
                    warranty = null;
                }
                
            }
        }
        catch (SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException("Error while perform getwarranty  --> " + sqlex);
        }    
        if (stmt != null)
            stmt.close();
        if (rs != null) {
            rs.close();
        }
        return warranty;
    }
    
}
