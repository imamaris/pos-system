// Decompiled by Yody
// File : CurrencyManager.class

package com.ecosmosis.common.currency;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.common.currency:
//            CurrencyBean, CurrencyBroker

public class CurrencyExchangeManager extends DBTransactionManager {
    
    public static final int TASKID_CURRENCY_EXCHANGE_LISTING = 0x1a2e3;
    public static final int TASKID_ADD_NEW_CURRENCY_EXCHANGE = 0x1a2e2;
    public static final int TASKID_ADD_NEW_CURRENCY_EXCHANGE_RATE = 101812;
    
    private CurrencyExchangeBroker broker;
    
    public CurrencyExchangeManager() {
        broker = null;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser) {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 107235:
                    returnBean = getList();
                    break;
                    
                case 107234:
                    if(request.getParameter("id") != null)
                        returnBean = addNew(request);
                    break;
                    
                case 101812:
                    returnBean = getList();
                    break;
                    
            }
        } catch(Exception e) {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
    
    public MvcReturnBean getList()
    throws Exception {
        MvcReturnBean returnBean = new MvcReturnBean();
        CurrencyExchangeBean beans[] = getAllCurency();
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }
    
    public CurrencyExchangeBean[] getAllCurency()
    throws MvcException {
        CurrencyExchangeBean clist[];
        Connection conn;
        clist = new CurrencyExchangeBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (CurrencyExchangeBean[])list.toArray(new CurrencyExchangeBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        } finally {
            releaseConnection(conn);
            return clist;
        }
    }
    
    public CurrencyExchangeBean getCurrency(String currencyCode)
    throws MvcException {
        CurrencyExchangeBean bean;
        Connection conn;
        bean = new CurrencyExchangeBean();
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getCurrency(currencyCode);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        } finally {
            releaseConnection(conn);
            return bean;
        }
    }
    
    public MvcReturnBean addNew(HttpServletRequest request) {
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try {
            CurrencyExchangeBean bean = new CurrencyExchangeBean();
            parseBean(bean, request);
            String chkMsg = checkBean(bean);
            if(chkMsg == null) {
                con = getConnection();
                boolean succ = getBroker(con).insert(bean);
                if(succ) {
                    ret.done();
                    ret.addMessage("MDL006");
                } else {
                    ret.addError("MDL007");
                }
            } else {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        } catch(Exception e) {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_135;
        } finally {
            releaseConnection(con);
            return ret;
        }
    }
    
    private void parseBean(CurrencyExchangeBean bean, HttpServletRequest req)
    throws Exception {
        bean.setCode(req.getParameter("id"));
        bean.setSymbol(req.getParameter("id"));
        bean.setName(req.getParameter("name"));
        bean.setDisplayformat(req.getParameter("format"));
    }
    
    private String checkBean(CurrencyExchangeBean bean) {
        String res = null;
        StringBuffer buf = new StringBuffer();
        if(bean.getCode() == null || bean.getCode().length() > 10 || bean.getCode().length() < 2)
            buf.append("<br>Invalid Location ID. ID length 2-3 chars.");
        if(bean.getName() == null || bean.getName().length() <= 3)
            buf.append("<br>Name Required. Min 3 Chars.");
        if(bean.getDisplayformat() == null || bean.getDisplayformat().length() <= 0)
            buf.append("<br>Display Format Required.");
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }
    
    private CurrencyExchangeBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new CurrencyExchangeBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
}
