<%-- 
    Created By  : Mila Yuliani
    Created on  : 29-06-2016
    Project     : Voucher
--%>

<%@ page import="com.ecosmosis.orca.voucher.VoucherManager" %>

<%
VoucherManager voucherMgr = new VoucherManager();

String productSKU = request.getParameter("productSKU");
String voucher = voucherMgr.getVoucher(productSKU);
out.print(voucher);
%>