/*
 * OutstandingTwBroker.java
 *
 * Created on August 26, 2015, 2:34 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.outstandingtw;

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
public class OutstandingTwBroker extends DBTransactionBroker {
    
    /** Creates a new instance of OutstandingTwBroker */
    public OutstandingTwBroker(Connection con) {
        super(con);
    }
    
    protected ArrayList getOutstandingTW(String outletID)
        throws Exception
    {
        OutstandingTwBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                        "pmp_default_name, " +
                        "a.piv_skucode, " +
                        "a.piv_owner, " +
                        "target, " +
                        "a.docno, " +
                        "b.piv_trxtype, " +
                        "a.sum_out as qty_out, " +
                        "b.sum_out as qty_order, " +
                        "(select " +
                                        "if(isnull(sum(inv.piv_in)),0,sum(inv.piv_in)) - if(isnull(sum(inv.piv_out)),0,sum(inv.piv_out)) as balance " +
                        "from " +
                                        "product_inventory inv " +
                        "inner join " +
                                        "product_master prod on inv.piv_productid = prod.pmp_productid " +
                        "where " +
                                        "inv.piv_trxtype <> ? and " +
                                        "inv.piv_status = ? and " +
                                        "inv.piv_owner = ? and " +
                                        "inv.piv_storecode = ? and " +
                                        "inv.piv_productid = a.piv_productid) as qty_stock " +
              "from " +
                        "(select " +
                                "(if(piv_remark like ?,REPLACE(piv_remark,?,?),piv_trxdocno)) as docno, " +
                                "piv_productid, " +
                                "piv_skucode, " +
                                "pmp_default_name, " +
                                "piv_owner, " +
                                "replace(piv_target,?,?) as target, " +
                                "sum(piv_out) as sum_out " +
                        "from " +
                                "product_inventory " +
                        "left join " +
                                "product_master on piv_skucode = pmp_skucode " +
                        "left join " +
                                "product_kit_item on pmp_productid = pki_productid " +
                        "where " +
                                "pki_productid is not null and " +
                                "piv_owner = ? and " +
                                "(piv_trxtype in (?,?) and piv_status = ?) " +
                        "group by " +
                                "docno, " +
                                "piv_productid, " +
                                "piv_skucode, " +
                                "pmp_default_name, " +
                                "piv_owner, " +
                                "target) a " +
                "left join " +
                                "(select " +
                                        "piv_trxdocno, " +
                                        "piv_trxtype, " +
                                        "sum(piv_out) as sum_out " +
                                "from " +
                                        "product_inventory " +
                                "left join " +
                                        "product_master on piv_skucode = pmp_skucode " +
                                "where " +
                                        "piv_owner = ? and " +
                                        "pmp_kitid != ? and " +
                                        "(piv_trxtype in (?,?) and piv_status = ?) " +
                                "group by " +
                                        "piv_trxdocno, " +
                                        "piv_trxtype) b on a.docno = b.piv_trxdocno " +
                "where " +
                                "a.sum_out < b.sum_out " +
                "order by " +
                              "a.docno ASC";
        
        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, "STAI");
            stmt.setInt(2, 100);
            stmt.setString(3, outletID);
            stmt.setString(4, outletID + "-001");
            stmt.setString(5, "Ref. to : %");
            stmt.setString(6, "Ref. to : ");
            stmt.setString(7, "");
            stmt.setString(8, "-001");
            stmt.setString(9, "");
            stmt.setString(10, outletID);
            stmt.setString(11, "STAO");
            stmt.setString(12, "STEO");
            stmt.setInt(13, 100);
            stmt.setString(14, outletID);
            stmt.setInt(15, 1);
            stmt.setString(16, "STAO");
            stmt.setString(17, "STEO");
            stmt.setInt(18, 100);

            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(bean))
            {
                bean = new OutstandingTwBean();
                bean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getOutstandingTW --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
}
