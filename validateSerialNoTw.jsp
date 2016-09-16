<%@ page import="com.ecosmosis.orca.inventory.InventoryManager" %>
<%@ page import="java.lang.Exception" %>

<%
InventoryManager inventoryManager = new InventoryManager();
        
String sku_kode = request.getParameter("sku_kode").toString();
String lokasi = request.getParameter("lokasi").toString();

System.out.println("Validate Serial Number TW "+lokasi+" kode "+sku_kode);
boolean status = false;

status = inventoryManager.getValidateSerialNoTW(sku_kode, lokasi);
out.println(status);
%>