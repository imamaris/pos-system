/*
 * TargetManager.java
 *
 * Created on November 8, 2013, 4:04 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.target;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.util.http.StandardOptionsMap;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class TargetManager extends DBTransactionManager {
    
    public static final int TASKID_SALESMAN_TARGET = 0x1A2E8;
    public static final String RETURN_PERIODE_TARGET = "PeriodeTarget";
    public static final String RETURN_BRAND_TARGET = "BrandTarget";
    private TargetBroker broker;
    
    /** Creates a new instance of TargetManager */
    public TargetManager() {
        broker = null;
    }
    
    public TargetManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private TargetBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new TargetBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public String defineTaskTitle(int taskID)
    {
        String taskTitle = "";
        switch(taskID)
        {            
            case 107240:
                taskTitle = "Salesman Target"; 
                break;
        }
        return taskTitle;
    }
    
    private MvcReturnBean getTarget(HttpServletRequest request, int taskID)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        String periodeTarget = request.getParameter("periodeTarget");
        String brandTarget = request.getParameter("brandTarget");
        String act = request.getParameter("act");
        
        if(periodeTarget == null) periodeTarget = request.getParameter("periode");
        if(brandTarget == null) brandTarget = request.getParameter("brand");
        if(act != null && act.equalsIgnoreCase("periode")) brandTarget = null; //Reset Brand Combobox
        
        try
        {
            returnBean.addReturnObject("TaskID", String.valueOf(taskID));
            returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskID));
            returnBean.addReturnObject("PeriodeTarget", getPeriodeTarget());
            returnBean.addReturnObject("BrandTarget", getBrandTarget(periodeTarget));
            returnBean.addReturnObject("Target", getTarget(periodeTarget, brandTarget, act));
            returnBean.addReturnObject("Salesman", getSalesman(getLoginUser().getOutletID(),periodeTarget,brandTarget));
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }

        return returnBean;
    }
    
    public TargetBean getTarget(String periodeTarget, String brandTarget, String act)
        throws MvcException
    {
        TargetBean tgtBean;
        Connection conn;
        tgtBean = null;
        conn = null;

        try
        {
            conn = getConnection();
            tgtBean = getBroker(conn).getTarget(periodeTarget, brandTarget, act);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return tgtBean;
    }
    
    public TargetBean[] getSalesman(String outletID, String periodeTarget, String brandTarget)
        throws MvcException
    {
        TargetBean tgtBean[] = new TargetBean[0];
        Connection conn;
        conn = null;
        
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesman(outletID, periodeTarget, brandTarget);
            if(!list.isEmpty())
                tgtBean = (TargetBean[])list.toArray(tgtBean);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return tgtBean;
        }
    }
    
    private boolean checkSalesmanTarget(String salesmanID, String periode, String brand, String outletID)
        throws MvcException
    {
        Connection conn;
        boolean status;
        conn = null;
        conn = null;
        status = false;
        try
        {
            conn = getConnection();
            status = getBroker(conn).checkSalesmanTarget(salesmanID, periode, brand, outletID);
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
    
    private boolean updateTarget(String salesmanID, String curID, String periode, String brand, String outletID, double salesmanTarget, String userLogin)
        throws MvcException
    {
        Connection conn;
        conn = null;
        boolean status;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).updateTarget(salesmanID, curID, periode, brand, outletID, salesmanTarget, userLogin);
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
    
    private boolean addTarget(String salesmanID, String curID, String periode, String brand, String outletID, double salesmanTarget, String userLogin)
        throws MvcException
    {
        Connection conn;
        conn = null;
        boolean status;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).addTarget(salesmanID, curID, periode, brand, outletID, salesmanTarget, userLogin);
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
    
    public static String getFormatNumber(double number)
    {
        //if(number == "") number = 0;
        
        String formatNumber = new DecimalFormat("###").format(number);

        return formatNumber;
    }
    
    private FIFOMap getPeriodeTarget()
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPeriodeTarget();
            for(int i = 0; i < list.size(); i++)
            {
                String data = list.get(i).toString();
                String[] dt = data.split(",");
                String key = dt[0];
                String value = dt[1];
                map.put(key, value);
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
    }
    
    private FIFOMap getBrandTarget(String periodeTarget)
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getBrandTarget(periodeTarget);
            for(int i = 0; i < list.size(); i++)
            {
                String data = list.get(i).toString();
                String[] dt = data.split(",");
                String key = dt[0];
                String value = dt[1];
                map.put(key, value);
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
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
                case 107240:
                {
                    if(formSubmitted)
                    {
                        String userLogin = getLoginUser().getUserId();
                        String curID = request.getParameter("curID");
                        String periode = request.getParameter("periode");
                        String brand = request.getParameter("brand");
                        String outletID = request.getParameter("outletID");
                        int countSalesman = Integer.parseInt(request.getParameter("countSalesman"));
                        
                        for(int i=0;i<countSalesman;i++)
                        {
                            String salesmanID = request.getParameter("salesmanID_" + i);
                            double salesmanTarget = Double.parseDouble(request.getParameter("salesmanTarget_" + i));
                            
                            if(checkSalesmanTarget(salesmanID,periode,brand,outletID))
                            {
                                updateTarget(salesmanID,curID,periode,brand,outletID,salesmanTarget,userLogin);
                            }
                            else
                            {
                                addTarget(salesmanID,curID,periode,brand,outletID,salesmanTarget,userLogin);
                            }
                        }
                    }
                    
                    returnBean = getTarget(request, taskId);
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
}
