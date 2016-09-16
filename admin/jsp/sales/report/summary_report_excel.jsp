<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="application/excel" language="java" %>

<%  
    response.reset();  
    response.setHeader("Content-type","application/xls");  
    
    String fileName =  request.getParameter("fileName");
    
    response.setHeader("Content-disposition","inline; filename=" + fileName);  
    
    PrintWriter op = response.getWriter();  
    String CSV = request.getParameter("tableHTML");  
    if (CSV == null)  
    {  
        CSV="NO DATA";  
    }  
    if (fileName == null)  
{  
    CSV="NO FILE NAME SPECIFIED";  
}   
  
op.write(CSV);  
%>