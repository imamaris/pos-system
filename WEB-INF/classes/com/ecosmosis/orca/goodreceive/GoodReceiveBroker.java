/*
 * GoodReceiveBroker.java
 *
 * Created on September 2, 2015, 3:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.goodreceive;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.Date;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class GoodReceiveBroker extends DBTransactionBroker {
    
    /** Creates a new instance of GoodReceiveBroker */
    public GoodReceiveBroker(Connection con) {
        super(con);
    }
    
    protected ArrayList getGoodReceiveList(String outletID, String DocNo)
        throws Exception
    {
        GoodReceiveBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "product_inventory.*, " +
                    "(select otl_name from outlet where otl_outletid = piv_owner) as outlet_name, " +
                    "pmp_default_name, " +
                    "pcp_default_msg " +
              "from " +
                    "product_inventory " +
              "left join " +
                    "product_master on pmp_productid = piv_productid " +
              "left join " +
                    "product_category on pmp_catid = pcp_catid " +
              "where " +
                    "piv_owner = ? and piv_trxdocno = ?";

        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, outletID);
            stmt.setString(2, DocNo);

            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(bean))
            {
                bean = new GoodReceiveBean();
                bean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getGoodReceiveList --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
}
