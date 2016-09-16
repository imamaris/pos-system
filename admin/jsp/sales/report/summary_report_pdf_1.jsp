<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="application/pdf" language="java" %>

<%  
    response.reset();  
    response.setHeader("Content-type","application/pdf");  
    
    String fileName2 =  request.getParameter("fileName2");
    
    response.setHeader("Content-disposition","inline; filename=" + fileName2);  
    
    PrintWriter op = response.getWriter();  
    String CSV2 = request.getParameter("tableHTML2");  
    if (CSV2 == null)  
    {  
        CSV2="NO DATA";  
    }  
    if (fileName2 == null)  
{  
    CSV2="NO FILE NAME SPECIFIED";  
}   
  
op.write(CSV2);  
%>