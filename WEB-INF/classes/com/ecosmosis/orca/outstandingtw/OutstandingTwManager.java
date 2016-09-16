/*
 * OutstandingTwManager.java
 *
 * Created on August 26, 2015, 2:33 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.outstandingtw;

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
public class OutstandingTwManager  extends DBTransactionManager {
    
    private OutstandingTwBroker broker;
    
    /** Creates a new instance of OutstandingTwManager */
    public OutstandingTwManager() {
        broker = null;
    }
    
    public OutstandingTwManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private OutstandingTwBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new OutstandingTwBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public String defineTaskTitle(int taskID)
    {
        String taskTitle = "";
        switch(taskID)
        {            
            case 102818:
                taskTitle = "Outstanding Transfer"; 
                break;
        }
        return taskTitle;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser)
    {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        
        try
        {
            switch(taskId)
            {
                default:
                    break;
                case 102818:
                {   
                    returnBean = new MvcReturnBean();
                    
                    returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                    returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskId));
                    returnBean.addReturnObject("OutstandingTW", getOutstandingTW(getLoginUser().getOutletID()));
                    
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
    
    public OutstandingTwBean[] getOutstandingTW(String outletID)
        throws MvcException
    {
        OutstandingTwBean bean[] = new OutstandingTwBean[0];
        Connection conn;
        conn = null;
        
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getOutstandingTW(outletID);
            if(!list.isEmpty())
                bean = (OutstandingTwBean[])list.toArray(bean);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return bean;
        }
    }
}
