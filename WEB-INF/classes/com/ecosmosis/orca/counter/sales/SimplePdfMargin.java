/*
 * SimplePdfMargin.java
 *
 * Created on March 26, 2013, 10:14 AM
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

import com.lowagie.text.Element;
import com.lowagie.text.PageSize;


public class SimplePdfMargin {
    
/** Path to the resulting PDF file. */
    public static final String RESULT
        = "../SimplePdfMargin.pdf";
 
    /**
     * Creates a PDF file: hello_mirrored_margins.pdf
     * @param    args    no arguments needed
     */
    public static void main(String[] args)
        throws DocumentException, IOException {
        // step 1
        Document document = new Document();
        // step 2
        PdfWriter.getInstance(document, new FileOutputStream(RESULT));
        document.setPageSize(PageSize.A5);
        document.setMargins(36, 72, 108, 180);
        document.setMarginMirroring(true);
        // step 3
        document.open();
        // step 4
        document.add(new Paragraph(
            "The left margin of this odd page is 36pt (0.5 inch); " +
            "the right margin 72pt (1 inch); " +
            "the top margin 108pt (1.5 inch); " +
            "the bottom margin 180pt (2.5 inch)."));
        Paragraph paragraph = new Paragraph();
        paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
        for (int i = 0; i < 20; i++) {
            paragraph.add("Hello World! Hello People! " +
            		"Hello Sky! Hello Sun! Hello Moon! Hello Stars!");
        }
        document.add(paragraph);
        document.add(new Paragraph(
            "The right margin of this even page is 36pt (0.5 inch); " +
            "the left margin 72pt (1 inch)."));
        // step 5
        document.close();
    }
    
}
