<%@ page import="import java.io.FileOutputStream" %>
<%@ page import="import java.io.IOException" %>
 
<%@ page import="import com.lowagie.text.Document" %>
<%@ page import="import com.lowagie.text.DocumentException" %>
<%@ page import="import com.lowagie.text.Paragraph" %>
<%@ page import="import com.lowagie.text.pdf.PdfWriter" %>

<%  
    String fileName2 =  request.getParameter("fileName2");    
    String CSV2 = request.getParameter("tableHTML2");  

        System.out.println("before step 1, fileName2 : "+fileName2+" CSV2 : "+CSV2);        
    
        // step 1
        Document document = new Document();
        
        System.out.println("step 1, document : "+document.toString();

        // step 2        
        PdfWriter.getInstance(document, new FileOutputStream(fileName2));
        
        System.out.println("step 2 .... ");
        
        // step 3
        document.open();

        System.out.println("step 3 .... ");
        
        // step 4
        document.add(new Paragraph("<table><tr><td>testetset</td></tr></table>"));
        
        System.out.println("step 4 .... ");
        
        // document.add(new Paragraph(CSV2));
        // step 5
        document.toString();
        
        System.out.println("step 5 .... ");
        
        document.close();
        
        // PrintWriter op = response.getWriter();  
    
    // String CSV2 = request.getParameter("tableHTML2");  
    
    if (CSV2 == null)  
    {  
        CSV2="NO DATA";  
    }  
    if (fileName2 == null)  
{  
    CSV2="NO FILE NAME SPECIFIED";  
}   
  
 // op.write(CSV2);  
%>