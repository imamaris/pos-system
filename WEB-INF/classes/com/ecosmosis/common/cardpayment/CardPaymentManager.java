// Decompiled by Yody
// File : CurrencyManager.class

package com.ecosmosis.common.cardpayment;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;


public class CardPaymentManager extends DBTransactionManager
{

    public static final int TASKID_CCPAYMENT_LISTING = 0x1a2e1;
    public static final int TASKID_ADD_NEW_CCPAYMENT = 0x1a2e0;
    
    private CardPaymentBroker broker;

    public CardPaymentManager()
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

            case 107233: 
                returnBean = getList();
                break;

            case 107232: 
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
        System.out.println("Masuk getList ");
        MvcReturnBean returnBean = new MvcReturnBean();
        CardPaymentBean beans[] = getAllCurency();
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }

    public CardPaymentBean[] getAllCurency()
        throws MvcException
    {
        CardPaymentBean clist[];
        Connection conn;
        clist = new CardPaymentBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (CardPaymentBean[])list.toArray(new CardPaymentBean[0]);
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

    public CardPaymentBean getCurrency(String currencyCode)
        throws MvcException
    {
        CardPaymentBean bean;
        Connection conn;
        bean = new CardPaymentBean();
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
            CardPaymentBean bean = new CardPaymentBean();
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

    private void parseBean(CardPaymentBean bean, HttpServletRequest req)
        throws Exception
    {
        bean.setCode(req.getParameter("id"));
        bean.setSymbol(req.getParameter("id"));
        bean.setName(req.getParameter("name"));
        bean.setDisplayformat(req.getParameter("format"));
    }

    private String checkBean(CardPaymentBean bean)
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

    private CardPaymentBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new CardPaymentBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
}
