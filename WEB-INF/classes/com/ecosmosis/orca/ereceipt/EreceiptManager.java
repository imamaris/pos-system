/*
 * EreceiptManager.java
 *
 * Created on July 22, 2015, 3:01 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.ereceipt;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.authentication.HttpAuthenticationManager;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.orca.counter.sales.CounterSalesManager;
import com.ecosmosis.orca.counter.sales.CounterSalesOrderBean;
import com.ecosmosis.util.crypto.DesEncrypt;
import com.ecosmosis.util.log.Log;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class EreceiptManager extends DBTransactionManager {
    
    private EreceiptBroker broker;
    
    /** Creates a new instance of EreceiptManager */
    public EreceiptManager() {
        broker = null;
    }
    
    public EreceiptManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private EreceiptBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new EreceiptBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser)
    {
        HttpAuthenticationManager auth = new HttpAuthenticationManager();
        
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        try 
        {
            switch(taskId) {
                case 101060:
                    if(getLoginUser() == null) returnBean = auth.loginUser(80,request);
                    break;
                    
                case 101070:
                    returnBean = new MvcReturnBean();
                    CounterSalesOrderBean bean = null;

                    String salesID = request.getParameter("SalesID");
                    bean = new CounterSalesManager().getSalesOrderSet(new Long(salesID), getLoginUser().getLocale().toString());
                    returnBean.addReturnObject("CounterSalesOrderBean", bean);
                    returnBean.addReturnObject("Outlet", new CounterSalesManager().getRecord(bean.getSellerID()));
                    returnBean.addReturnObject("Act", "ereceipt");
                    break;
            }
        } catch(Exception e) {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }

        return returnBean;
    }
    
    public boolean generateEreceipt(String salesID, String invoiceNo, String urlHost, String userID, String password, String width, String height, String email, String layout)
    {
        boolean result = false;
        
        try {
            DesEncrypt encryptor = new DesEncrypt();
            
            String generatorPath = getPDFGeneratorPath();
            String ereceiptPath = getEreceiptPath();
            String fileName = invoiceNo.replaceAll("/",".");
            
            // Execute command
            String command = "\"" + generatorPath + "CutyCapt.exe\" --url=\"" + urlHost + "/service.do?Fin=101060&Aid=" + userID + "&Password=" + encryptor.decrypt(password) + "&SalesID=" + salesID + "\" --min-width=" + width + " --min-height=" + height + " --out=\"" + ereceiptPath + fileName + ".png\"";
            //String command = "\"" + generatorPath + "IECapt.exe\" --url=\"" + urlHost + "/service.do?Fin=101060&Aid=" + userID + "&Password=" + encryptor.decrypt(password) + "&SalesID=" + salesID + "\" --min-width=" + width + " --out=\"" + ereceiptPath + fileName + ".png\"";
            Process child = Runtime.getRuntime().exec(command);
            //child.destroy();
            
            child.waitFor();
            int exitCode = child.exitValue();
            
            if(exitCode == 0) 
            { 
                if(generatePDF(fileName, ereceiptPath, layout))
                {
                    File filePNG = new File(ereceiptPath + fileName + ".png");
                    filePNG.delete();
                    
                    if(sendEreceipt(email, ereceiptPath, fileName, invoiceNo))
                    {
                        File filePDF = new File(ereceiptPath + fileName + ".pdf");
                        filePDF.delete();
                        
                        result = true;
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    public boolean generatePDF(String fileName, String outputPath, String layout) {
        boolean result = false;
        try {
            
            Document Insert_Picture_PDF = new Document(PageSize.A4);
            
            if(layout.equalsIgnoreCase("landscape")) Insert_Picture_PDF = new Document(PageSize.A4.rotate());
            
            PdfWriter.getInstance(Insert_Picture_PDF, new FileOutputStream(outputPath + fileName + ".pdf"));
            
            Insert_Picture_PDF.open();
            Image To_be_Added = Image.getInstance(outputPath + fileName + ".png");  
            
            //To_be_Added.setAlignment(Image.MIDDLE | Image.DEFAULT);
            To_be_Added.scalePercent(70f);
            To_be_Added.setAlignment(Element.ALIGN_CENTER);
            To_be_Added.setScaleToFitLineWhenOverflow(true);
            To_be_Added.setBorder(Image.BOX);
            To_be_Added.setBorderWidth(1);
            
            if(Insert_Picture_PDF.add(To_be_Added)) result = true;
            
            Insert_Picture_PDF.close();           
        }
        catch (Exception i1) {
            i1.printStackTrace();
        }
        
        return result;
    }
    
    public boolean sendEreceipt(String email, String ereceiptPath, String fileName, String invoiceNo) 
        throws MvcException, MalformedURLException{
        
        boolean sendStat = false;
        EreceiptBean[] bean = this.getEreceiptConfig();
        String sendFrom = bean[0].getErcptEmail();
        String password = bean[0].getErcptPassword();
        String host = bean[0].getErcptHost();
        int port = bean[0].getErcptPort();
        String sendName = bean[0].getErcptName();
        String subject = bean[0].getErcptSubject();
        String message = bean[0].getErcptMsg();
        String emailReply = bean[0].getErcptEmailReply();
        String ccEmail = bean[0].getErcptCc();
        String bccEmail = bean[0].getErcptBcc();
        String html = "";
        String fileNameHtml = "";
        String file = "";
        
        try {
            if(bean[0].getErcptGroup().equalsIgnoreCase("TIMEPLACE")){
                fileNameHtml = "ercpt_tpp.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("INTIME")){
                fileNameHtml = "ercpt_intime.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("TAGHEUER")){
                fileNameHtml = "ercpt_tagheuer.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("CARTIER")){
                fileNameHtml = "ercpt_cartier.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("ATPI")){
                fileNameHtml = "ercpt_atpi.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("ROLEX")){
                fileNameHtml = "ercpt_rolex.html";
            }else{
                fileNameHtml = "thanks.html";
            }
            
            // Create the attachment
            EmailAttachment attachment = new EmailAttachment();
            attachment.setPath(ereceiptPath + fileName + ".pdf");
            attachment.setDisposition(EmailAttachment.ATTACHMENT);
            //attachment.setDescription("e-receipt");
            //attachment.setName("Invoice.pdf");

            // Create the email message
            //MultiPartEmail mail = new HtmlEmail();
            HtmlEmail mail = new HtmlEmail();
            mail.setHostName(host);
            mail.setSmtpPort(port);
            mail.setAuthenticator(new DefaultAuthenticator(sendFrom, password));
            mail.setSSLOnConnect(false);
        
            mail.addTo(email);
            if(bccEmail != null && !bccEmail.equalsIgnoreCase("")) mail.addBcc(bccEmail); //Updated By Mila 2016-08-03
            if(ccEmail != null && !ccEmail.equalsIgnoreCase("")) mail.addCc(ccEmail); 
            mail.setFrom(sendFrom, sendName);
            mail.setSubject(subject);
            mail.addReplyTo(emailReply);
           
            try {
                file = getTempelatePath() + "/html/" + fileNameHtml;
                html = getEmbedImage(readFile(file), mail);
                mail.setHtmlMsg(html);
            } catch (MalformedURLException ex) {
                mail.setMsg(message);            
            } catch (UnsupportedEncodingException ex) {
                mail.setMsg(message);            
            } catch (EmailException ex) {
                mail.setMsg(message);            
            } catch (IOException ex) {
                mail.setMsg(message);            
            }
            
            // add the attachment
            mail.attach(attachment);
            
            // send the email
            if(mail.send().length() > 0)
            {
                sendStat = true;
                setEreceiptStatus(invoiceNo);
            }
        } catch (EmailException ex) {
            ex.printStackTrace();
        }
        
        return sendStat;
    }
    
    private boolean setEreceiptStatus(String invoiceNo)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).updateEreceiptStatus(invoiceNo);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return status;
        }
    }
    
    public String getEreceiptStatus(String invoiceNo)
        throws MvcException
    {
        String status;
        Connection conn;
        status = "";
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).getEreceiptStatus(invoiceNo);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return status;
        }
    }
    
    public boolean updateEmailCustomerByID(String customerID, String email)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).updateEmailCustomerByID(customerID, email);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return status;
        }
    }
    
    public EreceiptBean[] getEreceiptConfig()
        throws MvcException
    {
        EreceiptBean bean[] = new EreceiptBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getEreceiptConfig();
            
            if(!list.isEmpty())
            {
                bean = (EreceiptBean[])list.toArray(bean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    public String getPDFGeneratorPath()
        throws UnsupportedEncodingException 
    {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/WEB-INF/classes/");
        fullPath = pathArr[0];

        String reponsePath = "";

        reponsePath = new File(fullPath).getPath() + File.separatorChar + "lib" + File.separatorChar + "cutycapt" + File.separatorChar;

        return reponsePath;
    }
    
    public String getEreceiptPath()
        throws UnsupportedEncodingException 
    {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/WEB-INF/classes/");
        fullPath = pathArr[0];

        String reponsePath = "";

        reponsePath = new File(fullPath).getPath() + File.separatorChar + "temp" + File.separatorChar;

        return reponsePath;
    }
    
    public boolean generateEDM(String invoiceNo, String email)
    {
        boolean result = false;
        
        try {
              if(sendEDM(email, invoiceNo)) result = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    public boolean sendEDM(String email, String invoiceNo) 
        throws MvcException, UnsupportedEncodingException
    {
        boolean sendStat = false;
        EreceiptBean[] bean = this.getEreceiptConfig();
        String sendFrom = bean[0].getErcptEmail();
        String password = bean[0].getErcptPassword();
        String host = bean[0].getErcptHost();
        int port = bean[0].getErcptPort();
        String sendName = bean[0].getErcptName();
        String subject = bean[0].getErcptSubject();
        String message = bean[0].getErcptMsg();
        String emailReply = bean[0].getErcptEmailReply();
        String ccEmail = bean[0].getErcptCc();
        String bccEmail = bean[0].getErcptBcc();
        String html = "";
        String fileNameHtml = "";
        String file = "";
        
        try {
            if(bean[0].getErcptGroup().equalsIgnoreCase("TIMEPLACE")){
                fileNameHtml = "edm_tpp.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("INTIME")){
                fileNameHtml = "edm_intime.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("TAGHEUER")){
                fileNameHtml = "edm_tagheuer.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("CARTIER")){
                fileNameHtml = "edm_cartier.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("ATPI")){
                fileNameHtml = "edm_atpi.html";
            }else if(bean[0].getErcptGroup().equalsIgnoreCase("ROLEX")){
                fileNameHtml = "edm_rolex.html";
            }else{
                fileNameHtml = "thanks.html";
            }
            
            // Create the email message
            //MultiPartEmail mail = new HtmlEmail();
            HtmlEmail mail = new HtmlEmail();
            mail.setHostName(host);
            mail.setSmtpPort(port);
            mail.setAuthenticator(new DefaultAuthenticator(sendFrom, password));
            mail.setSSLOnConnect(false);
        
            mail.addTo(email);
            if(bccEmail != null && !bccEmail.equalsIgnoreCase("")) mail.addBcc(bccEmail); //Updated By Mila 2016-08-03
            if(ccEmail != null && !ccEmail.equalsIgnoreCase("")) mail.addCc(ccEmail); 
            mail.setFrom(sendFrom, sendName);
            mail.setSubject(subject);
            mail.addReplyTo(emailReply);
            //mail.setMsg(message);
            try {
                file = getTempelatePath() + "/html/" + fileNameHtml;
                html = getEmbedImage(readFile(file), mail);
                mail.setHtmlMsg(html);
            } catch (MalformedURLException ex) {
                mail.setMsg(message);            
            } catch (UnsupportedEncodingException ex) {
                mail.setMsg(message);            
            } catch (EmailException ex) {
                mail.setMsg(message);            
            } catch (IOException ex) {
                mail.setMsg(message);            
            }
            
            // send the email
            if(mail.send().length() > 0)
            {
                sendStat = true;
                setEreceiptStatus(invoiceNo);
            }
        } catch (EmailException ex) {
            ex.printStackTrace();
        }
        
        return sendStat;
    }
    public String readFile(String fileName) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(fileName));
        try {
            StringBuilder sb = new StringBuilder();
            String line = br.readLine();

            while (line != null) {
                sb.append(line);
                sb.append("\n");
                line = br.readLine();
            }
            return sb.toString();
        } finally {
            br.close();
        }
    }
    public String getEmbedImage(String html, HtmlEmail email) throws MalformedURLException, EmailException {
        String content = html;
        String str = "";
        String image = "";
        int endIndex = 0;
        int beginIndex = 0;
        
        for(int i=0;i<html.length();i++)
        {
            boolean find = false;
            beginIndex = html.indexOf("src", beginIndex + i);
            
            int jpg = html.indexOf(".jpg", endIndex + i);
            int gif = html.indexOf(".gif", endIndex + i);
            int png = html.indexOf(".png", endIndex + i);
            
            if(jpg >= 0) {endIndex = jpg; find = true;}
            if(gif >= 0) {endIndex = gif; find = true;}
            if(png >= 0) {endIndex = png; find = true;}
            
            if(beginIndex >= 0 && find == true)
            {
                str = html.substring(beginIndex,endIndex + 4);
                image = str.replace("src=\"","");

                URL url = new URL(image);
                String cid = email.embed(url, "img_" + i);

                content = content.replace(html.substring(beginIndex,endIndex + 5),"src=\"cid:"+cid+"\"");
            }
        }
        
        return content;
    }
    public String getTempelatePath()
    throws UnsupportedEncodingException 
    {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/WEB-INF/classes/");
        fullPath = pathArr[0];

        String reponsePath = "";
        // to read a file from webcontent
        reponsePath = new File(fullPath).getPath() + File.separatorChar + "mail" + File.separatorChar + "IntroMail" + File.separatorChar;
        
        return reponsePath;
    }
}
