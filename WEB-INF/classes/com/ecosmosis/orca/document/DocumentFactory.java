// Decompiled by Yody
// File : DocumentFactory.class

package com.ecosmosis.orca.document;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;

// Referenced classes of package com.ecosmosis.orca.document:
//            DocumentSeqManager, DocumentInterface

public class DocumentFactory
{

    public static final String MGR_DOC_SEQUENCE = "Sequence Basis";
    // public static final String DOCNO_PATTERN = "00000000";
    // public static final String DOC_CB = "CB";
    public static final String DOCNO_PATTERN = "000";
    public static final String DOC_CB = "IN";
    public static final String DOC_INVOICE = "IV";
    public static final String DOC_CGN = "CGN";
    public static final String DOC_RCGN = "RCGN";
    public static final String DOC_SDO = "SDO";
    // public static final String DOC_CN = "CN";
    public static final String DOC_CN = "SR";
    public static final String DOC_CN_REFUND = "RCN";
    public static final String DOC_DN = "DN";
    public static final String DOC_GRN = "GRN";
    public static final String DOC_GXN = "GXN";
    public static final String DOC_DO = "DO";
    public static final String DOC_BO = "BO";
    public static final String DOC_STOCK_PURCHASE = "SPN";
    public static final String DOC_STOCK_RETURNED = "SRN";
    public static final String DOC_STOCK_TRANSFER = "STN";
    // public static final String DOC_STOCK_TRANSFER = "TW-MCH";
    public static final String DOC_STOCK_COMPLIMENT = "SCN";
    public static final String DOC_STOCK_EXCHANGE = "SXN";
    public static final String DOC_STOCK_LOAN_IN = "SLNI";
    public static final String DOC_STOCK_LOAN_OUT = "SLNO";
    public static final String DOC_STOCK_ABOLISH = "SBO";
    public static final String DOC_STOCK_DISCREPANCY = "SDN";
    private static Hashtable docMgrTable = new Hashtable();

    private DocumentFactory()
    {
    }

    private static DocumentInterface createDocumentMgrAwal(String ownerID, String docType, String mgrID)
    {
        DocumentInterface result = null;
        String key = (new StringBuilder(String.valueOf(ownerID))).append("-").append(docType).toString();
        if(mgrID.equals("Sequence Basis"))
            result = new DocumentSeqManager(ownerID, docType);
        if(result != null)
            docMgrTable.put(key, result);
        return result;
    }

    private static DocumentInterface createDocumentMgr(String ownerID, String docType, String mgrID)
    {
        DocumentInterface result = null;

        Date dateNow = new Date ();
        SimpleDateFormat dateformatYYYYMMDD = new SimpleDateFormat("yyyy-MM-dd");
        StringBuilder Period = new StringBuilder( dateformatYYYYMMDD.format( dateNow ) );
        
        String bulan = Period.substring(5, 7).toString();
        String tahun = Period.substring(2, 4).toString();
        
        // int bulan1 = Integer.parseInt(bulan);
        // int tahun1 = Integer.parseInt(tahun);                 
        
        String key = (new StringBuilder(String.valueOf(ownerID))).append("/").append(docType).append("/").append(tahun).append("/").append(bulan).toString();

        System.out.println("Tahun " + tahun + " bulan " + bulan + " Key1 " + key); 
                
        if(mgrID.equals("Sequence Basis"))
            result = new DocumentSeqManager(ownerID, docType);
        if(result != null)
            docMgrTable.put(key, result);
        return result;
    }
    
    public static DocumentInterface getDocumentMgr(String ownerID, String docType, String mgrID)
    {
        String key = buildKey(ownerID, docType);
        if(key == null || mgrID == null)
            return null;
        if(docMgrTable.containsKey(key))
            return (DocumentInterface)docMgrTable.get(key);
        else
            return createDocumentMgr(ownerID, docType, mgrID);
    }

    public static DocumentInterface getDocumentMgrTW(String ownerID, String docType, String mgrID)
    {
        String key = buildKey(ownerID, docType);
        if(key == null || mgrID == null)
            return null;
        if(docMgrTable.containsKey(key))
            return (DocumentInterface)docMgrTable.get(key);
        else
            return createDocumentMgr(ownerID, docType, mgrID);
    }
    
    private static String buildKey(String ownerID, String docType)
    {
        return (new StringBuilder(String.valueOf(ownerID))).append("-").append(docType).toString();
    }

}
