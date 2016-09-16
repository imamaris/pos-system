/*
 * GoodReceiveManager.java
 *
 * Created on September 2, 2015, 3:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.goodreceive;

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
public class GoodReceiveManager extends DBTransactionManager {
    
    private GoodReceiveBroker broker;
    
    /** Creates a new instance of GoodReceiveManager */
    public GoodReceiveManager() {
        broker = null;
    }
    
    public GoodReceiveManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private GoodReceiveBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new GoodReceiveBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
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
                case 102024:
                {   
                    returnBean = new MvcReturnBean();
                    
                    String DocNo = request.getParameter("RefNo");
                    returnBean.addReturnObject("GoodReceive",getGoodReceiveList(getLoginUser().getOutletID(), DocNo));
                    
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
    
    public GoodReceiveBean[] getGoodReceiveList(String outletID, String DocNo)
        throws MvcException
    {
        GoodReceiveBean bean[] = new GoodReceiveBean[0];
        Connection conn;
        conn = null;
        
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getGoodReceiveList(outletID, DocNo);
            if(!list.isEmpty())
                bean = (GoodReceiveBean[])list.toArray(bean);
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
