/*
 * SimplePdf.java
 *
 * Created on March 26, 2013, 9:49 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales;

/**
 *
 * @author dodi.iswarman
 */

import java.io.FileOutputStream;
import java.io.IOException;
 
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

public class SimplePdf {
    
  /** Path to the resulting PDF file. */
    public static final String RESULT
        = "../hello.pdf";
 
    /**
     * Creates a PDF file: hello.pdf
     * @param    args    no arguments needed
     */
    public static void main(String[] args)
    	throws DocumentException, IOException {
    	new SimplePdf().createPdf(RESULT);
    }
 
    /**
     * Creates a PDF document.
     * @param filename the path to the new PDF document
     * @throws    DocumentException 
     * @throws    IOException 
     */
    public void createPdf(String filename)
	throws DocumentException, IOException {
        // step 1
        Document document = new Document();
        // step 2
        PdfWriter.getInstance(document, new FileOutputStream(filename));
        // step 3
        document.open();
        // step 4
        // document.add(new Paragraph("<table><tr><td>testetset</td><td>testetset3</td></tr> <tr><td>testetset</td><td>testetset5</td></tr> </table>"));
        document.add(new Paragraph("test lagi"));
        // step 5
        document.close();
    }
    
}
