// Decompiled by Yody
// File : DocumentSeqManager.class

package com.ecosmosis.orca.document;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.util.db.DbConnectionManager;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

// Referenced classes of package com.ecosmosis.orca.document:
//            DocumentInterface

public class DocumentSeqManager
        implements DocumentInterface {
    
    private String ownerID;
    private String docType;
    private String length;
    private DecimalFormat formatter;
    
    public DocumentSeqManager(String ownerID, String docType) {
        formatter = null;
        this.ownerID = ownerID;
        this.docType = docType;
        // formatter = new DecimalFormat("00000000");
        formatter = new DecimalFormat("000");
        
    }
    
    public synchronized Object getDocumentNo()
    throws MvcException, SQLException {
        String result;
        Connection conn;
        PreparedStatement stmtSel;
        PreparedStatement stmtUpd;
        ResultSet rs;
        String SQL_select;
        String SQL_insert;
        String SQL_update;
        boolean status = false;
        result = null;
        conn = null;
        stmtSel = null;
        stmtUpd = null;
        rs = null;
        SQL_select = "select * from document  where doc_ownerid=? and doc_doctype=?";
        SQL_insert = "insert into document (doc_lastindex, doc_ownerid, doc_doctype) values (?, ?, ?)";
        SQL_update = "update document set doc_lastindex=? where doc_ownerid=? and doc_doctype=?";
  
        try {
            boolean isNew = true;
            int index = 0;
            conn = DbConnectionManager.getConnection();

            Date dateNow = new Date();
            SimpleDateFormat dateformatYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder Period = new StringBuilder( dateformatYYYYMMDD.format( dateNow ) );
            
            String bulan = Period.substring(5, 7).toString();
            String tahun = Period.substring(2, 4).toString();
            String tahunbulan = tahun.concat(bulan);
            
            stmtSel = conn.prepareStatement(SQL_select);
            stmtSel.setString(1, ownerID);
            stmtSel.setString(2, docType);
            rs = stmtSel.executeQuery();
            if(rs.next()) {
                index = rs.getInt("doc_lastindex");
                
                //real
               
                if(ownerID.equalsIgnoreCase("24") && index == 47 && tahunbulan.equalsIgnoreCase("1205") ) {
                    index = 49;
                }else if (ownerID.equalsIgnoreCase("39") && index == 67 && tahunbulan.equalsIgnoreCase("1205")){
                    index = 69;
                }else {
                    index = rs.getInt("doc_lastindex");
                }     
                
                // test
                /*
                if(ownerID.equalsIgnoreCase("04") && index == 28 && tahunbulan.equalsIgnoreCase("1205")) {
                    index = 30;
                }else if (ownerID.equalsIgnoreCase("39") && index == 67 && tahunbulan.equalsIgnoreCase("1205")) {
                    index = 69;
                }else {
                    index = rs.getInt("doc_lastindex");
                }                
                */  
                
                isNew = false;
            }
            Log.debug((new StringBuilder()).append(this).append(" -> current index ").append(index).toString());
     
            index++;
            
            Log.debug((new StringBuilder()).append(this).append(" -> current newIndex ").append(index).toString());
            if(isNew)
                stmtUpd = conn.prepareStatement(SQL_insert);
            else
                stmtUpd = conn.prepareStatement(SQL_update);
            stmtUpd.setInt(1, index);
            stmtUpd.setString(2, ownerID);
            stmtUpd.setString(3, docType);
            // boolean status;
            /*
            Date dateNow = new Date();
            SimpleDateFormat dateformatYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder Period = new StringBuilder( dateformatYYYYMMDD.format( dateNow ) );
            
            String bulan = Period.substring(5, 7).toString();
            String tahun = Period.substring(2, 4).toString();
            */
            
            if(isNew)
                status = stmtUpd.executeUpdate() == 1;
            else
                status = stmtUpd.executeUpdate() > 0;
            if(status)
                // result = (new StringBuilder(String.valueOf(ownerID))).append("-").append(docType).append(formatter.format(index)).toString();
                result = (new StringBuilder(String.valueOf(ownerID))).append("/").append(docType).append("/").append(tahun).append(bulan).append("/").append(formatter.format(index)).toString();
            
            Log.debug((new StringBuilder()).append(this).append(" -> New DocumentNo ").append(result).toString());
            System.out.println("Tahun " + tahun + " bulan " + bulan + " TahunBulan : " + tahunbulan + " Result " + result);
        } catch(Exception e) {
            // boolean status = false;
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in DocumentSeqManager while generate DocumentNo for Owner -> ")).append(ownerID).append(", DocType -> ").append(docType).append(" --> ").append(e.toString()).toString());
        }
        
        if(stmtSel != null)
            stmtSel.close();
        if(stmtUpd != null)
            stmtUpd.close();
        if(rs != null)
            rs.close();
        DbConnectionManager.release(conn);
        return result;
    }
    
    //Updated By Ferdi 2015-04-02
    public synchronized Object getDocumentNo1()
    throws MvcException, SQLException {
        String result;
        Connection conn;
        PreparedStatement stmtDoc;
        PreparedStatement stmtSel;
        PreparedStatement stmtUpd;
        ResultSet rsDoc;
        ResultSet rs;
        String SQL_document;
        String SQL_select;
        String SQL_insert;
        String SQL_update;
        boolean status = false;
        result = null;
        conn = null;
        stmtDoc = null;
        stmtSel = null;
        stmtUpd = null;
        rs = null;
        rsDoc = null;
        
        SQL_document = "select * from document  where doc_ownerid=? and doc_doctype=?";
        SQL_insert = "insert into document (doc_lastindex, doc_ownerid, doc_doctype) values (?, ?, ?)";
        SQL_update = "update document set doc_lastindex=? where doc_ownerid=? and doc_doctype=?";
  
        try {
            boolean isNew = true;
            int lastIndex = 0;
            int index = 0;
            conn = DbConnectionManager.getConnection();

            Date dateNow = new Date();
            SimpleDateFormat dateformatYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
            StringBuilder Period = new StringBuilder( dateformatYYYYMMDD.format( dateNow ) );
            
            String bulan = Period.substring(5, 7).toString();
            String tahun = Period.substring(2, 4).toString();
            String tahunbulan = tahun.concat(bulan);
            
            if(!docType.trim().equalsIgnoreCase("TW") && !docType.trim().equalsIgnoreCase("SLN"))
            {
                SQL_select = "select max(trim(cso_trxdocno)) as last_docno from counter_sales_order where date_format(cso_trxdate,'%y%m') = '" + tahunbulan + "' and cso_trxdoctype=?";
                stmtSel = conn.prepareStatement(SQL_select);
                stmtSel.setString(1, docType);
            }
            else
            {
                SQL_select = "select max(trim(piv_trxdocno)) as last_docno from product_inventory where date_format(piv_trxdate,'%y%m') = '" + tahunbulan + "' and piv_trxdocno like '" + ownerID + "/" + docType + "/%'";
                stmtSel = null;
                stmtSel = conn.prepareStatement(SQL_select);
            }
            
            rs = stmtSel.executeQuery();
            
            if(rs.next()) {
                String lastDocNo = rs.getString("last_docno");
                
                if((lastDocNo != null) && (lastDocNo.trim().length() > 0))
                {
                    String[] dt = lastDocNo.split("/");
                    lastIndex = Integer.parseInt(dt[3]);
                    index = lastIndex;
                }
                
                stmtDoc = conn.prepareStatement(SQL_document);
                stmtDoc.setString(1, ownerID);
                stmtDoc.setString(2, docType);
                rsDoc = stmtDoc.executeQuery();
                if(rsDoc.next()) isNew = false;
            }
            Log.debug((new StringBuilder()).append(this).append(" -> current index ").append(index).toString());
     
            index++;
            
            Log.debug((new StringBuilder()).append(this).append(" -> current newIndex ").append(index).toString());

            if(isNew)
                stmtUpd = conn.prepareStatement(SQL_insert);
            else
                stmtUpd = conn.prepareStatement(SQL_update);
            stmtUpd.setInt(1, index);
            stmtUpd.setString(2, ownerID);
            stmtUpd.setString(3, docType);
            
            if(isNew)
                status = stmtUpd.executeUpdate() == 1;
            else
                status = stmtUpd.executeUpdate() > 0;
            
            result = (new StringBuilder(String.valueOf(ownerID))).append("/").append(docType).append("/").append(tahun).append(bulan).append("/").append(formatter.format(index)).toString();
            
            Log.debug((new StringBuilder()).append(this).append(" -> New DocumentNo1 ").append(result).toString());
            System.out.println("Tahun " + tahun + " bulan " + bulan + " TahunBulan : " + tahunbulan + " Result " + result);
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException((new StringBuilder("Error in DocumentSeqManager while generate DocumentNo1 for Owner -> ")).append(ownerID).append(", DocType -> ").append(docType).append(" --> ").append(e.toString()).toString());
        }
        
        if(stmtSel != null)
            stmtSel.close();
         if(stmtDoc != null)
            stmtDoc.close();
        if(stmtUpd != null)
            stmtUpd.close();
        if(rs != null)
            rs.close();
        if(rsDoc != null)
            rsDoc.close();
        DbConnectionManager.release(conn);
        return result;
    }
    //
    
    public String getId() {
        return "Sequence Basis";
    }
}
