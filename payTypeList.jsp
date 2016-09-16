<%-- 
    Created By  : Ferdiansyah Dwiputra
    Created on  : 26 Februari 2015
    Project     : DSR Collection
--%>
<%@ page import="java.util.ArrayList" %>

<%  
    ArrayList payTypeList = new ArrayList();

    payTypeList.add("AR - AR - AR - IDR;");
    payTypeList.add("VOUCHER - VOUCHER - VOUCHER - IDR;");
    payTypeList.add("CASH - CASH - CASH - IDR;");
    payTypeList.add("CASH - CASH - CASH - SGD;");
    payTypeList.add("CASH - CASH - CASH - SGD TO IDR;");
    payTypeList.add("CASH - CASH - CASH - USD;");
    payTypeList.add("CASH - CASH - CASH - USD TO IDR;");
    payTypeList.add("CEK/GIRO;");
    payTypeList.add("TT - TT - TT BCA - IDR;");
    payTypeList.add("TT - TT - TT MANDIRI - IDR;");
    payTypeList.add("DEBIT CARD - EDC BCA - DEBIT BCA - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA CARD - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - VISA/MASTER - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA 3 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA 6 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA 12 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA 24 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC BCA - BCA 36 BLN - IDR;");
    payTypeList.add("DEBIT CARD - EDC MDR - DEBIT MANDIRI - IDR;");
    payTypeList.add("CREDIT CARD - EDC MDR - VISA/MASTER - IDR;");
    payTypeList.add("CREDIT CARD - EDC MDR - POWERBUY 6 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC MDR - POWERBUY 12 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC MDR - POWERBUY 24 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC MDR - POWERBUY 36 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CTBK - VISA/MASTER - IDR;");
    payTypeList.add("CREDIT CARD - EDC CTBK - EAZY PAY 3 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CTBK - EAZY PAY 6 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CTBK - EAZY PAY 12 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC DNM - VISA/MASTER - IDR;");
    payTypeList.add("CREDIT CARD - EDC AMEX - AMEX - IDR;");
    payTypeList.add("CREDIT CARD - EDC UNION - UNION PAY - IDR;");
    payTypeList.add("DEBIT CARD - EDC CIMB - DEBIT CIMB NIAGA - IDR;");
    payTypeList.add("CREDIT CARD - EDC CIMB - VISA/MASTER - IDR;");
    payTypeList.add("CREDIT CARD - EDC CIMB - CIMB 3 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CIMB - CIMB 6 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CIMB - CIMB 12 BLN - IDR;");
    payTypeList.add("CREDIT CARD - EDC CIMB - CIMB 24 BLN - IDR;");
%>