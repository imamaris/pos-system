// Decompiled by Yody
// File : BankManager.class

package com.ecosmosis.common.staff;

import com.ecosmosis.common.locations.LocationManager;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.common.bank:
//            BankBean, BankBroker

public class StaffManager extends DBTransactionManager
{

    public static final int TASKID_UPDATE_BANK_SUBMIT = 0x1a21f;
    public static final int TASKID_UPDATE_BANK = 0x1a21e;
    
    public static final int TASKID_STAFF_LISTING = 0x1a2e7;
    public static final int TASKID_ADD_NEW_STAFF= 0x1a2e6;
    private StaffBroker broker;

    public StaffManager()
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

            case 107239: 
            {
                returnBean = getList();
                break;
            }

            case 107238: 
            {
                if(request.getParameter("id") != null)
                    returnBean = addNew(request);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                LocationManager locmgr = new LocationManager();
                com.ecosmosis.common.locations.LocationBean beans[] = locmgr.getAll(3);
                returnBean.addReturnObject("LocationList", beans);
                break;
            }

            case 107038: 
            {
                StaffBean bank = new StaffBean();
                if(request.getParameter("id") != null)
                    bank = getBank(request.getParameter("id"));
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                LocationManager locmgr = new LocationManager();
                com.ecosmosis.common.locations.LocationBean beans[] = locmgr.getAll(3);
                returnBean.addReturnObject("LocationList", beans);
                returnBean.addReturnObject("BankBean", bank);
                returnBean.addReturnObject("LocationDefault", bank.getCountryID());
                break;
            }

            case 107039: 
            {
                StaffBean bank = new StaffBean();
                if(request.getParameter("id") != null)
                {
                    returnBean = update(request);
                    bank = getBank(request.getParameter("id"));
                }
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                LocationManager locmgr = new LocationManager();
                com.ecosmosis.common.locations.LocationBean beans[] = locmgr.getAll(3);
                returnBean.addReturnObject("LocationList", beans);
                returnBean.addReturnObject("BankBean", bank);
                returnBean.addReturnObject("LocationDefault", bank.getCountryID());
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

    public MvcReturnBean getList()
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        StaffBean beans[] = getAll();
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }

    public StaffBean[] getAll()
        throws MvcException
    {
        StaffBean clist[];
        Connection conn;
        clist = new StaffBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (StaffBean[])list.toArray(new StaffBean[0]);
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

    public StaffBean getBank(String bankId)
        throws MvcException
    {
        StaffBean bean;
        Connection conn;
        bean = new StaffBean();
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getBank(bankId);
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
            StaffBean bean = new StaffBean();
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

    public MvcReturnBean update(HttpServletRequest request)
    {
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try
        {
            StaffBean bean = new StaffBean();
            parseBean(bean, request);
            String chkMsg = checkBean(bean);
            String oldBankId = request.getParameter("OldBankId");
            if(chkMsg == null)
            {
                con = getConnection();
                boolean succ = getBroker(con).update(bean, oldBankId);
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL008");
                } else
                {
                    ret.addError("MDL009");
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
         //   break MISSING_BLOCK_LABEL_147;
        }
        finally
        {
        releaseConnection(con);
        return ret;
        }
    }

    private void parseBean(StaffBean bean, HttpServletRequest req)
        throws Exception
    {
        bean.setBankID(req.getParameter("id"));
        bean.setName(req.getParameter("name"));
        bean.setCountryID(req.getParameter("countryid"));
        bean.setOtherName(req.getParameter("othername"));
        bean.setSwiftCode(req.getParameter("swiftcode"));
    }

    private String checkBean(StaffBean bean)
    {
        String res = null;
        StringBuffer buf = new StringBuffer();
        if(bean.getBankID() == null || bean.getBankID().length() > 5 || bean.getBankID().length() < 2)
            buf.append("<br>Invalid Bank ID. ID length 2-5 chars.");
        if(bean.getName() == null || bean.getName().length() <= 3)
            buf.append("<br>Name Required. Min 3 Chars.");
        if(bean.getCountryID() == null)
            buf.append("<br>Country ID Required.");
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }

    private StaffBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new StaffBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
}
