/*
 * TargetCategoryBroker.java
 *
 * Created on October 29, 2014, 4:15 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.target;

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
public class TargetCategoryBroker extends DBTransactionBroker {
    
    /** Creates a new instance of DSRReportBroker */
    public TargetCategoryBroker(Connection con) {
        super(con);
    }  
    
    protected ArrayList getPeriodeTarget()
        throws MvcException, SQLException 
    {
        TargetCategoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        
        SQL = "select " +
                    "CONCAT(tgt_month,' ',tgt_year) as period_target, " +
                    "CONCAT(MONTHNAME(STR_TO_DATE(tgt_month, '%m')),' ',tgt_year) as periode " +
              "from " +
                    "target_brand " +
              "where " +
                    "tgt_month <= MONTH(CURRENT_DATE()) AND tgt_year <= YEAR(CURRENT_DATE()) " +
              "group by " +
                    "tgt_year, tgt_month " +
              "order by " +
                    "tgt_year DESC, tgt_month DESC"; 
        
        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            
            for(rs = stmt.executeQuery(); rs.next();) {
                String key = rs.getString(1);
                String value = rs.getString(2);
                if(key != null && key.length() > 0)
                {
                    list.add(key + "," + value);
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getPeriodeTarget --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected ArrayList getBrandTarget(String periodeTarget)
        throws MvcException, SQLException 
    {
        TargetCategoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        String condition = "";
        
        if(periodeTarget != null && periodeTarget.length() > 0)
        {
            condition = "where CONCAT(tgt_month,' ',tgt_year) =  '" + periodeTarget + "' ";
        }
        else
        {
            condition = "where CONCAT(tgt_month,' ',tgt_year) = (select CONCAT(tgt_month,' ',tgt_year) from target_brand where tgt_month <= MONTH(CURRENT_DATE()) AND tgt_year <= YEAR(CURRENT_DATE()) group by tgt_year, tgt_month order by tgt_year DESC, tgt_month DESC limit 1) ";
        }
        
        SQL = "select " +
                    "tgt_brand " +
              "from " +
                    "target_brand " +
              condition +
              "group by " +
                    "tgt_brand " +
              "order by " +
                    "tgt_brand ASC "; 

        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            
            for(rs = stmt.executeQuery(); rs.next();) {
                String key = rs.getString(1);
                String value = rs.getString(1);
                if(key != null && key.length() > 0)
                {
                    list.add(key + "," + value);
                }
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getBrandTarget --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected TargetCategoryBean getTarget(String periodeTarget, String brandTarget, String act)
        throws Exception
    {
        TargetCategoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        bean = null;
        stmt = null;
        rs = null;
        String condition = "";
        
        if(brandTarget != null && brandTarget.length() > 0) condition += " and tgt_brand = '" + brandTarget + "' ";
        if(periodeTarget != null && periodeTarget.length() > 0) condition += "and CONCAT(tgt_month,' ',tgt_year) =  '" + periodeTarget + "' ";
        
        SQL = "select " + 
                     "tgt_id, " + 
                     "tgt_outletid, " + 
                     "tgt_brand, " +
                     "tgt_month, " + 
                     "tgt_year, " + 
                     "CONCAT(MONTHNAME(STR_TO_DATE(tgt_month, '%m')),' ',tgt_year) as periode, " +
                     "tgt_currency, " + 
                     "tgt_amt " + 
               "from " + 
                     "target_brand " + 
               "where " +
                    "tgt_month <= MONTH(CURRENT_DATE()) AND tgt_year <= YEAR(CURRENT_DATE()) " +
               condition +
               "order by " + 
                    "tgt_year DESC, tgt_month DESC, tgt_brand ASC " +
               "limit 1 "; 
   
        try
        {
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            
            rs = stmt.executeQuery();
            
            if(rs.next())
            {      
                bean = new TargetCategoryBean();
                bean.parseBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getTarget --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return bean;
    }
    
    protected boolean checkCategoryTarget(String categoryID, String periode, String brand, String outletID)
        throws MvcException, SQLException
    {
        int countTarget;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        String[] pr = periode.split(" ");
        String month = pr[0];
        String year = pr[1];
        countTarget = 0;
        boolean status;
        status = false;
        stmt = null;
        rs = null;
        SQL = "select count(*) as count_tgt from target_category where tgtcat_outletid = ? and tgtcat_brand = ? and tgtcat_catid = ? and tgtcat_month = ? and tgtcat_year = ?";
        try
        {
            stmt = getConnection().prepareStatement(SQL);
            stmt.setString(1, outletID);
            stmt.setString(2, brand);
            stmt.setString(3, categoryID);
            stmt.setString(4, month);
            stmt.setString(5, year);
            
            rs = stmt.executeQuery();
            if(rs.next())
                countTarget = rs.getInt("count_tgt");
            
            if(countTarget > 0) status = true;
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform checkCategoryTarget --> ")).append(e.toString()).toString());
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
    
    protected ArrayList getCategory(String outletID, String periodeTarget, String brandTarget)
        throws Exception
    {
        TargetCategoryBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        String SQL;
        ArrayList list;
        list = new ArrayList();
        stmt = null;
        rs = null;
        String condition = "(select CONCAT(tgt_month,' ',tgt_year) from target_brand where tgt_month <= MONTH(CURRENT_DATE()) AND tgt_year <= YEAR(CURRENT_DATE()) group by tgt_year, tgt_month order by tgt_year DESC, tgt_month DESC limit 1)";
        
        if(periodeTarget != null && periodeTarget.length() > 0) condition = "'" + periodeTarget + "' ";
        if(brandTarget != null && brandTarget.length() > 0) 
        {
            condition += " and tgtcat_brand = '" + brandTarget + "' ";
        }
        else
        {
            condition += " and tgtcat_brand = (select tgt_brand from target_brand where CONCAT(tgt_month,' ',tgt_year) = CONCAT(tgtcat_month,' ',tgtcat_year) group by tgt_brand order by tgt_brand ASC limit 1) "; 
        }
        
        SQL = "select " +
                        "pmp_producttype, " +  
                        "pmp_producttype as name, " +
                        "if(isnull(tgtcat_target_amt),0,tgtcat_target_amt) as target_amt " +
                "from " + 
                        "(select " +
                            "pmp_producttype " +
                        "from " +
                            "product_master " +
                        "where " +
                            "pmp_catid = (select pcd_catid from product_category_desc where pcd_desc = ?) " +
                        "group by " +
                            "pmp_producttype) pmp " + 
                "left join " +
                        "target_category on " + 
                        "tgtcat_outletid = ? and " +
                        "pmp_producttype = tgtcat_catid and " +
                        "concat(tgtcat_month,' ',tgtcat_year) = " + condition +
                "order by " +
                        "pmp_producttype ";

        try
        {
            int count = 0;
            Connection conn = getConnection();
            stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL))).toString());
            stmt.setString(1, brandTarget);
            stmt.setString(2, outletID);

            rs = stmt.executeQuery();
            
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new TargetCategoryBean();
                bean.parseCategoryBean(rs);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform getCategory --> ")).append(e.toString()).toString());
        }
        
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        
        return list;
    }
    
    protected boolean updateTarget(String categoryID, String curID, String periode, String brand, String outletID, double categoryTarget, String loginUser)
        throws MvcException, SQLException
    {
        TargetCategoryBean tgtBean;
        String[] pr = periode.split(" ");
        String month = pr[0];
        String year = pr[1];
        boolean status;
        PreparedStatement stmt;
        String SQL = "";
        status = false;
        stmt = null;
        
        SQL = "update " +
                    "target_category " +
              "set " +
                    "tgtcat_target_amt = ?, " +
                    "tgtcat_currency = ?, " +
                    "tgtcat_modifyby = ?, " +
                    "tgtcat_modifydate = CURRENT_DATE(), " +
                    "tgtcat_modifytime = CURRENT_TIME() " +
              "where " +
                    "tgtcat_outletid = ? and tgtcat_brand = ? and tgtcat_month = ? and tgtcat_year = ? and tgtcat_catid = ?";
        
        try
        {   
                stmt = getConnection().prepareStatement(SQL);
                
                stmt.setDouble(1, categoryTarget);
                stmt.setString(2, curID);
                stmt.setString(3, loginUser);
                stmt.setString(4, outletID);
                stmt.setString(5, brand);
                stmt.setString(6, month);
                stmt.setString(7, year);
                stmt.setString(8, categoryID);
                
                status = stmt.executeUpdate() > 0;
            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateCategory --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }
    
    protected boolean addTarget(String categoryID, String curID, String periode, String brand, String outletID, double categoryTarget, String loginUser)
        throws MvcException, SQLException
    {
        TargetCategoryBean tgtBean;
        String[] pr = periode.split(" ");
        String month = pr[0];
        String year = pr[1];
        boolean status;
        PreparedStatement stmt;
        String SQL = "";
        status = false;
        stmt = null;
        
        SQL = "insert into " +
                    "target_category " +
              "(tgtcat_catid,tgtcat_outletid,tgtcat_brand,tgtcat_target_amt,tgtcat_month,tgtcat_year,tgtcat_currency,tgtcat_creatby,tgtcat_createdate,tgtcat_createtime) " +
                    "values " +
              "(?,?,?,?,?,?,?,?,CURRENT_DATE(),CURRENT_TIME())";
        
        try
        {   
                stmt = getConnection().prepareStatement(SQL);
                
                stmt.setString(1, categoryID);
                stmt.setString(2, outletID);
                stmt.setString(3, brand);
                stmt.setDouble(4, categoryTarget);
                stmt.setString(5, month);
                stmt.setString(6, year);
                stmt.setString(7, curID);
                stmt.setString(8, loginUser);
                
                status = stmt.executeUpdate() > 0;
            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error while perform updateCategory --> ")).append(e.toString()).toString());
        }
        finally
        {
        if(stmt != null)
            stmt.close();
        return status;
        }
    }
}
