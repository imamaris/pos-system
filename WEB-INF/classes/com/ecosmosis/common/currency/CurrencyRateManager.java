// Decompiled by Yody
// File : CurrencyManager.class

package com.ecosmosis.common.currency;

import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.common.currency:
//            CurrencyBean, CurrencyBroker

public class CurrencyRateManager extends DBTransactionManager {
    
    public static final int TASKID_CURRENCY_EXCHANGE_RATE_LISTING = 0x1a2e5;
    public static final int TASKID_ADD_NEW_CURRENCY_EXCHANGE_RATE = 0x1a2e4;
    public static final int TASKID_ADD_NEW_CURRENCY_EXCHANGE_RATE2 = 101811;
    
    private CurrencyRateBroker broker;
    
    public CurrencyRateManager() {
        broker = null;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser) {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 101811:
                    if (request.getParameter("symbol") != null)
                        returnBean = addNewRate(request);
                    break;
                    
                case 107237:
                    returnBean = getList();
                    break;
                    
                case 107236:
                    if(request.getParameter("id") != null)
                        returnBean = addNew(request);
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
        CurrencyRateBean beans[] = getAllCurency();
        returnBean.addReturnObject("List", beans);
        return returnBean;
    }
    
    public CurrencyRateBean[] getAllCurency()
    throws MvcException {
        CurrencyRateBean clist[];
        Connection conn;
        clist = new CurrencyRateBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList();
            if(!list.isEmpty())
                clist = (CurrencyRateBean[])list.toArray(new CurrencyRateBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        } finally {
            releaseConnection(conn);
            return clist;
        }
    }
    
    
    public CurrencyRateBean[] getCurrencyRateSetListForSales(String priceCodeID,  Date effectiveDate, String locale)
    throws MvcException {
        CurrencyRateBean clist[];
        Connection conn;
        clist = new CurrencyRateBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getFullList2(priceCodeID, (java.sql.Date) effectiveDate, locale);
            if(!list.isEmpty())
                clist = (CurrencyRateBean[])list.toArray(new CurrencyRateBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        } finally {
            releaseConnection(conn);
            return clist;
        }
    }
    
    
    
    
/*
     public CurrencyRateBean[] getCurrencyRateSetListForSales(String priceCodeID, Date effectiveDate, String locale)
        throws MvcException
    {
        Connection conn;
        ProductBean beans[];
        conn = null;
        beans = new ProductBean[0];
        try
        {
            conn = getConnection();
            ProductBean activeBeans[] = getActiveProductSetList(locale);
            ArrayList list = new ArrayList();
            ProductPricingManager mgr = new ProductPricingManager(conn);
            for(int i = 0; i < activeBeans.length; i++)
            {
                ProductBean bean = activeBeans[i];
                com.ecosmosis.orca.pricing.product.ProductPricingBean curPrice = mgr.getCurrentPricing(bean.getProductID(), priceCodeID, effectiveDate);
                if(curPrice != null)
                {
                    bean.setCurrentPricing(curPrice);
                    list.add(bean);
                }
            }
 
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
 
        releaseConnection(conn);
        return beans;
    }
 
 */
    
    
    public CurrencyRateBean getCurrency(String currencyCode)
    throws MvcException {
        CurrencyRateBean bean;
        Connection conn;
        bean = new CurrencyRateBean();
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
            CurrencyRateBean bean = new CurrencyRateBean();
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
    
    private void parseBean(CurrencyRateBean bean, HttpServletRequest req)
    throws Exception {
        
        double symbol = Double.parseDouble(req.getParameter("id"));
        
        bean.setCode(req.getParameter("id"));
        bean.setSymbol(symbol);
        bean.setName(req.getParameter("name"));
        bean.setDisplayformat(req.getParameter("format"));
    }
    
    private String checkBean(CurrencyRateBean bean) {
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
    
    private CurrencyRateBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new CurrencyRateBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }

  public MvcReturnBean addNewRate(HttpServletRequest request)
  {
      MvcReturnBean ret = new MvcReturnBean();
      Connection con = null;
      try
      {
          CurrencyRateBean bean  = new CurrencyRateBean();
          parseBeanRate(bean, request);
          String chkMsg = checkRate(bean);
          if(chkMsg == null)
          {
              con = getConnection();
              boolean succ = getBroker(con).insertRate(bean);
              if(succ)
              {
                  ret.done();
                  ret.addMessage("Failed");
              }
              else{
                  ret.addError("Success Add Rate");
              }
          }else{
              ret.fail();
              ret.setSysMessage(chkMsg);
          }
          return ret;
      }catch(Exception e){
          Log.error(e);
          
          return ret;
      }
      finally{
          releaseConnection(con);
      }
      //return ret;
  }
  
  private void parseBeanRate(CurrencyRateBean bean, HttpServletRequest request)
    throws Exception
  {
      double rate = Double.parseDouble(request.getParameter("rate"));
      String sDate = request.getParameter("startDate");
      String eDate = request.getParameter("endDate");
      DateFormat formatter, time ; 
      Date dateAwal, dateAkhir;
      formatter = new SimpleDateFormat("yyyy-MM-dd");
      dateAwal = (Date)formatter.parse(sDate);
      dateAkhir = (Date)formatter.parse(eDate);
      java.sql.Date startDate = new java.sql.Date(dateAwal.getTime());
      java.sql.Date endDate = new java.sql.Date(dateAkhir.getTime());
      
      bean.setCode(request.getParameter("symbol"));
      bean.setSymbol(rate);
      bean.setName(request.getParameter("symbol"));
      bean.setDisplayformat(request.getParameter("format"));
      bean.setStartdate(startDate);
      bean.setEnddate(endDate);
      bean.setStarttime(null);
      bean.setEndtime(null);
      bean.setStatus("A");
  }

  private String checkRate(CurrencyRateBean bean)
  {
      String res = null;
      StringBuffer buf = new StringBuffer();
      if ((bean.getCode() == null) || (bean.getCode().length() > 18) || (bean.getCode().length() < 2))
      buf.append("<br>Invalid Location ID. ID length 2-18 chars.");
    if ((bean.getName() == null) || (bean.getName().length() <= 3))
      buf.append("<br>Name Required. Min 3 Chars.");
    if ((bean.getDisplayformat() == null) || (bean.getDisplayformat().length() <= 0))
      buf.append("<br>Display Format Required.");
    if (buf.length() > 0)
      res = buf.toString();
    return res;
  }
 
  
    
}
