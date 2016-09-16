/*
 * SimplePdfTable.java
 *
 * Created on March 26, 2013, 3:11 PM
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

import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;


public class SimplePdfTable {
    
    /** The resulting PDF file. */
    public static final String RESULT
        = "../table.pdf";
 
    /**
     * Main method.
     * @param    args    no arguments needed
     * @throws DocumentException 
     * @throws IOException
     */
    public static void main(String[] args)
        throws IOException, DocumentException {
        new SimplePdfTable().createPdf(RESULT);
    }
 
    /**
     * Creates a PDF with information about the movies
     * @param    filename the name of the PDF file that will be created.
     * @throws    DocumentException 
     * @throws    IOException
     */
    public void createPdf(String filename)
        throws IOException, DocumentException {
    	// step 1
        Document document = new Document();
        // step 2
        PdfWriter.getInstance(document, new FileOutputStream(filename));
        // step 3
        document.open();
        // step 4
        document.add(createFirstTable());
        // step 5
        document.close();
    }
 
    /**
     * Creates our first table
     * @return our first table
     */
    public static PdfPTable createFirstTable() {
    	// a table with three columns
        PdfPTable table = new PdfPTable(3);
        // the cell object
        PdfPCell cell;
        // we add a cell with colspan 3
        cell = new PdfPCell(new Phrase("Cell with colspan 3"));
        cell.setColspan(3);
        table.addCell(cell);
        // now we add a cell with collspan 2
        cell = new PdfPCell(new Phrase("Cell with colspan 2"));
        cell.setColspan(2);
        table.addCell(cell);        

        // we add the one remaining cells with addCell()
        table.addCell("row 1; cell 1");

        return table;
    }
    
}
