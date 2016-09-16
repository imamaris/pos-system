/*
 * SimplePdfColumnWidth.java
 *
 * Created on March 26, 2013, 5:53 PM
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
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class SimplePdfColumnWidth {
    
    /** The resulting PDF file. */
    public static final String RESULT = "../column_widths.pdf";
 
    /**
     * Creates a PDF with five tables.
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
        PdfPTable table = createTable1();
        document.add(table);
        table = createTable2();
        table.setSpacingBefore(5);
        table.setSpacingAfter(5);
        document.add(table);
        table = createTable3();
        document.add(table);
        table = createTable4();
        table.setSpacingBefore(5);
        table.setSpacingAfter(5);
        document.add(table);
        table = createTable5();
        document.add(table);
        // step 5
        document.close();
    }
 
    /**
     * Creates a table; widths are set with setWidths().
     * @return a PdfPTable
     * @throws DocumentException
     */
    public static PdfPTable createTable1() throws DocumentException {
        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(288 / 5.23f);
        table.setWidths(new int[]{2, 1, 1});
        PdfPCell cell;
        cell = new PdfPCell(new Phrase("Table 1"));
        cell.setColspan(3);
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Cell with rowspan 2"));
        // cell.setRowspan(2);
        cell.setColspan(2);
        table.addCell(cell);
        table.addCell("row 1; cell 1");
        //table.addCell("row 1; cell 2");
        //table.addCell("row 2; cell 1");
        //table.addCell("row 2; cell 2");
        return table;
    }
 
    /**
     * Creates a table; widths are set with setWidths().
     * @return a PdfPTable
     * @throws DocumentException
     */
    public static PdfPTable createTable2() throws DocumentException {
        PdfPTable table = new PdfPTable(3);
        table.setTotalWidth(288);
        table.setLockedWidth(true);
        table.setWidths(new float[]{2, 1, 1});
        PdfPCell cell;
        cell = new PdfPCell(new Phrase("Table 2"));
        cell.setColspan(3);
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Cell with rowspan 2"));
        // cell.setRowspan(2);
        cell.setColspan(2);
        table.addCell(cell);
        table.addCell("row 1; cell 1");
        //table.addCell("row 1; cell 2");
        //table.addCell("row 2; cell 1");
        //table.addCell("row 2; cell 2");
        return table;
    }
 
    /**
     * Creates a table; widths are set in the constructor.
     * @return a PdfPTable
     * @throws DocumentException
     */
    public static PdfPTable createTable3() throws DocumentException {
        PdfPTable table = new PdfPTable(new float[]{ 2, 1, 1 });
        table.setWidthPercentage(55.067f);
        PdfPCell cell;
        cell = new PdfPCell(new Phrase("Table 3"));
        cell.setColspan(3);
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Cell with rowspan 2"));
        // cell.setRowspan(2);
        cell.setColspan(2);
        table.addCell(cell);
        table.addCell("row 1; cell 1");
        //table.addCell("row 1; cell 2");
        //table.addCell("row 2; cell 1");
        //table.addCell("row 2; cell 2");
        return table;
    }
 
    /**
     * Creates a table; widths are set with special setWidthPercentage() method.
     * @return a PdfPTable
     * @throws DocumentException
     */
    public static PdfPTable createTable4() throws DocumentException {
        PdfPTable table = new PdfPTable(3);
        Rectangle rect = new Rectangle(523, 770);
        table.setWidthPercentage(new float[]{ 144, 72, 72 }, rect);
        PdfPCell cell;
        cell = new PdfPCell(new Phrase("Table 4"));
        cell.setColspan(3);
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Cell with rowspan 2"));
        // cell.setRowspan(2);
        cell.setColspan(2);
        table.addCell(cell);
        table.addCell("row 1; cell 1");
        //table.addCell("row 1; cell 2");
        //table.addCell("row 2; cell 1");
        //table.addCell("row 2; cell 2");
        return table;
    }
 
    /**
     * Creates a table; widths are set with setTotalWidth().
     * @return a PdfPTable
     * @throws DocumentException
     */
    public static PdfPTable createTable5() throws DocumentException {
        PdfPTable table = new PdfPTable(3);
        table.setTotalWidth(new float[]{ 144, 72, 72 });
        table.setLockedWidth(true);
        PdfPCell cell;
        cell = new PdfPCell(new Phrase("Table 5"));
        cell.setColspan(3);
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Cell with rowspan 2"));
        // cell.setRowspan(2);
        cell.setColspan(2);
        table.addCell(cell);
        table.addCell("row 1; cell 1");
        //table.addCell("row 1; cell 2");
        //table.addCell("row 2; cell 1");
        //table.addCell("row 2; cell 2");
        return table;
    }
 
    /**
     * Main method.
     * @param args no arguments needed
     * @throws DocumentException 
     * @throws IOException
     */
    public static void main(String[] args) throws IOException, DocumentException {
        new SimplePdfColumnWidth().createPdf(RESULT);
    }
    
}
