<%@ page import="com.ecosmosis.orca.inventory.InventoryManager" %>
<%@ page import="java.lang.Exception" %>

<%
InventoryManager inventoryManager = new InventoryManager();
        
String sku_kode = request.getParameter("sku_kode").toString();
String lokasi = request.getParameter("lokasi").toString();
String target = request.getParameter("target").toString();

System.out.println("Validate Loan In "+lokasi+" kode "+sku_kode);
String balance = "";

balance = inventoryManager.getValidateLoanIn(sku_kode, lokasi, target);
//balance = "false|0";
//System.out.println("-----------status " + balance);
out.println(balance);
%>