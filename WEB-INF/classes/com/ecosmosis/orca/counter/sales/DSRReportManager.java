/*
 * DSRReportManager.java
 *
 * Created on September 24, 2013, 10:17 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.util.http.StandardOptionsMap;
import com.ecosmosis.util.log.Log;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import java.text.DecimalFormat;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class DSRReportManager extends DBTransactionManager 
{
    public static final int TASKID_ADMIN_DSR_FILTER_RPT = 0x18db2;
    public static final int TASKID_ADMIN_DSR_SUMMARY = 0x18db5;
    public static final int TASKID_ADMIN_DSR_COLLECTION = 0x18db6;
    private DSRReportBroker broker;
    
    /** Creates a new instance of DSRReportManager */
    public DSRReportManager() {
        broker = null;
    }
    
    public DSRReportManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private DSRReportBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new DSRReportBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public String defineTaskTitle(int taskID)
    {
        String taskTitle = "";
        switch(taskID)
        {            
            case 101810:
                taskTitle = "DSR Report"; 
                break;
            case 101813:
                taskTitle = "DSR Summary"; 
                break;
            case 101814:
                taskTitle = "DSR Collection"; 
                break;
        }
        return taskTitle;
    }

    private MvcReturnBean getDSRReport(HttpServletRequest request, int taskID)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                java.util.Date docDtFrom = null;
                java.util.Date docDtTo = null;
                String sellerID = getLoginUser().getOutletID();
                if(taskID == 0x18db2)
                    sellerID = request.getParameter("SellerID");
                String docDtFromStr = request.getParameter("DocDateFrom");
                String docDtToStr = request.getParameter("DocDateTo");
                returnBean.addReturnObject("DSRReport", getDSRDocDate(sellerID,docDtFromStr,docDtToStr));
            }
            returnBean.addReturnObject("TaskID", String.valueOf(taskID));
            returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskID));
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }
    
    public DSRReportBean[] getDSRTrxDate(String outletID, String trxDtFromStr, String trxDtToStr)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getDSRTrxDate(outletID, trxDtFromStr, trxDtToStr);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public DSRReportBean[] getDSRDocDate(String outletID, String docDtFromStr, String docDtToStr)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getDSRDocDate(outletID, docDtFromStr, docDtToStr);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public DSRReportBean[] getDSRReport(String outletID, int DSRCatStat, String docDtFromStr, String docDtToStr)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        //rptBean = null;
        conn = null;
        ArrayList list;
        list = null;

        try
        {
            conn = getConnection();
            
            if(DSRCatStat == 0) list = getBroker(conn).getDSRReport(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 1) list = getBroker(conn).getDSRReport1(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 2) list = getBroker(conn).getDSRReport2(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 3) list = getBroker(conn).getDSRReport3(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 4) list = getBroker(conn).getDSRReport4(outletID, docDtFromStr, docDtToStr);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public DSRReportBean[] getCurRate(String docDate)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getCurRate(docDate);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
public DSRReportBean[] getSummary(String outletID, int DSRCatStat, String docDtFromStr, String docDtToStr)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;
        ArrayList list;
        list = null;

        try
        {
            conn = getConnection();
            
            if(DSRCatStat == 0) list = getBroker(conn).getSummary(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 1) list = getBroker(conn).getSummary1(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 2) list = getBroker(conn).getSummary2(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 3) list = getBroker(conn).getSummary3(outletID, docDtFromStr, docDtToStr);
            if(DSRCatStat == 4) list = getBroker(conn).getSummary4(outletID, docDtFromStr, docDtToStr);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public DSRReportBean[] getPaymentByDocNo(String docNo)
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPaymentByDocNo(docNo);
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public Date getLastDocDate()
        throws MvcException
    {
        Connection conn;
        Date lastDocDate;
        lastDocDate = null;
        conn = null;
        try
        {
            conn = getConnection();
            lastDocDate = (Date) getBroker(conn).getLastDocDate();
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return lastDocDate;
        }
    }
    
    public int getDSRCatStat()
        throws MvcException
    {
        Connection conn;
        int DSRCatStat;
        DSRCatStat = 0;
        conn = null;
        try
        {
            conn = getConnection();
            DSRCatStat = getBroker(conn).getDSRCatStat();
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return DSRCatStat;
        }
    }
    
    public DSRReportBean[] getOutletInitial()
        throws MvcException
    {
        DSRReportBean rptBean[] = new DSRReportBean[0];
        Connection conn;
        conn = null;

        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getOutletInitial();
            
            if(!list.isEmpty())
            {
                rptBean = (DSRReportBean[])list.toArray(rptBean);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return rptBean;
    }
    
    public static void createLogFile(String status, String path) 
        throws IOException 
    {
        FileWriter aWriter = new FileWriter(path, true);
        aWriter.write(status);
        aWriter.flush();
        aWriter.close();
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser)
    {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
        try
        {
            switch(taskId)
            {
                default:
                    break;
                case 101810:
                {
                    returnBean = getDSRReport(request, taskId);
                    break;
                }
                case 101813:
                {
                    returnBean = getDSRReport(request, taskId);
                    break;
                }
                case 101814:
                {
                    returnBean = getDSRReport(request, taskId);
                    break;
                }
            }
        }
        catch(Exception e)
        {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
    
    public static String getCurFormat(double number)
    {
        String formatNumber = new DecimalFormat("###,###,###").format(number);

        return formatNumber;
    }
}
