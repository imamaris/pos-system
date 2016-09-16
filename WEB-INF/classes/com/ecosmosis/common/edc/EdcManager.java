// Decompiled by Yody
// File : CurrencyManager.class

package com.ecosmosis.common.edc;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;


public class EdcManager extends DBTransactionManager
{

    public static final int TASKID_EDC_LISTING = 0x1a2df;
    public static final int TASKID_ADD_NEW_EDC = 0x1a2de;
    private EdcBroker broker;

    public EdcManager()
    {
        broker = null;
    }

    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser)
    {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        try
        {
            switch(taskId)
            {
            default:
                break;

            case 107231: 
                returnBean = getList();
                break;

            case 107230: 
                if(request.getParameter("id") != null)
                    returnBean = addNew(request);
                break;
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

    public MvcReturnBean getList()
        throws Exception
    {
        // System.out.println("Masuk getList ");
        MvcReturnBean returnBean = new MvcReturnBean();
        EdcBean beans[] = getAllCurency();
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }

    public EdcBean[] getAllCurency()
        throws MvcException
    {
        EdcBean clist[];
        Connection conn;
        clist = new EdcBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (EdcBean[])list.toArray(new EdcBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return clist;
        }
    }

    public EdcBean getCurrency(String currencyCode)
        throws MvcException
    {
        EdcBean bean;
        Connection conn;
        bean = new EdcBean();
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getCurrency(currencyCode);
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

    public MvcReturnBean addNew(HttpServletRequest request)
    {
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try
        {
            EdcBean bean = new EdcBean();
            parseBean(bean, request);
            String chkMsg = checkBean(bean);
            if(chkMsg == null)
            {
                con = getConnection();
                boolean succ = getBroker(con).insert(bean);
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL006");
                } else
                {
                    ret.addError("MDL007");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_135;
        }
        finally
        {
        releaseConnection(con);
        return ret;
        }
    }

    private void parseBean(EdcBean bean, HttpServletRequest req)
        throws Exception
    {
        bean.setCode(req.getParameter("id"));
        bean.setSymbol(req.getParameter("id"));
        bean.setName(req.getParameter("name"));
        bean.setDisplayformat(req.getParameter("format"));
    }

    private String checkBean(EdcBean bean)
    {
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

    private EdcBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new EdcBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
}
