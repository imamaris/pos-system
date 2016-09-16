// Decompiled by Yody
// File : OutletManager.class

package com.ecosmosis.orca.outlet;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.common.locations.*;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.orca.counter.sales.CounterSalesPaymentBean;
import com.ecosmosis.orca.outlet.paymentmode.OutletPaymentModeBean;
import com.ecosmosis.orca.pricing.PriceCodeBean;
import com.ecosmosis.orca.users.AdminLoginUserBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.outlet:
//            OutletBroker, OutletBean

public class OutletManager extends DBTransactionManager
{

    public static final int TASKID_OUTLET_LISTING = 0x1a25c;
    public static final int TASKID_ADD_NEW_OUTLET = 0x1a25b;
    public static final int TASKID_MANAGE_OUTLET_PRICING = 0x1a25d;
    private OutletBroker broker;

    public OutletManager(Connection _con)
    {
        super(_con);
        broker = null;
    }

    public OutletManager()
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

            case 107100: 
            {
                AdminLoginUserBean user = (AdminLoginUserBean)loginuser;
                returnBean = getList(user.getOperationLocationBean().getTraceKey());
                break;
            }

            case 107099: 
            {
                if(request.getParameter("id") != null)
                    returnBean = addNew(request);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                LocationManager locmgr = new LocationManager();
                LocationBean lbeans[] = locmgr.getAll(0);
                returnBean.addReturnObject("LocationList", lbeans);
                LocationBean cbeans[] = locmgr.getAll(3);
                returnBean.addReturnObject("CountryList", cbeans);
                break;
            }

            case 107101: 
            {
                AdminLoginUserBean user = (AdminLoginUserBean)loginuser;
                returnBean = getList(user.getOperationLocationBean().getTraceKey());
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

    public OutletBean getRecord(String id)
        throws Exception
    {
        OutletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getRecord(id);
            if(bean != null)
            {
                PriceCodeBean list[] = getPriceCode(id);
                bean.setPriceCodes(list);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        
        /*
         break MISSING_BLOCK_LABEL_67;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public MvcReturnBean getList(String tracekey)
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        OutletBean beans[] = getFullList(tracekey);
        for(int i = 0; i < beans.length; i++)
            beans[i].setPriceCodes(getPriceCode(beans[i].getOutletID()));

        returnBean.addReturnObject("OutletList", beans);
        return returnBean;
    }

    public PriceCodeBean[] getPriceCode(String id)
        throws MvcException
    {
        PriceCodeBean plist[];
        Connection conn;
        plist = new PriceCodeBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPriceCode(id);
            if(!list.isEmpty())
                plist = (PriceCodeBean[])list.toArray(new PriceCodeBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
         break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return plist;
    }

    public OutletPaymentModeBean getPaymentMode(String paymodeCode, String outletID)
        throws MvcException
    {
        OutletPaymentModeBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getPaymentMode(paymodeCode, outletID);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_55;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public OutletPaymentModeBean[] getPaymentModeList(String outletID)
        throws MvcException
    {
        OutletPaymentModeBean plist[];
        Connection conn;
        plist = new OutletPaymentModeBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPaymentModeList(outletID);
            if(!list.isEmpty())
                plist = (OutletPaymentModeBean[])list.toArray(new OutletPaymentModeBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }

        releaseConnection(conn);
        return plist;
    }  
    
    /*
    Public CounterSalesPaymentBean[] getPaymentModeList2(String outletID)
        throws MvcException
    {
        CounterSalesPaymentBean plist[];
        Connection conn;
        plist = new CounterSalesPaymentBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getPaymentModeList2(outletID);
            if(!list.isEmpty())
                plist = (CounterSalesPaymentBean[])list.toArray(new CounterSalesPaymentBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }

        releaseConnection(conn);
        return plist;
    }
    */
    
    public OutletBean[] getFullList(String tracekey)
        throws MvcException
    {
        OutletBean clist[];
        Connection conn;
        clist = new OutletBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getList(tracekey);
            if(!list.isEmpty())
                clist = (OutletBean[])list.toArray(new OutletBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    public MvcReturnBean addNew(HttpServletRequest request)
    {
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try
        {
            OutletBean bean = new OutletBean();
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
        /*
        break MISSING_BLOCK_LABEL_126;
        Exception exception;
        exception;
        releaseConnection(con);
        throw exception;
        releaseConnection(con);
        break MISSING_BLOCK_LABEL_141;
        */
        releaseConnection(con);
        return ret;
    }

    private void parseBean(OutletBean bean, HttpServletRequest req)
        throws Exception
    {
        bean.setOutletID(req.getParameter("id"));
        bean.setDocCode(req.getParameter("id"));
        bean.setName(req.getParameter("name"));
        bean.setControlLocationID(req.getParameter("control"));
        bean.setOperationCountryID(req.getParameter("operation"));
        bean.setType(req.getParameter("type"));
        bean.setRegistrationInfo(req.getParameter("registerinfo"));
        bean.setAddress1(req.getParameter("address1"));
        bean.setAddress2(req.getParameter("address2"));
        bean.setZipcode(req.getParameter("zipcode"));
        bean.setCountryID(req.getParameter("countryid"));
        bean.setRegionID(req.getParameter("regioinid"));
        bean.setStateID(req.getParameter("stateid"));
        bean.setCityID(req.getParameter("cityid"));
        bean.setOfficeTel(req.getParameter("officeno"));
        bean.setFaxNo(req.getParameter("faxno"));
        bean.setMobileTel(req.getParameter("mobileno"));
        bean.setEmail(req.getParameter("email"));
        bean.setSupervisor(req.getParameter("supervisor"));
        bean.setRemark(req.getParameter("remark"));
        String prv = req.getParameter("pickup_private");
        String pub = req.getParameter("pickup_public");
        if(prv != null)
            bean.setPickup_private(Integer.parseInt(prv));
        if(pub != null)
            bean.setPickup_private(Integer.parseInt(pub));
        if(bean.getOperationCountryID() != null)
        {
            LocationBean c = (LocationBean)Location.getObject(bean.getOperationCountryID());
            bean.setReg_prefix(c.getRegPrefix());
        }
    }

    private String checkBean(OutletBean bean)
    {
        String res = null;
        StringBuffer buf = new StringBuffer();
        if(bean.getOutletID() == null || bean.getOutletID().length() < 2 || bean.getOutletID().length() > 4)
        {
            buf.append("|");
            buf.append("MSG_INVALID_OUTLETID");
        }
        if(bean.getName() == null || bean.getName().length() <= 3)
        {
            buf.append("|");
            buf.append("MSG_NAME_REQUIRED");
        }
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }

    public TreeMap getMap(OutletBean beans[], boolean showDefault)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < beans.length; i++)
            maps.put(beans[i].getOutletID(), (new StringBuilder(String.valueOf(beans[i].getName()))).append(" (").append(beans[i].getOutletID()).append(")").toString());

        return maps;
    }

    private OutletBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new OutletBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
}
