
package com.ecosmosis.orca.warranty;
import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.*;
import java.util.Date;

public class WarrantyBean extends MvcBean
{
    private String pwyID;
    private String pwyName;
    private String pwyDesc;
    private int pwyYear;
    
    public WarrantyBean()
    {
    }    
    public void parseBean(ResultSet rs)
    throws SQLException
    {
        parseBean(rs, "");
    }
    public void parseBean(ResultSet rs, String prefix)
     throws SQLException
    {
        if (prefix == null)
            prefix = "";
        
            setpwyID(rs.getString(prefix + "pwy_catid"));
            setpwyName(rs.getString(prefix + "pwy_name"));
            setpwyDesc(rs.getString(prefix + "pwy_desc"));
            setpwyYear(rs.getInt(prefix + "pwy_year"));
           
    } 

    public String getpwyID() {
        return pwyID;
    }

    public void setpwyID(String pwyID) {
        this.pwyID = pwyID;
    }

    public String getpwyName() {
        return pwyName;
    }

    public void setpwyName(String pwyName) {
        this.pwyName = pwyName;
    }

    public String getpwyDesc() {
        return pwyDesc;
    }

    public void setpwyDesc(String pwyDesc) {
        this.pwyDesc = pwyDesc;
    }

    public int getpwyYear() {
        return pwyYear;
    }
    
    public void setpwyYear(int pwyYear) {
        this.pwyYear = pwyYear;
    }
}