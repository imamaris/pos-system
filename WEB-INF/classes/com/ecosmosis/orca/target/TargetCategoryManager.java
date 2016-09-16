/*
 * TargetCategoryManager.java
 *
 * Created on October 29, 2014, 4:04 PM
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
public class TargetCategoryManager extends DBTransactionManager {
    
    public static final int TASKID_CATEGORY_TARGET = 0x1A2E8;
    public static final String RETURN_PERIODE_TARGET = "PeriodeTarget";
    public static final String RETURN_BRAND_TARGET = "BrandTarget";
    private TargetCategoryBroker broker;
    
    /** Creates a new instance of TargetCategoryManager */
    public TargetCategoryManager() {
        broker = null;
    }
    
    public TargetCategoryManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private TargetCategoryBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new TargetCategoryBroker(conn);
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
                taskTitle = "Category Target"; 
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
            //returnBean.addReturnObject("Category", getCategory(getLoginUser().getOutletID(),periodeTarget,brandTarget));
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }

        return returnBean;
    }
    
    public TargetCategoryBean getTarget(String periodeTarget, String brandTarget, String act)
        throws MvcException
    {
        TargetCategoryBean tgtBean;
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
    
    public TargetCategoryBean[] getCategory(String outletID, String periodeTarget, String brandTarget)
        throws MvcException
    {
        TargetCategoryBean tgtBean[] = new TargetCategoryBean[0];
        Connection conn;
        conn = null;
        
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getCategory(outletID, periodeTarget, brandTarget);
            if(!list.isEmpty())
                tgtBean = (TargetCategoryBean[])list.toArray(tgtBean);
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
    
    private boolean checkCategoryTarget(String categoryID, String periode, String brand, String outletID)
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
            status = getBroker(conn).checkCategoryTarget(categoryID, periode, brand, outletID);
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
    
    private boolean updateTarget(String categoryID, String curID, String periode, String brand, String outletID, double categoryTarget, String userLogin)
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
            status = getBroker(conn).updateTarget(categoryID, curID, periode, brand, outletID, categoryTarget, userLogin);
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
    
    private boolean addTarget(String categoryID, String curID, String periode, String brand, String outletID, double categoryTarget, String userLogin)
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
            status = getBroker(conn).addTarget(categoryID, curID, periode, brand, outletID, categoryTarget, userLogin);
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
                        int countCategory = Integer.parseInt(request.getParameter("countCategory"));
                        
                        for(int i=0;i<countCategory;i++)
                        {
                            String categoryID = request.getParameter("categoryID_" + i);
                            double categoryTarget = Double.parseDouble(request.getParameter("categoryTarget_" + i));
                            
                            if(checkCategoryTarget(categoryID,periode,brand,outletID))
                            {
                                updateTarget(categoryID,curID,periode,brand,outletID,categoryTarget,userLogin);
                            }
                            else
                            {
                                addTarget(categoryID,curID,periode,brand,outletID,categoryTarget,userLogin);
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
