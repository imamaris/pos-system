/*
 * VoucherManager.java
 *
 * Created on February 20, 2013, 3:38 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.voucher;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author mila.yuliani
 */
public class VoucherManager extends DBTransactionManager {
    private VoucherBroker broker;
        
    /** Creates a new instance of VoucherManager */      
    public VoucherManager(){
        this.broker = null;
    }
  
    public VoucherManager(Connection conn) {
        super(conn);
        this.broker = null;
    }
  
    private VoucherBroker getBroker(Connection conn) {
        if (this.broker == null) {
            this.broker = new VoucherBroker(conn);
        } else {
            this.broker.setConnection(conn);
        }
        return this.broker;
    }
  
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser) {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
        try{
            switch (taskId){
            }
        } catch (Exception e) {
            if (returnBean == null)
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }    
        return returnBean;
    }  
    
    public String getVoucher(String skuVoucher)
    throws MvcException
    {
        Connection conn = null;
        String bean;
        try { 
            conn = getConnection();
            bean = getBroker(conn).getVoucher(skuVoucher);
            
        } catch (Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
    
        releaseConnection(conn);
        return bean;
    }
}